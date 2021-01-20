Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED9672FCC3C
	for <lists+linux-pm@lfdr.de>; Wed, 20 Jan 2021 09:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbhATIBr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Jan 2021 03:01:47 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47]:52069 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730253AbhATH7s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2021 02:59:48 -0500
Received: by mail-wm1-f47.google.com with SMTP id m2so1978310wmm.1;
        Tue, 19 Jan 2021 23:59:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=T2Nxi0UAJrvG7QfcIV+5/q/cjGRwozwlTwF0B5esfbc=;
        b=Rfr2tI195C+boZT9fQBqJ/SkWxEylbagQ8XfbghIfSK6lC16evvJ8H//QRRdSuXIkb
         RwAwQ4RQ1advODC4OZM90ymrHvEPB1N1NH/8fsh0m/qNdOf5gF3xyqcdm0JycVtoE+UN
         s0auMgSFokXdNjhNrQ7QXjlm9q8A4bo67BTYKnNQEz/C2doNdUuEffjsmOFsQ/wH69ry
         fZp9qiOQwZqzWxKjGt8y686MAMpQi6vCk/IM0L0fxrVYVbDFQamh9utVKqtwwEbQepxL
         9rhh5eePqZHDWEEoe3d8Abf/PfD0NfxQTAM7AQmxoozSeywnIgSBeHpsV/ybbNObpvfl
         oYvA==
X-Gm-Message-State: AOAM532mI6JKtS3lgk5Xm1XFStCHNeItyt7+UTBAk5rcTyrpcmIpL86R
        8azMTU28o+4BPZ47uyjlONs=
X-Google-Smtp-Source: ABdhPJwuoZx+7uPQvYpmVvSuwJYlxmIyZp4gj80Fm1xV/LqPgvhq9RJ1+mS9bs4zh22yQ0TDjyuX6g==
X-Received: by 2002:a05:600c:2601:: with SMTP id h1mr3086639wma.31.1611129545414;
        Tue, 19 Jan 2021 23:59:05 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id l8sm2355643wmi.8.2021.01.19.23.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 23:59:04 -0800 (PST)
Date:   Wed, 20 Jan 2021 08:59:02 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mark Brown <broonie@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [BUG] NULL pointer in dev_pm_opp_put_regulators
Message-ID: <20210120075902.lfz6cw4jgqg6e7c3@kozik-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

Today's next fails to boot on Exynos5422 Odroid HC1 board:

[    6.409023] Unable to handle kernel NULL pointer dereference at virtual address 00000004
[    6.417199] pgd = (ptrval)
[    6.419748] [00000004] *pgd=00000000
[    6.423499] Internal error: Oops: 805 [#1] PREEMPT SMP ARM
[    6.428724] Modules linked in:
[    6.431752] CPU: 5 PID: 1 Comm: swapper/0 Not tainted 5.11.0-rc4-next-20210120 #2
[    6.439209] Hardware name: Samsung Exynos (Flattened Device Tree)
[    6.445273] PC is at dev_pm_opp_put_regulators+0xb4/0x114
...
[    6.680370] [<c086f51c>] (dev_pm_opp_put_regulators) from [<c08d5d48>] (exynos_bus_probe+0x45c/0x620)
[    6.689556] [<c08d5d48>] (exynos_bus_probe) from [<c06b49a8>] (platform_probe+0x80/0xc0)
[    6.697614] [<c06b49a8>] (platform_probe) from [<c06b1ab4>] (really_probe+0x1d4/0x500)
[    6.705499] [<c06b1ab4>] (really_probe) from [<c06b1e58>] (driver_probe_device+0x78/0x1dc)
[    6.713731] [<c06b1e58>] (driver_probe_device) from [<c06b236c>] (device_driver_attach+0x58/0x60)
[    6.722571] [<c06b236c>] (device_driver_attach) from [<c06b2470>] (__driver_attach+0xfc/0x160)
[    6.731149] [<c06b2470>] (__driver_attach) from [<c06af85c>] (bus_for_each_dev+0x68/0xb4)
[    6.739294] [<c06af85c>] (bus_for_each_dev) from [<c06b0b5c>] (bus_add_driver+0x158/0x214)
[    6.747526] [<c06b0b5c>] (bus_add_driver) from [<c06b3314>] (driver_register+0x78/0x110)
[    6.755585] [<c06b3314>] (driver_register) from [<c0102464>] (do_one_initcall+0x8c/0x430)
[    6.763731] [<c0102464>] (do_one_initcall) from [<c11010e4>] (kernel_init_freeable+0x190/0x1e0)
[    6.772397] [<c11010e4>] (kernel_init_freeable) from [<c0b4fc50>] (kernel_init+0x8/0x120)
[    6.780542] [<c0b4fc50>] (kernel_init) from [<c010011c>] (ret_from_fork+0x14/0x38)

https://krzk.eu/#/builders/21/builds/2862/steps/15/logs/serial0

I did not do a bisect but the last commit touching these parts was:

commit 302c014726dbd9fcde852985528c139d2214a1f2
Author: Viresh Kumar <viresh.kumar@linaro.org>
Date:   Tue Jan 19 11:58:58 2021 +0530
    opp: Prepare for ->set_opp() helper to work without regulators

Maybe you have some idea of cause?

Best regards,
Krzysztof

