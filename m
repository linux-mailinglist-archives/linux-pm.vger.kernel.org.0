Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30D56521E7
	for <lists+linux-pm@lfdr.de>; Tue, 20 Dec 2022 15:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbiLTOCg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Dec 2022 09:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiLTOCf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Dec 2022 09:02:35 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EF21B1D0
        for <linux-pm@vger.kernel.org>; Tue, 20 Dec 2022 06:02:34 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id f13-20020a1cc90d000000b003d08c4cf679so8857417wmb.5
        for <linux-pm@vger.kernel.org>; Tue, 20 Dec 2022 06:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ggrQrvtjD4raQxhDVum7ur/FE1FzwO0y0Jf1jzOu9qE=;
        b=ao3/jNrlSI9MJgP/gV24Sjzpa0tWEjQEHhKqQ3v++DTIMLxyxjDF00c7eBczezvoRN
         7H0AsAXinpogCQvwUje0DTq5eNKB90P4TjqJhjkMUZAR6XKRFbory9G0ES2uxBsDI0HC
         jubA/U/+D1Bhr4xPuRYL4HBMS0rhZFE2B06q7nYRsxHYUIQHNgo/LwBHKiVtco4Cs5tK
         Ux5Ct/kXj4g7SgrghrnLAmmUPmYdItAmhQVFlir9GUEnNIa+FFl9JVRCCseCnkkBMo9t
         1xG/GXjxf41qpwzmMwNkQLDwQIKm/LBMKLCe/ubws6P2GNXfEzKfo0SdIDzA9oX4Mypo
         GwqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ggrQrvtjD4raQxhDVum7ur/FE1FzwO0y0Jf1jzOu9qE=;
        b=ZYbtiV3yMtmhUKGh7aKR70KcNVGGahNUVX9BdX1Ug7weVxANegLUV3sMvyQxNPORLn
         IZ6yJt4joNPWWTBk138tN+da2zDJyuOGFmFagmxRjftJOB8s908GUx/TFs0dGEkuY4eB
         Tuhli+S8vf8kuCk54zJ+31sM8xU0aBVuT2oGtCV1PH8MPGU6L5r9niWNiSNmupAwno7j
         v8SK+QSBEjyOsXMkBw9zfDGq5d60rQQ6S/X90BzEhnvpoHFVF6yGOtXAfUSffZBHmb6B
         LPBUm2NF7NHeEOy6iYgKyZ9xr8jiPCPwVuJvSKXSlAeP8hudXwhGxxrLL1thnlf2xkKd
         cQpg==
X-Gm-Message-State: ANoB5pmOvaEOC6X0s9p0TbU3o/xO4rxUypKWJvD7bdgX0zDETBwwHC5N
        oBqy4jnVbYo8iQZeQjbIEeb8ow==
X-Google-Smtp-Source: AA0mqf40nv+LdZQlx9TLtX8UvfivjBfsddq/oB/PTH870xyRUEZ+HJNbOGjsdmRfLMyG7/pPkyyh0g==
X-Received: by 2002:a1c:cc1a:0:b0:3cf:5583:8b3f with SMTP id h26-20020a1ccc1a000000b003cf55838b3fmr36080790wmb.20.1671544953482;
        Tue, 20 Dec 2022 06:02:33 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id p16-20020a1c5450000000b003d07de1698asm22686656wmi.46.2022.12.20.06.02.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 06:02:33 -0800 (PST)
Message-ID: <5f8bfaa4-945e-21d9-a951-221b9c9b6ac8@linaro.org>
Date:   Tue, 20 Dec 2022 14:02:32 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 08/15] thermal/drivers/tsens: Drop single-cell code for
 msm8939
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>
References: <20221220024721.947147-1-dmitry.baryshkov@linaro.org>
 <20221220024721.947147-9-dmitry.baryshkov@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20221220024721.947147-9-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20/12/2022 02:47, Dmitry Baryshkov wrote:
> There is no dtsi file for msm8939 in the kernel sources. Drop the
> compatibility with unofficial dtsi and remove support for handling the
> single-cell calibration data on msm8939.
> 
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Happy to take an off-list or follow on patch from Dmitry to re-enable on 
8939.

I will drop the relevant node on v2 of the 8939 patches in the interregnum.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

