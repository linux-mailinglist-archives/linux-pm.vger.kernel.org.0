Return-Path: <linux-pm+bounces-27686-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B8FAC4F20
	for <lists+linux-pm@lfdr.de>; Tue, 27 May 2025 15:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B501D3BFE57
	for <lists+linux-pm@lfdr.de>; Tue, 27 May 2025 13:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2DC27467A;
	Tue, 27 May 2025 13:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="IVNUtryi"
X-Original-To: linux-pm@vger.kernel.org
Received: from jpms-ob01.noc.sony.co.jp (jpms-ob01.noc.sony.co.jp [211.125.140.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB8B27144E;
	Tue, 27 May 2025 13:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.140.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748350824; cv=none; b=FfaLS6cPoEKmbIejWTZCpR+IZZwLbk0bxf0p6ZqCo5yw0XWioa9vdJbDOUWp0+30OR/kwYo9ovcbYNTlognySqRfRvpvQ/QT1FsasGteRUOpeCctsW9yOnPlRDqYBf0AQR9np2BRCRUB8VD2Tel3DNifKl5FTXvZxrokPBDjQ8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748350824; c=relaxed/simple;
	bh=MEqM4vWFkkhwqxSh+gqQSgVUNNIX+HgRMV/7LAhpF48=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p6aqrcWCBJDP3DRcm5bH2LOQGNGNLf8gQVsOVaQigUvL5E5uYR5PbLMpBzU5hyn7RZGG2loaGVGUZV+xCoInu7qxyAPD52zp1nMhdJTuRBKawOWGbt1I8W5ZP58HFnC3l8weNtoiUwRTQ7IxNj/MINcC4LKK4VEyCzRl+if4nnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=IVNUtryi; arc=none smtp.client-ip=211.125.140.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1748350822; x=1779886822;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=+Lxgs3He9IdDt6ifvL+tC57fCEzAPriv444VErqusZI=;
  b=IVNUtryiJWuouNq1l0dQWIl/runxMaBydXiYlrJSEXphR3/1hD1B7sF6
   zN6VeF+lC7dPgt2LRM3dd/iD8jxFZXFiQ59ghmfzEcN8i/RCAdId6TXuE
   dzEaJHe40b2Atwv/saw2RCvF5YdCJppegipAoES58vWdJSb3kNVG6CSN7
   zvHYiL64XzsGFkknEGckoaabfdm4CstWBP9tK6Y3HlIcjZsVc3VC6m7Cb
   9vgH12h7NgtHA4MoU+uK5/0L0qiMjh+at3iDKwnCuY3lEr6mMUsHbhPiG
   /pvxP9IKK7qGgtorUsIZ0CgZZFnNI3fsh9bkrNU/oYekU8Li2w0YHAI5H
   g==;
Received: from unknown (HELO jpmta-ob1.noc.sony.co.jp) ([IPv6:2001:cf8:0:6e7::6])
  by jpms-ob01.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 22:00:14 +0900
X-IronPort-AV: E=Sophos;i="6.15,318,1739804400"; 
   d="scan'208";a="564893580"
Received: from unknown (HELO [127.0.1.1]) ([IPv6:2001:cf8:1:573:0:dddd:6b3e:119e])
  by jpmta-ob1.noc.sony.co.jp with ESMTP; 27 May 2025 22:00:14 +0900
From: Shashank Balaji <shashank.mahadasyam@sony.com>
Date: Tue, 27 May 2025 21:59:10 +0900
Subject: [PATCH v2 2/2] cpufreq, docs: userspace: mention variation in freq
 due to hw coordination
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250527-userspace-governor-doc-v2-2-0e22c69920f2@sony.com>
References: <20250527-userspace-governor-doc-v2-0-0e22c69920f2@sony.com>
In-Reply-To: <20250527-userspace-governor-doc-v2-0-0e22c69920f2@sony.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-pm@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Shinya Takumi <shinya.takumi@sony.com>, 
 20250522-userspace-governor-doc-v1-1-c8a038e39084@sony.com, 
 Shashank Balaji <shashank.mahadasyam@sony.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1009;
 i=shashank.mahadasyam@sony.com; h=from:subject:message-id;
 bh=MEqM4vWFkkhwqxSh+gqQSgVUNNIX+HgRMV/7LAhpF48=;
 b=owGbwMvMwCV2mPH4Ij++H1mMp9WSGDJMt8d+ezrz5p8Zc4++XMZS2b/l46ZnVzqZFF0tTO+7p
 Ggu3qPZ31HKwiDGxSArpsjyTmbdhYNWlk1fjzN8g5nDygQyhIGLUwAm0u/N8Fcwk+PKRIbawypr
 JXyvf/0qVhKaJFW0UlZkhxjz9YjF7dGMDOuEvr7/d2yVp/uUvpwjCbdsHwcuu+NSv2j1mwkVM1g
 /7WcDAA==
X-Developer-Key: i=shashank.mahadasyam@sony.com; a=openpgp;
 fpr=EE1CAED0C13A3982F5C700F6C301C7A24E0EF86A

Signed-off-by: Shashank Balaji <shashank.mahadasyam@sony.com>
---
 Documentation/admin-guide/pm/cpufreq.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/pm/cpufreq.rst b/Documentation/admin-guide/pm/cpufreq.rst
index 3950583f2b1549b27f568632547e22e9ef8bc167..30799f734ca5568002d790c1db0ced7454bbbc8d 100644
--- a/Documentation/admin-guide/pm/cpufreq.rst
+++ b/Documentation/admin-guide/pm/cpufreq.rst
@@ -398,7 +398,9 @@ policy limits change after that.
 
 This governor does not do anything by itself.  Instead, it allows user space
 to set the CPU frequency for the policy it is attached to by writing to the
-``scaling_setspeed`` attribute of that policy.
+``scaling_setspeed`` attribute of that policy. Though the intention may be to
+set an exact frequency for the policy, the actual frequency may vary depending
+on hardware coordination, thermal and power limits, and other factors.
 
 ``schedutil``
 -------------

-- 
2.43.0


