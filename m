Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB25050BE8F
	for <lists+linux-pm@lfdr.de>; Fri, 22 Apr 2022 19:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbiDVR21 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Apr 2022 13:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbiDVR2X (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Apr 2022 13:28:23 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F286B7C6B
        for <linux-pm@vger.kernel.org>; Fri, 22 Apr 2022 10:25:23 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id s18so17785013ejr.0
        for <linux-pm@vger.kernel.org>; Fri, 22 Apr 2022 10:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xyTu4b7ZMRhX6whN7X8zUFA8mpZ14UJCNVpEn8M9ARg=;
        b=NIa/76KBpbPcghoDEkTYGEHbQsh/DvJWClpr17LX22LfUCDZlA8v44kBeEFyZHxhX9
         dGj9bcrXhnLJcjpa+sp0fCzGeiIsd1LcqXrgUryZ4GH9Ti06OoWYQRoFgPVXYpfL3ooe
         s66wJHVJ52frfDlYQLnrn63t4ijca1CnnUSagHs4Knl1WTBwye44ShV5svAu8Su/v5I+
         ODg58bbXoXdN12+yLukNzr33J+hvPWkrjqj1G9EpS0U0VRl6WdxsnagiIZzXQkZ2egSm
         RfJaPMmssnoS3R0VoGZqg3SJ/YWBy6ttx9uicI2bDwGRr7zZWCwWIcMJk3H78ck72pMZ
         qXaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xyTu4b7ZMRhX6whN7X8zUFA8mpZ14UJCNVpEn8M9ARg=;
        b=OBr6H4vbwdv7DFJKLm+NhplidYRUowZXIt9ThXeY2CN+eNgFIqqXUBv/PPsBj0v1QG
         xuTraym905WCjLVNCumv/bxW2enn8xS4yRBYbCfe5XDQcoFQ4hM1wUurDqNm8qIcCVna
         911uMwFon6RMEzVxpJEoOWxkneDs6NSh2zYf651awmsnOevZ3rISe+lSgEaFRN7a0OD5
         APoI2fke4CDUkQkOk08bEs6NrSXx0mutqE4T7+iUWk+WVGajdN1IU92XYtv0ZQjIpBuV
         AjuxddJPiZFzoHpoEC5nPgoaQw2OWtaUEOSriK9k2iZmRjsbZDEfN7OMI0HT2zScQyRf
         j8sA==
X-Gm-Message-State: AOAM532b6Qom6MbDte3mV/k5ZWOqov8XBuS7qClxQ9Sej7YzxsGyqVSb
        ZdvEO6xaEF2H37xA5i5fmWUAiQ==
X-Google-Smtp-Source: ABdhPJzS3sVONP52JJ41oUXMaywZWInX/T1GsMDEpa4Oo7VNHKVjxy8VUX1OKglrnM+JWmBSNQhpLg==
X-Received: by 2002:a17:907:62a6:b0:6ef:8118:d3e2 with SMTP id nd38-20020a17090762a600b006ef8118d3e2mr5004725ejc.605.1650648230694;
        Fri, 22 Apr 2022 10:23:50 -0700 (PDT)
Received: from [192.168.0.234] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id fq6-20020a1709069d8600b006e891c0b7e0sm933630ejc.129.2022.04.22.10.23.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 10:23:50 -0700 (PDT)
Message-ID: <af95f353-c91d-844e-3bc1-e052f7d16e54@linaro.org>
Date:   Fri, 22 Apr 2022 19:23:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V4 00/14] cpufreq: mediatek: Cleanup and support MT8183
 and MT8186
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        matthias.bgg@gmail.com
Cc:     jia-wei.chang@mediatek.com, roger.lu@mediatek.com,
        hsinyi@google.com, khilman@baylibre.com,
        angelogioacchino.delregno@collabora.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220422075239.16437-1-rex-bc.chen@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220422075239.16437-1-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22/04/2022 09:52, Rex-BC Chen wrote:
> 
> Reference series:
> [1]: V1 of this series is present by Jia-Wei Chang.
>      message-id:20220307122151.11666-1-jia-wei.chang@mediatek.com
> 
> [2]: The MediaTek CCI devfreq driver is introduced in another series.
>      message-id:20220408052150.22536-1-johnson.wang@mediatek.com
> 
> [3]: The MediaTek SVS driver is introduced in another series.
>      message-id:20220221063939.14969-1-roger.lu@mediatek.com

These are not proper links. Please use lore references.


Best regards,
Krzysztof
