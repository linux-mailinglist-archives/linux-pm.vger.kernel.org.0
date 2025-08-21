Return-Path: <linux-pm+bounces-32777-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 869E3B2EF61
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 09:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 306E31CC2FAB
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 07:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AEB2E8DF2;
	Thu, 21 Aug 2025 07:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LTZe5J22"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3862E8B8D
	for <linux-pm@vger.kernel.org>; Thu, 21 Aug 2025 07:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755760678; cv=none; b=TZJcU27g9gUui2ZfMpkI1XPNS0wkMne9GJXGYx0EuJu9Fen1XVppgtzIwyY6D50nzEchAt3wUiHNAhHhK6sk4cu89YO4WhEzZizV+YiE/AJUNHufAWVmV/RCYaJcYhsFpqzl0nWQ5+tFkCQTTvl0V/fsE91N1gIeuQ7UvIZ/eNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755760678; c=relaxed/simple;
	bh=JvEAmy7Jlkc5V+Vnd1agyO6c2e8/ldDsDOAnzIwmDSE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=X4fIx8v5Jgd7js7E7aHorAva7EqV9iA+4tvIDM5CHWDg9bxzyg70oWMDhBTEqr03HvdqNdpPynNCfIImK0Mo+oB+BIHy6Hw6PUpgBtaptER8AEJnMjHfX05ZOiSlFP5RAeZfrjtrAkyKJnhBDhLO4/6AfLoKECF74h/zGpUY4iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LTZe5J22; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3b9e411c820so398679f8f.1
        for <linux-pm@vger.kernel.org>; Thu, 21 Aug 2025 00:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755760674; x=1756365474; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H3tAtOi04xs7pQD42uV+iRrcb/K5gV7/3jestZ8bCUo=;
        b=LTZe5J22nrs15U5l4mQ+Peeowrri71fAsO1UnmRAkk3DACrIgC/qXS9zGRr+NQF8Z2
         +KvnmWVUvl7TN7Zo2IQruGKs2mPzzfNqwyHADLomaFhp50s3/7hAxMq+8FSIO5YS/y12
         7wcqUZAYmk9o9A/TyLx8FwMlX9BwOJaNvyvTSjf3SvV/1CWXzSNQlM4gttJ0XB4AH9mA
         bagpaXPhtYBiqtdcn3X3jg9C7BGS66dexW5/77kV461woP7cL59TV0CCSQX+ZGte7drb
         NwD1IaKU2+ExfKshmT1Fys9gFvH+MLrADRuL/wcBSoiZSLV36f4jckJTtSddPK8h3fy2
         zT3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755760674; x=1756365474;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H3tAtOi04xs7pQD42uV+iRrcb/K5gV7/3jestZ8bCUo=;
        b=q8D5xAAEbsmdza92fYRwFOrZq+0gJ1VGU/xneq7ZaWs+zbUWb+ugWZ4XdpcMx/Nene
         YKjOQDcYQd9NO3yPHnwfHgwbEdJyUtOmXbgEcMS821VeetVg5G2+iacbJQOfKQFNV7ro
         KC9+HHMmJvvNHDgeoCPTB2HKkGwxJhQ2AW9K/jIP2HOJSphiscxEZY/vRZt1OS01HZTT
         K6FQ5fwyxl2OL3yWbeq0Y5UGbqVrNadqe7rMoNPlAj+l8GQ6w+PlWwt5pqCpgUWlqhMT
         pBWHwbatrZ+B2KYwJ1Dvaa27Skth859D8MxmKByk6PQkKlsBIrbEO8Kf08DoXiEL6Q/z
         3EuA==
X-Forwarded-Encrypted: i=1; AJvYcCUn4B2qm5/WW0Cvbsq/oS4Gf3afNMe+dp2YjGFImONe77Z9MhhIFXOr1UQemteKaRNdeg2d3Ettmw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxqibeoHuRYReHNoH2VOtAEAa+IVZPNWk5tVeTXFAD76h+P3/yJ
	Ll2//bDjPULrIDHgcaBx96ojZm1zLvU0/GCey1pzxSlPie51dJewqPYH6mVYR5LHR2I=
X-Gm-Gg: ASbGncsl5PcmKCB9utlSRVemkypMI6h0fEjf26Mu/CBKGTzyUJ2dPCre6KDXkR6zL7a
	mdn5lBtUSiey6AxK2d9wiHpohQ7uOSRdd0E+gzYgasAx+TrdDHsZm6RfE6uQKL1i8nfTH0RHp0C
	Feoe4SCy5PRHON4BlPFhynKgCvF23zdc3phG8ezG4l3VRIlJUziLmsYdGV86/VG0EnrbfHqSUhR
	OLKzrgxfyupxrXt9NmimWpxtaXGYffCLpYwcWjtggU5Zzwmy6O6IcN3NyNYJzq3+Syal2Y/vwk6
	nSNmvwV6yeL5VyWfFoMmQnDHktk+GfuFXjHf0Y7tLT1GzqxF1qIWDdXeKtYpH1bEIBvpAvd2j15
	eby4L9T+CQXqh8BTK3Qg8h+iBKEA=
