Return-Path: <linux-pm+bounces-28356-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2285CAD340C
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 12:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E25403A2B21
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 10:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D28522259C;
	Tue, 10 Jun 2025 10:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RnF53qsV"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977981A2564
	for <linux-pm@vger.kernel.org>; Tue, 10 Jun 2025 10:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749552612; cv=none; b=MP7k3vpISJpvFN/QN0LkzP6hYSRmGnba2+7wUtfUh5/wMqmZP1DusG9KtaphHPwvKUxh+GBDm3FzyOvM+3yIzYtUW90rZ5/L6UqEP7Y1f/1ahdRNm70ZIyA222OQrbXyzNuZQ7ougmHio9TsdAZP3Qg7BSfaK9NIeMsHLM1+XSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749552612; c=relaxed/simple;
	bh=M/yt6PmnZ2jrfdD0657mBZpLdkEMCr2EeIetRZlxahE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jSl2rZ+QgUSNZEaTL4gvhkc9U407/KrXYfB665tcN8CVvU7Uf8ix/W/KDyuFbErNHpgfDu40clgOAKYShzZivy/L5qnU8idZWaRMvUG53ECwErKM50MHiEqQd0Ey/iddoY/ictgVFZYlJOm2WOFvvo1ObhX+dVE8aOAeowWM6mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RnF53qsV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749552609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kpKtLhvqHS8KIVsA3iz/UE8eK3KLf6wIycYS+xtq+ms=;
	b=RnF53qsV+f2Uz9h+Jt5XT+W8yAkxN3ahdekylH3W30QChQx4WS7qJoZz7XbPzKvvD6Z6SR
	qg8Vv20qODFXeduCqqgFAniix+qTHRHX88OnGvoPfHWEYTDbuHWE/CoqBviiWh19EoOZyF
	tEtz3dOx217+UtTqlygd52+oIpBtuNQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-KBLnqK8WPFe9FR_Wo6_4FA-1; Tue, 10 Jun 2025 06:50:08 -0400
X-MC-Unique: KBLnqK8WPFe9FR_Wo6_4FA-1
X-Mimecast-MFC-AGG-ID: KBLnqK8WPFe9FR_Wo6_4FA_1749552607
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4f6cc5332so3181968f8f.2
        for <linux-pm@vger.kernel.org>; Tue, 10 Jun 2025 03:50:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749552607; x=1750157407;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kpKtLhvqHS8KIVsA3iz/UE8eK3KLf6wIycYS+xtq+ms=;
        b=Qva6cM84Dcb0N7mknbel5BTopU11FkgklNdTN9Y52wq0/0lfPxV3lkB1ictZKf9Ji8
         8OTPD/GPGNWGsF73Jant+sCke+GuroTqI8YKK89KvRTXWS3KCmCRSwzc0ZfsPcEaMScu
         sYmx+FtPU/tMqWJ5k9AvL7LI+DM6VNw+LQ6pT6jG1+cRHDSN4FvgPHfaIXv09wW/kUhs
         R8g3NIjcgr15ORO94T7foXCRLYoqnm+6gZ9+LjALJsLOZv00RNBsPfLUJ4Z2spXLP5Xa
         36vI969tS3psQXgr4twFFXpimLusfgxezLe0zXhIBG5x+f9NkyaRvrIFYpFDxna41aKt
         U6LQ==
X-Forwarded-Encrypted: i=1; AJvYcCVi2o81GrIrsoPIA2N2ao3cfyDCAYwOYDr0gmzciy02YoxQsTPiWIyV25vRR7Px3qcRnRGaa4dTlg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzW8F+bRIRCPatm2aze+gHGkXNnJTDhW6scyurCJFg+QDKBmz7A
	c2ol+OsKmr9PiMhbvrAljDUAY+7XDJTsXyhSf03g4VWXj4WM/6Fd07dQ9CYgN2x7cnqdPFkzO+P
	rCUB4NSGtPxTw3VQCcYc4cQqX2XOPhPjvHtnG6bxxhXLFFVGrzd0+E571FHtK
X-Gm-Gg: ASbGnctEp5cEiWUbDM43HuV43Qlf0L28bnZ8ytkFHdtUr70AoPEiYd0RZdMgPzaXYOe
	y+A21CJojE+oh9Yx3Rkvq1F5nX1mfsAm06FnoTVb3m32S2yBcXAKt4BqLNBYWIkjUzfjz95XeRf
	Z/3Mfh5k07Zi1o1i/X4KzlPjgQCbtZWtGdxK5HYsBe3q6M2T8O6jZvWs4rjUTJ7dCgIzlFzUMQs
	N7lyB6tVPNE1fqLfbiCnMjH+GuY5lCN9kfFxZV6vQweiaY+pf5lOPfJQrK3kLf0R4KS/YkbO6Bz
	TNiFrXSisDPyiPn6+J/qRITbuq18Fawfp9YxK225pQNz1iuvncA/+KE=
X-Received: by 2002:a05:6000:22ca:b0:3a4:ef33:e60 with SMTP id ffacd0b85a97d-3a531abcc6dmr14648859f8f.40.1749552607207;
        Tue, 10 Jun 2025 03:50:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyuazec4l8no3MvYyiI4Sp+ZhzxfrwXC8RrYYB7RCMn9Cd7/4NTRm9T1G7XMUqEsNT+iugSQ==
X-Received: by 2002:a05:6000:22ca:b0:3a4:ef33:e60 with SMTP id ffacd0b85a97d-3a531abcc6dmr14648805f8f.40.1749552606770;
        Tue, 10 Jun 2025 03:50:06 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45213709611sm140530265e9.24.2025.06.10.03.50.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jun 2025 03:50:06 -0700 (PDT)
Message-ID: <cd548b13-620e-4df5-9901-1702f904d470@redhat.com>
Date: Tue, 10 Jun 2025 12:50:05 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] PM: Optionally block user fork during freeze to
 improve performance
To: zhangzihuan <zhangzihuan@kylinos.cn>,
 Peter Zijlstra <peterz@infradead.org>
Cc: rafael@kernel.org, len.brown@intel.com, pavel@kernel.org,
 kees@kernel.org, mingo@redhat.com, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20250606062502.19607-1-zhangzihuan@kylinos.cn>
 <20250606082244.GL30486@noisy.programming.kicks-ass.net>
 <83513599-e007-4d07-ac28-386bc5c7552d@kylinos.cn>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <83513599-e007-4d07-ac28-386bc5c7552d@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09.06.25 06:05, zhangzihuan wrote:
> Hi Peter,
> Thanks a lot for the feedback!
> 
> 在 2025/6/6 16:22, Peter Zijlstra 写道:
>> This isn't blocking fork(), this is failing fork(). Huge difference.
>> Also problematic, because -EBUSY is not a recognised return value of
>> fork(). As such, no existing software will adequately handle it.
>>   I completely agree there's a significant difference between failing
>> and blocking fork().
> The intent was to prevent late-created user tasks from interfering with
> the freezing process, but you're right: returning -EBUSY is not valid
> for fork(), and existing user-space programs wouldn't expect or handle
> that properly.
> As a next step, I'm considering switching to a blocking mechanism
> instead — that is, have user fork() temporarily sleep if it's attempted
> during the freeze window. That should avoid breaking user-space
> expectations while still helping maintain freeze stability.
> Would that be more acceptable?

Can't this problem be mitigated by simply not scheduling the new fork'ed 
process while the system is frozen?

Or what exact scenario are you worried about?

-- 
Cheers,

David / dhildenb


