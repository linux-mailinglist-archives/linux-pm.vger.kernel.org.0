Return-Path: <linux-pm+bounces-39224-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D629BCA5B98
	for <lists+linux-pm@lfdr.de>; Fri, 05 Dec 2025 01:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44BE23005BBC
	for <lists+linux-pm@lfdr.de>; Fri,  5 Dec 2025 00:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E47625;
	Fri,  5 Dec 2025 00:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="gc3Isf19"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECED78C1F
	for <linux-pm@vger.kernel.org>; Fri,  5 Dec 2025 00:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764893107; cv=none; b=UfNK7EuNvPpsFPmmv4V4ZBZFCA0+QI7iQkzGaeSS3JE4EJI69VyCzHz8nLO54jsvXh7oG3HevUVKQq+9j4uV4P9FavqxHShQBQXjy4WfMaRebc5yizcbo6t3Bn9HZQda8xcYpCYyqzkjsjjEwCqUrI3ANDhAGa69rTVqBvZM39w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764893107; c=relaxed/simple;
	bh=7UZ1toC9e7VUfNw46vgrmC1pH5XkA/pO6zTakAJTxvQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ear8RLR18XEsJjzdylqftfVcIWS7lEA3CRKjAXlMGZxTNu8LelqymXPRuB+biQHv3rdT9nRaicqhat/AJS7y48/ZxxYHFVJ/UCp33No5xcuSOZX8QBOa2Hk1N+NmtC6TcGm2WHdo8FTiQpia9puAnSJxP0BMN5gQLLLRNXaZeqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=gc3Isf19; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8b2ed01ba15so115238985a.1
        for <linux-pm@vger.kernel.org>; Thu, 04 Dec 2025 16:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1764893105; x=1765497905; darn=vger.kernel.org;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
         :from:subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QsEkGNQ0X1iLzP6SENhOBfRJJANLqH3MtVROdQOe/tI=;
        b=gc3Isf19FVpvKOo0lnrB04nNk4RGZ2GijYF4SIVwyV2AAnNtVlC/aBWS2SSUh5ryCc
         d8mv9v/r9K9F/Oq+EnrIiZi5Wm1J+ev6HtrNZKvVQqGE2ipZsl2fsrjufEQTvj4HaOPm
         bNQly5h2WbaOwb9b0K63X5K1ywkFKCBMXufwEgY8kXxORiVf7FiBLkhn/iFmzbsLtbRo
         FtBU3Tkkx37nuD+3koCEjHSyvURmOI7Zb6O+MwwE1Ch4rxminjLBK/X590HGUXEcwPVA
         H52O3RCqs1R2fmP0Fpbp8sDViSSFqdvs53D52JDpQIBtfCTy4crvSTRKa1ED8qH5o3a8
         itjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764893105; x=1765497905;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
         :from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QsEkGNQ0X1iLzP6SENhOBfRJJANLqH3MtVROdQOe/tI=;
        b=Wvp/hvshOq+vu/kjCsI4DmwNB3t/m1tGuXIjPNMmyID7oVuWYK2cM872fs7DszSQFG
         0OYcEMScsBM6B3sGTsm0WVjTpv/0StPi23rgDPKcbfD94O4Y0rszF7Ks3JdWn8uz8fka
         kc9DX8rx6AVzqpSCSaB2L/DFfsmoUopmQY+V930iI7kR1UWvG7QsA9Q6Z/BTn3KBD0ls
         t+DT8Oc1417aFUWW6FkyCS3ssJ0hI1x5GisBLrp47maZXSBb6+/dbH9ayFoAGGJI/Dys
         +jFQSvsXcfbWcS0AAvz/6PC1TtBuBJSZCfBo7XHETBoz93/hrgQGmtM333gpaFsGEa43
         FgiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVS7pGIIg+8afIH5l4Z1OKW+yGP9LdPse9fTpAgTbEACTggAK0wJ2RpOGRHZSJiEAKvYs6l7u/pyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YykHNJ3bLSDYyr5umqRylzuOm/wFD6cHEnn84BJBA9cu2nh7u2E
	fd/3aTqYhKnf3gv+krsk1500wVVa+i4NSqtGHMK2kWcSMlGmkoPRlL1WVzQj4l25ioc=
X-Gm-Gg: ASbGncuya5ghZejAQWGLRut+3s9zCbStK7uscXcWnu/+UO3GhwM0w9K/UV8+B3YdmoT
	RE01SZ9dKe3uouULS+h0t65Xi7nk0R5f0g+Ji+8lu68jtJNEpwfTMCCrGPSQoVppdD1ymdOiGhk
	mEam5ax7XiLpnDXHHZxhWjWaTQOenaljr6s2D+Izmmu54om8Veh25qPlZuQy4aQ6Xs5ATzvGf6P
	IIQSLUy04hVuJ0Cucook7XpjpNPaeN5wz5bwx6Os2ZQPDtfDT15VF6enfu2fb50g3MZyd7cxx1S
	VpEChlrkCacgrR1o11QhDZpVjLNf8G/BHE65sJmhL3P4SKW8MGOvHEYaZjb7h7gdxeDg7Fm0Q1i
	+ZpwhBSTP/DcsSNZ6F9DIBsYovdGO36WJM+0U4qiqD1/IWF81jtxWeCgevshpx9y5kOAvH6Bl2l
	CHES095K4kGZqMhTPU
