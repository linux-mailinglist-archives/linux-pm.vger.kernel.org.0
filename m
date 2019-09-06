Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09DB0AB682
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2019 12:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390788AbfIFK45 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Sep 2019 06:56:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:45266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388816AbfIFK45 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 6 Sep 2019 06:56:57 -0400
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B505208C3;
        Fri,  6 Sep 2019 10:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567767415;
        bh=eKqQLsZ1CqXLPChoayXDfV/yXKBUa6ki7SK6YURr7JQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iwe7A6POO/AXJafBwclGZTdDimAL7JL/4tkeyQ2Hmmn/p1RAKgcK1OXWpNcost0c6
         vb6M7H3Hkn2NmTAYYE4TKKuMQBsOeTRnrzB3CLFIS0u69fCfWWPHZAnzndjTpfAjSt
         FTUs49YdlcffPsxSnWGKYkGzC9ON7Sqxu9LEJ72k=
Received: by mail-lf1-f46.google.com with SMTP id w67so4643365lff.4;
        Fri, 06 Sep 2019 03:56:55 -0700 (PDT)
X-Gm-Message-State: APjAAAX7QwOnVMGx9VyFBlAipKtctxddwMZyP5E2ngKc3f/PStM44rI4
        BADpwCTBLEpKc+BXgcabB9zaf+m39yPd8ELcLtk=
X-Google-Smtp-Source: APXvYqyuyvNE+DfCX2EXl+GcF9M9zNqpthnU+rCpM/ZylcfvRmscK9OYLhqRaqB/x8T/f9Qsn/DW81HgYTXkDGfiTR4=
X-Received: by 2002:a19:c649:: with SMTP id w70mr5991002lff.33.1567767413630;
 Fri, 06 Sep 2019 03:56:53 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190906101407eucas1p15eb0df53374b27497b4793eab24becf6@eucas1p1.samsung.com>
 <20190906101344.3535-1-l.luba@partner.samsung.com> <20190906101344.3535-4-l.luba@partner.samsung.com>
In-Reply-To: <20190906101344.3535-4-l.luba@partner.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 6 Sep 2019 12:56:42 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfoYxTVvt_bMQOs1=BkHzUuW_WvL9zn0jTGS6LLpv=fhQ@mail.gmail.com>
Message-ID: <CAJKOXPfoYxTVvt_bMQOs1=BkHzUuW_WvL9zn0jTGS6LLpv=fhQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] dt-bindings: ddr: Add bindings for Samsung LPDDR3 memories
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        kyungmin.park@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        willy.mh.wolff.ml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 6 Sep 2019 at 12:14, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> Add description of bindings for Samsung k3qf2f20db LPDDR3 memory.
> Minor fixes in the old documentation.
>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  .../devicetree/bindings/ddr/lpddr3.txt        | 29 +++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/ddr/lpddr3.txt b/Documentation/devicetree/bindings/ddr/lpddr3.txt
> index 3b2485b84b3f..de0905239767 100644
> --- a/Documentation/devicetree/bindings/ddr/lpddr3.txt
> +++ b/Documentation/devicetree/bindings/ddr/lpddr3.txt
> @@ -40,10 +40,34 @@ Child nodes:
>    a given speed-bin. Please see Documentation/devicetree/
>    bindings/ddr/lpddr3-timings.txt for more information on "lpddr3-timings"
>
> +Samsung K3QF2F20DB LPDDR3 memory
> +------------------------------------------------------------
> +
> +This binding uses the LPDDR3 binding (described above)
> +
> +Required properties:
> +- compatible:  Should be:
> +               "samsung,K3QF2F20DB"
> +               followed by "jedec,lpddr3"
> +- density  : <u32> representing density in Mb (Mega bits)
> +- io-width : <u32> representing bus width. Possible value 32
> +- #address-cells: Must be set to 1
> +- #size-cells: Must be set to 0

If you decided to repeat all properties again, then it deserves its
own bindings file. However I though about simpler solution - just
document compatible. Exactly the same as AT24 or AT25 EEPROM bindings.
There is not much benefit from copying all these properties.

Best regards,
Krzysztof
