Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 664AF2B1ACE
	for <lists+linux-pm@lfdr.de>; Fri, 13 Nov 2020 13:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbgKMMGw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Nov 2020 07:06:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgKMMGw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Nov 2020 07:06:52 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A1BC061A47
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2020 04:00:24 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id a65so8211152wme.1
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2020 04:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NuCRg53FQPnGrrcKvABeKmOJP/aEbE+MQNC/BTO5Eg4=;
        b=vn1At+xgaFtwU8Id5WnHnmawstzAfZV/5fXcLTcO82I+Nlyc5fF6VU1KX1YEUt2KbM
         FpWhXArjEVp9S8bPqZpWUPb4yOcZddz2eUqsbO5LM5ZshfBnHF2s6E9iwfRgIwjso4qG
         qw0wgxWRUvr8uSk6p5D8a+c2sc0ev2khfQLxfGNNykwyQRXdLMXiMtimykhJP6PoyMLB
         KIR+sIzoKgRIqd5kcZHoJi5bLKnOhE52gGmE/A3FS9sTdk5LEj0wOWezdmniFdSfEypF
         3/C1f13j1Kbm3JJ8hIoDpNomHgPO8yMBkVTwNYLc5xwnWVCNvOc7YTn3GaPpR0JgwGab
         MKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NuCRg53FQPnGrrcKvABeKmOJP/aEbE+MQNC/BTO5Eg4=;
        b=TKsmJQmxV/bQngU2K6sFFNWsZ4JMjdE7vpEeOK9dEzh/cymZMTMup0orMsEeiebynn
         IRfyUE2ZhlvG/f5In4wD6reOKhJlVO3Bwh+nBfvyiTU0nKjIfp9xVrEtO5KMW+zARddD
         KOZ9QOf6pZX+OoPSMw2jnTvgd0UsDKRdiVtvmAMmcp4U/QvkHhK/WD7beK5c2+8xEpJg
         gujMWAR1dbafaS1HV5SBxSl+cB26c9kuEi/eNhPDRXs1wrtoMQBn/iJSoAkiYXy6o2B5
         h+bG7ibd+dHlk8u9YJQ7lnOuYpp8WMgfWc0NM7JNL/eHGk738v2g9i7bcJxkTGZ40YCZ
         Zsew==
X-Gm-Message-State: AOAM530MmA71hUEbD3GC+tBFttxej94ZIOgSm94DRPcBbw+iBnm1XGJo
        9ct/5mWp+wPqXP+0+qkbQuev1w==
X-Google-Smtp-Source: ABdhPJxxADnMM3AWVW6pI0YlYSGU6dqxv6N43BRr6JnTeIHH0xG2+/SW/cCavb3EyYjeBXhkKOoIvg==
X-Received: by 2002:a1c:20d0:: with SMTP id g199mr2356253wmg.68.1605268822737;
        Fri, 13 Nov 2020 04:00:22 -0800 (PST)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id a18sm4374731wme.18.2020.11.13.04.00.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 04:00:22 -0800 (PST)
Subject: Re: [PATCH 2/3] interconnect: qcom: sdm845: Add the missing nodes for
 QUP
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-pm@vger.kernel.org, mdtipton@codeaurora.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        akashast@codeaurora.org
References: <20201105135211.7160-1-georgi.djakov@linaro.org>
 <20201105135211.7160-2-georgi.djakov@linaro.org>
 <20201111043703.GA173948@builder.lan>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <47ce524f-3ba5-2977-3e36-08b646389d68@linaro.org>
Date:   Fri, 13 Nov 2020 14:00:20 +0200
MIME-Version: 1.0
In-Reply-To: <20201111043703.GA173948@builder.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/11/20 06:37, Bjorn Andersson wrote:
> On Thu 05 Nov 07:52 CST 2020, Georgi Djakov wrote:
> 
>> The QUP nodes are currently defined just as entries in the topology,
>> but they are not referenced by any of the NoCs. Let's fix this and
>> "attach" them to their NoCs, so that the QUP drivers are able to use
>> them as path endpoints and scale their bandwidth.
>>
>> This is based on the information from the downstream msm-4.9 kernel.
>>
>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> 
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> 
> Georgi, would you mind if I take the series through my tree, to avoid
> conflicts in sdm845.dtsi?

Agree. Please take it through your tree.

Thanks,
Georgi
