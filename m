Return-Path: <linux-pm+bounces-7997-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E90508C9F76
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2024 17:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CF9B1F21534
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2024 15:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B497B1E49D;
	Mon, 20 May 2024 15:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PEM5ajG0"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE0F4C66;
	Mon, 20 May 2024 15:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716218206; cv=none; b=Bhk7zG/VYaXZOkC9eIqEGIwvag2BSG07ziO9SuLsPryHb1UINKKaVFz18ZkEOuphSDTWioBiw6HGwJGeJurcZ6KBPGdTxV1Kz+tdSf1f9KOzEIRvmDu2qwWGQ7NQdm8Htr+cVMk5vZCN7zqzqOPV7iC6InM2593Soq4RZbpOoIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716218206; c=relaxed/simple;
	bh=iT54/HpDZG8UdWdWEo4UM/5Vmmtz6kPS3fZOIckwce0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OGs/llFh4UI/Ny1NvEI1pzv9hgoHMHPFZJMb1Bd40RLJz8VQuAdczbTHAsKmt0s+0UJUrEloS3nnpaML4e3jkht9wa0YuY4u8k5RVVniq7diXBJIAaPi6kfTcdj6l38NLjjHr0BFCreWkZpid3h7IAToyF87p5vnpHFpee2ZYBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PEM5ajG0; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716218203;
	bh=iT54/HpDZG8UdWdWEo4UM/5Vmmtz6kPS3fZOIckwce0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PEM5ajG07x1wmKTgoTEoazS/bTJarTiT+sxB/IglZCSJOMS1Y+itH3w3KGVoenTrF
	 /bmBaeMBVyFHFkHWnGKJ4O81QJ3IY+QFcxKCuB7EnzXY7Xl7c5DkO+E6BxEMNbFlle
	 wskUYdjGCsSjekpTct7zzgAq7M30OxnzHZODxegIu/e1BNect8Rl8x/RnAHXEbaSaC
	 PxqKtOqf0jOYnK89+356X5iClHu4Xx4Ey0zWk7QqTN3GYPia0zXRlGkc+J82DldF1n
	 rnIaH7lRpT2HPR3zLfkmQMJibPtKKqxh9ppmk3c+1Q79F9i82UWrNvU6/0Jl7NpNMH
	 GScbg2diT5X2g==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9C549378000A;
	Mon, 20 May 2024 15:16:42 +0000 (UTC)
Message-ID: <db915f6f-fa78-4747-9b1f-b36851d657f6@collabora.com>
Date: Mon, 20 May 2024 17:16:42 +0200
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
 <eae892e8-f888-4d15-85a5-c89b6b6825f7@baylibre.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <eae892e8-f888-4d15-85a5-c89b6b6825f7@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 20/05/24 14:53, Julien Panis ha scritto:
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
> Hello Angelo.
> 
> I took over Nico's work, so I might have missed a few things, but I'm
> a little bit confused with patches 7 and 13 (you wrote '12' but meant
> '13' I guess, didn't you ?).
> 
> It seems to me that patches 7 and 13 were applied in next-20240503
> (f5bcf8ab0950 and d3dbc472ac66). But I don't find them any more in
> next-20240520. It's likely that I don't understand well the process, but
> I prefer being sure...Should I resend them in next series ?

Yes, please.

> 
> Just a comment about d3dbc472ac66. There's a typo error, I think:
> nvmem-cell-names = "lvts-calib-data1";
> ...should be replaced with
> nvmem-cell-names = "lvts-calib-data-1";
> ...according to the related yaml.

Yes, that was a typo :-)

Cheers,
Angelo



