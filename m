Return-Path: <linux-pm+bounces-40891-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FF0D22143
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 03:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 407D530196AB
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 02:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E23212564;
	Thu, 15 Jan 2026 02:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJ7oUKQU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCEC4AEE2
	for <linux-pm@vger.kernel.org>; Thu, 15 Jan 2026 02:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768442517; cv=none; b=s8hRJXXWdHUXlfxBheTgDZ1U4cpcZBxYshLKRnsOJxScRc2xKPIIcQxBLRlD0wnIWN8RE+n9mamOOyJeWScnxytgYruBIipjmdbqIigqe+es256hwRTGx+sI2fyzrMqy+w7rwH5cEIM2Dy+poHTuKhWp54IJVWaINRyX9+l1TYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768442517; c=relaxed/simple;
	bh=rAu5+Y+ldifz5gFpgHhYWsMLDPPsiXJg+C1pDuBtLR4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Mh980uSsUWKl38XiX/tKDbgH8G3OVg7qkR2XvZXCgrOBNgzwDzdhQu1sqZcVup/TQbc04bvXmqntH/64Z5EFyOzmoMDPDhx475xl5QPx3ifDMFhmBtooqpg60m3MTNS3b3pJZntg2GVIG/uE3RdSyk7NVwAO1JgkKylODr7CGGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJ7oUKQU; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8c538d17816so58192485a.0
        for <linux-pm@vger.kernel.org>; Wed, 14 Jan 2026 18:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768442515; x=1769047315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PRCk+UADTFRA3aM1+hmZm3ZVRwhG32jzV9TAtba9MR8=;
        b=EJ7oUKQUg0KrfSP7ux/uxEKEQ8uYexZi+86klTgeYHnN7Pe5x2NkK2W7CP61wj5NGY
         GiUcxP928toG1Wbqg8jw5rVD/swcOpiKn/daxGr2/GBASR2MJ3Y5wwQOLT4fUwOP0RzR
         l0MrWmLH5ka2dy7iaAUH4H3NFJsnj9Tr3kaZIr7bAghmy+ASs96w+l2PTos67ES52rId
         ZV2RJC9Esk1apslhog9J+HgAdVCBAPTcrlOdBh+6x3qN9Mp+kzUbCe+jDOUbhinVWvWY
         D+NvGIK4zIOrCk+lksQHxGneOwa12xmeqZO3qu9HQNKwK9syxNMrUmfnb2uVO/ir6nkz
         fubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768442515; x=1769047315;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PRCk+UADTFRA3aM1+hmZm3ZVRwhG32jzV9TAtba9MR8=;
        b=ftojgnB7A0cQgaFu9PBYPZeEaEprN0tqZychQoeLbQyvIm9DnkUCZM9PPFw0IbnLxh
         oHgvu9e3arJ1u8s6571/bVN07bxUzlRu1uzmhTZfYBux3COBVD31Bi10QQaApedLWEyt
         cjtXP6Y1BhYfRFGZlwA0cbAyO1zenJJF8dDQpNVaEJRwH7PLOELqsKdczEDxmkIZQIWY
         6Fi+G3HDfx9r9BvYry11CTyMHl56rV98QN835oUZdD1uZRehinDqrMuYwEmIAnsfntma
         o0n56JHmwOS+00lWwsw3DYaFkhoUs8GwW2iLKg48UPwbCBCG2cp+Ikx2UWGmgMKJNfcv
         DKvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkCv5fZ/jWa3EUgikqCx9g1ksQgk40n8j1ESrgjq4DAbwR7SdGhrsIjCzh07uWF032tB8iuR3jdQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2ivAALs+ZhT3bVJFjruzDk/uOY8M7Dj4n+ecUKD3ARJzs68ws
	aTUFY/tBxDfOyCNu23r26iISxm66a29SN6lTYa9pBEUQNZm835DC/B09
X-Gm-Gg: AY/fxX6lkqdXEw/cAE/fpjH6eMekTqCuo1DhAH9ssATsL9KPcvg8jJ/lFVKuI1+Fhpw
	jTAPZDBuDPHOoIG66KnwA/Akcgfz5t6srfLRA8gBgvKRcZpMwsoLIkF8weFdKJGI+G/mYBzvzGO
	39eDBf3IsGQYaCSEbHEtwfQlgl5OmzG3rNe9a9botwP8Z7vHG607TusKuB1l0b4+8dfnCoYxNuh
	a7S92riM/zR1jduSB8ejNJ1+VbVIGhuJ+um+z8oz4klVIez0nOJIkjxg+uLCj0RGysrB+0Bf4q8
	RT/H4eLF7fD1LduwIBl0rGpeStfLIOU/r9f2WNvPabSs9eVL9L0PO4xDxYJqEgwbsUH6BlPotNi
	HsOLJ+P2u8AaehjTt7S6lOEZhVL9XVzLuiEZkpXnczuEnZDfDSZ6tRjNuST91M7GenPVsvIbMQQ
	jaF6Js3ZATKRBt8+FLAxGMbvr8Zai0eIQZclGxPVf2Yw==
X-Received: by 2002:a05:620a:c54:b0:8b2:efe7:d82b with SMTP id af79cd13be357-8c52fb5708bmr676515385a.30.1768442514383;
        Wed, 14 Jan 2026 18:01:54 -0800 (PST)
Received: from daniel-desktop3.localnet ([204.48.94.102])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890772341d0sm191726366d6.31.2026.01.14.18.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 18:01:53 -0800 (PST)
From: Daniel Tang <danielzgtg.opensource@gmail.com>
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] powercap: intel_rapl: Add PL4 support for Ice Lake
Date: Wed, 14 Jan 2026 21:01:52 -0500
Message-ID: <6088605.ChMirdbgyp@daniel-desktop3>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Microsoft Surface Pro 7 firmware throttles the processor upon
boot/resume. Userspace needs to be able to restore the correct value.

Link: https://github.com/linux-surface/linux-surface/issues/706
Signed-off-by: Daniel Tang <danielzgtg.opensource@gmail.com>
---
 drivers/powercap/intel_rapl_msr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
index 9a7e150b3536..a2bc0a9c1e10 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -162,6 +162,7 @@ static int rapl_msr_write_raw(int cpu, struct reg_action *ra)
 
 /* List of verified CPUs. */
 static const struct x86_cpu_id pl4_support_ids[] = {
+	X86_MATCH_VFM(INTEL_ICELAKE_L, NULL),
 	X86_MATCH_VFM(INTEL_TIGERLAKE_L, NULL),
 	X86_MATCH_VFM(INTEL_ALDERLAKE, NULL),
 	X86_MATCH_VFM(INTEL_ALDERLAKE_L, NULL),
-- 
2.51.0




