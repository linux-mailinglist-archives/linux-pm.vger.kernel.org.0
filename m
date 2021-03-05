Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4180B32F597
	for <lists+linux-pm@lfdr.de>; Fri,  5 Mar 2021 22:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhCEV5U (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Mar 2021 16:57:20 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]:44863 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbhCEV5O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Mar 2021 16:57:14 -0500
Received: by mail-oi1-f174.google.com with SMTP id x20so4111745oie.11;
        Fri, 05 Mar 2021 13:57:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MxDQYRpemmvxub9yE7cZIY4oUHqhC/Xcd1pD0uQpZgs=;
        b=HhYYLtLh/VIqypZ2uM5JrXUTAMOcQ8w45CM+83X+cVX2/1GIqRhQ/5Jr6nyAmGIUsU
         WNNM4BHXR0NF9jCuU3K0M4TIPoQYnOf4E8x9mi2WfyOl4gSSpSYHNRbiH5+XI7WD7arI
         ZRwFaRuaZE+bg2PNSzC/Y8U87dTRuMDbLJpkp0+IV7Z0sQRPwt59hxnoTr/H3l0DiVtb
         rq8UicUEGlok/OnQlgIzeZtrsrfsL7bOOO3s33U1zOo1yfgPtbOIS3qI5mJ7HuxxF0KT
         38paymmzeUlhSdQxTxyIIDxYMlZmYocvRdUqgiAarKcxavo1yEKzF5KxZwMw67anZ9ek
         aKuw==
X-Gm-Message-State: AOAM533edrgobdtB6y4VDpRtFtBD+kskfeFdvzI4MvsTxel9jCvHvfHk
        RxaVpBIDgN9THdD9+4IpsQ==
X-Google-Smtp-Source: ABdhPJwUxY21pvbjFVpIIH/mCjRoozUTiukLrG4+o2FKaMdMb9sVM2rZilFqvv8kppGI5rPg2spFyg==
X-Received: by 2002:aca:1302:: with SMTP id e2mr8517920oii.170.1614981433657;
        Fri, 05 Mar 2021 13:57:13 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a49sm844234otc.37.2021.03.05.13.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 13:57:13 -0800 (PST)
Received: (nullmailer pid 716064 invoked by uid 1000);
        Fri, 05 Mar 2021 21:57:12 -0000
Date:   Fri, 5 Mar 2021 15:57:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: cpufreq: cpufreq-qcom-hw: Document SM8350
 CPUfreq compatible
Message-ID: <20210305215712.GA710574@robh.at.kernel.org>
References: <20210216111251.1838149-1-vkoul@kernel.org>
 <20210217044955.qmbpd43wis7xtjoj@vireshk-i7>
 <20210218124457.GW2774@vkoul-mobl.Dlink>
 <20210218154820.lkcut7a657s6aqeg@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218154820.lkcut7a657s6aqeg@vireshk-i7>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Feb 18, 2021 at 09:18:20PM +0530, Viresh Kumar wrote:
> On 18-02-21, 18:14, Vinod Koul wrote:
> > On 17-02-21, 10:19, Viresh Kumar wrote:
> > > On 16-02-21, 16:42, Vinod Koul wrote:
> > > > Add the CPUfreq compatible for SM8350 SoC along with note for using the
> > > > specific compatible for SoCs
> > > > 
> > > > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > > > ---
> > > >  Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt | 4 +++-
> > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> > > > index 9299028ee712..3eb3cee59d79 100644
> > > > --- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> > > > +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> > > > @@ -8,7 +8,9 @@ Properties:
> > > >  - compatible
> > > >  	Usage:		required
> > > >  	Value type:	<string>
> > > > -	Definition:	must be "qcom,cpufreq-hw" or "qcom,cpufreq-epss".
> > > > +	Definition:	must be "qcom,cpufreq-hw" or "qcom,cpufreq-epss"
> > > > +			along with SoC specific compatible:
> > > > +			  "qcom,sm8350-cpufreq-epss", "qcom,cpufreq-epss"
> > > 
> > > And why is SoC specific compatible required here ? Is the implementation on
> > > sm8350 any different than the ones using "qcom,cpufreq-epss" compatible ?
> > > 
> > > FWIW, the same compatible string must be reused until the time there is
> > > difference in the hardware. The compatible string must be considered as a marker
> > > for a particular version of the hardware.
> > 
> > Rob has indicated that we should use a SoC specific compatible and I
> > agree with that. We are using both soc and generic one here and driver
> > will be loaded for generic one.
> 
> I am not sure of the context, lets see what Rob has to say on this. I
> believe we only need 1 compatible string here (whatever it is), as
> this is just one version of the hardware we are talking about. We
> already have 2 somehow and you are trying to add one more and I don't
> fell good about it. :(

The h/w block is the same features and bugs in every single 
implementation? If not sure, better be safe.

I don't know that I'd go back and add SoC ones for everything though.

Rob
