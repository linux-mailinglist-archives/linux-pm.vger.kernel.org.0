Return-Path: <linux-pm+bounces-11815-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB7F94518C
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 19:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B12301C21BA9
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 17:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8206C1B4C27;
	Thu,  1 Aug 2024 17:34:23 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF1913D62B;
	Thu,  1 Aug 2024 17:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722533663; cv=none; b=t5QOlEufSg7hCvg4B+BomDwYntYPEvg3It1aUWbzj5sOvqGpZFt13mZzI2Cd9t0yzpxnH2cug6jnvQq4QYAUv4FPdniJq6o81WjzWibjNiwz14lrFW/JdQn37g5StNZxFwQ5Oh+umBv0sYobahOJ8ZQAmucuvZPhgrunBRIyzJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722533663; c=relaxed/simple;
	bh=QGfv6Mwl2jnbBI5jZ5Gi7DAKze67LLzTrgAtwyJNyr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=riBDZX4jX/4SAoFTsm6P0ozSp9BXrWF30mfC/dri7VRf0fSlcH7MALSe0FWqqopGEG7dEkpd624hx5JxL41HjAyF9o69/MgoL8/UvpUvvKtxez+/6J3r28fIYc0RM7y9IvPUyvgLNw/AcS+Ul7xvIZ6rGQOUOdqSsaA5WTnPPXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-65f7bd30546so19669137b3.1;
        Thu, 01 Aug 2024 10:34:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722533659; x=1723138459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b7RLlBjK6VYDjExx9r5TpBCz781pCBuMFrVQOrMhhBk=;
        b=rOS26AfyhoiHWFlBodif68+WU/tWDEcOxcT/Y8bT1UCpefpFPdzkY4IimGw+SdsVEU
         tJGdKDN9xJrc4aI9B9i6GD8aY7XZOq1f2074VZC+69qm8wEmHxAEux68q1j8yIanXzoJ
         4hzHlA5rEcaQDVUnI6shZ/wZtr/seoiCR5rIs4ZoCjZJWoLqwY4uSrJy9qfDJwlhLj1G
         HYw0OCCrHl0TJlhea4wwAzbwaUiUbKsW3joi1kkvy/BiaMach5+YVW6vwcxvd/1yFDDt
         DxF6WgduZw9iogy+7r3J+PSGlhxq7j1R7OB/67k0H8rRXQRfoXmQunqqjCt8M8QJkCSX
         YlEQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+Hj7SIcGXclvsRxLOcoSn+3aviRApbDc3CiImBe7dFaH/2s/DT4ikzExrkkijIg1ZulSA2/gqPPZ6G5gMOuUERduY6HpvMr1EyzhIqvpk35M5joDAq+J1b7l9XlY0q/dqLZ86++kkKAnV6XpljBNlHxuyqUvrMILEP+q2AXPbCederLfeSl3X2mcLnz+SFKvNbcvQAvE6V0P32kobq6NLLoejcr98lSJcmoncxhVDyIDo9oc7rDiyBqMPoFdYSpY=
X-Gm-Message-State: AOJu0Yx9wOSwOOGIK/v7BZD2sl7Rxg+eX+qDb6YIv5qjUeeSGon5Vbzq
	CNO64FOySkm6ybYeZE7IlVn16debbOT+zm/BQsjUCyLAVhogx3bLFyWWlGMU
X-Google-Smtp-Source: AGHT+IEpDNT2ogMgupDB98BwUhJQZQ61IZB1mOGnyGEmEAwT8R54mpFr8XrFoOgraWpkDIuZTzeI0A==
X-Received: by 2002:a81:7755:0:b0:66b:c28b:f234 with SMTP id 00721157ae682-689638f35f5mr7412837b3.21.1722533659002;
        Thu, 01 Aug 2024 10:34:19 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-689af65b26dsm214667b3.7.2024.08.01.10.34.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 10:34:18 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-661d7e68e89so20248157b3.0;
        Thu, 01 Aug 2024 10:34:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVelEtnSLsTPOcBQ4H6g7FJBEakHBGLnpo+bKfhSbq9eqpnKZ2o3kSrKpQhcljb8kF73fYoD+sCEHJAbDRgUIev8LU4PhWCbm2I4XiuO5eC6/kFPSxTEZ1CGuqYMT07FnIcxTVGzfWCEcUETS7K8HfV+vP0RsGepFvI2IlXqV1QLOYhBrJDArzoelGlA8RiL5P78nhtKxAseEVtfxyHO2AJP8TBQvp7TfWkNgaQsLX9TtJWrNqnQqKL1VuRdatrBuQ=
X-Received: by 2002:a81:7755:0:b0:66b:c28b:f234 with SMTP id
 00721157ae682-689638f35f5mr7412527b3.21.1722533658194; Thu, 01 Aug 2024
 10:34:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422105355.1622177-1-claudiu.beznea.uj@bp.renesas.com>
 <20240422105355.1622177-9-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdWhRRdfoqg_o6bU7jjt5_Di0=z7MJ4fMh=MJ0m8=u4tgg@mail.gmail.com> <80d56236-2499-4c89-8044-6a271e47515d@tuxon.dev>
In-Reply-To: <80d56236-2499-4c89-8044-6a271e47515d@tuxon.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 1 Aug 2024 19:34:05 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXOztsoKp=9-TDXirJN8voRy0O5mYXcVy=Uz-GX0B2N_Q@mail.gmail.com>
Message-ID: <CAMuHMdXOztsoKp=9-TDXirJN8voRy0O5mYXcVy=Uz-GX0B2N_Q@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] arm64: dts: renesas: r9a08g045: Update
 #power-domain-cells = <1>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: mturquette@baylibre.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, magnus.damm@gmail.com, ulf.hansson@linaro.org, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

On Thu, Aug 1, 2024 at 7:28=E2=80=AFPM claudiu beznea <claudiu.beznea@tuxon=
.dev> wrote:
> On 01.08.2024 19:13, Geert Uytterhoeven wrote:
> > On Mon, Apr 22, 2024 at 12:54=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.=
dev> wrote:
> >> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>
> >> Update CPG #power-domain-cells =3D <1> and move all the IPs to be part=
 of the
> >> IP specific power domain as the driver has been modified to support
> >> multiple power domains.
> >>
> >> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >
> > Now the watchdog fixes are in v6.11-rc1, I will queue this in
> > renesas-devel for v6.12.
>
> Only the RZ/G3S support has been merged.
>
> The watchdog fixes that allows us to use this patch were submitted as RFC
> but got no input from Ulf, yet.

Oops, postponing.

> [1] https://lore.kernel.org/all/20240619120920.2703605-1-claudiu.beznea.u=
j@bp.renesas.com/

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

