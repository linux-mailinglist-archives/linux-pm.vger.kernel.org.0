Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFB812D75B
	for <lists+linux-pm@lfdr.de>; Tue, 31 Dec 2019 10:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfLaJXA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 31 Dec 2019 04:23:00 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33427 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbfLaJW7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Dec 2019 04:22:59 -0500
Received: by mail-ed1-f68.google.com with SMTP id r21so34818172edq.0;
        Tue, 31 Dec 2019 01:22:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zcMF0DszYjdAAeSzpwgiwYYj0Rmxb5AATwzX117pufo=;
        b=tp4tCPQqUUtrCUnBKOQ2hDTX5hSvi6k/POqxIqU8innGP4rro8a/dWwaydpd4O9XNS
         mnLoYBZL+FEl/mV9XqJtWs37/+cc+PaVaRPFFwRqQ66mj38Uhrvf1F3ImtD1N8oO5fH8
         TkQEDwbGnknv+AeVr9d+S/tPP8zzZ3wX9yml4nuDFflSbsTGKQjm05Pz8TJj3GzTPQ6J
         NmzL0QvJCJ7JWVy25EA19RQXp5XfkQtoyl/0op5sW75QKDUW3FYay1eaZRs+n6jhf5b4
         iSjN6x1TMno7z1EXAX55WBU3y0QWzlBEMxBkrDsklk6j+YzQuBmU/yGanfGg4fU5I/qI
         2HQA==
X-Gm-Message-State: APjAAAXnmYGksETNYv4hFNlSnDTR19e/fjZKK0xeP+prHxu5oodin03v
        C3L5ixW3vh2F8iFDqOVC+Dk=
X-Google-Smtp-Source: APXvYqzgzVpvRf+8IP6z3ujB3SZIWKfFAGfLl8aejvQf9p703WelAn4funQmIQW8H6z6pzmhM0Yc6w==
X-Received: by 2002:a17:906:1fd5:: with SMTP id e21mr44856105ejt.97.1577784177492;
        Tue, 31 Dec 2019 01:22:57 -0800 (PST)
Received: from pi3 ([194.230.155.138])
        by smtp.googlemail.com with ESMTPSA id x15sm5693555edl.48.2019.12.31.01.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2019 01:22:56 -0800 (PST)
Date:   Tue, 31 Dec 2019 10:22:54 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@samsung.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        georgi.djakov@linaro.org, leonard.crestez@nxp.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com
Subject: Re: [RFC PATCH v3 4/7] arm: dts: exynos: Add interconnect bindings
 for Exynos4412
Message-ID: <20191231092254.GA6939@pi3>
References: <20191220115653.6487-1-a.swigon@samsung.com>
 <CGME20191220120144eucas1p119ececf161a6d45a6a194e432bbbd1f9@eucas1p1.samsung.com>
 <20191220115653.6487-5-a.swigon@samsung.com>
 <20191230154405.GC4918@pi3>
 <2922135223b01126277ef92a53e6b294bc17bb5c.camel@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <2922135223b01126277ef92a53e6b294bc17bb5c.camel@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Dec 31, 2019 at 08:18:01AM +0100, Artur Świgoń wrote:
> Hi,
> 
> On Mon, 2019-12-30 at 16:44 +0100, Krzysztof Kozlowski wrote:
> > On Fri, Dec 20, 2019 at 12:56:50PM +0100, Artur Świgoń wrote:
> > > This patch adds the following properties to the Exynos4412 DT:
> > >   - exynos,interconnect-parent-node: to declare connections between
> > >     nodes in order to guarantee PM QoS requirements between nodes;
> > >   - #interconnect-cells: required by the interconnect framework.
> > > 
> > > Note that #interconnect-cells is always zero and node IDs are not
> > > hardcoded anywhere.
> > > 
> > > Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
> > > ---
> > >  arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > 
> > The order of patches is confusing. Patches 4 and 6 are split - do the
> > depend on 5? I doubt but...
> 
> Let me elaborate:
> 
> The order of the patches in this series is such that every subsequent
> patch adds some functionality (and, of course, applying patches one-by-one
> yields a working kernel at every step). Specifically for patches 04--07:
> 
>  -- patch 04 adds interconnect _provider_ properties for Exynos4412;
>  -- patch 05 implements interconnect provider logic (depends on patch 04);
>  -- patch 06 adds interconnect _consumer_ properties for Exynos4412 mixer;
>  -- patch 07 implements interconnect consumer logic (depends on patches
>     05 & 06);
> 
> My reasoning is that this order allows to e.g., merge the interconnect
> provider for exynos-bus and leave the consumers for later (not limited to
> the mixer). I hope this makes sense.

It is wrong. The driver should not depend on DTS changes because:
1. DTS always go through separate branch and tree, so last patch
   will have to wait up to 3 cycles (!!!),
2. You break backward compatibility.

In certain cases dependency on DTS changes is ok:
1. Cleaning up deprecated properties,
2. Ignoring the backward compatibility for e.g. new platforms.

None of these are applicable here.

You need to rework it, put DTS changes at the end. This clearly shows
that there is no wrong dependency.

> 
> > Adjust the title to match the contents - you are not adding bindings but
> > properties to bus nodes. Also the prefix is ARM: (look at recent
> > commits).
> 
> OK.
> 
> > > 
> > > diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > > index 4ce3d77a6704..d9d70eacfcaf 100644
> > > --- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > > +++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > > @@ -90,6 +90,7 @@
> > >  &bus_dmc {
> > >  	exynos,ppmu-device = <&ppmu_dmc0_3>, <&ppmu_dmc1_3>;
> > >  	vdd-supply = <&buck1_reg>;
> > > +	#interconnect-cells = <0>;
> > 
> > This does not look like property of Odroid but Exynos4412 or Exynos4.
> 
> Strangely enough, this file is where the 'exynos,parent-bus' (aka. 'devfreq')
> properties are located (and everything in this RFC concerns devfreq).

I cannot find exynos,parent-bus in exynos4412-odroid-common.dtsi. Can
you elaborate?

Best regards,
Krzysztof
