Return-Path: <linux-pm+bounces-15264-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC26992ED5
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 16:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 721371C23705
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 14:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940951D7E4E;
	Mon,  7 Oct 2024 14:19:14 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC931D414C;
	Mon,  7 Oct 2024 14:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728310754; cv=none; b=NVkzorg+Oo/r1/htLSP/nUqz7ZDNfwkHGhCOZq4Wie0aA7w+uECrjv6jX+7n31ZbxYbhuYt5kWgSAExdoltQv3BmWkzsV3ZwJ3vpvJpSumaYtBh3TNFF/TlsXluQ6UwfZXIfNnPRQpFjnAkqqhS3x3ucSeQ4VqGWH1A8+h53nlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728310754; c=relaxed/simple;
	bh=Y4hIzHKKp2pqmmmuX5GcD3u4s5c1SmZz+ccGdmi/E9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rbivfwkQJ5DBrxnGpi1sAWgV8bPflYQI3C69uSpukFVmlyaii6c0nX0lRZ9zQ2GOK5v///pptAad9+kB1uvMWm1Wf6HpKC/PEShqCm0Bk9hghlwJgFyYQB9//bI9o8F/Ktfg0wbcAOeMv7vpSP8+xQnVaCeK3LsfSDfyVK7xREw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e260850140fso4295983276.2;
        Mon, 07 Oct 2024 07:19:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728310750; x=1728915550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ds8x8rK9fFgQxGIaIXzitG1agS3sP9SVqNHcZua0LkM=;
        b=geNFtkct+lwek27bk5w0BJiVCgg8cTv4goPFFz+aF7jdNO9I+oOUER5cVNkUYTlWms
         9lTRkM7QmbWasfYTMQfWl0axVHjJLNHfN37Mc+1INN+ch3r9tvQYRBtwQnUPMsiWa9uu
         aoN9vAUTfUmYWSuMWnuOxAsRIAfv0uMdVJQpF1zOgJYOcipLwisqjIiLgOcU8IqAbapr
         +C2kw2M7IvPD+0XIoapf8lXusFC2BzzcDjJ3OfXWs0cZ/2Odz/FMdZIwq9k3GjS0wQTN
         UdqeLmJ4BnWzps9WwR5RlqS04Pf9/gf8dp3XNxLjnnE2FNfUt3/Lnzq83o74m3wQ+Tys
         wL2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUYn9phrgeU5p3q7wmJvIiUVT8da66I2hf3RdCbKm4FqPJOd5BXC6qa1o7OI0W+4XOtfl+eEk4tfOleOrq0k98=@vger.kernel.org, AJvYcCWEm0sRYjNH5ZR+iRNEmkHS4Mm1vOe7rJ0hW1IKn7Z7GgcN7lHXhihQZmGaVjZ9W5B9JC2vEKN+kY4=@vger.kernel.org, AJvYcCWVNLcHOyD56HkyItcHGWv78/cuVgTu+JU6VDXJexs73rst30uav8fZPwHWivPOzhw3L+73lv2Jlzs6kKaQ4rpoStg=@vger.kernel.org, AJvYcCWy14bbDVf/lQ+PyA49vaCQs6236HEwLCZcBLwomwdGnZVXvlZtgm8m1ZbEez2ZdQkzeMzR0504Dlg=@vger.kernel.org, AJvYcCX1nSvQrtKP/wnQhZcZaF0nz0qaLFh8pUDu7/QzwsWKKw5b8aldujy5xTMe7Hicp3D29TVHEHTMpHUINThq@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy69soB2l0cxsFiAmqrPQBA7QTbMMa9bVmdDSvFjmu8mfzAFt0
	KjQaRBpLfcVorq+MT+LqzPoFqVJedZpXLha7qQ0D1w8CCIk9ORZlF3Vba+B9
X-Google-Smtp-Source: AGHT+IEOlQDDhooFfyBC4SFKYtPq4+rrdH/7LlNTbGmqqS9stfkLi+e8u3Oqgzp3DY3Jfu1U21OdCw==
X-Received: by 2002:a25:aa05:0:b0:e26:cc5:4906 with SMTP id 3f1490d57ef6-e2893928939mr6743938276.41.1728310750506;
        Mon, 07 Oct 2024 07:19:10 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e28a5dbb316sm913306276.64.2024.10.07.07.19.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 07:19:08 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6db836c6bd7so41373417b3.3;
        Mon, 07 Oct 2024 07:19:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV/X/PjTTjn9fR3M4cN5NdmEbtZBquWqSpDlz/ZL0SXprwRdq0iT/+Np5WyKbCKgYIe6jXB1GL2EOg=@vger.kernel.org, AJvYcCVB9mM4WvzHh8hAQp6uIkRJdrWjais3kyultaKzSZkrqQ08MueoL35OMpdhjWTnL9I7coJb6L2sgae8aUB+@vger.kernel.org, AJvYcCW2pd7UIU70GYcI44KoY0C3zNHQoQ0/Nb/ANBPZik15BIruFidx32F6hOlVNa7jbWJcodqLIUQTTRU=@vger.kernel.org, AJvYcCWoacZK3zgPVIim9hRyQKtAiLlkLSaOB/r7C/gYgZadwH8V0L9c91DloJ2gq8eGCLhAXlOiLH0x4vDTRoSIHqxOigY=@vger.kernel.org, AJvYcCXOmfm8dAYKDzSNXJrwU4evv3g+Uv6IRTQ+PiCZexmRRDASNFE+FTRcmICIIp96EPJFHYx2xd5SJNhn8V9SQro=@vger.kernel.org
