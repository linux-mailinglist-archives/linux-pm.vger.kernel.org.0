Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F33679AA4
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jan 2023 14:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234769AbjAXNxv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Jan 2023 08:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234673AbjAXNx3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Jan 2023 08:53:29 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F0D48A33
        for <linux-pm@vger.kernel.org>; Tue, 24 Jan 2023 05:51:23 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id e19-20020a05600c439300b003db1cac0c1fso11379682wmn.5
        for <linux-pm@vger.kernel.org>; Tue, 24 Jan 2023 05:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GRHFm87xhd5kwGJXeGjCaI1s3MvLoDnYqaOChsF1PF4=;
        b=pcMpDVisDmB6BmL5C0d/5YIhuoNLTKnu81ssrjpVi0NxvZeV70feTYjhtHR4OR/Yyj
         AwPFghZLg62VGxxiOUpfY7NS1BPAt/GRPfoOKIRmx9ShUf23BuRt5P1BeJyVtxvdxcH6
         jxC2OAt0Vm7SvRJ3wiPKXkFfza17Jao1XQOTCyW1zV+ZVsTzyFPxCasrr7dmtJ8RpXPG
         J/knhYjAVj6EnNl8p+OYpANuWLsuF4BA07CAE3yMxmRXyKF8Gby4YOuu33Z4W4tuhm4o
         BAhKUwIe5/QnVmRVOaM17TTW5hPKXw0lDZuxZ6iaRVBaV+DuBhLIuAduTNIo14KKpXAq
         Wp8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GRHFm87xhd5kwGJXeGjCaI1s3MvLoDnYqaOChsF1PF4=;
        b=li29Ec6hoRjQol5KQtmlzs9yWbPbqnSDGm07H9HX/Sp9LUmDpd7CjbAhKmgFDXzpWu
         R2gN4b6L6/xhbGmYS3WeEmeL+x8phbcqMo9MxiQNZ4z3U6DXfPUlz7kQTyEg45Zhj78x
         7DXH9QTf+XFJHbmI2LV8yATmPoTLRzDmgOvoiyzqPL4NqoXw94GzypdPQ4508+ZOd87O
         9KwZSxtqyx3hI+N0d/GnvXCN0PgcLN9CvGHePBLuI9JnFt+kTzR+NqlDE5QqPUt3qlGA
         jXWfLreeWrbPcKlgDx36wKNYZZ2d/g6ohLB6Qw4/bROrJAV3i3JPDuZ/2VR2YUPe+9RT
         Pqxg==
X-Gm-Message-State: AFqh2kpthHoYlkGhvrxJnNKTAk05T31EhkY1uCXxSjAyhebkHIXM3gx8
        qXp/WaVMKSinO0tUh2/b36qh4QpSptDxaOZB
X-Google-Smtp-Source: AMrXdXspSwahLg1rfkDFtbVlcIe2CrdGVsZjEtpwfCh/Em01sMTR36gIlCx8fYTo8dsT5IjWqMeYXg==
X-Received: by 2002:a05:600c:5114:b0:3db:254e:59a9 with SMTP id o20-20020a05600c511400b003db254e59a9mr19030478wms.15.1674568238494;
        Tue, 24 Jan 2023 05:50:38 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id j4-20020a05600c42c400b003db1ca20170sm1972507wme.37.2023.01.24.05.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 05:50:38 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE)
Subject: [PATCH 3/3] thermal/drivers/imx: USe get_crit_temp() API instead of manual check
Date:   Tue, 24 Jan 2023 14:50:23 +0100
Message-Id: <20230124135024.366486-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230124135024.366486-1-daniel.lezcano@linaro.org>
References: <20230124135024.366486-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The thermal framework is reworked to use a generic trip point
description. That will consolidate the code and will allow to fix a
mishandling of the trip points crossed events.

In order self-encapsulate the thermal framework and prevent assumption
about the indexes we remove the trip id usage in the back end drivers.

As the i.MX driver is using the thermal trip generic structure, we can
rely on the thermal framework to get the critical temperature instead
of using the harcoded IMX_TRIP_CRITICAL index.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/imx_thermal.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index c115a696e83f..10ebf42f4915 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -337,7 +337,7 @@ static int imx_set_trip_temp(struct thermal_zone_device *tz, int trip_id,
 {
 	struct imx_thermal_data *data = tz->devdata;
 	struct thermal_trip trip;
-	int ret;
+	int crit_temp, ret;
 
 	ret = pm_runtime_resume_and_get(data->dev);
 	if (ret < 0)
@@ -347,12 +347,16 @@ static int imx_set_trip_temp(struct thermal_zone_device *tz, int trip_id,
 	if (ret)
 		return ret;
 
+	if (temp < 0)
+		return -EINVAL;
+
 	/* do not allow changing critical threshold */
 	if (trip.type == THERMAL_TRIP_CRITICAL)
 		return -EPERM;
-	
+
 	/* do not allow passive to be set higher than critical */
-	if (temp < 0 || temp > trips[IMX_TRIP_CRITICAL].temperature)
+	ret = thermal_zone_get_crit_temp(tz, &crit_temp);
+	if (!ret && (crit_temp < temp))
 		return -EINVAL;
 
 	imx_set_alarm_temp(data, temp);
-- 
2.34.1

