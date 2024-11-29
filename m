Return-Path: <linux-pm+bounces-18229-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8539DC195
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 10:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E79F128197D
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 09:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7085F176228;
	Fri, 29 Nov 2024 09:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vauBDyc/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AA838DD1
	for <linux-pm@vger.kernel.org>; Fri, 29 Nov 2024 09:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732873200; cv=none; b=MTLRks44J07Lk5o2v7yHh3hMpkMDL6ct4Fp+lhjD782/mqopTaDYNyO8k23keNSbHQxEmLsi0Af1zeRIZWmOyUgKx3ju3/Yi1xuaQVSpqSh/+0K1EDqcBrRnDBAr9JJT5JTUxbJbVTeeQNyS35fByKpmZxpIuOJPVjJYxRqgJe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732873200; c=relaxed/simple;
	bh=IzCqwsyp/ckKsqEM+TTTsqQsbXr6WOSqpOQRN4y+3Nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FO8MgJWylia/9yHl1ZxLfp3V82NxShY6D2gBnEwmXTW4mJptx9WlD31zch2+P985oiDUSvEUIMAk+5YLKyWC3r812AEwV2G8Z48wsvqveH438hCr3KN3udEnVsK9/LhK4eW/UaHVWOJmvYWM6p7gPa7EzS/wpBQM0teq2LRNjWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vauBDyc/; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21278f3d547so12116245ad.1
        for <linux-pm@vger.kernel.org>; Fri, 29 Nov 2024 01:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732873198; x=1733477998; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MOusRXoS6yLwNo2tY8vJRcYfq8J1TfQ3gXvaPL+GXYc=;
        b=vauBDyc/EOQex6S7oKFD/jyoI98xCukECmJhm5YnjBC2Fgh2/z5lCezYTAC751oCzr
         dEW6UrTmeCOFX8fguqMiv67/nlwcn5/gPIj67APQofF4WS7em1oC1o3S+FDIT7iqq3cO
         V2TVyfpvAJbmsfBctcv1gQPP9vRNh+pKA+JfeDhj/zFQ0B8nnTUWgnh2euW7//DP4QxL
         va4L24y36COKtMlR4yABIZsm1foWTjVJP/V70UOAbwQJ7iUX4yKth3yYNFqRbuzuQDEC
         ymM4gVNmAY69PJHWAnUMOrIGohgDORxN1pI2UwI+u/0apPIu/E8LOanO2XjQ/0dr+EkM
         CNLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732873198; x=1733477998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MOusRXoS6yLwNo2tY8vJRcYfq8J1TfQ3gXvaPL+GXYc=;
        b=UmB49fOKkWbqwzMCF8xv8PHszoQ61AseOzDnCcE6wixcSoH4wWMvWNIG+vRqa7Vpsm
         0JjaHyIX7lXTvMlLQqDLLEVhcG8xogFmPobFAXtmUiH5aCksD9p6q3cGGJJzUZyMgjbh
         8JTuu2KTDn5spE9ImyTqlTO5F3w/hj68pvYuJ4lVFL56u7+uvp2rnEpk4kLOtVBlGZUp
         mPMCJbWSZbCvA3E4w5hUiMkGZQfuDOSwHRg0igXqKvN+4KUJU07M5o9pvsrHLksIvnlL
         AnmPcY4sWJ2hDcB0zPw4UFT/fzkvBfMYR9oOQGnBK1FS3MGsW0vcHaXc6UYlg9Uk2cuB
         +1uQ==
X-Forwarded-Encrypted: i=1; AJvYcCVF7lLTIO1RgECwIEvhTW8JXuGi9outshY8n3opnR0HDXOP9HaDFmU8GsbrwSp8c7Jr7yHLr9LjnA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0C3cqf0dr/y6U6IJTb4O8uEEkEum1EEPBhbObIxa3+AoVqoq+
	1HlYeaku/klZOoWn/YVx/zX3oNulRNKjwFENft8Rbror5l/ajPakyXdxmMQUheE=
X-Gm-Gg: ASbGncu36/cdTWsCyMVqzVVq/aRkd+14NIzA6t949d+gUZp4V6oqe6rjnqtYLSPH2Mf
	3en867RfobdmYanp+qJ5Kbgyabxv0KjLprc6ADT5Ft4rrRR3i2XcuYjYIsPO23XjVqPsbrl0JkR
	eay/6TxnNpYbfx6/8eFbzAs8TdzAlBi7CG7oCgY0Bp3dXFzsWYjaz9eMUEGlUV2zplImjpnduG3
	iyp32ZRho2hlWfGXwA+ATDHXTaT7jpTeFgD7VetUiDgKEYtubu1
X-Google-Smtp-Source: AGHT+IHWodno/X6VRTJzhKdXVQ/gso6/rtS4xy33n61Y9sx/WwKW3iY78OTpvtXf0n7sw/wkaVMi3Q==
X-Received: by 2002:a17:902:ebce:b0:212:13e5:3ba4 with SMTP id d9443c01a7336-2150109b05amr120185115ad.21.1732873198197;
        Fri, 29 Nov 2024 01:39:58 -0800 (PST)
Received: from localhost ([122.172.86.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2152196845dsm26185725ad.121.2024.11.29.01.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 01:39:57 -0800 (PST)
Date: Fri, 29 Nov 2024 15:09:55 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] OPP: fix dev_pm_opp_find_bw_*() when bandwidth table
 not initialized
Message-ID: <20241129093955.c7wm3oabtiyjuaze@vireshk-i7>
References: <20241128-topic-opp-fix-assert-index-check-v1-0-cb8bd4c0370e@linaro.org>
 <20241128-topic-opp-fix-assert-index-check-v1-2-cb8bd4c0370e@linaro.org>
 <20241129084111.ifwak4y4irxjnpru@vireshk-i7>
 <46cb2f2a-908a-4600-8716-db7f937ec13c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46cb2f2a-908a-4600-8716-db7f937ec13c@linaro.org>

On 29-11-24, 10:34, Neil Armstrong wrote:
> Wait, this needs the first patch to work, otherwise index is not passed to assert

Oops. My bad.

-- 
viresh

