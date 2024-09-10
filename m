Return-Path: <linux-pm+bounces-13968-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 822B99741EE
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 20:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F093DB237F7
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 18:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38B61A0B1E;
	Tue, 10 Sep 2024 18:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="io0B/oab"
X-Original-To: linux-pm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1D9167DB7;
	Tue, 10 Sep 2024 18:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725992442; cv=none; b=Cb2KSNZmQ14uHPKfd5KqiKUjmlyceER14CigT+07Qr58/9jjpyW7l2Okmirf2c7GEfXCgN2VVAsPhI80U2i37dpKI5FwnD9j4OlTg0qS6RrtTqyspButLXY0Cu7skkxrpWF/w4ZDPz3GIEbxEqauKMa9TA0M97l5glqEFaC0pO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725992442; c=relaxed/simple;
	bh=aE47DC9nwl/98AItjTao91FIJOJr6lT0Tb7gm7bdihA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mD1zgr6wkOh8i4nxFQQMnw2EsjgFAVTxzCjO5ItCaSWxa2rdC4E11bSVMDZyd3JYuEL+0EipfKY/Hh37qY2+7E/+U2Z0cNSErKRT7C1pUzzl1xta7nSmp1BdVXwoQryG3S8i5+Lqsl87HATrENOf3w8gjObafVVL4bSfsPG9luo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=io0B/oab; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gqYeL+uQ8IfNvUhz5bkEnDyhpOy/MIoDCVXGyrUchP8=; b=io0B/oabjK/eKtPbO/ZPyAfsOz
	G1EtPG88uUIaHaM/tp3KON/XlE/fx9T1QloPsxey1KqLOM4TXZC4Qph4Shzoy2mq8en2xUR+zuFvV
	KOzWimEkrCSWruJT+014J7peEyMy8QX/d+iibnN4M48ffebW34aCdOU55y/AW+8ZAD8tsoraMTa+r
	Ws/VaGOiQTDxn/XVY4Z8exl1ohcxqplx35gIiy/JVUN5K1apDMFxYmlcsS6rT8A28YFZuLaWRu/96
	u7Vk09NpEGtq2j9owmXtMzodJSwb65z9Btx/upAOWfG4ntcT2RWdr8l7EHZohA8sV1RsIIFS74No+
	ttYjVC5g==;
Received: from i53875a02.versanet.de ([83.135.90.2] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1so5Te-0007Jy-92; Tue, 10 Sep 2024 20:20:34 +0200
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
 Re: [PATCH v1 2/6] pmdomain: rockchip: cleanup mutex handling in
 rockchip_pd_power
Date: Tue, 10 Sep 2024 20:23:02 +0200
Message-ID: <4864529.A9s0UXYOmP@diego>
In-Reply-To: <20240910180530.47194-3-sebastian.reichel@collabora.com>
References:
 <20240910180530.47194-1-sebastian.reichel@collabora.com>
 <20240910180530.47194-3-sebastian.reichel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Dienstag, 10. September 2024, 19:57:11 CEST schrieb Sebastian Reichel:
> Use the cleanup infrastructure to handle the mutex, which
> slightly improve code readability for this function.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

I guess you could make the guard patch the 1st to not add and then
remove the mutex_unlock in the "forward errors" patch.



