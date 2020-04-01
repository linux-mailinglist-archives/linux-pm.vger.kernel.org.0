Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8F919B5F6
	for <lists+linux-pm@lfdr.de>; Wed,  1 Apr 2020 20:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732211AbgDASw5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Apr 2020 14:52:57 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45218 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732208AbgDASw5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Apr 2020 14:52:57 -0400
Received: by mail-lj1-f195.google.com with SMTP id t17so553844ljc.12;
        Wed, 01 Apr 2020 11:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8rKHOvC+1viKsJ66KVDF6/jPm8HDlsQUVycgY4SH8Vg=;
        b=Xy87xPSeXhAJ78Ro5x2ym5wq7taSoRucC8rpa56D3dTwhb7ye6tJVkadZODi0TaX2Z
         FGXZw6RPux0GrE/o66bM/xQYb+Vap0+pPRUnbA6NDPDcVYBJL0X6cHOzPKyd3E74IGy7
         p8+waYyIQKantfIUZx38hnSy8NdzBUVq3pLyTWyurw5atx7FFZRvqC3o0M7P01fJCgNO
         p+W1GyRS96+LHVEfl57gxUZzBdD9RsDFXMujkPH1v00cjx6JsgdAS3hDWCFsZQUMisFD
         lkftZJHjGRnd4c8pVq6eatMy3AV6nZQD4MWorpNOb3sZjs3xGvbpkXs5KpApt4rPuEPT
         y3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8rKHOvC+1viKsJ66KVDF6/jPm8HDlsQUVycgY4SH8Vg=;
        b=UnPoWxslIkyLXLBpbhIUFuOgXnrb7eVGAri6zMTs/2gW29Vepx8VacYH8PghE7wa+7
         RqiPsPCj6lyT2Xi9CwPaVlq1MZ69Z2vvC2v2gA4zH/jQuL5fuL9ptLEvOapiDr/azD0S
         xbcQAHVILmBuqs/ZigK9bKPhCRoT2hZNNrzzD2oSk1dXhKL8w0SzCGeb7BTheRTFFQ0/
         WrRi+4O/7DT+FAy/tRjI4CdvsxWFYDz762ilXnnFHfzQ8ktz07TrBvNrLWy3eLkslapK
         0RRtd1X/q2xyMm++RXpg4rE76Z6Ex1Um5c7DlRk6Y5LuEopzGRV4gri1I3AYrrNpGSrE
         RZng==
X-Gm-Message-State: AGi0PuZLgzuBiTdsotM1Vl3RgEX7nVsYuPiI7XIt4HuzW4ywg/CGo1KW
        046kc64lzOwmM2R9jxdlloRrFutF
X-Google-Smtp-Source: APiQypK5HeIv37wFzYRlQ/paJfNLfRBhpQdfPZ64QlP0lqXYSx4R/I4wafisjCg1FffMpWgC33CQsw==
X-Received: by 2002:a2e:9959:: with SMTP id r25mr13930691ljj.200.1585767173779;
        Wed, 01 Apr 2020 11:52:53 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id c22sm2153008lfi.41.2020.04.01.11.52.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2020 11:52:53 -0700 (PDT)
Subject: Re: [PATCH v1 1/5] PM / devfreq: tegra: Add Dmitry as a maintainer
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200330231617.17079-1-digetx@gmail.com>
 <CGME20200330232036epcas1p2cba89238a41fa0941d0abcaf2b457072@epcas1p2.samsung.com>
 <20200330231617.17079-2-digetx@gmail.com>
 <db4883d4-18b7-238a-798b-ad45aad978fc@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <cfaf5c1c-51e7-2b5c-dcfa-65546674ca95@gmail.com>
Date:   Wed, 1 Apr 2020 21:52:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <db4883d4-18b7-238a-798b-ad45aad978fc@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

01.04.2020 02:13, Chanwoo Choi пишет:
> On 3/31/20 8:16 AM, Dmitry Osipenko wrote:
>> I was contributing to the NVIDIA Tegra20+ devfreq drivers recently and
>> want to help keep them working and evolving in the future.
>>
>> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  MAINTAINERS | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 8b8abe756ae0..9e8b0779f6df 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -10931,6 +10931,15 @@ F:	include/linux/memblock.h
>>  F:	mm/memblock.c
>>  F:	Documentation/core-api/boot-time-mm.rst
>>  
>> +MEMORY FREQUENCY SCALING DRIVERS FOR NVIDIA TEGRA
>> +M:	Dmitry Osipenko <digetx@gmail.com>
>> +L:	linux-pm@vger.kernel.org
>> +L:	linux-tegra@vger.kernel.org
>> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git
> 
> Need to update it as following:
> git git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git

Indeed, good catch!

>> +S:	Maintained
>> +F:	drivers/devfreq/tegra20-devfreq.c
>> +F:	drivers/devfreq/tegra30-devfreq.c
>> +
>>  MEMORY MANAGEMENT
>>  M:	Andrew Morton <akpm@linux-foundation.org>
>>  L:	linux-mm@kvack.org
>>
> 
> I already agreed it. To prevent the merge conflict of MAINTAINERS,
> better to be merged it to linux-pm.git maintainer. On next time,
> please add Rafael J. Wysocki to To list.

I'll update and re-send this patch separately from the rest of the
patches, thank you.
