Return-Path: <linux-pm+bounces-16768-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 969CB9B6D89
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 21:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3135B282E20
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 20:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CC91D173D;
	Wed, 30 Oct 2024 20:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f8Tcu1AX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D461D1721
	for <linux-pm@vger.kernel.org>; Wed, 30 Oct 2024 20:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730319674; cv=none; b=shTPtmp1I0ZnWl38iCRMOK9awhuZbKa5iL4g1tCoK8bj9D5EZKe/SB9I4rmQT/Mk5zBBihbXMKTa9Dmc9hhnDY/z39ta9GFqUTS6o/Go3hqvapiyfCmpqGNC2EEMCPrlelfxnynp+YN5Yi4FBH7YXG0kcXdjMYJOMGu2uf+zo5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730319674; c=relaxed/simple;
	bh=dMSieHhlLhjVhgnJbukKlpTIcZHhL33WPNnPyYGF7H0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dUkcDBSC1NUzgKAdx3UAaZJIJM0DbtuLva9M2shTVbMLw+nhLP9WyEVJmJLTX2Fnbsb4IFN8mdtCIKZeurEcMDBi/KqL5RLagA4Fa6cj/d+JuSe5h7sz+hUoy+9MzW+B7VEQ3kjHVIc22qLwyekZ0mnVCetXwuwSv9Dk0hBInAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f8Tcu1AX; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e56df894d4so163334a91.3
        for <linux-pm@vger.kernel.org>; Wed, 30 Oct 2024 13:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730319672; x=1730924472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VxptXU8oKSlVF2fvRzkZip9fG/KS/MTrvVI6j9ReCRo=;
        b=f8Tcu1AXhQqYPUGm43zkUTFCzO0HPNKSXDyWk0BHHXSkvXLhUez7jR+xvncLyLMCq/
         Wv7r6KArzkp8+IYWFh7TNi/G17lL5PA2TnyXwQ8Vxz/qm2YD1ihBrPIumIowG4ZJCq8x
         qEts+saBYMSfha/HW059ZK1G033pBtIvnA3HbJJlMimgYgm4CKQFY6jTNq3JMlRYl56y
         CBC/qFMb19Lw5kvPE2lJ6WhyUPKNpBiNZkpD80GGMmgo518ES25sgndUMw50/xq3pvsj
         27bX/ls9F6ItDZBjnDcUeiJ2lLNgx7ZGqpCqN57ZPfFHpjckkRyjBMrM938SuxULirmf
         HagQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730319672; x=1730924472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VxptXU8oKSlVF2fvRzkZip9fG/KS/MTrvVI6j9ReCRo=;
        b=tEMV9HYnVpQTfaCGWNezzDpl3O+ke977kQTOhtabKoxKzvmFEEuOy3Bm/7eWxD/ftM
         sPeGMG1EKdY5fXLFnp5CdvpXo1MZCDN8GfKgBUeaESfGlYJ2zEwnjDDlZWk0FgYsQfVQ
         3XhclC9UChTO/sB5vjaq9+MFM+qUZoHCZVckQn2xtxmAX/JkTYam3+rL9S2DC2UQfYUU
         Cp9Ehhjay0bWu6kKLzDcf9j/VejAbqVkrL3XZND5YVVkVvK5rn142twiOB2R1SEkAR39
         dvUu5zYM7Jzzy5kLeS2771r4jGrsR95CHhjq1utRAI8IxlMBUuyTTi5uoRf1hV2SnL/y
         iQgg==
X-Forwarded-Encrypted: i=1; AJvYcCVb5GwEeAShdKaQKdreVKkFjaHojRf/lQNntysNzZO3EtTEiG2azw4ejFLXuVjR/qPTzFndELZDlg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPTpVMGRLvvbylTwhzfX3a04piMmzMDJf9pLZwEkihWyV9EOwY
	fyQhqhGZm89ieZIsb8lAKUU7xQ5fvljOmgdevx9t9SSYaLWE3JTITbTEXX2Hu+lpzg62HpFf5iR
	unLrrzeYqZWeUetqzvREXOyJs8VulasWwLc4t
X-Google-Smtp-Source: AGHT+IEP9wXNWXu2pk9j6AVVN/5LTlwN5rgVci/DlwsY/hQHHrt79TYJSPQXM7eBts4e9mwGpTVwOvfM4MoIEhR+9sI=
X-Received: by 2002:a17:90b:1c84:b0:2e2:b6ef:1611 with SMTP id
 98e67ed59e1d1-2e93c1710afmr870053a91.18.1730319671512; Wed, 30 Oct 2024
 13:21:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240203165307.7806-1-aford173@gmail.com> <20241025080544.136280-1-mailinglist1@johanneskirchmair.de>
 <6d039ecf-0e48-415a-afd8-6bfce60081ae@kontron.de> <CAHCN7xKevGWipBSch6gKVeJRT9Zb8QTchhxg3c=96XhnAvnjZw@mail.gmail.com>
