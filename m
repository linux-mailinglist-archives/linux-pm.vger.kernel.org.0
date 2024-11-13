Return-Path: <linux-pm+bounces-17466-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 568919C6713
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 03:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DF6B281FAF
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 02:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA7F70812;
	Wed, 13 Nov 2024 02:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHS637jb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2641C2FB;
	Wed, 13 Nov 2024 02:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731463654; cv=none; b=Nj0ABbiAaKt7/gBVCZJVdQT/BAZ077lLAHEsmwWozDZXzgg7CkvHVDBTJFFsOBGs0+FvD0bGDwHeUKELzJWGwHX8/+swuTzzNsz3ZF1s5/t3NzxobRORf+sliV+di7r6MNmfogJ57S4SNcmZa9nbzSS+LY1JRLz3yIdPRcwJm/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731463654; c=relaxed/simple;
	bh=fBIDU+D9Nxyj4+oC2LH8Lvc0U3Wc+c5p99wk9ExNJ7E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a4EN0y4bdMr7vV6Qf9MxJTA0mtRKNZs3VeqoRyL2TG3M04gI3UxJTa/8OXbysc9s54ST3UASH7UhparmSrRzTj+KrDTvOc1/GaGV9tw65uc0nHoAABlO/bLbHhoB0ZfAD3g+Ta283V5SJ8dpQ7ChkckqaNh2yzr2TThoU+nH6MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DHS637jb; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6cbe68f787dso41181946d6.2;
        Tue, 12 Nov 2024 18:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731463652; x=1732068452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=WYP6Z7D+0l/1IgcWk70OwbLKb3OwbsoyZjfuToeA0wI=;
        b=DHS637jb9mkFEpImsh3JDuRTnmgcsSA/Ks30CAXXz8TUKVuaLuSxkYK/z8BncT+nkX
         rm/LLHP1QoMY8yLgasq6DOmxZOC9UBWlWOeUttK+OrpVJTH3jE5e/+yd/YbZo4BZcdfH
         jEUhMZyqB9LEyGZh/dhQ8QhUScpj97inOVOjDZEsGrp5/2mpZeeoRfJuOZnR0ziDMUsO
         tHOlK07zmpWVOaVnWwlQp3UkhK0pn8P2y1wpzqap1asyQSWt37P8+kJqKdo3KIIyCGyA
         Zn0Y/QcIcM1HIoItjJ15+jr1iqfQv/P96x7X46xvGy8akW3fVt/p8tsqOzxsGAKKAF2Y
         LYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731463652; x=1732068452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYP6Z7D+0l/1IgcWk70OwbLKb3OwbsoyZjfuToeA0wI=;
        b=n6vd0CbioTYelKKWOpTw9nYSDgyQffHxkSRk2DKS9FtVqfy2/vezJhYE+30EtrM6yS
         xi/AEBUooVWp6xsb8Psc2fjkYQtJ2NHf7gIVS3JDx94Ju4tnQRdd2xzJnBBJ3ouiKDAm
         cZl2TN7mreIkYxYTspKqr/g5P21ZthJUIcBR1i4cQ0NMkFX6zSQKsdjHL6MsigNZMgVM
         h2eXPT7Ji/WVc641FjjDCdbxSI3nyvZen4oGWJSxdf4ULsQl1NHhlKQNPyDXKbAlDYLc
         SXNUMJ8tFaVu7Pvhp5wfJbCddVW/RhvJuAsVJ0sdmayNhHLF3bDWWHn8kfNo+rMbRUon
         Ujpg==
X-Forwarded-Encrypted: i=1; AJvYcCV2bFqqYaJh/VBaPd7IQhr4YkRmnlFcD8POKBqPqPqROEMw9wVuZrJYtfqsBBWfcOSz2c6zUfYBndVjxcs=@vger.kernel.org, AJvYcCVR1orHEMtigur0CN3Lv4OcePwDMiCuC7tg43WbB0vyj4we43CF2151QMzgIi4bYx6eRq6/NP3U@vger.kernel.org, AJvYcCWc/eoAOB3fc+zBZK4FKAurgVFDfh7IXU5rOM7uce2OY29xme5WkKNwsMRYoLAEULMIXEGViAEs9o4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMjZi05HXv4zNjUwqOLbbcNMNG8gaiLdcOTeet1M9wwMjVn8SQ
	F7N7azRk6Dql3yk4l/DM4jvdu6RkDh9+8T4Blx+Knm1p7LZ1kyxN
X-Google-Smtp-Source: AGHT+IEpA4+yIXpM0Wyn3hUH9jkbdaPc1sjc6OvA/euzql3H6Je2Ifa7mqh0EOe7fu+kXMtkUehaQw==
X-Received: by 2002:a05:6214:5706:b0:6ce:2357:8a2e with SMTP id 6a1803df08f44-6d3dd06beeamr19108226d6.37.1731463651904;
        Tue, 12 Nov 2024 18:07:31 -0800 (PST)
Received: from lenb-Thinkpad-T16-Gen-3.mynetworksettings.com ([2600:1006:a022:33ba:88a7:81d8:bd03:622c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3a6b3250bsm58594056d6.96.2024.11.12.18.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 18:07:31 -0800 (PST)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: peterz@infradead.org,
	tglx@linutronix.de,
	x86@kernel.org
Cc: rafael@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Len Brown <len.brown@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] x86/cpu: Add INTEL_LUNARLAKE_M to X86_BUG_MONITOR
Date: Tue, 12 Nov 2024 21:07:00 -0500
Message-ID: <a4aa8842a3c3bfdb7fe9807710eef159cbf0e705.1731463305.git.len.brown@intel.com>
X-Mailer: git-send-email 2.43.0
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

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219364

Cc: stable@vger.kernel.org # 6.11
Signed-off-by: Len Brown <len.brown@intel.com>
---
v3 syntax tweak
v2 leave smp_kick_mwait_play_dead() alone

 arch/x86/kernel/cpu/intel.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index e7656cbef68d..4b5f3d052151 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -586,7 +586,9 @@ static void init_intel(struct cpuinfo_x86 *c)
 	     c->x86_vfm == INTEL_WESTMERE_EX))
 		set_cpu_bug(c, X86_BUG_CLFLUSH_MONITOR);
 
-	if (boot_cpu_has(X86_FEATURE_MWAIT) && c->x86_vfm == INTEL_ATOM_GOLDMONT)
+	if (boot_cpu_has(X86_FEATURE_MWAIT) &&
+	    (c->x86_vfm == INTEL_ATOM_GOLDMONT ||
+	     c->x86_vfm == INTEL_LUNARLAKE_M))
 		set_cpu_bug(c, X86_BUG_MONITOR);
 
 #ifdef CONFIG_X86_64
-- 
2.43.0


