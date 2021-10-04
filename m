Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4474209B6
	for <lists+linux-pm@lfdr.de>; Mon,  4 Oct 2021 13:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbhJDLGP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Oct 2021 07:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbhJDLGO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Oct 2021 07:06:14 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BC9C061749
        for <linux-pm@vger.kernel.org>; Mon,  4 Oct 2021 04:04:26 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id c4so10816856pls.6
        for <linux-pm@vger.kernel.org>; Mon, 04 Oct 2021 04:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W6tAA9CoM9zuCb38gqLGQ5EYxEkpOOFtNgaoMFePfIc=;
        b=P3iol4ylol3dQ5/O7YHGTNVdjm547GdmVZ9GpJiYE8i2zJLQ7TSUTFZjdMt6cwCeol
         ICqhSHobqEAecgZvA45L0fKNhflU7So+ibNhGmXvdAPZpeoQ7M3L3NBnu8REMeblbOiR
         2bSqJuSEDRdXFTORC5qNoos4AJbDf51mAB3aFqgyR++Fz29BOsSsDKsQhkvRXjp+18kH
         Z1L+oOgDZ4dAXZt0VeJNGkoQUDgeA6t9G3CFlXCb7clotEXyNUbDaeoVXdOsXQ397nb7
         izw1f4cPTGlfKZ401Ra57c55nGdxzTrv3vAh7W2+xDEUm/+ROm6lahh/J22VZoxb9mDl
         3E+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W6tAA9CoM9zuCb38gqLGQ5EYxEkpOOFtNgaoMFePfIc=;
        b=VvlzgQb3lTmHkY2H0KSnmaDOU9uPeB5a8cnpnGD68ohnTBsixnhoUOmhFBzxuGzjvf
         bAURDb+Nd5fDfnD+qX6tBh+fAh3qLw8p/MD1UmJyDPiOGgXpbbfrCo21rJik2hXyAKe+
         ARe17ptObDW4uFQWzXSMNpMFK110EbA1gX+OMHWps8ejOOTuF17ets4xiQFwa/krI+y1
         lawfoFwdYg/CkhMnuhTYTDlMU7XvkmQvF2IIqmcPy6RP0ix/MLV5uRP0b5Fq2+anFwSr
         Tlv75kaah3SXH9qIUVgpAgZHUm1YiVywX5zAv9+hQwSz78ZpMirSVRS+DSHcAi78tixw
         GY4w==
X-Gm-Message-State: AOAM533Lr5x80yxIDT6YykEJ9bpV+eThgZ9GNQohDnoSD1qgT6uMJUjS
        zmSp++RTg67ED3Wnh6TrpDQlNw==
X-Google-Smtp-Source: ABdhPJzYi/GepZQnZ+GCGDR1bKwnD72fTfCpo4YwvAfXPP2IqUq/muGXABomQIFUKyvX+GUiXYe8Dw==
X-Received: by 2002:a17:90b:3852:: with SMTP id nl18mr20660564pjb.74.1633345464201;
        Mon, 04 Oct 2021 04:04:24 -0700 (PDT)
Received: from localhost ([122.171.247.18])
        by smtp.gmail.com with ESMTPSA id w13sm15222561pjc.29.2021.10.04.04.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 04:04:23 -0700 (PDT)
Date:   Mon, 4 Oct 2021 16:34:21 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/4] opp: Add more resource-managed variants of
 dev_pm_opp_of_add_table()
Message-ID: <20211004110421.agep6hxoa6qo7wy2@vireshk-i7>
References: <20210920172249.28206-1-digetx@gmail.com>
 <20210920172249.28206-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920172249.28206-2-digetx@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20-09-21, 20:22, Dmitry Osipenko wrote:
> Add resource-managed variants of dev_pm_opp_of_add_table_indexed() and
> dev_pm_opp_of_add_table_noclk(), allowing drivers to remove boilerplate
> code.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/opp/of.c       | 46 +++++++++++++++++++++++++++++++++++-------
>  include/linux/pm_opp.h | 12 +++++++++++
>  2 files changed, 51 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 2a97c6535c4c..bd01ecb1d85c 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -1081,6 +1081,17 @@ static void devm_pm_opp_of_table_release(void *data)
>  	dev_pm_opp_of_remove_table(data);
>  }
>  
> +static int devm_of_add_table_indexed(struct device *dev, int index, bool getclk)

Made this _devm_of_add_table_indexed() and applied this patch. Thanks.

What about rest of the series ?

-- 
viresh
