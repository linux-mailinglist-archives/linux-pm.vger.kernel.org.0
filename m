Return-Path: <linux-pm+bounces-11329-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF8093A015
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 13:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 532FB1F2307F
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 11:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631141514D4;
	Tue, 23 Jul 2024 11:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mkLk4Mfp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A492C1509B3
	for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2024 11:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721734835; cv=none; b=RDbocj7Ay4BR4Yk7/IJO6GK9oTJvvE7F1ylSd9sGp21S/svXzmssRf1SJMjoqON7NjFUCavIVNZj9PhBeDGwAICnqWlEuAftCiIurt0K/2LD+NySforMO4uY1e35w21qWjOPEx3hM7FSrTG3jyW3hguCwCSOe1lFkUxffrBqxC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721734835; c=relaxed/simple;
	bh=W7OW3Ejgfp7G5j4icOUna0C6UGhzfYE5ZoNeOw3JMyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQf2ekJgCKKtKKvtRvrhl2IoS9dBQgKUMSgVSiO1G/CZEny8jCQefnANlYO7aJqmnWK0FnlF6GTrXmT2Fb2Qf75Fg3x1nphwvr+xYk8upApg35mGTqpYYqhz3yYWACx7os4tcuyjcDVaZ2HeJnC6KnmFrxM+il5SrjjJwBIH1k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mkLk4Mfp; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52fc4388a64so1536816e87.1
        for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2024 04:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721734832; x=1722339632; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hjlt0t66AG+BzODJZGyLjit24PidKbfoYtsLZ8osE8U=;
        b=mkLk4Mfpu++PmPspTzfAPROfQVTLJb4zyW8J5JDYdzz4HdmEWQEDsVJ4Uzv3e40u2l
         cIQ2YJbz6mBuxV8AFeSFUxGIYIbTfKMXjqan1uU3O+O8KRjuFKn9LJiJgmMrzFn7Umyr
         tRK0JXYvn4OKTW5olRIX4T+kKPsfPp4YW8eaYWTRO9VNKB3txk/jQHB8NN7bhnP5TVLS
         fNpNCIbbNR/qt45HwfM6hGKcMwFr69tnTqGlHjr+mQQoyiXIlscPxeTgdlvHsSfpJfqg
         5uSto9NVi9Hw+NBjdsZoAUyuJYOExnIr8QNoEoLaUOx25cZboXsrtWifnhy2aXJJyhFf
         3m0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721734832; x=1722339632;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hjlt0t66AG+BzODJZGyLjit24PidKbfoYtsLZ8osE8U=;
        b=J0K7P46GPJv+f2eEWQR/hqtU01fsdGHYIdBK7ldiYMgwpDgtCsdp4C8XXn7ZFcloWp
         549IwBi2pStm/HCOxsb1tkPGaeyouDpbOP0JfcLjK7YjzsOkr5NgO3IuX9FawV+2Iifk
         2l5W+61IWSGvb0w7NmArS25qwGFmZaYqd4zKE4yraYXQqzzKUkT+rqCmPImbSQO2lrrG
         MPdQQpHYCrEmrVid2nZdosQtMVuIbftUyT/4UnkRdWE0KkMINmiUgZKXbYgGVnU7nqia
         w17NRbceERM5YVN3JpTqu2SKaTS5FMrFLaOqy06Bki6rl+IsFEDp1BK5TOZ5ajnMI50e
         CHSA==
X-Forwarded-Encrypted: i=1; AJvYcCU44O7mJf3IIRQqNwiUYnvgnWNS3zE/pgq9alQjSa/+ub9Yk2MEt8ieD0bS5kWXptFzWfPKV0VHZc8rQQCe11+0VsGoYGRdTLo=
X-Gm-Message-State: AOJu0Yw3mY55YhygmniHeiXOVhJD9hkgJ8qOnq3pVt60TS1fe07XVxQL
	XVYcrBNnR1mqHHt40OyRC8cfkkHKuQNNkMXPpstBImXHDfqm2Kal2GZZqi63uX0=
X-Google-Smtp-Source: AGHT+IEbGSdRnrn1tMqSaQIsvU2xtF9ZvhQfnBkvrzoX6ZyDx0qPmdCjK7nDuJdNYROSEalcudqrEQ==
X-Received: by 2002:a05:6512:b84:b0:52c:d645:eda7 with SMTP id 2adb3069b0e04-52fc4046b22mr2098202e87.18.1721734831905;
        Tue, 23 Jul 2024 04:40:31 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52f0212c743sm881109e87.26.2024.07.23.04.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 04:40:31 -0700 (PDT)
Date: Tue, 23 Jul 2024 14:40:30 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	gregkh@linuxfoundation.org, konrad.dybcio@linaro.org, djakov@kernel.org, 
	quic_wcheng@quicinc.com, quic_kathirav@quicinc.com, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 4/5] clk: qcom: ipq5332: Use icc-clk for enabling NoC
 related clocks
Message-ID: <tg6wzvgiv67gpf6cc3wwubrj7hmpj3tdzsxtkce5shwjhbw5lx@kxa3umil5q5g>
References: <20240723090304.336428-1-quic_varada@quicinc.com>
 <20240723090304.336428-5-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723090304.336428-5-quic_varada@quicinc.com>

On Tue, Jul 23, 2024 at 02:33:03PM GMT, Varadarajan Narayanan wrote:
> Use the icc-clk framework to enable few clocks to be able to
> create paths and use the peripherals connected on those NoCs.
> 
> Remove CLK_IGNORE_UNUSED from gpll4_main as all consumers have
> been identified.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v4: Remove CLK_IGNORE_UNUSED from gpll4_main
> 
> v3: Not taking Reviewed-by: Konrad as NAK-ed by Dmitry
>     Remove CLK_IGNORE_UNUSED -> CLK_IS_CRITICAL change and fix
>     that in a separate patch
> ---
>  drivers/clk/qcom/gcc-ipq5332.c | 35 +++++++++++++++++++++++-----------
>  1 file changed, 24 insertions(+), 11 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

