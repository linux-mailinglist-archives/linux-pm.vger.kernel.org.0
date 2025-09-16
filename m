Return-Path: <linux-pm+bounces-34753-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1BCB5A0CF
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 20:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 008D31B26C54
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 18:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0943E2C2353;
	Tue, 16 Sep 2025 18:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="Bso0quWn"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29719219E8D;
	Tue, 16 Sep 2025 18:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758048764; cv=pass; b=bjGzmu/RslrgWinA6inyGAJzC2PtV2Jjedh3cJT8SO9k1GwurdQFGRFxxrq7PfHmvQCi/zgtmDmh/S1P3m+QnB9KInxOEmnqDSn1heddj4BD5kp02miyWZFFvN9NtfD5gfPewry33Aa6O45FaipBdInyjtPLoUxRBVmVe4rVQ4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758048764; c=relaxed/simple;
	bh=MkRhcuMfG7Wc5icNw+38YPni0DNeWvgarJWK/gyfE78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hVJLb51LNVthYbUe5fV6ti0rG7dgg3DLHbq9YWnGHTD2FVH5JVimiaSLAdIwOLrWyhhT8Ms7LjJKgZvRqUpvnJi1AVsIhXN0EehhXO4XHBZ+A/SOR6XBKTR8kbP3FsbL3IpOUYL1s/kxCI6cNEGFoT8Erhuxqy6nvJ4bJocOPQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=Bso0quWn; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1758048740; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hwEf/NxODHgKfr5qqNaXtIwC032hrGNLbfLqUMVsNDxaamv6rr4/dVzPm6RFqZ99ZKlWjJrZYRmji8jo1shANvnVc9RoxdslpXeI0Lu8cRFdljIXJqcNUem94yJt4FPiejvkVL0JK9vM3QT+8yVSbcUo1icHRQQn4gd1azdw7l0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758048740; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=AE2v096FXM3U02PoUXC7+g+/MgYT28uhtv7iQ0kgGIs=; 
	b=a8814MJmcLlEyFLDm4ezRBv/D2khSrl+dtKolpYcn2DwvcBNKUE97ziJza6F5Dkz/rDkgqeUV2yO3v6QOheh/VtTwMoeIVYJWrApFft8M8VUNYAbnLfxYoJQYIC5Z+KML9udiRMtC5+46zqsGMK0+8tzALbrhgq8fktzlr+STCE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758048740;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=AE2v096FXM3U02PoUXC7+g+/MgYT28uhtv7iQ0kgGIs=;
	b=Bso0quWn+dK9MmELmgJ1AMVQFe7An5XhaL2GXfyOgXyFvFFFT/BHBi5+d2+JubQv
	mDMy1PhOcbHIrkyxV8EAq34x6k2FBzokMlDjTWPV3tCNvsOfALxIBH2fhcK6vy5adI1
	ABs6DBlxrSQ2aCqHHs1UpJLXIhNH/FTR5JMmue+E=
Received: by mx.zohomail.com with SMTPS id 1758048737206189.14835880661303;
	Tue, 16 Sep 2025 11:52:17 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 25D89180733; Tue, 16 Sep 2025 20:51:31 +0200 (CEST)
Date: Tue, 16 Sep 2025 20:51:31 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Sudeep Holla <sudeep.holla@arm.com>, Souvik Chakravarty <Souvik.Chakravarty@arm.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andy Yan <andy.yan@rock-chips.com>, Mark Rutland <mark.rutland@arm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Konrad Dybcio <konradybcio@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
	Vinod Koul <vkoul@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, 
	Stephen Boyd <swboyd@chromium.org>, Andre Draszik <andre.draszik@linaro.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	Elliot Berman <quic_eberman@quicinc.com>, Srinivas Kandagatla <srini@kernel.org>
Subject: Re: [PATCH v14 04/10] Documentation: ABI: Add
 sysfs-class-reboot-mode-reboot_modes
Message-ID: <7z65qijcophg63npp5duix7zlhitazu6kba6aaulgwo2fg4txy@hzpj45cm77qd>
References: <20250815-arm-psci-system_reset2-vendor-reboots-v14-0-37d29f59ac9a@oss.qualcomm.com>
 <20250815-arm-psci-system_reset2-vendor-reboots-v14-4-37d29f59ac9a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ufoor27abvo5l3af"
Content-Disposition: inline
In-Reply-To: <20250815-arm-psci-system_reset2-vendor-reboots-v14-4-37d29f59ac9a@oss.qualcomm.com>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.3/258.4.7
X-ZohoMailClient: External


