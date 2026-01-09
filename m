Return-Path: <linux-pm+bounces-40539-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC9DD0A81F
	for <lists+linux-pm@lfdr.de>; Fri, 09 Jan 2026 14:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A697630608BB
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jan 2026 13:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F6035A95A;
	Fri,  9 Jan 2026 13:49:27 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A507833B962
	for <linux-pm@vger.kernel.org>; Fri,  9 Jan 2026 13:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767966567; cv=none; b=hzmlAe9LWX5umZil8vVgNemNRrH9DlAdSZDKXqKbWII2xJahVYuzqXO7HCD1TGWI/2PhH+Ba1tmhwlvYwmZ3ddXtbxUdmJ2llBcq0tz23Zm8Bywi22cV06p6QLGAwaC5RVmJ0gsK9dBlkTb0jEPg5aor4rs/lFfZ0eU+0XQ1baw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767966567; c=relaxed/simple;
	bh=WLFUrhNxJ/XDPIZxprmACvVsb1Pyo7q0wLa37Xprya8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LgCxwGMNk10Bwjcfr9nsiZR0Lhyzj9PSXJSw400emwcIEBrEv13gdHawZ8au2jtvDtdF727wlITRK3YrKDH2NkVlqeCGH/poH9fN94jMMEcF+ylkoyfupFNaUveLUcM4rV6lxr9D1d2W4OmNw8JVenBODm/Y9SOJ80gf/k0y0DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-55b24eedd37so3195178e0c.0
        for <linux-pm@vger.kernel.org>; Fri, 09 Jan 2026 05:49:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767966564; x=1768571364;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1K7NOffoek8SfFkqFSd9+BgcJllduHoywKqDwRr4NrA=;
        b=xC+xicAiEAgxf7zdVkOz0B4YXf7wiTUw1QTVtbcZjjfsHIj9IWmGRMWXXwE6H4aqVa
         VZ6MttBckCTpKNXDbcszO/qn7IyhnzZcDPF9fFGND8Tybc34eWbBErlb5YOba4q1hSZo
         1Z1dbry29mC/ddoXajM8PZYMCUB+6GR4ZzCGTq2httpfQPy4JEJhrXs61bdxxNDeAo7q
         j3Gj2Wkmadq/i6guhJHPx+Tl5DpVDZ8Ma9YKYf/x7Y6LBu6MuZTYqXe6ghoGWVJzKhy2
         EjNBJqXX8xK3+qsyMH1sN/RUvtDjTTRLfI5FSZjIhLcD+12kfwEum4j4GbOIXoTm8cOy
         sYNg==
X-Forwarded-Encrypted: i=1; AJvYcCVrJSKQt1wKZ3hw8IllcXDQuCbVocPHTC9zaPBZIZi6Sut8lKzt9PMlvha6KZ+SK/fqWN6R6/tkqQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzsqgPHl+Wes2G60W/RN9dVDpH/FYGTAG2iXXi/8VTbYDdk9D3o
	IQfl3PPlPVxwZUPftiP5Qd6xez7HUzJ5wVjNW4SAMtdEBrimnIPhIDW7WQXO+5uS
X-Gm-Gg: AY/fxX66Kyd1YkHgqGRx1O3gdwDKFWP+mxngi7yBe9B8uQmB+o6rvFCMKjZPnzGmWal
	5XqSucXtHiwkhcTk3vHvaCgSxa9o2IMULqgJnfFxVQgyl82BrB0KmzXvbwPmILkP+HQG5okkaaz
	UKYXZKEcRAenl36EwlhzSNVeCrYJlXUfrDGSxI440Zcp7aIZUelB+8Al5xwr1ufU9ahOl6BG6ow
	sGv1kpnqJj5tBVa9i6rVhqY5uc/bjvEPY7X3ldbZ9mEyVoNcJLewbexsaNTPD/8HE0a6664y1ov
	idyyDX1YJl0wpjufEomGktYqx2Rj1OhFr7VVqlWku5S6f85PBIaQyKY653/mIj5u8M02iVpctes
	ApGGfQk35uWd6WNF8wZD16YwhyNMFY9NeaJ1B+hLbNvww5qgWXj7jzK2vqDmHrR1PxQD4MhsALu
	sEGdF2/3p3sc8cVZIzsTIR0Z/2VZdcnCVdb7avPvo9qhx3iZuxdK1zr/s1vFo=
