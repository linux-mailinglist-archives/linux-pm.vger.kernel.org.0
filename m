Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFDD9DCE1D
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2019 20:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505340AbfJRSiD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Oct 2019 14:38:03 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33980 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730794AbfJRSiC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Oct 2019 14:38:02 -0400
Received: by mail-pf1-f195.google.com with SMTP id b128so4416110pfa.1;
        Fri, 18 Oct 2019 11:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IFDsqOMwc2ojaPSLkT8+wMYUXewN1acLP2lqR1XP15Q=;
        b=HDe9kDeKBahe9NjGm/ugr3PrO4D0Lw085ywSNSA095A6Y7b0bdnZjmqC82XIISIIdt
         HL1478hYPAIvWzZLWe743K+0Z4UKFrxK0/hQ9QagRbJbspKW/xQebobzv2mUFy3hRLKH
         //wSlMwz56Seed2I+e/Y5zi3HKTITkVYbYNZcR/r9Ty9L4OUJxGZQa8n7sooJF+d06MV
         U8c1Xqzj80SWkW1+fMzKDsGOIVt27mRFx9PdNgqZxq/nnXPUUxC1LvIFwI/iWySD+Mw9
         Y/fW+KH35SuT8tMvpzVKHsaJfOpxO5whSf8Fu101J4r54ddKqPMDRDSv0HSvbuy5Taxu
         2ebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IFDsqOMwc2ojaPSLkT8+wMYUXewN1acLP2lqR1XP15Q=;
        b=oQmEyaKbSDM+BjqtH9XH/ITkCs9nIAbpkizbSvzomnnq/0WoQtlqH+ZgB2NMm0sqyM
         46jfYSYcmdghh+BLiwdnMur5fcuVVl6PZBR4Duj0vEJaxdUwajkJ1+I0kRfNwUEu7Nqu
         LFIWf0HGvmwjhmAj3CGLg4COcqI1XNfQ+teg4tGyrVQ5OSd2bpo9lnC+9YemWrsnvNPx
         V4n2+Rm8RJFkviWUpgc2SzFFKIydJdRW5pFB16+igXpEOgwFaeJBXkb1vLNJyq9PFu7f
         8ZLX42oiOsFyC3ZhG7qLsIBE8Oxz6cqbcTajgQ7yjg8ZdDyJfe/tG97bNlPyNqi+R8le
         8lig==
X-Gm-Message-State: APjAAAVkC6MI9rbmGK5AsM/4nnVmhBP6ZwpDmT2NKV7C0BLUGKOr0CSe
        STr4JWggU2B73+Bp2Iktk80=
X-Google-Smtp-Source: APXvYqxI3fG8J2/DXNrMqbp5He+LcRaizowKU8zXJc/NBeHP6e+1CmGad85VCcLrdR+rSgjhba5HPg==
X-Received: by 2002:a63:5762:: with SMTP id h34mr2723268pgm.235.1571423881363;
        Fri, 18 Oct 2019 11:38:01 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id 69sm6908001pgh.47.2019.10.18.11.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 11:38:00 -0700 (PDT)
Date:   Fri, 18 Oct 2019 11:37:57 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Brown <broonie@kernel.org>, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-rtc@vger.kernel.org,
        linux-usb@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-watchdog@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 05/46] ARM: pxa: split up mach/hardware.h
Message-ID: <20191018183757.GL35946@dtor-ws>
References: <20191018154052.1276506-1-arnd@arndb.de>
 <20191018154201.1276638-5-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018154201.1276638-5-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 18, 2019 at 05:41:20PM +0200, Arnd Bergmann wrote:
> The mach/hardware.h is included in lots of places, and it provides
> three different things on pxa:
> 
> - the cpu_is_pxa* macros
> - an indirect inclusion of mach/addr-map.h
> - the __REG() and io_pv2() helper macros
> 
> Split it up into separate <linux/soc/pxa/cpu.h> and mach/pxa-regs.h
> headers, then change all the files that use mach/hardware.h to
> include the exact set of those three headers that they actually
> need, allowing for further more targeted cleanup.
> 
> linux/soc/pxa/cpu.h can remain permanently exported and is now in
> a global location along with similar headers. pxa-regs.h and
> addr-map.h are only used in a very small number of drivers now
> and can be moved to arch/arm/mach-pxa/ directly when those drivers
> are to pass the necessary data as resources.
> 
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Cc: linux-input@vger.kernel.org
> Cc: linux-leds@vger.kernel.org
> Cc: linux-mmc@vger.kernel.org
> Cc: linux-mtd@lists.infradead.org
> Cc: linux-rtc@vger.kernel.org
> Cc: linux-usb@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> Cc: linux-watchdog@vger.kernel.org
> Cc: alsa-devel@alsa-project.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

For input bits:

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

-- 
Dmitry
