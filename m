Return-Path: <linux-pm+bounces-16696-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 838099B5BD9
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 07:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A74CA1C2116B
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 06:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF3D1DE4EE;
	Wed, 30 Oct 2024 06:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZZKc345"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B211DD55B;
	Wed, 30 Oct 2024 06:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730270340; cv=none; b=Qe0UiZsG6QU+5pLZUj05IilEt/3LuPZi0J1pIUZMWFhommejJYQPbWSOE8CARjTI5Dtei5B+en2ujsgt7mcNm+W2f21KcMuTxFy6nXGnAuwBzFPr2ygYPUPIU2SArnOx9PDOuVSwFunGTpmN/7ByXYqqGV2lBpyYuQ5TAISWqIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730270340; c=relaxed/simple;
	bh=rn+WiHtBQzRPif3GnE4mdaXXApuavu7ost5UpHXs+5A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hcRMtUECG8IIKkA2Khd7a+HEDb7ejWSWpLLZul9mwrH5Leqf5nFWvfAGrczTEjO9sIFaz8xKKBd9MCJvWbD7JU1CcJSfQpgk5vv7F9i0xGAOabQQ8AOAQelDhOhRW/YRRLRaTexWQS/YrD7U2Swfbjqz0K8ekaFJxWmEyXYVfK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZZKc345; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c99be0a4bbso8428538a12.2;
        Tue, 29 Oct 2024 23:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730270337; x=1730875137; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fUpniwr1Q1kvW9+maEql1NLWyuJa7R2hiSy+rG+NqVY=;
        b=YZZKc3453qDM3iIFv5VIqAB6y6vKuxGGoFWCMfFFYopoLrKIG0DrWkBYIk/iHhSf/6
         V2DsA4Or+X1n58Q27xWlahE54I+5iFFrTI1QwSYZfwfYOIt+nwrPrbXVigJVtHrXe7pX
         TnaBBY8Mr4baqBTjmOkcZV/LK0bCdEw9VrStLWuR8mrQWUcvjj2n3jAnrpLZFYuV3xPW
         ssB6HJ453Lgn8dh6LYJJaao2g4S+XC43mZaiJftd7FQw6Lr0ex8dJ0fZCMG9PdF88gwh
         0/Lbp8O2DILbTZi5vxGEw0glG0tKYGP8HxiWaqQfKFddJABJknuplVhuZ80viD7iaJPL
         e4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730270337; x=1730875137;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fUpniwr1Q1kvW9+maEql1NLWyuJa7R2hiSy+rG+NqVY=;
        b=hp+Ab5+9s0ea1DhRy8PohO8kemQq4ZQ8YVoIP1Fuw6CX75iViyy+NdE44Xlfq61gVK
         EJ7NPiP6U1WgoicIU+g2+ruV0cwxevOIpoRhgtex38jRs5IyC5lIb8VrbGAra4ARXM3x
         +m5wsX6+DWTThRfA/sO6I/BY0Ku0XnDKLsNgz2NJGwDVtLfIIhX+suXfcg7uzCnH0fCy
         cgNncq46XfOh7uAkCe9jxeSSHb7gJBBIH7ob89p2MRE6xivc2LPPUK2s/R/SdwkbMgjy
         1QY9hkSRizsB96StKXmIF0zIKV53PODxzgAOZUgBZWsCYY2hxk/sUDEZnxiBmkiAlhNn
         bLQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmO0uS2l7E1Qe5SAOvaQk1xXSo9FEE2DnlKMe81s7yB2Zu49SqIq8NrHlDQAGsJ4dRLlhOSdCPoOY=@vger.kernel.org, AJvYcCV22XECFLIGWgdRtf65Rz2GKsqEmwupp5DJNfkmVdffZq0e0Hw7HGuRL2offkqc5SZDnsRhQQHG@vger.kernel.org, AJvYcCWt1Iv1pqzg4KsifNdat3p9V8oAIsFsxB65qk+Rew7DW+Fh1Qpptzq3EeEeog/o+mrP0IdOKZcTA7ImcGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzrWL3eOz+ulqtmsxn+ApGuVFSthiMsFZoMEL44hEbDGE7N0qu
	oUBPmJtItQeOYzeO0SQfbqg1pWfMeWOr9gPZLhLyIzKtXyguY8YP1VHoYg==
X-Google-Smtp-Source: AGHT+IGqLn4VdKBvfhGFSf7hnR814/+H9k3X/r6fsN1s1vIfz4R4kf3bYxG/1eIRThWfb9gVLCpAfg==
X-Received: by 2002:a05:6402:350e:b0:5c9:55a8:7e86 with SMTP id 4fb4d7f45d1cf-5cd54a83551mr1523466a12.8.1730270336996;
        Tue, 29 Oct 2024 23:38:56 -0700 (PDT)
Received: from [127.0.1.1] ([213.208.157.67])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb62c14c4sm4473498a12.44.2024.10.29.23.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 23:38:55 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 30 Oct 2024 07:38:33 +0100
Subject: [PATCH 2/2] cpuidle: qcom-spm: fix platform device release in
 spm_cpuidle_register
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241030-cpuidle-qcom-spm-cleanup-v1-2-04416fcca7de@gmail.com>
References: <20241030-cpuidle-qcom-spm-cleanup-v1-0-04416fcca7de@gmail.com>
In-Reply-To: <20241030-cpuidle-qcom-spm-cleanup-v1-0-04416fcca7de@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>, 
 Stephan Gerhold <stephan@gerhold.net>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730270327; l=1343;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=rn+WiHtBQzRPif3GnE4mdaXXApuavu7ost5UpHXs+5A=;
 b=cNTzi4pD+41J945oUZsoziKX5PKyr6TYYG+pzATvaIiNnx4vJrLeQlroCI/a7soVKC1vlbiwJ
 b7+beIcSHgzAOKhEw2FsltKk/Xcjltoz50kbX2uCQFMKDKUni0zySsL
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

A reference to a device obtained via of_find_device_by_node() requires
explicit calls to put_device() when it is no longer required to avoid
leaking the resource.

Add the missing calls to put_device(&pdev->dev) in the success path as
well as in the only error path before the device is no longer required.

Note that the acquired device is neither assigned nor used to manage
additional resources, and it can be released right after using it.

Cc: stable@vger.kernel.org
Fixes: 60f3692b5f0b ("cpuidle: qcom_spm: Detach state machine from main SPM handling")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/cpuidle/cpuidle-qcom-spm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-qcom-spm.c b/drivers/cpuidle/cpuidle-qcom-spm.c
index c9ab49b310fd..601aa81ffff3 100644
--- a/drivers/cpuidle/cpuidle-qcom-spm.c
+++ b/drivers/cpuidle/cpuidle-qcom-spm.c
@@ -106,10 +106,13 @@ static int spm_cpuidle_register(struct device *cpuidle_dev, int cpu)
 		return -ENODEV;
 
 	data = devm_kzalloc(cpuidle_dev, sizeof(*data), GFP_KERNEL);
-	if (!data)
+	if (!data) {
+		put_device(&pdev->dev);
 		return -ENOMEM;
+	}
 
 	data->spm = dev_get_drvdata(&pdev->dev);
+	put_device(&pdev->dev);
 	if (!data->spm)
 		return -EINVAL;
 

-- 
2.43.0


