Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 095BC31DA87
	for <lists+linux-pm@lfdr.de>; Wed, 17 Feb 2021 14:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbhBQNbb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Feb 2021 08:31:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbhBQNbN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Feb 2021 08:31:13 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2D0C061574
        for <linux-pm@vger.kernel.org>; Wed, 17 Feb 2021 05:30:32 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id v3so9465180qtw.4
        for <linux-pm@vger.kernel.org>; Wed, 17 Feb 2021 05:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9KvlBXWE9H1CeowlMEMLTPIl6Q9OVw73HzJ2aa5ZmGg=;
        b=vA5plzml7tzyib+hGFxVRbODs0ykXI8/JjG5qU3MkU5IcmOjw6MZ3XD5lKJBOZeDSv
         jOfJT+4h563NBykjv6VMmsNE//0tc+OawkhxvM8OJh633rGvQKFH8upmKZWEzJ0hj/b8
         iTFiNhYg62B7KEB8lwb4xi2KgY+f713Ywjsegh4Bm/nY2ZeuBQV1EsU2lqXoUvRjspGM
         A1y+r74E+oEXTC67qTFJsYBEJRO7Rzg3kVVnu8CXOFPcvDR6fadB/3RM8D3otxdMO+uK
         LIvgfB9a3f8v3bcww0R/NeUd00qCTnzezOhDbhTrH5UDvNOpsMjU45kI2/IsElxJFhUf
         HikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9KvlBXWE9H1CeowlMEMLTPIl6Q9OVw73HzJ2aa5ZmGg=;
        b=eMhm4m5DFw/dG0WCrCjKAXVCkEJ6oRY5k/aSSA/+dHdu7hVh6UJ1UJKYWHC0GIAIWD
         4xeTg0jJuape93ivimDzasvDqFvO2YjBl2haE3zfKNH935rhEX/ZWGUby4Eyj0rVRuum
         mdXMHf3UOxTYggiYIUUtzGm84+9OFalZDKSPAE9hIZLFLi5wL7wOCfDLiNXdsveVzLlf
         4nLX9j4v3kSlWYKv8PTMKcVoeSP32Eh1oYJeOEP7DUwM00iI2VF3TZ8cvTrhQAukOW16
         1RgSr7hmFnHWcd90zCAhA8QlqmigqXpCuQSMuyFtKAau442VwTntPpYn8nDDmkbVE/r7
         6G7g==
X-Gm-Message-State: AOAM532cvlj656YxlZIyXZjatN/yTC5JReLtrl38k8mqzmis5tF0o2+5
        fS/l5wjC7MnDmmvpPMSTAeswwg==
X-Google-Smtp-Source: ABdhPJyUzFF6WeMX4sFQFQgyNcl6ORc08DpDDsdCdLs2jTqDrjcn2QGP394cLkzhNsofkTrDLzaRWQ==
X-Received: by 2002:ac8:47d6:: with SMTP id d22mr22147384qtr.44.1613568631867;
        Wed, 17 Feb 2021 05:30:31 -0800 (PST)
Received: from [192.168.0.189] (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id n8sm1097761qta.61.2021.02.17.05.30.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Feb 2021 05:30:31 -0800 (PST)
Subject: Re: [PATCH] opp: fix dev_pm_opp_set_rate for different frequency at
 the same opp level
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        "open list:OPERATING PERFORMANCE POINTS (OPP)" 
        <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210216201030.19152-1-jonathan@marek.ca>
 <20210217045310.thfl7ckxzfiqjlu6@vireshk-i7>
From:   Jonathan Marek <jonathan@marek.ca>
Message-ID: <88b0c110-78fb-cbb0-dd2b-5c4ffb5bc930@marek.ca>
Date:   Wed, 17 Feb 2021 08:29:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20210217045310.thfl7ckxzfiqjlu6@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2/16/21 11:53 PM, Viresh Kumar wrote:
> On 16-02-21, 15:10, Jonathan Marek wrote:
>> There is not "nothing to do" when the opp is the same. The frequency can
>> be different from opp->rate.
> 
> I am sorry but I am not sure what are you trying to fix here and what exactly is
> broken here. Can you provide a usecase for your platform where this doesn't work
> like it used to ?
> 

The specific case is this opp table:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/qcom/sm8250.dtsi#n439

It does not define every possible clock frequency, it only defines the 
rates at which a higher rpmhpd level must be used. Which is the intended 
use of opp.

Your change broke this completely: the clock rate change can be silently 
ignored because the opp level is the same. In particular it breaks 
bluetooth for this platform.

>> Fixes: 81c4d8a3c414 ("opp: Keep track of currently programmed OPP")
>> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
>> ---
>>   drivers/opp/core.c | 7 +++++--
>>   drivers/opp/opp.h  | 1 +
>>   2 files changed, 6 insertions(+), 2 deletions(-)
> 
