Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98E6651F1B
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2019 01:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbfFXXZY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Jun 2019 19:25:24 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:32799 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbfFXXZY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jun 2019 19:25:24 -0400
Received: by mail-qk1-f195.google.com with SMTP id r6so11176669qkc.0
        for <linux-pm@vger.kernel.org>; Mon, 24 Jun 2019 16:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=0K4AayEvyC8tuCGamcfvuz4SEF7qHpfHWbMwtIK1ew8=;
        b=f+Aol/jhJxqWROn5hqlq8RfXeWDsFcZsHuHyt/f0ovQScbmkgV87LzypsaJ/bCsUep
         a7rWko5WL0RF/N0QGAAnq8I2CCm2bzHNj8R2MUS7HUwV99mya1ijH4Vb7P7RkasT/Fe4
         pQeSdvsYiuAJ91Tgj9FUFzi/YTM2RDrwoLeds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=0K4AayEvyC8tuCGamcfvuz4SEF7qHpfHWbMwtIK1ew8=;
        b=AOfU1Eim8nVgaVlpdjLC/c0f6weHhAl8YlAo8BfPiqYqBNJKifHkodm6Z2+mV2Zb91
         ezZ7wAO/iQsvJwpiLWgG+kzRW9yIvoWzUK8es4cRylfnbZFrdYyZz/9H1WF3w6mnqs8D
         g9c0JviQ0J3mMYbxoxAOF/xNY2Oa1MzCD76X8Mba/DFKGie4DrXvBOZE3MUz0R+lXBXC
         /eJjgJ78pMMAGkSeugybKONzFOn+wYeBAYM3eY0urUBKLLq/rVKtXSHEwAW0Cjv60uIi
         MRlctMA1wm5+fZ18xwoKeyN3x+8UTwZ4YiMQzChFJcVUaPH9HTnjpRUKK1pqth74fjcm
         PbnA==
X-Gm-Message-State: APjAAAX2Bz1TiNzWdj0emLvbI+Xg0Mxx49j7PHB1bdGx9WpnLIh1stiy
        iYyupsYkusFHe60ss0aQNRCme3/oBFgsB7SW9uNh8A==
X-Google-Smtp-Source: APXvYqygGP9QddTsQ0SFt8FpF9IKYbLSjITz3B58ECyT4vbLUFXLY9PLq33WblBJcqEp7qon9vDoHmgOFMfGw4gMijY=
X-Received: by 2002:a37:9307:: with SMTP id v7mr19255465qkd.495.1561418722995;
 Mon, 24 Jun 2019 16:25:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190619175142.237794-1-ravisadineni@chromium.org>
In-Reply-To: <20190619175142.237794-1-ravisadineni@chromium.org>
From:   Ravi Chandra Sadineni <ravisadineni@chromium.org>
Date:   Mon, 24 Jun 2019 16:25:12 -0700
Message-ID: <CAEZbON4e1=w6G4KEqq2qP0nTD4z00fcqHErWTBVGFGb17f=+1Q@mail.gmail.com>
Subject: Re: [PATCH] power: Do not clear events_check_enabled in pm_wakeup_pending()
To:     rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz,
        gregkh@linuxfoundation.org, linux-pm@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Todd Broch <tbroch@google.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

Just wanted to check if this is o.k.

Thanks,
Ravi

On Wed, Jun 19, 2019 at 10:52 AM Ravi Chandra Sadineni
<ravisadineni@chromium.org> wrote:
>
> events_check_enabled bool is set when wakeup_count sysfs attribute
> is written. User level daemon is expected to write this attribute
> just before suspend.
>
> When this boolean is set, calls to pm_wakeup_event() will result in
> increment of per device and global wakeup count that helps in
> identifying the wake source. global wakeup count is also used by
> pm_wakeup_pending() to identify if there are any pending events that
> should result in an suspend abort.
>
> Currently calls to pm_wakeup_pending() also clears events_check_enabled.
> This can be a problem when there are multiple wake events or when the
> suspend is aborted due to an interrupt on a shared interrupt line.
> For example an Mfd device can create several platform devices which
> might fetch the state on resume in the driver resume method and increment
> the wakeup count if needed. But if events_check_enabled is cleared before
> resume methods get to execute, wakeup count will not be incremented. Thus
> let us not reset the bool here.
>
> Note that events_check_enabled is also cleared in suspend.c/enter_state()
> on every resume at the end.
>
> Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
> ---
>  drivers/base/power/wakeup.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index 5b2b6a05a4f3..88aade871589 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -838,7 +838,6 @@ bool pm_wakeup_pending(void)
>
>                 split_counters(&cnt, &inpr);
>                 ret = (cnt != saved_count || inpr > 0);
> -               events_check_enabled = !ret;
>         }
>         raw_spin_unlock_irqrestore(&events_lock, flags);
>
> --
> 2.20.1
>
