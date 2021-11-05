Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B74B446676
	for <lists+linux-pm@lfdr.de>; Fri,  5 Nov 2021 16:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbhKEPxo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Nov 2021 11:53:44 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:39793 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbhKEPxW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Nov 2021 11:53:22 -0400
Received: by mail-ot1-f48.google.com with SMTP id c26-20020a9d615a000000b0055bf6efab46so5429013otk.6
        for <linux-pm@vger.kernel.org>; Fri, 05 Nov 2021 08:50:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bWLHiHChLTS6gNfP4+9qXbhSniLpig/BpiUxDwIYKZ8=;
        b=CnNkfmwefeJPzx2vC2sG3dGOkgvh0RZUp7YBb7Yv5AGaGL9epBTaN+ZkOEz7yoMtC8
         jQMEEBjiT3lMSJwnsalKAdxn8JmbSW6J2GR3OupO+GgxZOcKqbXL9J981+Jw91xLTboO
         Kmo0ILk1i2W7uDfcVnXjfGl6BqNwvuBjiD3c0ofKn1kGt7W6g47VRUG0YpwT2n8lWZWc
         BPAo9CvvTWK+F8C/fDpjRtuQQafXNt3yRw2PE+jiAS7AcMC20Umm2Qac8UkxmRj2lJar
         Ss0/0FpAk6I7Hc9rPgQ4oNZ2T6npiSR/kLzGl278ZvbayxNSptPDuv5uPWLSnRvCl3sT
         lKEA==
X-Gm-Message-State: AOAM530b7ONuiXhU5iaGpyE7FZcpjGuRQ4HyHsfiCxWSf4Een2yvqcMN
        fzn9Nfv9y/7V96Zm+ICdU1bufGN+ptFrFp9Xw2d5CiLcUzU=
X-Google-Smtp-Source: ABdhPJwcNjjcQPVb+xe5zGas2SiAo3SFS7kYEft0ylkpv0Alnm8hio269RGkXtDDJGNHFcWNnZU3WELYNzm7NUnTJKI=
X-Received: by 2002:a9d:a64:: with SMTP id 91mr38559775otg.198.1636127439805;
 Fri, 05 Nov 2021 08:50:39 -0700 (PDT)
MIME-Version: 1.0
References: <1635766618-24732-1-git-send-email-youquan.song@intel.com>
In-Reply-To: <1635766618-24732-1-git-send-email-youquan.song@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 5 Nov 2021 16:50:29 +0100
Message-ID: <CAJZ5v0jJ+tthguYtq81EbapZAxLkUkz=B=quDWcMzHQFcWAnrA@mail.gmail.com>
Subject: Re: [PATCH] PM/QoS: resume latency 0 should be not latency allowed
To:     Youquan Song <youquan.song@intel.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Nov 1, 2021 at 1:50 PM Youquan Song <youquan.song@intel.com> wrote:
>
> ICX and more recent Intel CPU has C1 exit_latency equal 1 in intel_idle

Please expand "ICX".

> driver, There are PM QoS interfaces: global /dev/cpu_dma_latency and
> per-device latency constraints. per-CPU set pm_qos_resume_latency_us
> to limit single CPU entery into deepest C-state.
> When it is required to disable entry into even C1, we need to set "0"
>  to /sys pm_qos_resume_latency_us, but "0" of pm_qos_resume_latency_us
> is redefined to no constraint now.
>
> so this patch set "0" back to original meaning "no latency at all".

It is not "back", it simply changes the meaning of 0.  And that's why
Documentation/ABI/testing/sysfs-devices-power needs to be updated.

> Signed-off-by: Youquan Song <youquan.song@intel.com>
> ---
>  drivers/base/power/sysfs.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
> index a1474fb67db9..b4bd67e6f440 100644
> --- a/drivers/base/power/sysfs.c
> +++ b/drivers/base/power/sysfs.c
> @@ -214,10 +214,8 @@ static ssize_t pm_qos_resume_latency_us_show(struct device *dev,
>  {
>         s32 value = dev_pm_qos_requested_resume_latency(dev);
>
> -       if (value == 0)
> -               return sysfs_emit(buf, "n/a\n");
>         if (value == PM_QOS_RESUME_LATENCY_NO_CONSTRAINT)
> -               value = 0;
> +               return sysfs_emit(buf, "no constraint\n");
>
>         return sysfs_emit(buf, "%d\n", value);
>  }
> @@ -237,10 +235,8 @@ static ssize_t pm_qos_resume_latency_us_store(struct device *dev,
>                 if (value < 0 || value == PM_QOS_RESUME_LATENCY_NO_CONSTRAINT)
>                         return -EINVAL;
>
> -               if (value == 0)
> -                       value = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
>         } else if (sysfs_streq(buf, "n/a")) {
> -               value = 0;
> +               value = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
>         } else {
>                 return -EINVAL;
>         }
> --

But do you really need to make these changes?  What problem is there
with using the interface as currently documented, ie. writing "n/a" to
it to get "no latency at all"?
