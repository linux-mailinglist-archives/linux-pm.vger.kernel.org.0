Return-Path: <linux-pm+bounces-14029-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9576A975529
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 16:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 414981F25338
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 14:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C51319E976;
	Wed, 11 Sep 2024 14:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iT/O2DJr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AE3199949;
	Wed, 11 Sep 2024 14:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726064524; cv=none; b=FzPqjBPP7TOcBSgqyOF2mE1915bZlRdqh0BpKqLoso5yC0t6EQhL/4ZDe55qn3Gj3qzgEOTOUAA5DH8wCs6rEpvL/bas4F7tfgjBOHakVqJ/7j8BEJsk8P1zU89vzPtlosCUzDqbljkeGZoWFmlG22W5iLKqbwINjnB2FZadb2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726064524; c=relaxed/simple;
	bh=o76AcHbXbRGzANSciTEuox4Bvd9TI1DHxqnZ0Ai44mQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X/jwImDS/67yCcjPrdlTrduBkRuudW6N+QIXaJqOULxWcE0WCdMsNQRlq9FX05/cmV1FpdYTwMat9UXU2joZhaSS8mjlnj9X30xnwmYS54ghX6NDyEeIP4tjWEdnpeCfaF3hq53SydW2Umjq4JHugYPhL73KvlVU404x61VkB6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iT/O2DJr; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71781f42f75so5457809b3a.1;
        Wed, 11 Sep 2024 07:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726064522; x=1726669322; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o76AcHbXbRGzANSciTEuox4Bvd9TI1DHxqnZ0Ai44mQ=;
        b=iT/O2DJroGGSiqGcijJmfe5FN9dD+RysqMd9BZUo4Y0kimWWmMud7rB64CT7QM7InM
         zXX4T6PLNnUyfSur0ErpVUacRdESS1/9GdIjb3KUi4A273QH4M52+HfOs3pREhLonHA5
         PxLpYbrBFp2S29pj/JgBipA3oOD118rzILQMfectXjRSYlGxnoYVLixYoabfozOb++E0
         fmH7uwoIQz2z1uHqLomFVlcEZ10qEM4HCh5fszoDDpluV9ossULxtANLW1Iy2UP5JfVb
         Qh0JHDJQCittbmtJyCFTvBacBp54IAFUG5Ti+4J8WvXKEG068AjJtEg0dv4+UmffV6Tk
         lCeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726064522; x=1726669322;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o76AcHbXbRGzANSciTEuox4Bvd9TI1DHxqnZ0Ai44mQ=;
        b=hASvZrOW95EQjazE2Il5dvpjzU/X3BOdb8yVj89SiTPfC0z8SnLbKCaFX4UAtJPlUD
         LUnHrFje53qncOHZ3Z/n6Wqp+sWtaPwITS/BLnbtxZ0h47YaHJPpR/RG1HMDka+ysOsZ
         82bBUMnWU78pk6zTWcDzTkZztzuOcCobwhC80ufWfSN5wfBnUpzXgN3uOH8gqsDemuRc
         sT6uzyOeR0v4MoeokGsHLrX1jh3iX6WE/KsOxz0fM81/DKYCSDG+7gChDxmzZuB9ayaZ
         65Dqvnqk6vbIotM4PPGxbnedzQfAj2CYWdC2s0/ZMmM5KmWPHtzKLPfIHCmipkI7E9f3
         Zz2w==
X-Forwarded-Encrypted: i=1; AJvYcCUA8MOQbDqx7NFCVFG3iiFyavoCbg5Go2InNwqow/Qe5tFmyEWP9hpuu3roiUJOMbg3iZS5WRDriZdu65GA@vger.kernel.org, AJvYcCUTZLXi0ar9gKWKj54Oiqngu12Dus5vW1/G/GjDISD63chA52gDrmsbjKdPdaVMIweNIJXRpa7kBYaDETuQ76g=@vger.kernel.org, AJvYcCVQkKxc0WgcQOGJ01+eucPwp0FSAlNGTjpJja3zx/rpX5mbk2zJtUTTeLyv1qL33IvSb/NxQuz7uey6Xg==@vger.kernel.org, AJvYcCVVZMV5zqhe5HDQILZuF3en3MG8PeI3Xr0ut0yvhT7kQ8UktQdnoeHUlnK5t0l8yeiRfCmuRQj2Ddw=@vger.kernel.org, AJvYcCXvxMLW66CCi0L6SZcYg3Qfi6up3atMv5bG4sSAYc/pgGZEOgsy7XL6q0+deqzCS/4JaJxkVhd7uaMk@vger.kernel.org
X-Gm-Message-State: AOJu0YxiGDcPNRU/OpDR55oSEDmVWS8oISSHi+Pw4iQ/VlqeefBk5/aL
	OvF4qN2m2yGIazX+CK997YIJkVMctOUHhbUR/hc2599vmzuapxKF
X-Google-Smtp-Source: AGHT+IGHiWzhUZMlISG1wfusUmj12FDfLvKIhsEju2A7EBEjueSKjiPNUyeW6qF3DD+xQn/SjKUC0A==
X-Received: by 2002:a05:6a00:94a7:b0:710:591e:b52f with SMTP id d2e1a72fcca58-718d5ded3a6mr21737936b3a.5.1726064522266;
        Wed, 11 Sep 2024 07:22:02 -0700 (PDT)
Received: from [192.168.0.122] ([59.188.211.160])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fba40f2sm31734a12.7.2024.09.11.07.21.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 07:22:01 -0700 (PDT)
Message-ID: <041215c1-ad90-4257-9852-57b1d7bd490c@gmail.com>
Date: Wed, 11 Sep 2024 22:21:56 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/22] Initial device trees for A7-A11 based Apple devices
To: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
 <linux@roeck-us.net>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Mark Kettenis <kettenis@openbsd.org>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-watchdog@vger.kernel.org
Cc: Konrad Dybcio <konradybcio@kernel.org>,
 Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
References: <20240911084353.28888-2-towinchenmi@gmail.com>
Content-Language: en-MW
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <20240911084353.28888-2-towinchenmi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

There is a recommended device tree node `chassis-type` to specify the
type of the chassis. For iPhones, iPod touches and iPads it is pretty
obvious that they are `handset` and `tablet`. However, nothing really
fits for Apple TV so a new chassis-type value may need to be added.

Nick Chan

