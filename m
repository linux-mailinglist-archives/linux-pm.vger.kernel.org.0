Return-Path: <linux-pm+bounces-20039-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B974A03F07
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 13:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88E0416435B
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 12:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116BA1EE001;
	Tue,  7 Jan 2025 12:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HwR6yB3t"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D75F1E0DD1;
	Tue,  7 Jan 2025 12:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736252714; cv=none; b=Om0sK8+fR8U6b9E076ZtlSg0pPopbtPjn0U1wWFFP8ClWlGCgOr3XnpqN/JM98/Zz9p/044t6XRc0TqTVW2oRSmHi0d+dmUfrN5LLcaH85AzBDW8k0bQgXVqYrBS9jdIdfLMNw+Qxbjhq6xZA3uuPJj561ViXxhE88zGRXB/BBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736252714; c=relaxed/simple;
	bh=uKpuN0WZd9vVEiVj4SEyuarv69NHmOZ8lL7reHm2oTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kq9EdqKnELP7KEloxS0f/tSwlcnLAe97uh62tpDA+qSD7MHAER2TwSK4cjf2Rlns6JRPEtXT0+A+lUHYCPcpclVm4W6gNFCdqA9e9tRKbaXjVH9OvqC3k8l47zlHnzCSy5PH6PMJARDTidLsnfSplk9a1M4Z2pUJwXZ8X/6THc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HwR6yB3t; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736252712; x=1767788712;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uKpuN0WZd9vVEiVj4SEyuarv69NHmOZ8lL7reHm2oTY=;
  b=HwR6yB3tga+ve/HVD6XO53mayDz/owyTh84N3LnALMMbxevNq9i8Vnhp
   OqrN401bTSgH6cW8HGW7u1wk+cD47XFyHIS86jBPkgkVeEypjjdu/e6Kz
   /FdWaKexbe+yu4a/MB1XIQCXSPxxcJiglwcJhczT1Wx7zW6UYcUToi062
   hsUjpZN7oDzMlgou262qF7mafyX+NNYGpz5HPBKZdgaRu3+1Y3ShAJ4Yj
   L4PHU9/Y5xHyiHVUJN4DL3ZSt3eDg5zyvzoEkrlHFDfiCKr5LSXPf/ooM
   8ZHp+1Ds7IkYShhLCTPa43k42HZaG4HbWK79VMjGoMrpiIBzx5XxJxVOR
   w==;
X-CSE-ConnectionGUID: MFX+1PnaS2W5RQtAXPTCkA==
X-CSE-MsgGUID: pnF3xunoQYSR6HwQJgbCbg==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="40378866"
X-IronPort-AV: E=Sophos;i="6.12,295,1728975600"; 
   d="scan'208";a="40378866"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 04:25:11 -0800
X-CSE-ConnectionGUID: +hXV3ZX9RpuUg18GG0ZvkQ==
X-CSE-MsgGUID: oVObbeAYRLGujom+byUEaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="133645683"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by fmviesa001.fm.intel.com with SMTP; 07 Jan 2025 04:25:06 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 07 Jan 2025 14:25:05 +0200
Date: Tue, 7 Jan 2025 14:25:05 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Pengyu Luo <mitltlatltl@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Sebastian Reichel <sre@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-hwmon@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v2 2/5] platform: arm64: add Huawei Matebook E Go EC
 driver
Message-ID: <Z30dIRA4MdtCp63q@kuha.fi.intel.com>
References: <20250105174159.227831-1-mitltlatltl@gmail.com>
 <20250105174159.227831-3-mitltlatltl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250105174159.227831-3-mitltlatltl@gmail.com>

Hi,

> +/* -------------------------------------------------------------------------- */
> +/* API For UCSI */
> +
> +int gaokun_ec_ucsi_read(struct gaokun_ec *ec,
> +			u8 resp[GAOKUN_UCSI_READ_SIZE])
> +{
> +	u8 req[] = MKREQ(0x03, 0xD5, 0);
> +	u8 _resp[] = MKRESP(GAOKUN_UCSI_READ_SIZE);
> +	int ret;
> +
> +	ret = gaokun_ec_read(ec, req, sizeof(_resp), _resp);
> +	if (ret)
> +		return ret;
> +
> +	extr_resp(resp, _resp, GAOKUN_UCSI_READ_SIZE);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(gaokun_ec_ucsi_read);
> +
> +int gaokun_ec_ucsi_write(struct gaokun_ec *ec,
> +			 const u8 req[GAOKUN_UCSI_WRITE_SIZE])
> +{
> +	u8 _req[] = MKREQ(0x03, 0xD4, GAOKUN_UCSI_WRITE_SIZE);
> +
> +
> +	refill_req(_req, req, GAOKUN_UCSI_WRITE_SIZE);
> +
> +	return gaokun_ec_write(ec, _req);
> +}
> +EXPORT_SYMBOL_GPL(gaokun_ec_ucsi_write);
> +
> +int gaokun_ec_ucsi_get_reg(struct gaokun_ec *ec, u8 *ureg)
> +{
> +	u8 req[] = MKREQ(0x03, 0xD3, 0);
> +	u8 _resp[] = MKRESP(UCSI_REG_SIZE);
> +	int ret;
> +
> +	ret = gaokun_ec_read(ec, req, sizeof(_resp), _resp);
> +	if (ret)
> +		return ret;
> +
> +	extr_resp(ureg, _resp, UCSI_REG_SIZE);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(gaokun_ec_ucsi_get_reg);

Why not just take struct gaokun_ucsi_reg as parameter? I did not see
this (or any of these) being used anywhere else except in your UCSI
glue driver. So the prototype would be:

        int gaokun_ec_ucsi_get_reg(struct gaokun_ec *ec,
                                   struct gaokun_ucsi_reg *reg);

> +int gaokun_ec_ucsi_pan_ack(struct gaokun_ec *ec, int port_id)
> +{
> +	u8 req[] = MKREQ(0x03, 0xD2, 1);
> +	u8 data = 1 << port_id;
> +
> +	if (port_id == GAOKUN_UCSI_NO_PORT_UPDATE)
> +		data = 0;
> +
> +	refill_req(req, &data, 1);
> +
> +	return gaokun_ec_write(ec, req);
> +}
> +EXPORT_SYMBOL_GPL(gaokun_ec_ucsi_pan_ack);

I think you should add proper kernel doc comments to these exported
functions.

thanks,

-- 
heikki

