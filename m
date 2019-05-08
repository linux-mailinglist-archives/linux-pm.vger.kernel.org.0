Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49855175D0
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2019 12:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfEHKRR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 May 2019 06:17:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:38126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfEHKRR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 May 2019 06:17:17 -0400
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C154121734;
        Wed,  8 May 2019 10:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557310636;
        bh=KL1Q3vlKVL3j046YaKILm/LmrgoI4TLlKqkWFmfAQ7g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YVLTTYCi/QTkkeZkwQCmWTvVGZB9bg3Gc7Ycl+8+KsX2Ht9krSX36dHOOybc+6VSq
         y4k1hc7Cz4Rgbd0wV8UlccDN2JZfpfGQx/cEaWwCgr/oeXVejP+lpMxiODl4FvXn96
         jJM+67HkVIUVG4X7bWI7P6Gf7EJ+YJk0WJeQaC34=
Received: by mail-lj1-f173.google.com with SMTP id f23so16998166ljc.0;
        Wed, 08 May 2019 03:17:15 -0700 (PDT)
X-Gm-Message-State: APjAAAUOaRO+aAj0+1zhI+VpEOY5BK5QPXjQ707L2Mjv2a7J5X/g/1Bt
        fpRcAwPx3MxdSP1bMSLIc39ipoESH2h4j3JTwUA=
X-Google-Smtp-Source: APXvYqwOdonWj+6joWoBvoSPOTkNm4EAhRQGXYIbBGr5SdSjgH67jPQ2ri7SNavGm/G3C86isfQRaipLXLI8WusYDpU=
X-Received: by 2002:a2e:9b49:: with SMTP id o9mr13804437ljj.113.1557310634000;
 Wed, 08 May 2019 03:17:14 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190506151219eucas1p2feab00f7b7c1c5fdd5614423fb38eae2@eucas1p2.samsung.com>
 <1557155521-30949-1-git-send-email-l.luba@partner.samsung.com>
 <1557155521-30949-12-git-send-email-l.luba@partner.samsung.com>
 <CAJKOXPd6GKVPixMiG37SoHiswaih-3S+o7QJn=WbuqdZzu-s_w@mail.gmail.com> <8d02ef2c-c5dd-6a72-9638-d858df3ea16d@partner.samsung.com>
In-Reply-To: <8d02ef2c-c5dd-6a72-9638-d858df3ea16d@partner.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 8 May 2019 12:17:02 +0200
X-Gmail-Original-Message-ID: <CAJKOXPf3tZGp-UQagGKNs0xFBGz2NwBdA2R=Y25C5jTK_ZcMXg@mail.gmail.com>
Message-ID: <CAJKOXPf3tZGp-UQagGKNs0xFBGz2NwBdA2R=Y25C5jTK_ZcMXg@mail.gmail.com>
Subject: Re: [PATCH v7 11/13] ARM: dts: exynos: add syscon to clock compatible
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        kyungmin.park@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        keescook@chromium.org, tony@atomide.com, jroedel@suse.de,
        treding@nvidia.com, digetx@gmail.com, willy.mh.wolff.ml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 8 May 2019 at 11:50, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
>
> On 5/8/19 9:22 AM, Krzysztof Kozlowski wrote:
> > On Mon, 6 May 2019 at 17:12, Lukasz Luba <l.luba@partner.samsung.com> wrote:
> >>
> >> In order get the clock by phandle and use it with regmap it needs to be
> >> compatible with syscon. The DMC driver uses two registers from clock
> >> register set and needs the regmap of them.
> >>
> >> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> >> ---
> >>   arch/arm/boot/dts/exynos5800.dtsi | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/arch/arm/boot/dts/exynos5800.dtsi b/arch/arm/boot/dts/exynos5800.dtsi
> >> index 57d3b31..0a2b328 100644
> >> --- a/arch/arm/boot/dts/exynos5800.dtsi
> >> +++ b/arch/arm/boot/dts/exynos5800.dtsi
> >> @@ -17,7 +17,7 @@
> >>   };
> >>
> >>   &clock {
> >> -       compatible = "samsung,exynos5800-clock";
> >> +       compatible = "samsung,exynos5800-clock", "syscon";
> >
> > What about Exynos5420 DTSI?
> OK, I will also add it to 5420 dtsi.
> --------------------------8<------------------------------------------
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi
> b/arch/arm/boot/dts/exynos5420.dtsi
> index aaff158..d9203f0 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -173,7 +173,7 @@
>                  };
>
>                  clock: clock-controller@10010000 {
> -                       compatible = "samsung,exynos5420-clock";
> +                       compatible = "samsung,exynos5420-clock", "syscon";
>                          reg = <0x10010000 0x30000>;
>                          #clock-cells = <1>;
>                  };
> diff --git a/arch/arm/boot/dts/exynos5800.dtsi
> b/arch/arm/boot/dts/exynos5800.dtsi
> index 57d3b31..0a2b328 100644
> --- a/arch/arm/boot/dts/exynos5800.dtsi
> +++ b/arch/arm/boot/dts/exynos5800.dtsi
> @@ -17,7 +17,7 @@
>   };
>
>   &clock {
> -       compatible = "samsung,exynos5800-clock";
> +       compatible = "samsung,exynos5800-clock", "syscon";
>   };
> ----------------------------->8-----------------------------------
>
> Can I add your ack after that?

No need for ack. The DTS have to go through arm-soc so I will pick it
up when dependencies get in and bindings are accepted (acked or
applied). We have now merge window so I guess this will go to v5.4-rc1
at earliest.

If you want to speed up things in future, be sure that dependencies
(headers) are applied as early as possible.

Best regards,
Krzysztof
