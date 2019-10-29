Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0A1E7E10
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2019 02:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbfJ2Bgu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Oct 2019 21:36:50 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34657 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727703AbfJ2Bgu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Oct 2019 21:36:50 -0400
Received: by mail-ot1-f67.google.com with SMTP id m19so8432328otp.1;
        Mon, 28 Oct 2019 18:36:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cUdKKEZxRPnFHu2QVFPMIhJT0tZzKagr6VomA8Jxo6Y=;
        b=RF8uAzXmfQbjN12wUWCrpaKS4OJClaip3oXx0EohDaWN5vPfUgWq/6ebBWU+JQ0giA
         R9dyBFFU9FirWgOjoFYvCnZdEPemQ+54XbAkEtdUKE7+Lp8xYkJm1vMLBck65l/ANzGE
         iEWSXop7qAKBXFMysDhcS3pkfIFtAgT1MA62t296QUI8PcMY4r+w6bxkZgZB9wPzXHi2
         Jvcr5OPokbVjHkI/ziWjfiXDN2cFduH9utiq77SMBICiws+WDNImnYWqX/WPuyNQ2Kia
         HWVUZY9fKseQbq6H+UCHgLDBvTGmi3g8KGfpagq6fM3WRlA+gpq+QFGHX0lSwWDdJntL
         SG2A==
X-Gm-Message-State: APjAAAXIldZGjYqKVl79gfsDkjixAkqhLlwMgAHiPDI1I+oBAflOBMfd
        O6fbh8f6lD5rmwmuYEcPBQ==
X-Google-Smtp-Source: APXvYqwxn84pDfRZOnEp1z2t14ueJoGhKjtzuewBpLvrfQbeO2MKZOGKV9rs31NSOa3Nb7V+31MQrg==
X-Received: by 2002:a9d:620c:: with SMTP id g12mr6225748otj.11.1572313009351;
        Mon, 28 Oct 2019 18:36:49 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s3sm3377053otq.76.2019.10.28.18.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 18:36:48 -0700 (PDT)
Date:   Mon, 28 Oct 2019 20:36:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, amit.kucheria@verdurent.com,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 6/7] dt-bindings: soc: qcom: Extend RPMh power
 controller binding to describe thermal warming device
Message-ID: <20191029013648.GB27045@bogus>
References: <1571254641-13626-1-git-send-email-thara.gopinath@linaro.org>
 <1571254641-13626-7-git-send-email-thara.gopinath@linaro.org>
 <CAPDyKFqcKfmnNJ7j4Jb+JH739FBcHg5NBD6aR4H_N=zWGwm1ww@mail.gmail.com>
 <5DA88892.5000408@linaro.org>
 <CAPDyKFpYG7YADb6Xmm=8ug5=5X3d1y+JdkRvrnvtroeV3Yj62Q@mail.gmail.com>
 <5DA89267.30806@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5DA89267.30806@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 17, 2019 at 12:10:15PM -0400, Thara Gopinath wrote:
> On 10/17/2019 11:43 AM, Ulf Hansson wrote:
> > On Thu, 17 Oct 2019 at 17:28, Thara Gopinath <thara.gopinath@linaro.org> wrote:
> >>
> >> Hello Ulf,
> >> Thanks for the review!
> >>
> >> On 10/17/2019 05:04 AM, Ulf Hansson wrote:
> >>> On Wed, 16 Oct 2019 at 21:37, Thara Gopinath <thara.gopinath@linaro.org> wrote:
> >>>>
> >>>> RPMh power controller hosts mx domain that can be used as thermal
> >>>> warming device. Add a sub-node to specify this.
> >>>>
> >>>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> >>>> ---
> >>>>  Documentation/devicetree/bindings/power/qcom,rpmpd.txt | 10 ++++++++++
> >>>>  1 file changed, 10 insertions(+)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.txt b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
> >>>> index eb35b22..fff695d 100644
> >>>> --- a/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
> >>>> +++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
> >>>> @@ -18,6 +18,16 @@ Required Properties:
> >>>>  Refer to <dt-bindings/power/qcom-rpmpd.h> for the level values for
> >>>>  various OPPs for different platforms as well as Power domain indexes
> >>>>
> >>>> += SUBNODES
> >>>> +RPMh alsp hosts power domains that can behave as thermal warming device.
> >>>> +These are expressed as subnodes of the RPMh. The name of the node is used
> >>>> +to identify the power domain and must therefor be "mx".
> >>>> +
> >>>> +- #cooling-cells:
> >>>> +       Usage: optional
> >>>> +       Value type: <u32>
> >>>> +       Definition: must be 2
> >>>> +
> >>>
> >>> Just wanted to express a minor thought about this. In general we use
> >>> subnodes of PM domain providers to represent the topology of PM
> >>> domains (subdomains), this is something different, which I guess is
> >>> fine.
> >>>
> >>> I assume the #cooling-cells is here tells us this is not a PM domain
> >>> provider, but a "cooling device provider"?
> >> Yep.
> >>>
> >>> Also, I wonder if it would be fine to specify "power-domains" here,
> >>> rather than using "name" as I think that is kind of awkward!?
> >> Do you mean "power-domain-names" ? I am using this to match against the
> >> genpd names defined in the provider driver.
> > 
> > No. If you are using "power-domains" it means that you allow to
> > describe the specifier for the provider.
> Yep. But won't this look funny in DT ? The provider node will have a sub
> node with a power domain referencing to itself Like below: Is this ok ?
> 
> rpmhpd: power-controller {
>                                 compatible = "qcom,sdm845-rpmhpd";
>                                 #power-domain-cells = <1>;
> 
> 			...
> 			...
> 				mx_cdev: mx {
>                                         #cooling-cells = <2>;
>                                         power-domains = <&rpmhpd	SDM845_MX>;
>                                 };
> 				

The whole concept here seems all wrong to me. Isn't it what's in the 
power domain that's the cooling device. A CPU power domain is not a 
cooling device, the CPU is. Or we wouldn't make a clock a cooling 
device, but what the clock drives.

Rob
