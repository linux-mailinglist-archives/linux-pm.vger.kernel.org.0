Return-Path: <linux-pm+bounces-37113-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 81894C20E05
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 16:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D5A14E3B6F
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 15:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4F1363349;
	Thu, 30 Oct 2025 15:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="G0rzQevx"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DAF31985C;
	Thu, 30 Oct 2025 15:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761837474; cv=none; b=N0LyZXpvUqGUb9FAxmvGehmFxi1wFz1jp/AuGuyAiJZKNGvlW2INKR92np7Nq+fwJoqc3z77m8t9Z7rtl8Fa3VqxbnpZESBiNYcffyPJpgke/tHJ9B6zL6c4odkff+Q2jo2RZw9ELvW2Zh5nB7P9Hxa2cli+dSR8F1qGhoYC50E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761837474; c=relaxed/simple;
	bh=OkBtFod+Tw0J/EkbQDgJVycQMKZFAL/9AmKvf27eyg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iZ+pK/9F2jtYV5D/lN0jFjT2w79crnocMAy6NbvS9J3LEIHEdqp3ZwaTOmA75OFr9CpHeivOEw/AtxqULMx50Qbtb69WmGpzmRG/j/LDacbtVQKJnPRPq8+BmhKAaF6yOVQKk1J9fKTCLvhA2YBqLNBjyKOkWJhUxM89a2exGWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=G0rzQevx; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761837464;
	bh=OkBtFod+Tw0J/EkbQDgJVycQMKZFAL/9AmKvf27eyg8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=G0rzQevxahouYSbAnsFKcmY9qMDD2v5jiXTeXGJ9pY6DtjXeGV6itkx3RqHhVlxVT
	 mHL5WLF18etfuWzQnk8fyECy6Gz/7zynkfXUDq1xY6DjcA6JhA/EyRGshK1GHDYmTO
	 kxfnv/ETUwEqeJupWm9EUNdivZbM7Mc+FkpdzN+lmkyHrb+kWlrXGfjdrVXhH1lzEV
	 MjIVEQZOVmhtMTosdJcGF/r406zB0kjN/mtxY5nzsDRR+CF2x4O/SXulXMXkP0K5Lp
	 Ku4LKQw9oPXQ5AjMk9b2H/oQ6ypkM3U3TchHzVv9s/Rq6PFxNDy2fQuLMXWCJCM/x0
	 ppNY+VrAHiVcg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id CA7A217E1315;
	Thu, 30 Oct 2025 16:17:43 +0100 (CET)
Message-ID: <480e1177-1be1-44ab-b20f-a6840b6fb564@collabora.com>
Date: Thu, 30 Oct 2025 16:17:43 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pmdomain: mediatek: mtk-mfg: select MAILBOX in Kconfig
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 kernel@collabora.com, kernel test robot <lkp@intel.com>
References: <20251030-mfg-mailbox-dep-v1-1-8a8c591aff27@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251030-mfg-mailbox-dep-v1-1-8a8c591aff27@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 30/10/25 14:17, Nicolas Frattaroli ha scritto:
> The mtk-mfg pmdomain driver calls common mailbox framework functions. If
> the common mailbox framework is not selected in the kernel's
> configuration, the build runs into a linker error, as the symbols are
> absent.
> 
> The hardware mailbox Kconfig system, MAILBOX, has no dependencies of its
> own. It's therefore safe to "select" it rather than use "depend on".
> 
> Declare this "select" dependency in the Kconfig for the driver.
> 
> Fixes: 1ff1f0db6aec ("pmdomain: mediatek: Add support for MFlexGraphics")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202510301311.TcOCnZ1s-lkp@intel.com/
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
> I assume this can be squashed into the mtk-mfg driver addition commit of
> the maintainer that merged it.
> ---
>   drivers/pmdomain/mediatek/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pmdomain/mediatek/Kconfig b/drivers/pmdomain/mediatek/Kconfig
> index b06aaa9690f0..8923e6516441 100644
> --- a/drivers/pmdomain/mediatek/Kconfig
> +++ b/drivers/pmdomain/mediatek/Kconfig
> @@ -32,6 +32,7 @@ config MTK_MFG_PM_DOMAIN
>   	depends on PM
>   	depends on OF
>   	depends on COMMON_CLK
> +	select MAILBOX
>   	select PM_GENERIC_DOMAINS
>   	imply MTK_GPUEB_MBOX
>   	help
> 
> ---
> base-commit: d78b0fee454c25d292fb6343253eca06d7634fd9
> change-id: 20251030-mfg-mailbox-dep-ec32ef510e6a
> 
> Best regards,


