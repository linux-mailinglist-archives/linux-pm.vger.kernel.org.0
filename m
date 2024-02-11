Return-Path: <linux-pm+bounces-3761-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B7E850A5A
	for <lists+linux-pm@lfdr.de>; Sun, 11 Feb 2024 17:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0C711C21C4A
	for <lists+linux-pm@lfdr.de>; Sun, 11 Feb 2024 16:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B455B669;
	Sun, 11 Feb 2024 16:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="FwWBjo4D"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFC359149
	for <linux-pm@vger.kernel.org>; Sun, 11 Feb 2024 16:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707669839; cv=none; b=J9oL+rECIjyjv9wMBpO5+DKx2A4vz33wPX3U7/EkZTIbCWTeSb8KFQnuTcl+CsTM6JrvLszySbMCJB3CzqFuscr7zr3+O3diagUqzu2qW/T613bXAoL+c7j8FW9x/4PKvjIhAlsq2gKnvSbW/6G5Pt4yYQ75BUMKMev6bO/SmUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707669839; c=relaxed/simple;
	bh=IUsuXjX03NWMrGdlBVw/b0WIQxpF85sr152/0Pzn9ZM=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=NLcb3V/fTwrbx1SsKyykHmfWaHv9M3B+Ny4qsZtC0un7/c82RU704H6jyJbNQ45n7q7eRzl94awYZVkgJl+oIxK0L71jLufIJM5QF2z5eUzoopZ0DAxHMC8erECoTtH+mZDmezYehrEdm4H9JLxvuQqhYt1Bf1sJgaybgEaVCkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net; spf=pass smtp.mailfrom=telus.net; dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b=FwWBjo4D; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telus.net
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-59a94c0fb55so1351875eaf.0
        for <linux-pm@vger.kernel.org>; Sun, 11 Feb 2024 08:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1707669836; x=1708274636; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=IUsuXjX03NWMrGdlBVw/b0WIQxpF85sr152/0Pzn9ZM=;
        b=FwWBjo4DiDCQQ3+EledAZOY9Qc21srVdj8stoNghQjeJAGZSWh+Y605QnrZiyYLSrq
         LCULw8OrRM2anIckhc1j8D9h3jf7jDdAMV/XA5DDOU2mZtNLNnG+pVQphAAhb2TVXvuJ
         r+0mTTP3t2S4K7vnX6CV7CUBjV4+ASvjTCMiK3GL9ANy2I+ss9ehae0494HD9vBgnj1q
         V7rPyhM6Jc2ywgLYlAlzCzZCKnnF4Kg98sJwQRUQ4m8berbHWnhhR3coWXNE9e/aoA8j
         Ld3baxIhFio06QQFarAAVuxsr1jQMxeKO415K5KveMLkwkGA7DCfpp5OK1d8nlI12HHf
         xBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707669836; x=1708274636;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IUsuXjX03NWMrGdlBVw/b0WIQxpF85sr152/0Pzn9ZM=;
        b=kOQ9vxq36WrYzkWcdNuC4MHIdoGb3DAzBtAcGFdZDnbKbUFGghbLz7nbbgB7EKd3qy
         sXTriqO8tuWpreyX05rG7IMwE87KeCQL51XUrU9MYYnqJyyU0Qgfjumx+5CBjiDKG8Bq
         Y3tmSj3TuugPuKh6zBItRKUPB3Vw+tL0MfZ3LQXKf/PaIdN2NaYDsyvmz/oTIDt0ta22
         sOW6jLFJi3Cl/2Gz/636+waZjwloEC2qXIpTJt//MOVPg5F9mT8jBVUHODvznF7vw3nE
         oC0pCdhYq/5gGwsSJgWaIXlrgR0DHH033Yfg+wXvpvHTfE5wFOiSvmM4U5g4YZXwu+o9
         NhfA==
X-Forwarded-Encrypted: i=1; AJvYcCXOU00Pwxxq6mn5Qup2B0CUk79Rbb4g0vmJTHtpKrSjKV3Mbm2EYwhwH2uoZIEQRq3+YkHbnP5dLHOmjxlkIeG3xD2kIy4tgkQ=
X-Gm-Message-State: AOJu0Yz2AsVbuL+jaa0N6ZrllBmpUZME1TjXj9GiWI53W5RLnPxUOqYq
	L4vTqLgpGn86S/Xh58Hv6IfmqPrTj52mVAgjrDJUbmtzuPo94Ht+YuKx+OygtTY=
X-Google-Smtp-Source: AGHT+IH+tY7O6WFeho5VnKia8cngNwgyEbGjks7wJwe5NBKvAhQK8uMFWgK7Gf9pOFFoEejPRTeWgA==
X-Received: by 2002:a05:6358:199e:b0:176:5a5e:4bf9 with SMTP id v30-20020a056358199e00b001765a5e4bf9mr7844088rwn.22.1707669836539;
        Sun, 11 Feb 2024 08:43:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXewZJOIg0FJAFqMImWK4z50DpnckeNc80B+nFTY9O0XMLKaT35n0FyWTxi4rtkQLcFj15j7xZFZxap6rB7UR7583aoC+Uuzy7KNIrC7uUEGmlJGedBkcelNGabjQ0RvmKHrAKKF7K7sCVdDRWr4nbYiu2rJ2GyvgdwBEVKNJjTXkHGV4rXaGEhQ1ezh/Ca
