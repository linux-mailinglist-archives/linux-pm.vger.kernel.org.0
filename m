Return-Path: <linux-pm+bounces-18450-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEDA9E1B5B
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 12:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8E94167B52
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 11:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54091E492C;
	Tue,  3 Dec 2024 11:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X0Bu4nmo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE3A1E5027
	for <linux-pm@vger.kernel.org>; Tue,  3 Dec 2024 11:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733226717; cv=none; b=n28PNGD2yUe6OHhnXpWJjxNAqgb8qW0cvBuvow5xuyqj/eoV3CRs5G2kDGyOo7DT1iEAVRqGcmn67nU9ZGeKBpuTR+/sebikUfWSC/+96gyMWJmmhKE+Xp/otlal2ZftaEmiXRD80tkd05lnxl63fYCbC+WPyumpBhjTxSshCk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733226717; c=relaxed/simple;
	bh=xODsXxgFfNZd8MjPBZGqmi3sIBbEKRslq024Q4XA774=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eZ2HNfuXa7RWvgT/Jt7+mDdc43fAar2R6P5ts0pl8Q2peKnpCz5krouMZ655pVeW4MiCG7ULeInjeUt29M509H9NWUVGPRGxOjfuK4HS6usxkE99aOIY6PP6zSV7CCRpMBp4XdhMUsGB3HmCgDKxXgGD1c4JpzyzzPAKrwWcxg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X0Bu4nmo; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e39841c8fd6so3908649276.3
        for <linux-pm@vger.kernel.org>; Tue, 03 Dec 2024 03:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733226715; x=1733831515; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jJmN9vm0KKdkbgYJY1kJ2PT7vRHayhKSRB17RM5kC5E=;
        b=X0Bu4nmocEtYnkYNZV3jm3+ODoDpXf7OFUSD4BK/eNEAnGS92mxk0QKcWlfWaqd/t0
         bKan83juUuc5txilEUJnJKr266BkeuwZs11HmnfIIFId0bUZK942UkyzZjafisK9doDa
         5uB31FoFPQSAcVIMtrd3oHZZEFpZAdOUXNu46lVNiBlb2B8OF9ub7va69WFNwxtQmIaU
         vTMyZCyG3++mj5oF+xqTNthMlYM4Untn1TvWhS/s5z0QjaD1NKuD8Vwz6cCO6E/OTwRr
         pVI3kW668KSehmrYZZye/FIFtvSjCLqF5ROYDf4byEq7/hFVlyROhu7oO+AjQ7lkRd4G
         MJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733226715; x=1733831515;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jJmN9vm0KKdkbgYJY1kJ2PT7vRHayhKSRB17RM5kC5E=;
        b=Wg4AZ9hCb9EJwXS0RLwWm9MYa1uBsTHEaqdxWUQkpcN3naVx3idC+QlF75vz+6Lfz5
         OVWXLg2FDtuGKe9Ic8QPZbWHvCnnknhPSEv2cRXxGFxYBDWnyI5/kmVXdob7X2RDwM9S
         mHLVtX3VPv4T8O4oskaquSz7aLgwI8S1EUjqWPqlofnDuhkDwJZPwE61oAC9fltjQWL5
         +QE5oqUsvFrz75NI4Sh65w1XyYRSpYv93jzlfpP3oGCRrcav5KlPN4Nhs0kI1fpBrYzy
         P1ylxLWloSJQp02NZV4EpK4fO42Jt5l9os2sDIGYLUuTlPE0dMLwoK6cZupaK3G3Wren
         LUsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVl0o25BHKibqYjFpnTt5s2sgQdrQDo5ylrgtmtjhSemxicHBgum3uBOPXuwyucMXs7o6jJeLD7Bg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8CtG19MvvrZ6yiiQZtfkXzXNyMEf99rcfcl6BjkyQMd9Axv7D
	amTZDFyOU1dZwwswCs5LtEkR8Tgm13Rqcc/XGrPq6lwIHonwNbAIFvn58BXGE6Q1S3PUYgGWf6X
	q8LCx3YdB09bpEF5V9DxOka6L8jhg5sxT2AluCQ==
