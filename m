Return-Path: <linux-pm+bounces-27948-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA32ACA945
	for <lists+linux-pm@lfdr.de>; Mon,  2 Jun 2025 08:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A75AA189D834
	for <lists+linux-pm@lfdr.de>; Mon,  2 Jun 2025 06:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5621A8F93;
	Mon,  2 Jun 2025 06:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RKV3AwYA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6764A1A265E
	for <linux-pm@vger.kernel.org>; Mon,  2 Jun 2025 06:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748844517; cv=none; b=VgX2O5poD0f5TdkVmdVZdm8SRSxkE4EnUL6m/pvqGf4Qei1ZjSh/YPIQJX6OqDCavFknHg4L9yS5gxy0B55O+JOqIsIgi5KP/n5ovg0vmm6KtC1BUvCa2TewERvHqdjvmvmNCqZrJ+ozP7cb7WwHxEismocz6li+lsAn6upjUiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748844517; c=relaxed/simple;
	bh=Xh9WnzSfgu+m0GMDti5P07SLsI9o4jWrD0yuJ3eYVjM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=r6421N25XGo+dZW8STXUjQDK5hXlltPLNU602BC2ynq8n4wzUd2rul90KujyVkJs9XFk3iFHMH9drsOovHVf4yjVa1lHW7K3DxzlEhMs5tfAjTfp/+vo8YzhWLkMnhivegvhXZuLkfv+H+SyqaTUsPJ3V7JV5nn3Kph9Qr0pej0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RKV3AwYA; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a374f727dbso3419250f8f.0
        for <linux-pm@vger.kernel.org>; Sun, 01 Jun 2025 23:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748844512; x=1749449312; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nUg394UUqvjb/oidDzwm9pG7XoUFy0Z+jw1O2ucewGg=;
        b=RKV3AwYAZeCz/xvq2cZnTzl50mMef7bBFfYRV/t8f6xYgW6eKR14YPoNmVFYPB7zdz
         TqGviriu+hTAg5DNPrNbqZvLtQzDFR35MYyBAA8gxdN2sk+a20uc+c91Racg/F345b9v
         ilY7d1xuJnxv115mInIwtaOV99txDV9ppiPDQGKWAVlJp6yNL/xQVKKAm/oN1dmyjGCr
         qtfgUnnrlriorPAQCKS+quQGUywdMx0mjic57QcedyCz5mG8l1TBVzBzvWSJTmDypHIZ
         SxhrMxLrNbVmqGOLKCfjO/m6yRvFLW18d7x6RiE1j0/b/mSDOct4g4iQ6h+9JdJxGjt1
         x6DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748844512; x=1749449312;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nUg394UUqvjb/oidDzwm9pG7XoUFy0Z+jw1O2ucewGg=;
        b=V8epK0PI6VGeel6O1WgAAG0B+64//N754U2UtQSoxO/ylPs927BinHGV37Uu5h+1PF
         N+lUVZTKFFM5EsCLpqlinvUueu6JNxGSGNKTL9M6ApNLCC6Ug/6RvPaNh8DJ4w7qxOmU
         V5TclZlbqXHcpoj3yxkqNTVt98iJqBrTvIYdFacDyvzbb/AIyASUkF0ZShOp4hZRvB39
         5BWwyB3SRCyMO/iPedwfwuD9hwC7WBv7CySrH0reIiklnmeTfCyfkphGmvYOjxVZYXDY
         IG3+PNrGzVFUcxGFlmEAa8OUPs5jhjkxlC7yNxYHLaT77mcWJr8CMabkZhKkugTb5ByM
         hyBw==
X-Forwarded-Encrypted: i=1; AJvYcCUgqKj3AQm4vDFqnfy7w80+49FNDeRmmCprBfNwaGXX1z+/Uo3KPFlog16H1PZalEaIWK6eod+a6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzVvOog8onPQR5YVT/vI2wf9kdDrsKxt74pnvsuwqj6lmVk+Yw+
	Eq6LqEuz3KFwREAyMEuwbnFAnSjR2/Gy8iZveJk/IKsgC9GY3rGQmQJ5nk70qWqP4/Y=
X-Gm-Gg: ASbGncsppI04dXAUvdE5jkAAWjBVK4HdQiHz9s52soYSVMxvuG+8yxydYxNfYa0Efgb
	UZ/UbDNkhZQpevNKQDLvuFgtItXHSx0c4+tT6cNwTm1b/+g66xuZuKKvlk+aiVO9/eue4PZhoo8
	Ya3iVfoNN3XCiwtQJSH2RmTRRoLrnrhhzINB9QJ5udA5Q0+TQMUuw/VLSlwj5UpVHqcD6LmLEyi
	Eblm9N+axhuzdxs6IKDPKRTm3pi71x/s7x54Gs5jECjDA/4up0BIp2ZfGZR8XrOb3zgRE+uQa74
	x7+6Jzk8Mb00D451kyZ38CydqNW956YzRA2/NarNJHWpZRrRMW9kVBTETrT5bJLuvQ==
X-Google-Smtp-Source: AGHT+IECaagk3g9nLoafLTcr2Co0rEQWyMHI31p8lTu8Ivf/YK9+vSssiruussNYu28rBIZV/D4I1w==
X-Received: by 2002:a5d:5f54:0:b0:39c:30cd:352c with SMTP id ffacd0b85a97d-3a4f89a482fmr8521278f8f.8.1748844511667;
        Sun, 01 Jun 2025 23:08:31 -0700 (PDT)
