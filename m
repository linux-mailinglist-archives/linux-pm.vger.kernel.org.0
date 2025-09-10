Return-Path: <linux-pm+bounces-34390-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FB2B51DE6
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 18:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9F861C270A2
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 16:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C382727E6;
	Wed, 10 Sep 2025 16:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b="MEGx7w4A"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C31E26E712
	for <linux-pm@vger.kernel.org>; Wed, 10 Sep 2025 16:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757522236; cv=none; b=okArCV5LNNLeXEQmmaa8dnZpPkm3Kw3egOXKIM0QBPACZy6DvBrJUnloXMpimvztIWwutMpZEjnQWNC+RCttgK827+d1Nw5IxpAGvWJcveDYM9IDgq3FyWrh0TMbZVEAyw0dIvCRhW7C+Sm1bqNCi7r1IdonoeDTQVx1uwb7sDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757522236; c=relaxed/simple;
	bh=D7+1Jtko4vGFBtZ3b9PtA52nn3hdE+r4sdDTEiZ9DIo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i/f+l3LOjervhHgGMvljG4Kg+67WknOkTCdE1fjD/cHJlztyuabIqdViPnS37aH8XZPnP5bebaimusr65xQNibvwu1tHTc+eRHkseXqh/XrSC+8iIYbbriHuvr9cIIFGVYAD7vVzGlecUFyN7vnQmsThwIqpMg111ezYNDgQWno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org; spf=pass smtp.mailfrom=kfocus.org; dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b=MEGx7w4A; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kfocus.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-412a2fe2f31so9210215ab.3
        for <linux-pm@vger.kernel.org>; Wed, 10 Sep 2025 09:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kfocus-org.20230601.gappssmtp.com; s=20230601; t=1757522232; x=1758127032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5PHdX8GAxuQZU4FPQQfLC6oiU9UUSdStUhO8V11U/BI=;
        b=MEGx7w4ABZdm126HTNA3s4s0PSDKCS3OOLXr47+IaN8cVf/aoJSJyepbAPxjWF3vNt
         eKEhp+bDQ/cS84luZDF9WrjX/JQSpJS1lSZKJvj1pWrvXeK0PtRTN95hJWUJ4mSjBefo
         RMoBa5MFEi9cieAPzBBycDMBw25U743V8q8XNwSmtmCwQbD8KX74j6ETivflnUAuYidK
         UmprWnN+5ZZxSXQsn0mQEK0B/ND2FKctk88eWYC4b11BpH8MdMgDUAmEY9FtE56HhOLU
         0Jrp5QQEQQiW7RVQXLMOoncdmdi/f8/GHXl2g6ZHnDRY9O7lZ6ii7nWiCuk1j9fLO+Q4
         TA4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757522232; x=1758127032;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5PHdX8GAxuQZU4FPQQfLC6oiU9UUSdStUhO8V11U/BI=;
        b=fgLn92RSbNaLRdIPj/ai5t5YjZoGh8K9uZqTYLIBBfQeAs5dG1XhefbQaXsi4U5Q+Y
         Bx6aW+tlfPRbFG0pEXrnWKFmzZK4TrY1asmJ0G1MTv4ZvemjJeXq5gLNcbVPP1FV6gPX
         2afxgO16z+dw3Di1jV+S6MG45aKL4ntN7KPdOtsbccpndlHalXJ67x8bsVtehjaz4Xzt
         sWGtbGMhOI+/7NkzPaGOyUlT8yA0ZEnviqjd8R88NKBmiGuKMXy7QR8Pk1n9uvoZCgSQ
         ae3RhZX7diNd3Sm/0xPmwaI3d0tb2fW59mfb62WdOUnP3gsxnNLMquO/t5vVXvGGD0Gt
         pS0w==
X-Forwarded-Encrypted: i=1; AJvYcCXLy4xxjhb+BYh/NsIu1EH/rteMe6BJ0wcZaj/y63LyvhkDDQWMrQC/FTaMmygbEFIqHYBPLmr+yg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPmOmC9wCTQtZ79RfAk1OYhP2KD82ojOJnv+KWfrixVeZmBiK0
	lYviSs1QzKIv151wcMbp+DdyjKsF3GLwC2y97D50u3l9eyiqi/JhumZkVcSaR+aGJpE=
X-Gm-Gg: ASbGncu8Rui2Y2dEEaGwCf55kmtBrm1pU7Vx4fkxSPcFFCi/u71k6QRoNzyDSXiOVZV
	u2PFPHq6m2Saf59M13FOHoe03BY4ax0nF20qT92ory/V7K0z+QOQEElimtkcdmmco5I9ro3RPJn
	wqzhmDblwKYhjOXiAlwUZU4jUaBhfS9+WQQ04PQQ52zXq6egSUKOJTjLF+gv+QWnN6KwZ1heK19
	p3KdIlKDTUlknMQmS1rfJ79QF4EAbON5f7sEvaRfIgTrCt11WmdZlv8uMYBqgNekr9H63QPzHyk
	rHZvf7k7kLNtGSMcXdVRHk2a2C9iw6hQPghE9VzvsWnLJJcbZ8q1HYGcN8C2unJZievu/K3gQ66
	e4v87EhM1OFPszLrKDUxnPgynwlgA/A==
