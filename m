Return-Path: <linux-pm+bounces-15477-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 206D6999217
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 21:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBF87B22404
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 19:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD3219F423;
	Thu, 10 Oct 2024 19:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YTbemSpm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807CA193407
	for <linux-pm@vger.kernel.org>; Thu, 10 Oct 2024 19:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728587369; cv=none; b=ldWoUksChsu25xeP0ZHxd52zlugFWw9EZBC90aXSFHlFn1bImWDSj76WW41SR+S32gZ4HQYDR6mfjzQAMXOprOtUujjczXHzrCpB1liWzUvpYgDcY1TjrlmXXNgEqwVx18ltW9bsGAwamhl9/kfkI/v5FDDN1CwZ5a2gQ9gcUi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728587369; c=relaxed/simple;
	bh=ac6ljY3jWue+JCbfCVb6wSZv8qSlyjP95ceg6pd5Fow=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=guaikiUEGNFhJpaHEX99fhY41IVmh+LK5QYtKb6NaNfb42Vz29kk/AEhJyyvlc4jVBQ1ZCxnSHDzmbQG0agokYVahiYFgeaUP9zZrFlAkadgnVG0JZ/yBNQfNujiafEe1M+bjZnhbmuHX+aZ2afX0t1ANToSWAbt57GYrkNiUg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YTbemSpm; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7e9ff6fb4c6so1601439a12.3
        for <linux-pm@vger.kernel.org>; Thu, 10 Oct 2024 12:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728587366; x=1729192166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kUOCohKNjMU4hf67Hk3xoSE5aNrSSgkCEQQwEX9Kx4U=;
        b=YTbemSpmvMXAViduHiXVeKqjt11JKQe6uEzu24oLFgZOdLzxgmthmwrjWpzIkM079K
         jWexmUBk+f3TyXuynIu7OSIVWAFNrD/yUECnxeCjhU+1Tmia9rY76gIVMpF4uRAAOpiT
         bmrAnF72FLSfvaDRtHrZVKklXxzssly3EX22a0g8aIGa4whgUddz7uC2b1ykDKrKQ1f9
         ADazB6NLyhCdp+lgoGjAoCcnnlXGsdQUv51hBfdsxhzoMhBvGTzGvheOuA28zUDlVKiE
         okZpo2prFKUMe6vAxt6zDt4DEe/3LZht+OhlhxmkDlgXEtsgXLNenTHdoB2DekRL/sOt
         cfmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728587366; x=1729192166;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kUOCohKNjMU4hf67Hk3xoSE5aNrSSgkCEQQwEX9Kx4U=;
        b=JDlNBPtsNlphH46DvyRfHNBgVvAwFqvdnrPUBaS3oxLPGyWbGc3/ky2KF27UOnZ+Xa
         AuaoEYNNnLhPIlmWO+dRtww3xR5RJSE8lf+fwb5tHWQw6U7k1KuTtVSEQBicZbmoVDXX
         +xNSkuGNvycAp6Slk04MVhtD8Cxnt9h8F4ujP5zLvI1a4x9Kgm8F3ESpGrg9O9AIKqre
         W0pzaVN9yjfZHm34D2nFpvrTfMXLsAD2egr7DdNa6f8ZvxkMjLT4CdSLVJ6p9U/JP3SP
         8TTUuO9dLVmlJw0ysD+1ghUnmGVFt3BjmFakY/OtwAIuBNszu9Mahdi3NPsdoymYDC2p
         FRZw==
X-Forwarded-Encrypted: i=1; AJvYcCVf9gZjefPtmtE+BMKSCJ//zXi1VQSz+0KYu5nwmZGp5D2kitm9BPH/RQIGzSH6OGP0XLMPhdQiug==@vger.kernel.org
X-Gm-Message-State: AOJu0YykfD2P25boCzw5NANPSbzZRMHd3y4u6It4wR39tzgqNfFeSpMe
	kWy/dRnXGOZDYPztS5LQYkJzoUKbykcgqkO97ZB0soEKJrhQgNnp3HkFwNYV28c=
X-Google-Smtp-Source: AGHT+IGQzanRV34lsOMIrO/8sNdsm8HVw9iYzX+86moGK24wjNpnNirVGSnTQpSGHJrtPDM4ekMUAA==
X-Received: by 2002:a05:6a21:118a:b0:1d6:e197:ae49 with SMTP id adf61e73a8af0-1d8bcf07936mr49510637.8.1728587365719;
        Thu, 10 Oct 2024 12:09:25 -0700 (PDT)
Received: from localhost ([71.212.170.185])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea449596d3sm1321625a12.61.2024.10.10.12.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 12:09:25 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Saravana Kannan
 <saravanak@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd
 <sboyd@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: arm64 s2idle vs. workqueues
In-Reply-To: <CAJZ5v0hTYkR64x_h5_Qn_J6k=seSZ=eKqdNKEC+UzkQMe1wC1A@mail.gmail.com>
References: <7ho73shkrw.fsf@baylibre.com>
 <CAJZ5v0hTYkR64x_h5_Qn_J6k=seSZ=eKqdNKEC+UzkQMe1wC1A@mail.gmail.com>
Date: Thu, 10 Oct 2024 12:09:24 -0700
Message-ID: <7httdjyduj.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Rafael J. Wysocki" <rafael@kernel.org> writes:

> Hi Kevin,
>
> On Thu, Oct 10, 2024 at 2:19=E2=80=AFAM Kevin Hilman <khilman@baylibre.co=
m> wrote:
>>
>> Hello,
>>
>> Looking for some pointers/tips on debugging s2idle, and in particular
>> why it is not staying in an idle state as long as expected.
>>
>> I'm attempting to use s2idle on a 4-core, single cluster ARM64 SoC (TI
>> AM62x), which doesn't (yet) have any DT defined idle-states, so is just
>> doing a WFI when idle.
>>
>> I'm doing an 8-second s2idle with RTC wakeup by using:
>>
>>   rtcwake -m freeze -s8
>>
>> and what I see is that 3 of the CPUs stay in their idle state for the
>> full 8 seconds, but one of them keeps waking due to the A53
>> arm_arch_timer firing, and processing misc. workqueue related activity
>> (example work listed below[1].)
>>
>> I realize that these workqueues are not WQ_FREEZABLE, so I don't expect
>> the freezer part of suspend to stop/freeze them.  However, I am a bit
>> surprised to see this non-frozen workqueue activity happening often
>> enough (few times per second) to prevent all 4 CPUs from being idle for
>> long periods at the same time, thus preventing a deeper cluster-idle
>> state.
>>
>> Is there something else I'm missing that is needed to keep these
>> workqueues quiet for longer?  I had assumed that most of this workqueue
>> work would be deferred, and shouldn't need to wakeup a CPU just to run.
>>
>> In case it's helpful I have published a trace.dat from trace-cmd which
>> captures power, sched, irq, timer and workqueue events.  With
>> kernelshark, it's pretty obvious to visualize what's happening: CPU0,1,3
>> are all nicely idle for 8 sec while CPU2 is waking due to the timer and
>> workqueue activity.
>>
>> Any pointers to how to improve this situation, or what else needs to be
>> tweaked here would be greatly appreciated,
>
> It looks like tick_freeze() is not called, which only happens in
> enter_s2idle_proper() that is called from cpuidle_enter_s2idle() if
> there are any idle states with an .enter_s2idle() callback.

Ah, thank you for the pointer, this is indeed what is missing.

> So does the cpuidle driver for this platform provide .enter_s2idle()
> callbacks for any of its idle states?

Unfortunately, no, so that explains my problem.

Thanks,

Kevin


