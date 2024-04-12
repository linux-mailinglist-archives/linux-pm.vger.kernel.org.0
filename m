Return-Path: <linux-pm+bounces-6295-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F4F8A25FB
	for <lists+linux-pm@lfdr.de>; Fri, 12 Apr 2024 07:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2060F2836C4
	for <lists+linux-pm@lfdr.de>; Fri, 12 Apr 2024 05:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79C81BC20;
	Fri, 12 Apr 2024 05:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q+PqjxQg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4311CAA1
	for <linux-pm@vger.kernel.org>; Fri, 12 Apr 2024 05:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712901142; cv=none; b=kuXlGdYjE+PDTbkiHzJWY8bpQSNaQZWSp4fiicR8yFPzh18a5XhBp5LfWabZH8nhjRZydULpxOK5jA4jVK78H96KBS/4sXlKUYHWTnIDYDViWDG4lt4kVerUHJ19N1RN0ketF7VeLUJMSVC7eisblVleBPpHwCRbfdrlTHSkWjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712901142; c=relaxed/simple;
	bh=Xk89cVFkdI52ZyYOY7Kf6L78ue6asWefaNYNc0ddo/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TvwwVYlY5itlAT5lFwQj1rdYpftdPmm+vbou6uIGzV/+Kr47OLP4Y+kNP3cIwV+MKWdrU9fy+OHmF62QtpiQYPGVWXdc3fI8qHeos9yMpVghSrAtpPpA92m00Vxdh3qzRvC/a8IMvzcns1dXpixZfl8Hu17hbv+vKBV4GMmnNLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q+PqjxQg; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ecff9df447so604551b3a.1
        for <linux-pm@vger.kernel.org>; Thu, 11 Apr 2024 22:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712901141; x=1713505941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5k+qpIN+bvCtZK47zSdCc5SpgFpAXhOx3I1lcWOdYRY=;
        b=Q+PqjxQgvOjxZ5hnJUQXR/Ow3sDN0AyHJwJwbg1X39q7ocXIJKkCM1qjTPLEoitVFE
         3z6nK3iagvprth2JuExAmHyU668b4BVktP+HGQjnw2q53ttE4G8CHTOn+N/hK8XIXs44
         BDBkpEy2E/4pCBZuIl8/YHk1WJ4R5fKRnV4iLhyypNAij32cQF12gKqa8mqwAMoF+48+
         VhcsRMZG+EXuvI6caxbOKf7Oqtu8/JinhsM9gvGJSRAVNe/kA0xYU5F9rUlSRc0tULNe
         OE/mE3Oxxyv16mCmIh7q9bWnfX8MQNKy/Xhlrt9jas6EyC6eeE7qL3kYpnL2TOhTlwTY
         f5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712901141; x=1713505941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5k+qpIN+bvCtZK47zSdCc5SpgFpAXhOx3I1lcWOdYRY=;
        b=PWsfi/QriBmd3w7C3lBMBqkUNrq2IEHf9Q9BMDr9JdNh4I3Q3B4K2cCSmL4DUsjLVZ
         rfc8bKFPk+Khf0ZTJOQwHgTyA8mRIhxc9wd/3p4O62WLrm991CRf4sv5akLfLk6/rnJ5
         aorToD9W677hjfcdaYMGTg6W66OB8RIx4StxGck7VtV+MJ/7bq08cDDIqegk/Pc5io81
         JagSwVn8esz1AnRwtu6BmrNp4b37jiOmk1nKPZz/irbEkRTBScPDKJpJKBvwud7Az/P/
         zhx7pI0nre31DMeyphg+ZcdvyDdbAxff9q3PHwU1R6VCb82CO4i/2re1HYM1+1q1fg65
         c1tA==
X-Forwarded-Encrypted: i=1; AJvYcCXRquh+/hdtYvwBNXmL7W2tnV1q2I0Fkf+2OL+PfakpdzDIMPo0viA7OOB0oVK0OR3LwOUgC5P4mSyFvP70bpTUmg8LDIC5w+4=
X-Gm-Message-State: AOJu0YwYGV7s9yWXCnMxxTKyxMllZ+Hbjjxyg2e99hQY09PU4SnP+kFs
	T7qhtTAsCOZj9tcO0rbtn7FZ7nFFqGdWUqfVZdpUx1tttN/BHFAL9O7jGVxU4M4=
X-Google-Smtp-Source: AGHT+IEXREnuzVi1AWDuu5Crjz5K7NndQbQAQd/ZmvZa+sa7/KprNUAKuey8qhUFNPPhIvMOzgoHQg==
X-Received: by 2002:a05:6a20:7489:b0:1a7:8978:a6b1 with SMTP id p9-20020a056a20748900b001a78978a6b1mr2458815pzd.16.1712901140744;
        Thu, 11 Apr 2024 22:52:20 -0700 (PDT)
Received: from localhost ([122.172.85.136])
        by smtp.gmail.com with ESMTPSA id k32-20020a17090a4ca300b0029c3bac0aa8sm4157940pjh.4.2024.04.11.22.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 22:52:19 -0700 (PDT)
Date: Fri, 12 Apr 2024 11:22:17 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Lizhe <sensor1010@163.com>
Cc: rafael@kernel.org, axun.yang@flygoat.com, linux-pm@vger.kernel.org,
	linux-mips@vger.kernel.org
Subject: Re: [PATCH] cpufreq: Remove redundant exit() functions
Message-ID: <20240412055217.soyzvivcenoadt3m@vireshk-i7>
References: <20240409141909.4413-1-sensor1010@163.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409141909.4413-1-sensor1010@163.com>

On 09-04-24, 07:19, Lizhe wrote:
> The return value of exit() is 0 and it performs no action.
> This function can be omitted. Please refer to the end condition
> check in the __cpufreq_offline() function.
> 
> Signed-off-by: Lizhe <sensor1010@163.com>
> ---
>  drivers/cpufreq/cpufreq-nforce2.c   | 6 ------
>  drivers/cpufreq/loongson2_cpufreq.c | 6 ------
>  2 files changed, 12 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

