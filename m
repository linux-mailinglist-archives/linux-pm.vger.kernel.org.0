Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB2249D1A5
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jan 2022 19:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237448AbiAZSXG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Jan 2022 13:23:06 -0500
Received: from mail-yb1-f174.google.com ([209.85.219.174]:45684 "EHLO
        mail-yb1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237412AbiAZSXE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jan 2022 13:23:04 -0500
Received: by mail-yb1-f174.google.com with SMTP id h14so1234909ybe.12
        for <linux-pm@vger.kernel.org>; Wed, 26 Jan 2022 10:23:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PU3C1m+MTHZdSFLfo8q1etcFcCM/mNJ2l0QPbTq/BMs=;
        b=VV4hdpHq6ORuEJKuhWHDTEVEkSmRWanEYVWO7RNJkN1ni5r9maNgHdvsEFuruYPGLt
         r70CjBo3GpkM+3sOCU9p+ft3FX+GoT2Jzv7qYyr19iyA/XWJkUTzXyW2Tq0ukhGBXefQ
         7JLIMi3jn41FxElqHiRb/WFwZ5CBCWLtZzTgk03nTQTYB+BSZMX5eZDhM2iSjwYVsZ65
         EKXxKim6wVcvFaxFCzRPV7u2Yn0BMPAN/Jn/uNUI967M9F1WzIMEe8WWPeDrlhcp34bM
         /zEzLO/4omeBC87tv2PeG6bDt3LxawYgq9WcHyNDCKwy4Xf3AipBzRTkrNwX4Bt0NenY
         ivHw==
X-Gm-Message-State: AOAM531bcaYlKZ+xdfw1Mi5n4mkdZaXYH8vLNkKW60v5cD7elodguVpK
        M1KqmU9ZDWlIDa5v/BeN5Z0J84kCpjnimd2gf8g=
X-Google-Smtp-Source: ABdhPJybEUj9a+XCyYL/sozStPtwRO8dzRiglqCtF05P0e+F35o0LBQeRMPwLQprvwUI/FXCgObgiIo+OhBiNApTArw=
X-Received: by 2002:a25:34c4:: with SMTP id b187mr320234yba.78.1643221383636;
 Wed, 26 Jan 2022 10:23:03 -0800 (PST)
MIME-Version: 1.0
References: <1643016384-11161-1-git-send-email-loic.poulain@linaro.org>
In-Reply-To: <1643016384-11161-1-git-send-email-loic.poulain@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 26 Jan 2022 19:22:52 +0100
Message-ID: <CAJZ5v0hJzZpLv69coibEApT9zOxZ43mmOixNo5TZtizbUCFSTA@mail.gmail.com>
Subject: Re: [RESEND PATCH] PM: wakeup: Wakeup accounting for interrupts
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jan 24, 2022 at 10:14 AM Loic Poulain <loic.poulain@linaro.org> wrote:
>
> Most of the time, system wakeup is caused by a wakeup-enabled
> interrupt, but the accounting is not done for the related wakeup
> source, causing 'wrong' values reported by device's wakeup attributes
> and debugfs stats (debug/wakeup_sources).
>
> This change reports a wakeup event for any wakeup-sources the irq is
> attached with.
>
> Note: This only works for drivers explicitly attaching the irq to
> a given device (e.g. with dev_pm_set_wake_irq).
>
> Note2: Some drivers call pm_wakeup_event() in their irq handler, but
> not all, moreover, an interrupt can be disabled while being flagged
> as wakeup source, and so accounting must be performed. This solution
> ensures that accounting will always be done for the interrupt waking
> up the host.
>
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> ---
>  drivers/base/power/wakeup.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index 99bda0da..2d75e057 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -952,8 +952,19 @@ void pm_wakeup_clear(bool reset)
>  void pm_system_irq_wakeup(unsigned int irq_number)
>  {
>         if (pm_wakeup_irq == 0) {
> +               struct wakeup_source *ws;
> +               int srcuidx;
> +
>                 pm_wakeup_irq = irq_number;
>                 pm_system_wakeup();
> +
> +               /* wakeup accounting */
> +               srcuidx = srcu_read_lock(&wakeup_srcu);

This is called from interrupt context, so srcu_read_lock() cannot be used here.

> +               list_for_each_entry_rcu(ws, &wakeup_sources, entry) {
> +                       if (ws->wakeirq && ws->wakeirq->irq == irq_number)
> +                               pm_wakeup_ws_event(ws, 0, false);
> +               }
> +               srcu_read_unlock(&wakeup_srcu, srcuidx);
>         }
>  }
>
> --
> 2.7.4
>
