Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 994A8421202
	for <lists+linux-pm@lfdr.de>; Mon,  4 Oct 2021 16:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235263AbhJDOyU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Oct 2021 10:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234608AbhJDOyU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Oct 2021 10:54:20 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB84C061745;
        Mon,  4 Oct 2021 07:52:30 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id g41so72554547lfv.1;
        Mon, 04 Oct 2021 07:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3phcTPmmne5oWPfHHNM2zgWcHv4rbonA7DOAOPhJ5+Q=;
        b=S6KZZQ4OKRk+CihDXceBJafSWwTtvJA/b0eahwh45+vXPUSti4gpobvgydFh7//HKR
         bHZYgOIARb6yzp2ndAGd4xgWIVANvVsAaZ6l8xTe+umZAexjDlS4iMweQqwbJ7WPSDfw
         jxxxDQmt1Ld6tyPpmpyHKnURpdIiMaOQbT+zvyo+MVvlnphe9BhexhO/2ptNB02GAh0C
         Mj93v0HJTxQhd2PZAtJnOjhS+IMRHsFeCbjb0uzz+ebDyOICmTiOqQoe1xuMuiuXhIZE
         rZ7+Re/UDIFz4bOGWxYy/+ph21stcBl0KpiA4ZD9rd4V/CmnT+DtECDyj8qg8CMX9D4o
         pfYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3phcTPmmne5oWPfHHNM2zgWcHv4rbonA7DOAOPhJ5+Q=;
        b=J3PFhGJO91KKpGfcLlS+wan3Xf2g8kqcI7ednvGa0Ux9PimNRSvc0/aC9XG5OlIk0L
         mYYSX7BujSjaBZLr+EwjPqR+uocAXl7fLo/P+tY4LUyISD9arxE2w747Jfkdm5p4RuQG
         pj8iw/JGizOAMJ1+6dBPPyM3A5Lh/EtS3oA+ruLlcwhNJ239fihtMsAgwLGejlwoMZS8
         xqPw/HFCx95Ocn0cx4yB1k09P7Pm9Pg1TrCuMakcGVTSJE4tKDZCK/fsSEysKwP/vP/1
         C3wnP0JRMHC58nlrLwFV7uQJ7AkByGJ1JW8a4LLUnGrS7lNB53nk/rmf4PLPrFcyB6k8
         N2EQ==
X-Gm-Message-State: AOAM530P6bYJw5sFC+jyfmYB5fUJVkdAW6L5lagQ+U45IhhSfvy6Sw4Z
        pGbhwWnpAFgpql1zzqddHAG2IpCIms0=
X-Google-Smtp-Source: ABdhPJxJpmy8a+mVhYmdvRrlXdglRvcdSBNqjpP3t6NqDRU1XQpmZY9mEwGOjJLUohJeDd6Z48BElw==
X-Received: by 2002:ac2:5101:: with SMTP id q1mr14839952lfb.284.1633359148605;
        Mon, 04 Oct 2021 07:52:28 -0700 (PDT)
Received: from [192.168.2.145] (79-139-163-57.dynamic.spd-mgts.ru. [79.139.163.57])
        by smtp.googlemail.com with ESMTPSA id a21sm623518ljd.38.2021.10.04.07.52.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Oct 2021 07:52:28 -0700 (PDT)
Subject: Re: [PATCH v2 1/4] opp: Add more resource-managed variants of
 dev_pm_opp_of_add_table()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20210920172249.28206-1-digetx@gmail.com>
 <20210920172249.28206-2-digetx@gmail.com>
 <20211004110421.agep6hxoa6qo7wy2@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <4d1b8e24-ce85-aa2d-5720-d6e91cfb157b@gmail.com>
Date:   Mon, 4 Oct 2021 17:52:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211004110421.agep6hxoa6qo7wy2@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

04.10.2021 14:04, Viresh Kumar пишет:
> On 20-09-21, 20:22, Dmitry Osipenko wrote:
>> Add resource-managed variants of dev_pm_opp_of_add_table_indexed() and
>> dev_pm_opp_of_add_table_noclk(), allowing drivers to remove boilerplate
>> code.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/opp/of.c       | 46 +++++++++++++++++++++++++++++++++++-------
>>  include/linux/pm_opp.h | 12 +++++++++++
>>  2 files changed, 51 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
>> index 2a97c6535c4c..bd01ecb1d85c 100644
>> --- a/drivers/opp/of.c
>> +++ b/drivers/opp/of.c
>> @@ -1081,6 +1081,17 @@ static void devm_pm_opp_of_table_release(void *data)
>>  	dev_pm_opp_of_remove_table(data);
>>  }
>>  
>> +static int devm_of_add_table_indexed(struct device *dev, int index, bool getclk)
> 
> Made this _devm_of_add_table_indexed() and applied this patch. Thanks.
> 
> What about rest of the series ?
> 

I assume you should take it all via the OPP tree since Chanwoo gave the
acks, otherwise immutable branch is needed from you.
