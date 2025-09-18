Return-Path: <linux-pm+bounces-35011-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CF9B87586
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 01:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FD9F5241A0
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 23:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02E62309B9;
	Thu, 18 Sep 2025 23:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="MepmCO20"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B6F4A2D;
	Thu, 18 Sep 2025 23:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758237539; cv=pass; b=HAMzxyHz9ufTeorV3zlW2h4bOswmwl0N5UlYWjs5zR0RFs4+ojT4Wnl5n4ynWQoe69AWNmqSxDoBT8Vdnv2GRroQgTf3Be3IBIKlRLfPH3xlAN9aZ+B/LWu7gJkqnUXz4MOFiGdEbhTCuIPAbGbf2PLcGP7AMpAUVMFY/bXKjLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758237539; c=relaxed/simple;
	bh=5iJGPs6vcEGywKPGkLdblZZi+nX/oYrCVtOfsRMrNrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yun8CgoqTRXzjcALxnG4djKakihm1P79+Fp8TRf8Zi5ZYcjDy3V7bOARugJmrUY8y2yFCyNT7ffOpvBc16iOeOgDNB7ljfH+/kEAFMDTJxA8xfpnxpjNXbQJoTOzsWkzVGQhfrRAdFMK7YC8ivjuQB3/UzksolbyVWIRRNlw9ms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=MepmCO20; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1758237508; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=eWUw3ZFSZkaOGqkvPkt58f11mCaojnfzoco2m3GDejMcZkkir8nmXmASCGMiUjMEFI6yHQjK+2Rgnb6P766jooFfj4flJZyZQL70JkSn9Wn+lfpsNsTr9IrNJmvTZ6hzCK3dhyd8guTw3JF8M99vh9R9YdYXBRlfXVwfX/W97Xs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758237507; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=5iJGPs6vcEGywKPGkLdblZZi+nX/oYrCVtOfsRMrNrw=; 
	b=MqHoOMhTefu1WmEPJywpu/MRI071IOIuuOOapI7fayqpLqoEPkqWkJ2iF8KB1yJtjpUoxNBXR2NMiOqJhZ4aQ8shhwO8FnGFbAvNVTjy6ZsvGn/tH3G1K7xujNoWTgegV1RSIOxsMDsus8370VCJ4zByMsyGsyycEg9t7Ds0lOA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758237507;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=5iJGPs6vcEGywKPGkLdblZZi+nX/oYrCVtOfsRMrNrw=;
	b=MepmCO20SYiw8AKHbcsT60UEli4QFi2Uzu8R1pBWBlO7t5J+55XfdujA/qMK1wUi
	rucR3lwpVSgA5VgsOwGU0YFgZESGDXuQ52xfX7Xg16EcECWQttdkq11Xpf62TtFVwFE
	swVy+qOXrznSDVhvO3KsB79qH7Y/qUQ3JOWZXgmQ=
Received: by mx.zohomail.com with SMTPS id 1758237504693973.1672975828773;
	Thu, 18 Sep 2025 16:18:24 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id B72F8180517; Fri, 19 Sep 2025 01:17:55 +0200 (CEST)
Date: Fri, 19 Sep 2025 01:17:55 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
	Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>, David Collins <david.collins@oss.qualcomm.com>, 
	=?utf-8?Q?Gy=C3=B6rgy?= Kurucz <me@kuruczgy.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, kernel@oss.qualcomm.com, devicetree@vger.kernel.org, 
	linux-usb@vger.kernel.org
Subject: Re: [PATCH v5 9/9] power: supply: qcom_battmgr: handle charging
 state change notifications
Message-ID: <mub3b5r3zpcgsisicjbbl2kudefibj7t2n3jz5pgshlqsglnlw@5a7gc3trlnn5>
References: <20250917-qcom_battmgr_update-v5-0-270ade9ffe13@oss.qualcomm.com>
 <20250917-qcom_battmgr_update-v5-9-270ade9ffe13@oss.qualcomm.com>
 <fa258ad4-1efa-4fe8-9636-d70c5ea9c8e1@oss.qualcomm.com>
 <d9db8b82-9000-478b-a7b5-93792f1e1bea@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kybmdzwa6byyxpic"
Content-Disposition: inline
In-Reply-To: <d9db8b82-9000-478b-a7b5-93792f1e1bea@oss.qualcomm.com>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.3/258.211.62
X-ZohoMailClient: External


