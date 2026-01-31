Return-Path: <linux-pm+bounces-41831-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAjuNNocfmn5VgIAu9opvQ
	(envelope-from <linux-pm+bounces-41831-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jan 2026 16:16:42 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07567C2A7D
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jan 2026 16:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24906300B120
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jan 2026 15:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E32528DB56;
	Sat, 31 Jan 2026 15:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkjZIKPs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C927A20CCDC
	for <linux-pm@vger.kernel.org>; Sat, 31 Jan 2026 15:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769872599; cv=none; b=ntNtliOSXJbVt+X2YYZmkp2N4EwuDUviB4iR2jx3O18lnQNoakfEmdHW6LcSVlzfzN1jBG8SeWSf/jveR9ueM8a58k5N8DRVlU+d06Ia4iMXqIv5zuG818PzSZ/d9Aj38UmkAVvhuMYIZ1R3GIVso5sxIK38BgQVURLSYWqltec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769872599; c=relaxed/simple;
	bh=QklRex04lsv9sydApIJql2WafhSZODxLKXRvx39yn4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VyZIFtFsFCdNpCDyhjtZyufR8yNlNJwGKdvONpVm9CCp75Dbcd2C1zg96M+qsjT5NMIoqW6XEeB8lm9U6a2rtd2QvoLnxCNbcHS3tjkehRj2uAwyDxPXEoWiSZE4QDqQs+M4XssYVowawdVVmN9R6LehsM73ilQGcXJNVN1dDS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jkjZIKPs; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a07fac8aa1so22815375ad.1
        for <linux-pm@vger.kernel.org>; Sat, 31 Jan 2026 07:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769872597; x=1770477397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CGDyJsMy6AHy/TBRAYTPojspsnlgHkAhmaua/x9b1+0=;
        b=jkjZIKPsyxYLTIYclDIhAPVQ5r4HtnIAX+XzoJ96qu63x2f6f8gF7Fz7lqsFPLPg8m
         wlQHanlgJ60jMD/7/ZzfH+Q4W63B3MUed/TJz5B/iZAtzREOf/XcOI0zKIh2HezOMK5A
         omxfVxHqugggSxJSnHk223mVyhxuthcBT13tr5pYpxE8pBedlzdWNBagydhKr9R71uME
         zD5ZeKjqv25L7l1kb5/LFR7a9RvBSQT9EZDKN+j+xq6GZllTvrM1OO2qZFefC9e4T78V
         bvMOYbNxstcBSQirHd+N06weK5OScWSCh5ebtidByJh1PP68DH1BhAPNMGvWEtF+c+ML
         3qNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769872597; x=1770477397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGDyJsMy6AHy/TBRAYTPojspsnlgHkAhmaua/x9b1+0=;
        b=PKnhSeOQfd9rWVIL/bqTIykkPU9O3EUksL66ASAGrTHfrxG9Qu04q+5aiAY120uBPV
         eRJ/5+HqqLxD7hPISaBkc5Z1xrWZkLf5onNOP7rVCu11fvwHFSCYmsGfAryOPMddFjuU
         8PHYo5PHNKoXLtsvYjtQs4Gq5kqSWjR4ir2LNxBJD+1HdLQbPMRuYQmawrXQXQ4TOZtc
         1aA4uwe61j5t4JPNsJMdDP4yW24xeWE8EOkxcDH0HAaC6hHDrAaXVRjkRfq6/ERDXqSn
         S+/quZ9bhN0qtBj/L1XQaJoDSPU5xcYiLtRWizXVXQtVMbITCuFtB1tYhJnKcIAwz3bk
         3UTw==
X-Forwarded-Encrypted: i=1; AJvYcCXYEwbUO6HlF9gEH2ltSgw1I9CYeRbCLTbY2S20BEJvX0qSBfQvjV0LvIcLUHE9XP9O+6nX6z9gqg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAgW6VuDiNZfML5zF/eCqAQ5GnY7qDhaXYQg1nT8hUtkkf/EHB
	CcYoHAk+tJgoMyYc/QuRAdIuOFecADjpaEiZav1ECiJc2PtzRL4+vsGQ
X-Gm-Gg: AZuq6aL/gPNthoQrFVJuVZiJtiVYpaM7fbv64NtC/wEiNnXD9FYU7A/2Gk7T5+4NWP1
	tuZTdhYkWkdGt10Z4q4ylc6WJQgb/r/0JpH7sptkwvMTv5x0EA+Ydb/03jj46fW4HiE9PIVJFAd
	DAFxhTjAareQwbOqa5KE1PgjwN1n93ZQC6Md2YnjVpzhTSac2eUsXxvJE+aAoKDA9Zy0rZohuRZ
	qY6DUU8vp5uYRm9gI+/nqM4gwn7HcCADS4P0rYRi/di0Gu7hlgiosln3PsTgV10yKBawIheqnFj
	G7JsWEvRH51qaUyKzHm2HIipbMvSCqDOC1Sjitm1Y4sDoipVKYvrOpS3EbIQsqdVswoxD+RYk25
	nc77Cw77L9dGi0wkXehWy0kSX7QTBILc4DcgpMyQCCOZA+PejjhOwfI0PL71ciMWwuhY4osCnLf
	hQn4d6XQUts64RwtzuQIBkEQEiHA==
X-Received: by 2002:a17:903:38c8:b0:295:5da6:6011 with SMTP id d9443c01a7336-2a8d7eb595emr68327685ad.11.1769872597120;
        Sat, 31 Jan 2026 07:16:37 -0800 (PST)
Received: from gmail.com ([2402:e280:3e9b:22f:1ecb:768f:dd7b:8c69])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b6e4110sm97826815ad.84.2026.01.31.07.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 07:16:36 -0800 (PST)
From: Sumeet Pawnikar <sumeet4linux@gmail.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	sumeet4linux@gmail.com
Subject: [PATCH] drivers: thermal: intel: tcc_cooling: remove unused variable
Date: Sat, 31 Jan 2026 20:46:15 +0530
Message-ID: <20260131151615.6230-1-sumeet4linux@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41831-lists,linux-pm=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_NEQ_ENVFROM(0.00)[sumeet4linux@gmail.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 07567C2A7D
X-Rspamd-Action: no action

Remove the unused variable 'ret' in tcc_cooling_init() and simplify the
error handling path. The variable 'ret' was declared but only used to
store the return value of PTR_ERR(tcc_cdev) before immediately returning
it, which is redundant.

Remove the duplicate variable declaration where both 'ret' and 'err' were
declared, but only 'err' was actually needed.
Also, simplify the error path by directly returning PTR_ERR(tcc_cdev)
instead of storing it in an intermediate variable.

Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
---
 drivers/thermal/intel/intel_tcc_cooling.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/intel/intel_tcc_cooling.c b/drivers/thermal/intel/intel_tcc_cooling.c
index f352ecafbedf..a5b31b25225e 100644
--- a/drivers/thermal/intel/intel_tcc_cooling.c
+++ b/drivers/thermal/intel/intel_tcc_cooling.c
@@ -72,12 +72,10 @@ MODULE_DEVICE_TABLE(x86cpu, tcc_ids);
 
 static int __init tcc_cooling_init(void)
 {
-	int ret;
+	int err;
 	u64 val;
 	const struct x86_cpu_id *id;
 
-	int err;
-
 	id = x86_match_cpu(tcc_ids);
 	if (!id)
 		return -ENODEV;
@@ -103,10 +101,9 @@ static int __init tcc_cooling_init(void)
 	tcc_cdev =
 	    thermal_cooling_device_register("TCC Offset", NULL,
 					    &tcc_cooling_ops);
-	if (IS_ERR(tcc_cdev)) {
-		ret = PTR_ERR(tcc_cdev);
-		return ret;
-	}
+	if (IS_ERR(tcc_cdev))
+		return PTR_ERR(tcc_cdev);
+
 	return 0;
 }
 
-- 
2.43.0


