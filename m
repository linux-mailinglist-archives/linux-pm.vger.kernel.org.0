Return-Path: <linux-pm+bounces-11049-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C9792FCE9
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2024 16:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5C561C22D0F
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2024 14:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E230E172BAC;
	Fri, 12 Jul 2024 14:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hVaarWED"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D982171075
	for <linux-pm@vger.kernel.org>; Fri, 12 Jul 2024 14:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720795895; cv=none; b=H6dCqGCrNgvEWl/LP6mNJ5mrqJCRjsbVtGcK2zUe41k7yaifEoDQ11NXBNHLGieh8s9BNdrg7AlKmfRZQ95DNJc4pj7of94DcxGzpcC1cHfamL3Fv/JgoiiOSDv03aB5ZVSxN6DhL1VUIgYdd8sD6qePfq1ydYbvointfAFZufs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720795895; c=relaxed/simple;
	bh=6Xme/fG7NEewAT3iCDuDM/s9b4eHsxK5bexy9nMN6Ew=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bbH8hOmn7o0u7m50X9kEXj4OzyvKTOjQfyK2LYsqp8RUCj1Kw/dAmWUKnz/l1aEwd7FLnMQNKBPz1Qqkt+Q1S16yJifr0sjdD05sCo/eZoLjDbk7xcWETvXV0sWHR10gW4CMCO0PXcRR/yUcfMnfygaIVxQilWoSgss4F/Z2zMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hVaarWED; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52ea5765e75so2481951e87.0
        for <linux-pm@vger.kernel.org>; Fri, 12 Jul 2024 07:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720795892; x=1721400692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ky4WPChWhIsghhn+5sM672ORVDTwy7ezIsC/I8SFrEU=;
        b=hVaarWEDDueA/zJa+Cm7+u7dGK2+rjWsj5TcwJNC6L1+frYzbzOX7PpVqqKWldUHs/
         470yi0V3WlaNEYc2k4YHiaz6zUO6eD/Kk+BXO4R9etzAxufrmhfTIiZDkYjTTUAkCyoj
         H1i1dm9yfbg+ztG0W7XcRRyMuN8XmyJjb6eqyCoLQStwK5EbFCPucmRPhGtx1skO4kEr
         sQeHoL1cCMcJTw5wHO0OQgqkMofVk2OxI+gJmEf4jOGrcH8naJc8KO09KcLA9NaMR4tK
         FaQHgcE3gytyPLuHaarcTWaeVyxIzwGqg6vicrcABM6xFzIYr9hD773YR9Jq3mj3t6KR
         NwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720795892; x=1721400692;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ky4WPChWhIsghhn+5sM672ORVDTwy7ezIsC/I8SFrEU=;
        b=NrzLg08J2riozdkoUGRQVxJEY85h4XzReR7mHHZtdtmtYausNy+clgW+l0E0mMufHU
         ps4GVkvtQBQxd29wRyMaQgV4PWzwcgMDBkzV5yTnsN6ftn1iCNR3rCXWZ2R5ZTVQeAlZ
         y+W9ZOpnolVNyejYB/+0xsCZH6E56/enJ62Fzl+UFrrJdOyb+1MR9Sd2KW7bAh9y7hC/
         V3FlMyN85V9to8FJigQH+796+uWirIT58Iyrvj1q7N8fYj7vOjYVp4Degtl7mVIlBkdn
         /j/mBXKQyGmpBQGxwbDswLhlQuHEm8hMho8RtYeZpCrLZiEzKR/pSHoqQIC3vNYG3Wt4
         AuDw==
X-Forwarded-Encrypted: i=1; AJvYcCUoU5c0XL970P3C3UoUaLmk4k8Dy+GWc92sZlfNiVkN/iA09FTXdOqXT7IXWphjWxVpp36Qn/u+D2uhIrC69VRo6JS7c0j5HSI=
X-Gm-Message-State: AOJu0YzFUVCY/mXnEFUaXoT/aO9406pKejjswaf1DQueVNbQYJGjybCE
	hGRz7DSQj0B2BlEMW/xzRzl2IdH6DHEXsPKWpzna2wqDOZdr7VOqbkD/CgfvYicSPCnse752+3F
	8
X-Google-Smtp-Source: AGHT+IE2vju82VfTfF5Xrs+6WtBUZDSZ/EBYY7uH6eZlCo/ZT85PKn9f8YK9Az7B5XqPdDfnn4EbmA==
X-Received: by 2002:a05:6512:3a8a:b0:52e:954d:359a with SMTP id 2adb3069b0e04-52eb99d1eabmr8889644e87.43.1720795892533;
        Fri, 12 Jul 2024 07:51:32 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52eb8e3454bsm1316600e87.61.2024.07.12.07.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 07:51:32 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] pmdomain fixes for v6.10-rc8
Date: Fri, 12 Jul 2024 16:51:31 +0200
Message-Id: <20240712145131.169802-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a PR with a pmdomain fixe intended for v6.10-rc8. Details about
the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit c3f38fa61af77b49866b006939479069cd451173:

  Linux 6.10-rc2 (2024-06-02 15:44:56 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.10-rc2

for you to fetch changes up to ddab91f4b2de5c5b46e312a90107d9353087d8ea:

  pmdomain: qcom: rpmhpd: Skip retention level for Power Domains (2024-07-09 12:47:46 +0200)

----------------------------------------------------------------
pmdomain providers:
 - qcom: Skip retention level for rpmhpd's

----------------------------------------------------------------
Taniya Das (1):
      pmdomain: qcom: rpmhpd: Skip retention level for Power Domains

 drivers/pmdomain/qcom/rpmhpd.c | 7 +++++++
 1 file changed, 7 insertions(+)

