Return-Path: <linux-pm+bounces-17685-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 000FA9D0864
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2024 05:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F566B20F61
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2024 04:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D2113957E;
	Mon, 18 Nov 2024 04:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B4/KSTPC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE61225760
	for <linux-pm@vger.kernel.org>; Mon, 18 Nov 2024 04:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731904164; cv=none; b=JkZ9QIz9xRQbvGV6EADVRVV8aSPAflUDRLTFQR1fi5gWH5dj3fzwNbDpyTCAXwqOvezsg++hx1X9/vCdxpwSiXXkSdwBD31w30NRAztTqEAf8DBmbJ7+x0C9RqjBIQGQlfgq5Avdsvm0PUNa0Ls9lcUYpbK7YbNpx0rA+MLQcF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731904164; c=relaxed/simple;
	bh=c2FNU8VAqZPHoHfsNxtkxDSwUZw0mk7UWoaRmwhIM8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VYFaTYlBA9p1nJghVRwb7Wqp8WOwPvuS1qRMztO/FLsTXHqAyEBcVm7obtPzfsnpePNvXuAu4m5AoOfbPXmtoTyaPkaLtrvznyPYpDeMpdjl5qsImZvhXO7hCfFgK8ej+md5fJ4YORLOe2cpgBVH6FMcXZyzwDDxxPZAQZUYq60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B4/KSTPC; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7f809332ffcso2504197a12.0
        for <linux-pm@vger.kernel.org>; Sun, 17 Nov 2024 20:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731904162; x=1732508962; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aRkzvR9JmsuEZqEzWfsXbEtv0Qql+USooOaHLs0v1jE=;
        b=B4/KSTPCoshvGy7HGueX5eUHsNduJli91Wg+XW6TeBtPz9u9s0CPr2RnkA+9nJ5Kbh
         vXF5pdaT4LcQrl5CyOLfRdnHwPfVe0SU4qE/lG+FKnCE5fUjH1MYjdX/Teab3z5ttW2V
         Ek14xJdvbrn2Sm8gVSudv2ds8lJ0cswybPtNNTAQhvcd7wEBCMsvsESv32kkBxXRM1DY
         /CGEVS7nswWVFexy56CNXFjgGLY2fEHDcDMr7W90kn33hYWG3UtEvoYugjbxDbhY54WE
         u+xxCe9qOm0WAW30HnHbJ8I7cgoPfpKg28em+s9yxjPpwW1Sc8Uw4Q5HBW6yrEMOaoJN
         W6qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731904162; x=1732508962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aRkzvR9JmsuEZqEzWfsXbEtv0Qql+USooOaHLs0v1jE=;
        b=MvN3gTR4RxMI3BELzPemuTjKIFcm/Wj+IjKsyI0Y68v3hcc8FLoPcpA4IWMzgWD6sO
         uMoKRkKYOSbDNLD56cCmLPNSdOmF1d6d2yNj0pqoFnfDNnVC75EscOY/EU5O+AcTzQP7
         HD9oewbQ85QpNvO5DdV563WsGs+CgzqT/7gl1h4SeeCLSXzlQlWVZ5nX7Phaa2TJ0u5n
         TFeaQk3ROmvqylqnyqDwc4Gda/AUHnW/6INV0BjGXm2Zav6IOVFp9BZjYkbdPuM0A7A5
         jYk1g669E13IFiEHtJptRjob6l1zPE3QDjalMHH+7cWGSwUh8yyKwOPUKvGla5e1CeRm
         TUOA==
X-Forwarded-Encrypted: i=1; AJvYcCV8WJ+M4wrOTLUY1Gg20iKtKi23HgddHWShVNobQjWcbooT1qyJ0G8dV6YZGtCKQZqVN051p8MjzA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKeBDwdqqiMH2bZfFtotNGiezF5lXv/GyxDye5p1RTDSajlNau
	bhh67rMy36HW4KLnz64QOsjoCdtUcPdHyWh9dIaGCd6NgIRchLcW8kuiKgwAhJs=
X-Google-Smtp-Source: AGHT+IHXV546gfhTrcSiQ/5TtpVxbP+9uPHavmMf9YaowqUBMk7FcaExC7jCPXHHNGj4K/9+30ugTQ==
X-Received: by 2002:a05:6a20:7292:b0:1d7:e76:6040 with SMTP id adf61e73a8af0-1dc805101d9mr26904641637.4.1731904162120;
        Sun, 17 Nov 2024 20:29:22 -0800 (PST)
Received: from localhost ([122.172.86.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f8c1c16d0esm5016479a12.6.2024.11.17.20.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 20:29:21 -0800 (PST)
Date: Mon, 18 Nov 2024 09:59:19 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 0/2] Fix SC8180X cpufreq dt-bindings error
Message-ID: <20241118042919.cakfxwr6xkszxir2@vireshk-i7>
References: <20241116-topic-sc8180x_cpufreq_bindings-v1-0-e7db627da99c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241116-topic-sc8180x_cpufreq_bindings-v1-0-e7db627da99c@oss.qualcomm.com>

On 16-11-24, 12:31, Konrad Dybcio wrote:
> Add the bindings and dt bits to fix:
> 
> cpufreq@18323000: compatible: 'oneOf' conditional failed, one must be fixed:
>         ['qcom,cpufreq-hw'] is too short
> 
> No functional changes.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
> Konrad Dybcio (2):
>       dt-bindings: cpufreq: cpufreq-qcom-hw: Add SC8180X compatible
>       arm64: dts: qcom: sc8180x: Add a SoC-specific compatible to cpufreq-hw

Applied. Thanks.

-- 
viresh

