Return-Path: <linux-pm+bounces-40222-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E11DACF52CB
	for <lists+linux-pm@lfdr.de>; Mon, 05 Jan 2026 19:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F1079302BF6E
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jan 2026 18:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123D933DEE9;
	Mon,  5 Jan 2026 18:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="M/shUAvW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83C5336ED4
	for <linux-pm@vger.kernel.org>; Mon,  5 Jan 2026 18:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767636610; cv=none; b=l+CjNxg6Agkqbv/ewsWps8Q9vK021eGUEyRz209nPddpZnOnde7ngGBmDjSu75Kw/jsb011mWaimp8gyCYQi0ZD6F5EU+ntyYVEfI03mB50CMkJ8e+GMiDWNTSM0jZ8kuI7d8ydN7MsPz9OlY2K5K5UMdIolILjsawpngUKW8m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767636610; c=relaxed/simple;
	bh=aOnfX3XPhgpVehluEO+HeLrdEIbIUxCCiC8mUuqAjdo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VXhREX5iejCxLnepN+TH3OILmK/VZ97R8ASUBi1cQjWciNn0NWPCtz48Yr9PevhV6VeqAciZiVapKwLb7jZPbVmvuYwmMJf+wKCEsEm+aTXCstHepNGUK9oMSar6AAgkB9O9Q/vybztHSNtGYvHd/SJABZjBRj7qHWmSoSpUT4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=M/shUAvW; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8ba3ffd54dbso22138685a.1
        for <linux-pm@vger.kernel.org>; Mon, 05 Jan 2026 10:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1767636605; x=1768241405; darn=vger.kernel.org;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
         :from:subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aOnfX3XPhgpVehluEO+HeLrdEIbIUxCCiC8mUuqAjdo=;
        b=M/shUAvWtuGg25JQahxti0tqMV1RLsTH33BA/OrLQ5RqHVRx25YdqwvkOPvIx2Hacl
         nNj+8JJ9OSNOwZLJOdww30f0xb93hEJihrBXXFq4iDupVDXVjqDFCSDXJycqaoLRIgMa
         r34aKJ4emH8gOcyNXIP5EacoTi+8BNg9EcUaHKEg5U9aJyZD4wCJrHbp7Sk+AglBaNqW
         Kngx8qVIxmZ0d7TZetTFYHa4DBOyeFB5eia6+VGvrgjDyks6eNa1akLhylOY8DoJd/ff
         L/HvOrFjI6+KqprTMJdRKHgx3wiwTpt2oiM5mlcaIGN11z8CXNSzh58Ccuw7eZRNLlyA
         a8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767636605; x=1768241405;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
         :from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aOnfX3XPhgpVehluEO+HeLrdEIbIUxCCiC8mUuqAjdo=;
        b=QRX5FBKx/VfY+dEHoPbdvz2+krZEJIf1anm+qVyukElkBs08nlp4MkszcrkLYz60gi
         N17zf2K4NtAFYf+9VP0GAp8C8hJvjiYjhVKjQtVJMbxz+I/e4rDME7WCegKhrD2rvrLk
         wn18kld37SVCWisxoP0AbWBlMBiDpmWFezowZg3uOtw2hmUE1jGvSLUU4GM190Xyma6J
         SCK2n2+6yLCKbKWveJC4173ji6p90ICBfMrDl/9+LWFLO3LSXQXmfEpxBr+mcs/1v+EU
         IAXSv7o29TR6QFDuAsZenLbwLFpLPt8GKN60ND/3BLMqJuuvgxripugLWctXQAqSHvQf
         dXZg==
X-Forwarded-Encrypted: i=1; AJvYcCW0bRRLj1YRgnR6ZJyzIE8qnVr/sHF4T9RUrXmaU0oR/L9VVJJwMnsTwoBbpLBw7uvNYxB2JjMPmQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEwM4N9xTVWXErp5PIEPiv9YCpBa9CyqfBfNGuoRa7k7aztqmA
	NsJldljMct21VoT1LvkAQXfY3yWjjwERizlY7PMCZ6DydpkTg/Nz9PulZt4H++qIoYQ=
X-Gm-Gg: AY/fxX6Jp1U6+8vn1HZfHlGspUhnY0QgjwtsrKZSXIbqdGO5tB1bz69lWGHNULqJ/Dm
	3PL7D7LmGhJRTkOGwh61ZH4ed1NiSEbiHZxf7hrMlu8SCY3iSdjhZirn2n5HfUe2yfUlSK69aO1
	5aot0TLFzDhmUvXIyvztg961dwy3jDkYuVupDixaduafHj0g7BRUB2hgSIxP3bn85oEZt7opEor
	FqSDROOPz8QJmyKxloaj3RW9X+H3MmEe0Y4KfMYtbU70a5V+Wds3fLAiWOybIVduVj2qJp2lJtZ
	rFjJymnloVbSOt1XFvGWmglq/iizfsrZzSru5ODPtc/wP602AIpj/phuRyz9lorH30RFBf8HNNt
	46Es5k08hnTstlAEvj0p9N1BgAXvaYbdpfwSUnsJGqRKWZuoJNSnwMnx9IrWgqjGipqQhoLAdan
	F7sIU7zeGKvK47kHz2naUIlPPiowM=
