Return-Path: <linux-pm+bounces-29721-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E75EAEC193
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 22:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D42031C2126F
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 20:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C792ECD32;
	Fri, 27 Jun 2025 20:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="bWjaJY6A"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD461F37D3;
	Fri, 27 Jun 2025 20:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751057727; cv=none; b=EU5m1xreYG9PTF64mKAEsQ4sZF42cPWw5C/wc5XWi44/QuDsRkDmB5Hib0odtqxdBGp/W7p8yNE4nlwfF33qfJlQ90BNyUDy4IUEL/Nx6dSIIREAW3WCHAB1mwS/wESqoUYa1MLRPzAOfEaYjxrK7wzNehvtYHXVSxPkqAiSIGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751057727; c=relaxed/simple;
	bh=Iy3cACmolLlCpm6h+lXgm2nS2ZxHsCMkZaSL+pEqTec=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ivhlJGaxU6ISP+0LW7uzbkv0tgAaAQlMqN5d41ibqOw/xwdhOm1e16LuPorAnIge1fqP07wOH50nDE4aVOUovVutDsnoY617QuIlElBwUotuUIgVPpYAZlG4ehwtoMGIWSkP2gNxnWXjke1EungA5h5Mp/d545SUkPDHGKaor4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=bWjaJY6A; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1751057715; x=1751662515; i=w_armin@gmx.de;
	bh=ZK5lfHITQIYdG4b8+6U4LrdYJT+fg/A/pCsaJDjS9Pc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=bWjaJY6AhBu5Z9Dr+ROsNtU+mqAsXaVVF+G3v5RUw4szLt6bwLiOO35dD+vahVbU
	 RgxHiwM0m1z3EUPHnvoE9/iIo+mjgS4zozGHHYQ7nVyUzUdQ8rgISw9blzOEoYUwW
	 wW1ZgGYm3Ezwr9Ad9uDD1YhCjaPGxzlQz3IuTRauueeXmUVu5I2V1OVL0P+aJ1KcR
	 4H2MEfINrvoVah/LUQUhySFz4EMVzT7xLd5atW+A01j1daTOOnXG9Uz8679DHMrqs
	 CcSFG+YxdacTJWX2N3b75K3k/GrCln7gjhCTS3bI1EPyWMqwwBnqvNhwsIeoHpw3q
	 FUNJl6gHpbESTGjhgw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mkpap-1v9JD33cHH-00anxL; Fri, 27
 Jun 2025 22:55:15 +0200
Message-ID: <d1a535df-37e9-481e-b1c0-c809923b34ea@gmx.de>
Date: Fri, 27 Jun 2025 22:55:12 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] power: supply: core: Add
 power_supply_get/set_property_direct()
