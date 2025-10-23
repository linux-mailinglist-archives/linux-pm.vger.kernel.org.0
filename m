Return-Path: <linux-pm+bounces-36684-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F136DBFEEE6
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 04:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D418E4EB8A2
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 02:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4208207DE2;
	Thu, 23 Oct 2025 02:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="eBG5n+nH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16AA8460
	for <linux-pm@vger.kernel.org>; Thu, 23 Oct 2025 02:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761186252; cv=none; b=R3FBkfGKKKSbEKPacGX3bjOSmYCwh5Mxqu77lqyeoKZasRZsRXx++/SgTjrNIK3S4df/66X9pwgsmbJMtfBr77e/KqMaPYx1JeNk7ZnOAo2gEG/+CHHlg4V87qHCoeQ8YpNECDDLMhTln9iESArAvuc0jU6rMaJnh64RHDXwLVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761186252; c=relaxed/simple;
	bh=SVr30Gy0yl93FUQ9VNPO4a87bKc+DSCWdirStpeVB+M=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=gMeRs52QkE8VKKc3D1WvyThmwwqz4N+AGWQX5RTCLOt04Y7qu9il/Obe5HnqTuAT9NMsng6xZQibqlhsoXoNjyrnZn4c8FZ2VjwOF1PBzGk8HR/lgxb2iqqll6LMhGEKa37ztV0QMgjl0zKsobYpNPhA/zd4wUCLj8CB87Zg2IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net; spf=pass smtp.mailfrom=telus.net; dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b=eBG5n+nH; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telus.net
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-78125ed4052so397650b3a.0
        for <linux-pm@vger.kernel.org>; Wed, 22 Oct 2025 19:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1761186250; x=1761791050; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hPrl+g8MWZLVjr5+X7xKR8IPIJl3i65GUuqXDZ4/RcU=;
        b=eBG5n+nH9zJ95Fzn+R7fnOhg9otrS9AMVa1A/fHAUzn23pY1VozDCsXiKOZkx9EGnq
         ZoiiijFynTJX5wEoaP/2pIFr8WN+VYve8GE709kK8X+REdW69dbyX32Qi2jo2nz9Q1Ns
         +4drH3zC74JcgAuemPQTILk0cxNxuWbjGUK7cuahIeh28G/edeiW5mb8DPr1MQ2VOHOL
         0HHfuckhu3MOoF8teCW1nKnfWroEOnxfCrpeA2l84qJL4P5cDK/3OyYXMSwaePh9Vq9F
         8iPLzttBU8HowRjQQcd8GiuV6LddHTqIobrs1dqqyn36itVfEBxBvb6IHDfj8Fy1Zgso
         qSsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761186250; x=1761791050;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hPrl+g8MWZLVjr5+X7xKR8IPIJl3i65GUuqXDZ4/RcU=;
        b=PGbUX/28La//hlQmIIb0+luBdc732nym5jacSg74ltpfLC6/+DIq8ZG4XkZ2Lo+rGY
         QP1NF5maer44iftWR5c7VazngpR8zAKUSg6BzbUR1xqo5JQfwVCDdxhq7K4kR9a+Lcy0
         HqKDFRsjfCrgwjHWAKLUYGEaPlKwDmlsciyYEQoLm75Fl1HNc+kYdut+54Z7MwEXVTAP
         hiToIU0U2SbbEuC6/LPyqWqDx9apSZD5czNt6bcllmLK6WKup/m+gd5TvArx/xnY75Pf
         m44ssRI2Lz8he9Kmce55t6x0bblJ4FSNuRScQjxiyu3o4b5fYbxIrTDKrkxW6o7Bgmdo
         h6qQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5FOikyckRbE9BfzGJAzuRly94Hmo6Qpq9DHcyZl8laLiUAH5CJsmHngyrZhnLfOY2bNT5kqj+1g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo5OocSDLVmD7bk3lvQUrwDlC7yaB8nvnrLgu4R8yjU4/OWn+c
	997z4HU/664CKnFZWPmI3+HwHtiGtJK/gXiCmPG4R9DpmwcNFUrOcLzmmyDDvczBtOs=
