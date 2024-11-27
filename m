Return-Path: <linux-pm+bounces-18149-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 819019DA7F1
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2024 13:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41775280A1D
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2024 12:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAF61FC7EC;
	Wed, 27 Nov 2024 12:37:48 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AB91FA82F;
	Wed, 27 Nov 2024 12:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732711068; cv=none; b=oFDznZlhpp7SQBXg+Ne7Df0Ov/dIMz1WYknFzQggebZEX/MzlhKgs/aYmUbe4fhw8ugqj04v13UdqgGnwYCULu6mWRiLQ6K21lBRDX7HCx+cIPC5jSwWtQT7ixGup9I3DxQHnqBFKFNgh83AbJs927Ra4DeVAa8VIX8SifUcO/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732711068; c=relaxed/simple;
	bh=Eia71GaAygkYAk8zVXAdJYbkcsXTdozswH/He1FKNUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sIQiSOsXxaGRZ8BFha9MxbGx0I/LFqCPGtTkuwYO9hgcoFteZPvP+p8T7nuL3oJ6Ls0b4Ko/axQyrAEAFM05g8wr2CWKufFvwLyFZW98XvJlXCA4GcSHbf2F8EEuZrcGya5QLf41gS6i0atxQ9lHLeqA1EkwYOaovbNMdkqxZFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3ea49cc8b88so1613559b6e.2;
        Wed, 27 Nov 2024 04:37:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732711065; x=1733315865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wFWuqVuxrfa4q4CwwnmEJbNVtao5d8ytAMdXvXH9sNs=;
        b=t4raDBRxmwLjsWO8Q/Rcr3L6usaKPsc3dAwKESLzi4V8aOexmlsR8Ty0aE6Gy8kLFT
         JlEa2kZ+TqpRQqfe6Et+lJd74OzLK7g2dviX3KjXj+qebTNitDx5OjfYcD0XLqfcqap7
         WA+2gC5Gt7uUaaU8aiXGQQINxWSp8YoDLfNwJFqZTG3qqW8/1uJuprrvdJ89nnlCAr46
         W2ihQQRKJVYVZo/dhgOs9B+1SVgf5Cl2C/vHqUh+GPNJyBU9WLGgdaMQGk6k982TRInd
         HaV14ix+GPWkD0LMD13Rhz4dLKJdL962yZX40VQ4j+foSp0IK+hN0VNba6r0mRjKzMmV
         NeaQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5pp1vWduqIE/WvcpK/YSmTbx73hSQN5OfThMsgCSMChwO+8TyqXoNTDMOj6IBEPCdHP8pnAwMog/oQJfAEdnbCkE=@vger.kernel.org, AJvYcCUSjK23K/CEw1uSxVbvP6VnzL6jdJ9y0JaEIrDdJxGrWKX4eaCr20KNgmyBk8rV+PDmZkx5saEQAA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwYR5452Z9iP6MeWkuHpNgDUAP0hOGcIlyTYrie4lA+okAKX80D
	ZOX8WoZrNjyi6ue41Ts/7DJEx8upDBFsZOKYGa/9dwPuHLfIGT7Vy/P9AtgCYEQ=
X-Gm-Gg: ASbGncumgatQoo0X5WrNybZABehclmyJwEeU0NLE+YaoLDQV3q9byJ7HREHPlmqLfS+
	jArWlB6KtQpQlLgb5QRcHxTpEFprpVLqHwye58EVSgCnILcrCAxCjn3yyenxe5tga+H2bV9sG81
	hKEPhYW7KrWB5UxTrOzYNeGWZsoNc8CumKeQfn7SFMOrK8YqUfyYwOiHx0kAaWwE75Z3yKLsqaN
	x8pLTYw7sjD3ovy77pTjjRjW26+9OIdOfDXRxTJux7OQIIuPXyzhjchhnx1vsRCg9kY4temfzcu
	D0SuqUpk/SpW
