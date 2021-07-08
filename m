Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E184A3BF6EB
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jul 2021 10:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbhGHIkL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Jul 2021 04:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbhGHIkL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Jul 2021 04:40:11 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4F2C061574
        for <linux-pm@vger.kernel.org>; Thu,  8 Jul 2021 01:37:29 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id o4so2580807plg.1
        for <linux-pm@vger.kernel.org>; Thu, 08 Jul 2021 01:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ow6TssIgweT/GoAzxSRukYv145LzMR/18ewmHa903tU=;
        b=fttXZFzoq1PFbtzT6GLchigJke//EcyHyL6cuG0NFxsW+gKl90hEVLn+Z6A8QGhs7Y
         UEIIIiugt6qH9dZWB0JhMKIOFrdORsR4qtubn1qCXg4Rn7dv07ktzjKTAh0La7t4n12t
         ZCpmtQBhp77h5hpZJaj/I/su2NJwX+nWQjNXHaTFlxPUwTDVl0Dwa+g3Ma0NlfoOQiXj
         NKDGfAFtspcRP2MvlflXl67RtXOJAaLktk4YEBZaptevxHCoCVtf+ii3q1UR5I24mAg0
         PNqfRuZ19MGwNrcCTKX4hyhcJtbBBtIec9cZBDabnJ1TyocsSRWsiaNy2+MskLFM6X7C
         5G1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ow6TssIgweT/GoAzxSRukYv145LzMR/18ewmHa903tU=;
        b=rSYy+mO4E7OMJHKqrVsWuSHRyi1oG0m4oLTkjYQbJBA0JLHGY0Z6JiMkbQAPaeB/MU
         bZ+NflFK8NMZEuG1Sw0PTMuGQg1FYKgDEOQg1A+W9dZ3dEQbtABg4Cjd+tJoz4TpIb+f
         1H26ztSEdXKxY01SPMpt+1hww7nkjmONJrsjPnsROqsTbvf40jf46kQk+xD+aPJaWN1w
         Q1GYN5t5IezeAGKbeo9I8OtiB8N8/5Hw7+cf/Lslxawnce/Txh59j/fFW2CVNxp7421j
         e2mkh/JDEsSMzGW8HWBkMWwBgDrEe3Q0Wxz6uSmoDKTSFSnn2Pv3ZwvieOY8fwO1oaWe
         mH7A==
X-Gm-Message-State: AOAM530vD4BvYpfsMk5rqT48aBVFrkfcuV6hjiO7EagW+FsAQUfm/KPr
        9tLrGpwocVt8vjTiD7OGqENmXw==
X-Google-Smtp-Source: ABdhPJwy6EnErPIofL/vD7EAud7+o6gts5+joGCEo+xXtxdeyOlzlPOH9f2OIAv6neGs35KZkbJ9zg==
X-Received: by 2002:a17:90a:eb0c:: with SMTP id j12mr7087591pjz.79.1625733448683;
        Thu, 08 Jul 2021 01:37:28 -0700 (PDT)
Received: from localhost ([106.201.108.2])
        by smtp.gmail.com with ESMTPSA id g9sm1782323pfj.49.2021.07.08.01.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 01:37:27 -0700 (PDT)
Date:   Thu, 8 Jul 2021 14:07:25 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     bjorn.andersson@linaro.org, agross@kernel.org, rjw@rjwysocki.net,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        amit.kucheria@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, jami.kettunen@somainline.org,
        paul.bouchara@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht, jeffrey.l.hugo@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v6 3/9] dt-bindings: arm: cpus: Document
 'qcom,freq-domain' property
Message-ID: <20210708083725.ggq66mv5g3w4e6nk@vireshk-i7>
References: <20210701105730.322718-1-angelogioacchino.delregno@somainline.org>
 <20210701105730.322718-4-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210701105730.322718-4-angelogioacchino.delregno@somainline.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01-07-21, 12:57, AngeloGioacchino Del Regno wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Add devicetree documentation for 'qcom,freq-domain' property specific
> to Qualcomm CPUs. This property is used to reference the CPUFREQ node
> along with Domain ID (0/1).
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> ---
>  Documentation/devicetree/bindings/arm/cpus.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
> index f3c7249c73d6..8512fa0147fa 100644
> --- a/Documentation/devicetree/bindings/arm/cpus.yaml
> +++ b/Documentation/devicetree/bindings/arm/cpus.yaml
> @@ -290,6 +290,12 @@ properties:
>  
>        * arm/msm/qcom,kpss-acc.txt
>  
> +  qcom,freq-domain:
> +    $ref: '/schemas/types.yaml#/definitions/phandle-array'
> +    description: |
> +      CPUs supporting freq-domain must set their "qcom,freq-domain" property
> +      with phandle to a cpufreq_hw node followed by the Domain ID(0/1).

We should be moving this driver to the new generic bindings instead.

commit 88bf5a85fe98 ("dt-bindings: dvfs: Add support for generic performance domains")

-- 
viresh
