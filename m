Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1AE6D33D7
	for <lists+linux-pm@lfdr.de>; Sat,  1 Apr 2023 22:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjDAUiP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 1 Apr 2023 16:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDAUiO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 1 Apr 2023 16:38:14 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB6B1A460
        for <linux-pm@vger.kernel.org>; Sat,  1 Apr 2023 13:38:13 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id n19so14884759wms.0
        for <linux-pm@vger.kernel.org>; Sat, 01 Apr 2023 13:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680381491;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RaeiX9EdxQ+G9xoCkZsd12/NSVD20AWdIKnmJIXd8HY=;
        b=UvHq6rgsoUw5HQ+32mAlR47rUiWddxfGMkG7EsJPaUAFivKjA3JQI6Tr3zV/LiBDhW
         UpMHoqcSw2J5W37BJk94by64Ft0EgzYdogXx2fovMjwAV51c0qBccG/xoyROXPnrpBUJ
         Rh85eitRQQ0CSiw2iqP8ESbGCsNC6hS5j6jrUJFDW65y7m7ebWt0g1L3xpOiN+oMTpoo
         k/qnYZeCLyWgtGcd5nCiyLj5MWO0tVH6F0PIocO1w1PYOqrSH4FWTlA0TjF52z1HWIKk
         d+Jq+5PHuzk83HOgIs+5TfLA2LhTQIko80I/Oat3LfoyleCZfNodfGod1wJFPa60Gf4t
         iPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680381491;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RaeiX9EdxQ+G9xoCkZsd12/NSVD20AWdIKnmJIXd8HY=;
        b=ySSTLr27LsQesGFxqMibHFmtFl2eEt4NL17y9oer1YyjurO3glZTjkWvhKlnXMMY70
         aSTpubQdKBe16b+s9hMUM2O5D4KDbEIEw60/WjxGnNnVhW6X8BarpgjT+bXWDCqODD9C
         Nq5jR0VXHrAG/qJkQe1rFS1KRPm4PjXQhA6z3KL7Uf18USc+JPJ1YGuh65e4U9mM0a28
         /eS5WFBD0gISJmoePaI/ZrHM9/IJMkMqEKwjjOH/f87/Yns3a6QNcT6EzwcZjYPDuQlM
         nh5c4jUiOjsXsfT8wPU0Ca0MAAdcV8PgaZcxAb1PebUFsYGiFG6QvC8fPNpgncttm4jJ
         B+Xw==
X-Gm-Message-State: AO0yUKVygiQxKoco1d5XzZkZbAZphhFRwVykv2cJSGofj5iZUloPhmPJ
        /G4eJTYKYLuKHB36M0G4wk4MmA==
X-Google-Smtp-Source: AK7set+piPx/xqNwNWikmQSUIScX7VtS1tyyyibUMrga0PeSsXZPDOGRRgUpJYh4AX6OWPTmKTtyYA==
X-Received: by 2002:a05:600c:2283:b0:3eb:3104:efec with SMTP id 3-20020a05600c228300b003eb3104efecmr23097598wmf.16.1680381491524;
        Sat, 01 Apr 2023 13:38:11 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:b36a:1186:309c:1f9a? ([2a05:6e02:1041:c10:b36a:1186:309c:1f9a])
        by smtp.googlemail.com with ESMTPSA id t23-20020a1c7717000000b003edcc2223c6sm7089922wmi.28.2023.04.01.13.38.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Apr 2023 13:38:10 -0700 (PDT)
Message-ID: <0234d87e-1980-51d9-1656-70f7f7058af4@linaro.org>
Date:   Sat, 1 Apr 2023 22:38:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] thermal/drivers/mediatek/lvts_thermal: Fix sensor 1
 interrupt status bitmask
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Balsam CHIHI <bchihi@baylibre.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230328031017.1360976-1-wenst@chromium.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230328031017.1360976-1-wenst@chromium.org>
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

On 28/03/2023 05:10, Chen-Yu Tsai wrote:
> The binary representation for sensor 1 interrupt status was incorrectly
> assembled, when compared to the full table given in the same comment
> section. The conversion into hex was also incorrect, leading to
> incorrect interrupt status bitmask for sensor 1. This would cause the
> driver to incorrectly identify changes for sensor 1, when in fact it
> was sensor 0, or a sensor access time out.
> 
> Fix the binary and hex representations in the comments, and the actual
> bitmask macro.
> 
> Fixes: f5f633b18234 ("thermal/drivers/mediatek: Add the Low Voltage Thermal Sensor driver")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

