Return-Path: <linux-pm+bounces-7671-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7238C03A6
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 19:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC691280DB9
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 17:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F72435F18;
	Wed,  8 May 2024 17:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RuTHulvN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB8112A17D;
	Wed,  8 May 2024 17:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715190477; cv=none; b=aMdF9xSKqPRPyBHF3PuJgcKicpF0nmgtFhEqJRLW7YZ5JBTO546aeLQW9bd9psfnfmuURpT4KgmUCEJ7/kSGf8Lo3lbDIBPx0WgH6cAAaCHZ4X0UrY2rr0zS5w7cp1WM2PY4u7vEC0ldegOJnBHKefqSQ8luxPDZDSuh8di4srQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715190477; c=relaxed/simple;
	bh=NIDVWllLarpxWInOUxzM8dpHdna/DzDLUzvnxbWU01g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I7uI9aw8e2m+yWghhC9SRsqhVxUzumlM+dWBAJATGaU0kS1ztv5M0lOs+PkqUYE6cPYuwVVG2aL60YlH2DvrkYp80aRoObgisBPXaa2fN86WL7NuMM5oul2gf+c5Acb8vguJrn14ih5CZQ8OnFOlfxJuKf8aANmYEoPpdiTx4pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RuTHulvN; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-de5a7b18acdso20022276.3;
        Wed, 08 May 2024 10:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715190474; x=1715795274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=04e9lsEENEtBo6Y1Ejz9Hf/22A/cgbyXH7aOe7PkMlI=;
        b=RuTHulvNKeCiHfJi7meJRQA5KizwX3s3ijSZBpVHu41tLa8Bj+u+bZXdIDsSllJVEq
         scU8i9/1DcdsiCWj1Sdp8eYe0vw+klD8K8w9PZoyawJ8PJzuQ8rlAsJotW16+sIcjRF9
         SftU7d3q9Y00jkrwc/Ooro/zgN5Kb5vnAprlVpU25IBSrf1K1PUZx1HBgP9hBZBIvByq
         d30wj2xnc0K6bkjHAi0iIrHpV6B6R47tbklnr/ot3r3aG7Qg7i91ilk5T87ka7adjt3E
         N6GLjncYNjZ77rR+Buv9aEn7qxmpbdXOWwcU778QyaMKA+0+K10ZmS99xkWZpz0T7H+B
         IQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715190474; x=1715795274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=04e9lsEENEtBo6Y1Ejz9Hf/22A/cgbyXH7aOe7PkMlI=;
        b=m/SRiTVvim7JJSFbaKUfgaC3T788o9R1O6QMwPdApXr1c/6qvSl9nRT1lzXz6ctFzQ
         BWHGBwyfOyAZE+1HDhhcybZ2SNGgPCUuQl8duMXSxKp37JAjQfWgIT/VlCd7ui7d1hcf
         9+TUtjA+kWRDRQrACeHVS9uogoPjnlB5Nluucr+wBdtzrtngO2UpXG0n9Iz5bYD0FFKM
         AZuxljHpYJfKlvsb847Y722CqI9NblQTTNHAePnFcPZL6A6r2DZkS618HXKeAddLCaMb
         PN/baWpUb0zN62hHlGqvCbFKMEe9iLNjFgKSoFAjRmBJSmtvqNIp7DJQV1Vo/8H8Vh1j
         YaBA==
X-Forwarded-Encrypted: i=1; AJvYcCXP4s+p4nHWRwGth4vJnF0Y3Vt0CkYLhq6y91FnvDZmPo8lviOksbX1qFgHsoyU1DRtn+/1MlBwWiOfDzPXd6dHbLeRoM45K/o5t+gydGnRHyGArszG5XB5fhGSAdmUHtARjUCIDr0=
X-Gm-Message-State: AOJu0Yz904UbM7Z0nxPjunJsGOXSWFzQBUlCW9DZdPiRg8OzbSbTG6b9
	V/F9W7LbzCju+tIAqULCPckRC77sCzVuS1opfOaZ0dkE4NP07fnDGWsQTj7+oIToKR1g81EAaJd
	7HxNBahrkNUAmh6XScDayDGaTkl1xoA==
X-Google-Smtp-Source: AGHT+IEqDuf6npYt7VEKOfS3+IldIr1XFvhfpyFy1EIIxsihAUcRdMjYbWrSBteTu6lo4K6q6rBf6MjFuFXKEqlq8JI=
X-Received: by 2002:a5b:609:0:b0:de5:4b1f:7e00 with SMTP id
 3f1490d57ef6-debb9d27bc8mr3109777276.15.1715190474410; Wed, 08 May 2024
 10:47:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fccbb040330a706a4f7b34875db1d896a0bf81c8.camel@gmail.com>
 <4e781d80fbec0db13555456ab8af6bdae6dee168.camel@gmail.com>
 <CAHCN7xJF1=BNgh=wpsyd6WP=haOq2UdCYEt2AaL7rGfhDUh6CQ@mail.gmail.com> <8636fb8d9809aaafbd8274ec0dbfc250e1113c73.camel@pengutronix.de>
