Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 707C1F534D
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2019 19:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbfKHSMv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Nov 2019 13:12:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:36316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbfKHSMv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 8 Nov 2019 13:12:51 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E284E214DB;
        Fri,  8 Nov 2019 18:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573236770;
        bh=ELQr5f48u8UP3gTQ4f0O6v3rgM59jKm+kt9ggY9rv9s=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date:From;
        b=bOSP1g9YSgcPhvpPAlL+a9JRxoTij3qU1HwCLePyjL/IOXi+sJLpbHKsEH1gLuhqO
         AhekoDy5jkd3MDdy7HhsZZoxylHaNfro54qAvKiCVLal478ISREwfbOcvq5jWDC4W2
         2RYU+3Bt4uPMUGJxhiOjNEqvgvwJuki6MI+L4owo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191108101116.GA2583136@ulmo>
References: <1565984527-5272-1-git-send-email-skomatineni@nvidia.com> <1565984527-5272-8-git-send-email-skomatineni@nvidia.com> <20191106231005.F2CD820869@mail.kernel.org> <fcc43ccb-8c6e-d518-4c70-503501706ffd@gmail.com> <20191107152115.GA2580600@ulmo> <20191107191933.0B18021D6C@mail.kernel.org> <20191108101116.GA2583136@ulmo>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
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
User-Agent: alot/0.8.1
Date:   Fri, 08 Nov 2019 10:12:49 -0800
Message-Id: <20191108181249.E284E214DB@mail.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Thierry Reding (2019-11-08 02:11:16)
> On Thu, Nov 07, 2019 at 11:19:32AM -0800, Stephen Boyd wrote:
> > Quoting Thierry Reding (2019-11-07 07:21:15)
> > > On Thu, Nov 07, 2019 at 03:54:03AM +0300, Dmitry Osipenko wrote:
> > > > 07.11.2019 02:10, Stephen Boyd =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > > > > Quoting Sowjanya Komatineni (2019-08-16 12:41:52)
> > > > >> This patch adds an API clk_hw_get_parent_index to get index of t=
he
> > > > >> clock parent to use during the clock restore operations on system
> > > > >> resume.
> > > > > =20
> > > > > Is there a reason we can't save the clk hw index at suspend time =
by
> > > > > reading the hardware to understand the current parent? The parent=
 index
> > > > > typically doesn't matter unless we're trying to communicate somet=
hing
> > > > > from the framework to the provider driver. Put another way, I wou=
ld
> > > > > think the provider driver can figure out the index itself without=
 having
> > > > > to go through the framework to do so.
> > > >=20
> > > > Isn't it a bit wasteful to duplicate information about the parent w=
ithin
> > > > a provider if framework already has that info? The whole point of t=
his
> > > > new API is to allow providers to avoid that unnecessary duplication.
> > > >=20
> > > > Please note that clk_hw_get_parent_index is getting used only at the
> > > > resume time and not at suspend.
> > >=20
> > > I agree with this. All of the information that we need is already cac=
hed
> > > in the framework. Doing this in the driver would mean essentially add=
ing
> > > a "saved parent" field along with code to read the value at suspend t=
ime
> > > to the three types of clocks that currently use this core helper.
> >=20
> > Don't we already have a "saved parent" field by storing the pointer to
> > the clk_hw?
> >=20
> > >=20
> > > That's certainly something that we *can* do, but it doesn't sound lik=
e a
> > > better option than simply querying the framework for the value that we
> > > need.
> > >=20
> >=20
> > Let me say this another way. Why does this driver want to know the index
> > that the framework uses for some clk_hw pointer? Perhaps it happens to
> > align with the same value that hardware uses, but I still don't
> > understand why the driver wants to know what the framework has decided
> > is the index for some clk_hw pointer.
> >=20
> > Or is this something like "give me the index for the parent that the
> > framework thinks I currently have but in reality don't have anymore
> > because the register contents were wiped and we need to reparent it"?
>=20
> Yeah, that's exactly what this is being used for. It's used to restore
> the parent/child relationship during resume after the registers have
> been wiped during supend.

Ok cool. Our whole suspend/resume and save/restore story hasn't really
been well thought out so we may want to pull all this logic into the
core one day. For now it's OK to do the heavy lifting from provider
drivers until someone gets a better grasp on how this should all work.

>=20
> > A generic API to get any index for this question is overkill and we sho=
uld
> > consider adding some sort of API like clk_hw_get_current_parent_index(),
> > or a framework flag that tells the framework this parent is incorrect
> > and we need to call the .set_parent() op again to reconfigure it.
>=20
> Okay, I think I see what you're saying. The current implementation does
> carry a bit of a risk because users could be calling this function with
> any arbitrary pair of struct clk_hw *, even completely unrelated ones.
>=20
> How about we turn it into this instead:
>=20
>         /**
>          * clk_hw_get_parent_index - return the index of the parent clock
>          * @hw: clk_hw associated with the clk being consumed
>          *
>          * Fetches and returns the index of parent clock. Returns -EINVAL=
 if the given
>          * clock does not have a current parent.
>          */
>         int clk_hw_get_parent_index(struct clk_hw *hw)
>         {
>                 struct clk_hw *parent =3D clk_hw_get_parent(hw);
>=20
>                 if (!parent)
>                         return -EINVAL;
>=20
>                 return clk_fetch_parent_index(hw->core, parent->core);
>         }
>         EXPORT_SYMBOL_GPL(clk_hw_get_parent_index);
>=20
> I think that has the advantage that we can't pass it a parent that's not
> really a parent. There's still the slightly weird case where the clock
> doesn't have a current parent, but hopefully that's something we are not
> going to encounter much. After all this only makes sense to be called on
> mux clocks and they always do have a parent by definition.

Right.

>=20
> Perhaps we should be more explicit and wrap that !parent conditional in
> a WARN_ON()? In my local patches I do that at the call sites because
> they are all functions returning void, so we'd be silently ignoring the
> cases, but I think it may make sense to have it in the core.
>=20

Sure a WARN_ON() sounds fair. That will not take the whole task down
and makes sure that drivers aren't doing something incorrect. Otherwise,
this looks good and we can optimize by caching the parent index later if
we really need to.

