Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38E1817021E
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2020 16:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgBZPRf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Feb 2020 10:17:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:57056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727941AbgBZPRf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 26 Feb 2020 10:17:35 -0500
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E15624687;
        Wed, 26 Feb 2020 15:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582730254;
        bh=QbvkJ7pUaSKaOk50O+V+6P1ajRDedKDnLBjdtDbWLMI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IrQfPqoLka7BEsWptwul43UPtO+sHb2/jj39k9KJXXnQHjhGjTZDSzpLpIkq+1897
         mpT+jaXTivYwii9Fj68e+3DuyiCY2ca0gdVDiFfFEVa+xZNcJdWg+rQvxJntnZpp0p
         Yz1RRZ2Kgr3M/F7dz6IXYXHOTe59jOjoCwZiQOOk=
Received: by mail-qk1-f179.google.com with SMTP id z19so2940885qkj.5;
        Wed, 26 Feb 2020 07:17:34 -0800 (PST)
X-Gm-Message-State: APjAAAWZK4EJPTm4bq25wWqLgp48FdKYCswr5FO3e2FfTlkG+3hN7Xyu
        yyhcnQHVJMnQF2E+262rZ4P86AFFiaRdd7vcnA==
X-Google-Smtp-Source: APXvYqwOBeVkQzDCVQhRRroVuItJt7tbfzF8jBjBWGkighsyGpHKqVvv0RuR0fNZzggl6WhCT14noYZJeodCe/v9itA=
X-Received: by 2002:ae9:f205:: with SMTP id m5mr6100523qkg.152.1582730253143;
 Wed, 26 Feb 2020 07:17:33 -0800 (PST)
MIME-Version: 1.0
References: <20200220055250.196456-1-saravanak@google.com> <CANcMJZBQe5F=gbj6V2ybF-dK=kRsGZT2BX9CBJiBFoK=5Hg-kA@mail.gmail.com>
 <CAGETcx88H+aFTt=Vp8Q1KVOZYEaD3D6=i5WN8tWmnBAs1YdY1g@mail.gmail.com> <CAGETcx_n=fZYaY5q6yZRJR9daTXm2Ryz5frfZr3n1BKf-pXCEQ@mail.gmail.com>
In-Reply-To: <CAGETcx_n=fZYaY5q6yZRJR9daTXm2Ryz5frfZr3n1BKf-pXCEQ@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 26 Feb 2020 09:17:21 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJUp6+FA8MCvpetk9UMAk+GWm9naASE-ddi-FcMKkcwQA@mail.gmail.com>
Message-ID: <CAL_JsqJUp6+FA8MCvpetk9UMAk+GWm9naASE-ddi-FcMKkcwQA@mail.gmail.com>
Subject: Re: [PATCH v1] of: property: Add device link support for
 power-domains and hwlocks
To:     Saravana Kannan <saravanak@google.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Todd Kjos <tkjos@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Feb 25, 2020 at 3:46 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Thu, Feb 20, 2020 at 3:30 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > On Thu, Feb 20, 2020 at 3:26 PM John Stultz <john.stultz@linaro.org> wrote:
> > >
> > > On Wed, Feb 19, 2020 at 9:53 PM Saravana Kannan <saravanak@google.com> wrote:
> > > >
> > > > Add support for creating device links out of more DT properties.
> > > >
> > > > To: lkml <linux-kernel@vger.kernel.org>
> > > > To: John Stultz <john.stultz@linaro.org>
> > > > To: Rob Herring <robh@kernel.org>
> > >
> > > Just as a heads up, git-send-email doesn't seem to pick up these To:
> > > lines, so I had to dig this out of an archive.
> >
> > Weird! Left out the main person who'd care about this patch.
> >
> > >
> > > > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > > > Cc: Kevin Hilman <khilman@kernel.org>
> > > > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > > > Cc: Pavel Machek <pavel@ucw.cz>
> > > > Cc: Len Brown <len.brown@intel.com>
> > > > Cc: Todd Kjos <tkjos@google.com>
> > > > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > > Cc: Liam Girdwood <lgirdwood@gmail.com>
> > > > Cc: Mark Brown <broonie@kernel.org>
> > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Cc: linux-pm@vger.kernel.org
> > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > > ---
> > > >  drivers/of/property.c | 4 ++++
> > > >  1 file changed, 4 insertions(+)
> > >
> > > This does seem to work for me, allowing various clk drivers to be used
> > > as modules! This removes the functional need for my recent driver core
> > > patch series around the deferred_probe_timeout (though the cleanup
> > > bits in there may still be worth while).
> > >
> > > Tested-by: John Stultz <john.stultz@linaro.org>
> > >
> > > Thanks for sending it out!
> >
> > Thanks for the Tested-by!
> >
> > Rob,
> >
> > Can you pick this up for the next rc?

You mean 5.7-rc1, right?

> Friendly reminder.

No need to ping. You can check patchwork[1] to see where you are in the queue.

Rob

[1] https://patchwork.ozlabs.org/project/devicetree-bindings/list/
