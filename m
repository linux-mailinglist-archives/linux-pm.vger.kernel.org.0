Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1537262227
	for <lists+linux-pm@lfdr.de>; Tue,  8 Sep 2020 23:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbgIHVx5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Sep 2020 17:53:57 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40547 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbgIHVx4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Sep 2020 17:53:56 -0400
Received: by mail-io1-f66.google.com with SMTP id j2so998828ioj.7;
        Tue, 08 Sep 2020 14:53:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wiPcYtXUmUOhYk2NP+zdXxVU6WZbJLZv+xg4idR2sPs=;
        b=NZD0FdOVuldf3/HVH7XxcuDnX+3RM9gRK8/2OMElQADDboO8pCTVnwSFBuSZGi/kGe
         Ik1PQqb3Wh2Tb7dfGZ968dCZJs2FNDYdnd4U5/wRPX2nFZ0VEmCA8XWTq025kb7mpMwR
         GtCbfyMHlz61sCSf6vlOAKLUpDGUCeLOkcr2vY1NbRgnWwZFKc/v4++wHDMYfZL3EO09
         xYcWSZLqG90D0K7wVbrnrMA0Nwlg8slBegmsrd7Nrz+WCI6F67wyTOE21s85qslDOCLi
         BD/2Yfu0V9dZf93kqF90OmPd9gSD6/UH+MQwbfOQclhcoW/pNVPvNet5yVe4Gi1GlcVB
         JGYQ==
X-Gm-Message-State: AOAM531tYKMoSnNPw3RdhlF3GHNvoe+R5vE/6QwjmnyaLRZGbNG3Nhy1
        WFWqk9tWWWiF1WLY+kLISw==
X-Google-Smtp-Source: ABdhPJwVWjjp5FxJlVlmFFdvHZsCnIqr88iEcaRkpM6x7dcQaMo4X89epeMAF5S/GKo8UmohORtsuA==
X-Received: by 2002:a05:6602:2e81:: with SMTP id m1mr893664iow.64.1599602034449;
        Tue, 08 Sep 2020 14:53:54 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id e14sm232699ilr.42.2020.09.08.14.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 14:53:53 -0700 (PDT)
Received: (nullmailer pid 995501 invoked by uid 1000);
        Tue, 08 Sep 2020 21:53:52 -0000
Date:   Tue, 8 Sep 2020 15:53:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Lubomir Rintel <lkundrak@v3.sk>, Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/6] dt-bindings: mfd: ene-kb3930: Add compatibles for
 KB930 and Acer A500
Message-ID: <20200908215352.GA989862@bogus>
References: <20200823140846.19299-1-digetx@gmail.com>
 <20200823140846.19299-5-digetx@gmail.com>
 <20200823182050.GA210632@demiurge.local>
 <b91b96d2-89e1-feb7-a4d0-6fd19a173ab4@gmail.com>
 <20200823211629.GA240555@demiurge.local>
 <c536557c-de42-d6bd-890c-ef71ca0e3116@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c536557c-de42-d6bd-890c-ef71ca0e3116@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 24, 2020 at 01:09:22PM +0300, Dmitry Osipenko wrote:
> 24.08.2020 00:16, Lubomir Rintel пишет:
> > Hello,
> > 
> > On Sun, Aug 23, 2020 at 10:31:36PM +0300, Dmitry Osipenko wrote:
> >> 23.08.2020 21:20, Lubomir Rintel пишет:
> >>> On Sun, Aug 23, 2020 at 05:08:44PM +0300, Dmitry Osipenko wrote:
> >>>> The ENE KB930 hardware is compatible with KB3930.
> >>>>
> >>>> Acer A500 Iconia Tab is Android tablet device, it has KB930 controller
> >>>> that is running firmware specifically customized for the needs of the
> >>>> Acer A500 hardware. This means that firmware interface isn't re-usable
> >>>> by other non-Acer devices. Some akin models of Acer tablets should be
> >>>> able to re-use the FW interface of A500 model, like A200 for example.
> >>>>
> >>>> This patch adds the new compatibles to the binding.
> >>>
> >>> I've responded to patch 5/6 with what should've been said here [1].
> >>> Sorry for the confusion.
> >>>
> >>> In any case please consider adding a new binding file instead of
> >>> modifying the kb3930 binding doc. It would also remove a dependency on
> >>> my patch set which should have slipped out of maintainers' radar.
> >>>
> >>> [1] https://lore.kernel.org/lkml/20200823180041.GB209852@demiurge.local/
> >>
> >> Hello, Lubomir! I was doing some research about the differences of
> >> KB3930 and KB930 before created this patch and my understanding is that
> >> the controllers are mostly identical. I've seen posts from people who
> >> replaced KB3930 with KB930 (and vice versa) on various notebooks and it
> >> worked, although not always.
> >>
> >> It's a very common practice to re-use binding in a case of a sibling
> >> hardware. Do you know what are the exact differences between KB3930 and
> >> KB930 which could justify having separate bindings?
> >>
> >> The firmware implementation varies a lot from device to device,
> > 
> > It sometimes does. The ENE's downstream driver suggests there are parts
> > that run more-or-less stock firmware that are comatible with each other.
> > That is why I grabbed the generic kb3930 name.
> > 
> >> and
> >> thus, each device needs to have its own driver in order to talk to the
> >> firmware, but hardware description (i.e. DT binding) should be common
> >> for all devices.
> > 
> > Note the DT is not the hardware description. It's the description of how
> > the hardware presents itself, from the software's perspective. As far as
> > that is concerned, the devices don't seem to have anything in common at
> > all (other than the bus address). The fact that you need an entirely
> > different driver implies this.
> > 
> > This would be the case even if the A500 EC was based directly on a KB3930.
> > 
> > A good reason to keep bindings for different yet somewhat similar devices in
> > a single document is to avoid duplication. Yet here there's very little to
> > share here. If you've done your bindings correctly, you'd need to
> > conditionalize the monitored-battery and power-supplies properties for
> > acer,a500-iconia-ec, complicating the binding too much. It makes more
> > sense to just add a new document.
> 
> Alright, I don't mind to separate the bindings. Although, before doing
> that, I'd want to get opinion from the device-tree experts, i.e. from
> Rob Herring :)
> 
> Rob, will it be fine to have separate bindings for each firmware version
> of the ENE controller given that firmware is individual for every device
> and given that FW has no compatibility with other devices?

Seems like separate bindings makes sense here.

Rob
