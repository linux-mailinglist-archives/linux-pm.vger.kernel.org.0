Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC12729D8F0
	for <lists+linux-pm@lfdr.de>; Wed, 28 Oct 2020 23:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389046AbgJ1Wkd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Oct 2020 18:40:33 -0400
Received: from mail-oo1-f68.google.com ([209.85.161.68]:34204 "EHLO
        mail-oo1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388995AbgJ1Wkc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2020 18:40:32 -0400
Received: by mail-oo1-f68.google.com with SMTP id f1so281719oov.1;
        Wed, 28 Oct 2020 15:40:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lKXnB8xG2TaqVrvcPL6FA2z+YJ8ahfjSqGNyGDBltcU=;
        b=JTKs07W4m6Xy59Cl7cCd004l7SUKimDXcDryG4BPm3/jU2mgU2EXW+Ef6j7zshlHNn
         ojrGGP8CEDmGfIdO7APe0y9hIiHVQLyZppqyXXhKVr1049acnh9gBQxiQBhDFIMp0UDZ
         bMMqPcsEJMwCKTdIFV3v/w4JqtTZZ2TeC9dbDN6c8UYQudd+s+8bGxlho31Yqpdr8wb6
         forYLRZz5+DmU6H2hKSlLLQwx8GZVhkIW9FTWs4z45/eVOQqA5OOZn7AAr5p8nQ9oWMb
         06bg5D2/U9pLmCbFi8V0/wn20G+eGFOHQRJEeKEozwKuFY/y//DNKilAw/QJR74I0r1T
         IqTA==
X-Gm-Message-State: AOAM530MSOMWwMzi/kIKFJdOJoTZiMKEui48004C7cLcUYesLqfaIOAt
        gcm4jJS/99VAIlblgQR34r1NxHFh8g==
X-Google-Smtp-Source: ABdhPJxGfgDHb9sV61QRZqr3+b2EpSc8QEOhlDV3yJBm7iPuuiiW0sXa+K9nzL2t0RXDsbchOOiWDg==
X-Received: by 2002:a9d:6751:: with SMTP id w17mr5813231otm.7.1603899520503;
        Wed, 28 Oct 2020 08:38:40 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g3sm2824247oif.26.2020.10.28.08.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 08:38:39 -0700 (PDT)
Received: (nullmailer pid 4071712 invoked by uid 1000);
        Wed, 28 Oct 2020 15:38:38 -0000
Date:   Wed, 28 Oct 2020 10:38:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: cpus: Document
 'qcom,freq-domain' property
Message-ID: <20201028153838.GA4065833@bogus>
References: <20201020153944.18047-1-manivannan.sadhasivam@linaro.org>
 <20201026143203.GA112606@bogus>
 <20201026145108.GG12646@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026145108.GG12646@builder.lan>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 26, 2020 at 09:51:08AM -0500, Bjorn Andersson wrote:
> On Mon 26 Oct 09:32 CDT 2020, Rob Herring wrote:
> 
> > On Tue, Oct 20, 2020 at 09:09:43PM +0530, Manivannan Sadhasivam wrote:
> > > Add devicetree documentation for 'qcom,freq-domain' property specific
> > > to Qualcomm CPUs. This property is used to reference the CPUFREQ node
> > > along with Domain ID (0/1).
> > > 
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > ---
> > >  Documentation/devicetree/bindings/arm/cpus.yaml | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
> > > index 1222bf1831fa..f40564bf004f 100644
> > > --- a/Documentation/devicetree/bindings/arm/cpus.yaml
> > > +++ b/Documentation/devicetree/bindings/arm/cpus.yaml
> > > @@ -290,6 +290,12 @@ properties:
> > >  
> > >        * arm/msm/qcom,kpss-acc.txt
> > >  
> > > +  qcom,freq-domain:
> > > +    $ref: '/schemas/types.yaml#/definitions/phandle-array'
> > > +    description: |
> > > +      CPUs supporting freq-domain must set their "qcom,freq-domain" property
> > > +      with phandle to a cpufreq_hw node followed by the Domain ID(0/1).
> > 
> > There's no 3 patches doing the same thing. Mediatek and SCMI are the 
> > others. This will need to be common. 
> > 
> 
> This property is used by existing dtbs for Qualcomm sdm845, sm8150,
> sm8250 and sc7180 based devices, so I expect that the support for the
> existing property will stay.

Indeed. Any of these can tolerate a change here?

We should still take QCom into account for whatever is come up with for 
a common binding.

Rob
