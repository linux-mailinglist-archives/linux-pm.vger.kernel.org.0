Return-Path: <linux-pm+bounces-23654-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 279C3A57339
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 22:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C7A33B4697
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 21:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCDE192B7F;
	Fri,  7 Mar 2025 21:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ASCLJvyP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F1017B500
	for <linux-pm@vger.kernel.org>; Fri,  7 Mar 2025 21:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741381267; cv=none; b=sTWqK4+dFLHcdF0hrIKvgMowXRJRwitfC6l5ID8ovOg0pRCyYsscp9GcWDIqxKbNmlyiyrxJCgc/BSxq52YUF5vNj1yp1xC/qo9RB4g9J8qMeYx02s0C1oTAxcmNtj09YXZVgqhIKFmRwyO3CsbU0UgQjaLwEwlZIu3RxLbH2q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741381267; c=relaxed/simple;
	bh=VOshJSE6jB4woN3d/OLsw7MLFJndnwrw1tbGnKCQXrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fTxLEqosGMY0ubg5v2OFZZGDLP3DlOvrsuFCUCEqPbZ7d+HBso+X4UFsb7AxApA7R8izc/TB+e4BxLajJPh1YLyUfbcBQxVcapLxZUi5L602xGN58JtSJ6UUFyG1Jk44AwSs1NfyYED534WO+dQU2rwSmvV4SlGmlLXM9E1rRcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ASCLJvyP; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-854a68f5afcso58449239f.0
        for <linux-pm@vger.kernel.org>; Fri, 07 Mar 2025 13:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741381263; x=1741986063; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gojw5NXZOYqYq4u5l0ybvxzT9QRwqj86IebaWxrKM4k=;
        b=ASCLJvyPVnQIsaoS1CiR1fFeQm6gKwA7OHUmlx1+TM2Op60iFLgFOOh80kRGYMWP6g
         uZSAt+k2iCf5NjwcYgxNTf31ElTI/ntJO5OfiStwYCz+Fhc/SrxnH0psVeAwvovmw9Mw
         2Hr56CWkHqw/G5JrqxBThaP2BV6fRYzSY8W84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741381263; x=1741986063;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gojw5NXZOYqYq4u5l0ybvxzT9QRwqj86IebaWxrKM4k=;
        b=vbi8woGsVbuUhhKJAek720PG5htXO8nPDVw8AOSYBfCtgNvHW8n7X5n2+2KIAxQe0g
         IooreIcaHR8esYdBybMipIj9yTLVwg8T6N3gQ97cr1wDAokRk2Hy1KLgJnxNkcIm3V7q
         04bpGQrSJTIXoZKefqMvgYQ2J0zYaemSifaF9vGS8tpU78IMaPJXFaBmX6R2l5u9MjFA
         d8IlKqRfOcXAjgF3SOfu6Ra69ahKab6xu/TTMArGj5M4qAtTtoGdL04xqF6hmdxuPNg9
         cQBSXYXN/uEfQSMMDt+4rbXe4Hd1ZBCex344KddvfSE54/gDu477CJGWwRwu6FsVNFNE
         OeNg==
X-Gm-Message-State: AOJu0YxPDy+5xSExGC4yqNq178brOoJ18+N2tPhULS9fmUc9lM0poXan
	h10jQOXANhPIB0h7805lGtatTqTZwwTCR0/kgW3A3j/Ke6dHMCD4QGlZQ3tqi3E=
X-Gm-Gg: ASbGncusrMBtXP4Ar2gDcDC5hyesOkNnMgAZF/9cmOY4csAetliCOT+SQ/IVGPo+dV9
	+8FIkLbNs7sdubS7crrsQF7VUePprMiDA/238f5HhYYl6ETX82fXoLnZe+WSoek1AhuFEGaxq3E
	VbIlB7X2Xfymwl1Srm+4UtMXp9YpTSLXwIsA5Rkr3C6HnW9MHrH98bHH6TzC9cLyMHDR3ypJ4Ov
	3HgMsCXCuHSym0Yz7fgdfnEpUnp6SZ/JVjv1Q5rUv2aZ3utxlrickDiWGIYnQIkPmvaBNggYYNd
	fBMhRqpzGsJscxWGsCHAUmODonNKNCMPUwsR0pEjFLFllpBHk6PdQis=
X-Google-Smtp-Source: AGHT+IHstWsZCXkrV4uQr4aex3IbYP9cioo+k/TjVj63sEMYO3cNyoQA9ZU9j6vdA7sBseRtEVERoQ==
X-Received: by 2002:a05:6602:3719:b0:85b:a:1e7d with SMTP id ca18e2360f4ac-85b1cfe8dbbmr737117339f.4.1741381262729;
        Fri, 07 Mar 2025 13:01:02 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-85b1184a4besm95503039f.0.2025.03.07.13.01.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 13:01:01 -0800 (PST)
Message-ID: <1fabcc28-dae2-4383-9396-2c8e229b8c63@linuxfoundation.org>
Date: Fri, 7 Mar 2025 14:01:01 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpupower: Make lib versioning scheme more obvious and fix
 version link
To: Thomas Renninger <trenn@suse.de>
Cc: linux-pm@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250307094334.39587-1-trenn@suse.de>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250307094334.39587-1-trenn@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/7/25 02:43, Thomas Renninger wrote:
> library versioning was broken:
> libcpupower.so.0.0.1
> libcpupower.so -> libcpupower.so.0.0.1
> libcpupower.so.1 -> libcpupower.so.0.0.1
> 
> and is fixed by this patch to:
> libcpupower.so.1.0.1
> libcpupower.so -> libcpupower.so.1.0.1
> libcpupower.so.1 -> libcpupower.so.1.0.1
> 
> Signed-off-by: Thomas Renninger <trenn@suse.de>

Tested it and looks good.

Thanks Thomas. Applied to cpupower branch - will include it
in my PR to Rafael.

thanks,
-- Shuah



