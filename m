Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1D412E0120
	for <lists+linux-pm@lfdr.de>; Mon, 21 Dec 2020 20:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgLUTh6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Dec 2020 14:37:58 -0500
Received: from mail-oi1-f181.google.com ([209.85.167.181]:35696 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbgLUTh6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Dec 2020 14:37:58 -0500
Received: by mail-oi1-f181.google.com with SMTP id s2so12423798oij.2;
        Mon, 21 Dec 2020 11:37:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q18NZxhvIxRINjWva11fV4XGSXxm/kjXgjBXhmlaf7Q=;
        b=Zp/re2CBKlbICt+UlgqVCUciVrf+pClbfhCNwnKMaRyrCVFdfMwbrQdzSCCGkCoym/
         CIemP5/1mvj4cIDozi4RfuCNR7enX25HKlt8Zoba72PTN9esnwa7LkV8PhRkV7unCL2R
         ZDcz+SIH1ccVMDODt/c3b5zbiYs4zuaaQmebgvy6yuKCEPuy9BtON1cXQIuqz33Y2oin
         60l9udJUzF2YX/jymIWB4/NauwLpQnKeIVAvlp19phT6jsTAC6x1NYto5xBChsa5HhjE
         oro/llhbLsEKih0ZbXzNBRbdsbtQD7ReG8ExeiSI+/Jqx+KZaB123dHzF/ZoLIev+5Qg
         KjUg==
X-Gm-Message-State: AOAM531tZEZb+PJCuGQKnP0YQ+DFNEZkl0qFa8E3/ZZ/quefNPFTP4ED
        w0UM2qVpI2BIkQ6+GYYu0w==
X-Google-Smtp-Source: ABdhPJwT/ITKR0tXg/1ddqMlf21lgfBAiRqRwlsfzNzLb+nCGUKxM9b0nx1d9t1knadgyrBINu3zMA==
X-Received: by 2002:aca:4c90:: with SMTP id z138mr12042714oia.142.1608579436938;
        Mon, 21 Dec 2020 11:37:16 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id s26sm4001068otd.8.2020.12.21.11.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 11:37:16 -0800 (PST)
Received: (nullmailer pid 422266 invoked by uid 1000);
        Mon, 21 Dec 2020 19:37:14 -0000
Date:   Mon, 21 Dec 2020 12:37:14 -0700
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        mark.rutland@arm.com, nicolas.ferre@microchip.com,
        ludovic.desroches@microchip.com, sre@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: atmel-sysreg: add
 microchip,sama7g5-shdwc
Message-ID: <20201221193714.GA420008@robh.at.kernel.org>
References: <1608123453-1423-1-git-send-email-claudiu.beznea@microchip.com>
 <1608123453-1423-3-git-send-email-claudiu.beznea@microchip.com>
 <20201216134100.GG2814589@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201216134100.GG2814589@piout.net>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Dec 16, 2020 at 02:41:00PM +0100, Alexandre Belloni wrote:
> On 16/12/2020 14:57:32+0200, Claudiu Beznea wrote:
> > Add compatible for Microchip SAMA7G5's shutdown controller.
> > 
> > Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> > ---
> >  Documentation/devicetree/bindings/arm/atmel-sysregs.txt | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> I'm pretty sure the first comment you'll get is to convert this file to
> yaml ;)

I certainly wouldn't object, but just for a new compatible not requiring 
that (yet).

> > diff --git a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
> > index 62cd4e89817c..7990358ac06e 100644
> > --- a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
> > +++ b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
> > @@ -91,7 +91,8 @@ SHDWC SAMA5D2-Compatible Shutdown Controller
> >  1) shdwc node
> >  
> >  required properties:
> > -- compatible: should be "atmel,sama5d2-shdwc" or "microchip,sam9x60-shdwc".
> > +- compatible: should be "atmel,sama5d2-shdwc", "microchip,sam9x60-shdwc" or
> > +  "microchip,sama7g5-shdwc"
> >  - reg: should contain registers location and length
> >  - clocks: phandle to input clock.
> >  - #address-cells: should be one. The cell is the wake-up input index.
> > @@ -103,7 +104,7 @@ optional properties:
> >    microseconds. It's usually a board-related property.
> >  - atmel,wakeup-rtc-timer: boolean to enable Real-Time Clock wake-up.
> >  
> > -optional microchip,sam9x60-shdwc properties:
> > +optional microchip,sam9x60-shdwc or microchip,sama7g5-shdwc properties:
> >  - atmel,wakeup-rtt-timer: boolean to enable Real-time Timer Wake-up.
> >  
> >  The node contains child nodes for each wake-up input that the platform uses.
> > -- 
> > 2.7.4
> > 
> 
> -- 
> Alexandre Belloni, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
