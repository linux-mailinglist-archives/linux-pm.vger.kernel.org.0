Return-Path: <linux-pm+bounces-25905-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F4EA96DDD
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 16:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49E2A161A5C
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 14:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83D028150D;
	Tue, 22 Apr 2025 14:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k4/oToVw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2995D1632E6
	for <linux-pm@vger.kernel.org>; Tue, 22 Apr 2025 14:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745330700; cv=none; b=qseSy7leeva70bV4AoD6NuqydP54m1aqG2/2sOEdIzYYK7cYYQ2kMmVY0OaO8zikgzqMygo2iWeaLzGwkYnciMHWHNfnOj8Ukd8+MQUiqswXerVEQH7qIbOJ0w2MHYVffP9ukBYE4U3FMOergGzL1/Mv2L+Ua53saaGkZ3zcBK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745330700; c=relaxed/simple;
	bh=CnFn6dl7idbTdtr/X4Lf3KXnyHFj+WX4URvdrrUx2FA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0+vVveOQ5/9CKX9eyLpGMkvKyyBgLeFrwbnxPbK+huj+XwQhOCQSQU+u86cdQvqaP5h/r551bopEZLZ4w8JjIe7Dy4UdU1KGrfPtVgfoEzMIf/WWSwnoffSwfcBJWWR7vqYfGUyTGrO86z1BRglxCluGLg+GUAYZ4br6HEfV9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k4/oToVw; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so904841666b.3
        for <linux-pm@vger.kernel.org>; Tue, 22 Apr 2025 07:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745330697; x=1745935497; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HPj38otgPfg1CUWLGvk15FrHBLxa1jnnTKS9SOSBOj4=;
        b=k4/oToVwUcwVUigqZAQ3uQswidA8klvJCr/7shMqoyq5U44IAPEeFXzAQgZt+1cYkx
         evum5XN7R3TCQrPgbqQ6LjZPA9XVkL+EJCk8Z8Kh/38vcE624uA6VjtcXyHUuvfOUfej
         /oeEDCpNOfnwgHL4ityY8hfGRydywpykytbZ93kxehyA4ScJN/wggIgHfecY7mdHIlKz
         Ad+z3G869rNHYJnMhz6xhuCyRM2c3aHfS1N0ua0aFLNRkAPAIkmK+u25qGMbWO0Ww+CY
         QJZq5sKfgKGsjJytpQqK0FSW++vw9HcWf8YLcl2bViqMgzhw1hC3kbA1mc20gbvTlHnB
         L9+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745330697; x=1745935497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HPj38otgPfg1CUWLGvk15FrHBLxa1jnnTKS9SOSBOj4=;
        b=AUJ3aUKQQ2lP7MqibcOIULW4YRq8+75M4NJehc4Ugrj1Mt1ZXIBFiVl3IdTYTk2ku2
         1EoXVJWpNF0wNRAgad5pDAxktq6C/OHhV4vwTf3GfDeKUWvweg7137iQyP7o3uYuiQ8r
         1hsjL5y+o0DfM3DTKHSYFHgSnjZJb40zQTbHOI2nwjKghr8MPv1jddVVmv0oipxwAOKd
         TFjSf8yndjXzrChstXg/uXxDoOD9hp1SRm10fQaZUo7lxhzOh64zVxQGtu62E/LjsVC3
         rjAok0OL0MigNTb+Gf1eg1ZiSz2HhTYpAllJg6bhxcIce8myc1uynYtDjBHZcntnqNM2
         Qj8w==
X-Forwarded-Encrypted: i=1; AJvYcCUJcQKboLXbUrccgKfRas4Agef72Pal1R2ZOaQMqBZsAzs66aEXYVSt81YUL/sl3MXIyw1K4rBZ5g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXzf+k5atBMk+FXlFulfepdQi3Vu3Y4fAtDR7yoG1JOPgbFcpZ
	4VIWc5vDc1uVzK1ygkDhGTIITDtOGKYDK2hU16LAGfg0WMLRdPynS36hwY5kBYM=
X-Gm-Gg: ASbGncuKSZL+m2CqSDA19ei+WWv+JwvlDwPxHf09pxpRYKeiCTN2FVkncj7eoBmRdRB
	HNf3Wk8OsYKjv7SUYFBJv9MDYNlOAyh3mZLfYPUhawtR0+aGUOngl3K1ReduINOmjcDLrsXOi/m
	8sp31pEXbutAtSThkXOUcGkU4Rzo6+9VSewhe+OM8itS/5SIRJWJBVGx68SFkFEYpF/1jze/FWI
	HGR6T/N5LKqf/DuQyDClgXr4RdyAjpaZrr1TGB6Gvtut9QiMX36rE/z4ewE+Rq5sbQz84DhqLxG
	11yMNq+7DGoi5Nj101kfAGbybhiJdWU7h2Dt+A==
X-Google-Smtp-Source: AGHT+IHdC+QkLw/63IGYXQS6q7rBVNNk2potXnQUurnAaNgoQ1+GXHaWxq0i9ui980YqMIhNIDyKmw==
X-Received: by 2002:a17:906:4fcc:b0:ac2:87b0:e4a5 with SMTP id a640c23a62f3a-acb74ac51f7mr1244467966b.2.1745330697218;
        Tue, 22 Apr 2025 07:04:57 -0700 (PDT)
Received: from linaro.org ([62.231.96.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6eefcf76sm669687666b.100.2025.04.22.07.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 07:04:56 -0700 (PDT)
Date: Tue, 22 Apr 2025 17:04:53 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Saravana Kannan <saravanak@google.com>, Stephen Boyd <sboyd@kernel.org>,
	linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Devarsh Thakkar <devarsht@lewv0571a.ent.ti.com>,
	Peng Fan <peng.fan@oss.nxp.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Johan Hovold <johan@kernel.org>,
	Maulik Shah <maulik.shah@oss.qualcomm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/11] pmdomain: core: Use device_set_node() to assign
 the fwnode too
Message-ID: <aAeiBbnWgHUkt/HE@linaro.org>
References: <20250417142513.312939-1-ulf.hansson@linaro.org>
 <20250417142513.312939-6-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417142513.312939-6-ulf.hansson@linaro.org>

On 25-04-17 16:25:03, Ulf Hansson wrote:
> Rather than just assigning the dev->of_node for the genpd's device, let's
> use device_set_node() to make sure the fwnode gets assigned too. This is
> needed to allow fw_devlink to work correctly, for example.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

With Saravana's comments addressed, this LGTM:

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

