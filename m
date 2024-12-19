Return-Path: <linux-pm+bounces-19548-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 575889F888B
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2024 00:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3094163B7A
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 23:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558081CCB21;
	Thu, 19 Dec 2024 23:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="i3XO874z"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB631853;
	Thu, 19 Dec 2024 23:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734651145; cv=pass; b=BZiyKQyhih7EcSSkK3WYBsQcdBwBp9FsYybLCUMpOffQKgIH7M8ZRnEyVNBKx4/v7IymoDFO5GNpd7eGQDlVBsHVxIJ1CqsmHr5oxzpQvN/Ojk3Z+ZwArNTGZIWRhPWtFe4USWclGarBTY8HdnsVYy5FH756Yl0dJKAhHs3fTHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734651145; c=relaxed/simple;
	bh=jc1hkf6U9IV0sPdXptSt4/hn2LcMO2/1jW6PMsmXjHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hqRff/0NiqlT4MEvWS7yqtUE7eE/xZj8pFMGAynyxk1uiuSFUHZY5aglkHe/Q0HBAmfsfCcPrzRD7aZE8HpKEYAtml1UEbcDXn4eTBbsRTKfzokBJXvLSy4ErTJWigfzyEOS6cWT+tvp6bgjbcXWei3EBf1T+Uti2aPlkq4povQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=i3XO874z; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1734651133; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ckSSYo18WB7URFKqvcPtcs8OrES3Jizc2c2zlIMUL5Ksezy1lhvssfGSjpLBQUsl17vB+kRd8kwnaW3YEs3BJfTwXZMoS0t4qXL34dhUT9S6ArJW/czeV3ydWdT9YiVPsOiObRyfJy3uEQgOvg2ODLRhR2+KYYBNt2ayvXdz3+Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1734651133; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=NmqCKeK5K45aoEzLTIlYC2L8AVjA4SYF3hYhFNC7U+Y=; 
	b=kUkfrJNcFDTFWOlFJN1nK92SSwGo1e096bo1W2I/2ownC23m+0K8O1BATUpf6I90W8AxqPUgfl+7C2XeQ7S0UUq9ER5tOxB4BlCSQWPUz91yVnlfg6NCE0SCgqQoGB6LFVm6vRU+n33EgLmLehS7TrFeMshHQb+Rity59GDKJBo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1734651133;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=NmqCKeK5K45aoEzLTIlYC2L8AVjA4SYF3hYhFNC7U+Y=;
	b=i3XO874zz+oyNZe565a4N8ev3NsjzF42snMy1gGRQIzEyebuCKQL5QIbAwo8hHne
	ATL9Cnngkzoc5sHFoTiL+JKW0gebSbn2gQym5TS/US6I0Moy/9B8r3St0L0G2WAMoYV
	4Et9XfVK+CWPbmgDwQUKUx3UnfF1RlKlCQ3KwexE=
Received: by mx.zohomail.com with SMTPS id 1734651130530412.27967565603046;
	Thu, 19 Dec 2024 15:32:10 -0800 (PST)
Received: by mercury (Postfix, from userid 1000)
	id A723C1060348; Fri, 20 Dec 2024 00:32:04 +0100 (CET)
Date: Fri, 20 Dec 2024 00:32:04 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
Cc: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 2/2] power: supply: Add STC3117 fuel gauge unit driver
Message-ID: <6degfnykilymnfxv2ly4gc24bkt5jrtneyrwv2bw5v2zrpgurf@bra77oalcysd>
References: <20241219094915.19059-1-bhavin.sharma@siliconsignals.io>
 <20241219094915.19059-3-bhavin.sharma@siliconsignals.io>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fdjqu6uhwmknjgq3"
Content-Disposition: inline
In-Reply-To: <20241219094915.19059-3-bhavin.sharma@siliconsignals.io>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/234.551.59
X-ZohoMailClient: External


--fdjqu6uhwmknjgq3
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v12 2/2] power: supply: Add STC3117 fuel gauge unit driver
MIME-Version: 1.0

