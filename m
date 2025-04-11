Return-Path: <linux-pm+bounces-25269-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C83A861BB
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 17:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 226D31776F5
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 15:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6419820DD63;
	Fri, 11 Apr 2025 15:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bumjaCWI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C28820C49E;
	Fri, 11 Apr 2025 15:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744385033; cv=none; b=XDZ+OViXukS8ens/RWz7+Ocb03jS9MKH5k49T9vp51eLQE9thn/q6OSfaDh61EdcurqsW+RiIv/CjKShPi4hpJzV2X0nzyvzXf6CKSqGedn5/Qlh4I2/PfbOJ73x67z3KmkaZU9syY6vgAzYajPAGAJN07HZKn7VJOXuLtUJDOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744385033; c=relaxed/simple;
	bh=f/+r7NNjXbrUArHILLHBRRMF683cnW/KbBRUzoqwqW0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=E+SbZZXno90jsRceVK7mua/UsNEkx4soKwdl/P4YmtQu+BSUPW2Q6mvSp+HN2zur4GhVNY8LOcVqZRyGsG/TgjbIm8arwijtv8Mp09GWz07cJkop8aO86sPk8cCo5KgL/ktHwicvdudGCQl28Z0PEDEgscP45S4qdQ1X84sd4MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bumjaCWI; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744385032; x=1775921032;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=f/+r7NNjXbrUArHILLHBRRMF683cnW/KbBRUzoqwqW0=;
  b=bumjaCWIRIf6P/oRu7DIBD4saza0UjTsDxuaXYLJFgcm16n9kQ40tfeg
   3dggTkAunz6sDaj8Mlt0+F6/J2zx5TSttpGPzJqxAMdbPwSyMgKnpP8va
   B7EhSnDP1G3FsYVJlQATg9k4FZ0d08Qg+kc2n1DKf7WKAdBnz7MlEaZaO
   y4O0XHG8NSdJl7zLEmv9QmpM+avsePw85xkfqiiaU5nS+SoeTezr4SzRY
   fZNDitBTFo8qi5EibU0hLbMkQfeD51xpmevzQH8J3BIRqBiiAyQvUGR/L
   6xUnoTKl6gOTM2ZgwPOp/YhBsL6DoNSF5jfVjkwBlovWXz+6PKZwQWs0v
   g==;
X-CSE-ConnectionGUID: VJexNOUlTXO82RWGWEugOw==
X-CSE-MsgGUID: rUBW0E7HSQaSBYCHLsH/Rw==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="33555105"
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="33555105"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 08:23:51 -0700
X-CSE-ConnectionGUID: 4a3iu6qzRn2khA9XEjV8JQ==
X-CSE-MsgGUID: DPXAsLGhQE2EE/JYLIKUFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="160203959"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.51])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 08:23:44 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 11 Apr 2025 18:23:41 +0300 (EEST)
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
Subject: Re: [PATCH v8 05/14] ABI: testing: sysfs-class-oxp: add tt_led
 attribute documentation
In-Reply-To: <20250322103606.680401-6-lkml@antheas.dev>
Message-ID: <fd6abf62-b822-c3e2-e006-92798abd8d04@linux.intel.com>
References: <20250322103606.680401-1-lkml@antheas.dev> <20250322103606.680401-6-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-664722212-1744385021=:944"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-664722212-1744385021=:944
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 22 Mar 2025, Antheas Kapenekakis wrote:

> Adds documentation about the tt_led attribute of OneXPlayer devices
> to the sysfs-class-oxp ABI documentation.
>=20
> Reviewed-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  Documentation/ABI/testing/sysfs-platform-oxp | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-platform-oxp b/Documentation=
/ABI/testing/sysfs-platform-oxp
> index 091269ab2c8c4..ccf8e5902cf86 100644
> --- a/Documentation/ABI/testing/sysfs-platform-oxp
> +++ b/Documentation/ABI/testing/sysfs-platform-oxp
> @@ -11,3 +11,15 @@ Description:
>  =09=09shortcut over the AT keyboard of the device. In addition,
>  =09=09using this setting is a prerequisite for PWM control for most
>  =09=09newer models (otherwise it NOOPs).
> +
> +What:=09=09/sys/devices/platform/<platform>/tt_led
> +Date:=09=09Feb 2025
> +KernelVersion:=096.15

As usual with these versions/dates, this ship has sailed by now.

> +Contact:=09"Antheas Kapenekakis" <lkml@antheas.dev>
> +Description:
> +=09=09Some OneXPlayer devices (e.g., X1 series) feature a little LED
> +=09=09nested in the Turbo button. This LED is illuminated when the
> +=09=09device is in the higher TDP mode (e.g., 25W). Once tt_toggle
> +=09=09is engaged, this LED is left dangling to its last state. This
> +=09=09attribute allows userspace to control the LED state manually
> +=09=09(either with 1 or 0). Only a subset of devices contain this LED.
>=20

--=20
 i.

--8323328-664722212-1744385021=:944--

