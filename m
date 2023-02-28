Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED966A57CE
	for <lists+linux-pm@lfdr.de>; Tue, 28 Feb 2023 12:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjB1LXl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Feb 2023 06:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjB1LXf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Feb 2023 06:23:35 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C542A6F4
        for <linux-pm@vger.kernel.org>; Tue, 28 Feb 2023 03:23:15 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id fm20-20020a05600c0c1400b003ead37e6588so9229249wmb.5
        for <linux-pm@vger.kernel.org>; Tue, 28 Feb 2023 03:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677583394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8cRPoTQKkI6Vh2gx5bELOPsRnRzqaEtxSxLlrGiyoRc=;
        b=UTo1WZIhqmcN7wwdxDBuiP6Ftgr+rLh5SArLgTbxPKLwp5MOgvHozjAy8Ai4QkqCIM
         +aWGs5earODOd3p4flLKDkVaXo/AIwY/pi340K/DWcSJPQoXz/sDRCEAHH3Jk6I3riaf
         cu3Ps1D/MNc8KWplvUJ5lDHXS5K1katSy6g2pGWwZn82crh13WpZozVvDNn69OgudtbB
         zNhv/Iek36bGxNE25wdNREu4DLO4EVTex7JEj5oHWh8oskMHI0tUtgN3D+H+yBBzSCqq
         DDopp/fMXoyvAI2fxSVcwAIE2P09zMKanRy8aFQ4dTZyHeuPIQT5oy7lgHF9HzQrMLke
         RsZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677583394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8cRPoTQKkI6Vh2gx5bELOPsRnRzqaEtxSxLlrGiyoRc=;
        b=GR57rszBLnvDpFAVvnU/5hwDdxJfYozF6D1mSvzy5uVE0ZALqRHjlhS0TEP7NvUfhT
         TsCHmRWtH8k58bhTGcumyAoF5i62GpfNpVdcGFROrmhoEFlmpGvvPvUzs/prqCG//nDQ
         pCPIMTNd5O2blX5iAorCAsiGklOU4R8d6ILIgM39gJCykzfbF2a7oK5f/2bge8i4QRB5
         KPA7YeAEPbicKrRAzfPwfli3QZDNfAWd9Z1dZbjRpf0ertSjgpMlPC/TX2/IOsq4TQ2h
         Sww+0Y6lNAznlVUYhFpljsHNioVQDnAvv246nKPHxipQTumiun/5PHrucYImbvX9xDyl
         2O9Q==
X-Gm-Message-State: AO0yUKVvnC8xF4ZcXmrRRNi6SHI+hyqS2nQzAMwE3WmD1tRkRX0HYJnu
        DmtrW0WFNhTHn9h7Izt8TiRwTg==
X-Google-Smtp-Source: AK7set/0yxMlzYmuvcH9ovpFBKXTYSoiuW6ABvTKoHrFSNkPM7VhBM8Ld5f+rSTKBW/nMgpX53H6ww==
X-Received: by 2002:a05:600c:43d6:b0:3ea:f710:bdad with SMTP id f22-20020a05600c43d600b003eaf710bdadmr1863338wmn.29.1677583393866;
        Tue, 28 Feb 2023 03:23:13 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:6830:6390:2815:b6a5])
        by smtp.gmail.com with ESMTPSA id z5-20020a5d6545000000b002c5501a5803sm9598130wrv.65.2023.02.28.03.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 03:23:13 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v4 05/19] thermal/core: Show a debug message when get_temp() fails
Date:   Tue, 28 Feb 2023 12:22:24 +0100
Message-Id: <20230228112238.2312273-6-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230228112238.2312273-1-daniel.lezcano@linaro.org>
References: <20230228112238.2312273-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The different thermal drivers are showing an error in case the
get_temp() fails. Actually no traces should be displayed in the
backend ops but in the call site of this ops.

Furthermore, the message is often a dev_dbg message where the
tz->device is used, thus using the internal of the structure from the
driver.

Show a debug message if the thermal_zone_get_temp() fails to read the
sensor temperature, so code showing the message is factored out and
the tz->device accesss is in the scope of the thermal core framework.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_helpers.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index 0f648131b0b5..9558339f5633 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -107,6 +107,9 @@ int __thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
 			*temp = tz->emul_temperature;
 	}
 
+	if (ret)
+		dev_dbg(&tz->device, "Failed to get temperature: %d\n", ret);
+	
 	return ret;
 }
 
-- 
2.34.1

