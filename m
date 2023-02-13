Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1866A6942CA
	for <lists+linux-pm@lfdr.de>; Mon, 13 Feb 2023 11:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjBMK0x (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Feb 2023 05:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjBMK0x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Feb 2023 05:26:53 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54A11BEA
        for <linux-pm@vger.kernel.org>; Mon, 13 Feb 2023 02:26:50 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id hn2-20020a05600ca38200b003dc5cb96d46so10882496wmb.4
        for <linux-pm@vger.kernel.org>; Mon, 13 Feb 2023 02:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u9XkQcR/ukcuNhbIYv8e/TtemQqGk36qfemF2Jz6RB0=;
        b=brmbQKVHdRY0TzmN0JVgb5QvPm3gsUqqHKWL9I1NOg/HJQvbNpNKr305fji1pLsOxK
         1rzNBncXnFoT4GgkPmh5Itr1CpkGnlQ3pNQFN0FAnL4waKDhNYv9lp+BbYo+7ydgpAI3
         8OfeRvuRTluqGQW/EkXPvjXzn9KBV1lRhkMwZjQGqsyH8HRGRR774rXI0cVwoAYE42xJ
         mgXLX3r8KVY/XS8jY0Nyb2QVcVK8BehaDxN7UM2f1vNX+zhFuTq40AyIv5JImURNA/4L
         0Z6s3J0iawU0EdWC9FCdgQpeoymvIEE2PYppCpwV5zPmNxi64HxbtFU1Guis41fBFruR
         ckZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u9XkQcR/ukcuNhbIYv8e/TtemQqGk36qfemF2Jz6RB0=;
        b=DATUB9Ih8L26cMj+r5ISfHtYf71szI0a0i/2OB67Y+6niqt3YXRVy0UmFqG1ZidGRe
         as2Q1yHwbD4OnE62tehmQxakAlJgi/8R6AYHb4/8VZ2YNbvcNGI6v7E8pucvkTbJBk6G
         aYyqXAu/0wRdwb0Ls525jsJzRl4ge++QWjsgO2ZRBEL8l/LaHlW9sne+PXVPalbQSjo8
         uB5C5I63OgDSrNQ9oKI/P7nP9/2weyaq4RmhtTo1iYAQ7q9A2tVLGpDvft7rvgyOUL51
         kkH7Fcyi75Eqb9eusMtRmWdVpwQdq/gdfqIlzlaK10zUVBsVTlIMJZwKH86h52825n/p
         PMxA==
X-Gm-Message-State: AO0yUKVZ8isQGNfLKnRWz3buxTfhMyVX3tCNUSxwwLkJjX6EigqXNAL4
        LE618Y6h4AMYXtHSsPaiK3Fpog==
X-Google-Smtp-Source: AK7set8+AinicK1vj4dn9W6I9bHT/HGzlVv+F1mSLKjeAex6majHYYwbTi1CSahSak1amq4tbZ4hRA==
X-Received: by 2002:a05:600c:13ca:b0:3dc:5937:35a2 with SMTP id e10-20020a05600c13ca00b003dc593735a2mr20543204wmg.9.1676284009266;
        Mon, 13 Feb 2023 02:26:49 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id a1-20020adff7c1000000b002c54a2037d1sm8020782wrq.75.2023.02.13.02.26.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 02:26:48 -0800 (PST)
Message-ID: <5480ed6a-fd9d-2d98-5f3a-ec1db920b047@linaro.org>
Date:   Mon, 13 Feb 2023 11:26:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v6 1/3] dt-bindings: cpufreq: qcom-cpufreq-nvmem: specify
 supported opp tables
Content-Language: en-US
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230208153913.24436-1-ansuelsmth@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230208153913.24436-1-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08/02/2023 16:39, Christian Marangi wrote:
> Add additional info on what opp tables the defined devices in this schema
> supports (operating-points-v2-kryo-cpu and operating-points-v2-qcom-level)
> and reference them.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

