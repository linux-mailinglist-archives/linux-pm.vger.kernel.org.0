Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAAF83544E2
	for <lists+linux-pm@lfdr.de>; Mon,  5 Apr 2021 18:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbhDEQJ5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Apr 2021 12:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbhDEQJ5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Apr 2021 12:09:57 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FA6C061756;
        Mon,  5 Apr 2021 09:09:51 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id C355F1F44A04
Received: by earth.universe (Postfix, from userid 1000)
        id 27F6D3C0C96; Mon,  5 Apr 2021 18:09:47 +0200 (CEST)
Date:   Mon, 5 Apr 2021 18:09:47 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Ricardo Rivera-Matos <r-rivera-matos@ti.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] power: supply: bq25980 Apply datasheet revision
 changes
Message-ID: <20210405160947.l2i2yl6gbihbmv3g@earth.universe>
References: <20210210225646.10055-1-r-rivera-matos@ti.com>
 <20210211073603.fjguvzwpnna35hbw@kozik-lap>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cwo2xmcosnqf5vzm"
Content-Disposition: inline
In-Reply-To: <20210211073603.fjguvzwpnna35hbw@kozik-lap>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--cwo2xmcosnqf5vzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 11, 2021 at 08:36:03AM +0100, Krzysztof Kozlowski wrote:
> On Wed, Feb 10, 2021 at 04:56:45PM -0600, Ricardo Rivera-Matos wrote:
> > The latest datasheet revision for BQ25980, BQ25975, and BQ25960 changed
> >=20
> > various register step sizes and offset values.=20
> >=20
> > This patch changes the following header file
> >=20
> > values for POWER_SUPPLY_PROP_CURRENT_NOW,=20
> >=20
> > POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
> >=20
> > POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
> >=20
> > POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
> >=20
> > POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT, and POWER_SUPPLY_PROP_VOLTAGE_NO=
W.
> >=20
> > Additionally, this patch adjusts bq25980_get_input_curr_lim(),
> >=20
> > bq25980_set_input_curr_lim(), bq25980_get_const_charge_curr(), and
> >=20
> > bq25980_set_const_charge_curr() to perform the get/set math correctly.
>=20
> Your formatting is so odd, it is not readable. Please open "git log" and
> try to write something similar to existing commits, e.g. without
> additional blank line between lines.

Ack. This is a paint to read.

>=20
> >=20
> > Fixes: 5069185fc18e ("power: supply: bq25980: Add support for the BQ259=
xx family")
> > Signed-off-by: Ricardo Rivera-Matos <r-rivera-matos@ti.com>
> > ---
> >  drivers/power/supply/bq25980_charger.c | 141 ++++++++++++++++++++-----
> >  drivers/power/supply/bq25980_charger.h |  77 ++++++++++----
> >  2 files changed, 173 insertions(+), 45 deletions(-)
> >=20
> > diff --git a/drivers/power/supply/bq25980_charger.c b/drivers/power/sup=
ply/bq25980_charger.c
> > index 530ff4025b31..7c489a9e8877 100644
> > --- a/drivers/power/supply/bq25980_charger.c
> > +++ b/drivers/power/supply/bq25980_charger.c
> > @@ -52,6 +52,10 @@ struct bq25980_chip_info {
> >  	int busocp_byp_max;
> >  	int busocp_sc_min;
> >  	int busocp_byp_min;
> > +	int busocp_sc_step;
> > +	int busocp_byp_step;
> > +	int busocp_sc_offset;
> > +	int busocp_byp_offset;
>=20
> Does not look like related to changing offsets of register values in
> header.

well looking at the change as a whole the problem is that each
chip has different offset/step size now. Arguably this is an
atomic change. I would have queued it (fixing the commit message
while applying), but the patch also does some unrelated changes:

 - introduced usage of clamp instead of min()/max() checks
   (which is great, but should be separate commit!)
 - rename variables to something more sensible in
   bq25980_get_adc_vbat (again a great change, but should be
   separate commit)

Ricardo, please submit a new version with these changes splitted
out.

-- Sebastian

--cwo2xmcosnqf5vzm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmBrNkUACgkQ2O7X88g7
+prVghAAiW4U1RmvIsGe1wO8bxYr9eZQ4W/dhA3YRslkWOmRxA8icvfZgv3rjI9X
E487nf+sLB/JEAs9txNEQzGtXQCJ0G9p17oVU2E/ZSM6ltRN9ec0NrcMHVfEXLNk
aThWYNH1afP3SWInhV4fI+Et2guEsCjts7YLHfTFEss+QEvnGflandYSzg1f8tnJ
N8jSuKkWB6bUjo13MZXiMG8Uy3SJyC4za0i3AhOfrSIIKJq8e1K4udghc3VQMpJ2
HXpIIDVU3htMoGboLPuM+Fr8f0eDbLRV3lhtKSjOmivIU4ncHwHhPc559oHny7Br
FmMPJJF3a5zfk/YZ8PPxjXdlJCSEeldCus3Gey8Fs/weW5G0d4UaXjNq7xF/MfcR
TRzWyMoMceibbbpfw/CytsooGdCNyKKWiASLh93CeL9yUnc7dNQyKgPHhXEIOR23
LMYm1vC2cg4xGxqmrTyGx3n7VpcZl7iwT/nkPFV3ixqwPDRUCD+NxXeGQLukAdqU
8egmw/3l1L1lmJCderQGVq4GUWBq2AOQlkcvki1SlAaWOqvkMSgtSCBdEqcq2LrD
Rg7wTKur68iuLLX4EICpBfsrq1dKFF4H9/sUGRD+Vi20ggr+ahIXrKRjchC37/Zo
mc8YCh2faWrGrCW9O3iAp1WmqhY3cidGpqlGuBd2qIA0ArgEYZI=
=WM2U
-----END PGP SIGNATURE-----

--cwo2xmcosnqf5vzm--
