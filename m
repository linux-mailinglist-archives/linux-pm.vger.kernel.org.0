Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56467228E2
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jun 2023 16:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234177AbjFEOd4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Jun 2023 10:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234138AbjFEOdz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Jun 2023 10:33:55 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E873BEC
        for <linux-pm@vger.kernel.org>; Mon,  5 Jun 2023 07:33:52 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f6e13940daso50017895e9.0
        for <linux-pm@vger.kernel.org>; Mon, 05 Jun 2023 07:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685975631; x=1688567631;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TxFsjFDrkkWh0zOasi8AvpLFKTAST5HlIO/cHnfS0FQ=;
        b=CGa8pVK7NGqRj6T9B7ug3IHvc2V1vvCPYgcRSq4KYUj5wNbbkdax7ObnvYdxPO6/8E
         8niTe6FgHcMtsdEc6pWnYGP9J8cBfHn/Pn0M9bMoze0GyhPmYyypxtTShWwueuJdOpNi
         tzuYS51Xu4DaQLUHTyH2/00Nn4/AtrRwd//fD74MItarwA0bWoaw6jyqWtPxuY5MkJMd
         J8C++MjGKFslnHSrWzk6apXeVShpwdtn4CLRzR8EldvyWFZghrUUXuc3DcaXNV2fsoyH
         Etrrl0MJugrEK/IP1ViDVvNplpqVfVgWHjeBIxAeRoTpfIuXh0OarrYf3+EW/6cnyeUq
         CpEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685975631; x=1688567631;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TxFsjFDrkkWh0zOasi8AvpLFKTAST5HlIO/cHnfS0FQ=;
        b=HrRh5iQWxkOmUGEpWmdLTlj5jtKwnVrsVcN1HCHNO8MEVEnn2C1Y+ID65RBK/zGmKl
         /ACReZEqicMhUYq+JB9P9rxikIKuX+PnGEiYLX9RXhzTDg5MR0W+Vbdk/G9QxNGUUC6z
         Ib9QQaZpL7BFembWuj9YbTmrMMt4OjSVBvIqcWIEwzMLs6miGeiUqw2oB6W7svtGoYFa
         Z65sBP4Kjm0ic2u8vGxoKF6/YFWudJik9YE7uBkSkSrBJFSqqMuXaB/m5vZGxvw4amHX
         ehTzJPLYGClIzzTMdXn6JrtmmasDSrPNFPTL5JjIJq2Ejq+G2xNU2A8BsNk4qJ2IbZ/L
         cXeg==
X-Gm-Message-State: AC+VfDwaYwpsTN+uMpm6DO0+zOTLCb9aQKc8/Y7OFfFALMGDyHZSNVQm
        k1eyd4lQ7BAVvyywVuiz2/m5ig==
X-Google-Smtp-Source: ACHHUZ7DDmVAivpAPtJBXVD2p59jjt6RBb6ItHCHX0sdwXFYdhEuqyZNAkbCPtz5hx7pqi2epuIlSw==
X-Received: by 2002:a1c:ed1a:0:b0:3f5:d0b8:4a53 with SMTP id l26-20020a1ced1a000000b003f5d0b84a53mr8230194wmh.34.1685975631334;
        Mon, 05 Jun 2023 07:33:51 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:2385:9257:ace1:1efc? ([2a05:6e02:1041:c10:2385:9257:ace1:1efc])
        by smtp.googlemail.com with ESMTPSA id b14-20020a5d40ce000000b002e5ff05765esm10110538wrq.73.2023.06.05.07.33.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 07:33:50 -0700 (PDT)
Message-ID: <c51add07-2344-1623-1402-8927b9442b43@linaro.org>
Date:   Mon, 5 Jun 2023 16:33:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH RFT v3 0/3] drivers/thermal/rcar_gen3_thermal: add Gen4
 fuse support
Content-Language: en-US
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
References: <20230511192220.7523-1-wsa+renesas@sang-engineering.com>
 <TYBPR01MB5341AF3D9EB0F9A074283341D8759@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <ZF4zjmkoE/njjG4x@ninjato>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <ZF4zjmkoE/njjG4x@ninjato>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/05/2023 14:39, Wolfram Sang wrote:
> 
>> Thank you for the patches!
>> I checked the patches. So:
>>
>> Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>>
>> And, I tested on R-Car H3 ES3.0 and R-Car S4 and it worked. So,
>>
>> Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> 
> Awesome, thank you Shimoda-san!

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

