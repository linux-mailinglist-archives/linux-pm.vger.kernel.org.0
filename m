Return-Path: <linux-pm+bounces-20816-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2EFA19566
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2025 16:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FDB43A2839
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2025 15:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387EA2147E0;
	Wed, 22 Jan 2025 15:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NUUC9yRt"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A2E2144C1
	for <linux-pm@vger.kernel.org>; Wed, 22 Jan 2025 15:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737560215; cv=none; b=AWqg9EBP9yQG7jRdgW/mwDRLNouBBifO0N1qFBi3Zkpqpz4g0osqQkgDTcMq+KaDLiD+RUhZNqYP6mamWDOTnqWT/lDx3Cj8vkJQ/l+ZPoIFD15p4ixU2vJu5nZ/9bkIUJxVz6YNUGpmPTD+F8+tNlzuKtowHfUXZ6LdpZrycZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737560215; c=relaxed/simple;
	bh=N8p0TD5QOTHYruWkg6jskvTBbKx7Yf/2rt53l8kao8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qONgcKc7j7o8qhmXWb0xcTp2pQBjoqQRXNsd/1EzipfDbqW1OvUa1fj9ZAE7RFNxUQF9RzZ9q52a2LmnyA9Hfr90CvBtP+UmMld0sK1bu1LYlX//uyGUOwQPyb4lsf9NRRiNRyLrri4nPi9ZCPo20zRcBnHgWTKKKDdDPoh/RnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NUUC9yRt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737560212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f8o7BcBFaAoDGx++JxsrnkYwkUHP1K1/2VxPdWlLaLw=;
	b=NUUC9yRttjMHb+U/2QYWEXRY78aeZVxpOaDSgISn8WJZ4GbMDGLDv265Si3xo2h4VAXyLX
	svhslu/DzCTYQpCzW+zY8l+2+IWVqvQ1oNMile2xe7jg4UQ1zg+trg5fWF6Q6n6SC50CKV
	ZnaRQCsuDX+fOlK342TdS2HYokj8Cvk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-uN1Ft24uNiK_FZilbzhcqw-1; Wed,
 22 Jan 2025 10:36:48 -0500
X-MC-Unique: uN1Ft24uNiK_FZilbzhcqw-1
X-Mimecast-MFC-AGG-ID: uN1Ft24uNiK_FZilbzhcqw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6E7F6195395C;
	Wed, 22 Jan 2025 15:36:45 +0000 (UTC)
Received: from localhost (unknown [10.2.16.37])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F145219560AA;
	Wed, 22 Jan 2025 15:36:43 +0000 (UTC)
Date: Wed, 22 Jan 2025 10:36:42 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Media <linux-media@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Block Devices <linux-block@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Power Management <linux-pm@vger.kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bingbu Cao <bingbu.cao@intel.com>,
	Tianshu Qiu <tian.shu.qiu@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/3] Documentation: ublk: Drop Stefan Hajnoczi's message
 footnote
Message-ID: <20250122153642.GA178738@fedora>
References: <20250122143456.68867-1-bagasdotme@gmail.com>
 <20250122143456.68867-3-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="G5Xn2h19SQtLrBjV"
Content-Disposition: inline
In-Reply-To: <20250122143456.68867-3-bagasdotme@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40


--G5Xn2h19SQtLrBjV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025 at 09:34:55PM +0700, Bagas Sanjaya wrote:
> Sphinx reports unreferenced footnote warning pointing to ubd-control
> message by Stefan Hajnoczi [1]:
>=20
> Documentation/block/ublk.rst:336: WARNING: Footnote [#] is not referenced=
=2E [ref.footnote]
>=20
> Drop the footnote to squash above warning.
>=20
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Fixes: 7a3d2225f1ae ("Documentation: document ublk")

The commit that introduced the unreferenced footnote was:

Fixes: 4093cb5a0634 ("ublk_drv: add mechanism for supporting unprivileged u=
blk device")

Other than that:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

> Link: https://lore.kernel.org/linux-block/YoOr6jBfgVm8GvWg@stefanha-x1.lo=
caldomain/ [1]
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/block/ublk.rst | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.rst
> index 51665a3e6a50cd..1e0e7358e14a96 100644
> --- a/Documentation/block/ublk.rst
> +++ b/Documentation/block/ublk.rst
> @@ -333,6 +333,4 @@ References
> =20
>  .. [#userspace_readme] https://github.com/ming1/ubdsrv/blob/master/README
> =20
> -.. [#stefan] https://lore.kernel.org/linux-block/YoOr6jBfgVm8GvWg@stefan=
ha-x1.localdomain/
> -
>  .. [#xiaoguang] https://lore.kernel.org/linux-block/YoOr6jBfgVm8GvWg@ste=
fanha-x1.localdomain/
> --=20
> An old man doll... just what I always wanted! - Clara
>=20

--G5Xn2h19SQtLrBjV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmeREIoACgkQnKSrs4Gr
c8jWNQf/d04gunXlgUuBBbP2JPmmUQ5tjr8BCc6SUve2iTkZZ40s+OMLA1pQTeVt
TrNpE5B0MndLQEtx9SJ2WQ7D/jZ18GJgoAklyQ9OYB8d47ViuxERgjytDGcx4dFe
ju/neQmr1HtxyE4hK1IMrNB5llOP7w3aBRdTgNBGnrhNM8kaexp5Cfp+UAxLN25L
c82oQ/NxCkJ/M8xCQ94LRQrWh5bJs+9XMANZr80YY8BRQTVuylN4A4f06bvPRznM
rz0aKGUEZiFaLAQKXDiRbqWutf+glkM3zGjh9VBLYw3pFZkiS910OYD5DTKeM700
DN24tDG8WwVF66EAz+4bWmJJ+GFSxg==
=2fOo
-----END PGP SIGNATURE-----

--G5Xn2h19SQtLrBjV--


