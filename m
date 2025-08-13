Return-Path: <linux-pm+bounces-32263-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D909AB2486F
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 13:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8E5214E2001
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 11:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1A12F6578;
	Wed, 13 Aug 2025 11:26:47 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370AB2EFDA5;
	Wed, 13 Aug 2025 11:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755084407; cv=none; b=dma+KCOYN1MJ5wlS2YJ1fezLJ8Zt5yFC7TdWKGPGBNjnNk3DiRHesYw3iZtJrebMqiTWZR+lTvTWSORVQt4RY1TBTXyx1MdWB1OFDkuP6eJD84yFQR0HHJ8YNQNk0aVIZNUcQINrKDw6fm0kWF+20fB0KJnvXF04XqwxY+8/z8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755084407; c=relaxed/simple;
	bh=fzqMGG8V8SPRaV1LKUoRN+6mAf+90Yl/FDGhIo20URo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kktFXafNvDioVa7XhJe5zgcoVGyRZo++NFy6XrpxZI8+ot3WV3J/crsPrCjmeZDW57CUfAcfCPcggf+NWAIszqI7PYa6SwvwybA6k7dMe7+GsnOwLzOkCcWy9rCoJSvzl6HJgavmi5XVIkSSy9usi4SCiZnYuYugdxcLeWoSi/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-88dbc90853cso2019364241.2;
        Wed, 13 Aug 2025 04:26:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755084405; x=1755689205;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5X88upYJLPZoU/cx5CDeAdlyDp5FEBOygx9KwHqJ+tA=;
        b=LllOQa2eAlVf8jISBphXyrCYhMjnpI6XQi+i6/zwhcpRQjPT7OUAaS8XgXzmHqL6CH
         eQaXeYdjyzRXyezVyCc+13v/7LDrdI3BvoAPo2UDIbVaBNOiYdIIKOYA6ENlAWVmq2jc
         +ZaibNDnM+9yV/pMB93fctoC2n1HJ7LBhypXPZP/ObXigCakQEQpqCQLVrF7D9eUINSV
         /LjSKCLcfShLr6o+/CDmYTtSxsp3F1G/JIz/9vHEXy3sB94romJ4gJLKygTT1+eRrKzR
         o60tEYauGyyRNG83kNpS1UbKZgwtrjGh9taOb8NVzuzGctpuzXN23idTYK3/JvWYMcpQ
         zDpg==
X-Forwarded-Encrypted: i=1; AJvYcCUX4JNvJQUXaMCYn8kKQi39mvaBNeKkApjrTwlrDpPa0TTPz0SUZVsVd2F/vkWg5tZlmoUQ2F3v3iUzWT9B@vger.kernel.org, AJvYcCVQPFrq4L+vcwp8mTJfvYVQJVhdXqhVlISNQi8NrVsn/mYCdAbb3rUHjjPTclLviRd10suNhbDawgo=@vger.kernel.org, AJvYcCW6AmY1cPXDR5VZrsh3mUrBrvCGc0bbA6Q1oNdS/UDd2Upjzoizndfw00oa/fErzfbNeW/HbMa9i5M=@vger.kernel.org, AJvYcCX8LydFKb32S+TP+4Asj+M4ZQHK0z22C2aX5BXN5ALsSP6Jr+O8uNguAzYBuw/1U3BxzrSuJZyKzjHMKc15ul0HILA=@vger.kernel.org
X-Gm-Message-State: AOJu0YytKmykbJFozUEtILsTm4LdzybPe0ZIqDsGH8ZFy2Jvy08JDNrV
	KF39HJpPs67YlCGId2x9kyNLwN4OjM7bF+IBlvdyZ1hCKAUyT5uZpflGvRyxG0dM
X-Gm-Gg: ASbGncsQ2wCQu9Btn+vBxdWMPVtwaLKN9ordfbYSIZLPHQHXtrqRi8J/AAd2LNdx4a8
	ex8Svu/zYfiTQIo0Nt7Lao9Ek4duvYOK5kf39rZNOce1rrvbR9p6P23BenPq6f2gF05aUatbiFB
	8DKZXl2ZZ8veQQ6KIgPavH1POAWHB4Vx2MuNzA815XyAU/CXQ/ZUfjUhl3vjaldmNzaEfWs4vLa
	DbMddRpJNv//9UonWt+JkxvECGF57zYSHRomTU4KZmlJcJYprbyCxDmxYUHpCnZdEJHpnj5oT7d
	7vZhf1Q+Wly851Wyq1DZzKryu/9Le2PoDkZhkjaO0WfLpQBnp58Oy63m59bGGj6lZTxYEQaZjzk
	F8rZwsRUaGdIZRpsqaJsgccY3XENFdmyv5hu1ak9XBcOgqkyOGhJARD0XucS7
