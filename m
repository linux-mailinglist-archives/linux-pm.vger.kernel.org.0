Return-Path: <linux-pm+bounces-39104-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7CEC9CE31
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 21:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0799F34834E
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 20:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B2E279792;
	Tue,  2 Dec 2025 20:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="pDRixGw2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36F6212574
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 20:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764706906; cv=none; b=CyFUnEp7++8etEr3ntxaxXV6OyR5mWv5emBpeRKxMoN3yMrTGpNujW7ag0t4hDpoHxsAY5SB19/Ts+lZEAx+TXCxuGjcLOh3sppldB7lsFMg8pOWdNBC74Rr3ALMKzG6A+/vUMP5c//R/j5bYM7XVs7yTkm7YR7VYMKkiiIzack=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764706906; c=relaxed/simple;
	bh=A0PSVgMbPgZnF/0MjPtEhWWUYOjFqFjkifaKlO/6NJE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ETHn0fqD0CWwWe+tIWpJuXDuGH7N+KROYEkZLimjGiSJ5ASukOEHS2cX36KYhDvaHIUc9pwGRrkRsLojFfJpxzaQ2AxG3gGAV71OCorZgmSRi7tWNxKoMKO8Jt3COArQxbBAkOARvoI9QY5Znid8jpkZW6BvrZo2qRPOTvsVBWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=pDRixGw2; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8b2dec4d115so594990985a.0
        for <linux-pm@vger.kernel.org>; Tue, 02 Dec 2025 12:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1764706904; x=1765311704; darn=vger.kernel.org;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
         :from:subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=A0PSVgMbPgZnF/0MjPtEhWWUYOjFqFjkifaKlO/6NJE=;
        b=pDRixGw29NAgkCv0LmsAM3Wf61/LRS/OOnpKh7PU0TMSJapAbiK+gPuo+UBlDjhi/y
         HNqwJEBKwtoIlI8JGH2/AKncqNctnZSQalTC+kUoBX06q2llsytoWlrKbXmILRMhQQEU
         rp76SoiEHBw3LhKVtDUgeaD7frU30AF/bg8rTTwJlTqK91TNHyIj+nm7V5cpEVgLo+VS
         HsYQuz8REKPkB2BExS55nNEej4R1RnE6cE7yrR+i78yjm0trg3H7oA97VdWGU6t2cehf
         ZDqCMwxCmYn4dPuuNW4r3X0bQ3OqgKAXA9wyuKSrYs5OzwJpL88VM5+EoBBEDv8wpjQB
         QyNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764706904; x=1765311704;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
         :from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A0PSVgMbPgZnF/0MjPtEhWWUYOjFqFjkifaKlO/6NJE=;
        b=E6dS62MkCnSt3FYudYq9B0TuOqGIGtjC2GwuuKOMY4XaP9QlwOLzPwm3ymJ33JlsG8
         22Oaq0cbVNpAbzKRRK5UGF1FWzsLjTZjxJlwMCtBxwd9AQIx4b4zZ3rDlWa0P8niNxIx
         4uUTsTcxdM/s4G/1x6vtoEegPKl7iYGLLrj47fPrNrREyhdJ+mUjO2jkcoV7qBCXJ1P6
         ml3GNLwYiGtKxXk08FcuGfkehOqAn2/Wa0B4MmixGHdJzuaBBCO4a621wvLOUZ6UQAmv
         JpLLHckliXn9fx/wXf04A3xChJj7X4dtQ268Hi8rRQ/b3tEyVsxIVVpCZL1CSkbiG6XM
         FQfw==
X-Forwarded-Encrypted: i=1; AJvYcCXULcBafCz22Uxb2JaiL3pn3+E2ZFibs0nI9yJTTbaRTI7FYxYvzdSRn1uKTtIbyoSC0OdLXisWYw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPJIME3PylcdAyzm49NRZtKi+dDo+fuRZK43yUwKPh762ZbX5/
	MRrslmN6wiQjBLuSMcVFZApMr5mbDpm6HzeX9MpTdkDT6p4rEwGT0D4XXZGKH23ZNKs=
X-Gm-Gg: ASbGnctB8ur8+9CI9p20l87xeCLrziqu4uudg4EKUSLwm1HKZQA7IU824PKX7Wzk3wD
	K7PGySc1KA6t3ppyH6AWNlWIlSb8jzbyMh2sTaCaQLUJo5EkF8zaBsUobHzDJeM8ZvD/4nj1XA3
	jjuvuEYtcWBeoG7cwkuMw0r+IMVgBpge5yzzMEuTIlaV596dleII42PoHOosK24OWsxU68pyf/C
	//mq0Qcjj2xW84NY6IwDCyVbqedqk35QtihZxtdRUidE/piZh0xanyFwJArznAtd+yCv0t7kr9e
	vyCDdON5aLpmP7CB2ogJ2Ij2QGDYo3pMn3QWMhD5slkufoR14oDo2wUAN8hrUTSJApdZk7p9F6+
	FU9CEWhoMrevtEgDXFnsHbsm5y4DkMuIUpuaI9qlk+OKf+3/IRno2VdAnlfhpvRujGEAWhrqQ9N
	zers4DwzYbjkhecD5l