X-Google-Smtp-Source: AGHT+IGBAC+NF9eQWXe2qgtcaHE/zyQFVP7RCp/eYumttsidkm4pYYuSbUHJdDdCHsm7TKN2JhGJKw==
X-Received: by 2002:a05:6e02:1c0f:b0:418:f658:acbc with SMTP id e9e14a558f8ab-418f658ae4bmr28223245ab.20.1757522232476;
        Wed, 10 Sep 2025 09:37:12 -0700 (PDT)
Received: from kf-m2g5 ([2607:fb90:cfaa:41d:4be0:7e8b:71d9:233b])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4049b300638sm42214305ab.10.2025.09.10.09.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 09:37:12 -0700 (PDT)
Date: Wed, 10 Sep 2025 11:36:50 -0500
From: Aaron Rainbolt <arainbolt@kfocus.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, mmikowski@kfocus.org
Subject: [REGRESSION] Intel Turbo Boost stuck disabled on some Clevo
 machines (was: [PATCH] cpufreq: intel_pstate: Unchecked MSR aceess in
 legacy mode)
Message-ID: <20250910113650.54eafc2b@kf-m2g5>
In-Reply-To: <CAJZ5v0h99RFF26qAnJf07LS0t-6ATm9c2zrQVzdi96x3FAPXQg@mail.gmail.com>
References: <20250429210711.255185-1-srinivas.pandruvada@linux.intel.com>
	<CAJZ5v0h99RFF26qAnJf07LS0t-6ATm9c2zrQVzdi96x3FAPXQg@mail.gmail.com>
Organization: Kubuntu Focus
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 30 Apr 2025 16:29:09 +0200
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> On Tue, Apr 29, 2025 at 11:07=E2=80=AFPM Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> >
> > When turbo mode is unavailable on a Skylake-X system, executing the
> > command:
> > "echo 1 > /sys/devices/system/cpu/intel_pstate/no_turbo"
> > results in an unchecked MSR access error: WRMSR to 0x199
> > (attempted to write 0x0000000100001300).
> >
> > This issue was reproduced on an OEM (Original Equipment
> > Manufacturer) system and is not a common problem across all
> > Skylake-X systems.
> >
> > This error occurs because the MSR 0x199 Turbo Engage Bit (bit 32)
> > is set when turbo mode is disabled. The issue arises when
> > intel_pstate fails to detect that turbo mode is disabled. Here
> > intel_pstate relies on MSR_IA32_MISC_ENABLE bit 38 to determine the
> > status of turbo mode. However, on this system, bit 38 is not set
> > even when turbo mode is disabled.
> >
> > According to the Intel Software Developer's Manual (SDM), the BIOS
> > sets this bit during platform initialization to enable or disable
> > opportunistic processor performance operations. Logically, this bit
> > should be set in such cases. However, the SDM also specifies that
> > "OS and applications must use CPUID leaf 06H to detect processors
> > with opportunistic processor performance operations enabled."
> >
> > Therefore, in addition to checking MSR_IA32_MISC_ENABLE bit 38,
> > verify that CPUID.06H:EAX[1] is 0 to accurately determine if turbo
> > mode is disabled.
> >
> > Fixes: 4521e1a0ce17 ("cpufreq: intel_pstate: Reflect current
> > no_turbo state correctly") Signed-off-by: Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com> Cc: stable@vger.kernel.org
> > ---
> >  drivers/cpufreq/intel_pstate.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/cpufreq/intel_pstate.c
> > b/drivers/cpufreq/intel_pstate.c index f41ed0b9e610..ba9bf06f1c77
> > 100644 --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -598,6 +598,9 @@ static bool turbo_is_disabled(void)
> >  {
> >         u64 misc_en;
> >
> > +       if (!cpu_feature_enabled(X86_FEATURE_IDA))
> > +               return true;
> > +
> >         rdmsrl(MSR_IA32_MISC_ENABLE, misc_en);
> >
> >         return !!(misc_en & MSR_IA32_MISC_ENABLE_TURBO_DISABLE);
> > -- =20
>=20
> Applied as a fix for 6.15-rc, thanks!
>=20

FYI, this seems to have broken turbo boost on some Clevo systems with
an Intel Core i9-14900HX CPU. These CPUs obviously support turbo boost,
and kernels without this commit have turbo boost working properly, but
after this commit turbo boost is stuck disabled and cannot be
enabled by writing to /sys/devices/system/cpu/intel_pstate/no_turbo. I
made a bug report about this against Ubuntu's kernel at [1], which is
the only report I know that is able to point to this commit as having
broken things. However, it looks like an Arch Linux user [2] and a
Gentoo user [3] are running into the same thing.

[1] https://bugs.launchpad.net/ubuntu/+source/linux-hwe-6.14/+bug/2122531

[2] https://bbs.archlinux.org/viewtopic.php?id=3D305564

[3] https://forums.gentoo.org/viewtopic-p-8866128.html?sid=3De97619cff0d9c7=
9c2eea2cfe8f60b0d3

