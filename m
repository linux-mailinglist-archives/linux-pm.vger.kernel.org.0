Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE5D67B558
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jan 2023 16:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235569AbjAYPCs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Jan 2023 10:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235341AbjAYPCq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Jan 2023 10:02:46 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A255C2134
        for <linux-pm@vger.kernel.org>; Wed, 25 Jan 2023 07:02:43 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id os24so4657050ejb.8
        for <linux-pm@vger.kernel.org>; Wed, 25 Jan 2023 07:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wapkp7jQNP7w6mlbVx+sKZqdo7KAYoZ0tdxTdIM62U8=;
        b=KbVn7SnwqKkdU0hL+9SxfPG2WxS+0BbpGxfl3RWlHmlfbNdf941qxSilRdh6RnKCUg
         Xs5/nLQzVApVZw6Zl/6Jk5IrpXtUXDk3BvzfGJuTMWFNFMCJFstg2aRWHINkjY5C85TG
         YYgCL4WvvksBn7jr57XAED/uOGUpUUo2Deqjz2NKnYfj8btdEl7shc0BQnJ23AP0O27Y
         6oXjZSMKLcSgPkH+vzw8h12sNj4PtVTma2MQxGf/XOS9L8RVh1QKx4IHRPsxxuuAruw2
         bCXNioSELe6CTXRFM9gNNfLJTg8k9cxIT2G74qfmnVSm2teFg+lREseplhfZMBK/Y1Hr
         Bmyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wapkp7jQNP7w6mlbVx+sKZqdo7KAYoZ0tdxTdIM62U8=;
        b=Pt2NUAkRRBsTYk9rYfY2GEY+sU/ofoS9S/LN5/iIt10/WUjkbZpExSWB8ROQxScplA
         PMyma48OsKvPvWeYd05nDogPOrWgq8iDmTMGLwJ1oygzjeqpkYiVGx0guPkQxW4dz3JC
         OacQX5+pub2MqBExCkIDaYESyh8qS2jV2kEK0Vapomtl/PoORiN7OYmYBYBYKyN75W4q
         N19VMcd8TVU9p0vev/AqxxTizI5fWJ0/yn6zsY7e0xxCsos659P2nf0mD4Ba6MqGpoMO
         XICcwLSSxlaVXV2oYj6AdGZPBOLDN6CsKjxgi4EwPULPJmOkic5TpBdAZJUctOKYcJWZ
         6M/A==
X-Gm-Message-State: AFqh2kqofGcQ4/91YtsggSOjAGI+aQcZMRf/xl3UZMy7/K27Cy+YcAVJ
        6fFE+NZyHCPYA1r2VWd2xgHVstDho0IwOXWn0oWMrA==
X-Google-Smtp-Source: AMrXdXs2eqPlIq51Dl1jYiUSg01kC0cn8kaqWKVFw9WGWQZwi/uHjvKD6XF5gIiXDW/HAlyKlCaek/h/NMBZaQfBM6s=
X-Received: by 2002:a17:906:71d0:b0:86e:40e4:9d8e with SMTP id
 i16-20020a17090671d000b0086e40e49d8emr2871902ejk.352.1674658962151; Wed, 25
 Jan 2023 07:02:42 -0800 (PST)
MIME-Version: 1.0
References: <20230124131717.128660-1-bchihi@baylibre.com> <20230124131717.128660-2-bchihi@baylibre.com>
 <976628a6-58c8-3298-3777-97aaddf53bc1@collabora.com>
In-Reply-To: <976628a6-58c8-3298-3777-97aaddf53bc1@collabora.com>
From:   Balsam CHIHI <bchihi@baylibre.com>
Date:   Wed, 25 Jan 2023 16:02:06 +0100
Message-ID: <CAGuA+orL4QPFic0vaKSqm5mQNkCT6=CuNxCfRuUutarP0sCJog@mail.gmail.com>
Subject: Re: [PATCH v11 1/6] thermal/drivers/mediatek: Relocate driver to
 mediatek folder
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

On Tue, Jan 24, 2023 at 4:37 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 24/01/23 14:17, bchihi@baylibre.com ha scritto:
> > From: Balsam CHIHI <bchihi@baylibre.com>
> >
> > Add MediaTek proprietary folder to upstream more thermal zone and cooler
> > drivers, relocate the original thermal controller driver to it, and rename it
> > as "auxadc_thermal.c" to show its purpose more clearly.
> >
> > Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
>

Hi Angelo,

Thank you.

Best regards,
Balsam

> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>
>
