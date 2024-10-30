Return-Path: <linux-pm+bounces-16698-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 640939B5BEA
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 07:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 964DF1C20F3B
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 06:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC021D2B23;
	Wed, 30 Oct 2024 06:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJ9YwDfM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E527C1D0DF4;
	Wed, 30 Oct 2024 06:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730270664; cv=none; b=onQ5DAvlbslw0+5wIiiZvur4dGympmdnyAgk3IrlP22lQpsx2RM9trAvYg9acCyfr/WQspRPLgNwdwfZZVLilrW1esRCskkbxCVZ2Gt2CNhP8dBhGb3Gpyz23TOqso28GjAOQtXm0BU833RSDiZ/sQHhFwdLfFzJtz0Gsc52XsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730270664; c=relaxed/simple;
	bh=BpGY/eDm3rqBN7WhGt8Gp/hzEZK3r2dryyGFB17Y+qg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ASmtVEq5b1Xg+k9kOsCnbYRKIEriEuRW3fhhD4e5rOsBiMSWbD40Epgt1plbPYGM4HIG2OwpDgisTZ98QkpYMSm2M2+4kd2McuAfS2f62DRVr9sMzRaWwCjpZIUXPNhI9Mpuz3cFsYYO4PMSmuhVrQN2dnX3IybvHn0O99Ke0QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJ9YwDfM; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4314c452180so3143435e9.0;
        Tue, 29 Oct 2024 23:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730270660; x=1730875460; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MmAW25Xq+08xhdq2HO0pkvHqB0sZSIrEGg3huWOKOV0=;
        b=bJ9YwDfM9WR40TyHVxNQpul4GW63hPhQHNuzxU0Nob2RPPwrBBtMLOehci5CtLX6hk
         yrw/7A3BqJDL1KQEwqJyg9EPgFXjGg5zxL6lruKoVrfDJgDpvNIo/rq+9dzP7pwzrU+9
         S50/JMUdailKcdBMhLUTyswRMWqftefiKhG77GfaidlVq5yMice0/o3aHBHRzQNwFqDR
         BF/mSx1yu2Tbj+zKp1T+GGchquBSfNFn/B3aDLsLEWugV9xaRVf1IbyD8xKkZLA7RyxJ
         LZQjh4pZpOb8DD5MGOGt95P63N7GnQdJkOx9z5s7WbvnsgL1xjJP8+VMQE10pX1yVYFu
         z3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730270660; x=1730875460;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MmAW25Xq+08xhdq2HO0pkvHqB0sZSIrEGg3huWOKOV0=;
        b=htbgSYkGt6ascaiyumS9kXLJ15OITP70mK1Es0YXVwqPNsYkIWANQvKVmdVMtNPB6f
         S38ww5z+91Ug9k7MDaV7OyQW5Z1mk6tr2YsZTABwihSUKEoKborBjIkQ1alkJUg2hsbq
         HNjqa6nC802M/M/MI3pZBMH2xL3Gt1TK0saHXOrX4+AG1Dwln6/O15wR2mIDatwTQMLI
         CDdqB3f4TZNfVJAof5QPm4sM69BFqgkjWS0Nnox6N6AU6A/71p00cK4bNI4EqpQsM4+l
         jk66E3pluvnH24T7ZmVkZk/+khKR2crhl3YS1lEZBbFXy6hCMHb4mHYBb293CO6ojbk2
         4DXQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0GEealsU2l1C7C6jOijtAIW7GUrnoHJyMSgaVsEhg2p6NRUU9orX6GOJKyw7bMdUnXZj3/DFqhpA=@vger.kernel.org, AJvYcCWCF/6ZX6onaLWQnAinOtnaZFc/zGvVCQ7QXZYV3HG6WUtH/WLFk9zQuZJYrPwJedQWfbsmritI3z9HewE=@vger.kernel.org, AJvYcCWmBrYB7W/cnNpeoSM0RYfz7Lw8zBbHCB9/ktPSd0iy4zflbzyE9w4uZ3vpM7oAPABBbzCr/77/@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsgdh0gs6VxV+P8S9MerLRbufDR+vVAG5opNFYZkNBSeBjw892
	KiGMt6Quiu661VTotDyJPppUfHfy++F2E9muZBYviXx6FIF1Nun+5NRxweJs
X-Google-Smtp-Source: AGHT+IE04UHobsipZRhjEUzyXYGDVgV5T/lYJ6JQc+mK46hY0hvvTcPS2K/ZH1cAZUvWtfyIwLDZ5A==
X-Received: by 2002:a05:600c:1990:b0:42c:b826:a26c with SMTP id 5b1f17b1804b1-431bd703983mr8293365e9.8.1730270659725;
        Tue, 29 Oct 2024 23:44:19 -0700 (PDT)
Received: from [127.0.1.1] ([213.208.157.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd9ca704sm11249655e9.41.2024.10.29.23.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 23:44:19 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH 0/2] cpuidle: riscv-sbi: fix device node release in early
 exit of for_each_possible_cpu
Date: Wed, 30 Oct 2024 07:44:08 +0100
Message-Id: <20241030-cpuidle-riscv-sbi-cleanup-v1-0-5e08a22c9409@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALjVIWcC/x3MQQqDMBBG4avIrDtgYhHiVUoXZvK3DkgaMiiCe
 HdDl9/ivZMMVWE0dSdV7Gr6yw3u0ZEsc/6CNTWT7/3T9T6wlE3TCq5qsrNFZVkx560wQhwkhhF
 uTNT6UvHR4/9+va/rBjbbwBRrAAAA
To: Anup Patel <anup@brainfault.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Atish Patra <atishp@rivosinc.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-pm@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730270658; l=1106;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=BpGY/eDm3rqBN7WhGt8Gp/hzEZK3r2dryyGFB17Y+qg=;
 b=Fi6G0zA8GxCLTTdxKa+iqQDjcH+qVUO0DqHCmAOYnKZNPnjqlM26MfkkjHWg5JOGPx43G+3hI
 BaHi4Gjt/YkDDRSSo/e1d/N6fxTxCtY3SXoh1IxP9YGLfFYEhCmY8qE
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This series releases the np device_node when it is no longer required by
adding the missing calls to of_node_put() to make the fix compatible
with all affected stable kernels. Then, the more robust approach via
cleanup attribute is used to simplify the handling and prevent issues if
the loop gets new execution paths.

These issues were found while analyzing the code, and the patches have
been successfully compiled, but not tested on real hardware as I don't
have access to it. Any volunteering for testing is always more than
welcome.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Javier Carrasco (2):
      cpuidle: riscv-sbi: fix device node release in early exit of for_each_possible_cpu
      cpuidle: riscv-sbi: use cleanup attribute for np in for_each_possible_cpu

 drivers/cpuidle/cpuidle-riscv-sbi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)
---
base-commit: 6fb2fa9805c501d9ade047fc511961f3273cdcb5
change-id: 20241029-cpuidle-riscv-sbi-cleanup-e9b3cb96e16d

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


