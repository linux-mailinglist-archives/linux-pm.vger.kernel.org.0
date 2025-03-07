Return-Path: <linux-pm+bounces-23625-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F43A5678F
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 13:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A70851886765
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 12:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DC7218AC4;
	Fri,  7 Mar 2025 12:13:37 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA911B413D;
	Fri,  7 Mar 2025 12:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741349617; cv=none; b=mwegwAwEBllcRbuEhdEkutMgx7m7tDi4kIR/6dIv0X2uGROTwytp2wpURsU3G4WsTA8O0ZgHyqpjMM4JjvortcDX937+oTlisE56cZV3DvL6ZRxjuE4fqaxQmRoKUQgTikEtANS4wB+PYDDWRpU68vUKZsHcB2e6TUu73dsE7fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741349617; c=relaxed/simple;
	bh=Y2tea/SV2O71IZ/SlEuXPbWMvLQMc6VbkdZr9bFJELI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N2Jxlr5Zb1/CwznvVCcTUzNCnA2jSq4Fh8VXjS2xx6xQaUBNEtBJGlrXhInzDF6Eg0KuuEQ09W4GOJ0EIh+gGyiRanXtTeUfoBY6+NHWQrFCqsVJlmtzd3D1zgjslaLiDCZoIpzWD2NQP10jTvG6FBfhNTjLQMAtuEsFQuVhl9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-86cce5dac90so757349241.0;
        Fri, 07 Mar 2025 04:13:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741349612; x=1741954412;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bxeVgWBPIaIHKr/VoNwwOt9Stv37rE17JkSSDvEu9I8=;
        b=k6J7q9J5wMpiS+oP0kDdwFSeCIRJFMBLMm1lYw3Dtfmnbre1TyJEW3Pna8GVh22kwr
         95enl2OR1q0rQhycywvHiiE3UsQHF3u1ohyaVn9Bd+iil4GPAIqa0TRqHymfiST5ibum
         uzAR6XR0p5c6YSYX0LUINTLtK+fYIvtvMUW1N1AAZzIuj+Ao+RdAKiYCwj9GZ1QRB40O
         oyRMVgvkPeFlpoFIEtTISSSppeaAAkO92xSxILuUyiM2xRu7RzbulGEiubHdqdsCREam
         EIYy7y6v7ay1hr3bDPIzRuw+Yf/zCUcubkr1R2yZ9kNuTlbeEu/K0vK+cgY9OvX6vuJQ
         CqEQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6IpNcUdZ65NduMkq8/bW6+f3SyC6tEa7qNOPfL8vrukSyW+sK7AXCDcwraf3wsE5qUpp+vQ92VVPXqa39@vger.kernel.org, AJvYcCX7dBbOG3PLRLRlF/1OrGK5soQMR9i8lO2Za5cg99+MvvSAsC0IhoUVfcH1ELeAE3HHTEDQoYez/mk=@vger.kernel.org, AJvYcCXNJyRA33aCfbtSC+QX6Lyx9BP4k/rCKW2/d3RVgJyLLWbM9nmc9IA+Cjxov/ocif4rB3FYwBL6jpa5@vger.kernel.org, AJvYcCXO2KV+wa0iVrUncu4xTgp+qp+v5F1+c6YBbGM6OGyTitKy0ycPLAAYkd6P2XPI2yiYRkIUOGu/XlE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4Qa6jNjMXTA6P9A654gbxhUz3RrULsMe6qRnpDpzCcsV67LRx
	xH6SDQAX4Oi11SySCFkR4Du5W0yequ46zD0/6zlNgIylMet+Mun8x1Eteww/x5U=
