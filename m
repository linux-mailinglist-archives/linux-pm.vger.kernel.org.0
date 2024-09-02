Return-Path: <linux-pm+bounces-13365-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A265968FDD
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 00:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 574B11F2454F
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 22:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2116F18786B;
	Mon,  2 Sep 2024 22:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZBz371vk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1545FDA7
	for <linux-pm@vger.kernel.org>; Mon,  2 Sep 2024 22:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725317306; cv=none; b=AX+veVX1mVKdi4YhfMb1oLfeS3VM8QX/YoSxJfEpiw82+fTAuPzXWMOS17eqtxKj2W+mWjGGXB8OZQ/nSTAgeAHX6g9meZjlW7t9svAGSEFMz48N5qWDBpiF4FZus8YLps4trfpo8r2L8+ZiCjvva/B0s1sUpvQ+Huk3w4IFotY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725317306; c=relaxed/simple;
	bh=mi5t8u/xebX7mhenOTAeq1Xr/3w8JvN1g+BM+B5n2Uo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=opY1zaOjizfvCfdQ2XoJDeXbYqX6ka7gLQKZijfalL6DG+zmZMu24w91ZZzgVDEzq1EyOMWDyVuI5v+Tsdg/mmSVUgaP4r7trNwYferIXlawkyZr62PYdD7EGfoILFDl4MyIvrEwHQ4EXNSSlrPSSHV3JUoNrqOmEERhZ0O560A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZBz371vk; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53346132348so5764129e87.2
        for <linux-pm@vger.kernel.org>; Mon, 02 Sep 2024 15:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725317301; x=1725922101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+tHt6YbEYKdIZoRecVjHoZ1hDu+9v6PoBrsVr9Tc8E0=;
        b=ZBz371vkN5VIxm8Q5NkYKTdzxvV/Y3Fxtkh3eDgZfMz2cdIPTJKLTho4b1EbgbUdcv
         h2wuiatvU1OrXGC4T+l82smLia1neNkL1NgzGh4pg57sMJp97ow8S1GNME9NdikJ63bD
         QVUzzK6no3h8ppedasYiNs0AoAbJGZzzwEUfeeBF1fsZljGaVMi09MQGrdlPeh3ubG3g
         M0kwAevlWWaxcrVFzImssYX0rr5ZylMLECdqKbhk0HwJL4iNEJ5AA15FQoU6go/TKLWf
         30MN2ScbhTBveZNSofPTKiTCIpS7BE3hnZR84Bcjwp9vkGTwNdWhpdZ+M2tGG/3vwAQJ
         unEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725317301; x=1725922101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+tHt6YbEYKdIZoRecVjHoZ1hDu+9v6PoBrsVr9Tc8E0=;
        b=fkpxQfjpLUoAvEgMBsjcUdErThUljUZtrD0Af9CZCAYyVH8gB1dJj4SmB3TR8OMSmN
         gYpKvERVcYHJNpMLP08x1j0lIWmdEc5lqEGSYtfZtSLz7mvpthhwAgjJJbHbljVnjQwy
         ami8mrpnZo3x79oB866IwW2nzKXt6BUztdRo93/noU7IlGEwPVxW7yoq+/dOm/xlt/Fp
         khob5O3KvC63Z2QkKzGtGDgt2vFW0DzJgWdL2ad9jpgRZmhrvltB1pYWjandl5LFrSfR
         DhvusPvcevgFPNrWRmaCJ2G7FQcFNDnoo/OzRJ6zTJKKAPLeUtcqF4S3e8ui9Wi0K2c7
         zI8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVeXkW+s5JkqYyp1CsqvgzOVyfjRGaGLQq2MxmInfY8Ylf34pPX7wN1qnNvI7KPsMObRAN3NgY/vg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ0rN6ZaQKFLkbHZCeoU8YHkNfysp5HVSUTNFIH1hZnFQKgRNl
	J8yNQJ0z3+gugAij7A8zxhBw8X7IgRPFPlHbPTH9nCrAvTlYFEWBmwXnXu8+al8=
X-Google-Smtp-Source: AGHT+IE5JsLl/nGfRejt5XBymU6zm0pRwvc7ZSu5/JJmpMVNh24v8a2zkgYPPPZHhLnvRh7ndQewkg==
X-Received: by 2002:a05:6512:1091:b0:52b:c1cc:51f1 with SMTP id 2adb3069b0e04-53546b2597emr7683029e87.23.1725317301026;
        Mon, 02 Sep 2024 15:48:21 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5354079bbf2sm1790646e87.20.2024.09.02.15.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 15:48:20 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Dikshita Agarwal <quic_dikshita@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <quic_kdybcio@quicinc.com>,
	Nikunj Kela <nkela@quicinc.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Stephan Gerhold <stephan@gerhold.net>,
	Ilia Lin <ilia.lin@kernel.org>,
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] OPP/pmdomain: Assign the correct required-dev 
Date: Tue,  3 Sep 2024 00:48:13 +0200
Message-Id: <20240902224815.78220-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The recent series for OPP/pmdomains [1] that has been queued for v6.12 via the
pmdomain tree introduces a regression for the Qcom Venus driver, which was
reported to me offlist.

This small series attempts to fix the problem by making the assignment of the
required-devs more robust and correct. More details are available in the commit
messages.

I have tested this on specific test setup with Qemu, trying to model all the
various way required-opps are being used. I would appreciate help with further
test on HW and reviews, of course!

Kind regards
Ulf Hansson

[1]
https://lore.kernel.org/all/20240822224547.385095-1-ulf.hansson@linaro.org/


Ulf Hansson (2):
  OPP: Add helper to retrieve the OF node for an OPP table
  OPP/pmdomain: Fix the assignment of the required-devs

 drivers/opp/core.c      | 15 +++++++-----
 drivers/opp/of.c        | 12 ++++++++++
 drivers/pmdomain/core.c | 52 +++++++++++++++++++++++------------------
 include/linux/pm_opp.h  | 13 +++++++++--
 4 files changed, 61 insertions(+), 31 deletions(-)

-- 
2.34.1


