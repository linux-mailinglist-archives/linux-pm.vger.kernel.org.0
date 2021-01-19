Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43FB52FC400
	for <lists+linux-pm@lfdr.de>; Tue, 19 Jan 2021 23:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbhASWr5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Jan 2021 17:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730492AbhASWnc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jan 2021 17:43:32 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAAE8C0613D3;
        Tue, 19 Jan 2021 14:42:24 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id q12so4412265lfo.12;
        Tue, 19 Jan 2021 14:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4FAVuEzyRp33QgNJC2sLGYQyuO7SkVh4EMA2cmMf8z0=;
        b=UBQUdYzF32jztJAmgtez/FprmJ8X0TXJ0WtSiUSgJpqAKEYXd3uQ2Ec/u9cJZTo9LW
         +4lwmRm6ox96NSq3/zULuyfrDnyK27AsOC1eiw4Njt3TNGhMi14FcaoZCgt1jf0BQprH
         4wUwdf/XEqHAIy0/Civ1NFxaHNOEbAGogqehnAlnfa2ki3N9f/Q6CXwu46MuWimSt1Nk
         3nzBwDSUeSAKram1+nBn4gl88L8vDtM3LPJ/593P7tOsEuKxbjdHqxjXYkK0CGGbNLeL
         Pl5jpaFGEXMFv1wbx8FvfWwoDnIo2xSH9lmWHNP2QbqhYJpXybp71bupzekDrzo/U4AN
         LnSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4FAVuEzyRp33QgNJC2sLGYQyuO7SkVh4EMA2cmMf8z0=;
        b=AuUg0uz9sPVfh2wOAZFBJkxQUqnyHCwHjLhk1qVohVTOfiDOHJNN9Sg2KIhlm61Imu
         5v5TmWT7uxr3XYJPJHlH1RvLVrMfGq8jkxEvVYNMOFxhgAu3YiJW/cTIfOzaSLH7QbZP
         tqlvJBW7fWik/qg/7NQgMZVlKgv+FTV4+jE4coRWx0GTGbOuqfNAqFrha4JYaaZo7Pk3
         dzkTn/dIVUi0aO9XirEfwfvBJei+vht7jmqi9fsMNbn3Hu8hit/u9oMIhlSMwBzfl39Z
         RBbwM531nSuNQqpGUWNb67WsrtgueTLnDLpfvZ/bLzKT2PLcYZTnenkrXn01W28DGHkU
         chrg==
X-Gm-Message-State: AOAM530bMmIYhjsQnMgca80kJdogiBfYV3Ty42ftC9GJRJj1chzdSafE
        z8BYIY1gJfppg6Ru2XVEKlBXk4e/gRE=
X-Google-Smtp-Source: ABdhPJxLpVyjT6uMHVILZtHrMIRn5rj9qHDAfA6ZumXfDZcl1uREg7HzAvGpQcHpB6f0bCmpVKSdjw==
X-Received: by 2002:a19:c3cb:: with SMTP id t194mr2650206lff.599.1611096143107;
        Tue, 19 Jan 2021 14:42:23 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.googlemail.com with ESMTPSA id e9sm15344lfc.253.2021.01.19.14.42.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jan 2021 14:42:22 -0800 (PST)
Subject: Re: [PATCH v3 04/12] opp: Add dev_pm_opp_sync_regulators()
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
 <20210118005524.27787-5-digetx@gmail.com>
 <20210118082013.32y5tndlbw4xrdgc@vireshk-i7>
 <4acde958-91c1-bbcb-6e20-2d90cf0e57d3@gmail.com>
 <20210119045827.2645gk6vabubehuh@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <436f873a-2f79-51f0-31f3-b1f38b406004@gmail.com>
Date:   Wed, 20 Jan 2021 01:42:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20210119045827.2645gk6vabubehuh@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

19.01.2021 07:58, Viresh Kumar пишет:
> On 18-01-21, 21:35, Dmitry Osipenko wrote:
>> 18.01.2021 11:20, Viresh Kumar пишет:
>>>> +int dev_pm_opp_sync_regulators(struct device *dev)
>>>> +{
>>>> +	struct opp_table *opp_table;
>>>> +	struct regulator *reg;
>>>> +	int i, ret = 0;
>>>> +
>>>> +	/* Device may not have OPP table */
>>>> +	opp_table = _find_opp_table(dev);
>>>> +	if (IS_ERR(opp_table))
>>>> +		return 0;
>>>> +
>>>> +	/* Regulator may not be required for the device */
>>>> +	if (!opp_table->regulators)
>>>> +		goto put_table;
>>>> +
>>>> +	mutex_lock(&opp_table->lock);
>>> What exactly do you need this lock for ?
>>
>> It is needed for protecting simultaneous invocations of
>> dev_pm_opp_sync_regulators() and dev_pm_opp_set_voltage().
>>
>> The sync_regulators() should be invoked only after completion of the
>> set_voltage() in a case of Tegra power domain driver since potentially
>> both could be running in parallel. For example device driver may be
>> changing performance state in a work thread, while PM domain state is
>> syncing.
> 
> I think just checking the 'enabled' flag should be enough here (you may need a
> lock for it though, but the lock should cover only the area it is supposed to
> cover and nothing else.

I'll remove the locks from these OPP patches and move them to the PD
driver. It should be the best option right now since OPP API isn't
entirely thread-safe, making it thread-safe should be a separate topic.
