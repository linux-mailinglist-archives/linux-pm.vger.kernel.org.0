Return-Path: <linux-pm+bounces-38519-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 017F7C8328F
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 03:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E5C7E4E256C
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 02:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587471E5B73;
	Tue, 25 Nov 2025 02:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="UK/ODl7I"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26371E2614
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 02:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764039551; cv=none; b=izSKILnlMtfFmzqWHYqPLNeL3cT1sLSPClodYXoZ4yAwPSVtw/K33m+syHW1MhPfJ7Aqsd9j3xfSrkW0N6fF33im2BauDHPAFfdvLUYi/l0/Ytq2fQM7pSDSUspNmEiGSgNS9/5x+kdVFb7ke4BuAvt9piCM3kcsk0Ct6Nb2keU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764039551; c=relaxed/simple;
	bh=7vsO8yRL5zDvY9vPKYftdlZbr4iSIkOT2GEUJeCI1G8=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=j2qeCWZo0qZNg4lqIiKm2iaiHMCOIFTwk6aCktF0qZMHOH8P8vN0QRxvLj7meYUyOBQrvFgp/9BhGUf5wlVs9M8/3Lwy3bDGf3Eg4ERvLpxPIWf72DiJW0IgYaTx4EOFLsXIl/gBdig/bhI47o/5IscemO1t8G8fjEo6IAI402w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=UK/ODl7I; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2953ad5517dso61502085ad.0
        for <linux-pm@vger.kernel.org>; Mon, 24 Nov 2025 18:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1764039549; x=1764644349; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fY1t3qEw9up3zZahP6BmPOCapaIM+S0F2CsFNk/g7So=;
        b=UK/ODl7IwwptXzp8gip9OH0gkEALzNClMf1u/JE9kZFoMa2lhJdhfWMzJ+PqLlGXdw
         csHryf3W6e9EykrcjpdvFjchxwMVYLq6GcHcHDTPg5zytJvbYoVLCjsnLtXq5Z+9apxp
         /37ae+IWluXQTZQHVP6UXaRZg8awDwhDC/ZdOw+Lpht+naos20VRVYjukpO5vwXXTiGQ
         FRsU49mx8FNdvMZ7KS1uaNOSI6K1yOjgNRMfFn/pVjqalhgJVfKCANJEYy3hxMW8ATH1
         dz+wya0HlfVwKpUZm43VkaCV1m+8joIh30R7TvZ4YpZSBYtrADPI37BuSMn3CuTaqULi
         AYRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764039549; x=1764644349;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fY1t3qEw9up3zZahP6BmPOCapaIM+S0F2CsFNk/g7So=;
        b=vSXZPajQPnRgxXvFCQPsoJDZQ9T+HMjV/eVLzzJM9A135fg/+smITGeNMrbtW6R9+e
         8Au+mbIlgdazSnJmwazJL9gJ8Syosn6KQHcLKyN8WMtsqekwJBlTxneZiXDz/FxmzFss
         gTaDWYMWxmpPbpu35MXkMrMpPiqZyNij4rC4oZPVcfFyEdU99I0Sq8iY/otcZNBxrtVa
         uWAaAABTfhbRC3CN6TnDOqLEZ6YxvS3oYHVZycDkB9cNsI0UPFT4fVpCGNSzHV+9jebz
         UWBdawXuN6yyxv6pga4jJLR3Br3rWWscNoyvkAP35HvfvwepU5Eo0xBhV1lNSlW8Lpxx
         P5YQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbpD1Bw4wSqVHyKg2UouXOKWbfnbP78X/CtdO+Q647Adidmk+9DzctN+6igdyA9U65XbDkGBiQyA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyrtjSvO7Wkpx6bySv5iyTcQnx4jot9M5fxHa6a10AiGlGkNe47
	6RcmWjh3rHvdxOWMkCPffC304FuQAnR6mGUg7EI3FcOtKLRMdY1Gw1eGv5Xla24edIs=
X-Gm-Gg: ASbGncs71mzQJ1ZVvSHaNZxU38WFPDxpSQv3vBELfDOE0pfann+tsdctgUuHJz2KlOp
	ba7KFfTAZw3D4rc6z/C4biI7ofl+gzEEMRkJRv/+G+3JI7r2gTiQ5DYyWGcWyB4BJcwjtS/NPur
	iw73Rtbvj7qjw8uPsb0JEr3Do4miIJz9gK32I7T0KGr2eNH8/8Py0BmSe+DoVmD7lkcRbOLw+Oz
	T/N92NqeAQbH92Ks7tFyXtHhVR3fzSqV812cLMYgudRLSKmxx9ZasRo8HGuEaEJK91mkRKrZL4A
	FVlaiDz2tSYV3h4Lkp47FGk1TgyKnpvxfltveBdpXya6BEvjEmWrw4umhFS/o2Me17dO9ATnVEe
	KV7dx4tHjlxYCgFudvWXsOsGWYwdPhOwNkSR2AOXBBv0YAFr38XSs/RcQKst8vxUFGwTHYNXNJ7
	Rhp6/t
X-Google-Smtp-Source: AGHT+IGC9Hyfim/WIXU0HSZmLz3yGQUf+7zNcitVSoymJQT8gmqWVT9/r/xC9HaTimOJHRaEpjukUQ==
X-Received: by 2002:a05:7022:7a6:b0:11a:23fb:16e2 with SMTP id a92af1059eb24-11cb3ee231amr1001440c88.9.1764039548635;
        Mon, 24 Nov 2025 18:59:08 -0800 (PST)
Received: from f771fd7c9232 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11cc631c236sm4359758c88.7.2025.11.24.18.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 18:59:07 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?q?=5BREGRESSION=5D_thermal/testing=3A_=28build=29_=E2=80=98waiter?=
 =?utf-8?q?=E2=80=99_declared_here_in_kernel/locking/semaphore=2Eo_=28kernel?=
 =?utf-8?q?/locki=2E=2E=2E?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, linux-pm@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Tue, 25 Nov 2025 02:59:07 -0000
Message-ID: <176403954749.358.4098701715364376162@f771fd7c9232>





Hello,

New build issue found on thermal/testing:

---
 ‘waiter’ declared here in kernel/locking/semaphore.o (kernel/locking/semaphore.c) [logspec:kbuild,kbuild.compiler.note]
---

- dashboard: https://d.kernelci.org/i/maestro:29e511d02a40e5e8aebce9a21e484b270a4ada15
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
- commit HEAD:  ca48ad71717ddda50ee8554f37061879362439a3



Log excerpt:
=====================================================
kernel/locking/semaphore.c:212:33: note: ‘waiter’ declared here
  212 |         struct semaphore_waiter waiter;
      |                                 ^~~~~~
kernel/locking/semaphore.c:240:59: note: ‘sem’ declared here
  240 | static inline int __sched __down_common(struct semaphore *sem, long state,
      |                                         ~~~~~~~~~~~~~~~~~~^~~
cc1: all warnings being treated as errors

=====================================================


# Builds where the incident occurred:

## x86_64_defconfig+kselftest on (x86_64):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-x86-build-only-69250bcaf5b8743b1f5fc256/.config
- dashboard: https://d.kernelci.org/build/maestro:69250bcaf5b8743b1f5fc256

## x86_64_defconfig+lab-setup+x86-board+kselftest on (x86_64):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-x86-69250bc5f5b8743b1f5fc24e/.config
- dashboard: https://d.kernelci.org/build/maestro:69250bc5f5b8743b1f5fc24e


#kernelci issue maestro:29e511d02a40e5e8aebce9a21e484b270a4ada15

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

