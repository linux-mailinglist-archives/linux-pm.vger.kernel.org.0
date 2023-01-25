Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A602067B59D
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jan 2023 16:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235999AbjAYPMA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Jan 2023 10:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236011AbjAYPL4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Jan 2023 10:11:56 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F54559B59
        for <linux-pm@vger.kernel.org>; Wed, 25 Jan 2023 07:11:33 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id x36so22058911ede.13
        for <linux-pm@vger.kernel.org>; Wed, 25 Jan 2023 07:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MK9Ce7LoyUpoHVdDI0Q6deRxLh9svgL/G7RdzcTDYaQ=;
        b=LySUeIdtlIdpu5P4Kgo82re6kq4R6LXSHS8u8/LBIhHqCR82KIlhMlw5ymVaJpi70D
         S+3hcT5ACjyUAC7ydHn+LbSTc8PYmMxWqbMHJOJZd09rbrTyxpGMKOy/FJ6TwGwawUO3
         3gdBQg8cwgg+i7TwUr30ShHh8R9d3/c0tKmRTdBQ3UNP3FI2MQc0vwPloZMwM7C0R/y8
         QDY+Cmg+3Jvoa6OPYSJdPzf1T8dI0MVldCHrlCW3jW0UvO506xUDHdLpqow7PADPcDLJ
         a1uw6AJqUjW6Lqqxn0rDd+ilQCOzzhdDNxNQToiQPzqKUvFVHZQE1xQZ6FTnKxmmWNUi
         ZdnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MK9Ce7LoyUpoHVdDI0Q6deRxLh9svgL/G7RdzcTDYaQ=;
        b=Vrk0cCBBcSviePJErbSazjJP8cZ4E7rCqq4xJb7xZPacLjk+JKLuvP4XymFuKlzKbl
         RUpkacITotk99krte9efwowmVLVV1UkENQEfY+U8di74RuPk7e4/qn2+37jRGMYOgqCF
         7H36rNwmACt9ywx4nUom9hn4Vhi2aWp4/lLN/orBNiyuVv6gv1JIBjpxlUsPiG1s8DXd
         Yo3IFW5M8HM0HAbPMOuIZe41z+VsioNlX95D2raZ9g0J3kmFI0b00nH4Qfnwiu6gJ4FD
         pwm7G7zO6u+AL4jTDcOPAtf6H5YtP0JeyQiwzfO9p6esiu/zfKGNsFARAmdZW4Q8Z+QS
         hR5A==
X-Gm-Message-State: AO0yUKUo9hwi7JEQmnkG3k7SDTrdcHWdIFyoRCtoDKAX3zU3SSn+hv/9
        Q194TiBjcfOe+RFXJtw4s/4/gWxofJF7IbrCx2YIwQ==
X-Google-Smtp-Source: AK7set+/d6h1+icdov+3bpJCPxwXk9ybBiTH6QptRDsERwtuuR1OBU2F9WB1DSqGNVJB0APKd2JKhc35tLg6EYBsWtg=
X-Received: by 2002:a05:6402:d59:b0:4a0:90da:4653 with SMTP id
 ec25-20020a0564020d5900b004a090da4653mr768644edb.153.1674659489645; Wed, 25
 Jan 2023 07:11:29 -0800 (PST)
MIME-Version: 1.0
References: <20230124131717.128660-1-bchihi@baylibre.com> <20230124131717.128660-6-bchihi@baylibre.com>
 <80ce4ea3-6ebd-c249-45bd-a2f04343690b@collabora.com>
In-Reply-To: <80ce4ea3-6ebd-c249-45bd-a2f04343690b@collabora.com>
From:   Balsam CHIHI <bchihi@baylibre.com>
Date:   Wed, 25 Jan 2023 16:10:53 +0100
Message-ID: <CAGuA+opCcdbPbasadEFbKw1nSy-kbK3WzKG=wXn6dtzynjrY1Q@mail.gmail.com>
Subject: Re: [PATCH v11 5/6] arm64/dts/mt8195: Add thermal zones and thermal nodes
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
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
> > Add thermal zones and thermal nodes for the mt8195.
> >
> > Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
>
> You should change the commit title to reflect the same syntax that you can find
> in a `git log --oneline arch/arm64/boot/dts/mediatek/`.
>
> arm64: dts: mediatek: mt8195: Add thermal zones and thermal nodes
>
> or
>
> arm64: dts: mt8195: Add thermal zones and thermal nodes
>

Hi Angelo,

Thank you for the review.
Should I resend with the fix?
Or you would fix it when applying it like Matthias did for "[PATCH v11
3/6] arm64/dts/mt8195: Add efuse node to mt8195"?

Best regards,
Balsam

>
> ...otherwise:
>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>
