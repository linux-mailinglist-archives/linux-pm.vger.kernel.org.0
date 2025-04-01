Return-Path: <linux-pm+bounces-24688-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B51A776CA
	for <lists+linux-pm@lfdr.de>; Tue,  1 Apr 2025 10:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51F4A3AA93E
	for <lists+linux-pm@lfdr.de>; Tue,  1 Apr 2025 08:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220C41EBFFC;
	Tue,  1 Apr 2025 08:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sLX4JV+5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AD01EB5FD
	for <linux-pm@vger.kernel.org>; Tue,  1 Apr 2025 08:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743497207; cv=none; b=LrDem6WV7+m3sKPD0XXevHmQeuztHjPnLYLCLSdeLDt+B3gQYY4HtcH24h5ttmo0SlLqAR8Rq/nNPhlkVYepobAxrTg245L8qivdCeR4YOSpLMBZeixbR1LjZsP/r7jHdJage0cJrxOdemu69r0T8xEOes+sBc6BTYvhuX3JoBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743497207; c=relaxed/simple;
	bh=5exalRKwxOCRfDiPsvj9Py5BGi7vRegOhGRQqcYzjN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=elJGxj/fn6Zs+8aGSLkrQLNjTNpwykPkb4Amin/9i2i7NUPfppayoWcTBWSBMc7fKwROLNX7LPZdhQ8l9M5Z8YZqngInnrPvEl3TZTvB21Z1uk6l5NI4b3SpyaSxJHOs2upgKvuKSXpBqx0jgImT2EKRCd74tHN3So446RvYTF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sLX4JV+5; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22928d629faso63597125ad.3
        for <linux-pm@vger.kernel.org>; Tue, 01 Apr 2025 01:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743497204; x=1744102004; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=86jslh1o/1gpjSTp9VBDwjU9RwO/decJQ7t8te/aUj4=;
        b=sLX4JV+56XfW3lmcELCsFLUXnJgDr6Lu9iOID7/gB0PVOaRCNNgRi7qXsNDj80m+oC
         v4vJcnNcM5CTm0v6uZzu3wT7o9VXWYSTmDtWgkifyx4TH4+1Hl/X0GsMOyf/TTvHHsZC
         vJn2qZL/eZgfjt9QsB7rPOaRrbnY/Ko+hIOswqtfuGLb76HaQG285bMzFc3jAZLPXiN9
         U4Ttl4iHQjGDFBMLnjPmNa2135mI9Jn0FW/TkkxC2JV6EaZw59Nmmqoh4nW6RfWTzDZ+
         N1yZ1jJHjIjwVqBCU711dEFoBP2xU/0+ntHZLlymskivuLpF6MBQxE8yIeZuDyQiNUEV
         g1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743497204; x=1744102004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=86jslh1o/1gpjSTp9VBDwjU9RwO/decJQ7t8te/aUj4=;
        b=ijh5jZXuZhoOYkP+d5jXU5J1j0M19vK8O74ySZ+TPSUzhhndm7TGTSXUS1HGaeJIIJ
         /TXN3WSCsGye4ywuN8Djbz4suyDRrTDw26uAfrelAxcY7unv53Tt5THGn+8lE9PfWWBs
         mXsO+Rs0MYrlI+cgpWR8+LMq08s/FufPP+f0DKxadQ5mqwWVNzdzhijbOqbqrZ7PUAu5
         1+aOoX1KhjRVtWZO3XCEwYYlWc+jxi+YY0v0D0MxSgJ3AVBJh7f7fNZ4A/gHgd8YeXI/
         TOF1mIIF31X3HV3KysyU7cRBdXhgOPWX7JaBClbbuWkuVeaLav7DgRdbrz7yNWHxBnor
         vNDQ==
X-Gm-Message-State: AOJu0YxsMJRIWYh4xR7IRFJA3+0sja5En4u0v+b8FwWPQknZ+gifbTB6
	OaORkXjHNTbjsJvG10gdpXDhF04zKwaW0NrimHo82ve0R64h8nJzGIV+3mE14fY=
X-Gm-Gg: ASbGnctbHNVFn80g4NivoXxoAbQg/aw1DrE1lUVUFnHF53yNpfNd3lb/WNXi3YHNho7
	QThQoFxe5m4Y3x0SfEXWH8bLnUW3d4S4Fa+FFv7ucR7Pud7sMQGfXDA+h0+UaBS2T7RZwEAoeR+
	u8dhyHBhf+tPbfCW37Xca7HSTwtyNBlcY56uTArZugHmLAQqixhf8VWFrbGUOgQpb9xYkhigdpV
	VYuq+PmZ47O74/PBCVxn9/1wYD9GFWbwDgQ4ND+PmjGRBGnQw3axwOnJGLm7RUBuHXEu6I+xwHD
	J3mQ+Pon4le7aTnbORwt5R9kxcjmlfhAfp7oKmF+xKma4A==
X-Google-Smtp-Source: AGHT+IFCpZR/bE/JG5DjOeXH0lmF0q3PgXI0eTKM+GEQW6T6GqSJsneEs5IpzvDV6w3X5HIQVbEBpA==
X-Received: by 2002:a05:6a00:4b05:b0:736:6151:c6ca with SMTP id d2e1a72fcca58-73980323564mr20129051b3a.4.1743497203779;
        Tue, 01 Apr 2025 01:46:43 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739710ace02sm8374083b3a.150.2025.04.01.01.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 01:46:43 -0700 (PDT)
Date: Tue, 1 Apr 2025 14:16:41 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v1 07/10] cpufreq: Drop cpufreq_cpu_acquire() and
 cpufreq_cpu_release()
Message-ID: <20250401084641.zeljsp4w5yxkdbna@vireshk-i7>
References: <4651448.LvFx2qVVIh@rjwysocki.net>
 <3880470.kQq0lBPeGt@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3880470.kQq0lBPeGt@rjwysocki.net>

On 28-03-25, 21:45, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Since cpufreq_cpu_acquire() and cpufreq_cpu_release() have no more
> users in the tree, remove them.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c |   45 ---------------------------------------------
>  include/linux/cpufreq.h   |    2 --
>  2 files changed, 47 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

