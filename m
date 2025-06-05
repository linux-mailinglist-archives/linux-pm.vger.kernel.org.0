Return-Path: <linux-pm+bounces-28146-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 711E0ACEE18
	for <lists+linux-pm@lfdr.de>; Thu,  5 Jun 2025 12:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43E663AD179
	for <lists+linux-pm@lfdr.de>; Thu,  5 Jun 2025 10:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8035320E031;
	Thu,  5 Jun 2025 10:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hbtrbKPB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFA4214209
	for <linux-pm@vger.kernel.org>; Thu,  5 Jun 2025 10:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749120716; cv=none; b=Zi35MvUj19KY2G2JDChgIDRr9ZEqNgXKCpm+nk1YpaEorCscbKAoWlucl9zAgu+RVqrxJottoqEQZuTcZ3mX2csKyalTCxSGP4RCSwLZYQ9/3bTq836QJxCBs4vbk6jsf1PtkjsJXJ+Q+Di6/Ji7o1onoN1lYB1L72OiUmRe9B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749120716; c=relaxed/simple;
	bh=9id0PzQTrOqnlN917S6tmcSU7arYBTtwcAmTKUqpTx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6QaeLKYTam/6MWcMQk52XAvJ4fGPqp04+JTsmTZzmP+ZsPa4vm4edMRavBC7JZn3XL0jjnIFLn6iYHfgBtPkXMzkmYYMEi7DkMwS0odNnUv2H8S8pPtK2nyf+ShCIkUDfOTn3hfIyT1xFvBltA/Ok20oFbElJ6Qwynq/gdh5Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hbtrbKPB; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2320d06b728so7600965ad.1
        for <linux-pm@vger.kernel.org>; Thu, 05 Jun 2025 03:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749120714; x=1749725514; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uxflC1Je6NBv1CJoZue5ehKHX4k8+2rNxAhbjWUDhZM=;
        b=hbtrbKPBfLdZftS5m6fu1Ss2hIstIW3Cp0anwuguqXV3zglRPeYqKXFTwGrzUn+tH+
         vJ0vd89KqScK5E1AAr4CFqjRKjbF9ywpifhSEv0vZFa78/75Szn0iqXQZHUtoR2SPiH7
         hx3NWMIHr1VfTb0WU6ZkYcHwOCFMlF7z0nJJ+0c/1NyFi68EZBzwt6985ZWOuj4gJ7Tt
         30MHYOBU8RfIUKI2ijyfgSk+k3oa+atXeNcD09oF3jFhFvq8gZP690d6MVicFuBL3Aa4
         goPyaBwxOy5+cbH3wy9u4HjmLtjSPG0X/W4N9hjhkpmrHufigOG/IpWQ38OYMgyIuMH2
         rodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749120714; x=1749725514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uxflC1Je6NBv1CJoZue5ehKHX4k8+2rNxAhbjWUDhZM=;
        b=DO16IjUwPr3++iPrnbx0z6No6he7jRt07pSe9DcK4iU8wqdZITQYNVrouoc945nOsb
         ZAEOZ1/kn/U9fW2I6iewUAJJ+C64O8HE6wqz4zLxI1orOet6a92xgQcznWO/sEGqX8iH
         /Wb/YL3TDSZ47jrE+Ab8kgExA1PpcWrFm2MUtAHZO+4pAlSCXOE6She52glD7mJOR9dw
         ePgSGxvlXSh/0ncdw/YusQF1UvosO0Mo1mj4gkF5Oz98BFccqbPQjqqcLQfCYolZhaF9
         +ZVNoMT3wItKa5Z7s4S5WW/9qa150QPrP6RuNo98pxGIQrawN6oMcxXTOBt7dGB9UvlH
         A4kg==
X-Forwarded-Encrypted: i=1; AJvYcCUgk/OPAS8LQK6mLU4qQD3uUD+IkxhOkuv4Ee1VlCmjZAVC0sdNGtLPGNclo0UY366hPSUfNEEBVw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNjIv6Lu1dEcSLxjBUNHbpg3df+4SPCNxfnjV1cJIXLv9T2/FH
	jDr6ghmKkKUMV+kmtlozAuBr58V5Q4OW6dYdkJI+8CGivy0ydSFvs8ej7DKaIh+qeAs=
X-Gm-Gg: ASbGncs+b6JecrrdE+EZSGSFaqA+h+BOU7X6AsGanlkiATajSKeiQVa+92oMhm16Ado
	4OwsIRTnVQDAZf2vPIfCR8KErl3KbDYb7w1fSnwjeH/pENZAw7sfIJEsIbGxoTWWglAf+9mnbzU
	L2s5B2uc5Mx//7ZJ0L0AoVmz3I16ai8adJjl7AS1n7ZtqJ2u70kH0xVvovq/c6rt++rQVaBOJV1
	xGXfKLP61C9BKMrUP72G3OoeIH9OyrIQS6wTmnqn9ZwCVB1zYKJHU8jkInF3MOe+UK2JMDI6xgX
	VHWhsmTCQPkMmiwerhTW3EjzM4oITYRrTrul+egxV1X/qg5jObAQ4o+y3Fl4o7A=
X-Google-Smtp-Source: AGHT+IHu4tZbsrp8f4l8H1I6bLci70BraNurpBDLKW59gH4FCKAHsDuVR+Uq4YM1lGTVhc1gzWLHVg==
X-Received: by 2002:a17:90b:48c1:b0:311:c5d9:2c7c with SMTP id 98e67ed59e1d1-3131109959amr6859743a91.23.1749120714352;
        Thu, 05 Jun 2025 03:51:54 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313318e6846sm1016088a91.8.2025.06.05.03.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 03:51:53 -0700 (PDT)
Date: Thu, 5 Jun 2025 16:21:51 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: webgeek1234@gmail.com, "Rafael J. Wysocki" <rafael@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v4 1/2] cpufreq: tegra124: Remove use of disable_cpufreq
Message-ID: <20250605105151.5s6eblr472mbhunt@vireshk-i7>
References: <20250508-tegra124-cpufreq-v4-0-d142bcbd0234@gmail.com>
 <20250508-tegra124-cpufreq-v4-1-d142bcbd0234@gmail.com>
 <040b0d8b-e862-48dd-9b77-9266a5194f99@nvidia.com>
 <20250519101725.k644wzizjwygtwa7@vireshk-i7>
 <49e7d006-e9cb-49da-a4cb-b73a08f6b792@nvidia.com>
 <20250520100218.te5i5ltrx43zjsq6@vireshk-i7>
 <9826e66a-3474-4a00-967d-b7784ff60be4@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9826e66a-3474-4a00-967d-b7784ff60be4@nvidia.com>

On 05-06-25, 11:34, Jon Hunter wrote:
> I think that would be fine. Given that the tegra124-cpufreq driver is the
> parent, if it fails to resume, then I assume that cpufreq-dt driver would
> not resume either?

There is no resume interface in the cpufreq-dt driver, it is the cpufreq core
which resumes to doing DVFS and I think it will try to do DVFS even if tegra's
driver failed.

> Has anyone tested this?

-- 
viresh

