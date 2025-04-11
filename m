Return-Path: <linux-pm+bounces-25210-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E65E6A856EC
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 10:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B79BC7A98C4
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 08:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767402989B5;
	Fri, 11 Apr 2025 08:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RBG1LnDS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0B72980B3
	for <linux-pm@vger.kernel.org>; Fri, 11 Apr 2025 08:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744361104; cv=none; b=mcbpJycLgjyPW2yznKZOSjOQKqZ/9jLEh1IC6lh5QAMyiZ/OlrAEbb/KnGLoDjDto9LPDr+hI4X7KrKzlZp9y9BZBiafDLtsj/jgHL+lV6FgbwLBictnZlSEGL9ivjET0lBvRhEj3nSxXrFwYg5OjeThCPCP0aLjzr/aACBaZeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744361104; c=relaxed/simple;
	bh=KT3ZPovNI1QLhpx/sSiAyZgWOThBW+OmkoKkybovVco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FaBCjFHDThoM6+0JuFCUisEgX1j1OMOcnmXMg7IvoAYLnL79PqaBr/XCczo68+XfZNE3hJXrGhBsgPkncGFSOmH87nHne6RuNz6TNhyJQv4BB85kr3c+zu71UhuAyHKOeaTc1p1ybzXnzAwFe3mExAIqsT0voenKRA4S6UfvNYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RBG1LnDS; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39c1efc4577so928042f8f.0
        for <linux-pm@vger.kernel.org>; Fri, 11 Apr 2025 01:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744361098; x=1744965898; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+Aj7bYwGpmFij+p6WS5NWCrr8WK21yn91m17fgt7T08=;
        b=RBG1LnDS0XL9QACH1EzRxLyIN+20ImfvA4fo1lXW8LLnOJ+XgQIZbVOY1Xh2mUAUKs
         JSpJoDfaF0WLFlJntUNIs7ImBkNA8G7SDGffZ/5Tu+sEl9JqLKfR3TX5St5/f60zJTMG
         yAxpf2i9dNak/PVE8hpxxrPYFsSGH2D2f3M6rr29V5ZFIYppAYBmhR44S6D8KLlkyp6S
         MYRQuzRWJ133puckXqW6+IlCGf61jw3lrYNuAwuCkzHUXhuAWsrYhmao4GRYOz6nztJq
         xL0A+axciZA6CQzMi+fiUDhg6Pf/VVhqa3nhe4FgbqhfWSgt/MSNwsFE8SGKeWdvpxU+
         thVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744361098; x=1744965898;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Aj7bYwGpmFij+p6WS5NWCrr8WK21yn91m17fgt7T08=;
        b=My+cglYeG/SG2w72zfnN+GsvZFVxA71H9k/uRCQV8I8elRwkJ8E0BVyZVobH3w37Ts
         nbfd9RFgv7s9KF9MJRYdWOGGfuoA2y1y2sHAO9fDiOy96/r155dIJJ1aGx5YueBJeboa
         S22m/+ouy/Gz2HZ0URAdNr0UFjjAnXg99zh1jbOC3rtYJakxrm5xzvx2qLRYDEryDQnQ
         yGFD4Bo/ovQEVnjbyC9Su6H0nJGvBUUBJs0//+dq872a8krtmggGk2iSeJwwv8TVOWIY
         niV+3OQ+xc1zBoC2crFgjCq5VwJtbrVynnkRl+u4MOu4dSKXuK8Qg7uvW1uB+6uDzwNL
         Orcw==
X-Forwarded-Encrypted: i=1; AJvYcCVjS4gZfAwmxAvev7CFKyCqcDCvqYsAtOOSfNI5r0AT3G7jyqo9UUaHyaZglBoYsvIjMCbRp8MBEg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxkyXw7KQ7CQltKXsIkQWq4RLwHmp3XdGDROGqap4TFlSaiOnAz
	S8QkHYTtP3ITorjGMbWUFzLQIJ+wj7uar6hZozeLoLsCJnLjrXR7SXLpaRF7lk8=
X-Gm-Gg: ASbGncsZXA6JFoONTYtGx8tbKR8/aHPf+jymamAowQxwo2Ewk5qusUsUv/F2pXFbpTj
	a7Tm+/i/5VTm3rJy4Cwoo0hkRPAEVsbhzjFu28XGM0SpeD7zbApYtw2umpPwFY/dROIwNyOcT4i
	JQQcPMhgdz0FGUpqo64TuTf7xEXrf1vYmk0ol0cqlOBjrxhOQbxth7K4RYZZegIOqdHwZvP/dxX
	fZqx/q654dy9s39jJwRsHNmfG8ZincQp9cXEmF/kfxhG99ORriB6tKKLMHuqT8que+95/1X6IYX
	ucAXwglJPu8pctDAy+jFWhttoZfiIcAIJoG1zGb6XJKMQk0d
X-Google-Smtp-Source: AGHT+IFmDNoMNIPep30iQGk7L0aRLNYJN1WA4f/yj9i/HMl65pMcNflAUWdBjK5NVU7WvtrKQTywtA==
X-Received: by 2002:a5d:6d82:0:b0:38f:2b77:a9f3 with SMTP id ffacd0b85a97d-39eaaecd9d3mr1479862f8f.43.1744361098447;
        Fri, 11 Apr 2025 01:44:58 -0700 (PDT)
