Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1B4FF5438
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2019 19:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733267AbfKHSzO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Nov 2019 13:55:14 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43943 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731463AbfKHSzK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Nov 2019 13:55:10 -0500
Received: by mail-wr1-f67.google.com with SMTP id n1so8176699wra.10;
        Fri, 08 Nov 2019 10:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2KyI5gG8oVKGdduHO94dhipbyaNzTl+pTbVN+jLWvE8=;
        b=ocVV6cboSI8o8e10ePYmnHUlp8pRAG9HE1jAUwocW1ZJ0WtpMd9ZJvYd0JGFOz3G36
         FQveUb1XsIoT+3wGKt8i5OqVgJe+1GuYQlpqWdf0W6sh6q42nI2jaK1gwRKEo9q2IP6M
         ebqYghCn7e191hL+Z8GTxxybkdLhPUSUPegDwGOZDgGvDpV8uqkAoJvwsdGKowRlc0KA
         +a4m1LeazYWOJyP3No6IfcG1urAaZ1+lKhg6JC53IGnYLWaeNAV/NSHevc/ImOG1qu8f
         U2/dMPw3NZCgfLzAESELyU6/ldFNx8ntnIKCUPcfOlb/ur/OlXvFf6Wk7Sq6vfHGow1x
         yJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2KyI5gG8oVKGdduHO94dhipbyaNzTl+pTbVN+jLWvE8=;
        b=AXiriMWWhcpAdJqWr4NpFHUR7SsJKdYkVGSRNqB8iu4kPIR9uUIM6F4VT+8oDcNeEG
         Qei1QAog926+hZXPf2T+89tcY71D7SystXNQfntXadrw8nnUfDee6IECvLuv3s+D9Y9/
         apjpKGN8YwINCYa1EAHwnXXkeVCnMEua4LINlFNo49XJ6lKxH0n0cWN3NfOwU2GhNuke
         WfPIasxA7KpvKMcEUJmBAo5+R1+NVeMahpHwymu/JaysVP8WDgWq3JzDqDqikcBtHo6m
         3ALj+OvF49v7yNy/SJvaVxC6ZqbDF8zm3/gMZcqb0hadutfN7DLGQAp29FCaMfEtltv3
         V8uw==
X-Gm-Message-State: APjAAAVIWfokh4nFR0eo8CN57bzAGsCYNJjAO0rUuFk5lWNB1biVXpJN
        PQJ4e/NsXG5oIf+gEV6BrJI=
X-Google-Smtp-Source: APXvYqyP4b/9kyOlrHoWxin14xG0RX2vUrlMCwQOwPrHHPU0pDDjbjSpVlNWXYQAdVY9UY0iGXhR8g==
X-Received: by 2002:adf:c413:: with SMTP id v19mr9438321wrf.208.1573239306854;
        Fri, 08 Nov 2019 10:55:06 -0800 (PST)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id g14sm7679466wro.33.2019.11.08.10.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 10:55:05 -0800 (PST)
Date:   Fri, 8 Nov 2019 19:55:03 +0100
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
Message-ID: <20191108185503.GB3384779@ulmo>
References: <1565984527-5272-1-git-send-email-skomatineni@nvidia.com>
 <1565984527-5272-8-git-send-email-skomatineni@nvidia.com>
 <20191106231005.F2CD820869@mail.kernel.org>
 <fcc43ccb-8c6e-d518-4c70-503501706ffd@gmail.com>
 <20191107152115.GA2580600@ulmo>
 <20191107191933.0B18021D6C@mail.kernel.org>
 <20191108101116.GA2583136@ulmo>
 <20191108181249.E284E214DB@mail.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jho1yZJdad60DJr+"
