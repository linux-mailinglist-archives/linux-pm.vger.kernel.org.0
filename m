Return-Path: <linux-pm+bounces-31728-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CC2B17D6F
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 09:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60480620DA0
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 07:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94F91F4CAF;
	Fri,  1 Aug 2025 07:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="P8TTs6Yc"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893032AE72;
	Fri,  1 Aug 2025 07:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754033324; cv=none; b=uZStF9ncWN6kgloXNel/i8XjwnCD85SgOQ/OzJ4YTY0HyBJHbfoJdQqxzp/xmFfiKuVRckA11SoyfmN72uKMI5dzoeqXofGuhXP8dBG8NCAVXmoae3jhrS0oXTnjdhRwR1Tj+tEiukaAsm4rNofItBbO9Xu5fssSwIeyCNhNRR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754033324; c=relaxed/simple;
	bh=7KLAjQU7uvnuJrjcRbN+uwgaq2T+iGTStYmHqkE2XI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ECTnWG3idNXJl0ZM9gK7KMu7IntRkBf9k5fyX/G6pJbqerLXz9VVyhK0uBHEVbYBWUps3krb++LwokUUqm098DwKSI2BwTFMsr8us5wS+hXiBs5/vnPUspznzCrfxewaN5snzoDdTUByWGh9qh3WfK5ZZHTyy+zRXn1rdkON2So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=P8TTs6Yc; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754033314;
	bh=7KLAjQU7uvnuJrjcRbN+uwgaq2T+iGTStYmHqkE2XI4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=P8TTs6YcAyYzT/Oz3XBZE39tCTA7VDmrnuQ+oYoFUw1BBaaQ2RPrLR0fRPSIjoPfg
	 bRzMfqLT2EEM5so0Vqk19QzUPReBKN9N/WrjNkCQc5Cqxvj4TijUjTBOLsszov7L0a
	 rFT6Qc0RoGYefG49GsFw8A5jsRnB3oualIu6oaZjhwnGIBnXSy754z6Jx4dRwEJrmu
	 3whvOfwdMkpW9X1ryA/kLuTqaqTID7B2TvL+KIsATaAsIpkzmUqFpBFySmqJLarxI/
	 TGWwvS2hN/Ji7/YKNpeYOmQy051BaukHH8wvqM0PwU1u5/0PcPs5/f8gTuNEkzdWK2
	 Ih9r/CyJn6STw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 74F5A17E0F3C;
	Fri,  1 Aug 2025 09:28:33 +0200 (CEST)
Message-ID: <489baf5c-b1ed-4605-88ab-866b3e4b99de@collabora.com>
Date: Fri, 1 Aug 2025 09:28:32 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] thermal/drivers/mediatek/lvts: Support MSR offset
 for 16-bit calibration data
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
 <20250730152128.311109-8-laura.nao@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250730152128.311109-8-laura.nao@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 30/07/25 17:21, Laura Nao ha scritto:
> On MT8196/MT6991, per-sensor calibration data read from eFuses is
> 16-bit. When the LVTS controller operates in 16-bit mode, a fixed offset
> must be added to MSR values during post-processing to obtain correct
> temperature readings. Introduce a new msr_offset field in lvts_data,
> program the respective register and apply the offset to the calibration
> data read from eFuses.
> 
> Signed-off-by: Laura Nao <laura.nao@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



