Return-Path: <linux-pm+bounces-36293-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B37EBE47ED
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 18:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 169F2583D74
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 16:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1027732D0F2;
	Thu, 16 Oct 2025 16:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="YO7nCjUg"
X-Original-To: linux-pm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4C732D0C6;
	Thu, 16 Oct 2025 16:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760631222; cv=none; b=CeWsThCIMk419KV7uQ1q/H437v/hD5OOO+pY5TpV9eCt/ttltsyECWhkPCf7hON8fNfpHj3ALP+e3givig0wYLwCf3bDzmJHev9ijMYVPY4xJ5PNaTspqCI3rEV4emmRJQNFzzDLuxTjRxhq7Bvw2nhlsbi3xT53ddpAWTVBXQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760631222; c=relaxed/simple;
	bh=euhE71GeA9z14C6UTDiq3F8p62BdmMC4iuWpvdEJH6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dJYzGj0+7dHCr87VOhS+N5cTQsPrNHY0g/hUl6DvzjHVKNGRIiFvXfY/R+l5pPCNOn3W6xNcpNZEhmmE7qCn+GXa1CGIJau81meZTULKRsKEAYh7UAe4YVg7l/pycQlgCPKOCmQmg5DZ1i8ifQdnqsPD5PTDUlsFOyoKFfPcfRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=YO7nCjUg; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=LzGjHDS+xi2DlOMgWkM/K6tjShNEfen6Tw2JtH1Zhpc=; b=YO7nCjUg0lOAZ06BrtQN/foq60
	FRtIzvKAyVc0aBUZyVXPR9TqlhFdGo8LvIxQRaqIhOqycd9p6SPR3a8/vwKfzYKtXQeO+vabIVSO0
	WdHaXqKIuitJJcZPsftdcGhW0VNlXBZ2vtJT7eL7dquQS6nwiQqzmOcK56gHaF0fAvY4RTgi+bu+/
	9SpIu41HlD1P3odwoVMBc9TDjO1QQS4FYfpvBvF7foTXoiCM26Vn69pGpLdVHYxpnvnydl9j6r/kF
	Z1CkI2SWYF1id0oUtmlSV2YVuG8/SA/inubLbfJUDQ0eNEkKV3edTuyjHxW9noahkCpP53opn6m+N
	LoXcGbQw==;
Received: from i53875b4f.versanet.de ([83.135.91.79] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1v9Qbf-0001Mr-58; Thu, 16 Oct 2025 18:13:35 +0200
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Finley Xiao <finley.xiao@rock-chips.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 ulf.hansson@linaro.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 finley.xiao@rock-chips.com, zhangqing@rock-chips.com,
 sugar.zhang@rock-chips.com, huangtao@rock-chips.com
Subject: Re: [PATCH v1 2/2] pmdomain: rockchip: Add support for RV1126B
Date: Thu, 16 Oct 2025 18:13:34 +0200
Message-ID: <2176528.bB369e8A3T@diego>
In-Reply-To: <20251016134103.294636-3-finley.xiao@rock-chips.com>
References:
 <20251016134103.294636-1-finley.xiao@rock-chips.com>
 <20251016134103.294636-3-finley.xiao@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Donnerstag, 16. Oktober 2025, 15:41:03 Mitteleurop=C3=A4ische Sommerzeit=
 schrieb Finley Xiao:
> Add configuration and power domains for RV1126 SoC.
>=20
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> ---

[...]

> @@ -1104,6 +1122,13 @@ static const struct rockchip_domain_info rv1126_pm=
_domains[] =3D {
>  	[RV1126_PD_USB]		=3D DOMAIN_RV1126("usb", BIT(9), BIT(15), BIT(15),  fa=
lse),
>  };
> =20
> +static const struct rockchip_domain_info rv1126b_pm_domains[] =3D {
> +					      /* name    pwr     req      wakeup */
> +	[RV1126B_PD_NPU]	=3D DOMAIN_RV1126B("npu",  BIT(0), BIT(8),  false),
> +	[RV1126B_PD_VDO]	=3D DOMAIN_RV1126B("vdo",  BIT(1), BIT(9),  false),
> +	[RV1126B_PD_AISP]	=3D DOMAIN_RV1126B("aisp", BIT(2), BIT(10), false),
> +};
> +

same clarification needed as for patch 1 ... is it aiisp (with 2 "i")?
As described everywhere in the TRM.

Other than that I checked the bits and registers against the TRM, so

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


Heiko



