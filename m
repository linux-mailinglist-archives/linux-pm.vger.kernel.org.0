Return-Path: <linux-pm+bounces-20395-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD6EA0FE20
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 02:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA45F1888E45
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 01:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14B42288C7;
	Tue, 14 Jan 2025 01:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSHX1Lb/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0B1228375;
	Tue, 14 Jan 2025 01:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736818279; cv=none; b=nwXYH3ubTAfyt10Kp3nP5qzeDOR07lPBpYJ4i1052+xPD+6vV1wPXVCTAU8YvjAfxeyf0qvrz07DSxldPkD9OmjuqyCVnYckf1yv5CPji/sCH0GqLsGkp50YtZ7g+/T1g4IhiSDKSKam3p801PkjgKCOzvyzt92cd2iMS0ZrHTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736818279; c=relaxed/simple;
	bh=RAc8JMWGHAEq/1zAnmcjYAkTf3sEC2U7lszSqnBPbgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uDZrkWN4NuK2BiL0roz+B4bItDS3VUY3nabFIhWfBOivopqvk/c6G0bhjFjwkmzaqAOWMeA/vNh2Jxmvqa9k0rlBqtPpc5g1+1JExqgHaH/HV8F7EjPZJ9hsz/YKv5zhQ1M8JZyZsQqEPFuFaTGFWWcSALefyq/w7uGQ+LGBGUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSHX1Lb/; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-303548a933aso39671811fa.3;
        Mon, 13 Jan 2025 17:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736818275; x=1737423075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/aU6EnYM1FFu/Ni2NC3JHueKkzhR3f1t7juJ8cBXKNg=;
        b=iSHX1Lb/SpRcZa+M00t8k9oFku+PU0EmuC5PPQIXMgMn8rKaT44UXFucMgwgVpFgFy
         Yy7QX6HiQ7yfmW8xANW6uo07xIsZJhM+FCB2R4vt4FIPMBARyCTQUrohvCox/hTMDTJU
         RbFBc+4hPVYbGpZbqu4akW0f1/FF1nEMo1Pf2nkeibvWV6zXIHb6rY0QMbO+R1zOIhRk
         nOjFG0GRwEdCMZgExdiJ4EZg/evBQSrDb8tAdS+DYJpep24MW5oqeIzd9rVCaJ/au66X
         dy/pLXsVWA6ill7zwWi7syQtazRNAKG0i1dxxp6qQieWlry2bvGgvivUbbNQ20iGKtIx
         TQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736818275; x=1737423075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/aU6EnYM1FFu/Ni2NC3JHueKkzhR3f1t7juJ8cBXKNg=;
        b=QFzEb5MkibkaX3aAWNd6whshGqagpKs4t36c37S1uz7nD0K0Oy13xQiUzUvuHcWNAq
         msCqrNnrvNSuKs5SkzVUsNrQKCt0VI8PHArotgGDgHYFV8ryQylqEXc+TBIVizU5R3WI
         NSyWhA+CDM28Ot6Qm7RUG3bkqseYurwgvFSWSIkFkPjcbPD6Kpo+smpyT4JeL2UxBPak
         A4GE1FZd2bmpN4ANZF2BU5uVGiHesTaxz7T4vPFqMsOIBA6RYv1KzvhoQ0FZbrNox/St
         QJmNHKHpCtb+JtioAwA+kcKQXQ0o97Zb/Q5oIcLxgFiu90kaL52sA9715za0CMSD8pkw
         Dnpg==
X-Forwarded-Encrypted: i=1; AJvYcCXJJv4LbnTZHX7puqlbZgmOUi1F4E1CTr4j5ivK5lFf6HWqb9XBnjR+Md2yq1EVYE8GunQy8AfEokc4eTI=@vger.kernel.org, AJvYcCXysCgSbjrJkMoC6Ls/maU296mNYwS2Ro1rMssnnN4cz2/AChDAWnPNITrbZcWhDMaLYDUfcRf2MPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFI9Fd+mM1l4zf32YmbEv+Zg1Mo0skdp4wKbpEUZHUBhJjjcWL
	+hRnBHR6AW3qpU7950QbA3Cw3/bdT97odkx5iBwypwjIFkxH0akQvYFtA8Ih+JWPKTM4uXqOxJG
	79MsXkoBwou7qpKECZyEHTXvf37U=
