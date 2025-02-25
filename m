Return-Path: <linux-pm+bounces-22875-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30749A43C45
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 11:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF64D19C0E6E
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 10:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6FC266EF4;
	Tue, 25 Feb 2025 10:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dYRZBIen"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A36D207640;
	Tue, 25 Feb 2025 10:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740480622; cv=none; b=RM3ggAUPJkcQLlIF/qjCUiHI6x0fKisuTSd8ZRurm6X+1j1L4N2E0kd0zN7H5E+xh6cH4EIBwaVyzF0WjJ6DSeLQJYfNHu/89xmOiskQxx1A8o7Zv4xAMBC4WFwCFlfc1Yh0YAcUfYIPLDJy/gvOJ+N1hbt3+TwaHyPNHXKy5tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740480622; c=relaxed/simple;
	bh=JzFCs8VCJ67cYjlx00TpF8m/+2Su4KE4IHRkCPu4G9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UPHbhbIsd6IKyxq0/xNFrhrQtSMOrVNpOWIwat83eo2AmfKce2G7sIbNONFKogXUvaSJQ3z/wABVedPu89WrtIrGQG/8xaDUvyRgbf1QhoYIUiXIanEbfLxPLhEIsod4q9aUmDZYovu2ElX8rU+bZ31oiCnOdVhQX21LAAuPTMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dYRZBIen; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740480618;
	bh=JzFCs8VCJ67cYjlx00TpF8m/+2Su4KE4IHRkCPu4G9g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dYRZBIenl9xlVLqv+2bZ0S4VSjAi3KKS+lPzc8qR8GSbsYJnhPTIMSylXXEORODwj
	 G8R6kTAyN2e/EOstqtMuDBaiaSx5bPTvyVRQHg+hG/uaJBAD1MKbAi1uGnBj8HwM2J
	 u4bOfxdLz5hjvBDUr7viX/t8ZkXBkItHUjsHKaMM6YOx8zBDCJykwrk8Rr45LnfSyo
	 DOZl2nfnUxeKGurMJWaBSNNJLFO+3laG1CakrMDPqihSX39zVUgJ8AuJSRudMvyjIo
	 4Q81vqlbcpRNEydR1SnkgMjxfcmSheBU+o773Qc4FFGyRzEmnMN/e3Rf17zbKnGX+7
	 oPUbmurvOVcZQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8792E17E1080;
	Tue, 25 Feb 2025 11:50:17 +0100 (CET)
Message-ID: <8ddb9122-6549-42b7-acf8-f73b2d5a5312@collabora.com>
Date: Tue, 25 Feb 2025 11:50:17 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] usb: common: usb-conn-gpio: switch psy_cfg from
 of_node to fwnode
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sebastian Reichel <sre@kernel.org>, Mark Brown <broonie@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linus Walleij <linus.walleij@linaro.org>, Hans de Goede <hdegoede@redhat.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>, =?UTF-8?Q?Pali_Roh=C3=A1r?=
 <pali@kernel.org>, Paul Cercueil <paul@crapouillou.net>,
 Samuel Holland <samuel@sholland.org>, David Lechner <david@lechnology.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
 Purism Kernel Team <kernel@puri.sm>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Orson Zhai <orsonzhai@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20250225-psy-core-convert-to-fwnode-v1-0-d5e4369936bb@collabora.com>
 <20250225-psy-core-convert-to-fwnode-v1-3-d5e4369936bb@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250225-psy-core-convert-to-fwnode-v1-3-d5e4369936bb@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 25/02/25 00:21, Sebastian Reichel ha scritto:
> In order to remove .of_node from the power_supply_config struct,
> use .fwnode instead.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



