Return-Path: <linux-pm+bounces-35233-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A982FB96990
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 17:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D01A3209FF
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 15:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62252263C91;
	Tue, 23 Sep 2025 15:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="DC6/kH63"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BE12652B2
	for <linux-pm@vger.kernel.org>; Tue, 23 Sep 2025 15:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758641517; cv=none; b=RtR+GjtfWXOw0X4QNdcF21/lGqOEysr+R8Wz/qmhk9IugyiyLGN3k+gEhcBP2uKnj8GhGfwTUSKVNkP9A2lp8OujsYoEc1TqNQPQrQevT+ESJJMqr4NJXsT0zgaFy+P3GngsNuSqWNO5ynOiLkTRlBci1/Qq5Uj1TEf7obh7JF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758641517; c=relaxed/simple;
	bh=6htOvfZjI2OMhlgVSh0J2CmuVWGKZAFM9288jbISAEY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PF7Zvc9oohXccIU7u6mJkk8cOwjB0cAW/OAWMOnSFCuV1MUZ0AgjaSRXuOPiIJ1wQR6/cNLKHfb5FWpKmtx10rlthRYbSxHhhhZdFJLbBau0DBVfCKKb+e9lfsLQ0gmyM/IvIEPvvjqTMvkjG/q1GJFwlSoeY3tStBB/V1LYOFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=DC6/kH63; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b38d4de6d9so35895371cf.1
        for <linux-pm@vger.kernel.org>; Tue, 23 Sep 2025 08:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758641512; x=1759246312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hcJ2gCgUm1v6G7+he7UDrBEl/Rd/VnVpfcNtogjhvQc=;
        b=DC6/kH63SPhSNJ6jw3pHQ01uVDe5Az9QT8tluZHwVP9ct/s+8XQeIP/PMsptN5U88O
         tc6aI4X0d1+4q0dB/piWz2wwEH/Am6A29EHaWa1ZplS8tsvPspLqz9f9Arlo12VgiGCu
         l+0PIJZo1By+bldQGAYCsJkBd20fzxARDYz2YtqMTfHF6AnBdXK29PyXb6XkfBBq0j5W
         WtUPxOFvC8RmtGn6GUrPumuPlU/ayAXwfCYvyBqAQX0L3e6TNR72iIMf0VEkS7LO/r/c
         W745wkdH+WY+Rh+m+Y+cA8PWDbL1bEohybo8iqKd+My4qIQMAHVwnHHQBCuf8eXP9oaa
         Va0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758641512; x=1759246312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hcJ2gCgUm1v6G7+he7UDrBEl/Rd/VnVpfcNtogjhvQc=;
        b=kq//64FciHMLkxk5roKBkmwyVPk2AWdY94rX6E/jfc6PCXTgF+Y4IBfcOH6uzh901w
         UTqADJ8++IiZfjBowaHhUse/1PAfDsRs36FGk1CrSLYg+X+XZYgMouRYvJBXaIozZ4gb
         cpF6gEpklr0hVDK0DfFTy+QgehteZSR8ITgI9yPaYDlYp8jEGKMWm0MgEY8BKdNP0u6t
         USifuICfJlSZ9hsCOt++g4Zws4cxxMfUXhyks4ePZuCd0aBOvlwAZ1IkSZJD4yH+g0bf
         FipacShIyOV+/37mLCi5VfEKi/Tuw9wlqQP+ffgqMfDiWy9dr7tRC1+c38gl1882qF7Z
         h8yA==
X-Forwarded-Encrypted: i=1; AJvYcCUguUN71Pd5bQkJIJbBJj1SX/v3tyroSz1UPqJNkeceMfvxT7iBEXRw4H3pTxwPbg7BR9cPUAoqBA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxgPBGofGN6whXX99TgR0N0B5CLQtUfo5Zgiw58s9pGq/Pbt27k
	gD46WcewRTe7CPCFsZbGmEGHGC0ue0c6oqH0HZnczkPuLzpuhEVN8leetZSk74X+/Cs=
