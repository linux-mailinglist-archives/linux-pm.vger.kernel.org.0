Return-Path: <linux-pm+bounces-27814-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 959DFAC8089
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 17:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 599B04E3A24
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 15:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DDD22D790;
	Thu, 29 May 2025 15:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JEVtj9sJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BB222CBF1;
	Thu, 29 May 2025 15:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748534014; cv=none; b=qxk2rf9uWNdeXSca1i/e8sfJnl6xlAbVrHRxoAN0l+Hqz1QtxP+KnW3DlZQR1Q7CzxzIsf18a3n4RuEM75KLkTqHe/kzylDLjOi4m6QnAgo6yApurTwTmieuExSHgm9BTe6hfsqSoI6gvQbaKLCCgYodhoDro+tegyZtv4eIA0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748534014; c=relaxed/simple;
	bh=gpaKs8nDRKUL3IKkyljnJJf6SvliLquwp0sCaRjiIX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZvIKns1llxYrCvX3/0gXOCJUsx5x4Wi/OqiGRKnqxR/Nw4M64o8RQji29VihUcxXPBqUknu4/6dkI+mhtDah/R9bVxrDQ+FEFxumKM7vF2ZFNwBkIiDvMcQUmWhXmO2/gHiHQwbXXhSjZ5f/8ZB58ViKqM5GwoZge9vMvT+vnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JEVtj9sJ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1748534005;
	bh=gpaKs8nDRKUL3IKkyljnJJf6SvliLquwp0sCaRjiIX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JEVtj9sJaIntHKm0eT3W+hHGiFjw4FjMyaLlOju9jajYO4VeHMdi2Tjvg/lCgGXah
	 UThWegoLWpeqmmvUYgaj0+4ZpiajwGziCtU+Ufppe166JLv128Ol8yj7norkXV0sDk
	 nobDXMcUJhUvU/kecHYToukrJE2sjv4kggAYDA6Xy8HEVNXN3w6+URJMKtBmdLlwb4
	 HtIz+vFgWt0xRC+Dw6OT6jQEBSZIVE/e64UNVroO1fRgEPfRkKJwpf7BLZwwxTsreN
	 L2UUPx7hUJH+ewUXx/xNMA8S9hG5dkdeoovbhMVIG3Wab/34v4kMmWNoTsZYWe5Y/O
	 hUHvBhg40+MIQ==
Received: from notapiano (unknown [IPv6:2600:4041:5b1a:9400:99d:464c:62e0:2118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 03B0B17E0415;
	Thu, 29 May 2025 17:53:20 +0200 (CEST)
Date: Thu, 29 May 2025 11:53:08 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Julien Massot <julien.massot@collabora.com>, kernel@collabora.com,
	Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Hui Liu <hui.liu@mediatek.com>, Yong Wu <yong.wu@mediatek.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Tinghan Shen <tinghan.shen@mediatek.com>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, iommu@lists.linux.dev
Subject: Re: [PATCH v2 1/3] dt-bindings: mfd: mediatek: mt6397: Add
 #sound-dai-cells property
Message-ID: <cee1e8bc-f4b0-49b9-a67b-2f54382c3d8e@notapiano>
References: <20250514-mt8395-dtb-errors-v2-0-d67b9077c59a@collabora.com>
 <20250514-mt8395-dtb-errors-v2-1-d67b9077c59a@collabora.com>
 <20250522-independent-ginger-bullfrog-4552d1@kuoka>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250522-independent-ginger-bullfrog-4552d1@kuoka>

On Thu, May 22, 2025 at 09:52:07AM +0200, Krzysztof Kozlowski wrote:
> On Wed, May 14, 2025 at 10:19:56AM GMT, Julien Massot wrote:
> > The 'mt6359.dtsi' file already uses the '#sound-dai-cells' property.
> > Add the corresponding property to the binding to fix the following
> > dtb-check error:
> > 
> > mediatek/mt8395-radxa-nio-12l.dtb: pmic: '#sound-dai-cells', 'mt6359rtc' do not match any of the regexes: 'pinctrl-[0-9]+'
> > from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
> 
> If this is a random drive-by, would be fine, but if that's your platform
> which you should know, then I expect this to be a real reason instead
> something which can easily be rejected with: what if DTS is wrong?
> 
> I could not find the ASoC driver for that compatible and quick glance to
> MFD shown me no usage of dai cells, so you need proper explanation here.
> 
> Especially, that there is a subnode audio-codec, so adding dai cells to
> the parent node feels just wrong. One is wrong - either subnode or
> parent is a codec.

The driver is sound/soc/codecs/mt6359.c, which defines 2 DAIs. It's currently
probed by the MFD through the driver name, hence the parent MFD device is the
one used to register the audio component.

The right fix would probably be to add the compatible both to the ASoC and the
MFD drivers, and then move the dai-cells to the sound subnode in DT.

Thanks,
Nícolas