From: Armin Wolf <W_Armin@gmx.de>
To: sre@kernel.org, hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com
Cc: linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux@weissschuh.net
References: <20250627205325.250608-1-W_Armin@gmx.de>
Content-Language: en-US
In-Reply-To: <20250627205325.250608-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wi81rAH/zYn3Lw2wFI2QIj8N7NBSBz2W5zZY+3vXFt6n9kAABY5
 LTD1lCkbIvP4LAtp88VD0aH21e29oBufYPplr/0jDkQK1htnP5AZv2Gm/UFAzWr2Bcz6RrU
 hRXcnB4h85gfiYy+IWkpyLiv1w3szQVWEngrm/NICHtnC5JYuyvJbrpQVL/v4zJOyiCFNvx
 n7poxVUFJ9KVbo1fvEjOw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LUokPHQmgQk=;LzQNAee7gaBYBk9+s2XPkVj4CGe
 b69eykTD+1CcHkGQOKDa1/kraigYOA5ryIJ6TsKveXUkMZtNuV5hlk2hFmNKc96HBMlkP5HbJ
 Z/W0IEylKq0Vrjr1FuPyZMM7KPaP4/PafCUk1G1L+8Se+0qLZuPS/oiLm5Pirw51taH4BwIgf
 J1HH36MQgUS71iZagYxcidqE1U64VPC7HGb0XHPiXJOZZD8CFyC68qzVgD71QIN/UddIOk22V
 b99lA3EBOE0S+yJgv1nbonI5FAlRArFUJ4LCkVvXCY6ieWS7jSzz0+5xDFj01/dBpQJSC26vf
 zWIgBHcQM7lpRIdqtcfGb/fS+ZdoHo08PoLKmVOxXhADEfKIW6CyjDudQfACShRuUgc74YlxQ
 cOjldzxsAewxWfkKRZ7oJVNCYcEwf86UwhZ64cl8hZinrzYwOIb49oehpq5pmBZhHzYOkDBRj
 7L/I4Fa7ThLRCrqPH3kCI7K8NEwvz5jxN3+oLM4uyXeualgjmYS/OkMSnNMj0Mz37eU63c3cK
 yQfJBGNGx+0xZi2uDRKHk2qCfVAUND5JyOhTUKBKOOaE37GMAkrdZweIQh+SfauqTXMtZCSoL
 GtRu4OoFNrngYvOBrhTVaidpdKmKj2Lzu2ivtERYCAZ9RCpyf6Zd+L038TYhnQ0H34bBhhOIV
 RAG59TF4C/8FSlnqY7CV8dA6uKqQIvqpHKvBIzjLEUjxEi0o3HU2KPV2HepQ7oW0y63MYrlHZ
 ySd+YMHQsbfF5NQKXB2ze4/GPlPnMigtekxbnY1tq8XY/X3b5piUIdwN/M+nrIHWA/6Vm1BfV
 3xK7rznUFfuCsHS73q3/HXbEz2W0X1VUYc0LopQl8yogbkJwWCgyQIGbplVCXwTiu4pqfP3WD
 aYM1TWjABaNlEElwVDwTRH8CYF8nwtUsZRRkUKNYm6oqVWFYs4q6cQ04NuB+qM90hmEDwEp1F
 leFQEarB10bcCjQgJeJ53+/Cq4KQbNh+z720DYE4NThdmIP5eS61DI6+m3o6UpAmM5ObFKw2f
 uSNAECiXSU0nHGGTRAkPm8bBapJgAphtd4gXcYJcjJlu1euco0j/eeMWMaDiWB+ZKjdhU4Yp6
 d8rIMNF8/q12DMtFJd8GoCXEwgFZ1CfZiGqPRhZkxYL375Be1kX/KmdI/j3XV+2dRSQLM5iZ0
 cO1v34xl4AxJC+Omis2xgM3O0yB2DfjkoegQbHrt9OWqvwbo0OtvvRoU+PwaZlmUu2QLAhkXG
 vq4xFMq1aSeTUYi5f2wkkabxJKNoPwfHoAfkAD/QSFUdA0fT/cg8Wnkjct8j7gRKuHDNIWKoF
 +GubLFRFAvvWAvkGDjhK8d8LB0hVb3W2ashw2c6PKI8UdIpYXjUJZOaWuMi6IX9VFXgbPd4ny
 FcsaNCFvAzvdFxjqzkU7xCPQao98h+/Vj706eopnP4TQPYa4OqnH5Z8Y0CMZMAd1RXZx/Arm4
 eYuz5c2zoCZ/DuGKpzQ5EKzQ1/TzjjQDNawdi+TVnT+m0jD5rIwUhH0mdmandxkAPxJw2T2qh
 npg9o0HdtjePh/HkYc6YpomLlayNhSUXvzuXp6lYpDE7ReP/1KTqHSEQicAQjSMvZquRnimFF
 SzFYKYLysMVsn32uxUJobOWoq+fzKKlmCBsFVeKw3BOq6mzsEH6EfhgTFs8SLH4AxAPn0h6m6
 wBwgPsmG37YFOzUeYUI3d/70PqDCiuDah1tmR7Qnfec9eMlOc2GgIJQcKrHCEX5FZoDdEajQY
 xBmuOz/4A1nSR6OmRGy+LiPUwT3mHqQqd50THfqhIQgqGca86gkPsSWrmEDa6frqIg99yBreO
 5O+HaguuQzRx5AtpT0jOLVuVbgR7kJwdHdKLZW8y9Mubh+VcKMQFZiadf540v26DSIhTzy3MG
 ZLjoqI6GWTlOi6VchlG2zY2+HUvL2vHr5nifcczDaRMCWOuTbx8fhxSCC9VeBcHjJPmF/K5Uc
 eUTvht/MzV+5mM00bSO1d6I2crrVAw/+Mhj61j42oe/xQ0fO5WNtlm1WKunaS92djRnOsSaYT
 vC4mfd+bJTRI5C4LhlXmgGrip0R+ROAD7Sc26wV7A/WhsoI0nC6wlJukJ34GOzvvZHNl/O/OY
 ZGbwE17lnwm1RzdDo5Traptf9CUUsdMNT8y0mru+QT88uc8O/tm6y7/FChyUCOK0z1wukEHEV
 D/PUnYQgtPF/xrigsVjAI5RYY72LZXLY9sFO02tBMYhmETg8wvg1jQ8r3GzoDi8U2yOEBhebw
 KQLxyCwKNdoIV4MYEOLl0YS3NuB7tEyVTNI3ULg3HUHzpxBKjYHq3JsVGShkfoB7SVZvCtGW+
 Yr7ZF+4hOVtEpBFzCaE7pwT5+qdfCxabsACukXWYLx1LwcF4VTImXTCwojfvOhQNTjw09ICSS
 v3KrNoS1va9CngZgdUAFEwVYPp5Cx5jqCzqG6q91RKmr6QWKCshTclAvTFm4jtgCpJgb69rq1
 4BoxqiHgrjii2U0hrIJM8Wvnw+jTmvUA3gEvUNFl0l73RQ6ZBpGqw8BmG/N0jUilBvOgWk9D9
 mVkeEZCPedQ9MOG4LYxcydMy8w8IQX/fk7hpeMUgLA8ogiZ71d7Wt3v5PIhxkbEwHz8FXe9Bi
 azlLyz+4YKSzUFqn/4Q3rd3+AYGEoTMgGhlj7zzC135IjnK7D4LaVW7dh+IykUsmi1uVZvOL1
 LjxUpzJeESdH7KBSZrieHSt9zSRdSIq8AHdYdFDZ6mHfkxw4E5Bq0F9MR6teHaaM6mvziIfZ+
 8YW9Y1ILtodKkbswIwAn1fBxDRdX4XE22O0lnFCMnm8n3URZub0p/Yy7jE/FwHh4/3F1igyKz
 BIsqHtq38U/N9uRFxVmruyfkWb2i3G+WPjyv+hR7z7ELEGNHUKLcosXueyovDlYVn94pXqqf0
 1xAluCi77BgxBRyqC8CKCFyejo7OrYhA6f9/JzKvp2k5JctHZ9dBgTsrn6aTEUdFTWetwb0WI
 7xE3hrfvnzjnHYhoPmmZh220nL1Hx011oD0We1hg6LUYw2W9trCZXjlIdoaP8CntESbYsj17B
 BD7xAOWUHqVbIqxcN7J+Y/QLqSeTuwO/hBzkF5kN3EiRgUnuElihy/+OXWeyk9D6AGjCYBu0S
 ClyK+kCakyUCSorbSkyTTPs7sXl03Eg2i16GZAs0NZoWNDPHCR4j+wm902n5hDgJkfXctFn4n
 3S9JX4ldoLQqpG+K8QJpV1q+BtiG2h2e/tumPBKoqAnfdnbSD5IQ0nGmkB6dF8lAGcR7QiWd5
 h3k/1nPcNfL+2GH5I4lPKI2xoNQEcI6JcWdnPpZca98jCJo+Ege5W87R5+sv50E1AcTsb9ACY
 c8YV6gRLzGARcROqPNItn3p40cObSdArPXEIsAF59YYYBYKxm/C5wpNRKcfMh9BF++0F9PeZ3
 PIFP443RdPW5VdEd9MiMWS1PYU1To5lMJ5Qe6isUUhoSORG1JFtdgm5xRYUE8RlILrW++EdP6
 Ssx05Q2NtiDy/kIGrwtIS5pYAF24tIbduEZnbPr0Wt0KV2VV1reeNubXkZV3iA6Rcr0oXRvzX
 5npxIKMKkOmj6wUTjzdGf3ufKKwo93sXVYnLugmD4nNx

