Return-Path: <linux-pm+bounces-23075-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 645A7A47EE9
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 14:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DC4117179E
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 13:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED0422F3BC;
	Thu, 27 Feb 2025 13:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="dqRuIPdT"
X-Original-To: linux-pm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF26E22F14C;
	Thu, 27 Feb 2025 13:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740662398; cv=none; b=Ask1f+++OFddO9mDqXyUHej6xnw+qL+ryoTF4uBKNScyd/VzFVAsGi9eyaFXiU7PSK/gB3Qlc96EErDyku9tDR97BWm/gvdxoPO+zRbGI9FNjL2IRFNCa/AaIziFxPvQg1zZIHg3pDUzXcdmowfjSNnVB7vgNJKn3LjDdkCrJl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740662398; c=relaxed/simple;
	bh=TmCMnpDNgMhA3ZQ889K7ggkmSq3nkn4tvhTRXXQhm9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hyZt20CGK7VTmtdTwO6HRulsDBntsYivfrXtbDOTzS0YI6QKvHVSOl+OKRrLCWuKctOtsH9rg8cOcv6VqK2zXwjtzhequnQT0X+yz4fy7uUb3vNRv6j4biX9nNvM83MRoGuc6GccUCYFxcmD46R+b0/tlWoNjIwLoivKUmj6KiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=dqRuIPdT; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zjjw7JOmUhRXjBZyb6Bvgigsi+ztWFQm+GvGLe901ak=; b=dqRuIPdTeFWHjBfK0767I0MAYe
	MnycsZx+FzO1ncp3G+LLW036SoUDmnB6W/akxuV799LCV6ebS/e9HZOfkojIYzMwCILQ4snttzf7F
	yhf5+lVHoai+a8ZhIM7vNZjKkrsxotZ1qLDyPL1e8m7RnWtFjgzIEbz2+n+FG1ZDmLkWBZjiL+pBV
	1vLDS3SA7dYUDtcuufbZpd5FuGK6dem7xBqPWskOXFPVDMoMrCJvbPwIKQYKd8tc91tj2VDO2l09W
	mt2zQcVIofdfrNdp88A0nxbmY6RxP0WP8IaJwlI3tnOfL28ZNMD82slWLu/tpOE1vDrJgJ+RH5/BW
	Wvhsq7Yg==;
Received: from i53875b47.versanet.de ([83.135.91.71] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tndnp-00013Q-Rf; Thu, 27 Feb 2025 14:19:49 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: linux-rockchip@lists.infradead.org,
 Kever Yang <kever.yang@rock-chips.com>,
 Finley Xiao <finley.xiao@rock-chips.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-pm@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Detlev Casanova <detlev.casanova@collabora.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Ulf Hansson <ulf.hansson@linaro.org>
Subject:
 Re: [PATCH v3 2/2] soc: rockchip: power-domain: add power domain support for
 rk3562
Date: Thu, 27 Feb 2025 14:19:49 +0100
Message-ID: <2307779.KTMopqUuYO@diego>
In-Reply-To: <20250227105957.2341107-3-kever.yang@rock-chips.com>
References:
 <20250227105957.2341107-1-kever.yang@rock-chips.com>
 <20250227105957.2341107-3-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Am Donnerstag, 27. Februar 2025, 11:59:57 MEZ schrieb Kever Yang:
> This driver is modified to support RK3562 SoC.
> Add support to ungate clk.
> Add support to shut down memory for rk3562.
> 
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>

forgot one thing, patch author doesn't match.

You have a first Signed-off-by from Finley, so the patch author
should be the same - similar to how the binding patch already is?


Heiko



