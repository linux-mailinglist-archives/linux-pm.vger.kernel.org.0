Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED70433DB6D
	for <lists+linux-pm@lfdr.de>; Tue, 16 Mar 2021 18:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbhCPRvh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Mar 2021 13:51:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:42424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233139AbhCPRvL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 16 Mar 2021 13:51:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C46E65104;
        Tue, 16 Mar 2021 17:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615917070;
        bh=pbJXtCdebP9sYUzCMuDBNQ/VmqE7MtiUhZT+utdKfOM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=t8FdK+fOB70tNbCjuQ/RgrRM2Wd0C3aelP/9AsTK0EhaEK2ioLvQGaB5Wd34h3aV4
         KeOSzmmPQF7+xTxE2hyu6GKVXMv2IuBhrNvHu8whsMR4uXFvi+vZkx4Gj5NQd0L4OU
         Bo1wJLI53BN2AHXTfnfvYtV7/pi/7gui09Pu5y7xZ1wlbCIP+xFYNNV27VUfy60xKB
         PoaAhT12LIWET8j5TYN9IrR1V7fEhgRlTZqFGm5hZpr4Lk6oHG8mHq7HkRigVVQ3SW
         fQw+RDruVgyKrhNte/jJ8d0vRTxVDuuwvVsgzqbPbKnIEB8G1xq2eQoSnh4Wd7w3Sm
         usTNR5ULOqoPg==
Received: by mail-qt1-f173.google.com with SMTP id l13so12300520qtu.9;
        Tue, 16 Mar 2021 10:51:10 -0700 (PDT)
X-Gm-Message-State: AOAM533QguOKsQ6ImKqCfxbnNLU8IR4Z58S2fSnIW8z8YiDXUCnu9i4z
        QaojLrtFXaEjl528t5sjVRDflY8OY7kItYrpSQ==
X-Google-Smtp-Source: ABdhPJyQ+kzNAOwqUQ5HTBukjAeFUdJ61x9F0CW9p3bMCtDLms1Vd2ObGy7uTjqxjypyXGTzjERW0l+ltG8kH1rSAC0=
X-Received: by 2002:ac8:70d1:: with SMTP id g17mr75201qtp.306.1615917069540;
 Tue, 16 Mar 2021 10:51:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210312154357.1561730-1-sebastian.reichel@collabora.com>
 <20210312154357.1561730-5-sebastian.reichel@collabora.com>
 <CAL_JsqKFJPSMyMbcrpnL1WgttHSP+3Q+U8bJ_m5hm=O0gEPe4g@mail.gmail.com> <20210316164602.hupmcy2hjflf4za2@earth.universe>
In-Reply-To: <20210316164602.hupmcy2hjflf4za2@earth.universe>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 16 Mar 2021 11:50:58 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK5zBuRHHj523qtBodoJ30YKXFBvnmDBdf0oHtVriESeA@mail.gmail.com>
Message-ID: <CAL_JsqK5zBuRHHj523qtBodoJ30YKXFBvnmDBdf0oHtVriESeA@mail.gmail.com>
Subject: Re: [PATCH 04/38] dt-bindings: power: supply: bq25890: Convert to DT
 schema format
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 16, 2021 at 10:46 AM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Hi,
>
> On Mon, Mar 15, 2021 at 12:21:34PM -0600, Rob Herring wrote:
> > On Fri, Mar 12, 2021 at 8:44 AM Sebastian Reichel
> > <sebastian.reichel@collabora.com> wrote:
> > > +  ti,ibatcomp-clamp-microvolt:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    description: max. charging voltage adjustment due to expected voltage drop on in-series resistor
> >
> > You don't need a type $ref on properties with a standard unit suffix.
> > Though it looks like there's some non-standard ones (-microvolts) in
> > the series.
>
> Ok. Unfortunately most properties in this series use non-standard
> ones :(. Newer bindings using common properties have already been
> written in YAML and/or make use of simple-battery.
>
> Can we have a warning for this in the dt_binding_check? Maybe
> something like

Yeah, I'm working on that.

> superfluous $ref for property with standard suffix

And having more helpful error messages is on my todo, but not much BW
to work on ATM.

Rob
