Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12F99168447
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2020 17:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgBUQ7U (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Feb 2020 11:59:20 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46571 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgBUQ7T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Feb 2020 11:59:19 -0500
Received: by mail-lf1-f67.google.com with SMTP id z26so1979507lfg.13;
        Fri, 21 Feb 2020 08:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uq96kUEsWfYbvUxWEC2QduQgNXK5ZAsIelUdjavWLZE=;
        b=Trc5vVTNIIUdO5777n+DDZZFPOCaDtX2J0yVmw1PBn55PKo1lxdCpMHMWC4MT+kn/X
         m180fK88XxAUUxrTIQjwAIrS89gdyGhVJKYHAX+Bo7DpL40TnymtryIsGzTpgHpJ5HWL
         2b8McZBvTNX3qTUYIk7plnmkaPrhFFSoMBpL5u4VOJ2YDuGyfQfLQDQz3ZhcT5iD4CMH
         ee1LTalzEukyhI5K1EfCigtMB59Ns83DFLdNyLDT4nzwLNp6HtrJ11dP4tQoo+BDh+Xp
         gn+lbUO6sOazYkP00QUAfKKpixVeDr5FfSaK61Krs9OcKfxovUkU8F/HSz/HgqE+kGuF
         ppYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uq96kUEsWfYbvUxWEC2QduQgNXK5ZAsIelUdjavWLZE=;
        b=LnJKc5Uu1rp56YZqPX7OfTWTLq7jEYxtovOC/rROPDsm9vf3Lg6/hu1vIHLToaszZW
         OEwHX31u9JsM9zC1Yf+ygghSIMs2ZDvNY3EIqTQl5M9Nd4Ic3nupE5Nlb/zhJN3XbndG
         /CBQ03dmi5KJXs12xzCEfPDAGTBq7Q7S71CxmQ82h7bqg6rr76bJC3jAXyU+8CIqAtH7
         BXJSoRTEJHryurNbsyGgDhVtK5Bv/3oIRH+9sHVxlt8KdF1pqRBXegLgXy4p4JyqGZ5p
         wDJ0Fj0oCC3DVkgiP/vtR2eA6AWl55qRQz+TKfQ4d6B9g+qM1G18ZHYN8LhvnWO6WnSP
         Zaug==
X-Gm-Message-State: APjAAAWGFNZsUtdH94NE/yU849ApZYGi2tlxDjpJPN0YZUywsuBtGttJ
        Zw6Dt8KV2Pj9+3ZhAwp63H5YL161
X-Google-Smtp-Source: APXvYqxJjtRWwMCfKgJMlKcIbAXtp7+cc4z6WxGQfgwI0cBSDpMQx5gAT4CgbtkLwQGCO0XhloX2WA==
X-Received: by 2002:a19:f00d:: with SMTP id p13mr20259778lfc.37.1582304355723;
        Fri, 21 Feb 2020 08:59:15 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id e30sm1952109ljp.24.2020.02.21.08.59.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 08:59:15 -0800 (PST)
Subject: Re: [PATCH v9 13/17] cpuidle: tegra: Squash Tegra30 driver into the
 common driver
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Jasper Korten <jja2000@gmail.com>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200212235134.12638-1-digetx@gmail.com>
 <20200212235134.12638-14-digetx@gmail.com>
 <20200221162951.GQ10516@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <89a9838c-faf3-b890-cea2-aad53df1eac3@gmail.com>
Date:   Fri, 21 Feb 2020 19:59:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200221162951.GQ10516@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

21.02.2020 19:29, Daniel Lezcano пишет:
> On Thu, Feb 13, 2020 at 02:51:30AM +0300, Dmitry Osipenko wrote:
>> Tegra20 and Terga30 SoCs have common C1 and CC6 idling states and thus
>> share the same code paths, there is no point in having separate drivers
>> for a similar hardware. This patch merely moves functionality of the old
>> driver into the new, although the CC6 state is kept disabled for now since
>> old driver had a rudimentary support for this state (allowing to enter
>> into CC6 only when secondary CPUs are put offline), while new driver can
>> provide a full-featured support. The new feature will be enabled by
>> another patch.
>>
>> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
>> Tested-by: Peter Geis <pgwipeout@gmail.com>
>> Tested-by: Jasper Korten <jja2000@gmail.com>
>> Tested-by: David Heidelberg <david@ixit.cz>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  arch/arm/mach-tegra/Makefile          |   3 -
>>  arch/arm/mach-tegra/cpuidle-tegra30.c | 123 --------------------------
> 
> Add the -M option when resending please.

Okay, thank you very much for taking a look at the patches!
