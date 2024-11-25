Return-Path: <linux-pm+bounces-18095-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F8B9D8B0D
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 18:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72C8E160EF1
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 17:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EEB1B6D0C;
	Mon, 25 Nov 2024 17:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1fjpsnk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3E7178378;
	Mon, 25 Nov 2024 17:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732554602; cv=none; b=gyYIZzd7ZTTHlBuFQwdrwy4unIMBR0FM1vBLMbQ5Afxq8Lu/bsAZz6dNzQ6M5xG+9gJklgNkUP71DZn9gbEnDM7XDtahfrmS5FcU0wIAyxAuBuiqFGjuuJ0uyM1hCkH2iiZIsF+Uh2gnQYoy2oGZCdxN2yJsUYOFU4pfx89E3Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732554602; c=relaxed/simple;
	bh=nlFbU7HRnNtmy64LQgVAl9mRG+bNolfIem6PDGHtylA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hrGpFnI3w/R9XVq9HH4nG57PVoyHk1kZLLXXurGXkAIe+yZ2DuiKu0DuUiCX8O/7S9jPfUFr4a/yuwqznekVaqSlXe54MXxDd2PO0LtDrvniaLHFO68FeE/D5RCUjbX5XYY/Od8U1hyTih1TgEbo8Pw68Hrn7NOB5fj/24ciaR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b1fjpsnk; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-724f41d550cso1286946b3a.2;
        Mon, 25 Nov 2024 09:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732554600; x=1733159400; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w3vdp3awGkdJWwVN21cFyGifTJo5FTt6OMTyRYMkxHw=;
        b=b1fjpsnkRbzeAWEkho1V2rrB89+tUYz0Y/Eszrr1u6+cumgH7udyw2JD7AicdEtDam
         qkA/tfh8iO7nqQ9U44cjdm6kwNsB5a8OjPZRmxnrWaFgfW1CwWsvkzkYoWW9HFKV/zmU
         66+mCNBietG69hsmP8qteToGWRYMC01VHeePOYEcAPvS1Kd5uFQOw95PZ3WOSE0UNUe9
         8QmkGdV0HHCH+p4+LEt8nthHAq1WZrqyKSMhhXyYy1zZeZkp4bC55npriuAVOPHObhh9
         ZfgDQUYIB+TxdOOWZCn/wlbVcm+HJnRnYspg4qX7+nnfVcTYvaSLbj8rMGir/B08LI89
         KQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732554600; x=1733159400;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w3vdp3awGkdJWwVN21cFyGifTJo5FTt6OMTyRYMkxHw=;
        b=WF5vThgMWfTPnfi73Q4a9ZslH8KVW6XCximA/ilJwwMsuh0q0JObhsSa9aAhPhxpOX
         whl5NUdbZUT1d/OIk03+b5xYvM6BGVtURmOfarkDIGMUSWIX7A2yUa55JD2CyRZqK5e/
         /pFMSpaq+XZyoPHaW+n3oziEX0nL7od4Y6WkFOj3dzsVfQ9BWg0bmzlAeAX7qGGtHHh1
         DnMjW9tPv/4sbZZ8jIf7C5xgbMS9U9noaiuc7T+K1uAIm4LiQiUV1FjP5z/aFK85DKsH
         In0BL88uDhX6OKond2CcmAmemAEekXjJxi2kzw1IFYBUC555lEx5KslRDjlMtJ2bvOKi
         LysA==
X-Forwarded-Encrypted: i=1; AJvYcCUobbrS4N5KQmAYEmfv8Brbc02VYGwIR0+as77oFEzxyFBnJsUKuhLbUvVJPkyGUmnhw2G/OG4Cvgk=@vger.kernel.org, AJvYcCUyA1JaT9lFW/Hozake06eu0pTZBUpyFQVxz+eeD+DSiSlvT/Oop+Blup8o3oUalK625gOgoR3dfIJbdA==@vger.kernel.org, AJvYcCV72Ow8ltnnqvWvzCFvQtAWlRKworyJgHyVhJ2fOY/xEt1LwCB/HvdubnpgdXoHCwm0u6seWRJTHdgWo+nl@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4ZSo1kgn3GrTHRAmIx9vti7mfaNtpdgiD5vkDKzD1LJVXCgQO
	hY2MVpe6Ph179mA6agZGrQkpJ31YMECbBiIbMYj15KiG9tutJOwY
X-Gm-Gg: ASbGncvkZOiA6n/iiqaZD7z+eB3ApdXRMsVn+OlifyxopVefkDcx3b66AmqpluDtA4g
	/ZV4idI0cuMwvYgUPc4cMiPDlntERwrixjIEOAvV4DgvIV3yAdTUcxlEnAK7ZKfDbRfLKIauXnE
	rQaMLuDF8CbitJNw9+jsX9riifyGPyMy25s835tcoAmlN4jz1p3y2ewxwBj5txsS/bCCwy1Tz6g
	7d5A9T8g5UxdGr1LbFlhwmXjIBdmGgRQQ3miW0ELvXF75+gOjkw3ayK4EyG1eo=
X-Google-Smtp-Source: AGHT+IG5zNKAsDTau9IlujMWfdzt38SGXzlCw5Z6FVVC+BkMmuV68VGaNohgx2hNsiS/ulDBN1Fv0g==
X-Received: by 2002:a17:903:18d:b0:212:3c3:7a61 with SMTP id d9443c01a7336-2129f28a2c1mr183431935ad.44.1732554600090;
        Mon, 25 Nov 2024 09:10:00 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dba2ff1sm67481145ad.76.2024.11.25.09.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 09:09:59 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 25 Nov 2024 09:09:58 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Jean Delvare <jdelvare@suse.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 2/2] hwmon: (core) Avoid ifdef CONFIG_THERMAL in C
 source file
Message-ID: <8d922f80-5641-41f2-8062-4c82280f8830@roeck-us.net>
References: <20241118-hwmon-thermal-v3-0-9c17973e7342@weissschuh.net>
 <20241118-hwmon-thermal-v3-2-9c17973e7342@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241118-hwmon-thermal-v3-2-9c17973e7342@weissschuh.net>

On Mon, Nov 18, 2024 at 07:15:59AM +0100, Thomas Weiﬂschuh wrote:
> Using an #ifdef in a C source files to have different definitions
> of the same symbol makes the code harder to read and understand.
> Furthermore it makes it harder to test compilation of the different
> branches.
> 
> Replace the ifdeffery with IS_ENABLED() which is just a normal
> conditional.
> The resulting binary is still the same as before as the compiler
> optimizes away all the unused code and definitions.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Applied.

Thanks,
Guenter

