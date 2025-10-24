Return-Path: <linux-pm+bounces-36796-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEE4C07899
	for <lists+linux-pm@lfdr.de>; Fri, 24 Oct 2025 19:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 48AAD4E9346
	for <lists+linux-pm@lfdr.de>; Fri, 24 Oct 2025 17:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D763431F6;
	Fri, 24 Oct 2025 17:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvekdrI1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D9832F771
	for <linux-pm@vger.kernel.org>; Fri, 24 Oct 2025 17:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761326980; cv=none; b=EOOjhqkQjD6skH4c96S2zDiDZqlKFk4/8+cyGZbQw6RrB+PjgdtXTT38PB9do1wk0B9rLoXT/ZDm7j8lmxbgDFK1sQEbUSDgaxG9hwut1pjpiLo8alcXD2Saj57uOgMzqxoqYkL9UvUpBDO9sK0sFPuNnKtpRAEeEs6HgqS6M/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761326980; c=relaxed/simple;
	bh=tkAGkZZm4VXBDBIYaN4VChrZKvpzE6+s6VHxe8EmXVs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DXcnGoi8tALVsJ8BGtBkbOZylr/4elnPnDrpmFqJHVxUIdOUklQ6gTQSdcMDNdmNerxCmwPRDbBDDlVozcoqfFAqVhgWsaT4GpYzZHc2m1nxdQmMtt+T3nSxzSayCigFA83Kni19fWTEoQMc2FZ6LsmZ8cMNNKLnjmdY9HWdtxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PvekdrI1; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-794e300e20dso3133364b3a.1
        for <linux-pm@vger.kernel.org>; Fri, 24 Oct 2025 10:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761326979; x=1761931779; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cN7ZMnvf82THEzrEsUSGywR0GGJwzb8nUT5u5I/IIf0=;
        b=PvekdrI1sfGT/nnrDK/4lvinqsF0m20DVEwXO0UX9hqTyKcp4E4ARfEaUZvOvgYGQp
         jk/ZQ3LAct8fwMMLSl66z6DoLfMgmF8H9m9cEO6sxxTAeN+z8GFitULOoQ57p+b3vf4T
         tHq9PWml9e7wyq9dXJ79D6Wzm6lY8TrANZk+YaosMRIcNlMPadDItX7CbDeLlw38rmyl
         FzAwqVcv/337/WLkbtEFKPCZhTfj/nsJzp3JDSwLu/lZPgrLi3422ojpckVRcml22Fcd
         f+ccTzC3XmmBgelIAjKkLw8zk+Q7JA/ta/m5IWN+dXRuxI5FchvLRi256mQQL5a6POZn
         LkIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761326979; x=1761931779;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cN7ZMnvf82THEzrEsUSGywR0GGJwzb8nUT5u5I/IIf0=;
        b=kxoBhwP1AW4FEAhWDpYEmwzR8e8ACd3vn6mWtWCbunxeuwj4QwHfk+1e2kaLCRxWxV
         G2foPdPmXsaMItYIjZ/CjR6b8ttrIpMCZB/DuXNI0Qn2LupMIKYzAZP9pYcHnymURj87
         ULucwZtPhUwXx5SfsYoLVR4xssU3xd/kSosUeQKUFzcqW/h+9lyy7wLqWoi0M8ko/2Zc
         Mgw6jFySfwU5+9UuPryuMHJTT3597+uk0rfMJLXkqT+sRO2452/mzPy5HFuBnBHjMPvR
         4ImQCtCU9K6yIqJ5DtBQ4QmXuxBK2aqLLlxBmfND1fLUKV+QE1CtNbr5sBU0O9Bne0ms
         oUWA==
X-Forwarded-Encrypted: i=1; AJvYcCX1Exe/mTwdA+xdgXgTvwhHNUeJmn7ssYloLJbaN4Of6qagLLsiAnw/fvk9nUsrYtD7lbQPxzi7Fw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5qi8PWCO4i1qSds/U/CnctHBcUxcrxnbdhqJIiJKAKYiEiiLh
	hyeukKgOoG9lBt/QRl5fHF1LNYxs4tPSnF+dVsD1fGCQTjhheGFYimvd
X-Gm-Gg: ASbGnctfBgFvoECh6kd1ntZ1bEMA0H76Y8D1COPLD7vEBQfcPh92QpfDxamjUAPCIx3
	X9cmcpNAUMZWg0bpEcC3V9gk5igQc1un5P7Wu3pBub1fV/L6PPVy48JlvgtualeYa9g9kme9hX3
	jFrp6PTuvI3aL8cWNBP591VMmw9VC2OxRfnkUPJuu16/+NkI7mfIvq7OEhTY6nSKhLN7ZogClC8
	rEK0OIFhyh7WdnjxeQ3bbyA+vXQnd06URbL+oUifL12P+IuAZ+LNPaEsrNEc6Ngs0PgiFAAc+Zq
	IpiCwc5lgfmw/nTIhTcVvGfFHBL6Jpqz/8f5vhdnsOf3tHiYUHdHzG7t5aimi1chMlcg+rhnkkD
	8qu70lyIwdCIPsM57fVqLZ3l2K7n9BF2NHr32DYlk9ewUMCTWvrIjlKKim9BmCPmm/Hok/127JA
	yaNjI7va+x8w==
