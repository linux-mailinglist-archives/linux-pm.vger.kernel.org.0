Return-Path: <linux-pm+bounces-34124-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C640EB48465
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 08:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B140E189F933
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 06:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FD72853EF;
	Mon,  8 Sep 2025 06:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HaMv7fDV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7532E1744
	for <linux-pm@vger.kernel.org>; Mon,  8 Sep 2025 06:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757314015; cv=none; b=nZBRQpUU7sZW3IJULuOy/zaQTl3OmkkqwiyVvVKeibvbSlTsOLuoEYffkhDDATVkG7v/jcKQmcFkv/G5RJ7ELqwO/cWxeXW9X01pSYIOhjkM/2wS5uKqgNx6VGmoM0nvveLH24lViOZDq+vq4bte/dWs/pQjOpbFgb+lEjUtIyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757314015; c=relaxed/simple;
	bh=CP+/lHUyOhzacsa5A544WPCWdSbkurijzlD2Tul0wzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ir/WMwWoYBLViAG9BvqoqwW2ptC0zqTMSpJFV+gdk/s/xJ0Ll4Ko36mMccPfzL0/XQ08iA7ierL+qX4sXOxzLWIdqmC2KJr4mcDBdQMKeFikU/r0l0MtLs8tySOx5xeIQdM3hEL/o8DkW5Mx6GXKig+kLlXI6/4vuvApLrDu658=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HaMv7fDV; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b49c1c130c9so2750908a12.0
        for <linux-pm@vger.kernel.org>; Sun, 07 Sep 2025 23:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757314013; x=1757918813; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tqKjKM+4UJsj2XqpsktSnw3L/nKXUi786mbz4PmkzFc=;
        b=HaMv7fDVXzAsPqtH1IlvApBSLvQvGOfTGyLLHAWHO2s9fXb6Iv2ipnbb9RogfIJ3yT
         bfw0gmriXPv2HefsdvhdEriZC8ZvrmPfD+j9Eg8TSd/rFTu/xL3A3OTbB4CGWqCL9NfZ
         LDQwE9fG39WVjXy8MdFmc8mi/E1pZDxHC4R5gGfeC7SwMhmOcunOJjFztS8BQZLuE+HC
         eVjMaAH6WY3JF0b2az9pkC+uJQI+pzUx4hTFPDpEZY098BpIhChS9V50FW14uQidOgL3
         0l98PNypmnVy/U7NO3ZpjVhoMkY77R/F+qhi/pp8GVYTMuE8D8a9gGeUIb0XZr2FiBIp
         i19w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757314013; x=1757918813;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tqKjKM+4UJsj2XqpsktSnw3L/nKXUi786mbz4PmkzFc=;
        b=qs257Nl7EYlyGACK7+f90lbqXan8QAxdO9SEo2KXn3R63Cs+dZfdd+BcyEcprusZu5
         vhLEo4qkKnfLo1+8EpZmh2Vbr4LqvBN/RFS54Gf42KH9qsaYXwjptRnjhqYvB1svmQUo
         gi2XurDfNgG8DQv/lZlCBC/favp+l9FNLrF7gNsVILN+U8SSuKs2OrS8QgeR5G3wirFW
         i2Wgrof0hUCaVm+JUfI3Uy8Z4Kq8c2UvdOwKAO8JN/mmFq9nGAShrxPAsZoSmiTMGbNz
         514Z37EhKch/4unqGp4eqNqxzmMVOvQS1KVc3aIqfmNO3KiPaqTP4NZJM4rz8WazRn6e
         XkLA==
X-Forwarded-Encrypted: i=1; AJvYcCWY4tl61/W0i2sJrsQee3qvY4FOa71dpbmNL8IE3yIleKWapO85xqvW9oObRi6Q1vnlcFygRyTuSA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm/6Am77NFRwLQrnHy2rAz5R/6OaRmBtFGyhlJpyowoDyjahlY
	pe5Gl/lzn23wfTYv+Z/a96fbAI0QmW4BQUyAwkizIlAs4rVxF55S0SZFLunAI+40zDuxjeoaNEX
	QkD9j
X-Gm-Gg: ASbGncvXxHTYBFiVV1F4jKfMdJtvnRlbLJLpCE854UKFnlWyqEX5hC35IXE9fsdyTn1
	BTQPwGunp5Vh5ZFouqT2mnmLYDm8YAXZ+58EgeqUj8X4U+bN6eNLKVXf5gYi2fei5ZZ63ODQcYk
	J6g4+7Px0LcgKOgq7FvwQO7IODhWQLG/fXxpL0/QK3yUKi982Djdr+AOOBMQg5oP0gsSP4wcngR
	PHvMwVSzqPcFezqiIJ0E098Jifcte02RlvoFgmj0qnFVLcgCRYpcB2hZ1xmIfReX2rMN5Nn1Yf0
	XoV0RYHkPVOBFRaadT0D4fN+xysdhigdO2T7SqieePhiFjAg6lQeQm2kvI/pWlqaXuU7ZPCa4O1
	r0AqLu90UCtuiKGYPZBJvdTaz
X-Google-Smtp-Source: AGHT+IGnLi/7AQXGknu49zTuLAwa3+GWl9/KYrdHWk9gv2snN+aXOGF0bL7+PQn094hEzNARFFZkBg==
X-Received: by 2002:a17:90b:2790:b0:32b:95b9:3eb0 with SMTP id 98e67ed59e1d1-32d43dfeba4mr10034880a91.0.1757314012692;
        Sun, 07 Sep 2025 23:46:52 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd28ae414sm25109366a12.33.2025.09.07.23.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 23:46:52 -0700 (PDT)
Date: Mon, 8 Sep 2025 12:16:49 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "Rafael J . wysocki" <rafael@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	zhenglifeng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] cpufreq: Make cpufreq_frequency_table_verify()
 internal
Message-ID: <20250908064649.5kk44m5ihdspyair@vireshk-i7>
References: <20250904032210.92978-1-zhangzihuan@kylinos.cn>
 <20250904032210.92978-4-zhangzihuan@kylinos.cn>
 <20250904044557.tde36hekoeuhnsci@vireshk-i7>
 <cec3bcea-4c75-4869-b9b8-efd3412a1e17@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cec3bcea-4c75-4869-b9b8-efd3412a1e17@kylinos.cn>

On 04-09-25, 13:34, Zihuan Zhang wrote:
> Thanks for pointing this out, Viresh.
> 
> You are correct — with the current changes, if
> cpufreq_generic_frequency_table_verify() fails, we no longer return
> an error in these drivers. For drivers that lack a frequency table,
> they can still operate, which is why I wasn’t sure whether returning
> an error is strictly necessary.
> 
> I would appreciate your advice here: should we preserve the old
> behavior and return an error on failure, or is it acceptable for
> drivers without a table to continue without it?

I looked at the code again, and it feels like the current code is
doing the right thing right now and making the suggested changes will
only make it less readable. The two function have different purpose
and it looks better if the callers call them explicitly.

So, I would suggest dropping patches 2 and 3.

-- 
viresh

