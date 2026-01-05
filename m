Return-Path: <linux-pm+bounces-40221-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C9CCF52AD
	for <lists+linux-pm@lfdr.de>; Mon, 05 Jan 2026 19:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AFFFA300968D
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jan 2026 18:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB6533DEE9;
	Mon,  5 Jan 2026 18:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="yisDBJm2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11622749DC
	for <linux-pm@vger.kernel.org>; Mon,  5 Jan 2026 18:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767636495; cv=none; b=RKQCyidk3ZRMgpC9hcFGTQ9Z3AaPsrqFXTt+MHKhT088id+AGb79GYyS4BbviPqGZsw5EfcHsiGDCChvwKBXhRv3wJMu3VW4Aw2L9ETUk2qxszchpJqVWHyzEhDOh93MVvRfduRkSxZcd98JzWyqehdB5VpRJL75nAbzcrJg4wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767636495; c=relaxed/simple;
	bh=1gtqFFWFbmnYqsdra7V6E0H/IysyN/79mV6ZrXnL61U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gFYJVpkSXhye+nm6fxkcGblRP9MQoFFNa/RMFFknQ4S3ZL3u4XQr4oChs1toEoaEF+qrdgHZEvDGSNnB4kLeGa4uOKydOjxB9tkqdKyxh58WDadqONwHAv3qmTmwhEa850xDrURoJIQOfZR3wW3z6AJ+8WglG25GcCIKa1p3zwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=yisDBJm2; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-88a37cb5afdso25349326d6.0
        for <linux-pm@vger.kernel.org>; Mon, 05 Jan 2026 10:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1767636491; x=1768241291; darn=vger.kernel.org;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
         :from:subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1gtqFFWFbmnYqsdra7V6E0H/IysyN/79mV6ZrXnL61U=;
        b=yisDBJm2Dtn+X6tKZIZZG+xtMBUpoCV+GG4e7iDhXHFW145Q88FNds/eIL5EJLbf8l
         z3rV/zH5OyFgmCvAWCeHOMlGUb8BFCQ4ynfd8KHKGIRxwgoeja2BLMlIqCbeL1H6vH3X
         cNCXTqtbAEXX9+kFTzHtekUCgX4vTTJzZHUn5Xe9sQgmEVhRGhjoxr6fpP2gff2G+5J2
         odKVu5S+bnTzIRdb/Vvot1RJV2ljjRJ1qfcJDrpLKngG6Yw9IgSll/9Zivsfa6PubmRQ
         4LTlikSmak9PZ7T3RGmjcsrwsD+8qIVLaU4skLfmWpdaEa8RahcRGW0OvBYHWdazKu5n
         +Y3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767636491; x=1768241291;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
         :from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1gtqFFWFbmnYqsdra7V6E0H/IysyN/79mV6ZrXnL61U=;
        b=tEyHweuTpqTrxgvqYmyoSe9LG4Uga8pk6pfMcrS3UaIscxkYoKJYfOABRnQbvHg4Sx
         08/vvGIJeLJTqnmjtK4toQ2/CxKDhQaSEZ/YqtY/O3smaqtDpkAif3H/TQNkKGJ3UY5l
         8QI/jJbvvhwBeUINz6lQlJQcC7n+01f5Z0nlrcA+kS6H7MoEVCiWvoPEyKId+ZwQ+niM
         hQ3Q0CtQx1chX9U3fy18C7G+bMOQr+xi9kHvKE+L/9zgIjj5yTpvuHNLWf9Br/S/WSxH
         FNjH3bR3UDgYiHu3imLFr+5NmpV155YEyA+lhQtvR777Ecur+4iEaT6IwF7PWvCDhczZ
         sM1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVKvJn7RU+7PzGFvPwYtpwDNIcwyy4g527UxS07wT7O0DMe+oW+9yNdiUfJg2LYPjT//LRC1g6aOA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9wuEW0s0zV5vIZehydo3W/8UsRdp8oio6tIgg3khsyGnM0js8
	MSvb0GRL6ULMck9pX9obdQx1yDXkMRyEUZGoQrykkNv5L9v7rquykmF2woz9rW2Tge4=
X-Gm-Gg: AY/fxX460ewWzuSHkX8wsXN5DU/+c8lkkYIRhUfsl1UqkNpkiRQi1CaZizoc3ufnQ41
	llS8QIAVMdH9fdRhtayKOHwAh+NIqnF4LJ/7uR21ccAHYZmkq9sZAZFArQrNLbAYiYuUMxBCisH
	cP+ey6CEZL0cLzbgl0xwkLT+1h38jtFeENLrkKVxpu+a9z+V8hbweHS4iIawZvf0N5WKvmb4uEu
	N4epoJC+EScT8gDNyTJCNshl9rZHu68M7LGYg1BW+NbBX6tGK/luunyyiXjCtffBRdzJXuCBLHE
	zP/PUnI4f1//DEsIIGPEGNh20trcSX7myikbl9Me0L9g7AsrFjQo4AhCp5vsXRVm4I8ppKy09/+
	RBUXB5zMErFLKhxH3NZNqobFM+XVVi8oyS2uko0jQPoTc2S5q7QHcszdgj1Xaxx1N6mJvdjAdi1
	GVcCHYvoIen+Kn+M1n
