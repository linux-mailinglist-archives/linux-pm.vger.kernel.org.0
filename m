Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E04953A9530
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jun 2021 10:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbhFPImA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Jun 2021 04:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbhFPImA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jun 2021 04:42:00 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3C4C061574;
        Wed, 16 Jun 2021 01:39:53 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id p7so2978330lfg.4;
        Wed, 16 Jun 2021 01:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6YpVa0+q2Eocwluyky2FGEKu1f+VgEpX5T1fuuU2+uE=;
        b=dJOVRj2ZEWQ7cxt2SkiE47Prb//6AoCzTina/QehwYubPpmPxEMItVLdStvydhXm35
         dJP97otG9TIkarIptGxLacxgLnUp0djzWcu3xBeuK5ehvGlqalZ70F4uMfnGt8HmLnbS
         qncyWVSv75bBpoKNsJ6jojmQdPMNQErj/uHUChHiH1O/YPS5OCizRzCcSjax5zJ/6XfN
         aEzz/LKRtP2Wv3VNzR4n2JP2RcDxP4SY42fpxrb1fqKoMU3O6f47rkkn6dBh0S5vMfUc
         fUhYkVol1TCvOqSHLejUDhVrjsnriBrKoHOn+AZqcF1/jBQjggK/NZC/rvpTkyNgq1/Q
         Ej8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6YpVa0+q2Eocwluyky2FGEKu1f+VgEpX5T1fuuU2+uE=;
        b=jZl9PJBQGf55JH1X3Wu8eMJYwMw1qE9dzcuffpeJKSfX0JA3n0kBiBXXVhIdJALBg9
         a+1IR3UoWieJ/Ks8QWeiyfnCRXARYmls8nx7RHgyVo1PkemIxNKfW3Atcee/OPYLQrUA
         YfmKIsfxa4tWBr51fQLH2dsSQQeWpECFDCIyWKgcPWLd+Xgkblu1+mSBwW6Y3MWJ2RBm
         FiqQLRSEqskUTLbfGw7AFfTNBAsf1qCMoGa71GRUDd5yciqEhdA2e36SmZvPs7PeSiEc
         XeDU7L43AP06M2ZMxReB5foqQ4XGWXzvJIBnAUAJ0L/+Wqun8FbNtPPLsFg5aTlNRAp0
         NzZA==
X-Gm-Message-State: AOAM532K3b70OnFy3hdoOUIkL6tbhW5UcneBUANOHbbMHUNBTwfR7P29
        GJwh5oXB6uU1Ld206W9S7rwbFTCB5gk=
X-Google-Smtp-Source: ABdhPJzTk9wKIGkG7m04OdTwoeo1mFBz4o5KFFJj71YQDsV99L/4sFss0gOpN05WFw8rk1asAksAMA==
X-Received: by 2002:ac2:47eb:: with SMTP id b11mr2938549lfp.455.1623832791520;
        Wed, 16 Jun 2021 01:39:51 -0700 (PDT)
Received: from [192.168.2.145] (94-29-31-25.dynamic.spd-mgts.ru. [94.29.31.25])
        by smtp.googlemail.com with ESMTPSA id k19sm175246lfe.25.2021.06.16.01.39.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 01:39:51 -0700 (PDT)
Subject: Re: [PATCH v3 4/7] thermal/drivers/tegra: Add driver for Tegra30
 thermal sensor
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andreas Westman Dorcsak <hedmoo@yahoo.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Ihor Didenko <tailormoon@rambler.ru>,
        Ion Agorria <ion@agorria.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
References: <20210529170955.32574-1-digetx@gmail.com>
 <20210529170955.32574-5-digetx@gmail.com>
 <6f2b6290-095a-bd39-c160-1616a0ff89b1@linaro.org>
 <20210615102626.dja3agclwzxv2sj4@vireshk-i7>
 <595f5e53-b872-bcc6-e886-ed225e26e9fe@gmail.com>
 <fbdc3b56-4465-6d3e-74db-1d5082813b9c@linaro.org>
 <4c7b23c4-cf6a-0942-5250-63515be4a219@gmail.com>
 <20210616080310.vhvauvo5y6m2sekz@vireshk-i7>
 <CAKfTPtAxvj4_TBpFesjQxcVzvEi3QVUThccfSAJXwwrLtOH-xg@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <96bf59af-20b6-b706-5ff0-fe70f9eba827@gmail.com>
Date:   Wed, 16 Jun 2021 11:39:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtAxvj4_TBpFesjQxcVzvEi3QVUThccfSAJXwwrLtOH-xg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

16.06.2021 11:30, Vincent Guittot пишет:
> On Wed, 16 Jun 2021 at 10:03, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>>
>> +Vincent.
>>
>> On 15-06-21, 22:32, Dmitry Osipenko wrote:
>>> IIUC, the cpufreq already should be prepared for the case where firmware
>>> may override frequency. Viresh, could you please clarify what are the
>>> possible implications of the frequency overriding?
>>
>> The only implication is software would think hardware is running at
>> some other frequency, while it is not. Not sure if something may break
>> as a result of this.
>>
>> The scheduler's view of CPUs will not be same though, i.e. scheduler
>> will see capacity as X, while in reality it has changed to Y.
> 
> thermal_pressure is used by scheduler to balance the load between CPUs
> according to the actual max frequency. If the thermal pressure doesn't
> reflect reality, scheduler will end up enqueuing too many  tasks on a
> throttle CPU.

What if all CPUs are throttled equally and running on the same
frequency, will throttling have any effect on the scheduler decisions?
