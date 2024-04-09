Return-Path: <linux-pm+bounces-6123-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EB489DF77
	for <lists+linux-pm@lfdr.de>; Tue,  9 Apr 2024 17:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 976A81C22E48
	for <lists+linux-pm@lfdr.de>; Tue,  9 Apr 2024 15:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0934B135A6D;
	Tue,  9 Apr 2024 15:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="T+Wwmva1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4375980619
	for <linux-pm@vger.kernel.org>; Tue,  9 Apr 2024 15:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712677209; cv=none; b=be/YUhgzzq49WOoGS8NoAPDkjKzUv0nEazC8x5HOHp9HxjzNgJEkHDkHkg/sFkpLOYgVgnu+OxNKtqX7ysQoLkW8wOswQRAJAq1I7i+fizIZ8uV2U45puwxoqrtQYa4tp99FhOgENOPDWoj7su0ckhmRZ5TyCAw1W3Jco7YvOPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712677209; c=relaxed/simple;
	bh=Im2pV7UUUvn6tVTrpIQQKBUVfbBnt4AHOBFlG8bAws0=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=OLSYAcKCOFC7konDrYw9+MhQlGDhA+Fa7a7MxWU4yu4b/go6OoLoIJQiw8czLpangp2Xf82+wlzF8711VmAo7VmaXYjGz74f37w9g5xtP897ddpU0axrTBqdc4M0yRpFE1u2F/770CwJUgG06oag+yBIrQiYfrOUCYNhkEHfX2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net; spf=pass smtp.mailfrom=telus.net; dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b=T+Wwmva1; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telus.net
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e3e56c9d2cso25468965ad.1
        for <linux-pm@vger.kernel.org>; Tue, 09 Apr 2024 08:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1712677207; x=1713282007; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=t1ZdjIfpwsEpN0j3fC1ZIMkWKugMLDNqW+g9FjihQJo=;
        b=T+Wwmva1E0RbFZVYk+wdhlb0eb9clZrQM9g6EwM41NWglXzihYvWhj/IpfaH1AcRq+
         gae8jA259O0Eaii0c8a3Vo44qi773jrUqwoR5xvJvHN+d1pfF9eOJXED+3Y9hrdqWIiv
         409IZfqhCrFI9h6bAMhfDKVw+EBAVXpuUztUH2TIyOUu+tKUWj7fxV1YhbhRh6IvhrZ2
         nQo/ndY6t1ehQPoiCAEYhHMu4+bW+QIK1rLE1aYT3JqV4SczpMitvgH1QDv+2NYvIXUL
         18ciDLTKVa3G88SpsdEYmPEIKK2YBsygLylxpn/LS5ZaznVcyf8YT4SEA/BWCiqVsRhI
         yR8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712677207; x=1713282007;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t1ZdjIfpwsEpN0j3fC1ZIMkWKugMLDNqW+g9FjihQJo=;
        b=EYvkTPlg9siLfNrDEWMB88nPw83VpZplLwjWivojkUdwPr86KmCmmnk7mgdSJZix0L
         PhbWXxrobQPjZxl4wcNyENxZVKjD2P5jeM5WmyJLqz8T6o98ol6cp1NBqTSYTapBOpF0
         YnbO75YIkzcS/2M00TR92oMXvJeLllzwGZRM0w2mMgfAB99n6+iAFA1noR4x1Mf1Z3fs
         QeBIQva+8r0WGZ7jKktQAU6Upc4I392faKEWW45Lsqk+kBiFJASF1l9tBKn8QsO+D1s5
         GZ94Z4tsSsFWvJuMckksux3czCmGW0xSA85bjGAmhjdPmo5guDkRfs1BFlDiCnNyQ12U
         6Hdw==
X-Gm-Message-State: AOJu0YyuAKWKVzXU7JwDb8OtpumY3S9Z9ZeQQpS9fDSEhW4rtBu7TEn/
	W5VOFuuytEqZTTVfwtw9joID2bwzsoDbfGewQDRf/IpZuA6FZ9zsfroHXyjCC2Zu4vfmm2DSn5y
	B
X-Google-Smtp-Source: AGHT+IGTtKPEPO9cZFEW6ACzIuOC7DuCasGENwvMLoSNZEl7VVK1zlW421vIJy8PwAwSYsfaacQpTQ==
X-Received: by 2002:a17:903:11cd:b0:1e4:b1c7:9a7a with SMTP id q13-20020a17090311cd00b001e4b1c79a7amr172710plh.22.1712677207553;
        Tue, 09 Apr 2024 08:40:07 -0700 (PDT)
