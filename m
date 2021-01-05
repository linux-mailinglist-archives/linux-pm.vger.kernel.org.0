Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B95222EA8B5
	for <lists+linux-pm@lfdr.de>; Tue,  5 Jan 2021 11:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbhAEKaV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 5 Jan 2021 05:30:21 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:46181 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729133AbhAEKaU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Jan 2021 05:30:20 -0500
Received: by mail-ot1-f50.google.com with SMTP id w3so28826156otp.13;
        Tue, 05 Jan 2021 02:30:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TDV5ld2/gAWUMe2e3Urs0OVOKaSoQnRn0I/4UgQMJgM=;
        b=kJXXWY9xHnbjkA1R3T8m+le/OFWnOoCfWn9a68vHYI4ZZS2PT6fjUpLIw1xBbrxCGE
         PqX4QtlTztB5ewMYCqlNXpE7xiWkcnNHUPZcxpgikUV7d2eThBKqYnTfHCQYAs3H0aEi
         tu+iajzxtA5MW/vJS7212k1HEvoZKXIcIe4H0HddUu62Wjx4wtOYj5gVLv7E3oXU0qU7
         Vp7ajp9CRK7ItYcw3giPpKMI6FlTgYrG4puRROZt9HjEtvenX5KRA20BbMZU1z9Poo83
         YZ3dgrbiyl9j8ceXmP6ISculcpf4+jSy0EXhFWYHMymNoAZOmd4iFYqvuDF8tjd5NN/B
         0GCg==
X-Gm-Message-State: AOAM532UEBl0CDFE6Jvy848UOKVxXAuZFj5rsQmUQQvsPZbt7QAJ7hZJ
        4W/pswmayxXn4wfBogz+Lxr3/ZE68Avn7kZ2Z3c=
X-Google-Smtp-Source: ABdhPJwNA6QGouDzm+wcuKIn/tlwSG85mL6qx+xf5/iIHI5prpE/grOjRPnL80sz12/MCWPpayowKKXHWLBMGrKTw5g=
X-Received: by 2002:a9d:c01:: with SMTP id 1mr40558293otr.107.1609842579594;
 Tue, 05 Jan 2021 02:29:39 -0800 (PST)
MIME-Version: 1.0
References: <20201126223028.3119044-1-niklas.soderlund+renesas@ragnatech.se> <20201126223028.3119044-4-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <20201126223028.3119044-4-niklas.soderlund+renesas@ragnatech.se>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 5 Jan 2021 11:29:28 +0100
Message-ID: <CAMuHMdUm-1Tv11z_--+h+LiU=0OggpYfK=oTsDwx6dT=KmuBKQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] thermal: rcar_gen3_thermal: Add r8a779a0 support
To:     =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Niklas,

On Thu, Nov 26, 2020 at 11:30 PM Niklas Söderlund
<niklas.soderlund+renesas@ragnatech.se> wrote:
> Add support for R-Car V3U. The new THCODE values are taken from the
> example in the datasheet.
>
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

Thanks for your patch!

> --- a/drivers/thermal/rcar_gen3_thermal.c
> +++ b/drivers/thermal/rcar_gen3_thermal.c
> @@ -60,13 +60,14 @@
>  #define MCELSIUS(temp) ((temp) * 1000)
>  #define GEN3_FUSE_MASK 0xFFF
>
> -#define TSC_MAX_NUM    3
> +#define TSC_MAX_NUM    4

As pointed out by Shimoda-san in response to the DT binding update,
R-Car V3U has 5 sensors.

>
>  /* default THCODE values if FUSEs are missing */
>  static const int thcodes[TSC_MAX_NUM][3] = {
>         { 3397, 2800, 2221 },
>         { 3393, 2795, 2216 },
>         { 3389, 2805, 2237 },
> +       { 3415, 2694, 2195 },

No idea what the missing fifth entry should be...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
