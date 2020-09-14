Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE4DB2691A8
	for <lists+linux-pm@lfdr.de>; Mon, 14 Sep 2020 18:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgINQdb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Sep 2020 12:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbgINPpn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Sep 2020 11:45:43 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7ACAC06174A
        for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2020 08:45:36 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id w11so13972013lfn.2
        for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2020 08:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I1Diq3BVw3//vJqeDcLXAlMyOlmanauBDrj7DA7Bapg=;
        b=aUDJEPCk0RcQKnW6Jt3+dgnCUbGNP8VTiZoqXo8QkUprwnChxH2RUbWoB/cLgQX2Rx
         riIjyia/GLCJR9xVU04942RbOEFED35baENMdlCUNgF6PEUJsruLtw9P2wgxxvHcZdo1
         8dnIN+mxtJeG9GZQl7WSoswNbvW7nvTXMlZk100dzBlnTyaoC33KqYHiLT/rDFEbelm0
         qgYKQr7GNdiTmK3mIj6bqJhXoB4e081sdIcPTQHbneq/Cnn41Dxgybep14VDkzKaDVS5
         37pnKSIy44Mxbs1HKblhUbJKz0QDHSYE+hvdUvhVfXHtH7oRP5H3jcG9PM67Vs2L9jYG
         umbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I1Diq3BVw3//vJqeDcLXAlMyOlmanauBDrj7DA7Bapg=;
        b=GhxosjUy6vbstC1ZaPKQVm/b8SG0FpbWeKXiBU0WwVOuwlUrAMWAiSAGtJC3+XsWY1
         cTI+sdZo8kmj5rtPBX+3x74lgtPgGCZ+LgqW3c+ekb8gSzWrjAmCoUoUzYFKBxbgt5Ce
         Gc6h9LDWvd2FkaCh0gLaJNvnwWAdggQ/xugStw6sOfyIQsjh/L6noTtY+WmhC+cuPr4R
         wZBImwNuKAmMIHiRfQcs9ZXGXWXIK1KpFnhrqT+f4SahjPm3a9/gq+9Pil9I8tsb6kHK
         dT/kmADa1W4xDrrKyNjfQUapq+M117GW0Z4k3gZrbr5YrmboBUkr9yX+e8Z2XMd18T+k
         W7kA==
X-Gm-Message-State: AOAM531hzdJ+uUmfIJwHs9XmJG7cZNoLsCCDvPMkvLAMHfFa7zu6BhYs
        dd0I/dcIEiBu0gIR0QZt45lqSg==
X-Google-Smtp-Source: ABdhPJxtV7I4cIHpLZEVpRugay28tPPeWIt/1IZHQRAI99Q5d18DZ+ZTy9N5LpAUQnzFQm1TXpLMWA==
X-Received: by 2002:ac2:48a2:: with SMTP id u2mr4534376lfg.359.1600098332759;
        Mon, 14 Sep 2020 08:45:32 -0700 (PDT)
Received: from [192.168.1.145] ([188.162.64.187])
        by smtp.gmail.com with ESMTPSA id y17sm4115896ljm.55.2020.09.14.08.45.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 08:45:32 -0700 (PDT)
Subject: Re: [PATCH v3 00/10] qcom: pm8150: add support for thermal monitoring
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
References: <20200910140000.324091-1-dmitry.baryshkov@linaro.org>
 <20200913112122.0f4ee51b@archlinux>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <99063ca8-c795-416c-18cb-5c026879a13c@linaro.org>
Date:   Mon, 14 Sep 2020 18:45:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200913112122.0f4ee51b@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13/09/2020 13:21, Jonathan Cameron wrote:
> On Thu, 10 Sep 2020 16:59:50 +0300
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:
> 
>> This patch serie adds support for thermal monitoring block on Qualcomm's
>> PMIC5 chips. PM8150{,b,l} and sm8250-mtp board device trees are extended
>> to support thermal zones provided by this thermal monitoring block.
>> Unlike the rest of PMIC thermal senses, these thermal zones describe
>> particular thermistors, which differ between from board to board.
>>
> 
> As far as I am concerned this series is now ready to go up to one or two
> things in patch 8.  So on to the normal question based on the assumption
> it will pick up other necessary reviews shortly...

Sending v5 right now, fixing issues in patch 8.

> 
> What route do we want this to take?
> I can do an immutable branch in IIO if that works for patches 1-8 and assume
> the dt file changes will got via usual SoC path?  We are getting a fair way
> into this cycle, so this may well end up happening next cycle depending
> on how quick reviews come in.

I think this makes sense. Thank you for your reviews.


-- 
With best wishes
Dmitry
