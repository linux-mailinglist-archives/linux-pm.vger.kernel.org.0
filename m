Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD095298FE9
	for <lists+linux-pm@lfdr.de>; Mon, 26 Oct 2020 15:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1782095AbgJZOvN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Oct 2020 10:51:13 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37763 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1782090AbgJZOvM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Oct 2020 10:51:12 -0400
Received: by mail-oi1-f194.google.com with SMTP id f7so10738886oib.4
        for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2020 07:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mWob+tzedQRU+r/coolBGzfAZbJH7LoTHZ6SLSxbMY4=;
        b=twUIGiwfWIRMWBeJSy6dgI4GpWSLHpg3THcr1YyNW+Z5jLeHYls96uEMFambf5NboL
         Z5hPI5udjL7TykBpTYqfdhQiGroQJSBHYxqUbkD+eSy4RgOf+drJCHUsQb0gQY4LrXr8
         zxUS2JEuPLIrJ7Rjs4D9kagvqVywc4Or4SsmfPQNB9BuGVo+irPKERbLXXwdnSGeSZ8C
         GUzRL77BG9+zozZciuwVmMcuIRqpwv9txfdbhpMYi1SAd3JYUHNCASvj+GyPJOOb8wYS
         VUxpCtJS0Im6wWHp6hUpXp1Opoiubk0MwV62lp8vhCwZ8edpucuhSo+mwuCQJuPDpLtI
         20ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mWob+tzedQRU+r/coolBGzfAZbJH7LoTHZ6SLSxbMY4=;
        b=Ra/D3KE4G+8ral/P1jwvaDau0bUma6RH+EQPFGRyPboGn3PqRWBI4MLI41kx6cjhID
         lLBKRtc1Bs2Ro5L58yx7UYw5JBhKYl8TXZMVJrapWTEd73szZFyMuFWprvDxikoU3Dkf
         0IBXorW9d88Uav5IuLcT+MiHgEmDYnBc6x03TWAeowZT2yw1yfTg1kEVMqjxLw9CG9ZF
         144ThJaqukcndXHHqxk8kC2YZkwiKVkhaZtMSQ575/sfIVeT0ZaivX593JvklEwwOrw3
         EuUmkNzuK//+NR4RM1222hkLmTMb1F/KRtS4JsFYlRcZ9e1uyKHkw7ULcL7JbQr2qfUp
         pmiw==
X-Gm-Message-State: AOAM530qwriF/nWL9blU5CZGlx2dvw00Ilg2PvYpdRDJJBZoev3ReOxZ
        W/XI7ohZ79oxQEyg0hq1SqDKNQ==
X-Google-Smtp-Source: ABdhPJwo9kp3RaDSpiGBhV+80QW/beHexUe7tsTU0QJgn+iPVr7AP7TlvSJY20fmG/Nkh72BBqi5Bw==
X-Received: by 2002:aca:4e4b:: with SMTP id c72mr1415245oib.96.1603723871230;
        Mon, 26 Oct 2020 07:51:11 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id w3sm4006512oov.48.2020.10.26.07.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 07:51:10 -0700 (PDT)
Date:   Mon, 26 Oct 2020 09:51:08 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: cpus: Document
 'qcom,freq-domain' property
Message-ID: <20201026145108.GG12646@builder.lan>
References: <20201020153944.18047-1-manivannan.sadhasivam@linaro.org>
 <20201026143203.GA112606@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026143203.GA112606@bogus>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon 26 Oct 09:32 CDT 2020, Rob Herring wrote:

> On Tue, Oct 20, 2020 at 09:09:43PM +0530, Manivannan Sadhasivam wrote:
> > Add devicetree documentation for 'qcom,freq-domain' property specific
> > to Qualcomm CPUs. This property is used to reference the CPUFREQ node
> > along with Domain ID (0/1).
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/arm/cpus.yaml | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
> > index 1222bf1831fa..f40564bf004f 100644
> > --- a/Documentation/devicetree/bindings/arm/cpus.yaml
> > +++ b/Documentation/devicetree/bindings/arm/cpus.yaml
> > @@ -290,6 +290,12 @@ properties:
> >  
> >        * arm/msm/qcom,kpss-acc.txt
> >  
> > +  qcom,freq-domain:
> > +    $ref: '/schemas/types.yaml#/definitions/phandle-array'
> > +    description: |
> > +      CPUs supporting freq-domain must set their "qcom,freq-domain" property
> > +      with phandle to a cpufreq_hw node followed by the Domain ID(0/1).
> 
> There's no 3 patches doing the same thing. Mediatek and SCMI are the 
> others. This will need to be common. 
> 

This property is used by existing dtbs for Qualcomm sdm845, sm8150,
sm8250 and sc7180 based devices, so I expect that the support for the
existing property will stay.

Regards,
Bjorn

> > +
> >    rockchip,pmu:
> >      $ref: '/schemas/types.yaml#/definitions/phandle'
> >      description: |
> > -- 
> > 2.17.1
> > 
