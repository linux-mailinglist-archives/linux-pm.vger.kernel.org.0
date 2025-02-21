Return-Path: <linux-pm+bounces-22653-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A72A7A3F740
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 15:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50B68863230
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 14:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1708A20FA89;
	Fri, 21 Feb 2025 14:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jkb3lJf0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2E620F08F
	for <linux-pm@vger.kernel.org>; Fri, 21 Feb 2025 14:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740148160; cv=none; b=H7jVxK9qloyIN9EiX/+v2aunrlzo5RKqO32KPKxKz85g4qHzaeE+creWRzvIsWlhkoWBel5SmzH4RUVDECaPCWWZImw+VEzP1/TEwYk+h4SGB3bkql0uUOTB5VLDR9gip8IY1KPbk9TvczHPkTBM0MXL3m377czur9sSaYLeTmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740148160; c=relaxed/simple;
	bh=SMB7Oulg94+Z2MBXQkXTAnaPYqD3Nq0hNq1RuWs5tLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xfw5Ugci0Bf7qSx7HZrEyEOcpg9SC5h+409MTo4/x//wZYmlltY2es9Sif1qZP+d8hqmvqj/t6ApJ5/M55ionwIjHP2TGFHxq9DbGlc05IOd0rD0Kz3lzX94vnsIeVH4P7kuJvd4XsRvQygkTeYpAWXLUffJo7GbbnPZ9W8IymQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jkb3lJf0; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-54622e97753so2006091e87.0
        for <linux-pm@vger.kernel.org>; Fri, 21 Feb 2025 06:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740148156; x=1740752956; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ddnou9M8kk7fCYmjkasHAfLTYCVLBdDBekbF0GdJqMI=;
        b=jkb3lJf034Vj64vkiINw0tnOwUbAhoNxu2vpPyyoqypkbkLp99lqA0jagH+e2rRBnu
         T+RLJcH0QfKMmCgcYrG9vI/ClOpJY1kvojrkR/ZEkovITtsNOLl9uZbmu+/luZy9p3Em
         rGCAKH1CWAoXZw1IFdYZajuam6XdN0HGduWxCarOUQMJhhEi6VNCE9mRo2gnT9mGKfVE
         v31sF2EelGyJDz05AwxJCZOEJEVV59ZARS4FLrkRTVZfdCP9/ACRkspN999jsHfzkG4T
         6H0kOWDgFHWKnLvoXhy33M+cahmvL++iCUroVGsEORKw5UpxlwASjaGszbQLp/LHRlOq
         Y3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740148156; x=1740752956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ddnou9M8kk7fCYmjkasHAfLTYCVLBdDBekbF0GdJqMI=;
        b=uvwBS/z5RFggSITqVIfCzBOr1LjAL2jJ2aJeDsm8P627MkHtQLpIcVLqvMZKS0RL0E
         GlfCDrnN3rffVCTaopsbrbg/MwvOJqn07JuNERk1hNBX3huBueY1QwSUhvJ8U6apPb9a
         H6IJEQfeszTUyZLB1dxmLGcjojgLcxW2gXK6r5gtkUtdxN1xpkTLvIrr8+13IKE0+mDK
         HHKeeFEcxrljSyCgKwVTHkyWFleFaDNVXBGliRTL8jvypO6aUZTqoQHIJdlFblGWRfGJ
         Y4ce/EhQAkUvSwnyuUxAc+J+IDWbqgJQDrNzFeJzdRaEsjHPGf6u0upbzU/4yTqtQjQg
         qh+g==
X-Forwarded-Encrypted: i=1; AJvYcCVQQ7NZiXg0qhFcWY74XRfJ0n+S4xs3N4sMoVyCMnIZ/LwxAloAnRMj7Yx4aYSuMUDv6WXDBsTHfQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPXLI+o+Rf9oxl8mUiNHrq94WtD/E4PNW+KYVcJIWpJVwlrVgg
	jgmY9pRwqyuo9REQrkOoYNHlsAt4ssm0n/iw13x6F6nLgB001TUHwV722Io0gzU=
X-Gm-Gg: ASbGnctONpraUCgDZwpNrev0mOu8F32X7JVw4fMgz4GDTJuaQA06iQPDfsWFE3s1NDJ
	QGQKK0+Eea5TIlJ5lTp4LwoTaUpoR4z+ysxpx/ADKE0qQYwj2r9EK3pVL8Fegtgt6472G17xYTA
	hQNU8PWc9T+kkMNt5MzTlt1Be6mN+jw9RTG2oAddXU81oGnsmCA0sIs6zFIkZXNvEbf/LhHW4nC
	Iv9rz3H5f03fDyIEK5mDEPfXTKHgfdfgTBok14xRK3PdZYlTrcd+nb/OAw3ZycK0lWUciKFUgiT
	r5Lzp5BjSbpQvDBM77hR8O5GD3sXUjkr+8bGMr5z9Jf6D7C5vLQznCxo7vgNPKu63uky9bHEM+j
	WgpbpKQ==
X-Google-Smtp-Source: AGHT+IE7b8g0z8/f55VUJfFuqsgXzs5AvZYpknnwAYynQLfST/ypxBMEs0bl4MIebB9oZLpkqp9CMA==
X-Received: by 2002:a05:6512:2212:b0:546:259b:9a99 with SMTP id 2adb3069b0e04-546e0dfc180mr2925902e87.0.1740148156301;
        Fri, 21 Feb 2025 06:29:16 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a25e60982sm19678111fa.83.2025.02.21.06.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 06:29:15 -0800 (PST)
Date: Fri, 21 Feb 2025 16:29:12 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: George Moussalem <george.moussalem@outlook.com>
Cc: amitk@kernel.org, devicetree@vger.kernel.org, krzk+dt@kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, quic_srichara@quicinc.com, 
	robh@kernel.org, thara.gopinath@gmail.com
Subject: Re: [PATCH v4 4/5] thermal: qcom: tsens: Add support for IPQ5018
 tsens
Message-ID: <hmhagxzvumlmzvnbw533ebzilbvknexarsnxjfwi4djq3eabkc@efferfxbxkt3>
References: <zesif5ehsoho3725k4xjqhb3tizj6fj6ufocdlzd3facj5hrrt@r4t5hthvyp2p>
 <DS7PR19MB888370DA2FE2AE936C47C13E9DC72@DS7PR19MB8883.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS7PR19MB888370DA2FE2AE936C47C13E9DC72@DS7PR19MB8883.namprd19.prod.outlook.com>

On Fri, Feb 21, 2025 at 06:13:12PM +0400, George Moussalem wrote:
> Good catch, thanks! Will fix and send a v5 after a quick test.
> Also found that the addresses in the tsens and qfprom nodes in patch 5 need
> padding.

Well... DT suggests that there are 5 sensors. So maybe the code is
correct, but the commit message isn't.

-- 
With best wishes
Dmitry

