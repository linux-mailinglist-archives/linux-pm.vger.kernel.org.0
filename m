Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 099702A34B1
	for <lists+linux-pm@lfdr.de>; Mon,  2 Nov 2020 20:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbgKBT6Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Nov 2020 14:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbgKBT6W (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Nov 2020 14:58:22 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72997C0617A6;
        Mon,  2 Nov 2020 11:58:22 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id x6so16388026ljd.3;
        Mon, 02 Nov 2020 11:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1JXbVMJB6iZDvFn2TYFYjVdXtMc5N33ypKmnpsnfwcw=;
        b=GvSuHE002gQYaHK6//lYRoOM8iWIiSv4gpl/5TT86pgpNMgJSYE95NrdAYllly3GCV
         NtqNKOo0iOAOZAGl1kccGHUkeoahEHnlwlFki7SVINZzbOJLUiBGHeQycvKYr8RCXQXR
         ua0qQV3Yg73dUVMtm+f/hjXdCnKv62cGSyT9WCUyI2c3S0U9K6xX9+/KJxTozePW/Fdj
         RjO0IYdL0vtZbedhzNaTkEeJ6Zo8S7CZFrnoc5A2ciH1TQS41z9yG2FdR+Gvq9GRy/wz
         rQh+FKmGENoIhBIqebP2Lbm+IaPNld+cxb9Htqdx0k9LEMh7YmNwTOhxR8qOD25mAtna
         SwMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1JXbVMJB6iZDvFn2TYFYjVdXtMc5N33ypKmnpsnfwcw=;
        b=TEL99p5su7bykuwFrVGJ9sZ+BrBvt6ldw1B//RN/s4qR4cpA5H960Vu2fsKnFznz9j
         EycDpHmBv28TckUWilOt0qaLMuC7ydKyUrtqbsRwuM8U8QjvX9IkMUSUwEn/Iukie6mz
         oPsZOOYgoeqsp4rvRCThGxTUvAlpXIg0yPgg0jNupTHsqSSWwRW8NicwyIchCBJ7lP+M
         jPdLFEAy2q3KxOqGgtsFWFFurfVP0SItwswiruJLB7DXrIbtoYeyWEyZWYDk/Hj1OxgK
         JYLliWzBjbqv0xPsY5S4DKtAF2uh5SWLVMOzgoy0BFPsrxMVxosB+rztaaVvV/uhe2Mz
         6NpQ==
X-Gm-Message-State: AOAM533tCklvxW4l9Aw6k3doyxNzFPEYa8xiul+ehx9wA9fG8olzzmF1
        WgXmpflWWxQ/O8+LvADTxnHmNJfQQq8=
X-Google-Smtp-Source: ABdhPJwh3UXwcgYRQlHhUY52Pf+LJUUHKC6w8/ZHkmXQQZvyOevxaLyiaDuXzsNb/9BlpQcIXJ1gYA==
X-Received: by 2002:a2e:97c1:: with SMTP id m1mr6756565ljj.58.1604347100787;
        Mon, 02 Nov 2020 11:58:20 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-177.dynamic.spd-mgts.ru. [109.252.193.177])
        by smtp.googlemail.com with ESMTPSA id j14sm2641536lfm.192.2020.11.02.11.58.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2020 11:58:20 -0800 (PST)
Subject: Re: [PATCH v6 51/52] PM / devfreq: tegra30: Support interconnect and
 OPPs from device-tree
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
 <20201025221735.3062-52-digetx@gmail.com>
 <CAGTfZH1PV4r-pD=zTKD71nQb5+UobJKa5mBv-Nb2ZgSubkscjA@mail.gmail.com>
 <2ebd184c-60e8-19e2-9965-19481ced1c70@gmail.com>
 <CAGTfZH0=6R02euOR3JHgA0iLq5++Yvp3Z_wBCEs7bzkfuorEFQ@mail.gmail.com>
 <5f5a22b1-4d01-5698-1bca-6bcc66c55e6f@gmail.com>
 <CAGTfZH3s-1cROd3_X2weBs6i1irgJQJZP+8G+rj9p3KZMUu2vQ@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <d8803971-1af7-0934-3f4c-8a9222623957@gmail.com>
Date:   Mon, 2 Nov 2020 22:58:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAGTfZH3s-1cROd3_X2weBs6i1irgJQJZP+8G+rj9p3KZMUu2vQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

01.11.2020 18:57, Chanwoo Choi пишет:
> On Mon, Nov 2, 2020 at 12:49 AM Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> 01.11.2020 18:44, Chanwoo Choi пишет:
>>>> OPP core will try to grab the clock reference for the table and it may
>>>> cause EPROBE_DEFER. Although, it shouldn't happen here because we have
>>>> devm_clk_get() before the get_opp_table(), hence seems the deferred
>>>> probe indeed shouldn't happen in this case.
>>> It is my missing point. If there, you're right.
>>> Could you provide the code point to check the clock reference on the OPP core?
>>
>> Please see it here:
>>
>> https://elixir.bootlin.com/linux/v5.10-rc1/source/drivers/opp/core.c#L1101
> 
> Thanks. It seems that if device tree node contains the any node,
> it is not EPROBE_DEFER because of just using "clk_get(dev, NULL)".
> 
> The patch[1] used the 'dev_err_probe' for getting the "emc" clock.
> Do you need to check it more?
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/commit/?h=devfreq-next&id=09d56d92ad25b58113f4ec677e9b1ac1e2c3072b

It should be safe to assume that the EPROBE_DEFER won't happen for
dev_pm_opp_get_opp_table(). I'll improve it in v7, thanks.
