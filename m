Return-Path: <linux-pm+bounces-34126-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63026B4848C
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 08:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EF64175DD6
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 06:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FD12E283B;
	Mon,  8 Sep 2025 06:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S+QNeCkJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AE822333B
	for <linux-pm@vger.kernel.org>; Mon,  8 Sep 2025 06:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757314556; cv=none; b=LWAcowyWUtdvfO7j0r7vFcP77bZ9IluL308CTgQwSVn/Vv48jSvJwtHJ0U0qGxxn/eYWWdRdozs4nBrdN1N3W868pFs672xL5woAs9IpvWSOUlTvsZmDl6mzdqN2MhxC0CC7AI8nY5Tzy2Po2070YUn3HmrmEpK+M1q3IQz/mfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757314556; c=relaxed/simple;
	bh=CpGKAIjx9opYm+HfzeDAQ0MJW1WE+sPDSShf9nh5CuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=syUc6a/DqLuzm/Ri0ptJPF1uzws7OS+Hh4Bvb9H5/Gp+CUwA3AE+3gjvshyY3QyxSyHXdGol7gj5McvdiL21hP74d52svnLcLJ4hU2DTwCM+v3lEB/gESDe1M1eKFZW6DqfQpMhqCBxt/D6ZOwCNMJxyBn1BnITG2KJLap+WEeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S+QNeCkJ; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-77256e75eacso3546640b3a.0
        for <linux-pm@vger.kernel.org>; Sun, 07 Sep 2025 23:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757314554; x=1757919354; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qjDemfu2IvLbw+qXa34kZRvjbWxOCBrNvY9zl55RAps=;
        b=S+QNeCkJo5vY6/myyb7Q/teXNz6Er8X+ArNhFihobADj5DF7hO2I1+SGcptkb3NkI8
         Kodq9ENIZSOX8UJ/2EYtW4LNlMT700Q79IpRI5Zr/gt34VCodxvOFZnW1Xn2BgqtxkYb
         tn0oObkMX9XNcosl1PXfGzTRFmMDURbOZY687YrVFxg04eIUi4kHRI23I1KCTslL/WCR
         ZeISeY8zoxnaCzlrfBb6xCYQSxtdzMCMKVFTolDzhloziHJ49Mk47SopbLVDL92pnCxa
         I+OCZ8lCOk+nDLhzlat7ETyl7h6KZVT0qkkHm5jxzfRxIuo+j6q8H2NkV238+tnWEmd4
         CTlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757314554; x=1757919354;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qjDemfu2IvLbw+qXa34kZRvjbWxOCBrNvY9zl55RAps=;
        b=dT80NQTaQrPkWrBJdA1xlqdQNDNJj0i8EHu6RSkVZzr+dqJAYIdT+QPq5UB78dX9Qs
         9hJLJs9hG4RbowpSn46dlU+MgxeS+7onngPGrqBPbWNOg50+VBul/nJ9gO7/FMrlDM+7
         CsGDSrHFDjPWkIlIcKiUaMBcJWGxEEh/lAd9jAnaZrx8qGG3RiyGFmMZQlIbkIPcoO48
         1rdw58g+FwaBLge7S4fjfsbviHLCbHucIK2CS1LKOoC2gGjQSPUJtNLXWXhoeWUftBmc
         v/rfxiOe6O2vE50MbI6Ao0eonobVO5zEDnCXZhh7cT8Pa7v6rkdmSsr37rCgxB2e6lig
         42uw==
X-Forwarded-Encrypted: i=1; AJvYcCVZjv2OtnLV7ZxI+yD8eYIGM6z53Xi50tnJv3tqBE9Bk0dtQq9tvIaNFd9pYah+Vwnblw0bfxtPcQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzU16IRU+nkOi2J+pPpuqPDUA5GMS/wHTO9TzoPA/ql5CPgYMRZ
	CDSuJ/3lEAPYKmMrHne8k9g7VYlQ5ODjUnOUv7x8QvVjY4BIuDdzW4wkxnmxrrZPAfU=
X-Gm-Gg: ASbGncuVtcaj1ESQ21yYLNs0ztr4OEICm8eL8QsjzkySV9CIW+aeXLvxPtpBNqecqpB
	qF+QCDKiIlvmCeew73p0jy1iyuR26DEzWQVlWOfUXFXed3XFzqxuZvJM+y4LOjJUg+q/+Zdp6DA
	XlX/ZY7DFzVdeP0n7LkCAiyHWkJJEwnDOeCyYNFES55RVei4Wzt8CLmaozwpwJpQWSmihvwpX1c
	KPd8ZlrOL8z9pEnAY7tGEmoQCxGhm8Dm2vlhgVCZpg5pl5LF5Fihszwg58liZaWeEQaR73/mIRZ
	+D9RbY3KP74Ja7B9sU+euVoP9yNVXHMYtQS+uBL6IU7WoksxNKmJjsEq7zoyk3dFJ1aTCsXpmDf
	P9+6GYFutFVCDi0YSeGTgk6fqqHWH99OEW2Zyc9m5lDN6yQ==
X-Google-Smtp-Source: AGHT+IFUii7IFPGF/GfdssWSzTteSva2Jd9iVfJQLLidaUj532ste3VwU6C9KZtFqK7PJto/9xnrdw==
X-Received: by 2002:a05:6a00:1823:b0:772:1fa1:be4a with SMTP id d2e1a72fcca58-7742de60f4amr7353357b3a.16.1757314554209;
        Sun, 07 Sep 2025 23:55:54 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2d97acsm28535953b3a.41.2025.09.07.23.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 23:55:53 -0700 (PDT)
Date: Mon, 8 Sep 2025 12:25:51 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "Rafael J . wysocki" <rafael@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	zhenglifeng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] cpufreq: Always enforce policy limits even
 without frequency table
Message-ID: <20250908065551.d5jhp5ejix4fzgd2@vireshk-i7>
References: <20250904032210.92978-1-zhangzihuan@kylinos.cn>
 <20250904032210.92978-3-zhangzihuan@kylinos.cn>
 <20250904044812.cpadajrtz3mrz2ke@vireshk-i7>
 <540469c3-9bc5-444e-87da-95dc27fc481b@kylinos.cn>
 <20250904053700.abdkh23zwi5x65do@vireshk-i7>
 <e91bd1e9-8db4-4923-92fe-52893623487e@kylinos.cn>
 <20250908061333.rwzq5dj4nxlav6x5@vireshk-i7>
 <cbe36377-6f92-4913-8cd7-087e718af368@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbe36377-6f92-4913-8cd7-087e718af368@kylinos.cn>

On 08-09-25, 14:51, Zihuan Zhang wrote:
> We are currently considering moving the check that ensures a driver
> providing a freq_table also implements target_index() into the driver
> registration path.

That won't work AFAIU. The freq table is initialized during
policy->init and that's not done at the time of registration.

> This way, freq_table.c no longer needs to defensively check for NULL
> pointers.
> 
> Additionally, we are thinking about merging the two related APIs into a
> single one. Do you think this is a good idea?

Which ones ? target/target_index ? I am not sure if that can be done.

We are fine with improvements generally, but please make sure whatever
you send doesn't break existing users. That will help saving some of
our review time.

-- 
viresh

