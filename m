Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2618EF443D
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2019 11:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731371AbfKHKLX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Nov 2019 05:11:23 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35879 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728513AbfKHKLW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Nov 2019 05:11:22 -0500
Received: by mail-wr1-f66.google.com with SMTP id r10so6377833wrx.3;
        Fri, 08 Nov 2019 02:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iT6U/p31YxLJ3YEw6t4R6XoTVyLwdKsrASJhJvCVA7c=;
        b=YEc1tQ3pBKpd9wRScCbdFG6sfGu5RZ4Uymj6LwRrCOXXY4aSbm9agzcU3eqEyUGI5B
         3rb7QXnRBQz+lbQSA67usjLLvtVduUz6FW5++kAubPXc9jpWDf7jCNMOjjfy5xLwwgat
         AYwqX+HrPY1LulKtmX+FJ8O1R7cbF5H4CDTF5wS9rO/PKCucuhIXaRD4y9l0LQRmihXm
         lf8XMeeeXciW6mJXggIEVJvK4I0WAYT/QhTbSeA1Mg0lFEh5wkw6AUQneR91kxxEiAOe
         rzzUmeA4bnO6J0C0RznWisKdzO/U1RhEtkXUNr+6Aq5uiKVgl0NqeVo463jkj3KY0ySI
         DJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iT6U/p31YxLJ3YEw6t4R6XoTVyLwdKsrASJhJvCVA7c=;
        b=pvIlUw+1Itwr/PQIz3cGJIF2QYC/zI9lCeYbW68E9BUmhW+MOuKAACm8hcHUqE3sGQ
         JEeHVa2jOcwCzLusT6sKrtM1wSgpWDqwweAM/mMK1eEQUcAgSWc8tLNFO5OR7hPpZdwZ
         G3AGy3SEVLSaySFJgLawPRXtSiIOZ5cyv2RC4GfAAbYayn8CwGr44puDg400gHH2VLSB
         Pwu4MWsSTtve/t0EBOfstSFufGYIbZhENhCxUxAd5oay7Iwlq21ogUY9tJNR3OrALZZp
         yA1oNaPhto5TJ2y3Obb9TPryZ/nptgcSgY7/Q+lTMCjkVgfxIg3SshVB+VrMPWVRzcwm
         5mNg==
X-Gm-Message-State: APjAAAVfaoOfJ5nNu7XZYUGrj3I+UbHB5gUzOPd8UNlldpIu/DPJl7ZS
        4M8z1RcBzWAUL0cp+YCCHAc=
X-Google-Smtp-Source: APXvYqy4jGZLapaMcNUIVTWiMnhLb1d2B11+C4njdIXrmrL3Aiwd54D5rZW0epTokS+komx38mzEwg==
X-Received: by 2002:adf:9d87:: with SMTP id p7mr7412454wre.11.1573207878719;
        Fri, 08 Nov 2019 02:11:18 -0800 (PST)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id y15sm4712432wrh.94.2019.11.08.02.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 02:11:17 -0800 (PST)
Date:   Fri, 8 Nov 2019 11:11:16 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        jason@lakedaemon.net, jonathanh@nvidia.com,
        linus.walleij@linaro.org, marc.zyngier@arm.com,
        mark.rutland@arm.com, stefan@agner.ch, tglx@linutronix.de,
        pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        jckuo@nvidia.com, josephl@nvidia.com, talho@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        mperttunen@nvidia.com, spatra@nvidia.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v9 07/22] clk: Add API to get index of the clock parent
Message-ID: <20191108101116.GA2583136@ulmo>
References: <1565984527-5272-1-git-send-email-skomatineni@nvidia.com>
 <1565984527-5272-8-git-send-email-skomatineni@nvidia.com>
 <20191106231005.F2CD820869@mail.kernel.org>
 <fcc43ccb-8c6e-d518-4c70-503501706ffd@gmail.com>
 <20191107152115.GA2580600@ulmo>
 <20191107191933.0B18021D6C@mail.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
