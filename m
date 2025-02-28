Return-Path: <linux-pm+bounces-23169-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C41EA496E1
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 11:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A7C13B8AE5
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 10:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015BE25DD0F;
	Fri, 28 Feb 2025 10:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="raxQR0X/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD0125DCFB
	for <linux-pm@vger.kernel.org>; Fri, 28 Feb 2025 10:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740737849; cv=none; b=dZ1178SbgYPBOhpNaLa7eBtJVQASb073hxE+omfy2LKD2wcdskC4BjtRwfS8T2lfBZD6WfdDAOcmYhOdhrrssxWS8X3EgKa0ZYvqDgYOYTaxRq7K1ibM8IZSkXlnylPSxUNyGcKuvQjE8xpzfgRifB+AJAqzRpCB3ucUzZAWSv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740737849; c=relaxed/simple;
	bh=b9yW9aKaAj0vv2X4pBwVEAQJxZ6g3pOXCix4VsedwdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nhaz5Eb4d+pkBO/H89sE7h9u2QHOQVz8GVWA0/7LXrf3IEbj2LaMmj13sPMIXgSldxaB/g/vnzB15kTe+svJh6Ot5ZOA4H/PdEma+QZVvRBqVEZWPX+TuJFqz4hk/V0yFyBtRlUR3w1egmqybpGkh3AcPHacYt+LnwkUMe1jjqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=raxQR0X/; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5484fa1401cso1691669e87.1
        for <linux-pm@vger.kernel.org>; Fri, 28 Feb 2025 02:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740737846; x=1741342646; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BtF5m7Eo7tw5lbKf+07cY2Tp/XNLgGV8I/BZlAp6LwE=;
        b=raxQR0X//11z6BewOta7agfUypiDhK4ApQngGZqwK+M/3S2fl4OV8WSIpzq8OPdwtN
         YMmQnIEa9idk8m+Lg15ITcP+7txroImhd/spu9J3hzPt3njZlZwwSTDZirviFGVvLHq4
         LgK3UXtjhnpBiFWB9hFhw+Az+OVik7TZWbmJiK2v8nLlICYhec6ODatU4mwlSTiBT7uT
         HBUPBrWymsDYnxgmvn393qOrpJmFlLV5kpTHlZDCwp84Gge5dB621/Mf77BlTB1ughfd
         TNY0ZcBQPYTPA/zp+C/AcVMGgL70cvPpL2bmzR8DQzYARGqDIbSjL75siqrpZiEfpR9L
         nbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740737846; x=1741342646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BtF5m7Eo7tw5lbKf+07cY2Tp/XNLgGV8I/BZlAp6LwE=;
        b=RF5/KBfsRw5s+l3ThsodYkbYa/DYZGtZU9dHjvwqfV/YtJoayPHXIoa5v8KI2Jq/Sg
         lhKqzTV1/Xo8vSlLT4j97dSc5ybb/EEw4kNOQ7S59SNzlUQTKY4xcc9gpEBF/nr9acpR
         FVC7WImISOr0J+Vi+LQc6e18x8YAPNy2LkJowXR42hcjpcoCHf6o35w6Nnq/zQ5VQzt0
         K0qUOIoxRJXf8Da3zIfMxq8uk3btzd+JpSQo2ooztpcVcCQoUEFnWP5PsvWpDRtM2mJ1
         YCyumqUTUHEZTtenOEfX0xYbCvxaxtZpSHAnVMwLH0dLxydZh40d6z2Dm0ri23Luo9Qh
         /I3w==
X-Forwarded-Encrypted: i=1; AJvYcCVc88Y9rjQGJjK9Rz7sjn26iSVXj6p2NpxuonNfNHinbeFEdw7EF7gaYPxIXqB5cIL4fxLzz+0wTg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEdPpT2UV9kegekBJUlIi7VQ1xIbkwLM+kLsuIJEckNBlW37iz
	KKHaf7YI88a2ClfHnjXD4KW3WI50cOvFPTjAuXPfGh8i1IAIdCkydx8RBXm8z8o=
X-Gm-Gg: ASbGncubi7MeDsKOuXVOuB4glFgbmdEhxQIBhY6Xh4cnkI8y8CspP9c5yc4CmblSM5m
	jNfSQt2uaZL9shqEooiL0gQ7zR9NG/GktbWUnpVS7cvhq5+bv2cmwauS1LfiTL1zx5Le78796OJ
	GILTYKPhsUJdI10gmDoJo42c54wYJLedoVKePXzizAiijA/4Dms6VDti778NCEC0bFXvEP8Ze02
	8+JJjeDnqZoKfpwJPPI3D2qkFdUt7iqBZbVBBgcPzm81zCx95pyre3zFTeVECtBTw+uz581i7PI
	5LlMwMw5Zc/DEdVBjUbGTFlVjxV8EXrJk60x1Q61kytAVkjJF+bMjIMUeZNltA68PMn0kvT8Esg
	8J2Gvkg==
X-Google-Smtp-Source: AGHT+IGumV9C8K5BUf/QNt3duu1Cz/DHryWxGnIRVWU5r5VemArqgE7BiCYNujMBRO+d3tj1JXx2Sg==
X-Received: by 2002:ac2:4641:0:b0:549:54f7:e54 with SMTP id 2adb3069b0e04-54954f70ecfmr305434e87.50.1740737846015;
        Fri, 28 Feb 2025 02:17:26 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549443cc9d3sm440219e87.224.2025.02.28.02.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 02:17:24 -0800 (PST)
Date: Fri, 28 Feb 2025 12:17:22 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Amit Kucheria <amitk@kernel.org>, 
	Thara Gopinath <thara.gopinath@gmail.com>, "Rafael J . Wysocki " <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thermal/drivers/qcom-spmi-temp-alarm: drop unused driver
 data
Message-ID: <u6h3ekbyhlscbf75wz5zc7pusizky4o34i5h3uluch5xi22oba@x7y4mhohlvgx>
References: <20250228082936.5694-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228082936.5694-1-johan+linaro@kernel.org>

On Fri, Feb 28, 2025 at 09:29:36AM +0100, Johan Hovold wrote:
> The platform device driver data has not been used since commit
> 7a4ca51b7040 ("thermal/drivers/qcom-spmi: Use devm_iio_channel_get") so
> drop the unnecessary assignment.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
> 
> I noticed this when doing some rework for pm8008 last year that I have
> yet to finish.
> 
> This can go in meanwhile.
> 
> Johan
> 
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