X-Google-Smtp-Source: AGHT+IExEqGK30pExEfkyV0gBzPWyWgac7N27+lB/OIuXkwNcep/BAxe9MOY1u0pDHlpOqqViu7rWw==
X-Received: by 2002:a17:903:1aa4:b0:271:9b0e:54c7 with SMTP id d9443c01a7336-29489d970b9mr43892925ad.11.1761326978569;
        Fri, 24 Oct 2025 10:29:38 -0700 (PDT)
Received: from aheev.home ([2401:4900:88f6:d7b0:8f5e:ff90:677:7d74])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946dda85e7sm61719615ad.11.2025.10.24.10.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 10:29:38 -0700 (PDT)
From: Ally Heev <allyheev@gmail.com>
Subject: [PATCH v2 0/2] checkpatch: add checks incorrectly initialized
 pointers with __free attr
Date: Fri, 24 Oct 2025 22:59:14 +0530
Message-Id: <20251024-aheev-checkpatch-uninitialized-free-v2-0-16c0900e8130@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGq3+2gC/5WNQQ6CMBBFr0K6tqZTg6gr7mFYDGVKJ0IhLTYq4
 e5WbmD+6v3Fe6uIFJiiuBWrCJQ48uQz6EMhjEPfk+Qus9BKl6A0SHRESRpH5jHjYpx8eva8MA7
 8oU7aQCRLc7raqiRQCCKb5kCWX3vl3mR2HJcpvPdogt/7nz+BzLvYVkFrzlhh3Y/Iw9FMo2i2b
 fsCM2iMA9YAAAA=
X-Change-ID: 20251021-aheev-checkpatch-uninitialized-free-5c39f75e10a1
To: Dwaipayan Ray <dwaipayanray1@gmail.com>, 
 Lukas Bulwahn <lukas.bulwahn@gmail.com>, Joe Perches <joe@perches.com>, 
 Jonathan Corbet <corbet@lwn.net>, Andy Whitcroft <apw@canonical.com>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>, 
 David Hunter <david.hunter.linux@gmail.com>, 
 Shuah Khan <skhan@linuxfoundation.org>, Viresh Kumar <vireshk@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
 linux-pm <linux-pm@vger.kernel.org>, dan.j.williams@intel.com, 
 Ally Heev <allyheev@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1425; i=allyheev@gmail.com;
 h=from:subject:message-id; bh=tkAGkZZm4VXBDBIYaN4VChrZKvpzE6+s6VHxe8EmXVs=;
 b=owGbwMvMwCU2zXbRFfvr1TKMp9WSGDJ+b69OE5hxadfN1B8RE+/t1/v38+M+v2mXV02b+ibwy
 RTbqltrGDpKWRjEuBhkxRRZGEWl/PQ2SU2IO5z0DWYOKxPIEAYuTgGYSN98RobrNh8nPlTt+yIv
 o7H05CzFCQ90xZUdSmK0pRZt61+9/ZYFI8PGVKNg1e3zBZY/XzH5WdJnhja9wN7oZ1abNCadFDc
 4ocEGAA==
X-Developer-Key: i=allyheev@gmail.com; a=openpgp;
 fpr=01151A4E2EB21A905EC362F6963DA2D43FD77B1C

Badly initialized pointers with __free attr can
cause cleanup issues. So,

Adding checks for
- uninitialized pointers
- initialized pointers with NULL

Testing:
ran checkpatch.pl before and after the change on 
crypto/asymmetric_keys/x509_public_key.c, which has
both initialized with NULL and uninitialized pointers

---
Changes in v2:
- change cover letter and title to reflect new changes
- fix regex to handle multiple declarations in a single line case
- convert WARN to ERROR for uninitialized pointers
- add a new WARN for pointers initialized with NULL 
- NOTE: tried handling multiple declarations on a single line by splitting
        them and matching the parts with regex, but, it turned out to be 
	complex and overkill. Moreover, multi-line declarations pose a threat
- Link to v1: https://lore.kernel.org/r/20251021-aheev-checkpatch-uninitialized-free-v1-1-18fb01bc6a7a@gmail.com

---
Ally Heev (2):
      checkpatch: add uninitialized pointer with __free attribute check
      add check for pointers with __free attribute initialized to NULL

 Documentation/dev-tools/checkpatch.rst | 11 +++++++++++
 scripts/checkpatch.pl                  | 13 +++++++++++++
 2 files changed, 24 insertions(+)
---
base-commit: 6548d364a3e850326831799d7e3ea2d7bb97ba08
change-id: 20251021-aheev-checkpatch-uninitialized-free-5c39f75e10a1

Best regards,
-- 
Ally Heev <allyheev@gmail.com>


