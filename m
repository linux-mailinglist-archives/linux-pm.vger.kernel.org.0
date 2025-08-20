Return-Path: <linux-pm+bounces-32694-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E14B2D6CF
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 10:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E69E5A3C81
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 08:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C212D9EF9;
	Wed, 20 Aug 2025 08:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jP3kgYXe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60632D9ED0
	for <linux-pm@vger.kernel.org>; Wed, 20 Aug 2025 08:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755679041; cv=none; b=GRln/EMNiU4MrS6WjevVZVaAuyC/ihZRmD2v5VJ6ddds/IsGqlLNfUySB/q2eFY64opTB4X7aiW2J22duUlUruZSIjsdisDmmoxIZapyUwhtZkhL+ERnHt7teGkaxgoBujiXmbRTOyTXXqkuIUZtv07nEth4aWkeUs31BrWf3pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755679041; c=relaxed/simple;
	bh=xZW3/6BdFNENaqcayraBvFNOb+CJk1Z7mxMRZBIVkS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oz6y9DoSBn82RzmSnIIYLteRrS23m2JsxCr1ooubVuxXU/MlKo7MUv3eImWX6EIE+id2UKfyKZtdY+ornQg5gmBmpivoRo0ZRFoZHkSEgD2DPdzxC//jb3tkn2hAHlLUH8mnlq256geqg8rWEqiMMzHwqyIErWyGV6iy7FNzhJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jP3kgYXe; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76e1fc69f86so542070b3a.0
        for <linux-pm@vger.kernel.org>; Wed, 20 Aug 2025 01:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755679038; x=1756283838; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o46xinVR1s0iYeN1jBFkHlapCwoj6PpvJWdxxR0YCtE=;
        b=jP3kgYXeMCZPevJHb+4/ACiZ00jcjBk9LKtF0O0uhTGM+tFo5jJNWKmvSk6xfHVRXB
         iXGeevw+85nQF36jX/cTzl9MlV4jh0HOXKpzLVLcUjhRIQ/vuyqnQrIMNGtwQB5+LCg1
         qfZoeq/wy0eBougAezCP1YmxIH6dWciawMRKGI5ub1HZRlsLiIujBf2aI03bbSo5vCCg
         7C4LHa6CTgZYvTc3H0tVRlY7WWO72Y8niwadUfQvRCg7flgd6CWwWjgNNTeX7Ozo9tJo
         RrBhhpdEwhxMczjKH1+8CWIYVkiHXvP9gyX0QPEB48HPrlVE4o27UPIUx4WqHaxHy01Z
         NyFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755679038; x=1756283838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o46xinVR1s0iYeN1jBFkHlapCwoj6PpvJWdxxR0YCtE=;
        b=qcpLw+EsqyzIXjsjCL1Om7gQZNcz4R9jjrEx5SMRGrl1hD+TwSFXRn77Zm9mXaq5x4
         H8in8niGp2ll78PKfcjiVP+ARvEDN6S932EMp0PRc7JkayxKA2sbHQGWFVsVqzog8/DX
         JYCJCT+Ujd65byp7rEZgT4l1iU2kHNPbe1gOiUcfpjgFrtawAWvBqPaMNIfdZ0FY0lx+
         bIxvvCOzF89ABUZqvUHqHdnL1T3WiE9IEclHvhZ00Ln/aHfxpn9ykDY7MpJ+k+2wSym5
         T4JGS2Fl+Rgv4jksQdhoY1Uu7/ErNAEYr8WBCREtw3k4FY5Ti+MJIPCUAy5YI+qAGlB6
         U7pQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXzdYHXpyZ0EcTp8loQMrZJDmzgbYEahpjmMdD1xT14UI8fo7S5iaWUnhbb46FefdCHrXSOvPHcg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwBx35/MLlPhk3l+JvDdkWD2pH60UwDrtef1tH7JufJ//C6pBZ3
	ghPKliEuzXAz97edtdPZ4Dma8zBMxvXpaCFDLAuH09j9Q92m04uOIW6/dVHMvIgNC+Y=
X-Gm-Gg: ASbGncv/PonIzirarWhDmZksCX1RPRm28z7fN2O6kkgL1QUXKo8biqrGb73G+u8pBLP
	t3TqauUChNxx1S7Ncj1PSdbll5kX0LOn9xX9OIJBrrYJgDW4A1KTDyEWYcbRBIAvhKg0V2ksIh8
	QmUxk2SilmZxzCbm3QsLAZzfGtk60hNnFez9qyqwNiegKfGBPmnDs2LnCPW6v2ptGaNusYMLTWU
	Y5hPTPUu5W9CkqpHW2IC8jZl7cCAWDw5lZG3EdrBmoeis1X3Bz8SjmwzsTZtLugeXLUrnmkDdYd
	27bf3ysqi4tNd5IFOGqLoqTnsJD92ZRF/A36IWT5BJOioR01YE9PJvHRexLMRhcXuClI3ATe7L6
	gqHdiIKM0rpsuc9mly97sIlmE
X-Google-Smtp-Source: AGHT+IHpJFoo2XVLENsEBA/Y5llAs8G7zIxVfwM+c4WxloFPk+FGCECVKHDac8lZXlFp3d+0H3OcQA==
X-Received: by 2002:a05:6a20:9389:b0:1f3:31fe:c1da with SMTP id adf61e73a8af0-2431b7c629amr3202399637.11.1755679037542;
        Wed, 20 Aug 2025 01:37:17 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-324e2625998sm1600813a91.16.2025.08.20.01.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 01:37:16 -0700 (PDT)
Date: Wed, 20 Aug 2025 14:07:14 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Paresh Bhagat <p-bhagat@ti.com>
Cc: nm@ti.com, vigneshr@ti.com, praneeth@ti.com, kristo@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	rafael@kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, khasim@ti.com, v-singh1@ti.com,
	afd@ti.com, bb@ti.com, s-vadapalli@ti.com
Subject: Re: [PATCH 0/4] Add cpufreq and USB support for AM62D2
Message-ID: <20250820083714.bvocz6cmcbhnrsmt@vireshk-i7>
References: <20250820083331.3412378-1-p-bhagat@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820083331.3412378-1-p-bhagat@ti.com>

On 20-08-25, 14:03, Paresh Bhagat wrote:
>   cpufreq: dt-platdev: Blacklist ti,am62d2 SoC
>   cpufreq: ti: Add support for AM62D2

Applied these two patches. Thanks.

-- 
viresh

