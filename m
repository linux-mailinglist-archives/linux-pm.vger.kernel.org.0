Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA9E3166AFA
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2020 00:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbgBTXb0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Feb 2020 18:31:26 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45156 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729270AbgBTXb0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2020 18:31:26 -0500
Received: by mail-oi1-f196.google.com with SMTP id v19so153556oic.12
        for <linux-pm@vger.kernel.org>; Thu, 20 Feb 2020 15:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cX+db5U8CtEgxjRtXzK2hbSPInTYpvJEKTM3HshbINU=;
        b=b12pI/w6/WlkF8IEQZyJGbw01kpouWxdzknoAlzX9xfdHWAj92OFUvxZPB8xnaeSrZ
         /rqdoZucH20EUAraAl7Xbb26kN3I3rk/EDsFyoQiinCW2lIl52SQ3dNl5PZx+C/sQyO+
         cmWmNTXuvXUb+DGIEcKJGdNYN4/KV3HLo1eGpUxg8odniE6dfC3a8fhT6IPkVeKpuxmW
         NtjFobDSIoBdKDmrplV9s0eF+m0SOI5WJN//JS1QIsrQ1ZVUF3aEoCojp/lLzFZkIk4U
         JWfoOChIrDqOAz1X6al3LGnSs5WYtrearJVjjVy8GCf9q8y5YDU7iBSVAHD3CXUGWdtE
         5qzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cX+db5U8CtEgxjRtXzK2hbSPInTYpvJEKTM3HshbINU=;
        b=GO+r+okBV8EnxzgFEYb46BZ5N26//eYyxV8pWtCi/vet7rH8Oppj8lpYjQnV1zy0EQ
         BsKDJvRubRpThG39zgC56oR4GOIuGnfg8GKgBLxIh0LKVdrSoK+G4EqyBRPiL+44khb4
         Fz4i3Q7XPWR9hq2KWnDx8BAzg6wucudD650yEYF/4CQOT39fsPqT6qVquFpWIzeeN6hg
         YqHloSVTU3C6APTXCb7ZyDAP3vL+dgRZlorf+3ek3NyepGOwBKCXCwhhFKD3LbAo1qW0
         uAoYtfvQsX2swCGWQjvhEfo7KfPDNYhBAe2bOdy/YWmunrEB4LnKWew71BdXIXO5aUIF
         NQpA==
X-Gm-Message-State: APjAAAU9O1w8tK7MJri8HjD35VPj0CYWX+MZzX2Ri+DSqP712dSeEhyJ
        q4Byf9FNFOkEftwTlX2niFgjjD68BCzfAOfaQPWe7A==
X-Google-Smtp-Source: APXvYqymRB2V+MyO0KyAEPT7mJxa7dCtj/3y+lnMklL2vrd2c6CSsFGHoO/m6Vc2EVGb333n3Shtlvn1zenKunK7V9E=
X-Received: by 2002:aca:d4c1:: with SMTP id l184mr4020121oig.172.1582241485487;
 Thu, 20 Feb 2020 15:31:25 -0800 (PST)
MIME-Version: 1.0
References: <20200220055250.196456-1-saravanak@google.com> <CANcMJZBQe5F=gbj6V2ybF-dK=kRsGZT2BX9CBJiBFoK=5Hg-kA@mail.gmail.com>
In-Reply-To: <CANcMJZBQe5F=gbj6V2ybF-dK=kRsGZT2BX9CBJiBFoK=5Hg-kA@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 20 Feb 2020 15:30:49 -0800
Message-ID: <CAGETcx88H+aFTt=Vp8Q1KVOZYEaD3D6=i5WN8tWmnBAs1YdY1g@mail.gmail.com>
Subject: Re: [PATCH v1] of: property: Add device link support for
 power-domains and hwlocks
To:     John Stultz <john.stultz@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Feb 20, 2020 at 3:26 PM John Stultz <john.stultz@linaro.org> wrote:
>
> On Wed, Feb 19, 2020 at 9:53 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > Add support for creating device links out of more DT properties.
> >
> > To: lkml <linux-kernel@vger.kernel.org>
> > To: John Stultz <john.stultz@linaro.org>
> > To: Rob Herring <robh@kernel.org>
>
> Just as a heads up, git-send-email doesn't seem to pick up these To:
> lines, so I had to dig this out of an archive.

Weird! Left out the main person who'd care about this patch.

>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Kevin Hilman <khilman@kernel.org>
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Cc: Pavel Machek <pavel@ucw.cz>
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: Todd Kjos <tkjos@google.com>
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: Liam Girdwood <lgirdwood@gmail.com>
> > Cc: Mark Brown <broonie@kernel.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: linux-pm@vger.kernel.org
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  drivers/of/property.c | 4 ++++
> >  1 file changed, 4 insertions(+)
>
> This does seem to work for me, allowing various clk drivers to be used
> as modules! This removes the functional need for my recent driver core
> patch series around the deferred_probe_timeout (though the cleanup
> bits in there may still be worth while).
>
> Tested-by: John Stultz <john.stultz@linaro.org>
>
> Thanks for sending it out!

Thanks for the Tested-by!

Rob,

Can you pick this up for the next rc?

-Saravana
