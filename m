Return-Path: <linux-pm+bounces-17958-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB9A9D5FD0
	for <lists+linux-pm@lfdr.de>; Fri, 22 Nov 2024 14:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22510B23359
	for <lists+linux-pm@lfdr.de>; Fri, 22 Nov 2024 13:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494E212E7F;
	Fri, 22 Nov 2024 13:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XAKatMsw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAD5259C
	for <linux-pm@vger.kernel.org>; Fri, 22 Nov 2024 13:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732282935; cv=none; b=og044MDYj1/g8FVznJlf484qvcNwow1EL4xvF46zq4bjbpILKvZ1lNmTpAVszGIUsEliGht1RRT8BaWVb0F2VqAM4SfrVxMUJ4y9lystEPiRuco3yV1n4d4v7tZz24QnLuZfxC/IRyr2jqIYy40j9U47ySslhY+FNPYfhV0qO2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732282935; c=relaxed/simple;
	bh=vdClCEEENC+YN6w0HUYbAxBS1Vuzfwgoe0+fu0g0IhI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bymo/TfJLvVLpDkO/ObbkCT09DIbwa75mUqTgOl/uccKi+Y/JFY7oLHa97J0AHoPuPo0lSMN8vsfLrskhtvEYdRQaWuBRfskurcLSpUH4jaQyGaJaRme9KV5kFaSJXw5e4CW6kD6ofOxmfZH7tFKp36mDGGLyCEHLixWFJTID9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XAKatMsw; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53d9ff92ee9so2453032e87.1
        for <linux-pm@vger.kernel.org>; Fri, 22 Nov 2024 05:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732282931; x=1732887731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kECXJ3tt3b+Rzl33FyQosajYwVB2nbctS6FkdLVf9NE=;
        b=XAKatMswPYgpfcjwAWgUkU/vadpk1wdRhDGRLOtABMKKRQbeL2s1m49bAwXS4hRhqs
         NfkdxPS0ed/0LxhgHMb7IsBbgk5DOfr8OSuQ3GUzA4ggTP3EE0oQjfmnuztcXe6bX4t6
         rXMdYDjcKEwbySMX6KlVU3QUeEDQkKRxbjwtbCiaWnv3AOMvHOBFZznwSgWlQV1/hLyk
         bvZAsZJNhv1lG18LDwPeMkKgY3GV/sDR81Mc9cdE++FxSCy5oCaoDDO1s7F/4Z7I1FMm
         Xzr7gqlkmt5FR3KgY1X//FUQ3sQ/i1tdKpSoU9Xev1yvNWI1R4Y3tOVATIJEcWZ5TbBR
         Skdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732282931; x=1732887731;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kECXJ3tt3b+Rzl33FyQosajYwVB2nbctS6FkdLVf9NE=;
        b=t5kNs/nDAFvoyZ3SUDJyPXJxzBESvsPWSorTSbbJZijNG1LDeOD9wFWpX78xu5xCAL
         ZoPSsFTNEkJ8GdeAY4Y0IW36bb7qdUH96oJlXqwUyT5ZB1Q5bZ+/ysZjoYeMcxY4D965
         odKjo+VPtXeFdjy+MWJ8PgWq29RHpDR9WXV/VSEc7vq4N1XX9Vfn2fC5HehesZS5RUZB
         nfba8pTJNZ4d2QHNClbfiLJkOHDqqPTlEQltoEd0s7BDcrWIX0tzKpARbTlmBkYBnbce
         x6keewsCNcHDTRz0wGhtWhL2ASKKuWQIZZSnuV6CQ0kBgskO3RmNuL1ygbCkHrUP42yz
         kbQA==
X-Forwarded-Encrypted: i=1; AJvYcCU4q38aRuGCfAFzaTuuAA2fOznG/wgi0l4XPvJgq6P7+YsfwPq3CxclJ0IvZb6WhdrAfGBBf7tBKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPh+h6uIlJG2t8w1KpW7ndPorgFvak7UM0hVr1iMJjCUxUCTn8
	RbGv1zi08KPo4CjAm8yBOaxL46NcdU9MWf7n8jRXUQvliQ+SuyLjtkH/LuMBalc=
X-Gm-Gg: ASbGnctYJ/yGmecHqvXrXRVh0BU/sKZASuOOpuiwyzcFBvuSMKkQ1hwa2Ge4pO8nPVw
	6bmv7EwR4VPLscUxdQM1GxZYIVH1hji1yIPxfWRtMKTV6GASDoETqo2RtXDoJP1VnDJmtEcZ1CZ
	3fFQaQGMJr+K5dVQoRVaFs44qDOWolTVhVukmxNjyPeHwhI+nzabem0NkzHOwVgWyCBYjY+CFCm
	TWgwt7tfkZIkS0NgEbv2JGPMat3aSqQIDzqUBW9ohGJ3DjnztUhjaoq3jxriSvgq42hmXjeOeb7
	2GCEctwZqt3CoSVrmxo8xeiq
X-Google-Smtp-Source: AGHT+IGlUj819yfU1NglS9myUqpv0uFLKQ7u9TuPUIL1bbAcBAmi8sjSJvBKcWX+TVn+XB5jFJ905w==
X-Received: by 2002:a05:6512:3d22:b0:539:ed36:eb8f with SMTP id 2adb3069b0e04-53dd36a1498mr1694046e87.24.1732282931567;
        Fri, 22 Nov 2024 05:42:11 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd2481e73sm376432e87.120.2024.11.22.05.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 05:42:11 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] pmdomain: core: Fix a couple of memory-leaks
Date: Fri, 22 Nov 2024 14:42:01 +0100
Message-ID: <20241122134207.157283-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

More information as available in the commit messages.

Ulf Hansson (2):
  pmdomain: core: Add missing put_device()
  pmdomain: core: Fix error path in pm_genpd_init() when ida alloc fails

 drivers/pmdomain/core.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

-- 
2.43.0


