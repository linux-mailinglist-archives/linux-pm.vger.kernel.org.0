Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE97E406AA8
	for <lists+linux-pm@lfdr.de>; Fri, 10 Sep 2021 13:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbhIJLZx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Sep 2021 07:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbhIJLZw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Sep 2021 07:25:52 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D8EC061574;
        Fri, 10 Sep 2021 04:24:41 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id n2so3421958lfk.0;
        Fri, 10 Sep 2021 04:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7Q2C3VPEZNnO5xnYJzISvTVm01xLr2rXMLDDfHFsoAs=;
        b=Iou5pGOOMVLhVgjWS7/IpCpzDkr9QY2Yk0tpPueY5hCuhzBzyPnLaUCufTXPgvrEq+
         I43N7uqiuLQkCZK8eAGO4gLEpsQNM8AtRGC+7DmHnhIgqq9yeqDvaF7eDj0hiQHxgiNV
         R19q3xg0+Qv8ONSYNgrSUJdxrYghOLbb8fibJGpnSsC9IGQhCc1g7VtXiq1QycZP950Z
         xnLSeR5wNAS2TozoL9lpGZX43aDuKM93ZUvYVCbjnK0QdCqqLZTmYGVzZ2B7wpVPrTjU
         2CCtxBvXQb4/l9QMs56JrPN6YJUj1YTNPh14AZ2MALnC6rpc63ZsWaNdAHOve3fGyEpw
         Ujjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7Q2C3VPEZNnO5xnYJzISvTVm01xLr2rXMLDDfHFsoAs=;
        b=2U2ihEI6zuB8VkrNNeKjq5LUAQNdOJ9Eys4xvjIa608zsaAIIYALOYqY9n4B/WUTat
         MaP8OzYoJ+ZZKERQ6LOH8XirmB1FZ+LpC+y3rnrdLzm5y8nJD3F4QVWR1ZBGbbsbx4MK
         bnoJsNEhkn80MQiQ0TqSReKuEeIXo4ZnZvwgA5gtM0guFEK3v2MAymwC5OLgAD8B8wkW
         k+AgOqZJaHqz8kJ9LkRH1yZVvFSA2iHKoGNb7/H/TcfMRUsefvfCxQgCV7Ce2LTR8dBv
         Pcd2TVj+6Mnw8ZBzEaFef66JnmIcLnatPh3b4rF4+wTXtd8kuKVf4VEa7n+PUSdCHVk3
         ltqw==
X-Gm-Message-State: AOAM530e1w6SoJEizyafciVyvGaI/5dQCL+NPPcuKydRqxRttP6psULK
        UL8qSBYUZ8DQa3Qd25zAS7KfG3t1dYE=
X-Google-Smtp-Source: ABdhPJxuSiSvkTN++pGSVMXBYNqvPAMcBOjHOJ69aDa4xEmqRjWTkrIQtYLFDPKSKObVK+FDDcTkYw==
X-Received: by 2002:ac2:4318:: with SMTP id l24mr3612756lfh.145.1631273079832;
        Fri, 10 Sep 2021 04:24:39 -0700 (PDT)
Received: from [192.168.2.145] (46-138-3-129.dynamic.spd-mgts.ru. [46.138.3.129])
        by smtp.googlemail.com with ESMTPSA id j21sm549514ljh.87.2021.09.10.04.24.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Sep 2021 04:24:39 -0700 (PDT)
Subject: Re: [PATCH 3/3] PM: domains: Add a ->dev_get_performance_state()
 callback to genpd
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
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
 <20210902101634.827187-4-ulf.hansson@linaro.org>
 <4e36e732-6ca3-1d00-e6dd-38bb8877577b@gmail.com>
 <CAPDyKFr2oQnKOhKhWt_9VyBoe=HQ7Y0uZUMKTcZ05a7G9RaBYA@mail.gmail.com>
 <1124dae5-478f-f0ca-ea91-b6945f7c9254@gmail.com>
 <CAPDyKFqE+thX0pLTg9d-ds7Tj3hsB78EmDB1Cryh26tN3kvQDA@mail.gmail.com>
 <3d92711f-ce30-2c19-c6a4-bb77d32df2dd@gmail.com>
 <CAPDyKFpJU3g2OzJeR9KUdtN-8wJsDckqVAMQMHBV=enu=DfURg@mail.gmail.com>
 <fbca049a-e673-1598-658f-a7bb5de52f18@gmail.com>
 <CAPDyKFqw2tp3-J8dW03Kqw9xC_gO7nWfEckMvT3=zB0AbR8jeA@mail.gmail.com>
 <1ca9a2d5-e89a-5bbd-2ecc-01f1c4a820ae@gmail.com>
 <CAPDyKFoFCVcjrGXQ56y0iSNPhE8-orpZiHvnAQTQW1b8oW4f5A@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <8dadc395-e7f4-9dcc-b484-60c119063007@gmail.com>
Date:   Fri, 10 Sep 2021 14:24:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFoFCVcjrGXQ56y0iSNPhE8-orpZiHvnAQTQW1b8oW4f5A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

09.09.2021 17:39, Ulf Hansson пишет:
> On Thu, 9 Sept 2021 at 15:48, Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> 07.09.2021 12:57, Ulf Hansson пишет:
>>> I don't mind extending the genpd API, but it needs to serve a good purpose.
>>>
>>> As I said earlier, genpd doesn't know nor can control how the consumer
>>> driver deploys runtime PM. Unfortunately, that also includes genpd
>>> providers, as the behavior isn't a platform or PM domain specific
>>> thing. This means genpd needs to be generic enough so it works for all
>>> cases.
>>>
>>> In the $subject patch, we rely on the pm_runtime_suspended() check in
>>> dev_pm_genpd_set_performance_state(), which should work for all cases,
>>> even if it may be sub-optimal for some scenarios.
>>>
>>> Note that, in the approach your suggested [1],
>>> pm_runtime_status_suspended() is used instead. This doesn't work when
>>> a consumer driver doesn't enable runtime PM - or calls
>>> pm_runtime_set_active() during ->probe(), because
>>> genpd_runtime_resume() won't be invoked to restore the gpd->rpm_state.
>>>
>>> That said, I wouldn't mind to simply skip adding the
>>> ->dev_get_performance_state() all together, if that is what you
>>> prefer? In this way, it becomes the responsibility for the consumer
>>> driver to do right thing, with the cost of some boilerplate code added
>>> in its ->probe() routine.
>>
>> Until a day ago, it wasn't clear to me that consumer drivers now can set
>> up rpm_pstate during probe(), which is a cleaner solution that works
>> well. So let's skip adding the questionable ->dev_get_performance_state().
>>
>> The boilerplate code in the probe() is minimal in comparison to a
>> previous variant with the state-syncing done by rpm-resume callbacks of
>> consumer drivers, it's good enough.
> 
> Alright, that sounds good to me as well.
> 
> I am happy to help with review of the consumer driver changes, just
> keep me posted.

Thank you and Viresh for the help, very appreciate it!
