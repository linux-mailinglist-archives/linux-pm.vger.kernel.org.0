Return-Path: <linux-pm+bounces-43346-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFaHAqLPoWn3wQQAu9opvQ
	(envelope-from <linux-pm+bounces-43346-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 18:08:50 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 604D21BB39E
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 18:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C66430B6D5D
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 17:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C9C35BDAF;
	Fri, 27 Feb 2026 17:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FLVeTTs/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832933570C1
	for <linux-pm@vger.kernel.org>; Fri, 27 Feb 2026 17:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772211708; cv=pass; b=KgHjd98RgKli8FtoH8IpEdEg4qNxOp41faS2fwvbRtQOpX9x5P+k+CMZfUtUO5v+34Ez3+gKGqJd7bHzjhflL7QymL9GkKK4vuND8Z5z9RVNA9m11ejT0xcv7ctX88vX5MKUeN+NEBkjzEpwJPfMO+N1KloJx6W/ip+T6zt+m2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772211708; c=relaxed/simple;
	bh=ZIYRl3u7bmaLRT8SRm9rQ3lQCf0ntfMkORxThMWjq60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aRHROGolOExjXivaSiRKNHOLHjQJrAPqr8jSRsT2cfRwajOd9eE8FfuSf4rTofbQ8WWwfhPI+6svUAVzvj51EnadRvXDjRn4Js7pFrSvzcmnDoCQn/vH9y+ZEFQGd2wh231asWNWGohonmfcBGROlXtE9W0io6tzlRC9oqZ9Gec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FLVeTTs/; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-65f90233e28so4365040a12.1
        for <linux-pm@vger.kernel.org>; Fri, 27 Feb 2026 09:01:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772211705; cv=none;
        d=google.com; s=arc-20240605;
        b=B+2sqNzdX25lRRtPn/9omZp+//1RmNG+j0eiHCWHrkp6GoDld5iVOVPe9r8FN6zDkR
         1s5qyrK5ugYLdp09XhWjKW81c61lS4q2m1M3vgCokVT0k/BfkPNiB0OyrDXx22grO2N0
         qp6TyJ5wdTmKo+DAKbNFFbAXf7HMTDRFx3GKvWc6gxggFEapvFHPCvKTDhyBKulJH2aj
         BTJAKICyhUfrh4Hi5V7zEWhtpKbJMM+kmh9WWks+mI/1+hEtOS8puR2NC2c1wIxc0L8j
         T1qAKldt2hsCKSd4sxXMUAugLyEJai+AEHjqInz5XibgaMOMRJZ9fyK8rpXLiHE9vEHX
         HgtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CW5KUGgoFn5q9gXUzCWImq5omL1f1unPYVtcaICmZNk=;
        fh=tX4joDqD1tKbewOFwOBEvndJGOIzrH6EoLqWz3Wi0KI=;
        b=QNKKsmogDSFiJK2Oz1XaaxPp3yez5NoVko+bNyuxhuo6BiDzFtRxJ0FtVV+myK3Wia
         y9sp/1aa5l22FCx/h00+cP4+KVoT71u2Rzlc3H4w/MrKYuoC+JqsHfZfU3i1ucr95qdN
         dfv9aCEUYobIGGuS8qS7ruIkmBsI0kLgEsuIkGP/Ma4SS1/0tgFfnosuzXU+aQyahe0r
         oVKZF4xBST+o228hCsznPidraCludh3bNhyhytAI1uO9ChspahVSIw8roRBlYF96p0CF
         XxPgQIAPHfXOMyFu8VrpU1jNSjSKVfOUQxIS69BjLhe01b5xbzJuR6/NbR8rScgfSujo
         aQDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772211705; x=1772816505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CW5KUGgoFn5q9gXUzCWImq5omL1f1unPYVtcaICmZNk=;
        b=FLVeTTs/BboDTLBfA/su+JwV0Jr7c0Sxtv1LwXCn7RJeg2M+TcmZTlin3PRQSmhZLv
         gtcmGsXHbJbhJEqKYymGuXPPKuyIw8tUtf156eXBwhGLgO45WJdttCn6saSbJcAkAoZ8
         wfb6kYeS4tWRaiCw7rtdeV3E4vKFjXik/OuP1S9fPRwTDRnH0sqpy+c7VR5c+qofchbV
         veFmTALO7r6zhlc86UFGT3wXypu44pkIB7vpUV6/QUO0UuF0vl1GVvKVrYXuMJbaolr4
         zDL4yKLUTVB0L5em8ukwjzpXCNq+bHgV33YeNYbqV87GZ43nJubl1O/STV/KvXm0Ojk8
         TsdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772211705; x=1772816505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CW5KUGgoFn5q9gXUzCWImq5omL1f1unPYVtcaICmZNk=;
        b=OB8rK7gS8VK+Se23+Qbt0jsDU9oI8/Pfb08XS14eZ4QTD2gy2tn84nBkqTVTU9i2KC
         uIoBrXiz5uUqwHqJpf0Pkb/4i1wjpVIXHc53/VGqB8VyhaH3hNNqE3+zqcIbiKV7WS5z
         fI82nPVqUWEfq0wVn7LT1sVVDeD6BKXjqtlIfa27IxUhOEgYyXdJfsXlgQplN+Yz0F1N
         9Df2nzNFZ2MHzjURG4V/1ICWZgm0BU8K6Umt+rw+BVnlltbOZC3ZRh79CnUIydJ0lXxE
         yXoi22id53WIjccKcgRi6upP8iALVSQmJkUctVIaHXVqlxAGlMdGhRFoZOZZahmm56f1
         fLAA==
X-Forwarded-Encrypted: i=1; AJvYcCW2YdQ4a3THsaGwCbKEMETZxLpG1bwlKvZsp4d9oPfVW5rNbsLWmoibQxRmIfKUdpdAOZQb3WeshA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTccqvJlgDic/nxJxWGL+wb0Za3cS1TR8gEeEYCezPqsJs+rcD
	4yuY583/PWysGnDzMNlymt/dA1z0aLFzIzTRgs4M/oR4dGm/TaarqF5V89kO8JsQg9VimBJ2V4V
	/DAbZAvD0FZi7WP0fXN5JYecKICsZkvijKK10Iak9Lw==
X-Gm-Gg: ATEYQzwrHVNZVbNGX9R7S1Ty4gsR+qhzvhZ233viQPQoyZAtN0x6ntBiB1DVv/skDrw
	DDS+r59jJAWGF8bQ5q8oC7Nn3+Lu+7IOk4IE4Ne8W9UOhobTQfpj5E1R2s0drcvkd9ivOcZoQVD
	P+FfNBl3leorpjWyaf4N3kBHw/6yFJG84gyoUz14SvfXYYiAZI1qMNQnNUhqbpFElywdpoyYJ/M
	BK5qZSHLNjqIdmAxOiZs2KHDeguWMihjGRIvXvBhO+GCjmQLxYqqxuHCH8d4jpe43iCtQFbwJca
	jf/wKgI0TsWeomIbAP88Zw==
X-Received: by 2002:a05:6402:270a:b0:65b:a76d:6fe5 with SMTP id
 4fb4d7f45d1cf-65fde4c9357mr2418868a12.30.1772211704672; Fri, 27 Feb 2026
 09:01:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227-max77759-fg-v2-0-e50be5f191f0@linaro.org> <20260227-max77759-fg-v2-10-e50be5f191f0@linaro.org>
In-Reply-To: <20260227-max77759-fg-v2-10-e50be5f191f0@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Fri, 27 Feb 2026 17:01:33 +0000
X-Gm-Features: AaiRm50je7Jyz9A7BguKdOxcDEnGvNXfC21AHwJKgBl8f23M-dLNvVvogDhwjVc
Message-ID: <CADrjBPrqmyZGNVzV2Qk3yLqG2CLQi0J=rD4vHP9N1ftjDV8UOg@mail.gmail.com>
Subject: Re: [PATCH v2 10/11] power: supply: max17042: consider task period (max77759)
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43346-lists,linux-pm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,linaro.org:dkim,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 604D21BB39E
X-Rspamd-Action: no action

On Fri, 27 Feb 2026 at 07:15, Andr=C3=A9 Draszik <andre.draszik@linaro.org>=
 wrote:
>
> Several (register) values reported by the fuel gauge depend on its
> internal task period and it needs to be taken into account when
> calculating results. All relevant example formulas in the data sheet
> assume the default task period (of 5760) and final results need to be
> adjusted based on the task period in effect.
>
> Update the code as and where necessary.
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

> While I do believe this should apply to all devices supported by this
> driver, given the register description in max17042_battery.h, I've made
> this change specific to max77759, as I have no way to confirm this
> works as expected on those. I've found a data sheet for
> max17047/max17050 online, which does describe the relevant register
> 0x3c as 'reserved', hence I'm a bit hesitant to enable this for all.
>
> v2:
> * update commit message subject prefix
> ---
>  drivers/power/supply/max17042_battery.c | 20 ++++++++++++++++++++
>  include/linux/power/max17042_battery.h  |  1 +
>  2 files changed, 21 insertions(+)
>
> diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supp=
ly/max17042_battery.c
> index 44626abdab34..89909b140cf9 100644
> --- a/drivers/power/supply/max17042_battery.c
> +++ b/drivers/power/supply/max17042_battery.c
> @@ -61,6 +61,7 @@ struct max17042_chip {
>         struct work_struct work;
>         int    init_complete;
>         int    irq;
> +       int    task_period;
>  };
>
>  static enum power_supply_property max17042_battery_props[] =3D {
> @@ -335,6 +336,8 @@ static int max17042_get_property(struct power_supply =
*psy,
>                         return ret;
>
>                 data64 =3D data * 5000000ll;
> +               data64 *=3D chip->task_period;
> +               do_div(data64, MAX17042_DEFAULT_TASK_PERIOD);
>                 do_div(data64, chip->pdata->r_sns);
>                 val->intval =3D data64;
>                 break;
> @@ -344,6 +347,8 @@ static int max17042_get_property(struct power_supply =
*psy,
>                         return ret;
>
>                 data64 =3D data * 5000000ll;
> +               data64 *=3D chip->task_period;
> +               do_div(data64, MAX17042_DEFAULT_TASK_PERIOD);
>                 do_div(data64, chip->pdata->r_sns);
>                 val->intval =3D data64;
>                 break;
> @@ -353,6 +358,8 @@ static int max17042_get_property(struct power_supply =
*psy,
>                         return ret;
>
>                 data64 =3D data * 5000000ll;
> +               data64 *=3D chip->task_period;
> +               do_div(data64, MAX17042_DEFAULT_TASK_PERIOD);
>                 do_div(data64, chip->pdata->r_sns);
>                 val->intval =3D data64;
>                 break;
> @@ -362,6 +369,8 @@ static int max17042_get_property(struct power_supply =
*psy,
>                         return ret;
>
>                 data64 =3D sign_extend64(data, 15) * 5000000ll;
> +               data64 *=3D chip->task_period;
> +               data64 =3D div_s64(data64, MAX17042_DEFAULT_TASK_PERIOD);
>                 val->intval =3D div_s64(data64, chip->pdata->r_sns);
>                 break;
>         case POWER_SUPPLY_PROP_TEMP:
> @@ -1146,6 +1155,17 @@ static int max17042_probe(struct i2c_client *clien=
t, struct device *dev, int irq
>                 regmap_write(chip->regmap, MAX17042_LearnCFG, 0x0007);
>         }
>
> +       chip->task_period =3D MAX17042_DEFAULT_TASK_PERIOD;
> +       if (chip->chip_type =3D=3D MAXIM_DEVICE_TYPE_MAX77759) {
> +               ret =3D regmap_read(chip->regmap, MAX17042_TaskPeriod, &v=
al);
> +               if (ret)
> +                       return dev_err_probe(dev, ret,
> +                                            "failed to read task period\=
n");
> +               chip->task_period =3D val;
> +       }
> +       dev_dbg(dev, "task period: %#.4x (%d)\n", chip->task_period,
> +               chip->task_period);
> +
>         chip->battery =3D devm_power_supply_register(dev, max17042_desc,
>                                                    &psy_cfg);
>         if (IS_ERR(chip->battery))
> diff --git a/include/linux/power/max17042_battery.h b/include/linux/power=
/max17042_battery.h
> index 05097f08ea36..d5b08313cf11 100644
> --- a/include/linux/power/max17042_battery.h
> +++ b/include/linux/power/max17042_battery.h
> @@ -17,6 +17,7 @@
>  #define MAX17042_DEFAULT_VMAX          (4500) /* LiHV cell max */
>  #define MAX17042_DEFAULT_TEMP_MIN      (0)    /* For sys without temp se=
nsor */
>  #define MAX17042_DEFAULT_TEMP_MAX      (700)  /* 70 degrees Celcius */
> +#define MAX17042_DEFAULT_TASK_PERIOD   (5760)
>
>  /* Consider RepCap which is less then 10 units below FullCAP full */
>  #define MAX17042_FULL_THRESHOLD                10
>
> --
> 2.53.0.473.g4a7958ca14-goog
>

