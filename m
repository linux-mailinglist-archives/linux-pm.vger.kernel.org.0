Return-Path: <linux-pm+bounces-32047-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A516B1DB22
	for <lists+linux-pm@lfdr.de>; Thu,  7 Aug 2025 17:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A7BA18C1D5E
	for <lists+linux-pm@lfdr.de>; Thu,  7 Aug 2025 15:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC2F26CE21;
	Thu,  7 Aug 2025 15:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I8canp1+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899B2266B52
	for <linux-pm@vger.kernel.org>; Thu,  7 Aug 2025 15:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754582311; cv=none; b=SF5NbHniycBpRwYhhmCdlSfcbN/cjiTfVNqDDNsYcT013k1YCnNA/Xw4H9Rm+Bx11eMQIOOzrVytpEuCf6RE1eVrj6g+pMW5TDTfi3/4H/IhRDymlo1AUxpJqtUKapPpg4UtrsCZfL13WY9OBFL4YqYG0K123+M1+rSLSRJOS8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754582311; c=relaxed/simple;
	bh=UebwSTgEBGX45jSwaqppv1MZDgNUsTmKmv0RDSYtYBM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oemQTXXwsMic4rXj0Vw2GpT9LJAeXmgcblxfs8Zxb8y8cW+qkJcYtE4sozUCaLI1oVjkRr0Wn0FDJk1JVKfe9zxIm47bxJVtiGuTxf4EhHXlJmKwjhFeFh6zbU9yjWRngQEFtP9Bviz5QOhgkBdNDcPmS/boH//O65RAajgdkx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I8canp1+; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-459d62184c9so7844805e9.1
        for <linux-pm@vger.kernel.org>; Thu, 07 Aug 2025 08:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754582308; x=1755187108; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ujGGaXLwvEaTDaelriMZ69/JBFsXGLBD07Z/REYyW1I=;
        b=I8canp1+HIYdWbmOTJfwAl3ic72csHSF9VQgrOjEGHQ4l8y4evhhxJ4ABC9uKGqKDK
         d3rGH4+lVZWpqlVguEXobU/mIpenQlinoV0jBumjFPSrcp6Sh2O414XnOrfwwY5pebp/
         Ml3SA/ZrCBYl+E/TcqcDK7nXtxmZO1uPgT+/HESLH1XMkscvtaqOKjNZR4G62c3UXpH6
         VPGlL0gkcaCFW8a2fAeUd/F4U8bhf/JWZoLlCv+A+E8d5UEXbLTGh5GNF0d7/Moi8tFr
         N4e2VQQepTLAOG1WCzXVe7ZPhJc2gVjdKnRdw/FuYdJeas6d4AXmIKYam9mTFqXDbP//
         Lbog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754582308; x=1755187108;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ujGGaXLwvEaTDaelriMZ69/JBFsXGLBD07Z/REYyW1I=;
        b=XhDmgImhq5fVS7riMyc/ZOOpBAv8fIkTO1bjW5g4TtDlDjX8XSAVGR5F96ebNakqjK
         VDEBXp4/0Ub50qDl8UiU1osCzHuDKUA7Dru1BwTFLZp/UDIheQ8N19t+EHl5iRQEQYo4
         kuoBCLvTfClZqmowlWPDPT2fSegh0StUJ6+5HNpgcqLZq62RAeehxz4qUfcRhvxah+hs
         HoqW+S56Gkg83/32JSMAZZcQu1PfrIBoAzc4WYXNw+H6nJwBQXWOK4XGlhwGZCt8JL26
         iOwBk3UAMzlueLrI6n0rlQ2NVsLXF2cGhmiJU25Cwmli/IPHKOagk/z6vfjxDana8OhO
         tU1w==
X-Forwarded-Encrypted: i=1; AJvYcCWP2SrLYNR6AvDr9M2RC+CqBt+K2K1XM7tqfVYaLDt1AJ1HaKHpLNlnqPCLoIN4tLvEVVsXcHha3w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwOMMw3MGXzbbMRhr2ukmRpxKRPFxxU1TABKgGg4RQqULPMiFNE
	mqovO1jErQskMMBDK9BxgfwSGviNNGviJmU9YeUuB5NCq6ZgbMkpum4UJW4HFOMxUamfuuZgzE+
	xEHWF
X-Gm-Gg: ASbGncvsH4g+EzAMWTPRLNQvKfwhS2e5xRTQMnEFJODzE7CDUbc3KZIla0qOAjnoBMJ
	xQVzp1m4cM9IdwIKUHfK+Nc+ocutWH8eKt9EXHJQH49xhXGPF2urOrsXDu8TB5UWkmflD9PQlRl
	yPMycw3MFzUyOR9NyDavUB2tS8XT4PXrkIt0KJnTJ5WE6Ga3sDXFNwYxjV0Gk4Ig+jFU1P7iLZ5
	Gv3pdgQFAtvd8xyM/cYLnNGf7hx6LtquUvWHdSgUzKRWsNTGjl5GN+PCuyFFMZzWJy5azqB3R5f
	T78L9b336IFO2wp0sPZ8RUaGJHQsqqpV5C8KtACc0LenzRP5LeLxLDC1hnCSC49Oya/h63Cs4lZ
	9lMmp14VLJ6zh+iWJqhOVL8I9T+w=
X-Google-Smtp-Source: AGHT+IEQAtbjB5WuaftcfISb7loqx9lFVpOAzAnPzXuHW243UbLgIM9IVwryPWI9EYIwJTEBgNYAhA==
X-Received: by 2002:a05:600c:154e:b0:456:1a69:94fd with SMTP id 5b1f17b1804b1-459f431f845mr2720525e9.0.1754582307874;
        Thu, 07 Aug 2025 08:58:27 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-459e587e154sm108933495e9.27.2025.08.07.08.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 08:58:27 -0700 (PDT)
Date: Thu, 7 Aug 2025 18:58:23 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Matthias Brugger <matthias.bgg@gmail.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] PM / devfreq: mtk-cci: Fix potential error pointer
 dereference in probe()
Message-ID: <aJTNHz8kk8s6Q2os@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The drv->sram_reg pointer could be set to ERR_PTR(-EPROBE_DEFER) which
would lead to a error pointer dereference.  Use IS_ERR_OR_NULL() to check
that the pointer is valid.

Fixes: e09bd5757b52 ("PM / devfreq: mtk-cci: Handle sram regulator probe deferral")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/devfreq/mtk-cci-devfreq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/mtk-cci-devfreq.c b/drivers/devfreq/mtk-cci-devfreq.c
index 22fe9e631f8a..5730076846e1 100644
--- a/drivers/devfreq/mtk-cci-devfreq.c
+++ b/drivers/devfreq/mtk-cci-devfreq.c
@@ -386,7 +386,8 @@ static int mtk_ccifreq_probe(struct platform_device *pdev)
 out_free_resources:
 	if (regulator_is_enabled(drv->proc_reg))
 		regulator_disable(drv->proc_reg);
-	if (drv->sram_reg && regulator_is_enabled(drv->sram_reg))
+	if (!IS_ERR_OR_NULL(drv->sram_reg) &&
+	    regulator_is_enabled(drv->sram_reg))
 		regulator_disable(drv->sram_reg);
 
 	return ret;
-- 
2.47.2


