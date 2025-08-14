Return-Path: <linux-pm+bounces-32368-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDD6B25CD0
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 09:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 167CC16D353
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 07:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342B6263F5F;
	Thu, 14 Aug 2025 07:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gb0YS6V6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FDF22A4FC
	for <linux-pm@vger.kernel.org>; Thu, 14 Aug 2025 07:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755155645; cv=none; b=eet5J9ZRQPox/Z3ir019y/TIW2QZN1gU/xHesUwjiiK5nX7a7X6XIp/1P4jz+OG/0/DJTjyfgCd40lzS9ID1UlTLb7uzB9b4qaml2hCa9bKtMU2uknvNSZTUo1lX8qT89bCh14ZuYxzYdnuXvRN7c4+TzDp2Xl+9A4+keV4xRWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755155645; c=relaxed/simple;
	bh=hDI+QCx07/AA+50YEkqGaqIlvDcXSqreOpqc3cQQCe0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VfRympf0eomjZvfQvbhV1Vvx//fElpQTOc6ultbWbXwuAZZkn9wytvWZFquPDnLLZnIvwYh0ktsGCCc6Z9UEf8jBTwxzrj/mwu5GdmckJM30yew1zNzTuJ7xKIC5Qpa5ePkaUrxWNrQvi5M/j5qCpDlkYUGKsRp83ppShWZTUVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gb0YS6V6; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b9e41101d4so278022f8f.2
        for <linux-pm@vger.kernel.org>; Thu, 14 Aug 2025 00:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755155641; x=1755760441; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t9E3NrCTEwbCDabEtVeBf62CMBWNpRfAcIAwAy7HrVc=;
        b=gb0YS6V6SX10hj3zECJ6vYAZWDUPJJn/TvdILbBZOBhi3++C8UxCQBuLCJA0UUSOzU
         P28kTrUgIn9hKgDIkFrkgJ64oiHsmzyL4LIdPCWMIbhIgD4wOnmFGMhi8kIA76a3wWl3
         83vLMpT08UYQ3E0+k72TbJIsTx0nuoKZatdS8W54aD8Qmqt81pPwE4ziTRl3L3tyr1lD
         adobfiNsMFUKmTf9BnaXQHaoUp+KG1lag63Aij3sjzhEYZ8z3XG5ilDLjBHNXfDYbAhA
         2GBzuw4oQwOjdVToZaoQxyim4+mPPoQb4LeHaEdEj+aVuEJQO0wPjKtFgmV0oQWgKgU7
         a2Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755155641; x=1755760441;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t9E3NrCTEwbCDabEtVeBf62CMBWNpRfAcIAwAy7HrVc=;
        b=qO2Mk+J4czHzGlPbFbFzoxlUWqbLq0oPYC/XFCm8w7SzmeEu8xeoN8SVWE2JWfH9D2
         plj5xvjxqVku3DI4ru6RNQrVyUSAgQlnze7Ga+0OiaW5x3ExYRr1JfzTE+NyTFqC6c+O
         TfITWTBacH8e0GQ0CusU9RKezZWYCXcJKgGGAtSDzTOogHHHH8Yc0NAv+PseIQwHkd+0
         Pc2byX2g6d6Uo6ioy4ya70oE9JvgPvRCJks7oOT8bNhS21ZL2qI6toc2kWMQ6IqD076W
         w5FpYWAmWg39n7BStQ16A1itLSp5HFh6vpk/6rHcWY9ZGCJxh4qDPu7PauLKFWKn+4Z5
         eUvw==
X-Forwarded-Encrypted: i=1; AJvYcCUkLZu1l97p15BXyIy/RuQ5xdvH1JiicvdDSzBT2QdTEZpwoseK7TgvIU+XVfOSKvrqKPCbDUvtWA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7Y67JmZB+9Bp0Flw0i7+C7VjaHM++81W3jYEdsr9t2MQj8AVt
	g0iHtQLSEai5EkXZ2gxDEtsFXAr6X97FKI4MBf0cPPHhLYBVfp1nOvypGXIDCrxFJOY=
X-Gm-Gg: ASbGncvV74A0HP7q5HifagItco+oFYCT7VBU1d8BrUSu5sV75N5NWcTThTtKNAE1yrP
	FMKNWXI9A7wp5cp+yhGCZBwvE8/THod3pnMZZthLQ6fCy20FKejr3DFVHHo4UxEvedh61O1DQu9
	lDAPkfSY3G4YPazdhg6amYn7E10LjJnYG353hSXJB5ECXCR/JgUejGamc09lhku7I6UmDRMgmYQ
	8WGippGFiRuu/AvQ3LIXci+/ECvuvVpIOMS9gaYD0XmtNssiZZMXtOkl0KcifOKt7dBTK27a6ab
	W/g4iNgVAisiy0lCyKuK1XLrL9hg/Ul7eROz1gkU2t4xIVH0LqQ/uDa4Cec1E85LoeMQdo3GVZZ
	UzbaimmAzNjgDc/uvtMmzwEW4VyY=
X-Google-Smtp-Source: AGHT+IFP9kiDc1q1dkQQRBUhr400gKrEB0WYTXwapO4qVV4879GgEBYYtEyy7MjPdh+h9soCzQb3KQ==
X-Received: by 2002:a05:6000:2089:b0:3a4:eed9:755d with SMTP id ffacd0b85a97d-3b9edfd196emr1313673f8f.3.1755155641197;
        Thu, 14 Aug 2025 00:14:01 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45a1c70acc7sm9647105e9.25.2025.08.14.00.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 00:14:00 -0700 (PDT)
