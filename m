Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53F2416ABDF
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2020 17:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbgBXQoZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Feb 2020 11:44:25 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43309 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbgBXQoZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Feb 2020 11:44:25 -0500
Received: by mail-lj1-f194.google.com with SMTP id a13so10831595ljm.10;
        Mon, 24 Feb 2020 08:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7oxyU+d/d8XY0EKKPhE8sqzYMShwxJo5/S8/lQ/V5N0=;
        b=vREfHiAcCl3Ua/9aE0F/R/DCXJsDhkt0GbZfVzmifGktCU/jwX2OqEQRiUQWx3y3aF
         R3IesHPQ3nOz7dDnpYasa3b4xh5RtIQsMSR4AK0GKulOtxBtHOK+0IRp6+xXQl8DekSq
         K7tRl7rkDu028QqORiYJcRNvv2jq/VGc3ExSi15VSd+Wg9vxIzstLU2PFTiSoSV8eTzg
         SkEPVpnDoVfVzonqwuHAXoRCS/oUd4B8SPQwlhrvid4M7DNht8bAYCbUyt+TBbPeLKLx
         +++tSCVLRiSQL0rcKLslEKovzIObrtQ3r/q5ZtS9NjvLAD6ZqaVhvBHEXHfD8N9s0Kce
         5wng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7oxyU+d/d8XY0EKKPhE8sqzYMShwxJo5/S8/lQ/V5N0=;
        b=O+8r7xIRw3b6usH0GlnWAbXBTf79Ou95rUbxYMU0N0r1mRTed253izpGPYzy16Ctll
         iwQunVILyqqgdWWVIEt//FBjO+jHgmrEGLYSKiUS9CBqSXu3QanRP/t+thPGCjzipBbV
         Iro/MwgBw2FFX4n27J/7s2y4xSj+5Er5LUI+xf+9W2iQ8rEHUeTB74Rg4xRTjAt3hiCy
         Xyd9ecZ1cKdMl55sczdhCLegiUpOiyenu926+XTm0sJKezwB3M0kzZDY9jZylenMlZIe
         iNG1V7GoeuorEu0xPpiLQ+uM77Uhlal3VWpk2vR3YcMFPujjzlrHt2ftrUlNlsUoHUTD
         adCg==
X-Gm-Message-State: APjAAAVEdqwp9DBL3ciL4yvgL3STQQTT2SNIMJMDjY2m4yxf8UwG07oF
        mfHYtTS+AdyklvZ7uFllR+rUGHbG
X-Google-Smtp-Source: APXvYqxbXa1nMc8dn3aaTyS28EGQspo1Xxm3d/K1Vcn3KJ/wuGB59VnWqLqhQ7TXq1K/B/jcc3gHkQ==
X-Received: by 2002:a05:651c:321:: with SMTP id b1mr31007810ljp.62.1582562661509;
        Mon, 24 Feb 2020 08:44:21 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id e8sm7884285ljb.45.2020.02.24.08.44.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2020 08:44:20 -0800 (PST)
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
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200212235134.12638-1-digetx@gmail.com>
Message-ID: <6fc959d6-8602-5ab0-d624-b410827005cf@gmail.com>
Date:   Mon, 24 Feb 2020 19:44:19 +0300
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
> 
>     - Temporarily dropped the "cpuidle: tegra: Support CPU cluster power-down
>       state on Tegra30" patch because Michał Mirosław reported that it didn't
>       work well on his TF300T. After some testing we found that changing
>       a way in which firmware performs L2 cache maintenance helps, but later
>       on we also found that the current v9 series works just fine without the
>       extra firmware changes using recent linux-next and the reason why v8
>       didn't work before is still unknown (need more testing). So I decided
>       that it will be better to postpone the dropped patch until we know for
>       sure that it works well for everyone in every possible configuration.
> 
>     - Rebased this series on top of recent linux-next, in a result dropped
>       the "cpuidle: Avoid NULL dereference in cpuidle_driver_state_disabled()"
>       patch because it's not needed anymore.

I just noticed that this patchset was versioned wrongly, it should've
been v10. Sorry for the confusion, next version will be v11.
