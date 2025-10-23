Return-Path: <linux-pm+bounces-36727-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 791A9C01ACC
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 16:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8ABF4562EC3
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 14:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0369032B995;
	Thu, 23 Oct 2025 14:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bKcnDu1U"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D810832861C
	for <linux-pm@vger.kernel.org>; Thu, 23 Oct 2025 14:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761228076; cv=none; b=kj4wAmQRvDDyaaSn7y4S0F66KrnEU/75JeBjHWv7nPcCpygFdd/auO1oo6OFsbcZaAFAJDJjcj3xS75/2SmEaNWYn+t7+zx9KxyhX2ZuiBFq1wleSK1Z/hCkC5CO1zR81Ev5sA3GL3BF/LGoqVhi1a6VvVr6yi3ARLXFJJSVf2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761228076; c=relaxed/simple;
	bh=JnMWVm8H5Ck5TN7RGfsn5EcNXl+YklqB9zPZXCC4wAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AsTGG2RSdvDQFn75DvQBG1GbBGkSzlFtTgpKi3/NvAaMHe+lnVnQlfP2ZHcuFA6ET9r4sI+LE/Gz0jmctkl2l08I6m53aHyqWDyodJrGyf6cf7NzBcZBIrtV5CBpEByKPPZqqoHfm4z1wQKqJHUd2ZdASq4p5fpbLioZy9C445E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bKcnDu1U; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47106fc51faso12435805e9.0
        for <linux-pm@vger.kernel.org>; Thu, 23 Oct 2025 07:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761228073; x=1761832873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JnMWVm8H5Ck5TN7RGfsn5EcNXl+YklqB9zPZXCC4wAA=;
        b=bKcnDu1Ugc8m1FO2mnc9vhsm9Gt701FFuUye9pb+IQLedRuOOPZ7GH9xP2YLtnqaWA
         3VWYZdNJluPWjsWKI7bj08iE3QMIoaJnU8TwJUYPVn/0XA0XkuqAHU5BXj7LoJjjzhI+
         Jt/w+MfFqdWkbmI0HsqDr4W7tk+853JoroELlD6yHZaI6anlSaR+rYrmNHOp1jmiaWFD
         bRyN7v/bJVXOET0nkcYsGPOCnkR+dK/eo37HgXt2JobJRvmuyK6SZzZEl2gA0M2s61AR
         mECOx3QCU9G2NjOSy3w79ydxc1TC77gKKwO4rdMFp48bKYCp+HPRYn1Q4LKcTYA2ZnkS
         9wDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761228073; x=1761832873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JnMWVm8H5Ck5TN7RGfsn5EcNXl+YklqB9zPZXCC4wAA=;
        b=cm0Q7fb1nm71Ya0kR+NMglUNqqv6WPaTA5hR6/ttfo+re/JSq6UIwAX505QTAAld07
         oicYn+vOpW4A0/Yc67VJrDWsJfeCR4L0TnWs/ikyaHFIOJoz6ztZ+xO4XxLbrKIvyqOd
         IxOrmNBJFtlel2oq22++lszfFeTfNDtYxnLRsLecbQv1hBRuH+bvApINBl0Kn3oRE6mF
         fo0uLbgEB3odmXj1pyZyaV5V/glf/Gur6fcM2ko4RPqNUM8jTzUTXB8myWROk5Dh6/BY
         yKhvM3Fad66Apr8/91lHgMMr9cKuRjlXf7XxMceo3eSDiTf/kRo2m7eKDf0qGrQcKAxd
         MPNw==
X-Forwarded-Encrypted: i=1; AJvYcCX8QdH+SSsO1eSQYPmQo5JBF+3QPmjesjyBX4XZK1nXtY+RUC4EqpfLF6rehkUSQmbClv99eYgQ/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzaYFdUkK2w3zz9xX3DjdrKx92E3iBI8C45QRRHpp5a7/HUZI+U
	BKLYCG0hdWvKRM3mKhc9olvbM9JaSj2nvMwFld29FIXZsuRGwbmOVMUlpo9QiY4N99E=
X-Gm-Gg: ASbGnctMiTVUqc2ZDTheB1oqj7vKX4M9xuUZF7Tfg3A0g7raY2tTG2SUXrnlbpI6ZzO
	KtmNvyfMMRjOsTpa+q9EsjmfaVOSLmv8ufpcjhbIMMl7iRALDT2/vmHIhqLhgQ73IMEph9/hToK
	goV6rT7VciDOcW8wgKAhESlq0Cjg1UMR689jYmWhUUorD1rDChqnvu9ODVF9PlbIMkQgUDW88qb
	oA1qU3Zc+WBJJHX45omKr0ODpDQJyI1GXGGuKFy/dPXEtbciWkfXr6mSeemz4hO2ndddqCeBQLu
	LG7YFlgc0nZNN8HtGwny9BSrWr1ezfkf8PUxMwz+RANoQG2HSv89o6eIreRe7qtk4v+arBMGybT
	bUi1HvP3269XfUWtJBXhFxle1aMZNaum81QEosDbiT7jh1XfEmRKr5o0RjwM+vjgIygobFgLbiW
	ZONyAwlw==
X-Google-Smtp-Source: AGHT+IEQurVzp77OCpHZFz2TRcOchNrP75ZwR0sZ9FlZgnu+xhnNBWaXzzz3i5vljtf/+Kejv/936A==
X-Received: by 2002:a05:600c:4688:b0:46f:b42e:ed87 with SMTP id 5b1f17b1804b1-47117925eb5mr165543035e9.40.1761228072957;
        Thu, 23 Oct 2025 07:01:12 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-475cae924a1sm49352875e9.2.2025.10.23.07.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 07:01:12 -0700 (PDT)
Date: Thu, 23 Oct 2025 17:01:09 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: ally heev <allyheev@gmail.com>
Cc: dan.j.williams@intel.com, Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>,
	Andy Whitcroft <apw@canonical.com>, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Hunter <david.hunter.linux@gmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-pm <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] checkpatch: add uninitialized pointer with __free
 attribute check
Message-ID: <aPo1JU7pe-vvQzEf@stanley.mountain>
References: <20251021-aheev-checkpatch-uninitialized-free-v1-1-18fb01bc6a7a@gmail.com>
 <68f7b830ec21a_10e910070@dwillia2-mobl4.notmuch>
 <f9cabfed7b165299b8048670e548c671f300f2b2.camel@gmail.com>
 <CAMB6jUG+ES6XY7NL5TF-hFVDmz6O5rd9T-HNk7Q+pJA2_9g4Mw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMB6jUG+ES6XY7NL5TF-hFVDmz6O5rd9T-HNk7Q+pJA2_9g4Mw@mail.gmail.com>

On Thu, Oct 23, 2025 at 04:38:43PM +0530, ally heev wrote:
> I will take this back. Found this in `include/linux/cleanup.h`
> ```
> * Given that the "__free(...) = NULL" pattern for variables defined at
> * the top of the function poses this potential interdependency problem
> * the recommendation is to always define and assign variables in one
> * statement and not group variable definitions at the top of the
> * function when __free() is used.
> ```

Ah, right.

regards,
dan carpenter


