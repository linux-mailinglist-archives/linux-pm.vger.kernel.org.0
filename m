Return-Path: <linux-pm+bounces-7769-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DCF8C47B2
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 21:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F3DE283871
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 19:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E9B75813;
	Mon, 13 May 2024 19:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjOKyeqy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6727580A
	for <linux-pm@vger.kernel.org>; Mon, 13 May 2024 19:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715629270; cv=none; b=O0RDqlVjQyHUf9Abpa+ZbY54/CcXjMyHuPOj/MihE8yZW9R9bjTQYtt7rgOC1IFxmU3w/Qm9/xxa3SHsJb1f09m46pwynOc3/6KoQo5idkTFbIv77O7aL4CLsm8j4E2dHzo2aVoPLBt9TYHFbHdUIV0mESRhmGyzaH28azi8Q9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715629270; c=relaxed/simple;
	bh=/V/Ux3n5GylZ7NZtDsPTbaIjcFMSwGRFWbvMbL7wzk4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=DRCV6Nu+HsmV37gZJs/D849LE/N4TsP65iFNQEqHuwgeO2ftcKKZvIzfl6PlYbYGjxLbBFEQbqM+k0JsUZQeyDXtEFVR01/ICUwYwiikuQJ+9BQe3RDuaC8Wma/M50RRyqYAQKJwIJ/NCoAfAZPP8Xx9YoQ3o79c+5E0PeP4cqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZjOKyeqy; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-620390308e5so43506897b3.3
        for <linux-pm@vger.kernel.org>; Mon, 13 May 2024 12:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715629267; x=1716234067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=6uNf2lnNn87uKE/95h88EhUkCrGJ04vRiAz+jr0yvZo=;
        b=ZjOKyeqyWboH7I4da63XQa2DJu8+0r9We+hDHNFqOw8kDjYeMAXLxG90i3rPCpO5S7
         fLDG6wj6pVm1STYJpmoAr8qDLPAgfLbxBqGi9FUCfr33xMIbZJjoddSNByG2HT9gkyEv
         rCfLY3bYU2bKJlk3o0NjFo8VrRy7FdVc+tLIYhGMqrQu+hGBeYPThaIb1fxKeknWwRnS
         7B07awrZC/BfLnPf4xbjIzXqe+ZPECYNc/AqFmO6vd9IT+Pi7GaSfk0ALMxjF1pbYcDc
         ZVqIkQetSTTrYNy0b1/EXyLPx5H1ofecEbklx9YD9/u2fl2VF8VprbC7xaKYrEmsAUX0
         lY3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715629267; x=1716234067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6uNf2lnNn87uKE/95h88EhUkCrGJ04vRiAz+jr0yvZo=;
        b=DjZJx8ckwrdV0j+LI5ZF0VnbsgW0gxAIzO9l6r2ZzwOAa/YlMXkjIdFDdkZktqZ7Jo
         WG41rBYICvJZgUUhtv/8vhY5IJ00gLbZJFRKJqLFJ21ZQnLGH3JhheqjR9fj/OqU4l9F
         T70c5/WMYJ9Gsg/JdRpw0PaAW7ul85FLhixaxTjLiAkWPIgZJQ/iFUMlvxnVhgD8YQyw
         bvWwFEvYqCmLqEM1Z0YtV7A9giaCEfGs0Q3syDqPLj+nXmh+HAz7qSzaUyt5Zch+Fv1k
         VJ1YX9CqpqMoBoTs+9aBN0XF6PDKcfBGHi+2f1dnSghLM0ui12GjJEdoruN6BsxKcjKQ
         d8FA==
X-Gm-Message-State: AOJu0Yz1wly5IJAZ0iTeplwaOA5NdR5VnFdfgeudPbyd19k0OBRL9Q4Q
	p+ubG51XPAZ7TykTZ2tqxBxU7WtgE5sxaHkBm6Id7hhvz0ngQjbW4hR4tw==
X-Google-Smtp-Source: AGHT+IFhE85yWKoJgJN80OKHppOYEcSV4iCDL6qglxP7rgha05zI2H5yTEGyRElf+q+Tv1WyelOJdw==
X-Received: by 2002:a05:690c:60c7:b0:61a:d30f:90ba with SMTP id 00721157ae682-622aff9231bmr128201407b3.5.1715629267422;
        Mon, 13 May 2024 12:41:07 -0700 (PDT)
Received: from lenb-Intel-NUC8i7HVKVA.search.charter.net ([2600:6c60:4a00:22d:edc9:ad0e:d214:6024])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6209e26fc1csm22266417b3.71.2024.05.13.12.41.06
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 12:41:06 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Subject: [PATCH 0/15] tools/power turbostat: version 2024.05.10
Date: Mon, 13 May 2024 15:40:36 -0400
Message-Id: <20240513194051.283919-1-lenb@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please let me know if you see any issues with this update.

Thanks,
-Len


Len Brown (6):
      tools/power turbostat: Add "snapshot:" Makefile target
      tools/power turbostat: Harden probe_intel_uncore_frequency()
      tools/power turbostat: Remember global max_die_id
      tools/power turbostat: Survive sparse die_id
      tools/power turbostat: Add columns for clustered uncore frequency
      tools/power turbostat: version 2024.05.10

Patryk Wlazlyn (7):
      tools/power turbostat: Replace _Static_assert with BUILD_BUG_ON
      tools/power turbostat: Enable non-privileged users to read sysfs counters
      tools/power turbostat: Avoid possible memory corruption due to sparse topology IDs
      tools/power turbostat: Read Core-cstates via perf
      tools/power turbostat: Read Package-cstates via perf
      tools/power turbostat: Fix order of strings in pkg_cstate_limit_strings
      tools/power turbostat: Ignore pkg_cstate_limit when it is not available

Zhang Rui (2):
      tools/power turbostat: Enhance ARL/LNL support
      tools/power turbostat: Add ARL-H support

 tools/power/x86/turbostat/Makefile    |   27 +-
 tools/power/x86/turbostat/turbostat.8 |    4 +-
 tools/power/x86/turbostat/turbostat.c | 1154 ++++++++++++++++++++++++---------



