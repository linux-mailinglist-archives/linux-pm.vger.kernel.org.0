Return-Path: <linux-pm+bounces-11063-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEC5930105
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2024 21:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3FEBB227F5
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2024 19:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BBC38DD9;
	Fri, 12 Jul 2024 19:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="HJMnYMS3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459D21B95B
	for <linux-pm@vger.kernel.org>; Fri, 12 Jul 2024 19:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720813212; cv=none; b=KlITZOU9hbsTAURN/uHdq2bBUOWpYR5PSiV9xE4AlU7EtOyiHKg4Y9/hq+atV5hDZ/5+8BrNWOX51a6wGuZPXWJ5cV+OfWNo1eL6Vcbfst/qDjGGwQ4G6m3EId/lnRngCwtFUCr+ixPcb6jm1JyerxqCCjJDftvJUS3qpklIXpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720813212; c=relaxed/simple;
	bh=MIU3owLLrwypm5/MgWUvunJsmR9PY6tV2qPUPU8aLZw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IKHnlubwkfPAjfonAfrP49CaqMmhA+ynWIC7y27vE1W0KoRUgRtMiBwM9YcRpiW572OQiyTe3yZLJ7xr8+1U3xo3aLJdnyvbxfubEvMOfplCoBmKNml8JZAOtuxuqpm/qYwVH5rF5h7jF9yiEsVEt61q8P4SfCL9NNr/I1ChWXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=HJMnYMS3; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-367990aaef3so1341069f8f.0
        for <linux-pm@vger.kernel.org>; Fri, 12 Jul 2024 12:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720813207; x=1721418007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FvuQrQGGQIwwog/EnWsNcgH7JSV94m6PJ1TUizGo8OI=;
        b=HJMnYMS3Nv+hSX5/QYJeog+MLpSwIUrVlyJzKagzQh2yQ8bGopGHHNOCQk+08rwvyl
         bZUKeGAuoNbuAmEdwFW3kzM/4ds96Q8mc2L1gF6TpYaAaUQgRMpV/otuvpPgkY5v28+x
         /dfdIABQavA8eMGrFtA2A2XJv5s3l2mkjUQJcV9ZfryPxupuKFWjn+Z+OFbAs2+SuDzr
         6Ir5clbdIIXMGfcQDg0CVGyN2H6cp4ZFuqaphAe+klUMT4meybiZP3vGnzCgUNCgvugO
         S4lkLiAyZ9GdXyYpxn2t0XZqffq9aIfCXYrJB+byhWn84NVI9MJJ8Kv62LJeM/kjJ/68
         8+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720813207; x=1721418007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FvuQrQGGQIwwog/EnWsNcgH7JSV94m6PJ1TUizGo8OI=;
        b=XmuQmWa1xGfgh0wVpBm8wPX9rymmfXzl9WqqgDCzqYc2QkG43b3/pi7NiX4ugf3/Wj
         cSByhE5NfuS3xVxYpvBICbU9QmgNnL1KgZxEVnBAKUFRRm2w8TNFXEi1n7sGRwhlB0Tu
         ewxqN+5rB1wYNQRNzkO9/VAWOBnQW5IHnWAl2qwU8J6alv5lpyuazQ4A2dDY+85ZZa5a
         725oW4jwNA/xd/AWXbzWbDfwOTrK3vcCtwJB7AeR/ZyzyhNqgQhaHuW4FAC5fXFjSehn
         3pB3e5Vz1OofqHPuOxXJX8Nd5S2NtOjCBDtb559ckn0ed/jwQZOTYbeQOs1C8+LUxqaE
         nFnw==
X-Gm-Message-State: AOJu0YwJwyZRCjpCqDA2wWzETiUeVbKEQInkeYall5fFqmztBp55NCOd
	J2yTMDxDDFhCasZmNvYtks/x7tB677poIgfkkUPkWOwbK3HvpluZFNwyFzftiaE=
X-Google-Smtp-Source: AGHT+IHNcSqKCNvMJWlQ3+gm4ni/DPQb7E7vc0oXSqOGorhg1y87UCQAfw7iqfKkb+xvsPeDXJZ4fg==
X-Received: by 2002:adf:ee4f:0:b0:367:8a68:e749 with SMTP id ffacd0b85a97d-367cea964ecmr9035312f8f.37.1720813207457;
        Fri, 12 Jul 2024 12:40:07 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:ac5f:fcfa:c856:a4d9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367df88b1c5sm8862467f8f.4.2024.07.12.12.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 12:40:07 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Dan Carpenter <dan.carpenter@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2] power: sequencing: fix an invalid pointer dereference in error path
Date: Fri, 12 Jul 2024 21:40:04 +0200
Message-ID: <20240712194004.241939-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We may end up calling pwrseq_target_free() on a partially initialized
target object whose unit is either NULL or an ERR_PTR(). Avoid
dereferencing invalid memory by adding an appropriate check to
pwrseq_target_free().

Fixes: 249ebf3f65f8 ("power: sequencing: implement the pwrseq core")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/linux-pm/62a3531e-9927-40f8-b587-254a2dfa47ef@stanley.mountain/
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
- check for ERR_PTR() in addition to checking for NULL
- only add the check to pwrseq_target_free() as anywhere else unit is
  always set and if it's not then it's another bug that needs fixing

 drivers/power/sequencing/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/sequencing/core.c b/drivers/power/sequencing/core.c
index 9c32b07a55e7..0ffc259c6bb6 100644
--- a/drivers/power/sequencing/core.c
+++ b/drivers/power/sequencing/core.c
@@ -212,7 +212,8 @@ pwrseq_target_new(const struct pwrseq_target_data *data)
 
 static void pwrseq_target_free(struct pwrseq_target *target)
 {
-	pwrseq_unit_put(target->unit);
+	if (!IS_ERR_OR_NULL(target->unit))
+		pwrseq_unit_put(target->unit);
 	kfree_const(target->name);
 	kfree(target);
 }
-- 
2.43.0


