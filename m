Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 853513C923E
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jul 2021 22:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbhGNUlj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Jul 2021 16:41:39 -0400
Received: from mail-il1-f169.google.com ([209.85.166.169]:34378 "EHLO
        mail-il1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbhGNUli (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Jul 2021 16:41:38 -0400
Received: by mail-il1-f169.google.com with SMTP id e13so2914265ilc.1;
        Wed, 14 Jul 2021 13:38:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Oqs7vKoe0auqSEgHvahfMsrIgLQ6xSdlLGxvngtPTW0=;
        b=lZWyZy84L3Mwl+chTO9YbN+zHi1bD2H64ot6MET1X9dfRIzfGvT32eaE7j5h+Xs51B
         LlH4/1VPdPEcnPvAe4mJZNav4v1C3J6a4yHvFxcfepRiAelP/sphk37mHmmO1BVQGQAV
         Zguw/dqTQC7D53jNnP0QApcpIt3bwwakfHMN36LM5dNjC5tByIYy4/2aOIZni6cNdU9E
         9uf5kixfYKzrawtSRewtssyY98OErSKJHEoD9AlIlHBgJScGX9j1bCD6ncZuc8CGokCt
         rGl/BisMwR5yvsSjl2qVQJjuGQWhN6DOzdOgP9caQKZnRL2a8Tbq8q8rwOTtHg/z1DIY
         w/2w==
X-Gm-Message-State: AOAM5326fekI5bTHMSkHEZNlgr1apF9LqeGligmo79g3mOT0Wd+ZBdM9
        3kP8IafaJEK5YciycgTMdA==
X-Google-Smtp-Source: ABdhPJwPefrXwGntr2qsp3ELCMjmMkRcSBjrRY1W4wOOnZH0vqUq7wSCEqfDGTkHZDh0OER6jPRbRQ==
X-Received: by 2002:a92:a013:: with SMTP id e19mr7743754ili.206.1626295126628;
        Wed, 14 Jul 2021 13:38:46 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id x10sm1670958ill.26.2021.07.14.13.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 13:38:46 -0700 (PDT)
Received: (nullmailer pid 3479516 invoked by uid 1000);
        Wed, 14 Jul 2021 20:38:43 -0000
Date:   Wed, 14 Jul 2021 14:38:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Sebastian Reichel <sre@kernel.org>,
        "Andrew F. Davis" <afd@ti.com>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] mfd: tps65086: Make interrupt line optional
Message-ID: <20210714203843.GA3476672@robh.at.kernel.org>
References: <20210625224744.1020108-1-kernel@esmil.dk>
 <20210625224744.1020108-3-kernel@esmil.dk>
 <YO1aSSSankv+cAru@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YO1aSSSankv+cAru@google.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 13, 2021 at 10:18:01AM +0100, Lee Jones wrote:
> On Sat, 26 Jun 2021, Emil Renner Berthing wrote:
> 
> > The BeagleV Starlight v0.9 board[1] doesn't have the IRQB line routed to
> > the SoC, but it is still useful to be able to reach the PMIC over I2C
> 
> What is still useful?
> 
> The GPIO and Regulator drivers?
> 
> > for the other functionality it provides.
> > 
> > [1] https://github.com/beagleboard/beaglev-starlight
> > 
> > Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> > ---
> >  .../devicetree/bindings/mfd/ti,tps65086.yaml  |  3 ---
> >  drivers/mfd/tps65086.c                        | 21 ++++++++++---------
> >  2 files changed, 11 insertions(+), 13 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/ti,tps65086.yaml b/Documentation/devicetree/bindings/mfd/ti,tps65086.yaml
> > index ba638bd10a58..4b629fcc0df9 100644
> > --- a/Documentation/devicetree/bindings/mfd/ti,tps65086.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/ti,tps65086.yaml
> > @@ -87,9 +87,6 @@ additionalProperties: false
> >  required:
> >    - compatible
> >    - reg
> > -  - interrupts
> > -  - interrupt-controller
> > -  - '#interrupt-cells'
> 
> I can't say that I've been keeping up with the latest DT binding
> changes, but shouldn't these lines be relocated into some kind of
> optional listing?
> 
> Or are optional properties omitted from documentation?

Optional properties are the ones not listed in the 'required' list.

Rob
