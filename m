Return-Path: <linux-pm+bounces-41058-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F28B2D39530
	for <lists+linux-pm@lfdr.de>; Sun, 18 Jan 2026 14:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 03D6930042AA
	for <lists+linux-pm@lfdr.de>; Sun, 18 Jan 2026 13:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6536A330B14;
	Sun, 18 Jan 2026 13:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCC3GMV3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091584A33
	for <linux-pm@vger.kernel.org>; Sun, 18 Jan 2026 13:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768741278; cv=pass; b=pO9LipLY4+XpfdPmTdW7fgeZM8+HbRt4o17ySq/PEigokcD1BzUkwDSYRHY3MDAoepsDRJQXaFSWU0Am5Q0jXNu6pm8Kk8yWfo8WvLN+aZX2JZkScVuO6hNSeF6rY011bz5pT5Lat9UFOupekB47kqfbyQplh6UKs2IcLK1zVBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768741278; c=relaxed/simple;
	bh=+01Cb3mcBpAIzGPDMv16TQTn/jHLAQ/E9dNDT0sGHCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NQcUpSx9eV1XJ/YPUQbL0vnAQfvQ0MsDhb6iQl4g5HeNa4PbXrR21xGqW/j1pLxIj2AkiypvXyLioAAwzFBGIV9ZA1dbLBazqZiNtw0tHjVkzQYCV/wdKDa8kee0CF/IXApmO9/07d7//ooMMSVqY4gqIbJMuUA0NCsvxREH5do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCC3GMV3; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-79275e61c2cso33007797b3.3
        for <linux-pm@vger.kernel.org>; Sun, 18 Jan 2026 05:01:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768741275; cv=none;
        d=google.com; s=arc-20240605;
        b=MEbUH534wYHUGdJTMiFrNnaO2yZw7VDaTIKX0zeyJIF5qtfvDqwsar/JwlSdk7fKwT
         y5pEuJw62tl3gmD8xBXzvSeBzCLwxRkq+zrpDlqXzfo8KFPLsrwp6xmhuubmZdWENRPb
         IgTbkMafHeRwiX5EUQlG4sMWImDm5GtFB75ucnWjwAqWgtG/MfsEDcgGKLIQ8NVtyMG5
         O1P0G2nLZdylzV/V41EyIUPfoW8QppTQT1EYXyNh0dr57hug026ZL88pd28pd4btMU1q
         uPEzDIF0ZWi4wNzAgSS7MfYJAGi2WIMemGkXdmfQ1I82S3r66HOEsyU/24So6h2AQzwl
         J5tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/HcqovNmS0C1WNUKztsxWUJLDiXtrL2QTXBBC/kxEI4=;
        fh=lGRmxU2MhqfMqOI+ORI4NrXbylkVUjDDW8exbUKaHEs=;
        b=NzyUVtrd1FBqcf6oPOKCfdVjVCgb2G7zIqHBdCo96L4wC4FvJhXVOc43+xHbAipnef
         +TADzGYb35NYtkAZmic5QJy6/RJbD6F9FsXyMue3kH2GITvdh2imEQKPY2M78kVFKA8u
         dL+15lKqFzQcy6VMc6BY/vL6GJpWxIpd1FkeaDETu+pu/H1A3KrZ6wfjhTSFhOUcgPOV
         Y8iiXd9YtYEHOwLQ5wjA1u4vgamQJyQ0a4Erw6OEghhOkThLN+r22ECzJyem984WUz0+
         xEBAx6aKmUFCGgpsIJdYYVkLwUMU09dvmI4pncqSowZpijuqRYtP7F+mBkde5c8UxDcm
         WCHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768741275; x=1769346075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/HcqovNmS0C1WNUKztsxWUJLDiXtrL2QTXBBC/kxEI4=;
        b=eCC3GMV39vuFm6GoFbaEtSCeg7YaK2Uc49zJVponjK/jjAdRasdVUUSccp+nYQXWIW
         uIdcpdwo1R+CQvwRBQP+L6hok6aIe6pXiNF8UZh/8JfKALiwGRCIQcKV4aYt+S5kNVDe
         TULXtg/zx0Vgi2WtMpQfXi4Rwm/r2d+dXNW3PZYz8UtSNWjbnqGBePFUCCUjKoXy/uNZ
         TcgTDzfC8cA9zi31h4ZgprRci5JYgDF3hvt7z4Al4Ux/bomDhJNqmacfFM7tMVJMDznZ
         +OMnsziZ0L21LrOAmg06hmn4tGOJufWFh0qNv/1XaYz48xK7UKL/rFLzjCpUU/OltbxE
         QsWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768741275; x=1769346075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/HcqovNmS0C1WNUKztsxWUJLDiXtrL2QTXBBC/kxEI4=;
        b=usWZwBrsfD/kUdMaAMjM2Sq+z5HU8YrkJQgt5Vb4/pKOabtIbJUHugZmXDkX/jnAK9
         KdvF8nV0LsHxh3BcmT/9fp8e0hUMVPoWMnhC7nF5Q7tRb8plrjo7TbEgUqgYICbPv2vV
         xI8tWkl/jqx2MMDuPFJVA1dOl/r3QQUOvYBg+70WQvE/hmRdKbv2oxh5h0zxx7ODJtMl
         J5f/YhT5fNeHKEn+u900E1dAmgJievnxB1Ua0LWapBDeimYEERm51knIX3IwSDiddHfK
         /HRO8zJf392a9F6SYhqyZynd2+CMDbw1S5IkpDeFJvb0i1Z+minLijyuf58R5f7B8i59
         c/Vg==
