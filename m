Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9664421369E
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jul 2020 10:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgGCIlU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Jul 2020 04:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgGCIlT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jul 2020 04:41:19 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DCBC08C5C1;
        Fri,  3 Jul 2020 01:41:19 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id z24so11121290ljn.8;
        Fri, 03 Jul 2020 01:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=94u4fadNGtidN2vaiyXlzWw+DxqIFzoI6bECvXw6Onc=;
        b=Rwjky4+fTcHJpBjZGyOurGK+bbTLYpMa1+miIEapCV2QYmnTJlRx+lbXF4XppXR4KP
         ehdKLNZRYaj5hPmxptVbfninuCrD1nDGglstkBWCsDZ/x+45XJt9jQNLoE5wg6sKcs5e
         r1u8drtFNmPJmN0ikR6asgq0lU1Z9PerEoyOcj+h8q8y/WmGU44iB7e3F+6PPriu4CKc
         wdgzD2y9QqrJstXhFQlETSGtPbCze3O4SeJ2IiqWpqH+m07PurDkSqPKu9cCD5vwayPL
         X49MryiptFeK3PzPBTXX+1ZPyS0w5pY25GOjNkZ2Fqq2wBEJ58ZB+8pN0ksGfMzSSkWS
         k0hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=94u4fadNGtidN2vaiyXlzWw+DxqIFzoI6bECvXw6Onc=;
        b=DLObjcbgoMX5lHY02GuZ4lZDEGdGPt8cBWamCWbAq7tmxcyNOU/IJZGpiK/NAU5Jys
         mbHOFjWWgBFyvnCjCRdFOiuuwmHouEDNfYiFONzPFohCseKCv1YpqB/gg6m4Z9SsQd3S
         nrmjVFAAv6G6QQSqu0qO18dRpBrOcVolkB03aqLi/QZYcfIXs7K5C1dX7hyfuhos12MW
         rvIBKNicE0oi9bIovLwLeEyvEzMjXCO/FCJtHHs3uiOdL85HfLgQpzlR1RWO2RqtndhM
         fpIYizB3Z1TI9JGeK5ZBNX+pvYkm397VPeLzmf3xzrNQGQw7iPfjMX0nfLAJdtyUkp55
         Qyiw==
X-Gm-Message-State: AOAM531RR1tADhClRzTC0P6EUL9n+iI/wMxQ8+tr4n+0KhUFGjcbSUJ0
        6NwHtPfQpNaGcWtdDVW/DoNdmdlGQj4=
X-Google-Smtp-Source: ABdhPJzHywnF/v01Hll4ows4GlWRPjjUQx4ETYaAZkhy1uLq32oivsjtx3GFvxO1wnG+bHMUCD+SfQ==
X-Received: by 2002:a05:651c:50d:: with SMTP id o13mr20078873ljp.181.1593765677281;
        Fri, 03 Jul 2020 01:41:17 -0700 (PDT)
Received: from [192.168.2.145] (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.googlemail.com with ESMTPSA id y13sm3871513ljd.20.2020.07.03.01.41.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2020 01:41:16 -0700 (PDT)
Subject: Re: [PATCH v4 28/37] memory: tegra: Register as interconnect provider
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
References: <20200609131404.17523-1-digetx@gmail.com>
 <20200609131404.17523-29-digetx@gmail.com>
 <aec831a6-a7ad-6bcc-4e15-c44582f7568e@linaro.org>
 <82d27a47-f189-6609-a584-c9ca1b35a76c@gmail.com>
 <05cb459d-fc10-1537-eaea-df06f7566b6a@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <31565962-a25c-324f-8319-b3e3ea66b4f1@gmail.com>
Date:   Fri, 3 Jul 2020 11:41:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <05cb459d-fc10-1537-eaea-df06f7566b6a@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

02.07.2020 15:36, Georgi Djakov пишет:
...
>>>> +	mc->provider.data = data;
>>>> +	mc->provider.xlate = of_icc_xlate_onecell;
>>>> +	mc->provider.aggregate = tegra_mc_icc_aggregate;
>>>> +
>>>> +	err = icc_provider_add(&mc->provider);
>>>> +	if (err)
>>>> +		goto err_msg;
>>>
>>> Nit: I am planning to re-organize some of the existing drivers to call
>>> icc_provider_add() after the topology is populated. Could you please move
>>> this after the nodes are created and linked.
>>
>> Are you planning to remove the provider's list-head initialization from
>> the icc_provider_add() [1] and move it to the individual provider
>> drivers, correct?
> 
> Yes, that would be the first step, but i need to post some patches first,
> so let's keep it as-is for now. Sorry for the confusion.

No problems, I'll keep an eye on the ICC core changes!
Please feel free to the CC me on the patches, I may give them a whirl.
