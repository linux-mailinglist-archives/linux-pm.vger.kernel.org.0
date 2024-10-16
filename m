Return-Path: <linux-pm+bounces-15810-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 031449A1588
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 00:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73A22B21F0B
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 22:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21721D2780;
	Wed, 16 Oct 2024 22:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b="Qka3ZapU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B0A1BE871
	for <linux-pm@vger.kernel.org>; Wed, 16 Oct 2024 22:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729116240; cv=none; b=fDyhRQ3PkQW8mkd1q3scw/khqzybbyPDOmqK6CT8133Hds9C4cd7B/G8TEjTDLHWfHtDNzOkCp+Jn0GDaxZqISVnDfIsnDwaxQFTT488xU8Tp3ZjLDYgXNo7rJmlXdaD2Jh3G0J42PnrSSJdTV+gO5Ps99cytldcHwXh6xwoZaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729116240; c=relaxed/simple;
	bh=pKk/6zrwsgyQPs6L8uSnW+XK2yvBcVM4b1sd3gOK/+Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:Content-Type:
	 MIME-Version; b=C/D3r8KXX6LOSu0XiH4ka+WcXYP+KgPRjurAPU4KajH2aPFdmTcg733eYz8CNdZGAssFG0smus+nIw/WpMeUQzO1gLAyUSSCgL5LmJ4Egrurr2Z9cLId9RjlC5SBai0svBVUhflXoPoToskUEZn1yQA0ksNY/2QWZ0mXDkCTP9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name; spf=pass smtp.mailfrom=intelfx.name; dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b=Qka3ZapU; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intelfx.name
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4314fa33a35so2824265e9.1
        for <linux-pm@vger.kernel.org>; Wed, 16 Oct 2024 15:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intelfx.name; s=google; t=1729116237; x=1729721037; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zAy+YI8aJBgzKDlu+bhq0/HfkrFTLmcq01oXRQXTyec=;
        b=Qka3ZapUP6QP4k6h3rcegoIrOL/bawoS9j35GuDFtdQ7QCXFQr45/17yBxz3xnAoYu
         mkkFtPBjZUsMgyozF2gPiP1YRH2cIgh1bhonRujGYpAaQZNDp+mLgfFiPZrPWd56T2EP
         EnGYWL8CcUlqf8+SZsairTJCjE5phaFXMQDwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729116237; x=1729721037;
        h=mime-version:user-agent:content-transfer-encoding:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zAy+YI8aJBgzKDlu+bhq0/HfkrFTLmcq01oXRQXTyec=;
        b=FAw5bO2xvtbEatueRBzchZnRfB+4TbhkATyy6ZdKNfa8micQpciR0AQ5BBx4m09qzT
         ErT4XxCtDnYN7t93ZdBX/cjNn29On9XI83BifPxP58TKgnggGj3W1ehhfy3F/Wmt/Xg4
         ognVFypXXBMqnRdW+zRVSwF2nFOUrxW5Sa6IJc08Vr9NItXSMFjfzqUcsypeMIBqqMTk
         xk6cvPM52/iPvr3ZSqzq+gNZ9ncle4UqM8dULt+wOE9VsQesl/U14AdrGkmtl/IIAiWX
         BIqFJ299S02RTweetd68spkpuzAelckFsx2ca9uk173W94Iz4PnI8986yOmsSrkGxvR9
         cYKw==
X-Forwarded-Encrypted: i=1; AJvYcCXFTSb8gvRobEC+mOiJul1EXvJ3Gct55sqI7QpupUx+rRgbP9usKzbMn83xiIQYqfsQ5liiqIgckQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYCU6vsA+DabNMXnVZxr1LsAPnJ4k+s1UESFFWSMdOoRSNRirz
	5PBvO05XGxMJIpIGjZRTfpo2R1p7PyMLB/7alGgpnmX9ztZ4bUOKUzNBXgl1CEE=
X-Google-Smtp-Source: AGHT+IGFt/uf+S0HV+Ry8LS1AtX6ZH7OZiyFlbevTM8J88NluXe8RmwYFQhQPmKCyxw6eLPaERmVsQ==
X-Received: by 2002:a05:600c:1f12:b0:431:5871:6c5d with SMTP id 5b1f17b1804b1-43158716f6bmr7664875e9.3.1729116237192;
        Wed, 16 Oct 2024 15:03:57 -0700 (PDT)
Received: from [172.20.10.2] ([91.151.136.222])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa7a13bsm5370910f8f.13.2024.10.16.15.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 15:03:56 -0700 (PDT)
Message-ID: <3b2195074d7c8fa20f93f1dc6fc25afe5dbb2909.camel@intelfx.name>
Subject: Re: [PATCH v3 00/11] Adjustments for preferred core detection
From: Ivan Shapovalov <intelfx@intelfx.name>
To: Mario Limonciello <superm1@kernel.org>
Cc: bp@alien8.de, gautham.shenoy@amd.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	mario.limonciello@amd.com, perry.yuan@amd.com, rafael@kernel.org,
 x86@kernel.org
Date: Thu, 17 Oct 2024 02:03:52 +0400
In-Reply-To: <20240905163007.1350840-1-superm1@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On my desktop Zen 3 (Vermeer) system applying this series yields a new
warning message on each boot:

> Oct 16 06:20:41 kernel: Could not retrieve highest performance (-19)

As I see it, this is one of the pr_debug()s newly promoted to warnings.
Is there anything I can provide to help fix this?

Just for completeness:

```
$ cat-files /sys/devices/system/cpu/cpufreq/policy0/*
/sys/devices/system/cpu/cpufreq/policy0/affected_cpus                      =
       0
/sys/devices/system/cpu/cpufreq/policy0/amd_pstate_highest_perf            =
       231
/sys/devices/system/cpu/cpufreq/policy0/amd_pstate_hw_prefcore             =
       enabled
/sys/devices/system/cpu/cpufreq/policy0/amd_pstate_lowest_nonlinear_freq   =
       1746000
/sys/devices/system/cpu/cpufreq/policy0/amd_pstate_max_freq                =
       5274000
/sys/devices/system/cpu/cpufreq/policy0/amd_pstate_prefcore_ranking        =
       231
/sys/devices/system/cpu/cpufreq/policy0/boost                              =
       1
/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_max_freq                   =
       5274000
/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_min_freq                   =
       550000
/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_transition_latency         =
       0
/sys/devices/system/cpu/cpufreq/policy0/energy_performance_available_prefer=
ences  default performance balance_performance balance_power power
/sys/devices/system/cpu/cpufreq/policy0/energy_performance_preference      =
       balance_performance
/sys/devices/system/cpu/cpufreq/policy0/related_cpus                       =
       0
/sys/devices/system/cpu/cpufreq/policy0/scaling_available_governors        =
       performance powersave
/sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq                   =
       1746000
/sys/devices/system/cpu/cpufreq/policy0/scaling_driver                     =
       amd-pstate-epp
/sys/devices/system/cpu/cpufreq/policy0/scaling_governor                   =
       powersave
/sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq                   =
       5274000
/sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq                   =
       1746000
/sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed                   =
       <unsupported>

$ grep -w cppc /proc/cpuinfo
<empty>
```

Thanks,
--=20
Ivan Shapovalov / intelfx /

