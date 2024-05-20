Return-Path: <linux-pm+bounces-7998-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B088C9F7D
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2024 17:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 581831C213A4
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2024 15:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1978136649;
	Mon, 20 May 2024 15:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UEJRy9kw"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147611E49D;
	Mon, 20 May 2024 15:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716218262; cv=none; b=mT83pLHu8+iEnUA4DJxxg78ERiJwxJl3PtqBdLtZnCh/F7dbXYNKAQ8pYwGbwYpV1SA21FyCIZBKijVEcKB4B36027OAOMCaD3Bk6I/C332DOvwRsBD38cKhWWa5txiiTxNVUTrGzIVgFE3Wq1OYY8FUuRqnl+eHhpmVKiBxJ3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716218262; c=relaxed/simple;
	bh=uOtGIokG1ej2tjKbqGupcKq5GCu2h9Y/Z6vGZV0u5Xs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q8xYehKOZBPvODU0a7s+/wE08O+ZRfQmL+CuvpPtbrz8eu19337EvBmd4SIaKxs2J6JBKNUxmNsHmLA831gXTyIomUFrpWU6Dv2M97WECQKmKIaiMu6VY+ItJwK+aMiyBTrXSgqwh5Qy5wF1cw3Ku8a7N5NirpiPpAhLDS675n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=UEJRy9kw; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716218259;
	bh=uOtGIokG1ej2tjKbqGupcKq5GCu2h9Y/Z6vGZV0u5Xs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UEJRy9kw6Npf7mH1E9bD3EIuQBame++rtyXg98us58+Q5wDNSXd+3ZunPzuNYT6Q/
	 4fXLAANOecpWvIoGki2FE25wKASJzcIG66ffpZJ//fnGnglhMn1MxhI85R5DHbf2EE
	 u0SbmVsFH6yrYm9CJpiGOxyqU7YN8Kk/lajgx+FxijhA3I4pxnRgKfzuhwoZ0hJb3F
	 3nBjfBn//3QToBasV5/TXI3+JmNyL/VaI7tzKaU8D/oAS0AQfysZFHIeOjKVJlNqGU
	 sO8N98F4CNw31ZjhOSNGSG85apx3031BocjAGZHQUzcxI+OJYpcMFjo6xA249T0Eqd
	 ir4O31HVWGm7Q==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id EB98637810F1;
	Mon, 20 May 2024 15:17:38 +0000 (UTC)
Message-ID: <42c247c8-f4d6-4adb-a44e-218acfef6dce@collabora.com>
Date: Mon, 20 May 2024 17:17:38 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/15] Mediatek thermal sensor driver support for
 MT8186 and MT8188
To: Julien Panis <jpanis@baylibre.com>, Nicolas Pitre <nico@fluxnic.net>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
Cc: Nicolas Pitre <npitre@baylibre.com>
References: <20240402032729.2736685-1-nico@fluxnic.net>
 <981a8748-16d0-4744-b097-aa9dd14c63a8@collabora.com>
 <13468147-6853-4bd8-bd3d-d1f1927133fa@baylibre.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <13468147-6853-4bd8-bd3d-d1f1927133fa@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 20/05/24 15:18, Julien Panis ha scritto:
> On 4/23/24 11:22, AngeloGioacchino Del Regno wrote:
>> Il 02/04/24 05:25, Nicolas Pitre ha scritto:
>>> This is a bunch of patches to support the MT8186 and MT8188 thermal
>>> sensor configurations. Several changes are needed to cope with oddities
>>> these SOCs implement.
>>>
>>> All values (calibration data offsets, etc.) were lifted and adapted from
>>> the vendor driver source code.
>>>
>>
>> I picked patches 7 and 12 (and also fixed them) introducing the nodes for the
>> LVTS controllers, but will not pick 9 and 15, as they're either missing thermal
>> zones and/or using the wrong names; let's wait for the next cycle for those, as
>> I will also be able to add the SVS on top (needs a bit of time for testing),
>> getting both SoCs complete on the LVTS side, without rushing.
>>
>> Cheers,
>> Angelo
>>
> 
> What do you mean by "missing" thermal zones ? (is there some reference
> code somewhere listing them, or whatever ? how can I know which ones are
> missing ?)
> 
> It seems to me that Nico took into account your comment about 'tzone_name'
> and fixed these names in v3 ('cpu-little0-thermal', ...). Are they still wrong ?
> 

Check mt8195.dtsi ;-)

Cheers


