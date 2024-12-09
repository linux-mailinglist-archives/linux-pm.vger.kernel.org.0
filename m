Return-Path: <linux-pm+bounces-18811-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1EA9E9106
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 11:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FF122813F9
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 10:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9320216E28;
	Mon,  9 Dec 2024 10:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cJ3NfQyg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3699D189B85
	for <linux-pm@vger.kernel.org>; Mon,  9 Dec 2024 10:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733741780; cv=none; b=prErrBywYdElS6lWNpHdhSecZ4A8DgM+ntbbn9NRUlfOCQjYkVjFohzrEMh9PsDaBjLLE44g3lNzV0SaP/Y9nuKBzvcAF7gpl3OR4QuEtzRI0Ckh3TaMz6IGcgsqunSzVhse/sQCjrOky/AGw5AtGB9HBxKOphS5o/dcMI+kl/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733741780; c=relaxed/simple;
	bh=MvjEr+QmcBYSFD+4yOMfFy5J+y5/erO43wRjxGBp134=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JyZNU8z+y7+UrVX5SJ1ubsBFH+5sJqn3djtef5sSWq4aDb+rp6pakrmYm7rnuzxcWd3kGz5UMplGaEcYOG/9jEkO7HYY/kWa9//n4taz0FZnU4bpTQKPxYP+06EhBJ6qV5vLCohRrrqnPGFeeQPwHi1TzYpSOpjDcxbDQ3hb1xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cJ3NfQyg; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5401c37d8afso1100278e87.1
        for <linux-pm@vger.kernel.org>; Mon, 09 Dec 2024 02:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733741777; x=1734346577; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s1LCGkepE9BNY41wwancZQPMjgbX9qpsMb1C/mBNuBo=;
        b=cJ3NfQygvrCnHUz1YhqypYJYiFuhT4uUwvhmpez3mjHDRzZZRMBdFD3aBlcQocSGVP
         QMi9lDv2NlEC9MDche/rEAOuJn0/+NKCZUQaM3JZvP/s0eavqk9x/oZQ4/8i0OwnNJ79
         y7OWe777vevFgqZ4gsWQJG1FpXm50ZYyihn5tOKOw6sqz/MX7fJW1/rQru9iQDUpLZc2
         gSgyqQQAM9ODTyP99A1dr+DRz2hUgN5NXcaPNJv7NREy0v+kAma9Zaj3qbG9AqFLpkC/
         yyrxMf5SSXNA24r+g0+leBQupql+B1aG1LhQANzOnk9wwS880CRLDnL/cUHnEhSPFNmX
         9w8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733741777; x=1734346577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s1LCGkepE9BNY41wwancZQPMjgbX9qpsMb1C/mBNuBo=;
        b=cQLOTkv4TOXMpHFahNHwWmR3Jz2QkuM8pnehydl3xR8Q6x657uTxu7DYb+yHT9IWn8
         BPPqux4frLL0CobKrt1PsHJS1xsHkRRekkiaTQcNSOIQnwxe/0FBRD8ArfLm9guXodW+
         bSFMeHort3f/D4mJjuV1FbYrvD4mxjMfrrikeJkSaUumAbVSSb2QtC4lHWD88a6BD0+e
         ArocHbB7i4VQjR+hyK+3eNRWkRHSFZyJuDoW7H8BrHShV8cN1AvDt57VdPjIaaAu9kel
         FdbIahHPgtCCbGFUpy1fOyJlV6c/9QGpr1z+iGquvvmTTJlKKZZMl8aoLwjFv+XmfOvT
         SXNg==
X-Forwarded-Encrypted: i=1; AJvYcCWwKlxdGAcT8pKiTXqzKoU0M+bmMPIim3PNnTq2Dvw2V1ALZHzZM8H0aVFaDEIaHprW1Mws064jmg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4FvHCngstAZDSpLa4peXFnll9IyrpXpHmniYTADj7hugwxds9
	6xoDqRZR9zP5+fqjO240bBTSdOExaRi4IZFCY9UthIDiajn8SCoPwMBPydJYvJ8=
X-Gm-Gg: ASbGncuuVBFC64d8FD7EArM4PkwF7M7qW67pER2B72SJ3X7Yx5CojYmpWG8W/5PSnis
	Q34N03jH0duC45vQN4Sw47krTOvc21Ng/M8JQEvezpFVpRzktfc1wAtljdhPhZ2iLp9Bh0CMW20
	/DhXvwp2ijkx+rt1UNmoTx9H0jxPcxor3/cAuecbysOB5dGL4Au28teZYJMFEHTCuQkZVylnuGj
	kl+H8HgPKq4q1XTy8IZgPiO8D8h1HVzjNzrQZPOUoRN7YsO63e07TYHYQdqIl+sDw+eR5VXlViy
	rKaLrDdMiVUrRhDrZj9LUOdyurx2Iw==
X-Google-Smtp-Source: AGHT+IHLQhW4yrOheTO3FKBH2BMc3+YO6hNqRhmWtxjdDrWhydjjQ8nuO7eWSOcahHRapkZ5ee4u3A==
X-Received: by 2002:a05:6512:3990:b0:53d:a321:db74 with SMTP id 2adb3069b0e04-5402411a69cmr1638e87.50.1733741777425;
        Mon, 09 Dec 2024 02:56:17 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e3745b0bbsm930193e87.185.2024.12.09.02.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 02:56:17 -0800 (PST)
Date: Mon, 9 Dec 2024 12:56:15 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 2/4] arm64: dts: qcom: qcs6490-rb3gen: add and enable
 BT node
Message-ID: <cros4yf4mwtu24xdpevpixlmtt5si6ywjzacezemhsmkfsomgx@gtjaznwqvjsm>
References: <20241209103455.9675-1-quic_janathot@quicinc.com>
 <20241209103455.9675-3-quic_janathot@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209103455.9675-3-quic_janathot@quicinc.com>

On Mon, Dec 09, 2024 at 04:04:53PM +0530, Janaki Ramaiah Thota wrote:
> Add the PMU node for WCN6750 present on the qcs6490-rb3gen
> board and assign its power outputs to the Bluetooth module.
> 
> In WCN6750 module sw_ctrl and wifi-enable pins are handled
> in the wifi controller firmware. Therefore, it is not required
> to have those pins' entries in the PMU node.
> 
> Signed-off-by: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 168 ++++++++++++++++++-
>  1 file changed, 167 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

