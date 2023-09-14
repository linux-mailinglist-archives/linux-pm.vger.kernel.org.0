Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C267A0956
	for <lists+linux-pm@lfdr.de>; Thu, 14 Sep 2023 17:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241031AbjINPeH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Sep 2023 11:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240810AbjINPeG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Sep 2023 11:34:06 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A42A1FCC
        for <linux-pm@vger.kernel.org>; Thu, 14 Sep 2023 08:34:02 -0700 (PDT)
Received: from mercury (dyndsl-091-248-132-131.ewe-ip-backbone.de [91.248.132.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DF0BB660734B;
        Thu, 14 Sep 2023 16:34:00 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694705641;
        bh=y8R0Xznzs6L8wv2XEwEwm152ybd7uMQ3GP8JesTIT2o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QpcpZCH4OvyhOBcEqfPNJLcRag6sW4przhv5T++zVOfH9uK9xaVJIWbRPyDP1AkkM
         YwTE/paDwfxVL5f9nbETTlfcdS+E9MD21x82r1+QnyRC5wP7B1yzzBoDojs6rtgH0B
         P1x6L90LdJsWammXnEkroy7quRrHbQhazdK8jqcnnSK6F1Oal0Zikmdspl56msNemt
         /lOJ/Ve75fduN2xRbOebaKW+p63Q12xkGIpuKmSGGPhiLeIH1pekfv7NGXYOcI3Zrw
         pesMnOHAvLloV+HwUnKAMjFeOZfZ7ECqNzHXV6uIO6cz3Oei3lv61TLXCcEGpWj2JC
         FrAFl14L51GVg==
Received: by mercury (Postfix, from userid 1000)
        id C2DE4106098B; Thu, 14 Sep 2023 17:33:58 +0200 (CEST)
Date:   Thu, 14 Sep 2023 17:33:58 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     linux-pm@vger.kernel.org
Subject: Re: (subset) [PATCH v6 06/10 RESEND] power: supply: rt5033_charger:
 Add cable detection and USB OTG supply
Message-ID: <20230914153358.e2ycsyic4xpohc5l@mercury.elektranox.org>
References: <cover.1684182964.git.jahau@rocketmail.com>
 <223b440ab6831f2e7302d2c49b2cfd7779d5effd.1684182964.git.jahau@rocketmail.com>
 <169226510772.947223.494995318945916008.b4-ty@kernel.org>
 <20230822070737.GP1380343@google.com>
 <20230822212909.mcnziqsuu523e4gk@mercury.elektranox.org>
 <96c08475-72e7-9ef4-2f16-e962f9338e78@rocketmail.com>
 <20230904142717.GD13143@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pvjx25gep5nip3le"
Content-Disposition: inline
In-Reply-To: <20230904142717.GD13143@google.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--pvjx25gep5nip3le
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jakob,

On Mon, Sep 04, 2023 at 03:27:17PM +0100, Lee Jones wrote:
> On Sun, 03 Sep 2023, Jakob Hauser wrote:
> > Hi Sebastian,
> > On 22.08.23 23:29, Sebastian Reichel wrote:
> > > On Tue, Aug 22, 2023 at 08:07:37AM +0100, Lee Jones wrote:
> > > > On Thu, 17 Aug 2023, Lee Jones wrote:
> > > >=20
> > > > > On Mon, 15 May 2023 22:57:15 +0200, Jakob Hauser wrote:
> > > > > > Implement cable detection by extcon and handle the driver accor=
ding to the
> > > > > > connector type.
> > > > > >=20
> > > > > > There are basically three types of action: "set_charging", "set=
_otg" and
> > > > > > "set_disconnect".
> > > > > >=20
> > > > > > A forth helper function to "unset_otg" was added because this i=
s used in both
> > > > > > "set_charging" and "set_disconnect". In the first case it cover=
s the rather
> > > > > > rare event that someone changes from OTG to charging without di=
sconnect. In
> > > > > > the second case, when disconnecting, the values are set back to=
 the ones from
> > > > > > initialization to return into a defined state.
> > > > > >=20
> > > > > > [...]
> > > > >=20
> > > > > Applied, thanks!
> > > > >=20
> > > > > [06/10] power: supply: rt5033_charger: Add cable detection and US=
B OTG supply
> > > > >          commit: c1af6bcc8583b0a1083338cd26c2090d0bcb0810
> > > >=20
> > > > Multiple fixes now follow this patch, so I am unapplying it.
> > > >=20
> > > > Sebastian, would you mind collecting it up please?
> > >=20
> > > I'm leaving for a two week hiking trip (with basically no internet
> > > access) in some hours. My planed return date is basically when Linus
> > > is expected to tag 6.6-rc1, so I will not queue any more patches and
> > > send my pull request early (within the next few hours).
> > >=20
> > > I planned to catch up with the power-supply backlog last week during
> > > Chaos Communication Camp, but it was too hot to do any sensible
> > > review. Now I expect to process the power-supply backlog in the
> > > week after the merge window.
> >=20
> > The patch 6 of the rt5033-charger series v6 gathered some issues. For a=
ll of
> > them a solution was provided. Thanks to everyone involved! However, I d=
on't
> > know what's the best way to put them together.
> >=20
> > - As the patch 6 was forgotten to apply with the others of the
> >   patchset, in the meantime another small patch by Rob sneaked in. The
> >   patch 6 needs to be rebased on Rob's patch. It affects the includes.
> >   Would be nice to order them alphabetically after rebase.
> >=20
> > - After patch 6 was added on top of Rob's patch in linux-next, there
> >   was a build failure. This is because "linux/of.h" now explicitly
> >   needs to be added to the rt5033-charger driver. Stephen Rothwell
> >   provided a fix. I'm not sure on the order: Maybe that needs to be
> >   added before adding patch 6 to avoid the build failure when the
> >   kernel test bot checks each commit separately.
> >=20
> > https://lore.kernel.org/linux-next/20230821125741.3a2474d7@canb.auug.or=
g.au/T/#u
> >=20
> > - Beyond that, the kernel test bot also complained about undefined
> >   reference related to extcon. I didn't understand why this happens
> >   because the driver has "linux/extcon.h" included. Randy was attentive
> >   and provided a fix. Here again I'm not sure about the order, I guess
> >   this should be added before adding patch 6 to avoid build failures if
> >   each commit is tested separately.
> >   Kernel test bot complaints:
> >     x86_64 clang https://lore.kernel.org/oe-kbuild-all/202308220324.LsI=
8q3ML-lkp@intel.com/T/#u
> >     x86_64 gcc https://lore.kernel.org/oe-kbuild-all/202308240723.O2rW0=
InU-lkp@intel.com/T/#u
> >     arm gcc https://lore.kernel.org/oe-kbuild-all/202308250617.ue4uQxWa=
-lkp@intel.com/T/#u
> >   Fix by Randy:
> >=20
> > https://lore.kernel.org/linux-pm/20230828224201.26823-1-rdunlap@infrade=
ad.org/T/#u
> >=20
> > - Yang noticed that the mutex_unlock() is not handled correctly in
> >   some error path and provided a fix:
> >=20
> > https://lore.kernel.org/linux-pm/20230822030207.644738-1-yangyingliang@=
huawei.com/T/#u
> >=20
> > - There are two clean-up patches by me. They need to be rebased to the
> >   patches mentioned above but there shouldn't be conflicts with them.
> >=20
> > https://lore.kernel.org/linux-pm/cover.1686948074.git.jahau@rocketmail.=
com/T/#u
> >=20
> > Please also note that the commit hash in the linked fixes above refers =
to
> > linux-next, where the patch 6 had been applied. As the patch was dropped
> > later on, I don't know what this means for the commit hashes in the fix=
es.
> >=20
> > What's the best way to proceed? Can you put these patches together? Or =
do
> > you want me something to do?
>=20
> You need to do this yourself.
>=20
> Rebase all of the fixes on top of v6.6-rc1 (which will be released in a
> little under a week).  Ensure that each patch builds as it's applied so
> as not to harm bisecability.  If you have to squash them to prevent
> built-breakages, then so be it, but don't forget to credit the
> contributors.  Once complete, post as a set and we'll take it from
> there.

Fully agreed. I expect to see a new series with the missing bits.

-- Sebastian

--pvjx25gep5nip3le
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmUDJ+IACgkQ2O7X88g7
+prUUg/9EHbtQJ95Lty12pyr1Z301FHiOH4f2qHbOAxe+5+IlXxMSLHfD0aNjl83
2PQAKq2/UUOqzgcY15diauh/YVCr49KaW7uF5JEefz52Zfmmtwpq/PVAdxoa6wXV
9pDj6omfE/kmzLeNQl8V0iNquz02wtZZXt17M0vtCpRbk8Avuj3OE3ssmbVF6Spq
ZkQKo2tD2oBT1/fh5k+W76OTjKPkHHnjljQWEAwTmMRetWDc6M55rNk2Vr0YrgGY
cWj7uEsD79kjv0F3/9Eko3YsEy9CPWnD6znJKdFEUsoxdxH5gdH51HtfjmLwbAQK
QyohiHj8anrP/7394HmiWEzHPDYsk4Sin2Hup5PI8IoqXV4vDa+FmCTajwuy6QC/
T8iBDAPGK5q+vQzmqgezhit0zECqEboiQwlXKDl84SjO11tv/S1MLpjpqkc0Z2aD
8WVdovUVkavPlzIs+lAqRhTdqNXSaVJd4e1LFZMoSYWl7k6HoVxPiPaj1TgAu0Iq
mcBvp2puwlK3KBDarKImjAm8tfHRkwH/btF7dYXoYVjWaeUeF8xuGu5gclBbZCFf
HH8G3OQIRBKDYPi8K3FngchfvTYBGuo/a3DpdUxapidTwEJ5MwBRxnN/HHc5G0u8
NifM3fA9IwFKscO5e3zt+uiyiZ2ASuPatjdafpM9VnNB01+YfX8=
=ia1f
-----END PGP SIGNATURE-----

--pvjx25gep5nip3le--