--ufoor27abvo5l3af
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v14 04/10] Documentation: ABI: Add
 sysfs-class-reboot-mode-reboot_modes
MIME-Version: 1.0

Hi,

On Fri, Aug 15, 2025 at 08:05:09PM +0530, Shivendra Pratap wrote:
> Add ABI documentation for /sys/class/reboot-mode/*/reboot_modes,
> a read-only sysfs attribute exposing the list of supported
> reboot-mode arguments. This file is created by reboot-mode
> framework and provides a user-readable interface to query
> available reboot-mode arguments.
>=20
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  .../testing/sysfs-class-reboot-mode-reboot_modes   | 39 ++++++++++++++++=
++++++
>  1 file changed, 39 insertions(+)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_mod=
es b/Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes
> new file mode 100644
> index 0000000000000000000000000000000000000000..6a3fc379afae3a6caf56ad0b7=
3b1c06c43a9fee7
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes
> @@ -0,0 +1,39 @@
> +What:		/sys/class/reboot-mode/<driver>/reboot_modes
> +Date:		August 2025
> +KernelVersion:	6.17.0-rc1
> +Contact:	linux-pm@vger.kernel.org
> +		Description:
> +		This interface exposes the reboot-mode arguments
> +		registered with the reboot-mode framework. It is
> +		a read-only interface and provides a space
> +		separated list of reboot-mode arguments supported
> +		on the current platform.
> +		Example:
> +		 recovery fastboot bootloader
> +
> +		The exact sysfs path may vary depending on the
> +		name of the driver that registers the arguments.
> +		Example:
> +		 /sys/class/reboot-mode/nvmem-reboot-mode/reboot_modes
> +		 /sys/class/reboot-mode/syscon-reboot-mode/reboot_modes
> +		 /sys/class/reboot-mode/qcom-pon/reboot_modes
> +
> +		The supported arguments can be used by userspace
> +		to invoke device reset using the reboot() system
> +		call, with the "argument" as string to "*arg"
> +		parameter along with LINUX_REBOOT_CMD_RESTART2.
> +		Example:
> +		 reboot(LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2,
> +		        LINUX_REBOOT_CMD_RESTART2, "bootloader");
> +
> +		A driver can expose the supported arguments by
> +		registering them with the reboot-mode framework
> +		using the property names that follow the
> +		mode-<argument> format.
> +		Example:
> +		 mode-bootloader, mode-recovery.
> +
> +		This attribute is useful for scripts or initramfs
> +		logic that need to programmatically determine
> +		which reboot-mode arguments are valid before
> +		triggering a reboot.
>=20
> --=20
> 2.34.1
>=20
>=20

--ufoor27abvo5l3af
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmjJsbIACgkQ2O7X88g7
+poTWQ/8DSYSg2jqDDCxWdzmAT84Zysi+6IUUCSr7Wgbhouh1+Sb8o4w+ETJBYqk
5YvCNDJyxrOvQ6fRQYHYqludVm13qFMAXiG5eKWOGA4zoou3MJtpGHNHcn776lMx
48uXZtxHTmuY3ZTkJGmvBSp2MVWmbeRY/mHGdfGPuqE7DkJq2H/NQ43vfdAMDHgj
pDCrNcl4f495LGdPwR4czKm/390Fw7DRGpcy6ZmathNjX+cHAHzfLWLSpyrzUfgA
sTeCW4C91y8wD9qnY2mQFbZzHdIChr+mEkSlBQLiO1Ves14fpxrNaz+TRia2XFfU
i+iavZPxLfBpi1DNw/ljbbyKcFYa2ivCbl7sXo/r9o82akE28RadjRgVeKgrHdxP
z/KC82emIlsltM2QExk2R05nemQjQk7USrVmgiQpbl4q8R4K5ashSO+Ee2XLLacl
NpynxRzYrWc7Bz8mAAZW7Jlh8xr5aE7Q5vQhPoFjzSFqztDO3ZfoPfDCYmvs5zJp
NydLsKCJUiKIq5zwiO3/Hp0l5dEwzEDOvZOP2PvYIeJ5X+N58fZN9JzrrPJ4fIuW
3vJatAVutg6q9qmm/yBByigPSySFSyr2RFcX93MpmctnrrK/6iDubMspRDqq4b2e
QnHwFolYjmkzyRqBlkQZWgy2MC8pNHIK5qQao1AEETWMKfRrLTY=
=6mt+
-----END PGP SIGNATURE-----

--ufoor27abvo5l3af--

