Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E1D29D902
	for <lists+linux-pm@lfdr.de>; Wed, 28 Oct 2020 23:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388986AbgJ1Wlk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Oct 2020 18:41:40 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:41525 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731064AbgJ1Wlk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2020 18:41:40 -0400
Received: by mail-ua1-f67.google.com with SMTP id b34so181406uab.8;
        Wed, 28 Oct 2020 15:41:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ifdl6rm0gNvcSFKZ5I/tiV7YK1rwdOd+QhoFYwULzTg=;
        b=psODguIavg8esBbE+vLlNOr8dliLd38X24ndBpKLiM3QEJE0NHdLaXXhaMvI5eGX3T
         /vt7yEPoOPrsUeUEVr4/Ow1odoXmlAmV35jWUlND3QXArD7rO15yRQUuyk7G+sC8Z+LJ
         okm+wAo7l2dInQGCktB03YEDmcJHl9o70T2ds6RWPFsXdtajx863Q3pEYNmUEr1P+NX+
         od8+Kqpsi3Xu6vmd0/Tz+7aX1kTAaVF2lAZPe5JHVcfDPHIJvIZjv4yoJQHJBgwADaOA
         9js/QOO7UWPrLA+osrOM2ZwtWL70pU2xBRkf00xiiSTcsF5gdw0xojUY5dhhbGjHGCh6
         OzNg==
X-Gm-Message-State: AOAM533GthAXfcMpvzqO8UJjrP6mHZ8diBaslAFG0DtgIKWOrUwKMZ2w
        pm1wZJfnybDfqToA2zrOADxhpLlevQ==
X-Google-Smtp-Source: ABdhPJziwrjiHTpXAkJ8pP/F82V8cE+tb5yLZhtJRaSIq9hNGSvT/Lg+akyRINC2pPgUjGmP9rs+Lw==
X-Received: by 2002:a9d:a0d:: with SMTP id 13mr5267372otg.348.1603899998892;
        Wed, 28 Oct 2020 08:46:38 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d17sm2146587ote.47.2020.10.28.08.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 08:46:38 -0700 (PDT)
Received: (nullmailer pid 4082138 invoked by uid 1000);
        Wed, 28 Oct 2020 15:46:37 -0000
Date:   Wed, 28 Oct 2020 10:46:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Hector Yuan <hector.yuan@mediatek.com>, rjw@rjwysocki.net,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: cpus: Document
 'qcom,freq-domain' property
Message-ID: <20201028154637.GB4065833@bogus>
References: <20201020153944.18047-1-manivannan.sadhasivam@linaro.org>
 <1603247803.20224.5.camel@mtkswgap22>
 <20201021095916.GA3334@Mani-XPS-13-9360>
 <20201021105037.vrqgmvbxxhccch33@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021105037.vrqgmvbxxhccch33@vireshk-i7>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 21, 2020 at 04:20:37PM +0530, Viresh Kumar wrote:
> On 21-10-20, 15:29, Manivannan Sadhasivam wrote:
> > Hi,
> > 
> > On Wed, Oct 21, 2020 at 10:36:43AM +0800, Hector Yuan wrote:
> > > Hi, Manivannan
> > > 
> > > On Tue, 2020-10-20 at 21:09 +0530, Manivannan Sadhasivam wrote:
> > > > Add devicetree documentation for 'qcom,freq-domain' property specific
> > > > to Qualcomm CPUs. This property is used to reference the CPUFREQ node
> > > > along with Domain ID (0/1).
> > > > 
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > ---
> > > >  Documentation/devicetree/bindings/arm/cpus.yaml | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
> > > > index 1222bf1831fa..f40564bf004f 100644
> > > > --- a/Documentation/devicetree/bindings/arm/cpus.yaml
> > > > +++ b/Documentation/devicetree/bindings/arm/cpus.yaml
> > > > @@ -290,6 +290,12 @@ properties:
> > > >  
> > > >        * arm/msm/qcom,kpss-acc.txt
> > > >  
> > > > +  qcom,freq-domain:
> > > Do you mind to change "qcom, freq-domain" to common naming? or drop the
> > > prefix. So that we can use this CPU node and map it to each freq-domain.
> > > Thanks a lot. 
> > 
> > I can do that but did the domain value match for other platforms as well?
> 
> I am not sure if you can. The code needs to be backward compatible so it can
> support all devices shipped with older bootloaders and latest kernels. And so
> changing the bindings isn't a good idea normally.

It can be done. We'd need to do the following:

- schema defines the common property/binding.
- The kernel supports both names and that is backported to stable.
- Update all the Qcom dts files to the new binding

Whether we actually do that or not, I'd like to keep the option open. 
Aligning the current proposals should be possible. My concern is more 
about what's the next addition and non-cpu device support.

Rob
