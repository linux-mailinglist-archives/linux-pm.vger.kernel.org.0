Return-Path: <linux-pm+bounces-27110-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46829AB5F09
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 00:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81A858C029D
	for <lists+linux-pm@lfdr.de>; Tue, 13 May 2025 22:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F571F4190;
	Tue, 13 May 2025 22:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YB0HUSJC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C089AB672
	for <linux-pm@vger.kernel.org>; Tue, 13 May 2025 22:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747174162; cv=none; b=WyfrORrzS2Wbu8/Z2x5zpVtA82sGdF7Ra8RauczSoKEZpRxBEtfXJTGkTEn6IrLlK1zrZEQk6SoSoG6Zbzj2mp9EHTondV6Tp8PacpfdUg1oEm/U+w4bwK7K8C+DBdibyuJGqxKiRSQ3ob1Y9rtPEQd9uq2L0t9IMZpaerNFbKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747174162; c=relaxed/simple;
	bh=jNGodkxVsaP6SYycu5iFPUnVWpqXmm8JQWM2ww3OVRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JiRvW9soqsUuhfiSA4xVOXL/IceDqPFC1ZrXZKxLrj0d3OptD+MSNKFoc6yZBlSK3CQireilBRPCtG1NP8EX6vk3KISDl/kYDwI2Fqk+e9uF3SCrcf/aYI4iwatmS6aIpph8KCQyO2gZbKxvFb93n9nhApHyFCVI9ijye56voqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YB0HUSJC; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-86135ac9542so14166839f.1
        for <linux-pm@vger.kernel.org>; Tue, 13 May 2025 15:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1747174159; x=1747778959; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RWO/l3NJzTnRU8kpSCqjvCgWkktFPjXwi12a9cTi4wo=;
        b=YB0HUSJCmjfbuUv1x+C6yM6P0/yFnfu13CyNhr2G7ePWhWIoSX/KO/nRuczynJyxPf
         c+zMfzJyesmbY3Vk0X/mteWAahrB6ZvcmTnUvXiexZ3YGYNx97LTH9wK2YdQY6D2uXXf
         hBDuez8TmnBp2xsM3iT2ww7lySOozG53y+Chk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747174159; x=1747778959;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RWO/l3NJzTnRU8kpSCqjvCgWkktFPjXwi12a9cTi4wo=;
        b=LAEXC7I1hWQvQXuAksOI+4isZYdLBgSJ4i9W2tdx9f3UDYb0UJH+SOPiEydzEVqUrO
         1By+3yYlbAk403195DBo0x49BR8ybeMrt0XmYHCS0PQcTtpmD4SquzFpleeaNVmionos
         nr4Pv8bkKjcTnov2UogT0AZhgBRiGGgKujb/lTEYFqrpn8uNUkOAhyjSk4qR8iQXON3P
         Qei5hF50fRwMTh6eKrg6ShWqsC/JWyk6M2lp32m+tFgv2VFkEiXLWNAGyxXHc3wbJ0kl
         wB7kxqr1ojPyz8ZmIMx0KwC69ZJJ9DKKdUsCo4lvwvYQSTvfM4DRJNypMaXu7P3/jjqe
         jtSg==
X-Forwarded-Encrypted: i=1; AJvYcCWwIwZCt0yqaD+MyT5fQXJfjIgPG31nLYAox8uUfK28yCk+TwVT4vcYRnPXkQu3Y0LEHB+W5aaq0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy2CKB+zXN//eAaUoc0vHxYT4w3Qf1erw53822sLNiZBLsoYWc
	WgcLhDWnvP+GrcKVIv0e/wawfEt96LsuytPdzGwoA8N3yYXd75kCJAGltgH/SiZAeQSNQWVW7ao
	W
X-Gm-Gg: ASbGncvHhOqhRJlpeLnfxk5NwL01h8iotpAF6tcTyJXXhQt6vH9A3XfO/mpEgwOHncR
	uTUC0YI5gV38S3pxH0oqXGnmND9Ekb+1HR278c2CH7EoAD+PSfKMs4hr+FA02QEKd2YZprZprmP
	fLs7Ve8Ky2j5Zl3FG4tTJgz+TsW0zQua9XXxF6NH4DXU5qrxPsswCWTIFm4RtBshEHTn/Mrtiy/
	JnvYhEhgGFOFLxUALi1PYl7o+Fek7+UEdpmvQqCyVo4D9MBKxsJxgeW0FlgvArJx2DTkrfCTUjI
	oTcws3Flzl+LKwSsSm+BlSfTtvXMUbalzkkH1/zpUwBbhxrueeJ6TKLncrsFtA==
X-Google-Smtp-Source: AGHT+IFYLb/9YylnsTJr3jX+GEPJeWtsUySTuxFWiiHm3CLRYIhVBFlqFBSUC2SxqtxlPq5PCr439A==
X-Received: by 2002:a6b:f703:0:b0:85e:73da:c56a with SMTP id ca18e2360f4ac-869f96fc510mr543194639f.3.1747174158781;
        Tue, 13 May 2025 15:09:18 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fb7abf256csm495248173.92.2025.05.13.15.09.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 15:09:18 -0700 (PDT)
Message-ID: <c120f005-5c4c-421b-8395-2d10870c7a8c@linuxfoundation.org>
Date: Tue, 13 May 2025 16:09:17 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] cpupower: fixes for cpupower.service
To: "Francesco Poli (wintermute)" <invernomuto@paranoici.org>,
 linux-pm list <linux-pm@vger.kernel.org>
Cc: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
 "John B. Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>,
 Thorsten Leemhuis <linux@leemhuis.info>, Justin Forbes <jforbes@redhat.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250513163937.61062-2-invernomuto@paranoici.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250513163937.61062-2-invernomuto@paranoici.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/13/25 10:29, Francesco Poli (wintermute) wrote:
> 
> Hello!
> 
> I prepared a patch series to address the issues reported about my
> previous patch by Thorsten Leemhuis.
> 
> The patch series has been created against the tip of the
> 'origin/cpupower' git branch.
> I hope it can be applied soon, if you agree with the fixes.
> 
> Thanks for your time!
> Bye.

I applied the series for my next pr to Rafael.

https://web.git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/log/?h=cpupower

thanks,
-- Shuah

