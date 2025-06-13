Return-Path: <linux-pm+bounces-28690-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C967AD933F
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 18:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DF417A8248
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 16:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04C31FCCEB;
	Fri, 13 Jun 2025 16:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="J/m6YGuw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B27C20F088
	for <linux-pm@vger.kernel.org>; Fri, 13 Jun 2025 16:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749833669; cv=none; b=ekOBACHxv1yr/257GXVc9BypMGPBi49vvasIrQmwk9+y1Z/6WKUjiLwrBmeznG7jqrr0jZ6dB6vnouSMfRJYGhI9vQO77m8ncmhp1XyDpndzR0DaFSciFOtqozfqM+lQm6ugCQ6Xa1QFSQjWtiFsQlFaGJZUjUV2o5SsBm254P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749833669; c=relaxed/simple;
	bh=iZGzCmHYrSZzhnDo4cKANmeZWbqdpurZQTN3/p8RwpE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DoXZMqGQ8ZHtojOk6soOH1XjahaSFVvYEh2/tVYemlTaAb8aP9KmF6w7GmV8qg18brbezc4wj/FnWOzm/x6dQ1qxyJojKLrFHTHlOpuPuKTixUlyY6O3CrEvYzboAzlwTB86sInSRxytwWU5wbzB/Y3mLbSENrasWwQNAkDIDB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=J/m6YGuw; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-234c5b57557so24086305ad.3
        for <linux-pm@vger.kernel.org>; Fri, 13 Jun 2025 09:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1749833667; x=1750438467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7WKF8glCmh5nzU1eT20mMxDjanpqM8jk1hyVO7UuIA8=;
        b=J/m6YGuwdUEBqtUPf7vx0ucpY2OSvU/f3MuclUixJCtz7lyn1QF1NnQ+mOyaf50d4d
         cxYGeSdnVEWAbC99b2M3Ye+TWLdNEsln3Zc3us5I3TRS+JusJ4a6D/fcGbvpSgoeUnro
         qdcDvGpGh/I0wEf9+5v0spWosCXWsw/cyO61MjP3q2CjvBBLGauh4fdeZB2mFYMuV2pC
         oey9fj9UtJjO4qRXl9WXbS7l11PwT/TTjxfpy0de8upyCif0AXvlqjPHOJELVcK8gNvx
         6GGT4fMASDRUUikCTMDYXeZA+gB9dbDCnaRxIo1oKuVJioQd0fo+f9iXYKkj6kE/fb2M
         tlZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749833667; x=1750438467;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7WKF8glCmh5nzU1eT20mMxDjanpqM8jk1hyVO7UuIA8=;
        b=Vrdp1f49cWFc8tHMOiWLKB+D7pJVUaYwCJtCNpSsHfdlHA/UwVCSfnxLwr51pm/KMx
         drjlHfsOPWsc4gTkUzRpsUfJWxxUqEYxVLXZAc/UJI+H+MBnO0wumCmRgYLIeV4Jhx/m
         ANnEBgd/NV63HiSYpjQdHPY3Z2bT5LFMHvTX54UBaL/uhL3eKOOvnINNsWoNvzvVraLC
         aEq816pn5neBrmZXFxxi0k5xbtcdfvsECOVzjMmAWJfgxQL32F0YKJCrWbCAiOKYYIkH
         VfhmgV4AvvHLfV/qaRL0uuqJIvWBjaKUKx/YaVn8NevF9SjORGlN/MJZmWkMWPQh1IsI
         xvQw==
X-Gm-Message-State: AOJu0Yxa9J6APthoCjDRWnbpspZa7rxOekpFNSKZsV0rELQhIALXHgxo
	ET9cJlGD40E9lM9VX8+aJm6/1FgAsXEp2lY3y5wsHWVJHe1V7xyQOWLi3lrVro43Er24hlq2z86
	+JjUU
X-Gm-Gg: ASbGnctPHiHMDVqQdQLLmVB1cyhciOhiCk2+4oEZo6t59AKhMhiIveIISCvyzki1pqq
	Bxn9bT+XDZKuRb7gBiVFIzLxRx6DvXcf54/58i/o2flWTZCp5s2LaagUHbf0kc0+9TSelz45ms0
	e+dHZlB+IvGQGHjEhUDr/5Z8sDXIyHnNTZNasNPGPBJTtKqAKRALrTjXWfQC/HTNDtVcYAHNDyE
	bF76XWZ8bB/NSmRDDqHcI5hDEqqockTLxeyuyX5buuU1s9NzRKL7Y/+uZN2R3HK/yVTbWtgsMgd
	zyZQu1g6p66Np6NT2YzbiXonmf4qBGP1EVHLq1AKAiX727WCgN/WGrvoxc2EtQy6Q65XBaIR9Ou
	CeGvCsG3kM51ZPR1L5IkOdc8KZe6Bb1sP7ZdAYLytdQ==
X-Google-Smtp-Source: AGHT+IFRM7HlvEUor2jbTS1VnT+o6aaNJW/BhmRTrRrnp52YltaanLYbOkxjDiCArSzSD2Li0Nby5Q==
X-Received: by 2002:a17:902:e881:b0:234:bca7:2926 with SMTP id d9443c01a7336-2366b3c5a98mr2626835ad.27.1749833667526;
        Fri, 13 Jun 2025 09:54:27 -0700 (PDT)
Received: from mozart.vkv.me (192-184-162-253.fiber.dynamic.sonic.net. [192.184.162.253])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe163a498sm1684088a12.15.2025.06.13.09.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 09:54:27 -0700 (PDT)
From: Calvin Owens <calvin@wbinvd.org>
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org,
	Len Brown <lenb@kernel.org>
Subject: [PATCH] tools/power turbostat: Fix build with musl
Date: Fri, 13 Jun 2025 09:54:23 -0700
Message-ID: <7edd4c688111a697cfe913c73d074738b3d1dffb.1749833196.git.calvin@wbinvd.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

    turbostat.c: In function 'parse_int_file':
    turbostat.c:5567:19: error: 'PATH_MAX' undeclared (first use in this function)
     5567 |         char path[PATH_MAX];
          |                   ^~~~~~~~

    turbostat.c: In function 'probe_graphics':
    turbostat.c:6787:19: error: 'PATH_MAX' undeclared (first use in this function)
     6787 |         char path[PATH_MAX];
          |                   ^~~~~~~~

Signed-off-by: Calvin Owens <calvin@wbinvd.org>
---
 tools/power/x86/turbostat/turbostat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 0170d3cc6819..925556b90770 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -67,6 +67,7 @@
 #include <stdbool.h>
 #include <assert.h>
 #include <linux/kernel.h>
+#include <limits.h>
 
 #define UNUSED(x) (void)(x)
 
-- 
2.47.2


