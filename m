Return-Path: <linux-pm+bounces-36054-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5297EBD89D6
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 12:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F24333520A7
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 10:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD2B2F5322;
	Tue, 14 Oct 2025 09:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DKxP0x3l"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1C72EDD60;
	Tue, 14 Oct 2025 09:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760435956; cv=none; b=ILFtMkFMGkEUV/6y5iMSdFEdzzJgNnBk+WtcbY/KIYeiJRBTQN0hs71IeeS+EcLuugcsZZEOQOVuaDwFrrOMuj6JuWpxTTh5+g3ezvOOp4pM1zgJPPLkGZ49AYZoYqM+YWdt5VNeHBCTuEUZKqLUyJSUQ/Y+ZWYXz7AOdO3zmRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760435956; c=relaxed/simple;
	bh=RW9rDXZZTkBlQd1CX3NyCXi4d1HyJorh8kDyYsGTwnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sol29P8GhazgdtRyzLwL9iAfxjcUC2Jdt94slAjS4v4KBqJIjt9eLoJ7Er1yNuPbMdCH8P12spv6s2kd19yABgxvIrhKhaqkVg+Uro0FEJMBY2vfOCmIj5TUGLCgLq5Rjvik5WiTnUl7pKQLH/OcRpX7KemmC9lWh1wuPsz1MX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DKxP0x3l; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760435952;
	bh=RW9rDXZZTkBlQd1CX3NyCXi4d1HyJorh8kDyYsGTwnw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DKxP0x3lFLMUJe9HY7f4ODu1k5SSB8FKbFPOGVemcQPAL3CtTFJkgsAd1lGyH3p63
	 xQTj9go7D7uuE46t5QxNGzCSmf0I7IEjboyBISp5li9Eq9Op6qEXpWlqScuEDripIM
	 uuSZMO8uc6A0oHfZ5VPfJtT4uJmQ1V5IT3qMKYIfXYwXp9iLewsGrAmixJTmVhpBJO
	 dgOBlgz8DwmAu3Qj9aayunm5X2u2V1M69TYaV6WHFAXfm0Q/2p7SsvI51z/tIiCDxG
	 4o4u9xoNW/zSFZaHp6Adc0ZcnmP6WPAJpf1KAW3C8gSToQZvgzTcwMajmkipcGA1/d
	 AYJR8scTTngnw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1801317E0125;
	Tue, 14 Oct 2025 11:59:12 +0200 (CEST)
Message-ID: <be3a2d50-044b-429a-820c-5260c6ce730c@collabora.com>
Date: Tue, 14 Oct 2025 11:59:11 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/10] pmdomain: mediatek: Refactor bus protection
 regmaps retrieval
To: Sjoerd Simons <sjoerd@collabora.com>, linux-mediatek@lists.infradead.org
Cc: robh@kernel.org, conor+dt@kernel.org, mbrugger@suse.com,
 y.oudjana@protonmail.com, =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?=
 <nfraprado@collabora.com>, linux-pm@vger.kernel.org, ulf.hansson@linaro.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 mandyjh.liu@mediatek.com, lihongbo22@huawei.com, wenst@chromium.org,
 matthias.bgg@gmail.com, krzk+dt@kernel.org, kernel@collabora.com,
 linux-arm-kernel@lists.infradead.org
References: <20250805074746.29457-1-angelogioacchino.delregno@collabora.com>
 <20250805074746.29457-5-angelogioacchino.delregno@collabora.com>
 <a2eae87efe46ebf397bcec3580eb9bc152b80846.camel@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <a2eae87efe46ebf397bcec3580eb9bc152b80846.camel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 13/10/25 15:41, Sjoerd Simons ha scritto:
> Hey,
> 
> On Tue, 2025-08-05 at 09:47 +0200, AngeloGioacchino Del Regno wrote:
>> In preparation to add support for new generation SoCs like MT8196,
>> MT6991 and other variants, which require to set bus protection on
>> different busses than the ones found on legacy chips, and to also
>> simplify and reduce memory footprint of this driver, refactor the
>> mechanism to retrieve and use the bus protection regmaps.
>>
>> This is done by removing the three pointers to struct regmap from
>> struct scpsys_domain (allocated for each power domain) and moving
>> them to the main struct scpsys (allocated per driver instance) as
>> an array of pointers to regmap named **bus_prot.
> 
> Trying to boot v6.18.0-rc1 on a Genio 700 EVK using the arm64 defconfig,
> ends up hanging at boot (seemingly when probing MTU3 and/or mmc, but that
> might be a red herring).
> 
> Either reverting this patch *or* having CONFIG_MTK_MMSYS builtin rather
> then a module seems to solve that.
> 

Thanks for the report.

This is not a problem with this patch specifically, but surely some race condition
that was already present before and that does get uncovered with this one in some
conditions.

Without the devicetree updates (which are not upstream yet) this patch is
fully retaining the legacy functionality 1-to-1.

I'll check what's going on ASAP.

Cheers,
Angelo