X-Google-Smtp-Source: AGHT+IG63iMqN7wTtRiIXVZbSCze5rPWQlrS04IFAuyrUFZ9haZV4BHRyggzdxUPlHVMATR9Za+YDA==
X-Received: by 2002:a05:6000:2411:b0:3b7:8146:4640 with SMTP id ffacd0b85a97d-3c4977414d6mr1081489f8f.56.1755760674518;
        Thu, 21 Aug 2025 00:17:54 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b4db29878sm15276145e9.6.2025.08.21.00.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 00:17:53 -0700 (PDT)
Date: Thu, 21 Aug 2025 10:17:50 +0300
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
Message-ID: <202508210308.Lw2Klipk-lkp@intel.com>
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
config: xtensa-randconfig-r073-20250819 (https://download.01.org/0day-ci/archive/20250821/202508210308.Lw2Klipk-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 9.5.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202508210308.Lw2Klipk-lkp@intel.com/

smatch warnings:
drivers/regulator/bq257xx-regulator.c:132 bq257xx_reg_dt_parse_gpio() warn: passing zero to 'PTR_ERR'

vim +/PTR_ERR +132 drivers/regulator/bq257xx-regulator.c

d6db7dce7cd965 Chris Morgan 2025-08-12  107  static void bq257xx_reg_dt_parse_gpio(struct platform_device *pdev)
d6db7dce7cd965 Chris Morgan 2025-08-12  108  {
d6db7dce7cd965 Chris Morgan 2025-08-12  109  	struct device_node *child, *subchild;
d6db7dce7cd965 Chris Morgan 2025-08-12  110  	struct bq257xx_reg_data *pdata = platform_get_drvdata(pdev);
d6db7dce7cd965 Chris Morgan 2025-08-12  111  
d6db7dce7cd965 Chris Morgan 2025-08-12  112  	child = of_get_child_by_name(pdev->dev.of_node,
d6db7dce7cd965 Chris Morgan 2025-08-12  113  				     pdata->desc.regulators_node);
d6db7dce7cd965 Chris Morgan 2025-08-12  114  	if (!child)
d6db7dce7cd965 Chris Morgan 2025-08-12  115  		return;
d6db7dce7cd965 Chris Morgan 2025-08-12  116  
d6db7dce7cd965 Chris Morgan 2025-08-12  117  	subchild = of_get_child_by_name(child, pdata->desc.of_match);
d6db7dce7cd965 Chris Morgan 2025-08-12  118  	if (!subchild)
d6db7dce7cd965 Chris Morgan 2025-08-12  119  		return;
d6db7dce7cd965 Chris Morgan 2025-08-12  120  
d6db7dce7cd965 Chris Morgan 2025-08-12  121  	of_node_put(child);
d6db7dce7cd965 Chris Morgan 2025-08-12  122  
d6db7dce7cd965 Chris Morgan 2025-08-12  123  	pdata->otg_en_gpio = devm_fwnode_gpiod_get_index(&pdev->dev,
d6db7dce7cd965 Chris Morgan 2025-08-12  124  							 of_fwnode_handle(subchild),
d6db7dce7cd965 Chris Morgan 2025-08-12  125  							 "enable", 0,
d6db7dce7cd965 Chris Morgan 2025-08-12  126  							 GPIOD_OUT_LOW,
d6db7dce7cd965 Chris Morgan 2025-08-12  127  							 pdata->desc.of_match);
d6db7dce7cd965 Chris Morgan 2025-08-12  128  
d6db7dce7cd965 Chris Morgan 2025-08-12  129  	of_node_put(subchild);
d6db7dce7cd965 Chris Morgan 2025-08-12  130  
d6db7dce7cd965 Chris Morgan 2025-08-12  131  	if (IS_ERR_OR_NULL(pdata->otg_en_gpio)) {

This should just be an IS_ERR() check.  When a function returns a mix of
error pointers and NULL, then the NULL is not an error and shouldn't
result in an error message.

https://staticthinking.wordpress.com/2022/08/01/mixing-error-pointers-and-null/

Here devm_fwnode_gpiod_get_index() can't actually return NULL so it
doesn't matter, I suppose.

d6db7dce7cd965 Chris Morgan 2025-08-12 @132  		dev_err(&pdev->dev, "Error getting enable gpio: %ld\n",
d6db7dce7cd965 Chris Morgan 2025-08-12  133  			PTR_ERR(pdata->otg_en_gpio));
d6db7dce7cd965 Chris Morgan 2025-08-12  134  		return;
d6db7dce7cd965 Chris Morgan 2025-08-12  135  	}
d6db7dce7cd965 Chris Morgan 2025-08-12  136  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


