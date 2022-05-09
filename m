Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E75651F4E0
	for <lists+linux-pm@lfdr.de>; Mon,  9 May 2022 08:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiEIHAV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 May 2022 03:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233244AbiEIGqc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 May 2022 02:46:32 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18281312B5
        for <linux-pm@vger.kernel.org>; Sun,  8 May 2022 23:42:37 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id z19so15073057edx.9
        for <linux-pm@vger.kernel.org>; Sun, 08 May 2022 23:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uJOQksv/Nz7S6hCUok26zJ6fKbWWbQlYtjVxm6ipB6o=;
        b=rPQ7B5yo6cD6nD6lgS4qglTb9gjR27VlU5Ie1sQOZvcSpF+l8ZfE8rPTipH7OnrLRK
         zhl/da1BJmVs4UzWOoHQq6rfRV2XWth6NfQnge+zDf39c3wMYvt1OeqnHeN7r0o1UR1m
         3b8x61LfsD5eo7AaltIOGOU7E70FHi+WRldTtz3+cIFQ14L0VeF6pvgMyPY5QFAGft5T
         vRYCmHluuHCvORXc6DVO2wxAi7voI9im5N0w1/xfY9cxNkkeDKRnPQs3tzCwXOzrQZHz
         YZtcXokO7fX+orSZXTie6NyyOS/8Nx4+zoOCpBv3SeLgQDkstwJILvL55tnoWBNtUPyJ
         SKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uJOQksv/Nz7S6hCUok26zJ6fKbWWbQlYtjVxm6ipB6o=;
        b=h7Zpjo6E+dQLgxLrtbYh4aZNoN9lUrQn/2CoRwd/C70R83xoeV+J4DEA1SWU5G6Uzb
         uMluliH2oQku6IVxHk9CUkOwu9iFApEV0WU03Zj4oJbOkxowatIjySQpPhaCjEpljk46
         VDvMry7IKsuOTYPLCfdObV77eUJ2T3pqmJ4bkbkWDqXS08UfffBvOvs6bJxPpesRj42J
         2iKWl+0OCBK/pjSoI98vTnVAyKsw3h3MVKqx/pnwmA5P/dhR9+UoHWvRlwvE2fQ3oxYS
         /eNPiMNn1bJAuhYIFSVgMAQDIkN5gC52nSfkbNXZSqSwLLNdamSEHyqHZDGnYg6WY1OF
         RzaQ==
X-Gm-Message-State: AOAM532nIbrfrbMqo268bnVT5Dw76Zi0s5vVs6TXSMh6wdgecXctNl6C
        YMLZdicK6eXkjvuc9J9LIyYi/eDdLhXh3jG7
X-Google-Smtp-Source: ABdhPJxtgRhW3ZJj9MbSV+/lI8mw0cEll+Lr/P1aCjNSFND2BqVyrj1DygJfs/9L3aylDRAqiVBMVA==
X-Received: by 2002:a05:6402:289a:b0:425:d682:105d with SMTP id eg26-20020a056402289a00b00425d682105dmr16072838edb.175.1652078556379;
        Sun, 08 May 2022 23:42:36 -0700 (PDT)
Received: from [192.168.0.242] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id cn18-20020a0564020cb200b0042617ba639esm5764601edb.40.2022.05.08.23.42.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 May 2022 23:42:35 -0700 (PDT)
Message-ID: <eb0745a6-ecf2-4b70-368b-9ad8a322f208@linaro.org>
Date:   Mon, 9 May 2022 08:42:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v6 1/4] dt-bindings: thermal: k3-j72xx: Add VTM bindings
 documentation
Content-Language: en-US
To:     "J, KEERTHY" <j-keerthy@ti.com>, robh+dt@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, amitk@kernel.org,
        kristo@kernel.org, vigneshr@ti.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220427064635.24898-1-j-keerthy@ti.com>
 <20220427064635.24898-2-j-keerthy@ti.com>
 <5859fed0-82b7-95eb-5719-9b0016916c50@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <5859fed0-82b7-95eb-5719-9b0016916c50@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09/05/2022 05:18, J, KEERTHY wrote:
> 
> 
> On 4/27/2022 12:16 PM, Keerthy wrote:
>> Add VTM bindings documentation. In the Voltage Thermal
>> Management Module(VTM), K3 J72XX supplies a voltage
>> reference and a temperature sensor feature that are gathered in the band
>> gap voltage and temperature sensor (VBGAPTS) module. The band
>> gap provides current and voltage reference for its internal
>> circuits and other analog IP blocks. The analog-to-digital
>> converter (ADC) produces an output value that is proportional
>> to the silicon temperature.
> 
> Hi krzysztof,
> 
> Any comments on this version?

You got Rob's review, so you don't need also mine.

If you want, then in general look okay, except the description for "reg"
you could split per items:

reg:
  items:
    - description: VTM cfg1 register space
    - description: VTM cfg2 register space
    - description: efuse register space

It's more obvious what items you expect.

Best regards,
Krzysztof
