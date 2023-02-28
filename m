Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6716A575F
	for <lists+linux-pm@lfdr.de>; Tue, 28 Feb 2023 12:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjB1LBZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Feb 2023 06:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbjB1LBY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Feb 2023 06:01:24 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227EC234E8
        for <linux-pm@vger.kernel.org>; Tue, 28 Feb 2023 03:01:23 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id r18so9287254wrx.1
        for <linux-pm@vger.kernel.org>; Tue, 28 Feb 2023 03:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677582081;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GTnTFqFPURW6kCKalJs0xI9sPB/wYdaYDcHb/G/mcAk=;
        b=jcscAv4rGw44xsz28EtfKDjevgpUawaIBI1qVtdGNgzPF3WJ1OAMvjz7hmOaX9idwT
         1LHOC2WDaVdq401Zp7CYo9xuTTP24Y1NOB/YhZxXWMp0aPUXHPPs2H/+CE4f21RgqRew
         MNqf74laTDtegpgEVCvIrma53cjgifBoi+O/nkNjxYReth31DPOP1EAI4P+3dRJO1S89
         +OMjl919FlVS/kW2dzfjiTqs0ZbQiujS92apeF9SzsvlSpiC9z6OSxswNK6G+9dH4uTT
         Nn0iFqsmRUpKT6iMc4rFhnp4inCOiWGojQJeX3SkjpSZ96j27+OlFnkbX2HohGx2lWsP
         sbcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677582081;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GTnTFqFPURW6kCKalJs0xI9sPB/wYdaYDcHb/G/mcAk=;
        b=ulmpQZCjQEvOPJlLIxuRioN6uerYpbNfYF8XzTphki9dIg3R2Ldp3S3WPv4U1wflCU
         Ww0+7Q8te3m3XtXaLVNYKJhlnNE4LBXDZaMxxg8iwGPq7R25c1y8DVU1So2++j3UTH5M
         G6+VoINZpy6Qf08YGSBW2T6h5z3hRYplMGt2VOra3SPgUiNcHXCscVdeZ0NwxX7a8C/K
         v5OuqZWaffTNMmXZIrpqYDHHsvRPUnmIRZ4OiVCv2qky8FFTDQu0FlhtE0MSI5RRWQNQ
         LLUTpfJz7D2/X5VVAdw+fSbYULfbU0dJy5LZ4oT43M4ZWqb2k2bydwzWWpMuosfmSdqT
         QUbQ==
X-Gm-Message-State: AO0yUKWkLw6gFnA5OJbLYj2vA3aLdrCsDHHUcFmSiT/MeJI5xrumfJKd
        szkYx0a64jxHCAQUkfF8JO5d3g==
X-Google-Smtp-Source: AK7set+q+5xFa0reU4GdXOhnWjTmVynWLRP4S+5Vw3DU134iwPiJjJx1hU7GaMR/sFB/AEprtrSCEQ==
X-Received: by 2002:a5d:6b10:0:b0:2c7:dad:5630 with SMTP id v16-20020a5d6b10000000b002c70dad5630mr1757683wrw.27.1677582081492;
        Tue, 28 Feb 2023 03:01:21 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:6830:6390:2815:b6a5? ([2a05:6e02:1041:c10:6830:6390:2815:b6a5])
        by smtp.googlemail.com with ESMTPSA id n31-20020a05600c3b9f00b003e8dcc67bdesm17389676wms.30.2023.02.28.03.01.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 03:01:21 -0800 (PST)
Message-ID: <321f2575-6a2b-6574-b5bf-42ffa6a68334@linaro.org>
Date:   Tue, 28 Feb 2023 12:01:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 14/20] thermal/drivers/da9062: Don't access the thermal
 zone device fields
Content-Language: en-US
To:     DLG Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>
References: <20230226225406.979703-1-daniel.lezcano@linaro.org>
 <20230226225406.979703-15-daniel.lezcano@linaro.org>
 <ff124b19-4a21-f9f8-4249-d72e3b8dbd6a@linaro.org>
 <OS3PR01MB8460E9E5C18126A0A0930E15C2AC9@OS3PR01MB8460.jpnprd01.prod.outlook.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <OS3PR01MB8460E9E5C18126A0A0930E15C2AC9@OS3PR01MB8460.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28/02/2023 11:04, DLG Adam Ward wrote:
> On 27/02/2023 18:14, Daniel Lezcano wrote:
>> Hi Adam,
>>
>> are you ok with this patch ?
> 
> Hi Daniel,
> Yep, looks good to me:
> 
> On 26/02/2023 23:54, Daniel Lezcano wrote:
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>    drivers/thermal/da9062-thermal.c | 11 +++++++----
>>    1 file changed, 7 insertions(+), 4 deletions(-)
> 
> Reviewed-by: Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>

Thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

