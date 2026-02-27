Return-Path: <linux-pm+bounces-43343-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGbaLhHMoWnbwQQAu9opvQ
	(envelope-from <linux-pm+bounces-43343-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 17:53:37 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 352EF1BB0CB
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 17:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2A4D6301BA75
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 16:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7993334A774;
	Fri, 27 Feb 2026 16:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IqqREgXB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED48B349B00
	for <linux-pm@vger.kernel.org>; Fri, 27 Feb 2026 16:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772211214; cv=pass; b=St5CB+2n13nh/iQztRdBvO55L6X5peRfXXuVXikTxgFOFqfQ1hIjSnkb0SzkpFWRyi2JUnIEHgPy9r81+LAm6dTkQzXfS+E4RIoyfxB8o/Jgh65ac5CBvAE8Z6gWUWcXjA3wNN8DALd4lAdbL/I9uPVHpQqgd7wsdh8sUdwXoOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772211214; c=relaxed/simple;
	bh=KZngnYUFiL9iC7PfOpmHfHOayoaMJPuP6405Q5pqqfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GtG7zzwyWqWikDSrz810RfD0uitzox7unt+lmjIbESvIk1F9BHVtsA9UFDFgswMbqcFJqAFdR2vhx6+zT2fqtuvoKOVrHpscR0i9uX6L0ceUe45JZOicgGszYbmbb0aw10Y1WoTNeEMRRZT+CaTjENgU/nYa0xIcZiKSix0+cnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IqqREgXB; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-65f73d68faeso3679560a12.3
        for <linux-pm@vger.kernel.org>; Fri, 27 Feb 2026 08:53:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772211211; cv=none;
        d=google.com; s=arc-20240605;
        b=gSrpUhdjQI887wK795Is5MUwZ8lOfEnD9CAKidc3+Wsyr6/CO596h+rspCAzP8qoDb
         qvVI+uHOzIMJuDforojRyii+sWmLJjjA9Alv8GZKlNDpGUxbEAGpRsG3xCcXkNluxStI
         Q71VXsKbfyocagiXj5e16Vmp0Yfxwd7KVj4dwMswLRF3hy7s2DgruUB52gwW/4xcHBsC
         yQWL9hh5f4zaSWBlc4yfAnaZiOxkV8qKRFOEg4O61ONCel4E6eOqRROWfZ7GvoHMmq9b
         hLTVImlTb+tgAeMKJ389qROHMPH+pkmHtXDztriVpHrey5aNF/umwQ1zqIS8E4LAtJ/P
         wggw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YnQBstCl1AwhiM2ywlP8p0cFY97sOWrrQ4M1rwGrcGg=;
        fh=ySEFA7a1RmSjLr4vsSKgJ/Lv8HTv8YWjkDCLQmJv1cY=;
        b=QwuN8Wdtxqpbi/KDFgtVZCODbf9BAh5veucePxU4KFxStq1BF+MDqXO3cBYODrngh7
         titDR5IMJfNj8HH6tHAXTvZD+QtCnTTi907vLm+BC0aBBjSoYLz244MO9qZNZTQQIGm5
         +EO8rj2IeCADoiq7gRMuiZOraVWYq25u9wgtxXlTyb8EelVgq07vCcSJ3bIseNcPDSc3
         5mE2B628+11On2MGWn/ezKyq0kkQmELY0wY0/wH8H/w/st3Lp0RAziYwYx61MBY3Oj5t
         1eRQgWz6o+JrGfrsbr/75ympCrQrkaZbLlbmOEOyugeSY+q90Z1yBdA/k70OU9IFf8WR
         sDHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772211211; x=1772816011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YnQBstCl1AwhiM2ywlP8p0cFY97sOWrrQ4M1rwGrcGg=;
        b=IqqREgXBjpI80Bmudspq923mrD9H0Uyxxjm9wxO2zjrA9LL/WTtYakC/YDSKmrEUnQ
         mHGUVxwNGSdac7wNU22ZOWQoU1ExKRNx6RY8/Y0tHNmi0tIT0muaJ7ugDOwLto4Y5dlt
         9mwfRDZTJuzjnTl9LD2faIZtTV5mkBWs560iWZYLNe8GCe2xepGjpHmGBerf0FsWDSY1
         VZOwFJLdkx1fq+B8ui2UexiE6VdG/gmx+BXJa5wsiW2HJwTTYNaUyaSWt42mEn3c7QEB
         9exqAJBiGsb2qLcQ8GhXBvCNuZncQ3tYv7kKr/sLYE9usXuX975szK1uPnRaUkYpLEUI
         dg5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772211211; x=1772816011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YnQBstCl1AwhiM2ywlP8p0cFY97sOWrrQ4M1rwGrcGg=;
        b=j6LYnv5m8Mi+MUREPCw9cT/dqN7OzNXf+HQEl1ypLQPBvCVuZViz/TN99+t1WNtp5Z
         jw1SJJeVQb5wLdrlXiYp1FF8cgi5mi6gxcHqJ6aSbuD3MCPdOlUGGubJIr8XhmPrWd88
         WMvEIn64ZCOktPOCTDDiL1KVmv0YBfD7TUxtLdyIEkNXAv1qL6mRqlI0BxtMTVbBU7EG
         bfv/oqQfY/NStKW1YBGgOwWOdmlswokC+3oRWolLP8VKjqZIai/1/oro0UYx+8r4CY0k
         meGZjIFZNVvFrIL6uRxb+ljsDqFIHo4ZrbOwjWc8sdtwgaGvw88K35wvFCRzcn7Z3Prn
         a8YQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSm+D+VWsLEpMGp+sqUe1sInUwfvWEQwSc291XrCSu/70CuHFZBwbAEdC+3zaGO7IpGP7KlOnNIQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzV4Q1HwWu8elLHHruDR2zguT9MjTTBNiMqVPoHoQ9HwrTFem6X
	y4wXMY5K+u3KQHFARwtJrQ4kaOee/q27NnNBQHCKbcV+puoWyjQ6XE5ASwcVfYebU/pKkuP7XxC
	cYg1IodnzbOmygOdoSL1BJwEWqF78z7mQtO8Rltn++w==
X-Gm-Gg: ATEYQzwx03KN7sjl6YizXXrDI49QYdGTj1LXfJMZRaKHUd//TCcx2/ZJTX2kTW74y9S
	eCsOcBOPzD7b+S2dFJyv6lV3pcMWsO2wQccxKcHH6cDEFbOHsmss1GdCvZQPQQL+U8vJ7meZNKF
	mssGLxwZUwoDsrYeWDS/SuqWueaTfalixSDnCa4mdXb+JETLOshMWp0gnec9XWqYRTtIU23oKN/
	8nYg0AqtzBelI2j03nFNj4th8gAb1YP3CVIqN/4QTvKcAiFrYpL/+j88kNMAP/HoQ3ubYADt66C
	Rbscs/bw1Te3IMT8JvyeMA==
X-Received: by 2002:a05:6402:4493:b0:660:475:93f2 with SMTP id
 4fb4d7f45d1cf-660047594bemr437404a12.18.1772211211217; Fri, 27 Feb 2026
 08:53:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227-max77759-fg-v2-0-e50be5f191f0@linaro.org> <20260227-max77759-fg-v2-11-e50be5f191f0@linaro.org>
In-Reply-To: <20260227-max77759-fg-v2-11-e50be5f191f0@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Fri, 27 Feb 2026 16:53:19 +0000
X-Gm-Features: AaiRm53V_nRNAsdqihybXB9OG23TzesOAxPFDxCpIlU-WABHWGF_CL5bChRorMU
Message-ID: <CADrjBPpYd+9jYt6ec-VF-ZS6Vjt0Lu0jo2T7B9TO=AQmcjL1dg@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] power: supply: max17042: report time to full
 (max17055 & max77759)
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Hans de Goede <hansg@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, 
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, Purism Kernel Team <kernel@puri.sm>, 
	Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
	Amit Sunil Dhamne <amitsd@google.com>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43343-lists,linux-pm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peter.griffin@linaro.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,linaro.org:dkim,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 352EF1BB0CB
