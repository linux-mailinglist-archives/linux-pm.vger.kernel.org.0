Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED3E3FB0B0
	for <lists+linux-pm@lfdr.de>; Mon, 30 Aug 2021 07:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhH3FMF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Aug 2021 01:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbhH3FME (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Aug 2021 01:12:04 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B974BC061575
        for <linux-pm@vger.kernel.org>; Sun, 29 Aug 2021 22:11:11 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id c17so12340356pgc.0
        for <linux-pm@vger.kernel.org>; Sun, 29 Aug 2021 22:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cWgVMXSad5yZ3bSOJM1fkZY0lTxqB0etZLZP8BLZWaQ=;
        b=Dvm58Zl/eh6Y1ogYPdZEXoLGCZocbMiYuV4MhZMMRvGkLgoz6LoR1BoePfSII1Lj3C
         a7eu0FRp7nYY6JoY5ko7EEdcBQoRpYYwtLXHNgzvckvM8WPawZhen5cxszM0mrWe8IdE
         1mxJJ7tsp6tLFbdClK0nmHM7hnsQOLqT3XXkv+lys8t0NLfN3pTESrrY3iNdLQlwBQy4
         voGZtnxgH/TN8mMMztgF62xy6l57HbXhX0b3yh9XIj7VW4PJMsWIbdu39LDfmVzCaEg8
         0HwaT0UNS6R2IKLAD5xPefpCveIQ20hoAvBqir+0cj8F8gvqIw+KBxmuaoQ7aRmZ3HMp
         A90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cWgVMXSad5yZ3bSOJM1fkZY0lTxqB0etZLZP8BLZWaQ=;
        b=fYYc2guXOoeQxRbUfRuugRiezrH0fnIsCNWh7St5VBzuLLlTXE9uuLR7c37jHVLHii
         /PpQpig29LMFV7NWSHqh4GE+7kpzDfTay47yvhKkWNpkTHjCUvJ4mRDVN9bQHAkPjkoB
         yYBKl/GexarKdeCsN7tnPMmz0weNNggcgbvTVpGPbrNzHDpGXY/9K+I0y2wXRZ7a9QcP
         jfut8Me8/dPfBKfHE58c2p999gNyHHQ88iE0s1w3MQeVIeuBERLhrebTDlg9Ny0wXNoN
         MvEVzOJrsDsyhm4RWl7B2qPO+QNlltRD3bdEMnCRKMrTZQtN5PQxZ/4uYRBEEKmg5Jw5
         Rktg==
X-Gm-Message-State: AOAM531/pH1cvHSlQKvUimYi9LbsxOjJa4E6uazRCUvVobeqFrSuqB+D
        hAkehfdlZPtDzKQz3kw3sDZDAA==
X-Google-Smtp-Source: ABdhPJxVvZKVY4Tk4ROefO4P5N5TZZU6g+xJz7KhOKoLTAr78z/oKOO+sfplxt4Y96r0FgOav2n/rA==
X-Received: by 2002:a62:a20d:0:b029:35b:73da:dc8d with SMTP id m13-20020a62a20d0000b029035b73dadc8dmr21842513pff.54.1630300271022;
        Sun, 29 Aug 2021 22:11:11 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id d5sm2729182pjs.53.2021.08.29.22.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 22:11:10 -0700 (PDT)
Date:   Mon, 30 Aug 2021 10:41:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Hector Yuan <hector.yuan@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH v14 3/3] cpufreq: mediatek-hw: Add support for CPUFREQ HW
Message-ID: <20210830051108.xgfwp2uvh724syeu@vireshk-i7>
References: <1630162872-25452-1-git-send-email-hector.yuan@mediatek.com>
 <1630162872-25452-4-git-send-email-hector.yuan@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1630162872-25452-4-git-send-email-hector.yuan@mediatek.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28-08-21, 23:01, Hector Yuan wrote:
> +static int mtk_cpu_resources_init(struct platform_device *pdev,
> +				  struct cpufreq_policy *policy,
> +				  const u16 *offsets)
> +{
> +	struct mtk_cpufreq_data *data;
> +	struct device *dev = &pdev->dev;
> +	void __iomem *base;
> +	int ret, i;
> +	int index;
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	index = of_perf_domain_get_sharing_cpumask(policy->cpu, "performance-domains",
> +						   "#performance-domain-cells",
> +						   policy->cpus);

You pass CPU here, while the first patch accepts index. Does this even work? Or
work just by chance ?

-- 
viresh
