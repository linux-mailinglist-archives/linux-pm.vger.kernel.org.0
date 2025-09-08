Return-Path: <linux-pm+bounces-34163-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB28B4930F
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 17:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 74F544E1D09
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 15:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DFD30DD01;
	Mon,  8 Sep 2025 15:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vMzWFNXs"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACAC304BA2;
	Mon,  8 Sep 2025 15:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757345067; cv=none; b=XQ94RnJaq1DvcemQqVfTV0A+IU/TiPVvC43ho1sfsciAsHgTwoOqAwqrdZl+4Hxsg6xJZW28l3UyDuJfKD7qg7zrXtFQlIXKhFcI0FjCBKl2Weo0PEJlPH+HwUGAY2vd63KueHqNgTez9yCP47msGenrBl7L3xyzRkMdwOm8vQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757345067; c=relaxed/simple;
	bh=KP48a7vfnnXh6scoEMtZSA6zYWODOusITUaTuLc+hDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HLcW/aN3USF6Ngx81y2dDn/O7Wwz9A56GyQaxPuHx5sCkDOyz4DICwJ8GO7+BHDRvflrn6bCfShQ/65PEmim6vu0hAn6OHsDmoxv2yMqRKgl1Hj7wyNtzwgvJfbSCVCaLnIbyWp9jVGtQC0SQqOOsyJTN7qMmUpDNr+x566eaRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vMzWFNXs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F42C4CEF9;
	Mon,  8 Sep 2025 15:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757345067;
	bh=KP48a7vfnnXh6scoEMtZSA6zYWODOusITUaTuLc+hDQ=;
	h=From:To:Cc:Subject:Date:From;
	b=vMzWFNXspNGWa/OyYHGikB0Ji2ew5vjMaG1qgKfMR2FpFC5ZqtL6zWK+PaFSvRJMr
	 Y5IpYZNYzA1/B/D0k26iNitl32XpPBvKtFnGvZLhgI84uHVduM0zUWPxVblZtmpLIJ
	 NgjY+KuGWZ+fne8iklVkYdZy6gR08ylYb36zgag1Bp3i1wQJxfN4Nm2ywhsaIvuMOS
	 gZMZKEietAS3Or/p4vJgsLZKWXYz3LjTy+jiQ+XXXp59r4j5cVlQ0RtNUd+nZkaq6I
	 9D3nevBV18rnFpkbhWvsSdpXj3J+bKCDOXOINXMaDiei/aLmgpKzNdZf8YUNurB01s
	 rk6LXb7L75f1Q==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1uvdjE-0000000080U-2Vzd;
	Mon, 08 Sep 2025 17:24:25 +0200
From: Johan Hovold <johan@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/2] cpuidle: qcom-spm: fix device and OF node leaks at probe
Date: Mon,  8 Sep 2025 17:22:11 +0200
Message-ID: <20250908152213.30621-1-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes a mostly benign device reference leak during probe
(e.g. to avoid it being reproduced in other drivers where it may matter
more).

Included is also a related cleanup.

Johan


Johan Hovold (2):
  cpuidle: qcom-spm: fix device and OF node leaks at probe
  cpuidle: qcom-spm: drop unnecessary initialisations

 drivers/cpuidle/cpuidle-qcom-spm.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

-- 
2.49.1


