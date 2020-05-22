Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34BBB1DF11D
	for <lists+linux-pm@lfdr.de>; Fri, 22 May 2020 23:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731029AbgEVV3f (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 May 2020 17:29:35 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:40104 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731027AbgEVV3e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 May 2020 17:29:34 -0400
Received: by mail-il1-f194.google.com with SMTP id m6so12131460ilq.7;
        Fri, 22 May 2020 14:29:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/FEKPVDTqZYdkry/gHcCWAwnNiWnV8DNS7HV5f1GoQI=;
        b=TPJIde6dEdsLcs1LdhvEyhOySzeUOZ1CiNJG4he1j98yAbJ8gV8W+ArPh8Ipnd37Vz
         pXZi1nqHmj4C550599w3TQs77ZV4/Xwl79pxGSHNv8lwI3IAKVzpR2cql4Znyt+C+mFB
         Imnk7SQFcQFg8vX+Y8+0Q8Pkszu6NF27mazBbP/K50ws/A3rkAfXBJK2XRN42qCSxRDD
         M+2S3vDO2ATKV9vYtb7LHdpQtdx5zXfkcH6hdwwj1ePj17F0Ua8EECTQZwt93FjQcotY
         uFBjYJR8DsUE6c5uUYffGoWVMc7zLkMAHENqhtwjMAdCKUIZIj7CUa7SroRjphJNProC
         C1Cg==
X-Gm-Message-State: AOAM533ODoUo1KGWCL203aK17phDpKpoay+y02m8aT0FSAyOvkrZwKit
        /wvc5ByijjaWv7k8A7wlK3s5+4SRUks=
X-Google-Smtp-Source: ABdhPJzgfC3yWWqO9UdDXOUNAhppP8mwrfKJ+jxYsbjhm0H4TYVYNN8ckWDxtItweG5bQSkvVk7kvQ==
X-Received: by 2002:a92:4909:: with SMTP id w9mr15370034ila.302.1590182973671;
        Fri, 22 May 2020 14:29:33 -0700 (PDT)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com. [209.85.166.48])
        by smtp.gmail.com with ESMTPSA id f15sm5252270ill.58.2020.05.22.14.29.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2020 14:29:32 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id r2so2621462ioo.4;
        Fri, 22 May 2020 14:29:32 -0700 (PDT)
X-Received: by 2002:a5e:8b4b:: with SMTP id z11mr4708967iom.78.1590182972502;
 Fri, 22 May 2020 14:29:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200507112955.23520-1-geert+renesas@glider.be> <20200507112955.23520-2-geert+renesas@glider.be>
In-Reply-To: <20200507112955.23520-2-geert+renesas@glider.be>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Fri, 22 May 2020 16:29:09 -0500
X-Gmail-Original-Message-ID: <CADRPPNSwEv_SV4jQk-gOj6+WhAX1jVQk2szgPN=o2JVqV0yjLw@mail.gmail.com>
Message-ID: <CADRPPNSwEv_SV4jQk-gOj6+WhAX1jVQk2szgPN=o2JVqV0yjLw@mail.gmail.com>
Subject: Re: [PATCH 1/4] ahci: qoriq: Add platform dependencies
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Shawn Guo <shawnguo@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-ide@vger.kernel.org,
        linux-clk <linux-clk@vger.kernel.org>, linux-pm@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 7, 2020 at 6:30 AM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> The Freescale QorIQ AHCI SATA controller is only present on Freescale
> Layerscape SoCs.  Add platform dependencies to the AHCI_QORIQ config
> symbol, to avoid asking the user about it when configuring a kernel
> without Layerscape support.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Hi Jens,

Are you applying this patches?  I can also apply it with your ACK.

Regards,
Leo
> ---
>  drivers/ata/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 05ecdce1b702cf8b..d9e66b37acd1862a 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -264,6 +264,7 @@ config AHCI_XGENE
>  config AHCI_QORIQ
>         tristate "Freescale QorIQ AHCI SATA support"
>         depends on OF
> +       depends on SOC_LS1021A || ARCH_LAYERSCAPE || COMPILE_TEST
>         select SATA_HOST
>         help
>           This option enables support for the Freescale QorIQ AHCI SoC's
> --
> 2.17.1
>
