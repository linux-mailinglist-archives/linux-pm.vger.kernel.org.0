Return-Path: <linux-pm+bounces-20784-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBE5A18BC1
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2025 07:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F2A0188A7C9
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2025 06:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B054F199384;
	Wed, 22 Jan 2025 06:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jR0TFrjr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286111A2550
	for <linux-pm@vger.kernel.org>; Wed, 22 Jan 2025 06:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737526375; cv=none; b=cmnC+JcmjP5SxEwsK5u/C4lpgvjnm8ztO9mztd+StgyH31aFkfa1MBoSA8Re6svG9v3JGYbTztCZiM+nNelJOkyS+lXDotIgvtGEaH6NTv2yvub2PzFT6b7iYREZI2vJkbugerqF+mvotdFmMh9k+Fw7WiXmzTtw41ZnewWO7Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737526375; c=relaxed/simple;
	bh=1M1v1faCJ0YnxCiTl9fBLMbbKtsRjF6LQmHYBasufMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D20VG1S00po3QC3gv4+6/JkE+YXQgpPFYpwIddD8qsj4Tx9hQmmNBjN+MjBCzWgKugEIgo0lYKzjLcBoEPsXbE+LRdU1d20Mohq+cVN70ar7MmOtB1pS+3VSDNmsa09eTvFRAHvTcLcR8KeInO0nQQnVlBkMTg9tL/5iuECKT5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jR0TFrjr; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2167141dfa1so9549795ad.1
        for <linux-pm@vger.kernel.org>; Tue, 21 Jan 2025 22:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737526373; x=1738131173; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l3KK0MOGtaWAndAtevjHBrqbRfvIMC+MFqCBRHVSmGE=;
        b=jR0TFrjrMAyTLRaE/Tw2Jvm0UT3HCorCc3oquYkqNqNe5vQ8ksyo18AlNkM9JG60g2
         YlGUNxtxz93ivyaTXKqUHEmr3P1Xhsd0ucFDqlxD89L8wBcZcoCa1p2uTXeZW21Xd9bn
         UW8LOuaEALmBoOpLdLwP0tz2ldn5EbFOmj16mEyWeNSK3HMB4cNa2h62mdzxmQFxFayH
         96bSgikga7hc9T9XTcMtVHzpFvysGSyAWEZ6W+oQreHNfaImj4ARu60AeBRLdjUgT/8P
         0UHdJYWIbG/Pw7c7GYDdiQq544Xabr4C0cu4ENCi4k6eJpB2HXhBs6uvmvP01UQKCOpv
         iKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737526373; x=1738131173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3KK0MOGtaWAndAtevjHBrqbRfvIMC+MFqCBRHVSmGE=;
        b=fTIowTop0VyN94exb4CZd5/AlsbK0mlSq6BLdaYrMnLn4jIv0i6ODCqyWS8oOqVsaO
         Y5OzQjGyfpucwkXNosM0SMxHguD2MyFQJAiuqa3/fEHCnEy6QIu5mMspeWwnUAsdAXmy
         OqWksjhYwKj4VPgCr5g8wF67ylmYxcb3VmGgNi9fAuRMMEwazQ/mCdvlC9HHnBLgvtBm
         ET3NMsCHn1soYtwi+3y8CKNcXVlQxwsYCjCcD3Gx5XUyma/VZBbqzxxmZPK2Ztt2MUYU
         gOk1ElMMqS0zYAbFXMe28nR3oNczbMFWVlrsi+glMroQV8jlDRiY1EJqN9aVznR/clPo
         GKxw==
X-Forwarded-Encrypted: i=1; AJvYcCUSI7O4B+UJuMTZSCldU6kPeiMp5/Xd6vt8g4F5kiURLVOjScc26xB3elq7yYzoRwSXbiW/FiyMmw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWmFaAddjiJsMNgENGvlCA1qHilIqdepTQiorNZrl47kW+AkrS
	FnaII7YsQSl8BRFLvvwhNCyI4yCmsdur1qxDBgSmyKpeZ3v2DsiPfvnEWmUC9Ck=
X-Gm-Gg: ASbGncumSLt22D9c7HIl1P0ZZWCsPuBjjPe8HWTlJAivsjpmdD3MwvjyVvS4qJRS8cm
	T91B6N7KHoTKQ6rd8Sei7mAI+9WL51J5fAIYZb9lKQHq2flalvNFsPwT8yVO4f8MQFBRSycr689
	3PSeRXCRv3E8f5PWxyTqI/xd9AHO+NvUQIaIq/PsaZNYE09Dcb/GU1MC5SvFBuBO9egUlXVI0Yz
	NdVzsd55B/U4QRm7jXkn2Ft9UzvK3Iojfcavmrzx0DuHdkc2aQhVhExoSvaSi84XUZyzRIns2Rj
	og6BuTE=
X-Google-Smtp-Source: AGHT+IED/wG8Z17uHAG8RDgDajZiHT5+stnTHfFUkVB7r5dBPMymGpBSqMx8GkfsJxtH9EE8WcA1qg==
X-Received: by 2002:a17:902:d4cf:b0:21d:90d0:6c10 with SMTP id d9443c01a7336-21d90d06e63mr12437185ad.23.1737526373366;
        Tue, 21 Jan 2025 22:12:53 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d4014dcsm87823835ad.206.2025.01.21.22.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 22:12:52 -0800 (PST)
Date: Wed, 22 Jan 2025 11:42:50 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Beata Michalska <beata.michalska@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
	sudeep.holla@arm.com, will@kernel.org, catalin.marinas@arm.com,
	rafael@kernel.org, sumitg@nvidia.com, yang@os.amperecomputing.com,
	vanshikonda@os.amperecomputing.com, lihuisong@huawei.com,
	zhanjie9@hisilicon.com
Subject: Re: [PATCH v9 1/5] cpufreq: Allow arch_freq_get_on_cpu to return an
 error
Message-ID: <20250122061250.kxdpkkvce4g5nar2@vireshk-i7>
References: <20250121084435.2839280-1-beata.michalska@arm.com>
 <20250121084435.2839280-2-beata.michalska@arm.com>
 <20250121104706.2gcegucb6hcuksrd@vireshk-i7>
 <Z4-52JUmR7A-7NJP@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4-52JUmR7A-7NJP@arm.com>

On 21-01-25, 16:14, Beata Michalska wrote:
> Theoretically speaking - it should, though what would 0 actually
> represent then ?

0 won't be a failure, that's clear, since errors are represented
differently now. I am not sure what 0 frequency would mean and it can
be left as an architecture specific value, which is a corner case I am
not sure will ever occur.

-- 
viresh