X-Gm-Gg: ASbGnctEMjRJLhNP1qwuJGF2pzWA5evSDpH6DxEulwXo4L2qk/TcCmGRrU7A+qLQhYD
	aM1/W2jLr6o0AGL2HTZDNH6CZXZ4yb26qsDcuAbMsC4KpcAOuUOmxGkIqnwDPxvO87eiIzS/F0m
	kDg6beCM8fdxEF6P59zdzl5MBmqjanRCM4ftxDaG/3vppAwcoRcpl3pTwTMv7a3xkVoJUmk2uLR
	I3T68b+0UUukFlUBMSDJMGUwgoZ4kxP8JqmCY0W/yXV3yyqhaANvde6XMxbptySrO8VFpUFQuHw
	QPOeNUT9A/lp6N9h0uXIgIRT9Yao+Ss7cz2WfSMXbDB0bgOq9E7mkMc6pv4DuzERxsm19O1mEUv
	XJLFqEq0NThY5WyRNn7FGTI2JrO5WIJxkQpCO9CUe
X-Google-Smtp-Source: AGHT+IFpL6H1dB2FZrnf40AeXbyhYSYaqzdlpFnn0TiqkPSYKZV0L9ra8zT/5TF6hcSjR6U0Mc1XQg==
X-Received: by 2002:ad4:4eea:0:b0:780:4845:f347 with SMTP id 6a1803df08f44-7e70df9acc3mr37328886d6.44.1758641512131;
        Tue, 23 Sep 2025 08:31:52 -0700 (PDT)
Received: from localhost ([79.173.157.19])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7b0eb62c2cesm52459436d6.54.2025.09.23.08.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 08:31:51 -0700 (PDT)
From: Fam Zheng <fam.zheng@bytedance.com>
To: linux-kernel@vger.kernel.org
Cc: Lukasz Luba <lukasz.luba@arm.com>,
	linyongting@bytedance.com,
	songmuchun@bytedance.com,
	satish.kumar@bytedance.com,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	yuanzhu@bytedance.com,
	Ingo Molnar <mingo@redhat.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	fam.zheng@bytedance.com,
	Zhang Rui <rui.zhang@intel.com>,
	fam@euphon.net,
	"H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	liangma@bytedance.com,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	guojinhui.liam@bytedance.com,
	linux-pm@vger.kernel.org,
	Thom Hughes <thom.hughes@bytedance.com>
Subject: [RFC 2/5] x86/smpboot: Export wakeup_secondary_cpu_via_init
Date: Tue, 23 Sep 2025 15:31:43 +0000
Message-Id: <20250923153146.365015-3-fam.zheng@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250923153146.365015-1-fam.zheng@bytedance.com>
References: <20250923153146.365015-1-fam.zheng@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thom Hughes <thom.hughes@bytedance.com>

Will be used by parker setup code.

Signed-off-by: Thom Hughes <thom.hughes@bytedance.com>
Signed-off-by: Fam Zheng <fam.zheng@bytedance.com>
---
 arch/x86/include/asm/smp.h | 1 +
 arch/x86/kernel/smpboot.c  | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index ca073f40698f..cfc212bbb4a6 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -104,6 +104,7 @@ void native_smp_prepare_boot_cpu(void);
 void smp_prepare_cpus_common(void);
 void native_smp_prepare_cpus(unsigned int max_cpus);
 void native_smp_cpus_done(unsigned int max_cpus);
+int wakeup_secondary_cpu_via_init(u32 phys_apicid, unsigned long start_eip);
 int common_cpu_up(unsigned int cpunum, struct task_struct *tidle);
 int native_kick_ap(unsigned int cpu, struct task_struct *tidle);
 int native_cpu_disable(void);
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index c10850ae6f09..c9a941178488 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -715,7 +715,7 @@ static void send_init_sequence(u32 phys_apicid)
 /*
  * Wake up AP by INIT, INIT, STARTUP sequence.
  */
-static int wakeup_secondary_cpu_via_init(u32 phys_apicid, unsigned long start_eip)
+int wakeup_secondary_cpu_via_init(u32 phys_apicid, unsigned long start_eip)
 {
 	unsigned long send_status = 0, accept_status = 0;
 	int num_starts, j, maxlvt;
-- 
2.39.5


