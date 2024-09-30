Return-Path: <linux-pm+bounces-14930-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3C7989D75
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 10:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8970AB2110A
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 08:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593F2183CCA;
	Mon, 30 Sep 2024 08:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gxRsvhD0"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872BA18132A;
	Mon, 30 Sep 2024 08:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727686625; cv=none; b=IZTcGow62tpbpWUbgjXEjR9u3z0BniAFJFGUGYYtgcg3LzGN3jdSy/IWz/y++TIA9prX3PhmOGs1Gz2Z80+7iVLzZDFy7PMnxN5joVcSe96Pid/PU0wYENBO/jK3ZCT9H+HmGQ+m92NHjnStQro39pU67VrmmRzNNa7ZpkOxg6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727686625; c=relaxed/simple;
	bh=RRK9Oszbh79YT4DewKwCNUO67et5+TBu6p5sJ2Au3kY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XZlRBcPYmekLApbEJix80lwoNNJHybdCqtKTVWUPiV+CjP96Bpju35Yobs/dU4tf836lNekiAwF8o+epuG40VayE9qGnBMr66qlde3pa98xKNNtiT4UwRZA1xigHeA5ZHnSuG6aWZ+1dNomPyZurcX8tUTw+yHMy/69O2cBKtGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gxRsvhD0; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727686621;
	bh=RRK9Oszbh79YT4DewKwCNUO67et5+TBu6p5sJ2Au3kY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gxRsvhD03S0cWwbUtL7sqBtCluUD69qqNc87WZkMBQGPx30E39voB4FbamMK0ME0l
	 QooGgAyiKgNKuOrsa2A0aKNHFRs6mZKddKzivfHwhDPq8XVNzpGre0Zmb3rZy/DMam
	 RBfad1caeHvQ7F9zUHMdnF4u9NLSUFzMO8wqwZG7LoJ4L1Ltrj4DYqhALQma+o09tk
	 4SMffNO17Gx6AsfmISZSv5xL0wlxEhLJUinDkc409u6gyIA5B3MBWtt5bsyAEnC+Ae
	 ux2d9sbFfYpmqbM/cpfPG7WKuCTF9Bzl1VsEV9cIXBvgKYIq6fICf2Zu4R1iVQxfNi
	 41ZbPNd6CRjsQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 542DB17E0EB5;
	Mon, 30 Sep 2024 10:57:01 +0200 (CEST)
Message-ID: <b261e9b1-826a-456a-bf69-b15bf50c3fa8@collabora.com>
Date: Mon, 30 Sep 2024 10:57:01 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/3] regulator: Add of_regulator_get_optional() for
 pure DT regulator lookup
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
 <20240930044525.2043884-2-wenst@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240930044525.2043884-2-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 30/09/24 06:45, Chen-Yu Tsai ha scritto:
> The to-be-introduced I2C component prober needs to enable regulator
> supplies (and toggle GPIO pins) for the various components it intends
> to probe. To support this, a new "pure DT lookup" method for getting
> regulator supplies is needed, since the device normally requesting
> the supply won't get created until after the component is probed to
> be available.
> 
> Add a new of_regulator_get_optional() function for this. This mirrors
> the existing regulator_get_optional() function, but is OF-specific.
> The underlying code that supports the existing regulator_get*()
> functions has been reworked in previous patches to support this
> specific case.
> 
> Also convert an existing usage of "dev && dev->of_node" to
> "dev_of_node(dev)".
> 
> Link: https://lore.kernel.org/all/20231220203537.83479-2-jernej.skrabec@gmail.com/ [1]
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



