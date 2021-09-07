Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E884A4024E4
	for <lists+linux-pm@lfdr.de>; Tue,  7 Sep 2021 10:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241261AbhIGILV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Sep 2021 04:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240530AbhIGILV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Sep 2021 04:11:21 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3657FC061575;
        Tue,  7 Sep 2021 01:10:15 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id k13so17968058lfv.2;
        Tue, 07 Sep 2021 01:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MDKgUOk2Pvmf4N3Pomrnd43ATp9QvOvkpc8abXhpJGA=;
        b=kzlGW1FVA3CuNStZtvaE20V1sOQa0IYU9cCB4qrfCClNymYG4f7V0eaFYXL8WccOIX
         5K6ne2ETZaHeusrSSzUcjhOfScSUieYysTqg/daw62pJuPHSth/pUbEdZcDv42f0++kc
         YHM221/PDW26cbrUXnuzAobWpOyRJRk53qusfYWtegEZHVK/N/p2IbdOSUBqGcKFB7s3
         /s2is53JMbkv3fyQKmLlxqZj0vcPw1qYoYYWuzgbD5X7lHWf6K4QnwKQz3WBCZmq2oIm
         2RjW0gWGdhSOXsYteG0YTV1mrjfwgMaLi+/JPJafgNxUV10yAO8OANezaK1T1pMmWEtY
         SPVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MDKgUOk2Pvmf4N3Pomrnd43ATp9QvOvkpc8abXhpJGA=;
        b=ImyF3XjiEzljAmmaU5DA+LE+Cen82tK0jkXqZ/saf9u+HU1FBI2VEmo1yec4MCavCn
         Z6uFNQ/KRLwZqq5uor1fojRmaLLWyXap5SuxakxLaCg4VHJJ8fGEKHDDRUDZlyLedpSm
         3L+Beih+5jkpVCa7MBtBbrqEnJFRA997GzNc5/QrSMNepZJ7oV8U+aNXHtZ6Gt4ks3GK
         tCaMiMjk6XYhAnInfZr6DtZdGL8Hxc02Lkd71cKg0M/l/knURo1wGhwVPBl68N/mQYvo
         iPtnG0DD1ewQ8iJo4oxoT7KIQHqBNd6FlV+Qbb1A7pVtg2aLbcrr8BJ5rrWAPr44/yhb
         g12A==
X-Gm-Message-State: AOAM533pJ5+f3A1qLzF1AVlvrbyb+LVsgI4zgfpg7bPSVsTFI2C6XrZm
        lP0jAbLeDhihPrFlrZhcfdB9c+jttwo=
X-Google-Smtp-Source: ABdhPJym3ofWIRZH2bvkuRXPkEnN/luDUmyRz4c1dwHVPc4pNqqXlkbVa5MRAVxwzIf+FTY8oqa25Q==
X-Received: by 2002:ac2:5d45:: with SMTP id w5mr12129021lfd.642.1631002213380;
        Tue, 07 Sep 2021 01:10:13 -0700 (PDT)
Received: from [192.168.2.145] (46-138-3-129.dynamic.spd-mgts.ru. [46.138.3.129])
        by smtp.googlemail.com with ESMTPSA id r7sm1012772lfr.60.2021.09.07.01.10.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 01:10:12 -0700 (PDT)
Subject: Re: [PATCH 3/3] PM: domains: Add a ->dev_get_performance_state()
 callback to genpd
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
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
 <20210907034038.ncx5nas6mhrk4u3r@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <b9b679ab-1214-a4dc-d903-4a8841e397dd@gmail.com>
Date:   Tue, 7 Sep 2021 11:10:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210907034038.ncx5nas6mhrk4u3r@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

07.09.2021 06:40, Viresh Kumar пишет:
> On 06-09-21, 17:35, Dmitry Osipenko wrote:
>> Viresh, are you okay with going back to the variant with the
>> dev_pm_opp_sync() helper?
> 
> I have missed a lot of stuff in between and wasn't following this
> carefully as I thought my half was resolved :)
> 
> Can you describe what to propose to do again ? From what I remember,
> doing this one time from probe() is okay, doing it from
> suspend/resume, not so much.

Hmm.. actually, it's not a problem to set up the performance state from
probe() now with that recent change that was made to the PD core. [1]

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=3c5a272202c28c1f9309566f206ba40787246149

And then we indeed don't need neither the dev_get_performance_state()
callback, nor the dev_pm_opp_sync() helper.

The devm_tegra_core_dev_init_opp_table() already supports performance
state syncing, so I will just need to call it after the RPM setup made
by consumer driver, allowing PD core to set the rpm_pstate. I already
gave it a quick test and it works perfectly.

Ulf, are you okay with abandoning the dev_get_performance_state()
callback? We don't need it anymore.
