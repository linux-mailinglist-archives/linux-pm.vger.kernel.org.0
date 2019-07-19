Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAEC6D7D1
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2019 02:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbfGSAgu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jul 2019 20:36:50 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41730 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbfGSAgu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jul 2019 20:36:50 -0400
Received: by mail-lf1-f66.google.com with SMTP id 62so15613188lfa.8;
        Thu, 18 Jul 2019 17:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d6XRGsphvO5VwyeOTd5IMW9yead4IXNTP6aR3kKM4EQ=;
        b=aGRCvWxwn2WzSEgd1n1l8Vh27OT1zQaA5s6nZ0E3niteyofVZwJbOiJkiwO9PH+W98
         BCsjJgAxfzHgPzTWuL5/6VVspWNLRWxgcbl2Z9rxk1D97rZNHW62qCPRBKRUOCIWCld+
         fMxrnxNKiZtq29pjy0XRve1dKRtouBSnDtz7HNox4gPea4maBlM735SaG3SLxp/3Jcqc
         2g0M3ClnAnjV+QIa0nMzYxJqHOycDJp9YecdN8wbOyAuK/zqmmlW089BciNm5vsNG+TV
         jSr3HGVWZYp+VwsKSEdn+yk/Yoa2dNTxegKi8NsQefGDOtU5ZU7VBCkzNXD5YMMtzafb
         UWOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d6XRGsphvO5VwyeOTd5IMW9yead4IXNTP6aR3kKM4EQ=;
        b=BkrB6p7m8+Cklk9Sw5lrU+FwaeD3wR0+CUxawqHEtOIWMd1N4F797qud7xrm+Cb0Z1
         HQHTM/uAdo+AneCSfEAx1ABlcRsUidvl+pKhMtYBkk/ZrFFmh4MYkWdtyI0SAO5EF+rI
         Re/LzH3+pljTdriu8N/KCe1ejDNf29U2pR0cqJcCzN0Jd+uTpIzLkvkkwGkHye3qDixa
         K+NlMm/0JdChJqcfCRASNbCMTiOtEO6Go/fmACxm86ES/n5JrwpQnxM0GWL0ima7pGGF
         zoMFAOnPtGWLvLH5raSZXFZJTD0xWkOKmWWRxH7Jj7F4exagL0OivQDajWE73deulf0b
         yEHQ==
X-Gm-Message-State: APjAAAWpBlRVK/5UIedRj5ktQqQONiqzvNU9wyjvFNvAVMslTwtgzNx3
        zR9i4tziSMpDOj3WNZXiUnE=
X-Google-Smtp-Source: APXvYqx6kxUTxgleSYbBtQCAXESEe/JwOtRHpq7xJ1C3VU3OCfBetFuk2jnZGapCuV9p18o+wZQ98w==
X-Received: by 2002:a19:9111:: with SMTP id t17mr22440659lfd.113.1563496608296;
        Thu, 18 Jul 2019 17:36:48 -0700 (PDT)
Received: from dimatab (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id z83sm5368566ljb.73.2019.07.18.17.36.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 17:36:48 -0700 (PDT)
Date:   Fri, 19 Jul 2019 03:40:25 +0300
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 19/24] PM / devfreq: tegra30: Optimize upper
 consecutive watermark selection
Message-ID: <20190719034025.67c82123@dimatab>
In-Reply-To: <17fabbaf-ceca-7551-0a58-9c8a0e7027ed@samsung.com>
References: <20190707223303.6755-1-digetx@gmail.com>
        <CGME20190707223622epcas4p48ec0d7e6fa26bc2397fa4351c0bd0c2d@epcas4p4.samsung.com>
        <20190707223303.6755-20-digetx@gmail.com>
        <17fabbaf-ceca-7551-0a58-9c8a0e7027ed@samsung.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

=D0=92 Thu, 18 Jul 2019 18:51:02 +0900
Chanwoo Choi <cw00.choi@samsung.com> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> On 19. 7. 8. =EC=98=A4=EC=A0=84 7:32, Dmitry Osipenko wrote:
> > The memory activity counter may get a bit higher than a watermark
> > which is selected based on OPP that corresponds to a highest EMC
> > rate, in this case watermark is lower than the actual memory
> > activity is and thus results in unwanted "upper" interrupts.
> >=20
> > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > ---
> >  drivers/devfreq/tegra30-devfreq.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-) =20
>=20
> It seems that you can combine patch19 with patch20.

No, consecutive and average watermarks are different things that have
different purposes. Consecutive are used for boosting, while average
are for significant memory bandwidth changes.

> >=20
> > diff --git a/drivers/devfreq/tegra30-devfreq.c
> > b/drivers/devfreq/tegra30-devfreq.c index
> > 8d6bf6e9f1ae..c3cf87231d25 100644 ---
> > a/drivers/devfreq/tegra30-devfreq.c +++
> > b/drivers/devfreq/tegra30-devfreq.c @@ -363,7 +363,18 @@ static
> > void tegra_devfreq_update_wmark(struct tegra_devfreq *tegra,
> > tegra_actmon_get_lower_upper(tegra, dev, freq - 1, &lower, &upper);=20
> >  	delta =3D do_percent(upper - lower,
> > dev->config->boost_up_threshold);
> > -	device_writel(dev, lower + delta, ACTMON_DEV_UPPER_WMARK);
> > +
> > +	/*
> > +	 * The memory events count could go a bit higher than the
> > maximum
> > +	 * defined by the OPPs, hence make the upper watermark
> > infinitely
> > +	 * high to avoid unnecessary upper interrupts in that case.
> > +	 */
> > +	if (freq =3D=3D tegra->max_freq)
> > +		upper =3D ULONG_MAX;
> > +	else
> > +		upper =3D lower + delta;
> > +
> > +	device_writel(dev, upper, ACTMON_DEV_UPPER_WMARK);
> > =20
> >  	/*
> >  	 * Meanwhile the lower mark is based on the average value
> >  =20
>=20
>=20

