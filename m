Return-Path: <linux-pm+bounces-10070-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCFE918E62
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 20:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62A111F276B0
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 18:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969FE190678;
	Wed, 26 Jun 2024 18:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WGUpkRVL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D046B19049E
	for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2024 18:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719426393; cv=none; b=isJaeXKAV6xxMG+psotJyLLu1SUandDCZ9HM04NHpkGfmyaLnzND3dYTX2dgCWGUtPxyx8JXcF/rvCpMEAA6+up/FssoM5gxg4xUigsGwHUCeixC5Pq+4d1CEUfea81QUvwQyrDHQzd3EeKb0v7WVrYVnbIThE0m0TE2QOa6GFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719426393; c=relaxed/simple;
	bh=k01cK/YCuo1hQTt6db4+MUng1CIWGzBUN3c2BeefC6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+tMBUMcsKkpSCHNymk1VTFgFl8hGnu0L/rlPQJ08M9hlZ6FNL3j/aJYjDXdbKoCm2UPVOMhKwnSUHDaz1oJ+GQqf1bI/j9YDo8fFueJyU3TGbxGOe6b8CMzdUyoXJHjuPAxLGqsy3lA7pKrc7yRpTttewixGaG4WFacTyKg0mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WGUpkRVL; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52cdea1387eso4801299e87.0
        for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2024 11:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719426390; x=1720031190; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LtNa5H2/MJwEwkgtO3HYccqUUX7XhI9GZ7VcG3cyTuQ=;
        b=WGUpkRVL0KZeMSWgWOf8iPJhDWK6YVaVEuTidHI0/9ubsiuGYf20fFJ9ndReCqAzwy
         we/j0JjTZHHz4WC/ir0UZxJY9OZ8jZlM3wfWicNSxE/V9aai9xygIGZKF4iK3inNu6lL
         QaKr4gOGHwV7O6uWh0xbBLzF1xSPIg5IDFGDfOfzaYU/iEpAc4puwCG0pT/z3Sq7w8fh
         jDNWa/Qy3NVnXLWKeMLxvHcOW/NjrKRaoysVG4unzQy1KI+BLwabQ+k7HVx3boPzIEuz
         gJrS8UmzdE+vns/SZBkYAQNSpmcTcr7P4mFEWQPTfpQfM6JJ8U7KsTwkhyRkmEK2ScF9
         6rKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719426390; x=1720031190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LtNa5H2/MJwEwkgtO3HYccqUUX7XhI9GZ7VcG3cyTuQ=;
        b=vYXH5MsC8kr6tI2CpFbvocAnRqTdnbf9c1PeaLwtIE4STKCcukXjFrZbUSic7Qdk4n
         FYDb6nPoG4WCKZVQhLEKv+aVpElMrGXrIPT+lW43AGI3vOm3apa5u3iw+tGjlvrfuKcE
         wcEFD+uIZlGWMzHPtKynkY1MJusTzbCHXV/f2BcjoF4fhPEnZmHl8Y6zYDZ9x8HHPtAm
         0a268sYsl+aO097FLQz5EKMS6SzCsuX8lFWKG/4dU9nN/bABio74rsRCap9G6KYvg9UV
         aitBkDKC3zV2Dyh+Fx5i/M/bIpLIJa1noDOjZLtyRwC0aHuk8dfDUTwQ8J8Xhz8UUSht
         w5wQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkDJ+DbiZeTk/txOYlR3V0OPpfsbWvFLn3eb1j4eidT12nrhCk4ducSnk2M8TtbSbPVkGJVYAq2OHskFKVKH8u0Qn1OgNi2MY=
X-Gm-Message-State: AOJu0YwigYVpd3hGWqy0XM0qIcfBhfua6hR3mW/u6D7JdizSscVj7ykb
	jThB7a0UI49yNb4cMEgWxL6ArpTCzM7q6Y7RW6Z1YL9oyxHU/0YB8gMpYRAfA9M=
X-Google-Smtp-Source: AGHT+IFPNDgKkvuVJj7YmfXDZK7PGPveQ+DO514sDOaDxGF/JOZUPyL7BfEVaKt57bjNRSLgfcMirQ==
X-Received: by 2002:ac2:5ded:0:b0:52c:dac0:59f8 with SMTP id 2adb3069b0e04-52ce185fb12mr7019578e87.53.1719426390002;
        Wed, 26 Jun 2024 11:26:30 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cd7697e0bsm1640365e87.124.2024.06.26.11.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 11:26:29 -0700 (PDT)
Date: Wed, 26 Jun 2024 21:26:27 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	angelogioacchino.delregno@collabora.com, andersson@kernel.org, konrad.dybcio@linaro.org, 
	mturquette@baylibre.com, sboyd@kernel.org, ilia.lin@kernel.org, rafael@kernel.org, 
	viresh.kumar@linaro.org, ulf.hansson@linaro.org, quic_sibis@quicinc.com, 
	otto.pflueger@abscue.de, neil.armstrong@linaro.org, luca@z3ntu.xyz, abel.vesa@linaro.org, 
	danila@jiaxyga.com, quic_ipkumar@quicinc.com, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 5/9] pmdomain: qcom: rpmpd: Add IPQ9574 power domains
Message-ID: <5dwbbuu74jdoukvmr7j3cqzf2rju6tngzawnptlldy5q2e4rwa@kqoucucwo4ae>
References: <20240626104002.420535-1-quic_varada@quicinc.com>
 <20240626104002.420535-6-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626104002.420535-6-quic_varada@quicinc.com>

On Wed, Jun 26, 2024 at 04:09:58PM GMT, Varadarajan Narayanan wrote:
> From: Praveenkumar I <quic_ipkumar@quicinc.com>
> 
> Add the APC power domain definitions used in IPQ9574.
> 
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v3: Fix patch author
> v2: Fix Signed-off-by order
> ---
>  drivers/pmdomain/qcom/rpmpd.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

