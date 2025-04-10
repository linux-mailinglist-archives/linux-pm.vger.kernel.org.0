Return-Path: <linux-pm+bounces-25071-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D70A837ED
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 06:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7F9B8C12CF
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 04:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876F21F1509;
	Thu, 10 Apr 2025 04:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EkX5hOhl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267C31E9B19
	for <linux-pm@vger.kernel.org>; Thu, 10 Apr 2025 04:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744260034; cv=none; b=MTfEQBz7NPBcGyp7VPn0rdCoCeRaw94i+xwjgamhEXEHPN7CdTiNCLLSpOVU/cSyXgAbP6wsnjR/m5RLOOJNENOCaO52bxJOCVS6gb8PesYkDjfJrh0ut3rIkeWC3jtXjoTXz2896n3LdgbK46QQmL0LKngFKe+rjWYEFzNpcpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744260034; c=relaxed/simple;
	bh=sWxyNmIBqTA+5eg4r6AJzmQjZ1/kjCXLuDHCQiD2z9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rc9dMBCMotB5gteKCBCkoE9HRuRqBikpRhfA8+clMY/++de9bt/B0vFAFTWDKNfd1ZxN17k9AX4DqEt0vPdJvlpaPRt3N0nGiZyZKfFY5duq00lSEhotdR+0qMDEv240N2AWV9qWq/1/5R+FL8iE+VBuWoiV4XvmH4d53A9yURQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EkX5hOhl; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso444493b3a.2
        for <linux-pm@vger.kernel.org>; Wed, 09 Apr 2025 21:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744260031; x=1744864831; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rG3CCHNXzkVc+H0+6PfQ3HiqfTyNzLew5Fjjk46m/4o=;
        b=EkX5hOhlLGIODHxEPIUL5xlxnVzDher1kXi333crloEF1s+8//P3ZLRWmjKP7Kx0u4
         wbLe6zwkFWngTIkobX6Kr/wkx592j5lJWjoyH5JcBHN3dN+QlV3VuPzvtZEY/qV7dPGB
         pB6cUcYFYjQxXQ3OzLvIuOMrPZCeOJtDUQkgAw3TTqF02DT9cP9mOtYZFhJsV2g/U+9J
         1HLnC2J4X8YNIa3OS8uQL5AxEEd2niLeVLo2qbLxYt8readWsoqwFZtquxYnnrwSVPat
         CmLiNPbfiRkHUpqeuEidKGJkQPft5QfHpI4x2YUJPVlTVOLmo2SLunSFVxKsXxQYae90
         9vsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744260031; x=1744864831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rG3CCHNXzkVc+H0+6PfQ3HiqfTyNzLew5Fjjk46m/4o=;
        b=KX+yUIMeiRUq/zVVI6OoO5pPl8A9dl1ZWKLqQiaeeLBmlYOsT2aEUBXnin3APYMW6s
         8Tx5s12U+cXWBUMkoGxS637lOBe3ZPx4Ux+Vodh1vquVRSmdY2R8Q9SzVV7CFPXUNLTU
         I1Ri1gIxSWDpK5mozqNJdTYoh563dW1zEP1XLUE5g54yGBMusz+p95WXZtSABbu2pTF/
         RRyocrhMNiwGuWs6uqTqtA43sCcGP8/sZEa8k8OPMuTeA2YG2nKkZ0+E06moGZvtdSs9
         EQY5WlE/eCNG99IOZNeLVKOplxMaguO/XO4X2fZgDGQqY8g+LPdj0OjQsArG5xhFfHr9
         aUfA==
X-Forwarded-Encrypted: i=1; AJvYcCVuyo5hFTJJuCUESlndzDbDAaqJQeaqa/iTcjWDAz9lD7pgVZEoZOvkTjV4/PLmOTne+4jTnrJbSQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUjaEbUZN2nq+veiuicW//GmStlIxqpAWN8bf5ab13LWdqeKOd
	jaCfahT0c2YsB+hwH0olGYowwgc9duy/jiLkj6vNr8qHQQl9S7C8oZacKGl6WJI=
X-Gm-Gg: ASbGnctbgflTejATmgFEM6HiN0Y9hgrDh5l4nlEwNJMaDpP0Zv73cXjNyFDFZeBkKQ0
	n0vctNZ0mHYqrjt89uEZXZBiuE5OTsoIkBtNXFOAsNkHf8iHNmmRL7qDEBvVQuxwc2HRjzuMSXx
	hgmfzx2Go3uWKy5n1tL8dihBJoKg2FExSxy8dTFpMG6Oeea4P0ZlN7Y8mDHVq2ekNpBt4XYHR4g
	9qRUhI/pFujMMvWQfEToIuMj5UIXV7N8qHiQM2rV/mIcixtmyqm8W0plcP2RdoIUoG26iIS5DRW
	EZNFzXWzFC2H4Un4wR3/DTcE+ahyn2VTLTt4JpY+Pg==
X-Google-Smtp-Source: AGHT+IFgRbLrUZ9NDazqU3l/f+bQGBqmoIwoUvJFi0i9jATU+nvyQ6g9ESyfUs7smCpWRcGzZPw3Yg==
X-Received: by 2002:a05:6a00:178d:b0:736:a638:7f9e with SMTP id d2e1a72fcca58-73bbee5477cmr2498194b3a.8.1744260031291;
        Wed, 09 Apr 2025 21:40:31 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1e694efsm2272421b3a.164.2025.04.09.21.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 21:40:30 -0700 (PDT)
Date: Thu, 10 Apr 2025 10:10:28 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: sudeep.holla@arm.com, cristian.marussi@arm.com, rafael@kernel.org,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] cpufreq: scmi/scpi: Fix NULL pointer dereference
 in get_rate()
Message-ID: <20250410044028.ancslars65llmgck@vireshk-i7>
References: <20250408150354.104532-1-bsdhenrymartin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408150354.104532-1-bsdhenrymartin@gmail.com>

On 08-04-25, 23:03, Henry Martin wrote:
> This series fixes potential NULL pointer dereferences in scmi_cpufreq_get_rate()
> and scpi_cpufreq_get_rate() when cpufreq_cpu_get_raw() returns NULL.
> 
> Henry Martin (2):
>   cpufreq: scmi: Fix null-ptr-deref in scmi_cpufreq_get_rate()
>   cpufreq: scpi: Fix null-ptr-deref in scpi_cpufreq_get_rate()
> 
>  drivers/cpufreq/scmi-cpufreq.c | 10 ++++++++--
>  drivers/cpufreq/scpi-cpufreq.c | 13 ++++++++++---
>  2 files changed, 18 insertions(+), 5 deletions(-)

Applied. Thanks.

-- 
viresh