X-Gm-Gg: ASbGncsYHyGxkP1rHHOd+R2EkFBjN1a1tkdwIZQ+S0LJVplEZfeY5rpyUbChaOteTZ4
	H7Ttl2yDczhJid08dDPby0PUdS6kHcDQSpHtFZhOAi+mqFSlFbD4PuqJOTJRxa/o6gkfkRn26jP
	rMzLdW99wLgsjTmDlD88NrV3y9M3ChpO0CMUx4sMH1A20RDdzqprXlsrEF0kc+RlpAlyTXlikVL
	J8p2FNDxEdZK3bMmYk419phN5A3DyELwkIosjEbVmtQhDNAoarvGCyt/X6mnA9v3dgVRPmQjce/
	/PQ0CuuxWzZfOyFHsFRkLgkhA7L5E3mH7NkSEquM7sNJSY+NmgcF1fhWGnhUbnu2Wehh1WTG8nw
	fNLIYtI5mjY2fn+0td6RVEcpAUsPpdlQIdjy5TcUQtsnfQextBgV7/d+w35gavMJMOJsMeVeNty
	0OGY/f22L3edY+ICoCSLQJ9GEdvaBK/PaVjt788kKCUQp4stif8gCmLPc=
X-Google-Smtp-Source: AGHT+IFwycBqDK/MPavB8G4BR9E3C2atxDC6Fo7M4NKNuTfl2rx4e6P8+xg4h4rSnxEx94PbV5suKA==
X-Received: by 2002:a05:6a20:a123:b0:324:6e84:d170 with SMTP id adf61e73a8af0-334a856d518mr32518220637.15.1761186250263;
        Wed, 22 Oct 2025 19:24:10 -0700 (PDT)
Received: from DougS18 (s66-183-142-209.bc.hsia.telus.net. [66.183.142.209])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4e12d6asm488383a12.21.2025.10.22.19.24.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Oct 2025 19:24:09 -0700 (PDT)
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Sergey Senozhatsky'" <senozhatsky@chromium.org>
Cc: "'Rafael J. Wysocki'" <rafael@kernel.org>,
	"'Christian Loehle'" <christian.loehle@arm.com>,
	"'Linux PM'" <linux-pm@vger.kernel.org>,
	"'LKML'" <linux-kernel@vger.kernel.org>,
	"'Artem Bityutskiy'" <artem.bityutskiy@linux.intel.com>,
	"'Tomasz Figa'" <tfiga@chromium.org>,
	"Doug Smythies" <dsmythies@telus.net>
References: <4687373.LvFx2qVVIh@rafael.j.wysocki> <5f0aa630-b30a-44c4-a52c-e08179cd3bf9@arm.com> <CAJZ5v0gBtv0bpK2swkc6D0AmanpKAvqO53dgRp2e7p9cWAM3TA@mail.gmail.com> <28ecb23b-ecee-409a-9771-24f801081d07@arm.com> <CAJZ5v0jMoEVUaYYPx6EtHFxsg6TF-QtDWJGrasGK7C2C+JxOFw@mail.gmail.com> <001801dc4041$607c19f0$21744dd0$@telus.net> <x4qvjfwxzatm6wnrtqgue7y673oqzo74i6ysmxalvnts5olkot@ekaee62fjg5l> <001201dc4297$3903af70$ab0b0e50$@telus.net> <zq6mqdrq2kxmyga2skrizuj63ocbab2o2k3ogeufq3sydmwyuo@epxcrwomkvvp>
In-Reply-To: <zq6mqdrq2kxmyga2skrizuj63ocbab2o2k3ogeufq3sydmwyuo@epxcrwomkvvp>
Subject: RE: [PATCH v1] cpuidle: governors: menu: Predict longer idle time when in doubt
Date: Wed, 22 Oct 2025 19:24:11 -0700
Message-ID: <001d01dc43c4$1f131eb0$5d395c10$@telus.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQEHjVQKCrlPynWgLAaVpIarC+pGJQGZtDQKAi3SGCUCWYi7hgLZuqUGAZPsdfIBj3Y3eQKrbtlkAf5ekF218ivVcA==

On 2025.10.22 01:01 Sergey Senozhatsky wrote:
> On (25/10/21 07:30), Doug Smythies wrote:
>> For your system booted with "base" and "revert" do:
>> 
>> echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
>> echo 2300000 | sudo tee /sys/devices/system/cpu/cpufreq/policy*/scaling_max_freq
>
> Alright, here are the results:
> 
> ~ # echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
> performance
> ~ # echo 2300000 | sudo tee /sys/devices/system/cpu/cpufreq/policy*/scaling_max_freq
> 2300000
>
> Base:		52.5
> Revert:	45.5

So, still 15.4 %.

Thank you very much.
I wish I could create a test that would show such results on my test computer and believe me I have tried.
I haven't been able to.

... Doug