X-Google-Smtp-Source: AGHT+IGeb38toe/bmqTQKGzgtA+jGVWL+A0DN2MDRDkmzAl36hTu7BPkQ7fh+mVDfjAhKWo0ZETUqA==
X-Received: by 2002:a05:6102:f99:b0:4e9:9281:85aa with SMTP id ada2fe7eead31-50e4e5d7b35mr862124137.1.1755084404909;
        Wed, 13 Aug 2025 04:26:44 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5062b6519e7sm2671826137.13.2025.08.13.04.26.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 04:26:44 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4fbfbda957fso2162459137.2;
        Wed, 13 Aug 2025 04:26:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUJnlN+ml+Fa2M27uI+nF0NrKB4dal6o7vYn6ImsPdbWIeHD7otJ6/rEyUKIm0T+0TnR3Jz9JY793I=@vger.kernel.org, AJvYcCV4819G+Wu4lpR1TXrqQB8X57kYxphPSWOP/SwDBgJJ+sLtA7DDryGRb4vmOxltSavRIY072K1DBCfzVrbkE/q72sU=@vger.kernel.org, AJvYcCVV2UVJJ4qw8cvx6cLmTPFxTj3Nu3aGUQchYByPer/wXx9B8vI177QBJAqbzN5bC22xCyrgu6tURnQ=@vger.kernel.org, AJvYcCXNce/vicxuhaNZOv2vyv37iidweDbE7203q2gXOlwHWZVOT9QRzkw7f6eyHGxBlj+0g8H4OoO8irt2YDQO@vger.kernel.org
X-Received: by 2002:a05:6102:304f:b0:4e2:ecd8:a27 with SMTP id
 ada2fe7eead31-50e4e5d6dd5mr768175137.4.1755084404225; Wed, 13 Aug 2025
 04:26:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <81ef5f8d5d31374b7852b05453c52d2f735062a2.1755073087.git.geert+renesas@glider.be>
 <CAPDyKFrCQdPAiDQyHm05mS7avOq6GPr0Ke4rZ2eaOhm37KGjfw@mail.gmail.com>
In-Reply-To: <CAPDyKFrCQdPAiDQyHm05mS7avOq6GPr0Ke4rZ2eaOhm37KGjfw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 13 Aug 2025 13:26:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWfXFHOYy9PbNAW0YoRxYyOU9T+Z3Vo34P_-GGOF0WkdQ@mail.gmail.com>
X-Gm-Features: Ac12FXxl8zxAgA21ZP-LF1f0j2Qj-NlmtJ9TPJhwIZT_94Hshc5_qb1VkFsBDgo
Message-ID: <CAMuHMdWfXFHOYy9PbNAW0YoRxYyOU9T+Z3Vo34P_-GGOF0WkdQ@mail.gmail.com>
Subject: Re: [PATCH] clk: renesas: mstp: Add genpd OF provider at postcore_initcall()
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Lubomir Rintel <lkundrak@v3.sk>, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Ulf,

On Wed, 13 Aug 2025 at 13:18, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On Wed, 13 Aug 2025 at 10:20, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> > Genpd OF providers must now be registered after genpd bus registration.
> > However, cpg_mstp_add_clk_domain() is only called from CLK_OF_DECLARE(),
> > which is too early.  Hence on R-Car M1A, R-Car H1, and RZ/A1, the
> > CPG/MSTP Clock Domain fails to register, and any devices residing in
> > that clock domain fail to probe.
> >
> > Fix this by splitting initialization into two steps:
> >   - The first part keeps on registering the PM domain with genpd at
> >     CLK_OF_DECLARE(),
> >   - The second and new part moves the registration of the genpd OF
> >     provider to a postcore_initcall().
> >
> > See also commit c5ae5a0c61120d0c ("pmdomain: renesas: rcar-sysc: Add
> > genpd OF provider at postcore_initcall").
> >
> > Fixes: 18a3a510ecfd0e50 ("pmdomain: core: Add the genpd->dev to the genpd provider bus")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> I assume there is a good reason to have one early part and one later
> part for the OF provider registration, otherwise we might as well do
> all the genpd registration at postcore_initcall, right?

Doing that requires migrating all clock drivers that provide a clock
domain from CLK_OF_DECLARE() to postcore_initcall() and/or platform
drivers.

> In any case, please add:
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