X-Received: by 2002:a05:690c:f14:b0:6e2:1626:fc24 with SMTP id
 00721157ae682-6e2c6fc3645mr101710117b3.7.1728310748657; Mon, 07 Oct 2024
 07:19:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902132402.2628900-1-claudiu.beznea.uj@bp.renesas.com> <20240902132402.2628900-2-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240902132402.2628900-2-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 7 Oct 2024 16:18:56 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWF=3svkFT8sVEtTahtDh3tJG4FjqmqhJJKs9JYNd+WCQ@mail.gmail.com>
Message-ID: <CAMuHMdWF=3svkFT8sVEtTahtDh3tJG4FjqmqhJJKs9JYNd+WCQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] clk: renesas: rzg2l-cpg: Move PM domain power on
 in rzg2l_cpg_pd_setup()
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: mturquette@baylibre.com, sboyd@kernel.org, wim@linux-watchdog.org, 
	linux@roeck-us.net, ulf.hansson@linaro.org, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, linux-pm@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

On Mon, Sep 2, 2024 at 3:24=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> w=
rote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Move the PM domain power on in rzg2l_cpg_pd_setup(). With this the
> previously always-on power domains got
> struct generic_pm_domain::{power_on, power_off} populated (and
> registered with simple_qos_governor if #power-domain-cells =3D <1> and
> with pm_domain_always_on_gov if #power-domain-cells =3D <0>). The values =
for
> struct generic_pm_domain::{power_on, power_off} are now populated for
> all registered domains but used by core only for the domains that can
> use them (the PM domain should be non always-on and registered with
> simple_qos_governor). Moreover, the power on/off functions check if the
> mstop support is valid. The mstop is populated only by the RZ/G3S
> initialization code at the moment.
>
> This approach was chosen to keep the code simple and use the same code
> across different implementations. There should be no issues with this
> approach as the always on domains are registered with GENPD_FLAG_ALWAYS_O=
N
> and the PM domain core takes care of it.
>
> This approach allows doing further cleanups on the rzg2l_cpg power domain
> registering code that will be handled by the next commit.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v3:
> - none; this patch is new

Thanks for your patch!

> --- a/drivers/clk/renesas/rzg2l-cpg.c
> +++ b/drivers/clk/renesas/rzg2l-cpg.c
> @@ -1680,23 +1680,26 @@ static int rzg2l_cpg_power_off(struct generic_pm_=
domain *domain)
>         return 0;
>  }
>
> -static int __init rzg2l_cpg_pd_setup(struct rzg2l_cpg_pd *pd, bool alway=
s_on)
> +static int __init rzg2l_cpg_pd_setup(struct rzg2l_cpg_pd *pd,
> +                                    struct dev_power_governor *governor)
>  {
> -       struct dev_power_governor *governor;
> +       bool always_on =3D !!(pd->genpd.flags & GENPD_FLAG_ALWAYS_ON);
> +       int ret;
>
>         pd->genpd.flags |=3D GENPD_FLAG_PM_CLK | GENPD_FLAG_ACTIVE_WAKEUP=
;
>         pd->genpd.attach_dev =3D rzg2l_cpg_attach_dev;
>         pd->genpd.detach_dev =3D rzg2l_cpg_detach_dev;
> -       if (always_on) {
> -               pd->genpd.flags |=3D GENPD_FLAG_ALWAYS_ON;
> -               governor =3D &pm_domain_always_on_gov;
> -       } else {
> -               pd->genpd.power_on =3D rzg2l_cpg_power_on;
> -               pd->genpd.power_off =3D rzg2l_cpg_power_off;
> -               governor =3D &simple_qos_governor;
> -       }
> +       pd->genpd.power_on =3D rzg2l_cpg_power_on;
> +       pd->genpd.power_off =3D rzg2l_cpg_power_off;
> +
> +       ret =3D pm_genpd_init(&pd->genpd, governor, !always_on);
> +       if (ret)
> +               return ret;
> +
> +       if (governor =3D=3D &simple_qos_governor && always_on)
> +               ret =3D rzg2l_cpg_power_on(&pd->genpd);

I think you can drop the check for simple_qos_governor: in the single
clock domain case, pd->conf.mstop is zero, so rzg2l_cpg_power_{off,on}()
become no-ops.  That would also allow you to drop passing the governor
as a parameter, as it can be set based on the always_on flag, as before.

Regardless:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