Am 27.06.25 um 22:53 schrieb Armin Wolf:

> Power supply extensions might want to interact with the underlying
> power supply to retrieve data like serial numbers, charging status
> and more. However doing so causes psy->extensions_sem to be locked
> twice, possibly causing a deadlock.
>
> Provide special variants of power_supply_get/set_property() that
> ignore any power supply extensions and thus do not touch the
> associated psy->extensions_sem lock.

Sorry for sending the same patch series twice, it seems that git ignored m=
y request
to append "RESEND" to the title of each patch :(.

> Suggested-by: Hans de Goede <hansg@kernel.org>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>   drivers/power/supply/power_supply_core.c | 82 ++++++++++++++++++++----
>   include/linux/power_supply.h             |  8 +++
>   2 files changed, 78 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/su=
pply/power_supply_core.c
> index aedb20c1d276..e70ffedf1a80 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -1241,9 +1241,8 @@ bool power_supply_has_property(struct power_supply=
 *psy,
>   	return false;
>   }
>  =20
> -int power_supply_get_property(struct power_supply *psy,
> -			    enum power_supply_property psp,
> -			    union power_supply_propval *val)
> +static int __power_supply_get_property(struct power_supply *psy, enum p=
ower_supply_property psp,
> +				       union power_supply_propval *val, bool use_extensions)
>   {
>   	struct power_supply_ext_registration *reg;
>  =20
> @@ -1253,10 +1252,14 @@ int power_supply_get_property(struct power_suppl=
y *psy,
>   		return -ENODEV;
>   	}
>  =20
> -	scoped_guard(rwsem_read, &psy->extensions_sem) {
> -		power_supply_for_each_extension(reg, psy) {
> -			if (power_supply_ext_has_property(reg->ext, psp))
> +	if (use_extensions) {
> +		scoped_guard(rwsem_read, &psy->extensions_sem) {
> +			power_supply_for_each_extension(reg, psy) {
> +				if (!power_supply_ext_has_property(reg->ext, psp))
> +					continue;
> +
>   				return reg->ext->get_property(psy, reg->ext, reg->data, psp, val);
> +			}
>   		}
>   	}
>  =20
> @@ -1267,20 +1270,49 @@ int power_supply_get_property(struct power_suppl=
y *psy,
>   	else
>   		return -EINVAL;
>   }
> +
> +int power_supply_get_property(struct power_supply *psy, enum power_supp=
ly_property psp,
> +			      union power_supply_propval *val)
> +{
> +	return __power_supply_get_property(psy, psp, val, true);
> +}
>   EXPORT_SYMBOL_GPL(power_supply_get_property);
>  =20
> -int power_supply_set_property(struct power_supply *psy,
> -			    enum power_supply_property psp,
> -			    const union power_supply_propval *val)
> +/**
> + * power_supply_get_property_direct - Read a power supply property with=
out checking for extensions
> + * @psy: The power supply
> + * @psp: The power supply property to read
> + * @val: The resulting value of the power supply property
> + *
> + * Read a power supply property without taking into account any power s=
upply extensions registered
> + * on the given power supply. This is mostly useful for power supply ex=
tensions that want to access
> + * their own power supply as using power_supply_get_property() directly=
 will result in a potential
> + * deadlock.
> + *
> + * Return: 0 on success or negative error code on failure.
> + */
> +int power_supply_get_property_direct(struct power_supply *psy, enum pow=
er_supply_property psp,
> +				     union power_supply_propval *val)
> +{
> +        return __power_supply_get_property(psy, psp, val, false);
> +}
> +EXPORT_SYMBOL_GPL(power_supply_get_property_direct);
> +
> +
> +static int __power_supply_set_property(struct power_supply *psy, enum p=
ower_supply_property psp,
> +				       const union power_supply_propval *val, bool use_extensions)
>   {
>   	struct power_supply_ext_registration *reg;
>  =20
>   	if (atomic_read(&psy->use_cnt) <=3D 0)
>   		return -ENODEV;
>  =20
> -	scoped_guard(rwsem_read, &psy->extensions_sem) {
> -		power_supply_for_each_extension(reg, psy) {
> -			if (power_supply_ext_has_property(reg->ext, psp)) {
> +	if (use_extensions) {
> +		scoped_guard(rwsem_read, &psy->extensions_sem) {
> +			power_supply_for_each_extension(reg, psy) {
> +				if (!power_supply_ext_has_property(reg->ext, psp))
> +					continue;
> +
>   				if (reg->ext->set_property)
>   					return reg->ext->set_property(psy, reg->ext, reg->data,
>   								      psp, val);
> @@ -1295,8 +1327,34 @@ int power_supply_set_property(struct power_supply=
 *psy,
>  =20
>   	return psy->desc->set_property(psy, psp, val);
>   }
> +
> +int power_supply_set_property(struct power_supply *psy, enum power_supp=
ly_property psp,
> +			      const union power_supply_propval *val)
> +{
> +	return __power_supply_set_property(psy, psp, val, true);
> +}
>   EXPORT_SYMBOL_GPL(power_supply_set_property);
>  =20
> +/**
> + * power_supply_set_property_direct - Write a power supply property wit=
hout checking for extensions
> + * @psy: The power supply
> + * @psp: The power supply property to write
> + * @val: The value to write to the power supply property
> + *
> + * Write a power supply property without taking into account any power =
supply extensions registered
> + * on the given power supply. This is mostly useful for power supply ex=
tensions that want to access
> + * their own power supply as using power_supply_set_property() directly=
 will result in a potential
> + * deadlock.
> + *
> + * Return: 0 on success or negative error code on failure.
> + */
> +int power_supply_set_property_direct(struct power_supply *psy, enum pow=
er_supply_property psp,
> +				     const union power_supply_propval *val)
> +{
> +	return __power_supply_set_property(psy, psp, val, false);
> +}
> +EXPORT_SYMBOL_GPL(power_supply_set_property_direct);
> +
>   int power_supply_property_is_writeable(struct power_supply *psy,
>   					enum power_supply_property psp)
>   {
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 45468959dd98..f21f806bfb38 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -878,15 +878,23 @@ static inline int power_supply_is_system_supplied(=
void) { return -ENOSYS; }
>   extern int power_supply_get_property(struct power_supply *psy,
>   			    enum power_supply_property psp,
>   			    union power_supply_propval *val);
> +int power_supply_get_property_direct(struct power_supply *psy, enum pow=
er_supply_property psp,
> +				     union power_supply_propval *val);
>   #if IS_ENABLED(CONFIG_POWER_SUPPLY)
>   extern int power_supply_set_property(struct power_supply *psy,
>   			    enum power_supply_property psp,
>   			    const union power_supply_propval *val);
> +int power_supply_set_property_direct(struct power_supply *psy, enum pow=
er_supply_property psp,
> +				     const union power_supply_propval *val);
>   #else
>   static inline int power_supply_set_property(struct power_supply *psy,
>   			    enum power_supply_property psp,
>   			    const union power_supply_propval *val)
>   { return 0; }
> +static inline int power_supply_set_property_direct(struct power_supply =
*psy,
> +						   enum power_supply_property psp,
> +						   const union power_supply_propval *val)
> +{ return 0; }
>   #endif
>   extern void power_supply_external_power_changed(struct power_supply *p=
sy);
>  =20

