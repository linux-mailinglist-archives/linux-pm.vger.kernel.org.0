Return-Path: <linux-pm+bounces-38903-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BB56EC93317
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 22:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1374034C5A6
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 21:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509742D4B68;
	Fri, 28 Nov 2025 21:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="JGwyx5ta"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3697C29E0E6
	for <linux-pm@vger.kernel.org>; Fri, 28 Nov 2025 21:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764365326; cv=none; b=K/VWFyq2hNOxMaFLRF8JCG2IEDEm5gjVEscdAwhn31O0dsX/iCWSs/qw9zxRNXXYGyrFKqfsfAuo9Q1ZP2WSJuLHJS2wxnn87e7pwQqOj+6UktWY9w99S9fFQIPJ52Enm9oBmi+N8nCblzmmfDQMUoNSvMch5a3jhKgk1Ncyjng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764365326; c=relaxed/simple;
	bh=tmVTnuvxR0wK6ZuW9OPVuqO+nqK/SMC9A1+2qGeSvSQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EHI0+uiAv9XA3jjXqnlGRdZbm0yMAJOVdLJ91jR5KZj6R6afoKQE6b9+pv0k3rviyphJYSRJbqhYcoAtQRi+Bt1FAr9JodpBP9u2Tqg2jB1PVijbv4HWMB1RYuPGAWj1QNICJXOZgsSWFMvdVrurl8aQqA2qNSxZqerom35Shwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=JGwyx5ta; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-882399d60baso17884786d6.0
        for <linux-pm@vger.kernel.org>; Fri, 28 Nov 2025 13:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1764365323; x=1764970123; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=g6w8QrfrOXi6sp9Fe0hRWKIBPis0Rvyzh9m6dBqHPME=;
        b=JGwyx5taRneXtdLYvLmKTCuMZqI79i5BQO8Wt9liXJFf6HqgWyJ+YAS12DcoLylpzf
         YmoiNRmyDVzLYmCWOs4qm+CNj3e+CRNDye9pHLTVdXW3Hm23siKXIH22BlibQXrQAn1a
         n7aRatf+EWErjjy83pHTpm78npCZHakKBol6R89R7TauiPMl1OtrzNon+9jqgycRZn+M
         Q5MqiygisTr4Uh/QMknPLbPOp1pT1bc25Jv4mGE0quH5tEtpNkRFXOBXspEoYj8Fz7Ml
         uaijetL+B0cQXy2feUoIDUNZhlvmOBYuasOS8d7r/aO18bNYv8vnVhORKhZiF1RmzhQF
         RObw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764365323; x=1764970123;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g6w8QrfrOXi6sp9Fe0hRWKIBPis0Rvyzh9m6dBqHPME=;
        b=s5yNafuhV1phDe+r2pQBOs0dqmEjs23ikSnED74bvGCtsiUfNWEer86NqqzVnAp0VT
         O1p1Knr63G9lPgffFPnl2fN20mwZyNP6WRvT1JDPYEZLly7NWoyg8IdCFBVOzPlLLsSl
         LyVgGuIoTao4/st590zcgXASrlMUkXB0LYz+SUWmzvrCGi4X/u3n0Xd4D32RGe/t4wuf
         M+pJEOtABWe0aJMNI+j7nVcKFjSM7twVLBNV1P4s2ezRjJFRFsNx26qZFcRPPEpPMih3
         OBakK17e5EtrH2tk58wj5Zj5pHiJdBXsK4vhtkUwJu61R645iD1sNeC+B2xiBnLfhLVe
         epbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHB9oKjLv8Ibqer42kVFRX+sta60zOY01Q54dClM5ysN1c4W4/sbYiwumts6ovLzhrZe4Ts3hpWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YytD8oK3GTBkHXa4VvJtYQCwNGLQQ9RsZQRrp0AkYHgumMCXwRc
	gTflhsSe10zdguplXkXLhEq//VnqXUI9Agqo7Te/p8dTwfUZ3VFX2CLYxxDYY7YzTUg=
