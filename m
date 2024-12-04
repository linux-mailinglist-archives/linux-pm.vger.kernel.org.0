Return-Path: <linux-pm+bounces-18587-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E37B9E47B9
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 23:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45C9928554B
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 22:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B975E1F03E2;
	Wed,  4 Dec 2024 22:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dmxe6/43"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC3B1C3C03
	for <linux-pm@vger.kernel.org>; Wed,  4 Dec 2024 22:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733350871; cv=none; b=mgut4ujdm9X6EK8oeteVTCb3hEu0zdZ6M9+g+P772jXwXVVks/XOheaKwDhDhKYqhNXHyMZgxZGRRqYhNbLwgoCvseWRW4KiscX6KKxgtYhCwtiXpS0leO8JDtUvvKqOjQsB0l65xSTFtGWode6lZ9VIMICwhlh3Cl3Pb9Sclz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733350871; c=relaxed/simple;
	bh=1XfksjHiUmLDBwfWEVhZRw6suaxhtKcDRmMSFnlRbIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SL29CWStRDyT25mJ5Q1uGQaDmINdChwdyVBjatJf3vcwci+2fhJP8tKyYbH/07g8U6NHgdDMJMMedCY/59jIqWKVn+TBivNfvNKP0OfIJaDbR95tEUPoJp+T4CsM9iejktIGIWtdK8OE0TEOJ+32yX+IK0pTYXrJhMXWmqKH4+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dmxe6/43; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ffa49f623cso2297061fa.1
        for <linux-pm@vger.kernel.org>; Wed, 04 Dec 2024 14:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733350868; x=1733955668; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OH4y0lMP3bH1lveKpeX+aBwZ95mtO7UpbBtdFwlO2l8=;
        b=dmxe6/43c5nCrEDsG3SuGqFFn2sZ5xxLPNi64hW6yfrIbDLs7Mmwrz+Qocjc1aNx+e
         zKfk5JCTscvALQor1UUfbV71YrNF0Dm3KTlpQrjtV2iAMX7KwuodapleVx0PDMbiSAmh
         WEw72zL+NiJ1AXsd5PSCyElTaN2JLQbhEv8TcmwE8GuixEK8c4b+bsYpCI2YB2A0snOx
         6u7ouy14GrUisYNRT5QGnVMFGdtL2DKWS3G+AFJTWlDDwRXFZcTVb+2PxIq/ID5pxsDx
         zPSmFXeG0E4XZa4bBZvkSiNRr+bJ/IOhBEPl8c2z/SFxAiDTmiIbBjt1MBq6XbNumeAe
         fBUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733350868; x=1733955668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OH4y0lMP3bH1lveKpeX+aBwZ95mtO7UpbBtdFwlO2l8=;
        b=XxCOe1OoaJczs2T0GZSSyQBFgy42RWzHFwBxPYcUtA7Ry9e2QcSbCGBYWFYk2lBmWs
         cTmzjNMGbSNqWAGnEfwlFI9NLBp601WQ2BR2+OV0x3MFV5vUy919Pd9v3YHRN9oOH8Sn
         5A6OJjv5efzCHlSebdJmlG4LZ5g2eQtY/4smNJaSrs2YrUml9J8o7VhSKwdo7D23/Gx7
         uL2uMcdUmOdrd2PpijKp+HMun9MCjSR7+Z8ZL//733kyAUAEa5qkwCzQQ65DTeE+Qt+m
         bAsUPMbTcGB2GulQC52uJxbqauHSISoyW32EIgGhSvoVFFi8bYF/EGeLfQmz/xk6LqsO
         4BpA==
X-Forwarded-Encrypted: i=1; AJvYcCXxLfS1uNGRiT65fnz3CK2pAXZ6YT5vqCu7wkurpRxdWbcav+UABQMUrj4c5cIy1oTBHxtA8sAAkg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyHcs43FxuFYvKm7F1iHWYooTcPQ8c/lPmiXdmtd1JZyqm3O1zt
	Koo90ytk1rBzBEIoEQEvbDf3qRMp1fUw25Zn0oU3g2bIhQh4h5PgQqEoIRW7nYQ=
X-Gm-Gg: ASbGncuDMATkTPg5hwYESbiP5r2xh7cWc4EzZe07AoULjuCUHG3h/1OOVtjdOcEz5tl
	AO1UFzB2rvut4Hyz0oiKmh53CWxOUXWS8ByEMBTyOvLN+k96WfeNffopghf2p1WrYhuJ52N2/jH
	HjLc0iAIg0g5ag0bEZXRsPnokB246JV2POIl45qphz31Dqe5ziTm1hpbZXO3eM4XGPQKH7W7gwS
	+GsIb8F0Xlpe5nItz09k9Vf4Io2mpIIDCvmwIV67Mdv4eEYr670GwwRCjmLyZxgnost4gZjaWVn
	7TNnUpQssdYpIWtu9onCn86yeubn7A==
X-Google-Smtp-Source: AGHT+IFQNKupoOz5B2N+8vVrOXLHYn4xv4Wtyf/8DA/aT70hkUWOnF+im9j6wqbTorBqmEkgbKr9BA==
X-Received: by 2002:a2e:a904:0:b0:2fa:cac0:2a14 with SMTP id 38308e7fff4ca-30009c30156mr45544571fa.11.1733350868075;
        Wed, 04 Dec 2024 14:21:08 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30020e20aa9sm23431fa.80.2024.12.04.14.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 14:21:06 -0800 (PST)
Date: Thu, 5 Dec 2024 00:21:04 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Melody Olvera <quic_molvera@quicinc.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Abel Vesa <abel.vesa@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>, Trilok Soni <quic_tsoni@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
Subject: Re: [PATCH v3 2/2] interconnect: qcom: Add interconnect provider
 driver for SM8750
Message-ID: <snccv4rebzwolmqknc2jm6nkfxchi3hm2vauxnneefsisc3xwe@slfyaiss2vat>
References: <20241204-sm8750_master_interconnects-v3-0-3d9aad4200e9@quicinc.com>
 <20241204-sm8750_master_interconnects-v3-2-3d9aad4200e9@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204-sm8750_master_interconnects-v3-2-3d9aad4200e9@quicinc.com>

On Wed, Dec 04, 2024 at 01:26:06PM -0800, Melody Olvera wrote:
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
>  drivers/interconnect/qcom/sm8750.c | 1705 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 1716 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

