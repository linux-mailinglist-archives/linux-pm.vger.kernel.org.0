Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABA84142FB
	for <lists+linux-pm@lfdr.de>; Wed, 22 Sep 2021 09:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbhIVH5M (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Sep 2021 03:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233303AbhIVH5L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Sep 2021 03:57:11 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BF5C061574;
        Wed, 22 Sep 2021 00:55:42 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id lb1-20020a17090b4a4100b001993f863df2so1615514pjb.5;
        Wed, 22 Sep 2021 00:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a4LVEfaLq327oC+OuEdH7ELI4IIn+exl8gSPSV42DbE=;
        b=DWmJa+DLG5+58msZw2eol35HwBKnYSQ7t02TLOj6y7kQuax03g9P17nczPrnLMeZ7z
         3sV0IwuR+61tJIjidNpyn2DIZkYiT8wnQLxkzgVir/0kRS+p3CPni+wg/rV+ywpzeydM
         G6PgM3M9JIZENg/tHQAUiEO4hzKKj9XEmfOstaWucgBiOgOd4yL1vEJHRESuqkajqhHU
         xXlTNa42T8o0Hvt334nWGwN64pd36MIqzhFPHlnN2GfOznadFxq047OjLsw2n4/gqCa+
         iLGPuOD7esCH/C+3dxb6kF5Po1ylFMbEOwmPyIy+qdMEnHf3lUpH9fxWPTvQHlj95XWq
         0McQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a4LVEfaLq327oC+OuEdH7ELI4IIn+exl8gSPSV42DbE=;
        b=cmLbtrJ7RUUvd/xxecI9zlxZZ07Qy9bpaHxsVsR/8Q5noCFAmn+rgj4pkO5MUkEdzZ
         ypTnf3WbaiPSpjvXNLKAobfsN1q1BPSPoEaZ8oKwmGkY4mjgGpqd7qRm93RdCHMkyMe1
         4MP1r/dKE3JmWlR5zV9iW8U37i4ll6p13h4PKhdGERCrFykllE4fHmD2Gn/wjppF/ZOG
         IDKLlJaqFIsilclRivv6fcTYHJ2WL/QrfUzsHjvFA9Yy65tM6JiCffDuj++lzZ04vh4V
         aBXou4AMmC9H8pNtaFJHPGHJEZRu5PPTGVpD0ILMQQC57IKFYXJ/wrB+tBAlrZpP/aqB
         7ESg==
X-Gm-Message-State: AOAM531zju8WB1Xl8vIEZUtl1t0OA7ZSJSXnYHGXyZ2mHvpNDrmIaEmc
        WLipjcu2UUtPLpZs2SXSx+fwK2NLSnA=
X-Google-Smtp-Source: ABdhPJxrg2xQum3vEzcdb8t6ZMjs25UcmhqVGJerQo4ZN/JiJ7Y3MAG2gCKgEruTaH5l6KhsofKj6w==
X-Received: by 2002:a17:90a:d516:: with SMTP id t22mr9821382pju.208.1632297341658;
        Wed, 22 Sep 2021 00:55:41 -0700 (PDT)
Received: from [172.30.1.2] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id d3sm1438903pfn.156.2021.09.22.00.55.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Sep 2021 00:55:40 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] devfreq: exynos-ppmu: use node names with hyphens
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
References: <20210920071540.38337-1-krzysztof.kozlowski@canonical.com>
 <20210920071753.38560-1-krzysztof.kozlowski@canonical.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Message-ID: <83206dd4-c779-1090-9394-2519d4747206@gmail.com>
Date:   Wed, 22 Sep 2021 16:55:37 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210920071753.38560-1-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Krzysztof,

On 21. 9. 20. 오후 4:17, Krzysztof Kozlowski wrote:
> Devicetree naming convention requires device node names to use hyphens
> instead of underscore, so Exynos5422 devfreq event name
> "ppmu-event3-dmc0_0" should be "ppmu-event3-dmc0-0".  Newly introduced
> dtschema enforces this, however the driver still expects old name with
> an underscore.
> 
> Add new events for Exynos5422 while still accepting old name for
> backwards compatibility.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>   drivers/devfreq/event/exynos-ppmu.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
> index 17ed980d9099..541bd13ab61d 100644
> --- a/drivers/devfreq/event/exynos-ppmu.c
> +++ b/drivers/devfreq/event/exynos-ppmu.c
> @@ -94,11 +94,16 @@ static struct __exynos_ppmu_events {
>   	PPMU_EVENT(d1-general),
>   	PPMU_EVENT(d1-rt),
>   
> -	/* For Exynos5422 SoC */
> +	/* For Exynos5422 SoC, deprecated (backwards compatible) */
>   	PPMU_EVENT(dmc0_0),
>   	PPMU_EVENT(dmc0_1),
>   	PPMU_EVENT(dmc1_0),
>   	PPMU_EVENT(dmc1_1),
> +	/* For Exynos5422 SoC */
> +	PPMU_EVENT(dmc0-0),
> +	PPMU_EVENT(dmc0-1),
> +	PPMU_EVENT(dmc1-0),
> +	PPMU_EVENT(dmc1-1),
>   };
>   
>   static int __exynos_ppmu_find_ppmu_id(const char *edev_name)
> 

Applied it. Thanks.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
