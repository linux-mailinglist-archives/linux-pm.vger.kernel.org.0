Return-Path: <linux-pm+bounces-31261-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11467B0D648
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 11:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E36F11C22A6F
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 09:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA3D2DC33B;
	Tue, 22 Jul 2025 09:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HaIsBVE8"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8DD2CCC1;
	Tue, 22 Jul 2025 09:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753177895; cv=none; b=R8+PggxT3027qBE3zm4E2xGle0EdFNxe+3fCb4DPZjTe8epwdkfJJSTDfGxn9gUIkO0gmLcW1OXlb6au4GnL9CiYnxnUBdPdwBto7Qrb/8kc5lpMGSP88miZvMoFU0phmnbQThNt7vw62Hlzj6UAsC+C/okHtyD1gI0rIHnPWxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753177895; c=relaxed/simple;
	bh=lVxHa2zhNH+2LvdHq/VYL69cUHX2Etw2hbHzGQ0URVo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A2MpzADBvKPsRGYDZkkMAJW50y9q8zrRxOXDbATVaw4MIJps7Pd28IiU/Z5gzdLEAUXnUX1Jc/KGsUuibPOng8U9H4FChRnCZ/0fpoEJ0VVvy13ISEVixUron11jRg/4ZFSeauuRwzEwAceEc5mmMY7qFQ2M6QUt4kkRfgjGlc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HaIsBVE8; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753177892;
	bh=lVxHa2zhNH+2LvdHq/VYL69cUHX2Etw2hbHzGQ0URVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HaIsBVE8eb/H8dV25NCgrOEWFYTe4t/eYFuI/rz3+JDB+8bOoCx4I/92/IvQb5kcc
	 cqq1Gn+T91lmo3V7bp9P1lUM2TZN755yPWu4pszqk5oxSaQJj3woP59HmLtiMY2Ljd
	 G7WYyATvPVKQCWH/6UENC+7bTtSF4+pVO1IV9txxnpH31sQRIHoNfzXtXPooYZolGF
	 pvKdFcs7RX7wJFTbxBJEWM2am1eizZU2h+vFnCpiqo1ytdiU9N3NugbEKZIP3oa+wW
	 ZtXKGlxCT3YJPA5SbOL/0IfIAV4OYkNgNKfqxZ/aNYWqp8DV/YZDfJk+atR9mHB893
	 IT0sZ5j8piJ0g==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:bd9c:eae9:88b0:783c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id AAF6817E10D6;
	Tue, 22 Jul 2025 11:51:30 +0200 (CEST)
From: Laura Nao <laura.nao@collabora.com>
To: wenst@chromium.org
Cc: andrew-ct.chen@mediatek.com,
	angelogioacchino.delregno@collabora.com,
	arnd@arndb.de,
	bchihi@baylibre.com,
	colin.i.king@gmail.com,
	conor+dt@kernel.org,
	daniel.lezcano@linaro.org,
	devicetree@vger.kernel.org,
	kernel@collabora.com,
	krzk+dt@kernel.org,
	lala.lin@mediatek.com,
	laura.nao@collabora.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-pm@vger.kernel.org,
	lukasz.luba@arm.com,
	matthias.bgg@gmail.com,
	nfraprado@collabora.com,
	rafael@kernel.org,
	robh@kernel.org,
	rui.zhang@intel.com,
	srini@kernel.org,
	u.kleine-koenig@baylibre.com
Subject: Re: [PATCH 0/9] Add thermal sensor driver support for Mediatek MT8196
Date: Tue, 22 Jul 2025 11:50:46 +0200
Message-Id: <20250722095046.27549-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CAGXv+5EmigF=m1zDZ71AMv02XwyYWQxpiRpiwc7YMg=8vc2FZA@mail.gmail.com>
References: <CAGXv+5EmigF=m1zDZ71AMv02XwyYWQxpiRpiwc7YMg=8vc2FZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi ChenYu,

On 7/22/25 09:40, Chen-Yu Tsai wrote:
> Hi,
>
> On Mon, Jul 21, 2025 at 4:18 PM Laura Nao <laura.nao@collabora.com> wrote:
>>
>> This patch series extends the MediaTek LVTS thermal driver to support the
>> MT8196 SoC.
>>
>> MT8196 uses a positive temp_factor for temperature conversion, requiring
>> slight adjustments in the conversion logic.
>>
>> To support this, the series introduces:
>>
>> - A new struct lvts_platform_ops to allow platform-specific
>>   conversion logic between raw sensor values and temperature
>> - A variant of the lvts_temp_to_raw() implementation for SoCs with positive
>>   temp_factor values
>> - Platform data and controller definitions for MT8196
>
> I see the GPU and APU thermal sensors were left out. Was there a reason
> for this?
>

Based on my testing, the GPU and APU sensors are not functional at this 
stage - the APU controller returns an invalid ID, and the GPU sensors 
report invalid values. I suspect that both the GPU and APU need to be 
fully initialized for the sensors to operate correctly, so I'm planning 
to upstream support for those at a later stage.

Best,

Laura

> Thanks
> ChenYu
>
>> Laura Nao (9):
>>   dt-bindings: thermal: mediatek: Add LVTS thermal controller support
>>     for MT8196
>>   thermal/drivers/mediatek/lvts: Make number of calibration offsets
>>     configurable
>>   thermal/drivers/mediatek/lvts: Guard against zero temp_factor in
>>     lvts_raw_to_temp
>>   thermal: mediatek: lvts: Add platform ops to support alternative
>>     conversion logic
>>   thermal/drivers/mediatek/lvts: Add lvts_temp_to_raw variant for
>>     positive temp_factor
>>   thermal/drivers/mediatek/lvts: Add support for ATP mode
>>   thermal/drivers/mediatek/lvts: Support MSR offset for 16-bit
>>     calibration data
>>   thermal/drivers/mediatek/lvts_thermal: Add MT8196 support
>>   dt-bindings: nvmem: mediatek: efuse: Add support for MT8196
>>
>>  .../bindings/nvmem/mediatek,efuse.yaml        |   1 +
>>  .../thermal/mediatek,lvts-thermal.yaml        |   2 +
>>  drivers/thermal/mediatek/lvts_thermal.c       | 315 ++++++++++++++++--
>>  .../thermal/mediatek,lvts-thermal.h           |  26 ++
>>  4 files changed, 325 insertions(+), 19 deletions(-)
>>
>> --
>> 2.39.5
>>
>>


