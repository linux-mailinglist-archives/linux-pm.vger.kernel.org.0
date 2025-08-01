Return-Path: <linux-pm+bounces-31729-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE6DB17D72
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 09:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 794536219E4
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 07:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104B120298D;
	Fri,  1 Aug 2025 07:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gtRDKKJb"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8531F3FC6;
	Fri,  1 Aug 2025 07:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754033326; cv=none; b=pXyw4shjn3ccXqzXbstic6SE3BR7MNsrhSmJHKoq/t67nSKT1+ZLEWj/XS/KRLk2gh1mzMAs0anXp/GnDEc7NcU09MLEF45rhE2wvbIWD3d7DybciYDqRmgRxVoK1FxQL+zP7RqXDhrcAUptbalaS5hQY1R1PI1+chJA/LiM9uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754033326; c=relaxed/simple;
	bh=cJOZrJVqTn54T1sWZZNpKwPvvOjubd5GMfcP+9HSNaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZaGe0MgOKP+0SsNLyjiadGnPaChaEM0LZ1SVmaNlXk2WCgrXUu5KUGVM0FBP/rwwzThR9IRpkVeu7PYofUJOPo212rSiKqhpD/ttR/SBgyjbsVh0u+wPk/JY4gzFaRrjmG79+zxBKDOJGZnGAHjSw6eKeujEZzh/2CB8Z/SU5pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gtRDKKJb; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754033322;
	bh=cJOZrJVqTn54T1sWZZNpKwPvvOjubd5GMfcP+9HSNaI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gtRDKKJb99HJ4Q5f3nHAVfpIo6Te/52HnDNPZguqiZ2hp4a4UkKINSMnggYExK8RJ
	 u1m3P7sKs4IKnyNC147SgsSHpbJiWHiV+IT5TfhJRBfIso5u4pTuCz++GtQvJFAyqh
	 /ZTndMioD5AsdLL7FCIXmhAhOyo/nGiljKNYUntnb4eMtNj4hwKoRLPIa+Qf9A4Zhj
	 TpiYX5H4Ip9nLnDSuYV9RXdSXCaj4Tuqg6AYq+ogTPjQ9teOcPNwLgzqbbVDj5L+X2
	 O0zJr2p5f5Z+XRdY2TxRjkJFBrAho+217t+8/OJKJv2Q+C39JWjIxf77N0suUK4oBF
	 nNIP2XPSp3r/A==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8007717E1319;
	Fri,  1 Aug 2025 09:28:41 +0200 (CEST)
Message-ID: <062a44cf-eae6-4d5f-a736-8242a606ca5b@collabora.com>
Date: Fri, 1 Aug 2025 09:28:40 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] thermal/drivers/mediatek/lvts: Make number of
 calibration offsets configurable
To: Laura Nao <laura.nao@collabora.com>, srini@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, rafael@kernel.org,
 daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com,
 matthias.bgg@gmail.com
Cc: wenst@chromium.org, nfraprado@collabora.com, arnd@arndb.de,
 colin.i.king@gmail.com, u.kleine-koenig@baylibre.com,
 andrew-ct.chen@mediatek.com, lala.lin@mediatek.com, bchihi@baylibre.com,
 frank-w@public-files.de, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 kernel@collabora.com
References: <20250730152128.311109-1-laura.nao@collabora.com>
 <20250730152128.311109-3-laura.nao@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250730152128.311109-3-laura.nao@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 30/07/25 17:21, Laura Nao ha scritto:
> MT8196/MT6991 use 2-byte eFuse calibration data, whereas other SoCs
> supported by the driver rely on 3 bytes. Make the number of calibration
> bytes per sensor configurable, enabling support for SoCs with varying
> calibration formats.
> 
> Signed-off-by: Laura Nao <laura.nao@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



