Return-Path: <linux-pm+bounces-43635-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DAmIR/wqGkwzAAAu9opvQ
	(envelope-from <linux-pm+bounces-43635-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 03:53:19 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E588320A578
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 03:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C06B13058560
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2026 02:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C50826ED41;
	Thu,  5 Mar 2026 02:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qXA5KvPS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3876626D4C7
	for <linux-pm@vger.kernel.org>; Thu,  5 Mar 2026 02:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772679146; cv=none; b=mXv1HdM0+0dTiY0bpbhl6S+WJNCGJNEYkpz08UarrhMRNka9Z/yf5IV0JqRryVkmk7YepC0t3r4f/oVReZzv0NeQc88GiKdOYOZVJGq4QwYaJxArDYO3//MvPMg/UWeF6Y8rw+fYkgTOS5PpOZ2d0ZFBfUX6jogY+zIt/Iwh9Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772679146; c=relaxed/simple;
	bh=02fIQkRhxEYW6dcEHiMxZAUWzpvF05ukxv85t9Jzd+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hFPeR4WlZLfqasQtelqDrqYWkEZmtJ6ddmC/RQnt94KSIlzOZvHXaJMkDAjZhxqF4vVJb0FmzVtS03BnqhYIouK1xEfLXS//74mdThBySM4zJQBTJhv/zSsBFtquUb8MEHP8DnCPR6yaGW7z4F+4FS8bMUBAHThqWrlDngfTDuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qXA5KvPS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1743BC2BC86
	for <linux-pm@vger.kernel.org>; Thu,  5 Mar 2026 02:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772679146;
	bh=02fIQkRhxEYW6dcEHiMxZAUWzpvF05ukxv85t9Jzd+Y=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=qXA5KvPSQzJIIWLPLJ96R6w5kHhq5MbDYgov+/4fVtPDJPnYbVf4yIrAl6ssp8jpr
	 5l3VNR8Q/wdSytoRHnsfVgpgF7+4b0ZlYhJi3oVr8cIrnx54lMEjwvHRB8hL/Y4DmL
	 9PjDB5cUzWu2fitmFQmrTN/rRWhChY16EchnyDS+67xhGyxIaF4z+6f5jaXKgfP7ge
	 g/2fiuZdJ4gRgrvyfI4Drx7pgwxh+SR9GR7Gp6FOHYGjuuC2a+bFk70RbElmyspASS
	 XxI1taANAY3SS0XtSU7oNa8VjORrqqKYMvYEKQixqI4fOReX6GCrfv+HMAT1R7Ur6B
	 8SRO8G3cjIyRA==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-38a2e62b893so17965511fa.1
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 18:52:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW0s1eeouCa6vXttaoi2ZHHcfGZqvXnpKAMSjgbySh5EDJIumXM3umSppUqDUjSnjgHU5G7LH5F/w==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq3XNnFnyLPg0s8XNHhvjSXjQKFUJa9b13TzcCKtQjnsedh8ki
	eENLKZMPIraRq0zIvwovb9Xt78ba5S69brXfEWyzRcbA8OgdB2Zo7jST1vPr15KJ1SuVwFGqEyZ
	Rj6Lv5LXjr2oUcUdRhpZa266G1nfPbuo=
X-Received: by 2002:a05:651c:b2c:b0:38a:2fea:ba2 with SMTP id
 38308e7fff4ca-38a2fea0e1cmr20133451fa.32.1772679144245; Wed, 04 Mar 2026
 18:52:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304-b4-pck600-a733-v1-0-2f54efdb8cc2@gmail.com>
 <20260304-b4-pck600-a733-v1-2-2f54efdb8cc2@gmail.com> <CAGb2v64n_8RyWDieUKvbpkTikipB9ZvqEscYRRLowe+rvaJKCQ@mail.gmail.com>
 <aajLNxYvDrpT-qqC@c67c70be8272>
In-Reply-To: <aajLNxYvDrpT-qqC@c67c70be8272>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Thu, 5 Mar 2026 11:52:11 +0900
X-Gmail-Original-Message-ID: <CAGb2v64uXxYYv=+3BVcwDWF247nUqs2EJY81HGsmdPVMdx7e3w@mail.gmail.com>
X-Gm-Features: AaiRm51B2kVDtM7bVFXZG0Lk1v7ZAfduJLHvMt3hmZ_YUmknvYKrQ94jheC8D5g
Message-ID: <CAGb2v64uXxYYv=+3BVcwDWF247nUqs2EJY81HGsmdPVMdx7e3w@mail.gmail.com>
Subject: Re: [PATCH 2/2] pmdomain: sunxi: Add support for A733 to Allwinner
 PCK600 driver
To: Yuanshen Cao <alex.caoys@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Ulf Hansson <ulf.hansson@linaro.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: E588320A578
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43635-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,sholland.org,linaro.org,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[wens@kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wens@kernel.org,linux-pm@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, Mar 5, 2026 at 9:15=E2=80=AFAM Yuanshen Cao <alex.caoys@gmail.com> =
wrote:
>
> On Wed, Mar 04, 2026 at 10:33:23PM +0900, Chen-Yu Tsai wrote:
> > On Wed, Mar 4, 2026 at 12:44=E2=80=AFPM Yuanshen Cao <alex.caoys@gmail.=
com> wrote:
> > >
> > > The Allwinner A733 PCK600, similar to A523 PCK600, is likely a
> > > customized version of ARM PCK-600 power controller. It shares
> > > the same BSP driver with A523. According to the BSP provided
> > > by Radxa, unlike A523, it doesn't require reset.
> > >
> > > Make reset optional in the sunxi pck600 driver and add support
> > > for A733.
> > >
> > > Signed-off-by: Yuanshen Cao <alex.caoys@gmail.com>
> > > ---
> > >  drivers/pmdomain/sunxi/sun55i-pck600.c | 53 ++++++++++++++++++++++++=
++++++----
> > >  1 file changed, 48 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/pmdomain/sunxi/sun55i-pck600.c b/drivers/pmdomai=
n/sunxi/sun55i-pck600.c
> > > index c7ab51514531..8f9fdc3915bd 100644
> > > --- a/drivers/pmdomain/sunxi/sun55i-pck600.c
> > > +++ b/drivers/pmdomain/sunxi/sun55i-pck600.c
> > > @@ -52,6 +52,7 @@ struct sunxi_pck600_desc {
> > >         u32 logic_power_switch0_delay;
> > >         u32 logic_power_switch1_delay;
> > >         u32 off2on_delay;
> > > +       bool has_rst_clk;
> > >  };
> > >
> > >  struct sunxi_pck600_pd {
> > > @@ -151,9 +152,11 @@ static int sunxi_pck600_probe(struct platform_de=
vice *pdev)
> > >         if (IS_ERR(base))
> > >                 return PTR_ERR(base);
> > >
> > > -       rst =3D devm_reset_control_get_exclusive_released(dev, NULL);
> > > -       if (IS_ERR(rst))
> > > -               return dev_err_probe(dev, PTR_ERR(rst), "failed to ge=
t reset control\n");
> > > +       if (desc->has_rst_clk) {
> > > +               rst =3D devm_reset_control_get_exclusive_released(dev=
, NULL);
> > > +               if (IS_ERR(rst))
> > > +                       return dev_err_probe(dev, PTR_ERR(rst), "fail=
ed to get reset control\n");
> > > +       }
> > >
> > >         clk =3D devm_clk_get_enabled(dev, NULL);
> > >         if (IS_ERR(clk))
> > > @@ -193,7 +196,14 @@ static int sunxi_pck600_probe(struct platform_de=
vice *pdev)
> > >  }
> > >
> > >  static const char * const sun55i_a523_pck600_pd_names[] =3D {
> > > -       "VE", "GPU", "VI", "VO0", "VO1", "DE", "NAND", "PCIE"
> > > +       "VE",
> > > +       "GPU",
> > > +       "VI",
> > > +       "VO0",
> > > +       "VO1",
> > > +       "DE",
> > > +       "NAND",
> > > +       "PCIE",
> >
> > No need to change this part.
> >
>
> Yes, I agree. But since A733 has more pd_names, that line will be too
> long if we stick with one line. And we also used this format in
> sun20i-ppu. It might make more sense if we align with ppu. Please let
> me know what you think. Thanks!

I prefer fewer lines. And you can have more than one line even if you
put multiple names per line. The ppu driver is a different file, so I
didn't bother changing that one.

ChenYu

> > >  };
> > >
> > >  static const struct sunxi_pck600_desc sun55i_a523_pck600_desc =3D {
> > > @@ -206,7 +216,36 @@ static const struct sunxi_pck600_desc sun55i_a52=
3_pck600_desc =3D {
> > >         .device_ctrl1_delay =3D 0xffff,
> > >         .logic_power_switch0_delay =3D 0x8080808,
> > >         .logic_power_switch1_delay =3D 0x808,
> > > -       .off2on_delay =3D 0x8
> > > +       .off2on_delay =3D 0x8,
> > > +       .has_rst_clk =3D true,
> > > +};
> > > +
> > > +static const char * const sun60i_a733_pck600_pd_names[] =3D {
> > > +       "VI",
> > > +       "DE_SYS",
> > > +       "VE_DEC",
> > > +       "VE_ENC",
> > > +       "NPU",
> > > +       "GPU_TOP",
> > > +       "GPU_CORE",
> > > +       "PCIE",
> > > +       "USB2",
> > > +       "VO",
> > > +       "VO1",
> > > +};
> > > +
> > > +static const struct sunxi_pck600_desc sun60i_a733_pck600_desc =3D {
> > > +       .pd_names =3D sun60i_a733_pck600_pd_names,
> > > +       .num_domains =3D ARRAY_SIZE(sun60i_a733_pck600_pd_names),
> > > +       .logic_power_switch0_delay_offset =3D 0xc00,
> > > +       .logic_power_switch1_delay_offset =3D 0xc04,
> > > +       .off2on_delay_offset =3D 0xc10,
> > > +       .device_ctrl0_delay =3D 0x1f1f1f,
> > > +       .device_ctrl1_delay =3D 0x1f1f,
> > > +       .logic_power_switch0_delay =3D 0x8080808,
> > > +       .logic_power_switch1_delay =3D 0x808,
> > > +       .off2on_delay =3D 0x8,
> > > +       .has_rst_clk =3D false,
> > >  };
> > >
> > >  static const struct of_device_id sunxi_pck600_of_match[] =3D {
> > > @@ -214,6 +253,10 @@ static const struct of_device_id sunxi_pck600_of=
_match[] =3D {
> > >                 .compatible     =3D "allwinner,sun55i-a523-pck-600",
> > >                 .data           =3D &sun55i_a523_pck600_desc,
> > >         },
> > > +       {
> > > +               .compatible     =3D "allwinner,sun60i-a733-pck-600",
> > > +               .data           =3D &sun60i_a733_pck600_desc,
> > > +       },
> > >         {}
> > >  };
> > >  MODULE_DEVICE_TABLE(of, sunxi_pck600_of_match);
> > >
> > > --
> > > 2.53.0
> > >
>

