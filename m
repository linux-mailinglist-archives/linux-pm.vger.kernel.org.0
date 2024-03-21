Return-Path: <linux-pm+bounces-5175-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D29178854E3
	for <lists+linux-pm@lfdr.de>; Thu, 21 Mar 2024 08:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E26FB213FC
	for <lists+linux-pm@lfdr.de>; Thu, 21 Mar 2024 07:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE9751C2C;
	Thu, 21 Mar 2024 07:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bNH2e3/0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C654F8BC
	for <linux-pm@vger.kernel.org>; Thu, 21 Mar 2024 07:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711005787; cv=none; b=IOGyrlHxxZjmL7H2gNroNEyzAo1RfaEsAEqZKoIiZGvWXTyCDCUy4LwCogT69x2uk5uG3BTJPDI8gzFiGgieoG2aGcFlagonp8kzqaVvK5am5qhLxtXVR/VMwnCmoMre3qGQNWKWsUvBxKJZtpPbwgc5cogzzYNmwBtojuOkC2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711005787; c=relaxed/simple;
	bh=8OVtJNE+wVx424qWwrUYVM+QE4I9cDcWGYnVOYBuBM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uks899UAjrcbhBGs4lMV8uONGkmcEvG7x16qOK/OPf6Vqum2j9oX55WsznGve4eVFEV2j5g9bAJq3P8H2/jlaqEjan/XCKV5Wzo6ormXA17+22LE23mK53iEIIn/4lfnIfmVFmyLN0lHCDIMdFS2AqT73zZDqV/PRiwmHqqO8FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bNH2e3/0; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a467d8efe78so70898766b.3
        for <linux-pm@vger.kernel.org>; Thu, 21 Mar 2024 00:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711005784; x=1711610584; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=efC9ADuz8uZ6q9rMWt/IWw4KlYedDKABf+PMc+/ki5M=;
        b=bNH2e3/0+sX3wWfll3GPNG6gczA0iDB9sdC0sGTvz4LFPyIXJpAJaEciAzF/fTbhnQ
         Oxo611r0FWb6R3cfM4ogh2KNghMuMFDt8QSDfsdp56l/QQKIQZuN36bU6MspRSg5H033
         LsgT/J/owPR+RRW2ZGHINvVxkvspIGjFN9MMQdqZpxnf3hWM8dNQYkfFuYu9M8cKyC6N
         69tfv4LD3WedHpIvPLZ2ty77DKvxsk+y3IHL/0zEjT5U6cBVmQGhYCcBYEYTI2LL7xwt
         QnkPrgbaKdd91NFPdNrrp9MamA/ekXhQXuz41MPOVMTPkvA7EDOw04LewEeHoa1qxbA7
         u91Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711005784; x=1711610584;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=efC9ADuz8uZ6q9rMWt/IWw4KlYedDKABf+PMc+/ki5M=;
        b=sQQvGaZBgQHgFOFGWYFWsjA2fnxJKl7m7scSnyb5llL7zV6GubNsaaLaeValtpSRtN
         rX7gooxPRwF0nCJtObP8/UGj6NcOg7Kqc2BBcrkgGV+hIaxV3vM5wUjpKPBSleRrqekh
         OSpwmypkhmWLSMxN+Q19cKV4bbZdEZQ6sLjkv6D8wbh5OdBD+IZIaavVTS6gQ7J5YCeO
         hiWXe0iI3KyKuBoLGMTu0LSfH0TjFD8ApA/pvTMuslhNGiVNhPVw7x4xTgju5bZlQEGf
         vXz1MxxBYJb5lpGnKxhCIkZU/P2bOzrePWr0jqn9Vmd6miOaw+L4730CyngvWD5mSgZv
         a1UQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/CPVHEn8asc7aJbZSWMCpLtXky7hAvG4hoq9n/7/EoUGjp7TcmT5rQkAtaF6HeQTK9COw6qNRXQfIE73pMNOqVV6UMPA6mq0=
X-Gm-Message-State: AOJu0YwPCNbAmIzAmI3EZVh2+qxxhc3w2wyMOuYlO13D2fCs1e/VH1Ai
	V+BserYthT+jxjfE7ggJf5PylS8fidhDdKEsNOyw13oUNamewoPyi8mbPAbyP04=
X-Google-Smtp-Source: AGHT+IEkg5VEK8CuEzKXO8WXf32zlJD3LR5GKX7zeaYgPcupSlqY+ryDGqJzaQMU6jqNcnk4WJc9YA==
X-Received: by 2002:a17:906:4692:b0:a47:ac1:5ba5 with SMTP id a18-20020a170906469200b00a470ac15ba5mr1051770ejr.50.1711005784004;
        Thu, 21 Mar 2024 00:23:04 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id bp14-20020a17090726ce00b00a46bdc6278csm4492272ejc.71.2024.03.21.00.23.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 00:23:03 -0700 (PDT)
Message-ID: <9e50c5fe-cb4c-4c3b-bff7-4492b24a5291@linaro.org>
Date: Thu, 21 Mar 2024 08:23:01 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: Add Qualcomm IPQ9574
 support
To: Varadarajan Narayanan <quic_varada@quicinc.com>, andersson@kernel.org,
 konrad.dybcio@linaro.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org, djakov@kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20240321043149.2739204-1-quic_varada@quicinc.com>
 <20240321043149.2739204-2-quic_varada@quicinc.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240321043149.2739204-2-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/03/2024 05:31, Varadarajan Narayanan wrote:
> Add master/slave ids for Qualcomm IPQ9574 Network-On-Chip
> interfaces. This will be used by the gcc-ipq9574 driver
> that will for providing interconnect services using the
> icc-clk framework.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  .../dt-bindings/interconnect/qcom,ipq9574.h   | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 include/dt-bindings/interconnect/qcom,ipq9574.h
> 
> diff --git a/include/dt-bindings/interconnect/qcom,ipq9574.h b/include/dt-bindings/interconnect/qcom,ipq9574.h
> new file mode 100644
> index 000000000000..96f79a86e8d2
> --- /dev/null
> +++ b/include/dt-bindings/interconnect/qcom,ipq9574.h
> @@ -0,0 +1,62 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> +#ifndef INTERCONNECT_QCOM_IPQ9574_H
> +#define INTERCONNECT_QCOM_IPQ9574_H
> +
> +#define IPQ_APPS_ID			9574	/* some unique value */
> +#define IPQ_NSS_ID			(IPQ_APPS_ID * 2)
> +
> +#define IPQ_ANOC_PCIE0_1_MAS		0
> +#define IPQ_ANOC_PCIE0_1_SLV		1

Please use style matching rest of mainline code. There is no IPQ in the
name of interconnect. Open recent SM8650 or similar and see.

Best regards,
Krzysztof


