Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372356C4B10
	for <lists+linux-pm@lfdr.de>; Wed, 22 Mar 2023 13:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjCVMtL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Mar 2023 08:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjCVMtH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Mar 2023 08:49:07 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB1412CDE
        for <linux-pm@vger.kernel.org>; Wed, 22 Mar 2023 05:48:53 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id cy23so72344281edb.12
        for <linux-pm@vger.kernel.org>; Wed, 22 Mar 2023 05:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1679489331;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fumu3JLKZhwp856FuysQVRkR+0TlueG1r5wPImZmw+I=;
        b=4PM18ToIRJTjDqK8A3zZ3oSydvcFQqxSYomaOYVN1iOD/8g+A7WZ2PPk2tQwKBJODD
         dpMbFH8IYI0TVoEQAWMb/0C9BrGWUfeXOii+eSaDG13lBGjOC9yMWabs2B8Yx37ezh40
         iXtCfHwEB0w2ls/Upq8ZD0aXN44SCZUjR9iU2jTR4RZ40FDzjaCy1RvVSmOH52OpC7iv
         PPztwZAmwbyyOF7fC/4/vIVKVMFd2EapBw/mflnqShvY3PnO0d44qyZj71L36z7NH7G/
         Q0IDmdXfyGEb52Neeby8RhOiWWs0xRscyoQw3Uap+zqUQWAKx0VyG5wSbzE8PtQYNgg5
         FDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679489331;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fumu3JLKZhwp856FuysQVRkR+0TlueG1r5wPImZmw+I=;
        b=g3uluku1lFUI+2P0ApiF39MmAA+Gl8nfc87XXAY5gdO+zUpisZITtHZyMkmMWheta/
         zNgLRsmAGxeQ2m+ERv7lWysW8LuG73DVZOkkVHZQvjQv0MFiLRjZH69Vi7QYYP7qmzNn
         a/SZntl8zEEKq1q/6izaBoXSbqFttPVe+cuyMoM62C8sDanYfBRkdm0wrHLI5V30DtWt
         0itmTwWwXeDtsrUyEOCHWB1241R61EFrgO3Qk37OCwBee4ECs5usxKBAow9beu8EePv5
         XPXG3rL6VdzZMKEbj7iQVzBqtDxtonB0YfMbKRFQUGjwvuRLVfuwfPF3y2mLQHf5+4A/
         Dz7Q==
X-Gm-Message-State: AO0yUKUjeXmIhvosi5giH7buN271nmr5iSiMUYuuIQX+WT8EeuZLeXng
        6rY5FNKMpJWBliteGDFCD8RfNQTBNr5GXlhZOqa3dw==
X-Google-Smtp-Source: AK7set9LmgImDdsZ2IHu8jkDjTSPdNbIHDaGmFo+ZWGyFz1m0ni6kr9LUjdRPKba16Kao34k2wkRn8v8a6CJ869D2tE=
X-Received: by 2002:a17:907:7d87:b0:931:f8b1:4474 with SMTP id
 oz7-20020a1709077d8700b00931f8b14474mr3172387ejc.2.1679489331471; Wed, 22 Mar
 2023 05:48:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230307163413.143334-1-bchihi@baylibre.com> <CAGXv+5E0wUJYUVD3wx3-=uES612ARQmUE0rxgAruFHxpZCBjzA@mail.gmail.com>
 <CAGuA+ooi7Kx05gagLzXAN3upDiSqDUNOM_djYdGftw6ogVx5gw@mail.gmail.com>
In-Reply-To: <CAGuA+ooi7Kx05gagLzXAN3upDiSqDUNOM_djYdGftw6ogVx5gw@mail.gmail.com>
From:   Balsam CHIHI <bchihi@baylibre.com>
Date:   Wed, 22 Mar 2023 13:48:15 +0100
Message-ID: <CAGuA+oqDPPYFJef_8=YrOpHQNVJ3xgm_zXS6fq_HG2Jy_6t-Zg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add LVTS support for mt8192
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Chen-Yu,

I suspect the bug comes from incorrect calibration data offsets for AP
Domain because you confirm that MCU Domain probe runs without issues.
Is it possible to test something for us to confirm this theory (i
don't have an mt8192 board on hand now), when you have the time of
course?
We would like to test AP Domain's calibration data offsets with a
working one, for example :

 static const struct lvts_ctrl_data mt8192_lvts_ap_data_ctrl[] = {
                {
-               .cal_offset = { 0x25, 0x28 },
+               .cal_offset = { 0x04, 0x04 },
                .lvts_sensor = {
                        { .dt_id = MT8192_AP_VPU0 },
                        { .dt_id = MT8192_AP_VPU1 }
@@ -1336,7 +1336,7 @@ static const struct lvts_ctrl_data
mt8192_lvts_ap_data_ctrl[] = {
                .hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8192,
        },
        {
-               .cal_offset = { 0x2e, 0x31 },
+               .cal_offset = { 0x04, 0x04 },
                .lvts_sensor = {
                        { .dt_id = MT8192_AP_GPU0 },
                        { .dt_id = MT8192_AP_GPU1 }
@@ -1346,7 +1346,7 @@ static const struct lvts_ctrl_data
mt8192_lvts_ap_data_ctrl[] = {
                .hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8192,
        },
        {
-               .cal_offset = { 0x37, 0x3a },
+               .cal_offset = { 0x04, 0x04 },
                .lvts_sensor = {
                        { .dt_id = MT8192_AP_INFRA },
                        { .dt_id = MT8192_AP_CAM },
@@ -1356,7 +1356,7 @@ static const struct lvts_ctrl_data
mt8192_lvts_ap_data_ctrl[] = {
                .hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8192,
        },
        {
-               .cal_offset = { 0x40, 0x43, 0x46 },
+               .cal_offset = { 0x04, 0x04, 0x04 },
                .lvts_sensor = {
                        { .dt_id = MT8192_AP_MD0 },
                        { .dt_id = MT8192_AP_MD1 },

This example is tested and works for mt8195,
(all sensors use the same calibration data offset for testing purposes).

Thank you in advance for your help.

Best regards,
Balsam
