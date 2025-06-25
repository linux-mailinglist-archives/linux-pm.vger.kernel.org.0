Return-Path: <linux-pm+bounces-29496-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47180AE8100
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 13:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8D831C22B46
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 11:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED162DA76C;
	Wed, 25 Jun 2025 11:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9Jy0X5c"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6202DA740;
	Wed, 25 Jun 2025 11:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750850715; cv=none; b=fy0+jUjiQx67a/y595lFdI71MAfDdDkoBpKZ9rm6e5E7jAcnN6sGxKK88lwCCoC7cyLWouZ83Iw6yxiTZ9Uh+9j6uo/K0MUU5Tq0KA+Kcky1/oJPDtYe8Asf0Yk5vMV8lMuJKGzBXqrqTwfp5OtlQ+8uQ2Yvj/gsS0/6OMkzm2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750850715; c=relaxed/simple;
	bh=Sj5tdg3WN3OUfbAEd9VRq4imt6Z4ASAMrzQsxj8b3OU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BDxAJ9vy5nGJrJ+hZs2da7FDold+mBAZ0uj0gkLiZNa+zBRGhveS2DWPSF1ojQrP+IcAskPvdiR5OcP0CBq2pmdX/6FaBpFNp+lZkx3Q0M9h/HSKlrLKketZ7x2I2TM3EUV6D6j7f5DUpTRrXGSEzg8zhdl3RgaPBcobzW6qr1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9Jy0X5c; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-451d54214adso10310185e9.3;
        Wed, 25 Jun 2025 04:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750850712; x=1751455512; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cIFXHNMMz/rnn3fp04SvsZG+L3Mgm1adSAVXhKCv578=;
        b=W9Jy0X5cIEUPGkL1g754Zyst9lUcnRsB/0mWfHiq+EXFUl3qyGr/CxWE7N/8ikDChc
         vSNrSwfQpdrAZHgQrGcwcr7ms4EaxIAj5TpaVCbfYnSlI70BoYgWaS6ZjO9Vddr1g3TK
         QqdMuMaPPBDRZSisdtaB8ZHiArJcMlWjvOY5RxSzNqhuTUHamUm/atGIymcVZCQtXCLn
         r3tRfaiVMr4stoaddqjb9KOtQbU5hoLHEGySXk05J8pL3b/e4tCKRK7sq//8zxiVYIfV
         Co4qZ6DQR2aWyD+LOmU5F9qjiDNOLzepjWYE0Bng8FhM7WB+SgAPQ9YVZc1WCUL/GX8p
         vq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750850712; x=1751455512;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cIFXHNMMz/rnn3fp04SvsZG+L3Mgm1adSAVXhKCv578=;
        b=KDUA2mm0OdjczDV/RI0N4hfDbaHMjWkRb6hXudcEKZy65s6fwGDKTy0eehgUzaHLct
         DbRs6j5YV4CX58Fy85zaA/wn68xqilqGx9WJ+0IGaoIpwypJwtq7RtwbK0opfVwxWk+A
         T55dOrunK+Vs8yD/PZM0Sm760Fz9X+XZikBModn0ajXzXJw/ha7g7r4LEszibiDeSn8t
         Vtp/IyRKKOei8JbYbsbZTuZiTkGHyZOKM8eTTRrI5SIhfy6SX8fEuGlX1HtK4kGiVh/C
         Bi0RNQUaif3pXirLOAQO2I2pURHr/M63sGLurMP0toX8zj3/5vt+92/f27X8IZM/XS/r
         YY4w==
X-Forwarded-Encrypted: i=1; AJvYcCUW/xIrPU6XL1rRgpkZFjwwg/J9NXVcaCwVDMuDrtHYfs8UQZLyjMtJd2y4FGfPDHFtgq/PBGwI8yzfN2lG@vger.kernel.org, AJvYcCV52hloHLqTM627qyFJ/DqRZTKIz0TPXnLRssoVbCJ6u302zHqcbfP/xnAYFVusskAOdEhxva+OUdFMVnj5@vger.kernel.org
X-Gm-Message-State: AOJu0YzUfOCjeGxsjeAke9VNwgU4RhFeSbbWn8kbBdfykYaA3HkqcgKa
	cwxbM/yqGdJsvSj51liwk+9NDXf9kcjT1ANisKIkRtskrFBVz2gVZRZWQmxLDg==
X-Gm-Gg: ASbGncv+mrBYq//1j4I9sh3YanbyWeJfInw/R9L2Y5VKCZ9ekCM8eKcxBUyHpdXt+za
	KWGwASiHUGauXVd5mRkIstO3TD6qjiRe7xdqWFDWMcJE+AYM+cUluIKKPtNopTGrO8woiiEypSO
	js/MdIbzHohs8oHgTn1shg0/CjMoFTzXdpeoY0+YaOnDfMIcYjVsKhEzXH/gY8BgOiFVdPyCRkD
	ElE3nPdSiVFS24LDy4Gu/bSQ7boPq6yrzPtqzKszKQv+qtTtaceLA6YnZD8d85YXTPcuUoapqBq
	K87RFDaX2ypGBAEWhiuYS3HIqKKo0XnVOCPcr54JHnPApYPV3vbH/x95OqR3QkFsAsBYDGjV9/S
	Z4yd0IjZ6PuIBwzQ=
X-Google-Smtp-Source: AGHT+IF/l2TTEwk7mY0FbHtJZWfy+l5zfhEIGiynhEEsNVF/kg3NtLIcHyU0wbAYZN6bOw1uR3Q5TQ==
X-Received: by 2002:a05:6000:2910:b0:3a5:1f2:68f3 with SMTP id ffacd0b85a97d-3a6ed66e655mr1844816f8f.46.1750850712019;
        Wed, 25 Jun 2025 04:25:12 -0700 (PDT)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a6e81106b8sm4428642f8f.91.2025.06.25.04.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 04:25:11 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Wed, 25 Jun 2025 13:25:04 +0200
