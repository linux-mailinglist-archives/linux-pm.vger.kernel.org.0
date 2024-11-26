Return-Path: <linux-pm+bounces-18114-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 612089D94FB
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2024 10:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A8A3B3096F
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2024 09:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CEF1BC9FE;
	Tue, 26 Nov 2024 09:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AiMtB6v3"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90C31BC063;
	Tue, 26 Nov 2024 09:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732614229; cv=none; b=GjL+PzOlRnokZ78Va2kuI+FmD8BG95i1ExGmbOvl3YkpOyzf2YerZXd1BJVCM4Qt4d9ReDKBQBd62fEnDF7OMYajqI+HJUtmK6fIcuxD7dL3v6YzYlMpAmdldYdvrYCMT9bhB4TgRqUJ8JbMWHc3DQkKTrF+3Uy5DIxkY3jFFHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732614229; c=relaxed/simple;
	bh=hFWivGWFXV2zKkOhtrDzHW7UZpgq/HrqUay9ptzgzvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BJ56TjD26oUO7ilLnenyFgfPISVazK5J6Xm7Nl3gEddf/NS0jMdTXlX94+B13vqadA4KP5tQVXYAKgUsn7TG9Va/CXDZayUSDjGDeLwOwngVjI0DiJpoTLLDqY4AlNOglkAzuU1DvaOoGuWOykhQe4cXrTsbjsH5nglONvWwmWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AiMtB6v3; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1732614226;
	bh=hFWivGWFXV2zKkOhtrDzHW7UZpgq/HrqUay9ptzgzvQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AiMtB6v3MhCGjwobllJZh0jq45f2sY/xCLlf9fe7ebbZHaitpkBVLxG3FpkJcnYcM
	 6hhMWZcvXb1d8UHVkDa1jkuEatG5LMs+zYIh2Z4NWpstABoQtrnwCmhLFb+hNa/ve5
	 bMDcH0w17cU55tUPozah6QcY4JqE/QVtr0JXxNueP5vrtZRlyhx7xAYC1hts1MpPxn
	 XvBCgWfWH2afj+S042QQOA/rC+wqQVR0045mb/8ehqe4C5y51BDk+VDNUK0BEVNOHO
	 D9qZuV2jgZ5Zzu3waFj/LwkP3G84T0PZnrVgYmLN0ibzoWf+zQJxpUQQlsJssoWbfj
	 GJJRvCSrFHFbw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3F96E17E1524;
	Tue, 26 Nov 2024 10:43:45 +0100 (CET)
Message-ID: <890e4d95-bd73-4176-993a-fc922d72cdde@collabora.com>
Date: Tue, 26 Nov 2024 10:43:44 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] thermal/drivers/mediatek/lvts: Only update IRQ enable
 for valid sensors
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, Alexandre Mergnat <amergnat@baylibre.com>,
 Balsam CHIHI <bchihi@baylibre.com>
Cc: kernel@collabora.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Hsin-Te Yuan <yuanhsinte@chromium.org>,
 Chen-Yu Tsai <wenst@chromium.org>, =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?=
 <bero@baylibre.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
References: <20241125-mt8192-lvts-filtered-suspend-fix-v1-0-42e3c0528c6c@collabora.com>
 <20241125-mt8192-lvts-filtered-suspend-fix-v1-5-42e3c0528c6c@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241125-mt8192-lvts-filtered-suspend-fix-v1-5-42e3c0528c6c@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 25/11/24 22:20, Nícolas F. R. A. Prado ha scritto:
> Only sensors that are valid need to have their interrupts enable status
> updated based on their thresholds. Use the lvts_for_each_valid_sensor()
> helper in lvts_update_irq_mask() to ignore invalid sensors.
> 
> Currently, since the invalid sensors will always contain zeroed out
> thresholds (from kzalloc), they will always get their interrupts
> disabled on this loop. So this commit doesn't change the resulting
> interrupts configuration, but it slightly optimizes the loop by skipping
> the invalid sensors, avoids potential future surprises if at some point
> memory is no longer allocated for invalid sensors, as well as makes the
> code more obvious.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

That's lovely.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



