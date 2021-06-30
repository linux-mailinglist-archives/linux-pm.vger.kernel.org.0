Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82A1A3B87CC
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jun 2021 19:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhF3Rl0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Jun 2021 13:41:26 -0400
Received: from mail-oo1-f51.google.com ([209.85.161.51]:42729 "EHLO
        mail-oo1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbhF3Rl0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Jun 2021 13:41:26 -0400
Received: by mail-oo1-f51.google.com with SMTP id s10-20020a4aeaca0000b029024c2acf6eecso831962ooh.9;
        Wed, 30 Jun 2021 10:38:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v8JSghkeuF9S6UG+ix50DzAmP5iiLVa7Kv5BETwhQUY=;
        b=Ouh519BVMnd6DOX0ExdOKEGNW+P74h+SlZB/RojH7yitQZWTepi9bkbJ3vDG3OzQjv
         bjN6vpwpWM07X51xz9Ie4E2wilvYpjfUHzqytqFisFlgPp+b2X44r9COkTIITjHf9nCn
         9wmSttKl99DQMaD4Mftq09t4mrLoQ42fHUZl4p7hIo7253iC70rP+Wota5WwK0R4NOvr
         VEWaT2t9ZjX8eQCnXF85k3L+7D9GxSvqijKbVRNCWlI2/54oT72opgKGgAHWVdMx8UIp
         jQV2e/Lw2D4qeQn6ZVCHYIan4FqezU0UoQNaqfSVa8y8exljqNv4ukIL147JXn2/kVu7
         aW7Q==
X-Gm-Message-State: AOAM531R7U8WrmKKkWhnbJuvJ5ytw6j+F3qK/ituYGa6a++JElPJCbBV
        SA9fT6usTtjEpIBKk5+z5xvIRPNPMtwA5vPksf8=
X-Google-Smtp-Source: ABdhPJyIqBN/PMZlwg+zLDpLQ+5vZtZEEPWWBWAMKd/bSA7C3Ih6//8+RKzY37SrjDfbUGDhqKlFPVZgdZPn4aL+HpQ=
X-Received: by 2002:a4a:5285:: with SMTP id d127mr9203493oob.2.1625074736951;
 Wed, 30 Jun 2021 10:38:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210623092545.20675-1-wjc@cdjrlc.com>
In-Reply-To: <20210623092545.20675-1-wjc@cdjrlc.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 30 Jun 2021 19:38:46 +0200
Message-ID: <CAJZ5v0iJ6Zo9k3A_4sMBxcNZVB0M1+qTcbrsbQ63-M5OZSGSdg@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: moved EXPORT_SYMBOL so that it immediately
 followed its function/variable
To:     Jinchao Wang <wjc@cdjrlc.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 23, 2021 at 11:26 AM Jinchao Wang <wjc@cdjrlc.com> wrote:
>
> change made to resolve following checkpatch message:
>   WARNING: EXPORT_SYMBOL(foo); should immediately follow its
> function/variable

checkpatch errors regarding the existing code base are not relevant as a rule.

Now, this patch removes unnecessary empty lines, so it is not
meritless, but it should go under a different subject and with a
changelog describing what's going on.

Something like

Subject: [PATCH] cpuidle: Remove unnecessary empty lines preceding
EXPORT_SYMBOL_GPL()

In several places in cpuidle.c there are empty lines between the
definition of a function and the following EXPORT_SYMBOL_GPL() which
are not necessary, so remove them.

> Signed-off-by: Jinchao Wang <wjc@cdjrlc.com>
> ---
>  drivers/cpuidle/cpuidle.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index ef2ea1b12cd8..ddd11236a0cc 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -457,7 +457,6 @@ void cpuidle_pause_and_lock(void)
>         mutex_lock(&cpuidle_lock);
>         cpuidle_uninstall_idle_handler();
>  }
> -
>  EXPORT_SYMBOL_GPL(cpuidle_pause_and_lock);
>
>  /**
> @@ -468,7 +467,6 @@ void cpuidle_resume_and_unlock(void)
>         cpuidle_install_idle_handler();
>         mutex_unlock(&cpuidle_lock);
>  }
> -
>  EXPORT_SYMBOL_GPL(cpuidle_resume_and_unlock);
>
>  /* Currently used in suspend/resume path to suspend cpuidle */
> @@ -538,7 +536,6 @@ int cpuidle_enable_device(struct cpuidle_device *dev)
>
>         return ret;
>  }
> -
>  EXPORT_SYMBOL_GPL(cpuidle_enable_device);
>
>  /**
> @@ -566,7 +563,6 @@ void cpuidle_disable_device(struct cpuidle_device *dev)
>         cpuidle_remove_device_sysfs(dev);
>         enabled_devices--;
>  }
> -
>  EXPORT_SYMBOL_GPL(cpuidle_disable_device);
>
>  static void __cpuidle_unregister_device(struct cpuidle_device *dev)
> @@ -665,7 +661,6 @@ int cpuidle_register_device(struct cpuidle_device *dev)
>         __cpuidle_unregister_device(dev);
>         goto out_unlock;
>  }
> -
>  EXPORT_SYMBOL_GPL(cpuidle_register_device);
>
>  /**
> @@ -689,7 +684,6 @@ void cpuidle_unregister_device(struct cpuidle_device *dev)
>
>         cpuidle_resume_and_unlock();
>  }
> -
>  EXPORT_SYMBOL_GPL(cpuidle_unregister_device);
>
>  /**
> --
> 2.31.1
>
>
>
