Return-Path: <linux-pm+bounces-16398-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E35D9AEB01
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 17:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D7161C21715
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 15:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB201E0B6F;
	Thu, 24 Oct 2024 15:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XBOggcZA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EAB1D5AB2
	for <linux-pm@vger.kernel.org>; Thu, 24 Oct 2024 15:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729784909; cv=none; b=uMvYPg4bylTOSJk1SHGzUI6acaRHJe5c9mprgOPxQYzP1NYK9S+OIqEYbHRlh5Z+xvdnzCRkEcRet3ifA//EPHCjyszugl4tdis/vKnqcEljighRaXhLjVaj7frCKveD+nrcWRCzorFFhUpVG56/ZxK8JRy914enja6EVrf0PcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729784909; c=relaxed/simple;
	bh=koRsjGvRkJdt5pRFrEkbpFSOhKrK57L1Ce+mec9D7Z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JX3g/8JTu1zlTcyhYRxcJVoe+Tkk9PUlWQPhvALy4/bmu8z5gKaETqTxT4bCCM7k7ZXPtmml8IHHxfnsHaWrNTikezUA7Md7xMIHj84sgF4jvwGmWbfj79ocP9SxXqmYp9wPdRak+f6IDxLW7SJ7hzk2VtmGIzudbA28S7ivP7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XBOggcZA; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539f8490856so1017418e87.2
        for <linux-pm@vger.kernel.org>; Thu, 24 Oct 2024 08:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729784906; x=1730389706; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2QYTQ8CP1AMDaXMWSWxiFJrNaiPGvGF4+0DCKgx8chM=;
        b=XBOggcZAGdjCqkWsoRm03y+ShFP4Iet2mV04oWi9Lxb4aL38ONSZMJSEEQ5UDheWS5
         u2OVg4goBVcjbZC2iXeFIhc4HxJm1jQgxbM+MPPPxUzQZMBk6MlLTPuYWTavxPBIVlgR
         qKFYlAA2VrU1cpMlaj8zHIQWht3YQspONnNdhk3uMlE/HNymPz1PFphmCeaMkJPdVVSJ
         Js1wqEM+6RplUtTsxCkGrsQ7I65+i+V2hFPVeJWP+j2cI4QJgzSFunThEsb7yOBb0fZW
         zDOGW78md+FFtSaJHxOtYja+SI/HTw7zZ6/ryKl9UYKjJJn8mLOSJRXJbHINwTf3ZsRI
         F+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729784906; x=1730389706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2QYTQ8CP1AMDaXMWSWxiFJrNaiPGvGF4+0DCKgx8chM=;
        b=slIG6XyXvGrp132e5t7VcghD9LAcwCTgnZ7kuU3HcOwJA351Jo3J5lxK9zlNS37BK+
         D1+5FXYLmImgR6d5JZXKbk1uyLc3VttdBFHPreSJd6Hq/MG8baoi9VQoR20XIzJutnsF
         wWptT5wEZG+L54mOxGv71ARd+M71x9LadorecDzAXaYnjh8zJyQ8d23dRG0snTrcaa/G
         yTjuwdkLSjMEcw+uEyw+ZnYwW7CgtvEC9adjnjM5+kEQvUCQtpjyXrAG8Ft4DEHEg4Cl
         UkOKa5SZ/qmyekr6jdtWS0EQW1at7HuJk5z8Xu3Aimxv0C20YvWOaQgbcy5yTHEn2HxD
         uNoA==
X-Forwarded-Encrypted: i=1; AJvYcCUadGi8Y9gf/bO3UHzbJ3ElMJUr1+SrSqelMV19H3phLy3rbepRnWk4QTCcGvoYL/vYSq/J5YmYxQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/YWyHJXp39Z9n23+wzVosDsT6VvfZSjxjj9OjLsy1ib0K0jr7
	o1QD/YL1UYFFUIlePCr7J/mHMLof75FPCcjBNJ3QTWHYkmR7AQZLKQKhnKaUq+Y=
X-Google-Smtp-Source: AGHT+IHg7/nEfvZkOn6BA7PZBmebnyVMgSWv5DTuDfVfgCnvwovuWEpOWHklDBlFgRxuL8B4nEgE7Q==
X-Received: by 2002:a05:6512:3989:b0:53a:1337:5ff7 with SMTP id 2adb3069b0e04-53b1a36c6admr4450312e87.40.1729784905657;
        Thu, 24 Oct 2024 08:48:25 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a2242fba2sm1394455e87.190.2024.10.24.08.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 08:48:24 -0700 (PDT)
Date: Thu, 24 Oct 2024 18:48:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Johan Hovold <johan+linaro@kernel.org>, 
	Kalle Valo <kvalo@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v6 2/6] power: sequencing: qcom-wcn: improve support for
 wcn6855
Message-ID: <rm2rlaqf4qtthzmyqkb7yko57tm2y2wlxno6ee2efll6kjxnz4@fs75wefpfz3d>
References: <20241018-sc8280xp-pwrseq-v6-0-8da8310d9564@linaro.org>
 <20241018-sc8280xp-pwrseq-v6-2-8da8310d9564@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018-sc8280xp-pwrseq-v6-2-8da8310d9564@linaro.org>

On Fri, Oct 18, 2024 at 02:49:12PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> WCN6855 (also known as QCA6490) is similar to the already supported
> QCA6390 but takes in two more supplies so add a new vregs list for it.
> 
> On sm8450-hdk it also requires a short assert of the xo-clk pin so add
> handling for it in a dedicated unit.
> 
> As we now have a separate set of targets for this variant, store the
> pointer to the targets struct associated with a model in the device
> match data.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/power/sequencing/pwrseq-qcom-wcn.c | 101 ++++++++++++++++++++++++++++-
>  1 file changed, 98 insertions(+), 3 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

