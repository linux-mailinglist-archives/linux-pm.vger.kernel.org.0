Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9E85822A6
	for <lists+linux-pm@lfdr.de>; Wed, 27 Jul 2022 11:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbiG0JDd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Jul 2022 05:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbiG0JD3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Jul 2022 05:03:29 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13E8474C3
        for <linux-pm@vger.kernel.org>; Wed, 27 Jul 2022 02:03:28 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id y127so2163239yby.8
        for <linux-pm@vger.kernel.org>; Wed, 27 Jul 2022 02:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0UIfKvFvMqAxcJyxWvWpP/N9FWfFY7zfLwomngLyGZ8=;
        b=fIdO0pY7egrExHSgHak6Z2Inm4ATnzaAOly1bxMtw9tVoSwX7aM1VrAyPzybYMgYcf
         C9F1eKsW3h0FUA7cB2RuK3Ef2yeQDITdSMTuU6K0hEmw+IyJhSEiBp4hUgYFnNJc2MQ0
         wEEEby7mAchafqVQvXoUoUn2EKpF+QB7+L6qbkJwOoVJkBKffyc9MBGCT7Z8pCcrsM/F
         R/7vr9fzJzoiuCXkzRUiB70zyHowU6fOAlgZ7XU5XZA93uadMqQrV2YBkErcnalhu2xM
         9l0nbEe8kQmAdA1LCZRRAYXO0SSTT1Ye9onQOUALcHeMXWPKeYsBfrOYWfRvl+g5W3y6
         0rfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0UIfKvFvMqAxcJyxWvWpP/N9FWfFY7zfLwomngLyGZ8=;
        b=wX1yVqZqrZjEGo1dSOvlIr8udAe9QNZR5/mHGt9DqDmFG5TgBD4lPhddMz8yHMVA/3
         2F/XiZbkN36DubbiFTVzz31Ig4Rj+0qM2rhw3dsl8RHXHMSSL8qJazTpaLxGjaoBaRGG
         2TyGEWH1qwMVq6ig1K3l4/cvZmH1UGeVthMvU7WQ8e2pmLj4bbCm16MF6WNpc49W+vNY
         R5Yx0GWOap9sGZG4fowO72/PVat88fv+4+WNt2L3Hq3XUHfCn8Z7zc5NQPeiwJLO/xJ5
         9ZMoO7GtHH44kdo25GbjlQ4dVWO6PMo0ePwQ1A3M0no25xomunvvFUuUdNLrYBPicAup
         ySWQ==
X-Gm-Message-State: AJIora8U5NrHVniL/mxsbbRlcbbK2I2I3bpl0Hu/pIzp9iz2WZHl7Hlw
        l+86m/hixlmJxU0oFHS7/3AwSFXd5iKXPB6RjiGXhw==
X-Google-Smtp-Source: AGRyM1vtjVCiK7A2GDqW/KyubKNqjvhydU8MnJUwOvM8jWILa+8/+sx6a8efaxGE5fWIQcDhL9rRTzH6sIt9ENFqg9U=
X-Received: by 2002:a25:bb12:0:b0:66f:3c5f:dd9c with SMTP id
 z18-20020a25bb12000000b0066f3c5fdd9cmr15614585ybg.520.1658912607967; Wed, 27
 Jul 2022 02:03:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220726135506.485108-1-bchihi@baylibre.com> <20220726135506.485108-3-bchihi@baylibre.com>
 <35e9db62-4233-1804-0233-f048b149c22c@collabora.com>
In-Reply-To: <35e9db62-4233-1804-0233-f048b149c22c@collabora.com>
From:   Balsam CHIHI <bchihi@baylibre.com>
Date:   Wed, 27 Jul 2022 11:02:51 +0200
Message-ID: <CAGuA+oqkcmJGUuzraQzjjVO-w7_sSNiU5ZpAYN9nc_hsufkkHg@mail.gmail.com>
Subject: Re: [PATCH v8 2/6] dt-bindings: thermal: Add binding document for
 LVTS thermal controllers
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        mka@chromium.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        rex-bc.chen@mediatek.com, abailon@baylibre.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 27, 2022 at 10:17 AM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 26/07/22 15:55, Balsam CHIHI ha scritto:
> > This patch adds dt-binding documents for mt8192 and mt8195 thermal controllers.
> >
> > Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> > Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> > ---
> >   .../thermal/mediatek,mt8192-lvts.yaml         | 73 ++++++++++++++++++
> >   .../thermal/mediatek,mt8195-lvts.yaml         | 75 +++++++++++++++++++
> >   2 files changed, 148 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/thermal/mediatek,mt8192-lvts.yaml
> >   create mode 100644 Documentation/devicetree/bindings/thermal/mediatek,mt8195-lvts.yaml
> >
>
> Hello Balsam,
>
> I don't think that having two separated files is necessary (and I don't know if
> that's correct, even).
>
> You're referring to variants of the same hardware (and using the same driver, but
> that's not really relevant here), so my suggestion here is to have only one YAML,
> named like "mediatek,lvts-thermal.yaml", where we list all of the compatibles for
> both MT8192 and MT8195 (and future SoCs).
>
> Regards,
> Angelo
Hello AngeloGioacchino,

Thank you for the feedback.
Well received. I will resend ASAP.

Best regards,
Balsam.
