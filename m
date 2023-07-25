Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3427C7609A9
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jul 2023 07:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbjGYFqP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jul 2023 01:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbjGYFqK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jul 2023 01:46:10 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528E019A1
        for <linux-pm@vger.kernel.org>; Mon, 24 Jul 2023 22:45:42 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-52227142a27so2859272a12.1
        for <linux-pm@vger.kernel.org>; Mon, 24 Jul 2023 22:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690263941; x=1690868741;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rcjrhThdQIsvyTPCzerLeVp106nvLkbtCY67g9wDHmE=;
        b=xdp1N2q7V6maKB3SibOZXNbTVOo+GtZEM5q0hFq4Ny+Jfs7sm2iJ3fgcljsAczYygV
         9porwxVlUy1ifXeioMtcmjatSYX2dN8unNz4SRpf4FW02h+ezeYLFobxsaDT4UFrj7Zd
         hMuZNhYEcTQv7Kx7m3OPXmJLufdcT5agMJQvi2h3BFHWRvws5EGRAC3PmZsyCVfxzOVN
         MjbpWouD0vBfFmaj32xDBtYDb+Onje3eZo0r3eyDdKT/Ivjgr6mK0kpilGhPSiXIfrhT
         iTRChTk1LWBaDxZrrjoxg7XDDKycptrMlfMylDQ91xRKLZ+YLpCDPZuq3Q1s+oMHAczg
         5ajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690263941; x=1690868741;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rcjrhThdQIsvyTPCzerLeVp106nvLkbtCY67g9wDHmE=;
        b=T9FxR+hvF1Z1Q76u+tXgOV80PEbkXp+++80v/9PuOySapSmdF2LMl4D8sfGgMTTy1j
         w7sXU1gHrqy8Jye4tUPK8W4ZZQpN2K1C6z/uOmyvDKi0S1OPHK2kv+SmxCaY2fzAu4al
         UV8UIRvsQAWPfMZxhWJ0Kh2miCmz/fgHed/y0IyCis5ddM8Bpp71CpdY3KPKYJERPG6s
         XbzlZ7UqezWeyazH4zrIuRRewNoDUBPAOIk0WDtuU+342B/gHXSIHtcP/xgYx+5L26V2
         0XPyKPAnr/clX3Cg+dutE1S0zJy/KM5GkhophhpdV/ppSlB8dPz0IXxM2AzghN1jWY1C
         bYWg==
X-Gm-Message-State: ABy/qLa9p5cHlOo61y78/RBO39FcotMxE7F0xXbByrI+urluSnPE26s+
        5V5NBdvQZclvemLqiLuTorhSUQ==
X-Google-Smtp-Source: APBJJlFQL78dPQ7jOkQS2ec5g8KpT9b2/3CLORE3azSmNueFLmHNCJH4tY+lARBAI22sxEP8F3UpLw==
X-Received: by 2002:a17:906:218a:b0:997:eab5:f1c3 with SMTP id 10-20020a170906218a00b00997eab5f1c3mr9592650eju.73.1690263940886;
        Mon, 24 Jul 2023 22:45:40 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id v12-20020a17090606cc00b0099290e2c15esm7719928ejb.75.2023.07.24.22.45.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 22:45:38 -0700 (PDT)
Message-ID: <781030b2-2c06-2767-d686-830bb93bc9d0@linaro.org>
Date:   Tue, 25 Jul 2023 07:45:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/4] dt-bindings: interconnect: add SDM670 OSM L3
 compatible
Content-Language: en-US
To:     Richard Acayan <mailingradian@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230724214209.208699-6-mailingradian@gmail.com>
 <20230724214209.208699-7-mailingradian@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230724214209.208699-7-mailingradian@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24/07/2023 23:42, Richard Acayan wrote:
> Add the compatible for the OSM L3 interconnect used in the Snapdragon
> 670.
> 
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

