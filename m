Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F077B5949F
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2019 09:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfF1HMe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Jun 2019 03:12:34 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43656 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfF1HMd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Jun 2019 03:12:33 -0400
Received: by mail-lj1-f196.google.com with SMTP id 16so4887475ljv.10;
        Fri, 28 Jun 2019 00:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/Cnt58VZhnbwSwijmz21auc9Yvj4p4PpT3m36ds3sv8=;
        b=RrGS2HZmYNW9Ve83uiayxQophGE2uHC1aW4PDfa9c5x47p2qEWlqVH6UxPRCJpS/ne
         6KcEizG2I2gHxL7QqRM6H9yvQF2/blA0KZ5aO70FtU27Zun5S3ilMHk70QMpqbLpI/ly
         uUbq54hToRVCcgo6vY1P4Ubv6J5n5pUhsAC1R9AIMTReADwYhf7nWMqLuTtV5JIxEz1K
         QdCfKSggPQoB135iMe/d2DPhvVMm7rH6U17BQndqPplv9grygtm11YYftN/0P0JARFSs
         hMbKFPHQ3woMemiMs6cM958UNgTR2VsgnxM7R6jd58aQOpxEqx2X3rC8jNgVy6898kEl
         uN+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/Cnt58VZhnbwSwijmz21auc9Yvj4p4PpT3m36ds3sv8=;
        b=TPccTSZOavxue/ShZ5Y/DOjYu3cQlLCD1TcP32KW1l/Z/rDNIsYFQZK6WJk9X7GHHK
         1tG6bbg9vhz6SGqtuOO9pVAO8AxyYr1E8jUF5tAIgypUxxmQSanvqneGKCN6yj3JfWjI
         6BTWps0Q6Gzf++NWsW+fPC5G36yzvrGKzrdJchmQpNk0SHDGT018jvVAgZ8QFePmny3C
         rnAsDgvEs6RBZDNE4SlYQf6D/0xyzHvHtdiGcVRYzMdozRVI1MNwjUAlyV/Yz1ECMWsz
         h01dgfvMMH2bLEefwd31pWH8J+wEv6/DPzLSqjYR2t5b8uNakVDnrUdHgbu/48hnvejK
         Mxug==
X-Gm-Message-State: APjAAAWXCTmJhKhtmtevKzbbCZ9Cht0NDOR+nWC2NSk6EjDs+c58zJaN
        b94F5u3tEVp+maaZsVPbac7TAwuh
X-Google-Smtp-Source: APXvYqx1jBOeBmJ+grvlgQb5D6Tzkz3PENoKFpwqzfzsIWiNEJlLF/GnRT+yY6B8gpiIAqVHv+OQ8w==
X-Received: by 2002:a2e:2c07:: with SMTP id s7mr5210551ljs.44.1561705951312;
        Fri, 28 Jun 2019 00:12:31 -0700 (PDT)
Received: from [192.168.2.145] (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.googlemail.com with ESMTPSA id v7sm459505ljj.3.2019.06.28.00.12.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 00:12:30 -0700 (PDT)
Subject: Re: [PATCH v3 02/22] PM / devfreq: tegra30: Keep interrupt disabled
 while governor is stopped
To:     myungjoo.ham@samsung.com,
        Thierry Reding <thierry.reding@gmail.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190627211115.21138-3-digetx@gmail.com>
 <20190627211115.21138-1-digetx@gmail.com>
 <CGME20190627211230epcas5p2504c225e67a823a586768a2749248b72@epcms1p3>
 <20190628064842epcms1p37e66e5fa52885ef7461b439bd336e60f@epcms1p3>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <17fe0599-b36e-31bc-4964-4b7cb77e1d64@gmail.com>
Date:   Fri, 28 Jun 2019 10:12:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190628064842epcms1p37e66e5fa52885ef7461b439bd336e60f@epcms1p3>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

28.06.2019 9:48, MyungJoo Ham пишет:
>> There is no real need to keep interrupt always-enabled, will be nicer
>> to keep it disabled while governor is inactive.
>>
>> Suggested-by: Thierry Reding <thierry.reding@gmail.com>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>> drivers/devfreq/tegra30-devfreq.c | 43 ++++++++++++++++---------------
>> 1 file changed, 22 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
>> index a27300f40b0b..5e2b133babdd 100644
>> --- a/drivers/devfreq/tegra30-devfreq.c
>> +++ b/drivers/devfreq/tegra30-devfreq.c
> []
>> @@ -416,8 +417,6 @@ static void tegra_actmon_start(struct tegra_devfreq *tegra)
>> {
>> 	unsigned int i;
>>
>> -	disable_irq(tegra->irq);
>> -
>> 	actmon_writel(tegra, ACTMON_SAMPLING_PERIOD - 1,
>> 		      ACTMON_GLB_PERIOD_CTRL);
>>
> 
> I think this has nothing to do with
> "keep it disabled while governor is inactive."
> 
> And this looks dangerous because it disables the safety measure
> of disabling interrupt while you touch some looking-critical registers.
> Anyway, as I do not know the internals of Tegra SoC, I cannot sure.

Sorry, I'm not sure what do you mean .. Before this patch we were disabling the
interrupt on a start of programming hardware configuration, now we don't needed to
disable the interrupt because it is already in the disabled state at that moment
since we're now requesting interrupt in the *disabled* state during of the driver's
probe using IRQ_NOAUTOEN flag.
