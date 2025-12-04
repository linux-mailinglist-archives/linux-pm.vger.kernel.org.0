Return-Path: <linux-pm+bounces-39214-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 801E6CA4EF6
	for <lists+linux-pm@lfdr.de>; Thu, 04 Dec 2025 19:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25BFC30A35EF
	for <lists+linux-pm@lfdr.de>; Thu,  4 Dec 2025 18:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F7D362152;
	Thu,  4 Dec 2025 18:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="2x+/V778"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E06361DB9
	for <linux-pm@vger.kernel.org>; Thu,  4 Dec 2025 18:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764872143; cv=none; b=uv/okGx1oh3JOUafubJN8RhseebT2uSbPKn8eIiVlDudw/pR5hvbd8zmh1W0SRa2Hl+KykNvlDLpLyeqpjjvnQ00Bz7LBppMh3VQlreKoQ7H3p01OSsuyXn+keQRrMVdDzApLd49tg4NzBL9ip4/w0E2QOdE22mCYxD1P8egdV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764872143; c=relaxed/simple;
	bh=a+2kYj5/q0i0WNKmd7h2WF2fnGy3xLOLJAXsmaD7G30=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TVxVeIkV5AzfjvzYi1Fuo91eEJnt8w1Zl7MtmYQDnAp8v8qAo1hIzhPai+nJAvomnhDCHwF0vVOSQSRvr1YUZ6xXTu3xABNzXTSFGDKig5HZx3v1U+dUt7S8ngxKLjaOEyN25vbjJ0FeXgpfugT4di8rZai4KzCQx1TCXgDoNHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=2x+/V778; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8b2d6df99c5so253774785a.1
        for <linux-pm@vger.kernel.org>; Thu, 04 Dec 2025 10:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1764872139; x=1765476939; darn=vger.kernel.org;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
         :from:subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CkN5ne6AGy4deatrHlfFV2w9dbwRa7Sv7MYr8Yqmbic=;
        b=2x+/V778sZne/8V2O+jrOFGn22MGvrVab/Mo7Efj63PENPvsG0BB9dYMl9aayM9R0U
         w6BKH83Ny8GrcgYCMfJJp/kF1l1s5id5LapvZnVXIT7bUcDTOuWg/rBgPtm0OL5324Gf
         u3vi2gs6EEUA7+8InEm82ujjlOZqIsYcPsuflvqJ/fnu102L/oV4ZYKZc9VZ6cmIOhB6
         kIHOVo8Uow3odqW4wjLPRbx5AyGv91oBOZ9ltJUVikmnXOsnvK9vFlQ1tFbF7qj/gWpp
         X+9D4yeExqBqyeyDqVAfEmdUjMOWbyiBCF/cT3px3jtZefQTJ3F+ZkJsokmxGfxhi5hd
         37hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764872139; x=1765476939;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
         :from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CkN5ne6AGy4deatrHlfFV2w9dbwRa7Sv7MYr8Yqmbic=;
        b=C6bh10vxTNTx53Xz22XemWrT/PtK7uYe1Qzmnq8RX2xYZEd8nZT2WKnkBNQDftCHd+
         uLyD6eLFSygeZL/ySN1fTOb1bfefR06ZrK39aEEY+gRuatVNVUmu+74zUT+o3e+Zeth+
         oKQDJoWxeD77HlI9npluoL3AcCOOTxbCj58+gXdaurxir5zxX/jLFHPdOd1WBHx5VI1T
         HrKkXJzNkqYKCQzYdpGVj6+XSoBOY6t9Ivrfsej8Lux1Mi7Ko7Yr735Xik/IDFMH6Bqk
         Ke3qcNZVPg0x4bcif5tnlrWpSgbY/dik50ImdxMrCHH6ZYaYqmGbObn/bRS2RiD62GoA
         qDXA==
X-Forwarded-Encrypted: i=1; AJvYcCWVtaxDTvGz2asr4pCnYemo4xSk05OLTzdCUVLNG176vOZ1WOE1VD/WW94NEIgSBDWF4z3EMHebmA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzI7zz79srk65q/9AEZdwauxH4Ype7UvNp59yoRflp4ymS9xWS6
	YtcBVry6LYi14RgTczfGXxupOTlku1kz8xGR1DyLrQcSsIbjJzG5DKrlgwiUwBS9xyM=
X-Gm-Gg: ASbGnctS7jSVj3WPVlHAr6cAtWFMUkQnd15EFScAPxkGwDZdzNtTGOYAUbO0KqJHfbt
	oRrDM6EknDXjUHTLNDgT/t6gr3s9oOYNVvA4RuO2zd3JR6nq+eEWESacmO2nyzYNnhww9p8A4+r
	Ym/wb1FwuS1FrtmwFEKAyoqLEJPwU1lhl9o2RjdSyErUuZSu3wg/gfsvLeC+s+NwrSTOlOVCOkC
	v5gkocVwKlsxAxJvTcHDew//C5dt7pdBl6nno2QH91glwrihCBQhAenmPp1vkEPw4DTVYaevPCD
	USGcUeBocIE9LulyDvC1NEUeI/4g55/6A9zghswkAGbV0ZIOsoJ4OUxkSSkCfsDEimW+OHC38ea
	up6ddT32ALypvgeoOJ6/NU1mIGhAB6vrw+5gU/HX4OxZ7ALZHY2EOnv2sgye5pkmAiJlf20q9jI
	qtRT/qFZTcJoQHv3gk
