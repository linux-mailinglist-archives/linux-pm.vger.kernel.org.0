Return-Path: <linux-pm+bounces-3772-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC89850D89
	for <lists+linux-pm@lfdr.de>; Mon, 12 Feb 2024 07:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5D451F25E71
	for <lists+linux-pm@lfdr.de>; Mon, 12 Feb 2024 06:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B2A23A6;
	Mon, 12 Feb 2024 06:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HwtlZkPv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2811876
	for <linux-pm@vger.kernel.org>; Mon, 12 Feb 2024 06:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707719505; cv=none; b=aY5P5pOT26BGsiTaS3w204Ws1K/Z/do+4YZRVdwOC5Kwpgsxl/XWzREgZfIe0Bbg8R7dQTZrUKnvwDvOuKdOXCGRR5LLRdSvnB84wGYvlnZgto3oBnrsVjzrCmP42YLyUxBMPBecYw/LskUl+NpacBVb2pxNC5XYPiXg2Bi+U6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707719505; c=relaxed/simple;
	bh=sJW8LTmgKhWrNX5KrZAvVAMpmt+gLvcunNUfU6iGUS4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mq54Ev9gIGLuuxK4HQSmqiJ8vgR1Ld+CdV7fpptndA0tZpVtkUV3EK4T3cWVIHSelVRt+ctj+EISVgrGEJGZ9px8NawO0UK/sxNXcEDFI+jJHIlzlQTi48FvUITU0fwxzoG8Ltfa7hlUVJb33LtgaOaUGljqVMZ7piqW+Z4ENSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HwtlZkPv; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a3916c1f9b0so373920766b.1
        for <linux-pm@vger.kernel.org>; Sun, 11 Feb 2024 22:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707719502; x=1708324302; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/ZEgPDx+pVY9gu5fSu4FckLKzR0ijYk63QNvpgbllZE=;
        b=HwtlZkPvxNnUcqCXCIhUbcaWiIA6+2X4x0NVmmBau+bVIlu4N2Mv1n71P65sLeSzix
         Vu8oV6+5XN5SkgqJKwe9OdGZ/UQTCsk/pzM9wuiCcseKqHQQLtw9pLcPCdYnI0MYI7JH
         Mevh9LOkiNx+ji3Ldd45hYD7Y7XgIzR/AFCfsxK8+ReFFVNGrBClFttXDWBm9IDuzoAe
         gQseOiYwVgJf06SLkCqJ/+PbKAXMor6eHU4vb4dHFqS+J9fijTFGeNQ8jX/k8yABl6jy
         LBRoEspKlRJUislrJh7OAbWoX3tXttLa2Qygrxy5oKQYV3VkiFcjzGSQCWXfDhtxRlCE
         b9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707719502; x=1708324302;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZEgPDx+pVY9gu5fSu4FckLKzR0ijYk63QNvpgbllZE=;
        b=Kl7K3ihNsOsfQZJT/yMAGSRKKwkGt8ViR2IW7qf//HRpXi/tb+XjGAYovwdh5zIsBR
         F8BWHIeHu7FNEka4HBva+dnyM+7lU9/oHK+DRJwHzAGX9eRHSUG7M/a4r8dQn5r+3cXN
         LsBK1oGGmbYRJuzErF7fohayh+BNIALHLS05cVFK5ISBVcCrw54w0/qFPV5MuGmaNRcb
         jJ6F0/8/uJDtiyB+2DjjDguHII2XU2Z1O844aFnv1XBf8Eydp+eb1rD6s/7FSF7ovVwq
         91sJZs/iBp1MP2MK8BLRqV5g5uQWRVBEpPRKwLja7LmHOMoMyqEg+byH+k80xBbUcEv/
         mgEA==
X-Gm-Message-State: AOJu0YzfKBLCQavw8BzXR3dzpPmYauog1IZ1YGYNKljwMUt9X0Iog2yE
	s8h9qSTd1tlY45t+Gyy/4nNv2zPjEoQefMYTwAYLy32PJS4aPxql13qE8FpPF4g=
X-Google-Smtp-Source: AGHT+IGP5gA7jOCPbzYKrsDj6WqcYYajyHpuSSHQK6EAZQNkJjiEkER9qHevDuYeDwJ0AFIRmpWe/Q==
X-Received: by 2002:a17:906:b309:b0:a3c:c8b:f6f7 with SMTP id n9-20020a170906b30900b00a3c0c8bf6f7mr4057700ejz.50.1707719502092;
        Sun, 11 Feb 2024 22:31:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWg4J8jSUyVaw93YuRA6hHihvmscjGYufc/io9m6e9bVZzDfAGGR8/LpzM+yrGYd90+XO0qS+Tj0hAaJmSZ1gf6PdoxWPA2EQM=
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id tb12-20020a1709078b8c00b00a3bd53ccbeasm3525501ejc.28.2024.02.11.22.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 22:31:41 -0800 (PST)
Date: Mon, 12 Feb 2024 09:31:37 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: linus.walleij@linaro.org
Cc: linux-pm@vger.kernel.org
Subject: [bug report] power: supply_core: Pass pointer to battery info
Message-ID: <914e1b78-58de-4e63-8179-12c7d24c6836@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Linus Walleij,

The patch 25fd330370ac: "power: supply_core: Pass pointer to battery
info" from Dec 15, 2021 (linux-next), leads to the following Smatch
static checker warning:

	drivers/power/supply/bq256xx_charger.c:1595 bq256xx_hw_init()
	error: uninitialized symbol 'bat_info'.

drivers/power/supply/bq256xx_charger.c
    1565 static int bq256xx_hw_init(struct bq256xx_device *bq)
    1566 {
    1567         struct power_supply_battery_info *bat_info;
    1568         int wd_reg_val = BQ256XX_WATCHDOG_DIS;
    1569         int ret = 0;
    1570         int i;
    1571 
    1572         for (i = 0; i < BQ256XX_NUM_WD_VAL; i++) {
    1573                 if (bq->watchdog_timer == bq256xx_watchdog_time[i]) {
    1574                         wd_reg_val = i;
    1575                         break;
    1576                 }
    1577                 if (i + 1 < BQ256XX_NUM_WD_VAL &&
    1578                     bq->watchdog_timer > bq256xx_watchdog_time[i] &&
    1579                     bq->watchdog_timer < bq256xx_watchdog_time[i + 1])
    1580                         wd_reg_val = i;
    1581         }
    1582         ret = regmap_update_bits(bq->regmap, BQ256XX_CHARGER_CONTROL_1,
    1583                                  BQ256XX_WATCHDOG_MASK, wd_reg_val <<
    1584                                                 BQ256XX_WDT_BIT_SHIFT);
    1585         if (ret)
    1586                 return ret;
    1587 
    1588         ret = power_supply_get_battery_info(bq->charger, &bat_info);
    1589         if (ret == -ENOMEM)

Only -ENOMEM is handled but it can return a bunch of different errors
where bat_info is uninitialized and we just introduced another recently.

    1590                 return ret;
    1591 
    1592         if (ret) {
    1593                 dev_warn(bq->dev, "battery info missing, default values will be applied\n");
    1594 
--> 1595                 bat_info->constant_charge_current_max_ua =
                         ^^^^^^^^^^
This used to be bat_info.constant_charge_current_max_ua = ...


    1596                                 bq->chip_info->bq256xx_def_ichg;
    1597 
    1598                 bat_info->constant_charge_voltage_max_uv =

regards,
dan carpenter

