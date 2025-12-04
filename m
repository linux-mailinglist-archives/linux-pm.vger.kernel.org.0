Return-Path: <linux-pm+bounces-39196-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FF4CA35F7
	for <lists+linux-pm@lfdr.de>; Thu, 04 Dec 2025 12:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E5B47302DF0D
	for <lists+linux-pm@lfdr.de>; Thu,  4 Dec 2025 11:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794E533ADBD;
	Thu,  4 Dec 2025 11:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ranostay.sg header.i=@ranostay.sg header.b="g9oLqBjL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-4320.protonmail.ch (mail-4320.protonmail.ch [185.70.43.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57FC334695;
	Thu,  4 Dec 2025 11:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764846246; cv=none; b=HhlcJVJ6cOxXnpNp4P4/0V78pCRg14Ku8R0l0OUM0/q1vb4N404Dj//GkfHMqc6IifW/JHZijV470PSqfi//sfTubC7z0AfrHKNyp3P1qxjbw5LpYyEf+ZEtb8MDYo/jtLWd3voF/CbFEtU2SCes+x9Z1wKE71DsXChb/p7cA5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764846246; c=relaxed/simple;
	bh=5FzTcSVMzM6nyPMirYnQRY06ESV1QxJo7pfqxG3/Odg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bfYBxQcewfTsnurk3cwe312av899Ah49BA4V7nAUV1r/axHCK0GQymWPcQM6ar2HprujHfguJlUnXkKwYvFoMykUyd9h87cauiRq3nPF+VrRXpDCaYoAxhPkl8iE1LWpW00USjXBD4m3RPcSVkQfCL1igwL7j3XjkGgIJXH0EPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ranostay.sg; spf=pass smtp.mailfrom=ranostay.sg; dkim=pass (2048-bit key) header.d=ranostay.sg header.i=@ranostay.sg header.b=g9oLqBjL; arc=none smtp.client-ip=185.70.43.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ranostay.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ranostay.sg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ranostay.sg;
	s=protonmail2; t=1764846230; x=1765105430;
	bh=5FzTcSVMzM6nyPMirYnQRY06ESV1QxJo7pfqxG3/Odg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=g9oLqBjLhOJ3tiASQ+HEgs+OfypXwjCaDzVoiGI+2ZxHsa+Erx88RXs67GcToR9uv
	 tE153hW1Cvq5Be8DEGyjlw4m52YR3AY63mxfoOYFoh0GVhS5WLdJ65GUGe1xg7kI4N
	 DCjO/cqqI/ki0HcbVBhm5v871MK8zgx6OGEQH6K1OWa5VwLfNZjoor7Z663UQp/QM5
	 xF+iHg+osgrlCHB4TBXk/3cIHkwaqYncbKoBQO4elDFTCLyi2KEb+wAqsnnkkko2jK
	 2rlS/ayjG0tTNnPwAQo6RQZ0jDeZ6zDFb6eKHGmrK1c9unPzTgRHpX6Aj1T2e5aNlD
	 PSDAKICsk9vVw==
Date: Thu, 04 Dec 2025 11:03:44 +0000
To: Haotian Zhang <vulab@iscas.ac.cn>
From: Matt Ranostay <matt@ranostay.sg>
Cc: sre@kernel.org, pali@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: bq27xxx: fix wrong errno when bus ops are unsupported
Message-ID: <NRoZvEd3G9hUveVmurvooyzuQ0LfrghfASmcQHggvJhrPCiqvunmHFg3iyhi49ufJ0zKOpzwkUc4btlf1bkR_-CTcCM2hJcifqPdqbxinXQ=@ranostay.sg>
In-Reply-To: <20251204083436.1367-1-vulab@iscas.ac.cn>
References: <20251204083436.1367-1-vulab@iscas.ac.cn>
Feedback-ID: 87502384:user:proton
X-Pm-Message-ID: 8a2a6e405d4cc30700f45ad06061e4a119845f0d
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Seems reasonable enough..
Only possible concern is breaking ABI if some application is wrongly expect=
ing -EPERM for an error condition, but seems unlikely enough to not correct=
 this.

Reviewed-by: Matt Ranostay <matt@ranostay.sg>

Sent with Proton Mail secure email.

On Thursday, December 4th, 2025 at 16:35, Haotian Zhang <vulab@iscas.ac.cn>=
 wrote:

> bq27xxx_write(), bq27xxx_read_block(), and bq27xxx_write_block()
> return -EPERM when the bus callback pointer is NULL. A NULL callback
> indicates the operation is not supported by the bus/driver,
> not that permission is denied.
>=20
> Return -EOPNOTSUPP instead of -EPERM when di->bus.write/
>=20
> read_bulk/write_bulk is NULL.
>=20
> Fixes: 14073f6614f6 ("power: supply: bq27xxx: Add bulk transfer bus metho=
ds")
> Signed-off-by: Haotian Zhang vulab@iscas.ac.cn
>=20
> ---
> drivers/power/supply/bq27xxx_battery.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/suppl=
y/bq27xxx_battery.c
> index ad2d9ecf32a5..1d7aa240126a 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -1172,7 +1172,7 @@ static inline int bq27xxx_write(struct bq27xxx_devi=
ce_info *di, int reg_index,
> return -EINVAL;
>=20
> if (!di->bus.write)
>=20
> - return -EPERM;
> + return -EOPNOTSUPP;
>=20
> ret =3D di->bus.write(di, di->regs[reg_index], value, single);
>=20
> if (ret < 0)
> @@ -1191,7 +1191,7 @@ static inline int bq27xxx_read_block(struct bq27xxx=
_device_info *di, int reg_ind
> return -EINVAL;
>=20
> if (!di->bus.read_bulk)
>=20
> - return -EPERM;
> + return -EOPNOTSUPP;
>=20
> ret =3D di->bus.read_bulk(di, di->regs[reg_index], data, len);
>=20
> if (ret < 0)
> @@ -1210,7 +1210,7 @@ static inline int bq27xxx_write_block(struct bq27xx=
x_device_info *di, int reg_in
> return -EINVAL;
>=20
> if (!di->bus.write_bulk)
>=20
> - return -EPERM;
> + return -EOPNOTSUPP;
>=20
> ret =3D di->bus.write_bulk(di, di->regs[reg_index], data, len);
>=20
> if (ret < 0)
> --
> 2.50.1.windows.1