X-Google-Smtp-Source: AGHT+IHdpembfqwpmswWFFz9cZsdx7AK9umfrrVDdCjPCqRhimX7DijoOUMJTXh45mBMme+hH86wMg==
X-Received: by 2002:a05:6808:1829:b0:3db:1cd1:cadd with SMTP id 5614622812f47-3ea6dbd8ffemr3071179b6e.18.1732711065629;
        Wed, 27 Nov 2024 04:37:45 -0800 (PST)
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com. [209.85.161.42])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71d565285b9sm1480609a34.61.2024.11.27.04.37.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 04:37:45 -0800 (PST)
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5f1ff6a2128so731201eaf.2;
        Wed, 27 Nov 2024 04:37:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWiUGXy3Gf8BVULSYmvIeh9P8FI/AVYAojQuuQgmurd65QdH+9PFxGJHgbn/hoyEnB6AgG0gsJuLQ==@vger.kernel.org, AJvYcCXp8mi1CSO0dZLtiq63m5Ui52Xko6bIHtyodA1ZTblsmXh9Y3qsURqnCKmZUEkZPmscEBWTJmkmxsFYxKqFhCnL3nA=@vger.kernel.org
X-Received: by 2002:a05:6358:d39c:b0:1c3:77fc:3bb6 with SMTP id
 e5c5f4694b2df-1cab16a47f0mr195065855d.21.1732711064426; Wed, 27 Nov 2024
 04:37:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120120336.1063979-1-niklas.soderlund+renesas@ragnatech.se> <20241120120336.1063979-3-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <20241120120336.1063979-3-niklas.soderlund+renesas@ragnatech.se>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 27 Nov 2024 13:37:31 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUX9X-TA7O0xcEF1ktaF+7sbPC14dMsYvuqyCGiyTPq-Q@mail.gmail.com>
Message-ID: <CAMuHMdUX9X-TA7O0xcEF1ktaF+7sbPC14dMsYvuqyCGiyTPq-Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] thermal: rcar_gen3: Reuse logic to read fuses on
 Gen3 and Gen4
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Niklas,

On Wed, Nov 20, 2024 at 1:04=E2=80=AFPM Niklas S=C3=B6derlund
<niklas.soderlund+renesas@ragnatech.se> wrote:
> The hardware calibration is fused on some, but not all, Gen3 and Gen4
> boards. The calibrations values are the same on both generations but
> located at different register offsets.
>
> Instead of having duplicated logic to read the and store the values
> create a helper function to do the reading and just feed it with the
> correct register addresses for each generation,
>
> Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.=
se>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Still, some suggestions for improvement below...

> --- a/drivers/thermal/renesas/rcar_gen3_thermal.c
> +++ b/drivers/thermal/renesas/rcar_gen3_thermal.c
> @@ -253,60 +253,43 @@ static irqreturn_t rcar_gen3_thermal_irq(int irq, v=
oid *data)
>         return IRQ_HANDLED;
>  }
>
> +static void rcar_gen3_thermal_fetch_fuses(struct rcar_gen3_thermal_priv =
*priv,
> +                                         u32 ptat0, u32 ptat1, u32 ptat2=
,

Perhaps ptat[1-3], to match REG_GEN3_PTAT[1-3]?

> +                                         u32 thcode0, u32 thcode1, u32 t=
hcode2,
> +                                         u32 mask)
> +{

>  static void rcar_gen3_thermal_read_fuses_gen3(struct rcar_gen3_thermal_p=
riv *priv)
>  {

[...]

> +       rcar_gen3_thermal_fetch_fuses(priv,
> +                                     REG_GEN3_PTAT1, REG_GEN3_PTAT2, REG=
_GEN3_PTAT3,
> +                                     REG_GEN3_THCODE1, REG_GEN3_THCODE2,=
 REG_GEN3_THCODE3,
> +                                     GEN3_FUSE_MASK);
>  }
>
>  static void rcar_gen3_thermal_read_fuses_gen4(struct rcar_gen3_thermal_p=
riv *priv)
>  {

[...]

> +       rcar_gen3_thermal_fetch_fuses(priv,
> +                                     REG_GEN4_THSFMON16, REG_GEN4_THSFMO=
N17, REG_GEN4_THSFMON15,
> +                                     REG_GEN4_THSFMON01, REG_GEN4_THSFMO=
N02, REG_GEN4_THSFMON00,
> +                                     GEN4_FUSE_MASK);
>  }
>
>  static bool rcar_gen3_thermal_read_fuses(struct rcar_gen3_thermal_priv *=
priv)

As both rcar_gen3_thermal_read_fuses_gen[34] became wrappers around
rcar_gen3_thermal_fetch_fuses(), what about parameterizing by data
instead of by code? I.e. replace the rcar_thermal_info.read_fuse()
function pointer by a pointer to a structure?

    struct rcar_gen3_thermal_fuse_info {
            u32 ptat[3];
            u32 thcode[3];
            u32 mask;
    };

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