X-Gm-Gg: ASbGncs3s/O3k0GoYijeVlHELFSyixc7mW2fJDBpE9Sgf9VJsBAql/uQFYihOnObTw3
	XWorHwUShUf7dvk+ralAYP/UEyGCSbrNTrBfQKPBrUVVeNBM9HFz+AiTPAqzZ6J2hhng8Sd6ZGm
	3CK8hSnxY3XaLKV/gixwYdnucXvVvqjYdtn8wd8kfsU35sW+Qin3qxcxUW5Ow0EHlYfekwtUmR8
	Mtfdj0JaO4tMuIeI2oK/RS7B9Kfw98XTdnDKQVHxgquWJWcYxKJFjbSvTpelDdTZw4dAWG/QZci
	cTeo0/1RWVx4bojIBZyRRt3Ip/4d2dhXVOJL/Scl8dgZfzeRfXFAAmPf0xr8tdWOSQcttG3vQ61
	0olzdgm8=
X-Google-Smtp-Source: AGHT+IEghvAAwuhoCq4oG0sKdWCVGwd5m0PWtGv1/pmpTcQ7dsNyqIES6opQez42K9NsZBqXxQ4jCg==
X-Received: by 2002:a05:6102:2927:b0:4bb:c24b:b64b with SMTP id ada2fe7eead31-4c30a68a683mr1582245137.19.1741349612137;
        Fri, 07 Mar 2025 04:13:32 -0800 (PST)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c2fb459a40sm651235137.12.2025.03.07.04.13.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 04:13:32 -0800 (PST)
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-866e8ca2e07so748378241.2;
        Fri, 07 Mar 2025 04:13:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUs8j9PWEJxFGun+6TofH2/CFdITiwmXZglRrX49ueeK9LwHB0o2V3CyVoZc2XjGMaZjYF0I6Ti8mc=@vger.kernel.org, AJvYcCVZat1KJsWJ6Ns0SEhtC0yGfstzIuE7Tb/d1QZNCPqA4MOiDqdu7XIusmOsjNW7mQtX75Yi4h5TVuoWHIxQ@vger.kernel.org, AJvYcCWH3A+fyb4JPcERcxxInhxCWybzYWkqC7hntD+cNmHqoz1mrH0/KaD8v6lWy31a5Z+GQr3lZE3RATI=@vger.kernel.org, AJvYcCX7baI6aYKSR4lJS0WSCbdAxStGYqbHRhQEKuCy5DkmUfs2v3DB4qEZewWjutZjDcCpjpclHpfgNDBA@vger.kernel.org
X-Received: by 2002:a05:6102:8001:b0:4bb:e8c5:b149 with SMTP id
 ada2fe7eead31-4c30a5ab186mr1795545137.7.1741349611548; Fri, 07 Mar 2025
 04:13:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307-vsprintf-pcn-v1-0-df0b2ccf610f@bootlin.com>
In-Reply-To: <20250307-vsprintf-pcn-v1-0-df0b2ccf610f@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 7 Mar 2025 13:13:19 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUeThsk5tSaMnT-6BqO6XSMTTDo1Q9kRgJ_d5iC7MTdcw@mail.gmail.com>
X-Gm-Features: AQ5f1JphTlGlfeyx26A9RukmW_sJoWB7kM5qnNPVm2RVhmEmPwlzPLJvmsJkOb8
Message-ID: <CAMuHMdUeThsk5tSaMnT-6BqO6XSMTTDo1Q9kRgJ_d5iC7MTdcw@mail.gmail.com>
Subject: Re: [PATCH 0/2] vsprintf: remove redundant %pCn format specifier
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Liu Ying <victor.liu@nxp.com>, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Luca,

On Fri, 7 Mar 2025 at 12:19, Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:
> There are two printk format specifiers for clocks: %pC and %pCn, and they
> print exactly the same string. The reason for having two is not totally
> clear (see discussion in patch 2), but there seem to be no advantage in
> having two instead of one.
>
> Definitely having two without properly documenting they do the same creates
> misunderstandings [0].
>
> Since %pCn is used in a single place, replace it with %pC and remove %pCn
> to simplify such format specifiers implementation and avoid
> misunderstandings.
>
> [0] https://lore.kernel.org/dri-devel/71c44221-b18b-4928-8faf-00893ec4a109@nxp.com/

The link looks unrelated?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

