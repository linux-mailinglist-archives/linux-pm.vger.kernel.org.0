Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E41E82D1CF1
	for <lists+linux-pm@lfdr.de>; Mon,  7 Dec 2020 23:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgLGWMF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Dec 2020 17:12:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgLGWME (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Dec 2020 17:12:04 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AB3C061793;
        Mon,  7 Dec 2020 14:11:24 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id f11so4915952ljn.2;
        Mon, 07 Dec 2020 14:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MJm4yFBoOOG0Zxihy7qPEaeoKuVX+MClzRO8u7W5XUg=;
        b=tbSwwhqIuNQzd6L+D2wv6DP3s10F3sQjGFbz9OZUiX32KC7DgE1gCLimps3ZYKpw1O
         btb4gSIDwLmF8DfMaR7t1MJmpGW3up9U8Yg4lnvwjKc2f1ionNYGvK9aJqwWNCh84DzI
         Wn2yeourqvFLQWyNQaL4qnZyP2G4GCcOOBP4a7WwMlSWL0o6WD3rO7w9x9d7F06HnH3S
         3LTCVfnD1bicCQawdSIduxCNwCe31R3Mp6nNjJP+9Cl6TbtPvoTpDB6s8XlH+vWU7/DL
         H+D8y86H6LXu6eMIf1FL9uRO0Nqqf6mVn9Mgfih/V4T0M3CSd6zTcQAO0PXofQPfWg+C
         gXCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MJm4yFBoOOG0Zxihy7qPEaeoKuVX+MClzRO8u7W5XUg=;
        b=r+Lk3SzV3im9Z1Cj4oh5Ex+SIsezMEh8i/tSP7fpthnqkNzVbdusd3fvvaaefGvpKb
         Ra/xaoHMcN4LyWm7Eo2shdFm1DE52FbyehTcdJe77MogIiQAkxuZVPnsPZlRqDhmPEIm
         QHlryxQTNsAERp+3bWikZzmlYHwAurFRMIKfRDSzy9BVwKUIua5Uq4p1C+K2lh3G69Zj
         YQzGrHwQ4KC95L3Doa3qg26KVxjq2KfMRcDnb5wDSA+fdd50C+Tdf3Ix7zfYrywFrh/N
         013gqYfIq10gpEc7RNN0i2ebOPh0eq2NaDbC5nS9rGe2a40b2p8PFO+1w5Ui/8MxNZVW
         wJjg==
X-Gm-Message-State: AOAM531Kk95/TQbwYmtyqXpBJjfBh5RQySogUij5U/ofTHklA6JNThG8
        S51S8dLXp+vMwjJZbL4cbciCyAp0uLA=
X-Google-Smtp-Source: ABdhPJwHEfUeaYEY6cBzpP/Ij0Zo7ypjRgpkG3KdpX0TNEunlTBMvM1jIpO0BRfGMx711+SK5PytMA==
X-Received: by 2002:a2e:2a83:: with SMTP id q125mr5672403ljq.436.1607379082627;
        Mon, 07 Dec 2020 14:11:22 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-53.dynamic.spd-mgts.ru. [109.252.192.53])
        by smtp.googlemail.com with ESMTPSA id x25sm3062664lfn.99.2020.12.07.14.11.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Dec 2020 14:11:22 -0800 (PST)
Subject: Re: [PATCH v11 09/10] PM / devfreq: tegra30: Support interconnect and
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
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
References: <20201203192439.16177-1-digetx@gmail.com>
 <CGME20201203192723epcas1p372e53c3e1443b7cd3010c44faff735ec@epcas1p3.samsung.com>
 <20201203192439.16177-10-digetx@gmail.com>
 <42927892-d4a7-9368-480b-14c0d06e7116@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <6ab55ef7-87bb-9f10-c262-b02430fe7d12@gmail.com>
Date:   Tue, 8 Dec 2020 01:11:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <42927892-d4a7-9368-480b-14c0d06e7116@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

07.12.2020 04:32, Chanwoo Choi пишет:
> On 12/4/20 4:24 AM, Dmitry Osipenko wrote:
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
...
> 
> Applied it. Thanks for your work for a long time.
> 

Thank you!
