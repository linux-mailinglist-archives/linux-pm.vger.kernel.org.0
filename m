Return-Path: <linux-pm+bounces-22411-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC32A3BC61
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 12:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0759188D69C
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 11:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7D81DE8A9;
	Wed, 19 Feb 2025 11:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wu7YWX0p"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A3F1D90DD;
	Wed, 19 Feb 2025 11:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739963144; cv=none; b=J17S2PtdZyyk3EJd6Tfo5+NASfJHUcnOG1mKYWvmX7dBGdC/unKG6o+iM8OADpYjjaCmpzCuQ913My0xjI8beko2xpWBL/DoOPETZeh20byjLwI1MyWSaoMIIAdO2dhKChNUp6vKIFA+PttECBOG8BRnDz+/tPodQUpNymDF2WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739963144; c=relaxed/simple;
	bh=3cp//M/sV12YOFZI+shyC4DjWt4VB+LwS/H5wzGNXB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bQyOd5XVbks51L4F26O6YvMMES9vZwUlyIuwdwWwKouUl5cW29Kf5mzM8XeUDn1BzHCc+jCKdoF/3vuOAkKoFi+eHbetOY9+2/GkHxuLhliDKKzZR47iyx8W/G/eFAVt8AYtRQaPcwZ7M54m0qY3BhnPl8fIBj1ueavgKPQBhNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wu7YWX0p; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e5dd7b439e3so3075140276.1;
        Wed, 19 Feb 2025 03:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739963141; x=1740567941; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/KCPDNMeea6cvXpnHeNMu1dpiWDklh2TuU8J67WkP9o=;
        b=Wu7YWX0pnIkV5enxAmhMawgw8gCk3PDfxw0o2E7Qd7ze7l6aS+yi5jPh2nlEZNKlrd
         wc+AJJvKWkJCeqUrkCFL64s+q500iKN1eygxR+mERE9ip0lLdXuTogvaC1prUVQJfluE
         hz90Mjnjx5b2TqSKbEIzXxr6ZyDRaS60FBKkgFYrp63Jdgt18kyL+0vFk/duJb8JBRIP
         Lwu1V0NU0KPYywfjI3GG3Y2r+bN83jzvSdMJZR0+e8SWroEH2zaPBttX6qKz7LQIVSSJ
         cOgqDH5d3aqb+ioeyUYhX4cTUCyTgOJJU95xJkzXDfmJ8cZZBX82VR8UYwupUSTWjQ1t
         /4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739963141; x=1740567941;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/KCPDNMeea6cvXpnHeNMu1dpiWDklh2TuU8J67WkP9o=;
        b=H8A0SkA/givjAMplOsIWEDglilWWQexLL2Qss8s971jDZ1J/IEX40QFJdckII3lD4d
         VKmsr6H3kG4ciC9EXiAyblutmrib5KM7nR9jCgd5xF+JRpf6v4rLsBfrMNvzCnW0QoDe
         Mq5BrVEtqUbkEL6AacTSX/nNsUiqpX0CczNLIDHWg7D02F+2EqdZjQbLYeogKLSXA8mt
         0eCOHwX9M0+o4JZmk5Zo02OeF9QUFouANliM3SaIWpXkvz+M/d8PERJYntSXapr/Bdxf
         2QjYhRbrcnB2YhTdNDQKdrr1TzZKeiBUsQhJhugNpbJr6kXB7dAhgNH0e4PbpoPpnDTC
         fY2g==
X-Forwarded-Encrypted: i=1; AJvYcCUHeXHBivvRWFuSek8+DxNL01xYFj4A3/hivJM8sof0dszhnPTMazbD4pGOxUZPLglLQNIOMvy5stDW@vger.kernel.org, AJvYcCVJDZMAq8V8L6Le5OM/DlyRIm/j0JH5Q1px5C8tQHb5840lulynn6Bwyfq3EYLDK1jmaqx/dqgTshs=@vger.kernel.org, AJvYcCWG4Pz7PmJccVsV+z+nS7IkAld1Alm4I6+4JFND1ojwLu4vqLIiSh8ttEJirbofo9H5mJJCA/C0AqXq3wf6@vger.kernel.org, AJvYcCXTdOKfQ+yuc281uBDwX/Ojl68I4VcQZd0iFI4S5flAJqZpCsN9cQma2nRf6GVViYhXC9vgDbBs0NoiUVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPNx5SWoZq4xUUf/BZfrpmof3cBUmJX5f55hsdn1LJKL2DHO/W
	hftlaVpOkc+ashgOCCY2rSjvCgwggojCB4oYMcystKb2U1rNHRkEbSYiQ41lcIqLDz3sHv2z3jL
	WjNcCbjwm1vXGeFV0wFgRkA+2AHk=