X-Google-Smtp-Source: AGHT+IE+HIR9s2e4UjyUeKhqtKhe1QpzEqyfDz+DTdQCgsuNTjBVcFH9SGVc4xBEqazvmpc5ECJjgg==
X-Received: by 2002:a05:620a:40c4:b0:8b2:9b48:605e with SMTP id af79cd13be357-8b61608ba80mr567564285a.38.1764872138834;
        Thu, 04 Dec 2025 10:15:38 -0800 (PST)
Received: from ?IPv6:2606:6d00:17:7b4b::5ac? ([2606:6d00:17:7b4b::5ac])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b6252b2855sm186512885a.13.2025.12.04.10.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:15:37 -0800 (PST)
Message-ID: <9f38bda2f1753645a1ae392ce5364ea0165fdc01.camel@ndufresne.ca>
Subject: Re: [PATCH v3 3/3] media: verisilicon: Avoid G2 bus error while
 decoding H.264 and HEVC
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Frank Li <Frank.li@nxp.com>, ming.qian@oss.nxp.com
Cc: linux-media@vger.kernel.org, mchehab@kernel.org,
 hverkuil-cisco@xs4all.nl, 	benjamin.gaignard@collabora.com,
 p.zabel@pengutronix.de, 	sebastian.fricke@collabora.com,
 shawnguo@kernel.org, ulf.hansson@linaro.org, 	s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, 	linux-imx@nxp.com,
 l.stach@pengutronix.de, peng.fan@nxp.com, eagle.zhou@nxp.com, 
	imx@lists.linux.dev, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org
Date: Thu, 04 Dec 2025 13:15:35 -0500
In-Reply-To: <aTHGJzVKa7PbEifJ@lizhi-Precision-Tower-5810>
References: <20251204090813.595-1-ming.qian@oss.nxp.com>
	 <20251204090813.595-3-ming.qian@oss.nxp.com>
	 <aTHGJzVKa7PbEifJ@lizhi-Precision-Tower-5810>
Autocrypt: addr=nicolas@ndufresne.ca; prefer-encrypt=mutual;
 keydata=mDMEaCN2ixYJKwYBBAHaRw8BAQdAM0EHepTful3JOIzcPv6ekHOenE1u0vDG1gdHFrChD
 /e0J05pY29sYXMgRHVmcmVzbmUgPG5pY29sYXNAbmR1ZnJlc25lLmNhPoicBBMWCgBEAhsDBQsJCA
 cCAiICBhUKCQgLAgQWAgMBAh4HAheABQkJZfd1FiEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrjo
 CGQEACgkQ2UGUUSlgcvQlQwD/RjpU1SZYcKG6pnfnQ8ivgtTkGDRUJ8gP3fK7+XUjRNIA/iXfhXMN
 abIWxO2oCXKf3TdD7aQ4070KO6zSxIcxgNQFtDFOaWNvbGFzIER1ZnJlc25lIDxuaWNvbGFzLmR1Z
 nJlc25lQGNvbGxhYm9yYS5jb20+iJkEExYKAEECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4
 AWIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaCyyxgUJCWX3dQAKCRDZQZRRKWBy9ARJAP96pFmLffZ
 smBUpkyVBfFAf+zq6BJt769R0al3kHvUKdgD9G7KAHuioxD2v6SX7idpIazjzx8b8rfzwTWyOQWHC
 AAS0LU5pY29sYXMgRHVmcmVzbmUgPG5pY29sYXMuZHVmcmVzbmVAZ21haWwuY29tPoiZBBMWCgBBF
 iEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrGYCGwMFCQll93UFCwkIBwICIgIGFQoJCAsCBBYCAw
 ECHgcCF4AACgkQ2UGUUSlgcvRObgD/YnQjfi4+L8f4fI7p1pPMTwRTcaRdy6aqkKEmKsCArzQBAK8
 bRLv9QjuqsE6oQZra/RB4widZPvphs78H0P6NmpIJ
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-MBM9wOUi8PufoWyT5ryr"
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-MBM9wOUi8PufoWyT5ryr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Frank,

Le jeudi 04 d=C3=A9cembre 2025 =C3=A0 12:34 -0500, Frank Li a =C3=A9crit=C2=
=A0:
> > +static struct v4l2_m2m_dev *hantro_get_v4l2_m2m_dev(struct hantro_dev =
*vpu)
> > +{
> > +	struct device_node *node;
> > +	struct hantro_dev *shared_vpu;
> > +
> > +	if (!vpu->variant || !vpu->variant->shared_devices)
> > +		goto init_new_m2m_dev;
>=20
> I found only use shared_devices here, how to=C2=A0 ensure that g1 and g2 =
operate
> alternately by using shared_devices?

shared_devices is an array of of_device_id we match against. All the matchi=
ng
devices will share the same v4l2_m2m_dev (aka m2m scheduler). Typically, bo=
th
cores will be schedule as one. This achieve what alternate operations witho=
ut
active polling or blocking locks/mutex.

For this platform, we only matched against the compatible for simplicity, s=
ince
we know there is only one of each type. I've suggested this method to Ming,
since it will make it really easy to apply such a quirk if other hardware h=
ave
problems or design constraints.

regards,
Nicolas

--=-MBM9wOUi8PufoWyT5ryr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaTHPyAAKCRDZQZRRKWBy
9FdpAP0WVi613vUGZXZ8B9/zghQmLePsDyJ2PS2cgoKj3hjSLwEAuoGzRC6WOtML
GYwvZvgMPtF3PhbqORxXKjZpwhicvwA=
=JuBF
-----END PGP SIGNATURE-----

--=-MBM9wOUi8PufoWyT5ryr--

