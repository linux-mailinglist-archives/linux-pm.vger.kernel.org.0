Return-Path: <linux-pm+bounces-19890-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE2B9FF833
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2025 11:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0A0916216E
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2025 10:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7251AC8AE;
	Thu,  2 Jan 2025 10:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qffiWESE"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D86A19E999;
	Thu,  2 Jan 2025 10:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735814074; cv=none; b=kUpjCZ0Zg70d72AkKiNT9xGhsyHKr4e9NHJ6P0affQ2BdJH5b5acI7dEO/IwWKi2M0Ds9Y4kzEoxa0WI4v0KN6hCONSatvvR/Kmy1kqe66hRcIonj7gSJ5TGgSVt5qOHm7SUGSgA2uOIQGUF7i//TqKSgAhi3IPTVsy722WDL0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735814074; c=relaxed/simple;
	bh=K1pfxYqXOc52PRosS2j0BYuB9mHwfBtw9u9O1FNSkPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C+GjL8OYjyqCb8e+MgttR9c9JVmHoq5UX9YMJdKCJrHLJpKkTjXfIQy29fXbZwTsyBFoabaHNc1dZAmrjlU5uscomymTrhTSMJAVX8D8BiUlmaAqjWvpM7ELF0RMMqgltmdyVI9RrCQD2xCIzojbG1ti74tmLnopkBP8I7Z89v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qffiWESE; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1735813554;
	bh=K1pfxYqXOc52PRosS2j0BYuB9mHwfBtw9u9O1FNSkPk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qffiWESEleKjF2uZCQdtKxqC+Uy8yySJ0NZISO4YqBRdcdETzJTZxdYkVLhvFHrv0
	 UVBu4bUYRyKXIbQHVK4lxrILiikEgDZGT9Nud2AK9TO6KmRGnUuCSwA9ucMEXaw0kn
	 1pQy9IhUSLzARpCIWI+rptSXUFGEtwUG6YP62cCsuJYfJhiE6OQ3TchWChDJ1hVnvs
	 eyp5mC/mcdcW6bBT8Ez8rnEoGlCTwftfEDFWc1w0u2tvRSwbNaDn8KmbjjLESg+fJX
	 F+4lv8SJNkiJfov6SY1ZHiBRVbEvsHrihMJB2oETHrgaLk0DNjdDhT8h1LX1xwMSkw
	 FG3/w1sB9S1rA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 64B8917E153D;
	Thu,  2 Jan 2025 11:25:53 +0100 (CET)
Message-ID: <599e27fd-e3fe-4d36-84b9-5742995cad69@collabora.com>
Date: Thu, 2 Jan 2025 11:25:52 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] arm64: dts: mt6392: add mt6392 PMIC dtsi
To: Val Packett <val@packett.cool>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
 Lee Jones <lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Eddie Huang <eddie.huang@mediatek.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Fabien Parent <parent.f@gmail.com>,
 Yassine Oudjana <y.oudjana@protonmail.com>,
 Chen Zhong <chen.zhong@mediatek.com>, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-rtc@vger.kernel.org
References: <20241226050205.30241-1-val@packett.cool>
 <20241226050205.30241-10-val@packett.cool>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241226050205.30241-10-val@packett.cool>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 26/12/24 05:58, Val Packett ha scritto:
> Add the dts to be included by all boards using the MT6392 PMIC.
> 
> Signed-off-by: Val Packett <val@packett.cool>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