X-Gm-Gg: ASbGnctqTLo/UP+xw2A5/ldMCwEzCfWbZ2jTbOGgeVNLbs174tvTejVdO72diEvPPNf
	KxiZSqsbw+Qicoit4EZxGFi142u80C4go4KDiAxCtQH/DEX55nEWEXCMDEdfsP8blgsEs0SKGAQ
	==
X-Google-Smtp-Source: AGHT+IFM7nPZ8tuQFLbd7DWBYfyE8wXlNRxQ8AMioKm2MbbUJCJH0PC+2gSNRcWOH4HRbsy98lSWob4Xz3NoErPmn1M=
X-Received: by 2002:a05:6902:2501:b0:e5b:1540:6c7d with SMTP id
 3f1490d57ef6-e5dc9536dbamr15187340276.49.1739963140849; Wed, 19 Feb 2025
 03:05:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219-isp-v1-0-6d3e89b67c31@gmail.com> <20250219-isp-v1-3-6d3e89b67c31@gmail.com>
 <16f6d4a2-2102-48b9-a0ae-b8c6595975b8@kernel.org> <CAMT+MTR7dhtt3SOMg0K3UakJQftqnc2S-rV41HdHtA+o9aSPug@mail.gmail.com>
 <20250219105326.GA31383@pendragon.ideasonboard.com>
In-Reply-To: <20250219105326.GA31383@pendragon.ideasonboard.com>
From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Date: Wed, 19 Feb 2025 12:05:29 +0100
X-Gm-Features: AWEUYZlUG9hH5el_Nj1wiDJlMQpA-IjzAT88JqmhR0NRl4eaH_UzxL_62EaFLEs
Message-ID: <CAMT+MTToVdm72ovNZ8ySySYe5fT99a0Y6bv02NKxADCBCe+pMQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] media: dt-bindings: Add Apple ISP
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Sven Peter <sven@svenpeter.dev>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Hector Martin <marcan@marcan.st>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-media@vger.kernel.org, imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Feb 2025 at 11:53, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> >
> > Those are board-specific and not discoverable via the ISP protocol.
>
> But they are settable through the ISP protocol, aren't they ? For
> instance, looking at isp-imx248.dtsi, the first four entries are
>
>         /* 1280x720 */
>         preset0 {
>                 apple,config-index = <0>;
>                 apple,input-size = <1296 736>;
>                 apple,output-size = <1280 720>;
>                 apple,crop = <8 8 1280 720>;
>         };
>
>         /* 960x720 (4:3) */
>         preset1 {
>                 apple,config-index = <0>;
>                 apple,input-size = <1296 736>;
>                 apple,output-size = <960 720>;
>                 apple,crop = <168 8 960 720>;
>         };
>
>         /* 960x540 (16:9) */
>         preset2 {
>                 apple,config-index = <0>;
>                 apple,input-size = <1296 736>;
>                 apple,output-size = <960 540>;
>                 apple,crop = <8 8 1280 720>;
>         };
>
>         /* 640x480 (4:3) */
>         preset3 {
>                 apple,config-index = <0>;
>                 apple,input-size = <1296 736>;
>                 apple,output-size = <640 480>;
>                 apple,crop = <168 8 960 720>;
>         };
>
> But I may be interested in capturing a 640x480 frame with cropping only
> and without scaling, with
>
> input-size = 1296x736
> output-size = 640x480
> crop = (328,128)/640x480
>
> Or I may want my cropped frame to be located in the upper-left corner:
>
> input-size = 1296x736
> output-size = 640x480
> crop = (8,8)/640x480
>
> If I set those parameters through the ISP protocol, won't it work ?
>
> --
> Regards,
>
> Laurent Pinchart

For cropping - you do not want to change those parameters, the sensor
is partially occluded, and the crop area is specified in such a way
to not expose those pixels. As for scaling - we can expose only the 1:1
scale and let userspace deal with it, but it appears that it expects
the other common output sizes to exist.

