Return-Path: <linux-pm+bounces-20455-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63177A11AA9
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 08:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 759881883E02
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 07:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D5328EC60;
	Wed, 15 Jan 2025 07:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m3xpbbHL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B5B284A59
	for <linux-pm@vger.kernel.org>; Wed, 15 Jan 2025 07:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736925175; cv=none; b=imPFx29jjpblZ7WmrKBDmTG6E65tWo1gdI7J8lMAxKR/8oyJenE8NGjym4lDyW+GP87GMFU0oTRsO4WEclm34RPLDa5t7BLAzNMbWVVN1EbQP0swagnpuqoRojxkW/A8jTEubGeW8c8E3nFOT4j1L0LwVpUFoIxd8JfAzf3KW8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736925175; c=relaxed/simple;
	bh=RIZq14xveaKtJ0Sj1xMhK6C7Hi/gylDBoJENBfOSwls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qn+6hZPVtK1NrlRjAP8Mjh1N3cyRzn27iLNj7lDuURfS3F9QuD/3qp2ZyjHtgKYgZ0c4CxwO8+28EMtKTZf7kXJUkVtn5hctPVD6ls/FJgjIcfU2tLbqqswSr+jTKOmCkAvgGXRinqihWxNbP6Fh2uIfDXd6up4UqpAZmA4Yn7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m3xpbbHL; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2161eb95317so113743465ad.1
        for <linux-pm@vger.kernel.org>; Tue, 14 Jan 2025 23:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736925173; x=1737529973; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O8HHF6MYQA6CAOWThaq0m4Xv0t8b1zLcaJQ7xxZQmfU=;
        b=m3xpbbHLlnRzDWvZSZ/h33GDT0hARS94ny86kNwKZjxpA0UMwpdcWYMCZG7JkfjLAE
         nisQefZbzhiYDk5MqZ7hf2HwSQTdGdHNIx2oS6gRHpXoZ7bYlncpazymM+xJcLZUVVDw
         XkH7/2hHu8O8Xytm6nsu+ZcSsuN6xZ89lmlgLEq9764cD1/b+ky/VtFA1qixi2X+bF2N
         uI84+MiCa+hyq+VY+DcExLzToPqNadWMn4Mmby4dnl5mBzaOJreBBrfTq7XQq2Q+vADj
         8yqbnKcCsWX6WAjzxVecRn7bBQSplSoGaSBBXiZdk5IesOfSZq5FpK0l2UPjLKoZQ5td
         Exaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736925174; x=1737529974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O8HHF6MYQA6CAOWThaq0m4Xv0t8b1zLcaJQ7xxZQmfU=;
        b=eBNK8R3gj8b8kR8HsBw6AU8k9j+IX+2xWIwhf3bJpGu99zg0JpOttiyrhbR0viMydL
         TW/PdnYRDct/dxfVzRjBoS217p3oM5HR6rBl+LwuYFE9UYKdaZcRkAsPvaCpTcVJscR8
         kThRq4tOm7ZigjoMDJZjfVpOQRi9Hc1WP1tYXwv4RjMFL6ZNAq4QQDgquolEEummWGcM
         yYvLEKuIj6a6W/vZzTdz3XbY45+LIfTlWkL4gXSmKyBpWDW0AkOBYa9ASRE81JmD7Ar4
         FxqMFLQ1duOwV8g78yyyG6gz7l7hqGj17eZrlMRfNrTyOprTsbE+FyewRtTMKNeSnT5x
         C04Q==
X-Forwarded-Encrypted: i=1; AJvYcCWYy9NJCaMqJf8t/cXA7u1eCZcHUmK8np2erln1MUrBpkOLyoRlKvewNPBz2be5m7TNalRNAx18Jg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVOQBsr/i5zIObi2kxipRjK4GBW4x0R87/Ggo2z3dWERcP4BgJ
	aardWW0n82iww/as70A0JdpZfljt0IoaxJAoAQ7IztBK90w2ms5s76D7D2PYGUs=
X-Gm-Gg: ASbGncugmdEA8FyHL9XOxylGb1hHBHHFBkx6c2AxoWTEnlyLbglr/8CI3JzRSnYr6u9
	xgJMHhMAlD0QSPlMT/g4Vo1Feqj6TQiVIXjeVUkUKVWScxWbz1gWEhmiu8NDpZtsfih2zdJMKzy
	LH1puh3X6gOIB0BoMIUTj2PX/b2bDbOoDB12zwMA3i/2TYKOAe7jfWJQEQ8ioZCejSR9FMDedgt
	OoedSH8G+8fwyOhfXNtmgIJVkk1rABQHpAoe007RxhTPqxfFHmtyP+hBX8=
X-Google-Smtp-Source: AGHT+IE2T/YITMwdTXu7fGoI/VNncgoEDza43yvfpT31YZbr+6WFdwjMNUDo/e4NJFzh+zf2/sHP0Q==
X-Received: by 2002:a17:903:41c3:b0:216:18f9:528b with SMTP id d9443c01a7336-21a83f6299emr406121655ad.26.1736925173712;
        Tue, 14 Jan 2025 23:12:53 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f22dd30sm76804695ad.171.2025.01.14.23.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 23:12:53 -0800 (PST)
Date: Wed, 15 Jan 2025 12:42:51 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] cpufreq: Use str_enable_disable-like helpers
Message-ID: <20250115071251.ww6z2h2oj2v56sbw@vireshk-i7>
References: <20250114190600.846651-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114190600.846651-1-krzysztof.kozlowski@linaro.org>

On 14-01-25, 20:06, Krzysztof Kozlowski wrote:
> Replace ternary (condition ? "enable" : "disable") syntax with helpers
> from string_choices.h because:
> 1. Simple function call with one argument is easier to read.  Ternary
>    operator has three arguments and with wrapping might lead to quite
>    long code.
> 2. Is slightly shorter thus also easier to read.
> 3. It brings uniformity in the text - same string.
> 4. Allows deduping by the linker, which results in a smaller binary
>    file.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

