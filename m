Return-Path: <linux-pm+bounces-27663-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B9BAC4092
	for <lists+linux-pm@lfdr.de>; Mon, 26 May 2025 15:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A931C17661D
	for <lists+linux-pm@lfdr.de>; Mon, 26 May 2025 13:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D29E1F463B;
	Mon, 26 May 2025 13:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dyuFdBPt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E45618871F;
	Mon, 26 May 2025 13:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748266741; cv=none; b=CGE94IyDsEJNYeI6ONt3NyI8jvRR7qB0zW9puIstbPClm0nFaZ9+QvCaKP4+37rY/Q37osoxxqOXq3DmcCCifIb9Di9LXnsIAHZEoQERXHECboYJiBmcOwX5yktcNnlDPSVfvrxKAquzUsBa0nl6zvDTu4XS73yMNop1ur34Y5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748266741; c=relaxed/simple;
	bh=1tUSF8lKVGOcvcJE1XdgtGuHr86xeDeDWjv+SJbV7Qw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DBAI57EN1e34F4hucAWpjpja2k76PY6rSKkTMqDXO7nr+gLUAck7zRm9SKkH8pa55Kfd3zKlj6HSHpCOAh+R1KEd9xTpwzqMvRS544Q82r8SAcif2od5vz+11DFe6eChw7QoGCUL0GqPDKBKxVlTo0UxLoNOXsLk3rx8QGmfknc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dyuFdBPt; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-742c5f3456fso1641366b3a.0;
        Mon, 26 May 2025 06:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748266739; x=1748871539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0F4i0Dy24Jd9tfOmTGUXWMV0Le8qMAUOTwRm7IYY+LE=;
        b=dyuFdBPtzhjCbQiDkWffFSyglOKxCZacviTLmlNyYISH6LsIycXdU/NAvJ5ABktyL2
         7RApixqeJMzoOyAF9ZClQYxJazw+/a8VPFxeXvY8cTXx+L5g6FW+hbyDcYe2WJFIEVWQ
         lMTkRHvVJnUHvjoLce2RjAJ7RexlXbAKpNSnOfs1sByL/DMp5u7PJg4y9wopES4B4CmX
         QixhsqUy6dBgTNeK5X6yMefPmJ4FjPCdNYDBzdaagl9Kl+vAim51nlo+9w/Tcyss3gxm
         Ftevhw26KVJFdGXYbreULIOH3CEyJCgRzTxDpCZYsOR+fW9YN/ZeYCUpYvg2SHURbHQm
         g0Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748266739; x=1748871539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0F4i0Dy24Jd9tfOmTGUXWMV0Le8qMAUOTwRm7IYY+LE=;
        b=wFdmZYgJrwWYX2/2vs0/zfUjxVQ5xZ0QoiiiqIC2w+eEkinLH5cnWNDNUT3ftVzslM
         R+/JVRu9L+xqTrLXGrunXp8RBFBsSzq/3i5gh0RGbC/ryfuaXeHQoEGzQlWez5fMq4EC
         WGkhkDLsKm0AaaQIf84jJ1MiLn6aNkmxX+2GRD2GfC8Qo+4x+TUw5QxQg214tXOFSHb5
         utc3eOB16voPeiZ6542bIPgqCDyNK7STrcyLorf+gefu4paMmb+f+YxmqR+l6FKZYJzt
         KTWvS8ejd5j39j3aKi8TaZcPjNjWy/lXKCC2GcxEvE3R0BzdDodxI5C8rIdGMY4jP7+f
         RK5A==
X-Forwarded-Encrypted: i=1; AJvYcCWgQCieFAyszNjfiBpgkjbVgE8/poo7BOGrvGXRrtRKz/qz0Gr+533AH7T46hHjp8O6z6U9RbWRFcX/LF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyX5jbGEOV50qEbOGEExTyxYGr9V8v8LtlZDWCTeHw/3Vnzrn4
	11xWQ4Uw8A61n8d1gWPwyaVz9kJFtggA2j01VtA4OVrflzEh7gvRpFS/
X-Gm-Gg: ASbGncvJtEPVlZckFWYA/OTqgnCpU9UqBcMjl0uZYdM1E1+QBIhgX9mFJDk8rLouaOX
	gfFqF/mpijVuLmdWmMC4mFfnNjGK97ipfTILstcxYnqvje7/zsbk8VYnDNF1N1hkTVZaGA6N+3F
	hjSHfvulmki18jnMiWd7y2dneVduX6qtFFTns8iENF05u7quTPd9VJO+BSuLNUKIpK5NFnZZIaG
	GCINM6UooFowPas3lrPLLTpuLDurKz6hO5+7fggp5z+UXbolroZLSoDHg9e2wiZc4ohYPkX1xjS
	stGkRqRSKIv463VTsZ6/DAK0lbuV0ZipikTn9+nvq1lg/NGRTXl0zhcK19tF3g==
X-Google-Smtp-Source: AGHT+IGiWE10oEwNg/vmfba3UaQ0l09Ni284yqf8ynB5mkWfOFUqBbPYejslg09NRxQJkAJS9mfUUA==
X-Received: by 2002:a05:6a00:3a0e:b0:736:3979:369e with SMTP id d2e1a72fcca58-745fde9e443mr13012863b3a.9.1748266738763;
        Mon, 26 May 2025 06:38:58 -0700 (PDT)
Received: from ti-am64x-sdk.. ([2409:40f2:3b:9933:39a:4805:6c67:6b00])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74617036291sm1337018b3a.89.2025.05.26.06.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 06:38:58 -0700 (PDT)
From: bhanuseshukumar <bhanuseshukumar@gmail.com>
To: cw00.choi@samsung.com,
	myungjoo.ham@samsung.com,
	kyungmin.park@samsung.com,
	skhan@linuxfoundation.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bhanuseshukumar <bhanuseshukumar@gmail.com>
Subject: [PATCH] docs: devfreq: Fix typo 'enabeld' to 'enabled' in devfreq-event.c
Date: Mon, 26 May 2025 19:08:39 +0530
Message-Id: <20250526133839.64455-1-bhanuseshukumar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed a typo in  description of the function 

This is me trying my way into opensource linux kernel contribution
journey beginning with this  first patch of trivial spelling 
mistake fix. 

Signed-off-by: bhanuseshukumar <bhanuseshukumar@gmail.com>
---
 drivers/devfreq/devfreq-event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfreq-event.c
index 70219099c604..020fe30ed5d9 100644
--- a/drivers/devfreq/devfreq-event.c
+++ b/drivers/devfreq/devfreq-event.c
@@ -100,7 +100,7 @@ EXPORT_SYMBOL_GPL(devfreq_event_disable_edev);
  * @edev	: the devfreq-event device
  *
  * Note that this function check whether devfreq-event dev is enabled or not.
- * If return true, the devfreq-event dev is enabeld. If return false, the
+ * If return true, the devfreq-event dev is enabled. If return false, the
  * devfreq-event dev is disabled.
  */
 bool devfreq_event_is_enabled(struct devfreq_event_dev *edev)
-- 
2.34.1


