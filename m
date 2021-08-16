Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 781D73EDC15
	for <lists+linux-pm@lfdr.de>; Mon, 16 Aug 2021 19:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbhHPRKK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Aug 2021 13:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbhHPRJZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Aug 2021 13:09:25 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C07C0617AD
        for <linux-pm@vger.kernel.org>; Mon, 16 Aug 2021 10:08:42 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id k5so8027116lfu.4
        for <linux-pm@vger.kernel.org>; Mon, 16 Aug 2021 10:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1H74w19usAiEiMxJXIrSteXyU7M5waeG7A1ewZ7Xfho=;
        b=wAckAHThXf56w5CDLj9ZXlr7hkoIw90UPR9ZZ/ph91R441/dNo7WjOPs4cSE/Rrzp+
         DHD0IS4/tAJAq4WBCTr9nDu27ivxB9HnvTZrl3B2Lpq2NYiG3IDLKqdHPGX2u7aBZnbh
         Fqu9p/aWzSE+eX9YFGS663KhT13kN5Y3gg8LQ6nkdS74En3QEpKx+hlBY+qa3SZ7g5PC
         cCZBzCAFAeYiJkabUuy2fGlbxcZ92mh2+SAcFZBOI0IaFEpzwX1o1bzIFWOqNaKXj/V7
         ZzXNlm9C1WV8hN7Qcu5JqWqpq67NZRRvwpxv1clwWW9ubyyaVLvY+ZP4KFfYeka4yZRQ
         PxHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1H74w19usAiEiMxJXIrSteXyU7M5waeG7A1ewZ7Xfho=;
        b=BH6QA+T5bNvte+3mCmqCmCPWzNvi+epiPRKfGNSmk5t2Q9gTwRhLzifHeiKPnZoHy9
         0QB/XOsPbHVvAdMBnFxfI6VQNBmuRmEMjl8QUdavfZI3UaqPJyxSah+GA/WNLawgw6h/
         Q0YgYUqIWfUUd5NBf18cBit7huGdHEez5JdrQ1sYZrSL86axKqk36ppzd+E36kuefaLP
         SXiVNREeAcvqQy+3BN+d4J1SIBPot3DgJWt4utllxRzOJZrS2lJKqu3B6Iee4+jvZ7TU
         fvVBu0f0KCDRxW8VlOMD3xw7iEXqf61i87LkGrf7ZXzHQelQwYMKZJcdkbbYKnsNIjNs
         I1bw==
X-Gm-Message-State: AOAM530R9Pck3WjNGJztP2OyWMzY0wFnCNmoNRb/pyhxYtAEd1AKvTE2
        gJYfObYGeTsk0615T89PJtiDGg==
X-Google-Smtp-Source: ABdhPJx/isfH0IafEhHRSHd+kPwEa9/jgEAO+r18P4mBet7LtD+AryXOaypqVOR2i1zQJidm08Jxcg==
X-Received: by 2002:a05:6512:a90:: with SMTP id m16mr2868826lfu.349.1629133720731;
        Mon, 16 Aug 2021 10:08:40 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id b14sm1174750ljj.101.2021.08.16.10.08.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 10:08:40 -0700 (PDT)
Subject: Re: [PATCH v3 0/3] PM: add two devres helpers and use them in qcom cc
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Taniya Das <tdas@codeaurora.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>
References: <20210731195034.979084-1-dmitry.baryshkov@linaro.org>
 <162820760640.19113.2386978922035728014@swboyd.mtv.corp.google.com>
 <CAA8EJppSVotv-O=2h3BVqAC6f7xG+2BvUREesKs9v7RJkLORrQ@mail.gmail.com>
Message-ID: <95acab94-ae80-b43c-673c-9dfc82f3b40b@linaro.org>
Date:   Mon, 16 Aug 2021 20:08:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAA8EJppSVotv-O=2h3BVqAC6f7xG+2BvUREesKs9v7RJkLORrQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06/08/2021 10:08, Dmitry Baryshkov wrote:
> On Fri, 6 Aug 2021 at 02:53, Stephen Boyd <sboyd@kernel.org> wrote:
>>
>> Quoting Dmitry Baryshkov (2021-07-31 12:50:31)
>>> Most of the drivers using using pm_runtime_enable() or pm_clk_create()
>>> follow the same pattern: call the function in the probe() path and call
>>> correspondingly pm_runtime_disable() or pm_clk_destroy() from the
>>> probe()'s error path and from the remove() function. This common code
>>> pattern has several drawbacks. I.e. driver authors have to ensure that
>>> the disable/destroy call in the error path really corresponds to the
>>> proper error clause. Or that the disable/destroy call is not missed in
>>> the remove() callback.
>>>
>>> Add two devres helpers replacing these code patterns with relevant devm
>>> function call, removing the need to call corresponding disable/destroy
>>> functions. As an example modify Qualcomm clock controller code to use
>>> new helpers. In this case we are able to drop error path and remove
>>> functions completely, simplifying the drivers in question.
>>
>> There are lots of folks on the To: line so I'm not sure who is supposed
>> to apply this. Please indicate which maintainer tree you're planning to
>> land a series through if it touches different areas of the tree.
> 
> I'd prefer for them to go through the clock tree.

Stephen, since Rafael has acked the patched, could you please take a 
look and hopefully merge them?


-- 
With best wishes
Dmitry
