Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 993C1296017
	for <lists+linux-pm@lfdr.de>; Thu, 22 Oct 2020 15:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900176AbgJVNfi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Oct 2020 09:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2900175AbgJVNfi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Oct 2020 09:35:38 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD01C0613CE;
        Thu, 22 Oct 2020 06:35:38 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id j18so1157885pfa.0;
        Thu, 22 Oct 2020 06:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9gfZHvr4tYCEuJzv16muggEgqQv0baFD2IqnGr4EwZE=;
        b=Sy0WHXYE5EAqZEmVVi5mWCPjNa8APLF6OWMK3Pd5LvlLKQoQr1NDz/TMM7+T2JnrYe
         PMQWPmkA1Oub1cwaXYdaPUrCmprM0pbPKvmllNlpVbecMLZfZcc/j6Yv0B0ldA8wCZR5
         YRzbw3DYjsQF1TWUi5XwUGaSEMpJLi5En5dLy3dHow1Fh+fnZTSXz/UTeoAoQZA0Hc+5
         TpHcSn/7D8ZsJK2Fs1DXCnU0AVjdeNy31xZWkagtABiGhVZDt/1KS3HOEShLUq5gMrwE
         qN0weaeM/hNqpKMOrQYZac43KqEAdT/Ua97xyxqwsJJ+1UFq5jrdadcUN1WNhKFv7ssA
         6LEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9gfZHvr4tYCEuJzv16muggEgqQv0baFD2IqnGr4EwZE=;
        b=hVeBPUafC0j91JsAfLylr9P1MHRDPUF2b9Qr5SGyWok5m4/1JduJzP2gjJ8akNttaR
         sewrIHhXF7wZ6IRE03w4huoqxfZiILkhU+HbkyHq9O/brxOLjFGXZkDFiKTzesRdSqJg
         6I1+hI8S6TNU/jMrW2NMxrqYmYjDwUN+5kR5zcwBLHL1n0CUw65Q1VDWjvfmlXHHNy/H
         3KFxPrZpB829vHb3wXithw+9airPn7Nr0hVm94eKJR+Kc8lhDIXfW6MXgIAQjjepkcoF
         b8I7mbk3KAJQbvzr64n1afQ3uIxvKTFaDFh5jwAcZrWNS36MkCoKyILRP4e2p5ni2lBN
         srtA==
X-Gm-Message-State: AOAM532gk37P2fPJxrKSzNfPlA5EifpgI5Fz+rMwYeIhl8LZGNc/uog1
        sH/YK/ryb+OA2pAOHzOH/M1SlsPAr8+aNITk/1U=
X-Google-Smtp-Source: ABdhPJzNJFtrmbGl1XLXoavPUiPLSJnIh7S6Oj3BXAYLaSAMDXn4m24EIX0C+YYpbPk+/3F05pCLzx0hd71aoK+/E3U=
X-Received: by 2002:a63:f908:: with SMTP id h8mr2330629pgi.203.1603373736383;
 Thu, 22 Oct 2020 06:35:36 -0700 (PDT)
MIME-Version: 1.0
References: <20201022085244.1860-1-yu.c.chen@intel.com>
In-Reply-To: <20201022085244.1860-1-yu.c.chen@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 22 Oct 2020 16:36:25 +0300
Message-ID: <CAHp75Vf52m78FNKgTQ8c_y6UNaR91ANZh296tg6nz+reEv0DEg@mail.gmail.com>
Subject: Re: [PATCH][v2] PM / sysfs: Expose suspend resume driver flags in sysfs
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 22, 2020 at 12:24 PM Chen Yu <yu.c.chen@intel.com> wrote:
>
> Currently there are 4 driver flags to control system suspend/resume
> behavior: DPM_FLAG_NO_DIRECT_COMPLETE, DPM_FLAG_SMART_PREPARE,
> DPM_FLAG_SMART_SUSPEND and DPM_FLAG_MAY_SKIP_RESUME. Make these flags
> visible in sysfs as read-only to get a brief understanding of the
> expected behavior of each device during suspend/resume, so as to
> facilitate suspend/resume debugging/tuning.
>
> For example:
> /sys/devices/pci0000:00/0000:00:15.1/power/driver_flags:4
> (DPM_FLAG_SMART_SUSPEND)
>
> /sys/devices/pci0000:00/0000:00:07.3/power/driver_flags:5
> (DPM_FLAG_NO_DIRECT_COMPLETE | DPM_FLAG_SMART_SUSPEND)

...

> +What:          /sys/devices/.../power/driver_flags
> +Date:          October 2020
> +Contact:       Chen Yu <yu.c.chen@intel.com>
> +Description:
> +               The /sys/devices/.../driver_flags attribute contains the driver
> +               flags to control system suspend/resume. The flag is a combination
> +               of DPM_FLAG_NO_DIRECT_COMPLETE, DPM_FLAG_SMART_PREPARE,
> +               DPM_FLAG_SMART_SUSPEND and DPM_FLAG_MAY_SKIP_RESUME, or 0 if the
> +               driver has not set any flag.

> This attribute is read-only. If
> +               CONFIG_PM_ADVANCED_DEBUG is not set this attribute is empty.

Which makes me wonder why we even expose this if the above is not set.

...

> +static struct attribute *pm_driver_flags_attrs[] = {
> +#ifdef CONFIG_PM_ADVANCED_DEBUG
> +#ifdef CONFIG_PM_SLEEP
> +       &dev_attr_driver_flags.attr,
> +#endif
> +#endif

> +       NULL,

No comma here, please. I think I commented on this internally.

> +};

-- 
With Best Regards,
Andy Shevchenko
