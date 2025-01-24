Return-Path: <linux-pm+bounces-20933-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2C0A1B23C
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2025 10:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB01E16E10C
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2025 09:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F4121ADC3;
	Fri, 24 Jan 2025 09:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B2yi5eQg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3CD219A8C
	for <linux-pm@vger.kernel.org>; Fri, 24 Jan 2025 09:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737709203; cv=none; b=mvZwRteOyZ7wZrSaBx9KhIzdk58PDA3kZOvpt+3LUDaghEvf3RtVyJiSYf/DnKuDqD+oP/yvfp1cw+/muDZSz4/W9s4eaFOeG+3bRqMJlZK9H+fJwXGKL2RM9CcehRKyJFpwP1v927bCCnsWDJrzABh5Zl0G4mWikKAllJOuDjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737709203; c=relaxed/simple;
	bh=qtnew2yqeoDd0x537XOPRKdgWkJTuwX13XGRTTtXA7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZfrZBsUYt1H25Ua+ceEho04X0LKBj+VfC7/D1CLJBRsnenT1fBvmlTb4+oBv0BI66aN2xzqZO8ehWoLk1kD+RhzF4a9BFlDPYT6bzTrlyQ6k66SzRqSpmqzCLnQmN04B4m5PfGJ9FZ6JYwzNTO1OiJNsAhCotETs2ad18K+ifFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B2yi5eQg; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21661be2c2dso32146815ad.1
        for <linux-pm@vger.kernel.org>; Fri, 24 Jan 2025 01:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737709201; x=1738314001; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ybu4sa/kF8nFIfMJZSBPwPbNLo1uM5t6aB+PxaUymyc=;
        b=B2yi5eQgGrlMnB2lqMYnQcUyAERlEDFZqVy6Yc5MnqmwGMmYhOIoJTQTDcnPCYxFzO
         0TkqaGkE9X3Ty+V/kUuruDexQVUkELbNLa3+BzIr9IGwrIAJPvuGj8D6R2NiVN0GD502
         Hsx2ZTpJZOdUsgY/ivsAdYiacys9eHq3p+AS00u/8d4BNmJZi3M/dj7R5rR2s/WX0APz
         EG2lmJWiV3T/jiF5FhapG6iVOBuZ2ZAKld9iRaExd2T94908A1LVxf9KOoeUEVjurB6Q
         fenr8wp60kMYDLcNZ/VZA+e3P/p5LY0MtzaAAVN/tNP2Si0BC3eQfdw43ZjDD1Uzibp3
         9xSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737709201; x=1738314001;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ybu4sa/kF8nFIfMJZSBPwPbNLo1uM5t6aB+PxaUymyc=;
        b=vWX70Eidw9Mo+2hKYA3QVL6bPIn0mS6hF7G6tanMkLNm/nK8wPSJ+ytlmu8eJVA3ZS
         fRCeYbnbv0kOJDKA2VLJwqqldJO6CN+8HPYx5mCbCN1xSlB6A9yXr3D8HA8VFFLGEbqX
         WOaJGGa+3QP3bDdTo9LUX5AWHXJc/t9yzCAEjEOOjM0IiOEmaCAlOLS8tbheytCW7bjm
         62Vois+n3jaH1sq8Ec1gjXwOkowR5ZkMu7QMBrrr/S5+YgjyUbThMeKkP6Glr9bjf+hJ
         fWDM7OzWx5l8ao1LDOheq/crHinW+m+j0Of6uwhYZFLj/GdBpC9W0D+kEAYQ3AoZbJ8v
         qcjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUexYVgHnGEXuSBucxP17Dbvqrxb1D0ED3wHW9nyzsJGoJbeyXDO5ATOaBw8iwtGEWl/b2whwPcJw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc69XYCQO6gWXrWxAq0OUiPy1l67i+5CYh0wmAvTG06mmG7WpK
	mtCxIPfj5OO4tH+H+3mtI86Nunruy+4EdhalmTjpHKVElnOuD2pM8K6MlomJSKg=
X-Gm-Gg: ASbGncvyxcVgHDq8fKUfL2qWoSXJgEakONfKgbY9rb2czxps8+CbaBo5NfUXLTWtXzN
	g1ZXvS2GBkitxyRzlZf+fCFIXB6AEYqERl1s2W5Dou83hNK8qwCIIWUqwCNkX/qyxFfDjlNsbVt
	Sl++QLEnML0hXnT40KRgCeckd4NZxn9KYLXADxjgQ8hungxPHIb5PqN0VbXByGuVCxOu18jChYY
	Uk2RDIIIxr2+yyAd26kp1n0cGBcGXA1BGpfPmHq0r3kRBCCsHBfQ/xmW/wHz10yxqLIZcXW3Zzr
	DoA38wk=
X-Google-Smtp-Source: AGHT+IEVjb6llFvLZA8fLj1bIz8+qKQpMGL2fjpHl/XTJZwBk2LNSSpZ5Go/YNe4GEiy0dzgoymSRg==
X-Received: by 2002:a05:6a21:4d81:b0:1e0:d4f4:5b2f with SMTP id adf61e73a8af0-1eb215a885cmr51384037637.32.1737709201540;
        Fri, 24 Jan 2025 01:00:01 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a6d2ca5sm1346622b3a.81.2025.01.24.01.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 01:00:00 -0800 (PST)
Date: Fri, 24 Jan 2025 14:29:59 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxarm@huawei.com,
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com,
	lihuisong@huawei.com, fanghao11@huawei.com
Subject: Re: [PATCH v2 4/4] cpufreq: ACPI: Remove set_boost in
 acpi_cpufreq_cpu_init()
Message-ID: <20250124085959.r3cf7qfd7fxz2iiw@vireshk-i7>
References: <20250117101457.1530653-1-zhenglifeng1@huawei.com>
 <20250117101457.1530653-5-zhenglifeng1@huawei.com>
 <20250121061418.2eiifftsv6q7jxlm@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250121061418.2eiifftsv6q7jxlm@vireshk-i7>

On 21-01-25, 11:44, Viresh Kumar wrote:
> There are more cleanups in drivers that can be done though. I will try
> that once this series is merged.

https://lore.kernel.org/751338633b070ee570c3c7da053bd6b9497ee50e.1737707712.git.viresh.kumar@linaro.org

-- 
viresh