In-Reply-To: <20191107191933.0B18021D6C@mail.kernel.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 07, 2019 at 11:19:32AM -0800, Stephen Boyd wrote:
> Quoting Thierry Reding (2019-11-07 07:21:15)
> > On Thu, Nov 07, 2019 at 03:54:03AM +0300, Dmitry Osipenko wrote:
> > > 07.11.2019 02:10, Stephen Boyd =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > > > Quoting Sowjanya Komatineni (2019-08-16 12:41:52)
> > > >> This patch adds an API clk_hw_get_parent_index to get index of the
> > > >> clock parent to use during the clock restore operations on system
> > > >> resume.
> > > > =20
> > > > Is there a reason we can't save the clk hw index at suspend time by
> > > > reading the hardware to understand the current parent? The parent i=
ndex
> > > > typically doesn't matter unless we're trying to communicate somethi=
ng
> > > > from the framework to the provider driver. Put another way, I would
> > > > think the provider driver can figure out the index itself without h=
aving
> > > > to go through the framework to do so.
> > >=20
> > > Isn't it a bit wasteful to duplicate information about the parent wit=
hin
> > > a provider if framework already has that info? The whole point of this
> > > new API is to allow providers to avoid that unnecessary duplication.
> > >=20
> > > Please note that clk_hw_get_parent_index is getting used only at the
> > > resume time and not at suspend.
> >=20
> > I agree with this. All of the information that we need is already cached
> > in the framework. Doing this in the driver would mean essentially adding
> > a "saved parent" field along with code to read the value at suspend time
> > to the three types of clocks that currently use this core helper.
>=20
> Don't we already have a "saved parent" field by storing the pointer to
> the clk_hw?
>=20
> >=20
> > That's certainly something that we *can* do, but it doesn't sound like a
> > better option than simply querying the framework for the value that we
> > need.
> >=20
>=20
> Let me say this another way. Why does this driver want to know the index
> that the framework uses for some clk_hw pointer? Perhaps it happens to
> align with the same value that hardware uses, but I still don't
> understand why the driver wants to know what the framework has decided
> is the index for some clk_hw pointer.
>=20
> Or is this something like "give me the index for the parent that the
> framework thinks I currently have but in reality don't have anymore
> because the register contents were wiped and we need to reparent it"?

Yeah, that's exactly what this is being used for. It's used to restore
the parent/child relationship during resume after the registers have
been wiped during supend.

> A generic API to get any index for this question is overkill and we should
> consider adding some sort of API like clk_hw_get_current_parent_index(),
> or a framework flag that tells the framework this parent is incorrect
> and we need to call the .set_parent() op again to reconfigure it.

Okay, I think I see what you're saying. The current implementation does
carry a bit of a risk because users could be calling this function with
any arbitrary pair of struct clk_hw *, even completely unrelated ones.

How about we turn it into this instead:

	/**
	 * clk_hw_get_parent_index - return the index of the parent clock
	 * @hw: clk_hw associated with the clk being consumed
	 *
	 * Fetches and returns the index of parent clock. Returns -EINVAL if the g=
iven
	 * clock does not have a current parent.
	 */
	int clk_hw_get_parent_index(struct clk_hw *hw)
	{
		struct clk_hw *parent =3D clk_hw_get_parent(hw);

		if (!parent)
			return -EINVAL;

		return clk_fetch_parent_index(hw->core, parent->core);
	}
	EXPORT_SYMBOL_GPL(clk_hw_get_parent_index);

I think that has the advantage that we can't pass it a parent that's not
really a parent. There's still the slightly weird case where the clock
doesn't have a current parent, but hopefully that's something we are not
going to encounter much. After all this only makes sense to be called on
mux clocks and they always do have a parent by definition.

Perhaps we should be more explicit and wrap that !parent conditional in
a WARN_ON()? In my local patches I do that at the call sites because
they are all functions returning void, so we'd be silently ignoring the
cases, but I think it may make sense to have it in the core.

Any thoughts?

Thierry

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl3FP0EACgkQ3SOs138+
s6H+Bw//V4AfdobAVh0YsffM4tSxdtWE5m8ZAqM3xgrS/NoFHHetMX+N9eHliery
eLURmpRvOPp7etDHteGRglIHaLqyMUvhvixOgurPno5G/TNlDsgdnhVXwiurA35Y
ybKZXcAcHweSMyo6ACaog7RWrgagSmCiE3dceWVqdKg0YcFWFvjq0Opy6Y8unDVi
AQBr7+pHyq2FWIvnRxKm96fwT8Wnnct5M99U3G1kegwqA0aLk4IK+bqPeRNFSF+t
qxFyc29HwSTS9n/a3g8qxmPFtPDBeqT4bMFm5oJymJHmXnE6Q6extVl3PenKTLiR
O7K6cpQpLO81rK0gS7yaKAKBWXIJBV0aIcMyxIraHS+yl2/WsPXjgCj8NanmDmbW
2odq4/nLGDeq6Gs0Epz8mb2BwZgCzLZnDjqnTbYWnEI/aq/0ommL7sr6n9WXgyDm
QkiCDMusDiW9rNIWUHibu4IhnkyjX1MJKrT/lvz6zJEURZhs3vnWzaxGyvFPuTt6
UGJ+E8Y0akYQNJzTUM+3v5OGKrsMRuzgPRTPgOdd+bvgrDsVNvDF5ckSd6DZgqGR
P09Ip4mXTO0OouCybVXmJWX9D40UthDDD1HLUqx22Chqhydt2u2d1NC55AnSahYu
HM72GcbB7XmYNGW+HqEuCAq3L++coTgb0do5xaRiFtOz2V2gEtU=
=ZzEg
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
