Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57C0B2D6E68
	for <lists+linux-pm@lfdr.de>; Fri, 11 Dec 2020 04:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395043AbgLKDR0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Dec 2020 22:17:26 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37127 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395038AbgLKDRZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Dec 2020 22:17:25 -0500
Received: by mail-ot1-f67.google.com with SMTP id o11so7044998ote.4;
        Thu, 10 Dec 2020 19:17:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UAQ/+yxq3lvFh3mlevVQAOgZP4fPvuW24IZd1p2z3wA=;
        b=NClEFe11d0rBvcJNrdC4c2fiEtfprTUsfDWnTiEfj1U3V1dkTdSSrQiZpbnVeKsyV8
         YNnP9ZyM8686+J3s8kY+DbXC/VZJBjW7Bku/wEFXcqFlBOhxTqQpLMNceZrjzWsco5XQ
         oS/L8zEMMERkgdZQ7nte4WLyS6am2XMtMez0MiAcDaXXNovBwuuKTq4cu4TLL4MUhbHr
         InvugUSxLamdp/pBwFvYIgTK2IhINlBWGonLQvPDopr8aKyvOdtI8X+xaL035s/o2Qhf
         GFHRidRrCIH0IDrwHKys4iQjJjLwmNQ85HCBx++iBhQTK3TJUCNDbhy26zXTQN4uhiWz
         DrHA==
X-Gm-Message-State: AOAM533CbsaROBXlXMB+4rf9Xt+iO7QOtJ727vowD09i9jFTqWcXAeo4
        KHfODH//y/qI5stFyLp9YQ==
X-Google-Smtp-Source: ABdhPJzEyaHLlvA4GwXz6prj5x7rXBSxOvLIEtJLnus5sFylsZnfvKpaDBWHA9e5tqLVo02eOu3czQ==
X-Received: by 2002:a9d:1f0:: with SMTP id e103mr8382432ote.74.1607656604698;
        Thu, 10 Dec 2020 19:16:44 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l134sm830943oig.25.2020.12.10.19.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 19:16:43 -0800 (PST)
Received: (nullmailer pid 3561568 invoked by uid 1000);
        Fri, 11 Dec 2020 03:16:42 -0000
Date:   Thu, 10 Dec 2020 21:16:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 1/7] dt-bindings: input: Add reset-time-sec common
 property
Message-ID: <20201211031642.GA3556770@robh.at.kernel.org>
References: <cover.1607216141.git.cristian.ciocaltea@gmail.com>
 <c08349db08db67e71cf428fe7fd53624aaa0acf8.1607216141.git.cristian.ciocaltea@gmail.com>
 <20201210033708.GA1606132@robh.at.kernel.org>
 <20201210091350.GA322060@ubuntu2004>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210091350.GA322060@ubuntu2004>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Dec 10, 2020 at 11:13:50AM +0200, Cristian Ciocaltea wrote:
> Hi Rob,
> 
> On Wed, Dec 09, 2020 at 09:37:08PM -0600, Rob Herring wrote:
> > On Sun, Dec 06, 2020 at 03:27:01AM +0200, Cristian Ciocaltea wrote:
> > > Add a new common property 'reset-time-sec' to be used in conjunction
> > > with the devices supporting the key pressed reset feature.
> > > 
> > > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> > > ---
> > > Changes in v3:
> > >  - This patch was not present in v2
> > > 
> > >  Documentation/devicetree/bindings/input/input.yaml | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/input/input.yaml b/Documentation/devicetree/bindings/input/input.yaml
> > > index ab407f266bef..caba93209ae7 100644
> > > --- a/Documentation/devicetree/bindings/input/input.yaml
> > > +++ b/Documentation/devicetree/bindings/input/input.yaml
> > > @@ -34,4 +34,11 @@ properties:
> > >        specify this property.
> > >      $ref: /schemas/types.yaml#/definitions/uint32
> > >  
> > > +  reset-time-sec:
> > 
> > Humm, I'm pretty sure we already have something for this. Or maybe just 
> > power off.
> 
> We only have 'power-off-time-sec', so I added 'reset-time-sec' according
> to your review in v2:
> https://lore.kernel.org/lkml/20200908214724.GA959481@bogus/

I'm doing good if I remember reviews from a week ago. From 3 months ago, 
no chance without some reminder.

Reviewed-by: Rob Herring <robh@kernel.org>

Rob