X-Rspamd-Action: no action

On Fri, 27 Feb 2026 at 07:15, Andr=C3=A9 Draszik <andre.draszik@linaro.org>=
 wrote:
>
> Report the remaining time to full as calculated by the firmware for
> devices that implement this.
> Similar to time to empty, the reported value is only meaningful when
> charging, i.e. if it is !=3D U16_MAX.
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

> v2:
> - limit to max17055 & max77759, the datasheet for max17047 and max17050
>   describes the register as 'reserved'. I was mislead by the comment
>   and enum ordering in max17042_battery.h
> - report as POWER_SUPPLY_PROP_TIME_TO_FULL_NOW (not _AVG). The max17050
>   datasheet is a bit clearer than the max77759 one on that.
> ---
>  drivers/power/supply/max17042_battery.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supp=
ly/max17042_battery.c
> index 89909b140cf9..770d806033b9 100644
> --- a/drivers/power/supply/max17042_battery.c
> +++ b/drivers/power/supply/max17042_battery.c
> @@ -89,6 +89,7 @@ static enum power_supply_property max17042_battery_prop=
s[] =3D {
>         POWER_SUPPLY_PROP_HEALTH,
>         POWER_SUPPLY_PROP_SCOPE,
>         POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW,
> +       POWER_SUPPLY_PROP_TIME_TO_FULL_NOW,
>         // these two have to be at the end on the list
>         POWER_SUPPLY_PROP_CURRENT_NOW,
>         POWER_SUPPLY_PROP_CURRENT_AVG,
> @@ -447,6 +448,21 @@ static int max17042_get_property(struct power_supply=
 *psy,
>                 if (data =3D=3D U16_MAX)
>                         return -ENODATA;
>
> +               val->intval =3D data * 5625 / 1000;
> +               break;
> +       case POWER_SUPPLY_PROP_TIME_TO_FULL_NOW:
> +               if (chip->chip_type !=3D MAXIM_DEVICE_TYPE_MAX17055 &&
> +                   chip->chip_type !=3D MAXIM_DEVICE_TYPE_MAX77759)
> +                       return -EINVAL;
> +
> +               ret =3D regmap_read(map, MAX17055_TTF, &data);
> +               if (ret < 0)
> +                       return ret;
> +
> +               /* when discharging, the value is not meaningful */
> +               if (data =3D=3D U16_MAX)
> +                       return -ENODATA;
> +
>                 val->intval =3D data * 5625 / 1000;
>                 break;
>         default:
>
> --
> 2.53.0.473.g4a7958ca14-goog
>

