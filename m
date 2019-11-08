Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 157A8F5BDE
	for <lists+linux-pm@lfdr.de>; Sat,  9 Nov 2019 00:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfKHXiX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Nov 2019 18:38:23 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34821 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfKHXiX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Nov 2019 18:38:23 -0500
Received: by mail-lj1-f193.google.com with SMTP id r7so7949318ljg.2;
        Fri, 08 Nov 2019 15:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7g5vTbYZHmeYxWc2Gp9Pqp9iJ2yMYEuiir3i4U6QyGc=;
        b=g4c+EHEmb/zwM04L6VsDL30KBvGNvRnetX4OgsnUMzeSIvfsNNMpr7R04r1t36mD1g
         9N1m/Zxmz0XL4qs1HL0kX9pb93U58ukQJP0DOpUqVsSj8z+XhQ0K1I3NzRuQSX/Xly41
         m0SRo/ziYu2HH+QVrBiQAj2HXcgyCOQMsbnr/dEg6BqOxBMiHQTxohH10+5PANOlmaoQ
         Tl9TvVkcHRxwnCh3TW0Vnd5nB8sDfxpwqAa9ImpAL8ANI8tsp/axNPL4rQZZ0bogO231
         c8vhCOauNTFoeu/q2r5NsyQNJBMc9U1ywy5Nt+reRVSwvIfee+ONnXutViIQR48cU2HG
         /fDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7g5vTbYZHmeYxWc2Gp9Pqp9iJ2yMYEuiir3i4U6QyGc=;
        b=ayX8AKH753WRo4COxGRoPSlSNmRK3BjEkr4XRNTLPc6m84WeQ1BC9GeRf1YsjHlG2T
         PstL5nTdKcoQMe6BEan/eD0kmvoTEbMj31m4aa1+1/vV+nC0/F74swJFjI26x8irnmFB
         mtIPBuobasgkt9ytlf7mxhFKv8PE0We39DeTfOAzvatPdC1sJK8egKTP+yrMSOkUtPSx
         eQ7chU1YtdHNyRsNpXwLoDYA26mGU7goW7RgmSoFMWkmMZ1ATiFRPD0AyYqdcKG69Zv+
         gJ8IzrCjdFGT5LkaW/7+ThfOz/SLv5GvecC0GI8djMqWEL14E0SLXUJA9SkybWE73HSH
         EsoA==
X-Gm-Message-State: APjAAAVkv0ybh1VoGEKqVOZ4Opj+GuMA/8i7ki6cadCSnRg2TiVa+tYv
        VsHi3A2vaO53964vml/RrXk5UL4s
X-Google-Smtp-Source: APXvYqxaj9XZxFaWcLquzKkYuOY6emBFDT9DQB76RUhm8CVhIxzy0iJ36Ofx4pSQCHKNBl6ONxjr1g==
X-Received: by 2002:a2e:b0f6:: with SMTP id h22mr8250988ljl.171.1573256300397;
        Fri, 08 Nov 2019 15:38:20 -0800 (PST)
Received: from [192.168.2.145] (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.googlemail.com with ESMTPSA id n21sm3053273ljc.67.2019.11.08.15.38.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2019 15:38:19 -0800 (PST)
Subject: Re: [PATCH v9 11/22] clk: tegra: clk-dfll: Add suspend and resume
 support
To:     Stephen Boyd <sboyd@kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        jason@lakedaemon.net, jonathanh@nvidia.com,
        linus.walleij@linaro.org, marc.zyngier@arm.com,
        mark.rutland@arm.com, stefan@agner.ch, tglx@linutronix.de,
        thierry.reding@gmail.com
Cc:     pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        jckuo@nvidia.com, josephl@nvidia.com, talho@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        mperttunen@nvidia.com, spatra@nvidia.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, linux-pm@vger.kernel.org
References: <1565984527-5272-1-git-send-email-skomatineni@nvidia.com>
 <1565984527-5272-12-git-send-email-skomatineni@nvidia.com>
 <20191108212015.07BC720869@mail.kernel.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f644adda-dc6b-9b7e-3fc2-94091a38c99a@gmail.com>
Date:   Sat, 9 Nov 2019 02:38:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191108212015.07BC720869@mail.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

09.11.2019 00:20, Stephen Boyd пишет:
> Quoting Sowjanya Komatineni (2019-08-16 12:41:56)
>> diff --git a/drivers/clk/tegra/clk-dfll.c b/drivers/clk/tegra/clk-dfll.c
>> index f8688c2ddf1a..c051d92c2bbf 100644
>> --- a/drivers/clk/tegra/clk-dfll.c
>> +++ b/drivers/clk/tegra/clk-dfll.c
>> @@ -1487,6 +1487,7 @@ static int dfll_init(struct tegra_dfll *td)
>>         td->last_unrounded_rate = 0;
>>  
>>         pm_runtime_enable(td->dev);
>> +       pm_runtime_irq_safe(td->dev);
> 
> Why irq_safe? It would be good to mention it in the commit text or
> something.

That's a good catch. It was somewhat relevant for some older version of
this patch, but should be irrelevant now.

[snip]
