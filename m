Return-Path: <linux-pm+bounces-17377-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 406D99C4E50
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 06:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC8501F25690
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 05:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E019A209F59;
	Tue, 12 Nov 2024 05:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEIbpSoY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572DC17333A;
	Tue, 12 Nov 2024 05:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731389854; cv=none; b=eek/O2dt81P9f/38Er19btDRltI4Rba5kqqIej5fYopunT/89cUqCSxR2hvoH4V78VZ0pkJedULRuLuWeH4vbBbH4ahAxFcFJZFvaEE2P1Rt4zVEFnP/XHx18/l4aH1S3EHi0CcrBLdhnV4/UPFBYjEOVj33pWl92XAU1853KbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731389854; c=relaxed/simple;
	bh=ysM6JFLp6aMpvJFUum99tSB8lJ7jeaOVFgHxE2jX/QU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O0AFaj4n8K202oPyWaTouxaTQ6P1saXsupL0F3aH2TlP+OnkM07aRZUo0hwHjegYg9Tjboa73YRwZ3MjtSndFL57hRXpm5D0FFuVF5pbCtZ+gJRKEYJXXtcBFsOwVNzhdOYluSSc8Oypw+2dHaYslbFabxNb2luwicH53rfGOdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UEIbpSoY; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6ea07d119b7so41694987b3.0;
        Mon, 11 Nov 2024 21:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731389852; x=1731994652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x9+yYob8QqpR929dgX2vkQRsU1UK4Vypk1h9CkIzhzk=;
        b=UEIbpSoYlKnJX9/MEC/s544rBdwnAMp84ENFwQB5aSLfKUA86ZObJiIzwGR54lavEo
         qoQ26dLlfztzo+CTgjxJt0oziGHNpPLJpyQBuwrUBme1gzRQxizvi9QBuMk7Qo961gXY
         +0mHwHIVKkn00/el4+Asf9DeZvMYkiG49iI743qnDtMqktCCJgVOa1rq3CNqbi2vlEdu
         ICWSjtM5KZxsTEKPQ56txzvJLttcqbTgAohDSRpTQ+fIs8rvU+mBnbEUL6WuG8SWGDTa
         Buikl0G/14c/uMiystJtVBfot0uPZcrZ1tsrLiWXd++hiDunB7ZpXb10/+QTRkcbL0wy
         sFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731389852; x=1731994652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x9+yYob8QqpR929dgX2vkQRsU1UK4Vypk1h9CkIzhzk=;
        b=oyUztK8E5UU49ju3yDPdAzJlH66Ah++MljwtqBcpw0wRngorH6nMMx24O4wmwFtAI2
         Y1TTR5cavHHxF5obVF7QQzNnRuakA2AJKwdrUJwZ4fq+kdfvXMlbF3D9Rsn3x7IyFgT0
         6PP+9ZMYR2kNoMG5r2HP7l4CIBsA+iGT7Kk6iS6ymovW3yai8SKt8qkBdcOcuOxye8pR
         lMsrCOnNmgLxozJYhhbrL+jH3+7DuG/ajRjIOverheK068QrN4Qw7qUOahhW33SFPos8
         ovdqUToH5FvdRFMPtADkn7P9SFfBpRUc1enzlK+fZRK7bbZhEA+Bb211BZbxejzJ14Cp
         8v2A==
X-Forwarded-Encrypted: i=1; AJvYcCUKC7M72r87sMp1h/lzkhrCd7D5pdEeFuQf3F8nmkmDYCluGIDpnv9vhjUQcRPomyDCtVSeky/o@vger.kernel.org, AJvYcCWplSrzOD+bArHYVnz7z9q7x8TkTmF0o8dJKjzxQg60RoBzdOS8QQR47fKVLw49rPfDLBMN0Lnz1Nh6yf0=@vger.kernel.org, AJvYcCXE/ajLqyeA51OkpZMgZmSEr9tzbAny9/dcKr7+jM11PTo5FbG2C6w4oAKKKpVtl7ns+geBdBnkD9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlFIcokIyfTRDuwCG8FzzJ1paxu5mm75BQBfV9MnR5f8zRYTDN
	U01IuHahrkZbuC0zzE2QPR9GPY7g8xoNXXmfljFwoocZYWfb2kP1jgD0BQ==
X-Google-Smtp-Source: AGHT+IFLEOjAvCtW17xbP1211witMMxzUtg/hnRRA6ebo2VqbzVaJc3+0z043qXyndCZ+lDVUetY6w==
X-Received: by 2002:a05:690c:6890:b0:6db:de99:28ae with SMTP id 00721157ae682-6eca466791fmr14989897b3.17.1731389852227;
        Mon, 11 Nov 2024 21:37:32 -0800 (PST)
Received: from lenb-Thinkpad-T16-Gen-3.mynetworksettings.com ([2600:1006:a022:33ba:a725:c031:83c7:29cf])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eaceb7b3d5sm23846457b3.119.2024.11.11.21.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 21:37:31 -0800 (PST)
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
Subject: [PATCH 1/1] x86/cpu: Add INTEL_LUNARLAKE_M to X86_BUG_MONITOR
Date: Tue, 12 Nov 2024 00:28:26 -0500
Message-ID: <351549432f8d766842dec74ccab443077ea0af91.1731389117.git.len.brown@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241112053722.356303-1-lenb@kernel.org>
References: <20241111162316.GH22801@noisy.programming.kicks-ass.net>
 <20241112053722.356303-1-lenb@kernel.org>
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
 arch/x86/kernel/cpu/intel.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index e7656cbef68d..284cd561499c 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -586,7 +586,9 @@ static void init_intel(struct cpuinfo_x86 *c)
 	     c->x86_vfm == INTEL_WESTMERE_EX))
 		set_cpu_bug(c, X86_BUG_CLFLUSH_MONITOR);
 
-	if (boot_cpu_has(X86_FEATURE_MWAIT) && c->x86_vfm == INTEL_ATOM_GOLDMONT)
+	if (boot_cpu_has(X86_FEATURE_MWAIT) &&
+	    (c->x86_vfm == INTEL_ATOM_GOLDMONT
+	     || c->x86_vfm == INTEL_LUNARLAKE_M))
 		set_cpu_bug(c, X86_BUG_MONITOR);
 
 #ifdef CONFIG_X86_64
-- 
2.43.0


