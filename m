Return-Path: <linux-pm+bounces-17208-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D1A9C1E95
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 14:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0FC2B2488D
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 13:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F3E1F4282;
	Fri,  8 Nov 2024 13:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjentqQN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABA21EF952;
	Fri,  8 Nov 2024 13:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731073957; cv=none; b=X4lylD9u2uoVv6N2842PIXTidUTCblfQevqbElGAyb4uKu0wHieDYEVGmdtAxIxbjF+cAIpWu67Z+r3NJXZ9C+/yCf3XxyT69bpnlApjGMFm9tGEGE5eyAVy3qX2iCwJC21TQ4FoJnaQGyi5euI9zAjqTRtP5u8C/gyyag9Gs9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731073957; c=relaxed/simple;
	bh=F5sBafYUYNn3NtevJ+VyTJBgbeWs+WIzNQF4WQ3wtBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AZ+eQN0GS2IT1tJoqtzYpKUTkrboeIq5cVm1xt7rj9fieeAoMdSBNOIWmFXyy6JHL8oGPY6sqK/Jj/ui1q0SLgflQG1vkyr8Sh/us3oUUW1a9/hdAbNQTs25zE9AjB9b0o03Yz17Mik6Q64E2n4UcyjhMKrACNDg5UUfU5wemPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjentqQN; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b18da94ba9so201779585a.0;
        Fri, 08 Nov 2024 05:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731073954; x=1731678754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8CzBburVbe0OCsxdL8gSb7GlYLLvvmm0SEGWBmYsoo=;
        b=CjentqQNlMWfeQ7y+iada7XOBDqom/Witc5ud2D9gkOHS9hshUaF5ekvTtGXQHAi80
         Awoo+gX7NmANsR5MVNfxa1OS836o5hbmrvMnVFh80XFispcJHnVpDW3ucqnnikwKzZiM
         kSRT0tzczdOmZ/FLxXSwLE6vbucSaCez+fkxEjOi58oR9A5ulTg2GbvreyGFKUbyvcMY
         fDldE8vxQgw26vqUB9hjMu0tZxjMtn5FFZjuGsbcyxpl65cSQhkFlLArhEzsvRKZCmez
         /svX+LkKbc6W0iHu4gklQsYjPDlgxRHYyaNOaBDK0c2TjjzfmoFvBUXPWyEkdW8U/Be6
         /y/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731073954; x=1731678754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F8CzBburVbe0OCsxdL8gSb7GlYLLvvmm0SEGWBmYsoo=;
        b=oamJZ+6HB2H5+WSYb41+UucbsIUI8xkNEEbjTtUyPjfFAq1CG5NfPozZ21hDwkd8Uu
         rC+45sfOzAoN6ZMfLAzfPHFfbBsfoyVbbnrUPLE4vVI+IwS4jDdoWmFrKaU2+TVvSjdc
         yaByL5lNglA/IkIN/uZFC5UEFAu2u5Hd0TX2XhybPyNujjXVTESJ1ZYuBJ5INzrAzYWE
         fU4WOy8h5+q9+axrzuDeHWS/TD7ojNbD/Hg9TrLo6gzSPM75CkAvr6OOcWEMOxI0aYZP
         IVsOtH5IO+/kNQF82SYll59F5iMvuyQUIxEtmuz9BJCENabcWSz4rsboLbVzbMkKrtQR
         4Law==
X-Forwarded-Encrypted: i=1; AJvYcCUop2mUvUyGj0MdgHQn2VEJ8PdpdDwO9cqp7jKWPzojafIsC8hy7gexpDUrMrRqqzMM7Xd929Wc@vger.kernel.org, AJvYcCWmmH06Hwe8WNrv4hSw1fdVNxij3n0/NYKgqRsFYcPTu5oug2MNNLp8gppfJkuEv4Q726WumGJdmbE=@vger.kernel.org, AJvYcCXRF/R4LrUGFlyuv6y4QClvg+7+o/PnjXJLsh4ZvooR+U28jC1Z/rGGj8L7UG3w4dD6Qvhz+HVgGBoT7yc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzaw7tJEGEUil8pmi9h77zq9duNaViIngjyfjHrwwSVmMLnA+Wn
	j5cs7ZPUaibO5ZtsES/gCAMvVIrIJc80xWNvABdsU5ZnGZfeHVIVC0rG0g==
X-Google-Smtp-Source: AGHT+IGFRepV9dnHZyVJJc0NGxL+SgPQIFB5GQIV5Qv7NdIPIWxWizmdVDopm+X9ehihIMmF8OG3UA==
X-Received: by 2002:a05:620a:19a4:b0:7b1:44ee:644d with SMTP id af79cd13be357-7b3318d0181mr506038485a.10.1731073954469;
        Fri, 08 Nov 2024 05:52:34 -0800 (PST)
Received: from lenb-Thinkpad-T16-Gen-3.mynetworksettings.com ([2600:1006:a022:33ba:65ef:6111:c43:42a7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32ac54e5fsm160431285a.49.2024.11.08.05.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 05:52:34 -0800 (PST)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: peterz@infradead.org,
	x86@kernel.org
Cc: rafael@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Len Brown <len.brown@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] x86/cpu: Add INTEL_LUNARLAKE_M to X86_BUG_MONITOR
Date: Fri,  8 Nov 2024 08:49:31 -0500
Message-ID: <20241108135206.435793-3-lenb@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241108135206.435793-1-lenb@kernel.org>
References: <20241108135206.435793-1-lenb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Len Brown <len.brown@intel.com>

Under some conditions, MONITOR wakeups on Lunar Lake processors
can be lost, resulting in significant user-visible delays.

Add LunarLake to X86_BUG_MONITOR so that wake_up_idle_cpu()
always sends an IPI, avoiding this potential delay.

Also update the X86_BUG_MONITOR workaround to handle
the new smp_kick_mwait_play_dead() path.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219364

Cc: stable@vger.kernel.org # 6.11
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/kernel/cpu/intel.c | 3 ++-
 arch/x86/kernel/smpboot.c   | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index e7656cbef68d..aa63f5f780a0 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -586,7 +586,8 @@ static void init_intel(struct cpuinfo_x86 *c)
 	     c->x86_vfm == INTEL_WESTMERE_EX))
 		set_cpu_bug(c, X86_BUG_CLFLUSH_MONITOR);
 
-	if (boot_cpu_has(X86_FEATURE_MWAIT) && c->x86_vfm == INTEL_ATOM_GOLDMONT)
+	if (boot_cpu_has(X86_FEATURE_MWAIT) &&
+			(c->x86_vfm == INTEL_ATOM_GOLDMONT || c->x86_vfm == INTEL_LUNARLAKE_M))
 		set_cpu_bug(c, X86_BUG_MONITOR);
 
 #ifdef CONFIG_X86_64
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 766f092dab80..910cb2d72c13 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1377,6 +1377,9 @@ void smp_kick_mwait_play_dead(void)
 		for (i = 0; READ_ONCE(md->status) != newstate && i < 1000; i++) {
 			/* Bring it out of mwait */
 			WRITE_ONCE(md->control, newstate);
+			/* If MONITOR unreliable, send IPI */
+			if (boot_cpu_has_bug(X86_BUG_MONITOR))
+				__apic_send_IPI(cpu, RESCHEDULE_VECTOR);
 			udelay(5);
 		}
 
-- 
2.43.0


