Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169164FDC95
	for <lists+linux-pm@lfdr.de>; Tue, 12 Apr 2022 13:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238745AbiDLKcQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Apr 2022 06:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376860AbiDLKTa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Apr 2022 06:19:30 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4917D031
        for <linux-pm@vger.kernel.org>; Tue, 12 Apr 2022 02:17:08 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id l7so30611059ejn.2
        for <linux-pm@vger.kernel.org>; Tue, 12 Apr 2022 02:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GhRsvMkqvOOZJ6oaXqUbn0li7sCX29u9xzmiTytidkU=;
        b=sqyfOTz7XJvOCL5M1maTVrFwiuyplXumGmdQcsG5q+E/kmxF+RY74KM3gGHaX+dXWQ
         IgXgoAqq0nbUBzxBaYqJ67ua3WQHE78OOnsNkkCtlSNdr2ok9W9pGfd9kDc35HNM+3PL
         ZofHRa+AVA+/tnD93nN7h0e/SWxCH7W7FSaTcqKY4G/thTKVIH6rz6mJ9gSjrWwN23Ll
         /8eb8Pdf0eLYNq9Fhw3W/hTCzIBEcC2GS6CZAVtizlWq2uCZGh5dZNOBE3LWDFn5k+8h
         ecMFhQ69Ri9j6CQ0dMcw8OVKH7KNjYhNqTY3Qma38vQytSAJ6ULJvn/K4ng8P7ZEm9DS
         VauQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GhRsvMkqvOOZJ6oaXqUbn0li7sCX29u9xzmiTytidkU=;
        b=SV3AOcEY3t9ERPJ2vWm9R/A+5gDZ4PjgiuSVsURK+FFC7c/kGhyJ8oqS8OcuQkljMm
         RlAVCLjABELLIKrVolJTbVdfbWkqJOudYo4KQDjc8+zJE+HnzzOwDiuKx8IwVDms6sjU
         xOmu1A1Q6TvWjeeQEzbEugZNga16yz0mMLMbSMiT0hqZbF2/xPViDDUQy0AWkAWhxvEi
         ovZ132hNZGg8Ldn/ymsaFVNxK4e5M+/1t5TyxarI6AlJDLFL+BiWlkpzNsvRjKyqqnNi
         BEqArNviBvOvuAwipezKrC83iyUPZNKgW1itkNgT0yNaf4PanooXikOycvgb4xTXgRMT
         8/1g==
X-Gm-Message-State: AOAM531Eb29yxYVK+ncAhXgUfcBxWtQSa7rxI5FmjT3aKxu5Rqfu40qi
        8+n/JmONBG2Xw/uaVA7Xwx5VgA==
X-Google-Smtp-Source: ABdhPJytgzbzMy/xrcB0VUNhJafmlE2cIehjiSoAP81ZGOZ6ie8XloS5sE9HdQwarBVxSude5T6RtQ==
X-Received: by 2002:a17:906:3082:b0:6e0:111f:8986 with SMTP id 2-20020a170906308200b006e0111f8986mr32504576ejv.677.1649755027477;
        Tue, 12 Apr 2022 02:17:07 -0700 (PDT)
Received: from [192.168.0.194] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id g2-20020a50bf42000000b0041cc5233252sm13533827edk.57.2022.04.12.02.17.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 02:17:07 -0700 (PDT)
Message-ID: <39152c86-ca11-2792-6b25-ae55ffb47b09@linaro.org>
Date:   Tue, 12 Apr 2022 11:17:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/2] dt-bindings: devfreq: mediatek: Add mtk cci
 devfreq dt-bindings
Content-Language: en-US
To:     Johnson Wang <johnson.wang@mediatek.com>, cw00.choi@samsung.com,
        krzk+dt@kernel.org, robh+dt@kernel.org, kyungmin.park@samsung.com
Cc:     khilman@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, jia-wei.chang@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220408052150.22536-1-johnson.wang@mediatek.com>
 <20220408052150.22536-2-johnson.wang@mediatek.com>
 <855d7daa-45d1-d6d8-32bd-51778cf58392@linaro.org>
 <fe7d2b878c18a42ff36ebd9911ecb562fe29c953.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <fe7d2b878c18a42ff36ebd9911ecb562fe29c953.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/04/2022 14:10, Johnson Wang wrote:
>> Also please put it in the "interconnect" directory.
>>
> 
> I don't really know about "interconnect".
> However, it looks like a Linux framework about data transfer and "NoC".
> 
> While this cci driver is more like a power managment which is
> responsible for adjusting voltages and frequencies.
> In my opinion, "devfreq" should be more suitable.
> 
> Please correct me if my understanding is wrong.

devfreq is a Linux mechanism, not a real device/hardware. We try to put
the bindings in directories/subsystems matching the hardware, therefore
devfreq is not appropriate.

Whether interconnect - or other subsystem - is appropriate, I am not
sure. To me this looks exactly like bus bandwidth management and you
even use "interconnect" in several places. So interconnect matches.

Best regards,
Krzysztof
