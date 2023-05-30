Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5C8715F4C
	for <lists+linux-pm@lfdr.de>; Tue, 30 May 2023 14:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbjE3M2T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 May 2023 08:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbjE3M2O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 May 2023 08:28:14 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6225AC7
        for <linux-pm@vger.kernel.org>; Tue, 30 May 2023 05:27:40 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f6ef9a928fso27332245e9.3
        for <linux-pm@vger.kernel.org>; Tue, 30 May 2023 05:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685449658; x=1688041658;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tlT+2nXHH7figLXYqN6h97DwdAFo3rxIuidTGSYR/P0=;
        b=sI3MnPYHWBdlGJxiLPwGf/TfKcYpod81NSp/jqBI3YWZtng5r/1mPKNwzutsfR10Kg
         DwHcdqhPcVpeSrLYmXXOWsb3iH3S4Qm80vFDhZLXQVOOayYS9XKAhPo9S76wn9sB1ArQ
         PwZWzRRrwr8mNnGETh/SBJgw/jjQk+CIKC9kVLnSme8yPNMasFySwRn1D+uo27CWNNHN
         xzPf4rayDYp4Saq1c+Tzd/ZEw/4Z0umLRNsTZRBKj30NRJ0Ebl2G3gOk6LZKdXEkZMWM
         eogv660XswWl/hQ2wcPZybEtPHy6xKc8I3mf7sQtGd39dAlRit3RXAbyft/o56g36/lb
         mlIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685449658; x=1688041658;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tlT+2nXHH7figLXYqN6h97DwdAFo3rxIuidTGSYR/P0=;
        b=Uy6t2PPQt910zPw2TIK/Z2+/G5k2F4n3/ST7cN/tcWd7dae4KcpOx4vJxe+YgGGNlK
         KYSMK6SQHdhvxR9cFouVnNcm6bRfOb2Bun3fBI7X5Ogq7cxvq7t1RxIng5xvshhfK8Yc
         4pFQs6h4MHeWlpTAhB+iGeIgT1zgjN6J7sLyfcGA++/tNx/ssXL/nUA6MFGpBI9FA5Bl
         UipN3Eb66DU+8BWwGZnCpd3ukqRXC6eN4ge3ZuL1l2MqJPwqLpEJRcjIwGhFN5MbWWlp
         BYcvK4Zdtqm8P5Dv9Rh2yMVYLPYPnHF3VC4Dj1c7GD8KMEr1d7HrDvh1rP6qg4eCPKbE
         7pAg==
X-Gm-Message-State: AC+VfDzQpX37H0Y4TDuyDj0JeWEZWX74hg8+9K8eMHTC+VQe/QQBRhGz
        z0u3xv4k6HNsDj1KBA+tkCvvaYtXMbBo1y1pTUw=
X-Google-Smtp-Source: ACHHUZ7tZSoWKLv88vvxIwF7juwlLyZPiMNgkF2OQNOSMP/LIQEoMZgC2CZdWs3Pf8uYLb5InErZcg==
X-Received: by 2002:a5d:4eca:0:b0:30a:a478:f559 with SMTP id s10-20020a5d4eca000000b0030aa478f559mr1456676wrv.2.1685449658181;
        Tue, 30 May 2023 05:27:38 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:dd1c:e75b:56ba:6bf? ([2a05:6e02:1041:c10:dd1c:e75b:56ba:6bf])
        by smtp.googlemail.com with ESMTPSA id c17-20020adffb11000000b0030633152664sm3101590wrr.87.2023.05.30.05.27.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 05:27:37 -0700 (PDT)
Message-ID: <87b0f5cd-67a8-fbd5-5ca7-a286b543d796@linaro.org>
Date:   Tue, 30 May 2023 14:27:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 0/3] thermal/drivers/mediatek/lvts_thermal: Fixes to the
 interrupt handling
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     Alexandre Bailon <abailon@baylibre.com>, kernel@collabora.com,
        Balsam CHIHI <bchihi@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Amit Kucheria <amitk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
References: <20230428195347.3832687-1-nfraprado@collabora.com>
 <20230502103344.GA3388518@google.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230502103344.GA3388518@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi,

On 02/05/2023 12:33, Chen-Yu Tsai wrote:
> On Fri, Apr 28, 2023 at 03:53:44PM -0400, Nícolas F. R. A. Prado wrote:
>>
>> Fixes in the interrupt handling of the LVTS thermal driver noticed while
>> testing it on the Spherion Chromebook (mt8192-asurada-spherion) with the
>> MT8192 support series [1].
>>
>> These are standalone fixes and don't depend on anything else.
>>
>> [1] https://lore.kernel.org/all/20230307163413.143334-1-bchihi@baylibre.com/
>>
>> Thanks,
>> Nícolas
>>
>>
>> Nícolas F. R. A. Prado (3):
>>    thermal/drivers/mediatek/lvts_thermal: Handle IRQ on all controllers
>>    thermal/drivers/mediatek/lvts_thermal: Honor sensors in immediate mode
>>    thermal/drivers/mediatek/lvts_thermal: Disable undesired interrupts
> 
> This series seems to have solved all interrupt storm issue I ran into, so
> 
> Tested-by: Chen-Yu Tsai <wenst@chromium.org>

I gave a try on a mt8195 board and I don't see any interrupt firing when 
crossing the temperature thresholds.

Did I miss something ?

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

