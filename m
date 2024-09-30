Return-Path: <linux-pm+bounces-14935-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 321DD989EBF
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 11:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63E691C21C58
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 09:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E59F18873F;
	Mon, 30 Sep 2024 09:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jk35nnik"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D0417CA03;
	Mon, 30 Sep 2024 09:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727690005; cv=none; b=acg+6/cp2vcwxwwe6BXlaIYgDXHP0su3qtluv1pavlUqKwq/cfGTMDL+sehDXdS3WmnRkHLI9/Di6tviFcDbfeN6LOaDeTRY5/3LPh3mlL8dC3FPkRa10eTNLz2007WeTVk9bVy2Y6Q3CY4a3MFc3UXbxOCVxNi87cfunYGI/t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727690005; c=relaxed/simple;
	bh=WwryNFNTrADMEFUUK+4XYSIziZV7c2lL0fLFpgjvOeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G6C8DN08CiJHYYa+gXtftNNTcavcgoTaircHjGx5AYn4wT2smZ0EC12Ga+QaTVCgNP+twA2DDI7qCfP2ylyUKdzFxVit6S3NBqPW68bPD1hFOI2lLn3V00+S5rqkcX29KUUvwjSBtqY4fc/OHFNnSQh8RvWCAle8D4gOMK8k0II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jk35nnik; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-a8d0d82e76aso684245266b.3;
        Mon, 30 Sep 2024 02:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727690002; x=1728294802; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WwryNFNTrADMEFUUK+4XYSIziZV7c2lL0fLFpgjvOeM=;
        b=Jk35nnikQOn+d8kDnV+dvj8HTj+ngfjmToiEJVAEVz6UUVAVjJWpH1BKmPriearFwm
         sVCSAqPTehMjBA+tsasw5QNfUIMB3rS+xmznoM59yhzNA7KADoBCAGnemwF+X/rsy6Zs
         dVmFIIMfsQDalz+5VmdcAWUJ0dPYCOaaIDUKHNi96miaN0w7l0y4U9pCQkEMUdZ+2syv
         XscW/Qds17iKA+bQKJuEpRVkWBxuW9dIjsQ7sGpmq10xj26Si68kw5paAmiphd531BAb
         qaI6ANJDcmJytGvZfdl6SyRRkBgNUzBZhGz0yVte/03GV7MIWEbZI9+6jZwWC2r1mDVn
         U2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727690002; x=1728294802;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WwryNFNTrADMEFUUK+4XYSIziZV7c2lL0fLFpgjvOeM=;
        b=qthdeg8EBEJFIlHs8RrIqIVxuniu5o/faHJ7LDcBtm/qZlzqLpQTYLIXd9A1u0NTUF
         eC2fyJ2Lh9faLWGQNKoEi6I8FFT7E08s1lqqz3KYf62x9r4vjyMcdGLTqbfaWFF3uU7i
         AY3oaKtI8qhrPtajnis3D/94EQ9alCoUCq3qGojLEfQU0oi8R9XwjkaTf8w8BxQLHm8/
         XyyWDzYQ5LN7dTHnjqIltuXaE1/5TJ9OOXzbWRyFf1x6KdhwRsdgUYT74FBTXf/6Vft8
         upk/hvQencSGXY3RP4DeG7NuDLgKFF438hFdRsQRb3NIQubtQfi719b1ajaVEBGHIUQw
         NAFg==
X-Forwarded-Encrypted: i=1; AJvYcCU4cxkoekSJpkMZ5T03BpiFEfRXWrbZmlnK/Nk1JkcHtlmxQ3v1FaimyHRJprS0o8pSTZDaexIL@vger.kernel.org, AJvYcCVjlhoB+1cZw9qkWxE/2snfx43lMkh1MGogj53Q1Je841OYvavBZt7UPqmr61G9f9qvHLx7BTEFzt5sp4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlPzoDnC0oMP/eEMQHGdxG35hEGldqq8TBjqRE63KPRnRxApoY
	nXoV7CAHeTeuKUOllCSBnkIhwwn3q+G/QU1ZOhnEubM+JwBbSJ+HmRIZ3OhxCmqBZaBbLkzxSgf
	G8DxrHlrPysv+ks0sia26ZjWk53o=
X-Google-Smtp-Source: AGHT+IFesu17FMSgHtqPjFAqDx+2j9HupmLvPFbzuG/osg6DHX7YGrWz9BBrfdV/IaFOEJ6v1+i2n+tRLAeTNs09GKc=
X-Received: by 2002:a17:907:7e85:b0:a8d:1284:6de5 with SMTP id
 a640c23a62f3a-a93c49042e6mr1187463066b.14.1727690000776; Mon, 30 Sep 2024
 02:53:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927084145.7236-1-chenqiuji666@gmail.com>
In-Reply-To: <20240927084145.7236-1-chenqiuji666@gmail.com>
From: Qiu-ji Chen <chenqiuji666@gmail.com>
Date: Mon, 30 Sep 2024 17:53:09 +0800
Message-ID: <CANgpojVi8q9kaUsOY9-GGGbKbUe9H_eghqPbDEH1=U=ZZGkfwg@mail.gmail.com>
Subject: Re: [PATCH] PM / devfreq: Fix atomicity violation in devfreq_update_interval()
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi MyungJoo Ham,

Based on our understanding of the code, the variable cur_delay stores
the old value of devfreq->profile->polling_ms. We also agree that
reading from *delay does not need to be protected by the lock. The
reason we moved both definitions inside the lock is to maintain the
original order of the code. We apologize for the misunderstanding this
may have caused.

If the read of devfreq->profile->polling_ms is not protected by the
lock, the cur_delay that enters the critical section would not store
the actual old value of devfreq->profile->polling_ms, which would
affect the subsequent checks like if (!cur_delay) and if (cur_delay >
new_delay), potentially causing the driver to perform incorrect
operations.

We believe that moving the read of devfreq->profile->polling_ms inside
the lock is beneficial as it ensures that cur_delay stores the true
old value of devfreq->profile->polling_ms, ensuring the correctness of
the later checks.

As for acquiring the lock in the caller, we believe that this is not
suitable in this case because it may require introducing a new lock.
Furthermore, the function takes a struct devfreq *devfreq as a
parameter and accesses devfreq->profile->polling_ms, so holding
devfreq->lock prevents devfreq->profile->polling_ms from being
modified. Protecting the read operation with devfreq->lock seems
natural and ensures that the retrieved value is the real old value of
devfreq->profile->polling_ms, which we believe is effective.

Thank you for your response, and we welcome further discussion.

Qiu-ji Chen

