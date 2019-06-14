Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6124E45A0A
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2019 12:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfFNKKW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Jun 2019 06:10:22 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41224 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbfFNKKW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Jun 2019 06:10:22 -0400
Received: by mail-ot1-f68.google.com with SMTP id 107so2101721otj.8;
        Fri, 14 Jun 2019 03:10:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EQFqDx56ArdqMtwRzBeDN3+uyf/q8nRQ91FrvCgNlus=;
        b=T+UDdh59PDstefaDEilZLq0jQ5l+z1dyJKp100jDHQPkg7iZDTx2TMsi4BDQsG2zjs
         MSoKipWtPSQVqElpqLD9yQZFgLulGPEhKr9FeNJ9RTaLWK4EY6SKvmNZlMPhQcMWjGHk
         lKVeVIvvPOtNLTEyn0jy505iGDNyWQwwkllpTi2VEnXx4ZVMKEdFhuI5ynKSlr2O0SLk
         Wm6kWDhDylzq9rAfEr/Z07Y5dzhWmu1AgtFfZqjhCTLrA50b05pxDy+iCt2Vkv5J8Wl7
         U+MVgFjJbqVlE7CElg+WvvDWB3GKnvZc5r6CYp1cZChSpXi2sPPyBytozgrxyHt4YHjl
         2Y1Q==
X-Gm-Message-State: APjAAAV6lQdirotAA9C/fGjUOKSabsBqBZbIDwbSL+C6M9Dw2+B6I0SF
        rjDm6Se93ZzqxWocDWYR8zEfuyg4Ig8A3aRX3NUGX1o3
X-Google-Smtp-Source: APXvYqzla74fywlifHDfrUkFPvp96u1JCh5ytR3Rfap99pfKpNbS6Np/wi5SUpskNas/C6Gyl2xZT2QWu5iLRTph14s=
X-Received: by 2002:a9d:5f05:: with SMTP id f5mr2484337oti.167.1560507021280;
 Fri, 14 Jun 2019 03:10:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190613170011.9647-1-thierry.reding@gmail.com>
 <20190614091058.GA25912@kroah.com> <20190614093856.GC15526@ulmo>
In-Reply-To: <20190614093856.GC15526@ulmo>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 14 Jun 2019 12:10:10 +0200
Message-ID: <CAJZ5v0jeH3x+kfAH9D5H6507-iBdVRhAfEKb-NOdhiutwR9O_Q@mail.gmail.com>
Subject: Re: [PATCH v2] driver: core: Allow subsystems to continue deferring probe
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Joerg Roedel <joro@8bytes.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-gpio@vger.kernel.org,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jun 14, 2019 at 11:39 AM Thierry Reding
<thierry.reding@gmail.com> wrote:
>
> On Fri, Jun 14, 2019 at 11:10:58AM +0200, Greg Kroah-Hartman wrote:
> > On Thu, Jun 13, 2019 at 07:00:11PM +0200, Thierry Reding wrote:
> > > From: Thierry Reding <treding@nvidia.com>
> > >

[cut]

>
> To avoid further back and forth, what exactly is it that you would have
> me do? That is, what do you consider to be the correct way to do this?
>
> Would you prefer me to add another function with a different name that
> reimplements the functionality only with the exception? Something along
> the lines of:
>
>         int driver_deferred_probe_check_state_continue(struct device *dev)
>         {
>                 int ret;
>
>                 ret = driver_deferred_probe_check_state(dev);
>                 if (ret == -ENODEV)
>                         return -EPROBE_DEFER;
>
>                 return ret;
>         }
>
> ? I'd need to split that up some more to avoid the warning that the
> inner function prints before returning -ENODEV, but that's a minor
> detail. Would that API be more to your liking?

Well, why don't you do

static int deferred_probe_check_state_internal(struct device *dev)
{
        if (!initcalls_done)
                return -EPROBE_DEFER;

        if (!deferred_probe_timeout) {
                dev_WARN(dev, "deferred probe timeout, ignoring dependency");
                return -ETIMEDOUT;
        }

        return 0;
}

int driver_deferred_probe_check_state(struct device *dev)
{
        int ret = deferred_probe_check_state_internal(dev);

        if (ret)
                 return ret;

        dev_warn(dev, "ignoring dependency for device, assuming no driver");
        return -ENODEV;
}

int driver_deferred_probe_check_state_continue(struct device *dev)
{
        int ret = deferred_probe_check_state_internal(dev);

        if (ret)
                 return ret;

        return -EPROBE_DEFER;
}
