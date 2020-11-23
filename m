Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6C722C054F
	for <lists+linux-pm@lfdr.de>; Mon, 23 Nov 2020 13:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbgKWMOZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Nov 2020 07:14:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729294AbgKWMOY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Nov 2020 07:14:24 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D920EC0613CF;
        Mon, 23 Nov 2020 04:14:22 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id d17so23380878lfq.10;
        Mon, 23 Nov 2020 04:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TRhGjbX+VEiprJASwNsMJBN6MmSp2/p8ffbHFNLLsjE=;
        b=K4daee2wLSFX05MC4H13VqAmjxeWpMxobi3uR5PHfIWNbdrgwBaSFlnfYL1dH55R/k
         Q4OGdyP5r6mHHk5nagnfvdyFpW347yr4CP77sOfL/q+fYsSjxR07X3LDfEz3yTdD3ATS
         MQTwsYFRCNSfgwQP00E/IHq1SDs0popuUroi2NUnsQssoGcJ3eOF2BJjOCE9zwZVn7sR
         XutkFZyFixsUwRX7R/iV86VV4fMQPUn1lOkBeSGlP+lUgQmwtCyWceLG9Kws2FZcONzi
         TAmvLk+APEduPsVRXNZCpkMlzp51XoyRIQTTaom1cvbRfM4+TzmPyNdSOkhFG8GgSFU2
         MK2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TRhGjbX+VEiprJASwNsMJBN6MmSp2/p8ffbHFNLLsjE=;
        b=koZX/ccODYENofJgzxodA6jae7f4IbiBXWeV2kjGZIjYAaEtulQ92fIO5PZAuR9nt+
         2YApf10O1pVVuk0lnCN2buHIhETfbtnLPuDiEfN7vcMkyOoo39sAr6+flqrFQ4TfT4Ll
         eTsL+VRNZKNGw39BSlMjbEgrsjpzM6uCKh4KJDNBQIngoSGpyDCZ6Xfd3lZV3qLu8+YK
         iRaCOVpB8gjnpy+5EW7EiW9doIv4PuQiaeSagBWZj2hP3cOExOI3Cu9iWsHhaS6KXiFZ
         LP2DZ2Iu/t82Z+3c95nTpYqBRZUhhw7LziAHesApMEd782x3Ne5+GMJq35ZwtW7cJ/HD
         AHww==
X-Gm-Message-State: AOAM532I5I4jveYEZGi+/LNLqxS8Cy1JuvgFd8t4Yzc9GQpz2np3O8Nb
        xRx9eUyxTLiWBKY0VFwJ/2Q=
X-Google-Smtp-Source: ABdhPJyeUKDBnMC5w2mRg2QuoMaH6BuqaSjVArPe4axgNT1C/Ngvvfi2S1/Hfsx7UiIAQiajE51y0Q==
X-Received: by 2002:a19:c94:: with SMTP id 142mr12360394lfm.284.1606133661420;
        Mon, 23 Nov 2020 04:14:21 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.googlemail.com with ESMTPSA id q26sm1371522lfa.104.2020.11.23.04.14.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2020 04:14:20 -0800 (PST)
Subject: Re: [PATCH v10 09/19] PM / devfreq: tegra30: Support interconnect and
 OPPs from device-tree
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20201123002723.28463-1-digetx@gmail.com>
 <CGME20201123003325epcas1p1b90c7b94507a3d58053949f5395c885a@epcas1p1.samsung.com>
 <20201123002723.28463-10-digetx@gmail.com>
 <f8f0b254-b5d6-7951-7576-846d8f58cb13@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <cb9ba2fd-c450-b35d-9a72-846f33e0c427@gmail.com>
Date:   Mon, 23 Nov 2020 15:14:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <f8f0b254-b5d6-7951-7576-846d8f58cb13@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

23.11.2020 10:02, Chanwoo Choi пишет:
> Hi Dmitry,
> 
> On 11/23/20 9:27 AM, Dmitry Osipenko wrote:
>> This patch moves ACTMON driver away from generating OPP table by itself,
>> transitioning it to use the table which comes from device-tree. This
>> change breaks compatibility with older device-trees and brings support
>> for the interconnect framework to the driver. This is a mandatory change
>> which needs to be done in order to implement interconnect-based memory
>> DVFS, i.e. device-trees need to be updated. Now ACTMON issues a memory
>> bandwidth requests using dev_pm_opp_set_bw() instead of driving EMC clock
>> rate directly.
>>
>> Tested-by: Peter Geis <pgwipeout@gmail.com>
>> Tested-by: Nicolas Chauvet <kwizart@gmail.com>
>> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/devfreq/tegra30-devfreq.c | 79 +++++++++++++++----------------
>>  1 file changed, 37 insertions(+), 42 deletions(-)
>>
> 
> (snip)

Hello Chanwoo,

> When the patches related to icc are merged, I'll merge patch9/10.
> Thanks for your work.
> 

Alright, thank you!
