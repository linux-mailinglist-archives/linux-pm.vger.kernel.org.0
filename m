Return-Path: <linux-pm+bounces-22540-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C69DCA3D9D8
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 13:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2136A19C2089
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 12:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B721F4639;
	Thu, 20 Feb 2025 12:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="rjngVgfU"
X-Original-To: linux-pm@vger.kernel.org
Received: from aposti.net (aposti.net [89.234.176.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FF21F63F0;
	Thu, 20 Feb 2025 12:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.234.176.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740054119; cv=none; b=Sj+6g/0e3CIvr1SpK8+jOnnBkigq5IuZxF48o/kRP/QgKXcIgqkqeEfb5pIMexFupQJg5KbnCz+zocWAR7ZFIeEPFiZZeqx31bh7Bj17Xl6sRhtgsrceOn14hshJC0Cs4Rcm6JrNaixHSE2TiPsTlIQ3XXlbLri6hxXcAj5ptFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740054119; c=relaxed/simple;
	bh=yu5nuGyzsBAWau1vPX5hO8Wz+P+nRxHfgC/xFUEm9xU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IDuwSPWSN5GF4vosiX5hQLPKTTWAWBWNGw7akp5C7AH6gW9s5WSMTm+AhU2sAYPAS91ZshXXxHMUAQF4MwrBN/c1kbu27m4A9uiYB7q3CPet6JBKlBz/c2Nz+AZhpLE2JhqWhZntpM7yt8dvFKQ+t10zRgQVt4PDAShlbgOvf1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net; spf=pass smtp.mailfrom=crapouillou.net; dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b=rjngVgfU; arc=none smtp.client-ip=89.234.176.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
	s=mail; t=1740053721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+Gl3G6XUYkIShZYZNz/CumKvDXy706ENSlqU/a6wAK4=;
	b=rjngVgfUX5tuj8FKXlqRQWA7w5v0ML6X43i/5KFkp3Da6az3cPc3Vt6suEc0EcbTadPO0m
	sGsA+1nePPI0Rn+lGyZkQnlg8hiHpF8HhCfCNF4meakXWNlVhtBfzjMeFySAObio1mU74H
	UTqZ41OfpAtcyPsYwv6fzzbmZQWmeaA=
Message-ID: <04b87029f2237e209d8c8b620d009692d80eea2f.camel@crapouillou.net>
Subject: Re: [PATCH v1] PM: Discard runtime_xx() handles using pm_ptr()
From: Paul Cercueil <paul@crapouillou.net>
To: Raag Jadav <raag.jadav@intel.com>, rafael@kernel.org, 
	andriy.shevchenko@linux.intel.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 20 Feb 2025 13:15:19 +0100
In-Reply-To: <20250220080318.2660840-1-raag.jadav@intel.com>
References: <20250220080318.2660840-1-raag.jadav@intel.com>
Autocrypt: addr=paul@crapouillou.net; prefer-encrypt=mutual;
 keydata=mQENBF0KhcEBCADkfmrzdTOp/gFOMQX0QwKE2WgeCJiHPWkpEuPH81/HB2dpjPZNW03ZM
 LQfECbbaEkdbN4YnPfXgcc1uBe5mwOAPV1MBlaZcEt4M67iYQwSNrP7maPS3IaQJ18ES8JJ5Uf5Uz
 FZaUawgH+oipYGW+v31cX6L3k+dGsPRM0Pyo0sQt52fsopNPZ9iag0iY7dGNuKenaEqkYNjwEgTtN
 z8dt6s3hMpHIKZFL3OhAGi88wF/21isv0zkF4J0wlf9gYUTEEY3Eulx80PTVqGIcHZzfavlWIdzhe
 +rxHTDGVwseR2Y1WjgFGQ2F+vXetAB8NEeygXee+i9nY5qt9c07m8mzjABEBAAG0JFBhdWwgQ2VyY
 3VlaWwgPHBhdWxAY3JhcG91aWxsb3UubmV0PokBTgQTAQoAOBYhBNdHYd8OeCBwpMuVxnPua9InSr
 1BBQJdCoXBAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEHPua9InSr1BgvIH/0kLyrI3V0f
 33a6D3BJwc1grbygPVYGuC5l5eMnAI+rDmLR19E2yvibRpgUc87NmPEQPpbbtAZt8On/2WZoE5OIP
 dlId/AHNpdgAtGXo0ZX4LGeVPjxjdkbrKVHxbcdcnY+zzaFglpbVSvp76pxqgVg8PgxkAAeeJV+ET
 4t0823Gz2HzCL/6JZhvKAEtHVulOWoBh368SYdolp1TSfORWmHzvQiCCCA+j0cMkYVGzIQzEQhX7U
 rf9N/nhU5/SGLFEi9DcBfXoGzhyQyLXflhJtKm3XGB1K/pPulbKaPcKAl6rIDWPuFpHkSbmZ9r4KF
 lBwgAhlGy6nqP7O3u7q23hRU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Raag,

Le jeudi 20 f=C3=A9vrier 2025 =C3=A0 13:33 +0530, Raag Jadav a =C3=A9crit=
=C2=A0:
> Discard runtime_xx() handles in RUNTIME_PM_OPS() using pm_ptr() macro
> and drop unnecessary CONFIG_PM ifdeffery.

So the RUNTIME_PM_OPS() is newer and people should use that, but we're
not yet at the point where the older SET_RUNTIME_PM_OPS() macro can be
dropped.

The difference is that in the !CONFIG_PM case, the former will
reference the suspend/resume functions, but they will be detected as
dead code; on the other hand, the latter macro won't reference them at
all. Many drivers still wrap their suspend/resume functions in a #ifdef
CONFIG_PM to avoid warnings about unused static functions. Therefore if
you unconditionally force the use of the first macro everywhere, many
drivers will fail to compile in the !CONFIG_PM case.

As for adding pm_ptr() inside RUNTIME_PM_OPS(), it is unnecesary, as
the whole pm_ops struct should be referenced through pm_ptr() or
pm_sleep_ptr() anyway, which means that the whole struct and the
callback functions will be garbage-collected if PM is disabled.

Cheers,
-Paul

> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> ---
> PS: I'm not very confident about this but thought I'd give it a try.
>=20
> =C2=A0include/linux/pm.h | 10 +++-------
> =C2=A01 file changed, 3 insertions(+), 7 deletions(-)
>=20
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index 78855d794342..416561c60e81 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -334,9 +334,9 @@ struct dev_pm_ops {
> =C2=A0	.restore_noirq =3D pm_sleep_ptr(resume_fn),
> =C2=A0
> =C2=A0#define RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
> -	.runtime_suspend =3D suspend_fn, \
> -	.runtime_resume =3D resume_fn, \
> -	.runtime_idle =3D idle_fn,
> +	.runtime_suspend =3D pm_ptr(suspend_fn), \
> +	.runtime_resume =3D pm_ptr(resume_fn), \
> +	.runtime_idle =3D pm_ptr(idle_fn),
> =C2=A0
> =C2=A0#ifdef CONFIG_PM_SLEEP
> =C2=A0#define SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
> @@ -359,12 +359,8 @@ struct dev_pm_ops {
> =C2=A0#define SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
> =C2=A0#endif
> =C2=A0
> -#ifdef CONFIG_PM
> =C2=A0#define SET_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
> =C2=A0	RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn)
> -#else
> -#define SET_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn)
> -#endif
> =C2=A0
> =C2=A0#define _DEFINE_DEV_PM_OPS(name, \
> =C2=A0			=C2=A0=C2=A0 suspend_fn, resume_fn, \


