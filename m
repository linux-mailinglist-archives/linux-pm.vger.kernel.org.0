Return-Path: <linux-pm+bounces-6086-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CA089CF69
	for <lists+linux-pm@lfdr.de>; Tue,  9 Apr 2024 02:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A8ED1F248DD
	for <lists+linux-pm@lfdr.de>; Tue,  9 Apr 2024 00:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F214A04;
	Tue,  9 Apr 2024 00:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMhIVoce"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290866FCB
	for <linux-pm@vger.kernel.org>; Tue,  9 Apr 2024 00:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712622718; cv=none; b=BM2wMyV5NUi8ZMzKrvta4jIUFm4y4s8+mfRxiNhbeTbgLAazg3LDzATRic+ZyjyCGruELmQsKtnX6wau3Cx2Qg+mMf1ToEsipdTJYSjNLWP99WF5BAfp3LKI21a9pLyhI4Fwm/iWt046YLP3BeufCZfFIACHXr13AT+sTSGw20E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712622718; c=relaxed/simple;
	bh=gi9Nq/rLi6q4vLZrhgGgB4P3Z0EKqyougPf4b2pLf1s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FvWS03JNQNQQFZp2NLp2qn9D8D82CZRtWTuS25lgOoYfgxaEAOs7DeqEXymgBOJ371ulqtf67HRRZPBvWKadVfQhNKol7YBA0J2JbBlzlZLMcoa80C7oYhuXS6DH6yJf833hb7Im8Pu1lP/KsdO0RYYUYJIJlg1XJxikmJvPugo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hMhIVoce; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dccb1421bdeso4979485276.1
        for <linux-pm@vger.kernel.org>; Mon, 08 Apr 2024 17:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712622716; x=1713227516; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=luDi78ZV0wVN225rOuayHwvu4VrSv9q1v6WTiodjvj0=;
        b=hMhIVoceLWwRcCleu6jx1E1m9hpuPCK/WGNNl2521nsmjPC8dvY+GgZFNrzysmeQIj
         yCfPbGZlBPa4Y0u1lhindLGhIqjMDeYk3grCMZjGN2UwHeYCI/pCrfnGUCHnEvz43aZR
         verw3GP+zXDEOfbbhRToR7ly105B69IK7rQBHADyzx3FKnTjqg5XL3ZohhDAWddQQ+JX
         zd03lamLTuPa2Yk+QPjh3pAL+QDyloXG8D/lOKx+obJYhTz58BpJGlEdxlZEdNtsbJTS
         GhyEkBABGKF70yZXSfA+F2q/Xu3mftFJrzqiHlt0Y6Vgg63bAu81ie54ckeiEhIHK0DS
         /R1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712622716; x=1713227516;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=luDi78ZV0wVN225rOuayHwvu4VrSv9q1v6WTiodjvj0=;
        b=qVedvbZh8hFJEg5ob7h/pQdM72CWFfmQkGWzdRsMOElHuV/obJx3sYkr32IrPzsnqT
         vqIPRHW+lxaMwtzHM273rjl4t5JZNUCzBvIKit1r1H9i/ZfGyOLISs5R2M+YLsVgDn4P
         B+RREZ0dP72SFWPLVi89F4tCHYSE8tjV9v/2ANv4hw4nnFEtmQDh/L57l3d4Ie+MEibW
         LBp8HS3+YsteFUCGRna1lp/VcLEzHFXnc5GbFTRiI0w/5EVLJAdcLcKc5b/nP3QOFiWn
         HjVnjxLiV9w8Aq6gaXx5gLqZCG+FF7rs2mUfZ3dLZZCN5LMIpJ91SzcQlp/HrPrJIrpG
         ejXQ==
X-Gm-Message-State: AOJu0YwoIoccRKLvezXcQl0HBtQ0uPar83EBnmim0al2XIHUX72oxBxE
	AR1B05R/EJDQbqXEgJ6u9JWoJdSEP58a4tWIZI3lp7Zup9YIUhdbNCfwOsM9
X-Google-Smtp-Source: AGHT+IFJgM+1Klwmb4uQ7BoQCWqmsF5nuUtSBJNpO2RDI+fDaxvvVRJTeoxcXWRUzaciZrtqfPgm2w==
X-Received: by 2002:a25:2102:0:b0:dc7:1d:5db4 with SMTP id h2-20020a252102000000b00dc7001d5db4mr7241733ybh.34.1712622716008;
        Mon, 08 Apr 2024 17:31:56 -0700 (PDT)
Received: from lenb-Intel-NUC8i7HVKVA.search.charter.net (2603-9000-9f01-67cf-100c-5508-c194-b194.inf6.spectrum.com. [2603:9000:9f01:67cf:100c:5508:c194:b194])
        by smtp.gmail.com with ESMTPSA id h6-20020a25e206000000b00dc74ac54f5fsm1531949ybe.63.2024.04.08.17.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 17:31:55 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 14/26] tools/power turbostat: add early exits for permission checks
Date: Mon,  8 Apr 2024 20:31:08 -0400
Message-Id: <aed48c48fa65abdd584e14f7d0273711bc10d223.1712621427.git.len.brown@intel.com>
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

From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>

Checking early if the permissions are even needed gets rid of the
warnings about some of them missing. Earlier we issued a warning in case
of missing MSR and/or perf permissions, even when user never asked for
counters that require those.

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 66 +++++++++++++++++++++++++--
 1 file changed, 61 insertions(+), 5 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 30db6e92193a..e5e01b58992e 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -5818,6 +5818,14 @@ static int has_instr_count_access(void)
 	return has_access;
 }
 