X-Google-Smtp-Source: AGHT+IGB/lTPqo8FUB1K8vcEzaAXKNJ3jkLu9HLwdfEC+eATOB31NhxyLoJxF149M0NnfHLXi/G67A==
X-Received: by 2002:a05:620a:1a9b:b0:89f:1204:504a with SMTP id af79cd13be357-8b5d2f12a5fmr116472585a.57.1764706903517;
        Tue, 02 Dec 2025 12:21:43 -0800 (PST)
Received: from ?IPv6:2606:6d00:17:7b4b::5ac? ([2606:6d00:17:7b4b::5ac])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b52a1b74f3sm1140019585a.26.2025.12.02.12.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 12:21:42 -0800 (PST)
Message-ID: <570d444a92b0e49a11379cabc8f7f838e5228f7a.camel@ndufresne.ca>
Subject: Re: [PATCH v2 2/2] media: verisilicon: Avoid G2 bus error while
 decoding H.264 and HEVC
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: "Ming Qian(OSS)" <ming.qian@oss.nxp.com>, linux-media@vger.kernel.org
Cc: mchehab@kernel.org, hverkuil-cisco@xs4all.nl, 
	benjamin.gaignard@collabora.com, p.zabel@pengutronix.de, 
	sebastian.fricke@collabora.com, shawnguo@kernel.org,
 ulf.hansson@linaro.org, 	s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com, 	linux-imx@nxp.com, l.stach@pengutronix.de,
 Frank.li@nxp.com, peng.fan@nxp.com, 	eagle.zhou@nxp.com,
 imx@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date: Tue, 02 Dec 2025 15:21:40 -0500
In-Reply-To: <64ad3d66-4edf-4a0b-8992-0db0e90a32b0@oss.nxp.com>
References: <20251128025117.535-1-ming.qian@oss.nxp.com>
	 <20251128025117.535-2-ming.qian@oss.nxp.com>
	 <46e9a5a881946d879d1b2af3421d574b26256ae3.camel@ndufresne.ca>
	 <64ad3d66-4edf-4a0b-8992-0db0e90a32b0@oss.nxp.com>
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
	protocol="application/pgp-signature"; boundary="=-fFM28PG+mNKcm637EtVe"
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-fFM28PG+mNKcm637EtVe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ming,

Le lundi 01 d=C3=A9cembre 2025 =C3=A0 09:52 +0800, Ming Qian(OSS) a =C3=A9c=
rit=C2=A0:
> > Then instead of this, I would like to add a kref to v4l2_m2m_dec, I che=
cked
> > already and this is both safe and backward compatible.
> >=20
> > Then in the get function, you will walk over the compatible that are
> > different
> > from the currently probe node. If you find one that is initialized, you=
 will
> > call v4l2_m2m_get() to obtained a shared reference. In _remove() you wi=
ll
> > simply
> > do v4l2_m2m_put() instead of v4l2_m2m_release().
> >=20
> > Hope the others are happy with this. For Hantro drivers, this will make=
 it a
> > much more powerfull mechanism.
> >=20
> > Nicolas
> >=20
>=20
> For v4l2_m2m_get() and v4l2_m2m_put(), do you mean defining these two
> functions in v4l2 m2m, instead of just adding them in the hantro driver?

my idea was to add a kref to be able to share v4l2_m2m_dev. One thing I not=
ice
is that its the v4l2_m2m dev that creates the media controller on all other
drivers. Note sure why Hantro does it own still, maybe it predates, maybe i=
ts
something else.

Its quite weirdly glued together, since the v4l2_m2m_release() function jus=
t
happily free the m2m_dev without even trying to cleanup the media controlle=
r. It
totally orthogonal to the job queue, maybe it shouldn't be there.

I'll make an RFC for the kref anyway, if that has a change, I'll try and sp=
lit
out the v4l2_m2m_mc_dev on it own, so driver can share a m2m and use the
helpers.

Nicolas


--=-fFM28PG+mNKcm637EtVe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaS9KVAAKCRDZQZRRKWBy
9FwpAQCE8mMTD4iXjzvjVTfRBA1nQ1p6o6DmW7kVwZdUjhgwmAD/ZZDhUJ/ZxJ5m
bTyOTlRWmN/+KTAIgA9It8hO1jE00g0=
=pT2D
-----END PGP SIGNATURE-----

--=-fFM28PG+mNKcm637EtVe--

