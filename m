Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A58277F13F
	for <lists+linux-pm@lfdr.de>; Thu, 17 Aug 2023 09:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348488AbjHQHcm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Aug 2023 03:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348515AbjHQHcU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Aug 2023 03:32:20 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E742D56
        for <linux-pm@vger.kernel.org>; Thu, 17 Aug 2023 00:32:19 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fea0640d7aso33417985e9.0
        for <linux-pm@vger.kernel.org>; Thu, 17 Aug 2023 00:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692257538; x=1692862338;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/lfeGgarqr8pvmcuCLypxJFrX3Z81nCjpOrSpMVIpPo=;
        b=yT5FAOhF6gcp8/gcIoR9hoFCQJmlkdyfZWyH2eFpTg/OvWV/if8NXZNBwvUksR+zb1
         nf/MYJ/8OfcqlfFnZBDr5weV0HaaluaoGl3ythidYiFlfFmw6Fx6vfTJBDdzXyo2oOdb
         xq/cfluT5fVb823uvGRbSIh8ekssBRq4Dkeg1B4nt9bcnIQ7bsEs4W2Y8ngF+JhplLPx
         j2xp/SmQ/ecnEY08x6gDn2wBxMen4AnePopH8kBSU537TBeOKvwSqCEJpdiCTmmgOJQD
         U0Spk4dCF41PH/KkIcrimH4FQewtaEEKUHemawCXlYgdfFkAo4Ri8uvRbCQ3AGB9E/Iq
         JTQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692257538; x=1692862338;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/lfeGgarqr8pvmcuCLypxJFrX3Z81nCjpOrSpMVIpPo=;
        b=Z+JnPBxEHFB+uJWYSm81HRGHIw7zVYnBf0ERFyoMGvLNuz/M8B8gA3/Ac6SAE+IrJV
         OUZgH6wvUaM7Db+C4EGaDpUOBYevz01lpa8+CloFgAHrfpxBs+/kVjOrhDeURY1n02Iz
         pEUJ5FO3lHLEqgudKAK0p3lqUthxerp3WgU4jp8k6Tt6VKcHnHFFA5MAdPFPsoF0uAFI
         CJ6kBGsRz5bjR50T6edosAxj9J7ViEikLV5QVgV/NSMKHbK78bpxBIpVfV9zBm9wPgOI
         7Ww8ymQMQoSkQbO2bPQluaFFfx7uFrqUF1n3NxAjt18Dw8stnoTVN2I5rAvfb16Dmnhc
         bfYQ==
X-Gm-Message-State: AOJu0YzYriyAjli2j5ZIsdV1vh4wxurdg6Tb+cLLQ9ejMGB9+V3aWcAp
        M0kjOMgW7Q8ksAk0qkx++ItKeF22dF9VSLBd4Ms=
X-Google-Smtp-Source: AGHT+IGAyVzAPE7vkoVKh0iPQCvd79KGjFUfpsbg7VM5Ch/A1X9FCDTW1jbLAH3G+3USuhoP2d3rEw==
X-Received: by 2002:a1c:ed13:0:b0:3fe:111b:7fc4 with SMTP id l19-20020a1ced13000000b003fe111b7fc4mr3356597wmh.21.1692257537924;
        Thu, 17 Aug 2023 00:32:17 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id e11-20020a05600c108b00b003fe557829ccsm1920787wmd.28.2023.08.17.00.32.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 00:32:17 -0700 (PDT)
Message-ID: <5c641067-fe4a-b515-9c04-32ec82b2c68a@linaro.org>
Date:   Thu, 17 Aug 2023 09:32:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH -next] thermal: ti-soc-thermal: Use helper function
 IS_ERR_OR_NULL()
Content-Language: en-US
To:     Li Zetao <lizetao1@huawei.com>, edubezval@gmail.com,
        j-keerthy@ti.com, rafael@kernel.org, amitk@kernel.org,
        rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
References: <20230817014900.3094512-1-lizetao1@huawei.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230817014900.3094512-1-lizetao1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17/08/2023 03:49, Li Zetao wrote:
> Use IS_ERR_OR_NULL() to detect an error pointer or a null pointer
> open-coding to simplify the code.
> 
> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

