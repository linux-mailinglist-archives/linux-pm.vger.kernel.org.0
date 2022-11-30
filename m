Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398BB63D84D
	for <lists+linux-pm@lfdr.de>; Wed, 30 Nov 2022 15:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiK3OeZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Nov 2022 09:34:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiK3OeB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Nov 2022 09:34:01 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9644813A3
        for <linux-pm@vger.kernel.org>; Wed, 30 Nov 2022 06:33:18 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id x11so2006265ljh.7
        for <linux-pm@vger.kernel.org>; Wed, 30 Nov 2022 06:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w35jd49HPhO+Jqkn0712oB2y+7R5nYXhRRJ8iiiiBus=;
        b=sQf9QPXHnJLO5ms9yq3mJa19QPCRxDiHgkuCupOOOnVwn/hNs5DO/urR3joJkyBpky
         Vvr8NxI8potWAj+yauWxbTn7o/eBvAWkDYd7Bv7+lKbk7rlqBjaFR9vK2J6I/Jjz9w4l
         Ok1f5qxKhUDqXlFpHTswJlz7tnBK+QTpVna6h1OESNxClbPQv7AmNc+S+HfpqQ008csF
         d1fbLtpUQafRh03JUyoZHo8CNVytb7fZV3Uu9IWs0+6tPkHcDsRbo4UZcnsTvUvy1/L/
         4d5JWGHdX4qENUsreyoMeL9cJd2Qd3I/Ca1d11VbwJeKBiQRTBV21OwEmS37XZuujvzY
         dL/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w35jd49HPhO+Jqkn0712oB2y+7R5nYXhRRJ8iiiiBus=;
        b=IrGP+T3adbIwIOQYwhGpbh+FaQhfz2ZHAXFmnJd4zMAopiCtkxA+jBbmsGKq0CT3Pe
         xwLdJdFG+8R9Wv00Z9mZN73gnMAmll0v3W7M9tSYBatWmx6sPO1l4igWEdDq98AL5QvQ
         qn9U7DxQDreqEYLH8p+fFZ4l4u8Jx8ZXxslqZevIdc/faUYAnuv5KV6JcdJlCyA2GxFH
         kWI80UebccRS0FpogV9lXUdI8XOyY/KYVhOBLIGmkO5tdHGeIh8g7lNOlM336vE/GFjX
         oWQMkW8I+3PBY2JJ99Vi4rxlVoSmnVYGMqCQw0dY0VlOK2lWTCjt/lNqiuJjkHY8vnaR
         +ADQ==
X-Gm-Message-State: ANoB5pkzPDBqb/c06Ytpn82itrS4iASD1DlhN/BFBuy5mGbOLUQL+Qpn
        WpDl4V46Y7l8OFBzxS/Zv1Gf4SLLe4Rak8ix
X-Google-Smtp-Source: AA0mqf5EuFHOvQQ+d29A0qJ/hg77DBRn0DLxyzPRKkxCGimdR2KB25/MA7ihtCKVDWU6yit8fGpjdg==
X-Received: by 2002:a05:651c:904:b0:277:210:41d1 with SMTP id e4-20020a05651c090400b00277021041d1mr14659593ljq.507.1669818797203;
        Wed, 30 Nov 2022 06:33:17 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id b28-20020a19645c000000b004a100c21eaesm279073lfj.97.2022.11.30.06.33.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 06:33:16 -0800 (PST)
Message-ID: <f7eb06a5-9c2d-568a-d363-4f70ffd0c581@linaro.org>
Date:   Wed, 30 Nov 2022 15:33:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 2/2] dt-bindings: thermal: mediatek: add compatible
 string for MT7986 and MT7981 SoC
Content-Language: en-US
To:     Daniel Golle <daniel@makrotopia.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Steven Liu <steven.liu@mediatek.com>,
        Henry Yen <Henry.Yen@mediatek.com>
References: <Y4dYpoVBmKZSaX2q@makrotopia.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y4dYpoVBmKZSaX2q@makrotopia.org>
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

On 30/11/2022 14:20, Daniel Golle wrote:
> Document compatible string 'mediatek,mt7986-thermal' for V3 thermal
> unit found in MT7986 SoCs.
> 'mediatek,mt7981-thermal' is also added as it is identical with the
> thermal unit of MT7986.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> Changes since v1: Properly document both supported SoCs


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

