Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0243737345
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2019 13:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbfFFLpa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Jun 2019 07:45:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:37876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbfFFLp3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 6 Jun 2019 07:45:29 -0400
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3439208C0;
        Thu,  6 Jun 2019 11:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559821529;
        bh=vqDCsXe5IHyavNfXW5krmCev6CdBmExEhG6HMAbCLhc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=b6yQ9oA8ENOTDIff2KAsFD3F/2NkJA10BoHe6N5aygghiYufyZUDmWLKLSdgY/2s5
         QQA61xYx11ZD/CnuimtlFIGJchk3K7856I/p/OqUxgKQkOimJQRTh34vyKAti116SA
         mkz/P+8qVzFpnMqqL0jlMYlxU+pMuzxiC9qeMHPE=
Received: by mail-lj1-f179.google.com with SMTP id o13so1698278lji.5;
        Thu, 06 Jun 2019 04:45:28 -0700 (PDT)
X-Gm-Message-State: APjAAAWiOTPzDmE/LU8D7L/BDloXUFNUy0KceyVOuijhcpa1FQLxAL9+
        TyccQOEht1ts/3ZDFib7qr3UdEmvgcrIcXkteT4=
X-Google-Smtp-Source: APXvYqw9cRx3ydyjVTR7FBMwbZdJR6asW1APtajO6t1UPptVjz86e1QW4Q5Md03p3BchHDHfSNkcP3PD41BDIh6uTSg=
X-Received: by 2002:a2e:568d:: with SMTP id k13mr23893341lje.194.1559821526851;
 Thu, 06 Jun 2019 04:45:26 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190605165435eucas1p2fa32f4583f396fdce443b6943ac180d3@eucas1p2.samsung.com>
 <20190605165410.14606-1-l.luba@partner.samsung.com> <20190605165410.14606-9-l.luba@partner.samsung.com>
 <CAJKOXPfKbWpx9AapOudDyEZjDpgtMX-aHPQHRivuVNKaap8EQg@mail.gmail.com> <d5758d38-c0e5-1732-1407-91d602ae5500@partner.samsung.com>
In-Reply-To: <d5758d38-c0e5-1732-1407-91d602ae5500@partner.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 6 Jun 2019 13:45:15 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfiFCp52rYtOBk5mfHfLLA=VtBpakAdUB__UcVCqbma-g@mail.gmail.com>
Message-ID: <CAJKOXPfiFCp52rYtOBk5mfHfLLA=VtBpakAdUB__UcVCqbma-g@mail.gmail.com>
Subject: Re: [PATCH v8 08/13] drivers: memory: add DMC driver for Exynos5422
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

On Thu, 6 Jun 2019 at 12:38, Lukasz Luba <l.luba@partner.samsung.com> wrote:
> Hi Krzysztof,
> >> +/**
> >> + * exynos5_dmc_init_clks() - Initialize clocks needed for DMC operation.
> >> + * @dmc:       DMC structure containing needed fields
> >> + *
> >> + * Get the needed clocks defined in DT device, enable and set the right parents.
> >> + * Read current frequency and initialize the initial rate for governor.
> >> + */
> >> +static int exynos5_dmc_init_clks(struct exynos5_dmc *dmc)
> >> +{
> >> +       int ret;
> >> +       unsigned long target_volt = 0;
> >> +       unsigned long target_rate = 0;
> >> +
> >> +       dmc->fout_spll = devm_clk_get(dmc->dev, "fout_spll");
> >> +       if (IS_ERR(dmc->fout_spll))
> >> +               return PTR_ERR(dmc->fout_spll);
> >> +
> >> +       dmc->fout_bpll = devm_clk_get(dmc->dev, "fout_bpll");
> >> +       if (IS_ERR(dmc->fout_bpll))
> >> +               return PTR_ERR(dmc->fout_bpll);
> >> +
> >> +       dmc->mout_mclk_cdrex = devm_clk_get(dmc->dev, "mout_mclk_cdrex");
> >> +       if (IS_ERR(dmc->mout_mclk_cdrex))
> >> +               return PTR_ERR(dmc->mout_mclk_cdrex);
> >
> > You are not enabling this clock. It is divider so it is fine for him
> > but what about its parents? How can you guarantee that parents are
> > enabled?
> It uses two parents in this configuration:
> 1. 'mout_bpll' which is set by the bootloader and is a default mode
> 2. 'mout_mx_mspll_ccore' which is used temporary as a 'bypass clock
> source' only for the time when BPLL is changing it's settings
>
> Do you suggest to put a call:
>
> to make sure the parent is up and running?
> OR just move the lines from the end of this function:
>         clk_prepare_enable(dmc->fout_bpll);
>         clk_prepare_enable(dmc->mout_bpll);
> and add:
>         ret = clk_set_parent(dmc->mout_mclk_cdrex, dmc->mout_bpll);
> then call the clk_get_rate on 'mout_mclk_cdrex'
>

Ah, It's my mistake. I missed that later you enable its new parent. It's fine.

Best regards,
Krzysztof
