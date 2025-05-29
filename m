Return-Path: <linux-pm+bounces-27812-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1DEAC7FD9
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 16:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 606D34E7084
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 14:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331021D54E3;
	Thu, 29 May 2025 14:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXlRywia"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B7833E4;
	Thu, 29 May 2025 14:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748530006; cv=none; b=bj49SaPGGTKA00Ty9ulHoJPhlGR0G/dhjFx4t40cFBg6Z67axtowyBlbsqtNY+yb3LGcoTrBhBh+h/KjiFX2/qaztk03n9e6U4jgVpACncJIS6KkqwZ7zszwQezwcBduBeLZTkuwhoZXAEj+TVHXRZn8cT/gg1+NmJV3BBpEgrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748530006; c=relaxed/simple;
	bh=o7zOUWw+bfVPmCX9sVtJU4ijfYOeILVW1h1XXcbFL7M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=L988M+rQZUF2+nJiRKQdIT/r4eFjVuBnmN5wrlGamLHphkIpxqnNu9Lr79whvN3zEdE7yJatZSSAOSui6RJQJfVd5WUI/gyFr8QrkyX49en4LajLwhFlVmElJsb5bmGYSacgT+XdgUDqambjef6N5OsP1Ysb/sU2W7PD9oxibZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TXlRywia; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-acbb85ce788so185805966b.3;
        Thu, 29 May 2025 07:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748530003; x=1749134803; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o6s1X44gSr+PicBbp06dR7dBEvoISYnjwPRlPfKlplU=;
        b=TXlRywiaTR4XLH8fgvMziVbBgoyhPwbKNRinTiDpZbe9GFbdCRV4kepQZQPix1+KAo
         Zxm6h7+I4Sa0PE6xk2Q6QI9q+8cz8stvMXAC6+EmMYqZXx4E8xL41GVPDWIaTvQeRy0q
         4IfDbx/Ca8tzM9Q3rKIey8UQpj8KIElltI3qlS1l3WZCkeXCNtpmqLxmElqjusB/tUh0
         hcfNmGw5bBP/48uvXZgzkbci8pE+92NSVgryJSJmick5swBA04djg/qmKLH/IKlwCRtI
         C4Bz7uAJQx2d2Gr5HDLmSY12nYQenk8hiQYduYRd4O8IaSayeVvDcBWf3bC67Ac9zYFe
         DY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748530003; x=1749134803;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o6s1X44gSr+PicBbp06dR7dBEvoISYnjwPRlPfKlplU=;
        b=ny0gpCsLBDNqjshd5sv33/ckGH+RHLKr7E2M2Hm3dWPA5FXixKwQiwveiqwGf3/AjA
         xUFH6OBviQGXU6jehlWO+mSNqfW8X5IEptlYG+HgOMvG6Ohu8Bm69rguGqDAvN9Hx/Pr
         +2rqVKAbIXu3ZAqKhy5WhLcjk3sX5bTaHMds+13JY/pGofsZc+zdkT87Dfk5dhylWoG4
         /eXjv5gejRpMuMlvlk+5SY/+2+UnRiSyu/CiIdtrMx4oxpm3cb/QBk4u9wngEqnoXFpQ
         qjnSH3VoasV/4jlBcyxTQ4wxD+KPZYnL6v4FEz6N2n7Q/JOXkbzmVsmp9J60O8Z6I51f
         T8/g==
X-Forwarded-Encrypted: i=1; AJvYcCV9kbuli6yTzjj0aPdEUU8/1xTHcIuAxuGQgxeQdi1JxxcNTKm7z1fcYn5rdXl2uBRrkzKx2i99f/8VkXBz@vger.kernel.org, AJvYcCVc2yIgnWTw5YO1uyDi/w6ujq8mEpAPTYhs8+5DxgpLmn4CkVHHvVoyUK0QXnZ9PVhQZjFimf33BE73kqNz@vger.kernel.org
X-Gm-Message-State: AOJu0YxdITpOJ9T1ut37uifYo3yVZwzS+Zg3cMqyBxVvP9c2N+QzaDHs
	y8I11+dFZK8uGIV6kFZaLGLpYJrRQFZBoAyXQK9DSMYTFkZ7bFAQUm2M1IhyOw==