+bool is_aperf_access_required(void)
+{
+	return BIC_IS_ENABLED(BIC_Avg_MHz)
+	    || BIC_IS_ENABLED(BIC_Busy)
+	    || BIC_IS_ENABLED(BIC_Bzy_MHz)
+	    || BIC_IS_ENABLED(BIC_IPC);
+}
+
 /*
  * Linux-perf manages the HW instructions-retired counter
  * by enabling when requested, and hiding rollover
@@ -5833,8 +5841,7 @@ void linux_perf_init(void)
 			err(-1, "calloc fd_instr_count_percpu");
 	}
 
-	const bool aperf_required = BIC_IS_ENABLED(BIC_Avg_MHz) || BIC_IS_ENABLED(BIC_Busy) ||
-	    BIC_IS_ENABLED(BIC_Bzy_MHz) || BIC_IS_ENABLED(BIC_IPC);
+	const bool aperf_required = is_aperf_access_required();
 	if (aperf_required && has_aperf && amperf_source == AMPERF_SOURCE_PERF) {
 		fd_amperf_percpu = calloc(topo.max_cpu_num + 1, sizeof(*fd_amperf_percpu));
 		if (fd_amperf_percpu == NULL)
@@ -5903,6 +5910,9 @@ static int has_amperf_access_via_perf(void)
 /* Check if we can access APERF and MPERF */
 static int has_amperf_access(void)
 {
+	if (!is_aperf_access_required())
+		return 0;
+
 	if (!no_msr && has_amperf_access_via_msr())
 		return 1;
 
@@ -6581,7 +6591,8 @@ static void set_amperf_source(void)
 {
 	amperf_source = AMPERF_SOURCE_PERF;
 
-	if (no_perf || !has_amperf_access_via_perf())
+	const bool aperf_required = is_aperf_access_required();
+	if (no_perf || !aperf_required || !has_amperf_access_via_perf())
 		amperf_source = AMPERF_SOURCE_MSR;
 
 	if (quiet || !debug)
@@ -6590,8 +6601,51 @@ static void set_amperf_source(void)
 	fprintf(outf, "aperf/mperf source preference: %s\n", amperf_source == AMPERF_SOURCE_MSR ? "msr" : "perf");
 }
 
+bool is_msr_access_required(void)
+{
+	/* TODO: add detection for dynamic counters from add_counter() */
+	if (no_msr)
+		return false;
+
+	return BIC_IS_ENABLED(BIC_SMI)
+	    || BIC_IS_ENABLED(BIC_CPU_c1)
+	    || BIC_IS_ENABLED(BIC_CPU_c3)
+	    || BIC_IS_ENABLED(BIC_CPU_c6)
+	    || BIC_IS_ENABLED(BIC_CPU_c7)
+	    || BIC_IS_ENABLED(BIC_Mod_c6)
+	    || BIC_IS_ENABLED(BIC_CoreTmp)
+	    || BIC_IS_ENABLED(BIC_Totl_c0)
+	    || BIC_IS_ENABLED(BIC_Any_c0)
+	    || BIC_IS_ENABLED(BIC_GFX_c0)
+	    || BIC_IS_ENABLED(BIC_CPUGFX)
+	    || BIC_IS_ENABLED(BIC_Pkgpc3)
+	    || BIC_IS_ENABLED(BIC_Pkgpc6)
+	    || BIC_IS_ENABLED(BIC_Pkgpc2)
+	    || BIC_IS_ENABLED(BIC_Pkgpc7)
+	    || BIC_IS_ENABLED(BIC_Pkgpc8)
+	    || BIC_IS_ENABLED(BIC_Pkgpc9)
+	    || BIC_IS_ENABLED(BIC_Pkgpc10)
+	    || BIC_IS_ENABLED(BIC_CorWatt)
+	    || BIC_IS_ENABLED(BIC_Cor_J)
+	    || BIC_IS_ENABLED(BIC_PkgWatt)
+	    || BIC_IS_ENABLED(BIC_CorWatt)
+	    || BIC_IS_ENABLED(BIC_GFXWatt)
+	    || BIC_IS_ENABLED(BIC_RAMWatt)
+	    || BIC_IS_ENABLED(BIC_Pkg_J)
+	    || BIC_IS_ENABLED(BIC_Cor_J)
+	    || BIC_IS_ENABLED(BIC_GFX_J)
+	    || BIC_IS_ENABLED(BIC_RAM_J)
+	    || BIC_IS_ENABLED(BIC_PKG__)
+	    || BIC_IS_ENABLED(BIC_RAM__)
+	    || BIC_IS_ENABLED(BIC_PkgTmp)
+	    || (is_aperf_access_required() && !has_amperf_access_via_perf());
+}
+
 void check_msr_access(void)
 {
+	if (!is_msr_access_required())
+		no_msr = 1;
+
 	check_dev_msr();
 	check_msr_permission();
 
@@ -6601,10 +6655,12 @@ void check_msr_access(void)
 
 void check_perf_access(void)
 {
-	if (no_perf || !has_instr_count_access())
+	const bool intrcount_required = BIC_IS_ENABLED(BIC_IPC);
+	if (no_perf || !intrcount_required || !has_instr_count_access())
 		bic_enabled &= ~BIC_IPC;
 
-	if (!has_amperf_access()) {
+	const bool aperf_required = is_aperf_access_required();
+	if (!aperf_required || !has_amperf_access()) {
 		bic_enabled &= ~BIC_Avg_MHz;
 		bic_enabled &= ~BIC_Busy;
 		bic_enabled &= ~BIC_Bzy_MHz;
-- 
2.40.1


