Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47FD5F2517
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2019 03:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbfKGCP6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Nov 2019 21:15:58 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39074 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfKGCP6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Nov 2019 21:15:58 -0500
Received: by mail-pl1-f194.google.com with SMTP id o9so366264plk.6
        for <linux-pm@vger.kernel.org>; Wed, 06 Nov 2019 18:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4cKuNUYvAqunvz+72B7anlYEtcmjqeC5FeNltzDFT5k=;
        b=T59vipNJYtRlVOnfzcZA23VauEahxy7MNspU0b7oX2ekYAE3qzT7B/EnaGYttLoMDQ
         TkM+K1VxwwR9r3IAcW2Flh4PVi7CpxcgKYiJ1Gp5/FrciIQBzjIveyNa6BeFvA0Cg05m
         iiljd57ipGroXvyQ0j/MtNI8E5IYIdVFMfilWKgYNhHQNn99lk+fFSHl2AfsNCElOeyb
         rGDw6zIdYgXGq1SmHNxizrDSS33B0eYcuUOsZeL2H0R8tqygnUZK2kuENLHQVCDiHSXr
         FjS14E2QKkU0EZ8CxEoVy3Em0+YdFMq2F86KoKPL8YywVWgvqHj1U6OEJg1mNqlq4fmd
         BB1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4cKuNUYvAqunvz+72B7anlYEtcmjqeC5FeNltzDFT5k=;
        b=gPKNts8+3lG1tTgAXMHPG0HKPgm+TzRnKeNyp3uWqt2LKkC/qowJMVsjpPP8t+TzIg
         EP0WLpMq/e732230OEx+RytokcZKZkg8UAT0ROOZummbuvNVVDNZRWJgqWouKBV1C0Vs
         ZnOcnmRUyOucgXy6T8CQcOZT2BZNeODJezv3wV+4V7HVCyUpp4bseItNbsoDyQacuRiD
         UvjG840GVWZF03kskHFEriRKkXOccCUyK1IDRYL/GG60c+Aq5o+wstzPCy4D+QGx1LId
         OAqWMOu32LM9Do7XM9IpWiqmzH5S3/POwm1nzsQCOhUHG3WhoEgPjVnO/9LV7Qyh08KW
         EdbA==
X-Gm-Message-State: APjAAAUbFuhZ58eUG6gbxRvGYSYi83t/sBscXq18u7nYvjnvAxC6oUi9
        xaIa0djPv0tW8ZCcFb5OUqVkRQ==
X-Google-Smtp-Source: APXvYqzCKzlvkuqzRAncs0ielDj0zuGNM9QqxzhWJxgll4/9/pZjwl3R0uj4+gXExMgSAmRcPke6aw==
X-Received: by 2002:a17:902:102:: with SMTP id 2mr1010877plb.156.1573092957436;
        Wed, 06 Nov 2019 18:15:57 -0800 (PST)
Received: from localhost ([122.171.110.253])
        by smtp.gmail.com with ESMTPSA id 70sm326657pfw.160.2019.11.06.18.15.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 18:15:56 -0800 (PST)
Date:   Thu, 7 Nov 2019 07:45:52 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, edubezval@gmail.com,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Guillaume La Roque <glaroque@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Javi Merino <javi.merino@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jun Nie <jun.nie@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 01/11] thermal: of-thermal: Appease the kernel-doc deity
Message-ID: <20191107021552.qlg2xvan6sajntgm@vireshk-i7>
References: <cover.1573046440.git.amit.kucheria@linaro.org>
 <ebd5991d5554202893fbcab4707be6d26f502aef.1573046440.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebd5991d5554202893fbcab4707be6d26f502aef.1573046440.git.amit.kucheria@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06-11-19, 18:58, Amit Kucheria wrote:
> Replace a comment starting with /** by simply /* to avoid having
> it interpreted as a kernel-doc comment.
> 
> Fixes the following warning when compile with make W=1:
> linux.git/drivers/thermal/of-thermal.c:761: warning: cannot understand function prototype: 'const char *trip_types[] = '
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/thermal/of-thermal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
> index dc5093be553ec..5235aed2fadd5 100644
> --- a/drivers/thermal/of-thermal.c
> +++ b/drivers/thermal/of-thermal.c
> @@ -754,7 +754,7 @@ static int thermal_of_populate_bind_params(struct device_node *np,
>  	return ret;
>  }
>  
> -/**
> +/*
>   * It maps 'enum thermal_trip_type' found in include/linux/thermal.h
>   * into the device tree binding of 'trip', property type.
>   */

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
