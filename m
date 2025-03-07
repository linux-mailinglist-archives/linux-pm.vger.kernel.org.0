Return-Path: <linux-pm+bounces-23627-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFF5A567A8
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 13:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CD037A7D53
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 12:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C487218AC4;
	Fri,  7 Mar 2025 12:15:59 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F93149E0E;
	Fri,  7 Mar 2025 12:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741349759; cv=none; b=r3jb3AwlYL9tLgjxJpsc4fRCMwDEHmq/FpSFwA6s9Cxuu8BIigsBqSTFX4+xzjcNZXFuAgU5r+6lyrPnVP1qg1j4LaoB9KoFvFMSYod4F8MlSrEoAyCex/Sq/k0QeODBSLEN6cdraTeK0xoVfg5a1CuT9hAYRFyXTFjGtYc4SZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741349759; c=relaxed/simple;
	bh=Mkxsk+8ZzK8MNLJflwpYr/fZgGBX+yXybH8aRt+IVXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cpGUnKwGL4LcDrWNlHi9BSosFOqt07jG8SvhmwjIZmz7GGsgdMsm1emnGR+L0HYvnXLj4BlYfQu5IMM08U/YPH/69uQovwL7hTM+INI1JQWbDdx5UtdMZUl6wOTp9oSpqRKSCW4FmxIIu61nhq4PP9V3nco64rmvz1y3sRmq8As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5dccaaca646so3617811a12.0;
        Fri, 07 Mar 2025 04:15:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741349750; x=1741954550;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K0tTBBkSXXJKUR9oaU2RMjBJaq/Kyp/6BfjUzv+/56o=;
        b=HMOjN1VGPgjEHXn0WBromolIKA0nN/4/Xpq8/CNd3Q65QAm4AjKIXRlmTADvhd44LY
         jI4XQk4Ayx3mEsNOAiMvaZKvDalyBf6RHfF+JQ37vmCDL93rtr7l5k5W8T5IgOeGnufu
         p05RpstbOkEA9nFOg3pC5QES5VxJe76YXXjyJuTlBCXvPh02VxPCmqKlZ/OMAy3mco7U
         L6dPdpBfFEpuGhMmK0kw1Q1nMl9asZoOX7lIGRrnxqdHzSpw/8M0wDKJXwxLlzeVFMay
         2atyPylcTH+y4Lq2+2mwdUl3cOht57bcOFTvsnxIjYKOhYjz1Cw68YcbwPeNIPZpSkng
         sS2w==
X-Forwarded-Encrypted: i=1; AJvYcCUarB2Cw2JUJIWK6h8b8DkuPARo0C9T3O5r11QI+1zNuxsBlkStxR1z3KmELkB7q26CunbftH5qYNI=@vger.kernel.org, AJvYcCWhvfK6TNX95oXGrA5gaMLQ9Dc+7VaW8D7V985Yjq7gryTlz0DmRveiDcgUzhANUZaksr9D5D70xBIxsDNO@vger.kernel.org, AJvYcCXCVjZjiP6UfTIc2FmLR+l857GK2fEaFsPRyt0UJRBlN7v6/bElO1yKUJkkFndp9vEkQvM5OmDQ+jQ=@vger.kernel.org, AJvYcCXbCc6YQOimKgdoBLQszQQDXrDPwQzynZ+9/IWzMFjRljdksvRGNsDQHLqvhhr3fcgUncAo9wKwj6BE@vger.kernel.org
X-Gm-Message-State: AOJu0YxUuu+Bi+ZdvdX77sSbbJdqExzR68Q/efSuMLsP4wPZBhcQW34n
	ov13q9TLfuZJbkWe+ZhmTIVrCMe/FdUTPwIMKtQ8nJy4OBS13KFvN2RIgF/2fI8=
