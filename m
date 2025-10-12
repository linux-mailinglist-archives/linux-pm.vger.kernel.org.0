Return-Path: <linux-pm+bounces-35938-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C09BD0D9D
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 01:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5829A3B0C28
	for <lists+linux-pm@lfdr.de>; Sun, 12 Oct 2025 23:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769B72F1FFC;
	Sun, 12 Oct 2025 23:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="nUABm1eO"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FFA2F0C7C
	for <linux-pm@vger.kernel.org>; Sun, 12 Oct 2025 23:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760312133; cv=none; b=bsGzmHyxJb7rJ/12+IsO6hJbCs1asMPaGvp+lawNWOZEEvmZG5301UMUFAI4CIwDdr+w/5gIqj1XTIOvbngE2Nz06cV8KqUI2SbxM8XqQgCGl+skK6AjU5N8Jxqx3IS2xb9DGeUlaqvTZmDHXl5CqvdOe660rC8xrovbTG1K/wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760312133; c=relaxed/simple;
	bh=RjwSkuSroUgpMQ3Z3ISFdpypDXbCwD3Kcl8yzwyMI+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SfTYFKoGgjz09HDbUgvJKjNqq3yHEVm/zydcv5dm2FP+b3VnuoalQhtvFut9bqm1nI8HjdSV8AfoSNrkEYixjt9KTZ6+qWoyGGT/Chtw+ZdVOx1tt6v9ITh74cuQ3FzpigAyYMAxxM8DPgYl/CgsezRpv1hU7hdtZ9qrx0WTOvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=nUABm1eO; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
	s=key1; t=1760312118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jkhzacjcds6W3I5BIs0Lk/YOFhJFn1fRWKod7Pdp9mY=;
	b=nUABm1eObyDhr1Xns2e9scHvW+Qmu4UQMkC238cRQq4yFyXqwIy076cmUhG99WWIfRGlky
	Fc9RSSehKm+J0avAEc59gBgZbMtvWFqxAAiI1/yaCnAGnz2ztzutvepSYgIBwtUtpLRkwf
	Zve8blObIBY3PjiG/l1ilHZVE1h6Q89ReOXKXz1dPcIdg5acD+naVQLWmw2kw2hC17siIc
	sCU7ktCeB6BZm6weB0itSM6ng0anFa+MVaTCw38nb0mMNJyrpGA0QptlMxA3fpkfltqFzz
	wZo9PfYQ54XoioIoxsarArLa2TUwcjVskKNaNdU5hK+R8liiYH+qsa3Po733Iw==
From: Val Packett <val@packett.cool>
To: Sebastian Reichel <sre@kernel.org>,
	Fenglin Wu <fenglin.wu@oss.qualcomm.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Val Packett <val@packett.cool>
Subject: [PATCH 0/2] power: supply: qcom_battmgr: improve charge control threshold handling
Date: Sun, 12 Oct 2025 20:32:17 -0300
Message-ID: <20251012233333.19144-2-val@packett.cool>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Currently, upowerd is unable to turn off the battery preservation mode[1]
on Qualcomm laptops, because it does that by setting the start threshold to
zero and the driver returns an error:

pmic_glink.power-supply.0: charge control start threshold exceed range: [50 - 95]

Kernel documentation says the end threshold must be clamped[2] but does
not say anything about the start threshold.

In this proposal I've special-cased start==0 to actually disable the
functionality via the enable bit, and otherwise made both start and
end thresholds be clamped to the acceptable range. Hopefully that's
fine? Or should the [1 - 49] range for start actually be rejected?

[1]: https://gitlab.freedesktop.org/upower/upower/-/issues/327
[2]: https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-class-power

Thanks,
~val

Val Packett (2):
  power: supply: qcom_battmgr: clamp charge control thresholds
  power: supply: qcom_battmgr: support disabling charge control

 drivers/power/supply/qcom_battmgr.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

-- 
2.51.0


