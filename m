Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B44D2BAD87
	for <lists+linux-pm@lfdr.de>; Fri, 20 Nov 2020 16:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbgKTPIE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Nov 2020 10:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728417AbgKTPIE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Nov 2020 10:08:04 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1218FC0613CF;
        Fri, 20 Nov 2020 07:08:04 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id d12so10285870wrr.13;
        Fri, 20 Nov 2020 07:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=293ibeu5UTezfgy152T6TJOZ3fV03PwIIQQwYjfSoNQ=;
        b=f5eKTsN1W7qyK+nLz0c44jL7Tk8uGoM3LjiJUbuz5WaHZM97NyymqPU5ZqlbTChOgD
         CRH6WWjUbZmAMmzwyspYTbxSq3wjOuN6pN16X5wNZY/cWL6dMD90drewGFWbTTW3mduz
         XwSUxzYM06yNuYK1nGAzUym5+7ou/EOIi2m/2q4eVqRXcg6Breq8JtfXa/7Tx+m4mVv9
         to9glAru6s6UfpH+cZ+zkg5I5Ff97fxQckQyDGnX1QiI8yOlwlATWjiYMOA2R+CS8IYB
         3bLrrIzKsX1PphwmgkxZ+twmV/3yg+HnRznbdGlxVAic4CRieiqCAgvDjFZgJZ41v8dV
         XKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=293ibeu5UTezfgy152T6TJOZ3fV03PwIIQQwYjfSoNQ=;
        b=kEwUCc0h2WdRNXkou0DTnzu4BDBgE6VZVRXNW7z+owmzrvqJwVtiCe4Vp2x9+4ZV2G
         i2ziKRzr7tLCN8qXzsdxEMA1Q5FmNMcYcNsZ5zEkXL7IQziLf7aecxUZUzpkvBRoJnH5
         ZB4WvCPCPB5xmZnRwgcKclyT1EQHjeQX3pwcFIiiqShSsMAZ8yiwc9qjo/wex+vQ2hyk
         NvschDwr+65eOjnRzVnR3yM/mq3mv4L4kJx3kVwPP8jQuWxMLqL5zyCeEqUA1abWD7ZC
         HK/iJ5aiIrJ+g/BbU4+Legq2EzVi5TBePZIcTDShcZwS2Pl5f27QarL/KVQde0QDJng5
         lXAQ==
X-Gm-Message-State: AOAM532Ch5tTD7AyWQ5bMVAmLk203KIf8kMwBMdFxhgeXKdL4mCbjVpT
        X2AEcOHa7CW++Rov5DxNe8w=
X-Google-Smtp-Source: ABdhPJxJ9Bh5yIIlRdAh02tO48D71vQcaj718rfG5w3aKBmbN+DBEBOD7wByC/IoMu/IpHKVf7bhCg==
X-Received: by 2002:adf:fdc5:: with SMTP id i5mr16257322wrs.26.1605884882794;
        Fri, 20 Nov 2020 07:08:02 -0800 (PST)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id u8sm4696535wmg.6.2020.11.20.07.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 07:08:01 -0800 (PST)
Date:   Fri, 20 Nov 2020 16:07:59 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Nicolas Chauvet <kwizart@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 0/6] thermal: tegra: soctherm bugfixes
Message-ID: <20201120150759.GA3870099@ulmo>
References: <20200927150956.34609-1-kwizart@gmail.com>
 <CABr+WTnftetrMzC8bq+=RqOxqJ9EvYsU1LEZ5bVv-OptVksbjA@mail.gmail.com>
 <90858129-bed7-eacf-915e-0c2b3acaa089@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
In-Reply-To: <90858129-bed7-eacf-915e-0c2b3acaa089@linaro.org>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2020 at 12:04:34PM +0100, Daniel Lezcano wrote:
> On 19/11/2020 12:00, Nicolas Chauvet wrote:
> > Le dim. 27 sept. 2020 =C3=A0 17:10, Nicolas Chauvet <kwizart@gmail.com>=
 a =C3=A9crit :
