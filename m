Return-Path: <linux-pm+bounces-1609-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D1D81EF49
	for <lists+linux-pm@lfdr.de>; Wed, 27 Dec 2023 15:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02BA2283865
	for <lists+linux-pm@lfdr.de>; Wed, 27 Dec 2023 14:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E40345022;
	Wed, 27 Dec 2023 14:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DDHCQMKU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1154501E
	for <linux-pm@vger.kernel.org>; Wed, 27 Dec 2023 14:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703685665; x=1735221665;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2M/0/ymYYTUFNrAUwhQwimViGbPmjweuxddLkfurLQA=;
  b=DDHCQMKUo1tD8vb7JJMTiJEM3anjT3s2rbbnnCm247S9b2tWAu4CTgzH
   Hwb/f4tZavarxHc++AMTmPzUz5CyKylQsW1VlCXZcRwVWJ627sc0thJGJ
   ADufq61BKFFxq5xexyuYNeGkuxEotZ7QsX8avD9TG1mrJi6jZm/34UGet
   12h/+obo25Hw7mBdEQBjKfcvlDCRWxnsx4nHYSUgeNCxybPp/W7Whj7Yj
   l3/MVdXxcrsvRWv1EgvE9gXmZ4boz4KNwM1vfsxyvDRyp8hcIurvKyM9J
   CYQ9elqjFVwSx7zA32ox9IYFyjMsd4ldCNeVPLSLVIYXbtrUIYu6hUGWc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="400262208"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="400262208"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 06:01:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="26576581"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.50.181])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 06:01:03 -0800
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org
Subject: [PATCH 2/2] thermal: netlink: Add thermal_group_has_listeners() helper
Date: Wed, 27 Dec 2023 15:00:57 +0100
Message-Id: <20231227140057.174314-2-stanislaw.gruszka@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231227140057.174314-1-stanislaw.gruszka@linux.intel.com>
References: <20231227140057.174314-1-stanislaw.gruszka@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a helper function to check if there are listeners for
thermal_gnl_family multicast groups.

For now use it to avoid unnecessary allocations and sending
thermal genl messages when there are no recipients.

In the future, in conjunction with (not yet implemented) notification
of change in the netlink socket group membership, this helper can be
used to open/close hardware interfaces based on the presence of
user space subscribers.

Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
---
 drivers/thermal/thermal_netlink.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/thermal/thermal_netlink.c b/drivers/thermal/thermal_netlink.c
index aca36c4ddbf3..b4e758d22077 100644
--- a/drivers/thermal/thermal_netlink.c
+++ b/drivers/thermal/thermal_netlink.c
@@ -76,6 +76,11 @@ typedef int (*cb_t)(struct param *);
 
 static struct genl_family thermal_gnl_family;
 
+static int thermal_group_has_listeners(enum thermal_genl_multicast_groups group)
+{
+	return genl_has_listeners(&thermal_gnl_family, &init_net, group);
+}
+
 /************************** Sampling encoding *******************************/
 
 int thermal_genl_sampling_temp(int id, int temp)
@@ -83,6 +88,9 @@ int thermal_genl_sampling_temp(int id, int temp)
 	struct sk_buff *skb;
 	void *hdr;
 
+	if (!thermal_group_has_listeners(THERMAL_GENL_SAMPLING_GROUP))
+		return -ESRCH;
+
 	skb = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
 	if (!skb)
 		return -ENOMEM;
@@ -280,6 +288,9 @@ static int thermal_genl_send_event(enum thermal_genl_event event,
 	int ret = -EMSGSIZE;
 	void *hdr;
 
+	if (!thermal_group_has_listeners(THERMAL_GENL_EVENT_GROUP))
+		return -ESRCH;
+
 	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
 	if (!msg)
 		return -ENOMEM;
-- 
2.34.1


