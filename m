Return-Path: <linux-pm+bounces-29848-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C102CAEE226
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 17:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F79A1883D64
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 15:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA1D28AAE3;
	Mon, 30 Jun 2025 15:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="Ri0tU0wW"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9592868A6
	for <linux-pm@vger.kernel.org>; Mon, 30 Jun 2025 15:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751296540; cv=none; b=fWxpiWDLo52qR8K2oXEN8u/nTbWn4xKA27gVU0fnA+27ZOcl9kYhC6exJNVxoa9Z69fkKBjOlIMct7oOkXWqR8/X6laX7BIQA7j34VZY5AH0CvjgsfmyKQaUoNZTjlU6xIpU9gNr/FqE24W/d6sYjArci6nU9w8tMvZ8YyCtCv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751296540; c=relaxed/simple;
	bh=3YRg2k4pE0gOn9+I/lnJDdKo+f7+9KmvohYEc+wGSI0=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=ahEQRzxbZTmO9PZWU0igM74vt7f1QCblGHTi6nD6bxkhxqjEKyd9+9fWjNbaBobORIbD/e8wTP1qFcOa1xkqWFjDBeQmwyBeM/9be/CCi7kx7OhVlUKTBlx4tNZc9K7/Ts8GGLxBK31nilBNMDR6NwBOR+J8tyS7WyNY/Q9f8R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=Ri0tU0wW; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1751296524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3YRg2k4pE0gOn9+I/lnJDdKo+f7+9KmvohYEc+wGSI0=;
	b=Ri0tU0wWigDP4ns/uMhq/DbtVnVrpFJULpOesADQNQN9Ttt6kCBagAkjDVGSK5VZC6AHOM
	ZWn79mbKvrEKuandb53v1+m+CqNi6PLgVySS5MdQjAhv4+/qUgV9wF25K7IsVDxSfRS0tz
	+XjPKyy798dJnbB2jfK5yw5XfQN73eHrk0t17S+dAUryNVgomhKBL21IHHqYAFwTK9HmBc
	1whhZZh15zpymQw8SlW/Fuvba6GlHfvBYWNcjSiT40Z8MuWPEhi54VrZmOEg5YlnFy9i2z
	0shugR0/yu/yovmPA5110JuR/CksANGaGSbA1RUTBBLMdJwasXbX34GBS4iROw==
Content-Type: multipart/signed;
 boundary=bd373288a0d8c3b229a1e6a0dff79d8e39c1f4f8b2c5ab7ef827047dc5fd;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Mon, 30 Jun 2025 17:15:06 +0200
Message-Id: <DAZYSSIAHK7V.3L51YEB1XPZWN@cknow.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Christopher Morgan" <macromorgan@hotmail.com>, "Krzysztof Kozlowski"
 <krzk@kernel.org>
Cc: "Chris Morgan" <macroalpha82@gmail.com>, "linux-pm@vger.kernel.org"
 <linux-pm@vger.kernel.org>, "linux-rockchip@lists.infradead.org"
 <linux-rockchip@lists.infradead.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "broonie@kernel.org" <broonie@kernel.org>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "sre@kernel.org"
 <sre@kernel.org>, "heiko@sntech.de" <heiko@sntech.de>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "lee@kernel.org"
 <lee@kernel.org>
Subject: Re: [PATCH V4 1/5] dt-bindings: mfd: ti,bq25703a: Add TI BQ25703A
 Charger
References: <20250626195343.54653-1-macroalpha82@gmail.com>
 <20250626195343.54653-2-macroalpha82@gmail.com>
 <20250627-lurking-amorphous-elephant-e14c7f@krzk-bin>
 <SN6PR1901MB4654D8420C9F65C8BE2D10ECA546A@SN6PR1901MB4654.namprd19.prod.outlook.com>
In-Reply-To: <SN6PR1901MB4654D8420C9F65C8BE2D10ECA546A@SN6PR1901MB4654.namprd19.prod.outlook.com>
X-Migadu-Flow: FLOW_OUT

--bd373288a0d8c3b229a1e6a0dff79d8e39c1f4f8b2c5ab7ef827047dc5fd
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Mon Jun 30, 2025 at 4:33 PM CEST, Christopher Morgan wrote:
> On Jun 27, 2025, at 1:58=E2=80=AFAM, Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>> On Thu, Jun 26, 2025 at 02:53:39PM -0500, Chris Morgan wrote:
>>> From: Chris Morgan <macromorgan@hotmail.com>
>>>=20
>>> Document the Texas instruments BQ25703A series of charger managers/
>>> buck/boost regulators.
>>>=20
>>> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
>>=20
>> Didn't you receive tag?
>
> I did, I=E2=80=99m sorry but I thought the changes suggested were substan=
tive
> enough to warrant another review so I dropped it. I did leave it on
> the other patches though. If I should have kept the tag I=E2=80=99ll try =
to
> remember next time.

AFAIK that is a valid reason, but you should explicitly document that
you did and why, so everyone knows it's not an 'oversight'.


--bd373288a0d8c3b229a1e6a0dff79d8e39c1f4f8b2c5ab7ef827047dc5fd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCaGKqBQAKCRDXblvOeH7b
bv/9AP9K8HfNsGjfd6lNsvgCpoQ4VKS4FOwXFjz2vljl9DJZEwD/fdDEa/yHtCyk
4/fNaRMhbrX7HECCNCCfkC3VxppukQM=
=00g9
-----END PGP SIGNATURE-----

--bd373288a0d8c3b229a1e6a0dff79d8e39c1f4f8b2c5ab7ef827047dc5fd--

