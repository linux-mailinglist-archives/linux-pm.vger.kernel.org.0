Return-Path: <linux-pm+bounces-10227-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD59D91C8E8
	for <lists+linux-pm@lfdr.de>; Sat, 29 Jun 2024 00:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF9F61C228E4
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 22:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9821F80BE5;
	Fri, 28 Jun 2024 22:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NOYIM9kH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC0678C64
	for <linux-pm@vger.kernel.org>; Fri, 28 Jun 2024 22:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719612342; cv=none; b=DeDG4g3SREfPlTvceyYFuHkBwpu/Ha4QbSjO1xhK6P5SRD2Zfcl7MiPN1eyJmoSkw1gdFYr6/1Wpn/snqSCMCdx7A90PAzJubiWbTGp/vDnc+4oF/Hma5MtRZAbB+60+ttN8oo8CBVB3jLAGg8i/1QDWMXvZCx5xkmob5YTBnpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719612342; c=relaxed/simple;
	bh=3aGEUvIOf/bidCVYqF7K+ZG+H0niWJmyzjVQCHJgyDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oYUsiLwEayg5565Kun3/9TAZ1pTBLsioaE5+ZUq0DnPsY/P6OJU7ruqYnhoukY95QsqJY9XmTrFWoJNa/wCeOsfbY+e8RNFuk8BWPJzTnmP4AiQBfsJkKGj+SVhSd7VXlvPfh9rQsk3zxGC9yppZYv/iS3UBJPRlz3g/i83plZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NOYIM9kH; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3762c172d99so667265ab.0
        for <linux-pm@vger.kernel.org>; Fri, 28 Jun 2024 15:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719612339; x=1720217139; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4zlra1gL7XkIhl5N+DR/hN71YFNtByPQ/FFGNneM+Yw=;
        b=NOYIM9kHcvXxaGbifJSO7dRypGIHhiJV2SotzEC12EUh2kppj9dzx2y8T/DtkT0m6z
         hNewHC3nYgdhsdRT/xuDM2KXdi97mBS4d40785+GLrAjWwNkudPBsd5rwXMm9ee8DOL0
         sUE5JU9T6fJ+EDDSWQuZ+a1OYJcgrFC2hkJYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719612339; x=1720217139;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4zlra1gL7XkIhl5N+DR/hN71YFNtByPQ/FFGNneM+Yw=;
        b=dr6zRE2AL6Q1R6fhxnU5WbDlOs+XQ4Eo0/LKg93TaHdCktM2FnhP6BiYX06Az3wXFK
         boBOoIWOsxFlJ2WeOFY0VpN7U0/RlLHCDv+G4E8bnx+fWGq3P8W0nwcyBHHcc/3NU3a9
         nlpNxHlKoa0mPQdvPwp1l2ca6HX+EsyxA5t40UvR2Ay3DgS2RdFuHZdBVCW3/CyUZ+Cw
         ytg3Z68mYGddiyLZOJHRAFc0dB9xCPj0Grn9b/AmKD5UAnryH/tKUtrX6dcbmyhRIzfF
         ZcSXu0TOvpXKZMRQJCEEo4kTeOGlR3o9mK9mGY+Ldc7RaLLKtpbRLI8F1HqVRqvwXcAY
         SeLw==
X-Gm-Message-State: AOJu0YwfUiubdCxq8zgXbJG+E+hpvu3EKgY25NppNNDWUM/Qr8n1hj19
	zBRhnApYgJ9sQbEYzZ/kJCecfJk/J4lBbxUgdsKz2rX7ztzvdKsPdLi2EBD76Gw=
X-Google-Smtp-Source: AGHT+IF5OaIaROSuGC1uEW7EZhHMkRrJMyqFF1GvL+sDpctUstwwNAvMlMZLGaJx48j+sKTVWG2yKQ==
X-Received: by 2002:a05:6e02:b21:b0:378:cf86:357b with SMTP id e9e14a558f8ab-378cf8636b9mr98406635ab.3.1719612338752;
        Fri, 28 Jun 2024 15:05:38 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-37ad4370c90sm6147595ab.69.2024.06.28.15.05.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jun 2024 15:05:37 -0700 (PDT)
Message-ID: <c1bcd796-033e-4ff1-b610-c7c2f64e0b44@linuxfoundation.org>
Date: Fri, 28 Jun 2024 16:05:37 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpupower: Disable direct build of the 'bench' subproject
To: Roman Storozhenko <romeusmeister@gmail.com>,
 Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240626-fix_bench_compilation-v1-1-d039bd5fa551@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240626-fix_bench_compilation-v1-1-d039bd5fa551@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/26/24 10:45, Roman Storozhenko wrote:
> Execution of the 'make' command in the 'bench' subfolder causes the
> following error:
> 
> $ make O=cpupower/build/ DESTDIR=cpupower/install/ -j8
> "  CC      " cpupower/build//main.o
> "  CC      " cpupower/build//parse.o
> /bin/sh: 1: "  CC      "cpupower/build//system.o
>    CC      : not found
>    make: *** [Makefile:21: cpupower/build//main.o] Error 127
>    make: *** Waiting for unfinished jobs....
>    /bin/sh: 1:   CC      : not found
>    /bin/sh: 1:   CC      : not found
>    make: *** [Makefile:21: cpupower/build//parse.o] Error 127
>    make: *** [Makefile:21: cpupower/build//system.o] Error 127
> 
> The makefile uses variables defined in the main project makefile and it
> is not intended to run standalone. The reason is that 'bench' subproject
> depends on the 'libcpupower' library, see the 'compile-bench' target in
> the main makefile.
> Add a check that prevents standalone execution of the 'bench' makefile.
> 
> Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
> ---

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/log/?h=cpupower
for Linux 6.11-rc1

thanks,
-- Shuah


