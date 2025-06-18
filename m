Return-Path: <linux-pm+bounces-29013-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E542ADF756
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 21:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF3227A2550
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 19:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE0921A421;
	Wed, 18 Jun 2025 19:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcphAlM0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E55204F93;
	Wed, 18 Jun 2025 19:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750276725; cv=none; b=uHmnxZu0+8miMxMLRXm+oQImVxuCttMRuhqgrgDcYN3tgfqKzRK8Z11zZpbrx4e0G7casR9OIi8uBdoSHgg1aXGovVyezWdjqLvdpKWxHla14/TBLdG2lPZU8a7MIb7pNA3IiW7Fw+1Gn5QSWVwACQlrGZNj+niDh3X0laOLUVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750276725; c=relaxed/simple;
	bh=oW4TG705Njm3fkS66GWsdvEAqtCg4YLGDNfdILMxpE8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MnvvpfzHeWkhOnAGzyKcwFUetK2QrSXkyi9jo7n3encp7L+xmGUQkO46uyDwJdeEec+SWQNpxWH/b9vBHKDMaoxogUWSp5LMHVzxL9wTeZ5i1OFm5QCK7A7FEHPsfvsyOsdc+/KDzJuCm+AX9vryd1tWAkDaMNq61p6p6EDmpbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NcphAlM0; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a525eee2e3so40712f8f.2;
        Wed, 18 Jun 2025 12:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750276721; x=1750881521; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yILEYjuFKOksTOtZQJ1mh+Zyv9A7FgLZzQhTctgdMTI=;
        b=NcphAlM0Cy33uhHypioyrU92Q2KfmNF03NgvSdGlAfce9XmhhoiCSok5ASm96H9b1k
         aLbHzncJ5j9o8W4sh/qTQ0Tv+VZtdJjVyfJ1PFyD3HWspYLioRgbqJpcoLQi6d8uMSzb
         IBbkY+1t7jpMn0N/8WS4YJ4sReNkHETlJQcitkEsKnyIdVsYHeCdeOVoSBu4JdA4pkTX
         OiW+Fl55MGGBgQO6UlTsVKIsvzIoyMQg8xew9m1aJ86YSdcFJri1fL6ladQnMz3X5Wsi
         QgqfuFcELHN1IothtbqKGGWqj8sav/xRd/88ia4zOm7utMmQAclGYzoiypOH7bMs94RI
         8b+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750276721; x=1750881521;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yILEYjuFKOksTOtZQJ1mh+Zyv9A7FgLZzQhTctgdMTI=;
        b=Efb01SUtbxK39jni2Z5e5vFpofMG2dtOPChMAaOMtoJSXLxzLLhQsphq1ZprSgQce7
         mexe/oh9qbdJcXoQBygjRKPPVO1txu7hkke1NYyGeFCe+xZ0bm7epx9laPZ4lNsa7+xe
         el73TBtfTfCGAl0Qo+94iJ/Fbm+ALGtAQ0ar48UVxFVc/byXg1h1AHOEr2QxFXJPbWNC
         75qml+ZiIVqvGYxe8tKhNLcLmBF7uG+GbbqTIc29t76br8XgHFEiPbLGv6hu0QfkIf3o
         ua9Z3ywqJF1RR0Pim4nm497m1HPKqk5k6H+1B8I7GPy3EKlv24o42040EFmhU6GPvPRS
         AMkw==
X-Forwarded-Encrypted: i=1; AJvYcCVe4a47EhKRFJ6/SUaIRdOD5741kZVeMy3LPeqOZ48cbX2M9Q3n+28RCe2eYPRkvHYqbzBmIc748Zni3aXZ@vger.kernel.org, AJvYcCW4tZJaG98rgZa9k3BLwvx3/Q0yU5UyAHzbpCCUOypOElmWaihimCwgD4hRWv0ezayScPwnq1gwGcbbn3dQ@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq/46DHdgEXBlf7Kfo623raYqcjC996U/pajhEI08++zXIXGq2
	k/WWxJrDd9HnQrJzEkdmA1Tud0Wqqa/FNSzmKxtcLr7DZhzSHu7Mg5Kg
