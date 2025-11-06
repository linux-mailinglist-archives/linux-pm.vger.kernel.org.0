Return-Path: <linux-pm+bounces-37568-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 816CFC3D85C
	for <lists+linux-pm@lfdr.de>; Thu, 06 Nov 2025 22:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F137F188865B
	for <lists+linux-pm@lfdr.de>; Thu,  6 Nov 2025 21:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90936273D68;
	Thu,  6 Nov 2025 21:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FATfLOCF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D5122A817
	for <linux-pm@vger.kernel.org>; Thu,  6 Nov 2025 21:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762465526; cv=none; b=szQ7hJsGE0FIW6S9jpDK0Xqvs62N6j1MwEXLF8gr+6mtoq6vmdDXTNWeECj8DHu2BqlIcm7dwsXEvdQqtQKSGe91RPnss1IvYtaazObr88hsqM5BA2eQk7ZxJioK7wVzI9UwM3FPzrYZRcJTELN2waH5kRam/Ayz8nCVfRBpH6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762465526; c=relaxed/simple;
	bh=uYNICSMwcINFxtVKDTUkwR+jyvr09smdSqwTdsQ/N2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MmdcSlsPUyZ9yqvs7XP0XFgJTdB4gHrpTQszkFwd28S1D8duZJjCf4D8FKxv+UV5M0lCcUV14vEZH/Gu5h0n9FPWVmG6mPTOzKvZYWTM4Xod291vFbk+djtn7V4m3m9FNr9OyuZHBzyzVT7FfLr9FOU9oPZP6ktFVPrJUz36wxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FATfLOCF; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-3e3dac349easo85949fac.2
        for <linux-pm@vger.kernel.org>; Thu, 06 Nov 2025 13:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1762465523; x=1763070323; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8wSNQhkx/Wd+48yznHEtHRoC01Ub8HTXtVN4/9DOki0=;
        b=FATfLOCFnVCLZmqXCPUul0e4ze1iFPTFXOfe5hYdDdqCViyQtUSRVqO0DXloUCvWhX
         ts3swklm98BKGdTPRsNIIjGA34tiyNgwvDavS2/YZow2K/NFvdi5b98+d4YdUwH0xfh4
         lUh7mJfCwgvjfPqniSdMRs9lLy9Gn7mKzlFv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762465523; x=1763070323;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8wSNQhkx/Wd+48yznHEtHRoC01Ub8HTXtVN4/9DOki0=;
        b=oc8lkWCzluuY0Jy20zq50eKhVPvr/0YYK39XdBNwRBMfdsRxWl3OOCVGIqPMEPg0TO
         6P/nto1ylXRD3qDxlXTDfgjqQ6n0rvRGwe9Hm4Uqnll2g/wB+Y8gN3nEBxyaMKhtURF5
         KjuDuJWXcz+KQZM5EZEEKV6FeHJZSIngYfmUut2OXPDi2p9N4+Gw5OgTn2UPJERp/Z1d
         e9UOyDBgDsQvilKWnjhwMZTu/G2Hc816jaaeSOawAf4m6r3rqO9TQUBDknkEserJWyfn
         9R9UMU3bDbWJOdarIZ92UD7Wm78f+kjOkjQauwtVcyC/7jY9kP1qjSfXtmI0mQmOPA0P
         UAzw==
X-Forwarded-Encrypted: i=1; AJvYcCUGrx5rsX1nBbqbEcGhGtVGAjhwhrYNTLfW3v4+Bu7OznA+syxruB/YnbzhAdlBEiJ3N/SA1a0LCA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1+x3/kcYUWFtUrK/CaISYRGW4tQxGJWPQtKenEjEMyH0pQnMc
	QeNiWysKydYAI9Evgfr5hS1iG51ZBB1AwJD0EUe5ciXGggmqE6IDpYP5Xg/5KuxtDkE=
X-Gm-Gg: ASbGncu4giKLYODlwu/jHfmWo2+uUMxSblBfbOJ88be8xBC4nV9X+gamspdZCiveFRo
	utLr9Q4wM3lTuerRWSeQGDL9Q4QeMLY6PHLVH8gjmV82V5qNJTuwcJqFuFdsZ9p4qus40rrekha
	MHe6wW14Hdp2UippjGz599gMJIXJ4a/ZmbWpSrC2aktVfkn0gp0WfdpfSjHV1UXPxZhIJ9Mf7xb
	FZDHiNVLarzLHgXCeoEwWFFPy61rUbrqSC0WKxiHwXbv2LMquGMj0uP71/fqVaP6/+ZXOtdLtQ4
	PuYpXSIDw5E/s4A6o53iroRDKJPqbzErxhR2Qz4wUKnByJFW7DLbU5YJis1nHdXu03jl9VHRyKV
	Ffr01JurEngyD0l+mOd23joyO1BbEO+c9QtFiaIx+7fJyRNRuXtTHOshTxJxS1xH8NXFFTXccG4
	eyFQsdd8c+iUSC
X-Google-Smtp-Source: AGHT+IFFVIQF5Ulg2gZsQPEo/D+7GUIlS0dUTcdAO+ODEVaczrhF+CoVdirV/snfEdNdIRTEZuc7SQ==
X-Received: by 2002:a05:6870:c195:b0:3d2:5173:7019 with SMTP id 586e51a60fabf-3e41e742ebbmr836672fac.43.1762465523583;
        Thu, 06 Nov 2025 13:45:23 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c6f0f5f64fsm346086a34.12.2025.11.06.13.45.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 13:45:23 -0800 (PST)
Message-ID: <5fe00261-7cdd-42c1-9668-60dc08c6479f@linuxfoundation.org>
Date: Thu, 6 Nov 2025 14:45:22 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/power/cpupower: Support building libcpupower
 statically
To: Zuo An <zuoan.penguin@gmail.com>, linux-pm@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
 "John B. Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <x7geegquiks3zndiavw2arihdc2rk7e2dx3lk7yxkewqii6zpg@tzjijqxyzwmu>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <x7geegquiks3zndiavw2arihdc2rk7e2dx3lk7yxkewqii6zpg@tzjijqxyzwmu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/23/25 23:46, Zuo An wrote:
> The cpupower Makefile built and installed libcpupower as a shared
> library (libcpupower.so) without passing `STATIC=true`, but did not
> build a static version of the library even with `STATIC=true`. (Only the
> programs were static). Thus, out-of-tree programs using libcpupower
> were unable to link statically against the library without having access
> to intermediate object files produced during the build.
> 
> This fixes that situation by ensuring that libcpupower.a is built and
> installed when `STATIC=true` is specified.
> 
> Signed-off-by: Zuo An <zuoan.penguin@gmail.com>
> ---

Applied to
git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/ cpupower
branch for Linux 6.19

thanks,
-- Shuah

