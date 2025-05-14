Return-Path: <linux-pm+bounces-27120-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F65AB655C
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 10:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21E2B4A5EB8
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 08:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E6221B9C2;
	Wed, 14 May 2025 08:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Q3ohjz62"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEC921ADC3;
	Wed, 14 May 2025 08:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747210283; cv=none; b=kzNUV+vwy0xoXiZwd/tnYZZavv5NER5B0iXyO7uAwDoZKOhS+bZHrVSecDn2baRrxLRSwcQoa5sMLLv268nIuzp3xckIHPi33yBTyfgGLNISM6l/Ii7iaD1RNAM3AihWjzm88RtjQLRyIK6xrSW2B+cXRBXhPPytb9G2DASjZc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747210283; c=relaxed/simple;
	bh=crecp3yT2SZLjBUhnRURx5oUzcLwjGoGZoCGTxx3isA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z/T9YBr2oS7VHmxqCuSXB3giFphDxOYB/yWsst8MXNMYBmnUMr4Y9wmGek3s/FxCbv2OgYpiIAPeT2ioRrF4dusrqDV/covF6Ps+x4g7kBD8FLkN7dYwp6nmmUbAnkOcseZ17at5Ct+bHDcBiT3whNiqqwbwoK8L4c0vZwjDnPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Q3ohjz62; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1747210279;
	bh=crecp3yT2SZLjBUhnRURx5oUzcLwjGoGZoCGTxx3isA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Q3ohjz62grUXQrGlMZmV14eAlrlnVDazHA+kNoz2opWnap5zMJoUYEri+JOLeIYO8
	 1l0nsxPkr994hI4PSEzVqba64Tny61FlFN9GYmwZXDIcEbJytJe8wMjSSDJ6/m/a/F
	 KBEHwPY/ovWtKaIUnBWPpxBf/47bWFJxiX5BXB7JRTdOCtT+uhs7MM4GbkO2lCH5pG
	 PBscEESi+ceSpfJQemzEQlTpCgHHNKqqPKaVScAqm/LfvZUAhTKNozXL/ciOywe1EI
	 78hMJbuWrXrtrJ0e9n96xwF/euvGBiCyWFaZ8JJxOz/FZg0UxTUK2ZKwa1EX6tA9ws
	 bazKi7SoCGEnA==
Received: from apertis-1.home (2a01cb0892F2D600c8f85CF092D4Af51.ipv6.abo.wanadoo.fr [IPv6:2a01:cb08:92f2:d600:c8f8:5cf0:92d4:af51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmassot)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id EC67D17E07F2;
	Wed, 14 May 2025 10:11:17 +0200 (CEST)
Message-ID: <5578490565f6d37fa435ca0c02fcfc2cb685baf8.camel@collabora.com>
Subject: Re: [PATCH 1/4] dt-bindings: mfd: mediatek: mt6397: Add
 #sound-dai-cells property
From: Julien Massot <julien.massot@collabora.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, kernel@collabora.com, Sen Chu	
 <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, Macpaul Lin	
 <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, Rob Herring	
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 =?ISO-8859-1?Q?N=EDcolas?= "F. R. A. Prado"	 <nfraprado@collabora.com>, Hui
 Liu <hui.liu@mediatek.com>, Yong Wu	 <yong.wu@mediatek.com>, Joerg Roedel
 <joro@8bytes.org>, Will Deacon	 <will@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>, Tinghan Shen	 <tinghan.shen@mediatek.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, iommu@lists.linux.dev
Date: Wed, 14 May 2025 10:11:17 +0200
In-Reply-To: <79148223-d87f-486e-9d51-979f9188a837@kernel.org>
References: <20250505-mt8395-dtb-errors-v1-0-9c4714dcdcdb@collabora.com>
	 <20250505-mt8395-dtb-errors-v1-1-9c4714dcdcdb@collabora.com>
	 <79148223-d87f-486e-9d51-979f9188a837@kernel.org>
Organization: Collabora Ltd.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Krzysztof,

On Thu, 2025-05-08 at 08:01 +0200, Krzysztof Kozlowski wrote:
> On 05/05/2025 15:23, Julien Massot wrote:
> > The 'mt6359.dtsi' file already uses the '#sound-dai-cells' property.
> > Add the corresponding property to the binding to fix the following
> > dtb-check error:
> If this is a DAI, then you miss dai-common reference. If not, you need
> to explain it in commit msg.

Thanks for the review, I will add the missing dai-common reference in the v=
2.

Regards,
Julien

