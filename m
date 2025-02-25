Return-Path: <linux-pm+bounces-22873-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E15A43C3A
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 11:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB3893B74A0
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 10:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E992676F1;
	Tue, 25 Feb 2025 10:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fMwJ9Xht"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A43267385;
	Tue, 25 Feb 2025 10:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740480583; cv=none; b=g17m7uQxb7ZomsNaBb6IY5WWUv29zwAuXwyVZF6GSBDRH5bYuqFtBqHwx4Ylti5kKLh58AsfgAZHixEfgjEPTPbCV0twUhLj8Sji+kvR6lpdplDlg6LV2ERkiOQ/dVBD9JB0Xh/1Xzex8Rop2KUkCArSlwYfX4pzugU0UEca8/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740480583; c=relaxed/simple;
	bh=R7MEZJW6bd4NSLTt3IimgwyCKUcwAwDoB6ir48EEfqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ip8ydtkjsdlLeL5SGphKY8mzLokGgmvPaWwHH2Hu/E/wEu7ilLMycyIlskjt8xf473KEwHVVpikzKzLLInmuRvuC4qcdhtJVN+Q6UzJIkf9nihSXE662KrEStcvItHNW8d9GM9YVWQwHoppah6PfXTAMb0Ixo6urGSMFv8K0h88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fMwJ9Xht; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740480578;
	bh=R7MEZJW6bd4NSLTt3IimgwyCKUcwAwDoB6ir48EEfqY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fMwJ9XhtUXjEN2vlaJh07PaXyT/nHqGslgv+kEdHPFJgLfRRqHOXb+mg9pbUnNuJJ
	 5ejO+FU8x3v5OPDoXDesfYMQ5GJYZG13z0EwPxp5b/DjsJtsbiAx4bek+1VfXJMv5H
	 9TP6khLKusio70+dPD0s6jDqTE2MPeMtKJ7Ax+AulmlBcfS9aaCun3SoRyabPWqW9f
	 mfUXGYB6S103fvizHXy3xEhyNQPJe6gPUIaIIJkNOpaO8zW7waoxQDrXQH1aPFygaG
	 ro+Apx4mwtvu1bhOd+C8anATsDEKrw5dUUMHjURPe7im7QFbtOYTlOI940/ut6xnYf
	 lS3HxsjaJK6Zg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 813B617E1067;
	Tue, 25 Feb 2025 11:49:37 +0100 (CET)
Message-ID: <6baa9e47-9ef6-410a-8ecc-77e40c0c9da2@collabora.com>
Date: Tue, 25 Feb 2025 11:49:36 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] power: supply: core: convert to fwnnode
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
 <20250225-psy-core-convert-to-fwnode-v1-7-d5e4369936bb@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250225-psy-core-convert-to-fwnode-v1-7-d5e4369936bb@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 25/02/25 00:21, Sebastian Reichel ha scritto:
> Replace any DT specific code with fwnode in the power-supply
> core.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



