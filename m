Return-Path: <linux-pm+bounces-25262-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF05A8617B
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 17:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CC439A2FA0
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 15:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE85020C485;
	Fri, 11 Apr 2025 15:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GAVi5RsK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123381F4CB2;
	Fri, 11 Apr 2025 15:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744384410; cv=none; b=I1JlnfZBlyMZwZB+1B+UVN/4+ciCb/yoPBOTk3rP42U/6mLjzHV9YrGtSevtnronqI43cWY/DQ4fi0rvhEDBe9XFd6+A1PQvIlFB021T+pEjY/pI5yNBqEV2ewc3xBcNzKO+xxPWekQ95X8k0ibh3+iS2pQm7el3MywS/uqR+AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744384410; c=relaxed/simple;
	bh=Q6oiw5NI10n4M3nXXpNGthLxIT/SdM7Jwoja/NSGTkQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=o/abnVreZh9sttP+4rI39DNA8FsXIyfXtBKqPmUiDthFVBJZ9cV3t8TYJOI1LhFgy2ldaHLzHz0ZVeD7duk7DJJ2cPEvaH2phtRiXpY49e/BPFckRNxvrG4US8brrQsCXpPImHZPZ77j/5AtTnKCNhy1dv0N0bkdMzCs5yriNIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GAVi5RsK; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744384409; x=1775920409;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Q6oiw5NI10n4M3nXXpNGthLxIT/SdM7Jwoja/NSGTkQ=;
  b=GAVi5RsK/HUOyub4rHqLr0AQeEZ6BYdBj+elvW7lEdNRDNUuETcLSkX8
   ieyfW6+XtS9IPwHdH9eZMIKFWqjTYNvykId14MImlIlTetCIETI9grIxs
   G217mYDOeympixD6yKfHCwJsIWZCF28D2RfFTyuQCymRJIGp51Tw5KKKt
   IdL61dO2S9UOPH3fEAy+gVNfG+MGDOH8R2U8DM+1o3BG/rCl8+M8GO6Sl
   cTNvp3ySaSF3wN5iLuwaTU+Z6NzPUUQnXiBf4csKzA+dXkAUgk1qs3aO0
   JBcf7Mr7xlhwWhuTQ/niV7jji78rtMX3+PObtynUpPyxg37yDuSJyvcP8
   Q==;
X-CSE-ConnectionGUID: CTcrWBcARHuNM9yaWMtidw==
X-CSE-MsgGUID: ZiZY8eW8TmSSfBABl4rAzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="49742487"
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="49742487"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 08:09:27 -0700
X-CSE-ConnectionGUID: hrlbZrJZQCi2mheKUPcsiQ==
X-CSE-MsgGUID: ++9EY4/3TXCppV+gP4pmtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="134200079"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.51])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 08:09:20 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 11 Apr 2025 18:09:16 +0300 (EEST)
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
Subject: Re: [PATCH v8 12/14] platform/x86: oxpec: Follow reverse xmas
 convention for tt_toggle
In-Reply-To: <20250322103606.680401-13-lkml@antheas.dev>
Message-ID: <31eabe0a-3cc6-2022-e426-dead9ab308c9@linux.intel.com>
References: <20250322103606.680401-1-lkml@antheas.dev> <20250322103606.680401-13-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-192321225-1744384156=:944"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-192321225-1744384156=:944
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 22 Mar 2025, Antheas Kapenekakis wrote:

> Since the rest of the driver follows this convention, apply it to the
> tt_toggle attribute as well.
>=20
> Suggested-by: Derek J. Clark <derekjohn.clark@gmail.com>
> Reviewed-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  drivers/platform/x86/oxpec.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.c
> index 3bf2c597e9b00..0a5b33a842b24 100644
> --- a/drivers/platform/x86/oxpec.c
> +++ b/drivers/platform/x86/oxpec.c
> @@ -275,9 +275,9 @@ static const struct dmi_system_id dmi_table[] =3D {
>  /* Helper functions to handle EC read/write */
>  static int read_from_ec(u8 reg, int size, long *val)
>  {
> -=09int i;
> -=09int ret;
>  =09u8 buffer;
> +=09int ret;
> +=09int i;
> =20
>  =09if (!lock_global_acpi_lock())
>  =09=09return -EBUSY;
> @@ -389,8 +389,8 @@ static ssize_t tt_toggle_store(struct device *dev,
>  =09=09=09       struct device_attribute *attr, const char *buf,
>  =09=09=09       size_t count)
>  {
> -=09int rval;
>  =09bool value;
> +=09int rval;
> =20
>  =09rval =3D kstrtobool(buf, &value);
>  =09if (rval)
> @@ -411,8 +411,8 @@ static ssize_t tt_toggle_show(struct device *dev,
>  =09=09=09      struct device_attribute *attr, char *buf)
>  {
>  =09int retval;
> -=09u8 reg;
>  =09long val;
> +=09u8 reg;
> =20
>  =09switch (board) {
>  =09case oxp_mini_amd_a07:
>=20

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-192321225-1744384156=:944--

