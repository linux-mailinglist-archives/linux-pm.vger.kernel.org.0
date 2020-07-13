Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98CDE21D830
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jul 2020 16:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730033AbgGMOTP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jul 2020 10:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729689AbgGMOTO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2020 10:19:14 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7393EC08C5DB
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2020 07:19:14 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f7so16774862wrw.1
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2020 07:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=83K02S19KVeFcCuKwV5wDITbGtNfW/QZzsJUSvvBykk=;
        b=lg+gsoCaIsMsj08WwXCtE4mFEfdT9H3wf/ZHYYZ+zi+JJtVq68YIxERPe6ixxMa5W6
         1B8BnrQ7ApuhcNPszUPdJ0kkmOaZ9E+dsyeD0WT7RNkxzo3R8cohzRU6H57g49Xl5UD6
         WkZK3BjDhtyZPLQggPvqIKcA+zAHWQoP7pOvLLdS8O2kdO33xupCexw1C3fEB4JHBVS6
         C4kJHVM6H92KAWlBzWboagL8j8ErAja0cHalaAQ3spSxJvcpGyZbfpMNw6bq9vdVO3Y2
         eAoGE5l9jlnQVnGy3589lqWCd4oGu8xqFy6qgFobbBIc2dbNppHT3OXQejLJ3xPVRYCI
         HsKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=83K02S19KVeFcCuKwV5wDITbGtNfW/QZzsJUSvvBykk=;
        b=HKKIV1PNm9zTtob9CpLhaKsgtXRyKPZQKiBJHCfwif9JZxVvCHrga2mVlPGJaQ+Ty0
         dgqzHPJ/aW9akSCjm6SNq8i93Fzr8nSV0IGmB67cqgaSW4gxZqdH+b2AeFP2rVVMftNi
         3IJopMuS1Mmh86gJ1n07xNmmQnIyrTF54jo68lnFiQR1LJt003MeDrJnvQyP9pSlWYV2
         H4rRrmi1rbvmiU2ci3qKTBa4jjV/Je61H3YV9cs26L66RtEyU/nOTkxMhUHLIuQu4nfQ
         /vGB21bNsAQU00xnpU1lRjrEseHKvJnoT7iXoSEXMcT+Cy4Zn+u34Muv5jy7P/Ini2WY
         HYpg==
X-Gm-Message-State: AOAM530ASYfTjJxsHkN9TML+wXuUysKGxKgTqtU95Eb76nXeZ6XSAHi9
        HwRZTjkgy8AlYDqOfcRKAh4WCTsDd5w=
X-Google-Smtp-Source: ABdhPJzY7QH2amwsGojVNJTZVbGOIvnZEX229rAFFmy/WZV6anc3JPLjyJtir1EwfqNsFXCXU6aa5A==
X-Received: by 2002:a5d:60d1:: with SMTP id x17mr79519469wrt.293.1594649952796;
        Mon, 13 Jul 2020 07:19:12 -0700 (PDT)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id 92sm26228241wrr.96.2020.07.13.07.19.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2020 07:19:12 -0700 (PDT)
Subject: Re: [PATCH 4/6] interconnect: qcom: Add SM8250 interconnect provider
 driver
To:     Jonathan Marek <jonathan@marek.ca>, linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20200701134259.8055-1-jonathan@marek.ca>
 <20200701134259.8055-5-jonathan@marek.ca>
 <5a0eca0e-d496-d8af-ca41-0f07e9a3e01d@linaro.org>
 <5074d900-da92-0b8a-a7c6-1ebfe4ae2d56@marek.ca>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <25c59c3e-e085-e940-e3fd-bb367d1438d2@linaro.org>
Date:   Mon, 13 Jul 2020 17:19:11 +0300
MIME-Version: 1.0
In-Reply-To: <5074d900-da92-0b8a-a7c6-1ebfe4ae2d56@marek.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 7/13/20 16:47, Jonathan Marek wrote:
> On 7/13/20 9:30 AM, Georgi Djakov wrote:
>> Hi Jonathan,
>>
>> Thanks for posting these patches!
>>
>> On 7/1/20 16:42, Jonathan Marek wrote:
>>> Add driver for the Qualcomm interconnect buses found in SM8250 based
>>> platforms. The topology consists of several NoCs that are controlled by
>>> a remote processor that collects the aggregated bandwidth for each
>>> master-slave pairs.
>>>
>>> Based on SC7180 driver and generated from downstream dts.
>>>
>>> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
>>> ---
>> [..]
>>> +
>>> +static const struct of_device_id qnoc_of_match[] = {
>>> +    { .compatible = "qcom,sm8250-aggre1-noc",
>>> +      .data = &sm8250_aggre1_noc},
>>> +    { .compatible = "qcom,sm8250-aggre2-noc",
>>> +      .data = &sm8250_aggre2_noc},
>>> +    { .compatible = "qcom,sm8250-compute-noc",
>>> +      .data = &sm8250_compute_noc},
>>> +    { .compatible = "qcom,sm8250-config-noc",
>>> +      .data = &sm8250_config_noc},
>>> +    { .compatible = "qcom,sm8250-dc-noc",
>>> +      .data = &sm8250_dc_noc},
>>> +    { .compatible = "qcom,sm8250-gem-noc",
>>> +      .data = &sm8250_gem_noc},
>>> +    { .compatible = "qcom,sm8250-ipa-virt",
>>> +      .data = &sm8250_ipa_virt},
>>> +    { .compatible = "qcom,sm8250-mc-virt",
>>> +      .data = &sm8250_mc_virt},
>>> +    { .compatible = "qcom,sm8250-mmss-noc",
>>> +      .data = &sm8250_mmss_noc},
>>> +    { .compatible = "qcom,sm8250-npu-noc",
>>> +      .data = &sm8250_npu_noc},
>>> +    { .compatible = "qcom,sm8250-system-noc",
>>> +      .data = &sm8250_system_noc},
>>> +    { .compatible = "qcom,sm8250-gem-noc-display",
>>> +      .data = &sm8250_gem_noc_display},
>>> +    { .compatible = "qcom,sm8250-mc-virt-display",
>>> +      .data = &sm8250_mc_virt_display},
>>> +    { .compatible = "qcom,sm8250-mmss-noc-display",
>>> +      .data = &sm8250_mmss_noc_display},
>>> +    { }
>>
>> My main concern here are the display RSC nodes. We should not add the nodes
>> for voting on the display RSC, but use the "qcom,bcm-voters" property in DT
>> to list both "hlos" and "disp" as bcm voters for gem-noc, mc-virt and
>> mmss-noc.
>>
> 
> Would it be OK to just drop the display RSC parts from this series then? Not
> sure if anything needs it to work, but I'm not using it currently.

This would be perfect! Let's start without the display bits. Reviewing and
testing the display part would be also a bit tricky for me.

> Though if you can provide details for a solution, I could implement it
> (qcom_icc_provider needs to have a list of voters, but I'm not sure how to deal
> with everything else).

Yes, exactly. The idea is to add voters to each qcom_icc_desc and then "get"
the voters and commit for each of them. But i think there is a patch for this
already, let me check about whether its going upstream anytime soon.

Thanks,
Georgi
