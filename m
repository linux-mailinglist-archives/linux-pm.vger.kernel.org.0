Return-Path: <linux-pm+bounces-37615-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5343AC3FEB9
	for <lists+linux-pm@lfdr.de>; Fri, 07 Nov 2025 13:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62C6418968A9
	for <lists+linux-pm@lfdr.de>; Fri,  7 Nov 2025 12:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765C6319857;
	Fri,  7 Nov 2025 12:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ff/sjVJJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UHHigW6L"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BF73064A6
	for <linux-pm@vger.kernel.org>; Fri,  7 Nov 2025 12:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762518990; cv=none; b=Ri6WWZsxzyxy2cu3GN2IYhktrlJvGCCb0MGgrmmISTX64TuVbWaRVH//twH5e96seZUVavFweZv25JykQyECBrZ1XamXguquRb6jeUxDa2915h9MX6CiMK0rs9JRP6mz2wb/kbEqP01SY4EUbOcVyz4wnQk50eNrukoqouEf/KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762518990; c=relaxed/simple;
	bh=fcggPcLDIQTv6YFTOVcBGogTQrJwnTz4cX4nFLOhcUA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uBRnQZ/v2gmnpo+7/tL9G56mdOp0kpbJKkarAmTHp3fHT8MOvFMv2bJn1CDr+Pq2mkZzmktj24qEge6NPczj1/2OUJjccYw5HnjluaRd2EMBExWXr7AcJ8Y4nRBPI7XMdUVhxkUO1ONhyfm1Cwn/E0khERgI7r81zpVHQ8EUX1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ff/sjVJJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UHHigW6L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762518987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1siZim9NDW4Tl0EKq7x9rZRpMbOBM1ClHh169bAxgS0=;
	b=Ff/sjVJJMW3PHtFLpZMVkIolfJgSjKW5OAdkulfuACAw8dIqMwW7Ok5Ivbz3ept7A53nEQ
	zhjCqbJjUUazyGvXN/HMfD1rOTHQHrCtkUBALNRqrFoD0gBPvbv7j+twkgJ2ewgs06pXRx
	XFYP0owtl9BBXEVPwTqn1cKXR1D8g0w=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-a6Y-SMzdM3u13-BvZ4yCZQ-1; Fri, 07 Nov 2025 07:36:26 -0500
X-MC-Unique: a6Y-SMzdM3u13-BvZ4yCZQ-1
X-Mimecast-MFC-AGG-ID: a6Y-SMzdM3u13-BvZ4yCZQ_1762518985
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-429b7b46eebso572506f8f.2
        for <linux-pm@vger.kernel.org>; Fri, 07 Nov 2025 04:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762518985; x=1763123785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1siZim9NDW4Tl0EKq7x9rZRpMbOBM1ClHh169bAxgS0=;
        b=UHHigW6LthOEZ4R2I9BAcE5P+CMup/pWkdtnc/BqG8ZEhQu8D8gtwSfoJa0idjxvkm
         dYzZDCbrNlCbsK6UbrBjLCXicfzs2fOzBaQiZyeOTitKfol76+TeW3C8Thkmvp9ZND9p
         pAiz5u4FU6T95Zr9Q/yik7kYn+WrAAlpKxF1+SUUtKw+gYUnbwxHbqd02+44cqSAfjV2
         ClV8ltrJhJhlzvCR/bigTsTmUAtivFFDdjsaggVDOUiZTjEyd45Jc24UZVmP8j67Stb8
         rSJLR/yfZgqYjMWncdmR341NyDelGHdSrXpO5QLox4p35qv3AAbkigUihiFxi0+tScDA
         DV4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762518985; x=1763123785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1siZim9NDW4Tl0EKq7x9rZRpMbOBM1ClHh169bAxgS0=;
        b=ALJaYOGzGRORRe9lQwCaU4uxTz900v3biFCKjxXYIPfJWBWNM6JMReGquFvVsHwkRP
         C+LIaeso7BwbupVytMgCetd/KrXtdBIJe6vyTbzKKt624DgVmVrkD5u948a7/kZX10d4
         ouZERgiHcmLpKzkwMxuiausTb9eOcZf2F7I4Icwea53AF20lE+Mbd3eHYsYCAlG2jBe5
         HI7PKPRrS9tzgJROm7JqEwuoh9UcKYnQy1U8qTAH47hsa0fM+EAXvKHaZwvmW32qWeTc
         h0xAWBm0ooGu9ndoycp/2bmoQJdDmM6Tb76LMTybGz0QQZui02ZvvdYTReITF8hidTxH
         EC+A==
