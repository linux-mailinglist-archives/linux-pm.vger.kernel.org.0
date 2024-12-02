Return-Path: <linux-pm+bounces-18312-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BF39DF981
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 04:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C6B0281B85
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 03:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5A31DF240;
	Mon,  2 Dec 2024 03:23:17 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB789481A3;
	Mon,  2 Dec 2024 03:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733109797; cv=none; b=bl0RpvOQ5mrddI36n6ibYsD9V+l/aLeLAaFWE6fYbOtzxHNJcF83GYwtIhbrboU96ysDEuhySBUsPPp640anFSyaodArtliFbhORr8CMMlshaeM2HAc+3dT7zBY3pPzRSrYvAPoOKYoBoL2DHY8rQWNAbxJnPTGj5mVxfY9qgVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733109797; c=relaxed/simple;
	bh=hRe073Qyfd3Ta4r1K3FtVgDRKPd+7AVOzmCZDc9HAtM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C8ieKfm9DKzsrn7ZjpoeiL4dN7vVxlTwOPNXFA2bL1DkXhnNukoRHCLO9EzzszJgXhnmTg7F6S7G9UEK/kgDW44S5PxgWcpqEzoOrowWwPoQM2MkOAVwJipXUqnFBX3yHfqOSbDK1Y0m5lXdBZ/uRsGdT1pCeQelv/5BCLn1580=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-7fc2dbee20fso2527159a12.3;
        Sun, 01 Dec 2024 19:23:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733109795; x=1733714595;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0dtFVYDQBbPu9F2seAqSmpYK0Qta0k2SVYOB9dve6KU=;
        b=lHcyr6BLHtZDEq9HM/Wt1aD9gL00ABHKkJkxAFY8hlJB/askt7M1xGIjifLE5Fwjo9
         CpfIIGyMIuOGKvTYgkosYvjUv9xEy312cxXM12cbUUnI//H9txnbUde088B9B+niqq0+
         EMGvvKDV5eM4HGEVyd5oaibqfEppLqZ42LOuWCBZAwfOeKQHuBzBSxKNt4koTYJAeZzH
         q4e8UDx0rp7oNEC/GxmxNlCZYfldKeIPZ7zQ4H5cTBCnUllBpbwLLF2BGx8ET8zKNzEL
         X94yCeYEkLOEe3NpVIC4YO+mQ4MjqI9cVMbEwni92BUz6qKKauNoYi1Erwi5nM1LH3Ae
         nErQ==
X-Forwarded-Encrypted: i=1; AJvYcCVd9lL58vWthX50a1LX9rIESfllZcU5Pzg2jMjXit13CVi4glf4Hg0YhWoFST/ZdE194E9pAJKc3U73S+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrrZg8pll24QszwgHt3lh+eNr1Kg3jnr3t11mK0AcMfgZIdWyL
	zw/nKeI4rZhdEF8uUZJoVMbKHBn5srGiB+3/31wZjhjJjrowUc2x
X-Gm-Gg: ASbGnctuOFI1J7YVP8YvU5C4D0jP6F6DKR3GTpiuBrd1NQvQsed7u//FHIZNibduHNH
	gPc5w+hsgTgV6YNyEG1BZmtUCMYXV/kWgqyGf5T5Fu/ABy2hGzK2DzkpvxKCf7i8GTkSiU3/2Of
	ppdMhIrLiJSW2x2kIVtWAS0q/gdI6E5eIqdvVz0QnwXs0nZXW0SVH+s6VF5fsLzsB5Z8RSypFth
	cj/r27QipCGS2Z4RHMx3BsIf4L1hTTW3ravjndN8CNPjhFXuXkoXJHuDmfA6JHbXoF1g1pZDw==
X-Google-Smtp-Source: AGHT+IEs08bkNN5ppqlAHxRlShlJslMhccvtNJZkPBlz+6t4YdQ8Lqj6t/4XOkJWq96uKV2+u65SAA==
X-Received: by 2002:a05:6a20:1593:b0:1d9:c64a:9f72 with SMTP id adf61e73a8af0-1e0e0afa644mr31745219637.2.1733109795104;
        Sun, 01 Dec 2024 19:23:15 -0800 (PST)
Received: from kylin-ThinkBook-15-G2-ITL.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541762d59sm7361614b3a.31.2024.12.01.19.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 19:23:14 -0800 (PST)
From: xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	pavel@ucw.cz,
	len.brown@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xueqin Luo <luoxueqin@kylinos.cn>
Subject: [RESEND PATCH] drivers: base: power: Optimize array out-of-bounds access logic
Date: Mon,  2 Dec 2024 11:23:06 +0800
Message-Id: <20241202032306.24671-1-luoxueqin@kylinos.cn>
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


