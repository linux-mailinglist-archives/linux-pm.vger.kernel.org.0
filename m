Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10717231936
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jul 2020 07:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgG2Fry (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jul 2020 01:47:54 -0400
Received: from mx1.riseup.net ([198.252.153.129]:44514 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbgG2Frx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 Jul 2020 01:47:53 -0400
Received: from bell.riseup.net (bell-pn.riseup.net [10.0.1.178])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4BGjHs2H3LzFdxZ;
        Tue, 28 Jul 2020 22:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1596001673; bh=4XFW4u/+G5HXbt7eUIc8d7Sanex92jlfdr8B53S0Imc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=juhJkytj+hjPn4ZQHO/oBfnJKs6529z0CVNAeEx8byKPZ2/zSGC5+B3Wlufz3gS8o
         RDarOIVA8pKMZjdhsAX6qSZw3nxR0k4tBPzU/EcZaDZM2TmkbvRvZLCHYmkRLULdM9
         IAGOqOZTBUimiw3bhXnbYzdTNIduYeC+Y9CVIfrU=
X-Riseup-User-ID: F6AB9DE493BA4FFF5239B6317CCD8B7E032182CC6BCC4533F2BFF0E278FFCC3D
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by bell.riseup.net (Postfix) with ESMTPSA id 4BGjHs03zPzJmmn;
        Tue, 28 Jul 2020 22:47:52 -0700 (PDT)
From:   Francisco Jerez <currojerez@riseup.net>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: intel_pstate: Fix EPP setting via sysfs in active mode
In-Reply-To: <11585512.O9o76ZdvQC@kreacher>
References: <11585512.O9o76ZdvQC@kreacher>
Date:   Tue, 28 Jul 2020 22:47:52 -0700
Message-ID: <87r1sug9dj.fsf@riseup.net>
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
> Because intel_pstate_set_energy_pref_index() reads and writes the
> MSR_HWP_REQUEST register without using the cached value of it used by
> intel_pstate_hwp_boost_up() and intel_pstate_hwp_boost_down(), those
> functions may overwrite the value written by it and so the EPP value
> set via sysfs may be lost.
>
> To avoid that, make intel_pstate_set_energy_pref_index() take the
> cached value of MSR_HWP_REQUEST just like the other two routines
> mentioned above and update it with the new EPP value coming from
> user space in addition to updating the MSR.
>
> Note that the MSR itself still needs to be updated too in case
> hwp_boost is unset or the boosting mechanism is not active at the
> EPP change time.
>
> Fixes: e0efd5be63e8 ("cpufreq: intel_pstate: Add HWP boost utility and sc=
hed util hooks")
> Reported-by: Francisco Jerez <currojerez@riseup.net>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Francisco Jerez <currojerez@riseup.net>

> ---
>
> This patch is on top of https://patchwork.kernel.org/patch/11689347/
>
> ---
>  drivers/cpufreq/intel_pstate.c |   17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> Index: linux-pm/drivers/cpufreq/intel_pstate.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> +++ linux-pm/drivers/cpufreq/intel_pstate.c
> @@ -653,11 +653,12 @@ static int intel_pstate_set_energy_pref_
>  		epp =3D cpu_data->epp_default;
>=20=20
>  	if (boot_cpu_has(X86_FEATURE_HWP_EPP)) {
> -		u64 value;
> -
> -		ret =3D rdmsrl_on_cpu(cpu_data->cpu, MSR_HWP_REQUEST, &value);
> -		if (ret)
> -			return ret;
> +		/*
> +		 * Use the cached HWP Request MSR value, because the register
> +		 * itself may be updated by intel_pstate_hwp_boost_up() or
> +		 * intel_pstate_hwp_boost_down() at any time.
> +		 */
> +		u64 value =3D READ_ONCE(cpu_data->hwp_req_cached);
>=20=20
>  		value &=3D ~GENMASK_ULL(31, 24);
>=20=20
> @@ -667,6 +668,12 @@ static int intel_pstate_set_energy_pref_
>  			epp =3D epp_values[pref_index - 1];
>=20=20
>  		value |=3D (u64)epp << 24;
> +		/*
> +		 * The only other updater of hwp_req_cached in the active mode,
> +		 * intel_pstate_hwp_set(), is called under the same lock as this
> +		 * function, so it cannot run in parallel with the update below.
> +		 */
> +		WRITE_ONCE(cpu_data->hwp_req_cached, value);
>  		ret =3D wrmsrl_on_cpu(cpu_data->cpu, MSR_HWP_REQUEST, value);
>  	} else {
>  		if (epp =3D=3D -EINVAL)

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEAREIAB0WIQST8OekYz69PM20/4aDmTidfVK/WwUCXyENiAAKCRCDmTidfVK/
W2UeAP9fOoZ4v0COIC0iKbSqKUb36eboq2WI18E8Z+qS5CwVnwD5Aayo3jkIrJTv
A09h7Eetf/QEkKWAk18YKfODZGjoH0E=
=MqNe
-----END PGP SIGNATURE-----
--==-=-=--
