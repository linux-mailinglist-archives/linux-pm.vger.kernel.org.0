Return-Path: <linux-pm+bounces-43083-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENQmIiMPnWnoMgQAu9opvQ
	(envelope-from <linux-pm+bounces-43083-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 03:38:27 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BC0181103
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 03:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CFF03052BAA
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 02:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECB022D4C3;
	Tue, 24 Feb 2026 02:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jst2vhew"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4409F239E7F
	for <linux-pm@vger.kernel.org>; Tue, 24 Feb 2026 02:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771900704; cv=none; b=iKTQkEKnoi22hKV63IfrAPzeF0/SdrhA6cMkzmu5ewXnxcHIRh0Alp/JA+QgoK6G5Q2jdEdumB+1Vfe+9+Q0hRovE3cdU1bQebt9pFxiPp2SzCFoeZzsroDmGnkDQjsxQJkyg401ToHGnwNi40VwNdChLH+6DxgwUBfsDEWJhig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771900704; c=relaxed/simple;
	bh=fn2u73mBSTbAd/EdpQfH9E2MCEctzADYuwz366K+YQY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h3ECAn7bEgwyH41BvMGpvsUGwwtLavS/MYLFtFWAGJBwxeXkNngmW4fjvgWBWk0RNGdr/x8o3aaqb/qFXT6zZkrsNdpyL6buKEsxe7bPcG0ZXXapZUHcmxRLrAFmIGe2EKa4R97rMHNP6+7DwvSC69VdQmtrt1SXUqvFHt33p5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jst2vhew; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-896f44dc48dso46253076d6.2
        for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 18:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771900702; x=1772505502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uHi4kGutlHIiCP5G7IafBayijdH0c6FDLs2gsnvP6Rc=;
        b=jst2vhewThOnLiMiXBgE4suG6tMMKaYmHbaDifof2ujJzbh9QS3pNJjIckoULbXkLN
         Ax6INe+0l4GDsvJIAtSrbV9Dl1xC7m7gMtyJkI8aOLeIgbBovVI+LwIZuptnYQ/g7BG5
         Hvr61z1eJ0KujUToVGylGWe34R+mNIjN3XlIQLfe/UnelW0jctstp69cJ+SKlU2soneK
         XEvWNFOAIu66JfvrkmrjJglOl1llSHocTesJHNsFqxJ6/Guwnm0iyaYwsQI020Tx3hTR
         h92V4LSZ6LwH6x+13qyaEPeFcb5MINDSHdWQ73m4dsODsblMmVKm6b7HyZ7dP7kQasCv
         KfbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771900702; x=1772505502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHi4kGutlHIiCP5G7IafBayijdH0c6FDLs2gsnvP6Rc=;
        b=uecdZlRHEf/3ZAsRc8cG+zVWKKgeEkbnqnhdYYHRjvgCgT1hql+1hP9uYG9X6+TAQm
         rEyJgEkeaRUOVBod97HIlQeubmSizfteSLfaXdGlvPnQaRmYMnZQ2kcL/DhMoRApdPaE
         VdGL2sy0V+BZJs7/Dt6lzKhn4uFA6n6E63OcZJaWVcSOyAbSX/3vKwhJhqs2CUH2NXgF
         sCzVSlobKMxCDvdDWPohBe5i4ZiDPpzyCJTtOvV3+EuDtEEnKK5cPkUAJmwjEEp1HV4S
         +ffQ69IIGH+VH2NCFCFU1FSGrepE5R6foGEkuButsHGOA9i5Qz0sM9aEHSOU7cSVs3ws
         QRwg==
X-Gm-Message-State: AOJu0YxU8dRiiaeZHPs3wquPiRmntIMoM/thENgg9OPx+9yMP/u0FXqC
	Zwu4uVEeRfJNJpdR2mp/I0HOv+E4drZCJJgXTXRbFBmodoIEmKeaUWDO
X-Gm-Gg: ATEYQzx22KAy/Jb+dZHF+z40mfbZ5ys1BAhvlzPb0Wlp4zjsf0HoZsSqRKTh1V1PBCA
	sTf8DyuIwSZGYgDFaCSWnUyCdxX9+SNZYIQjp8Zk5qAPbAoPpPIvuyfTpMUOzJHbSgWRVf233yv
	lkZegKZa5hK71XjH0cOzAhAZisx5pLZmfc6I09ZPgO8k7tta1j91iVtbQCR4ulsWzfIei5BZ3Ec
	MbBPuy2ExJNQfUiIvPc8zfFxLnruha+s7Y0L73YICQqc8kT6CF9nWYTrKMYdvNnqdIieN/fls+k
	xRCoVtygOZF8WpLUXYarLi24Gu4gExoXblQwQV/ABxmpCJJeT383PBD5xdO4Ms8yVCN/8olhady
	wrEQG/NX8A5vjrifid+1pN9sdWh25lEqIjhdOoNjnI6FoOJZPKcrNkMKL3h5Cg7OV0/6DRBstbA
	GBs6LZBMiDNC4ZXTGXizTYrX0teZX/VX3fk3tOTDW/nMU0xmjHeNYDjWSii6JOnAks1LEZUa6+w
	ew=
X-Received: by 2002:ad4:5942:0:b0:895:5dd:3d48 with SMTP id 6a1803df08f44-89979d85395mr168711276d6.59.1771900702162;
        Mon, 23 Feb 2026 18:38:22 -0800 (PST)
Received: from localhost.localdomain (modemcable231.2-131-66.mc.videotron.ca. [66.131.2.231])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997c691243sm82072666d6.3.2026.02.23.18.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 18:38:21 -0800 (PST)
From: Serhii Pievniev <spevnev16@gmail.com>
To: lenb@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Serhii Pievniev <spevnev16@gmail.com>
Subject: [PATCH] tools/turbostat: fix microcode patch level reading for AMD/Hygon
Date: Mon, 23 Feb 2026 21:37:19 -0500
Message-ID: <20260224023719.65165-1-spevnev16@gmail.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43083-lists,linux-pm=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[spevnev16@gmail.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E0BC0181103
X-Rspamd-Action: no action

turbostat always used the same logic to read the microcode patch level,
which is correct for Intel but not for AMD/Hygon.
While Intel stores the patch level in the upper 32 bits of MSR, AMD
stores it in the lower 32 bits, which previously caused turbostat to
report the microcode version as 0x0 on AMD/Hygon.

Split the logic into two paths, using upper bits of MSR_IA32_UCODE_REV
for Intel and lower bits of MSR_AMD64_PATCH_LEVEL for AMD/Hygon.
Although both MSRs share the same address (0x8b), separate constants
make this semantic difference explicit.

Signed-off-by: Serhii Pievniev <spevnev16@gmail.com>
---
 tools/power/x86/turbostat/turbostat.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 1a2671c2820..2698ac89376 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -9122,10 +9122,21 @@ void process_cpuid()
 	cpuid_has_hv = ecx_flags & (1 << 31);
 
 	if (!no_msr) {
-		if (get_msr(sched_getcpu(), MSR_IA32_UCODE_REV, &ucode_patch))
-			warnx("get_msr(UCODE)");
-		else
-			ucode_patch_valid = true;
+		if (authentic_amd || hygon_genuine) {
+			if (get_msr(sched_getcpu(), MSR_AMD64_PATCH_LEVEL, &ucode_patch)) {
+				warnx("get_msr(UCODE)");
+			} else {
+				ucode_patch_valid = true;
+				ucode_patch &= 0xFFFFFFFF;
+			}
+		} else {
+			if (get_msr(sched_getcpu(), MSR_IA32_UCODE_REV, &ucode_patch)) {
+				warnx("get_msr(UCODE)");
+			} else {
+				ucode_patch_valid = true;
+				ucode_patch = (ucode_patch >> 32) & 0xFFFFFFFF;
+			}
+		}
 	}
 
 	/*
@@ -9139,7 +9150,7 @@ void process_cpuid()
 	if (!quiet) {
 		fprintf(outf, "CPUID(1): family:model:stepping 0x%x:%x:%x (%d:%d:%d)", family, model, stepping, family, model, stepping);
 		if (ucode_patch_valid)
-			fprintf(outf, " microcode 0x%x", (unsigned int)((ucode_patch >> 32) & 0xFFFFFFFF));
+			fprintf(outf, " microcode 0x%llx", ucode_patch);
 		fputc('\n', outf);
 
 		fprintf(outf, "CPUID(0x80000000): max_extended_levels: 0x%x\n", max_extended_level);
-- 
2.53.0