X-Gm-Gg: ASbGncv3QAel1yzvGFTVcPgftsXTrYkT6bTBkolt1YL5gKPPXR3Ki2kWt0Q3/fQGsAe
	HwN8lE7Iq9P5B7E02NbUdtnjoOgZ7MpWawY5/+Y56++yEOqDFhuXFvtH1Q93Smnlb2rPsng==
X-Google-Smtp-Source: AGHT+IEUJmr5CzHShAQpgO68JDpagn9ocRTq7BeVsW6j7XDBWpIfZvawE2F15mzspC+LVxD1aFCcu76BGOg5HtppGiQ=
X-Received: by 2002:a2e:be10:0:b0:302:52a8:243 with SMTP id
 38308e7fff4ca-305f45db514mr82377271fa.30.1736818274651; Mon, 13 Jan 2025
 17:31:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250114011818.2401479-1-xiaolei.wang@windriver.com>
In-Reply-To: <20250114011818.2401479-1-xiaolei.wang@windriver.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 13 Jan 2025 22:31:03 -0300
X-Gm-Features: AbW1kvYlHMYh_9BWfuP0hql59S9fdsu1xJunec-2pANaEdOBUzmqZvZq2hVMDbI
Message-ID: <CAOMZO5BpBjPhr3Y_+28ob48N-6GMaA640=d=VTVxfz=vq5PV7A@mail.gmail.com>
Subject: Re: [PATCH v2] pmdomain: imx8mp-blk-ctrl: add missing loop break condition
To: Xiaolei Wang <xiaolei.wang@windriver.com>
Cc: ulf.hansson@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, ping.bai@nxp.com, l.stach@pengutronix.de, 
	marex@denx.de, aford173@gmail.com, linux-pm@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 10:18=E2=80=AFPM Xiaolei Wang
<xiaolei.wang@windriver.com> wrote:
>
> Currently imx8mp_blk_ctrl_remove() will continue the for loop
> until an out-of-bounds exception occurs.
>
> pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> pc : dev_pm_domain_detach+0x8/0x48
> lr : imx8mp_blk_ctrl_shutdown+0x58/0x90
> sp : ffffffc084f8bbf0
> x29: ffffffc084f8bbf0 x28: ffffff80daf32ac0 x27: 0000000000000000
> x26: ffffffc081658d78 x25: 0000000000000001 x24: ffffffc08201b028
> x23: ffffff80d0db9490 x22: ffffffc082340a78 x21: 00000000000005b0
> x20: ffffff80d19bc180 x19: 000000000000000a x18: ffffffffffffffff
> x17: ffffffc080a39e08 x16: ffffffc080a39c98 x15: 4f435f464f006c72
> x14: 0000000000000004 x13: ffffff80d0172110 x12: 0000000000000000
> x11: ffffff80d0537740 x10: ffffff80d05376c0 x9 : ffffffc0808ed2d8
> x8 : ffffffc084f8bab0 x7 : 0000000000000000 x6 : 0000000000000000
> x5 : ffffff80d19b9420 x4 : fffffffe03466e60 x3 : 0000000080800077
> x2 : 0000000000000000 x1 : 0000000000000001 x0 : 0000000000000000
> Call trace:
>  dev_pm_domain_detach+0x8/0x48
>  platform_shutdown+0x2c/0x48
>  device_shutdown+0x158/0x268
>  kernel_restart_prepare+0x40/0x58
>  kernel_kexec+0x58/0xe8
>  __do_sys_reboot+0x198/0x258
>  __arm64_sys_reboot+0x2c/0x40
>  invoke_syscall+0x5c/0x138
>  el0_svc_common.constprop.0+0x48/0xf0
>  do_el0_svc+0x24/0x38
>  el0_svc+0x38/0xc8
>  el0t_64_sync_handler+0x120/0x130
>  el0t_64_sync+0x190/0x198
> Code: 8128c2d0 ffffffc0 aa1e03e9 d503201f
>
> Fixes: 556f5cf9568a ("soc: imx: add i.MX8MP HSIO blk-ctrl")
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

Thanks for the fix:

Reviewed-by: Fabio Estevam <festevam@gmail.com>