Received: from DougS18 (s66-183-142-209.bc.hsia.telus.net. [66.183.142.209])
        by smtp.gmail.com with ESMTPSA id y20-20020a62b514000000b006e08da9c29csm3927793pfe.54.2024.02.11.08.43.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Feb 2024 08:43:55 -0800 (PST)
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Vincent Guittot'" <vincent.guittot@linaro.org>
Cc: "'Ingo Molnar'" <mingo@kernel.org>,
	"'Rafael J. Wysocki'" <rafael@kernel.org>,
	<linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	"Doug Smythies" <dsmythies@telus.net>
References: <002f01da5ba0$49cbf810$dd63e830$@telus.net> <CAKfTPtA-jizig0sh_shmkAMudAxDPYHP0SdanZe=Gc57jVKouQ@mail.gmail.com> <003801da5bae$02d6f550$0884dff0$@telus.net> <CAKfTPtC7pOtb-srrgQLFbTueLLDqHay+GQBm9=sNsnZDg_UYSQ@mail.gmail.com>
In-Reply-To: <CAKfTPtC7pOtb-srrgQLFbTueLLDqHay+GQBm9=sNsnZDg_UYSQ@mail.gmail.com>
Subject: RE: sched/cpufreq: Rework schedutil governor performance estimation - Regression bisected
Date: Sun, 11 Feb 2024 08:43:57 -0800
Message-ID: <000b01da5d09$8219f900$864deb00$@telus.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQHymzO4ho/iLx8gQfQ33x85MlP38AE230H5ATs9P70BGBlhK7C4e+GA

On 2024.02.11 05:36 Vincent wrote:
> On Sat, 10 Feb 2024 at 00:16, Doug Smythies <dsmythies@telus.net> wrote:
>> On 2024.02.09.14:11 Vincent wrote:
>>> On Fri, 9 Feb 2024 at 22:38, Doug Smythies <dsmythies@telus.net> wrote:
>>>>
>>>> I noticed a regression in the 6.8rc series kernels. Bisecting the kernel pointed to:
>>>>
>>>> # first bad commit: [9c0b4bb7f6303c9c4e2e34984c46f5a86478f84d]
>>>> sched/cpufreq: Rework schedutil governor performance estimation
>>>>
>>>> There was previous bisection and suggestion of reversion,
>>>> but I guess it wasn't done in the end. [1]
>>>
>>> This has been fixed with
>>> https://lore.kernel.org/all/170539970061.398.16662091173685476681.tip-bot2@tip-bot2/
>>
>> Okay, thanks. I didn't find that one.
>>
>>>> The regression: reduced maximum CPU frequency is ignored.

Perhaps I should have said "sometimes ignored".
With a maximum CPU frequency for all CPUs set to 2.4 GHz and
a 100% load on CPU 5, its frequency was sampled 1000 times:
28.6% of samples were 2.4 GHz.
71.4% of samples were 4.8 GHz (the max turbo frequency)
The results are highly non-repeatable, for example another sample:
32.8% of samples were 2.4 GHz.
76.2% of samples were 4.8 GHz

Another interesting side note: If load is added to the other CPUs,
the set maximum CPU frequency is enforced.

>>
>>> This seems to be something new.
>>> schedutil doesn't impact the max_freq and it's up to cpufreq driver
>>> select the final freq which should stay within the limits
>>
>> Okay. All I know is this is the commit that caused the regression.
>
> Could you check if the fix solved your problem ?

Given the tags for that commit:

$ git tag --contains e37617c8e53a
v6.8-rc1
v6.8-rc2
v6.8-rc3

It does not solve issue I have raised herein, as it exists in v6.8-rc1 but not v6.7

>> I do not know why, but I do wonder if there could any relationship with
>> the old, never fixed, problem of incorrect stale frequencies reported
>> under the same operating conditions. See the V2 note:
>> https://lore.kernel.org/all/001d01d9d3a7$71736f50$545a4df0$@telus.net/
>
> IIUC the problem is that policy->cur is not used by intel_cpufreq and
> stays set to the last old/init value.

Yes, exactly.

> Do I get it right that this is only informative ?

I don't know, that is what I was wondering. I do not know if the two issues
are related or not.

> Normally cpufreq governor checks the new limits and updates current
> freq if necessary except when fast switch is enabled.

>> where I haven't been able to figure out a solution.

>>>> Conditions:
>>>> CPU frequency scaling driver: intel_cpufreq (a.k.a intel_pstate in passive mode)
>>>> CPU frequency scaling governor: schedutil
>>>> HWP (HardWare Pstate) control (a.k.a. Intel_speedshift): Enabled
>>>> Processor: Intel(R) Core(TM) i5-10600K CPU @ 4.10GHz
>>>>
>>>> I did not check any other conditions, i.e. HWP disabled or the acpi-cpufreq driver.

Changing from HWP enabled to HWP disabled, it works properly.

...

>>>> [1] https://lore.kernel.org/all/CAKfTPtDCQuJjpi6=zjeWPcLeP+ZY5Dw7XDrZ-LpXqEAAUbXLhA@mail.gmail.com/



