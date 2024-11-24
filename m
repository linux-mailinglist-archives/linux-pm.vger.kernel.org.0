Return-Path: <linux-pm+bounces-18001-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E6E9D76E0
	for <lists+linux-pm@lfdr.de>; Sun, 24 Nov 2024 18:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1FB1283B69
	for <lists+linux-pm@lfdr.de>; Sun, 24 Nov 2024 17:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104C813B284;
	Sun, 24 Nov 2024 17:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="sEbnVTfL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADDB8460;
	Sun, 24 Nov 2024 17:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732470516; cv=none; b=R6vAxGH9RR/9bzzrtg/nLx7VUwlmZaTtczdO1yfw2HHOv8u9mgYwGGsKCP0YM2d0L+ug/foCQhhCO7M3jX1WFfROf+ptQCpBDyQxfIh46MfVGL8+25k1Qv9AS6GJmomYHSVSBeKIV+tPpkGxuXmERHR0vlx7BalCN2mxnXrHnyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732470516; c=relaxed/simple;
	bh=Gdzs4uKE7jGt+/EBHqLaBy/EK+be+aBmgqp6w5DFfyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DLWdDdqHPO4tMfRrJ5TICO28kb4dUt7GCgxCrJhDFWimBl9P1jSSfjq9K2tWqUcKGGgDztf47vvjoJTqHCu1F0hL2GNeNQfaqhpHe6EywrgqpGB/F0GXZn+7j9fMP4YSJys0U9FAImwI4wuBSK/F/+rpL1QTZY9hQ5mtawWvWxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=sEbnVTfL; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1732470501; x=1733075301; i=w_armin@gmx.de;
	bh=Ec6e0cxiUbLku127JupgUsP0HdDhf238R3Z58IYigKc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=sEbnVTfLCDbhNamAQ8S3otHYJwRc8wXcBZPGa3A0ND0xXs97+HEaRAhKNI8tJztR
	 Zg1VYOsvtbjYXfvq0FBbLNxMLv8iHm8jv9RHmCIwCEWhikchYk9OSIfxcUwt+Y42j
	 CMA0QvHCPDvvrvAEsZkPW0GCz/aQimhsFLJdxnCkzUYQ5gDSLI/az8/EYZ8gTDgoD
	 YPADtXZUb4XlNNmHS9l+vS+cendvX1Cp5svhWjGP9QaaTwqj9B6Q/ATPwmEidH6R/
	 nHC5NrDWBxS5keJNFHsTxd7mXasZDCwnXk71QPEmiUwtpewdWAsMZ1mGARqTMyDEb
	 8Nn0sGRPaOd3XNM90A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([141.30.226.119]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mw9UK-1tY1zN1eoG-00rKUX; Sun, 24
 Nov 2024 18:48:21 +0100
Message-ID: <6a355afc-d282-496b-8354-90044ecc2bd8@gmx.de>
Date: Sun, 24 Nov 2024 18:48:19 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/9] power: supply: core: rename psy_has_property() to
 psy_desc_has_property()
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>,
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 chrome-platform@lists.linux.dev,
 Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20241111-power-supply-extensions-v4-0-7240144daa8e@weissschuh.net>
 <20241111-power-supply-extensions-v4-2-7240144daa8e@weissschuh.net>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241111-power-supply-extensions-v4-2-7240144daa8e@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:L5ISpSDIZoaS7IKkN2iN6kXnUhQ7xCeqM9619mrQcrmse+FuEya
 qDfP/GByz3IgReimuw5SCXufHXFTmpOMhWbw4D6/9qsNuV/xGvZpSIMaYnShBqGhFweUHG8
 ERHKMM6Xk4mN1+t9xuh8LuMk32rbIUxu4macjOIVA/7POuvFTsvQ83bwBj2IGTCt2F16hMc
 pF+YVNcP5ICCVaUO0IC/w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9nXxO59AYJU=;q10le21Owy8yVDgw6BTaqiEeRmp
 69efm/JrqOWs/SCs4IaoRrPaFp5dVlhhdn6dzttwmmVzhiH4fMD71wrKyfOH/UK5IsJmexR2d
 X0GYcpWqdTHQ9/WP2g3TSQ0oMNzZ2dJgy9TmZvsHjUJnZl0bwWGGrvH66K5PlJhx6Cz/D1E0f
 u2d3vSUba0gJeI0uERRUYIdBoXJGJvN1LTaw7DOSB2ypoxUmjdTMJeQWTpahwvzHegX2Nbt3a
 7nHLCUQAfoU1FNBN0Wedt56S4LfKH+nxzZITlZVOms9wsSvQzNsbpo0vLXkYUgAuGSEUzOdEg
 PhkfMxEM9IIMjHIHFkAVAZzcO1TynzU/c16wvwAbPm6Lg1rWim4LIAOrL5F7q08fPw5veFahG
 JecTGuq9H7oYeziqZ775cuG98rvNcaNxkK22v5Xy8T8dIE2ERbNyLQztoYd84VAsboOUKxP00
 yQcQofCRvvubKqMszL/mKziJI+O9EgvXAJeCTuvu7NYEGZ4djGSPecJGAmidgaSI1PNbwHkPS
 kH8QIBRBqAGWNSpctalWsPms/se1xBmH0uPCMOdRZnrnLTwXIsUvFI557GIxmT1uAwE7SY4ef
 go7LISZyDIEoVArXwmLqlLymDvs+huNxsfmzESXzV6SBzXiJMhPPZn3z9YssvCrZo+T3CJ6DY
 PjS2zsjTtfW4vVLMOy9OKRD753U/wSizkepRtmswBBN5D91TyBKPcNvPaEQbeuNcuvEPGgAOZ
 YF1yFq6NfnWfTkWr0sUuC0EweYpjG5Gye7D7zwXT6gUSEp+2o2+qXwL0Qs6OJm5teFsHaWIDP
 CmIkUtrzt+iGZkhF5QDpOcnxjRDi7U3TUcpE2SkYS8vR8lDCXTOJ2Y5AGokSMQnf8a5XGULsq
 PfywHLD9v/nk5iIE9fWLf+FUaW3GWlHX4n+HvuN3/P5JxP9RJgHULl+LN

