Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60CE6D33ED
	for <lists+linux-pm@lfdr.de>; Sat,  1 Apr 2023 22:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjDAUvX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 1 Apr 2023 16:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjDAUvW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 1 Apr 2023 16:51:22 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2832827027
        for <linux-pm@vger.kernel.org>; Sat,  1 Apr 2023 13:51:21 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id r11so25643453wrr.12
        for <linux-pm@vger.kernel.org>; Sat, 01 Apr 2023 13:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680382279;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TMWQ7lJfy2rRcfJxRRfnhA0AkYqLVxzTiSyUCxhMmZM=;
        b=o919TC/9eFI7nT9tSFOb+eWcnqvKwTe2IZe5pRtIQW8tZyifCtY7Hv9DUm3VB7c7qv
         z5Tr5SUIrSqDgYLjXpwtQgMsHV/gZQ47kWJzASNBw1wYQsYwFbt4E00D0cgQAe/zv4ae
         PHTEFub8+DD2F6QxMaqZgV3vtMB8WymPab02w16puN5HOOxeIqxynrXX0H22Jd/vZjNq
         pqmumjFy5NA4lwZmfqVPoHeU3L14lUgcHqOaSSohtBZbzQNbBiKnJacPsTx/WFSoHLVn
         aTFvfGAXWc7YfTVBeYq99LUp54xRa/z0pWwzb9hBIAE1GHk6I9SFs/CwFpmWad7ozbUt
         F5tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680382279;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TMWQ7lJfy2rRcfJxRRfnhA0AkYqLVxzTiSyUCxhMmZM=;
        b=vzOlZEgF6TSF/8YrTxIhak3yT3J9pBa5s9zdgyowJ815u+rqNWh0SEMJcOBOxB1Ot9
         yPxJ7k5ajfyMvM2bWwBL0BF4gW+JcNjep0WIXk6lXliaoJPuCSyyUWHvmFvqEvIPq5VT
         sOV0JZO7kTpUeYZnU0EkLzVkWqpd35A57pLa623tCcCF6ma0QqOc7DqaXleuWYncu78L
         6GTQJ7q5rE4VEzkXeO6IH37Bal4TS0xP6Za6eS4z2/CGiQuAMHBdyLa9LeUd13z2v1SA
         e2RC+ktl18J+58U65YNR/npMZJMIT898szWFHTi+GkmelJdoJFmNcbrsltgB4Ab8l8nw
         +jfQ==
X-Gm-Message-State: AAQBX9dyn6eOzSUqic9G/5OwFuli90cHWX8O6D7oJW95Dg5laBm4DPgK
        avW3sMwCfU0rrRJhctQz4Ec+2A==
X-Google-Smtp-Source: AKy350Y5Y5d0oyq7FRXKb5ZRRxdbT/gKk1HkXoEP4jPfypIiihsIJ3SLzYUhnJ1tLpn5pDGChougfQ==
X-Received: by 2002:adf:f245:0:b0:2e6:2c05:8e97 with SMTP id b5-20020adff245000000b002e62c058e97mr4098803wrp.30.1680382279506;
        Sat, 01 Apr 2023 13:51:19 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:b36a:1186:309c:1f9a? ([2a05:6e02:1041:c10:b36a:1186:309c:1f9a])
        by smtp.googlemail.com with ESMTPSA id u18-20020a5d5152000000b002be5bdbe40csm5673614wrt.27.2023.04.01.13.51.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Apr 2023 13:51:19 -0700 (PDT)
Message-ID: <259ae527-631e-95cc-f3b0-039ef8536364@linaro.org>
Date:   Sat, 1 Apr 2023 22:51:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/4] dt-bindings: thermal: mediatek: Add AP domain to LVTS
 thermal controllers for mt8195
Content-Language: en-US
To:     bchihi@baylibre.com, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
References: <20230307154524.118541-1-bchihi@baylibre.com>
 <20230307154524.118541-2-bchihi@baylibre.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230307154524.118541-2-bchihi@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07/03/2023 16:45, bchihi@baylibre.com wrote:
> From: Balsam CHIHI <bchihi@baylibre.com>
> 
> Add AP Domain to LVTS thermal controllers dt-binding definition for mt8195.
> 
> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

