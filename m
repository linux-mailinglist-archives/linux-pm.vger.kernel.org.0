Return-Path: <linux-pm+bounces-37261-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 29713C298BA
	for <lists+linux-pm@lfdr.de>; Sun, 02 Nov 2025 23:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C04C4346F11
	for <lists+linux-pm@lfdr.de>; Sun,  2 Nov 2025 22:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C625D2475C7;
	Sun,  2 Nov 2025 22:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="EropUjAR"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CA723E229;
	Sun,  2 Nov 2025 22:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762124130; cv=pass; b=H/qnVMQsLBXIf3Ibf/l1a8kbEDK4AzByaXpaMMHOVFz6UknZ+YC0lC9ztZM4w719gbz5R2gBOgd5MiJb6Zy+0ExAI7f0EHwilTVhDseVF0LnWylfXxvQUTsMrh2J6wrJKVsIJRcNkH50VUejieOFuPpo/mu+b2RJTAO9+zedr0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762124130; c=relaxed/simple;
	bh=jyJblbvJ0sLYr7bCn28ST3tswXiXScXyRcbWm5D6Q6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGVp1bNNnjtPYyoNGb6EBsajt0Npp6QQB5c/p87DdWXAS8G5dEeDKmTtNULm6Aqa2QnArZ8417A2Tri3q/MLovwrcVQu2hChU8iAvCTgJmr2btkYEfNwPHLRq7DB5nB1i6mgLiN2vneAqiCkh6KmgPMpjkFRD8ng0yhfue/NMKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=EropUjAR; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1762124116; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UDgiZmGqoNekVObK2Xcfq+3X8ny7LksJjp0LpmgGgxySGTaY2XO4BoKz/n4sty2jBaNANPIw0aKRx12j/zqeDgdi2pj0lJORNlx9aNvMqsrUW6aZb4R2Z9NiV24vdz6nY7bLubWFun+zXOKvm82x8fIhgdlwZAhO2NpxBltmvgo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762124116; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hoIZshhwY3LgSE1vRhUe7P+FDEhvxk9JLKv2Oi3eqVA=; 
	b=hFnf+Jkc2+SsKilaSq0SWZtMsJfH4OTZ8/AfbpBtgWSJHRZfVIsAPVA5u5grrB+gAbMlqqYd7KLgQw0diaVgLtlNbAmxc/+nik3wRYqZTKC/jjmWXwwGXQA7RdbyV/Y/QapxP7P0+AoYR9kird8992o2jyRrIAHAsvZkisvajCE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762124116;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=hoIZshhwY3LgSE1vRhUe7P+FDEhvxk9JLKv2Oi3eqVA=;
	b=EropUjARJV8N3Os45Tu8kvjrckB2sK9+RLgwJ9Xz9+CWOrR9rouVUs9xcOOWxgRy
	j8Q27zzAATMVnr64zGmzPfWl6MBiN/fjmKAKuDyR6CJELg+B3dbV+ovrEv3xQuvRd+S
	0AQIGJ1a1KSyOfVhCM/cTnadtrhUkOLUnbvC6+tI=
Received: by mx.zohomail.com with SMTPS id 1762124114844164.23699285268174;
	Sun, 2 Nov 2025 14:55:14 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 7A878180CDA; Sun, 02 Nov 2025 23:55:04 +0100 (CET)
Date: Sun, 2 Nov 2025 23:55:04 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: 1647395606@qq.com
Cc: linus.walleij@linaro.org, brgl@bgdev.pl, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-gpio@vger.kernel.org, 
	wangwenqiang <wenqiang.wang@faiot.com>
Subject: Re: [PATCH] power: supply: Add SC8541 charger drivers
Message-ID: <cmdu4opg34tmoqz6uc5x26afxh7q6shkeoefniottnnk4dpjso@qgpbqoe4ra6y>
References: <tencent_DAD6E4E85F79FDC4DF2878B03940CA337108@qq.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wzdpsbha6mt7jix5"
Content-Disposition: inline
In-Reply-To: <tencent_DAD6E4E85F79FDC4DF2878B03940CA337108@qq.com>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.3/262.86.93
X-ZohoMailClient: External


--wzdpsbha6mt7jix5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] power: supply: Add SC8541 charger drivers
MIME-Version: 1.0

Hi,

On Mon, Oct 13, 2025 at 04:54:14PM +0800, 1647395606@qq.com wrote:
> From: wangwenqiang <wenqiang.wang@faiot.com>
>=20
> The SC8541 is a charger pump from South Chip.
> By adjusting the voltage difference between the input and output terminal=
s,
> it can achieve a maximum charging current of 8A.
> It has been verified that this driver can operate normally on the Qualcom=
m QCS615 platform.
>=20
> Signed-off-by: wangwenqiang <wenqiang.wang@faiot.com>
> ---

(incomplete review; I think the nice review from Linus is enough
work for now anyways :))

> +#ifdef CONFIG_MTK_CLASS
> +#include "charger_class.h"
> +#endif /*CONFIG_MTK_CLASS*/
> +
> +#ifdef CONFIG_MTK_CHARGER_V4P19
> +#include "mtk_charger_intf.h"
> +#endif /*CONFIG_MTK_CHARGER_V4P19*/
> +
> +#ifdef CONFIG_SOUTHCHIP_DVCHG_CLASS
> +#include "dvchg_class.h"
> +#endif /*CONFIG_SOUTHCHIP_DVCHG_CLASS*/

Drop all of the above and any future usage of the ifdefs. This kind
of stuff is not acceptable upstream.

> +#define SC8541_DRV_VERSION              "1.0.0_G"

Also drop this. Upstream driver can use the kernel version and it
surely shouldn't be printed as an error in the probe routine.

Greetings,

-- Sebastian

--wzdpsbha6mt7jix5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmkH4UQACgkQ2O7X88g7
+pon6A//ZFbgXZIwDYaqKrhDST0YQNngNpwn8YlgrdZL0WaWWTrHneIH+ECzbno2
aF4wJzoh9+sQXLV67nH0oxZEzuJ7MWjfCbZUn7y4eI5JxOJCt45vxsN2H/UhSJZV
8NHYvw9Rxd8hZKvGV4hmvCQlfvocvfyt+lYoY+CuJJesSYOOGuMXbHqXG2N0ZPz2
ZwznCET+R8DnPjDEjcGwiz38h/n03ZWGyF9ncFC5Duux25pvefkud7oU11Pd6822
eWO/HRzWxaiqQ2gLlKtZtOikLCNAKhO4V3aUZ0LAyV4hxHBPrtXeJ7oJAVeSMe+r
iDJjOUqwLvEOlhabcygzLVFA0YWt9Nlm7eNPXtxBA0sqGNthgbIgSCErenKUiQdF
CuYBZzOoREl1qR12BOmVAsTYlJRqfSjfhbxdkMjlQOXvgV/jr6dQ3KtGQ1d0+L7r
fwhPwSFM/D5yBzSq+fvJ4/LYp9CNhrYIXJL+38XhV2PYPA7LCaMiuejJszxUEJ7w
d8FzDUyIhGyBEI7/YOcGfz9xQSWd4Kl7DxYkB3H+XlxpWLq2fwg/40hyb0rYBanC
ZFtSH99OtYHQ/1LjLzxGbw6DBQJewNM4gaWMrerKQFTUxdXhHRDBn38qPlXqmRRO
fEYc9ds93KVLk3KGWVRRL8eZ8fil0AQa/JcH+p8B5rqLKy7TQCY=
=0qAR
-----END PGP SIGNATURE-----

--wzdpsbha6mt7jix5--

