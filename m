Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7891A330700
	for <lists+linux-pm@lfdr.de>; Mon,  8 Mar 2021 05:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234267AbhCHE5L (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Mar 2021 23:57:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:52766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234258AbhCHE4m (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 7 Mar 2021 23:56:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1F4E2650FD;
        Mon,  8 Mar 2021 04:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615179401;
        bh=/2NI+xWgqlYPKrf2Svu56F53Zb/dbnfUmmgIHBd9jXI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pm3DxdFaKBmo8pTIMLRRCu3BpYA776ndT/g+gl9T2cvAxhnfnFUGoqrs3PZoV/KnS
         pzJoZedzWImwnqnohNxi6Zia4BFyILvyifsSXh1z8oW41RLlTfFDeoJ0ulFzCptef4
         xHBPlpXL6jA1c5JLbTK5U4omKQnk8jhxN1iuiQaD7McNbSCDOHhAAd6JM3OhtX9Nwk
         A4dmS93CeALvV9gKaTQw2hGREv3NjT+BGiDH4ck70Z7qFbvBZOuyugbDEnyq7nbtHG
         dGW+k0J6DCVe1tolkEIkhSgVGrzKbubW7JzZv95qLjImEENjVs+N481TbxXJ18p4j3
         uz4QSI0bXHY3g==
Date:   Mon, 8 Mar 2021 10:26:38 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: cpufreq: cpufreq-qcom-hw: Document SM8350
 CPUfreq compatible
Message-ID: <YEWuhqbNJxmCeSER@vkoul-mobl>
References: <20210216111251.1838149-1-vkoul@kernel.org>
 <20210217044955.qmbpd43wis7xtjoj@vireshk-i7>
 <20210218124457.GW2774@vkoul-mobl.Dlink>
 <20210218154820.lkcut7a657s6aqeg@vireshk-i7>
 <20210305215712.GA710574@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305215712.GA710574@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 05-03-21, 15:57, Rob Herring wrote:
> On Thu, Feb 18, 2021 at 09:18:20PM +0530, Viresh Kumar wrote:
> > On 18-02-21, 18:14, Vinod Koul wrote:
> > > On 17-02-21, 10:19, Viresh Kumar wrote:
> > > > On 16-02-21, 16:42, Vinod Koul wrote:
> > > > > Add the CPUfreq compatible for SM8350 SoC along with note for using the
> > > > > specific compatible for SoCs
> > > > > 
> > > > > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > > > > ---
> > > > >  Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt | 4 +++-
> > > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> > > > > index 9299028ee712..3eb3cee59d79 100644
> > > > > --- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> > > > > +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> > > > > @@ -8,7 +8,9 @@ Properties:
> > > > >  - compatible
> > > > >  	Usage:		required
> > > > >  	Value type:	<string>
> > > > > -	Definition:	must be "qcom,cpufreq-hw" or "qcom,cpufreq-epss".
> > > > > +	Definition:	must be "qcom,cpufreq-hw" or "qcom,cpufreq-epss"
> > > > > +			along with SoC specific compatible:
> > > > > +			  "qcom,sm8350-cpufreq-epss", "qcom,cpufreq-epss"
> > > > 
> > > > And why is SoC specific compatible required here ? Is the implementation on
> > > > sm8350 any different than the ones using "qcom,cpufreq-epss" compatible ?
> > > > 
> > > > FWIW, the same compatible string must be reused until the time there is
> > > > difference in the hardware. The compatible string must be considered as a marker
> > > > for a particular version of the hardware.
> > > 
> > > Rob has indicated that we should use a SoC specific compatible and I
> > > agree with that. We are using both soc and generic one here and driver
> > > will be loaded for generic one.
> > 
> > I am not sure of the context, lets see what Rob has to say on this. I
> > believe we only need 1 compatible string here (whatever it is), as
> > this is just one version of the hardware we are talking about. We
> > already have 2 somehow and you are trying to add one more and I don't
> > fell good about it. :(
> 
> The h/w block is the same features and bugs in every single 
> implementation? If not sure, better be safe.
> 
> I don't know that I'd go back and add SoC ones for everything though.

I would prefer we have SoC ones to be future proof..

-- 
~Vinod
