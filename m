Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC11C688040
	for <lists+linux-pm@lfdr.de>; Thu,  2 Feb 2023 15:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbjBBOgn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Feb 2023 09:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbjBBOgk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Feb 2023 09:36:40 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B580C6F22F
        for <linux-pm@vger.kernel.org>; Thu,  2 Feb 2023 06:36:38 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id h12so1879817wrv.10
        for <linux-pm@vger.kernel.org>; Thu, 02 Feb 2023 06:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yHhQ8raHUNog1t1vWXT7RPad9uq4gG0GdOLVPnM+Q4I=;
        b=JtidDWByDdmVWVskhKz/0ROPf6l4UQyaGzM5lgbYwRKy3CFWEahMj4FFQ20zH5CZOu
         3n6b/BMgY/6ki0HsZbO5oDXphr5C0zY2yEs+AgtFEqz6GfJldQ7cuZkeWpDKPxwUUH+S
         u56i/CgpRnMi0x0tpa83mwkc5afBp4VVGXQVLtymyywYNA5wy0DAiKHDlrk3EwOPIW21
         4528Y2tFHcA/DfIf9Mp09c+mwGO1bvdXSRSgfHeOVxI5qALBa/X1FpRkTuQ99jY561dj
         axGIcghN5idzglobukYWCHgWKsexm7SO0Bvssh/KnhsylNuY/0//L2z8z0+yFsZ/1U4u
         yNFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yHhQ8raHUNog1t1vWXT7RPad9uq4gG0GdOLVPnM+Q4I=;
        b=J8k+JetyQ2QtGOvDUtHVtht7FLN/Dtc0LeRIIju/1OJGYOX3rY18kwhdB1TGXZmCIi
         VG46dWGKkD2/WK0aADdaidk5FMYwkrgMeC2NFksLH9rC6f1QsfixhfT7TW8di5eXLryd
         sBUZbKGrUO9rrBgksCHQPbacDuqR18DmIeyZPYiA946YYKSqVfvXqKeVUk8g+ZALp1dB
         Y1o13mvcCXSsbYMKUo7mnSxqDOEUFG4/oMAbwOtzjCvYkvpp5KJUqmoo2KYo2A2DKq68
         XDAVn5ACxqcO55/+yS2Lnaf6Q1jEA+iatM95nm4slNz9f4DSPfTehIVHNrU6hFeSRfs+
         T/fQ==
X-Gm-Message-State: AO0yUKXVbGQgtSA8/cepkhhacuCMSMmSv0DHVea+BNhQ75TuRcWpecK4
        vkUTM3zgiGmvBtj41yOTUQ+PpQ==
X-Google-Smtp-Source: AK7set9GOyjY7ZljPwZYanv/j6DtDNd+OPPr3gs6xrRr2zpKMLiQXNfedpf3LiHkJX/KgDzN0cZEUw==
X-Received: by 2002:a05:6000:982:b0:2bf:bd43:aacc with SMTP id by2-20020a056000098200b002bfbd43aaccmr6398511wrb.55.1675348597222;
        Thu, 02 Feb 2023 06:36:37 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id n9-20020a5d67c9000000b00294176c2c01sm19991708wrw.86.2023.02.02.06.36.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 06:36:36 -0800 (PST)
Message-ID: <c7c7d71d-28e1-310e-2c8f-e5ae53a09f78@linaro.org>
Date:   Thu, 2 Feb 2023 15:36:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 3/3] thermal/drivers/intel: Use generic trip points for
 intel_soc_dts_iosf
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     srinivas.pandruvada@linux.intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Amit Kucheria <amitk@kernel.org>
References: <20230118181622.33335-1-daniel.lezcano@linaro.org>
 <20230118181622.33335-3-daniel.lezcano@linaro.org>
 <CAJZ5v0jbHR03UyJBMmBBYnSsZmGG0OXqLJvMfXxXKVn4Np4Egw@mail.gmail.com>
 <beb367d8-dad7-87d9-7872-b81a4d3492ae@linaro.org>
 <CAJZ5v0hFG1VjzKubWkLYPXeGHN9sMt4SDdC_f-dLseaXpsAOKg@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0hFG1VjzKubWkLYPXeGHN9sMt4SDdC_f-dLseaXpsAOKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Rafael,

On 31/01/2023 20:17, Rafael J. Wysocki wrote:

[ ... ]

>>> Why should temp be overwritten here?
>>
>> You are correct. This is wrong.
>>
>> I think we should call get_trip_temp() before calling update_trip_temp()
>> instead of passing a zero temperature parameter
> 
> update_trip_temp() is sort of a misnomer, because it is used for
> initializing a trip point for example in
> intel_soc_dts_iosf_add_read_only_critical_trip() and in this
> particular case get_trip_temp() need not be called before it.
> 
> This driver seems to be in need of a cleanup.

Will you take care of this cleanup ?



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

