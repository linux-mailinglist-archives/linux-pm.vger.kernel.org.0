Return-Path: <linux-pm+bounces-10200-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F14591C1B1
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 16:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1553A1C2093D
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 14:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780731C007D;
	Fri, 28 Jun 2024 14:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Kk0GUHi/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA5C1C0048
	for <linux-pm@vger.kernel.org>; Fri, 28 Jun 2024 14:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719586400; cv=none; b=k9cL4lKe8xOr9i/S+EY4E8FlmBHfnpzoojX3xW31tO7aUkP8ezHlY8Xyo7qU3tui6dEuuH0gPoidSP0EmqsPVq0rkzSViAqeRSMp0fGb2Sv2wUuij/XuEee4dWRFoHd74JjfaTphqGo1EBbWpFWUh4p5ZxVlJ27cQz0CMOry3es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719586400; c=relaxed/simple;
	bh=1dB7UHPbYnujscVYEmFnttW++598Qv9F86Hsiobx4UA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=ESCEScWH9mcMZvYRzZbLby6ZtWLyIP5tTDz3bdoEf5pIxfggso0Xk56uVnD9/tgiYru3bZfHcuFoPH5iHtsBETjdII1lFpY5fMwcLlJ/nXVt//PMWJU1ANQScA3XcH6UNDl/Qz2PXqnPaGMbfcBRpNGfVrwAI6plcQVJC0IQWRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Kk0GUHi/; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7f3c804daf7so1478039f.1
        for <linux-pm@vger.kernel.org>; Fri, 28 Jun 2024 07:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719586398; x=1720191198; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vdbljrs/1ZCLZYC6oYgGWzonLEN9hffCNj85tHnM168=;
        b=Kk0GUHi/dazzrbbGKS7t37CGgrm19xmqijlxsnOjZMcH6LcgQ1IoDsjWqTKxki3yIt
         m6a8FOmXrghboJDadGxeH7iXqLuEmpt1W5TbERv1JadDi7XWFTaEUrK0cuu9AnAyyVGr
         HPUUe1QT+F0n8q7j1IdhszTKssJLV7BKrlaL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719586398; x=1720191198;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vdbljrs/1ZCLZYC6oYgGWzonLEN9hffCNj85tHnM168=;
        b=Ti0v/u6pQ3ecjQ557adJT7Tf0+P1W9xLmwIJ1eUgnqEZK36A9e54ANvk6gB7w/xImA
         YmMn7dK6++9pQLXwXGhA24SpCTz15ZZaqE+ypRK+O5NBHfdUixcX3U3Fcr3c+iPD9x+z
         lvtn5qm5pQhaUbT1JOGTw7kAqjTx7Hdw/P9LXbY/bxzZetFvarz3NwsejGhY+voTSOud
         X8466NwrQAbn2k0NehoK6aGQR/d3lDHn5ZrjVyi7rddoVS4eoKvkEzxIZC7USGgiCp7l
         qu98+p0axob/q97TUUBRVPsWFSJ1Sy4NctgmoPOwxi2C/PMoaYqBtsmLRPB3f4Q3DS8G
         aX3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWdkSAsPkzoqs24iLi01Ka7YLkrchw3XWFsJXcamga2AThnFV7uW0R8YOAjqveUgR+qAmbqf5CMvqQsWLsUHSaIANhVtnkP2TQ=
X-Gm-Message-State: AOJu0Yx5QiH26oBPsMKQn0P/VfJJMpwbsXmMfeu9UyeemDqqcOR1KGVH
	7qyC/Bs0cD8LpalAWBZly4L1U14U70lz6y5kEQORoh7VtQiqKcOg3jklKBDHJkVKo0h2mcqqNes
	x
X-Google-Smtp-Source: AGHT+IEY9qxTGt1t7su4b1INqVFoK33N+IUogITcmKIEi5eGoA1p6/abyJH1K7FUxOQ2lxxpHZjWKA==
X-Received: by 2002:a5d:994f:0:b0:7f3:b778:6966 with SMTP id ca18e2360f4ac-7f3b7786c2amr1400474839f.2.1719586397706;
        Fri, 28 Jun 2024 07:53:17 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb742b9974sm553122173.137.2024.06.28.07.53.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jun 2024 07:53:17 -0700 (PDT)
Message-ID: <ba4d74fd-6762-4e9d-8346-5f3384cb60ce@linuxfoundation.org>
Date: Fri, 28 Jun 2024 08:53:16 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] Signed-off-by: Daniel Hejduk
 <danielhejduk@disroot.org>
To: Daniel Hejduk <danielhejduk@disroot.org>, shuah@kernel.org,
 trenn@suse.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240627135437.2301-1-danielhejduk@disroot.org>
 <20240628092508.3664-2-danielhejduk@disroot.org>
Content-Language: en-US
Cc: Shuah Khan <skhan@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240628092508.3664-2-danielhejduk@disroot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/28/24 03:25, Daniel Hejduk wrote:
> Updating maintainer of the translation.
> 
> Last update to the po file is 5 years old. I will try to complete and
> maintain the translation.
> ---
>   tools/power/cpupower/po/cs.mo | Bin 0 -> 12805 bytes
>   tools/power/cpupower/po/cs.po |   6 +++---
>   2 files changed, 3 insertions(+), 3 deletions(-)
>   create mode 100644 tools/power/cpupower/po/cs.mo

There are multiple things to fix with this patch series.

1. Missing cover letter
2. Binary file included in the patch
3. Subject line doesn't include cpupower. See the format below
    cpupower: -----
4. Change logs are missing are inadquate.
5. Missing version information - this is v2 series

Refer to submitting patches documents in the kernel docs.

Please fix all these problems and resend patches.

thanks,
-- Shuah

