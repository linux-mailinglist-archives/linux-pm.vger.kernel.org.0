Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CADC38F454
	for <lists+linux-pm@lfdr.de>; Mon, 24 May 2021 22:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbhEXU0k (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 May 2021 16:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbhEXU0k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 May 2021 16:26:40 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8848C061574;
        Mon, 24 May 2021 13:25:10 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id c15so35252316ljr.7;
        Mon, 24 May 2021 13:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g9hgNwmOuDP5DthgeuaSKULnhUo7ubNRfZKms1Tzv8E=;
        b=uK3ppJAGePAn590fa0VNgjuAvFP6VPLQ4E6Zcop0dEpa33bKhMkltSH1KrnoPw2liA
         gzgY5alIPL4LDkf8ok2by6JZRu0bedLT7p8Gq1Im66WB3yfmDtjZ26R/zsfeVyyOQSUL
         o/JCpoMy58arwwyhOlPq4nU8vzCyJad12WNXBajLRRYL1Q59ZxRLi9CKbI8zfa43cwia
         cCm+ATVNeB0rxXMvb36poYjerFWKlBawfzoOrEDXXf3EWMNdwag92wvRYQzFwKMjSvP3
         yhwfWuDuJVFaz968/q84ArWT0H72LPXY3kWvqhMEC7ocOFHXwj+Vtc5Yamkw4B+uu5KW
         mQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g9hgNwmOuDP5DthgeuaSKULnhUo7ubNRfZKms1Tzv8E=;
        b=OUCUPs3N6S48yohq4uHpJCez7jX6NkYIOAX6adPHTWOfXoUrXLbWmBbNTQ4eM3xsdM
         LstcaDB7iQiWa+AfuDzt1nrvHQnyQuVB+QCFlzYO7c5vDkYcADZM8mwP63gYGKIHyAJ2
         1b7fnTYAHF7do5RFWEsm8993kKPXhmGXIsAb2rk5PNHWCrSw8cdBYNB4SqOgt7VOggh0
         /4cBeqE1GJ8nIGUgsBYHA3BeDKebhZVhuY0JuDmtL5UB61pg6EnTwIv6yvOBTkOQMyW/
         lcuJEg2KCIohF/Iqo4L9JZ3H2vdrdfzLnkPr6a9khQEhcPeydBzIUfJNQNswvBaW745d
         hAhg==
X-Gm-Message-State: AOAM53072oR2Gnns+kJW7cN6NQ+Zi3CAMxvNGL9C56E6eYniH/UcX5my
        Fr9ALqZv7XW35jmieYtD9BQfS8SYuYs=
X-Google-Smtp-Source: ABdhPJwIo76DFE3Csz9R+vPmfQuF0txDCYX+lFv5TGE4as15O/HmFYS80FS1l9HZDl3DZ5jfU1mC5Q==
X-Received: by 2002:a2e:95c6:: with SMTP id y6mr18642398ljh.155.1621887909009;
        Mon, 24 May 2021 13:25:09 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-110.dynamic.spd-mgts.ru. [109.252.193.110])
        by smtp.googlemail.com with ESMTPSA id x68sm1508832lff.92.2021.05.24.13.25.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 13:25:08 -0700 (PDT)
Subject: Re: [PATCH v2 13/14] soc/tegra: pmc: Add core power domain
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        =?UTF-8?Q?Nikola_Milosavljevi=c4=87?= <mnidza@outlook.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Paul Fertser <fercerpav@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
References: <20210523231335.8238-1-digetx@gmail.com>
 <20210523231335.8238-14-digetx@gmail.com>
 <CAPDyKFrto2cosX3Ben_QWCYVqgeoF1Yv=8gEx4Y86WNyjeHvdg@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <65f65cb9-a25f-9c2c-2902-7e1776d66661@gmail.com>
Date:   Mon, 24 May 2021 23:25:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrto2cosX3Ben_QWCYVqgeoF1Yv=8gEx4Y86WNyjeHvdg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

24.05.2021 20:04, Ulf Hansson пишет:
>> +static void tegra_pmc_sync_state(struct device *dev)
>> +{
>> +       int err;
>> +
>> +       pmc->core_domain_state_synced = true;
>> +
>> +       /* this is a no-op if core regulator isn't used */
>> +       mutex_lock(&pmc->powergates_lock);
>> +       err = dev_pm_opp_sync_regulators(dev);
>> +       mutex_unlock(&pmc->powergates_lock);
>> +
>> +       if (err)
>> +               dev_err(dev, "failed to sync regulators: %d\n", err);
>> +}
>> +
> Nitpick.
> 
> Would you mind splitting the "sync_state" thingy out into a separate
> patch on top of $subject patch?
> 
> I think it would be nice, especially since it shares a function via
> include/soc/tegra/common.h - that would make it clear to what part
> that belongs to.
> 

I'll split it in v3. Thank you for the review.
