Return-Path: <linux-pm+bounces-16508-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E5C9B1AA5
	for <lists+linux-pm@lfdr.de>; Sat, 26 Oct 2024 22:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0FF22825C6
	for <lists+linux-pm@lfdr.de>; Sat, 26 Oct 2024 20:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE3118BBBB;
	Sat, 26 Oct 2024 20:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="mcskVFcd"
X-Original-To: linux-pm@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722EA1E4A6;
	Sat, 26 Oct 2024 20:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729972931; cv=none; b=iQdnL9oBvQi2ao0isFPLKrLOgQw+exmBxYz+1aa4EjLshiCB1Zs3eFtsaGk1CtpIQPSu9gpLk08AVQmvGT3g7+rOZNoB1sPTdwco0aDJjv7H/2XVYYshXiM1FRGwNGlN08IJ+YwjQEyCO1wbwNXKKAWDU8fRB4LO5QQgNm+/TCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729972931; c=relaxed/simple;
	bh=xE/CdzsrY/SLsf15Df72Iqucl9kgnUM+5zmzCi3f2YA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ox7wOPaT4ESxdrccWf000uDCpUpbi0cDh3HwXVLcYBTr1AqXLf54aGXlWcAb9vdfEYSBgskVSbg3IyKEjD2sF8K5FxEH9nhYotqfiLr0iNwW19eWfjPVmODisHldiYvhOHS0XFjCeRX4yLAopK7rhmzGAiQcRQf60dytL9XTlEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=mcskVFcd; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id E478DA0DC8;
	Sat, 26 Oct 2024 22:02:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=UG9qAjctPlIK9M3esYhV
	NzjLR1aW7FYj6ulmnX61HyU=; b=mcskVFcduiHiFJ4C2L0g2jhLHOQHhx733dJQ
	8+LUfcNF3D+s/qR6pBWwJyUjBbpPV2wHHVD0kNFczewsoyxEVn0I9dQ6827Hav0K
	lyWFCAgzv2VFb7r/431O+Ta9NdH9VQ4VrRFZlQS0uDOSRooTDJzwAoX120IKU+V1
	ICmMIWMMFUllmTwuo2rHkHSUCOh+atkDcEXTMdoklB67bdJ+pTLOS2DPME5o2ulk
	MTPycUrGU6xbmGs0O2nkcEcLNgf2To4grp1GsIh6afr7KSW1OOAn4mam1jSbRid9
	FoZ5tJslnr1kjHTMjos35SqAFiRuseXLqT8Yv57jMKqXtwztJCRryhHxIdNVGc9F
	apJUKmGLZc3luvR2XnyJUDz9Gh4u0Tc94+p7DjPb74g2UyR/JqimEj4r2E5nkgMM
	HfVyAJ60Ik07F7STjyIiFPC+BcEOx0rsdcpEqOnDzPNHEtSyj/6DmxsvG8jd2Wq/
	RbWJ7t8Cn30tZgH8ufoTN8E3FmZ9AR0afAclouPw6SPffqqJ9vwbl4YqTw82KncO
	C0rcJuOXcYsRbTX5HNHfvU/OjEcqoa8/ZhCBEzVihBAKAPaENCXIYFigWEcGmqU+
	Z4xR0GjXM4uOWKUWTLXdvGju1aeMyqpo5TNnvZvlFz0jqkfoqMy05fIIDid5liKv
	EjoeU+0=
Message-ID: <4e909db8-eb2d-46e9-b61b-19124a1e19da@prolan.hu>
Date: Sat, 26 Oct 2024 22:02:02 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: ip5xxx_power: Use regmap_field API
To: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Samuel Holland <samuel@sholland.org>, Sebastian Reichel <sre@kernel.org>
References: <20241026185930.1777100-1-csokas.bence@prolan.hu>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <20241026185930.1777100-1-csokas.bence@prolan.hu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855677D67

Ah, sorry for the noise. I seem to have forgot to commit an amend with 
typo fixes. I'll send v2 right away.

On 2024. 10. 26. 20:59, Csókás, Bence wrote:
> The IP53xx series [1] has a much different register
> layout than the 51xx/52xx [2] currently supported
> by this driver. To accommodate supporting the former,
> refactor the code to use the flexible regmap_field API.
> 
> [1] https://sharvielectronics.com/wp-content/uploads/2021/07/IP5306-I2C-registers.pdf
> [2] https://www.windworkshop.cn/wp-content/uploads/2022/04/IP5209-IP5109-IP5207-IP5108-I2C-registers.pdf
> 
> Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>


