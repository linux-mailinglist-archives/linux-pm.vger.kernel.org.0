Return-Path: <linux-pm+bounces-43223-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPLYAdqCn2mIcgQAu9opvQ
	(envelope-from <linux-pm+bounces-43223-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 00:16:42 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EEC19EAAF
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 00:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4826730439EE
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 23:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56393806A5;
	Wed, 25 Feb 2026 23:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjKY/BRq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CEC3803FA
	for <linux-pm@vger.kernel.org>; Wed, 25 Feb 2026 23:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772061390; cv=none; b=o9HMFrHwc2Na1o583+OrxvvpoqP5rHR1zJK1hogQBTvdlRXRkk7oea0m/vvT+bJalt92bH9/RQtjaHtG7yRlzzWMppMLiLSe4i0hrWc+d8dk1KyGPBRB0daRoEwaALBc6SguTGfIjN/wvb5Ne4e06/O3cnPXc9cNkCp1d54WETo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772061390; c=relaxed/simple;
	bh=GXWK2Cqsl0nXDAX2tyRJWxUWQuzf7tLTZNIdOQhV7Kw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lyovJdR6Wf+Hj8EpOmmPhRDdgQp5bl44mbGzisZFCn1K7gplFew56kvGCi/5qBl4yMp7hRT9LEW1x3Gh0fwR/iHfqvkM909Qb87LJ8/3wIe47TIRTfoqMG8Rn26TZ6oV/3nOy6GHzDcIm4LPmHjHE1cWDHMA4kKiMa7vAwM+fIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KjKY/BRq; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-67934c83063so152006eaf.0
        for <linux-pm@vger.kernel.org>; Wed, 25 Feb 2026 15:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772061388; x=1772666188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ge0Z3Jh9aquHYy39xgGryoVJABVK8UNOJhhBcGQ7T+0=;
        b=KjKY/BRqEFWCiJ00d6Q9ClhE2z6UmOb/rCaFbm8lumzBoU0ML6rDOeFvtCvknM/tVL
         kWKThyeQTrmUU1yVdR6a2LvGAC+WbCKwVCiZ8BNMRI5qkz+RaKeNCLb7dC+DGN4lcpt7
         2L0f1BDDRF7/AZVHRm4el1KvXUHkBZ9aQCXmalhLLoX41rpYOf1wRlXqCl69GNLBcoDV
         +BhomUfv9wULLS2p+8z6cmS+D5SvZkTZ6Ko8xckqcZK6HYERaKQq/gInKnQoQoscRqSI
         yjEeHoxs64SzCwXnYKPVq6bQM3agQmESCN+25eh2O1nP74aoTpAQDBR0g8Qa+TlEyXFK
         E2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772061388; x=1772666188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ge0Z3Jh9aquHYy39xgGryoVJABVK8UNOJhhBcGQ7T+0=;
        b=hTATUIJFm6r6r52gKaYHOqxbpUPa7O57q8412IzS3S/o5aVPJfqcctlZNZ7o2ta2dw
         movY4XUcs1Lx+ks9EIrOIQVDCxaYOVUwoMGLNim0n3mfWggDnQDbe5lIBovwas7+O23I
         F+KUW6zaZJAEK9yAf35pxAhSqW5mrO+EPJRO7ZpmMVzRIOj2PUrKEyJ9XY2CbI0RflvO
         PAOzez/y2eKTwF8jfyYPVTIVKnJVyi7kQMRtRZrVPUavoQILN342Uyut7lzQReMctjRD
         XYgUdleaUtJhyFERVEv8AgN+zVSY8kN9rh9afTQBNQurtbDTRNNZ/dD4SNfdbav8U+7O
         8u0g==
X-Gm-Message-State: AOJu0Yz3yUlUdNcnxn71WdiKl3dvPmFHMwO5WzTNxewDJBPc+rqWinba
	M7g1VybSV9466Cxd95MVCrF/NRyTNWn2SglqGkDggafe8o4A/vGKTjC8
X-Gm-Gg: ATEYQzy8Hh3pF0ASSuqX6LIJnr4rUbc5hGTnsXaCxrUmoItyOxHk70lxgbtF9nNPHBr
	eL8rJ5PYm8gRjWEcXk7OnBthOFkmftEHCnUGbluwajj+6EaL9g4V7BgCqFMdNrvJRAcIY8k3APb
	0OIYntmWC8op7NqMBIfw/8H87Nap9fRk8MGz9MgP9AvIdQ18NsxeIdqvtCSiKes0O94bqkL2Ct+
	r+FXNZ3g2lEKKttMyaHgf2FHqb90toaOmPTBpiubnOoLpYoc36QNXdK04xF0muqxKxDiIokmJ8L
	rVGB1GXkeSqCxvAqkHGK1lno51Ka9Plb/tlyY/SkJevdeFXecJ0AYDrgb+TchflFSmEMUjixl9K
	8vHhCxVoYs0i4DUHCRCxBxHdkjbCMLWO1nUnPN7fCrnSyzxA1m0E2AroZn7pS3noNqTVPF0uE/4
	JWNtb123kh/bYY5C/8s5SskHtuFc46amAS5lvp8JODR/jVxHQ5+1ZdAd3ozmOYtngcQAMz7v+hX
	jk=
X-Received: by 2002:a05:6820:4a8a:b0:662:f8a9:9f7 with SMTP id 006d021491bc7-679ef96ff50mr775690eaf.37.1772061388448;
        Wed, 25 Feb 2026 15:16:28 -0800 (PST)
Received: from localhost.localdomain (modemcable231.2-131-66.mc.videotron.ca. [66.131.2.231])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679f2db737bsm350788eaf.15.2026.02.25.15.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 15:16:28 -0800 (PST)
From: Serhii Pievniev <spevnev16@gmail.com>
To: lenb@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Serhii Pievniev <spevnev16@gmail.com>
Subject: [PATCH v2] tools/turbostat: fix microcode patch level reading for AMD/Hygon
Date: Wed, 25 Feb 2026 18:16:03 -0500
Message-ID: <20260225231603.33160-1-spevnev16@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260224023719.65165-1-spevnev16@gmail.com>
References: <20260224023719.65165-1-spevnev16@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43223-lists,linux-pm=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 71EEC19EAAF
X-Rspamd-Action: no action

turbostat always used the same logic to read the microcode patch level,
which is correct for Intel but not for AMD/Hygon.
While Intel stores the patch level in the upper 32 bits of MSR, AMD
stores it in the lower 32 bits, which causes turbostat to report the
microcode version as 0x0 on AMD/Hygon.

Fix by shifting right by 32 for non-AMD/Hygon, preserving the existing
behavior for Intel and unknown vendors.

Signed-off-by: Serhii Pievniev <spevnev16@gmail.com>
---
v1 -> v2: Changed to single MSR path with conditional shift

v1: https://lore.kernel.org/linux-pm/20260224023719.65165-1-spevnev16@gmail.com
---
 tools/power/x86/turbostat/turbostat.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 1a2671c2820..7545142b3a6 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -9122,10 +9122,13 @@ void process_cpuid()
 	cpuid_has_hv = ecx_flags & (1 << 31);
 
 	if (!no_msr) {
-		if (get_msr(sched_getcpu(), MSR_IA32_UCODE_REV, &ucode_patch))
+		if (get_msr(sched_getcpu(), MSR_IA32_UCODE_REV, &ucode_patch)) {
 			warnx("get_msr(UCODE)");
-		else
+		} else {
 			ucode_patch_valid = true;
+			if (!authentic_amd && !hygon_genuine)
+				ucode_patch >>= 32;
+		}
 	}
 
 	/*
@@ -9139,7 +9142,7 @@ void process_cpuid()
 	if (!quiet) {
 		fprintf(outf, "CPUID(1): family:model:stepping 0x%x:%x:%x (%d:%d:%d)", family, model, stepping, family, model, stepping);
 		if (ucode_patch_valid)
-			fprintf(outf, " microcode 0x%x", (unsigned int)((ucode_patch >> 32) & 0xFFFFFFFF));
+			fprintf(outf, " microcode 0x%x", (unsigned int)ucode_patch);
 		fputc('\n', outf);
 
 		fprintf(outf, "CPUID(0x80000000): max_extended_levels: 0x%x\n", max_extended_level);
-- 
2.53.0


