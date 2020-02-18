Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C17C1628F5
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2020 15:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgBRO5E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Feb 2020 09:57:04 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45906 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgBRO5E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Feb 2020 09:57:04 -0500
Received: by mail-lj1-f194.google.com with SMTP id e18so23238464ljn.12;
        Tue, 18 Feb 2020 06:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GDudbG3wnHSzToLbMzRev0LydH80cdgIzJuKOmpovTg=;
        b=ZSGc57N2uN7+Gqai5OlHwJu1ACXOyVkoRr1rvba8pVFc5bmb00J8JQ7WAdgeEMRHS9
         +aemE4hxeBOfenkNP+vhZyZipc7GJUjCib23vSDw0SLwlpE+cAafnZ/99dYeTwsF0clH
         Hq+79o1sucatIZCDU4msoX/u6VBffwOkY/sLZtU4VQVfirtTJnHY319sSnWUSmZZhsF3
         0HDK6n8pu70Iko+/8adoert4vGG+qsiTzavcfL4qoh1elnKL4r2tRNkpJ2zx979kxkTA
         wxDLd5SMky6rcwIzMye7Ca5t8GkUf4Vpt5f0CazLrtudPd5XH0fywHxCk9iokLtUOwyV
         NFlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GDudbG3wnHSzToLbMzRev0LydH80cdgIzJuKOmpovTg=;
        b=rk3akuQifZeOyGYsCrF6ENkx3gAv8pfqE9q7uk1t0j8bGuTmJdXcBWzJ69KJL/Iv0C
         i/UuGKfN88dArk3sz6jriP8tiRGu9a2+I0ZrzWlxL8UnpyyOZl+AOkRXLuQK4tKFiEuz
         5tppPzGz/eHjSPy0cMnafLAS7FGO57f6ho0jcyKet0UBjcf7QiRtxP6VSCg+9uEGsCvp
         SxNQqZkBR7a1lSbJFNaY7gK01siWaECltxzsmBhPjHA0TgtFf86F5bxUVNoyv+uyeyco
         eR3sO9eqRkfT68JFeCENdJVXu2XqIWzKPoierps8Rin/fP6zO1AAjpL7cpud07JLLSN3
         xpwA==
X-Gm-Message-State: APjAAAXkgPs5aPPohvkWKrRuwyKk3/nNEoqzLNaOTF0WEKVHVa/W7bsQ
        EYJLoqeY0G9XwsSSQHCJTiW13OaV
X-Google-Smtp-Source: APXvYqyWg68EBq/eMAEuLUaAEgOAUEeryQ1pUZY8jHiCenUNXsboQco05A40bTmyPA2j4AQXK2on9A==
X-Received: by 2002:a05:651c:10f:: with SMTP id a15mr13244771ljb.237.1582037820375;
        Tue, 18 Feb 2020 06:57:00 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id l16sm2400202lfh.74.2020.02.18.06.56.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2020 06:56:57 -0800 (PST)
Subject: Re: [PATCH v9 00/17] Consolidate and improve NVIDIA Tegra CPUIDLE
 driver(s)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Jasper Korten <jja2000@gmail.com>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200212235134.12638-1-digetx@gmail.com>
Message-ID: <234f1d75-d86a-58b4-29d6-c0497498e85c@gmail.com>
Date:   Tue, 18 Feb 2020 17:56:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200212235134.12638-1-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

13.02.2020 02:51, Dmitry Osipenko пишет:
> Hello,
> 
> This series does the following:
> 
>   1. Unifies Tegra20/30/114 drivers into a single driver and moves it out
>      into common drivers/cpuidle/ directory.
> 
>   2. Enables CPU cluster power-down idling state on Tegra30.
> 
> In the end there is a quite nice clean up of the Tegra CPUIDLE drivers
> and of the Tegra's arch code in general. Please apply, thanks!
> 
> !!!WARNING!!! This series was made on top of the cpufreq patches [1]. But it
>               should be fine as long as Thierry Reding would pick up this and
>               the cpufreq patchsets via the Tegra tree, otherwise there will
>               one minor merge-conflict.
> 
> [1] https://patchwork.ozlabs.org/project/linux-tegra/list/?series=158206
...
>   cpuidle: Refactor and move out NVIDIA Tegra20 driver into
>     drivers/cpuidle
>   cpuidle: tegra: Squash Tegra30 driver into the common driver
>   cpuidle: tegra: Squash Tegra114 driver into the common driver
>   cpuidle: tegra: Disable CC6 state if LP2 unavailable

Hello Rafael and Daniel,

Could you please let us know whether you're fine with the above patches
by giving an ACK to them? My understanding is that Thierry can't take
the cpuidle patches through the Tegra tree without yours ACK. Thanks in
advance!
