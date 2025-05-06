Return-Path: <linux-pm+bounces-26755-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AFEAAD0AE
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 00:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 599114A1C71
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 22:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCDB21ABAD;
	Tue,  6 May 2025 22:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OkkVivCL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0052219EB6;
	Tue,  6 May 2025 22:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746568862; cv=none; b=Lzdla03UFuSsQaO1NEYVXeIw9bc8vLRQ2iHHy/hyLLGXK0zGeFUInDCgUBIzqFoQGsFeo8wAiq+pWIoCv1WnR9OKMRfL0RSPFy0OC3u0jMfuvRFOOK7EI/MWHtW3nFChyya6sY1p9xxkdtxV8MFhBdIP2wXhMZ77oIrVNxTJh6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746568862; c=relaxed/simple;
	bh=LV0ruNcHRpMJi2vfvfpRfLtobecYu0JIoRgAf4DBbYU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eMZBiQnyPggh1FVPUbKFTM5sdmM4F1IjH3LnCFDVxfzN1dLb6kr8VScyRsD5UoNcXVc3P2QwXrB5CtjmjA4vO5a19zW6Lw+D05CP/AvA7crut45XoexdAZQcPonT5mFFmxDTIHSK/F6k143z35XDwUMiKnX6TejpMCV0iqCrQUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OkkVivCL; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22e4db05fe8so11072595ad.0;
        Tue, 06 May 2025 15:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746568860; x=1747173660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+rDcZ92GkQmefn+4rDVGL9lHZUyx4g109kWVrq63bKg=;
        b=OkkVivCLY0i5AqV+/Cg9TYSPg0MVC2BsseD5YsQ3CGgGNJ7vGKStuOlGW38CWA+Wyw
         OKu9p2+Htb0YPuconR+hDzXobRmTmUBx+bw7yVbJkOOYV3zDMmOxG6X3wQlrT5DUEJ7A
         ft1Sz2S5DyyVarAB8enXq8KKH0DW31UHq2uD0R54rBOHl+jXbj4t44v88vT7ZhwgPkS8
         W4O3Hl4RN/1rgvUtirbozHwdf6VKaBq/lozs2zPSefcq+JGUVzPKazZi17h54vo0W00b
         CDvQCsyeYn1GJwJwAI9ztcagvC6LAK/Q+tttwWg4pVd6gEGVm0kNMnmxZGysARmIOXwA
         Yjug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746568860; x=1747173660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+rDcZ92GkQmefn+4rDVGL9lHZUyx4g109kWVrq63bKg=;
        b=frU+thAFOHGo8I52jlxUfmSxaPPH8nHibWSd3mdiIVqBkovooJpeqZX5ou+apKED4c
         3JbicnM2FCyxNFBKbg3zxgPwj2GbBtB+yjBtZFZscNJSYbFyh7lVFy+66N8Mie3HwzwD
         9+yntWzBzTBk5pDRqlMokaY8bZBg1XPojFJcalCGBLTehUt5HvX3cM2xzM6Le7V/Bdd0
         3cBTAIUcqjS0k6MQZb07Hzx+Vn9ZLvCvKnj9wWDPy+IaBqIiuAT/C1sD7WZEp7j2W3zF
         edsLd6pKwZ7O+YDfCtdEiXxyXyiK/DavW1mMhrD+d0jifprO0iwvimB7aBV3zujXU9IT
         Tl2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVC2bhpn3waLTC1pWR6QOsbhcG/LZqKR9S4m/mmqmJJaNIFkNDPltLG8Gjoy0k8L9FuSicrEtrIGWqLje0=@vger.kernel.org, AJvYcCVmfomg1w2j4Lt7fkirhu8pXrW0ck+VF/xaSZO/OmCgEv9d6fpXz5B6k0LOMb1ieTovUmzg7q4/Jcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCzZUC9q4pPHCOu54vtmmZBKkoNjzt2tyYly9kDO3xouC6r/BG
	ee9tJyueEUVCbdyY5GILlVqqj6FZYQDFn2bvrqIqf62t97cXHrjU
X-Gm-Gg: ASbGncu5bZ8cQLo2Rg6cHv0mzY0ANXbU3trzKuHidT7BcC1MeGmsPwoz09FEKwsqYhg
	FZRSC11Ki07l8tSyr9EloDo2GQ1oNWAYZwhefM5mWa0bZV1Abz4vnl6oz/jb+u04bxL5E3JbeyG
	Y9twMk+9uYMlLk4mNj883QpR6UH9wwKSYcAF1FD7M9FWqzL7jZamZ9DB48wW4xvZSIlxTwBqEUO
	f3y4GcjLMTjhYEGWxsYk+ynTereh2E5ZC7A7ohywdQNovlAjDvC4LY26Jz1SnfJG0IoroUb1HR2
	1A/Ua2Z2mgoFYgxQ3kAxBPiNcLT0H8AgJznjxDlK4jv4NB3sNXpZsFuXxdHUvyt3iy8BJ1RP5Mb
	goNspzoCeGbkuPw3Abxwcnszi0vfNWv0/lxk=
X-Google-Smtp-Source: AGHT+IENa9/kGarw9mxc/t5RKacJDRPAwdfKQlLEIUah+OKX/huZhyAfxQFY94dTpj+9W/i6cXNtxw==
X-Received: by 2002:a17:902:e743:b0:21f:61a9:be7d with SMTP id d9443c01a7336-22e5edfa34bmr10893105ad.49.1746568859875;
        Tue, 06 May 2025 15:00:59 -0700 (PDT)
Received: from server-kernel.moonheelee.internal (d173-180-147-14.bchsia.telus.net. [173.180.147.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e1521fb3esm78746415ad.121.2025.05.06.15.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 15:00:59 -0700 (PDT)
From: Moon Hee Lee <moonhee.lee.ca@gmail.com>
To: lukasz.luba@arm.com,
	rafael@kernel.org
Cc: len.brown@intel.com,
	pavel@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	Moon Hee Lee <moonhee.lee.ca@gmail.com>
Subject: [PATCH v2] docs: fix typo in energy-model.rst
Date: Tue,  6 May 2025 15:00:57 -0700
Message-ID: <20250506220057.5589-1-moonhee.lee.ca@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes a grammar issue ("than" -> "then") and changes "re-use" to
"reuse" for consistency with modern spelling.

Changes since v1:
- Limited scope to .rst files excluding translations, using:
  find Documentation/ \
    -path Documentation/translations -prune -o \
    -name '*.rst' -print | xargs codespell

Signed-off-by: Moon Hee Lee <moonhee.lee.ca@gmail.com>
---
 Documentation/power/energy-model.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/power/energy-model.rst b/Documentation/power/energy-model.rst
index ada4938c37e5..490ddd483f46 100644
--- a/Documentation/power/energy-model.rst
+++ b/Documentation/power/energy-model.rst
@@ -230,7 +230,7 @@ Drivers must provide a pointer to the allocated and initialized new EM
 and will be visible to other sub-systems in the kernel (thermal, powercap).
 The main design goal for this API is to be fast and avoid extra calculations
 or memory allocations at runtime. When pre-computed EMs are available in the
-device driver, than it should be possible to simply re-use them with low
+device driver, then it should be possible to simply reuse them with low
 performance overhead.
 
 In order to free the EM, provided earlier by the driver (e.g. when the module
-- 
2.43.0


