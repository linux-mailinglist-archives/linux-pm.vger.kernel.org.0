Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7132453A465
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jun 2022 13:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349581AbiFALw4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jun 2022 07:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350742AbiFALwz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jun 2022 07:52:55 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC756CA9C
        for <linux-pm@vger.kernel.org>; Wed,  1 Jun 2022 04:52:53 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id q21so3260901ejm.1
        for <linux-pm@vger.kernel.org>; Wed, 01 Jun 2022 04:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0AglY+1+Y6nT5tUGbirs2CVjYEPSqR8ctpG8KYL1ge4=;
        b=FI2JqFwBnVkQXCxczdrEtJeFFev4XkicqMbur0gVHJqUK+t0fWlK7500VhKo60XhBh
         uroIJmwO/oB+MO810EYP3Q3WoyS3qpBIjOkSl1u6V3rwTHXjIgd9S3sTcdH8+ecus5Eq
         RRGO/O1kV/q4DkxdF4D4Pmwe8MlGTeFGA2cC55SSlCz/2DLtqyzFAfmasUQxVoo8mWsg
         r5gCbQ2me/G5AD1GRdVrxrCBHCHqNmzyOpOCvFlY3CpzQvCH3T6sS2pJSJTFcZ9C2Q6r
         7BQpXM5wWo7J/R2QY0zpsmg+bL45QHFC+wWfAAS6fPdL2iVtMmzp2NpcSKSGpDpO/i/I
         SOiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0AglY+1+Y6nT5tUGbirs2CVjYEPSqR8ctpG8KYL1ge4=;
        b=vSIa69yQmb+nadf4zGk4I93z8Vv91+/ARddvraKYRF7wiDqY7anogV0S6TxDoC36eK
         XiWMDDhytnuiv1o4xc+LVlfOS5oneUMNkwQwBxfCdx7VBJamGM6/92n4BnD6j/HrSvG7
         3YJuhpWdXWGNErYa4bVEjryMx7QSKE3RP90kKgNgosvAeWbVqbrhFQzJQtB0012W+Vh9
         Y5VEEZRyk6IQMAnSuD41p/lzF0dJnz2px85iVx0oN5uPcwfoC78az7YRF+66DzcnWNBh
         Q9ChDj6YKbKbKep8hG7bmWVd9/t8BOFlHDIsAEuq7Qmvio6KgJh+cSim7fT4xvOYOd67
         Lhfw==
X-Gm-Message-State: AOAM533a4wec7VrNHI0pA8q5vV2nRvYMRDmFeAM/c9ooyEBkyrOhOS+V
        1XEVPLi7m4SFSUhknLZU2qTV2g==
X-Google-Smtp-Source: ABdhPJzcHqbLNZZnX7RgY3FztZmfteRZ5qeFecs5cZpTfofuYQdpVGoGRjira252J7iyp4ia7DFfTg==
X-Received: by 2002:a17:907:6d1f:b0:6fe:e53b:7f53 with SMTP id sa31-20020a1709076d1f00b006fee53b7f53mr42448923ejc.375.1654084372371;
        Wed, 01 Jun 2022 04:52:52 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ff4-20020a1709069c0400b006f3ef214e62sm609153ejc.200.2022.06.01.04.52.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 04:52:51 -0700 (PDT)
Message-ID: <5c754795-e569-1dfb-7474-658ccc3dc7a9@linaro.org>
Date:   Wed, 1 Jun 2022 13:52:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 3/8] dt-bindings: soc: imx: add interconnect property for
 i.MX8MP hsio blk ctrl
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, djakov@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        abel.vesa@nxp.com, abailon@baylibre.com, l.stach@pengutronix.de,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, Markus.Niebel@ew.tq-group.com,
        aford173@gmail.com
Cc:     kernel@pengutronix.de, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        Peng Fan <peng.fan@nxp.com>
References: <20220601094537.3390127-1-peng.fan@oss.nxp.com>
 <20220601094537.3390127-4-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220601094537.3390127-4-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01/06/2022 11:45, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add interconnect property for i.MX8MP hsio blk ctrl
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
