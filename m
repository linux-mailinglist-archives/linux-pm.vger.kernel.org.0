Return-Path: <linux-pm+bounces-32600-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F10B8B2B93B
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 08:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 597DF188FCCE
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 06:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986F9266580;
	Tue, 19 Aug 2025 06:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ibAhJEFU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA44F266560
	for <linux-pm@vger.kernel.org>; Tue, 19 Aug 2025 06:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755584095; cv=none; b=Epr6PHkpyxg83Ls5c+qNSJHESgFF7P2keOvJB2i6hQVtQVp3WmKHPTe/2N6Df3QrTQMaRU/YHtdsIhu9FduMUlhk04EnkYCGxehcdd4oWNMcnc/CiarUXHm2baXtbzuAnAqSbSYLezN9zcUzzD5IsyQ3aGAe9wpjhNMFzhclGzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755584095; c=relaxed/simple;
	bh=2YJR7pEFPy7xq1orNpVNhiTcdNQif4qFtdmH0fu7uU8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=SpnavGWBtbFJGbsUWx5FJSz6PHq4D3b1WVtPDNf8e3r4GlPLJDgojrRq3hNKWx/9F69wa/SUtkXKLbVucT5T374E26JOzjlyyNoYE/wNMNG9YeomlE2QiBlu015D+IhGlOnFnXyNY2sSe1O6ELR6LjWrlExannjENDwgBeaPLIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ibAhJEFU; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b9e411c820so2609879f8f.1
        for <linux-pm@vger.kernel.org>; Mon, 18 Aug 2025 23:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755584092; x=1756188892; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cfC6tmyznTQhu0WfGzgV8ZZbOGfzSI/Lw/Z1TOmfLRk=;
        b=ibAhJEFUO+vTpE3pCQcYDTbQCLdspElFpc5VKzca0gq8l5CsysS8U/avlwCT3tYhxv
         WStZb/+53HEANlYP5qSgfpBMT5Z56yNK4j2r37i0x7n4GsMDgE4UQ26g4ZwxnSBauBEj
         OqpB9DvcBSSIpt/705aPhux5DXhQi2aJjobyQ8nymEtpKxLbwYoHrTjstzi0SKUfefq1
         md9d300NgHcvbKKWumyooFsauU16I3KjsyNQLu0poMC7k5ORhbAC+uUvEIOjZjwstAKN
         7Cn+sJoSSSddJpdE59XFv3rtCa/yzOfhT5vxIAgH89hfpekDS10ZyPM3QehmN8/flfwm
         vQHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755584092; x=1756188892;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cfC6tmyznTQhu0WfGzgV8ZZbOGfzSI/Lw/Z1TOmfLRk=;
        b=mUkI3GxpL+UA9BPx+gVaBRGRHc734GaCbkiClleaR/8t9ODSV7xFDU+IAjW3W1+giw
         BJU2KDXPmhCO8jlSi6MRc4wAz46JeG09e+AoCrxm0/HOlGCuKK7EbBsJdc6qtjolCnGs
         +giwWxf3R0uFJesoPABbeyfU+Aza4rxhOskYGD6kTDkfUnrecAtMUHwkIlYNZ8tbOfP3
         E58D33U0axlcCwHCAI+PyZd8jxU1mTVc9S7kxTdwhmhwPCKFumRNbuFku6LJSo7B3tUO
         RmD06i6gE978pg2oSRA1gie7JKTBXqGMLQMHD/yQeU/NvpJ1T99SQkxj1hAwJ/dnBOFq
         zBMA==
X-Forwarded-Encrypted: i=1; AJvYcCVPjlJSSyYH19troqcu4jZJSPxtPvFNxvIdBAn/8+mns3I7k4/bMIs2hpo6mPY52yw+Ad3fUvsmbQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw48QNQEXm6oifwvqrVA/inyQ6dDhUCuU0ub8EConN1ddB0knnc
	i8XN6WdWmOsu9W+ClPflTmqQeQkCHt4hj1reAchrlC7jcOryR4AwiEzZfhmXXxAv/2Q=
