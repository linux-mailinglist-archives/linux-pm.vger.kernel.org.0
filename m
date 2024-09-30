Return-Path: <linux-pm+bounces-14929-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C53D989D73
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 10:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6104EB20C96
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 08:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E18183094;
	Mon, 30 Sep 2024 08:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NwvMWhBK"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67B217F505;
	Mon, 30 Sep 2024 08:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727686624; cv=none; b=GzUBKqOikmAGit9I/eOo1Ky0AZtamMBWEkQDfdiLRXOnNMHTDlraaqj071GDpR4dGM9hJXnvorki2vv32YlgIndVVbQKFW+C8b6x87w/Wo2TN32OjuF+/UY3CmxXJ7t4liZ85XYh9wmqPT6MiV0COpKkzSpO8I7tKySQwAx1zEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727686624; c=relaxed/simple;
	bh=1Wz1b+aWVRLx1CDCw9KifBrN59wS+Rx3ztAM1uWIgvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CkkCqiGGWXid9vdqLo64fAtTPUU61EvYWqkKX+/MzIfAQIP+unqmxT8qTUjO8KWxRISuPvEis6gpmEhL2FKjRAleuKLIt46iYQYDfdVr1DAi5dBHMubpwWa5B3Ej5sGE/WqPkxYBZrYzS++Xc/wDFmIgzejTxaWLofLIskST2U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NwvMWhBK; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727686621;
	bh=1Wz1b+aWVRLx1CDCw9KifBrN59wS+Rx3ztAM1uWIgvM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NwvMWhBKgOhb2wTuDuLJhlE4paPhhxKWACA+v+Cid6YECRLIJlhBlpF7m6YryRsxS
	 FHRy0VmMs5bvpenWE3gf0k4buEaA1WRmqOOiYKBVUWmam6ROs0j1xB/K4rl9LoWfZO
	 vOCI4sXRPcapSLY7BnPygOtdatFDSr0X/vT8w8CZAg/8GST/o+mMexGIjM7J7/TDvf
	 9ygaDTU+2BtuWlYVxiP1+imn4XI73J/vxVxTXnvou9QjfvSpuat+YlCmO+wzt+nvXD
	 7UsPQaON2MeHhOoTf+y4L3IyWeAjNY9fztGhvrHaCr3soaGQ0kBccrfFxgeJ1NKeGf
	 EXiGAp/vpu4Dw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9319117E0EB3;
	Mon, 30 Sep 2024 10:57:00 +0200 (CEST)
Message-ID: <70779c00-7f2a-4038-9241-b8bb2004948f@collabora.com>
Date: Mon, 30 Sep 2024 10:57:00 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/3] regulator: Add devres version of
 of_regulator_get_optional()
To: Chen-Yu Tsai <wenst@chromium.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, Douglas Anderson <dianders@chromium.org>,
 Johan Hovold <johan@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Pablo Sun <pablo.sun@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20240930044525.2043884-1-wenst@chromium.org>
 <20240930044525.2043884-3-wenst@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240930044525.2043884-3-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 30/09/24 06:45, Chen-Yu Tsai ha scritto:
> There are existing uses for a devres version of of_regulator_get_optional()
> in power domain drivers. On MediaTek platforms, power domains may have
> regulator supplies tied to them. The driver currently tries to use
> devm_regulator_get() to not have to manage the lifecycle, but ends up
> doing it in a very hacky way by replacing the device node of the power
> domain controller device to the device node of the power domain that is
> currently being registered, getting the supply, and reverting the device
> node.
> 
> Provide a better API so that the hack can be replaced.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



