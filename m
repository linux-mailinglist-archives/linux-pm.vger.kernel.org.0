Return-Path: <linux-pm+bounces-40700-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82772D16B3B
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 06:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 801FE3011B2C
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 05:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6447D284883;
	Tue, 13 Jan 2026 05:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=summations-net.20230601.gappssmtp.com header.i=@summations-net.20230601.gappssmtp.com header.b="T0LX/2xk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD60F23AB81
	for <linux-pm@vger.kernel.org>; Tue, 13 Jan 2026 05:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768282329; cv=none; b=IF0KsiOotWsY0DbMPMDPS+Xjejh1hZgRUjg8zZxMAaRWQAchkmBss+kgeOz5PF5VwTdF1cLBeH124Bzg6pqsSFPGSwmiHc7GHvva1L119e5y1aoBCpxAwKolQHGfG4rWEjBHWewYPfcjiNS0EfTxAQ+Fgdvv5Z1HchgRl51ajlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768282329; c=relaxed/simple;
	bh=NZl5a9oJSVbgl2RISi16U73Rp9GHxWVa3xTYWKGHssA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LDZje9LSJRnyWoMsNMmNmN51n6ITADccYBAdxmxA11Kw3DiU4eD3w8jr/U5v7hNWs1m0TDbC84Z3Sdd0vIVUA72lDiSUQprKD/3ebF+DfAdS2K5VGrzk8PLnMd/k6JWexpt3h03L9Aly73jdMNSkp8OBaHnJUY9I4x9BTaYajwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=summations.net; spf=pass smtp.mailfrom=summations.net; dkim=pass (2048-bit key) header.d=summations-net.20230601.gappssmtp.com header.i=@summations-net.20230601.gappssmtp.com header.b=T0LX/2xk; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=summations.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=summations.net
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64661975669so7725487d50.3
        for <linux-pm@vger.kernel.org>; Mon, 12 Jan 2026 21:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=summations-net.20230601.gappssmtp.com; s=20230601; t=1768282327; x=1768887127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sy4LMdldTGwISdglwEP/iBB5uJvH/fDPeL6tN/GI50Q=;
        b=T0LX/2xkmQ3a2phC+4QiDIY/3RiGK36BDngf/31gyjRFqlcQbEjVXey5sdkd4+2UvZ
         b4XKFhRSb6vUe8JyrGGaEP33j91ts9OPquWSk87ESmSat0LzLUVlSFunsQVpARD//wQ9
         XRDysJFxDDGhkKl1D3muczxFrnRxouiekirAUml/ap/qTfklBCaQf23s2GGjyuZxBZ0j
         x5G2RrStLPRHS+xc8nkbEWiIQD5zSJYB2iXyNdEGTm9AVV7IlSHunsUX/YMtDGKUCGkZ
         BLXqM6TF86X0LvEhtXHF5fDafXnFlfMvIlA0Pa8LDmw/BfZGoUchl7FdvCTN5yQp/73p
         YlyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768282327; x=1768887127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Sy4LMdldTGwISdglwEP/iBB5uJvH/fDPeL6tN/GI50Q=;
        b=PSTfm/5RGotsO8Y+Jxsy10/ny0GVATWJY0RhjLx8FU1sjemtVh/Uubukr9otCoJ1rJ
         lA8ZtIhlNKUDa918k9rF+0BmgW55cInXiaWaF6nNSW8NrumTgPrRKvW+dOG0E0jcmpe5
         7YQOiDs8ENHs5eHFKAcZHeuVl3X7+8NFAt9DyiAhLUQwzBJmRRUymWTLoejEXQCaWHuW
         t5WCAjVilyIM2WCWQFzAIwbRk5AHwksVZgxUBDxYTCH9OnIBVNxfUyVBk0bbubLRFVvc
         kHvHi+Hj2hzzOw726h/Oei2vKn73Tqu6oN3aEtzK33kNOV/4bOagi6HtM8XMPNAG4TDv
         MjKw==
X-Forwarded-Encrypted: i=1; AJvYcCXTX5ZhMgUBKiv2la8/TXTO+CfBj8G8VSDQ51KOZgAd3zpfX8BWKaLXurZ4DM2MhD8oczhg8jX+/w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8ke+QQB+ao2mypyPFnqqdHlM+wQY2UdrR7m3cWWCvvFbvhgZc
	XxYHPyTW2JfcFAyIiQEc4Muzy0AUHrLMGvNbsz2oNDF8zrgUWdi+JslBY+qo51vdpuCI5KMSUAu
	LfAVaKtHojEnlRyVxhw+uj+0W+WXQ5xUAMW8XQE0FltY=
X-Gm-Gg: AY/fxX5/gb+ZK5WYQ0G+oCdD7U7pd7PiZBgOd9xbBrBaahBFEumCnsVvAqJEny99eoy
	A4YIR6pw5khhCTcD3xYXuvEqG6+kSymivjJ7ENLT+U/7hAK0f/altJ+DsKiUBuPWdFTc8M/BEzZ
	9+00qXUWt5Hjz2neWgvEGEbG+tdKI2L+n68Lc7LEAGxOrCPAhunyz2vXP3LajehjekA/pP27/Nr
	iCqcSfZ/2LtYSaOyNLguSciucHZKjXsjeMoHyakzhhADo9U3A5hLdoviBMpqkkUZdINryPwfA==
