Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B63422B72
	for <lists+linux-pm@lfdr.de>; Tue,  5 Oct 2021 16:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235166AbhJEOtg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Oct 2021 10:49:36 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:38544 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbhJEOtf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Oct 2021 10:49:35 -0400
Received: by mail-ot1-f50.google.com with SMTP id c6-20020a9d2786000000b005471981d559so26105379otb.5;
        Tue, 05 Oct 2021 07:47:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4nYP50RnEwXOBEfqaBjPyWNKlAUJcU1dr1Q7oO/S2m4=;
        b=6bzBM3mZybrPvXlIH97vjaaG4YqL6+gSmmOlug7pl0dng4NkQ20D11LXxXd3S46dIS
         /YOiqRzeclOT7QzMBs0fbcbhq2KbMGHuBEPIhRpCndBOH9reR8CCjDa8vMOwGnf3M7uh
         DxgcBSkHCA86Dt8YqAL56JD6WGz5SHZ7zrceRCgtaHxTRch+QEMDbDVcmsyel7bkv91J
         9lNLzWXdIgWgRrr7yX8C5tki5y2aHZK4g9Po+c5GQE/QMVNQOhYlYmirsbc0HfH8o06z
         9aA5yEuFA76dvbnsy0ASWj2y1nQcceRX5uv6bK5SiVRsPFfk3y2xZsP/l78TuIjeTDae
         C8Ug==
X-Gm-Message-State: AOAM531JszNBeZLHEINdUXutv4vPKTh8PP5cOWt4Cp9Va0agfnUK1b4O
        Gl6LaqjbB1g69N+fwaes7vwmwq7JOSwlBRxToEY=
X-Google-Smtp-Source: ABdhPJyo1TtZkR9LWtCpd4ymU8HXD06ALO7VmmnTz/q8hRWsq/HXWKw2OUPmKpBCp6BMulu0BuAWTNZP+EFvBXdNvcs=
X-Received: by 2002:a05:6830:2784:: with SMTP id x4mr14795102otu.86.1633445264743;
 Tue, 05 Oct 2021 07:47:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210930122803.GC10068@kili>
In-Reply-To: <20210930122803.GC10068@kili>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 5 Oct 2021 16:47:33 +0200
Message-ID: <CAJZ5v0j3-o9L6q3YZFszSCKU3=yvoEWE7cbhahq1qSxu+z553w@mail.gmail.com>
Subject: Re: [PATCH] thermal: int340x: delete bogus length check
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Zhang Rui <rui.zhang@intel.com>, Takashi Iwai <tiwai@suse.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 30, 2021 at 2:28 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> This check has a signedness bug and does not work.  If "length" is
> larger than "PAGE_SIZE" then "PAGE_SIZE - length" is not negative
> but instead it is a large unsigned value.  Fortunately, Takashi Iwai
> changed this code to use scnprint() instead of snprintf() so now
> "length" is never larger than "PAGE_SIZE - 1" and the check can be
> removed.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> index 19926beeb3b7..8502b7d8df89 100644
> --- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> +++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> @@ -129,11 +129,10 @@ static ssize_t available_uuids_show(struct device *dev,
>
>         for (i = 0; i < INT3400_THERMAL_MAXIMUM_UUID; i++) {
>                 if (priv->uuid_bitmap & (1 << i))
> -                       if (PAGE_SIZE - length > 0)
> -                               length += scnprintf(&buf[length],
> -                                                  PAGE_SIZE - length,
> -                                                  "%s\n",
> -                                                  int3400_thermal_uuids[i]);
> +                       length += scnprintf(&buf[length],
> +                                           PAGE_SIZE - length,
> +                                           "%s\n",
> +                                           int3400_thermal_uuids[i]);
>         }
>
>         return length;
> --

Applied as 5.16 material, thanks!