Received: from localhost ([41.210.143.146])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a4f00a02cdsm13745291f8f.94.2025.06.01.23.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jun 2025 23:08:31 -0700 (PDT)
Date: Mon, 2 Jun 2025 09:08:27 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev,
	Samuel Kayode via B4 Relay <devnull+samuel.kayode.savoirfairelinux.com@kernel.org>,
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sebastian Reichel <sre@kernel.org>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, linux-pm@vger.kernel.org,
	Samuel Kayode <samuel.kayode@savoirfairelinux.com>,
	eballetbo@gmail.com, abelvesa@linux.com, b38343@freescale.com,
	yibin.gong@nxp.com, Abel Vesa <abelvesa@kernel.org>
Subject: Re: [PATCH v3 2/6] mfd: pf1550: add core mfd driver
Message-ID: <202505290859.CKZrTkZu-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250527-pf1550-v3-2-45f69453cd51@savoirfairelinux.com>

Hi Samuel,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Samuel-Kayode-via-B4-Relay/dt-bindings-mfd-add-pf1550/20250528-062840
base:   0a4b866d08c6adaea2f4592d31edac6deeb4dcbd
patch link:    https://lore.kernel.org/r/20250527-pf1550-v3-2-45f69453cd51%40savoirfairelinux.com
patch subject: [PATCH v3 2/6] mfd: pf1550: add core mfd driver
config: nios2-randconfig-r072-20250529 (https://download.01.org/0day-ci/archive/20250529/202505290859.CKZrTkZu-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 10.5.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202505290859.CKZrTkZu-lkp@intel.com/

smatch warnings:
drivers/mfd/pf1550.c:162 pf1550_i2c_probe() warn: passing zero to 'dev_err_probe'

vim +/dev_err_probe +162 drivers/mfd/pf1550.c

fc62e32ad9eb64 Samuel Kayode 2025-05-27  140  static int pf1550_i2c_probe(struct i2c_client *i2c)
fc62e32ad9eb64 Samuel Kayode 2025-05-27  141  {
fc62e32ad9eb64 Samuel Kayode 2025-05-27  142  	struct pf1550_dev *pf1550;
fc62e32ad9eb64 Samuel Kayode 2025-05-27  143  	unsigned int reg_data = 0;
fc62e32ad9eb64 Samuel Kayode 2025-05-27  144  	int ret = 0;
fc62e32ad9eb64 Samuel Kayode 2025-05-27  145  
fc62e32ad9eb64 Samuel Kayode 2025-05-27  146  	pf1550 = devm_kzalloc(&i2c->dev, sizeof(*pf1550), GFP_KERNEL);
fc62e32ad9eb64 Samuel Kayode 2025-05-27  147  	if (!pf1550)
fc62e32ad9eb64 Samuel Kayode 2025-05-27  148  		return -ENOMEM;
fc62e32ad9eb64 Samuel Kayode 2025-05-27  149  
fc62e32ad9eb64 Samuel Kayode 2025-05-27  150  	i2c_set_clientdata(i2c, pf1550);
fc62e32ad9eb64 Samuel Kayode 2025-05-27  151  	pf1550->dev = &i2c->dev;
fc62e32ad9eb64 Samuel Kayode 2025-05-27  152  	pf1550->i2c = i2c;
fc62e32ad9eb64 Samuel Kayode 2025-05-27  153  	pf1550->irq = i2c->irq;
fc62e32ad9eb64 Samuel Kayode 2025-05-27  154  
fc62e32ad9eb64 Samuel Kayode 2025-05-27  155  	pf1550->regmap = devm_regmap_init_i2c(i2c, &pf1550_regmap_config);
fc62e32ad9eb64 Samuel Kayode 2025-05-27  156  	if (IS_ERR(pf1550->regmap))
fc62e32ad9eb64 Samuel Kayode 2025-05-27  157  		return dev_err_probe(pf1550->dev, PTR_ERR(pf1550->regmap),
fc62e32ad9eb64 Samuel Kayode 2025-05-27  158  				     "failed to allocate register map\n");
fc62e32ad9eb64 Samuel Kayode 2025-05-27  159  
fc62e32ad9eb64 Samuel Kayode 2025-05-27  160  	ret = regmap_read(pf1550->regmap, PF1550_PMIC_REG_DEVICE_ID, &reg_data);
fc62e32ad9eb64 Samuel Kayode 2025-05-27  161  	if (ret < 0 || reg_data != PF1550_DEVICE_ID)
fc62e32ad9eb64 Samuel Kayode 2025-05-27 @162  		return dev_err_probe(pf1550->dev, ret, "device not found!\n");

return dev_err_probe(pf1550->dev, ret ?: -EINVAL, "device not found!\n");

fc62e32ad9eb64 Samuel Kayode 2025-05-27  163  
fc62e32ad9eb64 Samuel Kayode 2025-05-27  164  	pf1550->type = PF1550;
fc62e32ad9eb64 Samuel Kayode 2025-05-27  165  
fc62e32ad9eb64 Samuel Kayode 2025-05-27  166  	ret = devm_regmap_add_irq_chip(pf1550->dev, pf1550->regmap,
fc62e32ad9eb64 Samuel Kayode 2025-05-27  167  				       pf1550->irq,
fc62e32ad9eb64 Samuel Kayode 2025-05-27  168  				       IRQF_ONESHOT | IRQF_SHARED |
fc62e32ad9eb64 Samuel Kayode 2025-05-27  169  				       IRQF_TRIGGER_FALLING, 0,
fc62e32ad9eb64 Samuel Kayode 2025-05-27  170  				       &pf1550_regulator_irq_chip,
fc62e32ad9eb64 Samuel Kayode 2025-05-27  171  				       &pf1550->irq_data_regulator);
fc62e32ad9eb64 Samuel Kayode 2025-05-27  172  	if (ret)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


