Return-Path: <linux-pm+bounces-29797-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFBFAECC76
	for <lists+linux-pm@lfdr.de>; Sun, 29 Jun 2025 14:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D0C53B0825
	for <lists+linux-pm@lfdr.de>; Sun, 29 Jun 2025 12:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA8D21FF55;
	Sun, 29 Jun 2025 12:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WM9TF5if"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98CC218E96;
	Sun, 29 Jun 2025 12:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751200133; cv=none; b=g9tPMHGKFtMGd2tLD+fjxLQT/LfzvCR/9qNONLJyCl64uzAgWvvOTk/Q0hnHvlPAKGxUsArmGTOYnnhJSvxLBHWcmLChiPJNUgeuVJ+1xUbkRDdnth9JSCnNk8yQ/WumX4hyx9ZK6T1NRccE5JAQhMa13YcxYxqatek4EIgXzEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751200133; c=relaxed/simple;
	bh=FRu2A26eu4KBFJ6l+JTWln5JaWJl7JJQ3Hdp4WXn+Lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ChaE/aJ2ATsvfQVcsHSa/Ldo3VMumEog4KESVRrSsXoJnL4SODhp6QInQk6yfNVSkZ0gI4RErnA8tjnb2mb7/Uq+7y211r2mE6ngAJSBqjBhIa8Em6gaPsITRpbhNF466sytGz8wKZKHPMr6MqKofHXmaTde8N/X00CMylCFgFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WM9TF5if; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-747c2cc3419so3570228b3a.2;
        Sun, 29 Jun 2025 05:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751200131; x=1751804931; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hof9vhiYbQJiRNGLbC7upWUJmQgprv3f9wttuJdIcXM=;
        b=WM9TF5ifq+xILYZF/Fo2VLyDNcBaoIwPRjzADUJHEt7CH6lr/VkhMXNGzHi0BsU03d
         oLXdKd8x8puF6ibUUlua45aehjTRKqlsbjVClB9ILWiG8xh/VgGQsIsqTLE8iqyIhIXR
         QkuKwleHEpGXORO1YukzkcW9KFIYQKhgBZnDe8vT6T86Z6SG3zLPKfbxiJ4KputDeTsn
         YwU7Oof7OS8gx0NIw7S+lRwSHMyGs9XqFDq0VUcerkv4s3PgpTLxGJnOupLKsVvwem3/
         z6hMt4ySRTT4IK2eq8WwQQP1ZpFi797wFAZzulGDIHCX0NFBMfZl3YA3dSdXi5d0gobw
         Rk6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751200131; x=1751804931;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hof9vhiYbQJiRNGLbC7upWUJmQgprv3f9wttuJdIcXM=;
        b=iRFHtlxyiu7jBr9cMgHaX/sRFw6Gqt9F8yz/xif/Fcp6dBD/x5rUm05iVirUFaMTzW
         DhGw26GOzJ2kEnnY58FZzVonHCk2StYU9ngU8tx6OO04rM9VKZBHndIxWBC1eiTvB1IK
         70f923C79UJbcj57k37PgJfAu2rAGHDBOzyQswfIY70OIv1+uRt1hoTZWId2LyLQwQXu
         QOPFQj6nTPdiC+hysUE1n1lNm0jYsue9BZfDH2ybXXZGtc2kGeMRvQ1XcAZPraO+CKoe
         KSb64Q3sRvzO++f9uje0n9d/l3otexewgdrkT3Vx+SyHFQsuFHDWpRQZnClt/K1F803N
         Kg8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVKvS1oJwqxtzSfOcecXYzv647F7tyKTAM3Y4PCyrNCILPRGO7iQHFSELNFoll3xrzXhUpQeD6UOw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yysyx3PKeFfWo1JW8zAzudFIbGOhq0JGZdGJDq87N7Vu8zuoyi5
	kkJcX+POTzG3xcx0rlsiqqFx2J+TD6o/fSwKi5wFGC4MrliHKo8X3/VD
X-Gm-Gg: ASbGncs3T9/tT6R6cpxclyJfrXHzYp9VdK2il6aE0FAA/G9tL71FYv8yuP9DkbZCqRJ
	s4oWOlJJkOogmZirKC6mbUF2c5RDL23V7c+YSR5Fb9yAjpAYxiPVihRcAfIvM+CcdabQU954H61
	eJIj8Bbl7m9Jhp50SC+/H12XU2r0/+GRSRiRVNWCwWahz88e73mTbjIHynhfWpPbOydOBQ1apFm
	UV/cQON1Bh+fenEZ1T7mjGsrAUj1ymKl0e0ZyVV5NOTKgfeUS1l8U9DBtv1ijj2fjTPzxvFzPzB
	OV7ZQ2Mup7RaQHpAGCGMidxfRhQ1V00syR3//bH6RnCpS8xjY7ENgkCWxjBigIImNiCsyDkbxAe
	t
X-Google-Smtp-Source: AGHT+IHddfP/qfIqQ/Pq52wae/6r2Lx0bNCOsgAf+8+GNhKSX/5lqk384njvGbup7RDGk3HumHixQQ==
X-Received: by 2002:a05:6a00:3e17:b0:748:33f3:8da3 with SMTP id d2e1a72fcca58-74af6f2f9d7mr14770731b3a.19.1751200130818;
        Sun, 29 Jun 2025 05:28:50 -0700 (PDT)
Received: from [192.168.1.168] ([106.215.181.119])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af540b25dsm6369758b3a.25.2025.06.29.05.28.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Jun 2025 05:28:50 -0700 (PDT)
Message-ID: <a27c8ef8-9b80-4749-a64a-0389c266fd0e@gmail.com>
Date: Sun, 29 Jun 2025 17:58:44 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] cpufreq: intel_pstate: Enable EAS on hybrid
 platforms without SMT
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Pierre Gondois <pierre.gondois@arm.com>,
 Christian Loehle <christian.loehle@arm.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <2999205.e9J7NaK4W3@rjwysocki.net>
 <CAJZ5v0jLpKEgAodWx8G0k127vMUe-J1rGkCEreRP7a1dQXT2vA@mail.gmail.com>
 <CAJZ5v0gcgMJ-qihgc3_OF4djxAy8K0i-cmnjRe4AQrc_YEu4DQ@mail.gmail.com>
Content-Language: en-US
From: Ibrahim Ansari <ansari.ibrahim1@gmail.com>
In-Reply-To: <CAJZ5v0gcgMJ-qihgc3_OF4djxAy8K0i-cmnjRe4AQrc_YEu4DQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 5/13/25 19:31, Rafael J. Wysocki wrote:

> Finally, schedutil needs to be the cpufreq governor which requires
> intel_pstate to operate in the passive mode (schedutil is the default
> governor in that case).  The most straightforward way to switch it
> into the passive mode is to write "passive" to
> /sys/devices/system/cpu/intel_pstate/status (it may also be started in
> the passive mode as described in
> https://www.kernel.org/doc/html/latest/admin-guide/pm/intel_pstate.html).

I'm curious if you intend to bring back support for EAS with 
intel_pstate in active mode down the line?

That would get this working out of the box across distros, since 
`intel_pstate=active` is the default setup everywhere (and typically 
what users should prefer? as I understand from the documentation.)

Thanks for your work!


