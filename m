Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8C7A15B5F4
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 01:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbgBMAiS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 19:38:18 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42937 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729190AbgBMAiS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Feb 2020 19:38:18 -0500
Received: by mail-lf1-f67.google.com with SMTP id y19so2923640lfl.9;
        Wed, 12 Feb 2020 16:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6VRuFj0c+RR5xGzAmKGNr9wl5GP6aspxRb/bDjcgieY=;
        b=f5gjSkstyjpmmV0lR8bqdecWRblXCrc8SK+pqqiIvk4L8waZccX8O8Y2eXLGk1BipN
         /8F0C5FiwVi3ioV0P7WogpfxpTPsL+rGSwXur6oI0ZP7Mo9BW8ybW25/31MXeFO5RLJK
         B/SdA5qd8e91eeIO75Pd70nqGWpmeqFzAudoND0ASAW2UCNaCQjIsRz/Yryr8KcD87ez
         BfpvIeo58sbR5q4fqd2VMAAAyvL7pqDsdrxhbtNhYNyK74SEFzdC+a13iFpTIyWOEAVX
         5Fc08Scru4ZzRuysCghFScaiH0R2QIUvUJiqeiebsGnQhs5LtGXwL4KQbVIDVBe0VGb7
         La+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6VRuFj0c+RR5xGzAmKGNr9wl5GP6aspxRb/bDjcgieY=;
        b=h+sseUF7MJxQZGlHEgGNnpgV5n0Nny9muBtF1yXHLCEPnZj7EFexp9koI1V7Oe/kkN
         Iw/zHjncIz4HF17l2xtG6vffEZHZzMCeUEhUFnJzJPJE93CuBMVNXpb/bzQLlyhesqmZ
         /7C2qxJjNo4AqHJTHYKU2kdOj4zjcHQZm4nG34kilhxPT7udBrYkIN6q5a96jft61nPb
         70FHx5jdQUt5+BHGBxkc7O+dWgZAF1D7/cGpFUN0vq2/SMwf15kpzQZbNXGNlfAMu0C6
         YhBXgOCd3jNQ8JeDoQEv5fNwianUE2576/UR/QmHJ1qoEEvD+i0CDvwSWNFABm8IwX5R
         UTQA==
X-Gm-Message-State: APjAAAV/bu+mNx2CK3MkwDYFh98ukthsAMqFtZBCvSydgoN/KxtbMoF7
        jEYRrOhMGblBb2O/xwIr3SXYwOLd
X-Google-Smtp-Source: APXvYqyU2LIzu076BOgfOGAG4BemY1o4JaSFhiUPuO8enMLHjXtwsBkhKTntzqtE6LCiWewr6uPTRQ==
X-Received: by 2002:a19:4208:: with SMTP id p8mr7938370lfa.160.1581554295984;
        Wed, 12 Feb 2020 16:38:15 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id b17sm287671lfp.15.2020.02.12.16.38.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 16:38:15 -0800 (PST)
Subject: Re: [PATCH v9 00/17] Consolidate and improve NVIDIA Tegra CPUIDLE
 driver(s)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Jasper Korten <jja2000@gmail.com>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200212235134.12638-1-digetx@gmail.com>
Message-ID: <0a62d941-ddf7-4c9f-3897-2209eab994cf@gmail.com>
Date:   Thu, 13 Feb 2020 03:38:13 +0300
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
> 
> Changelog:
> 
> v9: - Added acks from Peter De Schrijver.
> 
>     - Added tested-by from Peter Geis, Jasper Korten and David Heidelberg
>       who tested these patches on Ouya, TF300T and Nexus 7 devices.

I forgot to mention that both cpufreq and cpuidle patchsets were also
tested on AC100 by Nicolas Chauvet and I forgot to ask for the explicit
t-b. Nicolas, thank you very much for all the testing of the
grate-kernel! Please feel free to give yours t-b :)

>     - Temporarily dropped the "cpuidle: tegra: Support CPU cluster power-down
>       state on Tegra30" patch because Michał Mirosław reported that it didn't
>       work well on his TF300T. After some testing we found that changing
>       a way in which firmware performs L2 cache maintenance helps, but later
>       on we also found that the current v9 series works just fine without the
>       extra firmware changes using recent linux-next and the reason why v8
>       didn't work before is still unknown (need more testing). So I decided
>       that it will be better to postpone the dropped patch until we know for
>       sure that it works well for everyone in every possible configuration.

Michał, please let me know if you'll spot any problems with the recent
version of the patches and please feel free to give yours t-b if it
works well.
