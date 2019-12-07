Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD796115ED9
	for <lists+linux-pm@lfdr.de>; Sat,  7 Dec 2019 22:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfLGVwW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 7 Dec 2019 16:52:22 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:15804 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725847AbfLGVwW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 7 Dec 2019 16:52:22 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 47VjmD01Rsz89;
        Sat,  7 Dec 2019 22:49:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1575755388; bh=4v0wpT6dtqU/uUD/0zE8+Yea3Nw5xFqroZs3stOp/QI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TNFH8TRJtUGxCh1QAlDTVjWSaKM0m6227wf5QVKMl/dWZ6HLZrMYz8jFYeawxz5He
         s1mHbWRkuit43M/boUbRaLnKFzF39geVnq7zIjnnEQJXZANvomqJmiVkID/dtgvxHI
         /rOG+uhgdhV2iRWG4zNGK6uqCpflF5KIpHhBeLD9zRghbvDuVnfKo1n7tYj0WsQB9y
         pqL7lunTqjmw9MX7spO987RcHfvom08bGkmb/w00/q7a8n2fAl4HDHHkqB7iGbc6+g
         jjNWcmGIw6Vr3+3BD4+TOx7wHRGqo+yohQM6Zob3iYNvVEAQ2/A98YEto3UEP6V0bi
         pBky2P/UYirHQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.4 at mail
Date:   Sat, 7 Dec 2019 22:52:16 +0100
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 00/19] Consolidate and improve NVIDIA Tegra CPUIDLE
 driver(s)
Message-ID: <20191207215216.GA9561@qmqm.qmqm.pl>
References: <20191203004116.11771-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191203004116.11771-1-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Dec 03, 2019 at 03:40:57AM +0300, Dmitry Osipenko wrote:
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
> and of the Tegra's arch code in general. Please review, thanks!

I did a quick smoke test for this series on top of Linus' master:
 - rebuilding with the patches applied, CONFIG_ARM_TEGRA_CPUIDLE=n - works
 - building with CONFIG_ARM_TEGRA_CPUIDLE=y - doesn't boot

The hang is somewhere early in the boot process, before simplefb can
take the console and show any logs. If I get BOOTFB to work again I might
be able to get some more info.

Best Regards,
Micha³ Miros³aw
