Return-Path: <linux-pm+bounces-16639-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1313B9B4267
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 07:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B856C1F231F7
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 06:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B431E0B93;
	Tue, 29 Oct 2024 06:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zX5UrGRR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E4C1DD54E
	for <linux-pm@vger.kernel.org>; Tue, 29 Oct 2024 06:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730183424; cv=none; b=cYc70RDvGQJE9M5mvLFdgJfeQ3M0kFflWVhepFm9tfGrV2nOADYGlChTxfDgmvGY71wasYp7RlA44mP81NWxsTCI9I3w1yD9g9OKw+QnKvGr5UBOHGDNSZlsgRwyYYMX1FgOdRMG6dpP4gpQWxclQqtdABKqRmo6uW7QjAnedUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730183424; c=relaxed/simple;
	bh=Du71veUrxgOiVmEv1nD5pxPo8ygHHxZEw5FXplwz4R0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f6QuJXmeRdbp5P0v84tlOxcOmvZ0KLtV0dZfyi0Rwnbdbgpf87mORtVXTlg1DJz7A8r7mfKDOzfANZ+UXV7H0X7+uWSe3PWZGRndLUxXPbiw4SQLzjOLpBJIh4JoNGPwj0XgjU5EDch7Ydscvpe6pzQYgYt38dJAk+VrneM0jLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zX5UrGRR; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e56df894d4so4052334a91.3
        for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 23:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730183422; x=1730788222; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=plGGeRa87dy8Uzv4SLW4IpzuHAuOumcDdkr887+CHXY=;
        b=zX5UrGRRho167yhKmEH+2ns4CDt+6I0cJYlMFEJtS10cEVzAjDs8fhTYfZVEL1A9rT
         EyiWbEwX21BhKcz9zWRaVC/RW+hhhEj00JGjAOiDxzNBh6VefmW5bUeZw+NqhH74YMmq
         1bNK+tHsy3QqiCPn6mHywZEYAo50L1rJoYeUT6pXvzHf5ubKWAuVB96+CSRrc/cFKzQX
         d/ngs0iu6F67fe09QEWT6NIwDBremIiVY+oVfUvr73OutasBbFrqtfy01+6IwM49UOJ7
         r5XuOolbmQPxScJYf+VTmlS8fE13vy+KnhhOP+R5wNPmZ7Wc0iHPV4USX29KxGP7Op4c
         IzHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730183422; x=1730788222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=plGGeRa87dy8Uzv4SLW4IpzuHAuOumcDdkr887+CHXY=;
        b=DZl6BMouq4Nww931ZOPgGbZhDU0gbtOL+W1+tANgOUJu7jgvmF9XWoOn/Ed0BzDjT1
         epP4MvTHe+7DauVBhzakZ1Ykmid6HNQPCGC5mbzKvloij8q5XZhlltHHj4TqtCnAwYUy
         P8k8I0RSjFz1TX9RD4x3QZB3N+OnGbTrOdd6Olg3LwWooDvxg2ZC2F3MBiRXqC34jOq+
         Pmm+q/H2CsC7E1nSz0Fmzr4SiaKhmda44Ll7A0Zmwlpph/3A9ehYCZP91pGCdQOz03GM
         COtGPrzk4lpW89oFQUCQVHOh2VnkbipCKIKBxQ+Cx9aP+3Sr4oSmwu5Zn+RlMhPZDt8I
         +7uw==
X-Forwarded-Encrypted: i=1; AJvYcCWlqZzpKi0sGuZRE/WNnHU/shBpYGxfbXhK6gL1/HPXMuhAvb7qDGwzsIyxcxO2y6jpfZ6HdwT2UA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywokf4aYTaOfeXEG+ju2g0Im9jt8zMy/psIyqBDTMdYFmSg19SK
	yG2jsm/rjBeWq9/1UTWoWxJDzEvLIfjf8cdvCT5/edEPR6bJoWa8ylqq9EytHG0=
X-Google-Smtp-Source: AGHT+IG6D07O8QX3Gia7cLoA/VBJO5TyyJ1Z9ZnthsBJrTHkMfDbAg3VVhuvyAIp1++8uBrWJizw9w==
X-Received: by 2002:a17:90b:4c8d:b0:2e2:c40c:6e8a with SMTP id 98e67ed59e1d1-2e8f11abed7mr12293880a91.26.1730183422056;
        Mon, 28 Oct 2024 23:30:22 -0700 (PDT)
Received: from localhost ([122.172.85.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e8e3572efbsm8623748a91.22.2024.10.28.23.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 23:30:21 -0700 (PDT)
Date: Tue, 29 Oct 2024 12:00:19 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Colin King (gmail)" <colin.i.king@gmail.com>
Cc: Markus Mayer <mmayer@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-pm@vger.kernel.org
Subject: Re: cpufreq: brcmstb-avs-cpufreq: issue with error number check
 that's always true
Message-ID: <20241029063019.funs4mtwe4y6fru3@vireshk-i7>
References: <6f78a1ba-23a7-4676-b9be-06d632bbf3ea@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f78a1ba-23a7-4676-b9be-06d632bbf3ea@gmail.com>

On 21-10-24, 23:30, Colin King (gmail) wrote:
> This was introduced with commit:
> 
> commit 22a26cc6a51ef73dcfeb64c50513903f6b2d53d8
> Author: Florian Fainelli <f.fainelli@gmail.com>
> Date:   Wed May 22 11:45:46 2019 -0700
> 
>     cpufreq: brcmstb-avs-cpufreq: Fix initial command check
> 
>     There is a logical error in brcm_avs_is_firmware_loaded() whereby if the
>     firmware returns -EINVAL, we will be reporting this as an error. The
>     comment is correct, the code was not.
> 
> 
> ..the commit message seems to rely on the logic expressed in the comment,
> but I think the "or" used in the comment is not equivalent to the English
> grammatical use of "or". I suspect the commit is incorrect and needs
> reverting/fixing.

Yeah, perhaps the existing code was doing the right thing and this
patch was never required.

Can you send a revert for this since we haven't heard from Markus or
Florian.

-- 
viresh

