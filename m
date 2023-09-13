Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351CC79E165
	for <lists+linux-pm@lfdr.de>; Wed, 13 Sep 2023 10:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238740AbjIMIDg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Sep 2023 04:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238728AbjIMIDe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Sep 2023 04:03:34 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F6A198B
        for <linux-pm@vger.kernel.org>; Wed, 13 Sep 2023 01:03:30 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9ad8d47ef2fso178381966b.1
        for <linux-pm@vger.kernel.org>; Wed, 13 Sep 2023 01:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694592208; x=1695197008; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1kjOm+yO1bEpK06tIac4VtD/LcBLpSROVXeAOIcQH5M=;
        b=SQrHhEiMPGVaAGg2kk6tdcb0hK9lY3w/tpEjPljPCnAPTnQ8rVz6uODjNONYpIzqxS
         o1LdVFrKWmEg/EZoZGrVXLgTNKoveQPPgNd3695nlQ2MEXJCYMo7DMmexWRTwV1r/C+g
         FiPESkpLUA3EHWMSbuDxy0szFmsNOyyxihKS9AmV4SHKV84twrGAQmwonNUhLAs1goNr
         +48b+IO1GJktwtCF25UJn2Re3Mm0CTAHCuSDG7MM+KbZnL9Icc+coEhqwpuFNE0Xjv/m
         DSGBvwS+5xtuX9xEUr8VS0ihZgWERvF885Oj/0xUYIWV2oZfjsKY5ueuKImWJ3mx5qsC
         UEQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694592208; x=1695197008;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1kjOm+yO1bEpK06tIac4VtD/LcBLpSROVXeAOIcQH5M=;
        b=aEUda8fiPNKq7X0Om9wIM6GTq7N7Y1adLR4skVQKsc+NH2+qHCSxLuXQCPYKD6jwjx
         69n3bjw1aysx9ZN5Qt3gZKfh7RhVmbBxx2Jn/8pI36BMTBaM0Cx1P09BSUYeAA5KyEtG
         9vzmTcDV4SpKCWkil0ndzeZjicInSo9hQYkoAq7w/DvIiYHE65/1QLka9N8pdlNc8nTH
         upF6XSL/XdYr//9L+foSei0hc/uXRtjrW+9hpyDUhYzPkgmNjdntxE+rPzQgAiDLKE83
         4xyHx4czqPcYuN9yZz3LvGsp9EpGjwRCpODOKhP1GdDYY5Sl7pyPmWd2aoCJXjG7X/2W
         QAxQ==
X-Gm-Message-State: AOJu0YxulNp/+f3GovNoAimd2JRLD2ol/8LFfg352WTl6FcEFaSKYCSe
        0ur03MmkQ0pZJOnsgzkNWtfjIRB4gYSyYDdz950=
X-Google-Smtp-Source: AGHT+IG3mCSisdpUbOJbDzS4VuyhZpOae5IS8BiUDI4Gst+a+ZzqN5sEd3+j3W8X0yWL0L35+WbCkA==
X-Received: by 2002:a17:906:3158:b0:9a2:5bf:8b14 with SMTP id e24-20020a170906315800b009a205bf8b14mr1215035eje.22.1694592208501;
        Wed, 13 Sep 2023 01:03:28 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id ho15-20020a1709070e8f00b009ad8ba6976bsm1974171ejc.9.2023.09.13.01.03.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 01:03:27 -0700 (PDT)
Message-ID: <c75ef5f8-5c37-0ac4-bce5-05de81368dc9@linaro.org>
Date:   Wed, 13 Sep 2023 10:03:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 3/7] thermal: exynos: switch from workqueue-driven
 interrupt handling to threaded interrupts
Content-Language: en-US
To:     Mateusz Majewski <m.majewski2@samsung.com>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20230911133435.14061-1-m.majewski2@samsung.com>
 <CGME20230911133615eucas1p123b3bed5bfa998bda65196d425f9b49d@eucas1p1.samsung.com>
 <20230911133435.14061-4-m.majewski2@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230911133435.14061-4-m.majewski2@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/09/2023 15:34, Mateusz Majewski wrote:
> The workqueue boilerplate is mostly one-to-one what the threaded
> interrupts do.
> 
> Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
> ---
> v1 -> v2: devm_request_threaded_irq call formatting change.
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

