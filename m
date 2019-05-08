Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F116D17280
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2019 09:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbfEHHWZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 May 2019 03:22:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:45572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbfEHHWY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 May 2019 03:22:24 -0400
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7C7D21734;
        Wed,  8 May 2019 07:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557300144;
        bh=huosOOEBHrGEUrxg9WuAD+jdVGM8rQMw4lbHGi1Z3YQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Sk7Yj8M9FalDKFCoQM4sD/TkVs+spcuk8TlxmbmAl6Z5ydM2k4/ggdV+NGvivH176
         6V98f1GTNjns0Ri0y/1buxX9EXtWQbrCOtZ3IZzr2ncvtP0t2WmWjGNabX7E/YNe84
         aD7G4HSlSCMCyps6GwOFnZioIpEe1/Hf89SDKigY=
Received: by mail-lj1-f180.google.com with SMTP id h21so16506060ljk.13;
        Wed, 08 May 2019 00:22:23 -0700 (PDT)
X-Gm-Message-State: APjAAAXywGya3MZvK62MWL/L/62z8ReUAtmyRaM33dlkkCByXY46Cs1r
        LBY9h8TsFd6op4eyEoeeqRgOwU9fGHK+b4FSXOE=
X-Google-Smtp-Source: APXvYqzXScVH7cxrCSwoWYOjKVWc/iiykI8Q/ktyQoORZeeA2rniqwMe6wfckIStnSqDZFY/mJaOQPxbHO8GT2u2iTE=
X-Received: by 2002:a2e:82cb:: with SMTP id n11mr19963536ljh.183.1557300142155;
 Wed, 08 May 2019 00:22:22 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190506151219eucas1p2feab00f7b7c1c5fdd5614423fb38eae2@eucas1p2.samsung.com>
 <1557155521-30949-1-git-send-email-l.luba@partner.samsung.com> <1557155521-30949-12-git-send-email-l.luba@partner.samsung.com>
In-Reply-To: <1557155521-30949-12-git-send-email-l.luba@partner.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 8 May 2019 09:22:11 +0200
X-Gmail-Original-Message-ID: <CAJKOXPd6GKVPixMiG37SoHiswaih-3S+o7QJn=WbuqdZzu-s_w@mail.gmail.com>
Message-ID: <CAJKOXPd6GKVPixMiG37SoHiswaih-3S+o7QJn=WbuqdZzu-s_w@mail.gmail.com>
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

On Mon, 6 May 2019 at 17:12, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> In order get the clock by phandle and use it with regmap it needs to be
> compatible with syscon. The DMC driver uses two registers from clock
> register set and needs the regmap of them.
>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  arch/arm/boot/dts/exynos5800.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/exynos5800.dtsi b/arch/arm/boot/dts/exynos5800.dtsi
> index 57d3b31..0a2b328 100644
> --- a/arch/arm/boot/dts/exynos5800.dtsi
> +++ b/arch/arm/boot/dts/exynos5800.dtsi
> @@ -17,7 +17,7 @@
>  };
>
>  &clock {
> -       compatible = "samsung,exynos5800-clock";
> +       compatible = "samsung,exynos5800-clock", "syscon";

What about Exynos5420 DTSI?

Best regards,
Krzysztof

>  };
>
>  &cluster_a15_opp_table {
> --
> 2.7.4
>
