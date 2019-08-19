Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84F30920BB
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2019 11:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfHSJv7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Aug 2019 05:51:59 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36710 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbfHSJv7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Aug 2019 05:51:59 -0400
Received: by mail-pg1-f195.google.com with SMTP id l21so915854pgm.3
        for <linux-pm@vger.kernel.org>; Mon, 19 Aug 2019 02:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xGqFoegYFFErF3k96plvP+BoToF4gSQapUoW0Zrc4EI=;
        b=tjBog+GFQi8eVR5IFt2HYmaEBLiJLQHxwfxJD321hYhOdjgK5Z3oqNtUNEwz5/DGUM
         CgK2pwBoFXfPXDH/+suP2sgFZzD50XlOsXvAZez4WXG03lgGgRVPxog7eKGf5EjlDzna
         6cIC492iG1do16x4weU/6N/DzEdydwxfFqjgp17sNZsOiNwPlY9dDzaDFb/7KRppt1xh
         5H/dJvmoYdEwLttrr8+OCIrrbNijeXHXIkqoaF7oWUDtXew+OV5iEODi5hhMFjexa2dT
         GAZLnxaJobyzQ8g5eE2mEWeChuuIqMtdY08D8RSuhTxX4hxQUt2qSDTYVxXrPZ7Ml5aF
         wNgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xGqFoegYFFErF3k96plvP+BoToF4gSQapUoW0Zrc4EI=;
        b=oiZwIbCUMgRgEh1SsvdH3ZgrTEZ+vGn2wAuUYPAItnQ/6/KBvLuuX7HkK5XzVAYQpZ
         mI4wVeRiZJWYeGXKCe/WVYvbw8mNYhZSL+eJn//x/nb300TesM7nnfid/nZnenQgA12j
         Zj4cR4AP+1ObreduOO+g1n9yT2WYpXPcx3QzRtXsjmg3XUPRlvHgLasdeUjr4uu662zO
         E5cHX0fEoGTErBA21OqEtUPqEhu8niFtYEL3WkcgRDiVPoXmFXNe4u8Pdalzt6N+IWJz
         V0OPhj90kvTkqOGkoq+ytzWNlaQmd7C8hj5xjo2Q4PLr29eEeTe4VbeadS1qnIj3vZmi
         Zwvg==
X-Gm-Message-State: APjAAAWpZrHwe1F9WAbqrvU6ni3PraCLTGctjwnEjPiSyslsjyMRvuGo
        ltvz60An3Yy4qbBwX/EdGSiSsA==
X-Google-Smtp-Source: APXvYqwefojTPrDuHM+2Bz8IW3MPXqRE/59Iakl1TK1LeLtzUvPNSDdCUFmUg0z973E3A07y52xJwg==
X-Received: by 2002:a17:90a:fd8c:: with SMTP id cx12mr19976973pjb.95.1566208318998;
        Mon, 19 Aug 2019 02:51:58 -0700 (PDT)
Received: from localhost ([122.172.76.219])
        by smtp.gmail.com with ESMTPSA id b126sm2036018pfb.110.2019.08.19.02.51.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 02:51:58 -0700 (PDT)
Date:   Mon, 19 Aug 2019 15:21:56 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com, fan.chen@mediatek.com
Subject: Re: [v4, 1/8] cpufreq: mediatek: change to regulator_get_optional
Message-ID: <20190819095156.m3iltf5ni3pprrt7@vireshk-i7>
References: <1565703113-31479-1-git-send-email-andrew-sh.cheng@mediatek.com>
 <1565703113-31479-2-git-send-email-andrew-sh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565703113-31479-2-git-send-email-andrew-sh.cheng@mediatek.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13-08-19, 21:31, Andrew-sh.Cheng wrote:
> From: "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
> 
> For new mediatek chip mt8183,
> cci and little cluster share the same buck,
> so need to modify the attribute of regulator from exclusive to optional
> 
> Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
> ---
>  drivers/cpufreq/mediatek-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> index f14f3a85f2f7..a370577ffc73 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c
> @@ -338,7 +338,7 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
>  		goto out_free_resources;
>  	}
>  
> -	proc_reg = regulator_get_exclusive(cpu_dev, "proc");
> +	proc_reg = regulator_get_optional(cpu_dev, "proc");
>  	if (IS_ERR(proc_reg)) {
>  		if (PTR_ERR(proc_reg) == -EPROBE_DEFER)
>  			pr_warn("proc regulator for cpu%d not ready, retry.\n",

Applied. Thanks.

-- 
viresh
