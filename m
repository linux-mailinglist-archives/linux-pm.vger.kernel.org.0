Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7333E70D9EC
	for <lists+linux-pm@lfdr.de>; Tue, 23 May 2023 12:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236373AbjEWKGx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 May 2023 06:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236195AbjEWKGw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 May 2023 06:06:52 -0400
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E0B94
        for <linux-pm@vger.kernel.org>; Tue, 23 May 2023 03:06:50 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-4f3baf04f0cso3141169e87.1
        for <linux-pm@vger.kernel.org>; Tue, 23 May 2023 03:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684836349; x=1687428349;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qy1qU8NvcGvI+3YDitV00fdotx7KraYx0th7XNX5GWo=;
        b=n1QSm7meBl8nT/2dWnq0KvenJvRUYw7rwxnXnHuv2ZJpQF0T5oY4hAnjlL1Bph4FBO
         puKx43VotTCJ5zdPs98qa5kFewQpBV67ZCxpVUBa16d+wEcilZlk3ORdsx9zcpTNMoVT
         lXPYSkHCyeP2yV4gfslgPm5lHYG33aCJfd8G2JLrDkJXU01JLXAui6AjZfcyShEJVmz2
         0WVLy4UlhFPlseQ6FpSqG3U2ASCGc810yHIpBPsuxwIZhzTeZjesle2EyPDXMlYLAu3q
         ZedhkD3xM9d9ThOHC6j0/w1Ics6VwxfT2GgRubP3vtOzTx+8FN+U81iROKP66DVer0HL
         //LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684836349; x=1687428349;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qy1qU8NvcGvI+3YDitV00fdotx7KraYx0th7XNX5GWo=;
        b=Hi09HUsvfvKXqPEPyTWJDpFrO4TzXXDwqHNUKdca0vts0eEsBDP+AYQhu2PQklPW1f
         V+PFIHCGuErmPjb8FGHwR1zlIr1Sqi4xFOcZdZXhoKCyQEffOVOxu0a5hkgDf0VLoZ7m
         wz8oaya047db3rq6TKRBscRx89sH4Sot/rhqy8dpFRe4v3DFgBt8IOY9hFdbdaPcjIyc
         aGpxAWjE99VDRn7jAvOLnBWYyLWt92BN0D1rSctVOy0qtat7/mcmYvpL5seCFSkQ/W5h
         DOQlTMeoEZ0s6nXpiJcqIKgsrsJWhhGK7AMbtA+I0onCjN+xdtgixFmEomh/U9k0Oq8w
         njnw==
X-Gm-Message-State: AC+VfDz/sWXYL1uk1LeN/Hff91PX2hSiol3yepGFyY4G6CZE9esVzQzj
        zNV3oqyDfreOLP2ZZ4mvwK/WAw==
X-Google-Smtp-Source: ACHHUZ709/zCZUuy2zE6yzDZvvdoH16A8BVN5S2NdiszPLJGnLV6EX44akDp8b7p5ro4oBr0H7KnLw==
X-Received: by 2002:a19:7501:0:b0:4f2:5d61:a04d with SMTP id y1-20020a197501000000b004f25d61a04dmr4094032lfe.63.1684836348939;
        Tue, 23 May 2023 03:05:48 -0700 (PDT)
Received: from [192.168.1.101] (abyk138.neoplus.adsl.tpnet.pl. [83.9.30.138])
        by smtp.gmail.com with ESMTPSA id v11-20020ac2560b000000b004f25c29f64esm1289083lfd.176.2023.05.23.03.05.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 03:05:48 -0700 (PDT)
Message-ID: <ad76a7b6-55aa-a20c-f678-75887f437be5@linaro.org>
Date:   Tue, 23 May 2023 12:05:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <a0f6184c-c2b5-4e8d-9b8a-867ae83f3094@kili.mountain>
 <2f03fa9a-1b4b-d208-f399-a31ab8c5b4cc@linaro.org>
 <d5c41227-21d8-4f64-9433-a774ecfa5685@kili.mountain>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH] interconnect: qcom: rpm: allocate enough data in probe()
In-Reply-To: <d5c41227-21d8-4f64-9433-a774ecfa5685@kili.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 23.05.2023 11:47, Dan Carpenter wrote:
> On Tue, May 23, 2023 at 10:31:27AM +0200, Konrad Dybcio wrote:
>>
>>
>> On 23.05.2023 10:11, Dan Carpenter wrote:
>>> This was allocating "sizeof(qp->intf_clks)" which is the size of a
>>> pointer instead of "sizeof(*qp->intf_clks)" which is the size of the
>>> struct (8 bytes vs 16 bytes on a 64bit system).
>>>
>>> Fixes: 2e2113c8a64f ("interconnect: qcom: rpm: Handle interface clocks")
>>> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
>> Whoops. Guess I was just really really lucky that nothing blew up for me.
>>
>> Thanks.
>>
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> Hold up.  Wait...  Let's not apply this.  The bug is more severe than I
> saw initially.  It should be:
> 
> 	qp->intf_clks = devm_kcalloc(dev, cd_num, sizeof(*qp->intf_clks),
> 				     GFP_KERNEL);
> 
> Did we only test with cd_num set to zero?
No, I also had buses using cd_num >= 1..

Interestingly enough the clocks with the higher indices *did*
in fact get enabled (the platform would otherwise crash on set_bw
during sync_state if they didn't), at least in the

probe (-> allocate) -> sync_state

path.


But there's not a whole lot of allocations in between, so perhaps
it must have been luck as well..

TYSM for catching this..

Konrad
> 
> regards,
> dan carpenter
> 
> 
