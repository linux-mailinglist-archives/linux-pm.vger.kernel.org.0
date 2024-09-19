Return-Path: <linux-pm+bounces-14491-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D142A97CDC3
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 20:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0397C1C20A5E
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 18:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49031BDDB;
	Thu, 19 Sep 2024 18:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PRQ8Vrjq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4688E1F95A
	for <linux-pm@vger.kernel.org>; Thu, 19 Sep 2024 18:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726771145; cv=none; b=C0Kd5mMW8PuT9dQlP9xizd3QkJtxH7QUhpf/DeXtuEb7nd7mHVs5OX4/U3qWJwnsJ6JRbi5iV7CHYLmGJtUis2kxM7+f/PQ2fXMr4J+EGUZzlinC7xbdCaKZpFuatDh1tq1GxviJSsZ1cRwCdMFA8bRoJ8UYhBxoFSjJb9ilt18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726771145; c=relaxed/simple;
	bh=11xZIjKNQ0UVk03B85El9Ld2IY8eytZtUo4DOnK/XRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BaKZq1RpWe4MbQYoxjE9XFX48IV3UXk7ptNl3jZAJvX5GY/+YenGzBo4dSiLR7nECXiUn2Lf6RjqtfoetLjL6AL+mCTIiF9oXKPDBMnv0aocTQM7DwYNxH2EIvGdIWJWDFEkt8NCcVJJzqUB0GyoKYItIzWdz0vDr1ipuCKK3GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PRQ8Vrjq; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-82cd869453eso53098939f.0
        for <linux-pm@vger.kernel.org>; Thu, 19 Sep 2024 11:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726771143; x=1727375943; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WRyKNx2jUNgKj4rHJ3yEyyNhXDGHWD1bthxzVxSAiQg=;
        b=PRQ8VrjqhCNMVKhDbeNHS4X4gaUMGWNJ2NrASoTB+qif2NBz4dhL2RhkBLAsTLysTi
         ftlpQ4gRItDZtiZAw8BngYJtaX9vm6ctyVA++I+JLZEsOzirKhwUcFBQekpJVw3MQGC8
         t+JggG/LaICTynD8Yl4iN+j61+aksk7Vti3y8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726771143; x=1727375943;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WRyKNx2jUNgKj4rHJ3yEyyNhXDGHWD1bthxzVxSAiQg=;
        b=CuDJlM4nhcjExtxTA+rEd1XlXcpTK4pAH9aLUIVLhAglplWMemEsONZ1jxiCQ+zX8g
         9/JkVZIdcHBJzdCBzwxEw39ojtDYb11ObY+UMnOUdNl2XDgYK3yPPCHfeqc6IGgNeV4m
         PKVYzTZlRpzjBU07GBEs2GoJt1QszqTaGlS4ePOC2pw9pD1NQyRU8xXYOVlVXhtL4E1V
         BpKa2lQb+GyFpX4po/sLV7ZtS9d/IgmW8Q3sQbpeI2W3dgUcw9KCdsdSY4i3cHDINUwz
         QRic4qkGBmIcehR0c3FVJRxYitwwhJ09FGMmw4NLuUqh8hh8FiTyAj4SsdVvTlTK4jaz
         OJ2A==
X-Gm-Message-State: AOJu0YzaykNn+romMxLFPqvva0iPe6dV1DXE7X5x7oTvQOQUaY1lpuaK
	HizCpn162ky1F4QJybh+1OGiR190g+jgKZ7iHOjHM6/iEr1+YUjHnFhl1iXBzpc=
X-Google-Smtp-Source: AGHT+IFiLbB7COufygh2ZrdMKfDaWHmEzlqXMoaF0ODyh+JInGc9s5TK3WvqOPyzSjOegwr5CjfbEw==
X-Received: by 2002:a05:6602:6016:b0:82b:c712:cc0d with SMTP id ca18e2360f4ac-83209e8d53emr40192539f.15.1726771143404;
        Thu, 19 Sep 2024 11:39:03 -0700 (PDT)
Received: from [10.212.145.178] ([12.216.155.19])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d37ec17e90sm3101385173.52.2024.09.19.11.39.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 11:39:03 -0700 (PDT)
Message-ID: <272b9839-f2a0-4090-be41-cf0ff8721808@linuxfoundation.org>
Date: Thu, 19 Sep 2024 12:39:01 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pm: cpupower: Clean up bindings gitignore
To: "John B. Wyatt IV" <jwyatt@redhat.com>
Cc: linux-pm@vger.kernel.org, Thomas Renninger <trenn@suse.com>,
 Shuah Khan <shuah@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-kernel@vger.kernel.org, John Kacur <jkacur@redhat.com>,
 "John B. Wyatt IV" <sageofredondo@gmail.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240919180102.20675-1-jwyatt@redhat.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240919180102.20675-1-jwyatt@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/19/24 12:01, John B. Wyatt IV wrote:
> * Add SPDX identifier to the gitignore
> * Remove the comment and .i file since it was removed in another patch
> and therefore no longer needed.

Don't use the * in the changelogs. There is no need to write this like a
itemized list. Simply write it as a paragraph.

> 
> This patch depends on Min-Hua Chen's 'pm: cpupower: rename
> raw_pylibcpupower.i'
> 
> Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
> Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
> ---
>   tools/power/cpupower/bindings/python/.gitignore | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tools/power/cpupower/bindings/python/.gitignore b/tools/power/cpupower/bindings/python/.gitignore
> index 5c9a1f0212dd..51cbb8799c44 100644
> --- a/tools/power/cpupower/bindings/python/.gitignore
> +++ b/tools/power/cpupower/bindings/python/.gitignore
> @@ -1,8 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>   __pycache__/
>   raw_pylibcpupower_wrap.c
>   *.o
>   *.so
>   *.py
>   !test_raw_pylibcpupower.py
> -# git keeps ignoring this file, use git add -f raw_libcpupower.i
> -!raw_pylibcpupower.i

thanks,
-- Shuah

