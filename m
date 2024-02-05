Return-Path: <linux-pm+bounces-3411-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4885B84A302
	for <lists+linux-pm@lfdr.de>; Mon,  5 Feb 2024 20:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8D1B1F21FA7
	for <lists+linux-pm@lfdr.de>; Mon,  5 Feb 2024 19:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0734A482E5;
	Mon,  5 Feb 2024 19:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xpqYQV7/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1743C481BF
	for <linux-pm@vger.kernel.org>; Mon,  5 Feb 2024 19:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159725; cv=none; b=kgkf/ja5EVtmp25uLPn+3TU405nVeegDaXcz5t6/2QOAslddpFTfYQavTHyL1vMmBSlbw/inGDYU2O1sOJ1hSlRnvqJaYK7mU8YP/nQ9/fzRcywXTOFz4h1yMe8YMaVqE0KgUqfrmxS983yyP3+LPoHzdHZZw5uGsV6x/qwXD4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159725; c=relaxed/simple;
	bh=5lYJPNH7ZdwNpNFjeIRTTlECYjlLU6dsHmfIjFZlzoY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fS0+Eq/dvbu+b5aXb4ZVRczVAw08CtiQD62G6KEMFh5Fh1ode/lHDQ72uC2GG+WhYVO/wEXmN1JqcTD0F0tdj39DlFztGFZ9J/owdk8fSuFjUoa9AeCjwJ0OtNoQ0VSary5BgNSIQobHADPuw8rKLPAfOpjye/dX+dj3RGN6tUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xpqYQV7/; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d0512f6e32so57282111fa.1
        for <linux-pm@vger.kernel.org>; Mon, 05 Feb 2024 11:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707159722; x=1707764522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QemNO+c45J3TSx6FcSHQfwkZOTsDS0K4Gg9M0rrbiy8=;
        b=xpqYQV7/Fx5ZDSrBNWO1xZ6JZTOtXuLnksLGI3pwhaFzKaRUsJnINArnPQfb02weyx
         OMGBpiJ2sgCSnWFW0nluDFKGgIUR5MGgdV3p/taV94iAcPaNiAByrr9OllbviI10WqAT
         mRyI3wY6RkEQQbzsOuM+sZSfv+tWyrnUdjJJcHjmf9d/FM0GQyD/0SqwIdFjs/e3MT6Q
         nNgKyEI4yygCg6vEeydlohasLgtV6jtiJlB2cSZ1aWXI4fRg+w4Sdg2v12CP3KlRQpvY
         S8fh/3QuuqDcVLjFQUQmVgOI+NqnuP2rJ0Icwxwbts0oN+u0pjNlDBOSUKquzr+qJUr1
         JsFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707159722; x=1707764522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QemNO+c45J3TSx6FcSHQfwkZOTsDS0K4Gg9M0rrbiy8=;
        b=HJnioX2dBK0UUec7tIzReGz2w0A07fr+g7OfB3/w1T3e9IAQ6vTWvPagOrpMQMQruD
         vBxV/0y3iJrm9Q21EJGnE4ePEnD6dwK6XTd3+Vw+u7ETzqMIDQkGac1nLgNjmfIxr8hq
         ihcKjWUGfTxEZQ/0b6gBufDKuXE0V2Te37vSXlM2r3OoXxeQF/mQqvv/rB20X8DH4MFo
         urM7v5sxGotVcS77Y4CweXf6bphGn1MD6ASAgKDHMMeAq2DQcLQl3rkrB86Sg/j/X3sZ
         b4Yf4A8roP39Cvj31BpRMC8vUcHWJpjoqsc5Ll7VA+MBppGq03Cicr0r8lPZf6HTFawz
         wG6w==
X-Gm-Message-State: AOJu0Yw0OnpXT1+/+y8z2aGtIyzUdAUfZF+2xvCz7WO3MHbzkFz+wV+e
	+UMt9wlPfw7AhPrsFsDHqkuD2YB6iS+h/NmP1zNsoadrjHuIwrbW4YHeVsc2vrA=
