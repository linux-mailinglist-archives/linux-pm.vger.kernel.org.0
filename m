Return-Path: <linux-pm+bounces-43073-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMsPLijBnGmgKAQAu9opvQ
	(envelope-from <linux-pm+bounces-43073-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 22:05:44 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6175A17D596
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 22:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 239253016AFC
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 21:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06BE37881C;
	Mon, 23 Feb 2026 21:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Gcpvbegx"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23079314B6A
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 21:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771880741; cv=none; b=fwFapR2jA9plDiEY6uGPHkB5hQ+NyE3LhjhMgSBE2D6nXMGo7jTZWbMbTs+MP3wIGOyzmZ772yV6kGyqijdwZssDFpwBV3gPicx10fpdIFmjDr+OeXx4/PkK+FSFH0y6Jhw7guDG0pvDd2XRwGWscP0hSFHoyM6gkZzH9094mGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771880741; c=relaxed/simple;
	bh=W0HLqr4M+aT9zcs+iBjjowOW9dEMVPG5rR6ftCMpuds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VyPAai5mxmtPv+PP83cgfB8Usf8aYg3DCf0Y9nggPj+Yg5OvHiM4f1L7s33+Cb9d5/J/W7Ouztm2SrhH9LVothOIawoXOaTkNbu9Hh98qR3Ap6zr4Z6zKBiWqsfxzmsQ9phIxLFC63BUDlL+/xEh/7IRTK8uNrDTwizGC+iyoxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Gcpvbegx; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771880728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jre9+4UjOPVBJ/a4+bDyRbBtwEbG+MxVnSpNOnp6Bwc=;
	b=GcpvbegxpJ86YYXGF2JPYOMkYvx6Xtcwi4as+ok16aoboW2xvOgMHyHtSmFFc6Qn0PnwDH
	ylIrDUOS8/d+bb0OapryM8w78ue3iiGhKcTcJgWRE8BOwQt1K3jDW/EaqJwfqtmWtVn51t
	qyUUfAWIsK0/G1/S92fkqSzDtMeaogg=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: governor: Use sysfs_emit in sysfs show functions
Date: Mon, 23 Feb 2026 22:03:51 +0100
Message-ID: <20260223210351.344388-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43073-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,linux.dev:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6175A17D596
X-Rspamd-Action: no action

Replace sprintf() with sysfs_emit() in sysfs show functions.
sysfs_emit() is preferred for formatting sysfs output because it
provides safer bounds checking.  No functional changes.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/cpufreq/cpufreq_governor.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index 168c23fd7fca..732fd4d1a803 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -21,6 +21,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/sysfs.h>
 
 /* Ondemand Sampling types */
 enum {OD_NORMAL_SAMPLE, OD_SUB_SAMPLE};
@@ -57,7 +58,7 @@ static ssize_t file_name##_show						\
 {									\
 	struct dbs_data *dbs_data = to_dbs_data(attr_set);		\
 	struct _gov##_dbs_tuners *tuners = dbs_data->tuners;		\
-	return sprintf(buf, "%u\n", tuners->file_name);			\
+	return sysfs_emit(buf, "%u\n", tuners->file_name);		\
 }
 
 #define gov_show_one_common(file_name)					\
@@ -65,7 +66,7 @@ static ssize_t file_name##_show						\
 (struct gov_attr_set *attr_set, char *buf)				\
 {									\
 	struct dbs_data *dbs_data = to_dbs_data(attr_set);		\
-	return sprintf(buf, "%u\n", dbs_data->file_name);		\
+	return sysfs_emit(buf, "%u\n", dbs_data->file_name);		\
 }
 
 #define gov_attr_ro(_name)						\
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4