X-Google-Smtp-Source: AGHT+IExqIdWS0cjfIxtkM38Mzck94Xq9kYShJuru8AXTnzNUNT6kOmvzgIPXGX80q+0JKl1Y4AKJl2QiWpSOmYRDGI=
X-Received: by 2002:a05:690e:120f:b0:641:f5bc:696c with SMTP id
 956f58d0204a3-64716c60119mr16680207d50.72.1768282326574; Mon, 12 Jan 2026
 21:32:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106092117.3727152-1-joshua.yeong@starfivetech.com>
 <20260106092117.3727152-5-joshua.yeong@starfivetech.com> <CABdD5xmVVkQu6rYzF52V-JrsdL=NOQa9N9i8PsMgfaOh3GT-Bg@mail.gmail.com>
 <SH0PR01MB0841EF813268269C2AE59372F98E2@SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn>
In-Reply-To: <SH0PR01MB0841EF813268269C2AE59372F98E2@SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn>
From: Rahul Pathak <rahul@summations.net>
Date: Tue, 13 Jan 2026 11:01:55 +0530
X-Gm-Features: AZwV_QjboB7fQnipHJLOjXWMnr27h-8kUlIUc9Twa974XLrlL36DjBouoLomDys
Message-ID: <CABdD5x=T0pXWCSHL+An2Nwsaz-kbYnGga5vt0OfdCwm-o493Dw@mail.gmail.com>
Subject: Re: [PATCH 4/5] cpufreq: Add cpufreq driver for the RISC-V RPMI
 performance service group
To: Joshua Yeong <joshua.yeong@starfivetech.com>
Cc: "anup@brainfault.org" <anup@brainfault.org>, Leyfoon Tan <leyfoon.tan@starfivetech.com>, 
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, 
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "pjw@kernel.org" <pjw@kernel.org>, 
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, 
	"alex@ghiti.fr" <alex@ghiti.fr>, "rafael@kernel.org" <rafael@kernel.org>, 
	"viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "sboyd@kernel.org" <sboyd@kernel.org>, 
	"jms@oss.tenstorrent.com" <jms@oss.tenstorrent.com>, 
	"darshan.prajapati@einfochips.com" <darshan.prajapati@einfochips.com>, 
	"charlie@rivosinc.com" <charlie@rivosinc.com>, 
	"dfustini@oss.tenstorrent.com" <dfustini@oss.tenstorrent.com>, 
	"michal.simek@amd.com" <michal.simek@amd.com>, "cyy@cyyself.name" <cyy@cyyself.name>, 
	"jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>, 
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 8:05=E2=80=AFAM Joshua Yeong
<joshua.yeong@starfivetech.com> wrote:
>
> On Monday, January 12, 2026 6:47 PM, Rahul Pathak <rahul@summations.net> =
wrote:
>
> > > +
> > > +static int rpmi_cpufreq_probe(struct platform_device *pdev) {
> > > +       struct device *dev =3D &pdev->dev;
> > > +       struct rpmi_perf *mpxy_perf;
> > > +       struct rpmi_ctx *mpxy_ctx;
> > > +       int num_domains =3D 0;
> > > +       int ret, i;
> > > +
> > > +       mpxy_ctx =3D devm_kzalloc(&pdev->dev, sizeof(*mpxy_ctx), GFP_=
KERNEL);
> > > +       if (!mpxy_ctx)
> > > +               return -ENOMEM;
> > > +
> > > +       /* Setup mailbox client */
> > > +       mpxy_ctx->client.dev            =3D dev;
> > > +       mpxy_ctx->client.rx_callback    =3D NULL;
> > > +       mpxy_ctx->client.tx_block       =3D false;
> > > +       mpxy_ctx->client.knows_txdone   =3D true;
> > > +       mpxy_ctx->client.tx_tout        =3D 0;
> > > +
> > > +       /* Request mailbox channel */
> > > +       mpxy_ctx->chan =3D mbox_request_channel(&mpxy_ctx->client, 0)=
;
> > > +       if (IS_ERR(mpxy_ctx->chan))
> > > +               return PTR_ERR(mpxy_ctx->chan);
> > > +
> > > +       ret =3D rpmi_cpufreq_attr_setup(dev, mpxy_ctx);
> > > +       if (ret) {
> > > +               dev_err(dev, "failed to verify RPMI attribute - err:%=
d\n", ret);
> > > +               goto fail_free_channel;
> > > +       }
> > > +
> > > +       /* Get number of performance domain */
> > > +       ret =3D rpmi_perf_get_num_domains(mpxy_ctx, &num_domains);
> > > +       if (ret) {
> > > +               dev_err(dev, "invalid number of perf domains - err:%d=
\n", ret);
> > > +               goto fail_free_channel;
> > > +       }
> >
> > The domain space in RPMI performance for CPU and Device is not separate=
 and a domain can be either CPU or a Device.
> > How the driver will make sure that the domains which are returned are C=
PU only and not the device.
>
> I think we need to enhance the RPMI spec to include information for types=
 of device.
> What do you think?
>
> >

Yes

