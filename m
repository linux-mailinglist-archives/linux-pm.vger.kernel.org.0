Return-Path: <linux-pm+bounces-38235-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C3348C7166C
	for <lists+linux-pm@lfdr.de>; Wed, 19 Nov 2025 23:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7884F4EE510
	for <lists+linux-pm@lfdr.de>; Wed, 19 Nov 2025 22:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA35302150;
	Wed, 19 Nov 2025 22:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="AAG9rXn0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A33E312816
	for <linux-pm@vger.kernel.org>; Wed, 19 Nov 2025 22:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763592745; cv=none; b=ajtRbG2u8VfL45W3jBGVly0KzanxhWI4h9iixmC0LQGc+HG8tQ3+yMKrB3qpcKEptkOGzHeDFcSlM7Sxx0UMJupTj1G7hf7u1GqT03RCiE5BcEMu/xkQdYoPo0m/DMA2WrLYGOJS5we53jrfEA4UUABQaSSF6S9+SF3M8OUq/ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763592745; c=relaxed/simple;
	bh=ZXvmGem1gwvmXBdBtjwkfC/CUQrpbProwp1nnMC3AA0=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=iV8Zxbntm7x6O4nLbQPCntk7HP7UvZRi4Pli9UEFlgtZkRQbSJDSXetRo3PPXi5asZ8kikK1YVrZQP8PdoO6kxvY8G3o6pAgm7dvUGiTnJG75M2wbO75C3IekPwzAzubCjgI8Ax9mOJFAusAEpIJafpjidGjl6n1GlJbfSWp1Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net; spf=pass smtp.mailfrom=telus.net; dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b=AAG9rXn0; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telus.net
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7bc0cd6a13aso140448b3a.0
        for <linux-pm@vger.kernel.org>; Wed, 19 Nov 2025 14:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1763592742; x=1764197542; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DNOjLlODDT7mgeVset8paaRwwJLENifjVg/m2cEQq14=;
        b=AAG9rXn0nPkX5E0ImJI29UE15roxzmpG0+Xm5dZy95SsTxRpn8RhIYIy3RZmNykI30
         YxAfdbV5JJpR4w8lGf9g0Is0XkoNkVr2bw7dMoJQ3hse/is5HBz+G2QkQjMDTr/srG5Z
         L4mnTerfZyn2DwmYq9h4uW2Ptb1WG8S9vZOP8dJ4pdmQ1Io/L4bRjHJGVqdJIPTM3LYf
         g8HYb2Ysu6Q1Lig80DtafZ+ktgqVHqoign3/6Lt3yXAe0dc2P611+KvFA3xJRTLjrQ7m
         YOqZh0XcrdwrEG/5ymAjgPGhW/IUm74ohJ//r5CENkMleVa44J4naQwvNL0ZdBBGXaT7
         cX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763592742; x=1764197542;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DNOjLlODDT7mgeVset8paaRwwJLENifjVg/m2cEQq14=;
        b=WSrW/KNpjc61YaJuHEnuOvxOaKbhGsW7HGXPEu+wTR2UTSFBJFMseHcUvv+UOITraD
         R6K8hsPsozedTh6GE1CGZ86hBDkbTdwGCNe70ZKb9hyurb19E9x9WmxqMoqJ2ZIjLDTs
         JgtTq23SSfGc47DYWP7bk7rJrQP5yyYpUQ1lfa9Fhy798s9ZsBA+cEtcJsaX+0tWORDx
         UQoxxciaUPfZF5Sh/l4GGLlbuVt65OoB8183/WCSiGsEtPQYDEh3XLX/y67/le6Ttrsw
         s3wyXAhYYfzbOr3r1EQymBWne6LnEgrjF9KCUSuJjLluq9Tw9VMtHJjpNduAkIPiT2e6
         49Jw==
X-Forwarded-Encrypted: i=1; AJvYcCXs/2QlJ2WZJVswdXLyBQquEQVQf5OrcM9STGGOcOpcDS0Aqyo2Tc7qbhfzwXqdcrLKVb9+OqX8lA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzaCXkBOWFt11D4hXOnY7BUJPs5XyR/tZmkzgzOUR/JpVyBxi0P
	/GZpLq79f+jxFvDaTTTJEqHMpUsDtm+ERRaDzv7AFMw87xHisRbAyJEZivIb8spo5U4=
X-Gm-Gg: ASbGncs/9egXilhYiD1PNTyvcNhU50V/FpNccTwD1IfZLnJnhhyRCIu1rViki5qFgoR
	LisGIUGqCyctXrvSkUPB6o7faGsE5Xr5gil5d5hc/0wrrc4LsMG+4mPRc+MRHDauJphl9An8adG
	ybqAUOtwF4cVRxPaIpOOHBpKNAitbBJxzMw1snqV4ErEckGZlZUopxkzHUdOcEHZ2f1RvHrKvky
	jHHNNFNcgyiaAY6A2p7LZF4SRLJPuaIhgfwXYHkap2rxYfjtlIFUG8VzppJT/6QyLaW88juFbcT
	G9aqCqoLjMiSdKxuVXENU0tFpg3VU7feS1xdoVP2pwQQJ9vEeJOg+g3DyTRbABoiKIzyOd4NYOz
	G67udk6InQXWG6uiQ8kIm3WHJOQ+olf7VnXLnVzIDYulhZ96sOm4UOVlBDWEictNtrhApTuXAjz
	gS+B9RxfNr7n4wUAqYZd1nbnQH2GoXSkynq328eLT/7NmNr+6H4jUr9UlVGWQeMZhgGQ==
