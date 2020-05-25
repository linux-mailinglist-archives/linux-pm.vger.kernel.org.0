Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C9D1E096E
	for <lists+linux-pm@lfdr.de>; Mon, 25 May 2020 10:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388657AbgEYI6y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 May 2020 04:58:54 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34110 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388437AbgEYI6y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 May 2020 04:58:54 -0400
Received: by mail-ot1-f67.google.com with SMTP id b18so13355436oti.1
        for <linux-pm@vger.kernel.org>; Mon, 25 May 2020 01:58:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kmOBLaV9HWFah/NGfLV9Jv/IzFjJEqCGRLY6DJeUv6U=;
        b=Nb+hBWjoB253Qc4iHqhVAgksPAtzSro607XADuj0LiikSFr+r2cm2PRAa4UPN+dxfg
         pxAddhxZoUlWfB3A5jcBikB2BWesesS8R583/jxcDJ/D0RKMRtV+fVtwDhlPqMxMWFYF
         YFy+/aYo8Wpjw/5B66kVlbm82AaHzK5GSDrqS+vDMb3+puh4ABmosCqfHJ7DNGZb+r93
         tGVjBxTEE2OAwoY1YL4VJupgjt7gRkbRM3cP8B+VoKEDRB+rTbmM/DCi2jyEZWQv4ceS
         IS7EuOd6SomOiayqGjkWunlPfTWUx0yoL/9rZP2wrnTmIPZmxHlAaOZXgSrVDjcHh9x4
         k8oQ==
X-Gm-Message-State: AOAM531AFboaP8Ye1m2DuV0wCHVnfHfpYcy3+SYiZXWSh5DUyFmmZ03o
        ummeXoZJyassQcDHAP/kH79FM+YdpOXsoqSAvQBmbQ==
X-Google-Smtp-Source: ABdhPJzXRvbL3UysoOL/C0408cUZZng4+P9C0rNTNZJ46n5h7sId2icjILRhlay4BooiEW0iwdt66WUu75M2Et4zezA=
X-Received: by 2002:a9d:3d05:: with SMTP id a5mr20377546otc.262.1590397132171;
 Mon, 25 May 2020 01:58:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200522150955.40569-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20200522150955.40569-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 25 May 2020 10:58:35 +0200
Message-ID: <CAJZ5v0j6-hw2KxSpLPNONOtiyU0-HOR=s8UDpbm1xOr6kKAqqA@mail.gmail.com>
Subject: Re: [PATCH v1] PM-runtime: Make clear what we do when conditions are
 wrong in rpm_suspend()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 22, 2020 at 5:10 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> rpm_suspend() simple bails out when conditions are wrong. But this is not
> immediately obvious from the code.  Make it clear what we do when conditions
> are wrong in rpm_suspend().
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/base/power/runtime.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 99c7da112c95..9f62790f644c 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -523,13 +523,11 @@ static int rpm_suspend(struct device *dev, int rpmflags)
>
>   repeat:
>         retval = rpm_check_suspend_allowed(dev);
> -
>         if (retval < 0)
> -               ;       /* Conditions are wrong. */
> +               goto out;       /* Conditions are wrong. */
>
>         /* Synchronous suspends are not allowed in the RPM_RESUMING state. */
> -       else if (dev->power.runtime_status == RPM_RESUMING &&
> -           !(rpmflags & RPM_ASYNC))
> +       if (dev->power.runtime_status == RPM_RESUMING && !(rpmflags & RPM_ASYNC))
>                 retval = -EAGAIN;
>         if (retval)
>                 goto out;
> --

Applied as 5.8 material, thanks!
