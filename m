Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC773798D6
	for <lists+linux-pm@lfdr.de>; Mon, 10 May 2021 23:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbhEJVM6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 May 2021 17:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbhEJVM4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 May 2021 17:12:56 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E12C06175F;
        Mon, 10 May 2021 14:11:51 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2so25475060lft.4;
        Mon, 10 May 2021 14:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a9iK163fq+2JSJvqMOtwOLKwobF36F5yzS2cbjuGjYA=;
        b=cCU2cSOiIrhB+EKiDwvIRI8PvAMjNBVJBt2Eg6K8nOXI3q5Dz6clwdk5O1ldg082Cz
         goOLkpUquBMpsyfx4CMedsJPbQ1xbr06Q0Fi0qS/ByOkrMcSShfhe/iNsYn0jH7XaXDc
         W6jeo3+oo1O7QFysmS8DX+f8Now6cTWgQGshkG2KBBh8wfKTe3TKVht0ssVjuTJ2gs3R
         k4bSquhf3Yw29Lv0kvG1NX/Kal6109UEumTesmYYX0j3oPLar/3D8Iky75cSJRaDevu+
         HL/1JUhKcGTbB0si+20GMUvIRPe9MN2f/ND4NSjTlzvHRYBNJe75R0bXd14mk3Tdf+6T
         4fOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a9iK163fq+2JSJvqMOtwOLKwobF36F5yzS2cbjuGjYA=;
        b=q9EHSxP5jX48ucGbzTB+TA/pm/6Hll8s3D4PY/W5QBYhDgTb7NFr2iKrCHRoJP7z6e
         V+heokWddQN48vdjU1vozpaBDcGr132IfWlh+64PQsbZaNITYV9Dk5W59jKEvINs2Hca
         E7yHDF/pLGOT+XuPfDBAjXvvh0+nqMJ/WlYziX3i6s86tZvB3CtzJ9OfQTJcmDru+PST
         vgAalM2GGV2rUODYTZN6f9pdclxSDg6mLu9JA7pUWaE/cZBxIh+wg0pUHD466qrGB1Ry
         OKWaZRHjhmZYYeku05AfHU+U1vr0Uoe+x85N0+FSUZCVPy3vmvT8fVPdToaJhGX/Ut9C
         mv+w==
X-Gm-Message-State: AOAM531BbjDAwf1QKfiGxGQD4Cmw1uQVT9JdztUz/B8SrroKkH4v/24s
        CKSTJRcI3UzaL6wz6AiPtqM=
X-Google-Smtp-Source: ABdhPJwcZdEZN1IinsTRa0g1x6zV4KMCiakmHwskkRj4UYHBpU1c3Bsa5kVMold8xXPu7F9MZZxwIA==
X-Received: by 2002:a19:ca11:: with SMTP id a17mr17634572lfg.271.1620681109820;
        Mon, 10 May 2021 14:11:49 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-91.dynamic.spd-mgts.ru. [109.252.193.91])
        by smtp.gmail.com with ESMTPSA id x4sm2365339lfa.173.2021.05.10.14.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 14:11:49 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v1 1/7] PM / devfreq: tegra30: Support thermal cooling
Date:   Tue, 11 May 2021 00:10:02 +0300
Message-Id: <20210510211008.30300-2-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210510211008.30300-1-digetx@gmail.com>
References: <20210510211008.30300-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Expose ACTMON devfreq device as a cooling device in order to throttle
memory freq on overheat. Throttling of memory freq has a significant
cooling effect on NVIDIA Tegra SoCs since higher memory freqs require
higher SoC core voltage which is one of the main causes of the heating.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index ce83f883ca65..10661eb2aed8 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -688,6 +688,7 @@ static struct devfreq_dev_profile tegra_devfreq_profile = {
 	.polling_ms	= ACTMON_SAMPLING_PERIOD,
 	.target		= tegra_devfreq_target,
 	.get_dev_status	= tegra_devfreq_get_dev_status,
+	.is_cooling_device = true,
 };
 
 static int tegra_governor_get_target(struct devfreq *devfreq,
-- 
2.30.2

