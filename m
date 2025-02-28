Return-Path: <linux-pm+bounces-23165-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CB8A4937C
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 09:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E97A16873D
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 08:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387DC24886A;
	Fri, 28 Feb 2025 08:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r+1POZyZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EE1214A8C;
	Fri, 28 Feb 2025 08:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740731401; cv=none; b=cvLhiSnfB2tj6Viq1J36UVpKdllTGSisJn2igPs8bR8j0bqXso5MmC9oVmNYSIFLW5IaPRJ89ie9IsHhXykH1KbfOaPq/44uw/dPlGlhNfsb+ou+iZOu2FJUimjrYfP1P1Pb+NZ0VfXlxR48ll/dBNQCuebX2sDRU5roUNaUg3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740731401; c=relaxed/simple;
	bh=An+3D7fMVEQAOZ4TvD4JYDkfVVMU6MDWRcyaKUi6AuI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XWRN3dUAMyucKOviqdkuX1G6eM00i7i8AaWLWke6gjaH9GsM3Vva5Wb1dfiAnc7rn1vN7OTpGb6mlVayfYsvH8kuCfE7WzVbxHc3X8mL5wezOBqzDaMa667Pxa3cZYsxw9m43aJ8DR1gz418hpnDsDd8v9dOo0uAa+fwwrnVwbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r+1POZyZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F30AC4CED6;
	Fri, 28 Feb 2025 08:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740731400;
	bh=An+3D7fMVEQAOZ4TvD4JYDkfVVMU6MDWRcyaKUi6AuI=;
	h=From:To:Cc:Subject:Date:From;
	b=r+1POZyZeCf95SVNCD5We0/hH1PS7rvuCV2wY/QBpBgN/lqqkRwGzKDwPPl/LlQye
	 CNcYOCLA2/LPyQ/+ghE1xuobkFehz4DlxXWALYnCiHJrN8+Q2hurLruQwnj4jzVAHP
	 e2aZS7SuHGXG7cAXMhPL9yAsEgFkK6JEpl1vapvx7jFBmIGOeFeymR8sn4DeUNP3Or
	 Glp1aMTXgrzMd3vjCkVsQmlte9QWjDb+FKi6bPLUjNYapGVtIrEh1b6H/t5LFhB1ir
	 yG1T2sxNRJeGIckq+VpDdoAAZGmqGwkJ/GnkXsX+yCtPYGknmfzJQYQjqMKJpgFLvs
	 KAKJvj8EFMlRg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1tnvl8-000000001V3-02zY;
	Fri, 28 Feb 2025 09:30:14 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	"Rafael J . Wysocki " <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] thermal/drivers/qcom-spmi-temp-alarm: drop unused driver data
Date: Fri, 28 Feb 2025 09:29:36 +0100
Message-ID: <20250228082936.5694-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.45.3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The platform device driver data has not been used since commit
7a4ca51b7040 ("thermal/drivers/qcom-spmi: Use devm_iio_channel_get") so
drop the unnecessary assignment.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---

I noticed this when doing some rework for pm8008 last year that I have
yet to finish.

This can go in meanwhile.

Johan


 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
index c2d59cbfaea9..a81e7d6e865f 100644
--- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
@@ -360,7 +360,6 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 	if (!chip)
 		return -ENOMEM;
 
-	dev_set_drvdata(&pdev->dev, chip);
 	chip->dev = &pdev->dev;
 
 	mutex_init(&chip->lock);
-- 
2.45.3


