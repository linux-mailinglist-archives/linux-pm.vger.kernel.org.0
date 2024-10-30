Return-Path: <linux-pm+bounces-16717-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C88989B61DB
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 12:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03DEA1C21370
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 11:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95361EABD3;
	Wed, 30 Oct 2024 11:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fy4uWG9x"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A8F1EABB6
	for <linux-pm@vger.kernel.org>; Wed, 30 Oct 2024 11:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730287887; cv=none; b=aMEYt5/UjNcQrFkjkAAnv1yj4Ayz8d17+oAVC8dBzyXTSTgsacORSwzWD+bAGn0YisLaMmacM98G6SVN5ip5KbvCoaijsj96u3ZjJisPHrQ5XoHCN4XqhasFHSXXcGZSykJiIevXmpYbGum9m86eeBG8T9su2/Z38nylI7nkSyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730287887; c=relaxed/simple;
	bh=sxaelGT4Idpj3BClN0eoO2elk6zpAu4e/9ginvYJ+4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h2RuNO4KM0a5r1WQZCkGOkN/0L5y8QdVNRxvfLvwrX07pN2n+py1AjdLjKAmaFAaCocpjhTe8UEUvAxGI4dsJZO7bQF5yJgEBEQJ7c1Km2gE9pD/PR7dsV5EQmXOwaHU+B1t2xUKZU/WyXsNtwweC8PaZiEwGIPbHm38n5dkctg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fy4uWG9x; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539f1292a9bso7746545e87.2
        for <linux-pm@vger.kernel.org>; Wed, 30 Oct 2024 04:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730287883; x=1730892683; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cX+ON3ydOpBhTY6o2Rbqes4QOxAe5cTgNGKeiB9S9mM=;
        b=Fy4uWG9xdnh4BLS2yJeB3ZHbBdUc0ILLrxm2OSQ/T2OmB3pkIkx+/RXDO2OaoDlv1L
         pM3c3Qd92xzHkaBBEL7J6vxc2+Q0/AdWepcit3Fqfq4ia8o6ijvRc7fwrtzz0r7ORBmn
         5hxE/w/hnXZCHB7e+2a0lZA+EKQkCgJPHq7hvnufdLR/7PN5Z6KEBUEztfASseSXPsPu
         k8TgCxXjyZGiHqZ3v6h8EY1ijmAay0stCcrq25ZvH3/hNSIfc/j5E9VelH8dHfRo5jRe
         XdjU/2FkN5FlkF+kRmnx9w2RggjEYetRjU/+2Gq37jt2axyxY/WmXUnWIQVhAhlwlx/K
         mwqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730287883; x=1730892683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cX+ON3ydOpBhTY6o2Rbqes4QOxAe5cTgNGKeiB9S9mM=;
        b=nt9LviT6eKFRX66kQ/6EnMyUQSy3JwZ0Nrrs73pp1WIGslNe9Cumx6XKHBxA/0QQkd
         DFUcUR9DVmZRGoexJFtdQjP6F4346swNqQ0ifLPfJveMuBcIWtKEyzJ+3BHQZCOJ2DJv
         ii8hkMF56np/4G7r75yheLZaWNW1LIHqTmKKa3ICWeirehn6n/spSuICeDAoqXrlGK8X
         nQOW9WchJGvNFdxE+y0TpaCLAJb46HfRyKHveaQL+XJhsvZWlo7G6mYuyKBQ9HA88fe9
         ckuPuAF3sYUDsNbeytwHW2A2kJwe0quUKtJMr4+NxDqQVbHIVjEq5M4KRSy8YSniDvlC
         kk9g==
X-Forwarded-Encrypted: i=1; AJvYcCWOV3RkGJ9UAIujICDSE7MH8Rux7YsfuGxNHLKtPe1i5gj9F1a9QKDk7XFABeRvvleOayP6sojamA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLfjfnSIgDatRE1ZHcVJqF4xLelN4oXv0n6ERAakraYWm+HyON
	5UrIPjXr8PCVH3X817VlTgrTba/slXOjYm1yuJ07tzexWwetYL4fQjM1oQpoP9k=
X-Google-Smtp-Source: AGHT+IEenLKvMDS8jmV4t5I3gxQ4u0flSc2k6Tm9NyWl2kHf7+zqlwDZsVHgTGFOMNvFzMYwSoNqqQ==
X-Received: by 2002:a05:6512:baa:b0:539:f1ad:b7a6 with SMTP id 2adb3069b0e04-53b3491c819mr7479539e87.37.1730287883506;
        Wed, 30 Oct 2024 04:31:23 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53bb8190cdasm229410e87.23.2024.10.30.04.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 04:31:23 -0700 (PDT)
Date: Wed, 30 Oct 2024 13:31:21 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>, Stephan Gerhold <stephan@gerhold.net>, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] cpuidle: qcom-spm: fix device node release in
 spm_cpuidle_register
Message-ID: <qpnqvvrv4lfmhavrt6apn2gajd3ugnd4k6ombcuejzmy2eczxq@3pgxhvac6eyv>
References: <20241030-cpuidle-qcom-spm-cleanup-v1-0-04416fcca7de@gmail.com>
 <20241030-cpuidle-qcom-spm-cleanup-v1-1-04416fcca7de@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030-cpuidle-qcom-spm-cleanup-v1-1-04416fcca7de@gmail.com>

On Wed, Oct 30, 2024 at 07:38:32AM +0100, Javier Carrasco wrote:
> If of_find_device_by_node() fails, its error path does not include a
> call to of_node_put(cpu_node), which has been successfully acquired at
> this point.
> 
> Move the existing of_node_put(cpu_node) to the point where cpu_node is
> no longer required, covering all code paths and avoiding leaking the
> resource in any case.
> 
> Cc: stable@vger.kernel.org
> Fixes: 60f3692b5f0b ("cpuidle: qcom_spm: Detach state machine from main SPM handling")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  drivers/cpuidle/cpuidle-qcom-spm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

