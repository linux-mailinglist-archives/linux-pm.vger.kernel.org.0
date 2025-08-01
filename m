Return-Path: <linux-pm+bounces-31730-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62634B17D77
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 09:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2653F7A2E0D
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 07:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4915320C00E;
	Fri,  1 Aug 2025 07:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="K05WUxP7"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707DE1F3D54;
	Fri,  1 Aug 2025 07:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754033327; cv=none; b=QbtbiottWEJJPl14uesUAFV8NClJFMdUy1cAhJCZe8YefirK+/vbHfn2XmvO+eXMX5+YVsNlVlkTXamagEiJsMHfgjuw63fksMMsEfaNiILA/022BWdHkILLqOTQnS6uhWchHBetQPl0+qhYiK/FOhyqIeWk7GbY6CqcIwOWKro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754033327; c=relaxed/simple;
	bh=YY/d5ElYBdgTxtMEPGsfYizPy2XmUPIe4KD7N3Dazfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hAFTcrJgSa8Z0xdiVkbK9moZ3pzOoeh1uSHZ79ojWSvrkNAl4HqsDf0yYdXuAqg6m/i+aD10u49yr7hx1iEG8W1Di1rhKpj2783C3rx2U2bj0uX4X5jSilqta0z3/nmgi+L9hSHnT137Q3Q+RuwPnYQZVC0y7GdjtGkRX6u2VO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=K05WUxP7; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754033316;
	bh=YY/d5ElYBdgTxtMEPGsfYizPy2XmUPIe4KD7N3Dazfk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=K05WUxP72G6uboUvXOqZcc7ryPs1yeM/N2RyDoCbreC6aSd19UYSJa5NT7yYBIj9q
	 p9hpaQ7SHwSf6eAjQX2mnaRvjVXD6I8GCoIi6hJ7dgVGkrU0n3fXK3Bt+j/foNkA65
	 p/DY0F3iWKyPBgnClQKSf3UaCL9HWIHd/N2XCaHQV4LiSugpl9XbhKA3KPvqV4bQNN
	 htZ3HW3awR5/Pu/Fva0dZxvu/Nb5wiXfhATle05j990eN/mn4Gq39wmkuPEBgGFRe5
	 pxazZFAyF/KCp5f8FvL+KGsXkhmvqYOSEuvXOUGMrv8T1nG9cpqnI3g9sUdrKox+ff
	 RnwViJMT8Qxbw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1BF0917E0FFA;
	Fri,  1 Aug 2025 09:28:35 +0200 (CEST)
Message-ID: <fbaad3bf-b2b6-48d8-863a-5eef16cc103c@collabora.com>
Date: Fri, 1 Aug 2025 09:28:34 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] thermal/drivers/mediatek/lvts: Add support for ATP
 mode
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
 <20250730152128.311109-7-laura.nao@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250730152128.311109-7-laura.nao@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 30/07/25 17:21, Laura Nao ha scritto:
> MT8196/MT6991 uses ATP (Abnormal Temperature Prevention) mode to detect
> abnormal temperature conditions, which involves reading temperature data
> from a dedicated set of registers separate from the ones used for
> immediate and filtered modes.
> 
> Add support for ATP mode and its relative registers to ensure accurate
> temperature readings and proper thermal management on MT8196/MT6991
> devices.
> 
> While at it, convert mode defines to enum.
> 
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