Subject: [PATCH v3] interconnect: avoid memory allocation when
 'icc_bw_lock' is held
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-icc-bw-lockdep-v3-1-2b8f8b8987c4@gmail.com>
X-B4-Tracking: v=1; b=H4sIAI/cW2gC/3XM0Q6CIBiG4VtpHEeDH0XpqPtoHSCQ/kvFQaOa8
 95DT2prHX7f9rwziS6gi+S4m0lwCSP6MQ+x3xHT6bF1FG3eBBiUrARF0RjaPGjvzc26iTrLBLO
 1As0VyWgK7orPLXi+5N1hvPvw2vqJr+/fVOKUU2ErXjRSK1EVp3bQ2B+MH8iaSvDhktc/HFYOI
 KwWhaxk+c2XZXkDLT9IT+sAAAA=
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

The icc_node_add() functions is not designed to fail, and as such it
should not do any memory allocation. In order to avoid this, move the
name generation directly into the functions which are using the dynamic
id feature.

The change in the icc core has been tested on the IPQ9574 platform,
where it eliminates the lockdep splat indicated above. The changes in
the 'icc-rpmh' and 'osm-l3' drivers are compile tested only due to lack
of suitable hardware.

Fixes: d30f83d278a9 ("interconnect: core: Add dynamic id allocation support")
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
Changes in v3:
  - move memory allocation out from the icc_node_add() function directly into
    the users of the dynamic id feature
  - adjust commit description according to the changes
  - Link to v2: https://lore.kernel.org/r/20250618-icc-bw-lockdep-v2-1-3223da346765@gmail.com

Changes in v2:
  - move memory allocation outside of icc_lock
  - issue a warning and return without modifying the node name in case of
    memory allocation failure, and adjust the commit description
  - remove offered tags from Johan and Bryan
    Note: since I was not sure that that the added WARN_ON() is a substantial
    change or not, I have removed the offered tags intentionally to be on the
    safe side
  - Link to v1: https://lore.kernel.org/r/20250529-icc-bw-lockdep-v1-1-3d714b6a9374@gmail.com
---
 drivers/interconnect/core.c          |  4 ----
 drivers/interconnect/qcom/icc-rpmh.c | 20 ++++++++++++++++++--
 drivers/interconnect/qcom/osm-l3.c   | 10 +++++++++-
 3 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 1a41e59c77f85a811f78986e98401625f4cadfa3..f0bdcdcf222af133fcb0a346fa347c5a829e62e6 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -1038,10 +1038,6 @@ void icc_node_add(struct icc_node *node, struct icc_provider *provider)
 	node->avg_bw = node->init_avg;
 	node->peak_bw = node->init_peak;
 
-	if (node->id >= ICC_DYN_ID_START)
-		node->name = devm_kasprintf(provider->dev, GFP_KERNEL, "%s@%s",
-					    node->name, dev_name(provider->dev));
-
 	if (node->avg_bw || node->peak_bw) {
 		if (provider->pre_aggregate)
 			provider->pre_aggregate(node);
diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
index 41bfc6e7ee1d53d34b919dd8afa97698bc69d79c..fa4ef78678eff10e83557035ba572010b51ff50c 100644
--- a/drivers/interconnect/qcom/icc-rpmh.c
+++ b/drivers/interconnect/qcom/icc-rpmh.c
@@ -276,13 +276,17 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
 		qcom_icc_bcm_init(qp->bcms[i], dev);
 
 	for (i = 0; i < num_nodes; i++) {
+		bool is_dyn_node = false;
+
 		qn = qnodes[i];
 		if (!qn)
 			continue;
 
 		if (desc->alloc_dyn_id) {
-			if (!qn->node)
+			if (!qn->node) {
 				qn->node = icc_node_create_dyn();
+				is_dyn_node = true;
+			}
 			node = qn->node;
 		} else {
 			node = icc_node_create(qn->id);
@@ -293,7 +297,19 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
 			goto err_remove_nodes;
 		}
 
-		node->name = qn->name;
+		if (is_dyn_node) {
+			node->name = devm_kasprintf(provider->dev, GFP_KERNEL,
+						    "%s@%s", qn->name,
+						    dev_name(provider->dev));
+			if (!node->name) {
+				icc_node_destroy(node->id);
+				ret = -ENOMEM;
+				goto err_remove_nodes;
+			}
+		} else {
+			node->name = qn->name;
+		}
+
 		node->data = qn;
 		icc_node_add(node, provider);
 
diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
index baecbf2533f76cbf92bb2451979c4db57f8e4a2b..ed59fa73f0d70a5dfdb658ff606ef82977f04bcb 100644
--- a/drivers/interconnect/qcom/osm-l3.c
+++ b/drivers/interconnect/qcom/osm-l3.c
@@ -236,7 +236,15 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
 			goto err;
 		}
 
-		node->name = qnodes[i]->name;
+		node->name = devm_kasprintf(provider->dev, GFP_KERNEL, "%s@%s",
+					    qnodes[i]->name,
+					    dev_name(provider->dev));
+		if (!node->name) {
+			icc_node_destroy(node->id);
+			ret = -ENOMEM;
+			goto err;
+		}
+
 		/* Cast away const and add it back in qcom_osm_l3_set() */
 		node->data = (void *)qnodes[i];
 		icc_node_add(node, provider);

---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250529-icc-bw-lockdep-ed030d892a19

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


