Return-Path: <linux-pm+bounces-14010-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C778D975009
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 12:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F70B28D5F4
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 10:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FB118593F;
	Wed, 11 Sep 2024 10:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kmbDiOe9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F43F184537
	for <linux-pm@vger.kernel.org>; Wed, 11 Sep 2024 10:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726051723; cv=none; b=BjVaNIumeu/D50Kcez1v0hP7iIOPzmaGDRzm30kB53FIYXm5M47D4AjgrsqN52BeMZkTKm6I2q/mzLvUqyLuplnPyoKdN6xVP8rCAXAUEQc3Nr1+UuBv9SKAcjRB+tKEsEv6MBj7K+85KWbbIeurDGift9UON/RkHI3AugyN/i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726051723; c=relaxed/simple;
	bh=DaYoPeJg9shuCtx4J1jS+goJUrZrFxkVlSXl6dreLv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fD4zEZrWuz17sXQkpnhoYaAinbIasmVchUcO/Tuyry6CdeCxD23MsvpKVANvQH5HvRv4b4cTd3VyWtL7wIg+b/TdvAYnsrlejYm5PwfyfdufN7jqf/JLrLQi/HYGhwvSyosEmlDroAHJRyNMwsETfw+Hjjc5FyQheDMcNdI61ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kmbDiOe9; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f75aa08a96so20858101fa.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Sep 2024 03:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726051719; x=1726656519; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xfOyw78Q7NNMTmln4lOFjsc2BJzJJyhZKXZ24axVdKQ=;
        b=kmbDiOe9yuyvgoiqx/32ejPtvqGWjZURAKk6YLMJe2daVekcyqVMOXpN5MFA2mzKLb
         4dWwgsEiXKy0spk6c3pNMLDb7Z7a+HMrX7cmf6PxI+hzhAQbyZlUCrNH8XvFl22Ons9B
         rl83cQPlu6fFE/zPtUFKlLOupfaz6AADsDiSx0HTpyK0k4MoTLyn7XiSMaCaN7yWW/HT
         w2cBj1RKz4GLwjeCt+dhJZXA0fiktrYdsS76rxFl3PTnFQgds3IcNwnyEStyPo8wG96s
         KdZPgpAn86cwn2aEMVTeQP7iywE1c6bvC/ooHwY3a6d4sSuEsmpQC4FT5M6WwiRoFpTh
         jcvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726051719; x=1726656519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xfOyw78Q7NNMTmln4lOFjsc2BJzJJyhZKXZ24axVdKQ=;
        b=eGZsM/DFnkyuWTM5sHtcnCaIAZvoNmbF/0KYvkblHqTH74ChUVbO0xf2JVqGTm5A7D
         OPssI45snxT+3hVav73qO2CfoABVhTCaMdfpx9X+3eafET+StxBzRLCbTtO79/fL51eM
         b3wVZZzQ6OXl9l0F6SP7j23FQZggl70zNMoJyMyAqhgGlHaCfhi4VQcprYzsy16pspA0
         7fnINRyxJu9ha3mcmh33dLQfcuLljsaWsS4UYGpW9z1yOy/hgRNtkWWGCULJPMzX/itc
         UF8IkOXxGNkv5+lmuCefLcNTHR0e1QkdxjBdrILQntPv7Qj6SXWjXdXW/lgbDKXLyZrV
         TxrA==
X-Forwarded-Encrypted: i=1; AJvYcCVPwdrWQTTSMygMvdpEDDYMbzAJL39x8ldibk12sia9kM1ourgEdNEfV0q293XBujZNBerFZlHqXg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyjVxqQICTD8NWJNYZflvUQ1Y5ilTgX8r0rm4HFHOpMS6JVj6Hf
	6zdCG/0m47k7yB1NFkHXgTwl6KCd/mTRK22PQv2Svq0x4EqeGcOaAf4j29Hh/Ek=
X-Google-Smtp-Source: AGHT+IFmPMxpL0sfW2aEQVWqW2rvHHyXYZsNZluRoWH8pk2J0ZkdsSyNGv+Nxad6h/EbFiV9iGvsOg==
X-Received: by 2002:a05:6512:1107:b0:52e:be84:225c with SMTP id 2adb3069b0e04-53673b6b445mr1852457e87.33.1726051718895;
        Wed, 11 Sep 2024 03:48:38 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5365f870baasm1520467e87.96.2024.09.11.03.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 03:48:38 -0700 (PDT)
Date: Wed, 11 Sep 2024 13:48:36 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Stephan Gerhold <stephan.gerhold@kernkonzept.com>, Danila Tikhonov <danila@jiaxyga.com>, 
	Adam Skladowski <a39.skl@gmail.com>, Vladimir Lypak <vladimir.lypak@gmail.com>, 
	Andrew Halaney <ahalaney@redhat.com>, Odelu Kukatla <quic_okukatla@quicinc.com>, 
	Mike Tipton <quic_mdtipton@quicinc.com>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 2/2] interconnect: qcom: add QCS8300 interconnect
 provider driver
Message-ID: <3xjvx2kwrlruhhxw4aald26qjf5fzikay2ypzr3mwv75mlmf5q@lmn2o64npfg2>
References: <20240910101013.3020-1-quic_rlaggysh@quicinc.com>
 <20240910101013.3020-3-quic_rlaggysh@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910101013.3020-3-quic_rlaggysh@quicinc.com>

On Tue, Sep 10, 2024 at 10:10:13AM GMT, Raviteja Laggyshetty wrote:
> Add driver for the Qualcomm interconnect buses found in QCS8300
> based platforms. The topology consists of several NoCs that are
> controlled by a remote processor that collects the aggregated
> bandwidth for each master-slave pairs.
> 
> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> ---
>  drivers/interconnect/qcom/Kconfig   |   11 +
>  drivers/interconnect/qcom/Makefile  |    2 +
>  drivers/interconnect/qcom/qcs8300.c | 2088 +++++++++++++++++++++++++++
>  drivers/interconnect/qcom/qcs8300.h |  177 +++
>  4 files changed, 2278 insertions(+)
>  create mode 100644 drivers/interconnect/qcom/qcs8300.c
>  create mode 100644 drivers/interconnect/qcom/qcs8300.h

The driver looks pretty close to sa8775p one. Would it make sense to
have a single driver instead? Or would it complicate things
significantly?

-- 
With best wishes
Dmitry

