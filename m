Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29D16E8FB7
	for <lists+linux-pm@lfdr.de>; Thu, 20 Apr 2023 12:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234663AbjDTKN4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Apr 2023 06:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234408AbjDTKNU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Apr 2023 06:13:20 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8B52D5D
        for <linux-pm@vger.kernel.org>; Thu, 20 Apr 2023 03:10:59 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4ec816d64afso2047157e87.1
        for <linux-pm@vger.kernel.org>; Thu, 20 Apr 2023 03:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681985458; x=1684577458;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rY35EhclsMROjwuBAZmDHq3kUGUzlcs2VX7rJH/Byds=;
        b=F10Pkm6HPnFCpyDMc0Rj1/CFS/6mqE4ElPA/1l4Iq2bRDdwCr/9bAITnnUAROu8TUz
         9YpjMumkRF2PINueIfUmSSXzJMxBq9WF+ZYnUXiMFbbYoH7jeuwPzsX0zIXkd53G7LdC
         wr0jqsgC3desNNCZEIW/ShkYfWe2laDMRvBmIWBUeMu/uAJfgSl1333vq8dpAChxUfsA
         xWvPzHpcBoxqwgnNsYbrWlsB9t4xXETonlzIfBoFtzLuZe73wU+uIE7/ljoiUmAUCOhw
         R5cMsYrtNH2XX6EvIETomIPz0GNSaiPT95ymLJRGW88tU8xFoyvhoENoFUd6ZeAhQyP1
         cSug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681985458; x=1684577458;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rY35EhclsMROjwuBAZmDHq3kUGUzlcs2VX7rJH/Byds=;
        b=GRlUe0M8ukX8cl9BvbP4Ht7xpmfoHqkQBPfUBT2sefbOn7CfGCWJllW/8T49V8vxQ1
         bD3IHzF2qP/itl7E7QCu+RrHi8TWupX4tLU1MpDLin//6aSRokJR/qxXRlT7j5pjN2YE
         o3/7Vjyr9dbq+v0DsLvlUwA1/i+noJMxsrNm0FkyRqWzJPTGnRa5vL7OSbpmoeq98OEZ
         kta4uru3s0VZ2+8+UWwXbEfbxxdlBEBU1FX8lajXpeR5bt5FuFQJWLt8F/Bx8YPcsJH6
         pI8+e1ndgO/fPiRMwHRrfxygXsbk9cLGVm802TxnqE5P9mEwhN4tgPRCzxancg7P0qc7
         MWVA==
X-Gm-Message-State: AAQBX9cMypveWVl7C6h6bEm2IeUUlcAfhBN2PVvDt8RhRuPZP8Ztxoj5
        HYhfe27SPQrogAjY+3/JRx+6Zw==
X-Google-Smtp-Source: AKy350awpAl9fizn8EEiwEoAcMf9paK+Kz1W56MpuKmmLZrVM5CSSmE4q1VkZxyDJbktHzppK48jEQ==
X-Received: by 2002:ac2:484f:0:b0:4ec:7973:1ac with SMTP id 15-20020ac2484f000000b004ec797301acmr358749lfy.22.1681985457710;
        Thu, 20 Apr 2023 03:10:57 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id x6-20020ac259c6000000b004db1a7e6decsm165806lfn.205.2023.04.20.03.10.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 03:10:57 -0700 (PDT)
Message-ID: <d406aa6b-18af-8181-d001-e48aef5c5812@linaro.org>
Date:   Thu, 20 Apr 2023 13:10:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] dt-bindings: thermal: qcom-tsens: correct unit address
Content-Language: en-GB
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230420072429.36255-1-krzysztof.kozlowski@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230420072429.36255-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20/04/2023 10:24, Krzysztof Kozlowski wrote:
> Match unit-address to first reg entry.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

