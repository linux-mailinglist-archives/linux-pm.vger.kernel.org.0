Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7033479E153
	for <lists+linux-pm@lfdr.de>; Wed, 13 Sep 2023 10:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238695AbjIMIAc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Sep 2023 04:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238679AbjIMIAb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Sep 2023 04:00:31 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA72F1993
        for <linux-pm@vger.kernel.org>; Wed, 13 Sep 2023 01:00:26 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-401d67434daso70452525e9.2
        for <linux-pm@vger.kernel.org>; Wed, 13 Sep 2023 01:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694592025; x=1695196825; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Kj5eZKkF+ZVKGS6KdoZl544DimPgkEdMytOlJF/XNw=;
        b=jjriZRu+9ElAwdOZk8N2A7MfC0TaNfj5EdDxq67AsX9IC+NytY4i5FV8mscfRdBVTd
         UMSL0BkHp603GqEZZKJ8qjTFx44fiUwZyQh7v3daAdHXfXlBCsjB7Y7ciRyx0nV1PqKT
         eo8iUyDd29NE2V30KNi9jsSo1Y2+mbADJt5XVOq1uhDZpUp72GjFjoLBqxQdXZqFMkTq
         EhQH0vSnXTZMC/1Do6np0avLqGjvnvnt0glEKxIDx/Swjx4Qdqg9EroOSgaSOqhLAY7n
         ISxfClCYkteWxUbx86gS8VHO2HuTUZqum1Lg12wdm7YY4hhPOc7kGxLEdSqt3/f7jroZ
         JybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694592025; x=1695196825;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Kj5eZKkF+ZVKGS6KdoZl544DimPgkEdMytOlJF/XNw=;
        b=aA3gQSF7EOI1Pih15V9sXsuoGa8y6Pj7EPVZ6DPaRfHT7KdZXifw5uALslucNbsC+P
         sYLvDCa+RE3Cg53QeQ98pvwoDg4euiNji5UOeHJm+6o4w+IcFfI0W+UDSg6lMx2Po+Jp
         /3cSXzBEbnMxO1JHYNSroar+b3apsxPwY7pyfHXLzaz+oBgduGFl+5bwq8n0gRHygfS3
         o9qO8iYS1S/tYXEM/sn2ea0BqJWnxvjSUBSXeFbvGKYSFuasLDIrcih7hXPEuetqf97z
         CGZlGoFnSi7IzC/T+nVYKsEl2++SWQY9MXhfV0OvK/04Lbu8pjEY96nW9t1OxicYHphc
         Wawg==
X-Gm-Message-State: AOJu0YyR6jl5AjyLQCh0MU6jzZOCT8OZku19c6ldBqem25M6c2V2yWkh
        IsFsWJOcuPSB6T8YVt/x2K07+g==
X-Google-Smtp-Source: AGHT+IE4VAS+PKlGYPxo0qX4pXbrIRoc2X7YSFpIGuvpDfjts/D15qYoJwuunsFw7qPuhPOJuMJvVQ==
X-Received: by 2002:a5d:4bca:0:b0:319:755c:3c1e with SMTP id l10-20020a5d4bca000000b00319755c3c1emr1502886wrt.11.1694592025323;
        Wed, 13 Sep 2023 01:00:25 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id l16-20020adfa390000000b0031c5e9c2ed7sm4108785wrb.92.2023.09.13.01.00.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 01:00:24 -0700 (PDT)
Message-ID: <667b6a4f-1d61-2788-6eeb-229a1b85141b@linaro.org>
Date:   Wed, 13 Sep 2023 10:00:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 1/7] thermal: exynos: remove an unnecessary field
 description
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
 <CGME20230911133611eucas1p286e43809a6ca785911c0bbdce15dc15d@eucas1p2.samsung.com>
 <20230911133435.14061-2-m.majewski2@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230911133435.14061-2-m.majewski2@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/09/2023 15:34, Mateusz Majewski wrote:
> It seems that the field has been removed in one of the previous commits,
> but the description has been forgotten.
> 
> Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

