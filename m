Return-Path: <linux-pm+bounces-10215-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E6C91C6C0
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 21:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95DC61C23DC6
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 19:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0EC76413;
	Fri, 28 Jun 2024 19:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EUESVM0x"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A235A75817
	for <linux-pm@vger.kernel.org>; Fri, 28 Jun 2024 19:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719603585; cv=none; b=uyo3lSPX57R1Dapb5KIivbbx6KJFAOPmMeSP4+cywwbirS1qrScoZgLQodLOTGKNJpV6vKpwSuLt2qp+J86KRA7JuwY/NR5M4UC8GiCjZ6vlkJydsukDpgdqe4JiFKozJTc2+8TO5yRDe95HO/ZKmIcWvh0M5KRN3p4qHOHoWHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719603585; c=relaxed/simple;
	bh=AiKlbNF2JyzTB73CXpB1ZJjuPsbUQGJbXOtwJrCQavA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=TnTafdpWVb1pJDksTJRvqCN+npr1oCwHypV/LQIjzbC+avwhPKnfbBawzm6ElXvCLq3ok0qD3YCIpzKomXheg0eAyYRaYkDWiSRru7oKhk9iCiHB8rz9fQJLHEeip7T0yHbBZpe2t+wbVvi6p6GVmJMsr3oqcC/YULLpK9cQatw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EUESVM0x; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3762c172d99so593115ab.0
        for <linux-pm@vger.kernel.org>; Fri, 28 Jun 2024 12:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719603581; x=1720208381; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jlu7OFoSigy4VBRWahwI/CAdqSq3ZHba+Z6d6xpDy0s=;
        b=EUESVM0x+XPkNnj5nWjY/8assAO+ASkJX3u3d8foYc88i2FbJvO/pxfC/Uouel6kMt
         zV9LpmUPTaryLRWIbiOF1wJUavylRu4mfAXHr/9mNJqMFqypHRQu3lAkJNq/8ZeSKWRq
         0K/0G8NwUBL/d+4rd3QWreJBhwFJBQ/vlnO7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719603581; x=1720208381;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jlu7OFoSigy4VBRWahwI/CAdqSq3ZHba+Z6d6xpDy0s=;
        b=RbUdpEBb/egYP6LNhNyuBkZjsG/uU1Mw4grEj7gKHQ61biR16rtlMCcLG0bb6eRhq+
         EgzWx+o7JbeyeyxM6Ty/83awgX1JB9x019zRoXlhD/ENIwl/tb8SgImzfCzANL7ZkW3k
         fyPczBAozhuLVGv4bl+TpZbK2NYv6THPisOh+HQy2Hzz2vrSfMLIORVMcgI5IpsKvIvz
         H496VItKKaqNrr/oyfpuVtsMpQjZf9lhDWJXKcQQCF1Dai8+yuhsWYHl1O5DqcyS+Ya5
         Ulc6cB7Ya6tNlaoWf1OSwEFKdqddOJqnWokjKTiXG1mZyTk+lT/hA4hlW74D8qfZEDQb
         3R2g==
X-Forwarded-Encrypted: i=1; AJvYcCUq8MOOBfCTObBCUqVqYE1cUsM9/qZl13GXHGSLT+WItnEqwaAh1PfvnXI6XZc+jTK8stqJYfK21Opw3fwUSFQ3KFPCtIyvCH4=
X-Gm-Message-State: AOJu0YzFXEdn1qtY7Q/X7o7r59h1v+g43fwv23O4vSrsQtzUdEYbwEQ+
	0rC3ze678M/j8JySOYb3NiepLhX7ZCKZg4ZoiwdxcamI7v11LM46GLjaCQmi7AM=
X-Google-Smtp-Source: AGHT+IEFN9w6La20dA4pfLcoEu0o6yN5RPDj+kWUC6AC8H3QgED7762nwW8XTv0QM/TYaxu3/bA0JQ==
X-Received: by 2002:a05:6e02:13a5:b0:376:3918:c50 with SMTP id e9e14a558f8ab-37639180e02mr219326075ab.0.1719603581458;
        Fri, 28 Jun 2024 12:39:41 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-37ad2f40743sm5547015ab.43.2024.06.28.12.39.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jun 2024 12:39:41 -0700 (PDT)
Message-ID: <74e09bb5-6226-4c6c-8694-7f4235dbb9f9@linuxfoundation.org>
Date: Fri, 28 Jun 2024 13:39:40 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Updating maintainer and correcting Czech translation
 in cpupower
To: Daniel Hejduk <danielhejduk@disroot.org>, shuah@kernel.org,
 trenn@suse.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ba4d74fd-6762-4e9d-8346-5f3384cb60ce@linuxfoundation.org>
 <20240628174420.5370-1-danielhejduk@disroot.org>
Content-Language: en-US
Cc: Shuah Khan <skhan@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240628174420.5370-1-danielhejduk@disroot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/28/24 11:44, Daniel Hejduk wrote:
> *** BLURB HERE ***

Explain what this patch series does.
> 
> Daniel Hejduk (3):
>    Updating cpupower's Czech translation maintainer
>    Correcting needs work strings and adding new to cpupower's Czech
>      translation
>    Adding changelog for cpupower

short summary format is wrong. Refer to commits in the kernel
rep for reference on how to write summary and commit logs.
  
> 
>   tools/power/cpupower/ChangeLog |   3 +
>   tools/power/cpupower/po/cs.po  | 174 +++++++++++++++++----------------
>   2 files changed, 95 insertions(+), 82 deletions(-)
>   create mode 100644 tools/power/cpupower/ChangeLog

thanks,
-- Shuah


