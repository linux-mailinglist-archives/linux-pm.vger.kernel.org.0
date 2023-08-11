Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536B9778C94
	for <lists+linux-pm@lfdr.de>; Fri, 11 Aug 2023 13:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234451AbjHKLBa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Aug 2023 07:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbjHKLB3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Aug 2023 07:01:29 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7F1E5D
        for <linux-pm@vger.kernel.org>; Fri, 11 Aug 2023 04:01:28 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-317f1c480eeso1664872f8f.2
        for <linux-pm@vger.kernel.org>; Fri, 11 Aug 2023 04:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1691751687; x=1692356487;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wq6rCNtRJuWHJjaVoPantiU5p6m/bCS3GxWdOo6VotM=;
        b=fdbZuOBtDpR54KoDZ7bjXOJyX1+vsRS26SItSnfpB482DRIBUsLZ3mPHwyiEuQIQZM
         d1r5PMnDYa60o2XN4r1tFjr+x86Hv28rsRYY9orAdiJBzjDtySjZuJlmCsEFfTXBiMTr
         fkgcAZtBywl66q8uOAlR+6r73wLzRYzLoLlco7eIxi3Mb+7gHniBllIY/PoNX8Z71+yD
         j4t+NialtrbOUxN5Zw+dTzP/Bhq41FgY+LUotEyAqGCc6Gb1P843EkVyPrEqMo1P5061
         n8YgSLlsEANtlasIV+/H7vVpnPwQsBSUKZjh162bYI5CJURFG0eMi4zFhyF9PygEqE+R
         ow2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691751687; x=1692356487;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wq6rCNtRJuWHJjaVoPantiU5p6m/bCS3GxWdOo6VotM=;
        b=EQMrcCm55bYOxF28KmxK3vDPTMB3DR3rruA2pSYuOMM7DNMpYUNnSJgWdqfw25Koel
         b9Jhr2aFUhGFEDE6Gj2CVpxx6tun0oYiY7nZUoqzExNU2MWhaFT8uVzVFp9HXoynyUET
         CuYN44nilc0yhdGfjR+QSa0E7l4ZyyXKDX+LXkhwf0Y5MYjKuCqUiKQDHy9wM71Pq60w
         yI2XXRUMTdNfSjsaQXW5wJbbo2BshisicxgmSkbE8mzz4q4+UmonjY+pCFkVBY11tMb2
         klSvXe6li99tJhKDFdRh0TYET3ZXaZ4W7imuy9RHJdPt9MWo/VUYnRqDLgTkdRAFyreN
         bcrA==
X-Gm-Message-State: AOJu0Yzdx8lv0Kahkr3GtG7bOP2Q98PVxOP+KbcCv2XLPJ2MypJeTHaR
        Xj7heUmsy8z673+FFnAHAo+TWg==
X-Google-Smtp-Source: AGHT+IFN6FIrAF8uUc/LBfkNlUB+1kXQV2At2Htm2rDvexqs7oWO5TreHNx76NdUio/+JzgV86S0lA==
X-Received: by 2002:a05:6000:100d:b0:314:475:bc47 with SMTP id a13-20020a056000100d00b003140475bc47mr1031035wrx.69.1691751686187;
        Fri, 11 Aug 2023 04:01:26 -0700 (PDT)
Received: from [192.168.3.194] ([89.226.188.33])
        by smtp.gmail.com with ESMTPSA id d2-20020a5d6dc2000000b00317f70240afsm5063042wrz.27.2023.08.11.04.01.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 04:01:25 -0700 (PDT)
Message-ID: <9db9f842-fcbe-77e0-4b7f-0f5c26a1db51@baylibre.com>
Date:   Fri, 11 Aug 2023 13:01:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] thermal/drivers/mediatek/lvts_thermal: Make readings
 valid in filtered mode
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        Amit Kucheria <amitk@kernel.org>,
        Balsam CHIHI <bchihi@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Yangtao Li <frank.li@vivo.com>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
References: <20230713154743.611870-1-nfraprado@collabora.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230713154743.611870-1-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

On 13/07/2023 17:42, Nícolas F. R. A. Prado wrote:
> Currently, when a controller is configured to use filtered mode, thermal
> readings are valid only about 30% of the time.
> 
> Upon testing, it was noticed that lowering any of the interval settings
> resulted in an improved rate of valid data. The same was observed when
> decreasing the number of samples for each sensor (which also results in
> quicker measurements).
> 
> Retrying the read with a timeout longer than the time it takes to
> resample (about 344us with these settings and 4 sensors) also improves
> the rate.
> 
> Lower all timing settings to the minimum, configure the filtering to
> single sample, and poll the measurement register for at least one period
> to improve the data validity on filtered mode.  With these changes in
> place, out of 100000 reads, a single one failed, ie 99.999% of the data
> was valid.

-- 
Regards,
Alexandre