X-Gm-Gg: ASbGncvKXag1EOGHJl4GBQd4M8dXYVBZEixVToHympbL3IPGtxtBd5W1BEYJ77KIje7
	Bc+AoqT2IW0z5wqYX8SRknam7nBV2Fx5lhD5kz1uvQaP3I40LIE9usU9ZypBkcWri5AXl5JaIzE
	SeVehsWgIk55PA2vj+LOs2uxMKqrsKSuhuC1JmuQ5ma7pjN5Z7T7u03quKzpClfRC0E0ka+Mgb8
	aURQ+zo/nLSilIi/u3hbn9Eu+Ivh22Rb27zmriyfKSHZLnho5Zng7tzFpNecci8Jvmod8mX8RA9
	sYsofAGyX+MPDmJvxNRQv3CK74Hevlxv58DrTBN5YonEJRIR9cjI3Li/hoMuDNGPxyDys3WmMSv
	aHB0I
X-Google-Smtp-Source: AGHT+IGIihMz3J/BrtVxXOI6Jl10NTFwYGyB7LBZsOOevcAu5Ett2ACNSRMbqkwLu8adJvPKKMaPUA==
X-Received: by 2002:a17:907:980f:b0:ad5:5893:501c with SMTP id a640c23a62f3a-adadeeb8516mr257005066b.41.1748530002230;
        Thu, 29 May 2025 07:46:42 -0700 (PDT)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ada6ad3a6c1sm153399266b.153.2025.05.29.07.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 07:46:41 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Thu, 29 May 2025 16:46:22 +0200
Subject: [PATCH] interconnect: avoid memory allocation when 'icc_bw_lock'
 is held
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250529-icc-bw-lockdep-v1-1-3d714b6a9374@gmail.com>
X-B4-Tracking: v=1; b=H4sIAD1zOGgC/x3MQQqAIBBA0avIrBswQ8iuEi1KpxoKE4UKxLsnL
 d/i/wyJIlOCQWSIdHPiy1e0jQC7z34jZFcNSiottTLI1uLy4HnZw1FAcrKTrjdqbg3UKERa+f2
 H41TKB8GUHdRgAAAA
X-Change-ID: 20250529-icc-bw-lockdep-ed030d892a19
To: Georgi Djakov <djakov@kernel.org>, 
 Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.2

The 'icc_bw_lock' mutex is introduced in commit af42269c3523
("interconnect: Fix locking for runpm vs reclaim") in order
to decouple serialization of bw aggregation from codepaths
that require memory allocation.