X-Google-Smtp-Source: AGHT+IGQxV9y91YKdnCOR4i6/G66t2JhwUCr1tLFTuISymHhHov8wGgUFbs69f9bFFdqv3C7/Rlbdw==
X-Received: by 2002:a05:6122:6b08:b0:563:4a88:6ea5 with SMTP id 71dfb90a1353d-5634a8870f2mr3213713e0c.5.1767966564598;
        Fri, 09 Jan 2026 05:49:24 -0800 (PST)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56345043f83sm8354608e0c.19.2026.01.09.05.49.23
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jan 2026 05:49:23 -0800 (PST)
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-941063da73eso2948390241.3
        for <linux-pm@vger.kernel.org>; Fri, 09 Jan 2026 05:49:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVqrc0ITU5T1MqN9c3n4OA3QHAaNKvHaC4LBLCvOcrjPTWB7mlKZuBY0R/8zsORkBCPrH5YlXoF1A==@vger.kernel.org
X-Received: by 2002:a05:6102:800e:b0:5ee:d0ff:7254 with SMTP id
 ada2fe7eead31-5eed0ff7574mr1607434137.34.1767966563511; Fri, 09 Jan 2026
 05:49:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108195223.193531-1-cosmin-gabriel.tanislav.xa@renesas.com> <20260108195223.193531-4-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20260108195223.193531-4-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 9 Jan 2026 14:49:12 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX39Bdg_LBry8QmGTR9Z=CNs6xGksFbzJw-8oDt4CcOqQ@mail.gmail.com>
X-Gm-Features: AZwV_QgbNm6q3mt1zlj7hyuAc6e9Eu-odKmqzHG0qAir3pZOPVNUb1tURDFNGtE
Message-ID: <CAMuHMdX39Bdg_LBry8QmGTR9Z=CNs6xGksFbzJw-8oDt4CcOqQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] thermal: renesas: rzg3e: make calibration value
 retrieval per-chip
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: John Madieu <john.madieu.xa@bp.renesas.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Magnus Damm <magnus.damm@gmail.com>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 Jan 2026 at 20:53, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs expose the
> temperature calibration data via SMC SIP calls.
>
> To prepare for supporting these SoCs, do the following changes.
>
> Rename rzg3e_thermal_parse_dt() to rzg3e_thermal_get_syscon_trim().
>
> Move the syscon usage out of rzg3e_thermal_get_calibration() and into
> rzg3e_thermal_get_syscon_trim() and remove single-use variables from the
> private state.
>
> Place a pointer to rzg3e_thermal_get_syscon_trim() into the
> chip-specific struct, and use it in the probe function to retrieve the
> calibration values.
>
> Now that syscon usage has been moved out of
> rzg3e_thermal_get_calibration(), remove it and inline the calibration
> validation into the probe function.
>
> Also, reuse the TSU_CODE_MAX macro to mask the calibration values, as
> GEMASK(11, 0) and 0xFFF are equivalent, and replace the hardcoded 0xFFF
> with TSU_CODE_MAX in the calibration validation.
>
> Reviewed-by: John Madieu <john.madieu.xa@bp.renesas.com>
> Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> ---
>
> V5:
>  * replace hardcoded 0xFFF values with TSU_CODE_MAX
>
> V4:
>  * pick up John's Reviewed-by and Tested-by
>  * replace new macro TSU_TEMP_MASK usage with existing macro
>    TSU_CODE_MAX
>  * remove "Validate calibration data" comments
>  * inline rzg3e_validate_calibration() into rzg3e_thermal_probe()

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

