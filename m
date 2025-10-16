Return-Path: <linux-pm+bounces-36292-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D43EABE4787
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 18:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20417580248
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 16:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DD232D0FB;
	Thu, 16 Oct 2025 16:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="oH1YeVeS"
X-Original-To: linux-pm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8785032D0E0;
	Thu, 16 Oct 2025 16:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760630808; cv=none; b=ifaKewpQ/egx9Mk8flb8lT4D7z82Tib/s9FqhtxuQj/y4eOtzI9pNFNJG8DV1KlXLXHEKpANKoaRJL4P6IhIxth0uqU20YPjKnUfAo8nEfumk9zbfmqr6Vl8/n9Noe8tBBV/iZeKSB2FoW1I8RsGA7jgcjHWNDDxnBSx9NvcvoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760630808; c=relaxed/simple;
	bh=VzM0BUUEPaZbFvHsmThY6Jte8zQ3NSP1NJZztDChTy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rHui7dDvlwczGVVbh4GKtwPs0GRdMsmCN+mX6B424ewHniswF/7N5hrvyhWPobB6EhhLuN8a04u5GLRZA8PtbEDufuGTbGmmNK1oEeQ5qSW44FEHrzTyheJsw1G8Mw0Wzn2W5gbzOe7bt3SnJTauqeHKmsB0JtGDNeJMPO7W3JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=oH1YeVeS; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=0UZ7TBAFRv9QMlrqmMJIgxKTa7jBW8b6E1/jAgXuGlo=; b=oH1YeVeSPwxjgB8BReleokluBW
	L/YnmwycCEwtNdpHcaBTwVY3Tm9/XPKUrNPDFuG3WIrNi/M4Uuw+n0u2lbe46vaUffCTxRLOXma0I
	5NXXmX3pmYQz5/iJG1ydP6SMjzlcVAVBA+padkoun6JAu0J18FI51rgrDutbd2RsxuKoMGVK476nw
	pOm9ONwUz6l3KAwHZpkS7sNnH0hT7hwhRkVwVR3qi6uPB/f254hK9NIpR5Cr1fhXoxx0XUE52HcPj
	FMAdlGqWvmyCNl1BJ1kGJqHrJsMniM79TuJSp8QIWXdUSCXU13/bRTGViV2aggt03Npm8pEIYIPcj
	q4CY1Emg==;
Received: from i53875b4f.versanet.de ([83.135.91.79] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1v9QUt-0001JG-IO; Thu, 16 Oct 2025 18:06:35 +0200
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Finley Xiao <finley.xiao@rock-chips.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 ulf.hansson@linaro.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 finley.xiao@rock-chips.com, zhangqing@rock-chips.com,
 sugar.zhang@rock-chips.com, huangtao@rock-chips.com
Subject:
 Re: [PATCH v1 1/2] dt-bindings: power: rockchip: Add support for RV1126B
Date: Thu, 16 Oct 2025 18:06:34 +0200
Message-ID: <24800526.ouqheUzb2q@diego>
In-Reply-To: <20251016134103.294636-2-finley.xiao@rock-chips.com>
References:
 <20251016134103.294636-1-finley.xiao@rock-chips.com>
 <20251016134103.294636-2-finley.xiao@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi Finley,

Am Donnerstag, 16. Oktober 2025, 15:41:02 Mitteleurop=C3=A4ische Sommerzeit=
 schrieb Finley Xiao:
> Add the compatible string and power domain IDs for RV1126B SoC.
>=20
> signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> ---

[...]

> diff --git a/include/dt-bindings/power/rockchip,rv1126b-power.h b/include=
/dt-bindings/power/rockchip,rv1126b-power.h
> new file mode 100644
> index 000000000000..0a418f16e4ea
> --- /dev/null
> +++ b/include/dt-bindings/power/rockchip,rv1126b-power.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> +/*
> + * Copyright (c) 2024 Rockchip Electronics Co., Ltd.
> + * Author: Finley Xiao <finley.xiao@rock-chips.com>
> + */
> +
> +#ifndef __DT_BINDINGS_POWER_RV1126B_POWER_H__
> +#define __DT_BINDINGS_POWER_RV1126B_POWER_H__
> +
> +/* VD_NPU */
> +#define RV1126B_PD_NPU		0
> +
> +/* VD_LOGIC */
> +#define RV1126B_PD_VDO		1
> +#define RV1126B_PD_AISP		2

is this missing a 2nd "i" ? ... The TRM calls this aiisp (for ai-isp maybe?)

Heiko



