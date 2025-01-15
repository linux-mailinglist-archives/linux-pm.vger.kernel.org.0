Return-Path: <linux-pm+bounces-20472-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B009AA11D14
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 10:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA10916547D
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 09:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908AD1EBFE8;
	Wed, 15 Jan 2025 09:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTDQWKsI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D711C1EEA3C;
	Wed, 15 Jan 2025 09:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736932511; cv=none; b=FZ7DA7wzfXJb0ksyVozSjUXCsABCI8pJljrTYzBB/r3IivaNF44w5OrzZT2wZg8DrfmXErU9b1sXmZaIPSyMdz9iAEg3NJwm3CO7YAD1XcJjJ9YxmU7GYuFOTUaL0AXgbaQN1xWvW4yWIf5u2Yja4abWc8XdrYe+AcK3+2Wcg2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736932511; c=relaxed/simple;
	bh=jeR7/gWf6Skl/qjAR+jZQXkKFEOuRqSrEZuOJL3HMyE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oJckeDyJvZcBK2rJOcDBwEGbuxQsvEJ02tfcUexRGIMvBVHO50d5Kz3ij7bcaQKn6KtMKa4JeZlK+wUSEQvMemPJ8t1dI6ZnMVp9clOb99gT3tFAQq/AC/b3PcXWMJ43Wd+ON3b9ubt4lRmA6YkCBrAvKkiqyVc/4/sSUVP50Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTDQWKsI; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-385f06d0c8eso3333501f8f.0;
        Wed, 15 Jan 2025 01:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736932507; x=1737537307; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J/Rn9ie+6t4Dw0dOkRjEwpRIvwGjZP3l0XjeBhuGtKk=;
        b=aTDQWKsIpKlhjjVPUlA8O/93NLgEuP2EmN6hvOc8+yIPVy/SIwBCIxpAv/0hBJe/bV
         YVmep9leXMqxW/nKuxUuHTDR5sP0DoqRL79508cW1scaE8uWCA16vxgEk+dONbd/qMX0
         s57KtcifeqZh0jtmk2AC/EkwFC5zoxOhGiWEmMN+TWehRuNSBPGB9Aalg0+1judBHcbr
         fheX/ct2elu6Zha3Hi5Ez1bDVJf8exCp8m6uJ+Y6lfDZbNFoQ/G2G1uCzm5Qa7JEaU2m
         mkaf4aJsdjMEyX+/qgRku4dt0iH/WSNrzJeT7D+bfgEufK2ay6BFtoikpbqLxO3udNJd
         Dn7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736932507; x=1737537307;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J/Rn9ie+6t4Dw0dOkRjEwpRIvwGjZP3l0XjeBhuGtKk=;
        b=sh4/2auXyj7NRDONJDVXn6ID2p4/lA/Q0hrJLEl6ZIhZsEmeUHxDjqHCFPmZZ+9ZLt
         r3UlDPS2W1uxKkSHcLgM6H9benrKCS4Mi0TpwQVtp8xH1taBHWHCEt25dH3ODrn+f+3S
         xBc0JUM750lUFmHqmBvAX/iT0OE1Y5LZOQe+jVOtTPAAmGHEmx+dXc41AUb6Mjl7oNoA
         p2tzm+EaSR09w0fPRQTQ7r+Px0y87Gmubo+y/zAIm9Bz5zH48enxS3MOO+pbM5F0z6mN
         HFSl04H49Z030VWEXGdAfFv8hS6fdkvIER2uu6MNAZ1E6kX5EFunXchu1+tLShrxlQM2
         K86g==
X-Forwarded-Encrypted: i=1; AJvYcCUqIsfaBPRL4Z5+L8kz4jEaM709QbBvS/zzauuy9AgzKp/8a4k7J7X2iUZPoyYJt3ywHWHLt94LK9jObrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv4ysDP9R//tr3rW4h7Wv4AU1SAVAXRAY6s3C0/dm26xHcL4E/
	58OGAl3ZF6W+DQy3mP21hqizy7KkWIbK2gNDUlB3Rxap3SEgjK5pf8UKh/m5j50=
