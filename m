Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 450CE6D8A0
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2019 03:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbfGSB4I (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jul 2019 21:56:08 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34009 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfGSB4I (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jul 2019 21:56:08 -0400
Received: by mail-lf1-f68.google.com with SMTP id b29so13351471lfq.1;
        Thu, 18 Jul 2019 18:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UO8btVVL/IFrG50cwCtu/sUBh+QFd3XXfzfNm+smt1U=;
        b=I6DLlrH2qXLZ8dYYWhYMjtjqWPy9phRY/H/xdpYgnKRp3y2vSSLmrQAwydlNe8RPaJ
         Ib0kOZK2DVtYAGEP3evhg2epnUr24mWBUZM1rzqBvBWJmnoI37Wz8fxwkDi8HRRkMPgv
         7MohbZI7ySNDx7m3wzAtGJpyE7iicruP4hyOZ2tkOKepPg10Blv2weJoDe4F/rZOSkRG
         I+oIrsGfMow9P8xnknTz++fgC2SfFkJPpB8C0nWzBMLDUsPkL5fBTwFSLDbSIKuxZYkD
         WM6Wxuzx0Gxq3CpAVU4SHMkjzWfAUhcJdRfambwlfyZnQEXa/djrQAmRPiTmg3FLTwjZ
         JlGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UO8btVVL/IFrG50cwCtu/sUBh+QFd3XXfzfNm+smt1U=;
        b=FrDcgzLfZJ+NA8f7RkR8mRtIGmztCwKNVKD4OlMzX0eNV2EbHB+OaKDcfq8vzHR+u5
         pXdQWFD9SJuQRGIfZ/IpUoTco4GbG3v5E2LfyWTsrgV+v3uIukC1K546Fc3WEa5Fa2PB
         3mgy/amH9zk4qZUR9/9gAo9p5cmUFDkfWlI60xNVr+krtouwLA5d338SSQfBIvCa5juG
         4P5Vqe5jbAA0eenNNzE1yACoECiRN9jWwpl067wGDV7AV3Z9fM/UEN0/V3qIeuf9Mdgy
         u+ujF7sSl+1jRJ/vGCMGaYlMmjd5q/CBoGZXwCchDytQaIWG/Jxs543fv39zIkRKaDpD
         0i0Q==
X-Gm-Message-State: APjAAAV3G3G1oG0DSed177HI4c9Rgx9Y2Lkoy6u38r4nhivjL19Pkout
        yQCUAn93p8kyDytKliXicvk=
X-Google-Smtp-Source: APXvYqw80ciSAc2Vs0Cibu7leQl8v3dj+nAs+2bkcaDWxZm3m+uaesL5gnuLrFhCcrV860i7v1Kg5g==
X-Received: by 2002:ac2:418f:: with SMTP id z15mr21418515lfh.177.1563501366148;
        Thu, 18 Jul 2019 18:56:06 -0700 (PDT)
Received: from dimatab (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id g4sm4245127lfb.31.2019.07.18.18.56.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 18:56:05 -0700 (PDT)
Date:   Fri, 19 Jul 2019 04:59:43 +0300
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
Message-ID: <20190719045943.73b53e31@dimatab>
In-Reply-To: <e3358039-d1b3-a5a0-1a37-aeb8edd49d6b@samsung.com>
References: <20190707223303.6755-1-digetx@gmail.com>
        <CGME20190707223619epcas4p333f556dcf5a477b5cad5c9362a6f9b97@epcas4p3.samsung.com>
        <20190707223303.6755-21-digetx@gmail.com>
        <e3358039-d1b3-a5a0-1a37-aeb8edd49d6b@samsung.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

=D0=92 Fri, 19 Jul 2019 10:36:30 +0900
Chanwoo Choi <cw00.choi@samsung.com> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> On 19. 7. 8. =EC=98=A4=EC=A0=84 7:32, Dmitry Osipenko wrote:
> > I noticed that CPU may be crossing the dependency threshold very
> > frequently for some workloads and this results in a lot of
> > interrupts which could be avoided if MCALL client is keeping actual
> > EMC frequency at a higher rate.
> >=20
> > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > ---
> >  drivers/devfreq/tegra30-devfreq.c | 23 ++++++++++++++++++-----
> >  1 file changed, 18 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/devfreq/tegra30-devfreq.c
> > b/drivers/devfreq/tegra30-devfreq.c index
> > c3cf87231d25..4d582809acb6 100644 ---
> > a/drivers/devfreq/tegra30-devfreq.c +++
> > b/drivers/devfreq/tegra30-devfreq.c @@ -314,7 +314,8 @@ static void
> > tegra_actmon_get_lower_upper(struct tegra_devfreq *tegra, }
> > =20
> >  static void tegra_devfreq_update_avg_wmark(struct tegra_devfreq
> > *tegra,
> > -					   struct
> > tegra_devfreq_device *dev)
> > +					   struct
> > tegra_devfreq_device *dev,
> > +					   unsigned long freq)
> >  {
> >  	unsigned long avg_threshold, lower, upper;
> > =20
> > @@ -323,6 +324,15 @@ static void
> > tegra_devfreq_update_avg_wmark(struct tegra_devfreq *tegra,
> > avg_threshold =3D dev->config->avg_dependency_threshold;
> > avg_threshold =3D avg_threshold * ACTMON_SAMPLING_PERIOD;=20
> > +	/*
> > +	 * If cumulative EMC frequency selection is higher than the
> > +	 * device's, then there is no need to set upper watermark
> > to
> > +	 * a lower value because it will result in unnecessary
> > upper
> > +	 * interrupts.
> > +	 */
> > +	if (freq * ACTMON_SAMPLING_PERIOD > upper)
> > +		upper =3D freq * ACTMON_SAMPLING_PERIOD; =20
>=20
> Also, 'upper value is used on the patch5. You can combine this code
> to patch5 or if this patch depends on the cpu notifier, you can
> combine it to the patch of adding cpu notifier without separate patch.

Well okay, I'll try to squash some of the patches in the next revision.
Usually I'm receiving comments in the other direction, asking to
separate patches into smaller changes ;) So that's more a personal
preference of each maintainer, I'd say.
