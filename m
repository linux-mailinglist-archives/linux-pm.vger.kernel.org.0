Return-Path: <linux-pm+bounces-14995-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4983298B4DC
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 08:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E66481F24E98
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 06:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110B11BC084;
	Tue,  1 Oct 2024 06:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zra1fMuM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B5819046D
	for <linux-pm@vger.kernel.org>; Tue,  1 Oct 2024 06:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727765250; cv=none; b=WEeKDHveYfVAZvGakZrrs34JdCDYNcPRxNxOSuMMDgV4mQCVXjmY2H0EgF8v8RDLeIPzNEv33fhUSBMyJZcIPnOCePJ8aYKPx9BnkdkTwrNzO7ELgVqvG4LQ1EJm4dBB/Dx3UY31iXtjAIZorALBFJ8Fyp9cdRbgJh6wOS7/HEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727765250; c=relaxed/simple;
	bh=n+ms9eas/yrSMAHRy5Y7bBaQ+oTS1E29qNA+U/tw/OY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jrA31MV5GyXmOVD9ea1WNUs4JiZcW2/LhvEwdeqvIC8pnwv3ENZXMAaC+SApHZbzhXLcSpDC71cvQihRqvNcRVdR0/y6YtncBEOT/qh2crgHOSw9+Ww5NiZ2D+PxCw1EXSdwLoKqxL0Xo3QfdbpTWZXQTMP//z8uPa64rQ3w0lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Zra1fMuM; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20bb92346caso788305ad.0
        for <linux-pm@vger.kernel.org>; Mon, 30 Sep 2024 23:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727765247; x=1728370047; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ATsOy61DsddooGaPEa2CzZYQXPNTRfIT95jkUv1EcB4=;
        b=Zra1fMuM2UnfbDUHPoXqC6pIqfDYr4/hfdZ51jq+bwYL18RCwOgqwTWHhhuTZYm7/B
         6O9T/U2VegBMsIlwFcSYvZL6n90GM2baeHL1Otmw4zWBwrm3BKg5U51HR4N8HTic+XZ/
         Jh1051u5I4pE2tsxpknXhJgPIFSP6Smd9KPe16iP1rTlLW0zSZ3HuuMRZvQjjwZB/caQ
         qLm/lxt4FC0UfjWrbiCT33xuwk4lkTbYnQTHI0pvXOoriQd7Tn6T1wew8hLbn2DAVOFj
         XMGkuFsYHawMs3L1TNR16Edj2lJTV6byOXqYzkunpOTysfsmxk5SDK32V4cHdHR7xu1o
         C91A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727765247; x=1728370047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ATsOy61DsddooGaPEa2CzZYQXPNTRfIT95jkUv1EcB4=;
        b=ZsrZ8hIXN/fwZrUJXrp/bnkwIKY8bHVlKOmLB4Vcq4bN+R81HKDAmtR3lsU+BubT/2
         gGaqr7S32i9jlnWvMQpKZCHkY98jqivQ8tpHmA/tN8rbq/o8teOkEDnjU/obl5wPouNi
         vwmxxANnouDIJWuiw73GEMrrsQ1pFFNlQAQHLhWXmHigAB3cC9ZJQrDragD5ElNfjr72
         /KDKCCnLn6ephlQy2mxO1+UZSObE6ZzkR1VgI8TBl7EzYVYpoqPyWeISliXpuVycX7Ny
         f8isEuUJadPaJTDJ62am8KKyXZ9c4cETKu4gUEwHKp+8p6lRGa9VOC1plVoqQitvwYxR
         Kr0g==
X-Forwarded-Encrypted: i=1; AJvYcCVnc/oZWTuNcj/uMce/H6GuVEMC+doI4DqFgvFSfN8XFcDxQeZDDK6E33C40pLIOqyWFdyas+c7Zg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwhlYEqMtCnSzvahIqhrHuX8/gvgOt6PFLVjzSuTYXFHSxZRVZ8
	JlgM6yT1UWUs6r0/3jT0xKpwJg3BxniPExuREiVM1mp3wvNDPIrXizOZDnrIa2I=
X-Google-Smtp-Source: AGHT+IEgEGAOc6QjgeVL09WHHyQC8Ps+y20CMVXh86yh6HQzv64PoeqKdtTv/zU4U5RmhWTExsEsxQ==
X-Received: by 2002:a17:902:f541:b0:205:6c15:7b75 with SMTP id d9443c01a7336-20ba9eb2654mr31998995ad.7.1727765246768;
        Mon, 30 Sep 2024 23:47:26 -0700 (PDT)
Received: from localhost ([122.172.83.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e61c4csm64001915ad.274.2024.09.30.23.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 23:47:26 -0700 (PDT)
Date: Tue, 1 Oct 2024 12:17:24 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Nikunj Kela <quic_nkela@quicinc.com>, rafael@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@quicinc.com,
	quic_psodagud@quicinc.com
Subject: Re: [PATCH v3] dt-bindings: cpufreq: qcom-hw: document support for
 SA8255p
Message-ID: <20241001064724.o4yz2d6xlcrbx6ro@vireshk-i7>
References: <20240912175043.2262697-1-quic_nkela@quicinc.com>
 <crsuqys5tlgtf4667fwaojn5z5ri4uf3te4n5a2bcalidgobo2@up62meevaxwn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <crsuqys5tlgtf4667fwaojn5z5ri4uf3te4n5a2bcalidgobo2@up62meevaxwn>

On 16-09-24, 11:44, Krzysztof Kozlowski wrote:
> On Thu, Sep 12, 2024 at 10:50:43AM -0700, Nikunj Kela wrote:
> > Add compatible for the cpufreq engine representing support on SA8255p.
> > 
> > Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
> > ---
> > 
> > Changes in v3:
> > 	- Added compatible to the correct constraint list
> > 	- Removed the new constraint block added in v2
> > 	- Removed the patch from original series[1]
> > 
> > Changes in v2:
> > 	- Added new constraints
> > 
> > [1]: https://lore.kernel.org/all/20240903220240.2594102-1-quic_nkela@quicinc.com/
> > ---
> >  Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> 
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied. Thanks.

-- 
viresh

