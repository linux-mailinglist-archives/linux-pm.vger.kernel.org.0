Return-Path: <linux-pm+bounces-38518-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 534D0C83289
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 03:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2BA0E4E2744
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 02:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D40C1E231E;
	Tue, 25 Nov 2025 02:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="2QV1TApF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03DD1E0DD8
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 02:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764039548; cv=none; b=MDEsBa5eAvCWEPTNSoNrWTu52VXwEUmmNLa0PWMtTkq6NvwhC0QjKx0YESEcUtFpmiSMRFxpEHRaNzNUhnbxZaTTstHhEfSl1dTwS295kZbWcEHVbMPtTVy7gKdTBHIy0I3BhGEsmyZO9rRb5KkLGYUYlgSSAa87bvExHKdqFrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764039548; c=relaxed/simple;
	bh=6zIONrWFOjkJwgpLsCpLLhdfVRiEt33lRR9lWpCJ6hA=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=iXNzg8vjQ+wJpkSeNwkdU1+eF6WvFsPzbGl62AChT6PBU1gC6lG/tfTVK2n3hDmAzTdODBrmUxY+Dey7VRewSy4GZ2aFex/vNiY5MNhZUZd14dmnBvCi3KgmfwGvHVXmFVYHZagYFlAJ/yrqUQJbxJ8AzrJkrWYorBnh5CcNArw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=2QV1TApF; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7acd9a03ba9so5662233b3a.1
        for <linux-pm@vger.kernel.org>; Mon, 24 Nov 2025 18:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1764039544; x=1764644344; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dbn/rYR1dj4se05KzQaG+W4TdzOK+ygJl5vQ9VaVe9w=;
        b=2QV1TApFY8oyRgam+4M5mQ8Jh5h8+6q0qewgXwJQypT8zT/tQux0K/WoszjrPOtfa3
         xwpffG7zhjMO3mZ9YngDefOJEt9XR2OmJ4Zn3m+lIMUXjzSpqUxJyYSVx2yVdsig81Rq
         oOtYM5uH7ZptaTz5c04gKPIsoDGnL2aBJCtBhF63LlBXjSkuCVf572BVkKE0kQEIj370
         UAZqIkk2k+6MqO+Ayf/QltVnIyYfLVkpl2a7yHyF2s8+09YaSimTCS/NPP/9tyPJh4Zh
         Kq2xj3piMVbipe3DcAiKzX0Cp3h9wJD/9x1AXKMD9MT4V1d/eeRkujUFHKCnaLmkjdK1
         IGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764039544; x=1764644344;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dbn/rYR1dj4se05KzQaG+W4TdzOK+ygJl5vQ9VaVe9w=;
        b=Qfms51IKTPVbVR5eput1/N4vw1BHl+UMY9UbDvxTFH9qiL8j9yj7he24o2Sajo/xmS
         HCkkb82IZRLZ5R5zWIjdE6wN3B9bfhLVOV2+mrQmcLAOTWPdhpueALfNs533QndKxr9F
         ndyEkaWTZXmrr/bhe+yJy3L+y52Ak/yz9IudFTvstFa/rD6D6q2lDs1xFX4GNUEndHEq
         z0bls0Vln5oH52sPajWw6ASBr1pmWS+B57Kp1Emmbo8JYG9ZE0LQBw0Qrz/mrNn9bq7Y
         W9gLztDRp3M6RuVa5zN2gbI/Wq+CxuuvtrLo3/T06k+UVuz6Y0waQcaNy58IPMwQ1I2t
         E+Fw==
X-Forwarded-Encrypted: i=1; AJvYcCW6vFk8BMAJY1E67e2+myMXVZ9jPzhNA/qgWAyrGWccu5f41ZfkXuB9HG67lkP+8lYzrylXsfanwA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxwgBj1qh3gCuE3qfN22G2vO9bqxlc4klIbpmhqjPF0a3k8jPle
	VFz/PTiuZqkP8ZtnVyFJK5B7VANOq8/w7gqEZSO1VQBIuaHckPrs8u8wrB1HWL91p7dL3JYNwiK
	71E7jYHY=
