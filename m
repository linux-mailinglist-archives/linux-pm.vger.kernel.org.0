Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCC83ACCD2
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jun 2021 15:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234020AbhFRNzi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Jun 2021 09:55:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39267 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234219AbhFRNzh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Jun 2021 09:55:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624024408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P/mlf3E91IxDGki9DJUtyEv6dP68LA3nvEkze77PADI=;
        b=ZHkww1dmxJ9VWP+u/tTeniV2dD+M303glrW98Nnuks2m7rsz+Nmsbwdc1EzhSW4sLdOcS6
        RDPr17F8MFalrQS7StLmVcD08rSuNYEYny2f8i2kQxa2wzQdjWfGOxUN7JZo8k5h9iuJtd
        errPpraV0dgohyta1s1pibQiNANuulk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-PJq3ikfEM1SIeZB0zJO7aQ-1; Fri, 18 Jun 2021 09:53:24 -0400
X-MC-Unique: PJq3ikfEM1SIeZB0zJO7aQ-1
Received: by mail-ed1-f72.google.com with SMTP id p23-20020aa7cc970000b02903948bc39fd5so1591548edt.13
        for <linux-pm@vger.kernel.org>; Fri, 18 Jun 2021 06:53:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P/mlf3E91IxDGki9DJUtyEv6dP68LA3nvEkze77PADI=;
        b=bMw6TL55a5o9fw58tWRlZ1YLhwOPwaxfTCz2bEIWc0Z1hFl9zrhm4kWB6Zcmb8xn5t
         aVFP5O7tOSGpYa7XHCNI/RiIYUzvzN/nAS1IG8LalmIY0lbOGxlDn6gh9lHP+0E8+BuR
         N3iz1hajHKvVZZAlcmcuRpn9o3DOU4e3NlMi8pZwHrJLSJqZ9lS5w9fsAj0myawuNwD2
         K/1cdkwiaf1zIL6z06E0x461CqQa2b/yBFlcFg7ZWBjb+vqgxjaFv4bfv9SNZGnl6Jiu
         xMJnr2hKLcieUK0mGfFnOazAtrIuUT5d200JNVCuZWQ6Dz/XLJWs1kKXTjMetxUh+V1d
         83WA==
X-Gm-Message-State: AOAM532Kr6boyIRNj66oRPWC996pVDbPnmqshOW2ehHbFU0KCZeJWpLp
        U9uxRxbRtqoND/Uvb4eVK2nn4GsJuwVLolfb8/dXg/f1U+LhuT1iqonwug7fWbPR/DfNyGmRHfl
        Ga0zmqOcOySwF8UC6c1w=
X-Received: by 2002:a05:6402:31ba:: with SMTP id dj26mr5123211edb.71.1624024403732;
        Fri, 18 Jun 2021 06:53:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTsF/0Cs/2BceDIqNAQD06Z7C0XH4tntVdthlt9jCkRfrIbPEznJ7emZ4sC946B20lOowpNw==
X-Received: by 2002:a05:6402:31ba:: with SMTP id dj26mr5123196edb.71.1624024403599;
        Fri, 18 Jun 2021 06:53:23 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id de6sm780838edb.77.2021.06.18.06.53.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 06:53:23 -0700 (PDT)
Subject: Re: AW: [PATCH] power: supply: axp288_fuel_gauge: remove redundant
 continue statement
To:     Walter Harms <wharms@bfs.de>,
        Colin King <colin.king@canonical.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210618092924.99722-1-colin.king@canonical.com>
 <5d5dad5246f442e5aa96bdc50ac4b1f1@bfs.de>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <bac7f313-6696-7973-4261-27bf59055425@redhat.com>
Date:   Fri, 18 Jun 2021 15:53:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <5d5dad5246f442e5aa96bdc50ac4b1f1@bfs.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 6/18/21 1:19 PM, Walter Harms wrote:
> Just a remark:
> the function fuel_gauge_reg_readb() is reporting via dev_err().
> But some callers are reporting also. Maybe someone should take
> a look.
> The valid return seems >=0 so removing the dev_err seems an option.

Actually the whole register reading code in this driver needs to
be reworked.

The AXP288 PMIC also controls voltage-planes which are used by
the CPU-cores and the i915 GPU which are part of the Intel SoCs
with which this PMIC is used.

This means that the PMU of the SoC needs to also talk to it
over the same I2C bus when CPU-cores / the GPU changes C-states
or ramp up/down their frequency.

To avoid conflicts there is a special handshake with both the
PMU itself (taking something resembling a mutex by a hw-handshake)
as well as with the i915 driver. This handshake is hidden inside
the i2c-adapter driver, so you don't see it in the code here.
This handshake is also the whole reason why the regmap_read may
return -EBUSY.

This handshake is quite expensive and currently it is done for
every single regmap_read (the handshake is many times as
expensive as the actual I2C read) and updating the fuel-gauge
status does quite a lot of reads.

A while ago I changed the underlying code so that AXP288
drivers can acquire access to the bus once; then do a bunch
of regmap accesses and then release the bus again.

A user who was having some stability issues has been working
(offlist) on a patch to use a register cache which gets updated
periodically (like how many hwmon drivers work) and then have
all the psy property accesses come from the cache. This allows
acquiring the bus once; do all the reads to fill the cache;
and then release it again.  I need to review his code; but
I've not gotten around to that yet (I really need to make
time for this).

Once we switch to this register-cache approach, then the whole
fuel_gauge_reg_readb() wrapper can go away since then we no
longer need to worry about EBUSY errors (once we have acquired
the bus these cannot happen).

TL;DR: you are right that there are some cleanups possible here,
but the entire thing is going to be rewritten soon, so it is
probably best to just leave it as is for now.

Regards,

Hans












> 
> jm2c,
>  re,
>  wh
> ________________________________________
> Von: Colin King <colin.king@canonical.com>
> Gesendet: Freitag, 18. Juni 2021 11:29:24
> An: Sebastian Reichel; Hans de Goede; Chen-Yu Tsai; linux-pm@vger.kernel.org
> Cc: kernel-janitors@vger.kernel.org; linux-kernel@vger.kernel.org
> Betreff: [PATCH] power: supply: axp288_fuel_gauge: remove redundant continue statement
> 
> WARNUNG: Diese E-Mail kam von außerhalb der Organisation. Klicken Sie nicht auf Links oder öffnen Sie keine Anhänge, es sei denn, Sie kennen den/die Absender*in und wissen, dass der Inhalt sicher ist.
> 
> 
> From: Colin Ian King <colin.king@canonical.com>
> 
> The continue statement at the end of a for-loop has no effect,
> invert the if expression and remove the continue.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/power/supply/axp288_fuel_gauge.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
> index 39e16ecb7638..20e63609ab47 100644
> --- a/drivers/power/supply/axp288_fuel_gauge.c
> +++ b/drivers/power/supply/axp288_fuel_gauge.c
> @@ -142,9 +142,7 @@ static int fuel_gauge_reg_readb(struct axp288_fg_info *info, int reg)
> 
>         for (i = 0; i < NR_RETRY_CNT; i++) {
>                 ret = regmap_read(info->regmap, reg, &val);
> -               if (ret == -EBUSY)
> -                       continue;
> -               else
> +               if (ret != -EBUSY)
>                         break;
>         }
> 
> --
> 2.31.1
> 