Received: from [192.168.2.177] ([81.0.8.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf43cb29sm1328298f8f.76.2025.04.11.01.44.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Apr 2025 01:44:58 -0700 (PDT)
Message-ID: <c65ed484-6edb-4e41-9f63-cde9671aa332@suse.com>
Date: Fri, 11 Apr 2025 10:44:56 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] pmdomain: mediatek: Add support for Dimensity 1200
 MT6893
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 robh@kernel.org
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, ulf.hansson@linaro.org,
 matthias.bgg@gmail.com, fshao@chromium.org, y.oudjana@protonmail.com,
 wenst@chromium.org, lihongbo22@huawei.com, mandyjh.liu@mediatek.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, kernel@collabora.com
References: <20250410143944.475773-1-angelogioacchino.delregno@collabora.com>
 <20250410143944.475773-4-angelogioacchino.delregno@collabora.com>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <mbrugger@suse.com>
Autocrypt: addr=mbrugger@suse.com; keydata=
 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
 PVrr2NoUqi/bxI8fFQJD1jVj8K0=
In-Reply-To: <20250410143944.475773-4-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/04/2025 16:39, AngeloGioacchino Del Regno wrote:
> Add power domains definitions to implement support for the
> MediaTek Dimensity 1200 (MT6893) SoC.
> 
> Since this chip's MTCMOS are similar to the ones of Kompanio
> 820 (MT8192), the definitions from that have been reused where
> possible.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Matthias Brugger <mbrugger@suse.com>

> ---
>   drivers/pmdomain/mediatek/mt6893-pm-domains.h | 585 ++++++++++++++++++
>   drivers/pmdomain/mediatek/mtk-pm-domains.c    |   5 +
>   2 files changed, 590 insertions(+)
>   create mode 100644 drivers/pmdomain/mediatek/mt6893-pm-domains.h
> 
> diff --git a/drivers/pmdomain/mediatek/mt6893-pm-domains.h b/drivers/pmdomain/mediatek/mt6893-pm-domains.h
> new file mode 100644
> index 000000000000..5baa965d22da
> --- /dev/null
> +++ b/drivers/pmdomain/mediatek/mt6893-pm-domains.h
> @@ -0,0 +1,585 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2025 Collabora Ltd
> + *                    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> + */
> +
> +#ifndef __PMDOMAIN_MEDIATEK_MT6893_PM_DOMAINS_H
> +#define __PMDOMAIN_MEDIATEK_MT6893_PM_DOMAINS_H
> +
> +#include <linux/soc/mediatek/infracfg.h>
> +#include <dt-bindings/power/mediatek,mt6893-power.h>
> +#include "mtk-pm-domains.h"
> +
> +#define MT6893_TOP_AXI_PROT_EN_MCU_STA1				0x2e4
> +#define MT6893_TOP_AXI_PROT_EN_MCU_SET				0x2c4
> +#define MT6893_TOP_AXI_PROT_EN_MCU_CLR				0x2c8
> +#define MT6893_TOP_AXI_PROT_EN_VDNR_1_SET			0xba4
> +#define MT6893_TOP_AXI_PROT_EN_VDNR_1_CLR			0xba8
> +#define MT6893_TOP_AXI_PROT_EN_VDNR_1_STA1			0xbb0
> +#define MT6893_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_SET		0xbb8
> +#define MT6893_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_CLR		0xbbc
> +#define MT6893_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_STA1		0xbc4
> +
> +#define MT6893_TOP_AXI_PROT_EN_1_MFG1_STEP1			GENMASK(21, 19)
> +#define MT6893_TOP_AXI_PROT_EN_2_MFG1_STEP2			GENMASK(6, 5)
> +#define MT6893_TOP_AXI_PROT_EN_MFG1_STEP3			GENMASK(22, 21)
> +#define MT6893_TOP_AXI_PROT_EN_2_MFG1_STEP4			BIT(7)
> +#define MT6893_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_MFG1_STEP5	GENMASK(19, 17)
> +#define MT6893_TOP_AXI_PROT_EN_MM_VDEC0_STEP1			BIT(24)
> +#define MT6893_TOP_AXI_PROT_EN_MM_2_VDEC0_STEP2			BIT(25)
> +#define MT6893_TOP_AXI_PROT_EN_MM_VDEC1_STEP1			BIT(6)
> +#define MT6893_TOP_AXI_PROT_EN_MM_VDEC1_STEP2			BIT(7)
> +#define MT6893_TOP_AXI_PROT_EN_MM_VENC0_STEP1			BIT(26)
> +#define MT6893_TOP_AXI_PROT_EN_MM_2_VENC0_STEP2			BIT(0)
> +#define MT6893_TOP_AXI_PROT_EN_MM_VENC0_STEP3			BIT(27)
> +#define MT6893_TOP_AXI_PROT_EN_MM_2_VENC0_STEP4			BIT(1)
> +#define MT6893_TOP_AXI_PROT_EN_MM_VENC1_STEP1			GENMASK(30, 28)
> +#define MT6893_TOP_AXI_PROT_EN_MM_VENC1_STEP2			GENMASK(31, 29)
> +#define MT6893_TOP_AXI_PROT_EN_MDP_STEP1			BIT(10)
> +#define MT6893_TOP_AXI_PROT_EN_MM_MDP_STEP2			(BIT(2) | BIT(4) | BIT(6) |	\
> +								 BIT(8) | BIT(18) | BIT(22) |	\
> +								 BIT(28) | BIT(30))
> +#define MT6893_TOP_AXI_PROT_EN_MM_2_MDP_STEP3			(BIT(0) | BIT(2) | BIT(4) |	\
> +								 BIT(6) | BIT(8))
> +#define MT6893_TOP_AXI_PROT_EN_MDP_STEP4			BIT(23)
> +#define MT6893_TOP_AXI_PROT_EN_MM_MDP_STEP5			(BIT(3) | BIT(5) | BIT(7) |	\
> +								 BIT(9) | BIT(19) | BIT(23) |	\
> +								 BIT(29) | BIT(31))
> +#define MT6893_TOP_AXI_PROT_EN_MM_2_MDP_STEP6			(BIT(1) | BIT(7) | BIT(9) | BIT(11))
> +#define MT6893_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_MDP_STEP7		BIT(20)
> +#define MT6893_TOP_AXI_PROT_EN_MM_DISP_STEP1			(BIT(0) | BIT(6) | BIT(8) |	\
> +								 BIT(10) | BIT(12) | BIT(14) |	\
> +								 BIT(16) | BIT(20) | BIT(24) |	\
> +								 BIT(26))
> +#define MT6893_TOP_AXI_PROT_EN_DISP_STEP2			BIT(6)
> +#define MT6893_TOP_AXI_PROT_EN_MM_DISP_STEP3			(BIT(1) | BIT(7) | BIT(9) |	\
> +								 BIT(15) | BIT(17) | BIT(21) |	\
> +								 BIT(25) | BIT(27))
> +#define MT6893_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_DISP_STEP4	BIT(21)
> +#define MT6893_TOP_AXI_PROT_EN_2_ADSP				BIT(3)
> +#define MT6893_TOP_AXI_PROT_EN_2_CAM_STEP1			BIT(1)
> +#define MT6893_TOP_AXI_PROT_EN_MM_CAM_STEP2			(BIT(0) | BIT(2) | BIT(4))
> +#define MT6893_TOP_AXI_PROT_EN_1_CAM_STEP3			BIT(22)
> +#define MT6893_TOP_AXI_PROT_EN_MM_CAM_STEP4			(BIT(1) | BIT(3) | BIT(5))
> +#define MT6893_TOP_AXI_PROT_EN_MM_CAM_RAWA_STEP1		BIT(18)
> +#define MT6893_TOP_AXI_PROT_EN_MM_CAM_RAWA_STEP2		BIT(19)
> +#define MT6893_TOP_AXI_PROT_EN_MM_CAM_RAWB_STEP1		BIT(20)
> +#define MT6893_TOP_AXI_PROT_EN_MM_CAM_RAWB_STEP2		BIT(21)
> +#define MT6893_TOP_AXI_PROT_EN_MM_CAM_RAWC_STEP1		BIT(22)
> +#define MT6893_TOP_AXI_PROT_EN_MM_CAM_RAWC_STEP2		BIT(23)
> +
> +/*
> + * MT6893 Power Domain (MTCMOS) support
> + *
> + * The register layout for this IP is very similar to MT8192 so where possible
> + * the same definitions are reused to avoid duplication.
> + * Where the bus protection bits are also the same, the entire set is reused.
> + */
> +static const struct scpsys_domain_data scpsys_domain_data_mt6893[] = {
> +	[MT6893_POWER_DOMAIN_CONN] = {
> +		.name = "conn",
> +		.sta_mask = BIT(1),
> +		.ctl_offs = 0x304,
> +		.pwr_sta_offs = 0x16c,
> +		.pwr_sta2nd_offs = 0x170,
> +		.sram_pdn_bits = 0,
> +		.sram_pdn_ack_bits = 0,
> +		.bp_cfg = {
> +			BUS_PROT_WR(INFRA,
> +				    MT8192_TOP_AXI_PROT_EN_CONN,
> +				    MT8192_TOP_AXI_PROT_EN_SET,
> +				    MT8192_TOP_AXI_PROT_EN_CLR,
> +				    MT8192_TOP_AXI_PROT_EN_STA1),
> +			BUS_PROT_WR(INFRA,
> +				    MT8192_TOP_AXI_PROT_EN_CONN_2ND,
> +				    MT8192_TOP_AXI_PROT_EN_SET,
> +				    MT8192_TOP_AXI_PROT_EN_CLR,
> +				    MT8192_TOP_AXI_PROT_EN_STA1),
> +			BUS_PROT_WR(INFRA,
> +				    MT8192_TOP_AXI_PROT_EN_1_CONN,
> +				    MT8192_TOP_AXI_PROT_EN_1_SET,
> +				    MT8192_TOP_AXI_PROT_EN_1_CLR,
> +				    MT8192_TOP_AXI_PROT_EN_1_STA1),
> +		},
> +		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
> +	},
> +	[MT6893_POWER_DOMAIN_MFG0] = {
> +		.name = "mfg0",
> +		.sta_mask = BIT(2),
> +		.ctl_offs = 0x308,
> +		.pwr_sta_offs = 0x16c,
> +		.pwr_sta2nd_offs = 0x170,
> +		.sram_pdn_bits = BIT(8),
> +		.sram_pdn_ack_bits = BIT(12),
> +		.caps = MTK_SCPD_KEEP_DEFAULT_OFF | MTK_SCPD_DOMAIN_SUPPLY,
> +	},
> +	[MT6893_POWER_DOMAIN_MFG1] = {
> +		.name = "mfg1",
> +		.sta_mask = BIT(3),
> +		.ctl_offs = 0x30c,
> +		.pwr_sta_offs = 0x16c,
> +		.pwr_sta2nd_offs = 0x170,
> +		.sram_pdn_bits = BIT(8),
> +		.sram_pdn_ack_bits = BIT(12),
> +		.bp_cfg = {
> +			BUS_PROT_WR(INFRA,
> +				    MT6893_TOP_AXI_PROT_EN_1_MFG1_STEP1,
> +				    MT8192_TOP_AXI_PROT_EN_1_SET,
> +				    MT8192_TOP_AXI_PROT_EN_1_CLR,
> +				    MT8192_TOP_AXI_PROT_EN_1_STA1),
> +			BUS_PROT_WR(INFRA,
> +				    MT6893_TOP_AXI_PROT_EN_2_MFG1_STEP2,
> +				    MT8192_TOP_AXI_PROT_EN_2_SET,
> +				    MT8192_TOP_AXI_PROT_EN_2_CLR,
> +				    MT8192_TOP_AXI_PROT_EN_2_STA1),
> +			BUS_PROT_WR(INFRA,
> +				    MT6893_TOP_AXI_PROT_EN_MFG1_STEP3,
> +				    MT8192_TOP_AXI_PROT_EN_SET,
> +				    MT8192_TOP_AXI_PROT_EN_CLR,
> +				    MT8192_TOP_AXI_PROT_EN_STA1),
> +			BUS_PROT_WR(INFRA,
> +				    MT6893_TOP_AXI_PROT_EN_2_MFG1_STEP4,
> +				    MT8192_TOP_AXI_PROT_EN_2_SET,
> +				    MT8192_TOP_AXI_PROT_EN_2_CLR,
> +				    MT8192_TOP_AXI_PROT_EN_2_STA1),
> +			BUS_PROT_WR(INFRA,
> +				    MT6893_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_MFG1_STEP5,
> +				    MT6893_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_SET,
> +				    MT6893_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_CLR,
> +				    MT6893_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_STA1),
> +		},
> +		.caps = MTK_SCPD_KEEP_DEFAULT_OFF | MTK_SCPD_DOMAIN_SUPPLY,
> +	},
> +	[MT6893_POWER_DOMAIN_MFG2] = {
> +		.name = "mfg2",
> +		.sta_mask = BIT(4),
> +		.ctl_offs = 0x310,
> +		.pwr_sta_offs = 0x16c,
> +		.pwr_sta2nd_offs = 0x170,
> +		.sram_pdn_bits = BIT(8),
> +		.sram_pdn_ack_bits = BIT(12),
> +		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
> +	},
> +	[MT6893_POWER_DOMAIN_MFG3] = {
> +		.name = "mfg3",
> +		.sta_mask = BIT(5),
> +		.ctl_offs = 0x314,
> +		.pwr_sta_offs = 0x16c,
> +		.pwr_sta2nd_offs = 0x170,
> +		.sram_pdn_bits = BIT(8),
> +		.sram_pdn_ack_bits = BIT(12),
> +		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
> +	},
> +	[MT6893_POWER_DOMAIN_MFG4] = {
> +		.name = "mfg4",
> +		.sta_mask = BIT(6),
> +		.ctl_offs = 0x318,
> +		.pwr_sta_offs = 0x16c,
> +		.pwr_sta2nd_offs = 0x170,
> +		.sram_pdn_bits = BIT(8),
> +		.sram_pdn_ack_bits = BIT(12),
> +		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
> +	},
> +	[MT6893_POWER_DOMAIN_MFG5] = {
> +		.name = "mfg5",
> +		.sta_mask = BIT(7),
> +		.ctl_offs = 0x31c,
> +		.pwr_sta_offs = 0x16c,
> +		.pwr_sta2nd_offs = 0x170,
> +		.sram_pdn_bits = BIT(8),
> +		.sram_pdn_ack_bits = BIT(12),
> +		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
> +	},
> +	[MT6893_POWER_DOMAIN_MFG6] = {
> +		.name = "mfg6",
> +		.sta_mask = BIT(8),
> +		.ctl_offs = 0x320,
> +		.pwr_sta_offs = 0x16c,
> +		.pwr_sta2nd_offs = 0x170,
> +		.sram_pdn_bits = BIT(8),
> +		.sram_pdn_ack_bits = BIT(12),
> +		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
> +	},
> +	[MT6893_POWER_DOMAIN_ISP] = {
> +		.name = "isp",
> +		.sta_mask = BIT(12),
> +		.ctl_offs = 0x330,
> +		.pwr_sta_offs = 0x16c,
> +		.pwr_sta2nd_offs = 0x170,
> +		.sram_pdn_bits = BIT(8),
> +		.sram_pdn_ack_bits = BIT(12),
> +		.bp_cfg = {
> +			BUS_PROT_WR(INFRA,
> +				    MT8192_TOP_AXI_PROT_EN_MM_2_ISP,
> +				    MT8192_TOP_AXI_PROT_EN_MM_2_SET,
> +				    MT8192_TOP_AXI_PROT_EN_MM_2_CLR,
> +				    MT8192_TOP_AXI_PROT_EN_MM_2_STA1),
> +			BUS_PROT_WR(INFRA,
> +				    MT8192_TOP_AXI_PROT_EN_MM_2_ISP_2ND,
> +				    MT8192_TOP_AXI_PROT_EN_MM_2_SET,
> +				    MT8192_TOP_AXI_PROT_EN_MM_2_CLR,
> +				    MT8192_TOP_AXI_PROT_EN_MM_2_STA1),
> +		},
> +	},
> +	[MT6893_POWER_DOMAIN_ISP2] = {
> +		.name = "isp2",
> +		.sta_mask = BIT(13),
> +		.ctl_offs = 0x334,
> +		.pwr_sta_offs = 0x16c,
> +		.pwr_sta2nd_offs = 0x170,
> +		.sram_pdn_bits = BIT(8),
> +		.sram_pdn_ack_bits = BIT(12),
> +		.bp_cfg = {
> +			BUS_PROT_WR(INFRA,
> +				    MT8192_TOP_AXI_PROT_EN_MM_ISP2,
> +				    MT8192_TOP_AXI_PROT_EN_MM_SET,
> +				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
> +				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
> +			BUS_PROT_WR(INFRA,
> +				    MT8192_TOP_AXI_PROT_EN_MM_ISP2_2ND,
> +				    MT8192_TOP_AXI_PROT_EN_MM_SET,
> +				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
> +				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
> +		},
> +	},
> +	[MT6893_POWER_DOMAIN_IPE] = {
> +		.name = "ipe",
> +		.sta_mask = BIT(14),
> +		.ctl_offs = 0x338,
> +		.pwr_sta_offs = 0x16c,
> +		.pwr_sta2nd_offs = 0x170,
> +		.sram_pdn_bits = BIT(8),
> +		.sram_pdn_ack_bits = BIT(12),
> +		.bp_cfg = {
> +			BUS_PROT_WR(INFRA,
> +				    MT8192_TOP_AXI_PROT_EN_MM_IPE,
> +				    MT8192_TOP_AXI_PROT_EN_MM_SET,
> +				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
> +				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
> +			BUS_PROT_WR(INFRA,
> +				    MT8192_TOP_AXI_PROT_EN_MM_IPE_2ND,
> +				    MT8192_TOP_AXI_PROT_EN_MM_SET,
> +				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
> +				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
> +		},
> +	},
> +	[MT6893_POWER_DOMAIN_VDEC0] = {
> +		.name = "vdec0",
> +		.sta_mask = BIT(15),
> +		.ctl_offs = 0x33c,
> +		.pwr_sta_offs = 0x16c,
> +		.pwr_sta2nd_offs = 0x170,
> +		.sram_pdn_bits = BIT(8),
> +		.sram_pdn_ack_bits = BIT(12),
> +		.bp_cfg = {
> +			BUS_PROT_WR(INFRA,
> +				    MT6893_TOP_AXI_PROT_EN_MM_VDEC0_STEP1,
> +				    MT8192_TOP_AXI_PROT_EN_MM_SET,
> +				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
> +				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
> +			BUS_PROT_WR(INFRA,
> +				    MT6893_TOP_AXI_PROT_EN_MM_2_VDEC0_STEP2,
> +				    MT8192_TOP_AXI_PROT_EN_MM_2_SET,
> +				    MT8192_TOP_AXI_PROT_EN_MM_2_CLR,
> +				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
> +		},
> +		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
> +	},
> +	[MT6893_POWER_DOMAIN_VDEC1] = {
> +		.name = "vdec1",
> +		.sta_mask = BIT(16),
> +		.ctl_offs = 0x340,
> +		.pwr_sta_offs = 0x16c,
> +		.pwr_sta2nd_offs = 0x170,
> +		.sram_pdn_bits = BIT(8),
> +		.sram_pdn_ack_bits = BIT(12),
> +		.bp_cfg = {
> +			BUS_PROT_WR(INFRA,
> +				    MT6893_TOP_AXI_PROT_EN_MM_VDEC1_STEP1,
> +				    MT8192_TOP_AXI_PROT_EN_MM_SET,
> +				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
> +				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
> +			BUS_PROT_WR(INFRA,
> +				    MT6893_TOP_AXI_PROT_EN_MM_VDEC1_STEP2,
> +				    MT8192_TOP_AXI_PROT_EN_MM_SET,
> +				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
> +				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
> +		},
> +		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
> +	},
> +	[MT6893_POWER_DOMAIN_VENC0] = {
> +		.name = "venc0",
> +		.sta_mask = BIT(17),
> +		.ctl_offs = 0x344,
> +		.pwr_sta_offs = 0x16c,
> +		.pwr_sta2nd_offs = 0x170,
> +		.sram_pdn_bits = BIT(8),
> +		.sram_pdn_ack_bits = BIT(12),
> +		.bp_cfg = {
> +			BUS_PROT_WR(INFRA,
> +				    MT6893_TOP_AXI_PROT_EN_MM_VENC0_STEP1,
> +				    MT8192_TOP_AXI_PROT_EN_MM_SET,
> +				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
> +				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
> +			BUS_PROT_WR(INFRA,
> +				    MT6893_TOP_AXI_PROT_EN_MM_2_VENC0_STEP2,
> +				    MT8192_TOP_AXI_PROT_EN_MM_2_SET,
> +				    MT8192_TOP_AXI_PROT_EN_MM_2_CLR,
> +				    MT8192_TOP_AXI_PROT_EN_MM_2_STA1),
> +			BUS_PROT_WR(INFRA,
> +				    MT6893_TOP_AXI_PROT_EN_MM_VENC0_STEP3,
> +				    MT8192_TOP_AXI_PROT_EN_MM_SET,
> +				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
> +				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
> +			BUS_PROT_WR(INFRA,
> +				    MT6893_TOP_AXI_PROT_EN_MM_2_VENC0_STEP4,
> +				    MT8192_TOP_AXI_PROT_EN_MM_2_SET,
> +				    MT8192_TOP_AXI_PROT_EN_MM_2_CLR,
> +				    MT8192_TOP_AXI_PROT_EN_MM_2_STA1),
> +		},
> +		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
> +	},
> +	[MT6893_POWER_DOMAIN_VENC1] = {
> +		.name = "venc1",
> +		.sta_mask = BIT(18),
> +		.ctl_offs = 0x348,
> +		.pwr_sta_offs = 0x16c,
> +		.pwr_sta2nd_offs = 0x170,
> +		.sram_pdn_bits = BIT(8),
> +		.sram_pdn_ack_bits = BIT(12),
> +		.bp_cfg = {
> +			BUS_PROT_WR(INFRA,
> +				    MT6893_TOP_AXI_PROT_EN_MM_VENC1_STEP1,
> +				    MT8192_TOP_AXI_PROT_EN_MM_SET,
> +				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
> +				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
> +			BUS_PROT_WR(INFRA,
> +				    MT6893_TOP_AXI_PROT_EN_MM_VENC1_STEP2,
> +				    MT8192_TOP_AXI_PROT_EN_MM_SET,
> +				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
> +				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
> +		},
> +		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
> +	},
> +	[MT6893_POWER_DOMAIN_MDP] = {
> +		.name = "mdp",
> +		.sta_mask = BIT(19),
> +		.ctl_offs = 0x34c,
> +		.pwr_sta_offs = 0x16c,
> +		.pwr_sta2nd_offs = 0x170,
> +		.sram_pdn_bits = BIT(8),
> +		.sram_pdn_ack_bits = BIT(12),
> +		.bp_cfg = {
> +			BUS_PROT_WR(INFRA,
> +				    MT6893_TOP_AXI_PROT_EN_MDP_STEP1,
> +				    MT8192_TOP_AXI_PROT_EN_SET,
> +				    MT8192_TOP_AXI_PROT_EN_CLR,
> +				    MT8192_TOP_AXI_PROT_EN_STA1),
> +			BUS_PROT_WR(INFRA,
> +				    MT6893_TOP_AXI_PROT_EN_MM_MDP_STEP2,
> +				    MT8192_TOP_AXI_PROT_EN_MM_SET,
> +				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
> +				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
> +			BUS_PROT_WR(INFRA,
> +				    MT6893_TOP_AXI_PROT_EN_MM_2_MDP_STEP3,
> +				    MT8192_TOP_AXI_PROT_EN_MM_2_SET,
> +				    MT8192_TOP_AXI_PROT_EN_MM_2_CLR,
> +				    MT8192_TOP_AXI_PROT_EN_MM_2_STA1),
> +			BUS_PROT_WR(INFRA,
> +				    MT6893_TOP_AXI_PROT_EN_MDP_STEP4,
> +				    MT8192_TOP_AXI_PROT_EN_SET,
> +				    MT8192_TOP_AXI_PROT_EN_CLR,
> +				    MT8192_TOP_AXI_PROT_EN_STA1),
> +			BUS_PROT_WR(INFRA,
> +				    MT6893_TOP_AXI_PROT_EN_MM_MDP_STEP5,
> +				    MT8192_TOP_AXI_PROT_EN_MM_SET,
> +				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
> +				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
> +			BUS_PROT_WR(INFRA,
> +				    MT6893_TOP_AXI_PROT_EN_MM_2_MDP_STEP6,
> +				    MT8192_TOP_AXI_PROT_EN_MM_2_SET,
> +				    MT8192_TOP_AXI_PROT_EN_MM_2_CLR,
> +				    MT8192_TOP_AXI_PROT_EN_MM_2_STA1),
> +			BUS_PROT_WR(INFRA,
> +				    MT6893_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_MDP_STEP7,
> +				    MT6893_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_SET,
> +				    MT6893_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_CLR,
> +				    MT6893_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_STA1),
> +		},
> +	},
> +	[MT6893_POWER_DOMAIN_DISP] = {
> +		.name = "disp",
> +		.sta_mask = BIT(20),
> +		.ctl_offs = 0x350,
> +		.pwr_sta_offs = 0x16c,
> +		.pwr_sta2nd_offs = 0x170,
> +		.sram_pdn_bits = BIT(8),
> +		.sram_pdn_ack_bits = BIT(12),
> +		.bp_cfg = {
> +			BUS_PROT_WR(INFRA,
> +				    MT6893_TOP_AXI_PROT_EN_MM_DISP_STEP1,
> +				    MT8192_TOP_AXI_PROT_EN_MM_SET,
> +				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
> +				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
> +			BUS_PROT_WR(INFRA,
> +				    MT6893_TOP_AXI_PROT_EN_DISP_STEP2,
> +				    MT8192_TOP_AXI_PROT_EN_SET,
> +				    MT8192_TOP_AXI_PROT_EN_CLR,
> +				    MT8192_TOP_AXI_PROT_EN_STA1),
> +			BUS_PROT_WR(INFRA,
> +				    MT6893_TOP_AXI_PROT_EN_MM_DISP_STEP3,
> +				    MT8192_TOP_AXI_PROT_EN_MM_SET,
> +				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
> +				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
> +			BUS_PROT_WR(INFRA,
> +				    MT6893_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_DISP_STEP4,
> +				    MT6893_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_SET,
> +				    MT6893_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_CLR,
> +				    MT6893_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_STA1),
> +		},
> +	},
> +	[MT6893_POWER_DOMAIN_AUDIO] = {
> +		.name = "audio",
> +		.sta_mask = BIT(21),
> +		.ctl_offs = 0x354,
> +		.pwr_sta_offs = 0x16c,
> +		.pwr_sta2nd_offs = 0x170,
> +		.sram_pdn_bits = BIT(8),
> +		.sram_pdn_ack_bits = BIT(12),
> +		.bp_cfg = {
> +			BUS_PROT_WR(INFRA,
> +				    MT8192_TOP_AXI_PROT_EN_2_AUDIO,
> +				    MT8192_TOP_AXI_PROT_EN_2_SET,
> +				    MT8192_TOP_AXI_PROT_EN_2_CLR,
> +				    MT8192_TOP_AXI_PROT_EN_2_STA1),
> +		},
> +	},
> +	[MT6893_POWER_DOMAIN_ADSP] = {
> +		.name = "audio",
> +		.sta_mask = BIT(22),
> +		.ctl_offs = 0x358,
> +		.pwr_sta_offs = 0x16c,
> +		.pwr_sta2nd_offs = 0x170,
> +		.sram_pdn_bits = BIT(9),
> +		.sram_pdn_ack_bits = BIT(12),
> +		.bp_cfg = {
> +			BUS_PROT_WR(INFRA,
> +				    MT6893_TOP_AXI_PROT_EN_2_ADSP,
> +				    MT8192_TOP_AXI_PROT_EN_2_SET,
> +				    MT8192_TOP_AXI_PROT_EN_2_CLR,
> +				    MT8192_TOP_AXI_PROT_EN_2_STA1),
> +		},
> +	},
> +	[MT6893_POWER_DOMAIN_CAM] = {
> +		.name = "cam",
> +		.sta_mask = BIT(23),
> +		.ctl_offs = 0x35c,
> +		.pwr_sta_offs = 0x16c,
> +		.pwr_sta2nd_offs = 0x170,
> +		.sram_pdn_bits = BIT(8),
> +		.sram_pdn_ack_bits = BIT(12),
> +		.bp_cfg = {
> +			BUS_PROT_WR(INFRA,
> +				    MT6893_TOP_AXI_PROT_EN_2_CAM_STEP1,
> +				    MT8192_TOP_AXI_PROT_EN_2_SET,
> +				    MT8192_TOP_AXI_PROT_EN_2_CLR,
> +				    MT8192_TOP_AXI_PROT_EN_2_STA1),
> +			BUS_PROT_WR(INFRA,
> +				    MT6893_TOP_AXI_PROT_EN_MM_CAM_STEP2,
> +				    MT8192_TOP_AXI_PROT_EN_MM_SET,
> +				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
> +				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
> +			BUS_PROT_WR(INFRA,
> +				    MT6893_TOP_AXI_PROT_EN_1_CAM_STEP3,
> +				    MT8192_TOP_AXI_PROT_EN_1_SET,
> +				    MT8192_TOP_AXI_PROT_EN_1_CLR,
> +				    MT8192_TOP_AXI_PROT_EN_1_STA1),
> +			BUS_PROT_WR(INFRA,
> +				    MT6893_TOP_AXI_PROT_EN_MM_CAM_STEP4,
> +				    MT8192_TOP_AXI_PROT_EN_MM_SET,
> +				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
> +				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
> +		},
> +	},
> +	[MT6893_POWER_DOMAIN_CAM_RAWA] = {
> +		.name = "cam_rawa",
> +		.sta_mask = BIT(24),
> +		.ctl_offs = 0x360,
> +		.pwr_sta_offs = 0x16c,
> +		.pwr_sta2nd_offs = 0x170,
> +		.sram_pdn_bits = BIT(8),
> +		.sram_pdn_ack_bits = BIT(12),
> +		.bp_cfg = {
> +			BUS_PROT_WR(INFRA,
> +				    MT6893_TOP_AXI_PROT_EN_MM_CAM_RAWA_STEP1,
> +				    MT8192_TOP_AXI_PROT_EN_MM_SET,
> +				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
> +				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
> +			BUS_PROT_WR(INFRA,
> +				    MT6893_TOP_AXI_PROT_EN_MM_CAM_RAWA_STEP2,
> +				    MT8192_TOP_AXI_PROT_EN_MM_SET,
> +				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
> +				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
> +		},
> +	},
> +	[MT6893_POWER_DOMAIN_CAM_RAWB] = {
> +		.name = "cam_rawb",
> +		.sta_mask = BIT(25),
> +		.ctl_offs = 0x364,
> +		.pwr_sta_offs = 0x16c,
> +		.pwr_sta2nd_offs = 0x170,
> +		.sram_pdn_bits = BIT(8),
> +		.sram_pdn_ack_bits = BIT(12),
> +		.bp_cfg = {
> +			BUS_PROT_WR(INFRA,
> +				    MT6893_TOP_AXI_PROT_EN_MM_CAM_RAWB_STEP1,
> +				    MT8192_TOP_AXI_PROT_EN_MM_SET,
> +				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
> +				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
> +			BUS_PROT_WR(INFRA,
> +				    MT6893_TOP_AXI_PROT_EN_MM_CAM_RAWB_STEP2,
> +				    MT8192_TOP_AXI_PROT_EN_MM_SET,
> +				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
> +				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
> +		},
> +	},
> +	[MT6893_POWER_DOMAIN_CAM_RAWC] = {
> +		.name = "cam_rawc",
> +		.sta_mask = BIT(26),
> +		.ctl_offs = 0x368,
> +		.pwr_sta_offs = 0x16c,
> +		.pwr_sta2nd_offs = 0x170,
> +		.sram_pdn_bits = BIT(8),
> +		.sram_pdn_ack_bits = BIT(12),
> +		.bp_cfg = {
> +			BUS_PROT_WR(INFRA,
> +				    MT6893_TOP_AXI_PROT_EN_MM_CAM_RAWC_STEP1,
> +				    MT8192_TOP_AXI_PROT_EN_MM_SET,
> +				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
> +				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
> +			BUS_PROT_WR(INFRA,
> +				    MT6893_TOP_AXI_PROT_EN_MM_CAM_RAWC_STEP2,
> +				    MT8192_TOP_AXI_PROT_EN_MM_SET,
> +				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
> +				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
> +		},
> +	},
> +	[MT6893_POWER_DOMAIN_DP_TX] = {
> +		.name = "dp_tx",
> +		.sta_mask = BIT(27),
> +		.ctl_offs = 0x3ac,
> +		.pwr_sta_offs = 0x16c,
> +		.pwr_sta2nd_offs = 0x170,
> +		.sram_pdn_bits = BIT(8),
> +		.sram_pdn_ack_bits = BIT(12),
> +		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
> +	},
> +};
> +
> +static const struct scpsys_soc_data mt6893_scpsys_data = {
> +	.domains_data = scpsys_domain_data_mt6893,
> +	.num_domains = ARRAY_SIZE(scpsys_domain_data_mt6893),
> +};
> +
> +#endif /* __PMDOMAIN_MEDIATEK_MT6893_PM_DOMAINS_H */
> diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
> index b866b006af69..9a33321d9fac 100644
> --- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
> +++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
> @@ -18,6 +18,7 @@
>   
>   #include "mt6735-pm-domains.h"
>   #include "mt6795-pm-domains.h"
> +#include "mt6893-pm-domains.h"
>   #include "mt8167-pm-domains.h"
>   #include "mt8173-pm-domains.h"
>   #include "mt8183-pm-domains.h"
> @@ -617,6 +618,10 @@ static const struct of_device_id scpsys_of_match[] = {
>   		.compatible = "mediatek,mt6795-power-controller",
>   		.data = &mt6795_scpsys_data,
>   	},
> +	{
> +		.compatible = "mediatek,mt6893-power-controller",
> +		.data = &mt6893_scpsys_data,
> +	},
>   	{
>   		.compatible = "mediatek,mt8167-power-controller",
>   		.data = &mt8167_scpsys_data,


