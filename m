Return-Path: <linux-pm+bounces-31731-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4601AB17D76
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 09:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ED971AA42CF
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 07:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F6E20E011;
	Fri,  1 Aug 2025 07:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DEzkPZrl"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10D01FDA94;
	Fri,  1 Aug 2025 07:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754033327; cv=none; b=S5W2SvjxFJ2rFgsTRJRR/qRPXOgslvJlJWHszw/NgCY3Obz/K2Ub7COtUowRzHsRKDb+YLTjr+594eeo2YyUZZPucFt74/8Sb00fRrP4nPt6R97qu8SZogoKiM/mhFrHpbxuPY/WjE4SMbqvbbEzOort+onPZnouAQLl3m7SxQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754033327; c=relaxed/simple;
	bh=m3/oenbHZiJsXlOg59UnMyyGslcBydh5bnFLoOrqjww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JEaDcco5j+jxBgKW/Z7PD+zOiNKU/7pxnhwJ1I/tHx1eAo1hZSkJXkd5AMIJ2HrdhnrYB5PHGE0M5DodfpjVqD44VuBO7+vWF878pYa1v9YSEqvPSlK1Gt5ZuNPfqXeUNXjPj8Emw2jAl/6t18XJMINGD2S7ZabTWlZzYZMkzxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DEzkPZrl; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754033318;
	bh=m3/oenbHZiJsXlOg59UnMyyGslcBydh5bnFLoOrqjww=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DEzkPZrlaIYaXoKbzSxCXrxYPKXem0hyo6SZeQ6Zk5e4TQjdhJnx3Dm0Qs3Jnjgvo
	 jknHEDjVyEHD8+oRriNc1uO+YUBM50wuIMUWmPBi7A9ABztRu43vKMkfNdgp95orOL
	 ZcpO1WHc2yB9Ceeqm26vebN6JRpNpzogdPYTnfWM4aPeZLuvk/wVwAXCxKPW6wZgdR
	 DtiBsaINDqj8OuefTXN7y3vHRTBino8HFXGvGcagk6XldU3Q88bNbsyvECXAC9NG4+
	 CsjDQ/vDYm2aDpQhqyPNQSBlX3BaFTG5V3hpm6BXwpd6WXCQMV4ajk4P4mknIlNi7w
	 pQtz6jzNu2i0Q==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id AB23217E129E;
	Fri,  1 Aug 2025 09:28:36 +0200 (CEST)
Message-ID: <83aca3fc-0880-449f-82ea-f2d8d554f0d6@collabora.com>
Date: Fri, 1 Aug 2025 09:28:35 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] thermal/drivers/mediatek/lvts: Add
 lvts_temp_to_raw variant
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
 <20250730152128.311109-6-laura.nao@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250730152128.311109-6-laura.nao@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 30/07/25 17:21, Laura Nao ha scritto:
> MT8196/MT6991 require a different version of lvts_temp_to_raw(),
> specifically the multiplicative inverse of the existing implementation.
> Introduce a variant of the function with inverted calculation logic to
> match this requirement.
> 
> This ensures accurate raw value generation for temperature
> thresholds, avoiding spurious thermal interrupts or unintended hardware
> resets on MT8196/MT6991.
> 
> Signed-off-by: Laura Nao <laura.nao@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


