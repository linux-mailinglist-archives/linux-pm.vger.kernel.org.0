Return-Path: <linux-pm+bounces-16752-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD689B6B00
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 18:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AACC41C20D1B
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 17:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB7B1BD9DE;
	Wed, 30 Oct 2024 17:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIzn2okU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE201BD9CB;
	Wed, 30 Oct 2024 17:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730309306; cv=none; b=ZkVqbjY+g9lwzoPSpD5zX9I+TzvuW8L+t0aTjTcxJid2VwQIqbMVUJDxAr8Ktg7QyMM2A19R5P84hJQcjNpOGPYk/ZrZaXRW+CLW9Xmm3ihgu5xHZNYENkfgXzFypRI3ngc4zNr/KmjiArO+gBVr95nLM+hxIIsuHeQ+G6vHt/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730309306; c=relaxed/simple;
	bh=I+pOOGHMZI2SP6OFUnOB4ImhG03P+O3foWEohCD03YA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y0Ob+bj4r66vxUFgsszBy7xtopFjq22ZXSVqBBjK09VYQBLlsMF0bR5Zc3HwFQob4tMhdANKN1Kd0InTYalvWLZ+/JnUCsuJXdQUSLCadR9geSkYtNgQQ3Cf4scKJIaVz+AShmS4O4vFqSnVBDbnQ9oefZaAwDyxUuWJNJvNJNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HIzn2okU; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-720b173a9ebso54451b3a.0;
        Wed, 30 Oct 2024 10:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730309304; x=1730914104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MnkN8ptr3KGmpx2Uv+pp+uUkuHBCH11BckHc8GqWeDg=;
        b=HIzn2okUNsJGA1yDQ62T5nhFz8JXJli5zSBbK/vxVBdYceEHL0ZPEVYhuVu29XSpi8
         4pr4XBLwTdD72d4oYy1rXrRJkfjeHZl5p0IQjXVTOdvP95Yl9XD5Wz82FLUEjVMpGqwD
         vl7IavGpluS/8tAu7s028/NKeLJRiJniS8VRYDQPMCKYUQadhl6/Lr+bsbg+Ywfkq0R/
         MYExAnJv4ytgAK7gVKAZq/aNP5rArJEK0AR2ff04yWhuysCGLqiaal14jDcaekrAktNb
         UgQfjUiKcEW0AfgrANK5ZRSSsQtKWF5NqSzlu35yozYtRAeETfcUHa8HG0d8DK3ZTC7o
         2iTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730309304; x=1730914104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MnkN8ptr3KGmpx2Uv+pp+uUkuHBCH11BckHc8GqWeDg=;
        b=ERz/FPS/zkKswIz7WzXMP9Whfc4c68PBlhQ9FgjdjPWPID9IycRCLt3OdCzUg3sCML
         1RfceAMw6eZeaESDYtiL0GDvRVx7uATUlrZ9lgpeKz8eOoYUls+wQWS4DxaEDhuOzq3g
         AmGq0rS8N7+6RqGWIOt8xyHtMvwNyIyuzFWjGZXb70nM1k/icDClHlgJyWbfjKp9/Jc9
         n3MaG6q5af9XCsbrhDiOTjidYio27yCQTYIDVKORbdpcT+SL9z5MvmIIO8I5zNHAXNkZ
         1CoHNYDiaPiWAMkq7g/eZItIHN/2Dx5ALByeLzFEbtSHOGByOCcFfXisuC2zYVeV4vIs
         lLQw==
X-Forwarded-Encrypted: i=1; AJvYcCUt+WbiBbEJSzutStsa7f5kUYbvyPd+5h4aMJT6gxu4YF5SkhL4VGlgOBnAjtavC2Qzryz6Aj0iJWHD@vger.kernel.org, AJvYcCW37a84R/O+kc7JORiR92oG+B2Oo3qu48yRbN5t4knCbuOzzqIiAfVzKNBOdcZdlmzX0HlCuvOjPN+a0S/1@vger.kernel.org, AJvYcCXNZS0Pntqsqw/1Z0JiLH8nDErRXkleKyZj6MvC4KXAzV9ks5AWq/C8m94gYYlIbqiLBsaoMLy99Gw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBM/PKxtxjHDWGfE8wltK6QaWMibQWXGzIVDQcItpAykeDSRzE
	FKQ0SYK32D47zMPg4AVioqSbrWuJKrbOsIw61jJSwjiKfEKsZOixzucvr8+C7Utmj60CqcDN7Li
	df6gCBhuVOo62QugBgd25ZUZ9LlbtjQ==
