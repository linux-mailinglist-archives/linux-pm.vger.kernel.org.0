Return-Path: <linux-pm+bounces-21779-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2267EA3048E
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 08:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F454166677
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 07:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410491EC016;
	Tue, 11 Feb 2025 07:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="1NDE5ocL"
X-Original-To: linux-pm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198CD1EBA1C;
	Tue, 11 Feb 2025 07:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739259320; cv=none; b=TbDMEkLeQqVl4uUQjmdnsRFjClyY5Z4qwfNtDoguWhBqTrCdt6TSesZ2bLhyQwdI1hofHYnk0jMe0MyFKKSOn+qx2T6TX/5C898H57lObH2QIjz+5D//XkJdtq1vDc//hOdQcg+ClsXuJHoPrGimG1j/qFvf2BrshnhF3G2Q7ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739259320; c=relaxed/simple;
	bh=UB6ByV9tZuql2thPJLeIhe3GFPQGh90kQFoON4qumIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AG88GfEW+WpA5Cs7KQQ9o+E2IHPdPLRmQ8eM/JprLq6QQUYhzCgYhwwPS3RA4EMGKg2fflDbStf5A67V+83bmBR0VzaIzQiq40EREw2JAvT8zpMLkaEkzAD5FwaOuEprJvPyyzXF5IV/Y4SSNadGsox/aF/+CdfLkSt7J+9cIqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=1NDE5ocL; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=d4N+Vq1mmXR208oNNBf7yHJutNb21W6I422ugkccxyA=; b=1NDE5ocL6knHGG6yjZDhUjrUm0
	QN4Y684vOahSwZqaJ8faSSNtbVzIqnJ7hjqxWc08plNKdHir5yNrSOMpy0Yi6KQC05L3nIlpsD2La
	AfJKrZQV8OKTrU/L1Eh5kF6Jo2K+c59C/GIwqaEWkXeqXR7SVgtE9U4bxEcFptLaEbICEtdwPv4vs
	GYWznnC1bpVIKcMRChdvWzEgF/p65ht5oYgfwhywkXAVZuWkV4t5+QTu+mpM/h1RZi2GqR6crHxwj
	h7J6PKw8fy2qMk7cqMb7EKHix7YxyNXRjxMRfo7kUeSDpfhwrBvsgLF2Pif9C+kWeJtghzlltQ5+a
	7MZhhaAw==;
Received: from i53875bc0.versanet.de ([83.135.91.192] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1thknO-0004nK-Qm; Tue, 11 Feb 2025 08:35:02 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Rob Herring <robh+dt@kernel.org>,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Shawn Lin <shawn.lin@rock-chips.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>,
 Bart Van Assche <bvanassche@acm.org>, YiFeng Zhao <zyf@rock-chips.com>,
 Liang Chen <cl@rock-chips.com>, linux-scsi@vger.kernel.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-pm@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
Subject:
 Re: [PATCH v7 2/7] soc: rockchip: add header for suspend mode SIP interface
Date: Tue, 11 Feb 2025 08:35:01 +0100
Message-ID: <5762938.0VBMTVartN@diego>
In-Reply-To: <1738736156-119203-3-git-send-email-shawn.lin@rock-chips.com>
References:
 <1738736156-119203-1-git-send-email-shawn.lin@rock-chips.com>
 <1738736156-119203-3-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Am Mittwoch, 5. Februar 2025, 07:15:51 MEZ schrieb Shawn Lin:
> Add ROCKCHIP_SIP_SUSPEND_MODE to pass down parameters to Trusted Firmware
> in order to decide suspend mode. Currently only add ROCKCHIP_SLEEP_PD_CONFIG
> which teaches firmware to power down controllers or not.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Acked-by: Heiko Stuebner <heiko@sntech.de>

> ---
> 
> Changes in v7: None
> Changes in v6: None
> Changes in v5: None
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> 
>  include/soc/rockchip/rockchip_sip.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/soc/rockchip/rockchip_sip.h b/include/soc/rockchip/rockchip_sip.h
> index c46a9ae..501ad1f 100644
> --- a/include/soc/rockchip/rockchip_sip.h
> +++ b/include/soc/rockchip/rockchip_sip.h
> @@ -6,6 +6,9 @@
>  #ifndef __SOC_ROCKCHIP_SIP_H
>  #define __SOC_ROCKCHIP_SIP_H
>  
> +#define ROCKCHIP_SIP_SUSPEND_MODE		0x82000003
> +#define ROCKCHIP_SLEEP_PD_CONFIG		0xff
> +
>  #define ROCKCHIP_SIP_DRAM_FREQ			0x82000008
>  #define ROCKCHIP_SIP_CONFIG_DRAM_INIT		0x00
>  #define ROCKCHIP_SIP_CONFIG_DRAM_SET_RATE	0x01
> 





