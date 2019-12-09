Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5651A11711A
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2019 17:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbfLIQEY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Dec 2019 11:04:24 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:32985 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbfLIQEY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 9 Dec 2019 11:04:24 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 47Wnxn1Xt9zCt;
        Mon,  9 Dec 2019 17:01:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1575907309; bh=0LvlWol9xHFubpsaWwNGCV5DpSsnj71ogNM5fySoWd0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C/5rSNoURlQ3WNB7l/51zLtMCO/c/z6nwsN6Zjx8CzNH2+Nn/uAxrIJX5j5vHYDbP
         H5s7J996Pr+LSbhxOEu8wEzBd8TX1r3aAQzlIjROTt+WtGCI4S8NtDRzXhyc8Cv51D
         8WtgOfvgAXX+3uLrxtrn4tNjxCQ/m5HSvspgwNtPsUoTwWFtMm/aNTBcC+nAQVPKd0
         ADJIC/rF6gfAhBkpLzwB+BU5mPS/sYEEhkYgeAWuClSBjt3J/p1gagazBRATdkuS05
         wrGtP2eFjSipMjvImt/SC3IStUyTSXYN/x/bABWCju/2Q/SQ/dUtMywNa2+CtFMYkG
         QjwX4MnTjR+Iw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.4 at mail
Date:   Mon, 9 Dec 2019 17:04:20 +0100
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
Message-ID: <20191209160420.GA24097@qmqm.qmqm.pl>
References: <20191203004116.11771-1-digetx@gmail.com>
 <20191207215216.GA9561@qmqm.qmqm.pl>
 <0b3a861d-e5e8-ddca-ac60-0a3c61a9d9dc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0b3a861d-e5e8-ddca-ac60-0a3c61a9d9dc@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Dec 08, 2019 at 01:56:14AM +0300, Dmitry Osipenko wrote:
> 08.12.2019 00:52, Michał Mirosław пишет:
> > On Tue, Dec 03, 2019 at 03:40:57AM +0300, Dmitry Osipenko wrote:
> >> Hello,
> >>
> >> This series does the following:
> >>
> >>   1. Unifies Tegra20/30/114 drivers into a single driver and moves it out
> >>      into common drivers/cpuidle/ directory.
> >>
> >>   2. Enables CPU cluster power-down idling state on Tegra30.
> >>
> >> In the end there is a quite nice clean up of the Tegra CPUIDLE drivers
> >> and of the Tegra's arch code in general. Please review, thanks!
> > 
> > I did a quick smoke test for this series on top of Linus' master:
> >  - rebuilding with the patches applied, CONFIG_ARM_TEGRA_CPUIDLE=n - works
> >  - building with CONFIG_ARM_TEGRA_CPUIDLE=y - doesn't boot
> > 
> > The hang is somewhere early in the boot process, before simplefb can
> > take the console and show any logs. If I get BOOTFB to work again I might
> > be able to get some more info.
> 
> Thank you very much for trying these patches!
> 
> Could you please try to make ARM_TEGRA_CPUIDLE "tristate" in the Kconfig
> and compile it as a loadable module? That way you'll get framebuffer
> shown before the hang happens.
> 
> Does LP2 suspend/resume work for you? There should be
> "nvidia,suspend-mode = <2>" in the PMC's node of device-tree.

Not at the moment. I also tried suspend-mode = <1> and <0>, but it
made no difference.

Best Regards,
Michał Mirosław
