Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6182F405929
	for <lists+linux-pm@lfdr.de>; Thu,  9 Sep 2021 16:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243853AbhIIOh4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Sep 2021 10:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347837AbhIIOhx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Sep 2021 10:37:53 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B94FC19A46D;
        Thu,  9 Sep 2021 06:48:52 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id h16so3832223lfk.10;
        Thu, 09 Sep 2021 06:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eHp4PDRkNj/IiyPBRl6G092rrNkLDcOQ4GlOapiuvhI=;
        b=BbFppZOfiFglODKD1J3lgNeIsc+hp73abQh1Sa8VG0KLCb9aAtyXRzYQE8ecJRAWL6
         UfSYVKyMjvQ6ytxwvxw51vB5480c7BvQgulJWL5T9d/dDnr0WKqx7HGNucXZHQJSgiTT
         wGjw5w4O/eMnuEdXqF8hWMH8+f39m5RQoMPZel27G0HwzEVw0Kzln0uBr2KD2p8Kfkw5
         YfrITaMRHIHSz4MQVRwJPZ4LSRO5rWqb2sewrZQ0cLNsrdXZr0gtZdTkbG6LpYEojsQf
         9OeYmNdxA7I2UX13962ZlMW8dKfUDqbRZjsj6Uoty6nL8jtxYTyGG21w4mk9pcn+TeB7
         3qzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eHp4PDRkNj/IiyPBRl6G092rrNkLDcOQ4GlOapiuvhI=;
        b=MoQZxOcAvJhCmAvZZqseQiGO9SQsNJtjm7Gj5sW49IxMrICE51xC7m6JxwmR3ZxNyX
         tT8iCFmfnkiQto/c2yQ6cwZD1kM82mRkb1HwwaPgWsoHcCK+rxhdpMAhViOoVugNsiFU
         6UM3zhgQFP2J1PmFfdAjeewbxyM6B5BsOAuJVGKZ9nwMo3K+ePRJXGnR4oRBpzr3XYoh
         6wKhip1yyd7YFm8gLs+I7XlSqZ4+VRUSjXoHweUG7I/Bgf9TXjAqUm6vDKVKCZlITBGh
         liYCeO9f+4yfV+g9xRMht4o/DvPQJ2ZXw24yJ5jTh26oFD22ZZieKM/txdITJP0Ok0vu
         zHsA==
X-Gm-Message-State: AOAM533Xp6FNzUjKL9A8xXUhVa8Ms+eQM+jFsaz49Jzr6YAirhp2RPGX
        cNbbIhdXnz1vf9OP9Ik+YwziiDihjss=
X-Google-Smtp-Source: ABdhPJx28e3JD3c68ORoRj8noGKSKy7C/Ql0cFHQR8T9d5nBTQ2StWcFRZ7iVHfDwnpOPIoRIl2kig==
X-Received: by 2002:a05:6512:33cd:: with SMTP id d13mr2352279lfg.28.1631195330484;
        Thu, 09 Sep 2021 06:48:50 -0700 (PDT)
Received: from [192.168.2.145] (46-138-3-129.dynamic.spd-mgts.ru. [46.138.3.129])
        by smtp.googlemail.com with ESMTPSA id e4sm206255lfc.141.2021.09.09.06.48.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 06:48:49 -0700 (PDT)
Subject: Re: [PATCH 1/3] PM: domains: Drop the performance state vote for a
 device at detach
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210902101634.827187-1-ulf.hansson@linaro.org>
 <20210902101634.827187-2-ulf.hansson@linaro.org>
 <08335cd4-7dc8-3b8b-d63f-374585ffa373@gmail.com>
 <CAPDyKFofrEj2LdqXh-L256b2Tcz=qYQgzTUBVuvx0rOR58SrVg@mail.gmail.com>
 <b597c805-e346-8c23-5014-cbb116e88075@gmail.com>
 <CAPDyKFrWofUKhbhvwTCjiFwJD8-Pzi8UMzU7ZjYLKm2j1HeeBg@mail.gmail.com>
 <6603212d-f36c-afff-6222-8125de5b7b79@gmail.com>
 <CAPDyKFoyszG2Wo3jbXK562XgpqXns_GPqm7nNu8WOdMCXYUOMQ@mail.gmail.com>
 <66fbbc69-3e16-e07c-4e25-48d59d69fd3c@gmail.com>
 <CAPDyKFqqdgr2DHf1Fidj3ksPHe3XgwvCo8SbQ2Cmnc5y1PDvMw@mail.gmail.com>
 <7ee1a2eb-67d7-dcad-6039-05129d3822ec@gmail.com>
 <CAPDyKFoFPpPPd0cUDRhqzXzXaQyNAv7UZToTaHnGXY30QXNB9g@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <71618f83-de5b-1180-60f4-8561c4f655a9@gmail.com>
Date:   Thu, 9 Sep 2021 16:48:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFoFPpPPd0cUDRhqzXzXaQyNAv7UZToTaHnGXY30QXNB9g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

07.09.2021 13:16, Ulf Hansson пишет:
...
>>> Also note that a very similar problem exists, *before* the device gets
>>> attached in the first place. More precisely, nothing prevents the
>>> performance state from being set to a non-compatible value for an
>>> always-on HW/device that hasn't been attached yet. So maybe you need
>>> to set the maximum performance state at genpd initializations, then
>>> use the ->sync_state() callback to very that all consumers have been
>>> attached to the genpd provider, before allowing the state to be
>>> changed/lowered?
>>
>> That is already done by the PD driver.
>>
>> https://elixir.bootlin.com/linux/latest/source/drivers/soc/tegra/pmc.c#L3790
> 
> Yes, I already knew that, but forgot it. :-) Thanks for the pointer.
> Let me rethink the approach.
> 
> In a way, it kind of sounds like this is a generic problem - so
> perhaps we should think of adding a ->withdraw_sync_state() callback
> that can be assigned by provider drivers, to get informed when a
> consumer driver is getting unbinded.

Not sure, doesn't feel to me that this is necessary for today. A bit too
cumbersome for a simple sanity-check, IMO.
