Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2882691AEC
	for <lists+linux-pm@lfdr.de>; Fri, 10 Feb 2023 10:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbjBJJK5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Feb 2023 04:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbjBJJKg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Feb 2023 04:10:36 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBFC55A7
        for <linux-pm@vger.kernel.org>; Fri, 10 Feb 2023 01:10:29 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id v13so4141257eda.11
        for <linux-pm@vger.kernel.org>; Fri, 10 Feb 2023 01:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JO1AgozF/Zya9WC0NgRmz45Iqf3MdEInH4N2K136jyM=;
        b=ZyFniiCCjmt9CvFd63F1Zj3IXNi4mNYXxXKEnzHLxPlFTMzNhXgAL3mcNuX5cYUWEW
         XLgUon3TpGuOxN5yFBKHZWe5rBLfxrjBjRkVxf8O9KheaOLF+XS9EoTuMNMEfPc1n0bG
         MDJvJGNT7D3w1/12SrGKArBX/1Vntjt1I19b1FyqOOW2athWYZaaYf/6UDVjWsYb0lTn
         YGVnI8UiVgl3HmOuryhDtX/pWrRHQJ9cfaT6GEsrsnD029W1HFFHZW9dhw34yvyh0u6u
         qEbrE6+qN40u0WDcfwsWEk26o50aD4BioUHqSaOaj+Aj7nKGSWgBi/xYTszNMgBq0sv1
         aJDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JO1AgozF/Zya9WC0NgRmz45Iqf3MdEInH4N2K136jyM=;
        b=6ltAas77KMrbCybVsv43Futk88xrqVkgMvjROrjnJpgN2kTSt00RAhN14ndOYAPK3T
         XTx5DgxFZr3nvYgYSlL7Z18YTR18cECe2JjtQRG3Tm5dTOGCgArpKQzWF9wQCzjBWDDU
         5DEBEEgcerl/4CuVaQQLEN5a4PDB0oYVepnsyEg0xBou/GXZkI+mH/z2xpTs3Dd7b+Ka
         C432BnSUoMT/rnOPQxjJ9+2ZpsTMk29N78pW05ddESKcgHPSLLnVJOL6R7fldwnXApWC
         rzZV4h42INmph64K+FeWEpChe0hvpEGHuyhvq4azBYgAaoq+VWDQRZe778UTWDwLt3jF
         XDZg==
X-Gm-Message-State: AO0yUKVeEt+cREjZ80Ct2Ul7ADV4i/Z3HLGQRUEDVBm0Eychcwm2zOzy
        FHV30ZRJESACGugY1itHMf8tnbORNJm8Mg0aJlZvcg==
X-Google-Smtp-Source: AK7set+IPEknsk8g/iIkwkkIan5htfnLkZaV7RhcstO9zjt8469/p979SjeKGgF3Upg96TNj1/y34dRtZXAYJDOE77o=
X-Received: by 2002:a50:d7c1:0:b0:4ab:2517:ca8 with SMTP id
 m1-20020a50d7c1000000b004ab25170ca8mr791593edj.7.1676020227744; Fri, 10 Feb
 2023 01:10:27 -0800 (PST)
MIME-Version: 1.0
References: <20230209105628.50294-1-bchihi@baylibre.com> <20230209105628.50294-3-bchihi@baylibre.com>
 <167596964747.647630.15058465615417584783.robh@kernel.org>
In-Reply-To: <167596964747.647630.15058465615417584783.robh@kernel.org>
From:   Balsam CHIHI <bchihi@baylibre.com>
Date:   Fri, 10 Feb 2023 10:09:52 +0100
Message-ID: <CAGuA+oqjQPQoJOzXdNxO+831noyGmiLcvzG1sGv6SFkr92XFCg@mail.gmail.com>
Subject: Re: [PATCH v14 2/6] dt-bindings: thermal: mediatek: Add LVTS thermal controllers
To:     Rob Herring <robh@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, khilman@baylibre.com,
        rdunlap@infradead.org, daniel.lezcano@linaro.org,
        devicetree@vger.kernel.org, p.zabel@pengutronix.de,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        james.lo@mediatek.com, rex-bc.chen@mediatek.com,
        linux-pm@vger.kernel.org, rafael@kernel.org, amitk@kernel.org,
        rui.zhang@intel.com, krzysztof.kozlowski+dt@linaro.org,
        ye.xingchen@zte.com.cn, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rob,

On Thu, Feb 9, 2023 at 8:07 PM Rob Herring <robh@kernel.org> wrote:
>
>
> On Thu, 09 Feb 2023 11:56:24 +0100, bchihi@baylibre.com wrote:
> > From: Balsam CHIHI <bchihi@baylibre.com>
> >
> > Add LVTS thermal controllers dt-binding definition for mt8192 and mt8195.
> >
> > Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> > ---
> >  .../thermal/mediatek,lvts-thermal.yaml        | 142 ++++++++++++++++++
> >  .../thermal/mediatek,lvts-thermal.h           |  19 +++
> >  2 files changed, 161 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
> >  create mode 100644 include/dt-bindings/thermal/mediatek,lvts-thermal.h
> >
>
> Reviewed-by: Rob Herring <robh@kernel.org>

Thank you for the review!

>

Best Regards,
Balsam
