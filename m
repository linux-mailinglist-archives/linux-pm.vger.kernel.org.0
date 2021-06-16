Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 109F23AA41F
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jun 2021 21:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbhFPTTe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Jun 2021 15:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbhFPTTc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jun 2021 15:19:32 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08DEC06175F;
        Wed, 16 Jun 2021 12:17:24 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id m21so6032676lfg.13;
        Wed, 16 Jun 2021 12:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vt3aTEsK9tpfVjQasrsyiVEB11qyTSKtUnV6R1cyy/0=;
        b=uy5rt2L3pyx0BlpVOqOuTlWs5j8fErl+ZQTmL+etCQdXt/p53EdAHaNERjU55YV1ls
         Y11SJkJCLhZxqQn51arh6PGkLxwvAqONQ+05/AWWJ6UTb1TkrTBLFpMVXLc2/lMP6TQl
         j2Nx8DIFto/3xvOVdfe2129qyy2Nz/b0SA2pllf785mqs7yIo94j1idjvvhJPhCLkkGF
         W2cPNIsbFc3cvG7a1eYUfnCo0IsQkoDdVyRyiAMyDshemLhtbcvb0C/rhGmBQZxb4ZND
         W8iENqOl+ivLq3E3qrDfNsRRTqk4QYboUs9hdBcl1Ge49Idz2kE228q7TCXabQCXLOKF
         88HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vt3aTEsK9tpfVjQasrsyiVEB11qyTSKtUnV6R1cyy/0=;
        b=I+v4um/tGvyQECH6g1P1CY73L3JxzoX8RlZGg90qEuJr8FUl6/iGANe2yLXqmgDHuH
         8OWrIca6KT8BN9vsWjRM3Ce9oy/Muegv/TMo1Cx82l9WJAxS+xDENLhaZBAk7rOH6Lux
         gef6p57taVMLOBOuypOJE9Ih4iC5wUevMlLakIJKP7yhDAzsK9jrYK4Viw6K7hLT1hYa
         gMp5CowKk3KQ0/l0robQMKYyqy+z1pScL50TM7q7lEOogkUMI5re0KY7Dm5WKf31HOpi
         tJHJl8ARs5PrBFjxsuKzCdpqMfXoJXcy6aj6j9LWV6fOt65JBoWhtAU7R79q9oca0KHK
         P/uQ==
X-Gm-Message-State: AOAM530J6n5ABQPW/kDPWo1I70+Wd1xT1q2gANFmvWyToEAqR0dxee/W
        s1xSdthD97ka/sDhw1QDyiuHvz/A6Hg=
X-Google-Smtp-Source: ABdhPJyEWQqWdgtnCvxSFTY/TxvQw8tFKfzGAKGhmmu7M1GBM7zQyl+IGpE8zyGWt4GEAw0Tz4ODFQ==
X-Received: by 2002:a19:7d82:: with SMTP id y124mr926404lfc.76.1623871042930;
        Wed, 16 Jun 2021 12:17:22 -0700 (PDT)
Received: from [192.168.2.145] (94-29-29-31.dynamic.spd-mgts.ru. [94.29.29.31])
        by smtp.googlemail.com with ESMTPSA id u8sm409284lje.99.2021.06.16.12.17.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 12:17:22 -0700 (PDT)
Subject: Re: [PATCH v1 2/5] soc/tegra: irq: Add stubs needed for compile
 testing
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20210606222817.12388-1-digetx@gmail.com>
 <20210606222817.12388-3-digetx@gmail.com>
 <92b521c6-f3fd-4f2c-de4f-3363e0384f55@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <cb9d8a40-a64f-e37f-1487-272b2c4ac9ea@gmail.com>
Date:   Wed, 16 Jun 2021 22:17:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <92b521c6-f3fd-4f2c-de4f-3363e0384f55@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

16.06.2021 22:06, Daniel Lezcano пишет:
> On 07/06/2021 00:28, Dmitry Osipenko wrote:
>> Add stubs needed for compile-testing of tegra-cpuidle driver.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  include/soc/tegra/irq.h | 9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/soc/tegra/irq.h b/include/soc/tegra/irq.h
>> index 8eb11a7109e4..94539551c8c1 100644
>> --- a/include/soc/tegra/irq.h
>> +++ b/include/soc/tegra/irq.h
>> @@ -6,8 +6,15 @@
>>  #ifndef __SOC_TEGRA_IRQ_H
>>  #define __SOC_TEGRA_IRQ_H
>>  
>> -#if defined(CONFIG_ARM)
>> +#include <linux/types.h>
>> +
>> +#if defined(CONFIG_ARM) && defined(CONFIG_ARCH_TEGRA)
> 
> Does not CONFIG_ARCH_TEGRA depends on CONFIG_ARM ?
> 
>>  bool tegra_pending_sgi(void);

ARM and ARM64, only ARM32 variant builds tegra_pending_sgi().

