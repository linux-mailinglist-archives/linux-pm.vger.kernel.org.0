Return-Path: <linux-pm+bounces-36315-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D46D1BE5DC4
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 02:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A870407566
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 00:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A6778F3A;
	Fri, 17 Oct 2025 00:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="35Ul1jOa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24971F95C
	for <linux-pm@vger.kernel.org>; Fri, 17 Oct 2025 00:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760659894; cv=none; b=eACzBGsYhYL1DgZe9MVsld3kgUpL+Z0+3qtk28r/QkWe2Cf8yzdFY07nBqQ/tBt875fc2WEV0Mz17UojxaF1sRFIkEyMmWV1IHyuOvijSwQisCB7niNDXpfWG5cqMnk5ow46hdLpsXRZd8iLiSDMQix3P6PkDDsLbbfhwk7XaD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760659894; c=relaxed/simple;
	bh=9qQ/Kaq1PQi1iQEGpE/Y4pRBJHUu5desBrWzjzYMp1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pkDQrkb1OCiFpEtkkrDf+KTeDfj3AImsjoVcDchf+sbaLUISe8wdOZ4soqghXIgJlNS2sF6tYa/4E7f/qwOr5wRpnQ5VsLKec+54VMbPDEmcQwdOmuqKYdcFZl2d4auzzKmxxtiGZ4q85xlx2lyydt0Iuay+bOqgq9HLUu/fw9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=35Ul1jOa; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-33ba37b3ff7so1271311a91.1
        for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 17:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760659892; x=1761264692; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6rdlnJ4bFVxMl/yRGUabSawyz7mEAHOSqjDImE5CoEM=;
        b=35Ul1jOaA8k6hSHM5pY5yRZMWRSaezWC9IvE2E1zA0yZsrOIeLiCJ9UoouboPAor+Q
         QTj3LFgL+BTtibQRft9CfKT4etURCans9Yw5OoOtzvgVw3oBcl6gtkaE4UFDc8agcdW1
         8V53SOx364gb6q7Wfi2zRka72O4+aRzNd3FM0tX5EkWOKDrekRYZOkzaHt5BitYWlAYi
         RZdsh45/0AhFUUdMXpE/2TnjjlkCsKc7bCEP7W8yjYH3Pi0CKVgxtJOrf4/qx/ExOcWn
         AJZqpfLS16IJ0K2ueYpNTi6xWw96n51egktTVi4N8oe9Gug6K7pPc3C08M+57U/dUfIm
         lEUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760659892; x=1761264692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rdlnJ4bFVxMl/yRGUabSawyz7mEAHOSqjDImE5CoEM=;
        b=EGff7KfL77txQZOaxCqJw36puD9/upYdciRClonCnHrWF7M/JUyIwiVJoaY+oNbuc8
         qQdfocClQ9Va32Nu70VR2JbFMTqC+7zBev62/4xBEbKZDphE+pooBFrrpAFNXAO9cVz/
         Hkk48TjbXowo0JSkDTQoxgB/SnlNvF/PoqzsrJFPT8Qe0pprc8iVMxK3t1rsNBVGjFDQ
         dCUXAVML4KiRiZJH/xJd/LewvxR+9jSdld+XxN9AB8WHBMdSKMSlg1CeR0ULtqQCoyrl
         ihh5+z7JS+rKig9rpt00jWigHGMpX4jDxqn+e4LZOv2BCytf2eef3f/UACLGgv/z/UnS
         uALg==
X-Forwarded-Encrypted: i=1; AJvYcCUou/mMfT+sGIklZKVmMk1RbF0Ugbi7vftpDFdVdUp9IcObfiN7bBvMbX/MRh9mfwZIoS2hxEYHVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZFedqPd4B+m3W3GvIa5OM2CSXEtauDlRFQZT+DulvVk6TvSia
	v06RdiKFIr0+QSCiKpYJkZUVp/wPDXQM+J/q8oIWbrL1m5ssDMp0K88LtHxh6OgDWw==
X-Gm-Gg: ASbGncshH+VaL9Bm0GsAcnZpPNB1nPiovHn8ijOi1NVXa1QZBnw1C5JABK6keHW1+Ty
	iJk0NrXsRldDgrKMz1TUaqiWwGRb8B/DQqnqepz7YdpBrVN4cO0cE6+OUikrRXwhQSQR9AJwRGb
	aa9R1v+7Wu9AyCu7mvSfJINGVGBlcdoAYqQ/IzMH4+0tfCgcVk6VAUWZd8dmuuRG9+FNbSU4ntE
	msxLj5iUAICFaaKHv7dNhybhlswOUujDZGXUneMeiEglFDT3aytVt1eeuRXDj1iO+sGP6QddC+L
	kYyosyol+EJ/1CVaVL/vE1tzhQBFUWoTxl7NU8NgiqAH8d0Y+B+RtgD6HLZbAfphyvpYXGMqPTy
	Fp1hBQ4VEk6VKoKPRisGOr7x+VBBMAU+MfPRs9nKUNsQ6m2kOn71c14EMh4Xb6k3dUe+KLOCIKP
	GCQ7rdI0hlyoJ3zyj1xlwsegF3qqb2KybkuK4JkrfebiA=
