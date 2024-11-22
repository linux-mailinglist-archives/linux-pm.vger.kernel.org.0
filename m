Return-Path: <linux-pm+bounces-17945-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A57EB9D597B
	for <lists+linux-pm@lfdr.de>; Fri, 22 Nov 2024 07:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A8881F22883
	for <lists+linux-pm@lfdr.de>; Fri, 22 Nov 2024 06:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92961632FC;
	Fri, 22 Nov 2024 06:44:36 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCF915ADA6;
	Fri, 22 Nov 2024 06:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732257876; cv=none; b=FcltGv04BsJ7ERN/jRT++ua3G7/xw3r/nzRUOyItvws6TsrIN/SMcmXpFmhJyDmjbnpgpFZLOO/4GyZjlFsPSxaCY1Bbwy7vh4Ro05Tn2sdhQuC+2a4gQ23wy1bu9G6+LccwG4qafyWffPk++jq1cW8dKMDNhtvzmaLDHg/Opqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732257876; c=relaxed/simple;
	bh=hRe073Qyfd3Ta4r1K3FtVgDRKPd+7AVOzmCZDc9HAtM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C0h706kCzcM1zoHyR09R4UCOb3bFRTcBVLB8HtFpWOf4OYDy1+pP1aa7s0DF4RtKCLzjoi5Se3Xt5ZbbCXY8Y5EQIzy7ltNSr0wFd7jZAdHRptJBQICreRM9R2VH++Ko2yL9GK3ITDUFY98KnzcGTg9EeKzw5pBTldKTGy9iUh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-2ea45dac86eso1483719a91.3;
        Thu, 21 Nov 2024 22:44:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732257872; x=1732862672;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0dtFVYDQBbPu9F2seAqSmpYK0Qta0k2SVYOB9dve6KU=;
        b=Ybx6sLFqhmTCJTHatMcb1Ap40z1TVTaRSHznpkCXBC0cW448dFoqX36Bx39ePNxJH+
         BR+NUcJ3eXz3hhSvjvFhCwUCUVQAn9FkSNHLgMpnL8cT/16Mrlr9zEiNivz5rbDbTINr
         o2UhQFCfLrS5fD65iW8R5E5YMfwVZhiI+w+f3Z/g7kE4CXZjjq8Aola8Q5ifxx3weDY8
         OHOIfeOJvTGtIxphEbacApsx3SUHior9csKY2JBD9T+24ZZYXXR/KCs3kfDNZSJGqXH+
         g+08KI70S7IXUUXqMTDheWnCjSVi7FAYKtDchTqJiJqjLU3aoBnKjWFBauBfcehyRxrK
         lAyA==
X-Forwarded-Encrypted: i=1; AJvYcCUZk90o7yl39XbREV8D4lqzNN6u+fnv3hvQ2uajW8IRFgqw/99Wa3gggRxUjugC50apkEvd2FoA51L4yPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLoyXfqNcUNy7s3IxEKXPbLwCNoNucPX0DTrfY4ooLCIdnH5iO
	paP3kyY35dwK2w17ZOL8WnhCC3EPw6BiBGjEQypxVoVr/yLe7dsc
X-Gm-Gg: ASbGncsSWHS08/y5ojPLiUjYLW9LlOO8Y69nIE89RnZHtwzyvBDdIRYy87HAfggTruJ
	qJlQjhMlMf7soWa/e1EBNUDnxyHQYxVfdUEP3ZueWkqGmLi+SrrjcjoCp8PkrvLVWGQlFKy7M/A
	1QC1dCNhr8Sspn2Jp5AhNJHijKISy/44rZll01I3b+wbLc6B1PrKkoQTaFhQx9OvFF8LWw2fNRT
	rCfQmnKorInE1NUnbehl9kwS974oXnmS4iR2SBrO9+OSb5cTN6D3cd5BkB2ZSx1H5pLTqjEDg==
X-Google-Smtp-Source: AGHT+IEe2epVNQ5nqqj51zhX5oVmEqVcvpPiujnDE/Y7+L64yr9fdDW7YU5ZHjNAFtMAmf3wCvbtLg==
X-Received: by 2002:a17:90b:2250:b0:2ea:b564:4b31 with SMTP id 98e67ed59e1d1-2eb0e51f7ecmr1860173a91.19.1732257872310;
        Thu, 21 Nov 2024 22:44:32 -0800 (PST)
Received: from kylin-ThinkBook-15-G2-ITL.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eb0cfe45bdsm945163a91.9.2024.11.21.22.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 22:44:31 -0800 (PST)
From: xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	pavel@ucw.cz,
	len.brown@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xiongxin@kylinos.cn,
	xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH] drivers: base: power: Optimize array out-of-bounds access logic
Date: Fri, 22 Nov 2024 14:44:22 +0800
Message-Id: <20241122064422.73500-1-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code previously used snprintf to format a string into a buffer and
manually checked for potential buffer overflows by comparing the returned
length with the buffer size. This approach introduced unnecessary
complexity and was prone to subtle errors.

Replaced snprintf with scnprintf, which directly returns the actual number
of characters written to the buffer (excluding the null terminator). This
change eliminates the need for manual overflow checks and simplifies the
buffer offset and size adjustment logic.

Signed-off-by: xueqin Luo <luoxueqin@kylinos.cn>
---
 drivers/base/power/trace.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/base/power/trace.c b/drivers/base/power/trace.c
index cd6e559648b2..d8da7195bb00 100644
--- a/drivers/base/power/trace.c
+++ b/drivers/base/power/trace.c
@@ -238,10 +238,8 @@ int show_trace_dev_match(char *buf, size_t size)
 		unsigned int hash = hash_string(DEVSEED, dev_name(dev),
 						DEVHASH);
 		if (hash == value) {
-			int len = snprintf(buf, size, "%s\n",
+			int len = scnprintf(buf, size, "%s\n",
 					    dev_driver_string(dev));
-			if (len > size)
-				len = size;
 			buf += len;
 			ret += len;
 			size -= len;
-- 
2.34.1


