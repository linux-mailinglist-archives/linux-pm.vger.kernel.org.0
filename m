Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7127D920DF
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2019 12:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfHSJ7Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Aug 2019 05:59:24 -0400
Received: from mail-pg1-f178.google.com ([209.85.215.178]:40736 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbfHSJ7Y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Aug 2019 05:59:24 -0400
Received: by mail-pg1-f178.google.com with SMTP id w10so920585pgj.7
        for <linux-pm@vger.kernel.org>; Mon, 19 Aug 2019 02:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=olmkP9Ue0IYi0nIG9Jgk3ly+FXYntmyDpFNEtwV9Avw=;
        b=jVMofs4s+gnCUAI79Ip6xg3i2RYI+g/WOdXI6cIBBoHeRXdYRK95YSl51r2dCRiGoS
         CiCQd8CQXBbUOr6+gF8VweGsgKMLsOcgsbdzsM35hExJDC8SuJ+8KO9GOiLG6J3lAZlM
         JBekdQXJuGo3w80gSIoEBzWdp7/nrsEpbTVMw6PIzssbWVHlxegW8W6TKqil4zjQUMKw
         UBZZopGFveiUcMuqZ4lF43p0BGxD8HqGxseLqoRLQeEuLwzYDRVodbbJ32/p2h9mj5ji
         UoP5hP0x0uBcNzonEoOq3XHWSVYrDeNst784sV+x8X5/hR0xw+fivaQ/8nmLW6eRtpKb
         L4vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=olmkP9Ue0IYi0nIG9Jgk3ly+FXYntmyDpFNEtwV9Avw=;
        b=eUDvPpRutVhXzFZiYMAhLx1q+Wm31epiRiAkbd0ViMrYg34oMRndAM7VQ2cKMgK3Fb
         UfOfXveyarkBI3N2FL60EDonNi3rm5ulg2uKEv+VAWdb9D0x6mNpYr6hbtd1v0SJJk02
         UO95GI7pxmFg8+sWcB5Ya1Vo6m15Vfltv2VQKYo4jRMGtYvx6dxOVtT63HxbVKQtcqgU
         UUJAXM0qgPBB9cQTAZXIPkTmf8Ln4/88aCodi+ZMkUuyb0t3rqURmerXTlAs6aq+lypU
         LZHauWDa0AFA7GD3FFmHWvoDWkoBc0a9JsUbV6EzpV3CzZd3YGK+0itzSQaw3y8bJ6qP
         HCOQ==
X-Gm-Message-State: APjAAAXaV9BwtLY0OSE6z6L4PO5iNsg6LaEP4ZHBkCjqClqbxyKMx6Je
        ZEHjAvWZyB52ghiq0p4JutrWIXQsaUQ=
X-Google-Smtp-Source: APXvYqzxIL7FNkeVE+u8/wl10luXKQYJ2XZM5P9oxQ0cMb5m0opTFk66svqyoJdFdPJeYTRamxtKbA==
X-Received: by 2002:a65:5584:: with SMTP id j4mr18996392pgs.258.1566208763608;
        Mon, 19 Aug 2019 02:59:23 -0700 (PDT)
Received: from localhost ([122.172.76.219])
        by smtp.gmail.com with ESMTPSA id r4sm18937523pfl.127.2019.08.19.02.59.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 02:59:22 -0700 (PDT)
Date:   Mon, 19 Aug 2019 15:29:21 +0530
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
Subject: Re: [v4, 3/8] cpufreq: mediatek: Add support for mt8183
Message-ID: <20190819095921.sk2pltuylfaxklnx@vireshk-i7>
References: <1565703113-31479-1-git-send-email-andrew-sh.cheng@mediatek.com>
 <1565703113-31479-4-git-send-email-andrew-sh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565703113-31479-4-git-send-email-andrew-sh.cheng@mediatek.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13-08-19, 21:31, Andrew-sh.Cheng wrote:
> From: "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
> 
> Add compatible string for mediatek mt8183
> 
> Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  drivers/cpufreq/mediatek-cpufreq.c   | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 03dc4244ab00..0f7e837a264e 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -117,6 +117,7 @@ static const struct of_device_id blacklist[] __initconst = {
>  	{ .compatible = "mediatek,mt817x", },
>  	{ .compatible = "mediatek,mt8173", },
>  	{ .compatible = "mediatek,mt8176", },
> +	{ .compatible = "mediatek,mt8183", },
>  
>  	{ .compatible = "nvidia,tegra124", },
>  	{ .compatible = "nvidia,tegra210", },
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> index acd9539e95de..4dce41b18369 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c
> @@ -546,6 +546,7 @@ static const struct of_device_id mtk_cpufreq_machines[] __initconst = {
>  	{ .compatible = "mediatek,mt817x", },
>  	{ .compatible = "mediatek,mt8173", },
>  	{ .compatible = "mediatek,mt8176", },
> +	{ .compatible = "mediatek,mt8183", },

Had to fix rebase conflict manually for this. Please always rebase on latest
linux-next.

Applied. Thanks.

-- 
viresh
