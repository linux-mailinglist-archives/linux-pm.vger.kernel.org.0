Return-Path: <linux-pm+bounces-33568-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 348EFB3E7BB
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 16:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B5D27A269A
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 14:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3452340DB5;
	Mon,  1 Sep 2025 14:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBiUaHxy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605862EDD76;
	Mon,  1 Sep 2025 14:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756738084; cv=none; b=L7MCW1CdWHTY0uYqyvY1YR4tvPdj3CSqRgW0qJks+eRfSwtRPt3sBVWRO/Q7tidi2NnnRurkRYDQThSTrNrp+K6kNbGaNRZhrZLrckn15Q7jMvjd+JbeIrttUOfEvyrDQIDKlTSQAp6g9DPiocOKavulbc2zm24XdQqeUzh5rDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756738084; c=relaxed/simple;
	bh=ZodUXseB6jOlGx8k6PDBGutePoOCdZWayn81mIJLLPA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AJOGGgzltwjegTXG2TdSAkJvZlmLI+ouimSAcsZwdC+9gwiWxvTd4NQm7rAt8gpJ5xIGOvrFVy7qA1sL0ybuG7QU48ZoOkSQWAqEDt6VUB+VFBZVXO5GASaZryBLlvt78Uyc9Jas6wt62nd6MdxOv/72kaiRbjPaCOrGDCGneSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBiUaHxy; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-244580523a0so43657045ad.1;
        Mon, 01 Sep 2025 07:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756738083; x=1757342883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z0FhGqrqMVb2l6eMQQnWxa3xWAyAOmTP51BuC3ToKwk=;
        b=KBiUaHxy1I7SWgIC0kdnnOI0/A82CgIHxF0bujkNsUmPk+dMKXY5JlhT4ncLoVG3E+
         a1kSSHPFYjXyvv+8SLFH6FUc8mwBNd/KJHo4zBLr/HYaorjalgbau1Qyh6bFnKZnhIxb
         stFMyYas4bRiKbqVKYTx1DpRncvE1hKhX/etB8DiMuhS0DRWu/KCc4qaEwQJ7JXa5R4K
         J8lxcPpSGCkSR3H1Es3/Gf5Q3Exz95TwJTVqG5ojyegFfF2fh4QAv6owpHLZqSw1KAWI
         a2LkV9tOyiCD0sv7r8h+ee/wMG9kVvqUPWUDECEdGwwzelc+xZ94+lxAF8W2YiGhSYAr
         v/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756738083; x=1757342883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z0FhGqrqMVb2l6eMQQnWxa3xWAyAOmTP51BuC3ToKwk=;
        b=k6ST1FwyHtPxJ3+skaBPLEzUrAq+d1LfNjqDbKanNDUKEe+leGjK4HBTpgXaRm04CW
         25kF9oB9qB+ikBR/5IZlxs1lXoJPehcWrtbksDfmw3ujbDJT6CyVBQO3ABjWTGo26TtL
         h3SU6sn2yDrCFC3xCi0zPThS11t9iimEe0MaX2d31CqLSY5zE553gD8SlwVkpr9Bxwjy
         CTQbaILt6etysswHjnOX+QHzinxxyzc2XSp+rIrJIulKVfeb/InUEFeJA3NCxqgHdCS1
         9P2XoH4SswxV4P7CRlmqNQYteyRw52wcgEtx+/7Lxv+SdeMIwCGZqxGx7bS7aycg33+Z
         LMYA==
X-Forwarded-Encrypted: i=1; AJvYcCW6GsFJrsh/a38mQ+q4To1MuV6UTzbPmVWBq4oqxeAlKSJA1TpH+a3aez2aoZWGSSXYc8HqXhfPTYo=@vger.kernel.org, AJvYcCXqgIm7veWFkhHUHRQOWCs9QQwx8F/1VtEQdqGM37JCGF8aeaWu2YxEkHG/j/h9qHBoruVhh0TmEbKl+x4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeitH6N4PAJ59QLDjAChulm14UutN12KZiezGp+qyojCPpL2lE
	rHJ2eZHhfcEF/CdLjcr5cYCjuZJoTisPmmfgiK8i6Y22QEId0msQvHvSdRBaWKua
X-Gm-Gg: ASbGncssnI9j/SCefVPeLQrpinn91q2lSm5W9UTczDuiN4giNgSrkI+DcixU43kfTpF
	NZeuWCoIsNsCZAAiRSLnGKoT22Q+sShDvkGwteVGU0QAGenRhaaKJfr8d2gciVJ1GG0eaFeRGO1
	C/fFIMBfzypLpf2c+a6oLEKcKbeY+R5UHtaFJaNB9ifp3048OW3Rhi8ichnwicEGOaaq1qA9eaM
	4NE4gNIsAxiK6uQeRHCwrueMZm6V8ClJ8m/64q1tttwNtoISyzccIh95uGzkmbChriQ5/eVvmYj
	fMACx1fSV1hMftSovPM0oFXCMLO8E5DXu7Fe/fQd5ADl5KkbO0nSJIuj4kgQt70cMPTAi5hfw8v
	2pBeyjCzxH4hDz7d4oytqooeZ8XrNTCeqmaNLAqVAPHzTtBPb/SFkZurFX6tnSEbJOSrr5Mjgkv
	a6S552WJto
X-Google-Smtp-Source: AGHT+IHi4NI+DwDO0TL0X09UVCvc+x42nzPdRk1MoMh/XqxGkbOkkM4vF1kBoSrMCukayJK/Nt99RQ==
X-Received: by 2002:a17:902:d4d1:b0:246:6113:f1a8 with SMTP id d9443c01a7336-24944b29febmr117589645ad.40.1756738082521;
        Mon, 01 Sep 2025 07:48:02 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2490375a9ccsm108059385ad.63.2025.09.01.07.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 07:48:01 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org
Cc: rui.zhang@intel.com,
	lukasz.luba@arm.com,
	jacob.jun.pan@linux.intel.com,
	jserv@ccns.ncku.edu.tw,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH] tmon: Fix undefined behavior in left shift
Date: Mon,  1 Sep 2025 22:47:56 +0800
Message-Id: <20250901144756.1179834-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using 1 << j when j reaches 31 triggers undefined behavior because
the constant 1 is of type int, and shifting it left by 31 exceeds
the range of signed int. UBSAN reports:

tmon.c:174:54: runtime error: left shift of 1 by 31 places cannot be represented in type 'int'

According to the C11 standard:

"If E1 has a signed type and E1 x 2^E2 is not representable in the
result type, the behavior is undefined."

Fix this by using 1U << j, ensuring the shift is performed on an
unsigned type where all 32 bits are representable.

Fixes: 94f69966faf8 ("tools/thermal: Introduce tmon, a tool for thermal subsystem")
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 tools/thermal/tmon/tmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/thermal/tmon/tmon.c b/tools/thermal/tmon/tmon.c
index 7eb3216a27f4..ef67cd1a4861 100644
--- a/tools/thermal/tmon/tmon.c
+++ b/tools/thermal/tmon/tmon.c
@@ -171,7 +171,7 @@ static void prepare_logging(void)
 
 		memset(binding_str, 0, sizeof(binding_str));
 		for (j = 0; j < 32; j++)
-			binding_str[j] = (ptdata.tzi[i].cdev_binding & (1 << j)) ?
+			binding_str[j] = (ptdata.tzi[i].cdev_binding & (1U << j)) ?
 				'1' : '0';
 
 		fprintf(tmon_log, "#thermal zone %s%02d cdevs binding: %32s\n",
-- 
2.34.1


