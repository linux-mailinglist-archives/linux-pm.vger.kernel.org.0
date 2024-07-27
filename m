Return-Path: <linux-pm+bounces-11478-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6AA93E085
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jul 2024 20:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F932B211B6
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jul 2024 18:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7948618754F;
	Sat, 27 Jul 2024 18:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H56yngBS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80EB187352
	for <linux-pm@vger.kernel.org>; Sat, 27 Jul 2024 18:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722104816; cv=none; b=W/W65i9HOZ9XD/CxJ5E4qJ1Eb58ogcUgo6VUnBcxToxxFUtyKPiAQS8otlKpYKAWMekWb7vYJwFPXxPL/AKCAxrnOQM0+G5a6xNxo3kJb9a5BiMAp3ZkO0R4bm1oHc8uZ3tm0OOWwRtf/BVF5dlQgf26mSApeWLVRVeXHhmYftY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722104816; c=relaxed/simple;
	bh=wjfP/XZkTQB1ylfHLuBaA7/89OuA1BtC+AJRrxu/EHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TQ/QluUaYrWyRSPNbKY92Gs4E8xcIPKFuWxQzf6IGIlfjQoW9gacUbnljTkJRReVUWN8ibSDMn8eiIfP65busuSeFGy0L4p15Ny8a3Pg5C3rr3JdU/91UgAnKR4RWDRd6EXdRCUVdESeC5jTem7Q4Yul35XFa2EncGcW0iq1Yo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H56yngBS; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-25e397c51b2so1384685fac.3
        for <linux-pm@vger.kernel.org>; Sat, 27 Jul 2024 11:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722104814; x=1722709614; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KK3J80kE/z8G0eqRMVBARFWyUCawjwQ2dKvUiKZ8auI=;
        b=H56yngBSB2khSDDCf3YFy/ZIUJNPmeArqaRpQEtmHimbyf63Xq1JrlMX17KUwR6FwG
         PIQtU9rBV1dovRC+5m/FADOaFQVULAsNIlXXFl5mVPK41CFAO39VD2ZCSNB4iDcVzQCp
         ElNpDT4BSVWv7t8jcIUycN2EfHVPes2qIrcVa59Pv5c7i1HAezFzvNfeKDQSfFSwBoks
         zKzPD7Is3xNINXvdQz5rMmfR2p9GJVJyLqTN56T9umQWa0E2MyQIPclzE/TdgZ3tb5a/
         jl07zlz1sJayVfa5AUqsVs2v23RGajTRzzte4/cPxu/133D99omMrgBG/BD6WojVMTni
         30aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722104814; x=1722709614;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KK3J80kE/z8G0eqRMVBARFWyUCawjwQ2dKvUiKZ8auI=;
        b=WQMULuCOYHeSrGIuwPPrZrjfxDF/LUF9tJP6LQ1BrzDUd1M2hHn2PaRsChMLXiFfDM
         fJ9uK7BjN8WIj8wKFp/qHeM2rw3q8kejwXMsv9kggKsqTeqNIoFSk+Cb7Nlnd3uqu63h
         JKADjgoPTPEoEmH6XG/QwmZmsDgE/MJQJh+iRCZti5toO9LkvRl2fluaNNdf5fVwDj9+
         ZRdbAgQu2Y1QvsshG/x5+hKzRC0qUl6t0Rr92PZswBS1GkvAuzJKMZAQgnB3RoES0Ubq
         E4kU9t983pD+OA41+GdtRbkT25PUyh696b4kQh/d/wKRyGYryj+pjVoGRrnBn3UIpdW3
         l0FA==
X-Gm-Message-State: AOJu0Yws8RLec+G62ZT7y0VurRy2MAxQjklxtIRJTBrrDAZeG1Nsj0P+
	2T51+426ERuqjXbnyO7+mds7fUgSX4x8IA2hb1tTHdDkoCTf1I1mKz3VTA==
X-Google-Smtp-Source: AGHT+IGO6VEVQKNOCicVAFB98v9JsuJVBjz+dJeGSNf+k3mB5d/dLp3RPbAORtev6R5Xn6NfzCbQZA==
X-Received: by 2002:a05:6870:ac21:b0:261:7b0:9d66 with SMTP id 586e51a60fabf-267d4f58616mr3203165fac.50.1722104813651;
        Sat, 27 Jul 2024 11:26:53 -0700 (PDT)
Received: from lenb-intel-nuc8i7hvkva.. (h75-100-80-185.cntcnh.broadband.dynamic.tds.net. [75.100.80.185])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7093050a35fsm1314136a34.6.2024.07.27.11.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 11:26:53 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 08/18] tools/power turbostat: Add perf added counter example to turbostat.8
Date: Sat, 27 Jul 2024 14:23:34 -0400
Message-ID: <9f50066b0dd47cff045ba6da37e6def52783ba55.1722019621.git.len.brown@intel.com>
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

We had few lines about the feature, but without any complete examples.

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.8 | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turbostat/turbostat.8
index 8a21e9b56071..71ae2d5159ad 100644
--- a/tools/power/x86/turbostat/turbostat.8
+++ b/tools/power/x86/turbostat/turbostat.8
@@ -336,6 +336,24 @@ CPU	  PRF_CTRL
 
 .fi
 
+.SH ADD PERF COUNTER EXAMPLE
+Here we limit turbostat to showing just the CPU number for cpu0 - cpu3.
+We add a counter showing time spent in C1 core cstate,
+labeling it with the column header, "pCPU%c1", and display it only once,
+after the conclusion of 0.1 second sleep.
+We also show CPU%c1 built-in counter that should show similar values.
+.nf
+sudo ./turbostat --quiet --cpu 0-3 --show CPU,CPU%c1 --add perf/cstate_core/c1-residency,cpu,delta,percent,pCPU%c1 sleep .1
+0.102448 sec
+CPU     pCPU%c1 CPU%c1
+-       34.89   34.89
+0       45.99   45.99
+1       45.94   45.94
+2       23.83   23.83
+3       23.84   23.84
+
+.fi
+
 .SH INPUT
 
 For interval-mode, turbostat will immediately end the current interval
-- 
2.43.0


