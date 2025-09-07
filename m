Return-Path: <linux-pm+bounces-34113-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE851B47C7E
	for <lists+linux-pm@lfdr.de>; Sun,  7 Sep 2025 18:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A94E91898140
	for <lists+linux-pm@lfdr.de>; Sun,  7 Sep 2025 16:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F765283FFA;
	Sun,  7 Sep 2025 16:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x5jUufKK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AD4B676
	for <linux-pm@vger.kernel.org>; Sun,  7 Sep 2025 16:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757264039; cv=none; b=njZJ0ObhFM7Avk/z3P/OvO344g5oNv4/OF6hfbwLFZkfNuDZWW0Z0X6dk2B7m8t+6skobqKRLH28rh3Ws5hSV3EqcWX8m2bAl9N8te2NWM44ylplSxwBrCuDJGzGwoIs+ENkU0hpPPZBMz41fl8NGTDL5eW3mXfHXwN9SX95Niw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757264039; c=relaxed/simple;
	bh=kzO1d26CjYIrrTQIe92/xKi3tFUly9oOjSkcbnkMCuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IOBaoMfdbaRf+tXgf7NCSVOhcuOcOJq4etx+XNnGFpXsNEymBel5pPgTdodsraE1bJjlC8WrQIITx6NiqS6BsnIlqqQbrFGKJyXzla2hE9ykPUd5YhAyYZuBldNGNLGaeHJSnUvzksf56Dhh/nPsYXtRZtQExTwFORP3QUy5cf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x5jUufKK; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45dd7b15a64so20559025e9.0
        for <linux-pm@vger.kernel.org>; Sun, 07 Sep 2025 09:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757264035; x=1757868835; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0b5aHuLlyiXUNt6Qliaxf44IrLT4IpJ+TTQE8S1B838=;
        b=x5jUufKKaz2fg4T7KLHxacq3SpZEncYofMIMN9RYugNzKWbEQbLWQSpXV6Uiz3pYIY
         i6jrbQ065XWDBfZKe4sdmMbaMD/k1OBG3GG2OWh5/5ZE09iTXvvfiZ8ej6dzLb4lf63y
         reMlPlZNWD9o2302KtCUfJw/HbLp5yBuG1n1zoji9T7oQHXhcuR4LIg/86cb5VDEnzxK
         zBkdHHTF40jPpVQZuj7hSXhuWBxHcNQH76fV0+VCWKxRdHA+YvOZz0sgfjGQkXWqyR2b
         c237cn2jYlgQBTKO8Kgq4pHuhp9PqBRtmbxrjO8x/+xkDITn6Oa7JgGlNFRRw5EA7YW/
         PfsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757264035; x=1757868835;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0b5aHuLlyiXUNt6Qliaxf44IrLT4IpJ+TTQE8S1B838=;
        b=SUGvauNK/4Lry5ot1BX9OjC8oeQBWF57EKlEK7iLqz2puCrKXPwbBYAjGrXtOFHKCC
         doXc7Kmt8+PZjGUace8Q56NX2BzkIGRWMZdQp8O3zm1ulGl9uQ5a4pfRDJcoLtXLxbAm
         O9GcvDcHfxB+wL/nUPNa1PaVRDqQTik379DIRy/2LWv4Sy6KXVzjQ43SQLVeYqSoRE5F
         1UcshepdwWmr3sSYhCNmf5CvQTrxxSjDkUNXYqisHrlRMZIYm+noJlN1jk05lyi0gCIT
         T+SWafCwbfC2JNTF8oFYsGdeGOtgdsll+azrnly9B/ljmdPDD/FmuLTTsTF6iLOqcUDB
         bGdA==
X-Forwarded-Encrypted: i=1; AJvYcCW8ZfEyGtSVgapqP1GMxKDUHwSS5TlfJ+Aza4e5+3J8PBZ/Ahxrq6h6new8LuUDHW9VKrzVwmQEng==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz+CH9ZpLSwDGuX11R6EU+on6Ev10mBE4KYJcvCx1MKd2O28M3
	8Ud0s5I1Rdc1jh/fq0IIxZdkh2VM1g+J5+1Ian0JJTrf8niAQrndIXE/wnoNp068lyI=
X-Gm-Gg: ASbGncsmSBCNz0ZeLg4sTYVYO3cyu+S/TERozadbO82rEQ3a28x3T1bFA7uCoIGhsKC
	h49domgzx/MPy0+yO6KRQQb+B6TNFJwgXgXqPwQ8E866RTgNOrOsxlH0jJvckGPfRkwcDyAN250
	gZAi0OH9K/AivPb8zH992RxwBWunmXMvq5Y3ujqft82jRBgapELUF/Szt0gX/gKo4UN/jHHudwY
	cLxEEUkK/Y2uLjjo4y8agB1J5ymZ2hy+WIwR18TI7ZLBUazWVFLC4wrgNMwbx4Fj7iiot0Hsg/H
	sabeJnbnQfxsoG6tx/tDZwg19ovyx/FM6cxFMsQ21bGzDaB1I9ZtSPM8KudM8cmgvRx3YSALl3K
	ZDCu+vGG1flizSMLYEznbErQjqygCAXAsMB2bTikQPrcaqM4A/m5wuHrZ3pirqsRL/krBuigEd1
	j10CnTlZROVQ==
X-Google-Smtp-Source: AGHT+IHNZ94fIVYGX++WYDXw00yX2U780C0UOGQJV6w/oRpb58iICGyHaYRvQiH/egvhusf/eVZNpg==
X-Received: by 2002:a05:600c:458f:b0:45d:98be:eea6 with SMTP id 5b1f17b1804b1-45dde1a8350mr46418375e9.3.1757264035469;
        Sun, 07 Sep 2025 09:53:55 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:60a3:7ee0:86e7:cb8? ([2a05:6e02:1041:c10:60a3:7ee0:86e7:cb8])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45dd3aadbcesm135438545e9.17.2025.09.07.09.53.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Sep 2025 09:53:54 -0700 (PDT)
Message-ID: <c3dba3da-800d-42f6-83d2-1b1be050c5cd@linaro.org>
Date: Sun, 7 Sep 2025 18:53:54 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/drivers/rcar_gen3: Fix comment typo
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, linux-pm@vger.kernel.org
Cc: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Lukasz Luba <lukasz.luba@arm.com>, Magnus Damm <magnus.damm@gmail.com>,
 Zhang Rui <rui.zhang@intel.com>, linux-renesas-soc@vger.kernel.org
References: <20250907154148.171496-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250907154148.171496-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07/09/2025 17:41, Marek Vasut wrote:
> Fix typo to millidegree Celsius. This aligns the comment with
> another comment later on the same function. No functional change.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: "Niklas Söderlund" <niklas.soderlund@ragnatech.se>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Lukasz Luba <lukasz.luba@arm.com>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-renesas-soc@vger.kernel.org
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

