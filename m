Return-Path: <linux-pm+bounces-24287-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5F4A69366
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 16:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A89EB1B803DC
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 15:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5C21CEADB;
	Wed, 19 Mar 2025 15:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b="MwDyoLAn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB11A1CAA70
	for <linux-pm@vger.kernel.org>; Wed, 19 Mar 2025 15:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742396988; cv=none; b=YH3QSq4ELdI9zJha6OJ/uZHX9+P6Jtgmy2+iYolILH3svMAE1hljbcFDK5vqxgfh/g++qO8hditvTEBIWnjISINwmCjknoBwxyO+B4USiER25Qqi+wggtn/GOvlj/t3JAfcA0JviZ3kNs2L2OkSe47svCxdhRGKFisY4g8msPcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742396988; c=relaxed/simple;
	bh=QWtbIf9nI04gI+Qaz/Sd2FXRcFGvlhRGVXdc8baSbOc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=n3TSML29GakcfDb0ik6Y35z706j2F/RxegIksIDT/QaObxVOkt0lPQOVj62oex7fpu9cBY7oscgyeAVFfUd++otxmCONrXXaN1B2g1Bi9kcoGegkiSdgUFyhrtJT8RrUMgD8ea498sI7TQ/8J5wfuDizHZo6SpF+hs4c5wetllY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org; spf=pass smtp.mailfrom=kfocus.org; dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b=MwDyoLAn; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kfocus.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-85dac9728cdso189747439f.0
        for <linux-pm@vger.kernel.org>; Wed, 19 Mar 2025 08:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kfocus-org.20230601.gappssmtp.com; s=20230601; t=1742396986; x=1743001786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:organization:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QWtbIf9nI04gI+Qaz/Sd2FXRcFGvlhRGVXdc8baSbOc=;
        b=MwDyoLAnc7B1JOeW78uI/s1QEjiFRa5vTPSWUF4Kki8DFtUbmDSl0/cxq1cgHymt+o
         +gR0rXk3ksJmaj2/5ZZPmIBRFneO72CmQ3GoECv7RLE9ckmA6anntp9v21iaWOeBS2cA
         AtbHWP9ttlH2lClyYYsuKC3YSG6UZ5VkbmKTKVWU8ULeK2sjQrV/9AoeqPFaxAivEq+d
         sa4FwbQvWmJzYlxbaj8GlrAuSw4tAIBADY9oJ/BPJFE4GXwgdKmV+mg9chi+MRCtf6Lr
         /bYSeTeY6qt9kCNYBVSaMMr+j7zMxUP+Ha9o0/bx4rC0D3Wkfnp1db93+Sp9jecQ7NBh
         gnzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742396986; x=1743001786;
        h=content-transfer-encoding:mime-version:organization:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QWtbIf9nI04gI+Qaz/Sd2FXRcFGvlhRGVXdc8baSbOc=;
        b=SWmqqQXEHxw4b742RWYrcQDDzN5mrhsTsc75z3dFL6hlcMlZ7YBrBWIwJZlCyjIa30
         Jlyr1VnUGCByCKwvHndbSMPy7LUEsPEMIZQIl1MczBqLKnN43OKfEnsbalSWk0ualLJJ
         WA8mNRMcOIrfvTs/LhX0bmBUxcppMdRhTRpQasByEDUxlsvkQczuyTanJmyJvxuFoVYA
         Y7E8hCOm6dsHSULsxFkw9PQelB4TqXTsBt5+UHGva9I+V6tYWGCezsfM5uUMipjn7A28
         nYAK5G5hZpsUjm+yrig/5KTDIk6aFfytOSrBs8JgptubyqkCC3mBNZ/RltfT2TIafELh
         Jk2w==
X-Gm-Message-State: AOJu0YzVzLc4KuRnAUXSHvnjb6izdQblHdzmWpRXoGUrllUtd53FirFi
	v0CLisZAt+LT8lqCMSTdzHrsrX/5m/iAb3UtrnsGGGa3l3VqFwE2/51nIhaQifkwnHw0WW9YDI5
	sE/Y=
X-Gm-Gg: ASbGnctKGDFdIeRwKDq2nJMTemA5wA4j9pqGiZGFF+d5sCS5W+VoJHew6KmeQSj73hg
	MxwxcwkVKok1ijafR3j7wsTy0rc6e6P0xNO5RAloekYr8tCqUmiAhlLBh/m/jR9jk+Ju7KtdLiQ
	CMjBi+tAhSfm//K078BFaitr6vb6ubOtkueJK342yV4pq/Uetx/GVcPPQhtTw4Dknq+sLzPm6zE
	v+RqxgHxcqkeSRXYOuORuIM/BnjMvlzSkO39p4AgLT7PIAejM/MeDpOdfncQKovXF3IaPXNtzOv
	Od/NufbC1e8U4ahSWs5Jx4gooSr1mOGSGOraLq3TPQ==
