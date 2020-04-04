Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10F6619E348
	for <lists+linux-pm@lfdr.de>; Sat,  4 Apr 2020 09:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgDDHbD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 4 Apr 2020 03:31:03 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:43156 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgDDHbD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 4 Apr 2020 03:31:03 -0400
Received: by mail-vs1-f68.google.com with SMTP id w185so6460804vsw.10
        for <linux-pm@vger.kernel.org>; Sat, 04 Apr 2020 00:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J+hFFTj54X+dnGLSJAQeLYPL3M77XkjKUzoz85gYbcc=;
        b=W5l3m915mdUEF+QTl2zp5yRyUKce6jM87djRxO61GJvftQpKX913IH6irpyEW3vjWS
         aoJ74HTDM5wHmJc1Ma+iPzFwIZOukAqxaZuvmwVBrJNp48lcRfPDwVSa9X1Q21W304Qd
         cQyEYq73wnnrVPdxQKQdypk+J9xuqsRFRq4jiGBuX3JV5VLQqscYAjO5CIhd2QpYKeg8
         ucXeqxti4ZpwQIRdl5WsT7wAE3iyMCWBT7I3jHnfRCfBGVJzv6x5TpSdEoWKSrdjyxdG
         f1spuqj+Bi+5vaowZYujt3kJGE1qlJV5ermVTGj+U0Ek8M+nE+D+dkCSLgQ+wctRmDko
         RHyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J+hFFTj54X+dnGLSJAQeLYPL3M77XkjKUzoz85gYbcc=;
        b=qhWEAjvAIT19QW7D9DmxITdhp65fOne0FJ/XS8RRktJExF99at28eTIM4oDBoNsEhs
         VqhTgdWum6UAVHUguIXziZui6fggz6myJRvCN+PfZQ4h7ok82RPg9pb8PivYOdP745mo
         aWjvlKqMkjefVrgvfrzFYvJyI9nEqzvtmO4odPsmtf6DiyEem74+tguVpwa0I70aM9qy
         j47rwynbO26skDZnVd1a8HTi5ElyBp2F1rSVFJKtyvlftbfGYTAXOlIFoSqaHzZrKdMn
         JykoU05dv1MvZlmBLLnbDprnDPEbOViH+/Iqi2bL1NVG4unG+Axvz54jbMwaoZMA6RQ/
         z8BQ==
X-Gm-Message-State: AGi0PubgPKNz/3qFt8CtsHSxImu4wxvpjJ56B5lpvVwPyuEb7P//YZgm
        bizE0Iz5QLgeM4X/0VQvcVQyldxBtth6Xy4UFsRrXw==
X-Google-Smtp-Source: APiQypKwCsok3pKZtYpKavnkMIyWFzjwvX+VhO/uzmDeq/p7hWUxGf25hzJLEtTfwGsf8hHS+ICVZnSZCzssbXJVdr8=
X-Received: by 2002:a05:6102:5c5:: with SMTP id v5mr9239819vsf.9.1585985460949;
 Sat, 04 Apr 2020 00:31:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200402142747.8307-1-daniel.lezcano@linaro.org> <20200402142747.8307-7-daniel.lezcano@linaro.org>
In-Reply-To: <20200402142747.8307-7-daniel.lezcano@linaro.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Sat, 4 Apr 2020 13:00:00 +0530
Message-ID: <CAHLCerNrAgOSO3DiFAr3rvD3Ar7N4SP7dLeURGNae7oqpzzEKA@mail.gmail.com>
Subject: Re: [PATCH V2 7/9] thermal: Change IS_ENABLED to IFDEF in the header file
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 2, 2020 at 7:58 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> The thermal framework can not be compiled as a module. The IS_ENABLED
> macro is useless here and can be replaced by an ifdef.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  include/linux/thermal.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 47e745c5dfca..12df9ff0182d 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -383,7 +383,7 @@ void devm_thermal_zone_of_sensor_unregister(struct device *dev,
>
>  #endif
>
> -#if IS_ENABLED(CONFIG_THERMAL)
> +#ifdef CONFIG_THERMAL
>  struct thermal_zone_device *thermal_zone_device_register(const char *, int, int,
>                 void *, struct thermal_zone_device_ops *,
>                 struct thermal_zone_params *, int, int);
> --
> 2.17.1
>
