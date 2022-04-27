Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7231511923
	for <lists+linux-pm@lfdr.de>; Wed, 27 Apr 2022 16:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235178AbiD0NCy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Apr 2022 09:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235182AbiD0NCy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Apr 2022 09:02:54 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C861850457
        for <linux-pm@vger.kernel.org>; Wed, 27 Apr 2022 05:59:42 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id g20so1845013edw.6
        for <linux-pm@vger.kernel.org>; Wed, 27 Apr 2022 05:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=T0hxnuRgL9NeQFiMioCyH45+WQ2S28ZgAPm0mFEWbLE=;
        b=MeiX9AY/6qkAvXGxzi5UU0gh6sd8cIlgkzkD94AXxkdyAlmdyQSYgjUWZavU45/Ec/
         3W5w5HbpX17VdLQJmVnJ0/7FqlFICHRSCqmeZrOeYyKEOjsD8x2JcvpSlp2CMpL2kc6N
         k+8J9IM3w4OD6AklioYFEHQJLaxOFYx/lI7xBlGxH1mj0y8USlaPjY3CWtok1kX2CzmM
         ufVfmXOznt9/E/vVMrgfhXP2N9xmw5lTNvluvgNu6uX9PMaoZLSSJvo2mhURlQzzpP8H
         HrQrGbb/hpOltrE6Luh6bfq4SaleG59aU/lu1QPvdCak6tCKZ7x5Nj3mM5m4g9/5bD8g
         g1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=T0hxnuRgL9NeQFiMioCyH45+WQ2S28ZgAPm0mFEWbLE=;
        b=7Mm5KFIyMunsXmUh+lrwa6I5JFORPUDPDZ/95aMmrSGBANgYV9Qc/oAc6bTXISggCu
         o565TiXhZ0e9jh4OXXlJ/XjCj8EmZca2PO46llgzLveAsKHWzEBqq9+SUSSAlBksqhoI
         4ZcClPdNJW/J4Tln1vSaZPuQihHbzbv21tO4toI6bEvnulrAm/MIomjxNZQy/19xg8dw
         ckOdphw6yJZ2icdxeiOHHvgAEEWwlDw7AHUTXu7U9O8ZK9jxc0HDHwZfSJU7rzW5PfJS
         lVQmGAMUAmCdW68VBpQCKNLhPlMX+ZeBJ/wwmSDyeEJoIFBCZQEa1Rp/IK1boPxHN/Ju
         tIOw==
X-Gm-Message-State: AOAM5307Z3UuC1CFkDtv9TfgC+UF5xje0CiJuzwP5AXo94swUSnCyNA8
        LaFIc1T4ru7dl1AR58OdWFg5RmyXC46sDQ==
X-Google-Smtp-Source: ABdhPJz98Md50Ai8wsdX8vX3fIUcCf+jcYhugjdBDzvzUy2U50EWkV+3GUFmIxe2wv2oo/XH6r1d3A==
X-Received: by 2002:a05:6402:5201:b0:426:124:a40b with SMTP id s1-20020a056402520100b004260124a40bmr6090702edd.198.1651064381331;
        Wed, 27 Apr 2022 05:59:41 -0700 (PDT)
Received: from [192.168.0.153] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id z14-20020a170906944e00b006f38c33b6e3sm4829572ejx.68.2022.04.27.05.59.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 05:59:40 -0700 (PDT)
Message-ID: <6d9ded33-f5fc-6346-51ca-2de8e7a644ec@linaro.org>
Date:   Wed, 27 Apr 2022 14:59:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/3] interconnect: qcom: constify qcom_icc_desc
Content-Language: en-US
To:     Georgi Djakov <djakov@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220412102623.227607-1-krzysztof.kozlowski@linaro.org>
 <b96fd335-df13-6657-c2ff-38ff677555a4@linaro.org>
 <12570c36-d005-f51c-654b-01d52c50205c@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <12570c36-d005-f51c-654b-01d52c50205c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27/04/2022 14:17, Georgi Djakov wrote:
> On 22.04.22 18:25, Krzysztof Kozlowski wrote:
>> On 12/04/2022 12:26, Krzysztof Kozlowski wrote:
>>> struct qcom_icc_desc is not modified so it can be made const for safety.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>>>   drivers/interconnect/qcom/msm8916.c |  6 +++---
>>>   drivers/interconnect/qcom/msm8939.c |  8 ++++----
>>>   drivers/interconnect/qcom/msm8974.c | 12 ++++++------
>>>   drivers/interconnect/qcom/qcm2290.c | 12 ++++++------
>>>   drivers/interconnect/qcom/qcs404.c  |  6 +++---
>>>   drivers/interconnect/qcom/sc7180.c  | 26 +++++++++++++-------------
>>>   drivers/interconnect/qcom/sc7280.c  | 24 ++++++++++++------------
>>>   drivers/interconnect/qcom/sdm660.c  | 12 ++++++------
>>>   drivers/interconnect/qcom/sm8150.c  | 22 +++++++++++-----------
>>>   drivers/interconnect/qcom/sm8250.c  | 22 +++++++++++-----------
>>>   drivers/interconnect/qcom/sm8350.c  | 20 ++++++++++----------
>>>   drivers/interconnect/qcom/sm8450.c  | 22 +++++++++++-----------
>>
>> Hi folks,
>>
>> Any comments here?
> 
> Thanks for the patches! I had actually some of these changes in my local tree
> for a long time.

Indeed I see them now in linux-next. Sorry for pinging, I just did not
get any notification they got applied.

> Do you want to send a follow-up patch also for sc8280xp?

Yes, sir! I'll constify that one as well.


Best regards,
Krzysztof
