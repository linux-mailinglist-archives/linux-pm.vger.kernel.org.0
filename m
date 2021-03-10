Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE7533396B
	for <lists+linux-pm@lfdr.de>; Wed, 10 Mar 2021 11:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbhCJKG5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 10 Mar 2021 05:06:57 -0500
Received: from mail-vk1-f173.google.com ([209.85.221.173]:40895 "EHLO
        mail-vk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbhCJKG2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Mar 2021 05:06:28 -0500
Received: by mail-vk1-f173.google.com with SMTP id l17so3673079vkk.7;
        Wed, 10 Mar 2021 02:06:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZllOVw90974p1HwhGEyhTj0sspN6R4JG5dk5ZNRcWNM=;
        b=DgNQSikgjdh5js4j1Fk7c3yzSZ1y+ifpJ8RqSPWKgMqvyhJcXOovlnuiTTRht4bqna
         epchlBbcOQrVdz3KJDQzYM5evK5BVJkh2Tb2jKKMLZGVUyGEdC7U/+zRTbM15d2u4EEp
         zsIbIy4m4jZ4dndPoBksNy5kHWxcWoxmpdoOUOxxawVkAgzgajujDHcRtFw54zd0voC9
         RS/my8fCMiD/P/Dxwa6kJTIx+7wWNX6HXgkcuRkXhoJm1Afrbi8KKtrk3+f+I3RObzOx
         2OdAkIWZ4Sw79u8h/bskKuK9dKBjqSP7uGiw8fiIYocnCN99xloUGcliMyb6/cllFcX/
         ITZw==
X-Gm-Message-State: AOAM532ocHbnTIQ4Eo58qs1mHGrAwkBAbIoEPZ09R1ox5wU9X2pekZIO
        0Q2QLc0drqO/hjB36tKl9QvFkKlwkkAG5a4CuNk=
X-Google-Smtp-Source: ABdhPJzs6gebqbXziFdEQvG8ykvR7NIRbnMOd5gHE9Z5tav4MGXryo39pscNHxwxBYHjt97l18Nc6TuxUCQxtZ3Py7c=
X-Received: by 2002:ac5:cbee:: with SMTP id i14mr899284vkn.1.1615370787235;
 Wed, 10 Mar 2021 02:06:27 -0800 (PST)
MIME-Version: 1.0
References: <20210309162205.2619943-1-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <20210309162205.2619943-1-niklas.soderlund+renesas@ragnatech.se>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 10 Mar 2021 11:06:16 +0100
Message-ID: <CAMuHMdX_s3Hsj2C7C2SEhRxySsj589W3Htn3d3=7Fnqk9RuJ-A@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: thermal: rcar-gen3-thermal: Support five TSC
 nodes on r8a779a0
To:     =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Niklas,

On Tue, Mar 9, 2021 at 5:24 PM Niklas Söderlund
<niklas.soderlund+renesas@ragnatech.se> wrote:
> When adding support for V3U (r8a779a0) it was incorrectly recorded it
> supports four nodes, while in fact it supports five. The fifth node is
> named TSC0 and breaks the existing naming schema starting at 1. Work
> around this by separately defining the reg property for V3U and others.
>
> Restore the maximum number of nodes to three for other compatibles as
> it was before erroneously increasing it for V3U.
>
> Fixes: d7fdfb6541f3be88 ("dt-bindings: thermal: rcar-gen3-thermal: Add r8a779a0 support")
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml
> +++ b/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml

> @@ -111,3 +121,20 @@ examples:
>                      };
>              };
>      };
> +  - |
> +    #include <dt-bindings/clock/r8a779a0-cpg-mssr.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/power/r8a779a0-sysc.h>
> +
> +    tsc_r8a779a0: thermal@e6190000 {
> +            compatible = "renesas,r8a779a0-thermal";
> +            reg = <0xe6190000 0x100>,

0x200, for all register blocks?

> +                  <0xe6198000 0x100>,
> +                  <0xe61a0000 0x100>,
> +                  <0xe61a8000 0x100>,
> +                  <0xe61b8000 0x100>;

0xe61b0000

> +            clocks = <&cpg CPG_MOD 919>;
> +            power-domains = <&sysc R8A779A0_PD_ALWAYS_ON>;
> +            resets = <&cpg 919>;
> +            #thermal-sensor-cells = <1>;
> +    };

The rest looks good to me.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
