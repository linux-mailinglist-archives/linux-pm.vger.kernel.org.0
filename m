Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6928A260150
	for <lists+linux-pm@lfdr.de>; Mon,  7 Sep 2020 19:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730669AbgIGQdU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Sep 2020 12:33:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:47044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730382AbgIGQdO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 7 Sep 2020 12:33:14 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F099421BE5;
        Mon,  7 Sep 2020 16:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599496393;
        bh=lup5T2irzIUCHMoPAIqsw8rXYWJKnE3Njzl1ilDEaho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K6MbQYZ5INwa1JNSj9hisgBAEhHom7EiwaZxUFsUS7ftnbLl0S/PoybgvGG6fS5hU
         Ci4FdplmEk/CBq5AWgFSjeuAgXvZu++nBdeXHVRXg6azH39rXY/QVw8tEqFccubHzm
         2oHQ4tFH6V+Wv2WjDxRS3Ertb8MYaz68YyK/Q8LM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.8 42/53] cpufreq: intel_pstate: Refuse to turn off with HWP enabled
Date:   Mon,  7 Sep 2020 12:32:08 -0400
Message-Id: <20200907163220.1280412-42-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907163220.1280412-1-sashal@kernel.org>
References: <20200907163220.1280412-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit 43298db3009f06fe5c69e1ca8b6cfc2565772fa1 ]

After commit f6ebbcf08f37 ("cpufreq: intel_pstate: Implement passive
mode with HWP enabled") it is possible to change the driver status
to "off" via sysfs with HWP enabled, which effectively causes the
driver to unregister itself, but HWP remains active and it forces the
minimum performance, so even if another cpufreq driver is loaded,
it will not be able to control the CPU frequency.

For this reason, make the driver refuse to change the status to
"off" with HWP enabled.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/intel_pstate.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 8c730a47e0537..97ed4fd0f1342 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2534,9 +2534,15 @@ static int intel_pstate_update_status(const char *buf, size_t size)
 {
 	int ret;
 
-	if (size == 3 && !strncmp(buf, "off", size))
-		return intel_pstate_driver ?
-			intel_pstate_unregister_driver() : -EINVAL;
+	if (size == 3 && !strncmp(buf, "off", size)) {
+		if (!intel_pstate_driver)
+			return -EINVAL;
+
+		if (hwp_active)
+			return -EBUSY;
+
+		return intel_pstate_unregister_driver();
+	}
 
 	if (size == 6 && !strncmp(buf, "active", size)) {
 		if (intel_pstate_driver) {
-- 
2.25.1

