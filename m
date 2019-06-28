Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32B655981B
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2019 12:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfF1KEC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Jun 2019 06:04:02 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38919 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbfF1KEC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Jun 2019 06:04:02 -0400
Received: by mail-oi1-f194.google.com with SMTP id m202so3853860oig.6;
        Fri, 28 Jun 2019 03:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PjQC+nbGLBJHldZkauJZuTd8Y9cEQW4N5aCR2WAPqM0=;
        b=s1THxaTHWUvDKei8nWHv+g0LbJlGjkVIx7lr+M/IEIXVfrBc1fkcrOzUW2pV+qhwwl
         iA8MH47yg427GeOWfwmNkrfhNWaHxwSKQpff8U/slV6GGmBSXzShcUV3e0zY38zNQicR
         WTERpH+a9wSTw3F+SU+osn8Je+OL2npGz6NEOYU+CS7J4OmBSgK1rdiKcJklR1EA206z
         /8gfvSTjCPQBsLF+td1T5/PJ7nCiQu6ZLae8s612M6k+2zYIhZ52Ni5FFvYZ/x7YbWC6
         sGzjIQ269SNiQgk3Hejx9iV1TwkwoIKZ69L3uf0uOTLsjdCPFOzRTSHK7S3Exub41KzB
         ZNQg==
X-Gm-Message-State: APjAAAWcxdzgN70mS8ilW/5AQd+QoJhSwNSKNRPCsOA94fUmS10lekO7
        6DUwSQ6TvYCNgudcvSnpFcLCKBKXNBNEf8wyKTQ=
X-Google-Smtp-Source: APXvYqxtMJHxjriXBL2G/aFHx9Aj+MOylCD8Rc6TljLhoCm8yhfHlt3m6LmoUHm2Oi1nauGBQQjlt492pqL2Ni067ZY=
X-Received: by 2002:aca:cdd3:: with SMTP id d202mr1045859oig.115.1561716241115;
 Fri, 28 Jun 2019 03:04:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190627210209.32600-1-daniel.lezcano@linaro.org>
 <20190627210209.32600-2-daniel.lezcano@linaro.org> <CAJZ5v0jJzCGfQFqi-S3vqs74D73MaE4f7WYF_NVnDKawNV4Wzw@mail.gmail.com>
 <cd79ffe3-4749-9135-27c4-deb4f259d702@linaro.org>
In-Reply-To: <cd79ffe3-4749-9135-27c4-deb4f259d702@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 28 Jun 2019 12:03:49 +0200
Message-ID: <CAJZ5v0hPjPMLfiWMPnm59HpmTbJNXw0MDpvRwMGOUpMXYUwgRw@mail.gmail.com>
Subject: Re: [PATCH V4 2/3] thermal/drivers/cpu_cooling: Unregister with the policy
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Eduardo Valentin <edubezval@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Keerthy <j-keerthy@ti.com>,
        "open list:CPU FREQUENCY DRIVERS - ARM BIG LITTLE" 
        <linux-pm@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:TI BANDGAP AND THERMAL DRIVER" 
        <linux-omap@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jun 28, 2019 at 11:58 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> On 28/06/2019 11:12, Rafael J. Wysocki wrote:
> > On Thu, Jun 27, 2019 at 11:02 PM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> Currently the function cpufreq_cooling_register() returns a cooling
> >> device pointer which is used back as a pointer to call the function
> >> cpufreq_cooling_unregister(). Even if it is correct, it would make
> >> sense to not leak the structure inside a cpufreq driver and keep the
> >> code thermal code self-encapsulate. Moreover, that forces to add an
> >> extra variable in each driver using this function.
> >>
> >> Instead of passing the cooling device to unregister, pass the policy.
> >>
> >> Because the cpufreq_cooling_unregister() function uses the policy to
> >> unregister itself. The only purpose of the cooling device pointer is
> >> to unregister the cpu cooling device.
> >>
> >> As there is no more need of this pointer, remove it.
> >>
> >> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> >
> > This doesn't apply for me.
> >
> > Care to rebase it on top of the Linus' tree?
>
> Sure but the patch depends on 1/3 which is in bleeding edge. Shall I
> rebase the 3 patches on v5.2-rc6 and resend ?

You can do that.

Alternatively, you can rebase on top of my linux-next branch.