Content-Disposition: inline
In-Reply-To: <20191108181249.E284E214DB@mail.kernel.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--jho1yZJdad60DJr+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 08, 2019 at 10:12:49AM -0800, Stephen Boyd wrote:
> Quoting Thierry Reding (2019-11-08 02:11:16)
> > On Thu, Nov 07, 2019 at 11:19:32AM -0800, Stephen Boyd wrote:
> > > Quoting Thierry Reding (2019-11-07 07:21:15)
> > > > On Thu, Nov 07, 2019 at 03:54:03AM +0300, Dmitry Osipenko wrote:
> > > > > 07.11.2019 02:10, Stephen Boyd =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > > > > > Quoting Sowjanya Komatineni (2019-08-16 12:41:52)
> > > > > >> This patch adds an API clk_hw_get_parent_index to get index of=
 the
> > > > > >> clock parent to use during the clock restore operations on sys=
tem
> > > > > >> resume.
> > > > > > =20
> > > > > > Is there a reason we can't save the clk hw index at suspend tim=
e by
> > > > > > reading the hardware to understand the current parent? The pare=
nt index
> > > > > > typically doesn't matter unless we're trying to communicate som=
ething
> > > > > > from the framework to the provider driver. Put another way, I w=
ould
> > > > > > think the provider driver can figure out the index itself witho=
ut having
> > > > > > to go through the framework to do so.
> > > > >=20
> > > > > Isn't it a bit wasteful to duplicate information about the parent=
 within
> > > > > a provider if framework already has that info? The whole point of=
 this
> > > > > new API is to allow providers to avoid that unnecessary duplicati=
on.
> > > > >=20
> > > > > Please note that clk_hw_get_parent_index is getting used only at =
the
> > > > > resume time and not at suspend.
> > > >=20
> > > > I agree with this. All of the information that we need is already c=
ached
> > > > in the framework. Doing this in the driver would mean essentially a=
dding
> > > > a "saved parent" field along with code to read the value at suspend=
 time
> > > > to the three types of clocks that currently use this core helper.
> > >=20
> > > Don't we already have a "saved parent" field by storing the pointer to
> > > the clk_hw?
> > >=20
> > > >=20
> > > > That's certainly something that we *can* do, but it doesn't sound l=
ike a
> > > > better option than simply querying the framework for the value that=
 we
> > > > need.
> > > >=20
> > >=20
> > > Let me say this another way. Why does this driver want to know the in=
dex
> > > that the framework uses for some clk_hw pointer? Perhaps it happens to
> > > align with the same value that hardware uses, but I still don't
> > > understand why the driver wants to know what the framework has decided
> > > is the index for some clk_hw pointer.
> > >=20
> > > Or is this something like "give me the index for the parent that the
> > > framework thinks I currently have but in reality don't have anymore
> > > because the register contents were wiped and we need to reparent it"?
> >=20
> > Yeah, that's exactly what this is being used for. It's used to restore
> > the parent/child relationship during resume after the registers have
> > been wiped during supend.
>=20
> Ok cool. Our whole suspend/resume and save/restore story hasn't really
> been well thought out so we may want to pull all this logic into the
> core one day. For now it's OK to do the heavy lifting from provider
> drivers until someone gets a better grasp on how this should all work.

Ah, that would explain why I was scratching my head trying to understand
how exactly this was supposed to work. It did feel like there was some
infrastructure there, but looking around there wasn't a very consistent
usage pattern that I could find.

I think suspend/resume is always a little tricky. For example the clocks
may required a slightly different logical sequences between SoCs. Maybe
even different types of clocks have different needs. We seem to have a
bit of that on Tegra alone already. Without having delved into this too
much, it seems to me like the core can't do a whole lot without stepping
(potentially) on drivers' toes.

The current save_context/restore_context seems to be mostly that,
though, so I think it's a good starting point. You're right that we may
eventually see clearer patterns appear.