In-Reply-To: <8636fb8d9809aaafbd8274ec0dbfc250e1113c73.camel@pengutronix.de>
From: Adam Ford <aford173@gmail.com>
Date: Wed, 8 May 2024 12:47:41 -0500
Message-ID: <CAHCN7x+L1RzT5EmOLaFcHmkSMS2pG0NVyWnRo-ZqhLpLEftBSg@mail.gmail.com>
Subject: Re: iMX8M Mini suspend/resume hanging on imx8m_blk_ctrl_power_on()
To: Lucas Stach <l.stach@pengutronix.de>
Cc: vitor <ivitro@gmail.com>, linux-pm@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	vitor.soares@toradex.com, ulf.hansson@linaro.org, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	rafael@kernel.org, geert+renesas@glider.be, peng.fan@nxp.com, 
	linus.walleij@linaro.org, u.kleine-koenig@pengutronix.de, marex@denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 12:45=E2=80=AFPM Lucas Stach <l.stach@pengutronix.de=
> wrote:
>
> Hi Adam,
>
> Am Mittwoch, dem 08.05.2024 um 12:30 -0500 schrieb Adam Ford:
> > On Fri, Apr 5, 2024 at 10:09=E2=80=AFAM vitor <ivitro@gmail.com> wrote:
> > >
> > > Hi,
> > >
> > > On Thu, 2024-04-04 at 16:53 +0100, vitor wrote:
> > > > Greetings,
> > > >
> > > > I'm trying to suspend/resume our Verdin iMX8M Mini with VPU IP usin=
g
> > > > the latest 6.9.0-rc2 Kernel. While the system can suspend without
> > > > issues, it hangs on the resume routine. After some investigation, I
> > > > can
> > > > see the Kernel hanging on imx8m_blk_ctrl_power_on()[1] while resumi=
ng
> > > > the hantro-vpu power domain.
> > > >
> > > > Any hint about that?
> > > >
> > > > [1]
> > > > https://elixir.bootlin.com/linux/v6.9-rc2/source/drivers/pmdomain/i=
mx
> > > > /imx8m-blk-ctrl.c#L101
> > > >
> > >
> > + Lucas
> >
> > > Looking at other child nodes of the pgc node, pgc_vpu_[g1|g2|h1] seem=
s
> > > to be nested into pgc_vpumix.
> > >
> >
> > On the surface, that's how it appears and it would be consistent with
> > how the GPU's work with the GPC's for each GPU calling the gpumix.
> > However, the VPU's all reference the vpu_blk_ctrl which itself
> > references the vpumix.
> >
> > Lucas,
> >
> > You seem to know this driver pretty well.  Do you expect the G1, G2,
> > and H1 PGC's to all reference the vpumix, or do you expect the
> > vpu_blk_ctrl to enable/disable the vpumix?
> >
> Nope, that's incorrect, as discussed here:
> https://lore.kernel.org/all/9ce35b9bb5a15891f6bd01bd54b7dc84b3ba4021.came=
l@pengutronix.de/

That's what I thought.
>
> >
> >
> > > After applying the following changes to imx8mm.dtsi, the suspend/resu=
me
> > > is working.
> > >
> > >
> > > @@ -739,16 +739,19 @@ pgc_vpumix: power-domain@6 {
> > >         pgc_vpu_g1: power-domain@7 {
> > >                 #power-domain-cells =3D <0>;
> > >                 reg =3D <IMX8MM_POWER_DOMAIN_VPUG1>;
> > > +               power-domains =3D <&pgc_vpumix>;
> > >         };
> > >
> > >         pgc_vpu_g2: power-domain@8 {
> > >                 #power-domain-cells =3D <0>;
> > >                 reg =3D <IMX8MM_POWER_DOMAIN_VPUG2>;
> > > +               power-domains =3D <&pgc_vpumix>;
> > >         };
> > >
> > >         pgc_vpu_h1: power-domain@9 {
> > >                 #power-domain-cells =3D <0>;
> > >                 reg =3D <IMX8MM_POWER_DOMAIN_VPUH1>;
> > > +               power-domains =3D <&pgc_vpumix>;
> > >         };
> > >
> > >
> > > I will prepare the patch to send in the next couple of days.
> >
> > Please CC me when post the patch, and I can run some tests on my hardwa=
re.
>
> The correct patch is already out:
> https://lore.kernel.org/all/20240418155151.355133-1-ivitro@gmail.com/

Thanks.
>
> Regards,
> Lucas

