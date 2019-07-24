Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39AD8732B1
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2019 17:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfGXP07 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jul 2019 11:26:59 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36602 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfGXP07 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jul 2019 11:26:59 -0400
Received: by mail-io1-f67.google.com with SMTP id o9so90519416iom.3;
        Wed, 24 Jul 2019 08:26:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3pDFUgVV3AzO747g/R1qutUAuLnJGEUD5MXGKcmRXCQ=;
        b=EAc153ZgiuZkJetsVVoLbxnW/pOgGWTrsX32xsN7oNaL5ORLWBMjIDkmGxvEAVPt1l
         XB4Wy6swLPkn/4U99rTT2P7tZF1WWkbUkNjBeRxZY7aMDGk4R7KHuws19wYH/MJMy2Tt
         x8U+BLs+yXNys5k8VREsRUlWmja3nQO/uE7MgltRvs1m2IFIZhiqeXUmm3lDMnJbufN2
         jQAPGyW93INtE3laYP4A0ljnL4rs+DcTA0sLEL3xRob3PF69CY/l1yEcJzRzzSLk2viM
         YgtGnMhROH7hX8kPRRtIpJAILDLZ2wn7/4zVLqKc61KZn9cYjIiYTY8xYlaJtjr0pxSM
         kL7w==
X-Gm-Message-State: APjAAAU1CsDsZ8ao0l6pPzVFJ5CRpqEqqBwKFZ9J9RTMhBr6rkowL5QG
        BK27g0+z9paKJ4bPojNkWjN3chA=
X-Google-Smtp-Source: APXvYqyjYTxl+fWY/wVpycSkzeXpA0EkAIzEOM0ykFzfmrDkAfA42dR6m3nn1rJEdvDtDN8wtaJm2g==
X-Received: by 2002:a02:5185:: with SMTP id s127mr15626392jaa.44.1563982018545;
        Wed, 24 Jul 2019 08:26:58 -0700 (PDT)
Received: from localhost ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id r24sm33807658ioc.76.2019.07.24.08.26.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 08:26:57 -0700 (PDT)
Date:   Wed, 24 Jul 2019 09:26:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Ilia Lin <ilia.lin@kernel.org>, Andy Gross <agross@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        jorge.ramirez-ortiz@linaro.org, bjorn.andersson@linaro.org,
        ulf.hansson@linaro.org, Mark Rutland <mark.rutland@arm.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/13] dt-bindings: cpufreq: qcom-nvmem: Support pstates
 provided by a power domain
Message-ID: <20190724152656.GA10017@bogus>
References: <20190705095726.21433-1-niklas.cassel@linaro.org>
 <20190705095726.21433-6-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705095726.21433-6-niklas.cassel@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 05, 2019 at 11:57:16AM +0200, Niklas Cassel wrote:
> Some Qualcomm SoCs have support for Core Power Reduction (CPR).
> On these platforms, we need to attach to the power domain provider
> providing the performance states, so that the leaky device (the CPU)
> can configure the performance states (which represent different
> CPU clock frequencies).
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> ---
>  .../bindings/opp/qcom-nvmem-cpufreq.txt       | 111 ++++++++++++++++++
>  1 file changed, 111 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt b/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
> index c5ea8b90e35d..e19a95318e98 100644
> --- a/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
> +++ b/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
> @@ -23,6 +23,15 @@ In 'operating-points-v2' table:
>  
>  Optional properties:
>  --------------------
> +In 'cpus' nodes:

In 'cpus' node or 'cpu' nodes?

> +- power-domains: A phandle pointing to the PM domain specifier which provides
> +		the performance states available for active state management.
> +		Please refer to the power-domains bindings
> +		Documentation/devicetree/bindings/power/power_domain.txt
> +		and also examples below.
> +- power-domain-names: Should be
> +	- 'cpr' for qcs404.
> +
>  In 'operating-points-v2' table:
>  - nvmem-cells: A phandle pointing to a nvmem-cells node representing the
>  		efuse registers that has information about the