--kybmdzwa6byyxpic
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 9/9] power: supply: qcom_battmgr: handle charging
 state change notifications
MIME-Version: 1.0

Hi,

On Thu, Sep 18, 2025 at 10:01:24AM +0800, Fenglin Wu wrote:
> On 9/17/2025 7:14 PM, Konrad Dybcio wrote:
> > On 9/17/25 12:15 PM, Fenglin Wu via B4 Relay wrote:
> > > From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
> > >=20
> > > The X1E80100 battery management firmware sends a notification with
> > > code 0x83 when the battery charging state changes, such as switching
> > > between fast charge, taper charge, end of charge, or any other error
> > > charging states. The same notification code is used with bit[16] set
> > > if charging stops due to reaching the charge control end threshold.
> > > Additionally, a 2-bit value is added in bit[18:17] with the same code
> > > and used to indicate the charging source capability: a value of 2
> > > represents a strong charger, 1 is a weak charger, and 0 is no charging
> > > source. The 3-MSB [18:16] in the notification code is not much useful
> > > for now, hence just ignore them and trigger a power supply change eve=
nt
> > > whenever 0x83 notification code is received. This helps to eliminate =
the
> > > unknown notification error messages.
> > Thank you for explaining the technical background.
> >=20
> > Please hit enter somewhere in your commit message, this is a very
> > long paragraph, making it difficult to read.
> I just realized I made a mistake on the bit position, it should be bit[8]
> for reaching to the charge control threshold, bit[10:9] for charging sour=
ce
> capability. I don't know what I was thinking when writing the commit text
> :(. I will correct them in the next patch.
> >=20
> > I believe this maps to:
> >=20
> > 0 -> POWER_SUPPLY_CHARGE_TYPE_NONE
> > 1 -> POWER_SUPPLY_CHARGE_TYPE_TRICKLE
> > 2 -> POWER_SUPPLY_CHARGE_TYPE_FAST (or _STANDARD, I see battmgr code
> > reports them both as 2)
> >=20
> > However, we already set it to none/trickle/standard(taper) based on
> > the usual notifications, so I'm not sure if these are more common or
> > arrive outside the normal state changes - if so, perhaps we can take
> > them into account as well?
>=20
> This is not related with the real charging status. I double checked in the
> battery management firmware, it is checking the charging source power
> capability by multiplying maximum voltage and current reading from the PD=
Os.
> Any charger adapter with a maximum power below 60W is identified as a
> slow/weak charger.

Please include that info in the commit message when sending a v6.
The code change itself LGTM.

Thanks,

-- Sebastian

--kybmdzwa6byyxpic
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmjMkx8ACgkQ2O7X88g7
+pqwLg/8DogotcprKe+ff5MNlSQgo3S8L5Bo8a46PQ6yojTQC7i5j/2A5mIwMJOw
YbEDu4okwunPYtLjOvcQDbyx3QwnB8Rgl0KkqQ8aOc/t9HxcuDDfVALsqooGKNuC
6z/PIA+XzH91Dxi9pUaVwlt6gobgCVcxze2uoOOnWjWhPnQvg14NRSFirmZ1bLV3
nUQAbOs7bPOodecSPOmlEAtFBeMOGQxsV0wfh8tzF1JwxsxaMsdlLET00OgKsyvv
jNL9I1X8wx2dno6kzjRDKVsqFKMewweTCMrjJaExGeFN/2gsSyhYR8GbMKcUVyUK
deuA5/j+FxL3DBzNp0DD76DhCWRz63QtOI3foyEcSlhOXSeUP+omKiVImtNl3L6i
Jaif8Tl5v3qVag8hYcvx9y/t6GQmadaJ0yw53uEKtF6XTlQAs4zuPWyxaCJ2Y0o5
ZEstSYigPM5nqcBtw9fepVu0uRNKT1DPRkO2sg0CZ6SAsKAoOH7ztQxDUp2UNinv
dG/HxbB7iU2WNEOiRbX5VXT8F9AiqgOgAsA8+6vy901rsjvxe5NRTiWk+mfcNO5Q
xhyj/gEMbA3U8Y7z4Na84lUopjpFqWqSixUlGcb9waP/pCIkiumwpu6ORTcUuF/E
LHdrTtRYAMSKTDUcUfinMhnzdKFSidGEMmzoOIBDH56OXCuDsFY=
=v/vi
-----END PGP SIGNATURE-----

--kybmdzwa6byyxpic--

