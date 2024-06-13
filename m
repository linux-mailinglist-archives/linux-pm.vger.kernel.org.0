Return-Path: <linux-pm+bounces-9061-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA83290662B
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 10:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47D2E282A5C
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 08:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BEB13D24A;
	Thu, 13 Jun 2024 08:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="U3TIGdS3"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E25013C90B;
	Thu, 13 Jun 2024 08:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718266048; cv=none; b=A9ZWhb9i3DEZfy/q18ibGqF5W/rq91dbTeb78d/j9YjQuEHTLr8i8WdUv/huUibSLE0ung9XtDFm/cUDi9L0KSzQHGxWZrNplL6GVnS62b1V0N+OurAfw9uD6ZMEFnF2tNe2naAHSgaRfkV0NxBqBMSGIEX2YLCEIgm6bp4XaJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718266048; c=relaxed/simple;
	bh=Xc9hAyyCn4DkrOcITDwEYrgqPgKOnmKW53OP3Af64R4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=h7i6RqBHTvlCWW3MNd54V2UJNlmWND7awbclCpj0j7XbtoBJSJkFWWldNpFcM5/zMuSkR9AwGeeYCrOBBRlwHzTaTylOQRSeclHKO1yfkcB+yBIp/RpFkbeqPXraPszhqqZXR236tjXDUlDyRM44RgDjsfUMNHX/UwHfNewu4B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=U3TIGdS3; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718266045;
	bh=Xc9hAyyCn4DkrOcITDwEYrgqPgKOnmKW53OP3Af64R4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=U3TIGdS3aTXaE5mdWZxJ2vjJCsYGfA8WI7L9VP7KwnZjfaxDstz+sBPHScxluLXHj
	 j1oC7g6o8sNNO2ffV+OyPzkXwy9YpYVIHHVsfGNIXhfjssb++P19NpFi0o+p+rKBsJ
	 qsN3k2jOnKqOviAwccP9JgN74Zek20cO7uy7hdQKJ6QZ12pDBb+q+yQI6llMR4sZaU
	 BOCYU04EGoxcewshXGmNTm+sCZ70k5A6FYwGoGeU+HU31I4qkch8KLLGN5Maaslwpz
	 fPmFDdGVXs74Fjb2Es6PnRyTPeXyEaTprx2msbc4ouUnNiYZYGnl5tpEvkhPUCy7cb
	 yIE7gathAmQMg==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2E589378107C;
	Thu, 13 Jun 2024 08:07:24 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Nicolas Pitre <npitre@baylibre.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Julien Panis <jpanis@baylibre.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, 
 Conor Dooley <conor.dooley@microchip.com>
In-Reply-To: <20240603-mtk-thermal-mt818x-dtsi-v7-0-8c8e3c7a3643@baylibre.com>
References: <20240603-mtk-thermal-mt818x-dtsi-v7-0-8c8e3c7a3643@baylibre.com>
Subject: Re: (subset) [PATCH v7 0/6] Mediatek thermal sensor driver support
 for MT8186 and MT8188
Message-Id: <171826604410.51825.14935271158174620262.b4-ty@collabora.com>
Date: Thu, 13 Jun 2024 10:07:24 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Mon, 03 Jun 2024 12:50:47 +0200, Julien Panis wrote:
> This is a bunch of patches to support the MT8186 and MT8188 thermal
> sensor configurations.
> 
> Since the patches of v3 were applied except those related to the SoC
> device trees, this series includes mainly patches for 'mt8186.dtsi'
> and 'mt8188.dtsi'. Due to some thermal zone renaming in these 2 device
> trees, the related definitions were also renamed in the dt-bindings and
> in the driver.
> 
> [...]

Applied to v6.10-next/dts64, thanks!

[3/6] arm64: dts: mediatek: mt8186: add lvts definitions
      commit: 0c598e50e6c823c1057ddad17c546e368a415d6a
[4/6] arm64: dts: mediatek: mt8186: add default thermal zones
      commit: d7c1bde38bf37a59551cfd52cfdb5bd974b17431
[5/6] arm64: dts: mediatek: mt8188: add lvts definitions
      commit: 7e3e18f2ed40ea9018590b4533fa148954a725bc
[6/6] arm64: dts: mediatek: mt8188: add default thermal zones
      commit: 2f950510411a33d98eea28c22d7880eeb48adb61

Cheers,
Angelo



