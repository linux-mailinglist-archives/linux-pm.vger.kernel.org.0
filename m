Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A468D5EEFA2
	for <lists+linux-pm@lfdr.de>; Thu, 29 Sep 2022 09:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235115AbiI2Hs4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Sep 2022 03:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235481AbiI2Hsm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Sep 2022 03:48:42 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEBF513A057
        for <linux-pm@vger.kernel.org>; Thu, 29 Sep 2022 00:48:39 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id o2so997993lfc.10
        for <linux-pm@vger.kernel.org>; Thu, 29 Sep 2022 00:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Tid/nAhFERXLfYgWORgIvhzA6ivC3KOuDpJP97O0ll0=;
        b=wigLur9gEbEr0wd44D9cpg/Ai6w1oJAU3sb2MgRTDV0zFs+G/4xkWVf40hkE9sDP6F
         NTH55wFMkb7l9lkHkfPp/wDhcp6Abp5zGLrGiPOOHw+lsbvUbimjZQdCmuvtmDjMJmTB
         l3PqFo2xwZ6Okcd20GaG2Ez3FSN2/qA9cuWtJBojPvSm0VPvZzXFYWAP/+fK2af5vejf
         LPUGZ6ciQgwbSv3zRxAXxSjncRUbX90PS1FVVmBYw/MDGsIf5mpIbcNNNYlouj+ungdG
         YDpxeme/NiPNzyPyD77UTn+1otYwmPHHe2p1iSUeFp2esPordv0Mfub90Wha4HbjRzNz
         qS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Tid/nAhFERXLfYgWORgIvhzA6ivC3KOuDpJP97O0ll0=;
        b=2dypfu6osYhGxR9ZCN/mw3bRcsmZcb4RymS+QU/skTR92/xLyLFSsN7XlX7LQihjoB
         wW1cn9v7FMl8WNNcMYV+c50cJd8pZgEZ7+D/eMOP2+3W4Gl5z+JENUXy6P8sMI4CPWLv
         wkNLCXASufrFVUhF8NBo8STsOsHmPmCiwtt5aA5R7d3wB/mYZMQCuIfSA9IL7E26/Qh7
         BLKooCXtcB9dI1cWWY/cw09dAfos2WdQAdnmRh2cdJYP2YWwyLtxtszDHqtIPU19Te+a
         okjecBiuJIb1oXpkF8EKp/hMleSLyR5v0zKJ2LJ9civk6/HX+N3AY+9cohLJq251KB3V
         /UmA==
X-Gm-Message-State: ACrzQf0RHCZ7cfTWK4pInS9N/y8j6GdtR/3u5aPkO/cGGF5/0t1S2YFN
        cwlzoq+pjqPCFNq/VAe3sokx3Q==
X-Google-Smtp-Source: AMsMyM7l6fn8/Gi16rRe0GWEMt+pHsumnQ2yl2vPgSexaYofuA0kIqGglb/cacoUDi3RaHE4qLeovg==
X-Received: by 2002:a05:6512:228b:b0:49e:f3d0:4ced with SMTP id f11-20020a056512228b00b0049ef3d04cedmr764655lfu.625.1664437717665;
        Thu, 29 Sep 2022 00:48:37 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id x4-20020ac25dc4000000b00494618889c0sm711460lfq.42.2022.09.29.00.48.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 00:48:36 -0700 (PDT)
Message-ID: <839afeb4-a5c2-2129-53c2-602d55a5ced2@linaro.org>
Date:   Thu, 29 Sep 2022 09:48:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v6 2/3] dt-bindings: thermal: add loongson2k thermal
 binding
Content-Language: en-US
To:     Yinbo Zhu <zhuyinbo@loongson.cn>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     zhanghongchen <zhanghongchen@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>
References: <20220929071312.29536-1-zhuyinbo@loongson.cn>
 <20220929071312.29536-2-zhuyinbo@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220929071312.29536-2-zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 29/09/2022 09:13, Yinbo Zhu wrote:
> Add the loongson2k thermal binding with DT schema format using
> json-schema.
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
> Change in v6:
> 		1. Fix the warning "reg: [[0, 534779136], [0, 48]] is too long"
> 		   when compile the yaml.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

I assume you dropped my tag on purpose, right?

Best regards,
Krzysztof

