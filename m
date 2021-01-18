Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A98B2F9DE8
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jan 2021 12:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388876AbhARLTM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Jan 2021 06:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390134AbhARLSv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jan 2021 06:18:51 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E29C061573
        for <linux-pm@vger.kernel.org>; Mon, 18 Jan 2021 03:18:08 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id n7so10751050pgg.2
        for <linux-pm@vger.kernel.org>; Mon, 18 Jan 2021 03:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vCOkqFp410/php68wIRNQR6nVYYVNeZ2EZUFKVUPxHE=;
        b=ezT0GZsmJBLOfurM03WOn2TH3aLnuBejXUqCkZ+NK5SRGAz2JKR3x1O6idpx8Lcj1y
         0DLHQbq74VYLZHUDI9nLk3/HEtEDabFAT9XCZqQZCnLGcktr5ymGPSkqescO+8q0zxz6
         4t09QgDxM2HTQpk1L0jpwMc2iy8lqttqsoH8Lb2Rv0jVDXX7GtOeKpbHmgvhHGqaRlZu
         t45b4ndPwrUdB0XBDGk9eQl0K22WmC7Pd1KzoZXyUrQ04URjcKde2N/Hz6kgLB61T82T
         FQDHpgyT3kty8uiNwyuKBJZREsN/LtS86t+ZwNiEh0mPOGk+8zEXwq656s41toAB97Ce
         kG9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vCOkqFp410/php68wIRNQR6nVYYVNeZ2EZUFKVUPxHE=;
        b=LIubdsnk3EQuLznsK0+zn8Lt2af6YyWbsIFm17EQZgHhCQAoSoeORzQf163lt8EM3D
         ggDx3qXYyBpbaj3dldgWtrtz1iWAP3LrJBdm9gqzC/Ek8n/Ee0YfvswTlEjEKTvuHy9I
         XWoP+pPqrJZjdT5EEFpQJQc8UvSZHLFENvC00my9c2LleoYximYHIf3QhNiAe8vR+hO7
         8o20GX83DNG0HCpFEsdGaGWpQa0r6CwpDcd3k5+13s4xoiFvkQ7/UXDOsgJ23AYeCBBJ
         fLtgiXCNL/dR+BgtW+7a0lUiITW5Xc2NFROLv3SteYGx+47zWi89B3RzSukdMBqwrCBh
         NKBQ==
X-Gm-Message-State: AOAM5329gvSRphmzuZvaGRuSB1mSJ4+b0zbtMJpFOfw3E2jkMkVU0KmT
        6zWdtBgEAiGmJ5G8bcoGkO9bOg==
X-Google-Smtp-Source: ABdhPJyhitKtN+Jw9TBHJr0LGjKjQtmfdaFk9RpKz7yIieZEnFiC+GNt+YuNqD4+blf9WjeEIS9HtQ==
X-Received: by 2002:a62:2e47:0:b029:1b7:840e:edc7 with SMTP id u68-20020a622e470000b02901b7840eedc7mr4547464pfu.52.1610968688492;
        Mon, 18 Jan 2021 03:18:08 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id bv21sm16763805pjb.1.2021.01.18.03.18.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2021 03:18:07 -0800 (PST)
Date:   Mon, 18 Jan 2021 16:48:05 +0530
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
Subject: Re: [PATCH v3 11/12] opp: Handle missing OPP table in
 dev_pm_opp_xlate_performance_state()
Message-ID: <20210118111805.ex5sou3ya2kpue4w@vireshk-i7>
References: <20210118005524.27787-1-digetx@gmail.com>
 <20210118005524.27787-12-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118005524.27787-12-digetx@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18-01-21, 03:55, Dmitry Osipenko wrote:
> NVIDIA Tegra SoCs have a power domains topology such that child domains
> only clamp a power rail, while parent domain controls shared performance
> state of the multiple child domains. In this case child's domain doesn't
> need to have OPP table. Hence we want to allow children power domains to
> pass performance state to the parent domain if child's domain doesn't have
> OPP table.
> 
> The dev_pm_opp_xlate_performance_state() gets src_table=NULL if a child
> power domain doesn't have OPP table and in this case we should pass the
> performance state to the parent domain.
> 
> Tested-by: Peter Geis <pgwipeout@gmail.com>
> Tested-by: Nicolas Chauvet <kwizart@gmail.com>
> Tested-by: Matt Merhar <mattmerhar@protonmail.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/opp/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 7726c4c40b53..ca8c6acc29f4 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -2419,7 +2419,7 @@ int dev_pm_opp_xlate_performance_state(struct opp_table *src_table,
>  	 * and so none of them have the "required-opps" property set. Return the
>  	 * pstate of the src_table as it is in such cases.
>  	 */
> -	if (!src_table->required_opp_count)
> +	if (!src_table || !src_table->required_opp_count)
>  		return pstate;
>  
>  	for (i = 0; i < src_table->required_opp_count; i++) {

Applied. Thanks.

-- 
viresh
