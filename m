Return-Path: <linux-pm+bounces-27499-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EFAAC08E9
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 11:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAFFD4E540B
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 09:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27937280A32;
	Thu, 22 May 2025 09:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bDdrXqbt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDCB2356DA
	for <linux-pm@vger.kernel.org>; Thu, 22 May 2025 09:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747907125; cv=none; b=gtxn17t3SXj6/wTQdBoalwWPAnAqBr5hhGbL0plagTOhPqnht0a1eVUbo1We6TSY25TZlMRLR3tCphnIZ2Q4hIsP6NW24mYluSS174Gks7FTBncTuSwZUKNvquc/UCN6m0iRqWMtExo1s6/iTCE1cDGV3BhpxZkXKEXOdb5OzME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747907125; c=relaxed/simple;
	bh=lUW88JlK7BVXXMOmbI0/ku/1QkPm4H4Jjhu0abvy1yU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ufs6UJAuSANtzgWMUmckiUkob6y7JizKacZTovTFhmVtsaiWVoMyowE70UxvgiC2JImNwf72qW5nCdRepKoasQJbyau2ajvCUzmomKpXpl2lFj7YpvwCXraxaQ3GiiZAM048GO8eawTLsz9TxJDWgnql+MsM6Kge2qaOv8olxUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bDdrXqbt; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-30e7bfef27dso5242800a91.0
        for <linux-pm@vger.kernel.org>; Thu, 22 May 2025 02:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747907123; x=1748511923; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UCeSJpIOFS0exbK/YOA4ghvpJUKGQ608Mgiqg3CcUrw=;
        b=bDdrXqbtUtljd7QhdbP+nySI75EgWkm2QMy7DDspJHCUJI0WWdk86bCyw7QBj07bYc
         Jykh5Lgp0Fo3yVnHif5BEUc9xpTHbQVb4ybBegIKtZTCdLLqTmhWk6/1qkOo3ceWdxlW
         TMVUPg58b98ewNjo6w+dyqWzq9id4lAZaXFxJ6Vx5m8lV1okziSV4bVc3fmWZ49vTiIE
         eGaE0fWnS40ArCCeoCGREIgAeo6nuRnQw7dqf4QJgnMOczWKdv6TmieLXCHDdvW+3AM7
         369j7G9u+tAYbzyW86kfQNtIZJ9bmqv/NBcu/IkWwYTkAjlpYSA48HKsCadsus/rJPsF
         Cm7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747907123; x=1748511923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UCeSJpIOFS0exbK/YOA4ghvpJUKGQ608Mgiqg3CcUrw=;
        b=CwqVFGiZnjoD1A7nVfsw4gI9zcjzv5jerpo7qYCLWVT84EJmxmvDMwUj6jEcO1xNCw
         FPpxex2lDSKjWmOsc46f0C5T2Fbl6O2tbAhjxO8u1Z+0yh/DlnYQftiPrf7IBObH66+M
         eANKfzLaiCuGA+cHChDn599r6M2ab8idnSGAlGExYxpIsvZQvgGUzUUZsQTdEPHlLz9u
         hFfPB8h0IoNcYyPvk1jjonDq+ELQssORWORdyCIfrWNWHi76B2OxrNTJqf6Y1NXcHdET
         cPECssDnc/Iad5b742LKPseJxPRR7iuH73PqHOE0P29h9ZFVEnfjzyBebhPOHaA644VR
         p0IA==
X-Forwarded-Encrypted: i=1; AJvYcCXIExh6NfqRCYh74+uwAwF41fXgIIE6/UMvQLcwWdlasEVIiDEOjAKDrBOSeQWPAukdAMh83XrSxA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxey+g3UK7tjlqyAFgKJRltqutKjE2JuHKXZz1EqSs/GxHwxQen
	2MCqs7J3JKFHKvJvH4XDoels65lr6DEvZ4idbqaNYNyaviMEXBJnKpUbAe6l9T8QmgU=
X-Gm-Gg: ASbGncthhRA2bfH2v3xQR76foZQJA8dLfDSrLKnTG95rmcaz48C80ilWQcwPCgz3zR5
	l7GygKLZ8gA97nLtmiTkBe0zi2aH9Mrobqa1L2oYN6YCfijMjB/2I7pa2e6dGCoqvvgOIeqGJGp
	8n+Qhmmp0DS9+DMqNDyCFqiXTqROiE+7M7R0YvdW43yopaIFfVE5EiTOWkrCrhQCwLou+BBAcVu
	HEDq4TNlhDwavw5imSwSZpYKqfekdB1x9LeMl9KNKpdHLK6me0Z4hZV8ul2rSpePTnRJg3uO9fG
	yl+SEvpa9JJ380vep11CezOWU/W7T4+cuX+/SEeNr1+n3jVm60f1
X-Google-Smtp-Source: AGHT+IGlWnWcKpf5U7vBQYK7+MoavUPpMAOQY1NhDDr46MQ50TxSToGTpsPqf+nd9cPRi8+h1wIeWg==
X-Received: by 2002:a17:90a:dfc7:b0:301:c5cb:7b13 with SMTP id 98e67ed59e1d1-30e830c6247mr32532488a91.3.1747907122844;
        Thu, 22 May 2025 02:45:22 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2720b62e06sm4500463a12.31.2025.05.22.02.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 02:45:22 -0700 (PDT)
Date: Thu, 22 May 2025 15:15:20 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Sapkal, Swapnil" <swapnil.sapkal@amd.com>
Cc: rafael@kernel.org, shuah@kernel.org, gautham.shenoy@amd.com,
	narasimhan.v@amd.com, linux-pm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/cpufreq: Fix cpufreq basic read and update
 testcases
Message-ID: <20250522094520.22zwevl6vgrjf3aw@vireshk-i7>
References: <20250430171433.10866-1-swapnil.sapkal@amd.com>
 <20250519075854.opnlhjlbybrkvd2k@vireshk-i7>
 <8a2149ca-a0fe-4b40-8fd4-61a5bf57c8b6@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a2149ca-a0fe-4b40-8fd4-61a5bf57c8b6@amd.com>

On 22-05-25, 14:07, Sapkal, Swapnil wrote:
> Initially I tried the same, but it does not work properly with the root user.

Hmm,

Tried chatgpt now and it says this should work:

if ! cat "$1/$file" 2>/dev/null; then
    printf "$file is not readable\n"
fi

- This attempts to read the file.
- If it fails, the cat command returns non-zero, and you print a message.
- 2>/dev/null suppresses error messages (Permission denied, etc.)
- This works reliably for both root and non-root users, because it actually tests the read action, not just permission bits.

-- 
viresh