X-Gm-Gg: ASbGncs+Oaxk5mBLDPO8UyNqd7iTzrvQWAaRJyQ35BqWqSsPTsPTLcLeA0gqkK47N2I
	epwk6PAne8tOW0HvoJph0TjCf4rEuab18Fkr8l9Nk4pYsUyYbVZEppL4epH+CMW/Ctlzj33aFpe
	ydkcFR3QaM2eodggy2r/CiQWF9iJiKnJd+4Nm/eKLFp2il6m3efIeNeesmvNbTL6q9meQm2Xwce
	6+UgznZ7pSRvjQvP98bXF2n54Qj3dkt2CnjFPhjpgNe3Ou3R9hhc+/7TCqmeXDeN+UBvjk+uITD
	lMT4DBPa4ugXX2t9bg84GlZODhTaWosAnnJEqS49ZwDpVJVhmKWIGABgsfGw5MQleRqxWToJNEY
	arPUbZ34=
X-Google-Smtp-Source: AGHT+IGYC2BFtgADX5tcvXREP6IthAkbQKnrNTYLD0waNq1mBm5QpcKespZcrve+ON46/krj/WXp8A==
X-Received: by 2002:a05:6402:5113:b0:5e4:d27a:d868 with SMTP id 4fb4d7f45d1cf-5e5c1a6463bmr8441040a12.0.1741349750401;
        Fri, 07 Mar 2025 04:15:50 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c768ef30sm2467240a12.69.2025.03.07.04.15.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 04:15:48 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac2400d1c01so282345866b.1;
        Fri, 07 Mar 2025 04:15:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV9ZkFB4WK2Ek8yWWzlyy8ok89VAmx6fy4R99yxJ8nfohq7lBfEtQhG042Nb53bEUMhPLwyblOzFuM=@vger.kernel.org, AJvYcCWVJFhCpoqqjaXPoLpOVK0L8+liLIllL7UrN9rL4yVv2kgR4oK1Nh1iolO70gew73GeECAlWY5K2tby@vger.kernel.org, AJvYcCWw8PRCP7q0xwYspQSWszPJfKVJUpftJg8+qBjiNNesnR3BmuKLg4X4NEdhGQi6XY7pzDMJDs1fkoorrId6@vger.kernel.org, AJvYcCXq8p45vG3YCMJKVyWF3LAcCTr2ePU7TIShbUnwiJ7/JQLbHzvaZyOVP2VGyS1SwR1dSYFkH8LnqfM=@vger.kernel.org
X-Received: by 2002:a17:906:59a1:b0:abf:555a:899f with SMTP id
 a640c23a62f3a-ac24e8a165dmr392518166b.6.1741349746952; Fri, 07 Mar 2025
 04:15:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307-vsprintf-pcn-v1-0-df0b2ccf610f@bootlin.com> <20250307-vsprintf-pcn-v1-2-df0b2ccf610f@bootlin.com>
In-Reply-To: <20250307-vsprintf-pcn-v1-2-df0b2ccf610f@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 7 Mar 2025 13:15:32 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUzZ8GK1mqXw+YgvFZ5xhOy-v_oOeaVrCtFUhk=n+rF8g@mail.gmail.com>
X-Gm-Features: AQ5f1JpiPD-qF9biv1S8tlEkcmxPY9MCTwa00AZqEgKbE5uM-n1NMvZ7sTZ9fuM
Message-ID: <CAMuHMdUzZ8GK1mqXw+YgvFZ5xhOy-v_oOeaVrCtFUhk=n+rF8g@mail.gmail.com>
Subject: Re: [PATCH 2/2] vsprintf: remove redundant and unused %pCn format specifier
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
> %pC and %pCn print the same string, and commit 900cca294425 ("lib/vsprintf:
> add %pC{,n,r} format specifiers for clocks") introducing them does not
> clarify any intended difference. It can be assumed %pC is a default for
> %pCn as some other specifiers do, but not all are consistent with this
> policy. Moreover there is now no other suffix other than 'n', which makes a
> default not really useful.

The original intention was indeed to serve as a default, like some
other formats also have ("%pa[p]", %pOF[f]").

> All users in the kernel were using %pC except for one which has been
> converted. So now remove %pCn and all the unnecessary extra code and
> documentation.
>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

I guess this is a worthwhile cleanup.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

