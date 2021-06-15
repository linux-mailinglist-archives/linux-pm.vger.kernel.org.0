Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 084D33A7B5D
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jun 2021 12:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhFOKFi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Jun 2021 06:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbhFOKFi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Jun 2021 06:05:38 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39737C061574
        for <linux-pm@vger.kernel.org>; Tue, 15 Jun 2021 03:03:32 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id y7so17629022wrh.7
        for <linux-pm@vger.kernel.org>; Tue, 15 Jun 2021 03:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KRA5JEo2f5eHwlGrBe+x1mvEfYhwDU4OUZncstnbx6M=;
        b=abmrGACQlQt5ZE+gApEShYt+RvKsyhEfHJfi5/vT9I3RDbrTqQzmrzTOkQPnsUni7U
         SzTFW7k7Vqv1fM3wfudlLmKmInuXzgUSrB39C8A+sKFdNR5KYvT9Rtik5Oau0y3aTfZy
         Mi+akzTENmyInfIMYQi7J+oITLgpkxVU8Wqbi5ixtXTky6kMVqnOuirimUH2PRPZBctc
         IElKBN1eVyo1Yq94sHzpeibE3VGjXfXlBO3eEU3qFCvAZYROE1bUyC3ccz6XT8cuYNOP
         mkJ464ru+HtEY6R6eU7nFXJyILxUoYN9HVgfWqZxVqSFCpTajJOQyMubzMqQbCv2hA+w
         py5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KRA5JEo2f5eHwlGrBe+x1mvEfYhwDU4OUZncstnbx6M=;
        b=cTePu2ZHdcskUjQPoIxgEcFuq+R5G4Z5KXqy94DQA1xzqZFeRZ38pz8DzQaXKb0rxB
         NZMyLUnoefgtM9iJlVZRRbT/2cEEzfL5CVqJJKeKcuodbtFvNiPtjOtZx2mgwcqJIHLl
         2OJi6KoVwsveLNpmHjfkr1u+ywb5gbgvUhNM9zOIyXBFBkhjFmdmFRWwMfaypxq7eRYG
         H9d6+By/kOAVzdtLsjeCk4q15L9CxRBaHkB1o6BrtwEZW6Hk4LVHukf2zAD/c2zsTCCa
         5DH/btac0TPAybLr5UOSkTO6STSbCefFwMFd/RP0Lzs0h94abpHMOkMIE/xkFEbiVumm
         cePg==
X-Gm-Message-State: AOAM5300Wsbwdr8zRuUCxhkn6sXtlh1L7oWyNFPCuzfgaAwGlNgF8X4p
        Vq921SyuBFQJtubIzih5z1vbjQ==
X-Google-Smtp-Source: ABdhPJxoM9gzPk3IB6/C7ha95cVkrtf3v1G/EmnZeUdJkwy9lR4zpVjozuDW7tuCcTy/nn30hvq6vA==
X-Received: by 2002:a5d:6208:: with SMTP id y8mr16865170wru.119.1623751410645;
        Tue, 15 Jun 2021 03:03:30 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:613a:6939:5f7f:dceb? ([2a01:e34:ed2f:f020:613a:6939:5f7f:dceb])
        by smtp.googlemail.com with ESMTPSA id j131sm1785395wma.40.2021.06.15.03.03.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 03:03:30 -0700 (PDT)
Subject: Re: [PATCH v3 4/7] thermal/drivers/tegra: Add driver for Tegra30
 thermal sensor
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andreas Westman Dorcsak <hedmoo@yahoo.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Ihor Didenko <tailormoon@rambler.ru>,
        Ion Agorria <ion@agorria.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>
References: <20210529170955.32574-1-digetx@gmail.com>
 <20210529170955.32574-5-digetx@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <6f2b6290-095a-bd39-c160-1616a0ff89b1@linaro.org>
Date:   Tue, 15 Jun 2021 12:03:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210529170955.32574-5-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


[Cc Viresh]

On 29/05/2021 19:09, Dmitry Osipenko wrote:
> All NVIDIA Tegra30 SoCs have a two-channel on-chip sensor unit which
> monitors temperature and voltage of the SoC. Sensors control CPU frequency
> throttling, which is activated by hardware once preprogrammed temperature
> level is breached, they also send signal to Power Management controller to
> perform emergency shutdown on a critical overheat of the SoC die. Add
> driver for the Tegra30 TSENSOR module, exposing it as a thermal sensor
> and a cooling device.

IMO it does not make sense to expose the hardware throttling mechanism
as a cooling device because it is not usable anywhere from the thermal
framework.

Moreover, that will collide with the thermal / cpufreq framework
mitigation (hardware sets the frequency but the software thinks the freq
is different), right ?

The hardware limiter should let know the cpufreq framework about the
frequency change.

	https://lkml.org/lkml/2021/6/8/1792

May be post the sensor without the hw limiter for now and address that
in a separate series ?

  -- Daniel

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