Received: from DougS18 (s66-183-142-209.bc.hsia.telus.net. [66.183.142.209])
        by smtp.gmail.com with ESMTPSA id lg15-20020a170902fb8f00b001e0c5be4e2esm9065235plb.48.2024.04.09.08.40.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2024 08:40:07 -0700 (PDT)
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Len Brown'" <lenb@kernel.org>
Cc: <linux-pm@vger.kernel.org>,
	"Doug Smythies" <dsmythies@telus.net>
References: <20240409003120.338589-1-lenb@kernel.org>
In-Reply-To: <20240409003120.338589-1-lenb@kernel.org>
Subject: RE: turbostat 2024.04.08 queued for upstream
Date: Tue, 9 Apr 2024 08:40:08 -0700
Message-ID: <001001da8a94$33d941c0$9b8bc540$@telus.net>
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
Thread-Index: AQIsF5tMX79vUXAlmdV8P6+qWnzTh7C84lHA

Hi Len,

Thank you for the new version of turbostat.
There seems to be 5 patches missing from the set of 26.
I also checked on patchworks:

https://patchwork.kernel.org/project/linux-pm/list/?series=842622


On 2024.04.08 17:31 Len wrote:

> Please let me know if you see any problems in this update.
>
> thanks!
> -len
>
> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git tags/turbostat-2024.04.08

I cloned it and all 26 patches are there. 
I would just compile turbostat there and use that one, but it doesn't compile.
(see below).

>
> Turbostat version 2024.04.08
>
>Use of the CPU MSR driver is now optional.
> Perf is now preferred for many counters.
>
> Non-root users can now execute turbostat, though with limited function.
>
> Add counters for some new GFX hardware.
>
> ----------------------------------------------------------------
> Chen Yu (1):
>      tools/power turbostat: Do not print negative LPI residency
>
> Doug Smythies (1):
>      tools/power turbostat: Fix added raw MSR output
>
> Justin Ernst (1):
>      tools/power/turbostat: Fix uncore frequency file string

Missing.

> Len Brown (4):
>      tools/power turbostat: Expand probe_intel_uncore_frequency()
>      tools/power turbostat: Fix warning upon failed /dev/cpu_dma_latency read
>      tools/power turbostat: enhance -D (debug counter dump) output
>      tools/power turbostat: v2024.04.08

Missing (just tools/power turbostat: v2024.04.08 is missing)

This chunk of the patch:

 @@ -3371,7 +3374,7 @@ int get_rapl_counters(int cpu, int domain, struct core_data *c, struct pkg_data
        struct rapl_counter_info_t *rci = &rapl_counter_info_perdomain[domain];

        if (debug)
-               fprintf(stderr, "get_rapl_counters: cpu%d domain%d\n", cpu, domain);
+               fprintf(stderr, "%s: cpu%d domain%d\n" __func__, cpu, domain);

        assert(rapl_counter_info_perdomain);

Should be this (note the missing comma added):

+               fprintf(stderr, "%s: cpu%d domain%d\n", __func__, cpu, domain);

With that change turbostat version 2024.04.08 compiles.

> Patryk Wlazlyn (11):
>      tools/power turbostat: Print ucode revision only if valid
>      tools/power turbostat: Read base_hz and bclk from CPUID.16H if available
>      tools/power turbostat: Add --no-msr option
>      tools/power turbostat: Add --no-perf option
>      tools/power turbostat: Add reading aperf and mperf via perf API
>      tools/power turbostat: detect and disable unavailable BICs at runtime
>      tools/power turbostat: add early exits for permission checks
>      tools/power turbostat: Clear added counters when in no-msr mode
>      tools/power turbostat: Add proper re-initialization for perf file descriptors
>      tools/power turbostat: read RAPL counters via perf
>      tools/power turbostat: Add selftests
>
> Peng Liu (1):
>      tools/power turbostat: Fix Bzy_MHz documentation typo
>
> Wyes Karny (1):
>      tools/power turbostat: Increase the limit for fd opened
>
> Zhang Rui (6):
>      tools/power/turbostat: Enable MSR_CORE_C1_RES support for ICX
>      tools/power/turbostat: Cache graphics sysfs path
>      tools/power/turbostat: Unify graphics sysfs snapshots
>      tools/power/turbostat: Introduce BIC_SAM_mc6/BIC_SAMMHz/BIC_SAMACTMHz

Missing

>      tools/power/turbostat: Add support for new i915 sysfs knobs

Missing

>      tools/power/turbostat: Add support for Xe sysfs knobs

Missing

>
> MAINTAINERS                                     |    1 +
> tools/power/x86/turbostat/turbostat.8           |    6 +-
> tools/power/x86/turbostat/turbostat.c           | 2197 ++++++++++++++++++-----
> tools/testing/selftests/turbostat/defcolumns.py |   60 +
> 4 files changed, 1805 insertions(+), 459 deletions(-)
> create mode 100755 tools/testing/selftests/turbostat/defcolumns.py