X-Google-Smtp-Source: AGHT+IEUOVs/PEv+o6VMIvuJWjXWVzpvIID7k6tyED5+QqAJqGBvf++DZDjd+NnQ4+2HkzklC2Q9FA==
X-Received: by 2002:a05:6a00:22cb:b0:7a9:7887:f0fa with SMTP id d2e1a72fcca58-7c41d72aa7dmr310149b3a.1.1763592742480;
        Wed, 19 Nov 2025 14:52:22 -0800 (PST)
Received: from DougS18 (s66-183-142-209.bc.hsia.telus.net. [66.183.142.209])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3ed0751dfsm447524b3a.6.2025.11.19.14.52.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Nov 2025 14:52:22 -0800 (PST)
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Christian Loehle'" <christian.loehle@arm.com>,
	"'Rafael J. Wysocki'" <rafael@kernel.org>,
	"'Linux PM'" <linux-pm@vger.kernel.org>
Cc: "'LKML'" <linux-kernel@vger.kernel.org>,
	"'Reka Norman'" <rekanorman@chromium.org>,
	"Doug Smythies" <dsmythies@telus.net>,
	"'Marcelo Tosatti'" <mtosatti@redhat.com>
References: <4701737.LvFx2qVVIh@rafael.j.wysocki> <69115878-ec5e-4f7c-bb3e-9f61cce75c70@arm.com>
In-Reply-To: <69115878-ec5e-4f7c-bb3e-9f61cce75c70@arm.com>
Subject: RE: [PATCH v1 0/4] cpuidle: governors: teo: Assorted improvements
Date: Wed, 19 Nov 2025 14:52:23 -0800
Message-ID: <003f01dc59a7$2bd98b40$838ca1c0$@telus.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQHuO70FIpoCT8UjwWdl7ErjLgnvJgHh6mEctMfG19A=

On 2025.11.13 07:22 Christian Loehle wrote:
> On 11/12/25 16:21, Rafael J. Wysocki wrote:
>> Hi,
>> 
>> This is a bunch of teo cpuidle governor improvements, some of which are related
>> to a bug report discussed recently:
>> 
>> https://lore.kernel.org/linux-pm/CAEmPcwsNMNnNXuxgvHTQ93Mx-q3Oz9U57THQsU_qdcCx1m4w5g@mail.gmail.com/
>> 
>> The first patch fixes a bug that may cause an overly deep idle state
>> to be selected when the scheduler tick has been already stopped.
>> 
>> Patch [2/4] removes an unnecessary function argument.
>> 
>> Patch [3/4] makes teo_update() to use s64 as the data type for its local
>> variables more consistently.
>> 
>> The last patch reworks the governor's decay implementation to also decay
>> metric values lower than 8.
>> 
>
> Tested-by: Christian Loehle <christian.loehle@arm.com>
>
> Test results below, although there really isn't anything interesting in there.
> teo-1 to teo-4 (patches 1 to 4 respectively are essentially indistinguishable from
> teo-m = mainline)

I tested the 4 patch set also, and also found no differences in results above
repeatability noise levels.

Additionally, I added another patch (patch 5 of 4):
"cpuidle: governors: teo: Rework the handling of tick wakeups" [1]
Similar findings.

Additionally, I added another patch (patch 6 of 4):
"sched/idle: disable tick in idle=poll idle entry" [2]
And found only one significant improvement, for only one test,
but only for the TEO idle governor:

Kernel 6.18-rc4:
For a 6 pair fast ping-pong test (meaning no work per token stop):
teo: 5.53 uSec per loop, reference test
4 of 4 patches: 5.53 uSec per loop, 0% 
5 of 4 patches: 5.54 uSec per loop, 0.2% (noise)
6 of 4 patches: 4.77 uSec per loop, 13% better
6 of 4 patches (again): 4.81 uSec per loop, 13% better
menu: 5.29 uSec per loop, 4.4% better
menu + patch 6 of 4: 5.28 uSec per loop, 4.5% better

Idle state 0 usage:
18% with patch 6, teo
11% with menu
~1% with mainline and not patch 6, teo.

Idle state 1 usage:
almost 0 with patch 6, teo
~6% with menu
27% with mainline and not patch 6, teo.

Power: About 100 watts. Patch 6 and teo does increase power use by about a watt or 2.

Processor: Intel(R) Core(TM) i5-10600K CPU @ 4.10GHz, 6 cores 12 CPUs.

For clarity my branch log:
3993913d7f81 (HEAD -> rjw-teo) sched/idle: disable tick in idle=poll idle entry
d9b12b8d62bf cpuidle: governors: teo: Rework the handling of tick wakeups
e47178c87272 cpuidle: governors: teo: Decay metrics below DECAY_SHIFT threshold
7fe32e411c2b cpuidle: governors: teo: Use s64 consistently in teo_update()
490e6118e45d cpuidle: governors: teo: Drop redundant function parameter
8f627f86062e cpuidle: governors: teo: Drop incorrect target residency check
6146a0f1dfae (tag: v6.18-rc4, origin/master, origin/HEAD, master) Linux 6.18-rc4

[1] https://lore.kernel.org/linux-pm/6228387.lOV4Wx5bFT@rafael.j.wysocki/
[2] https://lore.kernel.org/linux-pm/aQiWfnnSzxsnwa2o@tpad/




