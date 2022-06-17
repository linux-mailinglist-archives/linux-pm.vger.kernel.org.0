Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D188854F6BA
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jun 2022 13:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381463AbiFQLbY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jun 2022 07:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbiFQLbY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jun 2022 07:31:24 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F225D6CAB2
        for <linux-pm@vger.kernel.org>; Fri, 17 Jun 2022 04:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Type:References:
        In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Content-Transfer-Encoding:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=jefMjbgczLCC5ZgjzWRovraHzwRQY6Wrol6OOhFMrGg=; t=1655465483; x=1656675083; 
        b=R1uQIsdKmxSUQ7WeAN8N5oY89+GBo1lj5c5jo94fBr+8QQcdAAsOO9cjgD6dQBwi/UDHAQyxWzk
        OrtzNbNMq3XV9lPJBGlApdecLL8/qJq39UwL32OCFBA9hCbR4MRmrifOn7AB6DJ7GsA5Ta4wfPFsS
        kyskQSD7eNVnUaKiCedPSoWS5NjChFqKCRDjG2Km0ltrtiMgn9jHD+TisTtqjCXSW/Odgkeh71xvW
        +tlJ3Kf3Q+cPv0kGYO3bIhD7wV7+bYEiZ1jVLbw8AVKqWQu64LybM/Mn2BMAE8tXGitltp4U5ybex
        DwCQvPUHus3SFnvziLDxqWSYLB4OvUk1M+Yg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <benjamin@sipsolutions.net>)
        id 1o2AC6-008QBa-S0;
        Fri, 17 Jun 2022 13:31:19 +0200
Message-ID: <e2f00afe78432a13adc23fc879f0631ada49e122.camel@sipsolutions.net>
Subject: Re: How to identify the primary battery (for Wine)
From:   Benjamin Berg <benjamin@sipsolutions.net>
To:     Alex Henrie <alexhenrie24@gmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Huw Davies <huw@codeweavers.com>, linux-pm@vger.kernel.org,
        Wine Devel <wine-devel@winehq.org>
Date:   Fri, 17 Jun 2022 13:31:13 +0200
In-Reply-To: <CAMMLpeSRQ4T=_J0uwjoh=NNeuO43-Nb3PkzfSoDdUhOfU8_TqQ@mail.gmail.com>
References: <CAMMLpeTRZnpQ8b6puhHeKaDgzW12ZM_g3nAWjVP71HbSaeHktQ@mail.gmail.com>
         <20220614141742.j7lrj2q5b3suebb2@mercury.elektranox.org>
         <CAMMLpeSRQ4T=_J0uwjoh=NNeuO43-Nb3PkzfSoDdUhOfU8_TqQ@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-5wajEyz9QuFVuGgvIWQj"
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-malware-bazaar-2: OK
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--=-5wajEyz9QuFVuGgvIWQj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2022-06-14 at 09:17 -0600, Alex Henrie wrote:
> On Tue, Jun 14, 2022 at 8:17 AM Sebastian Reichel
> <sebastian.reichel@collabora.com> wrote:
> > On Tue, Jun 14, 2022 at 2:05 AM Benjamin Berg <benjamin@sipsolutions.ne=
t> wrote:
> >=20
> > > Wouldn't it make sense for Wine to use the UPower provided
> > > DisplayDevice that can be queried through DBus?
> >=20
> > UPower does the required data aggregation for the 'DisplayDevice'.
> > I don't know enough about the Wine codebase to recommend for or
> > against using UPower.
>=20
> I also don't know if D-Bus would be a good choice here. It would
> certainly be a bigger change than the patch that I've proposed. What
> are the advantages and disadvantages of querying the battery through
> D-Bus, besides it doing battery aggregation for us?

Well, depends on what you need, it will:
 1. Calculate a energy/power values if the HW reports charge/current
 2. Try to generate a proper state (charging/discharging, etc.) if the
    hardware does not provide it
 3. Aggregate multiple batteries

Actually, I think using UPower likely fixes bugs:
 * You are currently not supporting modern hardware that reports
   energy/power values (rather than charge/current).
 * You are only reading one battery
 * You are not estimating a rate if the HW does not provide one
   (and not smoothing it which might be desirable).

And, well, it should be easy. You can just query properties on a fixed
DBus path. And if it fails, just assume you don't have a battery.

Benjamin

--=-5wajEyz9QuFVuGgvIWQj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEED2NO4vMS33W8E4AFq6ZWhpmFY3AFAmKsZgIACgkQq6ZWhpmF
Y3B98Q//c6DPf+GwS5QsjcgbZ6tC3z1emZTB5adhgfPwXjBrczBv66SfgBaitASz
3gtGIuQAF+Q7lhe5PVqufBHpbNHaxs1rwDYa6QvfYO3SIBUGf34A1mN+FnjXT0cv
Dmd6vXGHawK3/bM5i0rqSXa1Uezzkuj8Y4JHh+fdRxgfYyLA3V7LzR9OZP1EmR18
x6pxFPrSBcXXWq6amgGnMz7Pcxbn5nXR0QE1c6zfxQI/QO18Wu29zyozQx0iqseC
V6hf3P2JN2NFrL+gkptTcLMzEK3wzCJfst/HKH1HD8ZT8zPSsAuEJoY5j3IsXfCK
4DFCpgsaoyaDFypvd9Oa1Ous46aJOSXc4+leTsY9vaGYB8m23n5GjdwJRxVTu72l
U0QKclv5kN8daq7rzqJclDchgyNbbGg0YMnwbbQsuewfqPgJZL+WeXQ/OHFRtENx
ZAFnD0amRcfoDX/6RXIiGvntFjO5SJn+bhhk+JSEmkBafWrqS+0na2nONYgdvxnN
INK4m14caPTRcV+Gq49eInIwZ0ejInqtyqmqJfXy+cQNRHZTLD5xo54DzomClMTW
aihXdUWoj2XD2eifPdCPl1ZpH1UoJHi5/jAzqQwuWUzYMcWlEbphvbHw9Is+jxdQ
atqgfOUPYVv9x24zZix5fU6goGCmUJOZy9JRljFpd31CM1VbYZ4=
=QQox
-----END PGP SIGNATURE-----

--=-5wajEyz9QuFVuGgvIWQj--
