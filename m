Return-Path: <linux-pm+bounces-16694-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5266C9B5BD0
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 07:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1FD11F23D02
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 06:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FAF1D1F77;
	Wed, 30 Oct 2024 06:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/5gW3kS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F6A63CB;
	Wed, 30 Oct 2024 06:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730270334; cv=none; b=aXqfBSMi/6ZKlF2c+Hf2H001yPX6bF27tWdQ3D1r7hI+jjhSCzdjGOl1h52xv7MfmsDkqPiKTfxEqPXrWwQBLXecpwOQQo74qWcweZfXKcO2Zu4Gj6Wh0r0g9dU3+zNBLE264BQtt26VS7rAHM9y5vgKeVQH3JMq22LSziXk1Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730270334; c=relaxed/simple;
	bh=9hv4oiZP/E3lwiZ5K3IdQqCCQA3rZPXvKf9qjI/ZlEE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lUBPsn1rZmcAxvUxJ1sU1Fas86Vb6mn7/vx4yIr2pEWF9h+HHy8k/aMmcBk18OsR5LIuq+ddTO0OeE0F43mc+kL4prTE04x8bmwWi5sjRp7pj2AE8g1BZFDSGhXFl9p8mCNpRzbtLYz3ooTfjHeO/JF40a1B8Snej6YueIsALjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/5gW3kS; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c95a962c2bso7593062a12.2;
        Tue, 29 Oct 2024 23:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730270331; x=1730875131; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jzqz2XOsU9I04oP6WRhYoAWHaZRwNYZPIUD+5gjKlFk=;
        b=D/5gW3kSjsnmrVTXZSZek61EWEwpOqKGvgQwqRD2gOASfVsCllawgO+XSl5mKdsSXF
         CXUmdbSmmnDF2se3eGDDdDK9ZVr8X1ExvWbGoG8PWBlnjoizNrIdVzU44OBrLK3iVJNE
         gQ5UGzGiSVJICvb89uKuTOan/3/nXuP01odg0yl5U7bKT41RWDnJ8KG6dxgwxHHd76kB
         TRz/vroJt0Ox4F7TJ53cncKLbW1osYOJmeO9rLBMK0qXGCKjdW+/xMr0Z//wDukFEISM
         vBlxSgvSFtUoBcQfbXFAvG6wPihwC2kycl6H75YT0UM/cufo4btYgXGNVAhtJ/n/U8IB
         IjKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730270331; x=1730875131;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jzqz2XOsU9I04oP6WRhYoAWHaZRwNYZPIUD+5gjKlFk=;
        b=eqh1OKKS/yZ0ORis31D7WxwtyFBXu/ijEDVCOW/DbCbyJTqsN9mY1U780Je/1mlaFL
         quu/NgevbTPWAb92i3WYpR9+7LHM6uMLjpo9mkR817OMvbCFnHuRM1DsQEy7vRNDRQhX
         xDdO2E97twMzDnAWUy76OV2DalbJ0j3w0koySgVeBwZQmyvKydS3SDW/oUyor9/ZKOol
         15DOXFm0LsQ7fK7BXQKwRsjBLlvDDWcU36D0QEe8ZvixK0Y51BX9wVehONz7Ks8eOAWn
         x5nr9JTqT/6Du+/URVC8aJ3qMZYTItKxjbXFgb4U2FNxgN7CZpKba3cgkl2urOlROnw5
         44EA==
X-Forwarded-Encrypted: i=1; AJvYcCVICKIaiAVPCbofXXG27KRaFcdoWikt28A9eFlvwi1z3473C/oXaI+/78dnCajT1VWVBeptZSIGAVBRqks=@vger.kernel.org, AJvYcCWLAQsYCcYBX9cr57xkrp9JjN2hlZ4qFllSx8+WVsa5awRVXYozGlS6eOeJBjnZ29SfVHZzYrShidQ=@vger.kernel.org, AJvYcCX7iLRR0JiS7K5QBP6dUbjSzk8FJe0k/mce08njS4gCWnldvH+rX8758hojSMbOyT4qBDKR2u/D@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4OUeCftASat/AXqJRCZKLu3mkbWz02ZQ6iAiRa2oRkzzOoCCM
	rGFAQpTnH4veI6+ru4cbJkdcLidlRQQxwXsQ3zR9UXi7tRv6QPYw
X-Google-Smtp-Source: AGHT+IF36EhAREbixa1zMQsy9eKlpMey+y0N5AWW+f8RgWv+ec40U6Sz4X8yC2pxKwFEcTv8ZriEGQ==
X-Received: by 2002:a05:6402:350c:b0:5c9:72c7:95a2 with SMTP id 4fb4d7f45d1cf-5cbbfa6223dmr9981183a12.22.1730270330474;
        Tue, 29 Oct 2024 23:38:50 -0700 (PDT)
Received: from [127.0.1.1] ([213.208.157.67])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb62c14c4sm4473498a12.44.2024.10.29.23.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 23:38:49 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH 0/2] cpuidle: qcom-spm: fix resource release in
 spm_cpuidle_register
Date: Wed, 30 Oct 2024 07:38:31 +0100
Message-Id: <20241030-cpuidle-qcom-spm-cleanup-v1-0-04416fcca7de@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGjUIWcC/x3MQQ5AMBBA0avIrE1SJRWuIhZMB5NQ1YZIxN01l
 m/x/wORg3CENnsg8CVRdpdQ5BnQMriZUWwyaKWrQukGyZ9iV8aD9g2j35BWHtzp0UyqNKYZydY
 KUu4DT3L/665/3w+KztggagAAAA==
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>, 
 Stephan Gerhold <stephan@gerhold.net>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730270327; l=951;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=9hv4oiZP/E3lwiZ5K3IdQqCCQA3rZPXvKf9qjI/ZlEE=;
 b=MczZxuOZmmgT5NN2RIwod60ZGPQLIqnoSGKvHr2U1rSG1OE271LjqraSuVRo2RhX4U/jQ0ZDX
 TP8Rh5W/opKBCWDx/fTsAD6wAY0XnCwObvG8JSKKZpkdXP9lKjxDSIL
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This series addresses two issues in spm_cpuidle_register: a missing
device_node release in an error path, and releasing a reference to a
device after its usage.

These issues were found while analyzing the code, and the patches have
been successfully compiled and statically analyzed, but not tested on
real hardware as I don't have access to it. Any volunteering for testing
is always more than welcome.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Javier Carrasco (2):
      cpuidle: qcom-spm: fix device node release in spm_cpuidle_register
      cpuidle: qcom-spm: fix platform device release in spm_cpuidle_register

 drivers/cpuidle/cpuidle-qcom-spm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)
---
base-commit: 6fb2fa9805c501d9ade047fc511961f3273cdcb5
change-id: 20241029-cpuidle-qcom-spm-cleanup-6f03669bcd70

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


