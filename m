Return-Path: <linux-pm+bounces-11476-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1A993E082
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jul 2024 20:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFB0B1C20DE4
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jul 2024 18:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958A1187345;
	Sat, 27 Jul 2024 18:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gIuQmeDl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC3E186E42
	for <linux-pm@vger.kernel.org>; Sat, 27 Jul 2024 18:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722104815; cv=none; b=g0OItK/OiejT8pXBXK3L1yd2xwlOGuY5RDAFW+7oY56KYZChBg8174/JxE22uhGYmqjJ3TX36TLVwoL+pPMS+MT729wfgsGQ7B+nCKnbnfzty5FkGruIaX+pGRGc5l4oRVsiIHbt2EGv9Gxgl1/spRP8gAWJdGBCqO813czY7og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722104815; c=relaxed/simple;
	bh=Jmnuyb8a7n6X0TC099tzUsqKBSwZOouV0YZlx60tQ7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cn+EAAOgqUF2CLthN4VwwYz5ktjV+TJKePqrTW8V8A63h6krm2PqQSs4mXXurq5tzrnSegNoGOhGM7Kt5c5g9xwyR/w6COAzw+2GcFFF7xLW5OwblGJ5Wby07MeZb5q/ooirvrxpr5CYilSU09k944dbQ0n7XIw30S/Vzc5NCTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gIuQmeDl; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5d5846f7970so1250226eaf.3
        for <linux-pm@vger.kernel.org>; Sat, 27 Jul 2024 11:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722104813; x=1722709613; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IbbYLSP5TTmHd93HhkWi6UEM6QTZ2jRlhO80ewY2bOw=;
        b=gIuQmeDlGV9g9fuYjzDL2f03YRQZML1Ro9iN9vvwcBUQGbjTbvjm+DjQisVON3WkVP
         njeKP//lXC794GTJZsxPd9pLOATcnmCfD8N5peon1ljBg7CcLy7w6W4BaFBMEnRhq7oT
         uteSLeCuSUR8s/XUDHa7IDSQN/pAVspdlk7kldgNzHatHVeJ1RVWi/dRMm2rm6jfuLCG
         vgccvxmpWqlyW+Ygo9Bv5smQQ37hP+CnqYXv3EOdF3kgS4cypxMorSpUQHfA1WS12BMK
         tv30dxFZzxfbhosdTqBM1jRch5O9BTsNDh6fuo9QSdhVH7pmJRxKXH2xxMgV1NAkzRF6
         4Nxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722104813; x=1722709613;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IbbYLSP5TTmHd93HhkWi6UEM6QTZ2jRlhO80ewY2bOw=;
        b=wEDIc2Sk3MKW9nd45ibWDoL2kc/K+lfmtHPEsAzCFMVLVRuVaI3BUQf9imltf1i14O
         82jvrcdJiM3v4QfUtBDaYNinX96C8xHvBFJr1LKagD3IyXYLFOgvyxdQBuiR3w42ZtNp
         bPDMZlnaOrmImC3xz8lzZUvLz+H+p71ont4XX5nrSfssaCaS/G77kJIjqdWPr1pleQCy
         lETfXGoexUhNCByYHvO7+5uTbvphE0lCo6nFDS/mDwu7RyF2YRsLjiaxFcJFXEg1o33P
         mFgSrCtu0UtZurxR8DZ+7BufSGSKrSL32gzBI7Ao+Rk9oevDg9sPu/HrUKEpenPGkf4V
         Kcbg==
X-Gm-Message-State: AOJu0Yy7NTytOLnjyusrlS2Kcrru2nTL7ezHbymuiAxqzf/fJiVu0nF0
	cgb87l3O1NXmcMvl0hi/Xs12/mDFVtCCYKDBwYP7bW1qS1+NOaxb3DlIJw==
X-Google-Smtp-Source: AGHT+IEgRjKhKXClhRE1pEjIzjR2ZfdDJCKVonrlXOnQ+xSRl3n/mqGbcW7s1suFxE3uRZkv26MVvg==
X-Received: by 2002:a05:6820:1c89:b0:5d5:ddd4:59d with SMTP id 006d021491bc7-5d5ddd40fd2mr1038485eaf.2.1722104812774;
        Sat, 27 Jul 2024 11:26:52 -0700 (PDT)
Received: from lenb-intel-nuc8i7hvkva.. (h75-100-80-185.cntcnh.broadband.dynamic.tds.net. [75.100.80.185])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7093050a35fsm1314136a34.6.2024.07.27.11.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 11:26:52 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 07/18] tools/power turbostat: Fix formatting in turbostat.8
Date: Sat, 27 Jul 2024 14:23:33 -0400
Message-ID: <25826c20da55a114c2cba8c4f237dfe7a7b4f8f6.1722019621.git.len.brown@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <1b3bf0747d4f1a963e59c26e602868bdce195318.1722019621.git.len.brown@intel.com>
References: <1b3bf0747d4f1a963e59c26e602868bdce195318.1722019621.git.len.brown@intel.com>
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

We had an extra "+" at the beginning of some lines that look like a
poorly formated patch.

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.8 | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turbostat/turbostat.8
index 5537fc6b5bc3..8a21e9b56071 100644
--- a/tools/power/x86/turbostat/turbostat.8
+++ b/tools/power/x86/turbostat/turbostat.8
@@ -70,10 +70,10 @@ The column name "all" can be used to enable all disabled-by-default built-in cou
 .PP
 \fB--quiet\fP Do not decode and print the system configuration header information.
 .PP
-+\fB--no-msr\fP Disable all the uses of the MSR driver.
-+.PP
-+\fB--no-perf\fP Disable all the uses of the perf API.
-+.PP
+\fB--no-msr\fP Disable all the uses of the MSR driver.
+.PP
+\fB--no-perf\fP Disable all the uses of the perf API.
+.PP
 \fB--interval seconds\fP overrides the default 5.0 second measurement interval.
 .PP
 \fB--num_iterations num\fP number of the measurement iterations.
-- 
2.43.0


