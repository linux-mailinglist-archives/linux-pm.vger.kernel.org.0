Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 932832322FF
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jul 2020 18:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgG2Q6t (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jul 2020 12:58:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:60776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbgG2Q6t (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 Jul 2020 12:58:49 -0400
Received: from earth.universe (dyndsl-095-033-172-175.ewe-ip-backbone.de [95.33.172.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6ECA2075F;
        Wed, 29 Jul 2020 16:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596041928;
        bh=l2TFwckTjlwlu/sf+JdNkZncU/9Xq195XSmtepPQo7U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xkJihn2ieLuuUYWiONWMlWgh8quAG8cx/gQz/m/GiiHdmHHTNyypnZo6o2dKit/a2
         +LloyAPie6+EicGBilGolSiwDUyxXqVWRvmgawOHz6TZtnPSUq3p5Dt4xJ+MskGDgU
         5js/3MgnXaB6iL31vcIysmQz3WC7NdwxPf1CtVb0=
Received: by earth.universe (Postfix, from userid 1000)
        id 08ECB3C0B87; Wed, 29 Jul 2020 18:58:47 +0200 (CEST)
Date:   Wed, 29 Jul 2020 18:58:46 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] power: supply: cpcap-battery: Fix kerneldoc of
 cpcap_battery_read_accumulated()
Message-ID: <20200729165846.zn2ueisucuxvsufb@earth.universe>
References: <20200729074348.28317-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n6kmyzh77xefgz2r"
Content-Disposition: inline
In-Reply-To: <20200729074348.28317-1-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--n6kmyzh77xefgz2r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 29, 2020 at 09:43:47AM +0200, Krzysztof Kozlowski wrote:
> Fix W=3D1 compile warnings (invalid kerneldoc):
>=20
>     drivers/power/supply/cpcap-battery.c:292: warning: Function parameter=
 or member 'ccd' not described in 'cpcap_battery_read_accumulated'
>     drivers/power/supply/cpcap-battery.c:292: warning: Excess function pa=
rameter 'regs' description in 'cpcap_battery_read_accumulated'
>=20
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---

Thanks, merged.

-- Sebastian

>  drivers/power/supply/cpcap-battery.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/=
cpcap-battery.c
> index 6e9392901b0a..90eba364664b 100644
> --- a/drivers/power/supply/cpcap-battery.c
> +++ b/drivers/power/supply/cpcap-battery.c
> @@ -274,7 +274,7 @@ static int cpcap_battery_cc_to_ua(struct cpcap_batter=
y_ddata *ddata,
>  /**
>   * cpcap_battery_read_accumulated - reads cpcap coulomb counter
>   * @ddata: device driver data
> - * @regs: coulomb counter values
> + * @ccd: coulomb counter values
>   *
>   * Based on Motorola mapphone kernel function data_read_regs().
>   * Looking at the registers, the coulomb counter seems similar to
> --=20
> 2.17.1
>=20

--n6kmyzh77xefgz2r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl8hqsYACgkQ2O7X88g7
+poTjg/+LqdgyEkNuyr4tPeswWZSZQBo8wMAB+dnKnxERw9mHv74hKU+bkbJ/nen
uWYUcdWwGM+yFFQAufMeLo01i1vf/LlfCVUqAOARjB3SSu5mgWmbfLOGoNFeqhM8
k8NZ7Oo4gKENnePswwhaDd9TNFTJmh8YKsNYGOsKeIVJkiIetHq0AYmCK+RjQFRF
KytMFC/+BRtuVYy1BbY9xFCJ1YIitDV5UDUhy1WS98e9S9IBRyyih6sImEwQzrd0
RL8UFG44AbeXAxpDBs+ol5kYzvlkzIAX9ES/cR0CViu060+Ot79SFE46V689xMUr
jiI+R0TWZC2vsG0bbGMVEppl1R/+NNQWdwlw/yhH5j/fiLp5E6wXLeohTuz+cJ8U
vwvlbwh5b9ZhczRvRCqnoDEYXYQi9uiSwvYhC0oIkTnvPcJ1JVGQ54js8I+2IKkk
js63N+c84pOiSmOjtJj8Dj4wzm6gI36rfDjK/Cgxwoh55nZ5FlhskMz9XOG0XDIq
OpY4Bijfx7I070YupP103ozIukqmmm2oxit79toA0OU/nDBDQphtxjgCmJir9vyR
Z9uhTMJA54q3SLMGYXB2UrOoggK3hMqU8g3RrCgEDM0Eu2xkZtMM9sxGKrEYAUWa
s7Zc3GEB+rko9BlqWBQvBFF/V9CuyOojtw8CtUZisO0y/DFlxqM=
=kLkE
-----END PGP SIGNATURE-----

--n6kmyzh77xefgz2r--