Am 11.11.24 um 22:40 schrieb Thomas Wei=C3=9Fschuh:

> The function only takes a desc as parameter, align the naming.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>   drivers/power/supply/power_supply_core.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/su=
pply/power_supply_core.c
> index 16085eff008442ecd04016cd12c2854a0230d9c6..2f61f6b90b99f40ee04a6d63=
ebc20036f0447102 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -1180,8 +1180,8 @@ bool power_supply_battery_bti_in_range(struct powe=
r_supply_battery_info *info,
>   }
>   EXPORT_SYMBOL_GPL(power_supply_battery_bti_in_range);
>
> -static bool psy_has_property(const struct power_supply_desc *psy_desc,
> -			     enum power_supply_property psp)
> +static bool psy_desc_has_property(const struct power_supply_desc *psy_d=
esc,
> +				  enum power_supply_property psp)
>   {
>   	bool found =3D false;
>   	int i;
> @@ -1206,7 +1206,7 @@ int power_supply_get_property(struct power_supply =
*psy,
>   		return -ENODEV;
>   	}
>
> -	if (psy_has_property(psy->desc, psp))
> +	if (psy_desc_has_property(psy->desc, psp))
>   		return psy->desc->get_property(psy, psp, val);
>   	else if (power_supply_battery_info_has_prop(psy->battery_info, psp))
>   		return power_supply_battery_info_get_prop(psy->battery_info, psp, va=
l);
> @@ -1300,7 +1300,7 @@ static int psy_register_thermal(struct power_suppl=
y *psy)
>   		return 0;
>
>   	/* Register battery zone device psy reports temperature */
> -	if (psy_has_property(psy->desc, POWER_SUPPLY_PROP_TEMP)) {
> +	if (psy_desc_has_property(psy->desc, POWER_SUPPLY_PROP_TEMP)) {
>   		/* Prefer our hwmon device and avoid duplicates */
>   		struct thermal_zone_params tzp =3D {
>   			.no_hwmon =3D IS_ENABLED(CONFIG_POWER_SUPPLY_HWMON)
>