X-Forwarded-Encrypted: i=1; AJvYcCVSFesDqhHVSU1G14GlnE5jBuxpF2SToqIejV9jwIMHP4k0bbW5BsZxZib2+G5IpWtxdkmXLhxjIA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMz7kD8sN3d8Z5bmdgUIBZSBmIazcJscSuY6iUI1anZE1ejMo7
	ZLNE+eXKqAHTjDGMjad1hoMVlX9T7danNNPd+1bByLJVIFwqpIrJjXvtPpC5dTPPfSOB8EzwJbY
	fQ4GX3WhAg8KDw2hrMrErjLnXlIlHkmtxxenBQQQ1+Rt9U8mvWnHSK6+XJEdx
X-Gm-Gg: ASbGncuxXedHI6q1tpmgDcz/4ynaJnBkSa2l0vesXLvxDe4gRfUjZggKfd2qBopI+kJ
	xf14WjUzhVwr2DL2Si3VvS0vKqew5WjayA+jqxW6TLI7qbi4SKCb8zzi6iKtOIDHXldQwQFsOrV
	kL1m+vNdqXtqCIGnCtlTrgaavX53TGQ6YkiPhD6xX4lcrRl7y2VsqbKIosiJF0R+JzXfTjVxJEo
	A2QGGRtwJLl6iXxtaTcPBX+q8aztSIxUFoALJx2iDWTHlQsgx9don1jjXPNF1RoJXUpEK78orz3
	ziaaRxBitqUUHfgcVCpbavsFlCQ0Llg26pW2ZCpcsvUctsJKLlmj51hB2+KLzgtaWCa8Xnwv6Pn
	IDkVEL83NuPdo6EGT9Z9Lb3ZWVkrt+Vb1AnmtJA+ORKG7tAUN
X-Received: by 2002:a05:6000:26cb:b0:429:d426:fb9 with SMTP id ffacd0b85a97d-42ae5ac987bmr2037286f8f.34.1762518984964;
        Fri, 07 Nov 2025 04:36:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEylXKmQTrFotELc6oCwxKJ4KvmE3IvEF0/zAZ97as2az8kWIyuFMKUbHCj4k9Gpi+YSaCAyg==
X-Received: by 2002:a05:6000:26cb:b0:429:d426:fb9 with SMTP id ffacd0b85a97d-42ae5ac987bmr2037266f8f.34.1762518984562;
        Fri, 07 Nov 2025 04:36:24 -0800 (PST)
Received: from lbulwahn-thinkpadx1carbongen12.rmtde.csb ([2a02:810d:7e01:ef00:1622:5a48:afdc:799f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac67921c3sm5146947f8f.40.2025.11.07.04.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 04:36:24 -0800 (PST)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Andreas Kemnade <andreas@kemnade.info>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: adjust file entry in ROHM BD71828 CHARGER
Date: Fri,  7 Nov 2025 13:36:21 +0100
Message-ID: <20251107123621.425633-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit 5bff79dad20a ("power: supply: Add bd718(15/28/78) charger driver")
adds the file bd71828-power.c in drivers/power/supply/, whereas commit
b838cecc2291 ("MAINTAINERS: Add entry for BD71828 charger") from the same
patch series, adds a section referring to the non-existing file
bd71828-charger.c in the directory above.

Adjust the file entry to refer to the intended existing file.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 58c7e3f678d8..68774e9d1d57 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22481,7 +22481,7 @@ ROHM BD71828 CHARGER
 M:	Andreas Kemnade <andreas@kemnade.info>
 M:	Matti Vaittinen <mazziesaccount@gmail.com>
 S:	Maintained
-F:	drivers/power/supply/bd71828-charger.c
+F:	drivers/power/supply/bd71828-power.c
 
 ROHM BD79703 DAC
 M:	Matti Vaittinen <mazziesaccount@gmail.com>
-- 
2.51.1


