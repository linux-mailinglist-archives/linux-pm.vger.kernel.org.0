Return-Path: <linux-pm+bounces-22058-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E2EA355B3
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 05:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB1303ABC18
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 04:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81621581E0;
	Fri, 14 Feb 2025 04:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="Q0W4gR67"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A5F1519AD
	for <linux-pm@vger.kernel.org>; Fri, 14 Feb 2025 04:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739507000; cv=none; b=l1uiR//lryE5AVHVbt0r5Bo5z9/4IGJByO6Nn/JR0N3dhqq+grLqSrZxiLXtL96WZkOUKYl2NKf/7JDkpJqz9xfF1DgNBqSmHumEOegdjrJL6i0utTYkPTSxgqeIpHrIM6aGupp/0NVdSdDjOnBlt5AbYh1O4U8Qoiwh3cYck24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739507000; c=relaxed/simple;
	bh=jb+PMT2oTp9UYqeR8yZM4e7/uMXYINckOiviDOlRz1A=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=f+6pF2mFkP8uCBGTcRPSnx3qbC2aev5hbFirIvvBwHpzkPfl0x36Ca+dC8Vlm2Wg9qfLGFhfdl8SQAVT9jKARZggEeJG6+/JP5voFFggFYTWnvnQzt+pB2zALsEqQf91++pwNrS5lRcIQSYwnlGScLH19f7mPNeq3QrWmxEoauk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net; spf=pass smtp.mailfrom=telus.net; dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b=Q0W4gR67; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telus.net
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2fa1fb3c445so2411467a91.2
        for <linux-pm@vger.kernel.org>; Thu, 13 Feb 2025 20:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1739506998; x=1740111798; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jb+PMT2oTp9UYqeR8yZM4e7/uMXYINckOiviDOlRz1A=;
        b=Q0W4gR67nKf2wm+qCAFdDLMagxcsDczoysbane4oE7c05iHoVNluFRlmZLQX4YfQPM
         CjtsL2MN6Xm7FVGuaIYx4Lj9y/YnZHQ/1oJaEuBOb96r3rXMOnoQ8wKn1KCRCou7EQdS
         82pOU3znK7YQmR0yEvvLr3aSBdn+P5ITxqi7YyWHfkQ6ykqDHbuINWN4ZkuLR8sMdsCn
         uZvz5xYk2bcwddzeWQnVo1k8bYozyRXIdN4SQ9OxdH3CPvZgyjum24YWh4yVIcLe400Q
         UWJAuGS2UkT1JRT9o4Saa3xFXjAvqSJtRcTzjH1xUi/+mGd7R7BCg0Mwn7g7DHy783Hg
         Emfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739506998; x=1740111798;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jb+PMT2oTp9UYqeR8yZM4e7/uMXYINckOiviDOlRz1A=;
        b=Ildmr17MRik3rJ3ilj15YGRRCJxRQeJXdpLTrTGiC4cbSIgyngi3K8/T+atnLh0uQX
         xoNVncyEpbDu81Q7Bi6O8Bcc+PACTnFD1SkIft+y9DUR2BM4A/BDmOClgFjGMypNdccd
         mJUssTB0qE9xoAcqrzwpZoQwARBUQNQWi6ZFSmdAjSrhLMQ+V2iG8SwBHHvyX6lRbAy0
         orucIYaYMrIQYJJWZHMY7Bty5lE4yfSKthiTqMK9fVpzr9kc0cbn275UKCnhEIml1MGW
         nSh9ntmGBEc8Wu933P6UOoMerD7fgwGdw+P/+PRGfElzcqqbGZZ9mRN46ecIU9OkLfsH
         PHUA==
X-Forwarded-Encrypted: i=1; AJvYcCWgCoeEY8n38WrBYRRkN9/xyjIFeBJfiLLsUePtxRent8nj7AMbE6eUoQZjlEnWNdqOKwZKXx39vw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxS9XdXV5syFlDC4sU7saOXYeH4F8/8QGn3jH/yH7GWOy8OGkZk
	G8ZHFf5V3TjHxnLwIBP77xodRgMrCIGJ7Ry8xTpSO6nhwQOEStdia9hhKQG5+ZM=
