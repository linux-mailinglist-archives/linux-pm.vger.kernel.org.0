Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0BF1165B2A
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2020 11:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgBTKJv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Feb 2020 05:09:51 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44210 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbgBTKJv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2020 05:09:51 -0500
Received: by mail-pf1-f194.google.com with SMTP id y5so1674369pfb.11;
        Thu, 20 Feb 2020 02:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NpuuBxfbKHIUwnb3LRiYILCMm22iCmnjP8uXzLSEjVk=;
        b=iWfuxaMZ1GQAXTsX3hPS/1aDPr5XJzqKbDVGbvb470Z38y5jXGtfwv1GBtfG91LdJg
         tetHrqKrBS+ZnHgF0HKe62d5hwp1mi85Ywe1ShUV9cPxQt16RvVQ9nDVztFQxMvPFHXr
         q978IwmZd5GBg4usV63XWJiTrktJtna8fXrAmhITtGKGGEinaLqnV4PXWJTF28y/NStB
         ZxeJzWC/CgV7Ur4MzWcU5R0mpOM2alMsKMC/pCrYdl8o+VO/AWmf6V4R0rR5ZujLlmSA
         KcmFNH0x6yo04LwD4qED5ZwDFTsTlQRdmQkvohwCF7FM7Fi0S3OK/VY/YOUNYIzbBvow
         iQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NpuuBxfbKHIUwnb3LRiYILCMm22iCmnjP8uXzLSEjVk=;
        b=VlW3PfGLKEU5U9RH76+nZL1TGurNLzAAN6Kuj/8LSJXk8sHXxJSf3SDiyywkgle+fc
         9cddsOrAA6JrzdxcKmz+E7onuDeDq5H86GAn3rFPMPyrA3n7507ZBwl+DUU4JSpaYIuy
         R9v3PtlDSY7MmKFTXSO9MIm73pxXtZkOhtf11UbO1iCJyMabCX9XlYQgaSux/6+tzhqg
         YtZQR0810xej4TsDd8KGrprcgqJH22tyWGV8rSH7r3DIKOrezyTqPZGdYDvgkRAad2oW
         uxxzSVqZuvff2BM5G2UveDDLCjksla/kf2qflUYqtzKj+pNw7kD0td4DzbkmUlj6wNeX
         TPQw==
X-Gm-Message-State: APjAAAWbj9jtc6Uw1ymLsBxA4odVuEvBcrwXnHnSreoAgDCPa0Ky/jVR
        s1d9U71idm/9FElJmCZgw1RxXSE6We6Mq6Xy5zc=
X-Google-Smtp-Source: APXvYqwy658WWlnW63JID/OYabb2tkComA3d7a+Zy6/L9sWbvQoYTfebwxlkJb4JZR8q8u7tLijnNFJySepK+2+BBe0=
X-Received: by 2002:a65:5242:: with SMTP id q2mr31475579pgp.74.1582193389555;
 Thu, 20 Feb 2020 02:09:49 -0800 (PST)
MIME-Version: 1.0
References: <20200218220748.54823-1-john.stultz@linaro.org> <20200220052739.87057-1-saravanak@google.com>
In-Reply-To: <20200220052739.87057-1-saravanak@google.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 20 Feb 2020 12:09:41 +0200
Message-ID: <CAHp75VfodUCQWRcPB08Qmp8o+BxwL4j4aAgqt9cuJ=mHLLAQyQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] driver core: Rework logic in __driver_deferred_probe_check_state
 to allow EPROBE_DEFER to be returned for longer
To:     Saravana Kannan <saravanak@google.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Todd Kjos <tkjos@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Feb 20, 2020 at 7:29 AM Saravana Kannan <saravanak@google.com> wrote:
> On Tue, Feb 18, 2020 at 4:07 PM John Stultz wrote:
> > Due to commit e01afc3250255 ("PM / Domains: Stop deferring probe
> > at the end of initcall"), along with commit 25b4e70dcce9
> > ("driver core: allow stopping deferred probe after init") after
> > late_initcall, drivers will stop getting EPROBE_DEFER, and
> > instead see an error causing the driver to fail to load.
>
> Both of those patches were the best solution at that point in time. But
> the kernel has changed a lot since then. Power domain and IOMMU drivers
> can work as modules now. We have of_devlink and sync_state().
>
> So, while a delay might have been the ideal solution back then, I think
> we need to work towards removing arbitrary timeouts instead of making
> the timeout mechanism more elaborate.
>
> I think driver_deferred_probe_check_state() logic should boiled down
> to something like:

...

> Once we add of_devlink support for power-domains, you won't even hit the
> genpd error path if you have of_devlink enabled. I believe in the case
> you are testing DB 845c, of_devlink is enabled?
>
> If of_devlink is enabled, the devices depending on the unprobed power
> domains would be deferred without even calling the driver's probe()
> function.
>
> Adding power-domain support to of_devlink is a 2 line change. I'll send
> it out soon.

...

Pardon me for not knowing the OF and devlink stuff in particular, but
have you had a chance to test your changes on some (rather complex)
ACPI enabled platforms?
Would it have any complications there?

-- 
With Best Regards,
Andy Shevchenko
