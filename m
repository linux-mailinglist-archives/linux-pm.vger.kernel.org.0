Return-Path: <linux-pm+bounces-18517-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CCA9E33D4
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 08:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75CF9284F9B
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 07:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F5B18B47D;
	Wed,  4 Dec 2024 07:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZmK6jvMD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DDF188A3B
	for <linux-pm@vger.kernel.org>; Wed,  4 Dec 2024 07:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733296010; cv=none; b=G9pajBGKwhg9A8rQcbd7XNJFqL3zackLwMo/OQYrWnj4yj70YEQiuCRtu3DoO+nMgmworPmBKFH0PjMJTGHNGpZDppnGWMqoOJsmW1R1OIe8gzto0wif1Z84F5JqDlm8WQynTiXT6eIUA1UEg7W5kwLGGocqFyVYkU2lMt8BmQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733296010; c=relaxed/simple;
	bh=cGlfrmz+NqreEMAIegTgQf/lwOLc4c3SnJaIudI5nbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RVFQVPYWmcTYkVna5voVSCzlARj9BSxIlwYWiwjIJ3832iJaUkDoyR8oK+NTS2p5h3K9LK/qYiP6lnH/KD3Apo4v8fFdGLheyGOSSdLLJqDD1MNPtIHtiIHSmF+sP7owils00Lm8e6Ni2QU6xadtPu4sM+r8h/9SOFCU7nZPWNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZmK6jvMD; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7fc99fc2b16so3827522a12.3
        for <linux-pm@vger.kernel.org>; Tue, 03 Dec 2024 23:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733296008; x=1733900808; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xA+pFDHJg3JhuJO3t6B1WVFWzMnLuBLDIJWm/HSdUeE=;
        b=ZmK6jvMD5KpCtMToxjn2rYrq+ODnsUw+YkXnToMzFDJCRlvCwYmK9gmYVnT9jEh31n
         amE/LfIVIFapl4+AZ8lXH2ZsD/TEGL+2EJERVaJ/eFoBU8jRPLV/5p3qAe0Rg+k+kcDZ
         ImfdmS//e2UXActguJNrCYwSNLelF5S26MxmIBgMsh6X6WEVpOS81BHkKfmYAv7LawUQ
         62nx5nny2xRX/1FpVc1I3Jk61dEVHwsJ5Ty+eu9z3fDlllOKhJOIPWa2kE6tA489MW1J
         n0NQQZz2N1pIcJ+ea8P/ycqBi+Rw7oroLf/QhXy7zHK7e+eYmPpdhlG77oH1yzFQkwvc
         D5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733296008; x=1733900808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xA+pFDHJg3JhuJO3t6B1WVFWzMnLuBLDIJWm/HSdUeE=;
        b=CRGL2P2sWig7ngha9+y5B1aVM6iupK25CgWJZq0aaO0w98ACmqx+0bIimwrzTDLD6Q
         SUY38lND7mG47cRqxJvKY2BtrDsmJUNJI6GoUhLu4if/ygnXxWdhJKIGXa6hjKkPaidP
         g57OQI2S3Qz2okKQHNFLbUUNt8z/e+GN82N4XQV4EgxWpXk7ZhNKnp/WMhZzZCyNxhcZ
         xR/Cp6hVg14B1XR3Pezk175QqPks8kDgrkhutzZDktzctD75p57N//KfgYgZa+Thp4LA
         itwYj1rohKUlk96XcMw/Vx8DFtideKtiYZyqx2PgA2tAnaMppLwaTXBrx53cUS94JgaD
         DpSg==
X-Forwarded-Encrypted: i=1; AJvYcCVNHa/xZzXAX6EQZkBjMar1rYVwfcD/taFdKjRRU63y9pDdIvER4mLEPy+G7YRTq0S4UKe/+/8ZEA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWqyZI1ZpD+Q5xJkRLrmzq4Xa3p1C/FtCpfC+a2w2CSjxOxsBn
	30+Y4uqNCPN5XLMI5LhY5dUaM0kPOChBltXaZwUQEi46y/ktcUSxv2vDtWDgM5Y=
X-Gm-Gg: ASbGncuel7gLErnt4gST3+buW9NtEILQBYyWFUKkfXIczQe32vrFTlrGqZl3PE4XmDN
	WY0NlWPdbit/PhFKm358fxyAesTsIKxSZ97JaIQYvMY0C07mVA/Ocv2QsLCqmNWJDNSQ7tPrR5u
	TlCOfkYKZCDADveRN3DKLTgh3dKaxdTO/UikZn3u9P9LRTDCErrs91ssa2Q0HCPZFRcdsoBcR1z
	wJKuhTTFywI5pr1/wmR+F1osnDxCZXv0O7VKW6uHR7TArqAZaE7
X-Google-Smtp-Source: AGHT+IG+WEflcRy0H3XEQNdVIydDsgK82mB+3ttGOJT8u6l9qXJ9IQZOOl8bI5c8OzLfA7MXQ9iRSw==
X-Received: by 2002:a05:6a21:999a:b0:1e0:d766:8da0 with SMTP id adf61e73a8af0-1e1653f2427mr7360540637.28.1733296007968;
        Tue, 03 Dec 2024 23:06:47 -0800 (PST)
Received: from localhost ([122.172.86.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541761246sm11705852b3a.12.2024.12.03.23.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 23:06:47 -0800 (PST)
Date: Wed, 4 Dec 2024 12:36:45 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [PATCH v5 2/2] cpufreq: airoha: Add EN7581 CPUFreq SMCCC driver
Message-ID: <20241204070645.4paiiaj5lsvlohlq@vireshk-i7>
References: <20241203163158.580-1-ansuelsmth@gmail.com>
 <20241203163158.580-2-ansuelsmth@gmail.com>
 <20241204053211.6gdogcpi4g3eavw5@vireshk-i7>
 <674fff09.050a0220.293594.24be@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <674fff09.050a0220.293594.24be@mx.google.com>

On 04-12-24, 08:04, Christian Marangi wrote:
> The idea I prefer this is to save a few CPU cycle and also to prevent
> bad usage of the CLK if anyone starts to use it. Returning 0 from a set_rate
> would provide bad information. Or your idea was to declare a set_rate
> and always return an error like -EINVAL? 

Returning error is not okay, as it will make opp-set fail eventually.
I think we are doing the right thing right now.

-- 
viresh

