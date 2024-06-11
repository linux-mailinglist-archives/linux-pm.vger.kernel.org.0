Return-Path: <linux-pm+bounces-8902-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88111902FA6
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 06:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 322FF283B7A
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 04:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5D3170823;
	Tue, 11 Jun 2024 04:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Iwz7e8sU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3589140E30
	for <linux-pm@vger.kernel.org>; Tue, 11 Jun 2024 04:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718081529; cv=none; b=Q6+GUoIy9USK0jqRmYdi3Fi0vs3fDRrpzYPJ3mgeIEzrIC5Yag+k6IOoT9tDWAqiBFwx3IYt/OCtS1FZ0MlodmYOFXU1Zp+CdQ2yo/fQHus9afZMa1Ir5dscsbIMsPUGymtXMatFMAjhU8Hicz1wlNX0XPUK20fjAMsmHp5s5ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718081529; c=relaxed/simple;
	bh=XVLIZfIJnnMN/EUq8/G3t+XkuGYTj4SvgWh/gJs9dMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s01WW1YTMVL9PyDr09sFQu3vBI9gWsPn07kMSZfGHaf2I9sJ0iFm8YvHg2xLn/p8cGHh6XRcm98aDro2ft6goctQdWGEyooOEcf338fLgGTirQLh1y4N1IRJpYlyGOHOEECiHvb3Y2ge4PJHIDIz0c3Uv0Kc7N4ZMXUvUwJoW/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Iwz7e8sU; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a6267778b3aso513431266b.3
        for <linux-pm@vger.kernel.org>; Mon, 10 Jun 2024 21:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1718081526; x=1718686326; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ehRXid+5yEA0xT7TzSIt1MaimTqtIHWJl33gJuDzaKE=;
        b=Iwz7e8sUv/wWwB05SpXWDstXjC1Tu/idaYJjOsfaKVX6cEbVGrapchtyB0O10L3fqY
         jCEqQr7Qh3+F187z3kTKJX6siR1JuDSQThOu5gwxxnMyUHtvseeVgId2wU4n/6/6W1Qz
         7rQqLjI83GhMDMCJBEtnGbEWJJ0nzzfJazepA92jD7acqB4dumENWCLAfC4XNK2Pgfjc
         8YL+HooTw2fQCplPsl8Bm+D3JZ88/e/6b3tTBL6d4raBRAFHgBw/aDmEH9nbfLn56Ouu
         5XokSUy/8e7yYey4lC9/bq1VcbJixtaLVam7/ZAH1O42SYeA0/HyND/P19NDceE/VuzM
         c6/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718081526; x=1718686326;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ehRXid+5yEA0xT7TzSIt1MaimTqtIHWJl33gJuDzaKE=;
        b=YpStwUyoT1V2CtIueG9VDre8XeyQ6MvbpwJp0mcUeaILflnMexC/hNaKfv9FvEb7Nk
         83Uq2YHqbKazHl7HjbIZdu6DmVM7n4RfV6kq2e8+ZnZo824KlYn4rZGYg4fPCPI/V7Ea
         jcUjbvrB5dmOjFkpAgKdz/WiQtOTz0erLKoTvAuXZmmdgJ08NUl2OQl7x1xRUm8G8UMb
         Qz2s9MiGXsxTO271LwPEDlssxmDT8iZsfqztBTEXKgkGdRcaJpmcVbF0QdqDTR4XW+gq
         +KTM2lP3iYjQyKLRpfFmpKqkIFG/vlGELaA5R5gZLwlPD39ZUsYhuXBn3tgKpOy5hPvp
         51SQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGhW/4R3r/Wi5ie/KYS16zK7QCqBPFu12zh1UYkFtyJ/rVIxBF//d3Z+c4i1OC9anBdc6XHFo/T5CNgL1H9Jj+Mx52JXEFUlw=
X-Gm-Message-State: AOJu0YwoNMJkdqOyP0IAl6/hdmwOBkC3SImV2N90wI4ZvPyw8dTIWX7G
	PYhBZkEKdeACCSMPl0A3X2a7Gk0uiwvLHvOHK6wY4VYwZdtzR9U4VMigw5411mo=
