Return-Path: <linux-pm+bounces-23281-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B42A3A4BD89
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 12:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7D3A188A1A9
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 11:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE49F1F540C;
	Mon,  3 Mar 2025 11:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DvJDubH7"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51E11F542A;
	Mon,  3 Mar 2025 11:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000044; cv=none; b=O6KdkURY0c0KzMAxroOBB5yJmp04AUH6K7C0xM/9Gt4hXh14Zmg9Bkl7vJXCkxGVbWs8NGq1qUuT2BeQpbCMEMkK15wEo199RcWHi5Y9WUrBjZqSgIheEZMwe7AhujdnBdpAAN5beO0ovnOA/WLvGzg3p+278AOebkAyP2phLJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000044; c=relaxed/simple;
	bh=CpJfq3S1+X8ONFH2yRFiUWGqiFMtXwOfwjmYSN63tck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uvfM4yEBZNRu3ORy/JLY5FIpqlaxV8N0HnsYkyi8E/h23CWsFXMNt0joSh3/8jdDwin6JA/HDKlPssdRx+Kbpqn/8tHBcZxoG6ddN5P7P4LBLBzq4+9gdyfujR9oMvw5g+VmF55B8SP16zUi4qE+8O8BH3r4XVB4deqjPY9h5PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DvJDubH7; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741000041;
	bh=CpJfq3S1+X8ONFH2yRFiUWGqiFMtXwOfwjmYSN63tck=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DvJDubH7pcfRMyNZUukFQ9x2863DM9mnq0eNM3tAYR6ZWG5xC/17mgJqpx2hzWW0L
	 U925ZhMJMsUAqX30mrSi15gSMXSj+YVkBp8JQDIC3EesS+OnbOP5Q+U4SCBpFsmOLv
	 Z24jIGSx5cfGY2Kr1iVwppqNgptLHZO7bBfPxlRhd6bbY3KsFqNVVRkd3MEQw/O/MJ
	 5zYvBFTFRVolifnmxXevB3ve8n1+W096FuWjlrdIjGQDlI8OLMsdX8Ab3AYvUBT0/P
	 1C/gCHrSN8gi2pVZtF9Jdo0qQanT5g0AjQQAFCpgP7WXxznb1vvklqnpU3KTVuNqkN
	 TbEHwop1VtzGw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8467F17E09B5;
	Mon,  3 Mar 2025 12:07:19 +0100 (CET)
Message-ID: <e6d45582-6631-4f90-bc1f-8f70f974aebe@collabora.com>
Date: Mon, 3 Mar 2025 12:07:19 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/20] ASoC: mediatek: mt6359-accdet: Drop unused
 moisture variables
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Sen Chu <sen.chu@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
 Lee Jones <lee@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-pm@vger.kernel.org
References: <20250302-mt6359-accdet-dts-v2-0-5bd633ee0d47@collabora.com>
 <20250302-mt6359-accdet-dts-v2-11-5bd633ee0d47@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250302-mt6359-accdet-dts-v2-11-5bd633ee0d47@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 02/03/25 17:30, Nícolas F. R. A. Prado ha scritto:
> The dts_data struct contains several variables for moisture
> configuration that are simply never used. Drop them.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



