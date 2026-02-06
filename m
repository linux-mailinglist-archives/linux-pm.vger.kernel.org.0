Return-Path: <linux-pm+bounces-42203-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOc6JBXxhWk+IgQAu9opvQ
	(envelope-from <linux-pm+bounces-42203-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Feb 2026 14:48:05 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4730BFE68E
	for <lists+linux-pm@lfdr.de>; Fri, 06 Feb 2026 14:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8020F30C82D8
	for <lists+linux-pm@lfdr.de>; Fri,  6 Feb 2026 13:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054B63ECBD7;
	Fri,  6 Feb 2026 13:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CIrrOrlB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854C23B8BB4
	for <linux-pm@vger.kernel.org>; Fri,  6 Feb 2026 13:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770385224; cv=none; b=MFZnGndwEyfXG+Ss8ljvECRQE5BoT3/LeidXY0XOJzzPaYwJZCM0mOmsBtZfFePRHOOpPG2QNQSHc1pezJdCWWpPxVbiDhasyv9EWaer5TJsdU9biIIj4UMwSWG0d4vgf/y/D7fnrUSsKEwf+pfMj9owbWuoleuVS1U2BjOVJWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770385224; c=relaxed/simple;
	bh=MsBaOlFTtNHSmjrYvF1WBawN2B1i3W2RNyrae6d+My8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bj4bM0iCxbTnATDgpw804zD7VuAHtVlwhljJ2RPdQES/M2yglmWs+Vi1GetWZCt6jAv9dSr1Q6F+sdWwQ6xtkPSZChTYdtabFRgrmM3fZ44TSvPQuT92wfGw35Jy1h0w5dTbtkuM6IOjAjNG5/VSIktT7EZ4pe7YOy7gbZGaNVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CIrrOrlB; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-4362cdf1d5aso492716f8f.0
        for <linux-pm@vger.kernel.org>; Fri, 06 Feb 2026 05:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770385223; x=1770990023; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SCKW2EKT60rAzHp4x98HKfl7+hwlJLayNRCIUaoeGvs=;
        b=CIrrOrlBSy92Dr7HZYiAZ26omZVTFnQLsT3eipG+Ex6TpRt7pFs9xWzMmM4IvJiKY9
         l291BgTU4CsmHC1i8bAquLkfOGOGqJltgj76YhIxAbwD73EUeW58w5Ze0qoA3qsoPB6W
         qUi1bgszkPepu8kp9k/z4YG0s0BmePRgjpXwYL222b9oJ6lz6HYGz+JyGX/zyEraPEBt
         5b+jNy5CaQDlzpbIin+2m/WtsOobV+Ep4ZVL09JY55ZT3OtclaPZ5WnpBMVu7xLATUhn
         +/pNOvXLBG7hRX3ZHwVBhhVOAJ4GnlP5zpWevP15UrDylpVU4Ym9B5ryWMdXagIiP6kl
         nZgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770385223; x=1770990023;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SCKW2EKT60rAzHp4x98HKfl7+hwlJLayNRCIUaoeGvs=;
        b=KsmtHMbhm6IUCuh5ziQP77p/xYf7IlH2tLkJK1f4HVWfo2hSGGVTQ30evHSGkgwK5F
         pHfpPnRmQ4LoZybTkiqTcZLLGJaXVXNJeWsXBrl9CcOtZ+yM4dD6mw/3Ox8989SmtdKy
         JcgXMaae1h1WzK6oGb8VYkRjZGys3ix6dxpLO3kAR9eR3elRJuyvNDROBhwvdtWQ6bIW
         ZO/jVLu1am+0QbMrigS+6giCGdpHmtxuNljl4XLzUn/wqFgDquGVbPEN5ibkFlMmmv7O
         KLXCK1iD4/3H4A9eeE12jfMD3Yhl/zDjbklDGGG53xh/IJM76KVNxIW3vv60gRtKCHp/
         l4QQ==
X-Gm-Message-State: AOJu0Ywe6Y3uOAVWwf9G91Uu4/tuNW3DfiDDgCRztQXYLOGo+eoTZ9MY
	laQaEKrS09aURah45bu+Xmj9jCxllS6QsZ3TF8U1Mug/6jtq5FnGwuYMQibbeBNxl+w=
X-Gm-Gg: AZuq6aK6rh2JAiDDr9O9vfyoOSYQOfsW9r561eKhnix1k99GF7mAaJXtIHK6mtPuxAE
	qa+oasBlFEmPU++/YUkC9OVT8tcCMgtAUcXpbXAoF/eKEH8Zzc0LqS5T/nl8naLezx0J8engixk
	mkXFFiWJ5QGdJp983Xr+v/kJ+YhlnT6nLw0ZenaVn7ZDPWevwLaklMUaczIb+09EQP41PJboVhr
	S2UZomwNIg5kiuf2oSp7spVaRZ1R+ziZC1gOD92woY8+8mLS6BpSkZIcqOmAI1LyRbuHM5q5pu2
	i+xw/s+bQXogUjIwViVafWAJwIx1PawezGc1++XinKezuV+/u14yGp4wnET25ORD9C0CoPzMkyl
	V5BGheTaT0kEcfkdNTX6M6JtewBtI2TxV2hOI9twvcNZN6Hf4KOG5yG2G/DYN48LcZ8fpusyAev
	fJgnxpGOknFJUdlcUR
X-Received: by 2002:a05:6000:1a87:b0:435:9223:bfd6 with SMTP id ffacd0b85a97d-43629342169mr4434497f8f.25.1770385222764;
        Fri, 06 Feb 2026 05:40:22 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4362972fa41sm5881120f8f.23.2026.02.06.05.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 05:40:22 -0800 (PST)
Date: Fri, 6 Feb 2026 16:40:19 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [bug report] power: sequencing: qcom-wcn: add support for WCN39xx
Message-ID: <aYXvQxKqmjP_sdCd@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <caa37f28-a2e8-4e0a-a9ce-a365ce805e4b@stanley.mountain>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42203-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.carpenter@linaro.org,linux-pm@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:dkim,stanley.mountain:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4730BFE68E
X-Rspamd-Action: no action

[ Smatch checking is paused while we raise funding.  #SadFace
  https://lore.kernel.org/all/aTaiGSbWZ9DJaGo7@stanley.mountain/ -dan ]

Hello Dmitry Baryshkov,

Commit 0eb85f468ef5 ("power: sequencing: qcom-wcn: add support for
WCN39xx") from Jan 6, 2026 (linux-next), leads to the following
Smatch static checker warning:

	drivers/power/sequencing/pwrseq-qcom-wcn.c:492 pwrseq_qcom_wcn_probe()
	warn: passing zero to 'dev_err_probe'

drivers/power/sequencing/pwrseq-qcom-wcn.c
    458 static int pwrseq_qcom_wcn_probe(struct platform_device *pdev)
    459 {
    460         struct device *dev = &pdev->dev;
    461         struct pwrseq_qcom_wcn_ctx *ctx;
    462         struct pwrseq_config config;
    463         int i, ret;
    464 
    465         ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
    466         if (!ctx)
    467                 return -ENOMEM;
    468 
    469         ctx->of_node = dev->of_node;
    470 
    471         ctx->pdata = device_get_match_data(dev);
    472         if (!ctx->pdata)
    473                 return dev_err_probe(dev, -ENODEV,
    474                                      "Failed to obtain platform data\n");
    475 
    476         ctx->regs = devm_kcalloc(dev, ctx->pdata->num_vregs,
    477                                  sizeof(*ctx->regs), GFP_KERNEL);
    478         if (!ctx->regs)
    479                 return -ENOMEM;
    480 
    481         for (i = 0; i < ctx->pdata->num_vregs; i++)
    482                 ctx->regs[i].supply = ctx->pdata->vregs[i];
    483 
    484         ret = devm_regulator_bulk_get(dev, ctx->pdata->num_vregs, ctx->regs);
    485         if (ret < 0)
    486                 return dev_err_probe(dev, ret,
    487                                      "Failed to get all regulators\n");
    488 
    489         if (ctx->pdata->has_vddio) {
    490                 ctx->vddio = devm_regulator_get(dev, "vddio");
    491                 if (IS_ERR(ctx->vddio))
--> 492                         return dev_err_probe(dev, ret, "Failed to get VDDIO\n");

s/ret/PTR_ERR(ctx->vddio)/

    493         }
    494 
    495         ctx->bt_gpio = devm_gpiod_get_optional(dev, "bt-enable", GPIOD_OUT_LOW);
    496         if (IS_ERR(ctx->bt_gpio))
    497                 return dev_err_probe(dev, PTR_ERR(ctx->bt_gpio),
    498                                      "Failed to get the Bluetooth enable GPIO\n");
    499 
    500         /*

regards,
dan carpenter

