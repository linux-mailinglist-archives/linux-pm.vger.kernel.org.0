Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B0D4DB60C
	for <lists+linux-pm@lfdr.de>; Wed, 16 Mar 2022 17:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244432AbiCPQVD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Mar 2022 12:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245536AbiCPQUw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Mar 2022 12:20:52 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F37F2B19E
        for <linux-pm@vger.kernel.org>; Wed, 16 Mar 2022 09:19:37 -0700 (PDT)
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0AC7E3F366
        for <linux-pm@vger.kernel.org>; Wed, 16 Mar 2022 16:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647447576;
        bh=ZRYQ7z9tZ99+GzXwYfi9q+aq0P3XgrXRoIknWvHPWiY=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=Da092m7MQiFrclop2JPRDe7V0I3y3BjCBJwYLXQmwQ1xopVwD+NifT1FsgPXiGN+o
         lCcIO9aiDht0Zpd7MA8xco7M6yEZUAD4Lv97xsj+INZveiAaaG+4I5DKz9XIQdGQW8
         T2dvvb6d87YJuvQYQLed2CnGbxNhAHG3LaMIMxbZouxU/sjio4oHxhAaifwZp54o3w
         4eaC2eOhzRydZ8RO6p0+ILlCa5r3xtzYNdUbD1jOP30ynZ7SRhv2CG4AJEvven5/r9
         teeO2RxL5/5v11B81pPlgJfNJupXtH01tm7fxgWnpePvwlOUW0Xs327iUxIJrC9MKe
         M5MXd9hKW/1cw==
Received: by mail-wm1-f69.google.com with SMTP id 2-20020a1c0202000000b0038c71e8c49cso718974wmc.1
        for <linux-pm@vger.kernel.org>; Wed, 16 Mar 2022 09:19:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZRYQ7z9tZ99+GzXwYfi9q+aq0P3XgrXRoIknWvHPWiY=;
        b=2HuaFgMioiNyN0twM6spLmOVwLz9yW26fN2rcYNJlpLnqeD/A2NNhY2hkD4I5q9Fbi
         /SaEcQNiURbT8Iwt/LFZ47IPzEDSTKxzReIhMmsJlZBstkLF/TIBamrWEDu49KyHapcV
         aa4pesk9Hn7DOQ8+xgiC19TSxsxgR57qcoFP2M/hc0ZFN4b3u1rOVunezGWIg5Qwyj/8
         rglNKB6RgJ5SUSsX6FeJmBbeSOt4ZjDmuCquqxKNHFOw72fE3/qcNlf5+Pst+pi6uMfO
         D3i2Dm7WCJTq2K74+HoCGy+6WnZ9IpP+LSHdVjsHXHIJno+kugqAjp3xj919RTrmllF2
         aEeQ==
X-Gm-Message-State: AOAM5307pet1VuJ+8cSjZ1Y1NVtc0EeA3jUevC/76ICyaKermfzMHE+V
        3Uv2eCoIjQW/7GI2ASQyDACEm3BcwLouxjcVs+thQiuPCpkPHSSqP8k5y0xNJlw0PEwk1nU6WK2
        3qarhqoxAt9YwDoxPzBPcY4qQhr9wqLhPD1JC
X-Received: by 2002:a5d:6da5:0:b0:1f1:f968:1a62 with SMTP id u5-20020a5d6da5000000b001f1f9681a62mr554988wrs.227.1647447575678;
        Wed, 16 Mar 2022 09:19:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgYANb6+IHUjd2tYv3t6zuG8C+19OKOirVe7PMEmdJAJNWdgt0WY7zKPbaRDMj+QIXT6tXnA==
X-Received: by 2002:a5d:6da5:0:b0:1f1:f968:1a62 with SMTP id u5-20020a5d6da5000000b001f1f9681a62mr554978wrs.227.1647447575512;
        Wed, 16 Mar 2022 09:19:35 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id i11-20020a05600c354b00b00389f440512esm5719821wmq.32.2022.03.16.09.19.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Mar 2022 09:19:35 -0700 (PDT)
Message-ID: <fe67c7e7-957b-3abf-a929-5ee346657bcf@canonical.com>
Date:   Wed, 16 Mar 2022 17:19:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5 2/2] dt-bindings:thermal: Add Sunplus SP7021 schema
Content-Language: en-US
To:     Li-hao Kuo <lhjeff911@gmail.com>, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        robh+dt@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, lh.kuo@sunplus.com
References: <cover.1647399369.git.lhjeff911@gmail.com>
 <71c1b80e0083f38de71f36193e12b3cbff2ec852.1647399369.git.lhjeff911@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <71c1b80e0083f38de71f36193e12b3cbff2ec852.1647399369.git.lhjeff911@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16/03/2022 04:01, Li-hao Kuo wrote:
> Add bindings for Sunplus SP7021 thermal driver
> 
> Signed-off-by: Li-hao Kuo <lhjeff911@gmail.com>
> ---
> Changes in v5:
>  - Modify yaml file remove reg name and change nvmem name
>  - Addressed comments from Mr. Daniel Lezcano
> 
>  .../bindings/thermal/sunplus_thermal.yaml          | 47 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/sunplus_thermal.yaml
> 
> diff --git a/Documentation/devicetree/bindings/thermal/sunplus_thermal.yaml b/Documentation/devicetree/bindings/thermal/sunplus_thermal.yaml
> new file mode 100644
> index 0000000..176bc07
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/sunplus_thermal.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright (C) Sunplus Co., Ltd.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/sunplus_thermal.yaml#

File name with vendor prefix and comma, so one of:
sunplus,thermal
sunplus,sp7021-thermal


Best regards,
Krzysztof