X-Google-Smtp-Source: AGHT+IENhU1Bd6KYqPomQwkI/vDljW6F2Sf1y49E1gWNuGUePlUTcFMG+iVNXpq2O9aWulA+yUJXTw==
X-Received: by 2002:a05:6214:224e:b0:88a:525a:8dbf with SMTP id 6a1803df08f44-890769ababcmr850536d6.15.1767636491324;
        Mon, 05 Jan 2026 10:08:11 -0800 (PST)
Received: from ?IPv6:2606:6d00:17:7b4b::5ac? ([2606:6d00:17:7b4b::5ac])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890753ef51csm3947706d6.16.2026.01.05.10.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 10:08:10 -0800 (PST)
Message-ID: <16eb88083b68e3701f22799d8ccc20b800b59d61.camel@ndufresne.ca>
Subject: Re: [PATCH v4 1/3] media: v4l2-mem2mem: Add a kref to the
 v4l2_m2m_dev structure
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
Date: Mon, 05 Jan 2026 13:08:08 -0500
In-Reply-To: <CAPDyKFpt-GL-RFcJ5mTWFqaRfy1dQJ7LL8OBCoQK0+zPDFEzsg@mail.gmail.com>
References: <20251205015428.643-1-ming.qian@oss.nxp.com>
	 <20251205015428.643-2-ming.qian@oss.nxp.com>
	 <CAPDyKFpt-GL-RFcJ5mTWFqaRfy1dQJ7LL8OBCoQK0+zPDFEzsg@mail.gmail.com>
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
	protocol="application/pgp-signature"; boundary="=-4H25zADnHXlwNymaecNy"
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-4H25zADnHXlwNymaecNy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le mardi 30 d=C3=A9cembre 2025 =C3=A0 14:39 +0100, Ulf Hansson a =C3=A9crit=
=C2=A0:
> On Fri, 5 Dec 2025 at 02:55, <ming.qian@oss.nxp.com> wrote:
> >=20
> > From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> >=20
> > Adding a reference count to the v4l2_m2m_dev structure allow safely
> > sharing it across multiple hardware nodes. This can be used to prevent
> > running jobs concurrently on m2m cores that have some internal resource
> > sharing.
> >=20
> > Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> > Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
>=20
> I certainly don't have the complete picture for how this needs to work.
>=20
> However, I was thinking that rather than using a kref and having to
> share two specific functions to update it (v4l2_m2m_get|put), couldn't
> we just use a device-link instead?

The device link seems to be intended for power management, I'm effectively =
not
familiar with it, so thanks for the information. However, my impression is =
that
this is indented to describe power management dependencies on siblings, but=
 this
was done differently on this SoC (way before my time here), the DT seems to
describe a block controller which is common to the two (defective) cores. S=
o
power management wise, its already handled.

Be aware that my intent is to rename v4l2_m2m_dev into v4l2_m2m_sched. Its =
not a
dev wrapper, but a helper object that will schedule work coming from N
v4l2_m2m_ctx (per open() calls). Making this helper object ref counted make=
s the
live-time management a lot simpler, and since its not a dev wrapper, this p=
atch
is not creating a second refcount for the same object.

regards,
Nicolas


