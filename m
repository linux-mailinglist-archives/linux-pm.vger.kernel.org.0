Return-Path: <linux-pm+bounces-39622-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A67F2CC1895
	for <lists+linux-pm@lfdr.de>; Tue, 16 Dec 2025 09:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D56D30625BC
	for <lists+linux-pm@lfdr.de>; Tue, 16 Dec 2025 08:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F37234A765;
	Tue, 16 Dec 2025 08:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjQDXj5m"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC38337113
	for <linux-pm@vger.kernel.org>; Tue, 16 Dec 2025 08:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765872256; cv=none; b=IkjVvMqdkQyN8njHFylxagIb4mtOBgCOMNFaQbVqt8zgusZcH4ObJZi+beFgx+oPEaUG6q8I8M35A3rAX3IYKALWlnqY+fRTzWuvFez4hq779AdM6dLu1Pp1NX6z8TCpmav31ArNoQ3DlNurqnsxRufckHptKMDmR95D1ILAY7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765872256; c=relaxed/simple;
	bh=gDpy2CFZGLVkrvvfrpkX+np6ujy0NPfPSy8K4PF/qKc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UgdDEun8UX3AlnzBAIErHQJcBrwjDyG7E/g8ruQuthI8CMDIOJ2/KCKvito9tUGoakTfPWiAN5XKFdhnJmkfULF/C3XygzmDvUupT36aoBDJo3lyxHsGBMhMQasW5pjq4zvAR4jF9qC4mlUFfDdmFW4RVBRHviWfU3pHgopk2U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jjQDXj5m; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-37fdb95971eso24584901fa.1
        for <linux-pm@vger.kernel.org>; Tue, 16 Dec 2025 00:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765872253; x=1766477053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p2T4QBQA2QaUTEbCgXDdDGm3M4lbz4HexNz0b3ZPm30=;
        b=jjQDXj5m/O28t4GYWaXj5bl/wODoYtuPqRu+G46zdfn0IALwLYHxbxjjmr6VWGBd6z
         yekSIcGyYffzkwoyI2AYDPSMKAUXj001v5e9n4ekIQjjtP9ZNOR7DedMkIuNZYxVuOBx
         +Ki8HKgasuzIl5n7VjEFcRlegEx2mjVb8WILjz3NNspDlO6ziyA14iAXc5pPzTqdaSyw
         eswqWmh9DSPK2J7XYRxHEOF9E8defE3FW0MdiKG8lRUoRGtJx3++cbo+KmMTD+nBK5Lp
         JFEXKnrbISex86mDhwAVmW2wYHy/ig9zMTDjKnDdNVa4ZRAlu8FFQ1RkXDgoEczXkxP6
         9ZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765872253; x=1766477053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p2T4QBQA2QaUTEbCgXDdDGm3M4lbz4HexNz0b3ZPm30=;
        b=tcK3NMP5l7qlaiZAa2OFluzpK7gsRAePlVXF5G+cSR5r73qnxugAO8u5sAVzLbV74/
         IKGUJw1oKyzzSxX5Y0pZXTOyz6dWr/5uPwJi8nPCPKtGriuj8qfk24YA80+M0zqBc1NF
         cUtDRNETpDyx2umM/8yyF6TTvON6qtLAM0LSfPOPbJGbdDVFPJgOjxx8MWlBqdrZ2hhM
         OV4xMItTSTJMq1uTuwh1SdI4QjzRFzMCPEUmfO6E/2mGiketSar+0nmuRZq18diHkHIT
         Xrx8+4yo+OdpwYmwFtuBhHAvZ0m37W5t0th0I9K0MhotYeUl73zBPLKgrfbvkRt6Zysa
         x2Yw==
X-Gm-Message-State: AOJu0YydVo2XJShwJ0olqEkoy18drFcVlRlPAcQkrdpJjFX489C81wOX
	TwnKMc8uM3p9DeqiN+UA1BFPO8VboURwwFYxyRLA8nqvXtvDcNPphQWzphLElRJgKeo=
X-Gm-Gg: AY/fxX6pgpPSOBnuqFCIDtvUHXACfJW3yOhUcw9P+aq6Km0Y4lrbTn3IKLT/3k8cILx
	pp1Y83bGCy8ws7Z9K7+h2IRwr8odESRZCdWCCPizP+jddhX9frtudoZptYD1mX8n43S6SE9NdQk
	Xw5/Z4oDMB3Elhe/YTjSFhWjyXYfeESnaYih+cEV/ILZ6GCe7DiSDmAFNmxXJeVYOJLfvb5CCXq
	Hau32k0qNgexOFJIxeqjuta4rtXo8/wAWSDwMEp+E4TAb8qrDYlOWdtmIO/wxTGGxOhPg1/Md4b
	4l/JCls5oDgoHuBSJ5Cpe9ELIMadvDDZo+i1aDW7Yy1Tp3lqGBahpesyfGMomijWDf1irU16Hv6
	5UTFYn6WW+9GyOR9eJocixSehNFeUcFxTn5ZM7CYenKzv8IUqmTrJKY9IGciHvIrXVoCpju4CMJ
	GGHB0/P4+DmUWOuMp/kY27CwQwNu3M+uMtKQ0AQtD8jDU963NTFzGdRVawUKgu+T0fi3T/HfK3d
	Z8puCo=
X-Google-Smtp-Source: AGHT+IHi7k/PLktktAFCCec/j/Y7YQbT1AmZUGxJjgv6N9M2LZatKIlSQzlby8lJo3z6HZAuG+y/KA==
X-Received: by 2002:a05:6512:32c9:b0:595:831d:2308 with SMTP id 2adb3069b0e04-598faa360c2mr3979949e87.1.1765872252497;
        Tue, 16 Dec 2025 00:04:12 -0800 (PST)
Received: from abityuts-desk (2001-14bb-ab-c176-62a0-4b37-648c-102.rev.dnainternet.fi. [2001:14bb:ab:c176:62a0:4b37:648c:102])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5990da5dc09sm657426e87.75.2025.12.16.00.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 00:04:12 -0800 (PST)
From: Artem Bityutskiy <dedekind1@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM Mailing List <linux-pm@vger.kernel.org>
Subject: [PATCH v2 0/3] intel_idle: Add cmdline option to adjust C-states table
Date: Tue, 16 Dec 2025 10:03:59 +0200
Message-ID: <20251216080402.156988-1-dedekind1@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

Add a new module parameter to customize the C-states table configuration used
by the intel_idle driver.

* Patch 1/3: Small preparation step for the new feature.
* Patch 2/3: Implement the new module parameter.
* Patch 3/3: Add validation for data passed via the new parameter.

Refer to patch 2/3 for details on the parameter name and syntax.

Patches are based on top of v6.19-rc1.

Artem Bityutskiy (3):
  intel_idle: Initialize sysfs after cpuidle driver initialization
  intel_idle: Add cmdline option to adjust C-states table
  intel_idle: Add C-states validation

 drivers/idle/intel_idle.c | 227 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 225 insertions(+), 2 deletions(-)

-- 
2.52.0


