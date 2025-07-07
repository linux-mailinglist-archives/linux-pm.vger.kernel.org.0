Return-Path: <linux-pm+bounces-30237-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D00DFAFA88E
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 02:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F68D176D92
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 00:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDD63597A;
	Mon,  7 Jul 2025 00:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="eQNcOwYH"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1B218035;
	Mon,  7 Jul 2025 00:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751847345; cv=pass; b=r74OimeZN7UPfcFCHYIVcnDRbNVSApy12JSnh0IL+HULI29lGvhLDJK3gxMl00bBPLkM3vqRvDy2sMfrhkEP2A40TowehPwvNxOjYHQY12BIFePFf8K5G6BseFhTWFRbl1Tx7gkSRg60nGHZezWjRX1CsQmqCmc9X9HawRYaKHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751847345; c=relaxed/simple;
	bh=bg3UTIoYitdrE1fKKbSI9xlD3lw7ZBNyiPwF21r9hGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AcpYzlth0SGRcWt9MYlP7fqqsIp0w59xeof3sN4SNC3vIjVgE9AUWgvAdy3jlX0kEQ5+/LIIlaKuYJswTthhOry9WYZOBhaW0id01WwmMGf7t6ikcKqr/MlzmUjeybG/XpZt+WpB2dBafxJSCzEYIuB80TWwu+R4wQc3YdiTNA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=eQNcOwYH; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1751847330; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UTrKTZ3xXD548GT3q5KhD3JK9dOlxc1/gl993isZWCDB7ZdC6tm8r2W+Qp5UhIm84ID1a8s+c5ahoB6x1Qixq6yG8PKLajvXPq+j8xR6/c1murPnw4hi+Jh/BKNJNL28IcO/KjB8ClIaHtHoaM11OnFvvxI/O6n9cY5aBGMnr/k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751847330; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=bg3UTIoYitdrE1fKKbSI9xlD3lw7ZBNyiPwF21r9hGQ=; 
	b=NxZbSbRmmq0WqYYLz2Z7EGdVQgB6LYDvNjNag+is8SPK5O4+TjkA7qbYTXXeigvvN9s3PDfbUHw/ZPBLeuUEPG6VKS4gjdIH242qHj1/3y1x7XonGD87ktU+Rrunk0oVU8New/T0jo8H4fuvyw0wsivX2AtlXlFLZh3sy6gZpFs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751847330;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=bg3UTIoYitdrE1fKKbSI9xlD3lw7ZBNyiPwF21r9hGQ=;
	b=eQNcOwYHfMrChfzs/bOXHZAs3RO0F7clXQprNAjtlaEA974VEP17E0Au6WE8lLvH
	KuH8iGLRDNF+uST57YHjjjfffgtxcGH/xaNQkQ2hxPxG7iFvBhN2uy6k8ZQmhax84VL
	7H3fGzTQpLW/DVxyyIeohIUqny+wsACP0phn5ROc=
Received: by mx.zohomail.com with SMTPS id 175184732787092.66100338687909;
	Sun, 6 Jul 2025 17:15:27 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 230A0180F14; Mon, 07 Jul 2025 02:15:22 +0200 (CEST)
Date: Mon, 7 Jul 2025 02:15:22 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>, David Collins <david.collins@oss.qualcomm.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	kernel@oss.qualcomm.com, devicetree@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 1/8] power: supply: core: Add resistance power supply
 property
Message-ID: <fb3ielhucosims237ikv4jfp3oq6fu5ftgt2mvenj6pjmzrpqo@vip3r6qew32p>
References: <20250530-qcom_battmgr_update-v2-0-9e377193a656@oss.qualcomm.com>
 <20250530-qcom_battmgr_update-v2-1-9e377193a656@oss.qualcomm.com>
 <b7m55sjc2rtvtelvez6sxnjvdostvxmfjhhsr4uxhyhh4bxrcd@xmioz2bsgis2>
 <e9160bb8-2b5c-4c30-b60f-520decde851e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="orqvdfabm65lopjd"
Content-Disposition: inline
In-Reply-To: <e9160bb8-2b5c-4c30-b60f-520decde851e@oss.qualcomm.com>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.3/251.827.75
X-ZohoMailClient: External


--orqvdfabm65lopjd
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/8] power: supply: core: Add resistance power supply
 property
MIME-Version: 1.0

Hi,

On Mon, Jun 30, 2025 at 04:28:14PM +0800, Fenglin Wu wrote:
> On 6/22/2025 9:26 AM, Sebastian Reichel wrote:
> > On Fri, May 30, 2025 at 03:35:06PM +0800, Fenglin Wu via B4 Relay wrote:
> > > From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
> > >=20
> > > Some battery drivers provide the ability to export resistance as a
> > > parameter. Add resistance power supply property for that purpose.
> > This is missing some information and the naming is bad.
> >=20
> > Which resistance (I suppose battery internal resistance)?
> >=20
> > That is heavily dependent on the battery temperature. So this needs
> > to document if this is for the current temperature or for some
> > specific one.
> >=20
> > -- Sebastian
>=20
> This is battery internal resistance calculated by battery management syst=
em,
> using the real-time temperature measured by the thermistor inside the
> battery pack.
>=20
> I can update the name to something like "rt_internal_resistance" and upda=
te
> the description accordingly.

Your message is kind of mixed signal to me.

If the BMS needs the thermistor to calculate the internal
resistance, it means the data is either not real-time, but
just adopting some fixed value to the current temperature,
or the internal resistance is adopted from the current
temperature to some fixed temperature.

My expectation would be, that the BMS instead actually measures the
internal resistance via ohm's and law and Kirchhoff's voltage law.
So please make sure to understand what data is actually provided by
the BMS for a proper ABI description.

Depending on the description I think 'internal_resistance' is a good
name.

Greetings,

-- Sebastian

--orqvdfabm65lopjd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmhrEZYACgkQ2O7X88g7
+poJbA//S3Qz3Ln7piw+pbGa8pohdUZjhJetS+frJHREKwEQX31E8iqMa5bbumhb
QQHbrNvDREndfwHjJZXWsCUA0YI6kLVWlUpUKegJJzszVuR++7ihPSwPo3AYs1kA
70dUL45RUIeqaaDfThdP0hZIkJZEiu9n72I/n4Y3R6QzlhOTAy1FwmZIdlY6Pfpa
Zdes/Kbp6YsTpftEfyBK90lrEUE5qRXu0sCDkjtaQQACIHr/61m2/h5v9D2OlEMn
0RgXFWi6hYAezGfGyY6+YjTkqmtcZcnHJlTdqORv5hmhbQYqqGrjP6gHzM7jwRx8
/4/lL5ax3EMjWQk8KdAs0s9GYsby9DeNGYcgpp0Qfee58mDUepagNkVntRQFhW6v
rCW1T5lYh4vkoY5GrOP8dLgRQEJQP66JPVq8pgppMj8WCCXyh7EbaltNvXGfm+WP
5h8hhsg8ysi9v2FTVqrHobvSc4BJ4DrUD9Gx2j11PjFV80KDjGiZAM4ZQXj9QjgQ
pvDozcn5C3mswYHBsT36Daan2S/16QQi9WIKwKCqUrRIW50xAJNzyWrsADh2NMe8
a2tDVYNK4c4qMvb7rqoPql/PtNAit/G4+nw5M2IddtG5eVxW7CrgSBpq5fJpDjdx
Bs/EzIFfg8j4K8xY9l0iRbVrze/jhO5Dsck3cbbXlUM5fCIEZGI=
=Jeor
-----END PGP SIGNATURE-----

--orqvdfabm65lopjd--

