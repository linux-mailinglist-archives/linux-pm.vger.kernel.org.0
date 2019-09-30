Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7CAC27A3
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2019 23:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfI3VBt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Sep 2019 17:01:49 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43824 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbfI3VBt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Sep 2019 17:01:49 -0400
Received: by mail-lj1-f196.google.com with SMTP id n14so10959622ljj.10;
        Mon, 30 Sep 2019 14:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+LlUNCVWfXSs/i1G07+SdYDQvuWX3zS76QLnciqHfRA=;
        b=vRyGgkPAU1bG3UyZ6cjD178gYt42EnWzSprmI3iz4s6L5bJBGkff8Nos2+7P4ROlN0
         tYFnjWNfx5J93hxMPMotA+rHTqelZhfDqDGolCIPHmqmvu71outUIyESgijLODwynRfO
         rF1/hXrwpHYNoCVrpXw+ICiA8Whj7AVX6a0JCgg6edWofAgpWXd8M+bywtYa9lyYkjPI
         K0iQ8fvLq3WJTZmNimq90wt4MHm9MU3ocSzEoH4Fc7HqqBd87VAC+TVdfEL9YYZ7PenJ
         xS4porvj/gatgHmjKxJA+ygNnBSMW5BrhQeGogAPjdLvB32Fy+tUPaak+F1rGOnF4t6Z
         /Qqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+LlUNCVWfXSs/i1G07+SdYDQvuWX3zS76QLnciqHfRA=;
        b=o+CrJmkXIzEZrfKo/yg7JLjugw4Kfxr1gOYG1ADxQPeyMJBGvMxSs8xQV+oMowqZsg
         3xfOlG0KF0iq/e5YXlzvTZTpZyBBLO2qCobSBpZRvvGTldoctH5rTKbtXY2zfHScNWBM
         +3OSotITC8/gyCiYIpHTO60qQBSYFYsQds6CCfwhHiMoFMStD98yD0x2tTrwAQ5xBptY
         oVICVoZPc8gTEY71CRa+EzW4E+SZf7UffNHpZ3wA05fgfnc92eezbqM1Wsr10xYcJZKo
         FCbnjKoXSATKx0wRYtsNPEqRSOHA2QTS68CB5HX68IIi94ng2FKQeeW76d4bTPc3tYOB
         Ac9A==
X-Gm-Message-State: APjAAAUPlL1X7duy8inuxhxyQD/PHUOBzxrADQikt58bBaOfDrPRF+Jb
        lJ4Pb/EAvRi3SWyb3RHbwgASKBa4
X-Google-Smtp-Source: APXvYqxqT7mVJy85RYmDDuLcpj6hmUPaCwL3lTF73T3SHNq53vxSpU8R+258fLGlXJAt6zSoFGZARw==
X-Received: by 2002:a2e:9093:: with SMTP id l19mr12159777ljg.205.1569868372714;
        Mon, 30 Sep 2019 11:32:52 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-32-67.pppoe.spdop.ru. [94.29.32.67])
        by smtp.googlemail.com with ESMTPSA id f22sm3334897lfa.41.2019.09.30.11.32.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2019 11:32:52 -0700 (PDT)
Subject: Re: [PATCH v5 00/14] Consolidate and improve NVIDIA Tegra CPUIDLE
 driver(s)
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190929175952.22690-1-digetx@gmail.com>
 <20190930082645.GF1518582@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <cf27855a-eb85-1a38-3d04-95e7efe06ebf@gmail.com>
Date:   Mon, 30 Sep 2019 21:32:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20190930082645.GF1518582@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

30.09.2019 11:26, Thierry Reding пишет:
> On Sun, Sep 29, 2019 at 08:59:38PM +0300, Dmitry Osipenko wrote:
>> Hello,
>>
>> This series does the following:
>>
>>   1. Unifies Tegra20/30/114 drivers into a single driver and moves it out
>>      into common drivers/cpuidle/ directory.
>>
>>   2. Enables CPU cluster power-down idling state on Tegra30.
>>
>> In the end there is a quite nice clean up of the Tegra CPUIDLE drivers
>> and of the Tegra's arch code in general. Please review, thanks!
> 
> I generally like this series and it looks really good from a diffstat
> point of view. However, removing existing drivers completely and then
> incrementally add a new one make this impossible to review.
> 
> If you think about it, it also makes it really difficult to find what
> went wrong if at any point in the future we find a regression caused by
> the new driver. A bisection will always point at the commit that removes
> the old driver because between that and the point where you add the new
> driver, CPU idle just doesn't work at all anymore.
> 
> While I understand that it's very convenient to just throw away old code
> and rewrite it from scratch, it's also impractical (and a little rude).
> It's not how we do things in the kernel. Unless maybe under specific
> circumstances.
> 
> Can you please try and make this a little more iterative? At the very
> least I'd expect a series where you do all the preliminary work in
> preparatory patches and then replace the old driver by the new driver in
> a single patch. That way at least there will be an unambiguous commit in
> a bisection.
> 
> Ideally, you'd also break up that last conversion patch into smaller
> incremental patches to make it easier for people to review. Remember
> that your chances to attract reviewers increases if you make the patches
> easy to review, which means your patches should be small, logical
> changes that (ideally) are obviously correct.

Thanks for the detailed explanation, probably this is the same what Jon
was asking to do. Now I see what you're are asking for.