> > > A generic API to get any index for this question is overkill and we s=
hould
> > > consider adding some sort of API like clk_hw_get_current_parent_index=
(),
> > > or a framework flag that tells the framework this parent is incorrect
> > > and we need to call the .set_parent() op again to reconfigure it.
> >=20
> > Okay, I think I see what you're saying. The current implementation does
> > carry a bit of a risk because users could be calling this function with
> > any arbitrary pair of struct clk_hw *, even completely unrelated ones.
> >=20
> > How about we turn it into this instead:
> >=20
> >         /**
> >          * clk_hw_get_parent_index - return the index of the parent clo=
ck
> >          * @hw: clk_hw associated with the clk being consumed
> >          *
> >          * Fetches and returns the index of parent clock. Returns -EINV=
AL if the given
> >          * clock does not have a current parent.
> >          */
> >         int clk_hw_get_parent_index(struct clk_hw *hw)
> >         {
> >                 struct clk_hw *parent =3D clk_hw_get_parent(hw);
> >=20
> >                 if (!parent)
> >                         return -EINVAL;
> >=20
> >                 return clk_fetch_parent_index(hw->core, parent->core);
> >         }
> >         EXPORT_SYMBOL_GPL(clk_hw_get_parent_index);
> >=20
> > I think that has the advantage that we can't pass it a parent that's not
> > really a parent. There's still the slightly weird case where the clock
> > doesn't have a current parent, but hopefully that's something we are not
> > going to encounter much. After all this only makes sense to be called on
> > mux clocks and they always do have a parent by definition.
>=20
> Right.
>=20
> >=20
> > Perhaps we should be more explicit and wrap that !parent conditional in
> > a WARN_ON()? In my local patches I do that at the call sites because
> > they are all functions returning void, so we'd be silently ignoring the
> > cases, but I think it may make sense to have it in the core.
> >=20
>=20
> Sure a WARN_ON() sounds fair. That will not take the whole task down
> and makes sure that drivers aren't doing something incorrect. Otherwise,
> this looks good and we can optimize by caching the parent index later if
> we really need to.

Okay, great. I'll go replace the above patch in the branch that I have.
I'm not sure if you saw it, but I had sent this in a pull request for
v5.5-rc1 about a week ago because I've got Tegra clock driver patches
that depend on this. I can replace this patch with the above proposal
and update the Tegra clock driver branch and then resend the two pull
requests.

Does that sound like a plan?

Thierry

--jho1yZJdad60DJr+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl3FugUACgkQ3SOs138+
s6EQnA//ZiKo3c49mc3rsgWD2GUXNTxh3pb93HOaHIv0hvAKb0CmP/Z9xuJt4UJY
B6EudUqwiDLKL/Nu6xeiS9+FwHOP+ZQUnbVfnCCGHNogxh5HYnH7Z7NiA4RjiZwx
TtaUGS2nwnFMcVOygJQ3oAwJys/tW9N2JKafqhFyY3ipuRCQtTUAM7k+6PZpVWP+
sb+zJuR+0cwzpTKyfKhSxgK6gxM4Ka2jrU3jFHY8j2KYERu+sQa9Z3Jz93dxobEK
A6un4q3A+323alhaeb/YkD0E+Xf9w+/DNcmxpzHNPqhGQ9J/M9omN77JlVqtALZP
iZ+heRWCvqJt6HB8P00EizQqr8vDm+pgqVQyVIgVU8uDb2YfXlFhgyPQtgY55zxK
q5BAhBCjxCOPVuqsCq5tGsDO9CcbZWVFDYSfC5KNZDR2WwX5ZfcvjKEkKQX/c7zm
dV93eius5LPzgQRIcofaslwrUaFwN2mI/jwk2RFL9FEvENQwQ5gzE+aYtwUofcWB
nhuP1N3dSicuAOQQDfpw6Llv4t23ccjPaKJi7UOkJWljw73UJsqp269/Ae72SgZc
fcolymTmqmgEm+Lm9G6yG+xUcSkz6T5MsnWavSUifpWmFeae0XNz02wSHVAhEVdC
4T2kV5R7iPuABKmDLwrbWFKPNEGWZU1jbl8Kk5DQMSwUu0h2GdA=
=N0dL
-----END PGP SIGNATURE-----

--jho1yZJdad60DJr+--
