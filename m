Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F235A420612
	for <lists+linux-pm@lfdr.de>; Mon,  4 Oct 2021 08:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbhJDGzd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Oct 2021 02:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbhJDGzc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Oct 2021 02:55:32 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55AFAC061746
        for <linux-pm@vger.kernel.org>; Sun,  3 Oct 2021 23:53:44 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id na16-20020a17090b4c1000b0019f5bb661f9so7603741pjb.0
        for <linux-pm@vger.kernel.org>; Sun, 03 Oct 2021 23:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MDRfZ7xXIFtmRSvzU6mcij8bUIp/DMbOkHB0+A48Ad0=;
        b=aVv1Kf9yUsOLpaX87dcD5Hin5Rdq499h1qqUIRSr/PAEdjgI+EGm/gMAauojeSMgcQ
         yfX89YvW3HZRf/Ist/jfzY7LERsm1HXeycB1KP6p6hzCRMIbdnIxpFipOwJ5F9B22iMR
         UzzBY353l9qcXYV5gXweu5c/3f5jettCiFESex/14cEifMV4O4W4xbc+E7fHcNUmBrnb
         CMFMbYMJVHFXzFMEbVmRGY0ZekRy8bwArU9eR6rT4+R7YZ6HpVkFqkYgIE46UkyKPwKu
         CZ8dZaZv1ms1/JYvChItjCJt5mEl1HB3d55ZYF9czjQIrxE8QvVPKCumJEWyEH2sNBci
         R/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MDRfZ7xXIFtmRSvzU6mcij8bUIp/DMbOkHB0+A48Ad0=;
        b=ZX08cBE+oLLUmclwTPhwGNuOHWKNpGRGP/6UCaRgPAZeTtsFz3Xh0nqz/7zMRVm8tE
         QOE99fT1jH8hAgKsaub68iqohte0NiMt+++ncccJGDdZZMjSlLAC5zpuskLRY/y5alVU
         KEBDnvNTusi8NwgRtrjilNdt7f4wTTNQUoeUNhpd5Bu5dPcaaA4KWe9m4jSsRvin1UYo
         YcY0lhlTViOyQwSHvEKxljjY71kNVrzM8+mmSDYQY6MuXHbJa4hNnG4d15ZBGAhRkGnU
         7Jpb5YXk6HA5l6W6YSi0TH4BUU4iFSw+iVadi62bEtR069iV2KK8JDAp91Pl5vs5dddT
         OM8g==
X-Gm-Message-State: AOAM532hH1eLQqTOcP8HftcHWO36tobJylKTPwNtiVH1dQCxRAP6Ed2a
        G6l2ontjrmeTRYqYoWim6vyJ0g==
X-Google-Smtp-Source: ABdhPJyqxEEbmmpXYWNr/esn1IX5Ja1t4KSBy0rO92HYhf96C/jbB6vvPA9fI+fWpwKi28uTcPNUMw==
X-Received: by 2002:a17:90b:4b4c:: with SMTP id mi12mr6079865pjb.57.1633330423788;
        Sun, 03 Oct 2021 23:53:43 -0700 (PDT)
Received: from localhost ([122.171.247.18])
        by smtp.gmail.com with ESMTPSA id o72sm9399259pjo.50.2021.10.03.23.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 23:53:43 -0700 (PDT)
Date:   Mon, 4 Oct 2021 12:23:41 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Pavankumar Kondeti <pkondeti@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] opp: Fix required-opps phandle array count check
Message-ID: <20211004065341.yuysdtwvbfypazue@vireshk-i7>
References: <1632996548-11647-1-git-send-email-pkondeti@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1632996548-11647-1-git-send-email-pkondeti@codeaurora.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30-09-21, 15:39, Pavankumar Kondeti wrote:
> The 'required-opps' property is optional. So of_count_phandle_with_args()
> can return -ENOENT when queried for required-opps. Handle this case.
> 
> Signed-off-by: Pavankumar Kondeti <pkondeti@codeaurora.org>
> ---
>  drivers/opp/of.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 2a97c65..5437085 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -170,7 +170,7 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
>  	}
>  
>  	count = of_count_phandle_with_args(np, "required-opps", NULL);
> -	if (!count)
> +	if (count <= 0)
>  		goto put_np;
>  
>  	required_opp_tables = kcalloc(count, sizeof(*required_opp_tables),

Applied. Thanks.

-- 
viresh
