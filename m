Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2977E6B0E16
	for <lists+linux-pm@lfdr.de>; Wed,  8 Mar 2023 17:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbjCHQEP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Mar 2023 11:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbjCHQDw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Mar 2023 11:03:52 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2015E5DC98
        for <linux-pm@vger.kernel.org>; Wed,  8 Mar 2023 08:02:04 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id o12so67652756edb.9
        for <linux-pm@vger.kernel.org>; Wed, 08 Mar 2023 08:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678291317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HvghSm+izAzoZfMW7sPseegOBllvRQAJZKazD98Q5ek=;
        b=f3GHy9XwNtZAVyNU/gw7bH0xY9mv5hj6I/KXK5IsVgFchFE6xqpHD4ttjk/YveOWnD
         +niOXVxlamUfbWhNqCuIUQb9+leO9ykdzXnWpaL0OCN6Ak36qveLZhTO/ECbbqwg6qws
         9v7AhZLaWcht3nvCscEKcAKmu00AGiDlj35POr9ssy8/AnRm9g3+YWR1eAVnH4CqFBr0
         5hgH2QDyBv9q4LVqM4Hje6dmSgFi0BbrPmRD3gymEF3VbbWqIJPwaCfQMw/G51O+9XIi
         /UUQ8UgxBME4CQXoTcZG+GCWSUrUacmppusRzIpdtDqbPxgYWMf93RgN8EbgZ7WPAMv4
         DHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678291317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HvghSm+izAzoZfMW7sPseegOBllvRQAJZKazD98Q5ek=;
        b=2zitN/ULNdOD0m5urhWx1VXRGSX4nAvqXnSdsqjSvXfFDYQcDb1or5nAdBOVZfmQn8
         pBjHGTivsuKq86clTuzrjPhK/s3xxx4VSthrqnv0eC24CEgwLP0lSQ61A4cMq6v39upZ
         HlFhLF8Z0mRGBwudrP+m/wzqEfHeBYFpDbdFw6lkCW7AGJ63dG0es+iyKRCjjGGme/Q0
         7gNcmqle/AEqOsdZ2WtIGkK8eSOKMkoJMwtWDflSOtv35FRVBA7WzfReeCkzD8Pdx6An
         McCM6I4fLnkZGRG7NNH/HDrFi6pH0tB/EUa0+DLQcuoMSr46pX2pEOByyuj7BdN1OAhz
         IH5Q==
X-Gm-Message-State: AO0yUKUT+djhAUrNkpSOBs71t7Q5dp+9EXa6a6AhArMCXCR/PaFSxKtI
        TqCwuiRvrnu1mCBxF3rbGlbvXQNZYJSWDJxLuZCCDw==
X-Google-Smtp-Source: AK7set9czStAcUNQ29jUhnUVYnTaY/lCYjixN6pRCnxEte8YUnfIYJlN08SvDepMIhgpwQmcnVtlX42y0dTAE4mfCYM=
X-Received: by 2002:a17:906:a0d8:b0:88d:f759:15b1 with SMTP id
 bh24-20020a170906a0d800b0088df75915b1mr9362342ejb.13.1678291316969; Wed, 08
 Mar 2023 08:01:56 -0800 (PST)
MIME-Version: 1.0
References: <20230307154524.118541-1-bchihi@baylibre.com> <20230307154524.118541-5-bchihi@baylibre.com>
 <5f980c7d-1bc4-cfdf-9392-70626317ca54@collabora.com>
In-Reply-To: <5f980c7d-1bc4-cfdf-9392-70626317ca54@collabora.com>
From:   Balsam CHIHI <bchihi@baylibre.com>
Date:   Wed, 8 Mar 2023 17:01:21 +0100
Message-ID: <CAGuA+oqEG-grekf=x6c7XwvbaAjgDDF1FJ=E+6zYLx8J2B+QJw@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: dts: mediatek: mt8195: Add AP domain
 temperature thresholds
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Mar 8, 2023 at 10:17=E2=80=AFAM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 07/03/23 16:45, bchihi@baylibre.com ha scritto:
> > From: Balsam CHIHI <bchihi@baylibre.com>
> >
> > Specify the targeted temperature thresholds.
>
> You're introducing the thermal zones and *then* fixing them in this commi=
t.
> To be honest, this doesn't make a lot of sense...
>
> Please squash this commit with
> arm64: dts: mediatek: mt8195: Add AP domain thermal zones
>
> P.S.: After squashing.. looks good.

Hi Angelo,

Thanks again for the review.
OK, I will squash them in the new series.

Best regards,
Balsam

>
> Thanks,
> Angelo
>