X-Gm-Gg: ASbGnctvpsHJSgRa4rH6ew8s0TTeBOlNN/Wtrm5+SbJ9zIDFy6axD6oPLW3ZP4CyJWM
	VQGMfEzN+nBXpDY/P/uLAMb1o2/pFs2ySCUlX4WjjnS/xxxD8JNnxHNroXEJKLh1Ycy2omeUYYF
	haa9iBdV87proYvJiJo072Dg+Zu/CmdPyak54/ApKrw2g44zcjNCS1jpqMevjCXScj7p7obGegZ
	uBQkOiHIPU93m5WKrjv8edSKEuIvUHogMR+JA4BsD5puclQnQPeQwqpM6zYn/sAc6O6BXdHHKTM
	nZZmoBrfBDmem6t6ITO84ZGjEVjfmYQZ1dquqQJxeOk7yVq/KLEUS+/8H7U9dra8ahCBkxsvjRS
	Xa35lXKovV4u4qIxXRtCkzn88FHM5iHuLCLd/pKozel2VelzQsmv2thDtUlOsUz508uGmDeS/11
	NsBhLHLPwHwLPxvcKk
X-Google-Smtp-Source: AGHT+IF5rpKVWKhhH5X99ZzJRg/cYQ5xHYiK2flb6+MOxSeRJ2HbYvrgV+3FUbcl1ZVy3O+iyDvm2Q==
X-Received: by 2002:a05:6214:2a89:b0:798:acd7:2bb with SMTP id 6a1803df08f44-8863af9edcfmr276981516d6.51.1764365322897;
        Fri, 28 Nov 2025 13:28:42 -0800 (PST)
Received: from ?IPv6:2606:6d00:17:7b4b::c41? ([2606:6d00:17:7b4b::c41])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88652b4afe8sm35038726d6.29.2025.11.28.13.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 13:28:42 -0800 (PST)
Message-ID: <46e9a5a881946d879d1b2af3421d574b26256ae3.camel@ndufresne.ca>
Subject: Re: [PATCH v2 2/2] media: verisilicon: Avoid G2 bus error while
 decoding H.264 and HEVC
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: ming.qian@oss.nxp.com, linux-media@vger.kernel.org
Cc: mchehab@kernel.org, hverkuil-cisco@xs4all.nl, 
	benjamin.gaignard@collabora.com, p.zabel@pengutronix.de, 
	sebastian.fricke@collabora.com, shawnguo@kernel.org,
 ulf.hansson@linaro.org, 	s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com, 	linux-imx@nxp.com, l.stach@pengutronix.de,
 Frank.li@nxp.com, peng.fan@nxp.com, 	eagle.zhou@nxp.com,
 imx@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date: Fri, 28 Nov 2025 16:28:39 -0500
In-Reply-To: <20251128025117.535-2-ming.qian@oss.nxp.com>
References: <20251128025117.535-1-ming.qian@oss.nxp.com>
	 <20251128025117.535-2-ming.qian@oss.nxp.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-Wt1eyF/4iRLYXSmGIIpE"
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-Wt1eyF/4iRLYXSmGIIpE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le vendredi 28 novembre 2025 =C3=A0 10:51 +0800, ming.qian@oss.nxp.com a =
=C3=A9crit=C2=A0:
> From: Ming Qian <ming.qian@oss.nxp.com>
>=20
> For the i.MX8MQ platform, there is a hardware limitation: the g1 VPU and
> g2 VPU cannot decode simultaneously; otherwise, it will cause below bus
> error and produce corrupted pictures, even led to system hang.
>=20
> [=C2=A0 110.527986] hantro-vpu 38310000.video-codec: frame decode timed o=
ut.
> [=C2=A0 110.583517] hantro-vpu 38310000.video-codec: bus error detected.
>=20
> Therefore, it is necessary to ensure that g1 and g2 operate alternately.
> Then this allows for successful multi-instance decoding of H.264 and HEVC=
.
>=20
> To achieve this, we can have g1 and g2 share the same v4l2_m2m_dev, and
> then the v4l2_m2m_dev can handle the scheduling.
>=20
> Fixes: cb5dd5a0fa518 ("media: hantro: Introduce G2/HEVC decoder")
> Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>

