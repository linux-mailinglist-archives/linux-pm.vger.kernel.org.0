Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01B142FA281
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jan 2021 15:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390990AbhARM0d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Jan 2021 07:26:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390769AbhARLpq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jan 2021 06:45:46 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7943C061575
        for <linux-pm@vger.kernel.org>; Mon, 18 Jan 2021 03:44:54 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id cq1so9343568pjb.4
        for <linux-pm@vger.kernel.org>; Mon, 18 Jan 2021 03:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vOR/+26l9csTfQ4s7cWBdOmYJpkK0DhA7IbvcwD8lYo=;
        b=SbIvM5dUxCMK+wbxk+2R2z7xjDZuMOPvQod5AKuGiAbZGQqpanrYmlPoc34H3fSg2D
         y4B9ZztYLw2XPTDjBgJENmr9dQY3QehtZg9qjq2aaIPMum3xBIhz5CJlJ1cCADZf+uDI
         blQc97m+aCUNe/D4xCZU0fZ9TAb+eQNOM4HQKhckw+fJl1cA876EnBKqoraSjVspUC/d
         8zX149g7+jfEmA/YG2wR9oaiaLI5CpYkMaeFJL0Xnpu6wwdE7C5AfxHRUPfLfcUsjYkU
         9UDxf+ZwWF4B8A9auOb5w59eEw152CXZt0jReEHvgRaxGrkY1pk3SV8JU9nKzRxuggth
         uXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vOR/+26l9csTfQ4s7cWBdOmYJpkK0DhA7IbvcwD8lYo=;
        b=uW8tnUXTCU1/Rcar7OdCdMfcFTxGo249tY29aV2jhnociRb8a68TR+cJTcMY0r6pVK
         YRgDCCpkAgfS2DpnwV2egqx6gbYjMcMQkz6zZccWW3bSpJ0sOj/LagQIeQkVqRop3/Uv
         Pm6AARwIMl+ZLur05ohkXg7hzsUCHI6qCX8nOtUJPC4Gcef3iZf0DHUs4mESMP4VCQQd
         y5r8yL4lhpd2wNZltzjF5MMxDHv4rc447mu7FX6HjAJgrLRZI5U4MvThGSBk1qRGicrX
         7VHEweroetX1UhOd//cCUKG1l4pjIqomtH8fWg/HQWYseXQO0IY1xmfxv898HJUeD4nO
         RdMg==
X-Gm-Message-State: AOAM533Ba3vIArpgUlVA8ZNLRS3PVSb0Y4ABxuK9L7qXe6V7TfOaDSZT
        S9uDyaktczhjkfcV1X5z0z1T/w==
X-Google-Smtp-Source: ABdhPJwbo7Qr06PQPFliKvpgaWWKHR9PVyUZju8iN0jRiAeJnH8XUIzKgkKeeHT+Nb98DIHfaFdCAQ==
X-Received: by 2002:a17:90a:5914:: with SMTP id k20mr25984689pji.199.1610970294461;
        Mon, 18 Jan 2021 03:44:54 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id z6sm15848101pfj.22.2021.01.18.03.44.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2021 03:44:53 -0800 (PST)
Date:   Mon, 18 Jan 2021 17:14:51 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 10/12] opp: Support set_opp() customization without
 requiring to use regulators
Message-ID: <20210118114451.5mpuvgnhhajx4b3y@vireshk-i7>
References: <20210118005524.27787-1-digetx@gmail.com>
 <20210118005524.27787-11-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118005524.27787-11-digetx@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18-01-21, 03:55, Dmitry Osipenko wrote:
> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> index eefd0b15890c..c98fd2add563 100644
> --- a/include/linux/pm_opp.h
> +++ b/include/linux/pm_opp.h
> @@ -13,6 +13,7 @@
>  
>  #include <linux/energy_model.h>
>  #include <linux/err.h>
> +#include <linux/kref.h>
>  #include <linux/notifier.h>
>  
>  struct clk;
> @@ -74,6 +75,7 @@ struct dev_pm_opp_info {
>   * @regulator_count: Number of regulators
>   * @clk:	Pointer to clk
>   * @dev:	Pointer to the struct device
> + * @kref:	Reference counter
>   *
>   * This structure contains all information required for setting an OPP.
>   */
> @@ -85,6 +87,7 @@ struct dev_pm_set_opp_data {
>  	unsigned int regulator_count;
>  	struct clk *clk;
>  	struct device *dev;
> +	struct kref kref;
>  };

Instead of kref thing, allocate the memory for supplies from
dev_pm_opp_set_regulators() and store it in new entries in opp-table
and for rest of the data from dev_pm_opp_register_set_opp_helper(), to
which you can copy supplies pointers then.

-- 
viresh
