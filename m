Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D9131EA52
	for <lists+linux-pm@lfdr.de>; Thu, 18 Feb 2021 14:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbhBRNPs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Feb 2021 08:15:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:53690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231791AbhBRM5J (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 18 Feb 2021 07:57:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC97C6023C;
        Thu, 18 Feb 2021 12:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613652301;
        bh=s7m6e8MgvP5IaBe7fZhQQGsTvRr9vg/yYbEFLpbXV7s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s9Jl/A+S2ZuncLL1pzR7Lvw2456VeI3RGhpA4xY+EBOt0IGBOneKFoSkoWAHxj+k0
         hTvkpIylKTCaa9sJA2sfJzh3SRQdk3+N1XSyklDc5lwfT6ZQDs1AqbfUXZXhpByBWB
         3lQMiuDiQxEAUeQpHAsd/x1roLMS8qtzAms9wneeTY06jaZd25nRXPSiafwsQMrBQa
         3WC3Yud/+qGFt4LNQEH7hWJwBA31YtyJxyai0w24482/pn6WbLhOqQDQbFXfLDDtSC
         R7YvESO1GpFNx9GqNZItCHNA/Xvsn4yVUuENgSB911WbnA4ua62ta+Ywvr/MHpXH5K
         zicQ2Z/oFnz/w==
Date:   Thu, 18 Feb 2021 18:14:57 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: cpufreq: cpufreq-qcom-hw: Document SM8350
 CPUfreq compatible
Message-ID: <20210218124457.GW2774@vkoul-mobl.Dlink>
References: <20210216111251.1838149-1-vkoul@kernel.org>
 <20210217044955.qmbpd43wis7xtjoj@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210217044955.qmbpd43wis7xtjoj@vireshk-i7>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17-02-21, 10:19, Viresh Kumar wrote:
> On 16-02-21, 16:42, Vinod Koul wrote:
> > Add the CPUfreq compatible for SM8350 SoC along with note for using the
> > specific compatible for SoCs
> > 
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> > index 9299028ee712..3eb3cee59d79 100644
> > --- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> > +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> > @@ -8,7 +8,9 @@ Properties:
> >  - compatible
> >  	Usage:		required
> >  	Value type:	<string>
> > -	Definition:	must be "qcom,cpufreq-hw" or "qcom,cpufreq-epss".
> > +	Definition:	must be "qcom,cpufreq-hw" or "qcom,cpufreq-epss"
> > +			along with SoC specific compatible:
> > +			  "qcom,sm8350-cpufreq-epss", "qcom,cpufreq-epss"
> 
> And why is SoC specific compatible required here ? Is the implementation on
> sm8350 any different than the ones using "qcom,cpufreq-epss" compatible ?
> 
> FWIW, the same compatible string must be reused until the time there is
> difference in the hardware. The compatible string must be considered as a marker
> for a particular version of the hardware.

Rob has indicated that we should use a SoC specific compatible and I
agree with that. We are using both soc and generic one here and driver
will be loaded for generic one.

Thanks
-- 
~Vinod
