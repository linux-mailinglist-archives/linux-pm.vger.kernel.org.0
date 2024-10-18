Return-Path: <linux-pm+bounces-15973-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F23A89A4262
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 17:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D5F31C228E3
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 15:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEBB2022E0;
	Fri, 18 Oct 2024 15:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LF17OhnF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9329B42AAF
	for <linux-pm@vger.kernel.org>; Fri, 18 Oct 2024 15:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729265515; cv=none; b=UM5ZYJJFfrnpvju/FIHHEYLcVplYweWU8YkK13KGweDxPSyuuFNnxxQUhBadhMWDBus/V7YSlJMN/7eVmArL642nusEZGqKUswd5Zq8bmunoMomiggbE0wGgGkT1BNWHOGf3k2trc1lYszELXHOYkBMNi5sfA2sVIRkC7vAW9vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729265515; c=relaxed/simple;
	bh=gQeddZA7AUNwll6ggmREqwiuhKzdOjqoIFQvMRD4+w0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fpMVAtRI5qpyQr4CY/1oMDGP2vYcLpEZrat1MuJF/K1bNt17bldhlAGJBJq1WfxApXeCzJf2yNtPxYFiS2AGyCUCdcMxytdAE0FBHbmeCiBdLzU8P2kO4g5QqBipW5V/HJC1lUmScZdC6vp4kDLM97RyjFK9XOUJk7WB/wDlgLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LF17OhnF; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539e690479cso2611087e87.3
        for <linux-pm@vger.kernel.org>; Fri, 18 Oct 2024 08:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729265512; x=1729870312; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v0nybU+upPHt2Dx8CJHCDz0JeIFRaZFDVbO6aBhUo3w=;
        b=LF17OhnFOdHr6XdlCUdYLDWBUF1bmSIVRBulPKzehc8LJtbTlpu/nRFQu08tH+Vrqb
         iBQeBKSOOYWCR1TH5WStbIG73V1hGT0OEImMwNg6Oo0V/pTbqP3I2EFDv2uLqTYFhYrB
         XKjPWarJP4aV4taRbbFcVoYa3V4M+IkieYHZhIGC1676Njl2UK6Qpeckxp2/EpckNutn
         RePP4oiO/9S+i3yIQkKsfGJdBVT1W9FIY3fOxNGMVRiQaU7EA1aMkO6iSZ/s6knAyRe4
         rwGbjXAIRONn6I6qGPWZ36/BRMB2yXS0amjSzKrr9MsNtCA2qIXtUscjbY6Cen0jHi1a
         xKWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729265512; x=1729870312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v0nybU+upPHt2Dx8CJHCDz0JeIFRaZFDVbO6aBhUo3w=;
        b=jTFqrwiDBLH/qnigq8KNRzArsUw9S1ZtBm/leXU5XsEGDWCaKUxombxwbpUXVeAO2H
         gI33cCIvTd+tO5F3+uZKeqfEZix/wTcPYmHoNj2R8Uo/rgdO6howTMlUxd0pPoXeYa+1
         WQOyrPsHhSMx4o+6DRofgBLgjrxgLCBDpjKj5sybh/M/a1TF1AYZVAWIeZ9ZUi1qNqg3
         q1g24x33WB+Q5oXHOvr3Vbd1nso8QMKMS4qZHs4V86wH9ZxVsgTOP0Gw3ZdWZBSwXWpf
         TbgnMr0hfBUQ1utlUomwMnUx7EZqEHysuV9+B9wUfmvFuZj6a+4p8yNKtgydp1A+hY1Q
         S8HQ==
X-Forwarded-Encrypted: i=1; AJvYcCXb4IAw+G5di9WZAuw3XpuztWrfknLFAv8LFz7AS9QeUmoY+nHipmLdq6CvvkI0nwvPyud7+NaARA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq9V5z47buQHRMenSbQ1CS6mM7fMqDcUnm/O54KAxLop9pF5jQ
	6E1I1niwSHs1fNKVIMEs0pEGaQPzrvEO03gyrviBM1S1QIu7ribnUWAFsMNfw8I=
X-Google-Smtp-Source: AGHT+IEYN8Z/8ko7R/xwHM1JXJhtjnqNmKTe/HKd0kHZ6O4I/L4D+iF6YO0NLqlfFP8rSbsSSvLPgA==
X-Received: by 2002:a05:6512:12c3:b0:539:d870:9a51 with SMTP id 2adb3069b0e04-53a154f8ebbmr1992715e87.48.1729265511562;
        Fri, 18 Oct 2024 08:31:51 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a151b934esm246241e87.100.2024.10.18.08.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 08:31:51 -0700 (PDT)
Date: Fri, 18 Oct 2024 18:31:48 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Johan Hovold <johan+linaro@kernel.org>, Kalle Valo <kvalo@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v6 2/6] power: sequencing: qcom-wcn: improve support for
 wcn6855
Message-ID: <gqgawgpcuw7ojttxh33fsymmucpfixeqhed23fkic5gz6n4nya@ubz23tw5x7vd>
References: <20241018-sc8280xp-pwrseq-v6-0-8da8310d9564@linaro.org>
 <20241018-sc8280xp-pwrseq-v6-2-8da8310d9564@linaro.org>
 <fee25ac2-14b8-412b-b093-1526443498e7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fee25ac2-14b8-412b-b093-1526443498e7@oss.qualcomm.com>

On Fri, Oct 18, 2024 at 04:30:17PM +0200, Konrad Dybcio wrote:
> On 18.10.2024 2:49 PM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > 
> > WCN6855 (also known as QCA6490) is similar to the already supported
> > QCA6390 but takes in two more supplies so add a new vregs list for it.
> > 
> > On sm8450-hdk it also requires a short assert of the xo-clk pin so add
> > handling for it in a dedicated unit.
> 
> Any chance this fits into what
> 
> Documentation/devicetree/bindings/clock/gated-fixed-clock.yaml
> 
> describes?

No, this is a software controlled set of straps for the WCN device.

-- 
With best wishes
Dmitry

