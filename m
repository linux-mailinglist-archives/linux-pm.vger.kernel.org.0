Return-Path: <linux-pm+bounces-25268-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A7CA861C1
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 17:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49CB51893E39
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 15:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5902520C482;
	Fri, 11 Apr 2025 15:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="arU83wvA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679971F91F6;
	Fri, 11 Apr 2025 15:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744384964; cv=none; b=bASKI7GYW+94Maqb3qTN/oBt05fi6hlqcKAWXm4OetDTcpfElEbUO/ITdRxnLMJshaYSj6WCL/baylewr/I4wD1RxiUFQbtsmg9BYKWl4e2WpVE/dpyxDEMgUYLi7YFAoRWIMgIAgtjnD204CofvXyFmZAswdr8ilzVdQwHU7Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744384964; c=relaxed/simple;
	bh=YNW3upEg+rmjkq0fNHdgYLGhzmcoyZD7ZEMp4a76oTk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=TU4AxUM1lBEh7DLiN+RjNhOipJiK7bS33rLgb7jLPqQl+U4gsORdLBamyXXcpR3KGR4sQ3wgZK5vA1miUjwLjzSNcFcW+Lvcf+/zQZ7SxLt3MjJAQ4yGm3mFg8JGPWQo95MZcoSriLQX9c5fG7IMceYT0tkGBKeZRPi1juw43Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=arU83wvA; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744384963; x=1775920963;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=YNW3upEg+rmjkq0fNHdgYLGhzmcoyZD7ZEMp4a76oTk=;
  b=arU83wvAuP3Md9/LMpMg+aWgaosK1Wske/unqwC7AqbcAcpf/d/Bhb7X
   nzskiXCUHvGErzpUm8ypZf66xQje6mh8AD/1Cd5KWWt9dOxjE+BzCMHwI
   tZjIeqGPLs2duLMqwLa5S4H3+saUF8vtSQ+Iyrp3InSZiVdz1fR/OZZfv
   ncep4wECMhtB8aCkPcwk/O5fMxPUK4UzHx/xlhwR7gXYe80mEnN6DD0yI
   +bHx/7c//7J8syGtOX2xaNLIXgPpirCBdjeEWkJnri0RLG0DTFAh7JMWR
   ODMXGDjZQ5s76d/L+KRl7vNKYrHxaK6Xt3ECMqjIIO6w3uzlxj0RZmEax
   w==;
X-CSE-ConnectionGUID: KcZHMsYbSAq3HhoVovPrJg==
X-CSE-MsgGUID: Pc0A0h1nRFiId06mZRmJ1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="56925088"
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="56925088"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 08:22:42 -0700
X-CSE-ConnectionGUID: biciTfkJTZiEHpVEjBkiWg==
X-CSE-MsgGUID: lSv1uLKWRKK3HjfJxvsskQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="166413756"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.51])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 08:22:35 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 11 Apr 2025 18:22:31 +0300 (EEST)
To: Antheas Kapenekakis <lkml@antheas.dev>
cc: platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org, 
    linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, 
    Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>, 
    Jonathan Corbet <corbet@lwn.net>, 
    Joaquin Ignacio Aramendia <samsagax@gmail.com>, 
    Derek J Clark <derekjohn.clark@gmail.com>, 
    Kevin Greenberg <kdgreenberg234@protonmail.com>, 
    Joshua Tam <csinaction@pm.me>, Parth Menon <parthasarathymenon@gmail.com>, 
    Eileen <eileen@one-netbook.com>, LKML <linux-kernel@vger.kernel.org>, 
    sre@kernel.org, linux@weissschuh.net, Hans de Goede <hdegoede@redhat.com>, 
    mario.limonciello@amd.com
Subject: Re: [PATCH v8 06/14] platform/x86: oxpec: Rename ec group to
 tt_toggle
In-Reply-To: <20250322103606.680401-7-lkml@antheas.dev>
Message-ID: <b1fbbb55-a8dd-fc46-bcd4-ce654d63612a@linux.intel.com>
References: <20250322103606.680401-1-lkml@antheas.dev> <20250322103606.680401-7-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1297281199-1744384951=:944"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1297281199-1744384951=:944
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 22 Mar 2025, Antheas Kapenekakis wrote:

> Currently, the EC group is used for the turbo button. However, the next
> patch in the series adds support for the LED button in X1 devices, which
> is only applicable for X1 devices. Therefore, rename it to prepare for
> adding the second group. And make it const while at it.
>=20
> Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
> Reviewed-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  drivers/platform/x86/oxpec.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.c
> index dc3a0871809cd..ee37070ec54fc 100644
> --- a/drivers/platform/x86/oxpec.c
> +++ b/drivers/platform/x86/oxpec.c
> @@ -681,18 +681,18 @@ static const struct hwmon_channel_info * const oxp_=
platform_sensors[] =3D {
>  =09NULL,
>  };
> =20
> -static struct attribute *oxp_ec_attrs[] =3D {
> +static struct attribute *oxp_tt_toggle_attrs[] =3D {
>  =09&dev_attr_tt_toggle.attr,
>  =09NULL
>  };
> =20
> -static struct attribute_group oxp_ec_attribute_group =3D {
> +static const struct attribute_group oxp_tt_toggle_attribute_group =3D {
>  =09.is_visible =3D tt_toggle_is_visible,
> -=09.attrs =3D oxp_ec_attrs,
> +=09.attrs =3D oxp_tt_toggle_attrs,
>  };
> =20
>  static const struct attribute_group *oxp_ec_groups[] =3D {
> -=09&oxp_ec_attribute_group,
> +=09&oxp_tt_toggle_attribute_group,
>  =09NULL
>  };

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1297281199-1744384951=:944--

