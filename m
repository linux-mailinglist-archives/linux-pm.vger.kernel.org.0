Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 871B223298E
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jul 2020 03:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgG3BbK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jul 2020 21:31:10 -0400
Received: from mx1.riseup.net ([198.252.153.129]:52776 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbgG3BbK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 Jul 2020 21:31:10 -0400
Received: from capuchin.riseup.net (capuchin-pn.riseup.net [10.0.1.176])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4BHCY84wkyzFf0J;
        Wed, 29 Jul 2020 18:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1596072668; bh=aUisLHgt6JsY1GKX1kNHTO+GIzCjTF9ZNIDBeF3Ng1c=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=mcx6Rx5sIvR+Mz8ZWWO7PSOshswXZaF93E9hH1w+NlyYTbDo/g3ZtE2XdjhYfRO95
         iJrA8xInIu0JMhSPfHUX6sJ0apCVvCPiDWiTPKnWc+BNNF0Tp3S6lhbO15DCMNdNfx
         tX5WIlfMrKLCxFfOq6Fs4CryHm92IM/clqGeg1xo=
X-Riseup-User-ID: 1FA0CC4141DEFDA066FBB3DC5B0B40BC23C0B84848AF0AEF793354A9C2D3F5BB
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by capuchin.riseup.net (Postfix) with ESMTPSA id 4BHCY771Grz8tJg;
        Wed, 29 Jul 2020 18:31:07 -0700 (PDT)
From:   Francisco Jerez <currojerez@riseup.net>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     Linux Documentation <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Doug Smythies <dsmythies@telus.net>
Subject: Re: [PATCH v4 1/2] cpufreq: intel_pstate: Rearrange the storing of new EPP values
In-Reply-To: <1665283.zxI7kaGBi8@kreacher>
References: <4981405.3kqTVLv5tO@kreacher> <1709487.Bxjb1zNRZM@kreacher> <13207937.r2GEYrEf4f@kreacher> <1665283.zxI7kaGBi8@kreacher>
Date:   Wed, 29 Jul 2020 18:31:07 -0700
Message-ID: <87wo2leqlg.fsf@riseup.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="==-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

--==-=-=
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

"Rafael J. Wysocki" <rjw@rjwysocki.net> writes:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Move the locking away from intel_pstate_set_energy_pref_index()
> into its only caller and drop the (now redundant) return_pref label
> from it.
>
> Also move the "raw" EPP value check into the caller of that function,
> so as to do it before acquiring the mutex, and reduce code duplication
> related to the "raw" EPP values processing somewhat.
>
> No intentional functional impact.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Francisco Jerez <currojerez@riseup.net>

> ---
>
> v2 -> v3:
>
>    * Fix error handling in intel_pstate_set_energy_pref_index() and
>      rebase.
>
> v3 -> v4: No changes
>
> ---
>  drivers/cpufreq/intel_pstate.c |   35 +++++++++++++++--------------------
>  1 file changed, 15 insertions(+), 20 deletions(-)
>
> Index: linux-pm/drivers/cpufreq/intel_pstate.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> +++ linux-pm/drivers/cpufreq/intel_pstate.c
> @@ -649,28 +649,18 @@ static int intel_pstate_set_energy_pref_
>  	if (!pref_index)
>  		epp =3D cpu_data->epp_default;
>=20=20
> -	mutex_lock(&intel_pstate_limits_lock);
> -
>  	if (boot_cpu_has(X86_FEATURE_HWP_EPP)) {
>  		u64 value;
>=20=20
>  		ret =3D rdmsrl_on_cpu(cpu_data->cpu, MSR_HWP_REQUEST, &value);
>  		if (ret)
> -			goto return_pref;
> +			return ret;
>=20=20
>  		value &=3D ~GENMASK_ULL(31, 24);
>=20=20
> -		if (use_raw) {
> -			if (raw_epp > 255) {
> -				ret =3D -EINVAL;
> -				goto return_pref;
> -			}
> -			value |=3D (u64)raw_epp << 24;
> -			ret =3D wrmsrl_on_cpu(cpu_data->cpu, MSR_HWP_REQUEST, value);
> -			goto return_pref;
> -		}
> -
> -		if (epp =3D=3D -EINVAL)
> +		if (use_raw)
> +			epp =3D raw_epp;
> +		else if (epp =3D=3D -EINVAL)
>  			epp =3D epp_values[pref_index - 1];
>=20=20
>  		value |=3D (u64)epp << 24;
> @@ -680,8 +670,6 @@ static int intel_pstate_set_energy_pref_
>  			epp =3D (pref_index - 1) << 2;
>  		ret =3D intel_pstate_set_epb(cpu_data->cpu, epp);
>  	}
> -return_pref:
> -	mutex_unlock(&intel_pstate_limits_lock);
>=20=20
>  	return ret;
>  }
> @@ -708,8 +696,8 @@ static ssize_t store_energy_performance_
>  	struct cpudata *cpu_data =3D all_cpu_data[policy->cpu];
>  	char str_preference[21];
>  	bool raw =3D false;
> +	ssize_t ret;
>  	u32 epp =3D 0;
> -	int ret;
>=20=20
>  	ret =3D sscanf(buf, "%20s", str_preference);
>  	if (ret !=3D 1)
> @@ -724,14 +712,21 @@ static ssize_t store_energy_performance_
>  		if (ret)
>  			return ret;
>=20=20
> +		if (epp > 255)
> +			return -EINVAL;
> +
>  		raw =3D true;
>  	}
>=20=20
> +	mutex_lock(&intel_pstate_limits_lock);
> +
>  	ret =3D intel_pstate_set_energy_pref_index(cpu_data, ret, raw, epp);
> -	if (ret)
> -		return ret;
> +	if (!ret)
> +		ret =3D count;
>=20=20
> -	return count;
> +	mutex_unlock(&intel_pstate_limits_lock);
> +
> +	return ret;
>  }
>=20=20
>  static ssize_t show_energy_performance_preference(

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEAREIAB0WIQST8OekYz69PM20/4aDmTidfVK/WwUCXyIi2wAKCRCDmTidfVK/
W+bIAP9VI6QX7g2roqBKi/zof0Rfvrs5n3eeDvhO33ZmdO88nwEAjpv6+ZAvh6pk
rKhiSm3lspzJ3ly69OUe1/IEeWcze5c=
=ElU5
-----END PGP SIGNATURE-----
--==-=-=--
