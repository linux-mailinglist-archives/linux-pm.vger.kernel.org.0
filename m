Return-Path: <linux-pm+bounces-33793-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A679B431A6
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 07:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37207544C6E
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 05:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07E72264A1;
	Thu,  4 Sep 2025 05:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ke8g1+F2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2814B215F5C
	for <linux-pm@vger.kernel.org>; Thu,  4 Sep 2025 05:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756964225; cv=none; b=atEeRPk7U9KDAagi7ud3JAzI4KfJkuU1Iy75yvgQHWhx8dW1g5yOCHfbGy6MpFpP0JFvWbhizt/yxv4UFHAQ/G2c9k/7ZrtcvcL3T46Ur9W0eTAJXg31BDwivWjZEbFSUKl+cNuzMZPx6WOox1CBArWKRgDP2wyWLEI/OweZS/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756964225; c=relaxed/simple;
	bh=b/a2yCMJq8KSVArlkt++a2zVi4wOLEM4CymEyHYWhJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LD4mZGpECZrsdF4VApuJo3wxGepUnzch2JFgcrkiKcBv6AVvdRfWGyFo5CQzH3nAEdIgm2zlRUkofJqn/kqrEV/8y82srLOO9/xRwDWkPV0zSxAc+396R4sLLyF38NzqPHwafVUshdOo9Ab0Q9PqEXZTclaILwLVxbOvaogE3aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ke8g1+F2; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b4c72885c8bso527998a12.0
        for <linux-pm@vger.kernel.org>; Wed, 03 Sep 2025 22:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756964223; x=1757569023; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EBf1R6dd96LkyOGtYdweLqxruOgKvQ3zhyso28sYrAU=;
        b=Ke8g1+F2ja9KN+Hn4KbFn5qyRDkNn7NZqmGsxVkt4n/EJc2gxEswOEk/4AHLE5QePw
         6D5r+MNGaVIfedR2QUmYKJWc29OsApzzb42+3pArbH6VYRFc2GKevZBvFw9vIDyBFqlj
         ZPkQ68+bx3OjyXvOim9lXqhz2dYwa4/yiaMudMfs7VvZirC3fWKRbCjwBGBavZQBCybk
         1sAyBe6y3o1qXkwWMJzIqlo6VcVWf74TkLJXvIJ5u3D/QGMwWiUMlTShzf4RlRsiR/NV
         kNJZ73HV9CZm2hNNeaVm253GvN6MJ3Pz8EcJ/1ILUy3yP7d8+HyVEp0/DF15qmEplfIl
         Qdcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756964223; x=1757569023;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EBf1R6dd96LkyOGtYdweLqxruOgKvQ3zhyso28sYrAU=;
        b=rQyNGqYgBp/rF987WaHPC5Jh8dlXKfAP9HUTFWiY8V9Gjr2kF1jPIIyoMQbx/jmPvZ
         wnqOJnKhC3ZQrGRw+ITJh8P07qixhqadaVyxXu7sho8b3W0IcMuWSFVKlFN1TqwHdYWb
         QG9ILUspRUgZFOlzAZQXkfSVPGW/NiodnaYMkkE0s74jnhTpc9dG8dmuo7+CfQa5FvIs
         AYABcNp3dS4dqB2wDilAI4fEvrjkYZSwbwr+VqXImgLrsgX9lEfJyuQ/ZFtvme4mCRQM
         qY1Q2UrvXs8Gbc1EmwfKErczguwhGKK10jFlLvA2D5hZEvFgsHLsGhL5G2HuemQvQF6c
         ciBA==
X-Forwarded-Encrypted: i=1; AJvYcCXPHLgnKZwZQuhsnWfhWG2zoCG1yiRrRVF8Dogi7Nz9c5bUVuVpYuOtdzf2AED+OFZa6nF2qICZsw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDfERZg+J8mB6pdw9FH5W1t6tLJP0NiFYk4prjF+xOpBAJYDp1
	rnnjiWiv+3RM65imMwC6lRg8MBrhtJrESUQ2CX0SVaqJZA0oSeOvh0zv7/vIVLKShts=
X-Gm-Gg: ASbGncuKH8hnOmo4rC2d3xnrAN2QKGHSKJUsqXMK+r8JobL7rqo5VcYFdqmSyXcSUEh
	PGQ8gBH6M/0aK6J6htKtUrn0RhFK6jr0lqkGK5hN2y9ds6XtYhibRON6pyentBc86lzWD2i3RBQ
	ZlkOlOz5zQaltp0ec3hmd842BBHEOq+Bnt4yVoBltXfRIAPwDY0FQlHMSSI3wJjNdR1FEidxMlF
	gNInU1tuJ2vMPaKDY9z/bbiOGFkuZ+Y4CSX7ZiCv5z4jY+5JBQXUQqOqD6e6Z9Y4H/i9buyQvQZ
	Gb8iM5wdS/4FP9S141pfSz/R+Xky6VRGS0r7M1w3IxB9OrGn3VKIvdVkAH7m0UN8aWfNFGdIlC2
	JcFC4KyIlSc0rHKWYOQZJ8reGxjmk2Gm+vDc=
X-Google-Smtp-Source: AGHT+IGYv9Ir/Bw5lHB3i4/uKJRbACnb4yPE53+Njb3AnK4qpxjJlR6XcFtBO92SmhPZXbDvwrNAgw==
X-Received: by 2002:a17:902:e5cf:b0:242:8a45:a959 with SMTP id d9443c01a7336-24944ae5ff7mr238904595ad.47.1756964223270;
        Wed, 03 Sep 2025 22:37:03 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249037223d7sm173520045ad.32.2025.09.03.22.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 22:37:02 -0700 (PDT)
Date: Thu, 4 Sep 2025 11:07:00 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "Rafael J . wysocki" <rafael@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	zhenglifeng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] cpufreq: Always enforce policy limits even
 without frequency table
Message-ID: <20250904053700.abdkh23zwi5x65do@vireshk-i7>
References: <20250904032210.92978-1-zhangzihuan@kylinos.cn>
 <20250904032210.92978-3-zhangzihuan@kylinos.cn>
 <20250904044812.cpadajrtz3mrz2ke@vireshk-i7>
 <540469c3-9bc5-444e-87da-95dc27fc481b@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <540469c3-9bc5-444e-87da-95dc27fc481b@kylinos.cn>

On 04-09-25, 13:23, Zihuan Zhang wrote:
> 在 2025/9/4 12:48, Viresh Kumar 写道:
> > On 04-09-25, 11:22, Zihuan Zhang wrote:
> > >   int cpufreq_generic_frequency_table_verify(struct cpufreq_policy_data *policy)
> > >   {
> > > +	cpufreq_verify_within_cpu_limits(policy);
> > So if we have a freq-table, we will call this twice now. Why make it
> > bad for the existing users ?
> 
> 
> Just to clarify, in the third patch of this series we remove
> cpufreq_generic_frequency_table_verify() from the table_verify path,
> so cpufreq_verify_within_cpu_limits() is now only called here. There
> won’t be any duplicate invocation for drivers that already have a
> frequency table.

Maybe I wasn't clear enough.

int cpufreq_frequency_table_verify(...)
{
	cpufreq_verify_within_cpu_limits(...);
        ...
}

int cpufreq_generic_frequency_table_verify(...)
{
        cpufreq_verify_within_cpu_limits(...);
        cpufreq_frequency_table_verify(...);
        ...
}

For a driver with a valid freq-table, we will call
cpufreq_verify_within_cpu_limits() unnecessarily, isn't it ?

-- 
viresh

