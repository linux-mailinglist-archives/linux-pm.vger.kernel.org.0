Return-Path: <linux-pm+bounces-19582-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A208B9F96A7
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2024 17:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DDA21623F8
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2024 16:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31ED364BA;
	Fri, 20 Dec 2024 16:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E2sGZlsF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90651BD9C1
	for <linux-pm@vger.kernel.org>; Fri, 20 Dec 2024 16:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734712532; cv=none; b=rh4MLAwO31nxic0T84DyDpFNqKz09niPOhR49TwB8WmZ8fgTItFXEE5db/qgfmAOwJuJrou2HidZRQBQPVDNucuvrYN0KnqALmXbvEcVLsFxMUtawy2maZ8wdBUje0OgaTC7dQnlSEQAmlnhXBX2HgWrOApBVH9bMFjc0bsS6LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734712532; c=relaxed/simple;
	bh=OgXWe+QSKP5xllrZnCv86e37V0TreCfsuEVfjnPVWuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YdU3AjulcOnepwFjP93CQrXPWS6ULE9ZtslIdGafYlR1OW+OUQraxw2H8z6AgvZ6URJFcrB2l5SNNND0O1liG1B5W/6JglScciCOOo3CJIYEUb31IHUJfbGiaoP5uP/464h5WHjrGU0xA5ZqIf7mds6GNifFkKZmJcntCeaFpG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E2sGZlsF; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a8160382d4so6143035ab.0
        for <linux-pm@vger.kernel.org>; Fri, 20 Dec 2024 08:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1734712529; x=1735317329; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xN+yt3kAE3qhszt8af+M5GDH5HLuin4z3BtChtZrdnM=;
        b=E2sGZlsF3kv+ZdTXLhCQv09ExcsU2TNFzefZDwmKQFiO9wQpWciL8PhUZkTDKrgwTX
         enCaDsaR6fd+kRH2RX/Xgk0k3n+0RLaZZYt2fpAugNGzOj09o6LMT0QjX7JKlQAir1kO
         VCuKaXblxqhNLEhwDRUic0+kl5Xqf4M84UWIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734712529; x=1735317329;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xN+yt3kAE3qhszt8af+M5GDH5HLuin4z3BtChtZrdnM=;
        b=wfCpwREYPtRFx8r9JCXtybbPgMvVx7AKyORlpnZdvNq6ikDqm8XI3oK4Rb2s4ugiot
         BZvszJu3zKhfloJgIJt/St2MaNB4LSjbzF4gjD1MF9UW3N3IysxS28Fk53Y6pwFbHV7Q
         UeCuCJ7WpZDPVbJhDjKz/9PRQUkfK5hyBII5aD308+elikOkK/Kq9a/eZJki5rFfMo/9
         QcvlKupSFPyYNGzgIjcr3DZCJyll6kCQLr5jbKK1jzAJI6pwIbZX8Iwlbmi0NxNNn1VI
         LEtmwwH3FIrCt0hlPkR9Mf9Xcds3ZraAWIUW+EJBt9oJMrwAm53vCYRWlSzdxOGNrwI4
         1IAg==
X-Gm-Message-State: AOJu0YzZZyk2hIQsnEP4clP+MITr4tHoDTCu6wAdgEL/8uSIgMaGVkJx
	Eo3xZ4D/MehFfCC0tF4zZ/X4E18c4+KPzBjZXrVxWyZbS7r/N4fUlKLtqLnDFLM=
X-Gm-Gg: ASbGncuMFw/Wjo1Gcc8KfKfOQcWJkKm048UgmxweBERFHsC3AUAPm57/ffVuR5zHHC8
	CbliTVbNASoIHwW1Ag2Qv6cw9RnMkXmEaunESIe1z2+Nl7QpQl+kBiTXvDz/KfMf6M5kdB6er+i
	u/vS3eH5FHysVF1a0gMnKcxRgtwkpQ3X7KSJA7IFFO0b6vdkDp2Mt/Z37WR6Qi/PBCADMWrgfeA
	DJY9NPrZYQc0aKx8PeR7rR6zjatls3aObuZmzaJdSjLCWoTy+MbLYyTH9eO/h5cMJ9D
X-Google-Smtp-Source: AGHT+IHK3hPMl35natzF+F2Ms1HgoFW+B9kWy2KX6tWkunNqcLu9cMUCStu/4KEe6hYgnt3tZ72cLQ==
X-Received: by 2002:a05:6e02:20ca:b0:3a7:8270:4050 with SMTP id e9e14a558f8ab-3c2d514fafdmr38247315ab.18.1734712529592;
        Fri, 20 Dec 2024 08:35:29 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3c0df949b6bsm9337725ab.39.2024.12.20.08.35.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 08:35:28 -0800 (PST)
Message-ID: <8dc731c3-6586-4265-ae6a-d93ed219a963@linuxfoundation.org>
Date: Fri, 20 Dec 2024 09:35:27 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] cpupower improvements on AMD systems
To: Mario Limonciello <superm1@kernel.org>, mario.limonciello@amd.com,
 jkacur@redhat.com, jwyatt@redhat.com, shuah@kernel.org, trenn@suse.com
Cc: linux-pm@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20241218191144.3440854-1-superm1@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241218191144.3440854-1-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/18/24 12:09, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> cpupower shows a number of errors on AMD systems configured
> in 'active' mode where the hardware transitions states for
> the user.
> 
> Clean up those errors and add some extra information for the amd-pstate
> preferred core feature.
> 
> Mario Limonciello (7):
>    cpupower: Remove spurious return statement
>    cpupower: Add support for parsing 'enabled' or 'disabled' strings from
>      table
>    cpupower: Add support for amd-pstate preferred core rankings
>    cpupower: Don't try to read frequency from hardware when kernel uses
>      aperfmperf
>    cpupower: Add support for showing energy performance preference
>    cpupower: Don't fetch maximum latency when EPP is enabled
>    cpupower: Adjust whitespace for amd-pstate specific prints
> 
>   tools/power/cpupower/lib/cpufreq.c        | 18 ++++++++++++
>   tools/power/cpupower/lib/cpufreq.h        |  8 +++++
>   tools/power/cpupower/utils/cpufreq-info.c | 36 +++++++++++++++++++++--
>   tools/power/cpupower/utils/helpers/amd.c  | 18 +++++++++---
>   4 files changed, 73 insertions(+), 7 deletions(-)
> 

Thank you. The patch series is now in

https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/log/?h=cpupower

I will include this in pull request to Rafael in early January.

thanks,
-- Shuah

