Return-Path: <linux-pm+bounces-6081-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1E689CF64
	for <lists+linux-pm@lfdr.de>; Tue,  9 Apr 2024 02:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 273C41C23F28
	for <lists+linux-pm@lfdr.de>; Tue,  9 Apr 2024 00:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E51915A5;
	Tue,  9 Apr 2024 00:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8wWpK0L"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBA610F2
	for <linux-pm@vger.kernel.org>; Tue,  9 Apr 2024 00:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712622713; cv=none; b=WsBYFNmiVDfwIJZn14Xaf/Nkk6Aq5+CFAO92qEUZMvRJdacpPZB36cqkfSuD8+66SNdpLsDUMjzJ+Wfcif0JEYg3WrSTqtUDtFLQoVLb7AEDvswiTWsD+5IYfbRkZutxms2LUcifztH099mpL2aYwwXS7+H82uwgme7MzqdDRT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712622713; c=relaxed/simple;
	bh=m1wNIKXYReCRtCA27drNQoejsNccbOSUwhWnFKuE2VI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DvWxQvbremv92luTFOUbE1nDFnU90Dq7x/KO27YCI1I4rnawFs8UiG0cYyKVlj+Mfn1oiDmZ7pU6QyRe1VyVbjPLP/Paaj23jSThGRrrhzdzBhYQa0CevnUEgTOolHRpFeNv69c951w16UIPXMWSgBhz7i83YL6xYHV7/nU2Wnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8wWpK0L; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dcc80d6006aso4934541276.0
        for <linux-pm@vger.kernel.org>; Mon, 08 Apr 2024 17:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712622710; x=1713227510; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s5Cg1j6eS8z+eni2zNZbijBria177Tq7vISFa7NEoVA=;
        b=k8wWpK0Lho4+4qoLXNlHRQWtOubLe4vZXFUtRfCvID5VnbTnA4zVq18e8yxjufF6M8
         Ny6G+TlBw80Ow/5wF00R+bwC7qVr+InybaD9NKxGQQclJMO32m6JPCZtKr8wMZLKOzgf
         4RWJNFx8XUfXTO3O6AoVRsIhFG5ClWFwArR1Yzdd7hZTJpyKFbuAy2rGAGnYQdoCY0Pl
         e8s9iCrUlC+njROY4VcZ5OQlBiq4F4HH5Q2phHfujrAD0IC0LnfEuJNX0zMPCizoH6kj
         32T7R5Jkldsm8CvBxwd1FrNGjvn/UO4s2PyVLUXOGQEXYNG078ypQuqAfn7Hto/xmSdF
         nARQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712622710; x=1713227510;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s5Cg1j6eS8z+eni2zNZbijBria177Tq7vISFa7NEoVA=;
        b=H/kOIRsu3TjbJhyBBBeZcAUVJVMIBm+lFm9izWVJlraeh4smuHI9lTCf/kyEY2wEOB
         CiSQyE4Cyp34TUX00Jt+14Dd04llA+y1qeabXzo5Q8FeqSfAbSnhhwcI0MU6UskiHScl
         0AlXjE0Eh48r8xZ025+V+q4/+W1xmvfylcSRVWti9++NvoSp5HACBs6aJYLT35nj1ygo
         EMtfv28BKy67zBxPB01Armwep6D+KufbhuvblaEk7CLHqTLWne+9WPE4imI8jUBKskc1
         zvCkzYlZ+rz4EFo72w/HvBrUL83Vcx4fLSJ838s2RoI/c1VYyMza2RKhJqx4A3IkAroL
         ykdQ==
X-Gm-Message-State: AOJu0Yw9wA+NcDpDerGj7jvhxJbByPXq8bG029FdMPTgrUb6IPK1l8O1
	owlcETj3xyvr6511aqdeaEhiGXbv1Cda0+8RC1OvKOd+zs4jI67K0vQoOmVE
