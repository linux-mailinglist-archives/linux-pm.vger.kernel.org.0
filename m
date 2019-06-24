Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B51450886
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2019 12:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730151AbfFXKS2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Jun 2019 06:18:28 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41550 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729957AbfFXKS1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jun 2019 06:18:27 -0400
Received: by mail-lj1-f193.google.com with SMTP id 205so3245902ljj.8;
        Mon, 24 Jun 2019 03:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vyuS1ujG9UIY+yejiz+Q6yg4IZCzarP8XNib11msW9Y=;
        b=tUaCZF6G7U0RK8nN+5LABe7LZahV07ysvAzTK0CLDMpaQm6Ht5/KvCDPSCzbA3wKfr
         kGLjZlhulwBTIuzSMMx0XflPJik8SXfJw1JpMz80IUQsundJSFmYuq/No9WhEIeqkR7p
         uHlGxlC8I7adEvMM8r9cwwBBy6BP76BNbT1ct4Vhb8FmLziuJARmAtuZlK3HB9RNrCRU
         h9o9Dl6U0s5T++8AP8/0hKEOR4P7o7eBPSXMcP5sKOPhbhpLhug03H0Bv+ALdHPtjPVi
         VIYEDyM8kSPnt38ab3OfmA5/8Zgd1h9QVz/Mc0SxIgxQO02dpnP4rXexZEF5KnZSuX8B
         W1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vyuS1ujG9UIY+yejiz+Q6yg4IZCzarP8XNib11msW9Y=;
        b=eMMF6TtFgZ4G/jD/BaOAoCiQ/15ky13+iU8peyWN64rNh752BNeQjCait1y/yGvegc
         0G4agv4L7NpG/wl9wyWF/8H4QEaq494cRRHoEYHFzykq+qlXn4kgd/TMBjvLQii/vA7L
         +6KmFDNNng7WE2DVrnoO71KcCEi99Ip1+Fg0qzhAFLjDrXLDQN1Nn0qw0R5P3V+eTxV0
         xcTcvbDCaOuObO2rymHr1nPabtShf6L6ZdgPDEXtgD0MefjH5Dn34pEbReGx8d3mlVF4
         89wKv4mw42kkj0aXYRkx3TiaLpZt8ISSfdqEkSqFs5yjZjExA3q36/xvaVBqYD2ZN3/X
         BUFg==
X-Gm-Message-State: APjAAAUxtO1gIqvkdtMEFY+XsQiYGwQkc0W6X3PsbUEX8yKbsIFOsXc4
        i6aqtZT+WTLTEVgfNh1sLVvSzbQi
X-Google-Smtp-Source: APXvYqxYmfWiHdxTXcDfhgn9yzRhuVvf6Kq/pEglYaIKNvZ6IyPRz1YxNbsIATONH9Ii1vocD82GXg==
X-Received: by 2002:a2e:980e:: with SMTP id a14mr71871735ljj.60.1561371505209;
        Mon, 24 Jun 2019 03:18:25 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.googlemail.com with ESMTPSA id p9sm1686854lji.107.2019.06.24.03.18.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 03:18:24 -0700 (PDT)
Subject: Re: [PATCH v1] OPP: Fix crashing when current OPP has unsupportable
 voltage
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Marc Dietrich <marvin24@gmx.de>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190623175053.26167-1-digetx@gmail.com>
 <20190624071857.6ji4zc55qugpqnij@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <c5c7d412-b3f6-1f6c-dc34-0f541e955d47@gmail.com>
Date:   Mon, 24 Jun 2019 13:18:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190624071857.6ji4zc55qugpqnij@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

24.06.2019 10:18, Viresh Kumar пишет:
> On 23-06-19, 20:50, Dmitry Osipenko wrote:
>> Fix NULL dereference caused by a typo in the code. In particular it
>> happens when CPU is running on a frequency which has unsupportable voltage
>> (by regulator) defined in the OPP table and a custom set_opp() callback is
>> being used. The problem was spotted during of testing of upcoming update
>> for the NVIDIA Tegra CPUFreq driver.
>>
>> Cc: stable <stable@vger.kernel.org>
>> Fixes: 7e535993fa4f ("OPP: Separate out custom OPP handler specific code")
>> Reported-by: Marc Dietrich <marvin24@gmx.de>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/opp/core.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
>> index 9fda9a0ec016..89ec6aa220cf 100644
>> --- a/drivers/opp/core.c
>> +++ b/drivers/opp/core.c
>> @@ -685,7 +685,7 @@ static int _set_opp_custom(const struct opp_table *opp_table,
>>  
>>  	data->old_opp.rate = old_freq;
>>  	size = sizeof(*old_supply) * opp_table->regulator_count;
>> -	if (IS_ERR(old_supply))
>> +	if (!old_supply)
>>  		memset(data->old_opp.supplies, 0, size);
>>  	else
>>  		memcpy(data->old_opp.supplies, old_supply, size);
> 
> While the change is fine, the commit log isn't. It isn't about
> unsupportable voltage but frequency. The frequency the CPU is
> currently running at, is not present in the OPP table and so there is
> no corresponding OPP, hence no voltage supplies.

Ah, indeed! Looks like the reason for old OPP not being found was caused
by the appropriate OPP being disabled because of unsupportable voltage.
The offending higher "unsupportable" CPU freq was left after bootloader.

> I have applied this patch with following change log:
> 
> commit 560d1bcad715c215e7ffe5d7cffe045974b623d0 (HEAD -> opp/linux-next)
> Author: Dmitry Osipenko <digetx@gmail.com>
> Date:   Sun Jun 23 20:50:53 2019 +0300
> 
>     opp: Don't use IS_ERR on invalid supplies
>     
>     _set_opp_custom() receives a set of OPP supplies as its arguments and
>     the caller of it passes NULL when the supplies are not valid. But
>     _set_opp_custom(), by mistake, checks for error by performing
>     IS_ERR(old_supply) on it which will always evaluate to false.
>     
>     The problem was spotted during of testing of upcoming update for the
>     NVIDIA Tegra CPUFreq driver.
>     
>     Cc: stable <stable@vger.kernel.org>
>     Fixes: 7e535993fa4f ("OPP: Separate out custom OPP handler specific code")
>     Reported-by: Marc Dietrich <marvin24@gmx.de>
>     Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>     [ Viresh: Massaged changelog ]
>     Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/opp/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thank you very much!
