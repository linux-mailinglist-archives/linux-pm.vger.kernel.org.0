Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8419021D2FB
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jul 2020 11:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729556AbgGMJjR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jul 2020 05:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729543AbgGMJjN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2020 05:39:13 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2FBC061755
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2020 02:39:13 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id j20so5771490pfe.5
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2020 02:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=skXD+wsQgKq4LXd9xCnrPvK7KZqTAPrAbDnvMV4BILs=;
        b=yh9Pm9P9Gp+QKQfxeQtuY1E1Hp14L5t3EfCVWNCaO52OM6gUUeJFFQTyK8rEyutk0H
         BMoHaR7zBcRyTShlru8V/TjqVRzrZV4+B5MeBPC/AGQ5A+jfZAy8UEt43EkfDOpZu4V9
         01nPZo5Akte8gAWlUJLgaa0gem1j28CIN8cD49/resMQr46y6OMYdUiK3whKdoa5Uvy5
         +y3ZSH/GpTj9Dn49PXWKm4+8ovC5Z15loSyOKMRDKhb71xCepwG0+P+RLVfWt5RjYGZr
         eyLaucHvluqtxjaz0JZV9dp8AXvH8VzJNZTRd03H+RiGwVDyP5C9sdB0gGbOaJ4/YDFw
         iing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=skXD+wsQgKq4LXd9xCnrPvK7KZqTAPrAbDnvMV4BILs=;
        b=HI4B2fs2mTrYjMqI8moVxVaqEUVn01cxCTXdVz7eJDNmRdIybHr/H8KojnKlzhzcIz
         t8zuOv4p7ib+KSB2pwTSXhDyY1uVX2nU7+/mQeWcfHK4kC2UmEjVqOKUE2hgF9hcgpBK
         moxGXYOX+iMxapeHtUfqCQBlbgAPhTxXb3TvykHQcc0xMk0Q+6jPhzf/d5dCjfZqme+9
         d8n+4i6nbg/KNup3DiBcBQR04tviiKYJ8ynpVvwpfZxMy4/WI3YLsYfMlOmkGnceKcmS
         ysmaIpNXM0vZ1UrHlvtk4ENmXMoF/S9tS1nHShCwDdq0etIGj3mx5og+8FDhnoW6eQN6
         q06w==
X-Gm-Message-State: AOAM5310OV6gCxH+wLkGq8GvVHsmWdyqy3eaC1DsYNP7EPWQf78J+1Z+
        l+4CVvAn2LsafB4KK+4PvXkM8Q==
X-Google-Smtp-Source: ABdhPJyl0zjLReOR/+Xr6FqTuxKWo4RJ4CVE+9dKiMkEDH87gGW8e4TOm3obgjWYwEX/7dZWcfxkkA==
X-Received: by 2002:a63:3d01:: with SMTP id k1mr65845600pga.71.1594633152842;
        Mon, 13 Jul 2020 02:39:12 -0700 (PDT)
Received: from localhost ([122.172.34.142])
        by smtp.gmail.com with ESMTPSA id i13sm14062787pjd.33.2020.07.13.02.39.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jul 2020 02:39:11 -0700 (PDT)
Date:   Mon, 13 Jul 2020 15:09:09 +0530
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
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com
Subject: Re: [PATCH v7 2/8] cpufreq: mediatek: Enable clock and regulator
Message-ID: <20200713093909.676v7wxjzsz4vbxv@vireshk-i7>
References: <1594348284-14199-1-git-send-email-andrew-sh.cheng@mediatek.com>
 <1594348284-14199-3-git-send-email-andrew-sh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594348284-14199-3-git-send-email-andrew-sh.cheng@mediatek.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10-07-20, 10:31, Andrew-sh.Cheng wrote:
> From: "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
> 
> Need to enable regulator,
> so that the max/min requested value will be recorded
> even it is not applied right away.
> 
> Intermediate clock is not always enabled by ccf in different projects,
> so cpufreq should enable it by itself.
> 
> Change-Id: I9f4c8b1ea793794f5f9cdc65427daad1393f5df8

You are on V7 right now, these should have been gone long back.

> Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
> ---
>  drivers/cpufreq/mediatek-cpufreq.c | 33 +++++++++++++++++++++++++++++----
>  1 file changed, 29 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> index 0c98dd08273d..4b479c110cc9 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c
> @@ -350,6 +350,11 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
>  		ret = PTR_ERR(proc_reg);
>  		goto out_free_resources;
>  	}
> +	ret = regulator_enable(proc_reg);
> +	if (ret) {
> +		pr_warn("enable vproc for cpu%d fail\n", cpu);
> +		goto out_free_resources;
> +	}

This is already done by the OPP core now.

-- 
viresh
