Return-Path: <linux-pm+bounces-13967-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C71009741E5
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 20:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03A801C25585
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 18:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3AD31A38F9;
	Tue, 10 Sep 2024 18:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="VajOz9ri"
X-Original-To: linux-pm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E7119FA93;
	Tue, 10 Sep 2024 18:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725992361; cv=none; b=VRgi+GjZmUX1GqfluS+Dh4OpUOYlmR3LpPlNAuHsIF3otx0Hk6swbwUOQ5ajl87873oll3Oh7XleOdTRysa9kEcZIDGLiP6k77wNoH8G6Sl0wFog3uE3B0wQfAypMocYBo/JYV9Ejqmd4XUuOsq14CbPTzusTpE09f6EyjfLGNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725992361; c=relaxed/simple;
	bh=0XNRgHlRh33jgSKTjnC9hP7ja6J8WlVCPnTjoKAAMEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PwM5H7WK8TAoK/5d7X4SR74FKLERDYO9ZjpyoioTWKirKJe0SLUZDjHb/i6fk5xsgjHjc3OlR2zognjofF7MP0F6r67i42c2ttHMNxz+BL987pnHPPb6ycVoqidWPyIM1+epAkM/ZACLEdAMXpbmzQ7fiYHWoT5/cYlXRvAhl4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=VajOz9ri; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XzlU8P8QZFu0BOwrWasNz2nIoiPFhgq1B8KDiec2fJQ=; b=VajOz9ri3kbGwukRMWUsfs9mFA
	SIo+WBOTiiOl9pUr+PeXDH0XkQ66A/H3hEovxgjFfvWC743jlS1VIVXhlcgE36BlhTbEQDS9dWO6z
	U+dzKR28KrLHqYkRdH0z0rvRWWqPhQfrD5BsT9mVEpPXJ2tj9amTi8pYrZBTXmI9D7KAQXydAWU08
	4+uZJrvN0DXoGUB+0ceCOEEYyyegluOjlGplApmTwYP8p/NmZvo61lPjuDj1DM2PWGJ7hS4x6RIYO
	ufFcqYbIp9xNjhIOmaP3+TzpJMxmGwV/sllsO78GngDiFlcYDY+uIDHfyfU8RdwklNIidMm8m6SWj
	uhDWB6ZQ==;
Received: from i53875a02.versanet.de ([83.135.90.2] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1so5SE-0007Ih-Ch; Tue, 10 Sep 2024 20:19:06 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Elaine Zhang <zhangqing@rock-chips.com>,
 =?ISO-8859-1?Q?Adri=E1n_Mart=EDnez?= Larumbe <adrian.larumbe@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>, kernel@collabora.com
Subject:
 Re: [PATCH v1 1/6] pmdomain: rockchip: forward
 rockchip_do_pmu_set_power_domain errors
Date: Tue, 10 Sep 2024 20:21:34 +0200
Message-ID: <4131747.ReJHH8Nr61@diego>
In-Reply-To: <20240910180530.47194-2-sebastian.reichel@collabora.com>
References:
 <20240910180530.47194-1-sebastian.reichel@collabora.com>
 <20240910180530.47194-2-sebastian.reichel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Dienstag, 10. September 2024, 19:57:10 CEST schrieb Sebastian Reichel:
> Currently rockchip_do_pmu_set_power_domain prints a warning if there
> have been errors turning on the power domain, but it does not return
> any errors and rockchip_pd_power() tries to continue setting up the
> QOS registers. This usually results in accessing unpowered registers,
> which triggers an SError and a full system hang.
> 
> This improves the error handling by forwarding the error to avoid
> kernel panics.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

more error handling is always better :-)

Reviewed-by: Heiko Stuebner <heiko@sntech.de>