X-Gm-Gg: ASbGnctVscxC8ZhLGsfSqC1TfG+LTcExqCCxxHwfSYlIAph9malqUiVa7OCSsOZhPpt
	04IE/E7VLSCj4GE7/TiajFnr/zEx+4w==
X-Google-Smtp-Source: AGHT+IEjsHAYwArBu8zqyJKRiaq0r1rzH6TwAontXOXbJw7jEjz6js3BPKBbGiqM6LVavcAfeIYgmun7BtLOfMgwhmU=
X-Received: by 2002:a05:6902:150d:b0:e39:772b:4bae with SMTP id
 3f1490d57ef6-e39d39ee384mr1903823276.6.1733226714940; Tue, 03 Dec 2024
 03:51:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112003017.2805670-1-quic_molvera@quicinc.com>
 <20241112003017.2805670-3-quic_molvera@quicinc.com> <em4vkg4totsg435s4usu7kqn45vfqfot2j7sikzmnof2kkyidi@26b6kkpz7z4c>
 <0ca812e7-bf5b-463a-83dc-9195aee14589@quicinc.com> <828dbdb1-d987-43e6-8cd1-7ba267da9e67@quicinc.com>
In-Reply-To: <828dbdb1-d987-43e6-8cd1-7ba267da9e67@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 3 Dec 2024 13:51:46 +0200
Message-ID: <CAA8EJpqPRpV_aGH_LHoG8EWkaQ_tCR3u0jM3C_jXKowCAUEqPQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] interconnect: qcom: Add interconnect provider
 driver for SM8750
To: Melody Olvera <quic_molvera@quicinc.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Adam Skladowski <a39.skl@gmail.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	Sibi Sankar <quic_sibis@quicinc.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Vladimir Lypak <vladimir.lypak@gmail.com>, Danila Tikhonov <danila@jiaxyga.com>, 
	Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Rajendra Nayak <quic_rjendra@quicinc.com>, Mike Tipton <quic_mdtipton@quicinc.com>, 
	Abel Vesa <abel.vesa@linaro.org>, Trilok Soni <quic_tsoni@quicinc.com>, 
	Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Dec 2024 at 00:04, Melody Olvera <quic_molvera@quicinc.com> wrote:
>
>
>
> On 11/18/2024 10:01 AM, Melody Olvera wrote:
> >
> >
> > On 11/15/2024 7:27 AM, Dmitry Baryshkov wrote:
> >> On Mon, Nov 11, 2024 at 04:30:17PM -0800, Melody Olvera wrote:
> >>> From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> >>>
> >>> Introduce SM8750 interconnect provider driver using the interconnect
> >>> framework.
> >>>
> >>> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> >>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> >>> ---
> >>>   drivers/interconnect/qcom/Kconfig  |    9 +
> >>>   drivers/interconnect/qcom/Makefile |    2 +
> >>>   drivers/interconnect/qcom/sm8750.c | 1585
> >>> ++++++++++++++++++++++++++++
> >>>   drivers/interconnect/qcom/sm8750.h |  132 +++
> >>>   4 files changed, 1728 insertions(+)
> >>>   create mode 100644 drivers/interconnect/qcom/sm8750.c
> >>>   create mode 100644 drivers/interconnect/qcom/sm8750.h
> >>>
> >>> diff --git a/drivers/interconnect/qcom/Kconfig
> >>> b/drivers/interconnect/qcom/Kconfig
> >>> index 362fb9b0a198..1219f4f23d40 100644
> >>> --- a/drivers/interconnect/qcom/Kconfig
> >>> +++ b/drivers/interconnect/qcom/Kconfig
> >>> @@ -337,6 +337,15 @@ config INTERCONNECT_QCOM_SM8650
> >>>         This is a driver for the Qualcomm Network-on-Chip on
> >>> SM8650-based
> >>>         platforms.
> >>>   +config INTERCONNECT_QCOM_SM8750
> >>> +    tristate "Qualcomm SM8750 interconnect driver"
> >>> +    depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
> >>> +    select INTERCONNECT_QCOM_RPMH
> >>> +    select INTERCONNECT_QCOM_BCM_VOTER
> >>> +    help
> >>> +      This is a driver for the Qualcomm Network-on-Chip on
> >>> SM8750-based
> >>> +      platforms.
> >>> +
> >>>   config INTERCONNECT_QCOM_X1E80100
> >>>       tristate "Qualcomm X1E80100 interconnect driver"
> >>>       depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
> >>> diff --git a/drivers/interconnect/qcom/Makefile
> >>> b/drivers/interconnect/qcom/Makefile
> >>> index 9997728c02bf..7887b1e8d69b 100644
> >>> --- a/drivers/interconnect/qcom/Makefile
> >>> +++ b/drivers/interconnect/qcom/Makefile
> >>> @@ -40,6 +40,7 @@ qnoc-sm8350-objs            := sm8350.o
> >>>   qnoc-sm8450-objs            := sm8450.o
> >>>   qnoc-sm8550-objs            := sm8550.o
> >>>   qnoc-sm8650-objs            := sm8650.o
> >>> +qnoc-sm8750-objs            := sm8750.o
> >>>   qnoc-x1e80100-objs            := x1e80100.o
> >>>   icc-smd-rpm-objs            := smd-rpm.o icc-rpm.o icc-rpm-clocks.o
> >>>   @@ -80,5 +81,6 @@ obj-$(CONFIG_INTERCONNECT_QCOM_SM8350) +=
> >>> qnoc-sm8350.o
> >>>   obj-$(CONFIG_INTERCONNECT_QCOM_SM8450) += qnoc-sm8450.o
> >>>   obj-$(CONFIG_INTERCONNECT_QCOM_SM8550) += qnoc-sm8550.o
> >>>   obj-$(CONFIG_INTERCONNECT_QCOM_SM8650) += qnoc-sm8650.o
> >>> +obj-$(CONFIG_INTERCONNECT_QCOM_SM8750) += qnoc-sm8750.o
> >>>   obj-$(CONFIG_INTERCONNECT_QCOM_X1E80100) += qnoc-x1e80100.o
> >>>   obj-$(CONFIG_INTERCONNECT_QCOM_SMD_RPM) += icc-smd-rpm.o
> >>> diff --git a/drivers/interconnect/qcom/sm8750.c
> >>> b/drivers/interconnect/qcom/sm8750.c
> >>> new file mode 100644
> >>> index 000000000000..bc72954d54ff
> >>> --- /dev/null
> >>> +++ b/drivers/interconnect/qcom/sm8750.c
> >>> @@ -0,0 +1,1585 @@
> >>> +// SPDX-License-Identifier: GPL-2.0-only
> >>> +/*
> >>> + * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights
> >>> reserved.
> >>> + *
> >>> + */
> >>> +
> >>> +#include <linux/device.h>
> >>> +#include <linux/interconnect.h>
> >>> +#include <linux/interconnect-provider.h>
> >>> +#include <linux/module.h>
> >>> +#include <linux/of_platform.h>
> >>> +#include <dt-bindings/interconnect/qcom,sm8750-rpmh.h>
> >>> +
> >>> +#include "bcm-voter.h"
> >>> +#include "icc-rpmh.h"
> >>> +#include "sm8750.h"
> >> Nit: please merge sm8750.h here, there is no need to have a separate
> >> header, there are no other users.
> >
> > Ack.
> >
> >>
> >> Also, is there QoS support? I see no qcom_icc_qosbox entries.
> >
> > Unsure; will let Raviteja comment.
> >
>
> Spoke w Raviteja; looks like he wants to do this later.

Will that cause bindings changes?

-- 
With best wishes
Dmitry

