Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A76F711679C
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2019 08:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbfLIHl5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Dec 2019 02:41:57 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:46009 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbfLIHl5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Dec 2019 02:41:57 -0500
Received: by mail-vs1-f66.google.com with SMTP id l24so9556477vsr.12
        for <linux-pm@vger.kernel.org>; Sun, 08 Dec 2019 23:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8x9z5IK3e1jLIYvYQLpPPPTrSa/xPbdbpcJwZ5RslgE=;
        b=pmn0xhN6Tb+kX0BCG0uXmcoqG1PzozNOPt10tuMFI22HOYdzAzYOdKDB/plA1snGDK
         Otsn3JiTjkyuuaBE0ZVIToFtEJRshz9dFzG8Chharzz8YaItxWj/H81zLPoCk/q4Na23
         paro+DokcNAtGu+4c6AJk4PUpR8Y0/MCdxV33fFY4CNzPjECPhnt1CyP/uPvFw7zw61D
         LaY7MKYg41sBBXBYtj7dBgMw1K7/uLnI5TaoO1LLNSiMYJdTBEFwE2KD0CgIEE1+bxbc
         SKDlhEgDaM8dlQf4fx2ZTaG4vhOMmQHDgJDeeDOZqzt5nOsSc5hoRtMXybBJEuGeWjV2
         2uwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8x9z5IK3e1jLIYvYQLpPPPTrSa/xPbdbpcJwZ5RslgE=;
        b=Vr4C3RQYFPEmzZA/VLNMuGEy5WchsLOPolxwzMrAZGTOS0UEyE+XrZ8xPCq4EIVvc/
         gP8RAEw/xGeFOzpTCIzu5A2uoFKRN+X7O43Tz7fXacRUi1TiDHNIPNtCIetSDGhqtrcv
         xHFBjASpEPl/Y1arNEg+CdcP66hIYG26eV1nawGzyBZ6PPUo+qQbv1TGtOBdBZnHpEW3
         KhLwo+KkZLy3dPASYtpwu3PjsswSyHScW0d7QsLgEuS1dW9OzI1IFdF6yy9kpAQSgwJj
         EaRmIArPBjSwwrgMaGjgrpUN2SU5rBQo2e0sYzg1dunx/JyljMMI3/83qNE5EFVIA03P
         QSDw==
X-Gm-Message-State: APjAAAWPH4lxAQjTE6MsdKZRw7DJ+nfMbA6LhWNtFoI1EO/f6aiX5Ze1
        sqbrrUqOtEsMajSjBxDLX2YCt8kcCFPMufcWJEt9tA==
X-Google-Smtp-Source: APXvYqzibvLQiYU/9XhXADboJGPQVfHnCc7v9B8G307Ku9so1UCHwb95zqnPu46yFD9lgRFp7QQvnrT7eW3mPNMga3w=
X-Received: by 2002:a67:fb41:: with SMTP id e1mr12561823vsr.159.1575877316661;
 Sun, 08 Dec 2019 23:41:56 -0800 (PST)
MIME-Version: 1.0
References: <20191205071953.121511-1-wvw@google.com> <20191205071953.121511-3-wvw@google.com>
In-Reply-To: <20191205071953.121511-3-wvw@google.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Mon, 9 Dec 2019 13:11:45 +0530
Message-ID: <CAHLCerOWxjG2nhyQFDy8=xXWhupL=7=juAzzTvnbAeutF=pU=g@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] thermal: improve error message in thermal zone registration
To:     Wei Wang <wvw@google.com>
Cc:     Wei Wang <wei.vince.wang@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Dec 5, 2019 at 12:50 PM Wei Wang <wvw@google.com> wrote:
>
> Follow up with commit 67eed44b8a8a ("thermal: Add some error messages")
> to clean up checkpatch warning on line length and also add more message
> for developers.
>
> Signed-off-by: Wei Wang <wvw@google.com>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  drivers/thermal/thermal_core.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 974e2d91c30b..9db7f72e70f8 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1255,29 +1255,33 @@ thermal_zone_device_register(const char *type, int trips, int mask,
>         int count;
>         struct thermal_governor *governor;
>
> -       if (!type || strlen(type) == 0) {
> +       if (!type || !type[0]) {
>                 pr_err("Error: No thermal zone type defined\n");
>                 return ERR_PTR(-EINVAL);
>         }
>
> -       if (type && strlen(type) >= THERMAL_NAME_LENGTH) {
> -               pr_err("Error: Thermal zone name (%s) too long, should be under %d chars\n",
> -                      type, THERMAL_NAME_LENGTH);
> +       if (strlen(type) >= THERMAL_NAME_LENGTH) {
> +               pr_err("Error: Thermal zone name over %d chars: %s\n",
> +                       THERMAL_NAME_LENGTH, type);
>                 return ERR_PTR(-EINVAL);
>         }
>
>         if (trips > THERMAL_MAX_TRIPS || trips < 0 || mask >> trips) {
> -               pr_err("Error: Incorrect number of thermal trips\n");
> +               pr_err("Error: Incorrect number of thermal trips: %s\n", type);
>                 return ERR_PTR(-EINVAL);
>         }
>
>         if (!ops) {
> -               pr_err("Error: Thermal zone device ops not defined\n");
> +               pr_err("Error: Thermal zone device ops not defined: %s\n",
> +                       type);
>                 return ERR_PTR(-EINVAL);
>         }
>
> -       if (trips > 0 && (!ops->get_trip_type || !ops->get_trip_temp))
> +       if (trips > 0 && (!ops->get_trip_type || !ops->get_trip_temp)) {
> +               pr_err("Error: Thermal zone device missing callback: %s\n",
> +                       type);
>                 return ERR_PTR(-EINVAL);
> +       }
>
>         tz = kzalloc(sizeof(*tz), GFP_KERNEL);
>         if (!tz)
> --
> 2.24.0.393.g34dc348eaf-goog
>
