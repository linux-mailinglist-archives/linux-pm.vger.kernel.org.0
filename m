Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1196026E751
	for <lists+linux-pm@lfdr.de>; Thu, 17 Sep 2020 23:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725858AbgIQVW7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Sep 2020 17:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgIQVW7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Sep 2020 17:22:59 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC8AC061797;
        Thu, 17 Sep 2020 14:14:28 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id q8so3751884lfb.6;
        Thu, 17 Sep 2020 14:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zeV+mNFI/EgD0ltGwvOsQ9sUEu48alm6T8WJu6X0xts=;
        b=ROFQIragMPxda0wm8eB23qUXEEnwDbE2wkNTzhsnH0F4GRxsP+X/ud4fE5EuSEAKgr
         4PPlDY2Bir6r4MQL7yrkndOMOQwVatr2LRbrzb5egzQgt7hlGRecWIarXBnkmeAzsOhB
         PDFE2OIqkURoKWgNj1IQ1zJKLVIitTkWKzbfGeYFL/HCEA706yu3UPWpBF8BFKvznOO8
         I/15etk99rRobQ8ahqc+tiBB9H/lDAdAIKerbN4rxfCzDY2tfe5Vw+WJcWkz/K6Nh6fZ
         j61JxbvntyzW13r9mZv/z3QVO1ESqqN2ww7ghB17m34xWMyDYI5f0b7XlB4060cpV/i1
         Ck1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zeV+mNFI/EgD0ltGwvOsQ9sUEu48alm6T8WJu6X0xts=;
        b=PRes7uyCy8NF7kC+5E4NtHc1qcQhSRy3RCgWQNz03N+cfieow2qCu8a9gX+NqznNUs
         JA2MToV9Aceqi8NOzp6MfnrtCLYb2pCoHX+u8U7ehzMhYQXZEMb8GhhoJw7DcUNWcPYS
         y/qlHmoW6rLTMLa4OneMw7o3+fJ+Qp0DAZJBadhEh+TByxrxiTljMCtkdOehfZGo57nH
         vAw31MTb4i++6PNhw7hIrGd8fxo7dCn3K9oV8rTDKzlXjNZe2qemjmI+GSMTREpZjiE9
         qTeYMY5Ol0lPK4i2CIVvoHVemu21n43GSX+J6sfnA0A+HxgU8dcVFzigsIWeXMbSKV8o
         QSWw==
X-Gm-Message-State: AOAM530hN3keBNmLSO9TXYIhAX2Y0GnvJ5oPPvaBS5iZD3JldNW4E679
        KH9Wp4F3Pbl+EqaenrgBruOZkMk9cqY=
X-Google-Smtp-Source: ABdhPJzX3Gh0eBK4RFPqX3iwxA8g95t6owrUg5pFXe6zYJNekJZyBM0quLpT/oWfVBFNJtkUZTYGHQ==
X-Received: by 2002:a19:404e:: with SMTP id n75mr9776857lfa.172.1600377266754;
        Thu, 17 Sep 2020 14:14:26 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id u18sm145137lfg.86.2020.09.17.14.14.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2020 14:14:25 -0700 (PDT)
Subject: Re: [PATCH] PM / devfreq: tegra30: disable clock on error in probe
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <CGME20200908072627epcas1p41f2c8c2730d42bd8935a40b0ab8122f7@epcas1p4.samsung.com>
 <20200908072557.GC294938@mwanda>
 <2ceb045a-ebac-58d7-0250-4ea39d711ce8@samsung.com>
 <44560522-f04e-ade5-2e02-9df56a6f79ba@gmail.com>
 <e45c8ffc-ea24-1178-7bfa-62ca6bedbb3b@samsung.com>
 <2573cd77-1175-d194-7bfc-24d28b276846@samsung.com>
 <5aac4d59-5e06-25a6-3de1-6a5a586b9e34@gmail.com>
 <bccb08ef-7e48-0cc7-08b5-7177b84a5763@samsung.com>
 <887f4b2d-9181-356c-5f09-23be30d2480c@gmail.com>
 <8edcfd7b-110b-3886-64ee-3ec02cc6bd19@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <57e8ccad-f0d5-febb-7a31-8d34430a5cb8@gmail.com>
Date:   Fri, 18 Sep 2020 00:14:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8edcfd7b-110b-3886-64ee-3ec02cc6bd19@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

17.09.2020 05:32, Chanwoo Choi пишет:
...
>> There is no need to deassert the reset if clk-enable fails because reset
>> control of tegra30-devfreq is exclusive, i.e it isn't shared with any
>> other peripherals, and thus, reset control could asserted/deasserted at
>> any time by the devfreq driver. If clk-enable fails, then reset will
>> stay asserted and it will be fine to re-assert it again.
>>
> 
> Thanks for the detailed explanation. 
> But, I think that almost people don't know the detailed h/w information.
> If possible, how about matching the pair when clk-enable fails as following?
> 
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -828,6 +828,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>         if (err) {
>                 dev_err(&pdev->dev,
>                         "Failed to prepare and enable ACTMON clock\n");
> +               reset_control_deassert(tegra->reset);
>                 return err;
>         }

That change won't bring any real benefits and will confuse people who
know the HW, so we shouldn't do it.

Since the interrupt is disabled by default at the probe time, we
actually don't need to care in a what state ACTMON hardware is at the
driver-probe time since even if HW is active, it won't cause any damage
to the system since ACTMON only collects and processes stats.

I made some experiments and looks like at least on Tegra30 the ACTMON
hardware block uses multiple clocks and the ACTMON-clk isn't strictly
necessary for the resetting of the HW state, it's actually quite common
for Tegra peripherals that a part of HW logic runs off some root clk.

Hence if we want to improve the code, I think we can make this change:

diff --git a/drivers/devfreq/tegra30-devfreq.c
b/drivers/devfreq/tegra30-devfreq.c
index ee274daa57ac..4e3ac23e6850 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -891,8 +891,6 @@ static int tegra_devfreq_probe(struct
platform_device *pdev)
 		return err;
 	}

-	reset_control_assert(tegra->reset);
-
 	err = clk_prepare_enable(tegra->clock);
 	if (err) {
 		dev_err(&pdev->dev,
@@ -900,7 +898,7 @@ static int tegra_devfreq_probe(struct
platform_device *pdev)
 		return err;
 	}

-	reset_control_deassert(tegra->reset);
+	reset_control_reset(tegra->reset);

 	for (i = 0; i < mc->num_timings; i++) {
 		/*