X-Google-Smtp-Source: AGHT+IH0lC83vmNja8AE71i3TrZcd5JzYAtGnU7Kfaw3qewnJANh1AFZkh4ihNNhebHCy9pOqJbXDQ==
X-Received: by 2002:a17:906:2e82:b0:a68:379d:d623 with SMTP id a640c23a62f3a-a6cd7a84203mr640846366b.36.1718081525789;
        Mon, 10 Jun 2024 21:52:05 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.189])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f17561c3dsm286452366b.217.2024.06.10.21.52.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 21:52:05 -0700 (PDT)
Message-ID: <b9c97dc4-b5d6-4886-967c-6b7d331d27a7@tuxon.dev>
Date: Tue, 11 Jun 2024 07:52:03 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/RFC 0/3] pmdomain: renesas: rmobile-sysc: Remove serial
 console handling
Content-Language: en-US
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>
Cc: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Peng Fan <peng.fan@nxp.com>, linux-pm@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1716811405.git.geert+renesas@glider.be>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <cover.1716811405.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Geert,

On 27.05.2024 15:41, Geert Uytterhoeven wrote:
> 	Hi all,
> 
> Since commit a47cf07f60dcb02d ("serial: core: Call
> device_set_awake_path() for console port"), the serial driver properly
> handles the case where the serial console is part of the awake path, and
> it looked like we could start removing special serial console handling
> from PM Domain drivers like the R-Mobile SYSC PM Domain driver.
> Unfortunately the devil is in the details, as usual...
> 
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
> cause a crash or system lock-up.  E.g. on R/SH-Mobile SoCs, the serial
> ports share their PM Domain with several other I/O devices.  After the
> use of pwm (Armadillo-800-EVA) or i2c (KZM-A9-GT) during early boot,
> before the full serial driver takes over, the PM Domain containing the
> early serial port is powered down, causing a lock-up when booted with
> "earlycon".
> 
> This RFC patch series aims to provide a mechanism for handling this, and
> to fix it for the PM Domain case:
>   1. The first patch provides a mechanism to let the clock and/or PM
>      Domain subsystem or drivers handle this, by exporting the clock and
>      PM Domain dependencies for the serial port, as available in the
>      system's device tree,
>   2. The second patch introduces a new flag to handle a PM domain that
>      must be kept powered-on during early boot, and by setting this flag
>      if the PM Domain contains the serial console (originally I handled
>      this inside rmobile-sysc, but it turned out to be easy to
>      generalize this to other platforms in the core PM Domain code).
>   3. The third patch removes the no longer needed special console
>      handling from the R-Mobile SYSC PM Domain driver.
> 
> I did not fix the similar clock issue, as it is more complex (there can
> be multiple clocks, and each clock provider can have its own value of
> #clock-cells), and I do not need it for Renesas ARM platforms.
> 
> This has been tested on the APE6-EVM, Armadillo-800-EVA, and KZM-A9-GT
> development boards, with and without earlycon, including s2ram with and
> without no_console_suspend.
> 
> Notes:
>   - This should not be needed on RZ/G3S, where each serial port device
>     has its own PM Domain,

For the record, I've tested this series on RZ/G3S. All good with it.
If any, you can add my:

Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thank you,
Claudiu Beznea

>   - drivers/clk/imx/clk.c and drivers/pmdomain/imx/scu-pd.c have special
>     handling for the of_stdout device, but is probably not affected, as
>     each serial port seems to share its PM Domain only with the serial
>     port's clock controller.
> 
> Thanks for your comments!
> 
> Geert Uytterhoeven (3):
>   earlycon: Export clock and PM Domain info from FDT
>   pmdomain: core: Avoid earlycon power-down
>   pmdomain: renesas: rmobile-sysc: Remove serial console handling
> 
>  drivers/pmdomain/core.c                 | 24 ++++++++++++++++--
>  drivers/pmdomain/renesas/rmobile-sysc.c | 33 +------------------------
>  drivers/tty/serial/earlycon.c           | 14 ++++++++++-
>  include/linux/pm_domain.h               |  4 +++
>  include/linux/serial_core.h             | 10 ++++++++
>  5 files changed, 50 insertions(+), 35 deletions(-)
> 

