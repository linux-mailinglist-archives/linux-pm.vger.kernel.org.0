Return-Path: <linux-pm+bounces-40898-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6C6D225CA
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 05:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D31C301B2FA
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 04:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376422C027B;
	Thu, 15 Jan 2026 04:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JBFqk+vB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946182BE05F
	for <linux-pm@vger.kernel.org>; Thu, 15 Jan 2026 04:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768450380; cv=none; b=J3J0VfNh6OiDAJAvilwad02x5JZgURUPtvCB+fhpiWXIfzWzL45Jo8JdXZ3IJTRsQiq14PvJEMFv/7FY4310jKCadQE9WwiDgE1y80j6xCMbFc2zyCADiauuo4ZvOjfi80IdSHr/lRdepxMLDiO+oHHrPisidOw9ZWrXzFGn4TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768450380; c=relaxed/simple;
	bh=OicEOFECTwzUbejfKgH7ecJn1P3Je+2L1KYHGrJqAJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gfYMq06P4jxToVmrQxAWG0TX+deEB9bqlIl/k1K/sGmdmes6AgDNPCD2MBzIDLP95tt4/uLvTbaqiyHfmi1qMz0hGRe02zKhmjS0Fz0EOTBkX50x1NO3Jd1tnySzFcWHJ02xcu/itUGLQY4U7KTeo1dvr3mdfRonRsbZWoAapV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JBFqk+vB; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-81f3fba4a11so427876b3a.1
        for <linux-pm@vger.kernel.org>; Wed, 14 Jan 2026 20:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768450377; x=1769055177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+n8GlhqjGW9h/LpOBUoPhtr9TRrvBPIYxXAgf01A/8Q=;
        b=JBFqk+vBd+3bJ7k8aAqZxpt05oD+NT/aoIK8Eccm9sCYlcSGAv2EFGX8okCL+O7ZTj
         lwF9bvP65ZIoI1O11M2T+vtwoVa82Wo6mDhmZjUWGWypMXMPeO5e9cMqxi8DQblbPvJ0
         gOSEF+EY0fxo0YtH6Uveimjy6zazELSml33RopKK8NywTAyLdSCEu+0d1Tt0lg+dKKeq
         xgv8FIZdqomgRuLJ7FrmPv64OH3f1AfyAXqardHzT2NwV/vKhhx81iqh4bZy/Z2zDEDd
         Dy1jIEZIx+7ijUDPPeN8xRupQ9joteyzG5pypXyIKSJrTv7ShWOioAApnFKzwJb79+j2
         avJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768450377; x=1769055177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+n8GlhqjGW9h/LpOBUoPhtr9TRrvBPIYxXAgf01A/8Q=;
        b=v9mIsCDXnioKXg1VZ0Y3iSihBtxO8smpqniBj/pPyYofPpMZXlr+9W3cAPAZyHXfNf
         YOVnnyT0gBYUSkequl7Ys/YYbBIwcmcIUCc0WAbzaIZwzj2+FKwRGE+4b1MVQUYg0Z7r
         BcUY5SwbetLoywAmb4BBtU1Cyn03iGUWav4MVKNqnL/EdNrXnEJk0x476Y1zR3kK/uES
         weuI8Sk5gWS+IJim+i1mF7KFcoqVRR93erbpTv1q4F7MECTAVucUSJSbli+ZvXVDuRiO
         HVoG50gA0wDZxwSRd1pdllYZ7mVGFzTNatltw0y5urukBDWN3wHwEwg9W4kYRVREg6Jn
         +cIg==
X-Forwarded-Encrypted: i=1; AJvYcCUPSU72oWr84O2dfN9X9Qj8eE9Qt+OlmSzGdbrqlODrraKchJFzfRYNMiSO+vhXvERNcGxzXyatyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYrDTMEHLqdf9POwdYWe1JdT4vIQn4XU1ETNCkKJB3tLsy94Zv
	Ams0lmJOhnFf2AR2LoS/7OuU2zJGGsv0ysALkrUvbJ/O+5fsgPOkEhaUDcK0xYUnPHo=
X-Gm-Gg: AY/fxX7Zua/YdyhFZWx9FgsM52RQ+zcbcqRn1p/AFGqmYO6+xffqq5/GxAVKrISfaf7
	H8shu5jewrNZZZUR8pn8h4g1EcBNFYF7d5+6Hg2+q5ii5RVXgDE48P4tpAuJhCSyZB325VMg4zJ
	0pgjjkQCFH31mrBZLpE32aM2g32KxbyjrXGXVidoDSFXivV8sHJo1YEVQnt/W3+wn1dRAcKYgeH
	k5bukHaT5StKczHVMe7C5J71D2kCbBORDq22d6vnQ6xpp9VbKsd6PkWNg710m8AkdC8CReXQeZs
	XCP7AojnUs1lYIlO6QV0hJGZhH3kWmUk8QajBGAiJsi+BsHRayclQYf2Vwq53yvXqNpK+kacqa1
	DkuGud6Jo9eQbjWAcnsZpbnoytI8xotAzzb9So3QF9lWu3Ij5YcCvlC6qlGQIsg0MZ5nOu3/l3g
	PD0izPWVyH6lc=
X-Received: by 2002:a05:6a00:1d92:b0:7b8:ac7f:5969 with SMTP id d2e1a72fcca58-81f81ce46eemr5018354b3a.4.1768450376695;
        Wed, 14 Jan 2026 20:12:56 -0800 (PST)
Received: from localhost ([122.172.80.63])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81f8e65097asm1012975b3a.37.2026.01.14.20.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 20:12:55 -0800 (PST)
Date: Thu, 15 Jan 2026 09:42:53 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Sergey Shtylyov <s.shtylyov@auroraos.dev>
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
	Cristian Marussi <cristian.marussi@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	arm-scmi@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] cpufreq: scmi: correct SCMI explanation
Message-ID: <reqgrcf6j4t5fxtuoe4fr7rygpfxaiapzyt5rhrpts45rdmaoj@wghppcuxvcuk>
References: <e6c2e7af-ad87-4d38-9dbb-f9d6ae81fe83@auroraos.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6c2e7af-ad87-4d38-9dbb-f9d6ae81fe83@auroraos.dev>

On 13-01-26, 22:33, Sergey Shtylyov wrote:
> SCMI stands for System Control and Management Interface, not System Control
> and Power Interface -- apparently, Sudeep Holla copied this line from his
> SCPI driver and then just forgot to update the acronym explanation... :-)
> 
> Fixes: 99d6bdf33877 ("cpufreq: add support for CPU DVFS based on SCMI message protocol")
> Signed-off-by: Sergey Shtylyov <s.shtylyov@auroraos.dev>

Applied. Thanks.

-- 
viresh

