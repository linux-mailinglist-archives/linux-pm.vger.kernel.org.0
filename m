Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036AF2FA933
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jan 2021 19:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436882AbhARSra (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Jan 2021 13:47:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407652AbhARSrN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jan 2021 13:47:13 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F15C061573;
        Mon, 18 Jan 2021 10:46:33 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id h205so25453089lfd.5;
        Mon, 18 Jan 2021 10:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UidCJzrD1s3AVXDJyUdxsL6wVFlBwRYb0i46sQWrpls=;
        b=L3ZbwSzFxfsTz1EyEfOxok0FLzZ0eRcDto8duBQKohBmqsPb+2T6TMJgrmWNB0oD2o
         NRxjMURON1U1xetQjUJiDc4ZstPB9x4Tu04XYkm2E0vITcVuASkJDuEb2svJIfIAod/b
         zrg0FqPaHb23qLIXOvNLujGv+dlQA26mR5rkBy80BwRInLwoVDcWiws+2DhEo3MnWqTc
         SnkbzAxB3hc+MiEs5HdUhmyRIHpKMjtsww8CMSF3flsLzxKILij59MqbGMSIsXL2HbbO
         jJjq+7NLKnfC+8/aYk7sKqVMmcP4Uc9KfQIZ42UwXCkkMWcvsBoKcYb1dYMPJAdqfc0+
         RG6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UidCJzrD1s3AVXDJyUdxsL6wVFlBwRYb0i46sQWrpls=;
        b=Klf64EA/LtSfHSwZAEDx/uWwRZ0vHbzBDdX1hFVREQlwpph/W2K2eCMK2mYLPOzl4Y
         5sFaXRQ0upRzfbeAzY31pwMHdobdkeQpjSTxexBMqtWMcGOKLY+FXsXS+20cJx3bwOXA
         +uWU3Jk/SM748yvNGq/FeGUnulq92bNkasWyxf0VEm/AmuzWd0lstfFF2QT5pzl4005t
         6bYANG9naZ6SnsKIZpreEK+FtdRtpeqdiYq+r6eb+6Kn+nRI7N5VDyZha1F8CSEF+UeZ
         vHnY2/G+vV1llq6ojtyF84XNYhWBHxvcOg/zD8J2Y6bAPG+cgHb6N8NPBnjZ71UygQp9
         qdHA==
X-Gm-Message-State: AOAM53295zQZy16uMBGHBO2op3OSmiyweO7RqrdZix9+Lg5MlyApm0oJ
        a5kqkTxphdYfUbHzv0QNRc7U0wm3WJc=
X-Google-Smtp-Source: ABdhPJyKl7ievkY1ZBSHBEckLW2JgrnWYAHbBqO6hoWkjId7DSctCw0+7jXcaH+tVtNY9qjfBQAybQ==
X-Received: by 2002:a05:6512:612:: with SMTP id b18mr223180lfe.598.1610995591917;
        Mon, 18 Jan 2021 10:46:31 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.googlemail.com with ESMTPSA id w20sm1988160lfk.67.2021.01.18.10.46.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 10:46:31 -0800 (PST)
Subject: Re: [PATCH v3 01/12] opp: Fix adding OPP entries in a wrong order if
 rate is unavailable
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20210118005524.27787-1-digetx@gmail.com>
 <20210118005524.27787-2-digetx@gmail.com>
 <20210118074416.5mjogew62fjohzlm@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <d91dd85b-c100-140d-ee23-9641caf5dcc7@gmail.com>
Date:   Mon, 18 Jan 2021 21:46:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20210118074416.5mjogew62fjohzlm@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

18.01.2021 10:44, Viresh Kumar пишет:
> On 18-01-21, 03:55, Dmitry Osipenko wrote:
>> Fix adding OPP entries in a wrong (opposite) order if OPP rate is
>> unavailable. The OPP comparison was erroneously skipped, thus OPPs
>> were left unsorted.
>>
>> Tested-by: Peter Geis <pgwipeout@gmail.com>
>> Tested-by: Nicolas Chauvet <kwizart@gmail.com>
>> Tested-by: Matt Merhar <mattmerhar@protonmail.com>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/opp/core.c | 10 ++++------
>>  1 file changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
>> index dfc4208d3f87..48618ff3e99e 100644
>> --- a/drivers/opp/core.c
>> +++ b/drivers/opp/core.c
>> @@ -1527,12 +1527,10 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
>>  	mutex_lock(&opp_table->lock);
>>  	head = &opp_table->opp_list;
>>  
>> -	if (likely(!rate_not_available)) {
>> -		ret = _opp_is_duplicate(dev, new_opp, opp_table, &head);
>> -		if (ret) {
>> -			mutex_unlock(&opp_table->lock);
>> -			return ret;
>> -		}
>> +	ret = _opp_is_duplicate(dev, new_opp, opp_table, &head);
>> +	if (ret) {
>> +		mutex_unlock(&opp_table->lock);
>> +		return ret;
>>  	}
>>  
>>  	list_add(&new_opp->node, head);
> 
> Applied. Thanks.
> 
> I am not sending it for 5.11-rc as there shouldn't be any users which
> are impacted because of this right now, right ?
> 

right
