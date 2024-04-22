Return-Path: <linux-pm+bounces-6752-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D42BB8AC36E
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 06:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F55EB2118F
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 04:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698C6125B9;
	Mon, 22 Apr 2024 04:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tatbdM6C"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07ECA11CB8
	for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 04:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713760166; cv=none; b=U/5Zs/dpNgCWSyhEgnsz9GOVoaj+PMVty+I8IDkS41kqPlMWcPUla2EyGHf8+SRVETZ6biRO2UxvNvhS0jAIUDpq4OAt+TYfYrft4Lrz25jS2MRm77X2S66LXlB6H987uAwDoD2/wjOPhv1cOupZlfiH+3wdiaLWuMZSUMWn4bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713760166; c=relaxed/simple;
	bh=4+/2HS4VKURVjvO87h3V2grQP/zeYtE446bsQYu31XA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NTG5jUWr/DGIwzZJzVDx4iCp1pCZLu1Hcm3Q8Am9tBLG1Ayzy9mjEmhwQi5egNAf1DEPBuOBT4lNZPYsL4tn9+q9TGAStNnX7B406KeE3r8akqy8c2/z4/z0wgOkLknvsuLrWUgi6d6eVY+GVyCf8CiqWSf3ox/lfPCWBPoCt0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--nsekhar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tatbdM6C; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--nsekhar.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61b028ae5easo82175657b3.3
        for <linux-pm@vger.kernel.org>; Sun, 21 Apr 2024 21:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713760164; x=1714364964; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mgVxAGNMSrt9uYv5g5ZyAhdPBATWU+/rfu7QaLtr/yo=;
        b=tatbdM6C2cGTLRbb49uVCFi7M8SenEvdiVvrLlQ8z5ifVQ7sf2WI/2MXNynMJOJNjJ
         r4KJATSuEhArjYVP9Oi/4gyc1r+3gVK9l5rbRAiuhdS2OASLlfNa9JGB2k00ljj73stR
         dp232gYzHAa+2UWDY2pCnxpNpI6/9WQvBFRRFfsIcKf8bOIHx5aF4b+mlXHruEy0A9Y1
         8OXZFFNr+ecgSqTSDZl1lp2XAi5BHduRVk8VNMqUOq/j8yw/n45XMLeIYCjFKiqAXO+a
         YsIJjY7cuZqJ6jGJyCkhVLNoPfN1jK4dG9LILikqSLTXBjjFgDXtj/iGNLvyliaGAyzw
         /W8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713760164; x=1714364964;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mgVxAGNMSrt9uYv5g5ZyAhdPBATWU+/rfu7QaLtr/yo=;
        b=LsZNLvOKxCQZEVZ3Jlv1Iezz90TOLsegeJgFfAaDAkNJAWUEiGxbn+UI8Y+HEonJqG
         rCoLmAMCxQjOrDlrSR63OUfqe4/W4c9avKDqi9zRORT1HHiOuY6fXxtodP/WJBT+5oal
         GJTfoEfJW+leDtVRhFsv2REVR0e/CgFdSJ/k+E8Zltc6xTA5Tk/opvY2mMesShUxFySl
         uGm9KxQS7fauNk3dZyUUM4O7BIq/tE9KjIi+n3tM+hp0CCr3nAxmSbndWj9HKStacrOT
         tiCLV08wjr2k/vIKC0pK3dQEz7wpSf85y25BfyrnD53LEtX/Pu6Ffva8ss2PSfuXdbnz
         sYiA==
X-Forwarded-Encrypted: i=1; AJvYcCXS7RQ6u1jqHtIL6Sj+G4nLFya1Vx0skdzF4c3/18EekJ9PAzqi1bK0xEqI0otLSCc6YVzQ2kJexEDh1ZZjQX0Ag7Q6Sy5GdJs=
X-Gm-Message-State: AOJu0Yxrtnw5Pu0SSdNin2VV2SP9B9aaGKv5KkZKFxajc/Pcz+4k1Qxl
	8yufPKcd85qH2xVZBKjPYSLRKsylTCFxsjSR0Vnw0RC4zSpck8O0fXTsg/IE4hmH/v/908u4uq4
	hZPNoHw==
X-Google-Smtp-Source: AGHT+IHAldkAyvCWIImPYDllXbDnEjYLXhUW/l/he8Y1Hqbao0lNGK962N7VmeHzve4AYaJgz8ix1jY6yGa/
X-Received: from nsekhar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6144])
 (user=nsekhar job=sendgmr) by 2002:a05:6902:1022:b0:dc7:7ce9:fb4d with SMTP
 id x2-20020a056902102200b00dc77ce9fb4dmr2721213ybt.12.1713760163982; Sun, 21
 Apr 2024 21:29:23 -0700 (PDT)
Date: Mon, 22 Apr 2024 04:29:10 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240422042910.2248234-1-nsekhar@google.com>
Subject: [PATCH] docs: driver-api: interconnect: fix typo
From: Sekhar Nori <nsekhar@google.com>
To: Mike Tipton <quic_mdtipton@quicinc.com>, Georgi Djakov <djakov@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-pm@vger.kernel.org, linux-doc@vger.kernel.org, 
	Sekhar Nori <nsekhar@google.com>
Content-Type: text/plain; charset="UTF-8"

Fix typo in debugfs path name that prevents copy-paste of
commands given.

Signed-off-by: Sekhar Nori <nsekhar@google.com>
---
 Documentation/driver-api/interconnect.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-api/interconnect.rst b/Documentation/driver-api/interconnect.rst
index a92d0f277a1f..6d0a205b42b7 100644
--- a/Documentation/driver-api/interconnect.rst
+++ b/Documentation/driver-api/interconnect.rst
@@ -119,7 +119,7 @@ any arbitrary path. Note that for safety reasons, this feature is disabled by
 default without a Kconfig to enable it. Enabling it requires code changes to
 ``#define INTERCONNECT_ALLOW_WRITE_DEBUGFS``. Example usage::
 
-        cd /sys/kernel/debug/interconnect/test-client/
+        cd /sys/kernel/debug/interconnect/test_client/
 
         # Configure node endpoints for the path from CPU to DDR on
         # qcom/sm8550.
-- 
2.44.0.769.g3c40516874-goog


