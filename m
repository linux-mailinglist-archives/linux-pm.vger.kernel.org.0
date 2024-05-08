Return-Path: <linux-pm+bounces-7666-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D45FB8C0319
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 19:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A72F1F22EAF
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 17:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FE32E3E8;
	Wed,  8 May 2024 17:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3yoAq0T"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E47979CF;
	Wed,  8 May 2024 17:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715189455; cv=none; b=PZtxyrwgyGM/HRXzcLG9Io7DxLjU5bu0a34Iulc0y6Q8pQUNRh1ixC/nqoLu5xDF5eGdCPqwPjPpsEaaiMn+MAA1dL93wkR/Nz60SwdQ2Z0MzXJwCgs/zX9dVQX0xivUd+NXkO2xZJtV5xx+qP5VKP3EfFDxkBNk2gb96LcOiuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715189455; c=relaxed/simple;
	bh=vYfE+uXBisYwplwMBgJYce9Fnn3PhzHMT3aXaLfTTEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pr3fI0lqxiOp6vtH+Xk0dzcYQ4GF7xO5fJnxlQ7DJZZ2l55YT609dwdm3I9atPQOJfeNwkJx99HtjQSgtlmrSjEBq8eWxCgxkr+V0a0KjrJRylM1Z12RW4WasBC8pn+iJ2bsWxQJRfqddv+FYFABlnVHNFxPTOtNcUEQtezIgv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R3yoAq0T; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2b3f5fcecc1so33689a91.1;
        Wed, 08 May 2024 10:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715189453; x=1715794253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+fR68JCn/hWTtGUKbSoApl+GEYdIRkhWhhAj/uy4nvw=;
        b=R3yoAq0TJDcZ0CDDm9ftbBh/F1gITEQ4cFZkbfEPjJ9wV5AxaaMcwifOeRbH39SHxu
         eKBHmZyBE4szzRgVxnzTxC3N4jo6KlvkBPYIWgsh5iXyLOGEiDQGt0wYkmJ66yZidc+m
         RpQVRs1fkHRhAcqgWDC5FlcfyOGdCpWk3IqBhYObG7pPDBS3NUh8LaE2bfEfwb64eWUj
         8ZkImoSUlPn1I/qTZUkVnotyFwMluolgaW1DPsSsDsMyrUIa+wu5wSXLAaXj9TUl6+EQ
         EGczX7Nij0QoJylX7fBHFNgMWmxSswigQ6TW30fnEeSYA9i1MuSRiIqJc0KuDUFO4RBM
         4qfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715189453; x=1715794253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+fR68JCn/hWTtGUKbSoApl+GEYdIRkhWhhAj/uy4nvw=;
        b=pOX0X7djzW0L5LiiN3zBYsLVC2CimDm9luY1fddvLN54sLukhVUFBmJ2005Jh8Odr3
         o4TsyrUWRGUEpQujf86qCBvDyvYxiqE7YTeWQsDW0ZL/zp/DdSe/mmTlHPiKXKF1Z7BJ
         kEwK6T5a1y/bMckE1nm87Y5wG2RBuAIzQuZmLPC8yg3CEo1vHqY5QsDvPvqim5jCKbry
         R3BEd4/CawHm7Lhv3G/SGf+2bL9htJjbWTbzddh+foQHWNbcXCNcGMN809xJ0cYvTs6f
         0jpTMyIS3XuAD+s94+7Y1x2EJ/AieJisIRCyT7nQ1QVAZH8vRy4B7ko3dsB0abn6nyUp
         k8cw==
X-Forwarded-Encrypted: i=1; AJvYcCVbZxU8u0JKVcBqrsg3nWEZnKuMHKNLm2SL5zEIL6fCw00fk8pdEvR38Lf3g9WyKZdBU/WLS29bVG8oaiHqcg3zTTVU2jf3uJMWNYSa
X-Gm-Message-State: AOJu0YzIroiW/OtzNXatu2gUlPilBCrTnn/AFJrH/xyE/+XKH54mgrwo
	fJ6T3e4QIv2UtC+4krq0R8DvTtcL/zdAT3pBQWOhR0iOMz7zkBGd9Nl0b1xAYxR9yJzRgs6LibW
	QLDZXUi6FVgg6hippCZ05FHGSql0=