X-Google-Smtp-Source: AGHT+IF/mLPPhwDZ9pM3tExE2bPuXwl/05sO0pJ0F8y1gYSwfK180J5bWJ1YL2l1fjSo1vLni9n+LA==
X-Received: by 2002:a17:90b:5110:b0:32e:4716:d551 with SMTP id 98e67ed59e1d1-33bc9b8f4e7mr2440735a91.6.1760659891842;
        Thu, 16 Oct 2025 17:11:31 -0700 (PDT)
Received: from google.com (232.92.83.34.bc.googleusercontent.com. [34.83.92.232])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33ba9270049sm1592080a91.0.2025.10.16.17.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 17:11:30 -0700 (PDT)
Date: Fri, 17 Oct 2025 00:11:26 +0000
From: Benson Leung <bleung@google.com>
To: Jameson Thies <jthies@google.com>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, dmitry.baryshkov@oss.qualcomm.com,
	bleung@chromium.org, gregkh@linuxfoundation.org,
	akuchynski@chromium.org, abhishekpandit@chromium.org,
	sebastian.reichel@collabora.com, kenny@panix.com,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 3/3] usb: typec: ucsi: Report power supply change on
 sink path change
Message-ID: <aPGJrjG6nsRQune_@google.com>
References: <20251016235909.2092917-1-jthies@google.com>
 <20251016235909.2092917-4-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fNlBXg0mnG7NeY4w"
Content-Disposition: inline
In-Reply-To: <20251016235909.2092917-4-jthies@google.com>


--fNlBXg0mnG7NeY4w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 11:59:09PM +0000, Jameson Thies wrote:
> Update the UCSI interface driver to report a power supply change when
> the PPM sets the Sink Path Change bit.
>=20
> Signed-off-by: Jameson Thies <jthies@google.com>

Reviewed-by: Benson Leung <bleung@chromium.org>


> ---
>  drivers/usb/typec/ucsi/ucsi.c | 2 +-
>  drivers/usb/typec/ucsi/ucsi.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index 7b718049d0d1..cad3913bd7f9 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -1293,7 +1293,7 @@ static void ucsi_handle_connector_change(struct wor=
k_struct *work)
>  	if (change & UCSI_CONSTAT_CAM_CHANGE)
>  		ucsi_partner_task(con, ucsi_check_altmodes, 1, HZ);
> =20
> -	if (change & UCSI_CONSTAT_BC_CHANGE)
> +	if (change & (UCSI_CONSTAT_BC_CHANGE | UCSI_CONSTAT_SINK_PATH_CHANGE))
>  		ucsi_port_psy_changed(con);
> =20
>  	if (con->ucsi->version >=3D UCSI_VERSION_2_1 &&
> diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
> index cce93af7461b..35993bc34d4d 100644
> --- a/drivers/usb/typec/ucsi/ucsi.h
> +++ b/drivers/usb/typec/ucsi/ucsi.h
> @@ -382,6 +382,7 @@ struct ucsi_cable_property {
>  #define UCSI_CONSTAT_BC_CHANGE			BIT(9)
>  #define UCSI_CONSTAT_PARTNER_CHANGE		BIT(11)
>  #define UCSI_CONSTAT_POWER_DIR_CHANGE		BIT(12)
> +#define UCSI_CONSTAT_SINK_PATH_CHANGE		BIT(13)
>  #define UCSI_CONSTAT_CONNECT_CHANGE		BIT(14)
>  #define UCSI_CONSTAT_ERROR			BIT(15)
> =20
> --=20
> 2.51.0.858.gf9c4a03a3a-goog
>=20

--fNlBXg0mnG7NeY4w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCaPGJrgAKCRBzbaomhzOw
wmyRAP4qaYGumR/0N01XkF9UwvhoHVmf95YivCn2pzq/dyTTSwD9E9LvRCPYKeaM
kvdNAAOULTjT4h0VUuKVJ93sTEh0LQM=
=N62/
-----END PGP SIGNATURE-----

--fNlBXg0mnG7NeY4w--

