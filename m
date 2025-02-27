Return-Path: <linux-pm+bounces-23074-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6801A47EE1
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 14:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79591164D8D
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 13:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7BD22DFAE;
	Thu, 27 Feb 2025 13:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="I/ckulVE"
X-Original-To: linux-pm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9A522171A;
	Thu, 27 Feb 2025 13:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740662319; cv=none; b=KxqkVxsh5g7KEajy6xJxebRO8dnLLI3xR4cEYeoNgjBswaDvJCN6th4bMUSk/kl3p8BIpN77O6KGKXXvYxyEJjVQxj9czHaDqJ6EJ0zVuU+uCUoWKnd4kqult4ZmbSja7jb9quftUdGVDRF7b9dyRAxiNxw8uO3WY5rb2von3sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740662319; c=relaxed/simple;
	bh=mNzyP2i8s5xxojWRGpta1D3Ukh8tpM3eSID4p4vReCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qZh1BLAAks4RIzQhdvncuolk5OI5Nd5ewCzKQ4c2ecFKb09xLhqRHiEBK3khMbUNtrw3YRGAJ6VHkvKfk/uFwnc2SoMdctMSwvRaI+RgXtvs/OqEwVlZZt+sE80XylAie7vCmDP5Be8f6BEO3wglBco7/dCIsrJ9Uzt60piNFLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=I/ckulVE; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=odRe86wbBsQkcjq+MlDDcHZ1ydHEZEkP/u4cZxHpKl8=; b=I/ckulVENplgJLCSPkpinMhiHF
	cya+hcSVQSocal22jUocKva6Y3YPPggHj7N8rUMd6sxpwPiQysYVQV4QX9YftUu9UwxqVX/+7yCNZ
	h9Ey4lCbqJOfcVi1d/L6Pz4jKJBTnQ3j7pGN7HDT5e3kB8wsPqwtK9JJdCGkNYuUr1xY2MUBAPW6A
	zmsr6Qh1i6iT1iog0K00WDYJmA8LtkJdEEG4a25Mt0yFwo0Z/F+GnNl/7AmJK6pv0ZpQR9xKNHOPn
	Hd8DfmcCmhPB7AXbHCsRyIy1gyD5m/K2nFDz9iR9mIHev3WHc/CBz9/jxvbpPvAu6h1EkEvFCI9Jj
	v1KAeXGg==;
Received: from i53875b47.versanet.de ([83.135.91.71] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tndmV-00012t-UU; Thu, 27 Feb 2025 14:18:27 +0100
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
Date: Thu, 27 Feb 2025 14:18:27 +0100
Message-ID: <3210955.TQGk6oTFT5@diego>
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

After the move to the pmdomains subsystem patch subject should be
	pmdomain: rockchip: add power domain support for rk3562

with that change
Reviewed-by: Heiko Stuebner <heiko@sntech.de>



