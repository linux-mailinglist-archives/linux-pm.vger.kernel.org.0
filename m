Return-Path: <linux-pm+bounces-23447-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A7AA4EE44
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 21:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 052FB1890A10
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 20:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A911FAC26;
	Tue,  4 Mar 2025 20:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="WNPh3e5p"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A34A1FA178;
	Tue,  4 Mar 2025 20:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741119807; cv=none; b=SYwgia0E0Zi9YPU6ZUSEqlSGvSSuTNpmgIVYerlV58CnHJzGiptA/9sLjsHI4xKcNdXsvQoZ4VDMq5PmavmmdaGwtAjPhyfIS09AR/lwVq9u59rqGQKFj+2WjGjybsOenkuN0+CdXYYGiWuCh8+aWloIQnVwohrcZ4sO1zbvPj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741119807; c=relaxed/simple;
	bh=nGGYL3cDvTVN8v68H4alhERUircqCGV/HD6MPfzPqx8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=dVmKxHPc8V9qaJ01F4608QWsn+65PdDEggskgic4H5yn6W2OBRNHWqHK+lu53tBjhj+vfIofucEHObq01pz00VJhZw/++L9IBccx5eEMAezUEUkLk0QqgPEPVhAzO5ZksA3/1p8okLUHeYmsOe3lPba+WMCpW5qY7CiUnA/T2hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=WNPh3e5p; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1741119802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U2sqEAxGJv2uGZqDwGrSnxcuM3qMt5QnCoz/T7iEsGY=;
	b=WNPh3e5psK966rm8ClScI8cegZulUjpiLwARCd4gpgUwa6Zx6B1/pufdZQy6A+HJHxL2vI
	dRT/9TzI6o24gv79nwK6r6q4uEhck3xgSAzyO15jYeukAy2cwig1FWFJfRV8Lp64xwLJF+
	miqoRz6zokio8gKJzZFyQhlPKPyTLr9JUkWAF8goplg75vvp+q7piNvWsxCoHoSviskbVe
	4U0fUGu2Sp3NVOpcETTE/39mSmEu3REBFj9EGJ5Qu/biUJaHkYMJoEFpgSmps3Nrf453nF
	s1GDjeIDJbNheYF8ATNdjkCLHZDCDBc2/5XKEP4pVcR0PLiwTn/naS1h3cp0dQ==
Date: Tue, 04 Mar 2025 21:23:21 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Heiko Stuebner <heiko@sntech.de>,
 Sebastian Reichel <sebastian.reichel@collabora.com>, Arnd Bergmann
 <arnd@arndb.de>, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pmdomain: rockchip: add regulator dependency
In-Reply-To: <20250304142803.689201-1-arnd@kernel.org>
References: <20250304142803.689201-1-arnd@kernel.org>
Message-ID: <57dc1e1b8a3f1134c5eed050a81de1b7@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Arnd,

On 2025-03-04 15:27, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When CONFIG_REGULATOR is disabled, this pmdomain driver fails to build:
> 
> drivers/pmdomain/rockchip/pm-domains.c:653:30: error: implicit
> declaration of function 'devm_of_regulator_get'; did you mean
> 'devm_regulator_get'? [-Wimplicit-function-declaration]
>   653 |                 pd->supply = devm_of_regulator_get(pmu->dev,
> pd->node, "domain");
>       |                              ^~~~~~~~~~~~~~~~~~~~~
>       |                              devm_regulator_get
> drivers/pmdomain/rockchip/pm-domains.c:653:28: error: assignment to
> 'struct regulator *' from 'int' makes pointer from integer without a
> cast [-Wint-conversion]
>   653 |                 pd->supply = devm_of_regulator_get(pmu->dev,
> pd->node, "domain");
>       |                            ^
> 
> Add a Kconfig dependency.
> 
> Fixes: db6df2e3fc16 ("pmdomain: rockchip: add regulator support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/pmdomain/rockchip/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pmdomain/rockchip/Kconfig
> b/drivers/pmdomain/rockchip/Kconfig
> index 7e4f9b628f0b..218d43186e5b 100644
> --- a/drivers/pmdomain/rockchip/Kconfig
> +++ b/drivers/pmdomain/rockchip/Kconfig
> @@ -5,6 +5,7 @@ config ROCKCHIP_PM_DOMAINS
>  	bool "Rockchip generic power domain"
>  	depends on PM
>  	depends on HAVE_ARM_SMCCC_DISCOVERY
> +	depends on REGULATOR
>  	select PM_GENERIC_DOMAINS
>  	help
>  	  Say y here to enable power domain support.

Looking good to me, thanks for this patch.

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