X-Google-Smtp-Source: AGHT+IG4rhQdwit+SFyBcgIAgQKUnvCE7OMOskvLtOW18cJVkS3xyCXAhYUOrG/YWT7S0yEfyhXhsA==
X-Received: by 2002:a05:6602:3991:b0:85b:4afc:11d1 with SMTP id ca18e2360f4ac-85e137bb681mr377336439f.5.1742396985762;
        Wed, 19 Mar 2025 08:09:45 -0700 (PDT)
Received: from kf-m2g5 ([2607:fb90:cf88:74c:d7f4:2d05:3df2:a7d7])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2637276a8sm3218228173.65.2025.03.19.08.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 08:09:45 -0700 (PDT)
Date: Wed, 19 Mar 2025 10:09:42 -0500
From: Aaron Rainbolt <arainbolt@kfocus.org>
To: srinivas.pandruvada@linux.intel.com, lenb@kernel.org, rafael@kernel.org,
 viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 mmikowski@kfocus.org
Subject: /sys/devices/system/cpu/cpu* frequency info different between
 kernels 6.8 and 6.11
Message-ID: <20250319100942.578b815d@kf-m2g5>
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

I haven't looked super closely into this yet (haven't compiled a
mainline kernel and tested it), but it seems that the CPU frequency
info under /sys/devices/system/cpu/cpu* has changed behavior, at least
on Intel CPUs. In particular, the frequencies shown under
/sys/devices/system/cpu/cpu*/cpufreq/cpuinfo_max_freq used to show the
maximum CPU frequency the hardware supported, even if turbo boost was
turned off in the intel_pstate driver. (This was the behavior in
kernels 6.8 and prior.) In kernel 6.11 however, they show the maximum
CPU frequency the hardware supports in its current turbo mode, meaning
that if turbo boost is turned off, the maximum CPU frequency shown is
much lower than it is when turbo boost is turned on. This is a bit of a
problem, because some userspace tools (for instance Kubuntu Focus's
Power and Fan tool) depend on cpuinfo_max_freq showing the maximum
frequency of the CPU regardless of turbo boost state, and rely on
base_frequency to show the maximum frequency without turbo boost
enabled. Now in order to read the maximum turbo boost frequency, you
have to at least temporarily enable turbo boost, then read the
frequency info.

To illustrate the issue:

=E2=94=8C=E2=94=80=E2=95=B4aaron@kf-m2g5:/sys/devices/system/cpu/cpu0/cpufr=
eq
=E2=94=94=E2=94=80=E2=95=B4$ echo '0' | sudo tee /sys/devices/system/cpu/in=
tel_pstate/no_turbo > /dev/null
=E2=94=8C=E2=94=80=E2=95=B4aaron@kf-m2g5:/sys/devices/system/cpu/cpu0/cpufr=
eq
=E2=94=94=E2=94=80=E2=95=B4$ grep . *
affected_cpus:0
base_frequency:2200000
cpuinfo_max_freq:5600000
cpuinfo_min_freq:800000
cpuinfo_transition_latency:20000
energy_performance_available_preferences:default performance balance_perfor=
mance balance_power power=20
energy_performance_preference:balance_performance
related_cpus:0
scaling_available_governors:conservative ondemand userspace powersave perfo=
rmance schedutil=20
scaling_cur_freq:1458327
scaling_driver:intel_cpufreq
scaling_governor:ondemand
scaling_max_freq:5600000
scaling_min_freq:800000
scaling_setspeed:<unsupported>
=E2=94=8C=E2=94=80=E2=95=B4aaron@kf-m2g5:/sys/devices/system/cpu/cpu0/cpufr=
eq
=E2=94=94=E2=94=80=E2=95=B4$ echo '1' | sudo tee /sys/devices/system/cpu/in=
tel_pstate/no_turbo > /dev/null
=E2=94=8C=E2=94=80=E2=95=B4aaron@kf-m2g5:/sys/devices/system/cpu/cpu0/cpufr=
eq
=E2=94=94=E2=94=80=E2=95=B4$ grep . *
affected_cpus:0
base_frequency:2200000
cpuinfo_max_freq:2200000
cpuinfo_min_freq:800000
cpuinfo_transition_latency:20000
energy_performance_available_preferences:default performance balance_perfor=
mance balance_power power=20
energy_performance_preference:balance_performance
related_cpus:0
scaling_available_governors:conservative ondemand userspace powersave perfo=
rmance schedutil=20
scaling_cur_freq:917829
scaling_driver:intel_cpufreq
scaling_governor:ondemand
scaling_max_freq:2200000
scaling_min_freq:800000
scaling_setspeed:<unsupported>

This is happening on Ubuntu 24.04 using a 6.11.0-series kernel.

Does this seem like a bug? If so, should I try reproduce it with a
mainline kernel and find the commit that introduced it?

Regards,
Aaron

