Return-Path: <linux-pm+bounces-17633-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A29699CEFD1
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 16:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6423328AA51
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 15:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD5F1D47C7;
	Fri, 15 Nov 2024 15:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PHQxPfOg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699A41CEAD1
	for <linux-pm@vger.kernel.org>; Fri, 15 Nov 2024 15:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731684471; cv=none; b=KCzxKTACcUHr4Rr+bUXGIe4K/Qmro6eRdKiHVOJw3ReA8ArzqhR7QDQr12rd8GeMZ68mv0i5RQoP0Mnp905mf/VWBosNx1ZK2CID+79hOau1p+4J3rC7sgbCpMTmPSwK0nsUmPUaNYBCczuel0mvZXx/7W+B/HnXLK1uE+Z+tvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731684471; c=relaxed/simple;
	bh=bVXjOnsWx/iYY5FZ/kXZfHu8Jl/8iTaixZb5j49sBB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZn4pC8dXDUYiQ8ghhJ8y+zItqHv6X3E22FWdhMluGLJTaSozMoSXgbeEpxNWvHZLC7BUCIfvyCkBoHFi7nWjxyliOZpSw++c0f/7ixOnY9i9AO4MHvIoKf/B5R/5DIan+xVaBIpt7MGmeLDwAifkp2E1ACbBey+2FvJZOCS1uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PHQxPfOg; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fb4fa17044so21033531fa.3
        for <linux-pm@vger.kernel.org>; Fri, 15 Nov 2024 07:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731684467; x=1732289267; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PMXuggpYjesVA4FmUllH/mkqHpozoEMNcx85tFh/IDc=;
        b=PHQxPfOgCu3d/K2wupcKv9NYWljNv//C5GXZw7WrG7VyZBKWnxpBUEWo55schv/EEE
         DaCsv81Xkk/i1ACbTyZTE3XdZZU9uQhHFpLqS3Im6bNp2I51qq17ISDMFkl9xlWIKUc5
         amB8noXqdIKtUaoW8O7C/TkWp6X/G/0n4wNFcSEWhavRu4fJtxak4jAsEVgsq7Yw3jPG
         7Q3C4CmvzkmWkB5Ek1IKy81wPgBroQAwG3BUM3XasCCWHtgdQjgFnaCGzhMKBPp/0klw
         VW+T/XDS822rrWwJ2ot6FuDTmY7IO655cOwH5v2HuKbkBfDMvU1cc2v2n8kg/IWDfrgx
         ALCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731684467; x=1732289267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PMXuggpYjesVA4FmUllH/mkqHpozoEMNcx85tFh/IDc=;
        b=I78wxXnmlqiakdLyMytV65N+09bcXUPZLtdcR/jGJZOnl+jusqMJpiEA3rx6sOyubB
         e+RhWrcc/8C9Tl29A8tczAAJ+yOTXQYcJ0XKeXcCv3uFUkZrP1XKhje3GSy5sPk3Limp
         LpY6UB1fr7TmE9Im0IF/qAQW0lLBpBTzqG5I0w98t4/sx7DuyiMB4/FbUS+Vw6CWsvkr
         utxhdK4JyzjcnSfk/9vXCdTSVy4A2cbD5lyAXVnup07qFrEK5qVql/Am39ZtcyPSzjYl
         WyVbL2dF8Zl6cMw+/bMdOudgn9/CTDhqrR9mXaJGNBmGCdMBcnagKShN8QAAxj0fkQVB
         yDlA==
X-Forwarded-Encrypted: i=1; AJvYcCXLnqzgQZW8tAjDsQNoKA+7UHUTXgAjHIHStAmuRt2UPcoHNoPIRBK3g7xNkHoGowIlFhmmCFhHdw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3SX22vWmpgAdNZuBdFG+D04X4jN+uD//cDbBEcwbh9TTetgr7
	YVG+vkTFUG2ugbymfCqeOej2iyrRvgeXvV1Az6I6fW0afBV64kJCMX28u5xUc9M=
X-Google-Smtp-Source: AGHT+IHdzjVyEhzeFfshpDNdqomTi8OW4O+yNGDbt9rQbjkJS5VK0ycCp1yfl5ev+Ig7t+lEe2ruWQ==
X-Received: by 2002:a05:651c:2122:b0:2fb:5035:7e4 with SMTP id 38308e7fff4ca-2ff60621cf1mr17333551fa.5.1731684466569;
        Fri, 15 Nov 2024 07:27:46 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff59763d43sm5824821fa.9.2024.11.15.07.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 07:27:45 -0800 (PST)
