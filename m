Return-Path: <linux-pm+bounces-17207-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF709C1E91
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 14:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F5431F23303
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 13:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EAA1F12E8;
	Fri,  8 Nov 2024 13:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9li45IT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2301F5FA;
	Fri,  8 Nov 2024 13:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731073955; cv=none; b=hMX+vY/42BU0+ykVF7Fmz82S++kxX3yXMskkVmZPs5a7CCjUjUu181lRiEN4uMPnCPhj0xwN22cdjwQjI/kWGgI6XgaQLwHqNTJR+BkS16HdTJjcGtQmXLV5FsOMksQELqj6c+Jj+CqEbOQehTqEgwF2c0CeIZ26RjwIC6NiJgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731073955; c=relaxed/simple;
	bh=xJ8I+JIxbh+5VlOOd/NToL3hdqC9hxpCPEPSeiLe5BM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KPtdSVysQ+Vf5mmSdYiwauvIKyHT0tlD9EGC253hg/rGwJvZkspJNLDsHF+WineMt+B8Ng4LLf+Ky/5e5W2Sfhsf+WIS/omduPgiqf8+uvQMhtj2oqHbIhzbqP6YDirlU/DkF2q1TzN+ljXuQLPMQ93V87svlE20E2E3uqVXMDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9li45IT; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7b14554468fso128312285a.1;
        Fri, 08 Nov 2024 05:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731073953; x=1731678753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X6hA/sEvIdJtDmv5th9L5y/Cue9Nm5ViWOOgqRkDOM0=;
        b=b9li45IT1M4mJG9Yqv7QSa2sPyyBq8MmmfLwcjFmsfMerI6Fe//BIhXQOLQ0XKeSVo
         Z+ahW7S7xy38wC8096nddopBIS7fqU5tCY5e0nqigw0Nz77a+Wb4HiBbhgVG95BXGqjs
         rCW+sOoA9w4YyT388IZxT2QNlY0IZAhzBEF90lceGu0zb420QxQAiuPOIT9enoIWcUQa
         0bmuUiFru5mi0eALZdb7ViB4qmSUCQqpWMl/zrn52FJKC/o9dWLpOxqFtIC6LHd+xpRz
         3UMyGl2TlzasQqbAB8g593ZjCa99/zDSaC8s4uVkNWpHONRUjHCwHk9CuXDgLurPLsxM
         Ng/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731073953; x=1731678753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X6hA/sEvIdJtDmv5th9L5y/Cue9Nm5ViWOOgqRkDOM0=;
        b=UFj1iDcQQIxCfYyPAbslPevLVCj/6nelLri9ebeqp7F/ZTFuMQPXtw8wi0V9G3mrTF
         E9KPAfn6mNpFkgvIhl6JUebU8U3vD3ZziWqGo2CuAc07TuspyhZRyqds6fGfb9esCZBe
         7Bxew5i5C0Vutn151ZovXvkE+VXaW+rkfRDFFZvUFzTk1FaCZcv9j3O6xLKEUJO5AMrV
         3WdL4j/GIS8DEbF7hjHDjCYQ1CdkwLB4iVYlPH81+aFr/6FwAOdq6YjZSCEXKpD8diAJ
         kKCjzV9TWJl1hfHP9qGqgesl2EteFNRyw95b3j2lkDQicNhlLQNcHI7hDRLAHrJbnJ2w
         pFqw==
X-Forwarded-Encrypted: i=1; AJvYcCUAQgXJ0faIDUd7SaX8isoWBt6YXqUUKtudbBDh3xnFaYhyDDvbwnbDlgxIMuHUWpokDm+1rwdAZlU=@vger.kernel.org, AJvYcCUvkPpObR5pSnc5o5BPpP1JRpQbqDe3YQJLH/607JBz+q4Az6/yl/wE29Ixmdws6Nfz3Ij0I551@vger.kernel.org, AJvYcCW71wlmXBKc0USPrDWudvJicLHseOaJmEGQRC2yQ6HR8DY2yM6EC1uu7JErYSN5hzN83ijNkqZ1BsPu81g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Tt4ZYCtbt6kM7sADzKGAUb9J/wrbYqXTAl5WJrYhzy6NiEY4
	WIYTPyDOFx/yLOyhBepr8EHWKQZmPYdCf9S0x8w8eh0fqL/KUYOq
X-Google-Smtp-Source: AGHT+IGplhmHakc2nOBAGsmUIiRduEp949/Rq00UioCzSO4JtufZzsNtZ0qNUfv1AmCb3fEycLjY3Q==
X-Received: by 2002:a05:620a:2688:b0:7b1:8cda:6f4c with SMTP id af79cd13be357-7b331e95ac7mr336935785a.3.1731073953095;
        Fri, 08 Nov 2024 05:52:33 -0800 (PST)
Received: from lenb-Thinkpad-T16-Gen-3.mynetworksettings.com ([2600:1006:a022:33ba:65ef:6111:c43:42a7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32ac54e5fsm160431285a.49.2024.11.08.05.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 05:52:32 -0800 (PST)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: peterz@infradead.org,
	x86@kernel.org
Cc: rafael@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Len Brown <len.brown@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH backport to 6.10] x86/cpu: Add INTEL_FAM6_LUNARLAKE_M to X86_BUG_MONITOR
Date: Fri,  8 Nov 2024 08:49:30 -0500
Message-ID: <20241108135206.435793-2-lenb@kernel.org>
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
Update the X86_BUG_MONITOR workaround to handle
the new smp_kick_mwait_play_dead() path.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219364

Cc: stable@vger.kernel.org # 6.10
Signed-off-by: Len Brown <len.brown@intel.com>
---
This is a backport of the upstream patch to Linux-6.10 and earlier
---
 arch/x86/kernel/cpu/intel.c | 3 ++-
 arch/x86/kernel/smpboot.c   | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 3ef4e0137d21..e6f4c16c0267 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -583,7 +583,8 @@ static void init_intel(struct cpuinfo_x86 *c)
 		set_cpu_bug(c, X86_BUG_CLFLUSH_MONITOR);
 
 	if (c->x86 == 6 && boot_cpu_has(X86_FEATURE_MWAIT) &&
-		((c->x86_model == INTEL_FAM6_ATOM_GOLDMONT)))
+		((c->x86_model == INTEL_FAM6_ATOM_GOLDMONT) ||
+		(c->x86_model == INTEL_FAM6_LUNARLAKE_M)))
 		set_cpu_bug(c, X86_BUG_MONITOR);
 
 #ifdef CONFIG_X86_64
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 0c35207320cb..ca9358acc626 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1376,6 +1376,9 @@ void smp_kick_mwait_play_dead(void)
 		for (i = 0; READ_ONCE(md->status) != newstate && i < 1000; i++) {
 			/* Bring it out of mwait */
 			WRITE_ONCE(md->control, newstate);
+			/* If MWAIT unreliable, send IPI */
+			if (boot_cpu_has_bug(X86_BUG_MONITOR))
+				__apic_send_IPI(cpu, RESCHEDULE_VECTOR);
 			udelay(5);
 		}
 
-- 
2.43.0