Date: Thu, 14 Aug 2025 10:13:56 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Chris Morgan <macroalpha82@gmail.com>,
	linux-rockchip@lists.infradead.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, broonie@kernel.org, lee@kernel.org,
	lgirdwood@gmail.com, sre@kernel.org, heiko@sntech.de,
	conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V6 4/5] regulator: bq257xx: Add bq257xx boost regulator
 driver
Message-ID: <202508141051.hwl2Erq6-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812214300.123129-5-macroalpha82@gmail.com>

Hi Chris,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chris-Morgan/dt-bindings-mfd-ti-bq25703a-Add-TI-BQ25703A-Charger/20250813-054704
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next
patch link:    https://lore.kernel.org/r/20250812214300.123129-5-macroalpha82%40gmail.com
patch subject: [PATCH V6 4/5] regulator: bq257xx: Add bq257xx boost regulator driver
config: m68k-randconfig-r073-20250814 (https://download.01.org/0day-ci/archive/20250814/202508141051.hwl2Erq6-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.1.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202508141051.hwl2Erq6-lkp@intel.com/

smatch warnings:
drivers/regulator/bq257xx-regulator.c:161 bq257xx_regulator_probe() error: uninitialized symbol 'init_data'.

vim +/init_data +161 drivers/regulator/bq257xx-regulator.c

d6db7dce7cd965 Chris Morgan 2025-08-12  138  static int bq257xx_regulator_probe(struct platform_device *pdev)
d6db7dce7cd965 Chris Morgan 2025-08-12  139  {
d6db7dce7cd965 Chris Morgan 2025-08-12  140  	struct device *dev = &pdev->dev;
d6db7dce7cd965 Chris Morgan 2025-08-12  141  	struct bq257xx_device *bq = dev_get_drvdata(pdev->dev.parent);
d6db7dce7cd965 Chris Morgan 2025-08-12  142  	struct bq257xx_reg_data *pdata;
d6db7dce7cd965 Chris Morgan 2025-08-12  143  	struct device_node *np = dev->of_node;
d6db7dce7cd965 Chris Morgan 2025-08-12  144  	struct regulator_init_data *init_data;
d6db7dce7cd965 Chris Morgan 2025-08-12  145  	struct regulator_config cfg = {};
d6db7dce7cd965 Chris Morgan 2025-08-12  146  
d6db7dce7cd965 Chris Morgan 2025-08-12  147  	pdev->dev.of_node = pdev->dev.parent->of_node;
d6db7dce7cd965 Chris Morgan 2025-08-12  148  	pdev->dev.of_node_reused = true;
d6db7dce7cd965 Chris Morgan 2025-08-12  149  
d6db7dce7cd965 Chris Morgan 2025-08-12  150  	pdata = devm_kzalloc(&pdev->dev, sizeof(struct bq257xx_reg_data), GFP_KERNEL);
d6db7dce7cd965 Chris Morgan 2025-08-12  151  	if (!pdata)
d6db7dce7cd965 Chris Morgan 2025-08-12  152  		return -ENOMEM;
d6db7dce7cd965 Chris Morgan 2025-08-12  153  
d6db7dce7cd965 Chris Morgan 2025-08-12  154  	pdata->bq = bq;
d6db7dce7cd965 Chris Morgan 2025-08-12  155  	pdata->desc = bq25703_vbus_desc;
d6db7dce7cd965 Chris Morgan 2025-08-12  156  
d6db7dce7cd965 Chris Morgan 2025-08-12  157  	platform_set_drvdata(pdev, pdata);
d6db7dce7cd965 Chris Morgan 2025-08-12  158  	bq257xx_reg_dt_parse_gpio(pdev);
d6db7dce7cd965 Chris Morgan 2025-08-12  159  
d6db7dce7cd965 Chris Morgan 2025-08-12  160  	cfg.dev = &pdev->dev;
d6db7dce7cd965 Chris Morgan 2025-08-12 @161  	cfg.init_data = init_data;
                                                                ^^^^^^^^^
Uninitialized.

d6db7dce7cd965 Chris Morgan 2025-08-12  162  	cfg.driver_data = pdata;
d6db7dce7cd965 Chris Morgan 2025-08-12  163  	cfg.of_node = np;
d6db7dce7cd965 Chris Morgan 2025-08-12  164  	cfg.regmap = dev_get_regmap(pdev->dev.parent, NULL);
d6db7dce7cd965 Chris Morgan 2025-08-12  165  	if (!cfg.regmap)
d6db7dce7cd965 Chris Morgan 2025-08-12  166  		return -ENODEV;
d6db7dce7cd965 Chris Morgan 2025-08-12  167  
d6db7dce7cd965 Chris Morgan 2025-08-12  168  	pdata->bq257xx_reg = devm_regulator_register(dev, &pdata->desc, &cfg);
d6db7dce7cd965 Chris Morgan 2025-08-12  169  	if (IS_ERR(pdata->bq257xx_reg)) {
d6db7dce7cd965 Chris Morgan 2025-08-12  170  		return dev_err_probe(&pdev->dev, PTR_ERR(pdata->bq257xx_reg),
d6db7dce7cd965 Chris Morgan 2025-08-12  171  				     "error registering bq257xx regulator");
d6db7dce7cd965 Chris Morgan 2025-08-12  172  	}
d6db7dce7cd965 Chris Morgan 2025-08-12  173  
d6db7dce7cd965 Chris Morgan 2025-08-12  174  	return 0;
d6db7dce7cd965 Chris Morgan 2025-08-12  175  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


