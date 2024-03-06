Return-Path: <linux-pm+bounces-4746-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C96873C2C
	for <lists+linux-pm@lfdr.de>; Wed,  6 Mar 2024 17:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6AAC280E17
	for <lists+linux-pm@lfdr.de>; Wed,  6 Mar 2024 16:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA689137904;
	Wed,  6 Mar 2024 16:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dvlTffuN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FDA1350EB
	for <linux-pm@vger.kernel.org>; Wed,  6 Mar 2024 16:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709742336; cv=none; b=S0h7i9FJV97j7wlPeHk347uhuGnUSPsCY3zopVDxXhH7QC73P5w5wZu11Ym8cbdJVYZ5667r7NfquddatdzCh8A8S/szOY8b1XEvj2LhDzmasmBKjyW1eaAXPbtb/kJUxGQxW4v3KPwybI60DbNCnFHTy6RXzpMvTOq0bPrr5gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709742336; c=relaxed/simple;
	bh=xXWdLc5ycH+yuvPLxfdFChS+CKGdFWAwKl45XDmxjyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fQkHIGQCBxB+sjuANnilpezmmoeyDF9rjriVWerWd2SPCsDo2xx7PVTFlepZPnUqtc9UvcEWH1r+Ueg+IKBQr+qvO+NGf8oMiB8/7QBlF0RzBst7X8/yENXy9n8dVwMCZ44dZOGYRSNj5AHSQL9TgttvD62Jpl/kyoQWMPkw89A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dvlTffuN; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-513181719easo5176008e87.3
        for <linux-pm@vger.kernel.org>; Wed, 06 Mar 2024 08:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709742333; x=1710347133; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GC4h3Ht3vNoae6gXTCtlzCHjHZn8NZlxWQ90uE72zuU=;
        b=dvlTffuNikK9knUGo54uMuk9FbiDe7aVE3MgEUsPWE1RzIn1+gCWxxzB57y/vlIbAP
         oOxdGEWoU8gj7E37fBKu9EIdMpJnfh2Q/9IcpXtcH9rJBAb4K/fe8TkHGXFQcOv7tZ+E
         i5+zc0WRJuaPK2IMHA3a2BbSPMIsLKmIiKfc6OAcONjQmt5cl3TbL4c6CgdoCYS6/VBB
         JlEhGZcDh6MeXbX3eAWPQnwqCsWDfGmsCtNgX9Jd5gXPn+aBHIl+ea7FVW5B5nNVEWR3
         CZUVl6NVoOHmOT/Q8Df/wXYDxKm+vvBJLr1C1DJhB6i7Cko3wjh3CnbLR53LCYIFqD3x
         77vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709742333; x=1710347133;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GC4h3Ht3vNoae6gXTCtlzCHjHZn8NZlxWQ90uE72zuU=;
        b=ww8jjnXyIDOXhFZOU0cscB0JSExLCAsQUYpPTXRngB4MbWStUdf94hWezPY50OzaHG
         SBtJdGFayP5YcidzV5hJNMn3Qmcssb/JLUVaoj/h4hILqYehtBGZTSK1dseAyN0l9+Vh
         hxpv1OjEKfGMolPrk+Wf9IXEPuCuQXT393al0dThS9sd9aCZe1aQ8s3xkC4Zka9a9yho
         cMHOLK0dlatPxsWx2xDx62das+H2ehRQowquLVsf3nrkKu7zJxOCe0vbJ4CTZ4afLxhe
         g0qk+EW/odKTndOKeoy8Jc6oDGfGCOhzxbqj6FrQIW8JyzkPbrrRJclBmYlc2PwmNeMF
         1ljw==
X-Forwarded-Encrypted: i=1; AJvYcCWVBtS7gCp0wM2bNigQRtkT+Lwj41DDHhBVN/2mYfh2iJAhAJsBasmTmv5AgRczrk1c/xS8imQSbvEEt9VLoGjPORKBtwIRU58=
X-Gm-Message-State: AOJu0YxPsUNyzyZ9wb2O/vOjonT2bGrvcqDcPwgpuT7rhg1HLoXCe9b1
	3upbk+dqZJLBSsvxtBJSx6NSgj2FNaZ5RD611k1PgKG3WvEIvLACp7DxMpOAE4E=
X-Google-Smtp-Source: AGHT+IFgy9N9FS/+ol1bEmTGLgjs/Aqz0S9idsbDAFmzV83opyYYygqCUkKwwKWJ2gnki+iP9QqwmA==
X-Received: by 2002:ac2:430c:0:b0:513:6bbc:e6fc with SMTP id l12-20020ac2430c000000b005136bbce6fcmr803184lfh.8.1709742333240;
        Wed, 06 Mar 2024 08:25:33 -0800 (PST)
Received: from [87.246.221.128] (netpanel-87-246-221-128.pol.akademiki.lublin.pl. [87.246.221.128])
        by smtp.gmail.com with ESMTPSA id u14-20020ac258ce000000b00512b7948baesm2674557lfo.41.2024.03.06.08.25.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 08:25:32 -0800 (PST)
Message-ID: <3bace619-46fc-4f9f-bfb3-4c55cb4d8408@linaro.org>
Date: Wed, 6 Mar 2024 17:25:31 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] interconnect: qcom: sc7280: enable QoS programming
Content-Language: en-US
To: Odelu Kukatla <quic_okukatla@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>, Georgi Djakov <djakov@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, cros-qcom-dts-watchers@chromium.org,
 "Gustavo A . R . Silva" <gustavoars@kernel.org>,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, quic_rlaggysh@quicinc.com,
 quic_mdtipton@quicinc.com
References: <20240306073016.2163-1-quic_okukatla@quicinc.com>
 <20240306073016.2163-3-quic_okukatla@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240306073016.2163-3-quic_okukatla@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/6/24 08:30, Odelu Kukatla wrote:
> Enable QoS for the master ports with predefined values
> for priority and urgency.
> 
> Signed-off-by: Odelu Kukatla <quic_okukatla@quicinc.com>
> ---
>   drivers/interconnect/qcom/sc7280.c | 332 +++++++++++++++++++++++++++++
>   1 file changed, 332 insertions(+)
> 
> diff --git a/drivers/interconnect/qcom/sc7280.c b/drivers/interconnect/qcom/sc7280.c
> index 7d33694368e8..1e1002c4d3d8 100644
> --- a/drivers/interconnect/qcom/sc7280.c
> +++ b/drivers/interconnect/qcom/sc7280.c
> @@ -1,6 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /*
>    * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
>    *
>    */
>   
> @@ -16,29 +17,53 @@
>   #include "icc-rpmh.h"
>   #include "sc7280.h"
>   
> +static const struct qcom_icc_qosbox qhm_qspi_qos = {
> +	.num_ports = 1,
> +	.port_offsets = { 0x7000 },
> +	.prio = 2,
> +	.urg_fwd = 0,
> +};
> +
>   static struct qcom_icc_node qhm_qspi = {
>   	.name = "qhm_qspi",
>   	.id = SC7280_MASTER_QSPI_0,
>   	.channels = 1,
>   	.buswidth = 4,
> +	.qosbox = &qhm_qspi_qos,

	.qosbox = &(const struct qcom_icc_qosbox) {
		.num_ports = 1,
		...
	},



Looks sensible otherwise

Konrad