I like where this is going.
> ---
> v2
> - Abandon the waiting approach.
> - Switch to a shared v4l2_m2m_dev solution.
>=20
> =C2=A0drivers/media/platform/verisilicon/hantro.h=C2=A0=C2=A0 |=C2=A0 2 +
> =C2=A0.../media/platform/verisilicon/hantro_drv.c=C2=A0=C2=A0 | 41 ++++++=
+++++++++++--
> =C2=A0.../media/platform/verisilicon/imx8m_vpu_hw.c |=C2=A0 2 +
> =C2=A03 files changed, 42 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/media/platform/verisilicon/hantro.h b/drivers/media/=
platform/verisilicon/hantro.h
> index e0fdc4535b2d..8a0583f95417 100644
> --- a/drivers/media/platform/verisilicon/hantro.h
> +++ b/drivers/media/platform/verisilicon/hantro.h
> @@ -77,6 +77,7 @@ struct hantro_irq {
> =C2=A0 * @double_buffer:		core needs double buffering
> =C2=A0 * @legacy_regs:		core uses legacy register set
> =C2=A0 * @late_postproc:		postproc must be set up at the end of the job
> + * @shared_resource:		flag of shared resource
> =C2=A0 */
> =C2=A0struct hantro_variant {
> =C2=A0	unsigned int enc_offset;
> @@ -101,6 +102,7 @@ struct hantro_variant {
> =C2=A0	unsigned int double_buffer : 1;
> =C2=A0	unsigned int legacy_regs : 1;
> =C2=A0	unsigned int late_postproc : 1;
> +	unsigned int shared_resource : 1;

Instead of that, I'd make an array of compatible node we are going to share=
 the
with.

> =C2=A0};
> =C2=A0
> =C2=A0/**
> diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/me=
dia/platform/verisilicon/hantro_drv.c
> index 60b95b5d8565..f42b2df86806 100644
> --- a/drivers/media/platform/verisilicon/hantro_drv.c
> +++ b/drivers/media/platform/verisilicon/hantro_drv.c
> @@ -35,6 +35,10 @@ module_param_named(debug, hantro_debug, int, 0644);
> =C2=A0MODULE_PARM_DESC(debug,
> =C2=A0		 "Debug level - higher value produces more verbose messages");
> =C2=A0
> +static DEFINE_MUTEX(shared_dev_lock);
> +static atomic_t shared_dev_ref_cnt =3D ATOMIC_INIT(0);
> +static struct v4l2_m2m_dev *shared_m2m_dev;
> +
> =C2=A0void *hantro_get_ctrl(struct hantro_ctx *ctx, u32 id)
> =C2=A0{
> =C2=A0	struct v4l2_ctrl *ctrl;
> @@ -1035,6 +1039,37 @@ static int hantro_disable_multicore(struct hantro_=
dev *vpu)
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +static struct v4l2_m2m_dev *hantro_get_v4l2_m2m_dev(struct hantro_dev *v=
pu)
> +{
> +	if (!vpu->variant || !vpu->variant->shared_resource)
> +		return v4l2_m2m_init(&vpu_m2m_ops);
> +
> +	scoped_guard(mutex, &shared_dev_lock) {
> +		if (atomic_inc_return(&shared_dev_ref_cnt) =3D=3D 1) {
> +			shared_m2m_dev =3D v4l2_m2m_init(&vpu_m2m_ops);
> +			if (IS_ERR(shared_m2m_dev))
> +				atomic_dec(&shared_dev_ref_cnt);
> +		}
> +	}
> +
> +	return shared_m2m_dev;
> +}
> +
> +static void hantro_put_v4l2_m2m_dev(struct hantro_dev *vpu)
> +{
> +	if (!vpu->variant || !vpu->variant->shared_resource)
> +		v4l2_m2m_release(vpu->m2m_dev);
> +
> +	scoped_guard(mutex, &shared_dev_lock) {
> +		if (!atomic_dec_return(&shared_dev_ref_cnt)) {
> +			if (!IS_ERR(shared_m2m_dev)) {
> +				v4l2_m2m_release(shared_m2m_dev);
> +				shared_m2m_dev =3D NULL;
> +			}
> +		}
> +	}
> +}

Then instead of this, I would like to add a kref to v4l2_m2m_dec, I checked
already and this is both safe and backward compatible.

Then in the get function, you will walk over the compatible that are differ=
ent
from the currently probe node. If you find one that is initialized, you wil=
l
call v4l2_m2m_get() to obtained a shared reference. In _remove() you will s=
imply
do v4l2_m2m_put() instead of v4l2_m2m_release().

Hope the others are happy with this. For Hantro drivers, this will make it =
a
much more powerfull mechanism.

Nicolas

> +
> =C2=A0static int hantro_probe(struct platform_device *pdev)
> =C2=A0{
> =C2=A0	const struct of_device_id *match;
> @@ -1186,7 +1221,7 @@ static int hantro_probe(struct platform_device *pde=
v)
> =C2=A0	}
> =C2=A0	platform_set_drvdata(pdev, vpu);
> =C2=A0
> -	vpu->m2m_dev =3D v4l2_m2m_init(&vpu_m2m_ops);
> +	vpu->m2m_dev =3D hantro_get_v4l2_m2m_dev(vpu);
> =C2=A0	if (IS_ERR(vpu->m2m_dev)) {
> =C2=A0		v4l2_err(&vpu->v4l2_dev, "Failed to init mem2mem device\n");
> =C2=A0		ret =3D PTR_ERR(vpu->m2m_dev);
> @@ -1225,7 +1260,7 @@ static int hantro_probe(struct platform_device *pde=
v)
> =C2=A0	hantro_remove_enc_func(vpu);
> =C2=A0err_m2m_rel:
> =C2=A0	media_device_cleanup(&vpu->mdev);
> -	v4l2_m2m_release(vpu->m2m_dev);
> +	hantro_put_v4l2_m2m_dev(vpu)

> =C2=A0err_v4l2_unreg:
> =C2=A0	v4l2_device_unregister(&vpu->v4l2_dev);
> =C2=A0err_clk_unprepare:
> @@ -1248,7 +1283,7 @@ static void hantro_remove(struct platform_device *p=
dev)
> =C2=A0	hantro_remove_dec_func(vpu);
> =C2=A0	hantro_remove_enc_func(vpu);
> =C2=A0	media_device_cleanup(&vpu->mdev);
> -	v4l2_m2m_release(vpu->m2m_dev);
> +	hantro_put_v4l2_m2m_dev(vpu);
> =C2=A0	v4l2_device_unregister(&vpu->v4l2_dev);
> =C2=A0	clk_bulk_unprepare(vpu->variant->num_clocks, vpu->clocks);
> =C2=A0	reset_control_assert(vpu->resets);
> diff --git a/drivers/media/platform/verisilicon/imx8m_vpu_hw.c b/drivers/=
media/platform/verisilicon/imx8m_vpu_hw.c
> index 5be0e2e76882..5111ce5c36f3 100644
> --- a/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
> +++ b/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
> @@ -356,6 +356,7 @@ const struct hantro_variant imx8mq_vpu_g1_variant =3D=
 {
> =C2=A0	.num_irqs =3D ARRAY_SIZE(imx8mq_irqs),
> =C2=A0	.clk_names =3D imx8mq_g1_clk_names,
> =C2=A0	.num_clocks =3D ARRAY_SIZE(imx8mq_g1_clk_names),
> +	.shared_resource =3D 1,
> =C2=A0};
> =C2=A0
> =C2=A0const struct hantro_variant imx8mq_vpu_g2_variant =3D {
> @@ -371,6 +372,7 @@ const struct hantro_variant imx8mq_vpu_g2_variant =3D=
 {
> =C2=A0	.num_irqs =3D ARRAY_SIZE(imx8mq_g2_irqs),
> =C2=A0	.clk_names =3D imx8mq_g2_clk_names,
> =C2=A0	.num_clocks =3D ARRAY_SIZE(imx8mq_g2_clk_names),
> +	.shared_resource =3D 1,
> =C2=A0};
> =C2=A0
> =C2=A0const struct hantro_variant imx8mm_vpu_g1_variant =3D {

--=-Wt1eyF/4iRLYXSmGIIpE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaSoUCAAKCRDZQZRRKWBy
9H6pAP9Yhdngbwt8OH8RGhvCSHfsb/fie3vizZPWTzJzx3viGAEAsoVoim+8k68z
i06SAHMjZlxmNSWFIYqN873wNoWfWAs=
=xBWz
-----END PGP SIGNATURE-----

--=-Wt1eyF/4iRLYXSmGIIpE--