X-Gm-Gg: ASbGncuBvDXOXIITe6/roH/uxipCWQgpuVapIfHkB25Brj8U2Q54CuFwDMEunfaQv3n
	5oU8VYLyo/ex550/lt1ya8kP6AS/M4p/x4oUef/EpkB3r6zhDw7J3WpU9K5bxJ9rlSwqGn3Sexx
	iar09Jd5XH66WTTGsOFZk/rvJp4lJyxiP4GncGituzPLBw/MW0buWk2ZpXBAwrUMHOVReosLHhL
	hbGJF7JnyOM80Iqu0/xYal1bZswrgJniCyuOz3unsfR3jQSHdnIGXm04kljMLaYRhRwUSYTXoC2
	FGZOOp7Ap4Shw6RHYFW5xOFt2Q7A
X-Google-Smtp-Source: AGHT+IE0c1f7spcMvHNvh+ACVR4C0TvhK0aSqqVXi6IH+rZFY8EMdS08HctrMeI17jzG17HFgSMowQ==
X-Received: by 2002:a05:6000:1f89:b0:38a:9ffb:fe2f with SMTP id ffacd0b85a97d-38a9ffc0071mr13394732f8f.0.1736932506842;
        Wed, 15 Jan 2025 01:15:06 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e38428bsm17079228f8f.37.2025.01.15.01.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 01:15:06 -0800 (PST)
Message-ID: <4393f4a97a5acbf1ba17bbe0cf5dc3993149acff.camel@gmail.com>
Subject: Re: [PATCH] power: supply: ltc4162l: Use GENMASK macro in bitmask
 operation
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Kim Seer Paller <kimseer.paller@analog.com>, Sebastian Reichel
	 <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 15 Jan 2025 09:15:06 +0000
In-Reply-To: <20250114011318.5784-1-kimseer.paller@analog.com>
References: <20250114011318.5784-1-kimseer.paller@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-01-14 at 09:13 +0800, Kim Seer Paller wrote:
> Replace the bitmask operation BIT(6) - 1 with GENMASK(5, 0) to make the
> code clearer and readable.
>=20
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/power/supply/ltc4162-l-charger.c | 8 ++++----
> =C2=A01 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/power/supply/ltc4162-l-charger.c
> b/drivers/power/supply/ltc4162-l-charger.c
> index 24b62f000..db1a75c9b 100644
> --- a/drivers/power/supply/ltc4162-l-charger.c
> +++ b/drivers/power/supply/ltc4162-l-charger.c
> @@ -410,7 +410,7 @@ static int ltc4162l_get_icharge(struct ltc4162l_info
> *info,
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> -	regval &=3D BIT(6) - 1; /* Only the lower 5 bits */
> +	regval &=3D GENMASK(5, 0); /* Only the lower 5 bits */
> =C2=A0
> =C2=A0	/* The charge current servo level: (icharge_dac + 1) =C3=97 1mV/RS=
NSB */
> =C2=A0	++regval;
> @@ -449,7 +449,7 @@ static int ltc4162l_get_vcharge(struct ltc4162l_info
> *info,
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> -	regval &=3D BIT(6) - 1; /* Only the lower 5 bits */
> +	regval &=3D GENMASK(5, 0); /* Only the lower 5 bits */
> =C2=A0
> =C2=A0	/*
> =C2=A0	 * charge voltage setting can be computed from
> @@ -500,7 +500,7 @@ static int ltc4015_get_vcharge(struct ltc4162l_info *=
info,
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> -	regval &=3D BIT(6) - 1; /* Only the lower 5 bits */
> +	regval &=3D GENMASK(5, 0); /* Only the lower 5 bits */
> =C2=A0
> =C2=A0	/*
> =C2=A0	 * charge voltage setting can be computed from:
> @@ -636,7 +636,7 @@ static int ltc4162l_get_iin_limit_dac(struct ltc4162l=
_info
> *info,
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> -	regval &=3D BIT(6) - 1; /* Only 6 bits */
> +	regval &=3D GENMASK(5, 0); /* Only 6 bits */
> =C2=A0
> =C2=A0	/* (iin_limit_dac + 1) =C3=97 500=CE=BCV / RSNSI */
> =C2=A0	++regval;
>=20
> base-commit: a3a8799165ff83bb764fd800c6559c3cba0ddac3


