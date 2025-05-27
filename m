Return-Path: <linux-pm+bounces-27684-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64806AC4F19
	for <lists+linux-pm@lfdr.de>; Tue, 27 May 2025 15:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAD223BF87A
	for <lists+linux-pm@lfdr.de>; Tue, 27 May 2025 13:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DFA27145C;
	Tue, 27 May 2025 13:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="q3xlNA0K"
X-Original-To: linux-pm@vger.kernel.org
Received: from jpms-ob01.noc.sony.co.jp (jpms-ob01.noc.sony.co.jp [211.125.140.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9446526FDBB;
	Tue, 27 May 2025 13:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.140.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748350819; cv=none; b=HS1bKVfkiIxfNnI6DM6WfenGMNRA0MqWU5QYBKeVk441CjH28uJ1YzSphV7t0qRxUlF+qs684cukhdobGCL3Y43cslsaSlRZpxlOJ+SmOmK3oA7sFRMYOLLpW+aFEew2XwYiL5j4MI0+6awdTFDsPX3Svbi4PuwIQxl7+Hurtn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748350819; c=relaxed/simple;
	bh=6AiBnz+NtthXTl7ipClTn38s9n5ZuPe1WkRCyxo4yFc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ln3PXDDAnlwHX20JKmpXoDS6+ZO1u8ssg39rG2NfiQXFXdOb8ObmTV2bWVxgXPHlEhsL+60PNkheF98uFlk1RtzCJwxzOE/RNwTVJ+rjFxVFR1L8ZS9XJFw6z4panTfGS2fI+tMKL8KlRtlxcSDpEHBEvMH0sBfprYOiMt8Buo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=q3xlNA0K; arc=none smtp.client-ip=211.125.140.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1748350817; x=1779886817;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=2UYaaE2+OTCkjb9XKZqJZIC2PXKJNvGod0gjUbVzluY=;
  b=q3xlNA0KKVH8AA73Qv/1pDYRJG6ouhuGLdLlZhf1vpa/qet3jeBNNw9O
   qRUyt3v6w53LCKE9qXjze/4+G8bfSX2yjfPR8zN5ifar03RGw90WdsKlZ
   73CGcN6UKihAxFYjcxcskxIH3RHVAJSsdYOqxb/vy14TWjyKsnD+ck3Wb
   YzDsBvq/Fo4LOlAKMB+UX+dA1FnOtbkbylzHB5D/hxJUahmR9sLR4dOgk
   VlaymKENvFi9t/bzsBR3RXWSEQu0AP++CKGNnfKHKKR+664epjJ4LfJrD
   cWQJaFRJ/0A8gMYuL5DF2ydvVlETo0q1dYeDqnQQlMPG8sQJxBQS2N5r2
   w==;
Received: from unknown (HELO jpmta-ob1.noc.sony.co.jp) ([IPv6:2001:cf8:0:6e7::6])
  by jpms-ob01.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 22:00:14 +0900
X-IronPort-AV: E=Sophos;i="6.15,318,1739804400"; 
   d="scan'208";a="564893578"
Received: from unknown (HELO [127.0.1.1]) ([IPv6:2001:cf8:1:573:0:dddd:6b3e:119e])
  by jpmta-ob1.noc.sony.co.jp with ESMTP; 27 May 2025 22:00:14 +0900
From: Shashank Balaji <shashank.mahadasyam@sony.com>
Subject: [PATCH v2 0/2] cpufreq: userspace: add CPUFREQ_GOV_STRICT_TARGET
 flag
Date: Tue, 27 May 2025 21:59:08 +0900
Message-Id: <20250527-userspace-governor-doc-v2-0-0e22c69920f2@sony.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABy3NWgC/4WNQQ7CIBBFr9LM2jEUxKAr72G6oDC2LGQaUGLTc
 HexF3D5fvLe3yBTCpTh2m2QqIQcODaQhw7cbONEGHxjkEJqoaXEdxPyYh3hxIVS5ISeHZqzMsK
 PdlReQ5OXRI/w2cP3ofEc8ovTuv+U/rf+TZYee3TGCmVIXYQ53TLH9ej4CUOt9Qu/UAUFuwAAA
 A==
X-Change-ID: 20250522-userspace-governor-doc-86380dbab3d5
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-pm@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Shinya Takumi <shinya.takumi@sony.com>, 
 20250522-userspace-governor-doc-v1-1-c8a038e39084@sony.com, 
 Shashank Balaji <shashank.mahadasyam@sony.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1158;
 i=shashank.mahadasyam@sony.com; h=from:subject:message-id;
 bh=6AiBnz+NtthXTl7ipClTn38s9n5ZuPe1WkRCyxo4yFc=;
 b=owGbwMvMwCV2mPH4Ij++H1mMp9WSGDJMt8d8OvJWer1tQL9Y06ONd/OzS15Uv+ORlJNUrn1TL
 m6sfk+7o5SFQYyLQVZMkeWdzLoLB60sm74eZ/gGM4eVCWQIAxenAExk4mSG32x37z/zmTPhCGdc
 hEj0o3NyjEYRttsP6LKy/I18dujq/RmMDBscVs44adPTe+fAj113BRZHPztkYzXhQqLnPIaKfw1
 svxkA
X-Developer-Key: i=shashank.mahadasyam@sony.com; a=openpgp;
 fpr=EE1CAED0C13A3982F5C700F6C301C7A24E0EF86A

In-Reply-To: 20250522-userspace-governor-doc-v1-1-c8a038e39084@sony.com
Signed-off-by: Shashank Balaji <shashank.mahadasyam@sony.com>
---
Changes in v2:
- Instead of modifying the documentation to say that variation in frequency is
possible despite setting scaling_setspeed, add the CPUFREQ_GOV_STRICT_TARGET
flag to the userspace governor to make its behaviour match the expectation when
used with the intel_pstate driver with HWP enabled
- Mention in the documentation that variation in frequency due to hardware
factors is possible
- Link to v1: https://lore.kernel.org/r/20250522-userspace-governor-doc-v1-1-c8a038e39084@sony.com

---
Shashank Balaji (2):
      cpufreq: userspace: set CPUFREQ_GOV_STRICT_TARGET flag
      cpufreq, docs: userspace: mention variation in freq due to hw coordination

 Documentation/admin-guide/pm/cpufreq.rst | 4 +++-
 drivers/cpufreq/cpufreq_userspace.c      | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)
---
base-commit: 914873bc7df913db988284876c16257e6ab772c6
change-id: 20250522-userspace-governor-doc-86380dbab3d5

Best regards,
-- 
Shashank Balaji <shashank.mahadasyam@sony.com>


