Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32F636D8EF
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2019 04:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbfGSCRg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jul 2019 22:17:36 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45812 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbfGSCRg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jul 2019 22:17:36 -0400
Received: by mail-lf1-f66.google.com with SMTP id u10so20590809lfm.12;
        Thu, 18 Jul 2019 19:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HNMhY1ykx0GnlF6JKggl8sLwPS/j8cg780i6U3Mhwco=;
        b=Dx8cfGssBH0NKhAMWIEB7HWEf805sROrkX6S5J/H28OWuwBMRRU3XkAr5eAmVFT9Mw
         xxtr+j/rXikat90qken+vFjFhMwaBUnzOe8dRPPpvN+SWFTxK+CYvm1ksW69kEQ7BPa8
         E6iLZjIXomLfUMqUMgTHWAFmS8GmuhpQZXKHomw1K/R2yMQJ1sLcTYpEjyWGWl1dPURU
         WxudHnp625GFMMhE0rthRa/X1xc3gCisghB0Y2115/uoylalkqkhZI44mtgJ8g6zrVzZ
         wsJ3sExsi2j1zRFpiOYu8rEIC2d75wgFRX0mh56YRO/lcBPQpaI9OnSmZSJaczdpYcnz
         wz/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HNMhY1ykx0GnlF6JKggl8sLwPS/j8cg780i6U3Mhwco=;
        b=psjT1Y8DrvcB14ik8583sizHJqHMvbwgE59m5YGbv8wjPAhdD54BEHeJe5lwGbgleM
         0P7bSfxVdX2b6sD/ZNhHKWaWIgqwcL11kqzflT52cvZx6rwSlvPlPv28GdmIBChAW1LX
         vMI0nB+lElzP1k49GRxbT52d+EY+PHbvIYfkTb1RUJ9wWRwuR9o4BXSrQlIsIICpSwhJ
         PqoqbtPO/ZC23Uo0iCRe4sIb08LorXVy/Oj2awV3rJb5h3symq/NmrL1+iytBvfJkdX3
         60SbPgVGHZ+TmXvn4pM3xmDC6nXCsbxW8eZh1GtZE4xXzgzjKuDq1EjniniPqvmWoWz5
         g+KA==
X-Gm-Message-State: APjAAAX7mt3OArFrUOjNTfyqCcrG6LHcRTJe/YpdQOVHcKzsi5OMtYVT
        t/hPB0TQJelQM9gSri2d3IM=
X-Google-Smtp-Source: APXvYqzAKEmTBGQd15nuGMd3QY1+47/Z33uRupMg//JatM2+dT3yIeJw6o+KZj2LFG0FNsvByPG07g==
X-Received: by 2002:a19:6a01:: with SMTP id u1mr22530555lfu.141.1563502654101;
        Thu, 18 Jul 2019 19:17:34 -0700 (PDT)
Received: from dimatab (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id i62sm5317413lji.14.2019.07.18.19.17.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 19:17:33 -0700 (PDT)
Date:   Fri, 19 Jul 2019 05:21:11 +0300
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 20/24] PM / devfreq: tegra30: Optimize upper average
 watermark selection
Message-ID: <20190719052111.6641285d@dimatab>
In-Reply-To: <1cec80ae-c03e-98a7-1d9f-6b57690610c7@samsung.com>
References: <20190707223303.6755-1-digetx@gmail.com>
        <CGME20190707223619epcas4p333f556dcf5a477b5cad5c9362a6f9b97@epcas4p3.samsung.com>
        <20190707223303.6755-21-digetx@gmail.com>
        <e3358039-d1b3-a5a0-1a37-aeb8edd49d6b@samsung.com>
        <20190719045943.73b53e31@dimatab>
        <1cec80ae-c03e-98a7-1d9f-6b57690610c7@samsung.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

=D0=92 Fri, 19 Jul 2019 11:06:05 +0900
Chanwoo Choi <cw00.choi@samsung.com> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> On 19. 7. 19. =EC=98=A4=EC=A0=84 10:59, Dmitry Osipenko wrote:
> > =D0=92 Fri, 19 Jul 2019 10:36:30 +0900
> > Chanwoo Choi <cw00.choi@samsung.com> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >  =20
> >> On 19. 7. 8. =EC=98=A4=EC=A0=84 7:32, Dmitry Osipenko wrote: =20
> >>> I noticed that CPU may be crossing the dependency threshold very
> >>> frequently for some workloads and this results in a lot of
> >>> interrupts which could be avoided if MCALL client is keeping
> >>> actual EMC frequency at a higher rate.
> >>>
> >>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >>> ---
> >>>  drivers/devfreq/tegra30-devfreq.c | 23 ++++++++++++++++++-----
> >>>  1 file changed, 18 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/drivers/devfreq/tegra30-devfreq.c
> >>> b/drivers/devfreq/tegra30-devfreq.c index
> >>> c3cf87231d25..4d582809acb6 100644 ---
> >>> a/drivers/devfreq/tegra30-devfreq.c +++
> >>> b/drivers/devfreq/tegra30-devfreq.c @@ -314,7 +314,8 @@ static
> >>> void tegra_actmon_get_lower_upper(struct tegra_devfreq *tegra, }
> >>> =20
> >>>  static void tegra_devfreq_update_avg_wmark(struct tegra_devfreq
> >>> *tegra,
> >>> -					   struct
> >>> tegra_devfreq_device *dev)
> >>> +					   struct
> >>> tegra_devfreq_device *dev,
> >>> +					   unsigned long freq)
> >>>  {
> >>>  	unsigned long avg_threshold, lower, upper;
> >>> =20
> >>> @@ -323,6 +324,15 @@ static void
> >>> tegra_devfreq_update_avg_wmark(struct tegra_devfreq *tegra,
> >>> avg_threshold =3D dev->config->avg_dependency_threshold;
> >>> avg_threshold =3D avg_threshold * ACTMON_SAMPLING_PERIOD;=20
> >>> +	/*
> >>> +	 * If cumulative EMC frequency selection is higher than
> >>> the
> >>> +	 * device's, then there is no need to set upper watermark
> >>> to
> >>> +	 * a lower value because it will result in unnecessary
> >>> upper
> >>> +	 * interrupts.
> >>> +	 */
> >>> +	if (freq * ACTMON_SAMPLING_PERIOD > upper)
> >>> +		upper =3D freq * ACTMON_SAMPLING_PERIOD;   =20
> >>
> >> Also, 'upper value is used on the patch5. You can combine this code
> >> to patch5 or if this patch depends on the cpu notifier, you can
> >> combine it to the patch of adding cpu notifier without separate
> >> patch. =20
> >=20
> > Well okay, I'll try to squash some of the patches in the next
> > revision. Usually I'm receiving comments in the other direction,
> > asking to separate patches into smaller changes ;) So that's more a
> > personal preference of each maintainer, I'd say.
> >  =20
>=20
> Right. We have to make the patch with atomic attribute.
> But, if there are patches which touch the same code
> in the same patchset. We can squash or do refactorig
> of this code.

The main benefit of having smaller logical changes is that when there is
a bug, it's easier to narrow down the offending change using bisection.
And it's just easier to review smaller patches, of course.

> And also, if possible, I'd like you to make the patch
> list according to the role of patch. For example,
> the patches related to the 'watermark' could be sequentially
> listed. But, it is not forced opinion. If just possible.

Okay, will take this into account.

