Return-Path: <linux-pm+bounces-34039-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA328B4675E
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 01:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87A8A565968
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 23:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E427C2BD5AF;
	Fri,  5 Sep 2025 23:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="Rfwq9QaD"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1319B29E11E
	for <linux-pm@vger.kernel.org>; Fri,  5 Sep 2025 23:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757116784; cv=pass; b=uYp4uCFOYhoBSMFOZmBUJnElfryD4QQ9bI3vVQTwotBOsXbIFXidGl0GxziJBNc4eL9pjvi9hqPxr40DDKpgJGkiWNDu/1MCwSo5YCJunLwoYXkIhZxFHIAV6epTCgj/BemYZupRD5I8yjyQuNvdgxgUSMyzRC98Cb++WSLZ60M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757116784; c=relaxed/simple;
	bh=HMbtJEKJu5ZSrdQD/ID0TpgrhGQNJN15jxzwvcrQR5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tB6bl6eN28plHJd9E+3duZ6Pv8Gfv/s4mOwINH15VQtfOj08btQkc2jFY3bE6Y6k5TrDLzbnAXEsPh/W0tuhTwSvAvT5mERLE1uO6mTmcOnzNahiUEnBZZXUIdctUJ8epzHUXUrZc+WtSGopWCSSBIDfG+jTD3kOMCWPoPsIdyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=Rfwq9QaD; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757116777; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jdgoa6ZJffam8oviqrU3BxprJ/i/bQ8es6pccQuJSeVE/31RFTReyPhXzy3keWQJhQ6QTssAiGZrDKx7vg4EHLZoDzMznxu4nBS1lKWExo0Up/I49NNSWoWEMr+JwdmfwYtaduaBsSdxQ8k20SCypNIiwRGMNfDt70+/grwWsHo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757116777; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=BmJXKpmKo7KabfTpbG2T3/7XGGzSAvTiixdMY7v+C00=; 
	b=jPFLiN1PySUp872psTaJFxjeKAPBPux/VpQpV+sdKLuJJ0gGH6dmpF0KOYS+gvk7prl17wW3hLsr0T3SLDe/fp1oegNBaA3d6jOJcov1UuoTqWgbPZ7Au34f7mtJnG+uP4gNGdgjzYCGRSYhNbXqFzYSwwtFSdyQVl/F3gOGHww=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757116777;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=BmJXKpmKo7KabfTpbG2T3/7XGGzSAvTiixdMY7v+C00=;
	b=Rfwq9QaDZk/Wj59FOIU0XKhOIDjauULCyjs90ILbqmaIMPifviFUcfesCUbskbYM
	KRRZxbmhmbOEyom6uh8Akd7+bkYYCsi2xe+YQFr4ZUri6sz/qqM1LM/sKt04Kg0QT6g
	QXsaB9hLCI1zDksKOroxKF7A5tmLUB1ymvPANak8=
Received: by mx.zohomail.com with SMTPS id 1757116775481230.11996971766303;
	Fri, 5 Sep 2025 16:59:35 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id E850B180B21; Sat, 06 Sep 2025 01:59:31 +0200 (CEST)
Date: Sat, 6 Sep 2025 01:59:31 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Hans de Goede <hansg@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 5/5] power: supply: Add new Intel Dollar Cove TI
 battery driver
Message-ID: <sfsn4int5dcrx6ln6xicps45utch7vnjocyeuroazjepgwpphd@hesz45zgrvdy>
References: <20250831122942.47875-1-hansg@kernel.org>
 <20250831122942.47875-6-hansg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p2zzw7wrns6iqx7d"
Content-Disposition: inline
In-Reply-To: <20250831122942.47875-6-hansg@kernel.org>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.3/257.68.7
X-ZohoMailClient: External


--p2zzw7wrns6iqx7d
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v4 5/5] power: supply: Add new Intel Dollar Cove TI
 battery driver
MIME-Version: 1.0

Hi,

On Sun, Aug 31, 2025 at 02:29:41PM +0200, Hans de Goede wrote:
> [...]
> +	/*
> +	 * Note cannot use devm_iio_channel_get because ACPI systems lack
> +	 * the device<->channel maps which iio_channel_get will uses when passed
> +	 * a non NULL device pointer.
> +	 */
> +	chip->vbat_channel = devm_iio_channel_get(dev, "VBAT");
> +	if (IS_ERR(chip->vbat_channel)) {
> +		dev_dbg(dev, "devm_iio_channel_get() ret %ld\n", PTR_ERR(chip->vbat_channel));
> +		return dev_err_probe(dev, -EPROBE_DEFER, "Waiting for VBAT IIO channel\n");
> +	}
> [...]

The comment confuses me. What is it supposed to tell me? Is it a
leftover from early development stages? Anyways, I merged the whole
series as it looks good to me. But I think this comment should be
fixed in a follow-up patch :)

Greetings,

-- Sebastian

--p2zzw7wrns6iqx7d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmi7eWAACgkQ2O7X88g7
+pq9RxAAmCfU4+/XDBW03ZHQ/utVI+56D2LEfOu04R4brF9dcktzOqwx+Hhw3nwu
MLC06hCRmdZwVE/S64nYV1ghzJaAsn/B+IKv4Se4/yUuJN2vg+VxUwdbAz1joPjN
QLh5wqPsceq9DOwhWR3zsLmqUpBXs7dtZ0mNpoKHyi2sZOGIrZLZz6523dV/ea2T
GwQrkqSCQYqTQ1EZ9LjWFuGqoN6JKlngwiqpeR+FEr8+/fbaGYUOrR2kguN7KGIH
5aYFBQhrRpljU/7qgSurUsIXQ6dldTF9+HWfnT8wEkwaxdBAG0NKbfapxOusvbIt
W7vUzB1N5R5BPVblUA5KGTO4IFNIjB4Xyxf32iNVf8dxI4XEq2D4G2FV94KNNcgD
y2xEeqYVcn+1ZgKzrqn0VHUzEtV19mmEJNqqgkF5I121Jcb4U7YorvxWfzUVxXnH
9AHXhqVj0yJw4MsyM6rwwlq2kc69IoijGO5EujR4C3ncZPsg5AeSnuwGEzUNo0Ae
uPv6eToAYyCf/K0/acueEF/la1FkR5UBAPTQl2NaWgUPRZ2ZI3t3+JE+sj1HmBw2
BEOeP7jVB+0QlThKYU+VLPg4MoIE6dTXis4CUOJYZWNoWIN/0APanSyj2lNHAZhy
IK/kpXGOqRUzj1/cdf4uWIfW4ZR3F0UCQnSr5PGAFBHVQdMhodI=
=c6eM
-----END PGP SIGNATURE-----

--p2zzw7wrns6iqx7d--

