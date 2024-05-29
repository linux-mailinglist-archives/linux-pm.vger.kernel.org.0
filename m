Return-Path: <linux-pm+bounces-8350-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 125608D3274
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 11:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35D9E1C22DAD
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 09:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DAA167DAB;
	Wed, 29 May 2024 09:01:46 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9424D1E888;
	Wed, 29 May 2024 09:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716973306; cv=none; b=L+bIaX74EHXMfDEUygE5TJ3qpbwhXIm2ns6//TxhKdrmK7edXpOUBc4qxVQ/xGD/InjLRWCAnhCYTKtbqOVVnscMKYuq9qXIMOZirvQmbLCqkIImOlbpuIZ8I9NamWCUFQJ/Mxix00wUpsk+axw7inpp2PeAlof76gF2ABqFNqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716973306; c=relaxed/simple;
	bh=wq6Q5U9qIc0wVfPUvIazA+e9F1mn1D2Z4oXYmue4Ipo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KM6B451ZKUZH12aLtfj0s6gDwSbWe5nKMXy75lNgvj9E9ezK1TGsLJ4Tm/9WlZwcY5/xEXRo3ZTSBlnQquT9C707dtNY4sxv0iNn8tFBjNtSfKWH1u5GJjIq46x0IlgcEbMB87YBjcumIwayMW+bA0nzRXcydgcWx+lYBfpI8Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-df771db8b24so1737163276.3;
        Wed, 29 May 2024 02:01:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716973302; x=1717578102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KnYuIo1n1oD5QX7J07WFDaga5vIEVHxJRsHJ8yWO98A=;
        b=srzF4XauBhGx3v9W7ihZ874tqY6/cY4tnfPyu6DPkjlLREC+oH1zgGhXZ8H72kbGqE
         JYujLxLlQUjcNDcHRVXe0A9a4lDWolEdf9ZDKBdQy+l6RZam0yK6yaBbBzeI0T6PexqY
         ECUfQVMqhwrgAU5hv0SqQlOFau+23lHyY9DtykMopNCEbLKzS0+XfMtyB/diY9mkMaO+
         kJFkYxWro1klBxmJ+888Qkm20FdvQFMMnjbi/3duVgiWEgnANy0AABcJlurBFq7KOiLJ
         KRBNtnLUfTQpCKlIECbSd2Yx+kKN38U0QF1RWWXQvrSwEoN4ZStRM2d0OAKuyzRJiUYo
         GsaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXleI+4HMS3egI2rz/THTxvP56VqQjeM16D2VvTLD/gNxhg7VCbOgeQaLk1S87toZgPjlgWzxj1ZqBpDue5f6DDqtp0beDRJdBUHYqD0R4QL4Hl5Af+In/iHwv2Va7sxW/esqZoerfe5OCml8mhiMhLUeZ8JlaP/+cLD3Nnmwmca14t8cYemXGnWxb4ZGrlowtF5Vr8V1sdqZ3oCgASIqPveeXxtueqUiUDvOiKLEnYDe68EAvbNd3reu2mF2Yj/C26nrQ=
X-Gm-Message-State: AOJu0YyfGRAOX6+bnwMDu/JUZOurEgUCOiWHI2Ppvl3MxsmShq2r+9PT
	hjFZKHuX6T33Eo2y7l+Ei//lWAJ31sAdvd8gkxoAY64CCNdQIe8RpBwLBlm2n/8=
X-Google-Smtp-Source: AGHT+IG1N3AmKZnNB7pxmFQEEWkmIBZaiEFCGdmbClIb8hwogzic7RLgZvMcDvl83mbqJR2oUGmFoQ==
X-Received: by 2002:a25:8c03:0:b0:de6:1494:f144 with SMTP id 3f1490d57ef6-df7721a7766mr13396377276.28.1716973297477;
        Wed, 29 May 2024 02:01:37 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-dfa482bd39fsm173285276.37.2024.05.29.02.01.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 02:01:37 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-62a2424ecb8so16712377b3.1;
        Wed, 29 May 2024 02:01:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUit2zCbakmG6A0AbA5CeRTuIYODupvJG1rU96PoCvZ5fukmm28XZzsQxcpl2etweQZrkOv7k8vO+GSZJhc1oYh/5+NPLloj+dRlbYkOZA4oX2rmLUFXmqkqAfVnsLEO4JFYhhWMU1cfZsByICDLHiaMzCuHE0vQOu59MGvGJbJ3+GLqqTnIXnRnD01xxtA50btf8fwXs2GyBD/P8ca7vkCYQWJVxLiNI7gKHqnZEtR6fbaMXCfRCL+iNqYzDHsSOsNdRc=
X-Received: by 2002:a25:b202:0:b0:dfa:4ce2:3315 with SMTP id
 3f1490d57ef6-dfa4ce234f0mr828856276.38.1716973296714; Wed, 29 May 2024
 02:01:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1716811405.git.geert+renesas@glider.be> <efd9397662ff743f95298ca6aad4efdfa0ba1962.1716811405.git.geert+renesas@glider.be>
In-Reply-To: <efd9397662ff743f95298ca6aad4efdfa0ba1962.1716811405.git.geert+renesas@glider.be>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 29 May 2024 11:01:25 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUxXQca5MzP9fGjVoUWbOvSekwRp_+HMTT618yD8wc=tw@mail.gmail.com>
Message-ID: <CAMuHMdUxXQca5MzP9fGjVoUWbOvSekwRp_+HMTT618yD8wc=tw@mail.gmail.com>
Subject: Re: [PATCH/RFC 1/3] earlycon: Export clock and PM Domain info from FDT
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Peng Fan <peng.fan@nxp.com>, linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 2:41=E2=80=AFPM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> Earlycon relies on the serial port to be initialized by the firmware
> and/or bootloader.  Linux is not aware of any hardware dependencies that
> must be met to keep the port working, and thus cannot guarantee they
> stay met, until the full serial driver takes over.
>
> E.g. all unused clocks and unused PM Domains are disabled in a late
> initcall.  As this happens after the full serial driver has taken over,
> the serial port's clock and/or PM Domain are no longer deemed unused,
> and this is typically not a problem.
>
> However, if the serial port's clock or PM Domain is shared with another
> device, and that other device is runtime-suspended before the full
> serial driver has probed, the serial port's clock and/or PM Domain will
> be disabled inadvertently.  Any subsequent serial console output will
> cause a crash or system lock-up.
>
> Provide a mechanism to let the clock and/or PM Domain subsystem or
> drivers handle this, by exporting the clock and PM Domain dependencies
> for the serial port, as available in the system's device tree.
> Note that as this is done during early boot-up, the device_node
> structure pointing to the earlycon console is not yet created, so this
> has to resort to raw property data.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -954,6 +954,16 @@ static const bool earlycon_acpi_spcr_enable EARLYCON=
_USED_OR_UNUSED;
>  static inline int setup_earlycon(char *buf) { return 0; }
>  #endif
>
> +#ifdef CONFIG_OF_EARLY_FLATTREE

This should include a check  for CONFIG_SERIAL_EARLYCON.

> +extern const __be32 *earlycon_clocks, *earlycon_power_domains;
> +extern int earlycon_clocks_ncells, earlycon_power_domains_ncells;
> +#else
> +#define earlycon_clocks                        NULL
> +#define earlycon_clocks_ncells         0
> +#define earlycon_power_domains         NULL
> +#define earlycon_power_domains_ncells  0
> +#endif
> +
>  /* Variant of uart_console_registered() when the console_list_lock is he=
ld. */
>  static inline bool uart_console_registered_locked(struct uart_port *port=
)
>  {

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

