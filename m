Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63A5A7B94D
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2019 07:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfGaF5t (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Jul 2019 01:57:49 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39278 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbfGaF5t (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Jul 2019 01:57:49 -0400
Received: by mail-pf1-f193.google.com with SMTP id f17so27218546pfn.6
        for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2019 22:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xxuiJ99C2BSuqlzuSQ5W3YPgqsvt8eIr0onh3k8tPXo=;
        b=N7AI4rm6nDiwuslyuxOVL59UrdPgVMoFYBuIt3dzK7KCjfsgpLiWu9KLO75h3ClCnf
         9U87etJ7ysWJuzuEYhNY4izjsB6fiygLp6GbYKqUDUI8f9fCMU81Ju1hesmSK3zIRChQ
         VL1s81AtRaYeNoqGHB6MzXZxAIR+tBQJusZMC93Wq4/MbXkMqidnD8HT4zwQvOSxJ01K
         3V3JqjQobiFbGSZ4iIEt6q3D03zfR0tf1XoLGzWx0Q8A+LHPVE3FxcDAXmP6KNmGGHCZ
         muYJnMDBiEdkFuKxpsOdq3+rVCLD4pLFaQk2J2M2b1/qoFDPUhh9stwxfo4GYdR9KX3Z
         uAcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xxuiJ99C2BSuqlzuSQ5W3YPgqsvt8eIr0onh3k8tPXo=;
        b=ZSMFf8a/QbGE7zrgr1drrW+iDcIyu3wjSOVZQdYKIwWuK1KemQFwaztIGmY8PCznRD
         wtuKfjIp9uyipPNSpNGgmEAgDAWEwybKfVF+pdWlBbQHrHm73b9B7Vy/s2LXOn8aownW
         6SgzndgTGzcgN1UM4vJiqVG2Uvt/C4uXKXXI+Y/WfRJBXLhhHO15oVOeLvjH+YA+6KgB
         iu+2SRcUiED/kAa6vwCe1j4xewG3uu/nfToNPp8RwEZL46eGGQR7ElbGXOz1ZG+ykDsF
         gqrv2y8ebKMGNeFNSBOU0M/kSayrSYhGA26GWbYWwf8FNVS8/WykyrO/4kPHPcNteVz1
         ZMyA==
X-Gm-Message-State: APjAAAWj0W2mIUWgVOvFopN+FlzWzP3YfJxtLOn9C1BFVb8XcH0U1oKD
        0GxP5d/Xb8LnYOvG3jEsxz4=
X-Google-Smtp-Source: APXvYqwxSJxsxBx/cLg9FVAWVyZxs+OfgVM0TqcjHGlf4u5wKKnHv2lXQXmQ8Mkwt12xrcDMvBjloA==
X-Received: by 2002:a62:b408:: with SMTP id h8mr44513131pfn.46.1564552668385;
        Tue, 30 Jul 2019 22:57:48 -0700 (PDT)
Received: from localhost ([218.189.10.173])
        by smtp.gmail.com with ESMTPSA id r6sm1781853pjb.22.2019.07.30.22.57.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Jul 2019 22:57:48 -0700 (PDT)
Date:   Wed, 31 Jul 2019 13:57:36 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        linux-pm@vger.kernel.org, huyue2@yulong.com
Subject: Re: [PATCH] PM / devfreq: Drop the name check to request module in
 try_then_request_governor()
Message-ID: <20190731135736.00006a55.zbestahu@gmail.com>
In-Reply-To: <cf760204-2504-cef9-09e7-19643986a902@samsung.com>
References: <CGME20190730100844epcas4p14dfa39fff2636e89c94033f154240db0@epcas4p1.samsung.com>
        <20190730100819.8056-1-zbestahu@gmail.com>
        <8e5efa9c-96c4-0c2c-b92a-d72ee598838c@samsung.com>
        <20190731133808.00006f5b.zbestahu@gmail.com>
        <cf760204-2504-cef9-09e7-19643986a902@samsung.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 31 Jul 2019 14:55:39 +0900
Chanwoo Choi <cw00.choi@samsung.com> wrote:

> On 19. 7. 31. =EC=98=A4=ED=9B=84 2:38, Yue Hu wrote:
> > On Wed, 31 Jul 2019 09:33:06 +0900
> > Chanwoo Choi <cw00.choi@samsung.com> wrote:
> >  =20
> >> On 19. 7. 30. =EC=98=A4=ED=9B=84 7:08, Yue Hu wrote: =20
> >>> From: Yue Hu <huyue2@yulong.com>
> >>>
> >>> No need to check specific governor name of `simple_ondemand` to reque=
st
> >>> module, let's change the name string to `simpleondemand` to keep the
> >>> consistency on loading module if needed.   =20
> >>
> >> NACK.
> >>
> >> hmm.... It is impossible to change the devfreq governor name
> >> because there are many reason.
> >>
> >> The devfreq governor could be changed through the sysfs interface
> >> on runtime. For a long time, many users or platforms change
> >> the devfreq governor with the defined governor name through sysfs.
> >> If it is just changed, it breaks ABI interface and cannot support
> >> the compatibility. It is very critical problem. Please drop it. =20
> >=20
> > Yes, needs update also if using sysfs. it's problem indeed. =20
>=20
> No, It is impossible to update it. You have to change all kind of
> platform in the world. We never know the all use-case in the world.
> As I said, it break the ABI interface.=20
>=20
> >  =20
> >>
> >>
> >> Maybe, you didn't check the usage of devfreq device driver
> >> in the mainline kernel. Almost devfreq device using simple_ondemand
> >> governor have to add the governor name with devfreq_add_device().
> >> If changed the governor name, it cause the fault of device driver
> >> using the devfreq framework with simple_ondemand. =20
> >=20
> > Currently, seems no devfreq users use the simple_ondemand directly in
> > mainline kernel. =20
>=20
> You can find them in the mainline kernel as following:
>=20
> drivers/gpu/drm/panfrost/panfrost_devfreq.c:160:&panfrost_devfreq_profile=
, "simple_ondemand", NULL);
> drivers/gpu/drm/msm/msm_gpu.c:98:		&msm_devfreq_profile, "simple_ondemand=
", NULL);

drm related code is already updated as below link:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/=
?id=3D67fe62dcf713c36f4766c0218cc14796ee9536e1

>=20
> drivers/scsi/ufs/ufshcd.c:1333:			DEVFREQ_GOV_SIMPLE_ONDEMAND,
> drivers/devfreq/tegra20-devfreq.c:176:		DEVFREQ_GOV_SIMPLE_ONDEMAND, NULL=
);
> drivers/devfreq/rk3399_dmc.c:452:		DEVFREQ_GOV_SIMPLE_ONDEMAND,
> drivers/devfreq/exynos-bus.c:437:		DEVFREQ_GOV_SIMPLE_ONDEMAND,
>=20
> >=20
> > Maybe we can rename the governor file name to governor_simpleondemand.c,
> > just not compatible to module name compared with this change. =20
>=20
> The file name was already 'drivers/devfreq/governor_simpleondemand.c'.

