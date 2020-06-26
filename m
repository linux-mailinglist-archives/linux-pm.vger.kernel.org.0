Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65F3D20B596
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jun 2020 18:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbgFZQEe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Jun 2020 12:04:34 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:3260 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725807AbgFZQEe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 26 Jun 2020 12:04:34 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49thXR6fSNz8k;
        Fri, 26 Jun 2020 18:04:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1593187471; bh=dRgqe4wiOWYz7rwvRwaf+FBl8AmPXPxGIWeTwHg9vd0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kf4kOiJY2yMhVY3ZjN968hGBCaGmdNZCB69H58CTeQV8L+hdWjkhUDo1rUqEVetUh
         rBYW5eKriEG1Hm5yFUT0H9XBHWndtFMukzgWxLUY3EdmL5EWFn9YyFUMpbymGSJcBC
         tnKdm8MkdrXklEZfClJmT8yAhBxQK71RzUcqzNg0aMYihysNO3zI/m6lK6tYiIeo76
         2Exqy8Lbl++kvojlQhe+pub53UiPU2Xemdif0kIAWnDnU8brV24xLY/W74ikj5igP4
         SlRfgs3QQ0HAW9DStLd78/L+OlHB6xBDxPP6t/FVemPOYm5LjxQZsEO04HL4to6j3X
         fyEAaaGAT+BWg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.3 at mail
Date:   Fri, 26 Jun 2020 18:04:19 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, thierry.reding@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        jonathanh@nvidia.com, talho@nvidia.com, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, bbasu@nvidia.com,
        mperttunen@nvidia.com
Subject: Re: [TEGRA194_CPUFREQ PATCH v4 1/4] dt-bindings: arm: Add t194
 ccplex compatible and bpmp property
Message-ID: <20200626160419.GA9302@qmqm.qmqm.pl>
References: <1593186236-12760-1-git-send-email-sumitg@nvidia.com>
 <1593186236-12760-2-git-send-email-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1593186236-12760-2-git-send-email-sumitg@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jun 26, 2020 at 09:13:53PM +0530, Sumit Gupta wrote:
> To do frequency scaling on all CPUs within T194 CPU Complex, we need
> to query BPMP for data on valid operating points. Document a compatible
> string under 'cpus' node to represent the CPU Complex for binding drivers
> like cpufreq which don't have their node or CPU Complex node to bind to.
> Also, document a property to point to the BPMP device that can be queried
> for all CPUs.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  Documentation/devicetree/bindings/arm/cpus.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
> index a018147..737b55e 100644
> --- a/Documentation/devicetree/bindings/arm/cpus.yaml
> +++ b/Documentation/devicetree/bindings/arm/cpus.yaml
> @@ -162,6 +162,7 @@ properties:
>        - nvidia,tegra132-denver
>        - nvidia,tegra186-denver
>        - nvidia,tegra194-carmel
> +      - nvidia,tegra194-ccplex
>        - qcom,krait
>        - qcom,kryo
>        - qcom,kryo260
> @@ -255,6 +256,14 @@ properties:
>  
>        where voltage is in V, frequency is in MHz.
>  
> +  nvidia,bpmp:
> +    $ref: '/schemas/types.yaml#/definitions/phandle'
> +    descrption: |
> +      Specifies the bpmp node that needs to be queried to get
> +      operating point data for all CPUs.
> +
> +      Optional for NVIDIA Tegra194 Carmel CPUs

Hi,

The code (next patches) suggests, that the property is relevant for Tegra194
only. If it is required for compatible=tegra194-ccplex, then maybe you can
mark it so (there is already similar constraint described in the file, just
before the example section).

Best Regards,
Micha³ Miros³aw