X-Google-Smtp-Source: AGHT+IFR3DFd9jpe0oN2x6M/8bWNFU8mAiEEjbZ9LTTfuDxwfvW0bq8zMCRJmYOp1ZK5Jd4YL/mM9g==
X-Received: by 2002:a05:620a:46a0:b0:85b:8a42:eff9 with SMTP id af79cd13be357-8c37ebbb452mr64060085a.53.1767636604517;
        Mon, 05 Jan 2026 10:10:04 -0800 (PST)
Received: from ?IPv6:2606:6d00:17:7b4b::5ac? ([2606:6d00:17:7b4b::5ac])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4a9a19sm3638685a.1.2026.01.05.10.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 10:10:03 -0800 (PST)
Message-ID: <4d885ca36bef3e8227f8e0ee80bf5bcc3959e9ce.camel@ndufresne.ca>
Subject: Re: [PATCH v4 0/3] Fix concurrency issues between G1 and G2 on
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Ulf Hansson <ulf.hansson@linaro.org>, ming.qian@oss.nxp.com
Cc: linux-media@vger.kernel.org, mchehab@kernel.org,
 hverkuil-cisco@xs4all.nl, 	benjamin.gaignard@collabora.com,
 p.zabel@pengutronix.de, 	sebastian.fricke@collabora.com,
 shawnguo@kernel.org, s.hauer@pengutronix.de, 	kernel@pengutronix.de,
 festevam@gmail.com, linux-imx@nxp.com, 	l.stach@pengutronix.de,
 Frank.li@nxp.com, peng.fan@nxp.com, eagle.zhou@nxp.com, 
	imx@lists.linux.dev, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org
Date: Mon, 05 Jan 2026 13:10:02 -0500
In-Reply-To: <CAPDyKFpFm9kCSNbALJTqeyzFdg3OoooE2gUOXJcjv=WgQeZ84Q@mail.gmail.com>
References: <20251205015428.643-1-ming.qian@oss.nxp.com>
	 <CAPDyKFpFm9kCSNbALJTqeyzFdg3OoooE2gUOXJcjv=WgQeZ84Q@mail.gmail.com>
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
	protocol="application/pgp-signature"; boundary="=-zvFzPoy3A7lV+wocoxlB"
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-zvFzPoy3A7lV+wocoxlB
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le mardi 30 d=C3=A9cembre 2025 =C3=A0 14:42 +0100, Ulf Hansson a =C3=A9crit=
=C2=A0:
> On Fri, 5 Dec 2025 at 02:55, <ming.qian@oss.nxp.com> wrote:
> >=20
> > From: Ming Qian <ming.qian@oss.nxp.com>
> >=20
> > On the i.MX8MQ, we encountered some concurrency issues with H264 and HE=
VC
> > decoding.
> >=20
> > There are two main reasons:
> > 1. The vpu blk-ctrl don't have separate reset and clock enable bits.
> > 2. The g1 VPU and g2 VPU cannot decode simultaneously.
> >=20
> > We attempted to make corresponding fix to address these two issues.
> >=20
> > Ming Qian (2):
> > =C2=A0 pmdomain: imx8m-blk-ctrl: Remove separate rst and clk mask for 8=
mq vpu
> > =C2=A0 media: verisilicon: Avoid G2 bus error while decoding H.264 and =
HEVC
> >=20
> > Nicolas Dufresne (1):
> > =C2=A0 media: v4l2-mem2mem: Add a kref to the v4l2_m2m_dev structure
> >=20
> > =C2=A0drivers/media/platform/verisilicon/hantro.h=C2=A0=C2=A0 |=C2=A0 2=
 +
> > =C2=A0.../media/platform/verisilicon/hantro_drv.c=C2=A0=C2=A0 | 42 ++++=
+++++++++++++--
> > =C2=A0.../media/platform/verisilicon/imx8m_vpu_hw.c |=C2=A0 8 ++++
> > =C2=A0drivers/media/v4l2-core/v4l2-mem2mem.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 23 ++++++++++
> > =C2=A0drivers/pmdomain/imx/imx8m-blk-ctrl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 11 +++--
> > =C2=A0include/media/v4l2-mem2mem.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 21 +++=
+++++++
> > =C2=A06 files changed, 100 insertions(+), 7 deletions(-)
> >=20
>=20
> Can I pick the pmdomain patch separately from the others? Or does this
> need to go together?

I believe you did already, and its perfect, we have picked the rest in the =
media
tree now.

regards,
Nicolas

--=-zvFzPoy3A7lV+wocoxlB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaVv+egAKCRDZQZRRKWBy
9FfKAPwIfuzu0Oju3HLojCHI9FM9JdnnqW5c8KFbwAK37MdTNgD/erN0pVhummc6
5FGqJ5UvmnrrAGczimw1n6SlMWulQQk=
=CTsW
-----END PGP SIGNATURE-----

--=-zvFzPoy3A7lV+wocoxlB--

