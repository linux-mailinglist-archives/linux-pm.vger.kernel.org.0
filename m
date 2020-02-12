Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFAD159FC7
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2020 05:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgBLELw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Feb 2020 23:11:52 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:52223 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbgBLELw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Feb 2020 23:11:52 -0500
Received: by mail-pj1-f68.google.com with SMTP id fa20so295073pjb.1
        for <linux-pm@vger.kernel.org>; Tue, 11 Feb 2020 20:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W+QTR48OqykWy5/ehCHMs+7sFSz/xjk3FQlT6pd118Y=;
        b=E+06gfvMBiE1Ks3YH7MaemoT8YRv8WXvpxjrb+QqvFOex+72qLSpkgBl5uG49ETpZf
         bmgnQ7pdpz5fhuaROXGdw1HjsXZKHJRPxTOrjbmi+tTr4pNbMvrW/8/gZbj4qF2TzW5u
         J6qDMIkegCf1SRu1ZVfB5QYgvbZq+aAGFqck6Cej66IOntQeldJnAmwtA6kK2O63tEt7
         Q+UQdvS58idwRCQ8Xy7hRID9idiXwkG+shSqFYLWtC7QEVDZEe9v1qNBePtz84IdwoTV
         m0olzSec61urUmNKEHS1DxqXZewjrqKDfRCWo/dvrWwO+oPwac7OTtgYcRLeSQnbkCkV
         +RhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W+QTR48OqykWy5/ehCHMs+7sFSz/xjk3FQlT6pd118Y=;
        b=MQ16Qsk/PzFgN38aPYZ+w66+a8CyiB6Yhh/bLMHkip07dZEax0OPYy4WM8djmh1EZ8
         kEYyF3MmHCMZ7WwST5kqIwGguO2FYILS0l4Co7W32CBco1lfjqeTYbVxzjPf1L7cF/fj
         liNBcHueEIkPiGeT/aOo0disxuGW74/NooJq1LC4F2zWpm5UxoaqVW1bo8zomu6xYCpJ
         huoD+1dt7PjCFpyCNfGAsbFSTIymRZ6QnLDZ3/xABovPR/9bIxfEemCF2rcZIJb3LFJc
         XLcaIb3+aWaXP6+JJZDbDIK3r797xR4H5ihFb92fYdKu/PdHblrCV4/ZerPo5zEDug6H
         D1tQ==
X-Gm-Message-State: APjAAAW7sST+kmyqQee8dlZ+64Zh+pZX5RCKvWgKF/l8v1HCNrQf6iQG
        z/C1Z7JhtbXNYXdlQOB08oGxVw==
X-Google-Smtp-Source: APXvYqw4xtMA6dvfNR7gOlXiS9oB5WsGSZ/+0TAc5So7WwT2pipAfAUhC5o56tc8WfT5SsrQKtzg/Q==
X-Received: by 2002:a17:90a:d80b:: with SMTP id a11mr7716068pjv.142.1581480711508;
        Tue, 11 Feb 2020 20:11:51 -0800 (PST)
Received: from localhost ([122.167.210.63])
        by smtp.gmail.com with ESMTPSA id c3sm6214302pfj.159.2020.02.11.20.11.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Feb 2020 20:11:50 -0800 (PST)
Date:   Wed, 12 Feb 2020 09:41:48 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lokesh Vutla <lokeshvutla@ti.com>
Cc:     linux-pm@vger.kernel.org, Tero Kristo <t-kristo@ti.com>,
        Dave Gerlach <d-gerlach@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] cpufreq: ti-cpufreq: Add support for OPP_PLUS
Message-ID: <20200212041148.vptopihbts7ummb4@vireshk-i7>
References: <20200211072355.5476-1-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211072355.5476-1-lokeshvutla@ti.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11-02-20, 12:53, Lokesh Vutla wrote:
> DRA762 SoC introduces OPP_PLUS which runs at 1.8GHz. Add
> support for this OPP in ti-cpufreq driver.
> 
> Acked-by: Dave Gerlach <d-gerlach@ti.com>
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
>  drivers/cpufreq/ti-cpufreq.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
> index 557cb513bf7f..ab0de27539ad 100644
> --- a/drivers/cpufreq/ti-cpufreq.c
> +++ b/drivers/cpufreq/ti-cpufreq.c
> @@ -25,11 +25,14 @@
>  
>  #define DRA7_EFUSE_HAS_OD_MPU_OPP		11
>  #define DRA7_EFUSE_HAS_HIGH_MPU_OPP		15
> +#define DRA76_EFUSE_HAS_PLUS_MPU_OPP		18
>  #define DRA7_EFUSE_HAS_ALL_MPU_OPP		23
> +#define DRA76_EFUSE_HAS_ALL_MPU_OPP		24
>  
>  #define DRA7_EFUSE_NOM_MPU_OPP			BIT(0)
>  #define DRA7_EFUSE_OD_MPU_OPP			BIT(1)
>  #define DRA7_EFUSE_HIGH_MPU_OPP			BIT(2)
> +#define DRA76_EFUSE_PLUS_MPU_OPP		BIT(3)
>  
>  #define OMAP3_CONTROL_DEVICE_STATUS		0x4800244C
>  #define OMAP3_CONTROL_IDCODE			0x4830A204
> @@ -80,6 +83,10 @@ static unsigned long dra7_efuse_xlate(struct ti_cpufreq_data *opp_data,
>  	 */
>  
>  	switch (efuse) {
> +	case DRA76_EFUSE_HAS_PLUS_MPU_OPP:
> +	case DRA76_EFUSE_HAS_ALL_MPU_OPP:
> +		calculated_efuse |= DRA76_EFUSE_PLUS_MPU_OPP;
> +		/* Fall through */
>  	case DRA7_EFUSE_HAS_ALL_MPU_OPP:
>  	case DRA7_EFUSE_HAS_HIGH_MPU_OPP:
>  		calculated_efuse |= DRA7_EFUSE_HIGH_MPU_OPP;

Applied. Thanks.

-- 
viresh
