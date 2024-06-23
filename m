Return-Path: <linux-pm+bounces-9835-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AA2913DA9
	for <lists+linux-pm@lfdr.de>; Sun, 23 Jun 2024 21:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1582FB21A4B
	for <lists+linux-pm@lfdr.de>; Sun, 23 Jun 2024 19:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C7518307E;
	Sun, 23 Jun 2024 19:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMhugZUl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12192AEE9;
	Sun, 23 Jun 2024 19:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719170394; cv=none; b=CxOocRj+GYQB94fIi2OUCtCYE0L6kO3NQ+W2m1g6mwqx12+FOJeIE2WcD/K7CzutCRjOB243G4YJkyqb0Wn0oLS0XMgw1e60IzG6hcnTy2oj7WiWNLnZuk0bqhqmVsebFFoEhbsUS/zRtExcBAu/LiFquXsRCBvpyxgg7L2LTg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719170394; c=relaxed/simple;
	bh=Ws7hGvjZkiJzCUTlmGX2m+s5i54lyChXPotsqc0/pbk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=O6L/Q0DhUcIqP3qovPcYoYRkP4SkWKZqj1sq4TJVRaUl1Y/IjqTqjBVJDxfpYhKHk0riAxT1/evR1BRn1ptYaEXUh3/D/eBySroesEEFrUQcf5sPBrhF+mnfVY6SvaFs7O+v7x7O6lBOUXK+mc0RmDbtdaS7f6sszlWfE8V7Vl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XMhugZUl; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ec17eb4493so49531161fa.2;
        Sun, 23 Jun 2024 12:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719170391; x=1719775191; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MHw6pZIKtndeIkJjiBOSG5ktlR30QStxLBqGrPo4stE=;
        b=XMhugZUl+nqRv59V0OhynYJRFDuZfEmA+fe5tFyafzIeQla4PivvsMWBsjLM9ANk1i
         b+bjga6+UZQiDN4wydTF7FU/s71GSbtFJhbgYjOzMpIZev3AcYYtpqw81QGFiNPuwpNr
         shFOVt7nX1zayhbGMm3OFIUJZwWRcK38kXBxN0FgGXxfPEyH5E6Jz93igq7Sg9U8h/7o
         S5hI3n5KUKo3cBqyPQ2VAKQYlsZXH3LBp7DOcsM0o2fDCH3NZif/RHLmMOUEEFuAmOi4
         DjJuI0oBSqeA8rpEzSZ3+DXj1WjcIoOxyz9xrjvYoChfecNEHoQYm+swwXcjir+F0UTe
         XtlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719170391; x=1719775191;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MHw6pZIKtndeIkJjiBOSG5ktlR30QStxLBqGrPo4stE=;
        b=BlhZ/2V1u3A+D10Ov5VfdV1QP19sn/PPJkd3Q0olLh4QSotr3RNym3Kgr1Qjdlj+IO
         xCDM2dBH48cPynNd8y+lnrlhHw0xAnoXapnGkmYP09od/W97YPLIsK4ljH2bksKSKbXL
         83CAvlyj2nmiJzhNBZ1FzaVpFyiSxBQ6QDHZ+CNX0dKZCqAjI0fsAULhXArvTMJpzgxp
         RilyVwjly5epHcukAh5CsLFkhSuiY5ZrbO8IorCBcUjRovHm7RtBSoJ3OPRMXuTkIIcH
         5rVZ3HwSVGEmP61T1p28rNRdZeA9DF1oO5z30fe62KMXPnTrgBwdkISyc3KoadfWl6ga
         mLsA==
X-Forwarded-Encrypted: i=1; AJvYcCXIdxWtaaGm6W5NcPyA9dZMIFrbDeENhrTxxa3ilb1p35Yxw1WBVcBeNWsnzSM/GH8JlZG2bOsLweB50IKqw5JYx+gVEAajcSh+o0DuSFEHlYywasyVrmTxxZzqQpVgwKI3OgqrhZU=
X-Gm-Message-State: AOJu0YwQJ3lehWARjfvQpA79Bm9EQutKlv7t/XasIPYZyzEuYXeFea6K
	we1E33tzQESivlxxWy0tmkciQqYCU7Hc3kF86JJfUJZKdaw+H3qz6afS3g==
X-Google-Smtp-Source: AGHT+IH00LgM/ceDlja7GeFcDFgy5Ff2CYRCj5rbFwPfnV7LsZ0hRzqWiFVrfIgorPn9EX3b/6TYbA==
X-Received: by 2002:a05:6512:a8b:b0:52c:de43:808e with SMTP id 2adb3069b0e04-52ce185275cmr2281702e87.49.1719170390353;
        Sun, 23 Jun 2024 12:19:50 -0700 (PDT)
Received: from [127.0.1.1] (31-179-0-202.dynamic.chello.pl. [31.179.0.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7255b56e48sm22075166b.176.2024.06.23.12.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 12:19:50 -0700 (PDT)
From: Roman Storozhenko <romeusmeister@gmail.com>
Subject: [PATCH 0/4] cpupower: Add 'help' target to all the makefiles that
 don't have it
Date: Sun, 23 Jun 2024 21:19:40 +0200
Message-Id: <20240623-make_help_rest-v1-0-4bd3fd51064b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEx1eGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDMyNj3dzE7NT4jNScgvii1OIS3VRzS0sLC8s0E+NEQyWgpoKi1LTMCrC
 B0bG1tQCqJ+ajYAAAAA==
To: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Roman Storozhenko <romeusmeister@gmail.com>
X-Mailer: b4 0.14.0

This patch series adds the 'help' target describing all the user-available
targets to the makefiles which haven't had that target yet.

Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
---
Roman Storozhenko (4):
      cpupower: Add 'help' target to the 'bench' subproject makefile
      cpupower: Add 'help' target to the 'debug/kernel' subproject makefile
      cpupower: Add 'help' target to the 'debug/x86_64' subproject makefile
      cpupower: Add 'help' target to the 'debug/i386' subproject makefile

 tools/power/cpupower/bench/Makefile        | 12 ++++++++++++
 tools/power/cpupower/debug/i386/Makefile   | 12 ++++++++++++
 tools/power/cpupower/debug/kernel/Makefile | 12 ++++++++++++
 tools/power/cpupower/debug/x86_64/Makefile | 12 ++++++++++++
 4 files changed, 48 insertions(+)
---
base-commit: f76698bd9a8ca01d3581236082d786e9a6b72bb7
change-id: 20240623-make_help_rest-e799889f43a1

Best regards,
-- 
Roman Storozhenko <romeusmeister@gmail.com>