X-Google-Smtp-Source: AGHT+IHW4Ei/MHebO474qYJ4FnNy3KOOcESKnX+HK1imXciZaQOAIYn479DmypH3MHAeRnnMNdgGnRLoV9bhVu1WXCI=
X-Received: by 2002:a05:6a00:3c96:b0:71d:f4ef:6b3a with SMTP id
 d2e1a72fcca58-720b9db22bfmr624360b3a.21.1730309303938; Wed, 30 Oct 2024
 10:28:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240203165307.7806-1-aford173@gmail.com> <20241025080544.136280-1-mailinglist1@johanneskirchmair.de>
 <6d039ecf-0e48-415a-afd8-6bfce60081ae@kontron.de>
In-Reply-To: <6d039ecf-0e48-415a-afd8-6bfce60081ae@kontron.de>
From: Adam Ford <aford173@gmail.com>
Date: Wed, 30 Oct 2024 12:28:12 -0500
Message-ID: <CAHCN7xKevGWipBSch6gKVeJRT9Zb8QTchhxg3c=96XhnAvnjZw@mail.gmail.com>
Subject: Re: imx8mp: HDMI display blank/black problems
To: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: mailinglist1@johanneskirchmair.de, johannes.kirchmair@skidata.com, 
	Laurent.pinchart@ideasonboard.com, airlied@gmail.com, 
	alexander.stein@ew.tq-group.com, andrzej.hajda@intel.com, 
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
	vkoul@kernel.org, will@kernel.org, Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 4:01=E2=80=AFAM Frieder Schrempf
<frieder.schrempf@kontron.de> wrote:
>
> Hi Johannes,
>
> On 25.10.24 10:05 AM, mailinglist1@johanneskirchmair.de wrote:
> > [Sie erhalten nicht h=C3=A4ufig E-Mails von mailinglist1@johanneskirchm=
air.de. Weitere Informationen, warum dies wichtig ist, finden Sie unter htt=
ps://aka.ms/LearnAboutSenderIdentification ]
> >
> > Hey,
> > We had some problems with the hdmi on the imx8mp and wanted to leave, w=
hat we found out about it, somewhere for others to find it.
> >
> > The problem was that our hdmi display sometimes stayed blank after hot =
plugging and sometimes at startup. On older kernel versions 6.6 we did not =
have the problem with the not mainlined hdmi patches.
> > We tracked the commit down that introduced the problem for us. It was t=
he following =E2=80=9Cdriver core: Enable fw_devlink=3Drpm by default=E2=80=
=9D  https://lore.kernel.org/lkml/20231113220948.80089-1-saravanak@google.c=
om/
> > So we switched back to FW_DEVLINK_FLAGS_ON via kernel parameter. Don=E2=
=80=99t really understand what the problem with RPM is.
> >
> > So, this information is just for reference. Maybe someone has an idea w=
hat is going on here. And how to fix the problem in a more proper way.
>
> Thanks for investigating and sharing your results!
>
> I'm seeing the same symptoms and previously found out that this is
> related to LCDIF underrun errors. See [1] for more information.
>
> Adam has also started this thread: [2].
>
> Anyway, knowing that this is related to fw_devlink=3Drpm is really
> helpful. I just tried with fw_devlink=3Don and wasn't able to see any
> issues anymore. So this confirms your findings.

I was off in the weeds thinking there was something wrong in timing
and/or a race condition around the PLL or something.  This is good
news.
Please forgive my ignorance, what does fw_devlink do?  Is there
something we can do in the driver itself to force its behavior?

adam
>
> I hope that some of the driver framework and runtime PM experts can help
> to find out what is actually wrong and how the correct fix might look lik=
e.
>
> I'm also CC-ing Saravana who authored the change from fw_devlink=3Don to
> fw_devlink=3Drpm to see if they have anything to add.
>
> Thanks
> Frieder
>
> [1]
> https://patchwork.kernel.org/project/linux-phy/cover/20240904233100.11461=
1-1-aford173@gmail.com/#26014057
> [2]
> https://lore.kernel.org/imx/8cfd3052-c85a-4235-b9b8-6d2929e9e455@kontron.=
de/T/

