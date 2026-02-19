Return-Path: <linux-pm+bounces-42889-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGyQDnNTl2kzxAIAu9opvQ
	(envelope-from <linux-pm+bounces-42889-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 19:16:19 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCAF1618C9
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 19:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C23D6300603C
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 18:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEFF28B4E2;
	Thu, 19 Feb 2026 18:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nZIs5gB9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34302D0607;
	Thu, 19 Feb 2026 18:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771524974; cv=none; b=PjG10od9yBUCm0VONvqvy15tuByZkGg1jiQSDNSe7BBcVr/AiOYszPJf0PdSBJEXduwf1b/zQThpQdV3IwP/KGh5qZknk25v99mUGwt3nj6jb8Qv5pNYfPbyHMeDlhlEekc3zKh47p2/pfN7qZhQ5P7Key2xvOXBKVRakHS0CQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771524974; c=relaxed/simple;
	bh=EkpkNDP5RMdbEPTYhEw2tx2LdhyFb1zRupH5ND78m3M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TGz7gJlZpeU35dXoqkO+dZsNO/h2jAR+8tTMJgag6kUapuI0fFf6JrC9/18uKFkwkFfGG56n3+0ecNuyFHGMKGLpsatoAtSArP0qldpiyMSU93b13GRtUGjL9wVUwEfrUYIIszL5p76NpiM4LKX7WMJgCIDOTeEOcRDXzWvyxoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nZIs5gB9; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771524973; x=1803060973;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EkpkNDP5RMdbEPTYhEw2tx2LdhyFb1zRupH5ND78m3M=;
  b=nZIs5gB9x3N2qBF71GGhgTKCNtBpnEhPUpvhvUf2OsRRxYySotQMWIZX
   xAdu2D9mXxFeuvFPv/RuG3XeOn5FgjUC0B/PHiGvSueUlWVk6dm2Xt3XA
   dOICoP+jqmmHyAe+auYaXOk7hpwI8G9SByASXKigKxBvdc9KV5GeN3UlN
   EjqVieLaI9xSe3rUoaCF5lFP9WzNO7l7HUmP8m3YJUqQKIxUZqrjDllW7
   EriPTYqA6PJE3z8EVdNZVQ6pUGhbjH04YgoHC4MDUGhxRby+gbhbYjR1J
   /07dLMeIiuFkcdr2E6ryXxheCWFZL0uFHnLWxCCWWnE2V1VXo1Y9NkZ5p
   g==;
X-CSE-ConnectionGUID: 8EuGSdhKRQ6qBM8VO07CTw==
X-CSE-MsgGUID: H2D0wyGcR2WSxZRaWvPheQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="83243494"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="83243494"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 10:16:12 -0800
X-CSE-ConnectionGUID: fylhLGphQ1+K3Z2XnR4GWQ==
X-CSE-MsgGUID: zH6HBFNNTiGdQate6aIfoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="213698676"
Received: from ettammin-desk.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.245.246.167])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 10:16:08 -0800
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Artem Bityutskiy <artem.bityutskiy@intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Allow repeated intel_pstate disable
Date: Thu, 19 Feb 2026 19:15:55 +0100
Message-ID: <20260219181600.16388-1-fabio.m.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42889-lists,linux-pm=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fabio.m.de.francesco@linux.intel.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.intel.com:mid]
X-Rspamd-Queue-Id: 4BCAF1618C9
X-Rspamd-Action: no action

Repeated intel_pstate disables currently return an error, adding unnecessary
complexity to userspace scripts which must first read the current state and
conditionally write 'off'.

Make repeated intel_pstate disables a no-op.

Cc: Artem Bityutskiy <artem.bityutskiy@intel.com>
Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 1625ec2d0d06..d639cc150092 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -3470,7 +3470,7 @@ static int intel_pstate_update_status(const char *buf, size_t size)
 {
 	if (size == 3 && !strncmp(buf, "off", size)) {
 		if (!intel_pstate_driver)
-			return -EINVAL;
+			return 0;
 
 		if (hwp_active)
 			return -EBUSY;
-- 
2.53.0


