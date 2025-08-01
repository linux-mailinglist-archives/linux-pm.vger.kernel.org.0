Return-Path: <linux-pm+bounces-31734-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A17AB17D80
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 09:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94BFF5622BE
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 07:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB6921D5AA;
	Fri,  1 Aug 2025 07:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cjvIiO48"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD4C2192EE;
	Fri,  1 Aug 2025 07:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754033331; cv=none; b=a2J7EgkkpN8xfcUrrc8HYh7Ge3rQM4bcHzTWry4G5WF8NRMsxoLORbDCFqR2c3HJ4JyHv6Uah4lMC04Uf6Q9qtnqbKPiqdOJv45wQ5xLZ3QdMygshG0EmgwBXTMYcodNuO3S7HsNAAUMCL8qsVxhBEJVe7Y3Wpo2QgMMf4MajIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754033331; c=relaxed/simple;
	bh=ampSXwXhrsh0B69HgKlyT4DdAISxdbwFoDCgBK1hfc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bAqB5PjBuF4YL+oioMZfFfzxQ2JxWKY67pHBq0WV8shKj+9ILG4R9AE1biDji4QXxWCuXDqNQ8xlGoszSwUo0p6XuNMHbTRM5WEPuFWa+vn2vUXV0ApbH+jKLcBPBrdCi00FLTt5eJQSfrhe8JJtUb+YOVSXLvmSdp6LvfcDX0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cjvIiO48; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754033327;
	bh=ampSXwXhrsh0B69HgKlyT4DdAISxdbwFoDCgBK1hfc8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cjvIiO48+WQC4N5/io9LgHRVljj/OmVGX3CRimyWTBRQx8T87takQ6PcYWeLJVNq6
	 k+ApgpZNHp39HyAFs+VYK1D1d2f889PQq5S3AWLbKwKPilh6XDEpRA7r6w8JwBQT9P
	 mm02Ccu2cR6wQFVIph0bPyIOTQL72BbJ/wXHGbcj4Du44xkNht4o2jSYuZ/GU+uP+C
	 5OKpFkE3etD0rYpp2l1/GVQ7dBEWFVPCJmnPhPv2CpysyVuGQL/iv0mvutTzlFPH10
	 dJ8ToQ6zD1ipagVp0osunQuN8GX8HfvErmXMuh1NN69t8CRnr86dDnWoqwfeEfi+Zx
	 daPAl2xBA2uWA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BF71A17E1293;
	Fri,  1 Aug 2025 09:28:46 +0200 (CEST)
Message-ID: <6d117b30-1017-42db-af45-9d4137e9656d@collabora.com>
Date: Fri, 1 Aug 2025 09:28:46 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] thermal/drivers/mediatek/lvts_thermal: Add MT8196
 support
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
 <20250730152128.311109-9-laura.nao@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250730152128.311109-9-laura.nao@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 30/07/25 17:21, Laura Nao ha scritto:
> Add LVTS driver support for MT8196.
> 
> Signed-off-by: Laura Nao <laura.nao@collabora.com>

When changing commit 4/9, this also needs to follow with

const struct lvts_platform_ops lvts_platform_ops_v2 = {
	.lvts_raw_to_temp = lvts_raw_to_temp,
	.lvts_temp_to_raw = lvts_temp_to_raw_v2,
};

and

static const struct lvts_data mt8196_lvts_mcu_data = {
	.lvts_ctrl	= mt8196_lvts_mcu_data_ctrl,
	.num_lvts_ctrl	= ARRAY_SIZE(mt8196_lvts_mcu_data_ctrl),
	.temp_factor	= LVTS_COEFF_A_MT8196,
	.temp_offset	= LVTS_COEFF_B_MT8196,
	.gt_calib_bit_offset = 0,
	.def_calibration = 14437,
	.num_cal_offsets = 2,
	.msr_offset = LVTS_MSR_OFFSET_MT8196,
	.ops = lvts_platform_ops_v2,
};

static const struct lvts_data mt8196_lvts_ap_data = {
	.lvts_ctrl	= mt8196_lvts_ap_data_ctrl,
	.num_lvts_ctrl	= ARRAY_SIZE(mt8196_lvts_ap_data_ctrl),
	.temp_factor	= LVTS_COEFF_A_MT8196,
	.temp_offset	= LVTS_COEFF_B_MT8196,
	.gt_calib_bit_offset = 0,
	.def_calibration = 14437,
	.num_cal_offsets = 2,
	.msr_offset = LVTS_MSR_OFFSET_MT8196,
	.ops = lvts_platform_ops_v2,
};

After which:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



