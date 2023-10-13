Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689A17C7F5B
	for <lists+linux-pm@lfdr.de>; Fri, 13 Oct 2023 10:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjJMIEj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Oct 2023 04:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjJMIEi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Oct 2023 04:04:38 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC52EDC
        for <linux-pm@vger.kernel.org>; Fri, 13 Oct 2023 01:04:35 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-406402933edso18958915e9.2
        for <linux-pm@vger.kernel.org>; Fri, 13 Oct 2023 01:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697184274; x=1697789074; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6oVhznh5ySaCITk6uUsd0gVfsZrYmqi620mDBOnSkgE=;
        b=K31duJoe56u0w54NAeMc6te01AIC3N17mKrTKGY6mvukNSDU5evPg4dl1Ufa4Yytr+
         H0S6dU9GLdecBRcxKteJX826vo01wtOVzTZi98VWePbsbIK92gLObdZVp0TH9lt10oV7
         EsB0GNtCOmWbhZq2gQ+9o3F3TVHEE1+I5UUYgZ2Retntp9E3ShK4EOnpqHM/7B9VgqXJ
         JfRM4WYU27IWniVehHegrw7KmOgWJe/ji1AmUpTketZMLDQZmtVXhpStMQHcdBGVooiR
         +TPa4G3L67mdHBXo+B3ZHGjjhearB0aDTC/+jNIQ6bSLcXMuzkWm5x4XxZMWRwHEEiQG
         7B5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697184274; x=1697789074;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6oVhznh5ySaCITk6uUsd0gVfsZrYmqi620mDBOnSkgE=;
        b=EnGoyDoc0gqZGk8DNLHtlvz3vFv2T6BxSJMaMTs2Y+pekABi4gKvzuVOChvdHyecvt
         muXIl1mxV+DzAQfDO1Uwj/wiDZXc1DuJ2tmSv4QxJHv3ZDQgXYPrhO15t7uvW7oI2kvt
         RAQXBkgLlp+IBT21FkwegMvoUhtOv7VIw4Z2YTcianRueAJJEABYkCkcl0x6KXnSeVqO
         BT/bjkGMbQJvkY0KlDmsX5o4IT+oQbVwRmRQk8HLjT7Vvv2C+EFqn/RkIqpkl6QKD00D
         uBpiQ9/AlFlNLRDZFI0nTzzBhESB1+Euw99sNt938FRRFYa0SSqqMTWd/ND8Hkzy89iy
         9+sg==
X-Gm-Message-State: AOJu0YwcaRzFN6JkiX2iQQsw4ktfBRr/U9e44y2xfSwT/wpf3T3tD3IG
        E0zDjpJ6O4mFGq4vZ5ZcW6ZHrg==
X-Google-Smtp-Source: AGHT+IEY+YdginKOKbt7XjrFQw/JmsnmIDsYLonWOqHU1C0wPurRswbnevHMG+OjuJH3csgNEH7xww==
X-Received: by 2002:a7b:c7d7:0:b0:3fd:2e89:31bd with SMTP id z23-20020a7bc7d7000000b003fd2e8931bdmr22943447wmk.14.1697184274113;
        Fri, 13 Oct 2023 01:04:34 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id t14-20020a1c770e000000b0040303a9965asm1850318wmi.40.2023.10.13.01.04.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 01:04:33 -0700 (PDT)
Message-ID: <24073646-373e-452d-94b6-3d91101ac5e2@linaro.org>
Date:   Fri, 13 Oct 2023 10:04:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/13] thermal: tegra: Use driver-private data
 consistently
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Jon Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20231012175836.3408077-1-thierry.reding@gmail.com>
 <20231012175836.3408077-5-thierry.reding@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20231012175836.3408077-5-thierry.reding@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/10/2023 19:58, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Instead of passing around platform and plain devices and figuring out
> the driver-private data within each helper, directly pass around the
> driver-private data when it's available.
> 
> Also store a pointer to the parent device in the main driver-private
> data structure for easier access.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---

[ ... ]

> -static void soctherm_debug_init(struct platform_device *pdev)
> +static void soctherm_debug_init(struct tegra_soctherm *tegra)
>   {
> -	struct tegra_soctherm *tegra = platform_get_drvdata(pdev);
>   	struct dentry *root;
>   
>   	root = debugfs_create_dir("soctherm", NULL);
>   
>   	tegra->debugfs_dir = root;
>   
> -	debugfs_create_file("reg_contents", 0644, root, pdev, &regs_fops);
> +	debugfs_create_file("reg_contents", 0644, root, tegra, &regs_fops);

(Orthogonal to this series) : in case you are not aware of it there is 
the debugfs_create_regset32() function. That may make go away a bunch of 
code related to the debugfs code here.

cf. 
https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/tree/drivers/thermal/mediatek/lvts_thermal.c?h=thermal/bleeding-edge#n159

[ ... ]

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

