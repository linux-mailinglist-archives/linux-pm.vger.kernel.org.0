Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DADD2A34E8
	for <lists+linux-pm@lfdr.de>; Mon,  2 Nov 2020 21:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgKBUIb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Nov 2020 15:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbgKBUI2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Nov 2020 15:08:28 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CB8C0617A6;
        Mon,  2 Nov 2020 12:08:28 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id m16so16408725ljo.6;
        Mon, 02 Nov 2020 12:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Hka4cKqpDMPFWpJt8TYHJB5ZlWozslgjk/byOs/Vz6Q=;
        b=lIKs4+aJlWuxFicaenX76Fiz0DWMW6nUw7wC+zfMn0PaBYMsKo2zYOP8nG8l3RoEH8
         J5J2Phmj83ZVB4hVVzqWHBDR6giS4zsN51Bs1rqw8UpAPN/6LWvditv7rEFBphh0cyI3
         mKo69CaTCMaaAQKgTMDDfGtB+bWEnFIWgq2s/oT75QBIuS1E0Gclwy7ErdoFkzucOYNk
         QY12ShXYL2dpGTnkHkUBEuqC5rxgpDCAGgryRA1CAcXhwq6aEFIQQnglHMwbUTo1wTUD
         6I88siB1KZ5vbyZdQ61YCChaBKm7wlpl4f/+XM9/SXWFMSUeOu5mX2Q25F09pDLTvCdh
         zZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Hka4cKqpDMPFWpJt8TYHJB5ZlWozslgjk/byOs/Vz6Q=;
        b=GcuFFfnLfYADoCwE5WWknvQWJj4LOPcjkBCUO6F4ZexTmOCJm5bVnp6UdpHS3WvQLm
         FtobyaQBdr1MFfL4Ew/V3r/4s4E7Xl7DAn5AEGWXzcx0ldMPhCIUxBDJhk7jIZju7cR2
         si256ogdMxmmhJgGNIb+90TcYeHbwjX1QlWj9CrylfhZ5OaGrwtWylRvxcIyDK/DiGOa
         efUZjSqAXJFSXcx5Kcof5G7pV3knJAh7kkOonc0aktn1gpwiIlVz7pW/QG93aOBIejyi
         X2VF2KrJ2RIrDA/ZuYxjbLOQe0ZSjE9zA0MsdYzEXA0yTMTJCsJ3/tdoCfVXKMPDWXNb
         dffA==
X-Gm-Message-State: AOAM533Ha+1IFURWOE+b/qc0bo3envDX1ZDh/0Bj5Z+jgZYuCL+N/Crz
        EYseJKjyx1S7sQsCkx3O6bCXZjcJgFQ=
X-Google-Smtp-Source: ABdhPJwu9+601VtSHx9RG6K454vM9jL+o3J7hQ/5XYw2V8eE5tjRxvEHJyNtJxSvrhytwkDkKtlzXw==
X-Received: by 2002:a2e:98c2:: with SMTP id s2mr6789352ljj.339.1604347706478;
        Mon, 02 Nov 2020 12:08:26 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-177.dynamic.spd-mgts.ru. [109.252.193.177])
        by smtp.googlemail.com with ESMTPSA id c4sm2657571lfm.294.2020.11.02.12.08.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2020 12:08:25 -0800 (PST)
Subject: Re: [PATCH v6 49/52] PM / devfreq: tegra20: Convert to EMC_STAT
 driver, support interconnect and device-tree
From:   Dmitry Osipenko <digetx@gmail.com>
To:     cwchoi00@gmail.com
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-tegra@vger.kernel.org,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201025221735.3062-50-digetx@gmail.com>
 <CAGTfZH0KxyZYLZ_AgM7Lr+4s35kaWJp1AenpZ-o_FRLCCHC+6A@mail.gmail.com>
 <0ffa84f6-625e-807c-e9af-7a67f0fe48e7@gmail.com>
Message-ID: <bff3bf4a-8111-7c96-92f6-46343d85be0d@gmail.com>
Date:   Mon, 2 Nov 2020 23:08:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0ffa84f6-625e-807c-e9af-7a67f0fe48e7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

01.11.2020 17:12, Dmitry Osipenko пишет:
...
> We will probably move the Tegra20 EMC_STAT devfreq driver into the
> memory driver and remove the older IMC_STAT driver in v7, like it was
> suggested by Thierry Reding. This will be a much less invasive code change.
> 
>> Also, if you want to get more responsiveness, you could use delayed timer
>> instead of deferrable timer by editing the devfreq_dev_profile structure.
> 
> Thanks, I'll try the deferrable timer.

I took a brief look at the delayed timer and I think the deferrable
timer should be more a preferred option because this devfreq drive is
more an assistance for the optimal bandwidth selection and it will be
more preferred to keep system idling whenever possible.

My primary concern is the initial performance lag in a case of
multimedia applications. But this will be resolved by hooking up
performance voting to all drivers, once we will get around to it.
