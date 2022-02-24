Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE304C27E6
	for <lists+linux-pm@lfdr.de>; Thu, 24 Feb 2022 10:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbiBXJPm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Feb 2022 04:15:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbiBXJPl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Feb 2022 04:15:41 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E632782B1
        for <linux-pm@vger.kernel.org>; Thu, 24 Feb 2022 01:15:11 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id ev16-20020a17090aead000b001bc3835fea8so1543260pjb.0
        for <linux-pm@vger.kernel.org>; Thu, 24 Feb 2022 01:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WRVIFs33r3ON7s1O5MK2VQ5yAl5/kACrQl2hNe16evw=;
        b=GCPGvdX/eISdLly2vk3dhEEi+lVSWWrO4ahjSb7Lt4tn45dcNW2r6lrkWgQEsaHWX8
         y2DYlh84/4V3i7EemGnX2oFVBHVCxK2n2VZRcux/SDYFVrQiGZ8W7OXeWVnkXb6hxFQj
         nR5FceRzgms6kc9qesmO9rpcFUz7X5S9molA5Zj+qPZ4NDCrm7v1y9fJzwbl3CTF1QS0
         sPHWAwzXs0JEMH61MwV24mYzvbwdyoMsvfFtO9StDtAsynaIwWdmoyev7pJeCfl4OuJP
         U6yfgmSOSeMqYG4VyLqa0m8X/2UXAh5F4hYkRCq8kjUrRLwj1G2oe1rp2bCTp/m5n+Bh
         2cHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WRVIFs33r3ON7s1O5MK2VQ5yAl5/kACrQl2hNe16evw=;
        b=4wECiYsWeH60PWtt5DVFmGFCkE0ET+7xCJ6gA+2Oz2KHIBWp2dOvzq2YlEsbe7Lhxt
         XTcOC5dyAF3FI1lAc/IqBCEUs8CN9JU08yPn7bziMr8CBiEpyTKoINtfLm9dNFxOn9jU
         UxBUKP1hBE/fvqvAeSmp02q1UMSLGNaz6gVBGxwJJaYI0nSh1l8rP7R3OFWLgth8iAsA
         V09lBjIB1c7Wa3pZeC9xn4zOfNoLPfvEKgRxVKDZVskwRvLgXZKKqVijweseKFSpEihu
         Dr2Epmmu4Vx5WhA8bky4XDwieOboG5A8lMyNJ9CI9RZvnLU7hxiiGwUdBh7tXMPpccw0
         UNRw==
X-Gm-Message-State: AOAM532tEq7CvB6tXgYZdXiBfQ8mUpKurrmo2XYqJb2rmXoH1TycTCJg
        8l/wvGA5y84xc5ORbVxpr0mgVg==
X-Google-Smtp-Source: ABdhPJxDumVEcgQbj8SI+qzLPCB1IEGyK0sHFknDJM7Kt/qk4jg1FEeJP0d6CydRNEOVFq9rQyOjRg==
X-Received: by 2002:a17:902:7403:b0:14f:9f55:f9e6 with SMTP id g3-20020a170902740300b0014f9f55f9e6mr1917652pll.21.1645694110595;
        Thu, 24 Feb 2022 01:15:10 -0800 (PST)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id t22sm2905028pfg.92.2022.02.24.01.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 01:15:10 -0800 (PST)
Date:   Thu, 24 Feb 2022 14:45:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, nm@ti.com,
        sboyd@kernel.org, mka@chromium.org, dianders@chromium.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 4/4] Documentation: EM: Describe new registration
 method using DT
Message-ID: <20220224091508.fp7emu2zyhavkfkt@vireshk-i7>
References: <20220224081131.27282-1-lukasz.luba@arm.com>
 <20220224081131.27282-5-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224081131.27282-5-lukasz.luba@arm.com>
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

On 24-02-22, 08:11, Lukasz Luba wrote:
> The new registration method allows to get power values from the DT OPP
> definition. The new OPP entry property "opp-microwatt" contains total
> power expressed in micro-Watts. Align the EM documentation with this
> new possible registration method of 'advanced' EM.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  Documentation/power/energy-model.rst | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/power/energy-model.rst b/Documentation/power/energy-model.rst
> index 5ac62a7b4b7c..719253fd5215 100644
> --- a/Documentation/power/energy-model.rst
> +++ b/Documentation/power/energy-model.rst
> @@ -113,6 +113,16 @@ to: return warning/error, stop working or panic.
>  See Section 3. for an example of driver implementing this
>  callback, or Section 2.4 for further documentation on this API
>  
> +Registration of 'advanced' EM using DT

I am not really sure if this should be called *Advanced*. Just call it
registration of EM using DT.

> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The 'advanced' EM can also be registered using OPP framework and information
> +in DT "operating-points-v2". Each OPP entry in DT can be extended with a
> +property "opp-microwatt" containing micro-Watts power value. This OPP DT
> +property allows a platform to register EM power values which are reflecting
> +total power (static + dynamic). These power values might be coming directly
> +from experiments and measurements.
> +
>  Registration of 'simple' EM
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  
> -- 
> 2.17.1

-- 
viresh
