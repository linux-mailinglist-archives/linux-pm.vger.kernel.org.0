Return-Path: <linux-pm+bounces-16695-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C309B5BD4
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 07:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D27AE283F84
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 06:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4B21D89EF;
	Wed, 30 Oct 2024 06:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LyZikD1h"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F371D2F55;
	Wed, 30 Oct 2024 06:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730270337; cv=none; b=QVD9hVItxFxH0N9MO2/8aZ6TrCtZyhI/NjBcipInXjBl8BmMAfArdNyI29s8kWgVYmE1xxZc2Nc3KTAMrsBw+VYOw+kc7vEQRW/RVdDzmdvoQFqexrxAOZKnguO3uyXHEdOGnWi4Go3eyfXu7xIDXpI9Zdwrlh4HGT/Li+wxCpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730270337; c=relaxed/simple;
	bh=/I5I4x5Gwnf5QLdxasjdfK1xcvvLoK596m0S2t/Q8gE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O43tERg7zjp+p0x/Pnt+nUb0z9wzZF0znkIHWSkufTbHsbGPsTXfeiSfH3Ik39mrOQrh8viMjMOBrmoFQwgtskWQ3s+aFvvNcEsEuCx7oEsgVyMX3Ln++/SjDBwNLX296xE5vFV2njDrXpf2Zio2TGOXer/6GvOVVW2gFtzzDto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LyZikD1h; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c937b5169cso881651a12.1;
        Tue, 29 Oct 2024 23:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730270334; x=1730875134; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YQMXrA7Cqk0xyc5rOwL3N11QuakbSsF3H3+icvQ02SA=;
        b=LyZikD1hNscbLukwiEc7u3k9ADEnJxfrfniPGDB5cdmydox8ra72yQPMERtBzmqobc
         UkpUVxALjYZY8ynA7bv8zF1g6kZ0l5cmK5Ew70oxOAv0+6XvIZTFbYcJu4p6EHam/Tha
         QxR+5UKeCon/LO+FuUNrW1sG43dpWO/OCPx+BJ0a3jvbBOQbGcabk7JfU5I0/0ydHG7x
         PluXKcRBEeV6V+X+BrQ8lsaSYHYZUj7M4TSxF8Sb1B6Oijn2elhj547wSYYcNFfkwoYr
         g+hh6zU0UFUMwn0WAbdjPtp7xVrs7vdr2SvGuPRcWIIhxDLw19h2Km4sXpGGxknnKGlh
         3nxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730270334; x=1730875134;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQMXrA7Cqk0xyc5rOwL3N11QuakbSsF3H3+icvQ02SA=;
        b=o9yparmTGnxCbxciUQqXDdhafwYqEZBw75+UO5L5p5I6nVr7qodMfxMoJQe7pMG6zK
         eR9cyiJ1KzfNGOzSo16oSTJYm6FdYlbhiB2VFtTx9JbWLuKSbBn8aIvBKYfWrX4Wg0ah
         ko49bXWR1jII/vnKHvYcFkMQulJl0iJmevhtrDbje27WEqh+2/HNLjuFTHcogmr09xKP
         clHshujCO4shJ5nBRZFDrlx8s3XShgs/HBJT9GaCD2SsSl7GZJDy1Bo2y/K/z6kcY5Kr
         uwf0qosstOGxWDd6nNjxYnFKt/DbdFKQrBbR23/PLQLUpcaEHzgXcLLEC7b+4SevTHc6
         ObEw==
X-Forwarded-Encrypted: i=1; AJvYcCU+wf0vxh1qiEc87u/Cx+YV1AQJUrNs4+wQMnp04dRu5fyGM7gnVObJ8eIcHdc990xXQOBEltgg/jWUB1M=@vger.kernel.org, AJvYcCVl5BtRaiWpJxyo4NXXnosCmc2JK2ebYif5SLRON7IMybBcfx6CQKWS4TRC4AvAPNY6psgdCSzeWFk=@vger.kernel.org, AJvYcCXpjZLV9UIRC7CoGmX/FMsDTsDrC6TE96mWJIPpzfF9OeeA37KGgrHBcfz57v5jI57MzbrwZydJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwyvZqXISvrhUw3BdEzbb6gsV1UhRk8QjWjD2KdbiM1E1SQNbX8
	58iE+KY3lOKjKrRQS3A2407jbriBJnaQWmTu3AQS+uRqYiI9ZLnC
X-Google-Smtp-Source: AGHT+IGiqRf7Z4EjZXm8fu7FnaIzXPZvugOg0ixKoNg8/7ySFr/2N/hU9C7y6RGWOzTSEn3t7G8jJw==
X-Received: by 2002:a05:6402:2790:b0:5c8:88f2:adf6 with SMTP id 4fb4d7f45d1cf-5cd2904ddeamr4696359a12.13.1730270333513;
        Tue, 29 Oct 2024 23:38:53 -0700 (PDT)
Received: from [127.0.1.1] ([213.208.157.67])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb62c14c4sm4473498a12.44.2024.10.29.23.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 23:38:52 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 30 Oct 2024 07:38:32 +0100
Subject: [PATCH 1/2] cpuidle: qcom-spm: fix device node release in
 spm_cpuidle_register
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241030-cpuidle-qcom-spm-cleanup-v1-1-04416fcca7de@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730270327; l=1200;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=/I5I4x5Gwnf5QLdxasjdfK1xcvvLoK596m0S2t/Q8gE=;
 b=accprF+pCR3JmnudIgFKMo4/PjdP3Lsiiw7rv2XRS50m2SvQv/19rvTeIRFUs2ELr9UVpNMPj
 C0rfyl8RISrDgJwxprW7EsYEJbULQK8v59TQlkyqAD8i/hwL77aU+Fo
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

If of_find_device_by_node() fails, its error path does not include a
call to of_node_put(cpu_node), which has been successfully acquired at
this point.

Move the existing of_node_put(cpu_node) to the point where cpu_node is
no longer required, covering all code paths and avoiding leaking the
resource in any case.

Cc: stable@vger.kernel.org
Fixes: 60f3692b5f0b ("cpuidle: qcom_spm: Detach state machine from main SPM handling")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/cpuidle/cpuidle-qcom-spm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-qcom-spm.c b/drivers/cpuidle/cpuidle-qcom-spm.c
index 3ab240e0e122..c9ab49b310fd 100644
--- a/drivers/cpuidle/cpuidle-qcom-spm.c
+++ b/drivers/cpuidle/cpuidle-qcom-spm.c
@@ -96,12 +96,12 @@ static int spm_cpuidle_register(struct device *cpuidle_dev, int cpu)
 		return -ENODEV;
 
 	saw_node = of_parse_phandle(cpu_node, "qcom,saw", 0);
+	of_node_put(cpu_node);
 	if (!saw_node)
 		return -ENODEV;
 
 	pdev = of_find_device_by_node(saw_node);
 	of_node_put(saw_node);
-	of_node_put(cpu_node);
 	if (!pdev)
 		return -ENODEV;
 

-- 
2.43.0


