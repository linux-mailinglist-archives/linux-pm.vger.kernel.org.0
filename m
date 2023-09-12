Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C0979D5C1
	for <lists+linux-pm@lfdr.de>; Tue, 12 Sep 2023 18:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjILQGI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Sep 2023 12:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbjILQGH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Sep 2023 12:06:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBF610EB
        for <linux-pm@vger.kernel.org>; Tue, 12 Sep 2023 09:06:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA50C433C8;
        Tue, 12 Sep 2023 16:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694534762;
        bh=Q/TEkMWLXQKDzVgkahRn+n43VpZCdu0lgRVofBA7+Q8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JpDQ5mpok4kTlzsx+0W8ao1sDPfIZK7GybvEEX/87ZRQSoz6ufqt0O629BFP0gQfW
         JXrGpqPM921dMCTs5Jb1Df87osNZhr5BaoeZI4wbBmipnKSJtiWPl/ttr+gdGobpb1
         AJyo8+zH60kbFZFfWoGgM3mNdCApQETLq5RxG8g8/tsnFT6OECEInSXKbdu3nZrugj
         O7UJSTAb5LWhHD8SCDamfH58UFh75LbaenlPmw/HDzoBJDd6cvdUdCftj3NUXGNdJL
         1YpZZ2plXX9+L/dU/YREAUYHzMQHsodMn++icX7y+dNAEYE332+gcjDfHAJ+Zoh2C4
         kg+zz/7Owl1rQ==
Date:   Tue, 12 Sep 2023 17:05:58 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     arnd@arndb.de,
        Changhuang Liang <changhuang.liang@starfivetech.com>,
        Walker Chen <walker.chen@starfivetech.com>,
        linux-riscv@lists.infradead.org, Rob Herring <robh@kernel.org>,
        Jia Jie Ho <jiajie.ho@starfivetech.com>,
        linux-pm@vger.kernel.org
Subject: Re: Missed soc/genpd PR for 6.6 mw
Message-ID: <20230912-postal-succulent-d83861d769ad@spud>
References: <20230911-scouring-squash-3ef2cc8b1ee2@spud>
 <CAPDyKFqB_2KiqYy1Li1sGkXPiEAnc2GOUO7SdqCxy5G+YkeLcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gdsE8Rlaoyspx0wO"
Content-Disposition: inline
In-Reply-To: <CAPDyKFqB_2KiqYy1Li1sGkXPiEAnc2GOUO7SdqCxy5G+YkeLcA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--gdsE8Rlaoyspx0wO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2023 at 11:09:51AM +0200, Ulf Hansson wrote:
> On Tue, 12 Sept 2023 at 00:11, Conor Dooley <conor@kernel.org> wrote:
> >
> > Hey all,
> >
> > So I've been informed that I made a hames of things and forgot to send
> > my soc driver PR for the 6.6 merge window. There's not too much in my
> > branch
> > https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/log/?h=
=3Driscv-soc-for-next
> > so I would've kicked the can to 6.7, but the majority of changes there =
were
> > made to the starfive pmu driver that has since moved to the new genpd
> > subsystem.
> >
> > Sending a PR to Arnd for 6.7 with the pmu bits & based on v6.5-rc1 does=
n't
> > seem to make all that much sense to me, since that stuff is no longer in
> > drivers/soc, but rebasing on top of v6.6-rc1 would make these genpd cha=
nges,
> > with a different path to Linus.
> >
> > What's the best way to rectify me screwing this up? Should I split out
> > the non genpd patch and send a PR for that for the genpd tree for 6.7?
>=20
> Yep, that seems like the best option.
>=20
> If you think it's better to re-post the re-based genpd patches, I can
> certainly pick them up from the mailing lists too.

Cool, I'll try to do one of the above tomorrow. Thanks!

--gdsE8Rlaoyspx0wO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQCMZgAKCRB4tDGHoIJi
0k/RAP0ZqY8mLJi3PfQkOA/0RkMdz91zRn/e7yBskW8Y/TgEQwEA50GlQEqMfL00
22snh32/SkoUK7nbNCGoVBF2nmqBKgY=
=FxtK
-----END PGP SIGNATURE-----

--gdsE8Rlaoyspx0wO--
