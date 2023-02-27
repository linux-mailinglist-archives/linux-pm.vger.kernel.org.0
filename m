Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62ED96A4089
	for <lists+linux-pm@lfdr.de>; Mon, 27 Feb 2023 12:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjB0L0m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Feb 2023 06:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjB0L0l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Feb 2023 06:26:41 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB2A1E5D1
        for <linux-pm@vger.kernel.org>; Mon, 27 Feb 2023 03:26:40 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id p26so3989279wmc.4
        for <linux-pm@vger.kernel.org>; Mon, 27 Feb 2023 03:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uJkhkcyw+YCo652cbJy90MfhJa/odF41bwjtMLAeNIk=;
        b=I8DJ4R4mY3qM6LJfuoOc5sWEglN86Bn6qN7fE5U3snRukx66IsbHq0xHzEZhZAz2eh
         AjHjJmx3SNfdzoX99c35EDO9sIU9CDnP8ltFRn2S4VI459gg7AC6MbE6ThEgrx/TXdge
         rVEgCvfb3nxIa7zLRHZmy0AlNmoRpK0sv+wErKVmbtPDd28lYcrSGPiZOfoptxX2Vbow
         E+j4Xzc/9mJPnyn65Km/aaz3XpJSdy2JSd6IqQv+kmiaZoKMGjz955v4BE8fxpoqmAKJ
         KNztNYTVFuEgWMSuVFJ3dT7JUQvqxYwSW0xrmOVOw0L4rBHDzZQNNKaApOlkU1Ngk7jL
         Shcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uJkhkcyw+YCo652cbJy90MfhJa/odF41bwjtMLAeNIk=;
        b=GZ8w6cxlEWOMPtfsiz3INVq+5p0ZcqWbOd+BTqTJmOIeG8nl4dnyFLJEWjhR8Phi3e
         k9yCrHJKfkaqaXsQ3tOQStuvj0IA2lv30JKWwHeRDzditVFMu0cUjai0aDeLSiVPX6MC
         p5PUJmhf/onLiy3zfNYZSpGvenfsKCi88DberzYoUVRRJiLOm3LwtLEAYpYu8oQzciiq
         RCtY5RUULHjzTKPr2ggG1kkP3EN7Rx4Y+aN8/3P8gKDwAJbDuPWDoHhql/rM4URpFYSV
         Qd7AP4QqoEupIDRXkcZJNaXSNz49pbDW4ICIHdT1xVFblymyETTIDQ+D+VFevhCJJvO1
         rJdA==
X-Gm-Message-State: AO0yUKXUw6TF/n75ziVe+1p2brJt6EdjxiIeYBoDiYOYM+uX3XwSE4c9
        scACgp7mzJru05TnxV+yuMLUYz26ljN9Dw==
X-Google-Smtp-Source: AK7set8JaGUU/ejyFbK8vANqItq8nP5VI5XJzamLuDLbt0B8Gg7MjSYEzUbAHgIk13cwKIwS0QjM5Q==
X-Received: by 2002:a05:600c:3512:b0:3df:9858:c02e with SMTP id h18-20020a05600c351200b003df9858c02emr6311165wmq.3.1677497198575;
        Mon, 27 Feb 2023 03:26:38 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id u6-20020a05600c00c600b003e21dcccf9fsm12084392wmm.16.2023.02.27.03.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 03:26:38 -0800 (PST)
Date:   Mon, 27 Feb 2023 14:26:33 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     bchihi@baylibre.com
Cc:     linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [bug report] thermal/drivers/mediatek: Add the Low Voltage Thermal
 Sensor driver
Message-ID: <Y/yTacHF8TvAkxdj@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Balsam CHIHI,

The patch f5f633b18234: "thermal/drivers/mediatek: Add the Low
Voltage Thermal Sensor driver" from Feb 9, 2023, leads to the
following Smatch static checker warning:

	drivers/thermal/mediatek/lvts_thermal.c:562 lvts_calibration_init()
	warn: not copying enough bytes for '&lvts_ctrl->calibration[i]' (4 vs 2 bytes)

drivers/thermal/mediatek/lvts_thermal.c
    555 static int lvts_calibration_init(struct device *dev, struct lvts_ctrl *lvts_ctrl,
    556                                         const struct lvts_ctrl_data *lvts_ctrl_data,
    557                                         u8 *efuse_calibration)
    558 {
    559         int i;
    560 
    561         for (i = 0; i < lvts_ctrl_data->num_lvts_sensor; i++)
--> 562                 memcpy(&lvts_ctrl->calibration[i],
    563                        efuse_calibration + lvts_ctrl_data->cal_offset[i], 2);
                                                                                  ^
This is copying an array of known ints to a u32 array.  It should copy
sizeof(int) instead of 2.  It only works because the data you're on
little endian and the data is small.

    564 
    565         return 0;
    566 }

regards,
dan carpenter