X-Gm-Gg: ASbGncul9NHfvT3pEBlKqrnlNVGBU9tlEpz8fxTGu4b3No/qjqBW7O18gaf3CBuctuD
	e7y7T0seu35rPhcek4vTacB7Mp2miR6bTdiVhXo7tx0IoAXNxfMe9xsBS0b4NuxdshefsezLVMH
	C5/nWGOR7G/IfIhltSJqreKaX0qJtCCn6ZYiT/OML3ZcMprSsKkW9U2Q/17UZdyq/2h0ouV/WAi
	PIfXJelO6Ooy8J+J77V8/2SfSE1ZC1MhxzUmXvg4M/vBUiM137PSEwuyORnktdKJbB+ergox3c0
	JOv46A4LhK5POcR9Ll+CgLecTY/bmWluTvTDTjT4N/XE7cGwjOsowcns
X-Google-Smtp-Source: AGHT+IG2QHeQBkVHQWJbFh0rqoGoY4A0Mor/nCLFolUetRVisiO4xlKLSp/ye3TEAmwb/DY4PnwUWA==
X-Received: by 2002:a05:6a00:3d41:b0:730:949d:2d32 with SMTP id d2e1a72fcca58-7322c591b1dmr15819016b3a.6.1739506998246;
        Thu, 13 Feb 2025 20:23:18 -0800 (PST)
Received: from DougS18 (s66-183-142-209.bc.hsia.telus.net. [66.183.142.209])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-732547af8acsm241142b3a.71.2025.02.13.20.23.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Feb 2025 20:23:17 -0800 (PST)
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Christian Loehle'" <christian.loehle@arm.com>,
	"'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
	"'Linux PM'" <linux-pm@vger.kernel.org>
Cc: "'LKML'" <linux-kernel@vger.kernel.org>,
	"'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
	"'Artem Bityutskiy'" <artem.bityutskiy@linux.intel.com>,
	"'Aboorva Devarajan'" <aboorvad@linux.ibm.com>,
	"Doug Smythies" <dsmythies@telus.net>
References: <12630185.O9o76ZdvQC@rjwysocki.net> <8d147f4f-f511-4f44-b18e-2011b0fab17c@arm.com>
In-Reply-To: <8d147f4f-f511-4f44-b18e-2011b0fab17c@arm.com>
Subject: RE: [RFT][PATCH v1] cpuidle: teo: Avoid selecting deepest idle state over-eagerly
Date: Thu, 13 Feb 2025 20:23:21 -0800
Message-ID: <003a01db7e98$2e9ad770$8bd08650$@telus.net>
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
Thread-Index: AQLC2T+pvcOY0U2G0e8FLXneTSytVAHTSa8dsWjejUA=

Hi Christian,

Thank you for trying to repeat my idle test results.

On 2025.02.13 06:07 Christian Loehle wrote:

> I'm curious, are Doug's numbers reproducible?
> Or could you share the idle state usage numbers? Is that explainable?
> Seems like a lot and it does worry me that I can't reproduce anything
> as drastic.

While I am having some severe repeatability issues with my testing,
not for this test.

Please recall my test conditions because the CPU frequency
scaling governor does matter. I was using "performance".
The power comes from the high amount of time in idle state 1.
I verified the idle state 1 power use by disabling all other idle states.
I also have HWP disabled, but do not know if it matters.
If I use the "powersave" governor (driver is intel_pstate, not
intel_cpufreq) then idle power is < 2 watts.

Anyway, my data:

http://smythies.com/~doug/linux/idle/teo-6.14/idle/perf/

> (Idle numbers aren't really reflective in energy used -> dominated by
> active power.)

Well, it depends on idle time verses active time on the computer.
I also measured the difference in the mains power at 20%, from
43.2 watts to 51.4 watts.

I am about to send a long email with all of my test results.
Since I can not seem to function without making graphs,
it has a lot of links to graphs.