Hi,

On Thu, Dec 19, 2024 at 03:19:12PM +0530, Bhavin Sharma wrote:
> Adds initial support for the STC3117 fuel gauge.
>=20
> The driver provides functionality to monitor key parameters including:
> - Voltage
> - Current
> - State of Charge (SOC)
> - Temperature
> - Status
>=20
> Co-developed-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.=
io>
> Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
> Signed-off-by: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
> ---

I missed one thing in my review. Apart from that things look good to
me now.

> [...]
> +static union stc3117_internal_ram {
> +	u8 ram_bytes[STC3117_RAM_SIZE];
> +	struct {
> +	u16 testword;   /* 0-1    Bytes */
> +	u16 hrsoc;      /* 2-3    Bytes */
> +	u16 cc_cnf;     /* 4-5    Bytes */
> +	u16 vm_cnf;     /* 6-7    Bytes */
> +	u8 soc;         /* 8      Byte  */
> +	u8 state;       /* 9      Byte  */
> +	u8 unused[5];   /* 10-14  Bytes */
> +	u8 crc;         /* 15     Byte  */
> +	} reg;
> +} ram_data;
> +
> +struct stc3117_data {
> +	struct i2c_client *client;
> +	struct regmap *regmap;
> +	struct delayed_work update_work;
> +	struct power_supply *battery;
> +
> +	u8 soc_tab[16];
> +	int cc_cnf;
> +	int vm_cnf;
> +	int cc_adj;
> +	int vm_adj;
> +	int avg_current;
> +	int avg_voltage;
> +	int batt_current;
> +	int voltage;
> +	int temp;
> +	int soc;
> +	int ocv;
> +	int hrsoc;
> +	int presence;
> +};
> +
> +struct stc3117_battery_info {
> +	int voltage_min_mv;
> +	int voltage_max_mv;
> +	int battery_capacity_mah;
> +	int sense_resistor;
> +} battery_info;

You may not use a static variable for holding the battery
information and RAM data. A system could have two stc3117
fuel gauges with different data. Instead you can add them
into struct stc3117_data, which is allocated per instance.

Greetings,

-- Sebastian

--fdjqu6uhwmknjgq3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmdkrOgACgkQ2O7X88g7
+ppaig/+JJU52PjhXzHM5qk5pTmi/m8/L51vb2F9Y0VmAFwOaWMgTpULO0SU369+
Sil2aEWZOgu2iGKCEV3hTXT6SyYYUVIURjwepmHM72uNsiUiLwVdPbqqp/15jDxU
ATMA/cFvqUVSFf9C3/y8575FEnMbQ+4J9hAT9RmW/hHvQUx6Qf59OMjryaAY9q33
5RRUgkL6MWVf5H7LriHbJbxxWp3cDZWMjQOMyJY468iXwpLiL1MbQnTTOCelZQSi
WzUP4S+uUd7Hon2RXtoignL6aGIlAXFfhYPyIpLFI8R2XifTqRDEcLaRtHKvXZZK
EKKHPfkHA6U3+8xmRTpWqCzVkHrPDeYLPg+c+wa5ZNZmw/jtC9dSRlMFBh2iGQjs
727fZAh9qwgl6TLWGkGl5IGtCVbsucRgALJrYE7ygwsOOQyUA7chkENuqYMNxG3s
hfH1dcTh4gDbK67UF/9RcVegjOY0YzFuoRogZBHjRSfecLpBNXbrIU7R8wNLoJtC
f1ckJ+oKN3CNVaSek+NrLPn/ASnSnmR6N2Y3Q6XKOnJsxNz9qkDS6SzlwhMJGdp1
JzqfqdrE2D0Tg0Zcz2oj0iF9A/si8jVKpiXtaQsYeZW/OMPN6IaKmN9p61SZZ2Ou
ZQhhH3usRouV9wJyIyZCEW3YYHKaHffa3x4UHKwIjaoAQliT9Ck=
=eiQ/
-----END PGP SIGNATURE-----

--fdjqu6uhwmknjgq3--

