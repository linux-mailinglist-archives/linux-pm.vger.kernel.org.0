Return-Path: <linux-pm+bounces-4451-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8008869C8C
	for <lists+linux-pm@lfdr.de>; Tue, 27 Feb 2024 17:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C1D61F248A0
	for <lists+linux-pm@lfdr.de>; Tue, 27 Feb 2024 16:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E8044369;
	Tue, 27 Feb 2024 16:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Dwoo1/r8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB540200A0
	for <linux-pm@vger.kernel.org>; Tue, 27 Feb 2024 16:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709052087; cv=none; b=iSu6xkLDicIgUvXM6kzooUtIEXkyXtmAH1vT8FlftyuWPBF/A63zukpyFPC06XzrpIjLvtLhAT4OLzKdEbuDZnEgnOc/mpMrf4uiLyE2L+KSHlePzfHIHQe0ZnL5sIBb99O8vpE9yh2jf4UZwO1Rsm9aU6WASE2bBabzpIBTXtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709052087; c=relaxed/simple;
	bh=/drlaqNP34djKRMPww7Fy9vfeScYwuCh547zTKPR7TY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WkZoFWQcauOsnclObIvZLo1BxKdava7puAIR0g37cAWhS/4k/w+24+Gk5o1JKQ9kGQhvrGNvWDxCAmd7+0n70yE4ig7yfsfrNH4t2rfP74OTQ3+92Ca2nnkuoE7bPp9QjFoW9d6Gq5ZUFkCjZ8Zy7dCusPOXPfNHSTUlYijLegA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Dwoo1/r8; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5a04665952eso90051eaf.1
        for <linux-pm@vger.kernel.org>; Tue, 27 Feb 2024 08:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1709052085; x=1709656885; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cj7Czl12HamAEioeVvBO9DiukTU/zhT4MfnATWo179Y=;
        b=Dwoo1/r89EOVOjAjfR9mHhZe6H8WKo+0Q/0K0G3RiLg+xq46NCE4n4zzchXh9SPGiC
         mXwij9heY8JtqHbmPnWxFkRDKE5DnweKOeOcdpN6asYYzf3go+/nMo8WrxzFXBjYDK58
         AFtu/jT641TwLkRqCpiLAFEznG5RMXgu9WuJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709052085; x=1709656885;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cj7Czl12HamAEioeVvBO9DiukTU/zhT4MfnATWo179Y=;
        b=bNais1MumRwaMRkLEtYwtpgX76twU/qeHS+L+In0CO33ohz4qjehAQUtU5J2Zwt/3h
         BzhTViT0PSFLFe6DM0OIGpGhDJyO8CrYiZZH/uLpEz7opnjmx7fwyBoWO+y1vPoVKRBy
         VSTDjS4NEYJsZtxmbcXisMPLpLJHY6KMYUXdWFVjBAnxvMwnbZEngHTLXih/LB26epVN
         kttq+a4CmMaMHQD8sdLVXTc8ZQpBoQikrVT28hhGqgVdR2ShtRUNbXb6VbHzyYQIF5e3
         pygnMb2CdIRtvhoaDGGQhQDfQ8q1oUJZMI++GOG3nRmmIhSl5DcxbtV+PQsS8SHaPl6b
         DkTw==
X-Forwarded-Encrypted: i=1; AJvYcCX7uJTt8qjWthmU/GUK2mS4IbDZvO9y8a5uDwe8h9PnblhuuVqervm402ueKRypzwSD+5juVdEhPM290ng/0d9YPtvL6FZDE14=
X-Gm-Message-State: AOJu0Yzsiq/Dn5CKah4QdO27qs/WJIf4qH3cm4gEFLDKDZu8yUdLRQpM
	7ckHoh2qTsWyQTa/e6m7SotPIINMixqZgUDBYpKmeIxQgC3LjsVGdkZaBXzsIV604quZOSeBWXc
	6VLM=
X-Google-Smtp-Source: AGHT+IHbpcRP3SYOp6TthHDLPxhDxQntg2dWl5/P/9lzYYvGOMon4J/GdfdlbHWeBuNjMwcMVhHFVw==
X-Received: by 2002:a05:6820:2c8e:b0:5a0:4d78:975d with SMTP id dx14-20020a0568202c8e00b005a04d78975dmr9529006oob.1.1709052084818;
        Tue, 27 Feb 2024 08:41:24 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id v11-20020a056820004b00b005a0a8e661d3sm456853oob.42.2024.02.27.08.41.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 08:41:24 -0800 (PST)
Message-ID: <2aaa2a61-f753-4434-8c92-886fc4bb9aef@linuxfoundation.org>
Date: Tue, 27 Feb 2024 09:41:23 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] selftests/overlayfs: fix compilation error in
 overlayfs
Content-Language: en-US
To: Meng Li <li.meng@amd.com>, Andrei Vagin <avagin@google.com>,
 Huang Rui <ray.huang@amd.com>, linux-pm@vger.kernel.org
Cc: Nathan Fontenot <nathan.fontenot@amd.com>,
 Deepak Sharma <deepak.sharma@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <Perry.Yuan@amd.com>, Xiaojian Du <Xiaojian.Du@amd.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, Borislav Petkov <bp@alien8.de>,
 linux-kernel@vger.kernel.org,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <20240227074204.3573450-1-li.meng@amd.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240227074204.3573450-1-li.meng@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/24 00:42, Meng Li wrote:
> make -C tools/testing/selftests, compiling dev_in_maps fail.
> In file included from dev_in_maps.c:10:
> /usr/include/x86_64-linux-gnu/sys/mount.h:35:3: error: expected identifier before numeric constant
>     35 |   MS_RDONLY = 1,                /* Mount read-only.  */
>        |   ^~~~~~~~~
> 
> That sys/mount.h has to be included before linux/mount.h.
> 
> Signed-off-by: Meng Li <li.meng@amd.com>
> ---
>   tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

I don't see this problem when I build it on my system when
I run:

make -C tools/testing/selftests
or
make -C tools/testing/selftests/filesystems/overlayfs

Are you running this after doing headers_install?

thanks,
-- Shuah