However commit d30f83d278a9 ("interconnect: core: Add dynamic
id allocation support") added a devm_kasprintf() call into a
path protected by the 'icc_bw_lock' which causes this lockdep
warning (at least on the IPQ9574 platform):

    ======================================================
    WARNING: possible circular locking dependency detected
    6.15.0-next-20250529 #0 Not tainted
    ------------------------------------------------------
    swapper/0/1 is trying to acquire lock:
    ffffffc081df57d8 (icc_bw_lock){+.+.}-{4:4}, at: icc_init+0x8/0x108

    but task is already holding lock:
    ffffffc081d7db10 (fs_reclaim){+.+.}-{0:0}, at: icc_init+0x28/0x108

    which lock already depends on the new lock.

    the existing dependency chain (in reverse order) is:

    -> #1 (fs_reclaim){+.+.}-{0:0}:
           fs_reclaim_acquire+0x7c/0xb8
           slab_alloc_node.isra.0+0x48/0x188
           __kmalloc_node_track_caller_noprof+0xa4/0x2b8
           devm_kmalloc+0x5c/0x138
           devm_kvasprintf+0x6c/0xb8
           devm_kasprintf+0x50/0x68
           icc_node_add+0xbc/0x160
           icc_clk_register+0x15c/0x230
           devm_icc_clk_register+0x20/0x90
           qcom_cc_really_probe+0x320/0x338
           nss_cc_ipq9574_probe+0xac/0x1e8
           platform_probe+0x70/0xd0
           really_probe+0xdc/0x3b8
           __driver_probe_device+0x94/0x178
           driver_probe_device+0x48/0xf0
           __driver_attach+0x13c/0x208
           bus_for_each_dev+0x6c/0xb8
           driver_attach+0x2c/0x40
           bus_add_driver+0x100/0x250
           driver_register+0x68/0x138
           __platform_driver_register+0x2c/0x40
           nss_cc_ipq9574_driver_init+0x24/0x38
           do_one_initcall+0x88/0x340
           kernel_init_freeable+0x2ac/0x4f8
           kernel_init+0x28/0x1e8
           ret_from_fork+0x10/0x20

    -> #0 (icc_bw_lock){+.+.}-{4:4}:
           __lock_acquire+0x1348/0x2090
           lock_acquire+0x108/0x2d8
           icc_init+0x50/0x108
           do_one_initcall+0x88/0x340
           kernel_init_freeable+0x2ac/0x4f8
           kernel_init+0x28/0x1e8
           ret_from_fork+0x10/0x20

    other info that might help us debug this:

     Possible unsafe locking scenario:

           CPU0                    CPU1
           ----                    ----
      lock(fs_reclaim);
                                   lock(icc_bw_lock);
                                   lock(fs_reclaim);
      lock(icc_bw_lock);

     *** DEADLOCK ***

    1 lock held by swapper/0/1:
     #0: ffffffc081d7db10 (fs_reclaim){+.+.}-{0:0}, at: icc_init+0x28/0x108

    stack backtrace:
    CPU: 3 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.15.0-next-20250529 #0 NONE
    Hardware name: Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C7 (DT)
    Call trace:
     show_stack+0x20/0x38 (C)
     dump_stack_lvl+0x90/0xd0
     dump_stack+0x18/0x28
     print_circular_bug+0x334/0x448
     check_noncircular+0x12c/0x140
     __lock_acquire+0x1348/0x2090
     lock_acquire+0x108/0x2d8
     icc_init+0x50/0x108
     do_one_initcall+0x88/0x340
     kernel_init_freeable+0x2ac/0x4f8
     kernel_init+0x28/0x1e8
     ret_from_fork+0x10/0x20

Move the memory allocation part of the code outside of the protected
path to eliminate the warning. Also add a note about why it is moved
to there,

Fixes: d30f83d278a9 ("interconnect: core: Add dynamic id allocation support")
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/interconnect/core.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 1a41e59c77f85a811f78986e98401625f4cadfa3..acdb3b8f1e54942dbb1b71ec2b170b08ad709e6b 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -1023,6 +1023,16 @@ void icc_node_add(struct icc_node *node, struct icc_provider *provider)
 		return;
 
 	mutex_lock(&icc_lock);
+
+	if (node->id >= ICC_DYN_ID_START) {
+		/*
+		 * Memory allocation must be done outside of codepaths
+		 * protected by icc_bw_lock.
+		 */
+		node->name = devm_kasprintf(provider->dev, GFP_KERNEL, "%s@%s",
+					    node->name, dev_name(provider->dev));
+	}
+
 	mutex_lock(&icc_bw_lock);
 
 	node->provider = provider;
@@ -1038,10 +1048,6 @@ void icc_node_add(struct icc_node *node, struct icc_provider *provider)
 	node->avg_bw = node->init_avg;
 	node->peak_bw = node->init_peak;
 
-	if (node->id >= ICC_DYN_ID_START)
-		node->name = devm_kasprintf(provider->dev, GFP_KERNEL, "%s@%s",
-					    node->name, dev_name(provider->dev));
-
 	if (node->avg_bw || node->peak_bw) {
 		if (provider->pre_aggregate)
 			provider->pre_aggregate(node);

---
base-commit: 5fed7fe33c2cd7104fc87b7bc699a7be892befa2
change-id: 20250529-icc-bw-lockdep-ed030d892a19

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


