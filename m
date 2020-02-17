Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0418160C0F
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2020 09:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgBQIBb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Mon, 17 Feb 2020 03:01:31 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39996 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgBQIBa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Feb 2020 03:01:30 -0500
Received: by mail-oi1-f193.google.com with SMTP id a142so15854143oii.7;
        Mon, 17 Feb 2020 00:01:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CQ1mKDwhrXQV7zEXL+R8pA9wSR2h3UQcHntZ6yLJatE=;
        b=gc15yOUpSE0MSwTKxD4KeyFTlCqNqnem/0jXIqb8DUXEdxCrD0Zt86cW4zhS/7woGl
         S/Q6auKuaGOA5SxQgNFFgUIqHvYtS86rWdsggjKUu7SCkZz5ZY30lpHZykmis3GNncAu
         Tn7aKngF006RPzbuV5xx+TlxWISfslQTEZ51aZp4m9DfeHUxCcESt9bkTEPNu2bNSA/b
         viIw+H4TSTg+R31t2smomvuRgtaD2U4GQQmG/QfbP5miDDEV4rmuaTbJBlVF3IGOuFmx
         6l7Is2oSnq9hLBzIOTqz50sj62eL9vJ22NH5vmeqFFe+DnfZ8dHxCbfMg4aVxsUnQz7f
         7bhQ==
X-Gm-Message-State: APjAAAVNXqCu7MjXXcOa+VZARMOkaiFtC73OHwI0DOgRfU9RD2RHXsPc
        oLoSPRrqISjv4/tJjMxt+6w5aoGHhSiF4A9E6M+pJw==
X-Google-Smtp-Source: APXvYqz54VsuWqMzr2U/2Jdpu2Lgc6B0HcOy1XVGCSHxRSr7iUM9SOQflHUOxeJm4B62XzG8iu+n3/bG5T0fHsdQvFU=
X-Received: by 2002:aca:b4c3:: with SMTP id d186mr8906251oif.131.1581926490013;
 Mon, 17 Feb 2020 00:01:30 -0800 (PST)
MIME-Version: 1.0
References: <20200216130252.125100-1-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <20200216130252.125100-1-niklas.soderlund+renesas@ragnatech.se>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 17 Feb 2020 09:01:18 +0100
Message-ID: <CAMuHMdUdBVwAbG8Qicg3_aKvwjq91QJWS5FQwM6NPdgbyP2Wzw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add entry for Renesas R-Car thermal drivers
To:     =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Niklas,

On Sun, Feb 16, 2020 at 2:09 PM Niklas Söderlund
<niklas.soderlund+renesas@ragnatech.se> wrote:
> Add an entry to make myself a maintainer of the Renesas R-Car thermal
> drivers.
>
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

Thanks for your patch!

> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14206,6 +14206,15 @@ F:     Documentation/devicetree/bindings/i2c/renesas,iic.txt
>  F:     drivers/i2c/busses/i2c-rcar.c
>  F:     drivers/i2c/busses/i2c-sh_mobile.c
>
> +RENESAS R-CAR THERMAL DRIVERS
> +M:     Niklas Söderlund <niklas.soderlund@ragnatech.se>

+renesas@???

> +L:     linux-renesas-soc@vger.kernel.org
> +S:     Supported
> +F:     Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.txt
> +F:     Documentation/devicetree/bindings/thermal/rcar-thermal.txt
> +F:     drivers/thermal/rcar_gen3_thermal.c
> +F:     drivers/thermal/rcar_thermal.c
> +
>  RENESAS RIIC DRIVER
>  M:     Chris Brandt <chris.brandt@renesas.com>
>  S:     Supported

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