X-Forwarded-Encrypted: i=1; AJvYcCVG4XDJLOqAGUQzXAFHtVFiNjXU0W3aKRSAkHHVK0d6gmgVb28yj3xisjceZG8J28QT+eeB5tppEA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxwHnPzfWRVAvz106+5zSWvAMBPpuqxBtFVXwrNePOzGtwbCk9Y
	twuqvQ3lXv7VvHrxp9DiPs0fxmeiFZHXpAC6iekjt20HEhyztearJ6F8Am72tCgN/VZyn4vJ/Cb
	Rml4i50UwWzDGUjuR/0T7e5Qpm4QnHRo=
X-Gm-Gg: AY/fxX6Jqp18lxPdMm60PPiV9TKg8UPrRb1MQygyBJ4U31o5depayEjB0QhrcvSYoch
	oO6PbvRC9HRr1pty7RObgyaeJlb5TmKDGBfqVLcDy6OpywOfxaG60Nahj1e65nNaUHY2ZwuabyY
	Tnx7FvC9JdyQq06IqsWNQvwYhSeYUx3UbyQTLQyjhZYW5UysWIeEJ2lWXJLO0zgsCHL6ieBc/GL
	oqqocSstb3y0/iG1q6E8YFpPawJvg6+fFg05dEyH0804k/KM9stVqbOTnvQULNIq8TRzwAWAHVl
	87/ZAKaDRYrbBHIfMWKFDNzq/pt2
X-Received: by 2002:a05:690c:9c0b:b0:793:b353:9dd7 with SMTP id
 00721157ae682-793c683524bmr71951307b3.53.1768741274889; Sun, 18 Jan 2026
 05:01:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115-b4-macsmc-power-v3-0-c236e09874be@gmail.com>
 <20260115-b4-macsmc-power-v3-2-c236e09874be@gmail.com> <20260117123247.GB58217@robin.jannau.net>
In-Reply-To: <20260117123247.GB58217@robin.jannau.net>
From: Michael Reeves <michael.reeves077@gmail.com>
Date: Mon, 19 Jan 2026 00:01:03 +1100
X-Gm-Features: AZwV_Qg0kRBEifh1Sp_fpTXxWriqblhk8t3g8YtA9hXlnvyNjUGbX9JPXHLuelA
Message-ID: <CANpmGNuZjYVEu-0mGezuy0mLpnu9Cg1aBooJV=hAr+-BJW0yiw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mfd: macsmc: Wire up Apple SMC power driver
To: Janne Grunau <j@jannau.net>
Cc: Sebastian Reichel <sre@kernel.org>, Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>, 
	Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	Hector Martin <marcan@marcan.st>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Janne,

Thank you again for your feedback!

On Sat, Jan 17, 2026 at 11:32=E2=80=AFPM Janne Grunau <j@jannau.net> wrote:
>
> On Thu, Jan 15, 2026 at 06:08:16PM +1100, Michael Reeves via B4 Relay wro=
te:
> > From: Michael Reeves <michael.reeves077@gmail.com>
> >
> > Add the cell for the macsmc-power driver so it is probed by the
> > MFD core.
> >
> > Co-developed-by: Hector Martin <marcan@marcan.st>
> > Signed-off-by: Hector Martin <marcan@marcan.st>
>
> Co-developed-by: for a single line change as simple as this is silly.
> Please just keep Hector as author and just add your SOB
>
Will fix in v4, thanks for pointing it out!
> > Reviewed-by: Neal Gompa <neal@gompa.dev>
> > Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>
> > ---
> >  drivers/mfd/macsmc.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/mfd/macsmc.c b/drivers/mfd/macsmc.c
> > index 1b7e7b3e785f..358feec2d088 100644
> > --- a/drivers/mfd/macsmc.c
> > +++ b/drivers/mfd/macsmc.c
> > @@ -46,6 +46,7 @@
> >
> >  static const struct mfd_cell apple_smc_devs[] =3D {
> >       MFD_CELL_NAME("macsmc-input"),
> > +     MFD_CELL_NAME("macsmc-power"),
> >       MFD_CELL_OF("macsmc-gpio", NULL, NULL, 0, 0, "apple,smc-gpio"),
> >       MFD_CELL_OF("macsmc-hwmon", NULL, NULL, 0, 0, "apple,smc-hwmon"),
> >       MFD_CELL_OF("macsmc-reboot", NULL, NULL, 0, 0, "apple,smc-reboot"=
),
>
> This patch does not apply on top of v6.19-rc1. The base-commit helpfully
> provided by b4 does not exists in my tree. I assume it's either a mfd or
> linux-next commit? Please note the branch/tag this series applies to in
> the cover letter if it is not the most recent -rc1 from Linus
>
It's based on-top of the latest linux-next, I will mention this in the
cover letter
body for v4 (i only put it in 'Changes in v3' for this one), thank you for =
the
pickup!
> Janne

Thank you again!

Best regards,
Michael

