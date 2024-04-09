Return-Path: <linux-pm+bounces-6079-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2D889CF62
	for <lists+linux-pm@lfdr.de>; Tue,  9 Apr 2024 02:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE5ED1C23F1F
	for <lists+linux-pm@lfdr.de>; Tue,  9 Apr 2024 00:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04FF5250;
	Tue,  9 Apr 2024 00:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bG9QakLU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D524A07
	for <linux-pm@vger.kernel.org>; Tue,  9 Apr 2024 00:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712622711; cv=none; b=pOpTEo1OW6+aeuEAT50890DgVaDkoXxGNUkC+35SuWD4HAVlc0TAWSs7QpoCGTKSmsoIArcYAPLrKAABHpg82INB06gd5w+uOQo4GnWrURCUVUyA2M9nlJ013GcGfb6OedY7e6JeOOdUcqu+CFDjeDqezy2Wi05KFrRbxvvh7vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712622711; c=relaxed/simple;
	bh=/YbwUyYrt28qPZZQ/6k56eNBLSU+Mpp/+wCBtEtQKfY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LVvZa2OJs16pAx3oMfTUNblPBHF+3oXDTQ04QUN7zZCpDNIVWRWcC9RKg2lYU3BOrnazG1PlcbefNo6jB6Pm+vv4wS2bSBASczSsjooR+2cPD2CuirVaKCRhTguJkBRFKYOg3IVHeMxwySbUxHcKAf120yei58sFE1nnAKQkjLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bG9QakLU; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dd10ebcd702so5236678276.2
        for <linux-pm@vger.kernel.org>; Mon, 08 Apr 2024 17:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712622709; x=1713227509; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jzUCuhMkUylMcc+eCz2GQfJ1emZeqh2Ez9m4JWmfD54=;
        b=bG9QakLUDDrzHe4KZk6EbigbIBSJ9zQ6LZbE2+RqIuIzYrdU1f9piYf6u+FT418sM8
         t7y+SkahxwMRoCUNv2md9ibauqdJT6jW6g/LDuPSikQLPLkKfGGwPNgCv6i9Pwl3qJaZ
         C9mOcLEgnlNjIt5w0nGvT49MssGD8G0QKiAvgkPChr+JSAdcgkxDzPxThUYQrbndl05w
         FdvbsNA3Mu2yAoFH/RhNIVXZYDXQ6il1fn8QdOGUw8bVx4zR+96QGJbpG7X1PJ6kV8pn
         yzgy6cVCb2BDloQ0wxMJ+ZYosMfR5/K5MzV7DE7vk0siqllyh4jmUHXnOMCnkapo+KXL
         zzLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712622709; x=1713227509;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jzUCuhMkUylMcc+eCz2GQfJ1emZeqh2Ez9m4JWmfD54=;
        b=UVJulpYIXKLRc90U5FLet4b3WsE5k8e6mN1aHVJN173cqCGZEdVy3Fef+4TS4cm9EO
         WFIKb0feYNFW1YdAp2RlaHGKNLHdqJZliru2k0oapzf77kurSGdikos/hfVjW74BzF65
         xipWd2weO4yWCZdpvesnygT/hLSWrvrbr+FSRXV1n+hbEBy7gIvn14eT1wk4hkxZiFAi
         ZYPb69q0BAtNWGZ1trWx5npbkhW8ZL4EvhRrunwNlQI8SRaeY08PC21nCyOpRPMdaeWx
         9pcIGcTH4oLiY7jDRR7I5cHMVvw2V1s++GizGUCXJT49zbBZ1jxMrtGbwrhT6EiO2hYr
         37vw==
X-Gm-Message-State: AOJu0Yyu55HCeGoGuRlwOPqQHYoU4OM/8Dz/AU2qxzUkRHg0gV5bTAo3
	LrvIJgi5nlksj3t6rmnOeuEFOAm0lVvT/AUg2AQXhm1ocP8I6SiwC0EGfm8+
X-Google-Smtp-Source: AGHT+IFYh4jSAsHKgBjb2Lw8tiY35zUIpdzeuKgcgkygDAibpCdgBoSXlWG+vCGiW6BDM6rXqrDFAQ==
X-Received: by 2002:a25:946:0:b0:dbf:6267:eba4 with SMTP id u6-20020a250946000000b00dbf6267eba4mr8880776ybm.27.1712622708978;
        Mon, 08 Apr 2024 17:31:48 -0700 (PDT)
Received: from lenb-Intel-NUC8i7HVKVA.search.charter.net (2603-9000-9f01-67cf-100c-5508-c194-b194.inf6.spectrum.com. [2603:9000:9f01:67cf:100c:5508:c194:b194])
        by smtp.gmail.com with ESMTPSA id h6-20020a25e206000000b00dc74ac54f5fsm1531949ybe.63.2024.04.08.17.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 17:31:48 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 07/26] tools/power turbostat: Read base_hz and bclk from CPUID.16H if available
Date: Mon,  8 Apr 2024 20:31:01 -0400
Message-Id: <538d505fde20393bce1e6fb95cec82b56cdd22ef.1712621427.git.len.brown@intel.com>
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

If MSRs cannot be read, values can be obtained from cpuid.

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index a4a40a6e1b95..c35c48b6a99a 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -5848,6 +5848,15 @@ void process_cpuid()
 		base_mhz = max_mhz = bus_mhz = edx = 0;
 
 		__cpuid(0x16, base_mhz, max_mhz, bus_mhz, edx);
+
+		bclk = bus_mhz;
+
+		base_hz = base_mhz * 1000000;
+		has_base_hz = 1;
+
+		if (platform->enable_tsc_tweak)
+			tsc_tweak = base_hz / tsc_hz;
+
 		if (!quiet)
 			fprintf(outf, "CPUID(0x16): base_mhz: %d max_mhz: %d bus_mhz: %d\n",
 				base_mhz, max_mhz, bus_mhz);
-- 
2.40.1


