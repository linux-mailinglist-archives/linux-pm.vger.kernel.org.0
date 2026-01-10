Return-Path: <linux-pm+bounces-40601-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCD6D0D909
	for <lists+linux-pm@lfdr.de>; Sat, 10 Jan 2026 17:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16F0B303BE3E
	for <lists+linux-pm@lfdr.de>; Sat, 10 Jan 2026 16:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0194B34889F;
	Sat, 10 Jan 2026 16:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HpjKeBdG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DD9345CD9
	for <linux-pm@vger.kernel.org>; Sat, 10 Jan 2026 16:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768061641; cv=none; b=uI06r5pQSdou1X88TqZn9GTHI5ArxZDoPKTYI7A0rA9dzwZFW+hoCfo/yYo/w2ARBFCNRYiBI6i+PwH6qV6Z8FFTvi2t4EkgFT77Tffez1bXqF2DMFSO7l/y+zWhbkqpk7bUFiph2GwnFwSNWA0XxcA7EaH5en/1QWDlaYdyVog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768061641; c=relaxed/simple;
	bh=CZZIXy+M3Hwd2R3IUz/gMxdE6SMi8+NpZ+MFX6odPrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VNhhoEYKNPXZHYtOb7TW4ygoNFiF+VbEGLR/QHvkgeeu1xlL4ggiBERbpoth5VJUR9MTEfKQEdtUKzGEIEO6IosLlHRtti1vX1C6+AkgzKT7xap0EsM8TaSkjI27kdcYm0G8nWkx/pwmCJJy++GQfdZHbR6LrVWbfyceFxBss78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HpjKeBdG; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b802d5e9f06so751831666b.1
        for <linux-pm@vger.kernel.org>; Sat, 10 Jan 2026 08:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768061637; x=1768666437; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Za5zkOXc/pUTKApHzs7ZvT3Vilb+ymesEJJeGab5uBU=;
        b=HpjKeBdG1Tzm60BS2k4E+4mTnOjtUQs2/CueCPGiWyXiJmSSabTBO0DvQhD7YGm4S6
         yi5zkvKBoFnjOpyy3683AHEP8+odRx3EpTrXSQ1S4Jrm4uLbfBHxly25l7h7hV7bcFXd
         0NmXlCodoh+eVzWUB8vVbuOc4miE9xWuUa1WeZOILX4BWNKLDt4qfPfa++INvNYFdMfd
         +E9hNxg7awFj+5+4Uh9cBlsFQO8o75df5+KZ0QVyapa3yabm2SGKRZg6M3isjAhIymii
         YDeUWGn30HxJm/1bUjyP5vAuWRUeMn1CCSRitnnPzGZn+lOXq84sw+3IJIjE1y05KJKa
         iFAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768061637; x=1768666437;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Za5zkOXc/pUTKApHzs7ZvT3Vilb+ymesEJJeGab5uBU=;
        b=VLWQFYBl4TAorGUBRP9/sRlORh/LTpy4MDkXCF7HpEHV0uiuJE//5yKxOG4okZZxtw
         5kRgmCE6wnlCDt6o/49surXhFG1EjHmS7Vg9Y5S4QUmpPO+MVo3SJCin1ErdKIeQFwSz
         I3gr1k3PjCJFngDViEfoA1436mi/d+sIMo/GSJBP9p+uSlirXTjOZWOzzloZwXmdFylo
         ggTcanaqxL2nXwku5WG6oew8e13WZ3WQTma/aVYpg5ebG5vYegvXBPQqs90Bg1Jm0aEq
         ADbaU3SB3li3h3696QHu/lln+iW00bag/uAAN32KfEwdD9TdNcW6/XHIR20tfR8hYRg0
         f51Q==
X-Forwarded-Encrypted: i=1; AJvYcCUsaItk6TY2+z/0KmGPPwQ2ZzW5rB5qrRmS48yeGCwVvKGHhiQa9cgMqzpxcmeE1rvDSDv1kl81pA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxdbUMvvK+tkjOi/fbwMbQojIduyz9sKF/Vf0XquHS5QGyF4U2A
	dzrRlsG6ngT6zBdyPpsdGFOSk9fsNuMujXGI25ksKseTayf/4DmACepXH5lXCZk5xoU=
X-Gm-Gg: AY/fxX6h96ywAM7afBkgeLrwBjjaHRfMdr15Y7vDh7OSaOp2ZOY17qo9wTsSogqBKHl
	xLzK6gwjGL0ulnDQHfzy7bGTXM4M7F/nheEme8TwX2DqadbOBfC9fDat7dB/g2fmKzjM7nQGANi
	nPvwdWnrk1L10H+bCF+hz7XzbTeQ1v5ACZ2xbYcyPiho9ZhCf9iMK/kd8GkAMKU37x9wr1zOtBU
	gZPAMZBU53YQvaoGkzlN4KVviI8luKGur7pd0LEPW13mEs21WsC2OeC8/mcdnTnHi6zYmIFYuGo
	e1SHP28oUegNKwfdCnVwHX8Wy0fMld6pdoZIGp3ngHPggTkIdc+gcpDtbGooXuj30578h64h+k0
	lIhDqg9sHgqynE4l67TGrhpNLSna4LEjGwWIQ1OMYa1GbkF4MLHrIAqnGV7RaU3vY3YbhLixY/9
	DWHfozUEO0VrA73zK60hDP6SJ5Fhhimrn/ugVlyVGo8yFj/TeUJhyFQPppELCQFdJIHKajCxVb3
	4Ky