X-Google-Smtp-Source: AGHT+IHerr2CNFXSws+9oBTQ1tIV+44SZX35ntb27kGhJN1L9duM9t4b3FiH8V5NKy3Yk6hWqepjXw==
X-Received: by 2002:a2e:7c07:0:b0:2cf:425b:59ee with SMTP id x7-20020a2e7c07000000b002cf425b59eemr389756ljc.24.1707159722038;
        Mon, 05 Feb 2024 11:02:02 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVcIYZUzWXNPe+XZYc2Z0KZG6GhW1LuluhaOzBv2XMMn4xg8oWZ1HePY85qWcd1aAl+zZh9qdSkVkVwP7RCtaMHfxRi++WK+plrBLPs1BtwxF6gt3B5rFlhCqxzOunA4M2I+DIgzbzTvms8wsz26wWuXiA4eT/ghls8DibnNiboj2WgZbICOR8G
Received: from loic-ThinkPad-T470p.. (74.212-33-141.static.xfiber.net. [212.33.141.74])
        by smtp.gmail.com with ESMTPSA id y11-20020a2e320b000000b002d085fdb893sm41293ljy.31.2024.02.05.11.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 11:02:01 -0800 (PST)
From: Loic Poulain <loic.poulain@linaro.org>
To: rafael@kernel.org,
	len.brown@intel.com,
	pavel@ucw.cz
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Loic Poulain <loic.poulain@linaro.org>
Subject: [RESEND PATCH] PM: hibernate: Request 0 CPU latency during image decompression
Date: Mon,  5 Feb 2024 20:01:57 +0100
Message-Id: <20240205190157.50278-1-loic.poulain@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The (SMP) load_image_lzo procedure relies on multiple threads and
their synchronization for decompressing the hibernate image. for
performance reasons, it is important to keep the CPUs responsive
so that the synchronization overhead stays minimal. This overhead
roughly corresponds to thread wakeup latency, which is linked to
the CPU idle exit time.

By requesting 0 CPU latency, we prevent CPUs to enter their deepest
idle states, ensuring that they will be as responsive as possible
during the whole decompression procedure, and by extension improve
the hibernate resume time (CPU dependent).

On iMX8M mini SoC, that gives a ~40% boost for the decompression time:
PM: hibernation: Read 365640 kbytes in 1.88 seconds (194.48 MB/s)
vs
PM: hibernation: Read 363476 kbytes in 1.26 seconds (288.47 MB/s)

Note: 40% diff sounds huge, and may point to iMX specific cpuidle
issue. Anyhow, we know that during this bottleneck procedure, the CPUs
will be fully dedicated to the decompress task, and must be kept ready
for it.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 kernel/power/swap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index f6ebcd00c410..d2cd53497c4e 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -22,6 +22,7 @@
 #include <linux/swap.h>
 #include <linux/swapops.h>
 #include <linux/pm.h>
+#include <linux/pm_qos.h>
 #include <linux/slab.h>
 #include <linux/lzo.h>
 #include <linux/vmalloc.h>
@@ -1180,6 +1181,7 @@ static int load_image_lzo(struct swap_map_handle *handle,
 	unsigned char **page = NULL;
 	struct dec_data *data = NULL;
 	struct crc_data *crc = NULL;
+	struct pm_qos_request qos;
 
 	hib_init_batch(&hb);
 
@@ -1190,6 +1192,8 @@ static int load_image_lzo(struct swap_map_handle *handle,
 	nr_threads = num_online_cpus() - 1;
 	nr_threads = clamp_val(nr_threads, 1, LZO_THREADS);
 
+	cpu_latency_qos_add_request(&qos, 0);
+
 	page = vmalloc(array_size(LZO_MAX_RD_PAGES, sizeof(*page)));
 	if (!page) {
 		pr_err("Failed to allocate LZO page\n");
@@ -1470,6 +1474,8 @@ static int load_image_lzo(struct swap_map_handle *handle,
 	}
 	vfree(page);
 
+	cpu_latency_qos_remove_request(&qos);
+
 	return ret;
 }
 
-- 
2.34.1