X-Gm-Gg: ASbGnct9iK6NG6ManaZkALqXFMyYpD64LM/0tcHKad/hGzP0NblrGW3bAZLiA0g4QdJ
	mFMbxjP82gqQCrbSjE4F8dNIBvDVPiIbiCbwAAlc29lRE+et12/w3e8FQCAnvq85Zy5w76ecZqq
	cUAW39v+Lj4a1aCcAH8jj4ZZk6i5uyq/pNW0BEABrFfvjWZuypB5+Z2IZYvVgk0mQ7rpCvnxp6t
	LfDpqtOeYfsh7vlDA7fMmvkL9q0gEfgmi7MqXW/85/o39XrULihOFpde1XrlWqm/OGKLIUJfmry
	NEFdfGUiR8M4rBbHfOnDz3h5OTT1ECqoVrf6KQ9zwLx+Qi5jyowQzkfXaxy6ImaHPa98G0jU6/Y
	HDUvQ5sP1apm6qaiJehJoJ0x4/TMP88NRze2lAA==
X-Google-Smtp-Source: AGHT+IGGFEZgyeEaX2pBRfjbPpLg1ixzuD1sw99+W5A5gTT8EacRooGmmANMREXLdZz4noMb1+AVvg==
X-Received: by 2002:a05:6000:4014:b0:3b9:148b:e66 with SMTP id ffacd0b85a97d-3c0ed2e8f63mr910658f8f.54.1755584091917;
        Mon, 18 Aug 2025 23:14:51 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c0754f3b7esm2146290f8f.30.2025.08.18.23.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 23:14:51 -0700 (PDT)
Date: Tue, 19 Aug 2025 09:14:48 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Andreas Kemnade <andreas@kemnade.info>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Lee Jones <lee@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH 2/2] power: supply: Add bd718(15/28/78) charger driver
Message-ID: <202508191303.UzPStkjj-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250816-bd71828-charger-v1-2-71b11bde5c73@kemnade.info>

Hi Andreas,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Andreas-Kemnade/mfd-bd71828-bd71815-prepare-for-power-supply-support/20250817-032146
base:   8f5ae30d69d7543eee0d70083daf4de8fe15d585
patch link:    https://lore.kernel.org/r/20250816-bd71828-charger-v1-2-71b11bde5c73%40kemnade.info
patch subject: [PATCH 2/2] power: supply: Add bd718(15/28/78) charger driver
config: loongarch-randconfig-r073-20250818 (https://download.01.org/0day-ci/archive/20250819/202508191303.UzPStkjj-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 15.1.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202508191303.UzPStkjj-lkp@intel.com/

smatch warnings:
drivers/power/supply/bd71828-power.c:298 bd71828_get_temp() error: uninitialized symbol 't'.
drivers/power/supply/bd71828-power.c:559 bd71828_battery_get_property() error: uninitialized symbol 'tmp'.

vim +/t +298 drivers/power/supply/bd71828-power.c

c57d31029550a0 Andreas Kemnade 2025-08-16  286  static int bd71828_get_temp(struct bd71828_power *pwr, int *temp)
c57d31029550a0 Andreas Kemnade 2025-08-16  287  {
c57d31029550a0 Andreas Kemnade 2025-08-16  288  	uint16_t t;
c57d31029550a0 Andreas Kemnade 2025-08-16  289  	int ret;
c57d31029550a0 Andreas Kemnade 2025-08-16  290  	int tmp = 200 * 10000;
c57d31029550a0 Andreas Kemnade 2025-08-16  291  
c57d31029550a0 Andreas Kemnade 2025-08-16  292  	ret = bd7182x_read16_himask(pwr, pwr->regs->btemp_vth,
c57d31029550a0 Andreas Kemnade 2025-08-16  293  				    BD71828_MASK_VM_BTMP_U, &t);
c57d31029550a0 Andreas Kemnade 2025-08-16  294  	if (ret || t > 3200)
c57d31029550a0 Andreas Kemnade 2025-08-16  295  		dev_err(pwr->dev,
c57d31029550a0 Andreas Kemnade 2025-08-16  296  			"Failed to read system min average voltage\n");

We should return the error here.

c57d31029550a0 Andreas Kemnade 2025-08-16  297  
c57d31029550a0 Andreas Kemnade 2025-08-16 @298  	tmp -= 625ULL * (unsigned int)t;

If bd7182x_read16_himask() fails then t is uninitialized or invalid.

c57d31029550a0 Andreas Kemnade 2025-08-16  299  	*temp = tmp / 1000;
c57d31029550a0 Andreas Kemnade 2025-08-16  300  
c57d31029550a0 Andreas Kemnade 2025-08-16  301  	return ret;
c57d31029550a0 Andreas Kemnade 2025-08-16  302  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


