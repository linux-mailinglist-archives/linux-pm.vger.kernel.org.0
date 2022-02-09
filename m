Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 150184AEA8C
	for <lists+linux-pm@lfdr.de>; Wed,  9 Feb 2022 07:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234367AbiBIGo4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Feb 2022 01:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234740AbiBIGop (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Feb 2022 01:44:45 -0500
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0369C014F36
        for <linux-pm@vger.kernel.org>; Tue,  8 Feb 2022 22:44:49 -0800 (PST)
Received: by mail-vk1-xa35.google.com with SMTP id m131so618165vkm.7
        for <linux-pm@vger.kernel.org>; Tue, 08 Feb 2022 22:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3iRmgk4sE3G5R6ny6tEUeYqF+37fupjFGhzzwxVHVG8=;
        b=JdppDHBgdz10eh2s8OCsYPjqQBQ8wFWZAWETfQHtXPXaTjFoP7TZCfKLcE9oyZEpkY
         JKxEa+5wNV2aw+nYMiCguaKjOcNDJIobhu9T3yzprebIBHyE8BRFH+DBU1+Zy7XekGrn
         LpkTAy0NR7y6kFQtY4W/pepaKpQJgBVcUfOtPb0wzs5JeFeKpmF6NVXjt24+RVyrZ1pb
         ZohA8eMc6H3yAuu1ns7aLfq4vGCJrbgaeWLWIsBXpsJsH41M93wapFIjEVxtr88d+wFi
         F+HqL+9g1MafeMNADh0yGo5Ji8FaxLT5E7lHSo24/XZlqDu3RK+Dd4pqZClgpUKRyNZz
         cOlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3iRmgk4sE3G5R6ny6tEUeYqF+37fupjFGhzzwxVHVG8=;
        b=j9pnedheBG8g6KwCYxNaiyFfhS5e/drEmY4kftRZRnqSLs2SqWdxBJEnJpVFwzVz3k
         iqMSLnceEhUacPGIB8qubIT6EnJ0Phl1rxLy5kTU1qThy9XUzysQDUOXY7XpcIuDpwOR
         5sVOBu/mvGdL0OsOQNPAjkjy/6t5l3E5g5IsNS2XrGCPt8VXOELQnGC0bFA0AryRnb7W
         Npv+n3rdAQbKx+7oX9i2Se0tyjiq5R1HPmDH1nicwI4zJ2ZhGnpUkVvCFPPGMR2n10it
         np4cnl06h9GJlt7D9xtF9w7IRYgCAIX1ImVy4jfieJWf8X7XRD3jfyNh496gH5TxXfDo
         p07Q==
X-Gm-Message-State: AOAM532tti3cVaOgnaXTy9YOiIMXjJzhyPEk5LiNzk1qUKAkNFKp4NNZ
        fsYeE2qVk0sakHR7YpeTLK5ecYHlBk8BdA==
X-Google-Smtp-Source: ABdhPJy2lLB8xWFpGXYP/CJTJOWd1D0F2Y7DVX2HSlQlSMcbtD2yZI73Kb8Z3Z1TJLOIRyFt3Oh2Hg==
X-Received: by 2002:a05:6a00:88e:: with SMTP id q14mr723726pfj.47.1644388658146;
        Tue, 08 Feb 2022 22:37:38 -0800 (PST)
Received: from localhost ([136.185.132.167])
        by smtp.gmail.com with ESMTPSA id nv13sm5149261pjb.17.2022.02.08.22.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 22:37:37 -0800 (PST)
Date:   Wed, 9 Feb 2022 12:07:35 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Francesco Dolcini <francesco.dolcini@toradex.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Denys Drozdov <denys.drozdov@toradex.com>,
        Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH v2 0/2] Enable i.MX7 SOLO temperature sensor
Message-ID: <20220209063735.552mz6q5cqymv5gx@vireshk-i7>
References: <20220124082803.94286-1-francesco.dolcini@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124082803.94286-1-francesco.dolcini@toradex.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24-01-22, 09:28, Francesco Dolcini wrote:
> To be able to read the T junction on i.MX CPU the imx-cpufreq-dt needs to be
> loaded, however this is currently not the case for i.MX7S given that it does
> have only one operating frequency.
> 
> Add "fsl,imx7s" to cpufreq-dt-platdev blocklist and a single frequency
> operating point to the CPU.
> 
> With that it is now possible to correctly read the CPU T junction.
> 
> Tested on Toradex Colibri iMX7S
> 
> [    6.232577] imx-cpufreq-dt imx-cpufreq-dt: cpu speed grade 0 mkt segment 1 supported-hw 0x1 0x2
> ...
> [    6.880624] imx_thermal 30360000.anatop:tempmon: Extended Commercial CPU temperature grade - max:105C critical:100C passive:95C
> 
> root@colibri-imx7-02983025:~# cat /sys/class/thermal/thermal_zone0/temp 
> 38000
> 
> v2:
>  - removed empty new line
>  - rebased and tested on v5.17-rc1

Applied. Thanks.

-- 
viresh