X-Google-Smtp-Source: AGHT+IEApl3TxNSeIkqfktM/yAubKMXjdwKSRv8nVwvMfEAIehyTaQLljuSSDvebWx4PryXczfykg+2AXkwOlbCDIC8=
X-Received: by 2002:a17:90a:1bc9:b0:2b6:2089:e4ec with SMTP id
 98e67ed59e1d1-2b6208a10f3mr2568776a91.22.1715189453289; Wed, 08 May 2024
 10:30:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fccbb040330a706a4f7b34875db1d896a0bf81c8.camel@gmail.com> <4e781d80fbec0db13555456ab8af6bdae6dee168.camel@gmail.com>
In-Reply-To: <4e781d80fbec0db13555456ab8af6bdae6dee168.camel@gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Wed, 8 May 2024 12:30:41 -0500
Message-ID: <CAHCN7xJF1=BNgh=wpsyd6WP=haOq2UdCYEt2AaL7rGfhDUh6CQ@mail.gmail.com>
Subject: Re: iMX8M Mini suspend/resume hanging on imx8m_blk_ctrl_power_on()
To: vitor <ivitro@gmail.com>
Cc: linux-pm@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	vitor.soares@toradex.com, ulf.hansson@linaro.org, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	rafael@kernel.org, geert+renesas@glider.be, peng.fan@nxp.com, 
	linus.walleij@linaro.org, u.kleine-koenig@pengutronix.de, marex@denx.de, 
	Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 10:09=E2=80=AFAM vitor <ivitro@gmail.com> wrote:
>
> Hi,
>
> On Thu, 2024-04-04 at 16:53 +0100, vitor wrote:
> > Greetings,
> >
> > I'm trying to suspend/resume our Verdin iMX8M Mini with VPU IP using
> > the latest 6.9.0-rc2 Kernel. While the system can suspend without
> > issues, it hangs on the resume routine. After some investigation, I
> > can
> > see the Kernel hanging on imx8m_blk_ctrl_power_on()[1] while resuming
> > the hantro-vpu power domain.
> >
> > Any hint about that?
> >
> > [1]
> > https://elixir.bootlin.com/linux/v6.9-rc2/source/drivers/pmdomain/imx
> > /imx8m-blk-ctrl.c#L101
> >
>
+ Lucas

> Looking at other child nodes of the pgc node, pgc_vpu_[g1|g2|h1] seems
> to be nested into pgc_vpumix.
>

On the surface, that's how it appears and it would be consistent with
how the GPU's work with the GPC's for each GPU calling the gpumix.
However, the VPU's all reference the vpu_blk_ctrl which itself
references the vpumix.

Lucas,

You seem to know this driver pretty well.  Do you expect the G1, G2,
and H1 PGC's to all reference the vpumix, or do you expect the
vpu_blk_ctrl to enable/disable the vpumix?



> After applying the following changes to imx8mm.dtsi, the suspend/resume
> is working.
>
>
> @@ -739,16 +739,19 @@ pgc_vpumix: power-domain@6 {
>         pgc_vpu_g1: power-domain@7 {
>                 #power-domain-cells =3D <0>;
>                 reg =3D <IMX8MM_POWER_DOMAIN_VPUG1>;
> +               power-domains =3D <&pgc_vpumix>;
>         };
>
>         pgc_vpu_g2: power-domain@8 {
>                 #power-domain-cells =3D <0>;
>                 reg =3D <IMX8MM_POWER_DOMAIN_VPUG2>;
> +               power-domains =3D <&pgc_vpumix>;
>         };
>
>         pgc_vpu_h1: power-domain@9 {
>                 #power-domain-cells =3D <0>;
>                 reg =3D <IMX8MM_POWER_DOMAIN_VPUH1>;
> +               power-domains =3D <&pgc_vpumix>;
>         };
>
>
> I will prepare the patch to send in the next couple of days.

Please CC me when post the patch, and I can run some tests on my hardware.

thanks

adam

>
> Regards,
> Vitor Soares
>