>=20
> Kind regards
> Uffe
>=20
> > ---
> > v4
> > - Add my Signed-off-by
> >=20
> > =C2=A0drivers/media/v4l2-core/v4l2-mem2mem.c | 23 +++++++++++++++++++++=
++
> > =C2=A0include/media/v4l2-mem2mem.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 21 +++++++++++++++++++++
> > =C2=A02 files changed, 44 insertions(+)
> >=20
> > diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l=
2-
> > core/v4l2-mem2mem.c
> > index fec93c1a9231..ae0de54d4c3e 100644
> > --- a/drivers/media/v4l2-core/v4l2-mem2mem.c
> > +++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
> > @@ -90,6 +90,7 @@ static const char * const m2m_entity_name[] =3D {
> > =C2=A0 * @job_work:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 worker to run queued jobs.
> > =C2=A0 * @job_queue_flags:=C2=A0=C2=A0 flags of the queue status, %QUEU=
E_PAUSED.
> > =C2=A0 * @m2m_ops:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 driver callbacks
> > + * @kref:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 device reference count
> > =C2=A0 */
> > =C2=A0struct v4l2_m2m_dev {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct v4l2_m2m_ctx=C2=A0=C2=
=A0=C2=A0=C2=A0 *curr_ctx;
> > @@ -109,6 +110,8 @@ struct v4l2_m2m_dev {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job_queue_flags;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct v4l2_m2m_ops *m=
2m_ops;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct kref kref;
> > =C2=A0};
> >=20
> > =C2=A0static struct v4l2_m2m_queue_ctx *get_queue_ctx(struct v4l2_m2m_c=
tx
> > *m2m_ctx,
> > @@ -1200,6 +1203,7 @@ struct v4l2_m2m_dev *v4l2_m2m_init(const struct
> > v4l2_m2m_ops *m2m_ops)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INIT_LIST_HEAD(&m2m_dev->job=
_queue);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock_init(&m2m_dev->job=
_spinlock);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INIT_WORK(&m2m_dev->job_work=
, v4l2_m2m_device_run_work);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kref_init(&m2m_dev->kref);
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return m2m_dev;
> > =C2=A0}
> > @@ -1211,6 +1215,25 @@ void v4l2_m2m_release(struct v4l2_m2m_dev *m2m_d=
ev)
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL_GPL(v4l2_m2m_release);
> >=20
> > +void v4l2_m2m_get(struct v4l2_m2m_dev *m2m_dev)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kref_get(&m2m_dev->kref);
> > +}
> > +EXPORT_SYMBOL_GPL(v4l2_m2m_get);
> > +
> > +static void v4l2_m2m_release_from_kref(struct kref *kref)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct v4l2_m2m_dev *m2m_dev =3D =
container_of(kref, struct
> > v4l2_m2m_dev, kref);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 v4l2_m2m_release(m2m_dev);
> > +}
> > +
> > +void v4l2_m2m_put(struct v4l2_m2m_dev *m2m_dev)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kref_put(&m2m_dev->kref, v4l2_m2m=
_release_from_kref);
> > +}
> > +EXPORT_SYMBOL_GPL(v4l2_m2m_put);
> > +
> > =C2=A0struct v4l2_m2m_ctx *v4l2_m2m_ctx_init(struct v4l2_m2m_dev *m2m_d=
ev,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 void *drv_priv,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 int (*queue_init)(void *priv, struct vb2_queue *src_v=
q,
> > struct vb2_queue *dst_vq))
> > diff --git a/include/media/v4l2-mem2mem.h b/include/media/v4l2-mem2mem.=
h
> > index bf6a09a04dcf..ca295c660c7f 100644
> > --- a/include/media/v4l2-mem2mem.h
> > +++ b/include/media/v4l2-mem2mem.h
> > @@ -547,6 +547,27 @@ v4l2_m2m_register_media_controller(struct v4l2_m2m=
_dev
> > *m2m_dev,
> > =C2=A0 */
> > =C2=A0void v4l2_m2m_release(struct v4l2_m2m_dev *m2m_dev);
> >=20
> > +/**
> > + * v4l2_m2m_get() - take a reference to the m2m_dev structure
> > + *
> > + * @m2m_dev: opaque pointer to the internal data to handle M2M context
> > + *
> > + * This is used to share the M2M device across multiple devices. This
> > + * can be used to avoid scheduling two hardware nodes concurrently.
> > + */
> > +void v4l2_m2m_get(struct v4l2_m2m_dev *m2m_dev);
> > +
> > +/**
> > + * v4l2_m2m_put() - remove a reference to the m2m_dev structure
> > + *
> > + * @m2m_dev: opaque pointer to the internal data to handle M2M context
> > + *
> > + * Once the M2M device have no more references, v4l2_m2m_realse() will=
 be
> > + * called automatically. Users of this method should never call
> > + * v4l2_m2m_release() directly. See v4l2_m2m_get() for more details.
> > + */
> > +void v4l2_m2m_put(struct v4l2_m2m_dev *m2m_dev);
> > +
> > =C2=A0/**
> > =C2=A0 * v4l2_m2m_ctx_init() - allocate and initialize a m2m context
> > =C2=A0 *
> > --
> > 2.52.0
> >=20

--=-4H25zADnHXlwNymaecNy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaVv+CAAKCRDZQZRRKWBy
9GnBAP9YVI4l3nVSoW8LuEWowJqpYHQplV4632VpWVcZXPWxgQD/VvEAJf8OJJu4
siPIvlpEB/ftrpXiSKkVbExl1UWd6AI=
=a96A
-----END PGP SIGNATURE-----

--=-4H25zADnHXlwNymaecNy--