> >>
> >> When using tegra_soctherm driver on jetson-tk1, the following messages
> >> can be seen:
> >> from kernel: tegra_soctherm 700e2000.thermal-sensor:
> >>  throttle-cfg: heavy: no throt prop or invalid prop
> >>  soctherm: trip temperature -2147483647 forced to -127000
> >>  thermtrip: will shut down when cpu reaches 101000 mC
> >>  soctherm: trip temperature -2147483647 forced to -127000
> >>  thermtrip: will shut down when gpu reaches 101000 mC
> >>  soctherm: trip temperature -2147483647 forced to -127000
> >>  thermtrip: will shut down when pll reaches 103000 mC
> >>  throttrip: pll: missing hot temperature
> >>  soctherm: trip temperature -2147483647 forced to -127000
> >>  thermtrip: will shut down when mem reaches 101000 mC
> >>  throttrip: mem: missing hot temperature
> >>  IRQ index 1 not found
> >>
> >> This serie fixes two errors and two warnings that are reported in dmesg
> >> It was compiled and tested at runtime on jetson-tk1 only.
> >>
> >>
> >> v2:
> >>  * Add missing tegra210 device-tree properties
> >>  * Add the appropriate prefix for tegra soctherm
> >>  * Use SoCs condition over of_compatible
> >>
> >>
> >> Nicolas Chauvet (6):
> >>   ARM: tegra: Add missing gpu-throt-level to tegra124 soctherm
> >>   ARM: tegra: Add missing hot temperatures to tegra124 thermal-zones
> >>   arm64: tegra: Add missing hot temperatures to tegra132 thermal-zones
> >>   arm64: tegra: Add missing gpu-throt-level to tegra210 soctherm
> >>   arm64: tegra: Add missing hot temperatures to tegra210 thermal-zones
> >>   thermal: tegra: Avoid setting edp_irq when not relevant
> >>
> >>  arch/arm/boot/dts/tegra124.dtsi           | 11 +++++++
> >>  arch/arm64/boot/dts/nvidia/tegra132.dtsi  | 10 ++++++
> >>  arch/arm64/boot/dts/nvidia/tegra210.dtsi  | 13 ++++++++
> >>  drivers/thermal/tegra/soctherm.c          | 38 +++++++++++++----------
> >>  drivers/thermal/tegra/soctherm.h          |  1 +
> >>  drivers/thermal/tegra/tegra124-soctherm.c |  1 +
> >>  drivers/thermal/tegra/tegra132-soctherm.c |  1 +
> >>  drivers/thermal/tegra/tegra210-soctherm.c |  1 +
> >>  8 files changed, 60 insertions(+), 16 deletions(-)
> >>
> >> --
> >> 2.25.4
> >=20
> > Hello,
> > This series is still pending review.
> >=20
> > Thierry, do you expect some reviewers from the linux-pm (Zhang, Daniel =
?)
> > To me it seems like tegra specific changes, so maybe a Nvidia reviewer
> > is awaited ?
>=20
> I can apply the patch 6/6, other patches must go through arm-soc tree.
>=20
> Thierry can you give your blessing ?

As Jon mentioned, making support for that EDP IRQ doesn't seem to be the
right thing. If this IRQ does exist on Tegra124/Tegra132, then a more
correct patch would be to add that to the device tree. I vaguely recall
writing a patch to do that, a while back when I was trying to get rid of
a couple of dt_binding_check warnings/errors, so I'll dig around for
that.

I think for now we should probably ignore the driver patch. I'll get
back to you if we determine that EDP IRQ is not present on those SoCs,
in which case the driver patch would be correct.

Thierry

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+328wACgkQ3SOs138+
s6Gplg//S1BPPaEyoBvWQ3AnYuIeHzB42VU6ZgXvQ+FB0J959UgWeSb7PCZLdzMk
i+ey+6ka+LMX5s8/SYjiAU+UJ65CyIYVLXHQThNnRv4dogit3DXEd6K3lkN6bgwz
9rG4hYH9aKPJL2FO49NeutwLwsqZOQ0kLJudIudsPaiVNyFGGITeN3pCl1NFtRE9
qCyFP88Y5tl41HOtyGJH8ecngb9LtNZFLFwv9NZkUprCwmASioKH+mnS4xUkrUub
hnutARJ9ZJO1jgMNe7Sfmx+2Fec+X3ZJ4sg3RRM6cJZJBECKkPbo5deD6RtR0IGu
lasbz8liXe8bs6aqXFvTT3Bb+XUb70mNKbAK3QO1xbG1nN5i6xvhc5TnNnoQvARP
xJ34ktH5yYLka00/PTDxkbFxw6pZEfPPzBwEZoIMNRy2Vb6F7bp9/dUeaYE+lCSI
RpJ/SIPrBnLXGdvM38aqxcbu3ddas+zBqKtFiWc6xoyOsgv3TTIaPaFGYMBts6rT
jPsnNctE/NCM4tcLjkyU+24r/bz45NBtx1YohbTsM9Cq3BTWpo+zim9Z+508CqgA
4YgeRj0sbEzjZN8qSF0x7guiF/+51kvQrxhxoyCZ7OkjM24/00NI2CwXl8+BEKof
D4VUwi0qB15704cUxqLCzW0mEAl2JLUi0JN071bxl86j8n+SRMk=
=+yUI
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