X-Gm-Gg: ASbGncsHK8dfRRRWwz0gZKxneqjB4JJjsY6ypAAEEurnJLDr5Z8PzTT0G1fuAH2+I1N
	FkDK59QwRmGIaD9qjYMRyKjVXP63u60IgCvW9vctIYvvKnNTdqvrmTmQyKwpeRzClpgPbKNIvmI
	CbvIFo2WOys/y9cTFnl9ADa56d8tFpNNnX5vIL36XndykfXNh2svBLZnOzKdYF8edeZkf3i2pjA
	scp3z7hhLHcVe1nE0R8LTKxwypdbDT3CCMY4wcgJ1nlHHOpQ3ux6LSMauxCfhZiXXoHZHFALfh5
	u3i4mr31cnOTBO0X2jukR12nKppLTA3J0awDs/450yu07DzcczZ4iCTr5Krh2xKIG1SAcas6cb4
	XdVD4Ght2VNz5k7SVSMFozT1aDktp+HoMMuAGgEsIPz6TlUOZOsb80V8eob7OX4XrxKPIToQVWE
	bIZTSEQlXYuZGj7XM=
X-Google-Smtp-Source: AGHT+IF3ZZ3fQlFIqJkyeYbjTLZOtGoT+mUpltJyLqRT26a9VGgJbaG+b2mPBhFMnJ9KbutJzXV1Gw==
X-Received: by 2002:a05:7022:a8c:b0:119:e56b:958c with SMTP id a92af1059eb24-11c9d7153d8mr8187102c88.17.1764039544335;
        Mon, 24 Nov 2025 18:59:04 -0800 (PST)
Received: from f771fd7c9232 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93e5674csm76551652c88.8.2025.11.24.18.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 18:59:03 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] thermal/testing: (build) cast from 'void (*)(struct
 callback_head
 *)' to 'void (*)(struct r...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, linux-pm@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Tue, 25 Nov 2025 02:59:03 -0000
Message-ID: <176403954305.358.17321672829642880147@f771fd7c9232>





Hello,

New build issue found on thermal/testing:

---
 cast from 'void (*)(struct callback_head *)' to 'void (*)(struct rq *)' converts to incompatible function type [-Werror,-Wcast-function-type-strict] in kernel/sched/core.o (kernel/sched/core.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:5c62b04b94caf918bd860d772b299e78e084a809
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
- commit HEAD:  ca48ad71717ddda50ee8554f37061879362439a3



Log excerpt:
=====================================================
kernel/sched/core.c:4750:10: error: cast from 'void (*)(struct callback_head *)' to 'void (*)(struct rq *)' converts to incompatible function type [-Werror,-Wcast-function-type-strict]
 4750 |                 func = (void (*)(struct rq *))head->func;
      |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
kernel/sched/core.c:4763:10: error: cast from 'void (*)(struct rq *)' to 'void (*)(struct callback_head *)' converts to incompatible function type [-Werror,-Wcast-function-type-strict]
 4763 |         .func = (void (*)(struct callback_head *))balance_push,
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  AS      arch/x86/realmode/rmpiggy.o
  HOSTCC  certs/extract-cert
  CC      arch/x86/entry/vdso/vclock_gettime.o
  CC      arch/x86/events/intel/ds.o
  AR      arch/x86/realmode/built-in.a
  AR      arch/x86/net/built-in.a
  CC      arch/x86/events/amd/uncore.o
  CC      mm/filemap.o
  CC      arch/x86/kernel/fpu/regset.o
3 errors generated.
  CC      kernel/locking/semaphore.o

=====================================================


# Builds where the incident occurred:

## x86_64_defconfig on (x86_64):
- compiler: clang-21
- config: https://files.kernelci.org/kbuild-clang-21-x86-69250ba0f5b8743b1f5fc223/.config
- dashboard: https://d.kernelci.org/build/maestro:69250ba0f5b8743b1f5fc223


#kernelci issue maestro:5c62b04b94caf918bd860d772b299e78e084a809

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