X-Google-Smtp-Source: AGHT+IGqo34gwDaVO/m+5VpHdBRasQlU4JVxPK9Bh03IIycMFs0uLvhCbmteMbRKqDkLy3Bg67E3Bw==
X-Received: by 2002:a05:6902:20c1:b0:dc7:4c21:fbd5 with SMTP id dj1-20020a05690220c100b00dc74c21fbd5mr7588756ybb.0.1712622710360;
        Mon, 08 Apr 2024 17:31:50 -0700 (PDT)
Received: from lenb-Intel-NUC8i7HVKVA.search.charter.net (2603-9000-9f01-67cf-100c-5508-c194-b194.inf6.spectrum.com. [2603:9000:9f01:67cf:100c:5508:c194:b194])
        by smtp.gmail.com with ESMTPSA id h6-20020a25e206000000b00dc74ac54f5fsm1531949ybe.63.2024.04.08.17.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 17:31:50 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 09/26] tools/power turbostat: enhance -D (debug counter dump) output
Date: Mon,  8 Apr 2024 20:31:03 -0400
Message-Id: <2d2ccd57338779469777d4319152151272994182.1712621427.git.len.brown@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <e5f4e68eed85fa8495d78cd966eecc2b27bb9e53.1712621427.git.len.brown@intel.com>
References: <e5f4e68eed85fa8495d78cd966eecc2b27bb9e53.1712621427.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Len Brown <len.brown@intel.com>

Eliminate redundant debug output for core and package scope counters.

Include name and path for all "ADDED" counters.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 531f37e5f92a..60432753fe6a 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1673,11 +1673,13 @@ int dump_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p
 			outp += sprintf(outp, "SMI: %d\n", t->smi_count);
 
 		for (i = 0, mp = sys.tp; mp; i++, mp = mp->next) {
-			outp += sprintf(outp, "tADDED [%d] msr0x%x: %08llX\n", i, mp->msr_num, t->counter[i]);
+			outp +=
+			    sprintf(outp, "tADDED [%d] %8s msr0x%x: %08llX %s\n", i, mp->name, mp->msr_num,
+				    t->counter[i], mp->path);
 		}
 	}
 
-	if (c) {
+	if (c && is_cpu_first_thread_in_core(t, c, p)) {
 		outp += sprintf(outp, "core: %d\n", c->core_id);
 		outp += sprintf(outp, "c3: %016llX\n", c->c3);
 		outp += sprintf(outp, "c6: %016llX\n", c->c6);
@@ -1687,12 +1689,14 @@ int dump_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p
 		outp += sprintf(outp, "Joules: %0X\n", c->core_energy);
 
 		for (i = 0, mp = sys.cp; mp; i++, mp = mp->next) {
-			outp += sprintf(outp, "cADDED [%d] msr0x%x: %08llX\n", i, mp->msr_num, c->counter[i]);
+			outp +=
+			    sprintf(outp, "cADDED [%d] %8s msr0x%x: %08llX %s\n", i, mp->name, mp->msr_num,
+				    c->counter[i], mp->path);
 		}
 		outp += sprintf(outp, "mc6_us: %016llX\n", c->mc6_us);
 	}
 
-	if (p) {
+	if (p && is_cpu_first_core_in_package(t, c, p)) {
 		outp += sprintf(outp, "package: %d\n", p->package_id);
 
 		outp += sprintf(outp, "Weighted cores: %016llX\n", p->pkg_wtd_core_c0);
@@ -1721,7 +1725,9 @@ int dump_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p
 		outp += sprintf(outp, "PTM: %dC\n", p->pkg_temp_c);
 
 		for (i = 0, mp = sys.pp; mp; i++, mp = mp->next) {
-			outp += sprintf(outp, "pADDED [%d] msr0x%x: %08llX\n", i, mp->msr_num, p->counter[i]);
+			outp +=
+			    sprintf(outp, "pADDED [%d] %8s msr0x%x: %08llX %s\n", i, mp->name, mp->msr_num,
+				    p->counter[i], mp->path);
 		}
 	}
 
-- 
2.40.1