X-Gm-Gg: ASbGncvsqphwPLrPcZR2LqPqNR/kjuHymP/D+WpikXejTeMWReCeS9E+14RyEpBu4bM
	kFXb5GKPltNFlCH3dMQi+u2G8W1geoeSFa319Y941JkNXVUmO9TeLxtec2F2784F2BIQGCZkPhC
	GEcDCzmgtAzFltUNZEL0+skNTtGubo9oNh4ef8/0qo/lSD9Y7jpXRUdUba+7EHmcd9w5piXl49t
	uQwo23XvFa7fUIW++oG9j5Gd3Wy+YqT5LURxnIlBReiTAH9Ze3+66Xt06qBCGQ+MEOGUvuziRgG
	8xFP4KFL8QJBG9P29/nLPQYyDLgaCVHEHXOugDSERBwnqrT9Ek2Ho9RT24veVvWzfTuS4UFehIO
	/Es/YJlYN55WbBSM+r/XrysUkZA==
X-Google-Smtp-Source: AGHT+IHKDBE85qKyxIh/y74WJ1k5i5BdngRQIWn0H2JXqVuA/Jp5pXJ5N/mmlj9xCDhDKks1oNCrxA==
X-Received: by 2002:a05:6000:2d0c:b0:3a5:8d0b:d0b8 with SMTP id ffacd0b85a97d-3a58d0bd1camr3306079f8f.54.1750276720655;
        Wed, 18 Jun 2025 12:58:40 -0700 (PDT)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a57b15015fsm12196730f8f.95.2025.06.18.12.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 12:58:40 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Wed, 18 Jun 2025 21:58:31 +0200
Subject: [PATCH v2] interconnect: avoid memory allocation when
 'icc_bw_lock' is held
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-icc-bw-lockdep-v2-1-3223da346765@gmail.com>
X-B4-Tracking: v=1; b=H4sIAGYaU2gC/3XMQQ6CMBCF4auQWTumLSDWlfcwLEo7wkSgpDWoI
 b27lb3L/yXv2yBSYIpwKTYItHJkP+dQhwLsYOaekF1uUELVolYa2VrsXjh6+3C0IDlRCnfWykg
 N+bQEuvN7B29t7oHj04fP7q/yt/6lVokSS9fIqjsZXTbVtZ8Mj0frJ2hTSl9vjjULrAAAAA==
X-Change-ID: 20250529-icc-bw-lockdep-ed030d892a19
To: Georgi Djakov <djakov@kernel.org>, 
 Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>, 
 Johan Hovold <johan+linaro@kernel.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
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
path to eliminate the warning, and add a note about why it is moved
to there. Also add memory allocation failure handling, while we are
at it.

Fixes: d30f83d278a9 ("interconnect: core: Add dynamic id allocation support")
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
Changes in v2:
  - move memory allocation outside of icc_lock
  - issue a warning and return without modifying the node name in case of
    memory allocation failure, and adjust the commit description
  - remove offered tags from Johan and Bryan
    Note: since I was not sure that that the added WARN_ON() is a substantial
    change or not, I have removed the offered tags intentionally to be on the
    safe side
---
 drivers/interconnect/core.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 1a41e59c77f85a811f78986e98401625f4cadfa3..32d969c349093bc356dc66234c62484aa9b9e872 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -1022,6 +1022,21 @@ void icc_node_add(struct icc_node *node, struct icc_provider *provider)
 	if (WARN_ON(node->provider))
 		return;
 
+	if (node->id >= ICC_DYN_ID_START) {
+		char *name;
+
+		/*
+		 * Memory allocation must be done outside of codepaths
+		 * protected by icc_bw_lock.
+		 */
+		name = devm_kasprintf(provider->dev, GFP_KERNEL, "%s@%s",
+				      node->name, dev_name(provider->dev));
+		if (WARN_ON(!name))
+			return;
+
+		node->name = name;
+	}
+
 	mutex_lock(&icc_lock);
 	mutex_lock(&icc_bw_lock);
 
@@ -1038,10 +1053,6 @@ void icc_node_add(struct icc_node *node, struct icc_provider *provider)
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
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250529-icc-bw-lockdep-ed030d892a19

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