X-Google-Smtp-Source: AGHT+IGSnH/JXwRwm6jBIx+8DOrUaP2xqYV4k8pRacxA2nEEaHNzRx2PV5KL8Zh8YrfImVMtOQRvRw==
X-Received: by 2002:a05:6214:4613:b0:87d:e32:81c4 with SMTP id 6a1803df08f44-8881955b913mr136009156d6.48.1764893104770;
        Thu, 04 Dec 2025 16:05:04 -0800 (PST)
Received: from ?IPv6:2606:6d00:17:7b4b::c41? ([2606:6d00:17:7b4b::c41])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88827f59c3fsm21465976d6.25.2025.12.04.16.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 16:05:04 -0800 (PST)
Message-ID: <b45a73845e66355080cfad0f0040b6e7a9d78241.camel@ndufresne.ca>
Subject: Re: [PATCH v3 3/3] media: verisilicon: Avoid G2 bus error while
 decoding H.264 and HEVC
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Frank Li <Frank.li@nxp.com>
Cc: ming.qian@oss.nxp.com, linux-media@vger.kernel.org, mchehab@kernel.org, 
	hverkuil-cisco@xs4all.nl, benjamin.gaignard@collabora.com, 
	p.zabel@pengutronix.de, sebastian.fricke@collabora.com,
 shawnguo@kernel.org, 	ulf.hansson@linaro.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, 	festevam@gmail.com, linux-imx@nxp.com,
 l.stach@pengutronix.de, peng.fan@nxp.com, 	eagle.zhou@nxp.com,
 imx@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date: Thu, 04 Dec 2025 19:05:01 -0500
In-Reply-To: <aTIRwcocnye0Y6yV@lizhi-Precision-Tower-5810>
References: <20251204090813.595-1-ming.qian@oss.nxp.com>
	 <20251204090813.595-3-ming.qian@oss.nxp.com>
	 <aTHGJzVKa7PbEifJ@lizhi-Precision-Tower-5810>
	 <9f38bda2f1753645a1ae392ce5364ea0165fdc01.camel@ndufresne.ca>
	 <aTIRwcocnye0Y6yV@lizhi-Precision-Tower-5810>
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
	protocol="application/pgp-signature"; boundary="=-vhLAVdUguC0rEDc5y4Vo"
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-vhLAVdUguC0rEDc5y4Vo
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeudi 04 d=C3=A9cembre 2025 =C3=A0 17:57 -0500, Frank Li a =C3=A9crit=C2=
=A0:
> On Thu, Dec 04, 2025 at 01:15:35PM -0500, Nicolas Dufresne wrote:
> > Hi Frank,
> >=20
> > Le jeudi 04 d=C3=A9cembre 2025 =C3=A0 12:34 -0500, Frank Li a =C3=A9cri=
t=C2=A0:
> > > > +static struct v4l2_m2m_dev *hantro_get_v4l2_m2m_dev(struct hantro_=
dev *vpu)
> > > > +{
> > > > +	struct device_node *node;
> > > > +	struct hantro_dev *shared_vpu;
> > > > +
> > > > +	if (!vpu->variant || !vpu->variant->shared_devices)
> > > > +		goto init_new_m2m_dev;
> > >=20
> > > I found only use shared_devices here, how to=C2=A0 ensure that g1 and=
 g2 operate
> > > alternately by using shared_devices?
> >=20
> > shared_devices is an array of of_device_id we match against. All the ma=
tching
> > devices will share the same v4l2_m2m_dev (aka m2m scheduler). Typically=
, both
> > cores will be schedule as one. This achieve what alternate operations w=
ithout
> > active polling or blocking locks/mutex.
>=20
> Okay, but this code require shared_devices=3D=3DNULL's device probe first=
ly.
> generally not order guaranteed, if there are not depentance at DT.

shared_devices is a constant array that is set inside the variant. It is
normally NULL, except for the imx8mq SoC, for which its always set.

>=20
> Does VPU always probe before g1/g2?
>=20
> and if there are two VPU instances, what's happen?

Since there is two VPU, g1 and g2, we will enter this loop:

> +	for_each_matching_node(node, vpu->variant->shared_devices) {

On imx8mq, this will match twice.

> +		struct platform_device *pdev;
> +		struct v4l2_m2m_dev *m2m_dev;
> +
> +		pdev =3D of_find_device_by_node(node);
> +		of_node_put(node);
> +
> +		if (!pdev)
> +			continue;

If the match does not have a device yet (not probe yet), we skip.

> +
> +		shared_vpu =3D platform_get_drvdata(pdev);
> +		if (IS_ERR_OR_NULL(shared_vpu) || shared_vpu =3D=3D vpu) {
> +			platform_device_put(pdev);
> +			continue;
> +		}

If its the current VPU, we also skip.

> +
> +		v4l2_m2m_get(shared_vpu->m2m_dev);
> +		m2m_dev =3D shared_vpu->m2m_dev;
> +		platform_device_put(pdev);

Finally, if the other VPU was initialized, we ref the v4l2_m2m_dev. We will=
 then
create m2m_ctx from it which will cause the two VPU to be scheduled one aft=
er
the other.

> +
> +		return m2m_dev;
> +	}

> +
> +init_new_m2m_dev:
> +	return v4l2_m2m_init(&vpu_m2m_ops);

Otherwhise we create a fresh one.

Does it make sense now ?

Nicolas

--=-vhLAVdUguC0rEDc5y4Vo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaTIhrQAKCRDZQZRRKWBy
9GE5AQDJOm22eqxSILGUVYuLEGZXBEYnvCqwMf4OaSeoN4eG6gEAshUhjhSYRqW9
GJYH8F9tSP/jNRsCAnew+09GBU8MXQ0=
=gSqa
-----END PGP SIGNATURE-----

--=-vhLAVdUguC0rEDc5y4Vo--

