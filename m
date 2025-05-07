Return-Path: <linux-pm+bounces-26835-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6E1AAEC1D
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 21:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 665831B65E4B
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 19:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E5728E563;
	Wed,  7 May 2025 19:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DJum2erF"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB001714B3;
	Wed,  7 May 2025 19:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746645771; cv=none; b=ds/gq/N5T4XSN3WdvqxkUMDiAvY7eIg6hZsivQhQuPd7bN9ITOwUG+y+CZeXN2sYZ4TqraYn+6r7QfYyntprfvieAfjlJ0+1n0pYnNcLpyZLckED8wvQc7fu9iVKA6Lu/ZsZtgG/tChGLdSr+bKIjdqCoPvZBZ9hw9OhpYaJ+pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746645771; c=relaxed/simple;
	bh=GHSW4wUcpOnEic7k+DsKOTurTrfizcPlOAPqQKlmSxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4LJEZByYhTSNiPgPshoMXaKLEP9T1s0MXmpSm8/mB3bgu2H2irF2vNRMOwhXjUTYDUB2iTmMxmE41Esd/D3WqZZ2IhSJu2ifEsIhJsR70WJOuhaGYvF11yWGLMMPg0rm794nHAHcXqyBB2nDdOphJa2EVEKURVnnK4FqIerjPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DJum2erF; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1746645767;
	bh=GHSW4wUcpOnEic7k+DsKOTurTrfizcPlOAPqQKlmSxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DJum2erF0U6Oe3JU03iuTHFSIhY6ng6wCMy0Mr9OR02DXfh6sR7teIeAzjz8skiz7
	 Hx8XeaOeFZGUBreY6dHMUMT23eP4TuamLtCc7Oi44RjECYYEKqYHNx9mI4TVmjEHhZ
	 m340VuRQezMVuaH/dQA652+UkGp5NwAyjQIOoqkWvG6qGY0NT23B9aupLILsYjfaD7
	 w4r81iugdj7GRaSF8pB0zCImSDP1lA4n/YNgF81y4BrnZua72f1R9Ad6CBhVHpCifo
	 zPSQri20rT87KaRg8vwC2aKb531baL1ShC4h4i0Jh/xIRaZiP0Zjk5SLbZ874xfnoK
	 8GGgMU/pLCsyA==
Received: from notapiano (unknown [70.107.117.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C48CA17E0147;
	Wed,  7 May 2025 21:22:42 +0200 (CEST)
Date: Wed, 7 May 2025 15:22:40 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Julien Massot <julien.massot@collabora.com>
Cc: kernel@collabora.com, Sen Chu <sen.chu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
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
Subject: Re: [PATCH 1/4] dt-bindings: mfd: mediatek: mt6397: Add
 #sound-dai-cells property
Message-ID: <34399fb1-f876-4c7e-b164-4331defd4426@notapiano>
References: <20250505-mt8395-dtb-errors-v1-0-9c4714dcdcdb@collabora.com>
 <20250505-mt8395-dtb-errors-v1-1-9c4714dcdcdb@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250505-mt8395-dtb-errors-v1-1-9c4714dcdcdb@collabora.com>

On Mon, May 05, 2025 at 03:23:37PM +0200, Julien Massot wrote:
> The 'mt6359.dtsi' file already uses the '#sound-dai-cells' property.
> Add the corresponding property to the binding to fix the following
> dtb-check error:
> 
> mediatek/mt8395-radxa-nio-12l.dtb: pmic: '#sound-dai-cells', 'mt6359rtc' do not match any of the regexes: 'pinctrl-[0-9]+'
> from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
> 
> Fixes: 9bc8353be720 ("arm64: dts: mt6359: Add #sound-dai-cells property")
> Signed-off-by: Julien Massot <julien.massot@collabora.com>

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas

