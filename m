Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27F252EF26
	for <lists+linux-pm@lfdr.de>; Fri, 20 May 2022 17:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237193AbiETP0b (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 May 2022 11:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350852AbiETP0L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 May 2022 11:26:11 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6536611C22
        for <linux-pm@vger.kernel.org>; Fri, 20 May 2022 08:26:08 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id ay35so3102168wmb.5
        for <linux-pm@vger.kernel.org>; Fri, 20 May 2022 08:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=IIqtgCzNSeqKw8j48M0jMnpUd6n4sTNC1dQh3wc63iM=;
        b=AfEwR7pD0jiCCW/0Ra5X7F+iAknaRwE2El2kpNq0r1TQLVYXYO1U5mqTfazW1BxM85
         +VVyEPU/5CDpIACcvIUJ7foobxlepMPbMy5zoAO7IhKgAHz6o7wGtckAIJyGXE7ODVaZ
         2mPd1SNBm7wVuDg1LNjXPZgluibOzeMvY7Ioxs/7S7UGdSI37HkySCA31QeSa+Q7/UYG
         hkig0XWzejvYcRbFPP1dz9rDdlyTThVpjgC1LzJFccUPXjjHZ7fIcDL5ETQR6E3dnOkj
         FdXSKlHPspNxCLQxRPcH/MisMNidn2QWmLJuFyCkWMnQdEGzJ050rxvfLu0pLoWHYCYK
         AMKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IIqtgCzNSeqKw8j48M0jMnpUd6n4sTNC1dQh3wc63iM=;
        b=M+amUEMrkgDqhGNid1uhVgIRW6XgJytAgSAsG/ZU20zobmQuPbbV+u26g37BDRaODf
         0lrVzyLiZA2VjWncJR+aLas1MNbqgmE0rYJgfLSU5ReXh478bL2i5o72iMe9AuOVk0yB
         4vuZ6otEgKY3t1Mv4rdIe7axRqmK/7ZRUdQVNZD/KgHGr1cN47kmFtRD+7Jg+QKp4P3k
         m+lGz4SiY41tlq4vpeC/wWkn1LvbnTNxP5PnU/4AAcy4YpsACSF6fNNhdECJ0bBqoBZf
         k+dFgWTSEOgBUUD+zTtLFc/ezNRmD1r1/z+RL8DjTZ6dejWhH0v+FCx82wDoqo8oe77a
         1O5w==
X-Gm-Message-State: AOAM5311zjf4WvCScXdpK54hsZ9HQBniqI3VGNXcPC2izOnKcYACBzZq
        yg/FAT7nnX9IiMxYS9t7UN496TI2wWQJ8S/voDY=
X-Google-Smtp-Source: ABdhPJzTQTpTppVCBw61PgXQnzBb6wQCNtBUQhcsbLYozX3ugc7CSUicW5bRgHzt3QN12dgJ3bmTcg==
X-Received: by 2002:a05:600c:1d23:b0:394:685b:c18b with SMTP id l35-20020a05600c1d2300b00394685bc18bmr9129228wms.121.1653060366523;
        Fri, 20 May 2022 08:26:06 -0700 (PDT)
Received: from ?IPV6:2a01:e34:ed2f:f020:b8:a290:ff05:e4c4? ([2a01:e34:ed2f:f020:b8:a290:ff05:e4c4])
        by smtp.googlemail.com with ESMTPSA id o4-20020a05600c338400b00394708a3d7dsm2242616wmp.15.2022.05.20.08.26.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 08:26:05 -0700 (PDT)
Message-ID: <3061a9fd-5301-4d91-2d60-b85a5d4910e9@linaro.org>
Date:   Fri, 20 May 2022 17:25:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] thermal: k3_j72xx_bandgap: Fix array underflow in
 prep_lookup_table()
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Keerthy <j-keerthy@ti.com>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <YoetjwcOEzYEFp9b@kili>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <YoetjwcOEzYEFp9b@kili>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20/05/2022 17:02, Dan Carpenter wrote:
> This while loop exits with "i" set to -1 and so then it sets:

Won't it exit with 'i' set to '0' ?


> 	derived_table[-1] = derived_table[0] - 300;
> 
> There is no need for this assignment at all.  Just delete it.
> 
> Fixes: 72b3fc61c752 ("thermal: k3_j72xx_bandgap: Add the bandgap driver support")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>   drivers/thermal/k3_j72xx_bandgap.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/thermal/k3_j72xx_bandgap.c b/drivers/thermal/k3_j72xx_bandgap.c
> index 64e323158952..a9789b17513b 100644
> --- a/drivers/thermal/k3_j72xx_bandgap.c
> +++ b/drivers/thermal/k3_j72xx_bandgap.c
> @@ -151,8 +151,6 @@ static int prep_lookup_table(struct err_values *err_vals, int *ref_table)
>   		/* 300 milli celsius steps */
>   		while (i--)
>   			derived_table[i] = derived_table[i + 1] - 300;
> -		/* case 0 */
> -		derived_table[i] = derived_table[i + 1] - 300;
>   	}
>   
>   	/*


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
