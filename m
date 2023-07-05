Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29522748378
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jul 2023 13:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjGELtv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Jul 2023 07:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjGELtv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Jul 2023 07:49:51 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92538E3
        for <linux-pm@vger.kernel.org>; Wed,  5 Jul 2023 04:49:48 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3141c3a7547so6754285f8f.2
        for <linux-pm@vger.kernel.org>; Wed, 05 Jul 2023 04:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688557787; x=1691149787;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lBdhQMjZ1nmdVkf9BPqZOJoWodxWjAZazvM+FwYqquU=;
        b=lvWaH8FhmcKK4FHYbjSZy+vvVeZPVdi5dzrJra3N8JSUQZLCodRkpRjG/VErV0KaRa
         XubE1cBmEq6dXiEGMbg/Cnfre0T1PU8u5pet31/BbuxauVeKTSRyfziztq3/2/1VSHV9
         PIj3Bg4bOoFKwIRXDavIFNVq2V2P6uQ1an0pmoD5jNXDwoapzjZ43JX6/dfu4Frpppyx
         kIRq6oLhzBHGBI69Vn9AawlNlYpvcRsum/4lxFfZvoFh+poS2asS2t/b/KrLQOKj+0W4
         p2aabg9IeaRhTp5djHtxxsVutqIH/mj9eWpf/VKLh17Uig8kDxcd3xnK5n0jmXq8dQkD
         HEDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688557787; x=1691149787;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lBdhQMjZ1nmdVkf9BPqZOJoWodxWjAZazvM+FwYqquU=;
        b=egac5RS0EUic6Wn/3Xv2h/UizAdUhWu3HmE7Ezym94AsWh0Te5aERzfqI7LE6mMC2D
         ew/Ae78kpZdZ4HUFKcn8KGS6ccMhSN/4E6ZoE3qSDj4RiQ2a69Yzg7YdVDD+yd+AuwUw
         Ljk+NijEb/MYr4++X1U26AeK3gybeMuAvfZcYKaugs89o0+0KPk/wLNkkVeO5sUh8cXJ
         s3c9whJwiPtqya4ZHpmMu0Dj5MFqp+w7rHleA7NxXTxf4oheHwCiDxa4I7T38kwJAHxD
         3jnRjFr2EvG/4kMA6Uhl2qhY4R+nGWrU+rNDMQF6l1M+t3VZLYU4kfoSx4fj7CNhH7rZ
         nE/Q==
X-Gm-Message-State: ABy/qLYhjfKpaadYWsGFw9p9GyA0GEYQ45d+8d8Z8A+ILOC0kLGcJUpz
        i+lVwBNg90KAPwmDF6NzjqmSRg==
X-Google-Smtp-Source: APBJJlGA54lpF7GkU8VEDpwGTeAGM+Ylm1KCIcUDHKGYR+tvHzBEJzquneg2oziHR1M5iEmZ/0/g/g==
X-Received: by 2002:a5d:544d:0:b0:313:e146:1816 with SMTP id w13-20020a5d544d000000b00313e1461816mr12558836wrv.24.1688557786918;
        Wed, 05 Jul 2023 04:49:46 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id c8-20020adfed88000000b0031433443265sm9361029wro.53.2023.07.05.04.49.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 04:49:46 -0700 (PDT)
Message-ID: <1845ebfb-8b1a-c291-6724-73df3639905b@linaro.org>
Date:   Wed, 5 Jul 2023 13:49:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5/8] thermal/drivers/int3400: Use thermal zone device
 wrappers
Content-Language: en-US
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     linux-pm@vger.kernel.org, thierry.reding@gmail.com,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        open list <linux-kernel@vger.kernel.org>, rafael@kernel.org
References: <20230525140135.3589917-1-daniel.lezcano@linaro.org>
 <20230525140135.3589917-6-daniel.lezcano@linaro.org>
 <ab892878-9c66-f94f-cf4c-9961723411d2@linaro.org>
 <74c232550c6787ef34ddac67a61339e6c028fb0d.camel@linux.intel.com>
 <77c90891-3712-4b3b-a22c-d9ccba36f58e@linaro.org>
 <f3679761bbf31ff93d45985f67a85f28b0027eac.camel@linux.intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <f3679761bbf31ff93d45985f67a85f28b0027eac.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 05/07/2023 13:35, srinivas pandruvada wrote:
> Hi Daniel,
> 
> On Wed, 2023-07-05 at 12:41 +0200, Daniel Lezcano wrote:
>>
>> Hi Srinivas,
>>
>> thanks for your answer. What about the patch 6?
> I was not CCed. But checked from LKML,
> The change looks good.

Actually, you were Cc'ed, the mail may have been lost somehow.

Anyway, thanks for the review. I'll resend with the changelog fixed in 
patch 5 and your acked-by

   -- Daniel

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

