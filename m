Return-Path: <linux-pm+bounces-13597-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DB296C12B
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 16:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32C30283F1C
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 14:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98F639FFE;
	Wed,  4 Sep 2024 14:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="GZNggFPC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367321DB53B
	for <linux-pm@vger.kernel.org>; Wed,  4 Sep 2024 14:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725461373; cv=none; b=ZI1kOh2nv704fP8ifWzBdFP5jGvksUYP70yWK0C5eKspQabU5tQD82V2WRDhK9QfWyLVYTrIAbb+W69L+U/l8/zfJHeeb4hpK+muAqNHyAIFIweJWLX9ucVuLK1TdpUs0ySAJGhtMlJ+KMm9uXuRQ+axaFWaYl0kAmwp5EMEKjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725461373; c=relaxed/simple;
	bh=cBtG1mGQoB1mZs6kdcgoRPisL9P5R/ZmOfxaKD8RhiI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=gKPkC1xcBipOThRyu7FEOxOU8v8o6UNm/tTCxvgNmelHTozRy4/Th41doGrC7x6eZy1l56Pk78uEvADHI/0lB6N5CkUX1uKDRF/YdlzYTp81F/di5kcdU8C9P+8AiYGzhtoBMih6dRNGPiGn57VEy6jWb9aqz8+l8Bibe932sns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=GZNggFPC; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-82a29c11f05so232740739f.0
        for <linux-pm@vger.kernel.org>; Wed, 04 Sep 2024 07:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725461371; x=1726066171; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gg/6+bOeg22R6GFget1feB6uWX6QELmDRdwKsUWQSdA=;
        b=GZNggFPCEi//CWkjBoXW/XI6gYIvD4VzKtpA1DTS45gjk2BGs7IbmndNczYXAuojX+
         iJh5nLeEf6twpDicyGMck+eKzAL74hn16fUghvVKeLq0Z+uXO9SG4ALF26wTo/XVdAoK
         Fz8SX4+gyByIoDiS127s//6wuLaszhHpGsDnQ0GNTY2RB8h8Hxwwy0Tl89JQDcqbL61H
         g27ObFsCxs2emj/mCf5tA8liQCQ+17jqvDCUAWKsJDAsDx66LSvXO1g8alUxIND1+U4j
         nFYr2SosV090vcMoCuwhuEokjujuzUA7Rm/J3HNsqIDEL95BR1m34lwh8kbuyld2PKGg
         r+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725461371; x=1726066171;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gg/6+bOeg22R6GFget1feB6uWX6QELmDRdwKsUWQSdA=;
        b=jMpkx0v9nTWb8UsfarzDHkInQ5Pqnk/qGd9rfU9Z0DTYAiclbu3mA+WWSIGaet9ob6
         ZNYBuRZ6qeOapEZYRJGsB7/RM4DZB+WYytx0M7zJ+iVulMwfHgDXGgKrLHIGLkfKQjhr
         uz7IToN6iVl9LQSMHJv4nKaVBEBIVZhsjCR7OkrnVS7505cQ2HsbR0FxAyEERqPKcsnt
         ZZ7xA9CxKDFmU7CO2l+OO/eIbD3BVyKkxGgFja/jXGgF2noVRYz8mB//JgOyeMSNcKck
         //101dA4Ijrv0nICM+kPqLH1iopbtMs+nqH/vYFxqdNqC2nBvfs9AYpmHV6h+G/SpY7S
         tqQw==
X-Forwarded-Encrypted: i=1; AJvYcCXvXmvhJwaFJGFkI1uNlFDWe5gH4KaFRyZydRDZlX1sed6IG2X0g4mdVjUD6YM5qh8eg8Se3EkomA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYM/i/P4AVNioOvA9ZUswVsuooQ7ziQTZRSSZ/TM6IOSmCNBHG
	9GAcd6POg7hZhdLLVJvd8CdBM49zoOEtNjy6AbkPuR/uAZZ5/XvVdUYugHvDl+0=
X-Google-Smtp-Source: AGHT+IH8k7vfp320rD77eC2+5M59WBgRyP+qCZblSu8VWx7cqNHs3tkLg51MBXFEtHpGgqQnrjEggQ==
X-Received: by 2002:a05:6602:26c7:b0:82a:1e96:bce5 with SMTP id ca18e2360f4ac-82a1e96bd72mr2961475039f.10.1725461371276;
        Wed, 04 Sep 2024 07:49:31 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced2de7b11sm3084201173.70.2024.09.04.07.49.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 07:49:30 -0700 (PDT)
Message-ID: <4f804d53-6f6c-402c-b8db-db6ab8161f11@kernel.dk>
Date: Wed, 4 Sep 2024 08:49:30 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET v6 0/4] Split iowait into two states
From: Jens Axboe <axboe@kernel.dk>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, rafael@kernel.org,
 daniel.lezcano@linaro.org, linux-pm@vger.kernel.org
References: <20240819154259.215504-1-axboe@kernel.dk>
 <20240904142841.GL4723@noisy.programming.kicks-ass.net>
 <30eeae06-0d8a-4968-ba57-d723162a0782@kernel.dk>
Content-Language: en-US
In-Reply-To: <30eeae06-0d8a-4968-ba57-d723162a0782@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/4/24 8:41 AM, Jens Axboe wrote:
> On 9/4/24 8:28 AM, Peter Zijlstra wrote:
>> On Mon, Aug 19, 2024 at 09:39:45AM -0600, Jens Axboe wrote:
>>> Hi,
>>>
>>> This is v6 of the patchset where the current in_iowait state is split
>>> into two parts:
>>>
>>> 1) The "task is sleeping waiting on IO", and would like cpufreq goodness
>>>    in terms of sleep and wakeup latencies.
>>> 2) The above, and also accounted as such in the iowait stats.
>>>
>>> The current ->in_iowait covers both, this series splits it into two types
>>> of state so that each can be controlled seperately.
>>
>> Yeah, but *WHY* !?!? I have some vague memories from last time around,
>> but patches should really keep this information.
> 
> To decouple the frequency boost on short waits from the accounting side,
> as lots of tooling equates iowait time with busy time and reports it as
> such. Yeah that's garbage and a reporting issue, but decades of
> education hasn't really improved on that. We should've dumped iowait
> once we moved away from 1-2 processor system or had preemptible kernels,
> but alas we did not and here we are in 2024.

Forgot to mention, it's not *just* an educational thing - lots services
of services do mixed network and disk IO, obviously, and they do have
some interest in retaining iowait metrics on the disk side.

-- 
Jens Axboe


