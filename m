Return-Path: <linux-pm+bounces-13693-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E8296DA4A
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 15:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D60D2850C5
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 13:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A33719D07C;
	Thu,  5 Sep 2024 13:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FEybFqNL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D141527B4
	for <linux-pm@vger.kernel.org>; Thu,  5 Sep 2024 13:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725542947; cv=none; b=tElHivBbem6CtQRCeRmyAdYP1ZATOaDGdIxhLl95TgBWPbM4hqG8mqei14jwV7zkl0Z3z/r4I1UIduzBorW0iESPhaCV1N/iFNXIN0WLJ1M4f3amW3nsgQUR0MdfPPT60eyRDdVgAGz2WB9UBVO8SHOzbswrV300g6MhNC2J3EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725542947; c=relaxed/simple;
	bh=5evTdunuLhVAJcs/+kUduc/E4egJQadthe4kW1wlI3E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=etjMsvb+idvl0ywyOTTUS8PxTiTgX7/Qf3RqwVxDbVZKeZF1qCis6r3pVbloQ32199Zvn//x2Z/4ejWE+X4usP93HrWeMH181242/rtGTEwsNo3SKzj4wNOP0KQHUkMU08N3kjoXdgMJK9iMhauvNeV6RwAFTxuJI0DY/STeKqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FEybFqNL; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42ba9b47f4eso4541755e9.1
        for <linux-pm@vger.kernel.org>; Thu, 05 Sep 2024 06:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725542944; x=1726147744; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mmo44zFx8mrvsxCT8MsK26g0o98DN2eXGHyiYlsG/6k=;
        b=FEybFqNLjPU3DSuy++aT6kG/iP1oegSY5KCdeqqtpy1yBIZqKmg4BBKbqHb5qOifpi
         1bGJq63JCO5uq6BKdnPveSslvcPp7/9ABiu9lFM6+A+dBuzBPY5j+4SoZqPyb0geF4sH
         ODh4ZMDycG+Ui0zyPBAQ92c0VZW2/akNGxnOTCnld/PIFvR+nobySiw22C2ZFtpp1Oj4
         fPsg9eTZTkJBdXmdYHbj+V3K3nYDmCemIUeF4aLKcWMSXCL/C18PDWGmTkpaE9b+iVAh
         0S8iywz3b+aPu4GfrCiqSXbBBo/sgvmrJiCTjaoMAAl452ljdMU4JzJmTbwU4YW2fEWm
         KtvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725542944; x=1726147744;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mmo44zFx8mrvsxCT8MsK26g0o98DN2eXGHyiYlsG/6k=;
        b=C1O6K7geZpSRRlm0lelJvy5WK8W9JJt4XwnfK8XFylYy3XnCP4zp0d0SmTp3HUBw+m
         WNy1uoNwoxNAWqvAvtcGkLjeuWDDKiK2JxrACJqxqf9nC23NhSfovgKLr9BOk9CL0Dmb
         hNIPqIbNL7inKdgtuaoTgDm9DN7Q6NXEdRBgQ4hYh46kYqUSoipWnC1hincLK0nEaGeJ
         nqTsIze1MZhmZJD5ljg0kulHQtvq+cXQsR0HFdOeZKOfruCBmgiNOZoETmPBUbgebYqJ
         Ghgm0BNoccWpRABd9ql4kQK/1sM4mdGWghepgUL3yHkEl70xdgvCilR4oBtB/7sFijuX
         Voxg==
X-Forwarded-Encrypted: i=1; AJvYcCUm7jAdXbDt/rELgUNaEnRa/SBf6TPaUhXl7GfeDPtujnNeDJzEkL/GXvEG2bzWuJVJG8sqU5vK4g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzaULcStuhYzhHTHdiIM2MO2naS8ZPlgeZ4hpL/SqqGiyqedzfJ
	ISRnhTwBoNnj3W6MrBCYZdjTGmOOgxRsuuIWleMRo2puBTWo7/epphHbfFFL8Mo=
X-Google-Smtp-Source: AGHT+IFsWenqoAd2RFaGr+OZ74a6/40O2rid0oEltUVZXpv8n2OTkZHPQAC4DFZMtytig8GfX00Tew==
X-Received: by 2002:a05:600c:3ba0:b0:42b:b016:70ce with SMTP id 5b1f17b1804b1-42c95ac1978mr35442465e9.1.1725542944053;
        Thu, 05 Sep 2024 06:29:04 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374b9859486sm16167785f8f.111.2024.09.05.06.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 06:29:03 -0700 (PDT)
Date: Thu, 5 Sep 2024 16:28:59 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] power: supply: fix a double free on error in probe()
Message-ID: <9c2f76e7-5679-473b-9b9c-e11b492b96ac@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

In this code, if devm_add_action_or_reset() fails, it will call
max1720x_unregister_ancillary() which in turn calls
i2c_unregister_device().  Thus the call to i2c_unregister_device() on the
following line is not required and is a double unregister.  Delete it.

Fixes: 47271a935619 ("power: supply: max1720x: add read support for nvmem")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
From code review, not tested.

 drivers/power/supply/max1720x_battery.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/power/supply/max1720x_battery.c b/drivers/power/supply/max1720x_battery.c
index 3e84e70340e4..2bc3dce963a3 100644
--- a/drivers/power/supply/max1720x_battery.c
+++ b/drivers/power/supply/max1720x_battery.c
@@ -427,7 +427,6 @@ static int max1720x_probe_nvmem(struct i2c_client *client,
 
 	ret = devm_add_action_or_reset(dev, max1720x_unregister_ancillary, info);
 	if (ret) {
-		i2c_unregister_device(info->ancillary);
 		dev_err(dev, "Failed to add unregister callback\n");
 		return ret;
 	}
-- 
2.45.2


