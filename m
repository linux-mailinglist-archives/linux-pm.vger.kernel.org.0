Return-Path: <linux-pm+bounces-7660-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB428C00D5
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 17:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BD521F2732E
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 15:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6FD8663E;
	Wed,  8 May 2024 15:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="JJByW78n"
X-Original-To: linux-pm@vger.kernel.org
Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06ED7126F09;
	Wed,  8 May 2024 15:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715181655; cv=none; b=XMe7Osckr6X19dKMIBF4DKDGatAb7wQ3NJnUqGMLjpt2h+ol6SkXrrNR4Qw11daCNOjrt8RT8Hnxr4ODh2bbghc03K+YfLwdcWa3B9qWcf0eTG/nAlSOmlMML/osntQHsN22yU/kzKJJQ4CZtU+ASPZSVoEVldsUAKKe93XZSpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715181655; c=relaxed/simple;
	bh=9KfSBIs6QBB5Bs4bjruYweDO6HbWwrmg0B82/emw7qI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XmgZewdgdTo9xpf+mvuRcoFS3BzA0LhfzhNRCIoIpdfpQJ+qbLT6FiXOJ/FUuvFTBi6Ydvy4TYUqAxsGqbW7dOd51hzLWe0ZVPF+lQ9p7WvZJ5Z5aIrlFJnlkGuzkBzl0sVnfmRguSKSF69146OTnOXu0JFyswXYAEGey0KO5dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=JJByW78n; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Received: from spock.localnet (unknown [94.142.239.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id 806CF62DD101;
	Wed, 08 May 2024 17:20:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1715181650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XMMtb1BMjAvu2gtOu1/OO6RYgYCtqAybUixIDl8KFFk=;
	b=JJByW78ngj5+sOcCUZucdBIlUDwAUUdzOol4Xer6TQn632bY+nIpT9XIjYphWOuSRnEX7B
	vqC29q2X44owrtx+LrY+iMu7zihdlAiIYI30uku3jbVoQmnx8HvwGj8pTAXil6/qfBMUA1
	E5L9TTOPhUtCAOiDGHWpxIzQt0m7NSc=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
 viresh.kumar@linaro.org, Ray.Huang@amd.com, gautham.shenoy@amd.com,
 Borislav.Petkov@amd.com, Mario Limonciello <mario.limonciello@amd.com>
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH 11/11] cpufreq: amd-pstate: automatically load pstate driver by
 default
Date: Wed, 08 May 2024 17:20:39 +0200
Message-ID: <2728771.mvXUDI8C0e@natalenko.name>
In-Reply-To: <3cd5fe9d-514c-4a09-a895-47d97a5c6b94@amd.com>
References:
 <cover.1715065568.git.perry.yuan@amd.com>
 <60bdfbeb426512d74faa91597453fd7960ebd7b5.1715065568.git.perry.yuan@amd.com>
 <3cd5fe9d-514c-4a09-a895-47d97a5c6b94@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12430785.O9o76ZdvQC";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart12430785.O9o76ZdvQC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
Date: Wed, 08 May 2024 17:20:39 +0200
Message-ID: <2728771.mvXUDI8C0e@natalenko.name>
In-Reply-To: <3cd5fe9d-514c-4a09-a895-47d97a5c6b94@amd.com>
MIME-Version: 1.0

Hello.

On =C3=BAter=C3=BD 7. kv=C4=9Btna 2024 16:41:29, SEL=C4=8C Mario Limonciell=
o wrote:
> On 5/7/2024 02:15, Perry Yuan wrote:
> > If the `amd-pstate` driver is not loaded automatically by default,
> > it is because the kernel command line parameter has not been added.
> > To resolve this issue, it is necessary to call the `amd_pstate_set_driv=
er()`
> > function to enable the desired mode (passive/active/guided) before regi=
stering
> > the driver instance.
> > This ensures that the driver is loaded correctly without relying on the=
 kernel
> > command line parameter.
> >=20
> > [    0.917789] usb usb6: Manufacturer: Linux 6.9.0-rc6-amd-pstate-new-f=
ix-v1 xhci-hcd
> > [    0.982579] amd_pstate: failed to register with return -22
> >=20
> > Reported-by: Andrei Amuraritei <andamu@posteo.net>
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218705
> > Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> > ---
> >   drivers/cpufreq/amd-pstate.c | 39 +++++++++++++++++++-----------------
> >   1 file changed, 21 insertions(+), 18 deletions(-)
> >=20
> > diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> > index 3ff381c4edf7..f5368497ee79 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -66,7 +66,7 @@
> >   static struct cpufreq_driver *current_pstate_driver;
> >   static struct cpufreq_driver amd_pstate_driver;
> >   static struct cpufreq_driver amd_pstate_epp_driver;
> > -static int cppc_state =3D AMD_PSTATE_UNDEFINED;
> > +static int cppc_state;
> >   static bool cppc_enabled;
> >   static bool amd_pstate_prefcore =3D true;
> >   static struct quirk_entry *quirks;
> > @@ -1762,6 +1762,16 @@ static int __init amd_pstate_init(void)
> >   	if (boot_cpu_data.x86_vendor !=3D X86_VENDOR_AMD)
> >   		return -ENODEV;
> >  =20
> > +	/* Disable on the following configs by default:
> > +	 * 1. Undefined platforms
> > +	 * 2. Server platforms
> > +	 */
> > +	if (amd_pstate_acpi_pm_profile_undefined() ||
> > +		amd_pstate_acpi_pm_profile_server()) {
> > +		pr_info("driver load is disabled for server or undefined platform\n"=
);
> > +		return -ENODEV;
> > +	}
> > +
> >   	/* show debug message only if CPPC is not supported */
> >   	if (!amd_cppc_supported())
> >   		return -EOPNOTSUPP;
> > @@ -1781,28 +1791,21 @@ static int __init amd_pstate_init(void)
> >   	/* check if this machine need CPPC quirks */
> >   	dmi_check_system(amd_pstate_quirks_table);
> >  =20
> > +	/* get default driver mode for loading*/
> > +	cppc_state =3D CONFIG_X86_AMD_PSTATE_DEFAULT_MODE;
>=20
> Rather than setting it here within amd_pstate_init() I think you can=20
> just set it at line 67 to CONFIG_X86_AMD_PSTATE_DEFAULT_MODE.

To me it seems like setting it here kills a possibility to set the mode via=
 the kernel cmdline. Regardless of what will be set in `amd_pstate=3D`, `CO=
NFIG_X86_AMD_PSTATE_DEFAULT_MODE` will be used instead.

>=20
> > +	pr_debug("cppc working state set to mode:%d\n", cppc_state);
>=20
> I think this debug line is going to be unnecessary when it's already=20
> hardcoded to kernel config.
>=20
> > +
> >   	switch (cppc_state) {
> > -	case AMD_PSTATE_UNDEFINED:
> > -		/* Disable on the following configs by default:
> > -		 * 1. Undefined platforms
> > -		 * 2. Server platforms
> > -		 * 3. Shared memory designs
> > -		 */
> > -		if (amd_pstate_acpi_pm_profile_undefined() ||
> > -		    amd_pstate_acpi_pm_profile_server() ||
> > -		    !cpu_feature_enabled(X86_FEATURE_CPPC)) {
> > -			pr_info("driver load is disabled, boot with specific mode to enable=
 this\n");
> > -			return -ENODEV;
> > -		}
> > -		ret =3D amd_pstate_set_driver(CONFIG_X86_AMD_PSTATE_DEFAULT_MODE);
> > -		if (ret)
> > -			return ret;
> > -		break;
> >   	case AMD_PSTATE_DISABLE:
> > +		pr_info("driver load is disabled, boot with specific mode to enable =
this\n");
> >   		return -ENODEV;
> > +	case AMD_PSTATE_UNDEFINED:
>=20
> With the intent of this patch I no longer see a need for=20
> AMD_PSTATE_UNDEFINED in the rest of the driver (or in this case=20
> statement even).
>=20
> I feel you can drop it from amd-pstate.h.
>=20
> >   	case AMD_PSTATE_PASSIVE:
> >   	case AMD_PSTATE_ACTIVE:
> >   	case AMD_PSTATE_GUIDED:
> > +		ret =3D amd_pstate_set_driver(cppc_state);
> > +		if (ret)
> > +			return ret;
> >   		break;
> >   	default:
> >   		return -EINVAL;
> > @@ -1823,7 +1826,7 @@ static int __init amd_pstate_init(void)
> >   	/* enable amd pstate feature */
> >   	ret =3D amd_pstate_enable(true);
> >   	if (ret) {
> > -		pr_err("failed to enable with return %d\n", ret);
> > +		pr_err("failed to enable driver mode(%d) with return %d\n", cppc_sta=
te, ret);
> >   		return ret;
> >   	}
> >  =20
>=20
>=20
>=20


=2D-=20
Oleksandr Natalenko (post-factum)
--nextPart12430785.O9o76ZdvQC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmY7mEcACgkQil/iNcg8
M0s7/A/5AXSNu7dyskGlrQ15LP7kQG1RkojprdDnOMrBWiMlXopK/nGfDFzK4aIh
i8oaB/Duhzo8GWO9e/kl7HF69YXscMZUKu6MllqsAjv0e1xJSEi6VLcl7jJ6jjmV
Il44Cb0CX3DlMU/cSZUWoohXqBKQEEpdJhrghUj2ZpVi4GBFhkhXuoLIPiGzd88t
xvtZgBbfVWmqCxWO0meKfphWC4F4MZmCiMEbJDC73nwYBrPIViYsrkBy9qPBDPCN
H4tlxX0rL8wpOk3e8RFTJ8NBHmHnsiwTqsDsJWeCr5ccAsGn/8FdulfWJwz7Clfj
4LDFAFPhZAfPFXiwZIeQfTQZrjj1KSLnzOrCgqsgugebu4nWa7hPZC9lFNDofqcY
rbgXnJe19PeSINJcpE19dKEDR9SL/Y3KRPZq8owNIo34z3UTxEswVexlAAp58IkK
iEFkSAXYAi6orghoWcEUpuPHQg2VkRMyVtx3nQ/Nvs5LxCDWUZfAs0WQZMvFZiQU
bkNTc1xRnhmiw6D3CsvBO8yTHW8627GAOj67maQmTLXAzUUBDjSCcWQpbORD09xh
vxuq82+FRiY/OC/cjNpTt+v+othxUIAW/V7GEVl0OZjBBJTDdRshFwPVvfwlfGCa
oOQYcifClMug+9AG5CuN8ezoU6rbmQ4V7j7248jwLv+Q+7l/WVs=
=CHXk
-----END PGP SIGNATURE-----

--nextPart12430785.O9o76ZdvQC--




