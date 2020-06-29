Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBCEA20D53C
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jun 2020 21:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731854AbgF2TPx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jun 2020 15:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731742AbgF2TOW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jun 2020 15:14:22 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F298CC08EACA
        for <linux-pm@vger.kernel.org>; Sun, 28 Jun 2020 23:16:42 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id e18so7821279pgn.7
        for <linux-pm@vger.kernel.org>; Sun, 28 Jun 2020 23:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4irVPvy6SLfIHJxFGOTl27eLkGNjnPf7i0OL+P/LA5k=;
        b=gvy6L2gNxq9EwuQLge3KvNqHHwK00gDANooUZvO4v6O5WkSzyTrdIQh/0aKfX2EltN
         BC+F/sMOwIeTzytYh6C+biD3Z0k6ukqbdDxfzaddghnTjVpA5NWIn66UJGhUQht65PyZ
         UeQC58uEadA2EDA5nxAwZTOmY1XiiRXMAqh4qZqk5F0ktgOQ4Giv/rDvhNJX+IvYgcRF
         uyUIijuxIyKFEY98uEPgkKkWVz1lx7Yn194BvXvE9VqaqfoT3h524c71kZLvLyv0Y3xD
         Y9evO5z8oHOrC+f8Jlfh91dni7AyjZR5XVxyL1Ss6Xooxx2IhT7B1txyR0AIA+/7u5mi
         FGzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4irVPvy6SLfIHJxFGOTl27eLkGNjnPf7i0OL+P/LA5k=;
        b=s3R3JiDc+KyWd/aLhxl/kCyzF2pDPYescUqdlTtNxztA7qn0YrkWLvJyLE9RNJCKuo
         tZqTVc3z6o64cyPHYHw9lYGZF5sSAFMMDBhuN6tOdsHD1NEgyuWBi2x0OCbppa20KaO7
         Wm65WnagzXAnNVhqvMg6whufcrhSWBxRm64kkACceJ2B9kwTJidDu8e04+UM2TzJR35a
         WzaHhlAekAphWEmqg3T7Pamh/U2k15OSNeiU6IYOz+oi1SuluZ4fdsbA7vGdzhb7STMR
         T7tvX54M1zaJR2mqg2f3SKM4d0gloD26SCx8/p6hcIppm7zLlYCM/j2plxy0csp8ZBLu
         RAGg==
X-Gm-Message-State: AOAM530dpEobGQ5bRkYmGamkAbmVv84jtYm8D9V1Gc4QbKWI8tLP7+CR
        GqBegadoTDz9XcY/NpN9phfzOQ==
X-Google-Smtp-Source: ABdhPJyWU8GRq0w0MyNAiW2bszj3RcxuYIa7V3PZhOEGRHvN2Ts53LH/NqZxHeCX7T8Kw8KhW0DfLg==
X-Received: by 2002:a63:182:: with SMTP id 124mr8482105pgb.288.1593411402221;
        Sun, 28 Jun 2020 23:16:42 -0700 (PDT)
Received: from localhost ([122.172.127.76])
        by smtp.gmail.com with ESMTPSA id m20sm34111505pfk.52.2020.06.28.23.16.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jun 2020 23:16:41 -0700 (PDT)
Date:   Mon, 29 Jun 2020 11:46:39 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     rjw@rjwysocki.net, catalin.marinas@arm.com, will@kernel.org,
        thierry.reding@gmail.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, jonathanh@nvidia.com, talho@nvidia.com,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bbasu@nvidia.com, mperttunen@nvidia.com
Subject: Re: [TEGRA194_CPUFREQ PATCH v4 3/4] cpufreq: Add Tegra194 cpufreq
 driver
Message-ID: <20200629061639.7cwxfi64drkof6yu@vireshk-i7>
References: <1593186236-12760-1-git-send-email-sumitg@nvidia.com>
 <1593186236-12760-4-git-send-email-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593186236-12760-4-git-send-email-sumitg@nvidia.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26-06-20, 21:13, Sumit Gupta wrote:
> +static int tegra194_cpufreq_probe(struct platform_device *pdev)
> +{
> +	struct tegra194_cpufreq_data *data;
> +	struct tegra_bpmp *bpmp;
> +	int err, i;
> +
> +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->num_clusters = MAX_CLUSTERS;
> +	data->tables = devm_kcalloc(&pdev->dev, data->num_clusters,
> +				    sizeof(*data->tables), GFP_KERNEL);
> +	if (!data->tables)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, data);
> +
> +	bpmp = tegra_bpmp_get(&pdev->dev);
> +	if (IS_ERR(bpmp))
> +		return PTR_ERR(bpmp);
> +
> +	read_counters_wq = alloc_workqueue("read_counters_wq", __WQ_LEGACY, 1);
> +	if (!read_counters_wq) {
> +		dev_err(&pdev->dev, "fail to create_workqueue\n");
> +		err = -EINVAL;
> +		goto put_bpmp;

This will call destroy_workqueue() eventually and it will crash your
kernel.

Apart from this, this stuff looks okay. Don't resend the patch just
yet (and if required, send only this patch using --in-reply-to flag
for git send email). Lets wait for an Ack from Rob for the first two
patches.

> +	}
> +

-- 
viresh
