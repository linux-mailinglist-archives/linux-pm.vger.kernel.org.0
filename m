Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD955E89FE
	for <lists+linux-pm@lfdr.de>; Sat, 24 Sep 2022 10:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbiIXIRf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 24 Sep 2022 04:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233918AbiIXIRF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 24 Sep 2022 04:17:05 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305951A81A
        for <linux-pm@vger.kernel.org>; Sat, 24 Sep 2022 01:14:42 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id j24so2335586lja.4
        for <linux-pm@vger.kernel.org>; Sat, 24 Sep 2022 01:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date;
        bh=nKMztXRCuk/jyIVPD9sdwwGa292FT0FAg9FBWO41Kkk=;
        b=hR7H+Mz6827Te/atYIVJCEH8jVZlO7f7PJtz0MQUKMHFK0GQlKZUYeYvCAs6G3N2eS
         6kmDq46NS/1q1ZUtejb+LHtL2yiMQWqRgC9YcHQc3vEkv+jSngxjud/vJz+ViLqb4Ye6
         WAu7T0lUS56awHPnGa5hYZZm5N+C8/6Et1/nLOLb1x/BF7ICd8bNa0CizxdErQ1KBQK3
         A6gZrhEc+CuHouPUc91MJCb1GHuImGPz7NpsjgNbFW5WZUbARcjuFyAbtQtkZqPPQJKw
         XD0WxZLoHZAbtPdlS/tyEAcIV9BiKl+3l9gnQnl6wPPHFusHSVK++taxjb+zfHxfFVtG
         uPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=nKMztXRCuk/jyIVPD9sdwwGa292FT0FAg9FBWO41Kkk=;
        b=WZlHry7Bb9MSscy9Ke1VFBZQ6GV9QLNMPnpgk1c0MXWi0I49vuscIcVjcI6Bk6VoAW
         tZo5Eu7T7k3FinrPYTyBUcUDxDyWMBDOIyBH9XSOv+kyDwf4Ny0oTZwNf3OowafP0Ivt
         5DbyJJU/JyeKdldgBEDmq4bBJ8QIMI5pv+oEJYU7paFGAp8Xzx+E38pW7pn5ghJ5Bhe9
         CeYG5VQUrxGP2RFhZ5VQ62iYB2e8bbyRwtGosQm+8LV3u9phn720mDcKkkJJTrfms6Dx
         YElsHfhDZMah8X6peq7Y6EjUvm8k+F2MximS3ammKHXpUz78COdYh3Ixy0rm1vFGac+3
         cgrg==
X-Gm-Message-State: ACrzQf13KMn5CtVPKIkc9fnWuPjZ+aPC/SVvfXY92J0EwEpUCzVoVge7
        7rcyyKELb42Qg4x9pskQpsj7fA==
X-Google-Smtp-Source: AMsMyM6aeLPi2q90UoV1/L7V2+8UoUbEnvHv1+DVByviDLMdvGtfXCInh0lMddvxdgV+JyIMSCptyQ==
X-Received: by 2002:a2e:9cce:0:b0:26b:e2a8:d137 with SMTP id g14-20020a2e9cce000000b0026be2a8d137mr4478272ljj.356.1664007280364;
        Sat, 24 Sep 2022 01:14:40 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id f8-20020a193808000000b0049473593f2csm1805301lfa.182.2022.09.24.01.14.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Sep 2022 01:14:39 -0700 (PDT)
Message-ID: <e2fdf757-5ce4-72a3-534e-03db941ae75d@linaro.org>
Date:   Sat, 24 Sep 2022 10:14:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH -next v2] interconnect: qcom: icc-rpm: Remove redundant
 dev_err call
To:     Shang XiaoJing <shangxiaojing@huawei.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@somainline.org,
        djakov@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20220924015043.25130-1-shangxiaojing@huawei.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220924015043.25130-1-shangxiaojing@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24/09/2022 03:50, Shang XiaoJing wrote:
> devm_ioremap_resource() prints error message in itself. Remove the
> dev_err call to avoid redundant error message.
> 
> Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

