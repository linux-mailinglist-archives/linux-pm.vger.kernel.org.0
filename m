Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A4467B567
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jan 2023 16:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235701AbjAYPGn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Jan 2023 10:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234565AbjAYPGm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Jan 2023 10:06:42 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD07CDD9
        for <linux-pm@vger.kernel.org>; Wed, 25 Jan 2023 07:06:41 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id vw16so48406809ejc.12
        for <linux-pm@vger.kernel.org>; Wed, 25 Jan 2023 07:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hZ+XWT7x3GIrVuC5smdu5kaGnAEgwF0jVXjRtih1Jog=;
        b=cH3hA1DNTFYYXcYv2dYsdfs/F0a4Fo0x393HAZwW7sg2/ZjfnFAD1GtMUOqjWL6CnP
         ZvzRjkIG0subDN66xQFmo5RPvHMO3JcQFlvxD4ONkyFtfwzAB0ttmle/4y/TihRmks2S
         QXEXCp8Wf6YgFDGr3UNW6Zg1acdhVDLA6TZFsp2afNANCN/FBWcfLjqRBqIzEzy0hs2+
         Iu7AQIKZKCjwH1r3tr76JeJWLqDPeFtDwhkwh4CwUKs4fBH3dkJgQS9oXUFzIuRCTvAV
         wz10ylaivnJCsis/1BoziUFwpkgIXGHitA8M5eSFjzZ2tVIZ5zMWatWzwaCmwmELkutj
         aVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hZ+XWT7x3GIrVuC5smdu5kaGnAEgwF0jVXjRtih1Jog=;
        b=rfAcXheJkhDpuocYbRDepCVQLZdr4fL9Ird3M+ws2Xf25BqOP1rmpuWFh65wE0DIYW
         ZOxAFs9fUPodZFzFf+1ZdTm2vz274uOc6DCs8evapaZFiVH4WHL/uZKk3q7oefzJgED8
         PPEDTFbzaSlzBskAZ82JuPwM1eNn/fIPM+cRV+Q+F/hgQktP5m9LgwGFO0WipDXRsv44
         EByJoFEo1q0ZJGPRUHPLXvAIZtW6zicnn60AZ8Np1cfYgKSMzDUHtEByPekDtyBLw9PN
         9KdtIT1ybwpCkgxT2NASfxqLAZ2h1JtxyEbXkf60f+l7gnHisJchMsiD1I1dk8KF/1Ua
         tAyA==
X-Gm-Message-State: AFqh2kpCtrqG9WxwcU6ijiZl/WaM+Utd6LpHMBChhmKrw1+BfRDTHgXa
        IAGVhdgG7pVeZ2fERCjLdDcwsFFqmWQjKDl6dxR4jQ==
X-Google-Smtp-Source: AMrXdXvqJOlDJST3w87/gr/ZwRFOMtImwLKSDqGCZTr2eYhDs7UWmBPmEUcE54nfAXRo5cLYHmUUvd9VLSwpRS2TOrc=
X-Received: by 2002:a17:907:c243:b0:7c0:e391:c548 with SMTP id
 tj3-20020a170907c24300b007c0e391c548mr5314680ejc.18.1674659200062; Wed, 25
 Jan 2023 07:06:40 -0800 (PST)
MIME-Version: 1.0
References: <20230124131717.128660-1-bchihi@baylibre.com> <20230124131717.128660-5-bchihi@baylibre.com>
 <5dd5c795-5e67-146d-7132-30fc90171d4c@collabora.com>
In-Reply-To: <5dd5c795-5e67-146d-7132-30fc90171d4c@collabora.com>
From:   Balsam CHIHI <bchihi@baylibre.com>
Date:   Wed, 25 Jan 2023 16:06:04 +0100
Message-ID: <CAGuA+oo6dV=Vs69PMPSpBSdqDa2ESHjiTzrH_ZYAyUgVmq9HJw@mail.gmail.com>
Subject: Re: [PATCH v11 4/6] thermal/drivers/mediatek: Add the Low Voltage
 Thermal Sensor driver
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     daniel.lezcano@linaro.org, rafael@kernel.org, amitk@kernel.org,
        rui.zhang@intel.com, matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jan 24, 2023 at 4:31 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 24/01/23 14:17, bchihi@baylibre.com ha scritto:
> > From: Balsam CHIHI <bchihi@baylibre.com>
> >
> > The Low Voltage Thermal Sensor (LVTS) is a multiple sensors, multi
> > controllers contained in a thermal domain.
> >
> > A thermal domains can be the MCU or the AP.
> >
> > Each thermal domains contain up to seven controllers, each thermal
> > controller handle up to four thermal sensors.
> >
> > The LVTS has two Finite State Machines (FSM), one to handle the
> > functionin temperatures range like hot or cold temperature and another
> > one to handle monitoring trip point. The FSM notifies via interrupts
> > when a trip point is crossed.
> >
> > The interrupt is managed at the thermal controller level, so when an
> > interrupt occurs, the driver has to find out which sensor triggered
> > such an interrupt.
> >
> > The sampling of the thermal can be filtered or immediate. For the
> > former, the LVTS measures several points and applies a low pass
> > filter.
> >
> > Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>
> On MT8195 Tomato Chromebook:
> Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Hi Angelo,

Thank you for reviewing and testing it.

Best regards,
Balsam
