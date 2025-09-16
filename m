Return-Path: <linux-pm+bounces-34758-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DF7B5A187
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 21:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 261E47B636E
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 19:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8025B2E093C;
	Tue, 16 Sep 2025 19:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="IyJWJaCy"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D5927A907;
	Tue, 16 Sep 2025 19:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758051371; cv=pass; b=pRebJjowyi2SqM/TxCTKMTKmaVF0Q9vcp91d8N9a8M5GYOkEKTuY1yQmHqD8wKlcd8Zt/iCCaz6IBj8TrNvFQpjHKQutWELn5MUBzU5lAMgMxM6m3dOYH9w1WGGDQyvbMHB0XvpBrbbw88YmYjjy4vFQFTr0R4l4wt7s7W8CuFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758051371; c=relaxed/simple;
	bh=EPKW0Hv4jB6StlyVkeD8DuM/FdXIbHZ/uCo3nGrmUYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VSaqbfOj4SPn0K/FYV1ITuFtLdM+9qE6DHZ9mly+GlT51W5PIjB4M0Ia+BK6DtlDoXHOXuPrHaCaHMhF+04tQFPmKtwai1JV6lVT6dfYtVa0T5jifIft8pOjVPMQS5kpnB2/ZUQUi3FWZnjiBVFfOXflGcH2Qmmm5oIFaAuK+wE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=IyJWJaCy; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1758051347; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=AMGRqJTbSPtwOV7oRnaCTlZ6S7Okj4t3dm1mb19NFRlOAV0vPO7oJPvpK0EWhBhdxOSb06EsTGM6+/6eU+uJL3ktbWhXfwFn7ChlnKVMXjFulbzlkuxCLaAEuTDF7i7+Y1yhRvPEC+0iQtVnzEPyqLbbeRHHTfDiQXy67Bc+WNs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758051347; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=8ntexXLv31C2JME2WNT4kxVTkVYgJZZd07oFmq0TU+g=; 
	b=eFupUJsTE2TLzq3zRcINnT7Lq/LNDEOeYtWDaOrWv5uOEqjGRI1ExvdahZ0qq9O+17SNuV0/VxZPy2QWYQ+dKdc7sqGWEPFNmj0t7l9S8a/mlqmVMh/4OWY9sulT6irX6QSHTylNBZ+h67YhkDoJnWHDqGtrcfn5kgIgnAcw3XE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758051347;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=8ntexXLv31C2JME2WNT4kxVTkVYgJZZd07oFmq0TU+g=;
	b=IyJWJaCyiRuthMad1/PqnHsCUv/TOQwHDmG9EBCCu01jC+kCg7uo/o+6S8TqVKle
	Din0vV50/GjWU7W6RecfskzLSDzBj60XlXNi11l3q7hbv+6XMgsDGZGItHTfrs1Xrvj
	90QixqwZCkM9qGPSb2tGe9YQkyP7Bo1yW4+daW6c=
Received: by mx.zohomail.com with SMTPS id 1758051344739982.4683264465028;
	Tue, 16 Sep 2025 12:35:44 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 6DA9B180733; Tue, 16 Sep 2025 21:35:31 +0200 (CEST)
Date: Tue, 16 Sep 2025 21:35:31 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: fenglin.wu@oss.qualcomm.com
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>, David Collins <david.collins@oss.qualcomm.com>, 
	=?utf-8?Q?Gy=C3=B6rgy?= Kurucz <me@kuruczgy.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, kernel@oss.qualcomm.com, devicetree@vger.kernel.org, 
	linux-usb@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 0/8] power: supply: Add several features support in
 qcom-battmgr driver
Message-ID: <r65idyc4of5obo6untebw4iqfj2zteiggnnzabrqtlcinvtddx@xc4aig5abesu>
References: <20250915-qcom_battmgr_update-v4-0-6f6464a41afe@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7yyu3k5bxetq5asm"
Content-Disposition: inline
In-Reply-To: <20250915-qcom_battmgr_update-v4-0-6f6464a41afe@oss.qualcomm.com>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.3/258.4.7
X-ZohoMailClient: External


--7yyu3k5bxetq5asm
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 0/8] power: supply: Add several features support in
 qcom-battmgr driver
MIME-Version: 1.0

Hi,

On Mon, Sep 15, 2025 at 04:49:52PM +0800, Fenglin Wu via B4 Relay wrote:
> Add following features in qcom-battmgr drivers as the battery management
> firmware has provided such capabilities:
>  - Add resistance power supply property in core driver and qcom-battmgr
>    driver to get battery resistance
>  - Add state_of_health power supply property in core driver and
>    qcom-battmgr driver to get battery health percentage
>  - Add charge control start/end threshold control by using
>    charge_control_start_threshold and charge_control_end_threshold power
>    supply properties
>=20
> The changes have been tested on QRD8650 and X1E80100-CRD devices based on
> qcom/linux.git for-next commit a679f3f6931cdb0c2ef5dc0c26f895ae3f6c1ddc.
>=20
> Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
> ---

Unrelated to this series specifically, but can you look into fixing
the following errors (appearing at least on X1E based Thinkpad T14s)?

qcom_battmgr.pmic_glink_power_supply pmic_glink.power-supply.0: unknown not=
ification: 0x283
qcom_battmgr.pmic_glink_power_supply pmic_glink.power-supply.0: unknown not=
ification: 0x283
qcom_battmgr.pmic_glink_power_supply pmic_glink.power-supply.0: unknown not=
ification: 0x483
qcom_battmgr.pmic_glink_power_supply pmic_glink.power-supply.0: unknown not=
ification: 0x83

Thanks,

-- Sebastian

--7yyu3k5bxetq5asm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmjJu/wACgkQ2O7X88g7
+prvHg/7BJXwOEfENpjb+Lvn03BDEtvTKwc1pWwW9nTsVTOz2q8Y3/uroczVeoWy
UpinHAxIRPLl0UVqR9kcCIPn1R8NJgnNnibV0hiczlm3LdYGeuCLuF1DULcX8MXI
hWeNdsT9ql5IKpdUtwyilxy9tX4/NKt5bOioDcAluMrrJMAObQCjEwv1IcKNbn/6
8TxIeuv9K+wwBekx+5Jzz/Xyx5UfPqvkkwkM0kLW6mrZH3RWTuXqJrJHfB9J+FPG
vUA+QA/djKjV2K78s0XYSai02qOQ2Gpnc5esAPH1NQJivCRRxjm75likH0g2bgFC
9y3JSzUmbkiCd5PkBf2NvHUjedXdVRM1F8+ggFt4rLvJj+5ty5QW8HKVe+aXxZCP
jCDi4avGcSzZFtZg7RSUA4ZJbEqXcMlZMXPvZ04hGrWnOFv+Ku93wouUuhYmA5hK
+R5zM64lrtrpOuHb8P5n5DSJNdgQfDNj35lM3dNEpyMWRJGK5PWqHQWHhZgyYhtg
62ezZra7P7CAFtiq+XyUOIzZMFBw5vnkjCMxZfyz5R8k7NFJIZTpkP/tmLfcKAEs
foFyol14MgGPuN1nqGqoUHxJW1UhGreqvYLvgJRlTMqC62KLLdrH+KGd7ZAp3v9v
XlaE7dveUDUaDHtUAo1vhrlUOk9iDifrM7T4HxXL522Mn0NMavY=
=Sioo
-----END PGP SIGNATURE-----

--7yyu3k5bxetq5asm--