In-Reply-To: <CAHCN7xKevGWipBSch6gKVeJRT9Zb8QTchhxg3c=96XhnAvnjZw@mail.gmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Wed, 30 Oct 2024 13:20:32 -0700
Message-ID: <CAGETcx-LGZ1k-seh4LkvCobsxUk67QK40swiQvH6Wrzs0Log0A@mail.gmail.com>
Subject: Re: imx8mp: HDMI display blank/black problems
To: Adam Ford <aford173@gmail.com>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>, mailinglist1@johanneskirchmair.de, 
	johannes.kirchmair@skidata.com, Laurent.pinchart@ideasonboard.com, 
	airlied@gmail.com, alexander.stein@ew.tq-group.com, andrzej.hajda@intel.com, 
	catalin.marinas@arm.com, conor+dt@kernel.org, daniel@ffwll.ch, 
	devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	festevam@gmail.com, jernej.skrabec@gmail.com, jonas@kwiboo.se, 
	kernel@pengutronix.de, kishon@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	l.stach@pengutronix.de, linux-arm-kernel@lists.infradead.org, 
	linux-imx@nxp.com, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
	maarten.lankhorst@linux.intel.com, marex@denx.de, mripard@kernel.org, 
	neil.armstrong@linaro.org, p.zabel@pengutronix.de, rfoss@kernel.org, 
	robh+dt@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org, 
	tzimmermann@suse.de, ulf.hansson@linaro.org, victor.liu@nxp.com, 
	vkoul@kernel.org, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 10:28=E2=80=AFAM Adam Ford <aford173@gmail.com> wro=
te:
>
> On Wed, Oct 30, 2024 at 4:01=E2=80=AFAM Frieder Schrempf
> <frieder.schrempf@kontron.de> wrote:
> >
> > Hi Johannes,
> >
> > On 25.10.24 10:05 AM, mailinglist1@johanneskirchmair.de wrote:
> > > [Sie erhalten nicht h=C3=A4ufig E-Mails von mailinglist1@johanneskirc=
hmair.de. Weitere Informationen, warum dies wichtig ist, finden Sie unter h=
ttps://aka.ms/LearnAboutSenderIdentification ]
> > >
> > > Hey,
> > > We had some problems with the hdmi on the imx8mp and wanted to leave,=
 what we found out about it, somewhere for others to find it.
> > >
> > > The problem was that our hdmi display sometimes stayed blank after ho=
t plugging and sometimes at startup. On older kernel versions 6.6 we did no=
t have the problem with the not mainlined hdmi patches.
> > > We tracked the commit down that introduced the problem for us. It was=
 the following =E2=80=9Cdriver core: Enable fw_devlink=3Drpm by default=E2=
=80=9D  https://lore.kernel.org/lkml/20231113220948.80089-1-saravanak@googl=
e.com/
> > > So we switched back to FW_DEVLINK_FLAGS_ON via kernel parameter. Don=
=E2=80=99t really understand what the problem with RPM is.
> > >
> > > So, this information is just for reference. Maybe someone has an idea=
 what is going on here. And how to fix the problem in a more proper way.
> >
> > Thanks for investigating and sharing your results!
> >
> > I'm seeing the same symptoms and previously found out that this is
> > related to LCDIF underrun errors. See [1] for more information.
> >
> > Adam has also started this thread: [2].
> >
> > Anyway, knowing that this is related to fw_devlink=3Drpm is really
> > helpful. I just tried with fw_devlink=3Don and wasn't able to see any
> > issues anymore. So this confirms your findings.
>
> I was off in the weeds thinking there was something wrong in timing
> and/or a race condition around the PLL or something.  This is good
> news.
> Please forgive my ignorance, what does fw_devlink do?  Is there
> something we can do in the driver itself to force its behavior?

fw_devlink figures out supplier/consumer dependencies between devices
and creates device links between them. This ensures proper
probe/suspend/resume/shutdown/runtime PM ordering.

fw_devlink=3Drpm vs on means "enforce all of these" vs "enforce all of
these except runtime PM".

> adam
> >
> > I hope that some of the driver framework and runtime PM experts can hel=
p
> > to find out what is actually wrong and how the correct fix might look l=
ike.
> >
> > I'm also CC-ing Saravana who authored the change from fw_devlink=3Don t=
o
> > fw_devlink=3Drpm to see if they have anything to add.

When fw_devlink=3Drpm, you'll have device links created between
consumers and suppliers with the DL_FLAG_PM_RUNTIME flag set. So
before your device is runtime resumed, it'll make sure all your
suppliers are resumed first.

My guess is that there is some issue in the runtime PM handling in
these drivers. I don't have enough context to provide further insight.

-Saravana

> >
> > Thanks
> > Frieder
> >
> > [1]
> > https://patchwork.kernel.org/project/linux-phy/cover/20240904233100.114=
611-1-aford173@gmail.com/#26014057
> > [2]
> > https://lore.kernel.org/imx/8cfd3052-c85a-4235-b9b8-6d2929e9e455@kontro=
n.de/T/

