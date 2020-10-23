Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5429296B3B
	for <lists+linux-pm@lfdr.de>; Fri, 23 Oct 2020 10:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S460620AbgJWI3p (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Oct 2020 04:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S460622AbgJWI3o (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Oct 2020 04:29:44 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2961EC0613D2
        for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2020 01:29:44 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id b19so486063pld.0
        for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2020 01:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MMav+PtnWA8e0lc96loqiE6mTzZH6xG4l/t4zMITsAk=;
        b=YQ2AKoRwpkty0tvJPPA8WCCIKDOr9TT0bTWA5t2FhKzhb8Ss+jzt3G3AS/k5guH6wq
         tI72tb/I4pZzAHl9BKirKz2Yage3lUKgCDS8DdgzH7cpUBIh3Ad1oYsmvnT7tobdj7VG
         dkhy0/7q1cL2Fzl3+y6xUeWAGbtcUgE4nPH+nKbpSj2OE05m9gWZn/K1ObetheeZob0x
         yafIFMf9P8AYz8MCi8WnOob24dMArObcFn1ZIZ41wCSgzyGdtfo8iuFPNkNM2ciLFX15
         B8iaKwOQQJUJMCdm9o7EHXdgn7Gp8jbdSGwwFZMuWuXWDIbPes52ML1nZVpUMvOGfiTz
         pV6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MMav+PtnWA8e0lc96loqiE6mTzZH6xG4l/t4zMITsAk=;
        b=FnfEInfEgW7/uDcTVsfrHVq8qsyFn9jmf7RBdF0F3iWaki++ojaP0fX/yN3rEk80Gf
         poRcue8jOhUmYlv6Q1GhDMbaMpnwDqtnKngKvCXgwsw5Y5LFd+KeVWGy3J6tdhobiS5Q
         6X6IN/pS5Gf6ARQOxjTisB9T5Iu+dldsFUcFH1W6Sj3YIog72BrPINA7mmo8zIWRIOTf
         E3c8mKEx7ZF+75gbeuuEZT9BMCsWAYHQpr5QGC0+tlSydpMvgyR8SwRRv8aVhrWUYs5D
         JGJIs8tNH2/n4UEkcbRcoXl4BHPezw0skg6fgL1n5z1mgLtwuuqpXVDisEtQ3LgyZg/D
         qKMw==
X-Gm-Message-State: AOAM533fFDxsb3O+CFdDe5+dObJZ988f2wPaYglJDMQLLjTBWVVNH1ab
        YlrVhUPhbM22g2+K6hFB0o+ggg==
X-Google-Smtp-Source: ABdhPJzWK1/wuqJtRsFK0GxzZn3Rmp3+fNzvootOjfC35/ce5xHXdauekDAiOnFpGysDl/EFqjHNZw==
X-Received: by 2002:a17:902:6bc5:b029:d3:f10c:9449 with SMTP id m5-20020a1709026bc5b02900d3f10c9449mr1154917plt.54.1603441783714;
        Fri, 23 Oct 2020 01:29:43 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id e2sm1021057pgd.27.2020.10.23.01.29.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Oct 2020 01:29:43 -0700 (PDT)
Date:   Fri, 23 Oct 2020 13:59:41 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Hector Yuan <hector.yuan@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Maxime Ripard <mripard@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dave Gerlach <d-gerlach@ti.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        wsd_upstream@mediatek.com
Subject: Re: [PATCH v1 2/6] dt-bindings: arm: cpus: Document
 'mtk,freq-domain' property
Message-ID: <20201023082941.yfjewzdsnspug7by@vireshk-i7>
References: <1603441493-18554-1-git-send-email-hector.yuan@mediatek.com>
 <1603441493-18554-3-git-send-email-hector.yuan@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603441493-18554-3-git-send-email-hector.yuan@mediatek.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23-10-20, 16:24, Hector Yuan wrote:
> From: "Hector.Yuan" <hector.yuan@mediatek.com>
> 
> Add devicetree documentation for 'mtk,freq-domain' property specific
> to Mediatek CPUs. This property is used to reference the CPUFREQ node
> along with the domain id.
> 
> Signed-off-by: Hector.Yuan <hector.yuan@mediatek.com>
> ---
>  Documentation/devicetree/bindings/arm/cpus.yaml |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
> index 1222bf1..06a6f5b 100644
> --- a/Documentation/devicetree/bindings/arm/cpus.yaml
> +++ b/Documentation/devicetree/bindings/arm/cpus.yaml
> @@ -255,6 +255,12 @@ properties:
>  
>        where voltage is in V, frequency is in MHz.
>  
> +  mtk-freq-domain:
> +    $ref: '/schemas/types.yaml#/definitions/phandle-array'
> +    description:
> +      CPUs supporting freq-domain must set their "mtk-freq-domain" property
> +      with phandle to a cpufreq_hw node followed by the domain id.
> +

Name should have been mtk,freq-domain I believe. Rob will confirm the
rest.

>    power-domains:
>      $ref: '/schemas/types.yaml#/definitions/phandle-array'
>      description:
> -- 
> 1.7.9.5

-- 
viresh