Sorry for the typo error. I mean governor_simple_ondemand.c?

Thanks.

>=20
>=20
> >=20
> > Thanks.
> >  =20
> >>
> >> =20
> >>>
> >>> Signed-off-by: Yue Hu <huyue2@yulong.com>
> >>> ---
> >>>  drivers/devfreq/devfreq.c | 6 +-----
> >>>  include/linux/devfreq.h   | 2 +-
> >>>  2 files changed, 2 insertions(+), 6 deletions(-)
> >>>
> >>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> >>> index 784c08e..baff682 100644
> >>> --- a/drivers/devfreq/devfreq.c
> >>> +++ b/drivers/devfreq/devfreq.c
> >>> @@ -246,11 +246,7 @@ static struct devfreq_governor *try_then_request=
_governor(const char *name)
> >>>  	if (IS_ERR(governor)) {
> >>>  		mutex_unlock(&devfreq_list_lock);
> >>> =20
> >>> -		if (!strncmp(name, DEVFREQ_GOV_SIMPLE_ONDEMAND,
> >>> -			     DEVFREQ_NAME_LEN))
> >>> -			err =3D request_module("governor_%s", "simpleondemand");
> >>> -		else
> >>> -			err =3D request_module("governor_%s", name);
> >>> +		err =3D request_module("governor_%s", name);
> >>>  		/* Restore previous state before return */
> >>>  		mutex_lock(&devfreq_list_lock);
> >>>  		if (err)
> >>> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> >>> index 2bae9ed..41e8792 100644
> >>> --- a/include/linux/devfreq.h
> >>> +++ b/include/linux/devfreq.h
> >>> @@ -17,7 +17,7 @@
> >>>  #define DEVFREQ_NAME_LEN 16
> >>> =20
> >>>  /* DEVFREQ governor name */
> >>> -#define DEVFREQ_GOV_SIMPLE_ONDEMAND	"simple_ondemand"
> >>> +#define DEVFREQ_GOV_SIMPLE_ONDEMAND	"simpleondemand"
> >>>  #define DEVFREQ_GOV_PERFORMANCE		"performance"
> >>>  #define DEVFREQ_GOV_POWERSAVE		"powersave"
> >>>  #define DEVFREQ_GOV_USERSPACE		"userspace"
> >>>    =20
> >>
> >> =20
> >=20
> >=20
> >  =20
>=20
>=20

