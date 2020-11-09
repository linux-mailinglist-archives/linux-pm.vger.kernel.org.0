Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 922102AB0CB
	for <lists+linux-pm@lfdr.de>; Mon,  9 Nov 2020 06:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbgKIF3y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Nov 2020 00:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgKIF3y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Nov 2020 00:29:54 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A2DC0613CF;
        Sun,  8 Nov 2020 21:29:53 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id v144so10626067lfa.13;
        Sun, 08 Nov 2020 21:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Rub6A86a0+TidKGgBoC2PFnme8lun0CVqmJ7J6T6EZQ=;
        b=lOUMHcG5m2tMEm+526TpHbvBV9zUKuKVrYtjEntSyVPCHGP7QSox/NpzyJtSlbLYF/
         y2l6Qngqr/slp1nSBLBsiBNl0hw8Z5oHgFvHI195tO6HGfIRiyP8PwR8m+8tND5Btk74
         ETK390CCylvgmqHDYIbEy9tK15Qsn+bQbOCp7BAs4rsib0E18fSdaiKlVFLmhqVb/0tv
         85sV7ulW/FA8+Uo+1tvOhb916bROcd27At9mtPawLLauDoWhBDHcxCcAFtXUi7LwhVby
         r9wIMJQhjztQm+oJIgfwCzA0meqCl+jSQgdj9pmDLfEv1GsYIhaIUN/2VvupygqLCNLB
         ur7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Rub6A86a0+TidKGgBoC2PFnme8lun0CVqmJ7J6T6EZQ=;
        b=K6oC2t56iJ8e8cDCY3VhQ93LMCDnmCdYW4vU+R1BXqY/lS0p6419HfxmlEOFARAR+8
         94DcrPhfHdoshYII5yayG0cj0CAZTX16NmT0mh9/3dce4F9yppyfQBSw0aTKO3sXzGBC
         feYbaWHfNoExRLtCjarctmqD3f9RqJ6QRWLypDaGUnhFT79bKcXeUZrdmev0ehzNY/oe
         dLKR6OiqOpF1iBEF3fwEJRuvRgeDyFcZPov2iFWCtZPeuBRp6mp0px42a+QlVFyu7Uag
         md0K4GVxPlnx6/uzJtg/9eHJlnjd328CMLzFlhGlDh2/TKFYvCDe9X1Bx4CmcFH8rI6G
         gYTw==
X-Gm-Message-State: AOAM533h6b7XxSIUHC2HjOCkb+1Lv568+5pd8LYTZa9TS7FoVZ646oVZ
        aBPbo6UcdSFtx8sIPy+jTPhxULtIzO4=
X-Google-Smtp-Source: ABdhPJyzg4zY7FpKZt6Zpyuu5gjleO0eds+qOHEpyxpD93RF8dgVewYfzmKsVjY21/Kpaq0doH/vcQ==
X-Received: by 2002:a05:6512:31d5:: with SMTP id j21mr4525808lfe.488.1604899791728;
        Sun, 08 Nov 2020 21:29:51 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.googlemail.com with ESMTPSA id r66sm835570lff.265.2020.11.08.21.29.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Nov 2020 21:29:51 -0800 (PST)
Subject: Re: [PATCH 2/2] opp: Don't create an OPP table from
 dev_pm_opp_get_opp_table()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
References: <684ff01900180c0a40ec307dacc673b24eab593b.1604643714.git.viresh.kumar@linaro.org>
 <1012a98950355bd5a52424668050a17c3430cbe0.1604643714.git.viresh.kumar@linaro.org>
 <ec9839dd-5d2d-0d6b-6563-b14da4af1a57@gmail.com>
 <20201109043457.xf55kufhjjz2fvct@vireshk-i7>
 <c5078503-ee14-0f84-85fd-9c6e55d2e897@gmail.com>
 <20201109045740.y5kpd6tjscoqxhi5@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <7a0a904d-8ee2-d1d6-509c-950bb408e0c5@gmail.com>
Date:   Mon, 9 Nov 2020 08:29:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201109045740.y5kpd6tjscoqxhi5@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

09.11.2020 07:57, Viresh Kumar пишет:
> On 09-11-20, 07:41, Dmitry Osipenko wrote:
>> 09.11.2020 07:34, Viresh Kumar пишет:
>>> On 06-11-20, 16:18, Dmitry Osipenko wrote:
>>>> 06.11.2020 09:24, Viresh Kumar пишет:
>>>>> It has been found that some users (like cpufreq-dt and others on LKML)
>>>>> have abused the helper dev_pm_opp_get_opp_table() to create the OPP
>>>>> table instead of just finding it, which is the wrong thing to do. This
>>>>> routine was meant for OPP core's internal working and exposed the whole
>>>>> functionality by mistake.
>>>>>
>>>>> Change the scope of dev_pm_opp_get_opp_table() to only finding the
>>>>> table. The internal helpers _opp_get_opp_table*() are thus renamed to
>>>>> _add_opp_table*(), dev_pm_opp_get_opp_table_indexed() is removed (as we
>>>>> don't need the index field for finding the OPP table) and so the only
>>>>> user, genpd, is updated.
>>>>>
>>>>> Note that the prototype of _add_opp_table() was already left in opp.h by
>>>>> mistake when it was removed earlier and so we weren't required to add it
>>>>> now.
>>>>
>>>> Hello Viresh,
>>>>
>>>> It looks like this is not an entirely correct change because previously
>>>> it was possible to get an empty opp_table in order to use it for the
>>>> dev_pm_opp_set_rate(), which would fall back to clk_set_rate if table is
>>>> empty.
>>>>
>>>> Now it's not possible to get an empty table and
>>>> dev_pm_opp_of_add_table() would error out if OPPs are missing in a
>>>> device-tree. Hence it's not possible to implement a fall back without
>>>> abusing opp_set_regulators() or opp_set_supported_hw() for getting the
>>>> empty table. Or am I missing something?
>>>
>>> For that case you were always required to call
>>> dev_pm_opp_set_clkname(), otherwise how would the OPP core know which
>>> clock to set ? And the same shall work now as well.
>>
>> Why _allocate_opp_table() grabs the first default clk of a device and
>> assigns it to the created table?
> 
> Right, it was there so everybody isn't required to call
> dev_pm_opp_set_clkname() if they don't need to pass a connection id
> while getting the clock. But for the case of supporting empty OPP
> tables for cases where we just want dev_pm_opp_set_rate() to act as
> clk_set_rate() (in order for the drivers to avoid supporting two
> different ways of doing so), we do need that call to be made.
> 
> We need to add the OPP table explicitly and what happened with
> dev_pm_opp_get_opp_table() was accidental and not what I wanted.
> 
> drivers/mmc/host/sdhci-msm.c has an example of how this is done.
> 

Alright, thank you for the clarification.
