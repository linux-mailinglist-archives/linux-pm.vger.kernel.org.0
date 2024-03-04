Return-Path: <linux-pm+bounces-4646-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA25870056
	for <lists+linux-pm@lfdr.de>; Mon,  4 Mar 2024 12:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E7721C23455
	for <lists+linux-pm@lfdr.de>; Mon,  4 Mar 2024 11:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7780D39AF6;
	Mon,  4 Mar 2024 11:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d4HGey8N"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054903984B
	for <linux-pm@vger.kernel.org>; Mon,  4 Mar 2024 11:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709551368; cv=none; b=g5RkRVKbGAp8XUrkTCmbOhqa4iXh4QKe19oXZ0iprF1UBrbraqVyvYL6pXJ+bmmyyarFZQ5/7upDpstdTv0l3gaS7fY7V1ATIJSdzi1g0rt9cfWHv0hpMZaYzdLLRR/8r0cXgKcqkSsXO1OLMddIDIpGL4mzN+gOvBZLyJG/M6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709551368; c=relaxed/simple;
	bh=Am+c6dBF6BHH2/RgeyDCuH3cl4jzRaTZllBvX4joDU4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fVox+TfLJD7olk7FW6ucmSFyptoH17jfQ8FTdqpBZ9YtI3veY4+CSsZ91dv8TQRhCRBX2e0B5+Ru2Ut4gK2mUrGVaC6KXY2oi+DXtvo19i0y075gL1gkg7bc69gBovmQQiokHZtDYBVLN3rhJ1UP05BkHDQXjOwnJ0a2AXD96wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d4HGey8N; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dcab44747bso34884315ad.1
        for <linux-pm@vger.kernel.org>; Mon, 04 Mar 2024 03:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709551366; x=1710156166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0o2qbRz2LsYMldaZB2Fall4oN2xIZEAZu8iTzW+0lNA=;
        b=d4HGey8N+RGJYYXIsf1LaNUWUyVqK0xKAYAV6olhhD1fzviqRu1nR4cG7lkpWm74ob
         EqyuV9WuZNDlcVlTEkWzRmdGRCDI+7hr5RBjAl3/5+UlsaO8+B1wC+msVbmzjvGSFUVS
         twfv/wd0t5Koy5gzg6SThA6SZGH0vlHNZAoivQHlF85XtG4IMyD5Nti7iD3UZb3gsGiI
         zAGAgetOvA9Z6fNsCovyH8j0gvwGMav0lsC94uoLppQwCoUDnhWvIc4Y7ZBOkRoO/aCh
         coG2AUVujbilniFtEZ17IHy2CZBazl8po/hKgOpJmVPn42mAkSXXhoOKC3EojeLtJpIX
         o2bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709551366; x=1710156166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0o2qbRz2LsYMldaZB2Fall4oN2xIZEAZu8iTzW+0lNA=;
        b=uflLe2dnGMYFn+RVw3lD4xFdBMVOqfyjEBPkzKAS10Yv9Q19+K0iye1unUPfm04I1q
         HPdhDID/6XOQvAYfiTRvm3ED28nm1fFlTsSJXrjUPGLWHISV+GGGGy05qxydx5BVyvV9
         6sKD+cG22R3JTK4zOCw+XQhvQNEbDG3slJEpDsFZaFv/CmKLA87dl4igZnwqgshRud7Q
         wtIGAfJ/gAzE0TWSCWu/iOPnacn1tZ1e/2mcc7xYK4XAJXLzOyOwUdb0boFwWfcLm7ro
         rck7XETIM8Edi8tN4iy12HypVwfkDhNu8a7z8koS3T3rd1tyJu/dYZ4hflCY/YyjNE02
         szHA==
X-Forwarded-Encrypted: i=1; AJvYcCXCr3SMcD4ZcIL9unfYmzhcL2RdbiAKRLQzmkTFU7HBFZYAlzu46+pj74ChQMAOU4eAFoGv8WUXiudqAhZhtWSMLyyNWG7gpEw=
X-Gm-Message-State: AOJu0Yx9W4ETnrm3zXN0QQ51aSjRVY+BxN8U1Mm59bfZr0aad1aVx3Ox
	NOeN7MeWId3ObH1YJnfXhiPVBYdlGslHXZHVeokRZItkEX6ySescTk5g/T3O19E=
X-Google-Smtp-Source: AGHT+IHz7bqsB9Ws8NUy0LKb8krVg7wj1/42xJsEwwY/wamQqVtxqvyzRSdaS0/cjmA8YPFhGCsXCA==
X-Received: by 2002:a17:902:e78c:b0:1dc:fc86:2e7a with SMTP id cp12-20020a170902e78c00b001dcfc862e7amr5384513plb.59.1709551366086;
        Mon, 04 Mar 2024 03:22:46 -0800 (PST)
Received: from localhost ([122.172.85.206])
        by smtp.gmail.com with ESMTPSA id e5-20020a17090301c500b001dc11f90512sm8225480plh.126.2024.03.04.03.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 03:22:45 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Dhruva Gole <d-gole@ti.com>,
	kernel test robot <lkp@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] OPP: debugfs: Fix warning around icc_get_name()
Date: Mon,  4 Mar 2024 16:52:39 +0530
Message-Id: <0275dc46489419f34765c6ed389c0e9d6245fd31.1709551295.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <ab75239d2280e506e5b9386b8aeb9edf97cd3294.1709551295.git.viresh.kumar@linaro.org>
References: <ab75239d2280e506e5b9386b8aeb9edf97cd3294.1709551295.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the kernel isn't built with interconnect support, icc_get_name()
returns NULL and we get following warning:

drivers/opp/debugfs.c: In function 'bw_name_read':
drivers/opp/debugfs.c:43:42: error: '%.62s' directive argument is null [-Werror=format-overflow=]
         i = scnprintf(buf, sizeof(buf), "%.62s\n", icc_get_name(path));

Fix it.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202402141313.81ltVF5g-lkp@intel.com/
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/debugfs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/opp/debugfs.c b/drivers/opp/debugfs.c
index 27c3748347af..a9ebfdf0b6a1 100644
--- a/drivers/opp/debugfs.c
+++ b/drivers/opp/debugfs.c
@@ -37,10 +37,12 @@ static ssize_t bw_name_read(struct file *fp, char __user *userbuf,
 			    size_t count, loff_t *ppos)
 {
 	struct icc_path *path = fp->private_data;
+	const char *name = icc_get_name(path);
 	char buf[64];
-	int i;
+	int i = 0;
 
-	i = scnprintf(buf, sizeof(buf), "%.62s\n", icc_get_name(path));
+	if (name)
+		i = scnprintf(buf, sizeof(buf), "%.62s\n", name);
 
 	return simple_read_from_buffer(userbuf, count, ppos, buf, i);
 }
-- 
2.31.1.272.g89b43f80a514


