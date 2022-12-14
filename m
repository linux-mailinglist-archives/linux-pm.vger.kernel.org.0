Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8943E64CCAD
	for <lists+linux-pm@lfdr.de>; Wed, 14 Dec 2022 15:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238701AbiLNOwE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Dec 2022 09:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238727AbiLNOv7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Dec 2022 09:51:59 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2829226A98
        for <linux-pm@vger.kernel.org>; Wed, 14 Dec 2022 06:51:58 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso10756833wme.5
        for <linux-pm@vger.kernel.org>; Wed, 14 Dec 2022 06:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IiSnpue6iOmz6L8zVrDjfUc0muwFjLoqBWFHi5L4ZfE=;
        b=ML9PjZ/+nrI9mCEvEcuGQP2u/gxh8PbvEL5mseGdKcyX1oieDAVTtqhfYK3elDITKR
         ZRAd7iREPbW/9yRoZZVD2Wj68XBEeqAwjJVpJ93KDjjH1ING2UFPC2LYHRX0DzOh3e0F
         30MJKxc4d4TNsW38G3gwUXT9GbzO8VUI6aNfkWBGHYg/611TBGE5wqRulxs9RwQFONv3
         tmd4i1gJigFZPZZ3t/VeRIZzc68vCc0YoEzNPOSClleRxgGpLJLncXguboUlRA2pFcGo
         L73gtLadRq12X5QFgGsrgVU87UEcj6ha1lfEcrdEne9rEnMJUFN57XbTup/jVgMz23xZ
         gazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IiSnpue6iOmz6L8zVrDjfUc0muwFjLoqBWFHi5L4ZfE=;
        b=c2Enwe9lSSNnUYNLPCd8uIH3B3dL1d9ZYzFoL8RgX7oiWdHczR+9H8420eFabWmv0l
         rR/tZvzif3aH9VLWE5FDj7jlwNjnPADM/rPJOIlJ8eOrXL3nLr3Ero/8RZI/M/ON3hxh
         01kCTVmp6Lz2oKqv9nZPvN8O7YtiCrCTjACqRrsG2lheAjDrgwDIkEamtxtW3YEq2BNT
         HO9f+wkYDjihZ/ZfhoH/OP3OPg9xC1VGsebNRwu/8D3aE5iWK+FKpqjFPihE894Z+adu
         XhXN2V3lQEkYlLra6Sr20HaTGu33HUTvrfsYM3kkVvXydwBtptFKE8jRnjfIuGaLFm9o
         bXrg==
X-Gm-Message-State: ANoB5pkzpRAezKtjzKhEqCvaS81Dqu/jFj0pUQD9d7g94D1HSph7j5ad
        qtXtH7f3czL8iZb6ZraVSM4oyg==
X-Google-Smtp-Source: AA0mqf5viJGPbkA9DJBQc40lI7/cf35dpqsNAmnTgEn4+gdohkG0chrb5zLj/DBXWD7luiB6q7HM6w==
X-Received: by 2002:a05:600c:2d07:b0:3d1:ee3a:62ae with SMTP id x7-20020a05600c2d0700b003d1ee3a62aemr18698856wmf.8.1671029516593;
        Wed, 14 Dec 2022 06:51:56 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id g12-20020a05600c4ecc00b003cf9bf5208esm3133352wmq.19.2022.12.14.06.51.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 06:51:56 -0800 (PST)
Message-ID: <b54c3eb6-6373-3679-4561-272b8f249a7b@linaro.org>
Date:   Wed, 14 Dec 2022 15:51:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 0/4] thermal: fix locking regressions in linux-next
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
References: <20221214131617.2447-1-johan+linaro@kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20221214131617.2447-1-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Johan,

thanks for your fixes

On 14/12/2022 14:16, Johan Hovold wrote:
> This series fixes some of the fallout after the thermal changes that
> just landed in linux-next.
> 
> Lockdep reported a lock inversion in one of the Qualcomm drivers and a
> closer review revealed that the changes had also broken the sysfs
> interface for at least three drivers.
> 
> Note that a simple revert of the offending patches was not an option as
> some of the infrastructure that the old implementation relied on has
> also been removed.
> 
> Johan
> 
> 
> Johan Hovold (4):
>    thermal/drivers/qcom: fix set_trip_temp() deadlock
>    thermal/drivers/exynos: fix set_trip_temp() deadlock
>    thermal/drivers/tegra: fix set_trip_temp() deadlock
>    thermal/drivers/qcom: fix lock inversion
> 
>   drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 7 ++++++-
>   drivers/thermal/samsung/exynos_tmu.c        | 2 +-
>   drivers/thermal/tegra/soctherm.c            | 2 +-
>   drivers/thermal/thermal_core.c              | 1 +
>   include/linux/thermal.h                     | 2 ++
>   5 files changed, 11 insertions(+), 3 deletions(-)
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