X-Google-Smtp-Source: AGHT+IEUIfkx8+lGVACl9YjDlxYymQluSPmgIIVsmxsUKIPlcHRtxRGZm5IY8ly5yIKe9vinZeykRg==
X-Received: by 2002:a17:907:970c:b0:b80:1348:226e with SMTP id a640c23a62f3a-b844532ae89mr1390302166b.33.1768061637487;
        Sat, 10 Jan 2026 08:13:57 -0800 (PST)
Received: from ?IPV6:2001:9e8:17d0:db00:2109:890f:3eab:3c56? ([2001:9e8:17d0:db00:2109:890f:3eab:3c56])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8701e1d467sm79351266b.70.2026.01.10.08.13.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jan 2026 08:13:56 -0800 (PST)
Message-ID: <2a39719e-e73b-4558-95fa-d54f94c43220@linaro.org>
Date: Sat, 10 Jan 2026 17:13:55 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/8] Add RemoteProc cooling support
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>, andersson@kernel.org,
 mathieu.poirier@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
 rui.zhang@intel.com, lukasz.luba@arm.com, konradybcio@kernel.org,
 amitk@kernel.org, mani@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20251223123227.1317244-1-gaurav.kohli@oss.qualcomm.com>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20251223123227.1317244-1-gaurav.kohli@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/23/25 13:32, Gaurav Kohli wrote:
> This series introduces a generic remote proc cooling framework to control
> thermal sensors located on remote subsystem like modem, dsp etc.
> Communications with these subsystems occurs through various channels, for example,
> QMI interface for Qualcomm.
>   
> The Framework provides an abstraction layer between thermal subsytem and vendor
> specific remote subsystem. Vendor drivers are expected to implement callback
> and registration mechanisms with cooling framework to control cooling
> devices.
> 
> This patchset also revives earlier discussions of QMI based TMD cooling
> devices discussion posted on below series by Casey:
> https://lore.kernel.org/linux-devicetree/20230905-caleb-qmi_cooling-v1-0-5aa39d4164a7@linaro.org/
> 
> That series introduced Qualcomm QMI-based TMD cooling devices which used
> to mitigate thermal conditions across multiple remote subsystems. These
> devices operate based on junction temperature sensors (TSENS) associated
> with thermal zones for each subsystem and registering with remoteproc
> cooling framework for cooling registration.
> 
> This patch series has a compilation/runtime dependency on another series [1].
> 
> [1] https://lore.kernel.org/linux-devicetree/20250822042316.1762153-1-quic_gkohli@quicinc.com/
> 
> Casey Connolly (2):
>    remoteproc: qcom: probe all child devices
>    thermal: qcom: add qmi-cooling driver

I'm glad this series is getting revived. It would be good if you could 
explain what changes you made to my patches somewhere.

I also remember one of my patches adding the DT parts for SDM845, would 
you be willing to pick that up for the next revision? I'd be happy to 
provide my Tested-by.

Kind regards,

> 
> Gaurav Kohli (6):
>    thermal: Add Remote Proc cooling driver
>    dt-bindings: thermal: Add qcom,qmi-cooling yaml bindings
>    arm64: dts: qcom: Enable cdsp qmi tmd devices for lemans
>    arm64: dts: qcom: Enable cdsp qmi tmd devices for talos
>    arm64: dts: qcom: Enable cdsp qmi tmd devices for kodiak
>    arm64: dts: qcom: Enable cdsp qmi tmd devices for monaco
> 
>   .../bindings/remoteproc/qcom,pas-common.yaml  |   6 +
>   .../bindings/thermal/qcom,qmi-cooling.yaml    |  99 ++++
>   MAINTAINERS                                   |   8 +
>   arch/arm64/boot/dts/qcom/kodiak.dtsi          |  36 ++
>   arch/arm64/boot/dts/qcom/lemans.dtsi          | 138 ++++-
>   arch/arm64/boot/dts/qcom/monaco.dtsi          |  92 ++++
>   arch/arm64/boot/dts/qcom/talos.dtsi           |  23 +
>   drivers/remoteproc/qcom_q6v5.c                |   4 +
>   drivers/remoteproc/qcom_q6v5_mss.c            |   8 -
>   drivers/soc/qcom/Kconfig                      |  13 +
>   drivers/soc/qcom/Makefile                     |   1 +
>   drivers/soc/qcom/qmi-cooling.c                | 498 ++++++++++++++++++
>   drivers/soc/qcom/qmi-cooling.h                | 428 +++++++++++++++
>   drivers/thermal/Kconfig                       |  11 +
>   drivers/thermal/Makefile                      |   2 +
>   drivers/thermal/qcom/qmi-cooling.h            | 428 +++++++++++++++
>   drivers/thermal/remoteproc_cooling.c          | 154 ++++++
>   include/linux/remoteproc_cooling.h            |  52 ++
>   18 files changed, 1981 insertions(+), 20 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml
>   create mode 100644 drivers/soc/qcom/qmi-cooling.c
>   create mode 100644 drivers/soc/qcom/qmi-cooling.h
>   create mode 100644 drivers/thermal/qcom/qmi-cooling.h
>   create mode 100644 drivers/thermal/remoteproc_cooling.c
>   create mode 100644 include/linux/remoteproc_cooling.h
> 


