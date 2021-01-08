Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396B52EF362
	for <lists+linux-pm@lfdr.de>; Fri,  8 Jan 2021 14:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbhAHNqh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Jan 2021 08:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbhAHNqg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Jan 2021 08:46:36 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9373BC0612F4;
        Fri,  8 Jan 2021 05:45:56 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id u12so10275285ilv.3;
        Fri, 08 Jan 2021 05:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cKHeUR1zK43NQMUQKMTc/nRz+XRhb8es7I3o2+Po5OM=;
        b=QUE6Q4+lt/2IpN5/4MWXoP7r0zJ6gpUbj1DYEZl5QziVOJF8mGuSPZ4J+rL14IiCDW
         5m78yFYf0V/P5spwFvv2o9vWhc8AVD/UXQQNy4yaR50rIwb87ufnDX6VsgU1SwDX17xo
         F6MFJBs+ENedFrk3eZMLEzRT6yAlvdM0BhRN/cn75uGqyWtoXsOcuZff7G/4I7OXoPzt
         DxQ4L9VUR8B2dmmuKGGX6Z/ZijmawRDUESWOR+dT4DnAcv+q8YL5P+oZYErPsHAP/Pe/
         pNN28cP7WYRNIgrSQtWwtgbjOc0q8QqiGsXZFNG4v3POd+VlM9L0mLIoFR7GiLQLUhy2
         bPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cKHeUR1zK43NQMUQKMTc/nRz+XRhb8es7I3o2+Po5OM=;
        b=n8Q/41A0FWZDscct4DFtarxeZ1yiU/cZTQKGU8Lko4jI7u+ENVFijdcIaQ/HuhA+Cj
         CCfJ6j8jlwHU7mTkG4VIPMMz5SsobJQph1bEfknYb94ELhHyyVRWn1Yd9YAvs+Uw9Tfv
         9guOabVQ7wWxzQpBTnBkGp+6UGXGVrim4EPGUkjPy0jcbxROkSF4JEBsw3zdLKaxASCX
         42b3BU+4ynQ6bW1ik/Z9PD3hpfprHXQ+UvFaLOdEyj3Mbxuw3/BydQijC1OjBIa+eNpm
         sEdzj7H1W+HsvNcySM31U5cTHFdeP4hoYz7Afu2exUgUzS803hiOZ7WHgrNkV/d1U7f2
         w77A==
X-Gm-Message-State: AOAM533XUXx0h8Mm6tkm+/7M61JZWxsJugoMPdhxHqydZ+CLz2yMSGQf
        80H37zePRwtlVfgAq0lJNTNaesDmO27eh4zfeGM=
X-Google-Smtp-Source: ABdhPJxCDlsxvVBHcnRxKe76pie+vUEs4FqREROSJT+0vN+DUoNM18G/O5julpRlaHGXvzKU3rmH0/vttv0j61jeuFw=
X-Received: by 2002:a92:c561:: with SMTP id b1mr3896749ilj.65.1610113555882;
 Fri, 08 Jan 2021 05:45:55 -0800 (PST)
MIME-Version: 1.0
References: <20201230084338.19410-1-tony@atomide.com> <CAHCN7xJmwcUOpoza-LNxTAbRNb9ToERnBNuKboP86DSBdtS61A@mail.gmail.com>
 <7C9106E0-FC75-4056-AD5F-16CCFA9C24E5@goldelico.com> <X/gIO9Ta3JPDaeV3@atomide.com>
In-Reply-To: <X/gIO9Ta3JPDaeV3@atomide.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Fri, 8 Jan 2021 07:45:44 -0600
Message-ID: <CAHCN7xKzeqabm5YJbNS_jcENnhxdU9tAuhWZv81xJA7VbaW6NA@mail.gmail.com>
Subject: Re: [PATCH 1/3] thermal: ti-soc-thermal: Fix stuck sensor with
 continuous mode for 4430
To:     Tony Lindgren <tony@atomide.com>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Amit Kucheria <amitk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>, linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        Carl Philipp Klemm <philipp@uvos.xyz>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Pavel Machek <pavel@ucw.cz>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Andreas Kemnade <andreas@kemnade.info>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jan 8, 2021 at 1:22 AM Tony Lindgren <tony@atomide.com> wrote:
>
> * H. Nikolaus Schaller <hns@goldelico.com> [201230 13:29]:
> > > Am 30.12.2020 um 13:55 schrieb Adam Ford <aford173@gmail.com>:
> > > On Wed, Dec 30, 2020 at 2:43 AM Tony Lindgren <tony@atomide.com> wrote:
> > >>
> > >> At least for 4430, trying to use the single conversion mode eventually
> > >> hangs the thermal sensor. This can be quite easily seen with errors:
> > >>
> > >> thermal thermal_zone0: failed to read out thermal zone (-5)
> ...
>
> > > I don't have an OMAP4, but if you want, I can test a DM3730.
> >
> > Indeed I remember a similar discussion from the DM3730 [1]. temp values were
> > always those from the last measurement. E.g. the first one was done
> > during (cold) boot and the first request after 10 minutes did show a
> > quite cold system... The next one did show a hot system independent
> > of what had been between (suspend or high activity).
> >
> > It seems as if it was even reproducible with a very old kernel on a BeagleBoard.
> > So it is quite fundamental.
> >
> > We tried to fix it but did not come to a solution [2]. So we opened an issue
> > in our tracker [3] and decided to stay with continuous conversion although this
> > raises idle mode processor load.
>
> Hmm so maybe eocz high always times out in single mode since it also
> triggers at least on dra7?
>
> Yes it would be great if you guys can the $subject patch a try at
> least on your omap36xx and omap5 boards and see if you see eocz
> time out warnings in dmesg.

I should be able to try it on the dm3730 logicpd-torpedo kit this weekend.

adam
>
> Regards,
>
> Tony
