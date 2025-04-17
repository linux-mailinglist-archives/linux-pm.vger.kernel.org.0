Return-Path: <linux-pm+bounces-25595-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 230D5A91286
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 07:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1F8B171BA8
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 05:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9C41B4259;
	Thu, 17 Apr 2025 05:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IYT3clgR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF59479C4
	for <linux-pm@vger.kernel.org>; Thu, 17 Apr 2025 05:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744866556; cv=none; b=t6VlYjY1Wu0oiew/hj1uQTeE4x0dEaqzx566yjpDiu1SdPnKABtxC7wBCcwH8te28iRAMZwmyzteAZ0HkkPuJ3Q5iZjGxFAIZCEnICoRSYY7rpYvlum1DMyynOopsvmxEq4QXyg8k1MYoSoTwyXADSJJ4kJCwnbuQ7sdtAxtuZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744866556; c=relaxed/simple;
	bh=5w4FOljkzJbGGIXWHxTmPupRaWvAl7cIsRzK2TOG83g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oylRzRhFx4I5UtwZ1bfCch7XLcp5cXWBjZEQZi3DwPL4/wBzZMTOekHrbFBwlLDvT46l9zyUlVg9iQJ8ROYSkA/5BBXcOABc7e1hfNffhc/ht+sJP54PtWVUNvRd6QA7XKTrntjE5cu8JfQy4v1m1Hrsl8eBvLaXFYOjxDzt5+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IYT3clgR; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2279915e06eso4317335ad.1
        for <linux-pm@vger.kernel.org>; Wed, 16 Apr 2025 22:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744866554; x=1745471354; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kvmisUd6UaTKf/W6iowSm0gUPOkMDXnF7C2h8jm0b2g=;
        b=IYT3clgRZsawKluTsvmI6Iq4FMzVrkOIB1CBTU3Ec834M0/t5w3NLHJUz5lfH5wnSK
         asQrvY6nVYyazaSFD4HaP76Ey2fkjiD7eEB7t4mduU5HDTWRDZdPo830sAvYZlXyppZC
         dqimxp9Hck/x94BkbLHvrd/qBt5IAIrjtT4GCu0gepMEZfFUz4wz5KFVGEEWBtMOewU4
         NK0MT0QRUBWzU5yfDCicpjO9fS6gfrXug3whAm5jjPBZR9LAztWlou4FpUlIJZO0G6Y4
         rPrCL79yijjvP8Lx1Ec+ugnaL9uEBnD++bx0uL+o8/YBbtU2fO/05j4Ynf4Ky5+PXs/0
         cpQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744866554; x=1745471354;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kvmisUd6UaTKf/W6iowSm0gUPOkMDXnF7C2h8jm0b2g=;
        b=O+P5hZDtMdr7ZgA8rj+l4e/bNkyntP8Qo7yEqyT4YSGYsC3r95PEqBBaoii4aSTkbX
         0xwUSKuGj4p1eISqVHf7Bm/Q+hPZu5d9OMk5HiwUcQFLv08jwTae4C2ZLcQZYp/FejDX
         uj49j2Ma/4ciLLG+gpDRWklT822xc2IF086E159e6P+WqWFJHUL3ZZ9uEXYaSb0oMRnr
         QOkaVotNMGbCmaDGYdMGtgfwL0xmZcPHKSqSSyMMDNXg+z7Dmt9DGhoKBzxjjwxy4sfT
         KbVvqGyZ8gdfG7XZ5b+to/T+S8b88VthZmIB75OnDjwIoWsGmrqYDhuuxwrLqNgvPQqa
         M5eQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFk3scNVZj5H0HE4fstejimvc6RGYkfEK91BKK/l7qJGQGUjXr1DH/IMiYSR0O2SVEDbuHdfyU0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzzvUGbDjsHb2oqydqqpS6PSwXuN/imluLReEIrPR6SEoEQlHsM
	+7WY7UsSZMczyZdgzR9TN+6n3PK7DxIv1oz2Jt4SU7LgpvfRJQ/QLeyAq1UpAqHEjjMhvYRg33F
	H
X-Gm-Gg: ASbGncspPJwVuCLhCMSpqTDgZH8NI76kl4WKqBqcd6xa4bPYjODQOpzXL7YO40c1QoY
	gUuVqlrBrqwQERoSnRde8RXSrEqlC1rMRRMRzO8CSdJXU51ty/Blkm7VnASbAebyp4Rxe1Sr01y
	2Giwuwu5qxG6mExt7ShMtZgpMZHXmw6R2jyk/4Hp3GL3FQ89iNKkhkK1m2535NLXs6Qt9poSK1x
	Lzv/Y0c6zvTfpHBiBzVvRdk1Fgwf8VGBMJqv3S0i5ZSD1pgkRBKCa00P3bB309chbSGU4PTq5UU
	x/SOBWiZDP8yI+05eFnN9UkqXUmRomO4yrGqcvMEgA==
X-Google-Smtp-Source: AGHT+IGMA5MKbOii+J+XmRiRHvR+u7zUVn/vas+G2cyV8a5scK4dReH5B1deiIw76a5aPJ0OUXCMww==
X-Received: by 2002:a17:903:2344:b0:224:76f:9e59 with SMTP id d9443c01a7336-22c358c42c3mr73689985ad.10.1744866554088;
        Wed, 16 Apr 2025 22:09:14 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33ef10c3sm24138845ad.30.2025.04.16.22.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 22:09:13 -0700 (PDT)
Date: Thu, 17 Apr 2025 10:39:11 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Nicholas Chin <nic.c3.14@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com, rafael@kernel.org,
	vincent.guittot@linaro.org, zhenglifeng1@huawei.com
Subject: Re: [PATCH] cpufreq: acpi: Don't enable boost on policy exit
Message-ID: <20250417050911.xycjkalehqsg3i6x@vireshk-i7>
References: <2c788c2ca0cab09a8ef4e384f272af928a880b0e.1744781329.git.viresh.kumar@linaro.org>
 <20250417015424.36487-1-nic.c3.14@gmail.com>
 <20250417050226.c6kdp2s5du3y3a3j@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417050226.c6kdp2s5du3y3a3j@vireshk-i7>

Copying more information from Bugzilla here (Nicholas, it would be
faster if you can put all your observations here first, more people
are looking at emails than bugzilla).

> Nicholas Chin wrote:
> I did some more testing and debugging and it seems like when
> cpufreq_online() runs after waking the system, policy->boost_enabled
> and cpufreq_boost_enabled() are both 0, so the set_boost() at the end
> of that function is never run.

Right, this is what I wanted to do with the $Subject patch. Don't
update boost anymore in suspend/resume

> cpufreq_boost_enabled() being 0 indicates that the MSR has boosting
> disabled, but when I read out that MSR using rdmsr the bit seems to
> indicate that it is actually enabled (I am aware of the inverted logic
> of that bit). set_boost() seems to be the only place in the kernel
> that causes that MSR to be modified, and I didn't see any extra calls
> to it in my debug logs, so it seems like something else (outside the
> kernel?) is setting that MSR.

And this is what I feel too, something else in kernel or outside of it
is doing something tricky.

-- 
viresh

