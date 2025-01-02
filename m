Return-Path: <linux-pm+bounces-19883-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9A79FF7EE
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2025 11:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8906D16254C
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2025 10:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5751A9B42;
	Thu,  2 Jan 2025 10:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FdBsD+9P"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F29C190485;
	Thu,  2 Jan 2025 10:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735813568; cv=none; b=bqQzfxHr886VJ6kpI4ZONV36uqeJvGqaJzm2pfKTYa7vixodOA+B0oNn8aqTNWqy1DgPRVi+kfkUM4qrPg0wrZvEOftoQPXFUc3IRqoZmkBTeym+h8MirZmoVPYFXvUmKlU2PCz0yApG21gk24viVqgGCRxwGMHaumbEsRyy+8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735813568; c=relaxed/simple;
	bh=3GT0ivpU3yT9AFjZTEHywkw0fqTG8Qo34fH2ZWvQSrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n3B8JDXfyyrKFXYFNpLalMHDUnrRJpKPPJclyO9yxBcOwR9uw8TOpGEGSsBVmpnUnQKwkMBXdj1a+duJB78Wj3AvGT00Wcw9Vfr3xXLqBYOkfuNcOu0ueI2/1C2Zf66plhDmfmMxMTq8Vt5sH/cK2u9876gCTvnhWNpie2nrL2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FdBsD+9P; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1735813564;
	bh=3GT0ivpU3yT9AFjZTEHywkw0fqTG8Qo34fH2ZWvQSrE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FdBsD+9P380hWkNn9bHXbcDSUudBTfYl1d1kX+tSRZpea+eqZiieF9N6pYkDqhmek
	 2J343vp5xN+VyV72GslwlXzLbUAORXEF+XYf61+JrbIiPTT7rtb9iTE2HiW/01m8+x
	 +LloVK0m9x6TdXOy0hYEnuVwjersrzRAk9hXwBa5Mkar/cP+FglQq8t3fJNHK3LUFf
	 IuxpklkXQvkxoEHyij8MFPg5eHIRnhSYGtFhvlfxEYliu1mEv5t0GriA3z8Iz4gctp
	 btj6Hot9wx7BHDpaGyKBhWEt7PHCtFt4C/eyjqcQ0f8px2Oc4Ia1RxYAuoeHT7QK7I
	 iGSNOnhfLDL3g==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 33D5317E1554;
	Thu,  2 Jan 2025 11:26:03 +0100 (CET)
Message-ID: <61df483d-76ae-4974-8410-4888d89a5f3f@collabora.com>
Date: Thu, 2 Jan 2025 11:25:58 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] dt-bindings: regulator: add support for MT6392
To: Val Packett <val@packett.cool>
Cc: Fabien Parent <parent.f@gmail.com>, Rob Herring <robh@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
 Lee Jones <lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Eddie Huang <eddie.huang@mediatek.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Yassine Oudjana <y.oudjana@protonmail.com>,
 Chen Zhong <chen.zhong@mediatek.com>, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-rtc@vger.kernel.org
References: <20241226050205.30241-1-val@packett.cool>
 <20241226050205.30241-3-val@packett.cool>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241226050205.30241-3-val@packett.cool>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 26/12/24 05:58, Val Packett ha scritto:
> From: Fabien Parent <parent.f@gmail.com>
> 
> Add binding documentation of the regulator for MT6392 SoCs.
> 
> Signed-off-by: Fabien Parent <parent.f@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