Date: Fri, 15 Nov 2024 17:27:42 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Melody Olvera <quic_molvera@quicinc.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Adam Skladowski <a39.skl@gmail.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	Sibi Sankar <quic_sibis@quicinc.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Vladimir Lypak <vladimir.lypak@gmail.com>, Danila Tikhonov <danila@jiaxyga.com>, 
	Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Rajendra Nayak <quic_rjendra@quicinc.com>, Mike Tipton <quic_mdtipton@quicinc.com>, 
	Abel Vesa <abel.vesa@linaro.org>, Trilok Soni <quic_tsoni@quicinc.com>, 
	Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] interconnect: qcom: Add interconnect provider
 driver for SM8750
Message-ID: <em4vkg4totsg435s4usu7kqn45vfqfot2j7sikzmnof2kkyidi@26b6kkpz7z4c>
References: <20241112003017.2805670-1-quic_molvera@quicinc.com>
 <20241112003017.2805670-3-quic_molvera@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112003017.2805670-3-quic_molvera@quicinc.com>

On Mon, Nov 11, 2024 at 04:30:17PM -0800, Melody Olvera wrote:
> From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> 
> Introduce SM8750 interconnect provider driver using the interconnect
> framework.
> 
> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  drivers/interconnect/qcom/Kconfig  |    9 +
>  drivers/interconnect/qcom/Makefile |    2 +
>  drivers/interconnect/qcom/sm8750.c | 1585 ++++++++++++++++++++++++++++
>  drivers/interconnect/qcom/sm8750.h |  132 +++
>  4 files changed, 1728 insertions(+)
>  create mode 100644 drivers/interconnect/qcom/sm8750.c
>  create mode 100644 drivers/interconnect/qcom/sm8750.h
> 
> diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
> index 362fb9b0a198..1219f4f23d40 100644
> --- a/drivers/interconnect/qcom/Kconfig
> +++ b/drivers/interconnect/qcom/Kconfig
> @@ -337,6 +337,15 @@ config INTERCONNECT_QCOM_SM8650
>  	  This is a driver for the Qualcomm Network-on-Chip on SM8650-based
>  	  platforms.
>  
> +config INTERCONNECT_QCOM_SM8750
> +	tristate "Qualcomm SM8750 interconnect driver"
> +	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
> +	select INTERCONNECT_QCOM_RPMH
> +	select INTERCONNECT_QCOM_BCM_VOTER
> +	help
> +	  This is a driver for the Qualcomm Network-on-Chip on SM8750-based
> +	  platforms.
> +
>  config INTERCONNECT_QCOM_X1E80100
>  	tristate "Qualcomm X1E80100 interconnect driver"
>  	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
> diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
> index 9997728c02bf..7887b1e8d69b 100644
> --- a/drivers/interconnect/qcom/Makefile
> +++ b/drivers/interconnect/qcom/Makefile
> @@ -40,6 +40,7 @@ qnoc-sm8350-objs			:= sm8350.o
>  qnoc-sm8450-objs			:= sm8450.o
>  qnoc-sm8550-objs			:= sm8550.o
>  qnoc-sm8650-objs			:= sm8650.o
> +qnoc-sm8750-objs			:= sm8750.o
>  qnoc-x1e80100-objs			:= x1e80100.o
>  icc-smd-rpm-objs			:= smd-rpm.o icc-rpm.o icc-rpm-clocks.o
>  
> @@ -80,5 +81,6 @@ obj-$(CONFIG_INTERCONNECT_QCOM_SM8350) += qnoc-sm8350.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_SM8450) += qnoc-sm8450.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_SM8550) += qnoc-sm8550.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_SM8650) += qnoc-sm8650.o
> +obj-$(CONFIG_INTERCONNECT_QCOM_SM8750) += qnoc-sm8750.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_X1E80100) += qnoc-x1e80100.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_SMD_RPM) += icc-smd-rpm.o
> diff --git a/drivers/interconnect/qcom/sm8750.c b/drivers/interconnect/qcom/sm8750.c
> new file mode 100644
> index 000000000000..bc72954d54ff
> --- /dev/null
> +++ b/drivers/interconnect/qcom/sm8750.c
> @@ -0,0 +1,1585 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
> + *
> + */
> +
> +#include <linux/device.h>
> +#include <linux/interconnect.h>
> +#include <linux/interconnect-provider.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <dt-bindings/interconnect/qcom,sm8750-rpmh.h>
> +
> +#include "bcm-voter.h"
> +#include "icc-rpmh.h"
> +#include "sm8750.h"

Nit: please merge sm8750.h here, there is no need to have a separate
header, there are no other users.

Also, is there QoS support? I see no qcom_icc_qosbox entries.

Other than that:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

