Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8663932EC7E
	for <lists+linux-pm@lfdr.de>; Fri,  5 Mar 2021 14:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbhCENuU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Mar 2021 08:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbhCENuR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Mar 2021 08:50:17 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CF5C061574;
        Fri,  5 Mar 2021 05:50:16 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id m22so3720283lfg.5;
        Fri, 05 Mar 2021 05:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=U3/LzMi4cTeDMrdSeL631gD2B3Wxm74dgKy4oke52fE=;
        b=BOgHL0AfORkOjoLV8he8vecZq9ujYLtvaINn6F9xely/VjWyMFPbb/gZjTU8JlNxtW
         RFsoPb2F6TpOUiarg4VoF9HFrh/XiaESVcYFhqI2h0vXthjrviBU0gAWNWD8/mB/nOob
         ERUVYzbZKgtiFvIkiECoDd5nL5Z0HPQ6tI9zNFH8Bg5L4Wc9bL5RisYH5n+yFZPEBjR6
         KF7egtTnnk0MD6IYiUmbweM05mRIte9rYHe3zuHQyslxpCVm/8xNgCUdwaGJzuD3IncU
         bL2+8U1ccK5c19KbBGClLbkxpyJAPohEoar7WYE1d2r+gtFe8QYtXN4TrYp8XV88/t68
         NmLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U3/LzMi4cTeDMrdSeL631gD2B3Wxm74dgKy4oke52fE=;
        b=f6mHWhSJQM02haXE0AP968JARunpU3TpX4Q2CUZGEfrQxlcPRtwPEWywqTretLgROD
         M7zRjGFDy3b9hnA8JO5xqDola3UYuYjCOiDl7YsSwYAnjfrg8T1hoRHC3Xn9uuwdg0YE
         qYAKDzev+5E7LBW+4E24Acdfn60hY1jgmROdP3GZivJh9p5/+pMR/BTc+zY6ygrmm9ya
         wOFA+K9uk0AQvIbsriMVP+VsIdVApKD238Il0J2wcBgvs4Qj0NXN9g1F2OmT7djlepId
         5JBaXuxJxq9vDvycOqCJAEXdWA6yz1wXr5FJgqNF9xzSRFsK2IRhtCmRYpx2QTM2F4cV
         PvNQ==
X-Gm-Message-State: AOAM530nqrRj4oLHhfBBN8zLQ+Fm/8XbzaW5b950N3df2zPNtMouJnwu
        iaVHsCKMPg66YLX/cgJ3JW7UZSqpXNs=
X-Google-Smtp-Source: ABdhPJzR0j7vWsubcx5lrf2dXUXNtSLHcXub9dikmJVfNwk3YZaZX1Mw8MmtnG65X34gpNwi3fzJfA==
X-Received: by 2002:a05:6512:224c:: with SMTP id i12mr5921725lfu.520.1614952215063;
        Fri, 05 Mar 2021 05:50:15 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.googlemail.com with ESMTPSA id y16sm319148ljk.34.2021.03.05.05.50.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Mar 2021 05:50:14 -0800 (PST)
Subject: Re: [PATCH v1 4/5] cpuidle: Add Tegra194 cpuidle driver
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org
Cc:     ksitaraman@nvidia.com, sanjayc@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
References: <1614838092-30398-1-git-send-email-skomatineni@nvidia.com>
 <1614838092-30398-5-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <7c21e0cc-d266-87db-b92d-663561924537@gmail.com>
Date:   Fri, 5 Mar 2021 16:50:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <1614838092-30398-5-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

04.03.2021 09:08, Sowjanya Komatineni пишет:
...
> +static int __init tegra194_cpuidle_probe(struct platform_device *pdev)
> +{
> +	struct cpumask *cpumask;
> +	int cpu, ret;
> +
> +	if (!check_mce_version()) {
> +		pr_err("cpuidle: incompatible MCE version, cannot register driver\n");

Should be dev_err() everywhere.

> +		return -ENODEV;
> +	}
> +
> +	tsc_per_usec = arch_timer_get_cntfrq() / 1000000;
> +
> +	cpumask = devm_kzalloc(&pdev->dev, cpumask_size(), GFP_KERNEL);
> +	for_each_online_cpu(cpu)
> +		cpumask_set_cpu(cpu, cpumask);

cpumask_copy(..)?

> +	t194_cpu_idle_driver.cpumask = cpumask;

Depending on 'online' mask instead of the 'present' mask looks odd. Is
this really intended to be so?

...
> +static int tegra194_cpuidle_remove(struct platform_device *pdev)
> +{
> +	unregister_pm_notifier(&suspend_notifier);
> +	cpuhp_remove_state(hp_state);
> +	cpuidle_unregister(&t194_cpu_idle_driver);
> +	kfree(t194_cpu_idle_driver.cpumask);

kfree() of a managed resource.
