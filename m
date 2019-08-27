Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 380B69F5F5
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2019 00:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbfH0WVh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Aug 2019 18:21:37 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34407 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfH0WVh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Aug 2019 18:21:37 -0400
Received: by mail-pg1-f193.google.com with SMTP id n9so250121pgc.1
        for <linux-pm@vger.kernel.org>; Tue, 27 Aug 2019 15:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=+QV1lxfro+2xR75kWYH74+2iVl7rk3tcmnqLNLA7fCo=;
        b=iJ+G8JlwHiPuZWkUcHmYZ1wNy1XV+y4WOsqYeulXbySkVPtadrhuD6PODEirTRSnKz
         PcmSWctkTfOPUu2QdZLFCLjZgzPgHst9fW09h2thERpJdEd+shbFxcGg3NxGNiN8VNJj
         j9c6N9CjbAt69F46n4zHU08vNJUrqAYEuBt4Aown2HorEx/NH++awnk3shP7rl07I5Y3
         /uaAKAwkv9sRdPF2Uhz1rrW2zwQt9AGvzdnEJfrhJMjA0hqdBXf2Nq2W9HlLqJNzw2jQ
         HsedPaxYFjjGYIDJ9uW+Nv3LIo/RUfG0ymLrYn+8NxYVgYNYVR14RlELOsfdzTfWzeDM
         mTwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=+QV1lxfro+2xR75kWYH74+2iVl7rk3tcmnqLNLA7fCo=;
        b=pyf72CI24SSqEULX2oXXEke+J/BisFu+rRA1MjTnPUxOd1CQoThKimXtRjcZBE53ER
         TeTb+CnSJBTAEE23kd6WaQd2bUkxv3OADDUPjLvesT4Lu9PNQ79hFg3S5FO7iwQux2Ux
         IO2rDPTo8Ou88AayJgW8HnRD/dAaO+CKPqfV7tGfYhSLR327JHS6y726HzjFBUCh6p3l
         s8yUlaO7ENOqJirFPX6i0nkhucC9clemxvCeaWzWSul30DOf0LZzT4JCBcWIcRQT+pTx
         caeocB4LLi1boQy7NRFvG7ZK3ALocZTYHdH1nMikinEe1NEfbp5ZUIfcs7zzV14Kty51
         AINQ==
X-Gm-Message-State: APjAAAUQp67ZWbfYxoPlxvlY5DIohw2gidKkJkxb7kpdmyYkkXaiqSm/
        LgEPUG53TJispbefozTqOa5yMA==
X-Google-Smtp-Source: APXvYqyco51mSNQzAaGPYLSKHmnGSAdHb2J1OzexYesNtAuslu1oxLH/YK/Ojv+o6ZBh9nX/zUeuRA==
X-Received: by 2002:a63:fc09:: with SMTP id j9mr600765pgi.377.1566944496183;
        Tue, 27 Aug 2019 15:21:36 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:cc35:e750:308e:47f])
        by smtp.gmail.com with ESMTPSA id p189sm306576pfb.112.2019.08.27.15.21.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Aug 2019 15:21:35 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, ulf.hansson@linaro.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>, linux-pm@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] arm64: meson: add support for SM1 Power Domains
In-Reply-To: <20190823090418.17148-1-narmstrong@baylibre.com>
References: <20190823090418.17148-1-narmstrong@baylibre.com>
Date:   Tue, 27 Aug 2019 15:21:35 -0700
Message-ID: <7hef16uu4w.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> This patchset introduces a new "Everything-Else Power Domain Controller"
> designed to handle all the different non-Always On peripherals like :
> - VPU
> - Ethernet Memories
> - USB, PCIe, Audio, NNA on SM1
>
> The current "gx-vpu-pwrc" process has been integrated to support the VPU
> and the other power domains in a single driver.
>
> Support for SoC domains has been made generic and easily extendable.
>
> In order to restart from clean architecture :
> - the PWRC node has been moved into the HHI simple-mfd, this suits much
>   better than beeing in the AO RTI simple-mfd
> - a brand new yaml bindings schemas has been written
> - reset-names has been added to clarify which resets are needed, so we can
>   dispatch them to domains
>
> For G12A, the PWRC now offers support for the ethmac memory power domain.
>
> For SM1, it also offers support for PCIe, USB, NNA, ethmac and Audio power
> domains.
>
> The DOS domains has been excluded for now, but can be added very easily.
>
> GX hasn't been integrated for now, but it would follow the same scheme
> as G12A support.
>
> Changes since v1 at [1]:
> - removed open-coded reset & clock get, enable/assert, disable/deassert
> - moved to clk_bulk and reset_array with count check with a warning
> - removed remaining sm1_pwrc in probe
> - reordered arguments for VPU_PD and TOP_PD
> - added get_power for TOP_PD aswell
> - ported special VPU handling from gx-vpu-pwrc
> - added shutdown driver call to avoid errors on reboot
> - fixed patch 4 commit log
> - collected rob's review tag on patch 1
>
> [1] https://patchwork.kernel.org/cover/11106393/

Series queued for v5.4...

> Neil Armstrong (5):
>   dt-bindings: power: add Amlogic Everything-Else power domains bindings
>   soc: amlogic: Add support for Everything-Else power domains controller

These two in v5.4/drivers,

>   arm64: meson-g12: add Everything-Else power domain controller
>   arm64: dts: meson-sm1-sei610: add HDMI display support
>   arm64: dts: meson-sm1-sei610: add USB support

and these 3 in v5.4/dt64,

Thanks,

Kevin
