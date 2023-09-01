Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D584278FACE
	for <lists+linux-pm@lfdr.de>; Fri,  1 Sep 2023 11:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236657AbjIAJ2L (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Sep 2023 05:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236132AbjIAJ2K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Sep 2023 05:28:10 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF9F1703;
        Fri,  1 Sep 2023 02:27:43 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6bb07d274feso1356300a34.0;
        Fri, 01 Sep 2023 02:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693560460; x=1694165260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNejtY2CYRQHuWNnMRsL970fJ2LcYenjaMg4E67qwZg=;
        b=aPMPbbkVTpRFHS2sbTuv8SBuUMHDEXNixNglpJxD0EFQnKdcSGl/A/i83axsUf+w3H
         OplaEXAQvdXkXrkfqs1Ft5QBwDsJ2yx0EOu537gaYKmOvbXOp/AB3JXoX9T3wnrnl4U3
         Mi0OhbfO+D6Vrca6dLw0W77T2aLBQhoqoiLvbTJRasMo5CNsZCK6Tnb1jxwcTg2nIHxY
         bEkPEJNCM9ha2Hrk7QfCNYMERyAbGerbiWgP6gS+pvi94dEnShQiHdo2iD8lJLqLwKOd
         pJs9h00VlPRM5bSaDQv/VRF67WwyJHbABJKjc5z0Xq1S+bLAWt2YDTWoa7G1TBBeudrx
         lP3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693560460; x=1694165260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nNejtY2CYRQHuWNnMRsL970fJ2LcYenjaMg4E67qwZg=;
        b=U3u3clEJpv/BdeGNplEEixSji5e+4KdUoPgvhTP0E0aQjPH3M6Hk9Gs1EYX6Cajfum
         lOs2UaenwVO+VTwXFEyChodxZm2j5zKeDPxa9btvvB7X/cn/xcj4UnMuNA8S7yr16/Gf
         IRI9OM5U3jRkv0qfX96Aludg8tNg1SlWQDqymo5vtnK10awNGwS1D61FdrV2dRRHA1Ot
         +rAVTPx+dH2J6JINRso79iCbYcLgPmRSWYZ6fj2GylJ7Xz1oVY+8ZuXWH6kcpWg0f1m5
         tfq8oFM2nRlUkovBENBBHCaro/WNSJR1sPSZjn2+ElX8sFuQVaDglgaN2rXP2uDtB36C
         7x4g==
X-Gm-Message-State: AOJu0Yy64uMuiinzF/hUj6aZWHV1/QC6y2eo2JOoDr8NzF1IdGGUH0RL
        46pAvPRXojkAmrVObMUUY7jPlpTvFrcY8QgNo3s=
X-Google-Smtp-Source: AGHT+IHGcKLODahchCBBvFixtlLSYCgY2KNa3x1lSet1wv+1MdRrmY04593geKiUioPkoJbLl9x3eu52b/hIFO0+TyY=
X-Received: by 2002:a05:6358:342a:b0:133:428:35dc with SMTP id
 h42-20020a056358342a00b00133042835dcmr1444953rwd.11.1693560460156; Fri, 01
 Sep 2023 02:27:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693474728.git.zhoubinbin@loongson.cn> <38e811816c37a2d52374fa04864654ff1e9b4dc8.1693474728.git.zhoubinbin@loongson.cn>
 <cfa55813-946e-7aad-b7a4-54450a1ea5d5@linaro.org>
In-Reply-To: <cfa55813-946e-7aad-b7a4-54450a1ea5d5@linaro.org>
From:   Binbin Zhou <zhoubb.aaron@gmail.com>
Date:   Fri, 1 Sep 2023 17:27:28 +0800
Message-ID: <CAMpQs4Jrvd=KAXUBYYdixvvhBx1hAXxECUhGVsuEED1Jp9SPDA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] dt-bindings: soc: loongson,ls2k-pmc: Allow
 syscon-reboot/syscon-poweroff as child
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Binbin Zhou <zhoubinbin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        loongson-kernel@lists.loongnix.cn, soc@kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Krzysztof:


On Fri, Sep 1, 2023 at 5:06=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 31/08/2023 13:43, Binbin Zhou wrote:
> >  required:
> >    - compatible
> >    - reg
> > @@ -54,4 +66,18 @@ examples:
> >          interrupt-parent =3D <&liointc1>;
> >          interrupts =3D <11 IRQ_TYPE_LEVEL_LOW>;
> >          loongson,suspend-address =3D <0x0 0x1c000500>;
> > +
> > +        syscon-reboot {
> > +            compatible =3D "syscon-reboot";
> > +            offset =3D <0x30>;
> > +            mask =3D <0x1>;
> > +        };
> > +
> > +        syscon-poweroff {
> > +            compatible =3D "syscon-poweroff";
> > +            regmap =3D <&pmc>;
>
> ???

I did notice that commit [1] changed "regmap" to "unrequired" for
"syscon-reboot", but "syscon-poweroff" did not do the same.
So, at least under the current "syscon-poweroff" rule, "regmap" is "require=
d".

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Doc=
umentation/devicetree/bindings/power/reset/syscon-poweroff.yaml?h=3Dv6.5#n4=
1

I had my doubts before, but seeing that some dts do have
"syscon-poweroff" as a separate node, I assumed there was a
difference.

commit[1]: 2140d68d69d4 dt-bindings: power: reset: Unrequired regmap
property in syscon-reboot node

Thanks.
Binbin
>
> This is a friendly reminder during the review process.
>
> It seems my previous comments were not fully addressed. Maybe my
> feedback got lost between the quotes, maybe you just forgot to apply it.
> Please go back to the previous discussion and either implement all
> requested changes or keep discussing them.
>
> Thank you.
>
> Best regards,
> Krzysztof
>
