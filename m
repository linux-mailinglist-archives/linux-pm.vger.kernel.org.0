Return-Path: <linux-pm+bounces-8075-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6EF8CD2CF
	for <lists+linux-pm@lfdr.de>; Thu, 23 May 2024 14:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 621D3B20CD9
	for <lists+linux-pm@lfdr.de>; Thu, 23 May 2024 12:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB79814A4DD;
	Thu, 23 May 2024 12:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TR9RWNJo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02ED14A08E
	for <linux-pm@vger.kernel.org>; Thu, 23 May 2024 12:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716468627; cv=none; b=aVYsKqIQX/ciNYJhaS2CNQaRapLppk3mziIq4U4OP0dNoqOmHxBQL4m0lHJotzaV6iPP8rDIY40KrXtLHF1AWZTlNm/XFyXjrbyxVODjOg1oVCjobx8w2eB/Z0wbX0roARaeXRFj/K2UFIFkHt7eIsMi4DtrUCecK7Q/BRLDaiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716468627; c=relaxed/simple;
	bh=ibZU/Uk6VSr0voTpC9iwARL/7suVVCV2wKyJXhs8GqE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZzlNJCZLSUEF8ISsR4ZtPDE+9GKCkyjI0S2E3/jE9jWVXYx++sZgk4wMCPe1nSIC3MppuX/F38fz+06hhV/JVbKe3I93kPdn/T8RuRvdVCRTJ+W23u3CXGhYgQnw3k8UQj8As346cGfPJPUS8xknciEiyWziXyNOTCmRZQNwZps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TR9RWNJo; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2e724bc46c4so50970831fa.2
        for <linux-pm@vger.kernel.org>; Thu, 23 May 2024 05:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716468623; x=1717073423; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iMRosXpx6OHaMx5JGWHkEwQsj1y/M7jejw8tTuvOccA=;
        b=TR9RWNJokP1LsSdS8/SjleoafZ7tz4h3nul/gs+WsW8KexCgzcAQHi/uB2QemW+sn3
         4USk8CkoptOAZiXtmTR49gDMzRkxPxJF+BPghHz+YHdQpIHbgPG0VQ72Jwg9KEHpvpAy
         bsZaThT/23hKU3Uq9OEAxkOkUmEpdgWidkbbEAIv4mbZVEFg9hKkqZTlnWWim83ElWBK
         sb3wiMZx2PuOgBhtOJ1MxnGNUSFnaUpjYIoqqZc/rtO3oI2g0jRMuNi9HK/jL3ZrXm6X
         0IWWV0WPruJveAaJ1UIei6ZDeFUDdf5AkKJABvocFYqd9RA2r7g2npMySuMRtUsGr6nq
         tUWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716468623; x=1717073423;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iMRosXpx6OHaMx5JGWHkEwQsj1y/M7jejw8tTuvOccA=;
        b=KgddqiftNcCLQfCKpoevWJbZghydndbAfhAWkQ7C1Y84X2lV0v8GmCyb7SgbLx1cpV
         jAEMS++UkY14FgHZp1O1rKJPCp/Oc+OqJuLClBFU9I8EdrvGO06ti9s+BN5oPnXBHBC+
         XynZNeA6pfPYgF+Ui0PdNDnn8ONCV/NY8keiGLmBleUuVV4UDPYt3gQWYhd5Ehvp24gy
         rZQ/vHtqWDSMS4UH//dOC7SNWvIkuFw0gzAZHhNpx/vbhqF8faW055O/anymQ8KGODU2
         70JzEz/+wuWeUesMzawKsT7Vc5u0yUus1pBmouytO47ZPQaYliWFPMZSHvPSSuBJXSOS
         tJwA==
X-Forwarded-Encrypted: i=1; AJvYcCXOprbXGpEjjtzEgtI6bJ1mm7Upnll9Vhn549z8Y5T7fcfD65YxIOwUpU90D9pemKVCEBfAO/qB2tl48d4G46Fe3P3lvmdGZtI=
X-Gm-Message-State: AOJu0Yzx7RNYQWBQQn1oLLSMnSJ1sckPv27f6npN2IsDH7TccKavvJTX
	aIZWXXYX/l3+wGWlKTGHNByXwpVBnAtCbD3GCnfNQ1KPXM4FlVxHanAKgjEiRG8=
X-Google-Smtp-Source: AGHT+IEYdbwkk+JyzWTXRqnous0dnxnUZ9YrXqdyIoZLDlluWrI7kO3bl7ZKTWUKoBj2mjM2eRZ/oQ==
X-Received: by 2002:a2e:7302:0:b0:2e6:f4c1:31e5 with SMTP id 38308e7fff4ca-2e9494bb49amr32177141fa.23.1716468622636;
        Thu, 23 May 2024 05:50:22 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-354f9ba7584sm1430381f8f.57.2024.05.23.05.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 05:50:22 -0700 (PDT)
Date: Thu, 23 May 2024 15:50:18 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Viresh Kumar <viresh.kumar@linaro.org>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-acpi@vger.kernel.org, devel@acpica.org,
	linux-pm@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: [rafael-pm:bleeding-edge 11/15] drivers/opp/core.c:2447
 _opp_attach_genpd() warn: missing unwind goto?
Message-ID: <3d73f08e-8305-4ad8-8327-adaaf96ac673@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   fe07fa9fa1115e0979b89a90ae8594794ac2f63f
commit: 2a56c462fe5a2ee61d38e2d7b772bee56115a00c [11/15] OPP: Fix required_opp_tables for multiple genpds using same table
config: i386-randconfig-141-20240517 (https://download.01.org/0day-ci/archive/20240518/202405180016.4fbn86bm-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202405180016.4fbn86bm-lkp@intel.com/

New smatch warnings:
drivers/opp/core.c:2447 _opp_attach_genpd() warn: missing unwind goto?

vim +2447 drivers/opp/core.c

442e7a1786e628 Viresh Kumar          2022-05-26  2394  static int _opp_attach_genpd(struct opp_table *opp_table, struct device *dev,
3734b9f2cee01d Dmitry Osipenko       2021-09-27  2395  			const char * const *names, struct device ***virt_devs)
4f018bc0e1cfde Viresh Kumar          2018-06-26  2396  {
2a56c462fe5a2e Viresh Kumar          2024-04-09  2397  	struct device *virt_dev, *gdev;
2a56c462fe5a2e Viresh Kumar          2024-04-09  2398  	struct opp_table *genpd_table;
baea35e4db17a7 Viresh Kumar          2019-07-17  2399  	int index = 0, ret = -EINVAL;
3734b9f2cee01d Dmitry Osipenko       2021-09-27  2400  	const char * const *name = names;
4f018bc0e1cfde Viresh Kumar          2018-06-26  2401  
e37440e7e2c276 Viresh Kumar          2023-10-27  2402  	if (!opp_table->required_devs) {
e37440e7e2c276 Viresh Kumar          2023-10-27  2403  		dev_err(dev, "Required OPPs not available, can't attach genpd\n");
e37440e7e2c276 Viresh Kumar          2023-10-27  2404  		return -EINVAL;
e37440e7e2c276 Viresh Kumar          2023-10-27  2405  	}
4f018bc0e1cfde Viresh Kumar          2018-06-26  2406  
925141432fa4d8 Viresh Kumar          2023-11-16  2407  	/* Genpd core takes care of propagation to parent genpd */
925141432fa4d8 Viresh Kumar          2023-11-16  2408  	if (opp_table->is_genpd) {
925141432fa4d8 Viresh Kumar          2023-11-16  2409  		dev_err(dev, "%s: Operation not supported for genpds\n", __func__);
925141432fa4d8 Viresh Kumar          2023-11-16  2410  		return -EOPNOTSUPP;
925141432fa4d8 Viresh Kumar          2023-11-16  2411  	}
925141432fa4d8 Viresh Kumar          2023-11-16  2412  
e37440e7e2c276 Viresh Kumar          2023-10-27  2413  	/* Checking only the first one is enough ? */
e37440e7e2c276 Viresh Kumar          2023-10-27  2414  	if (opp_table->required_devs[0])
e37440e7e2c276 Viresh Kumar          2023-10-27  2415  		return 0;
4f018bc0e1cfde Viresh Kumar          2018-06-26  2416  
6319aee10e5303 Viresh Kumar          2019-05-08  2417  	while (*name) {
6319aee10e5303 Viresh Kumar          2019-05-08  2418  		if (index >= opp_table->required_opp_count) {
6319aee10e5303 Viresh Kumar          2019-05-08  2419  			dev_err(dev, "Index can't be greater than required-opp-count - 1, %s (%d : %d)\n",
6319aee10e5303 Viresh Kumar          2019-05-08  2420  				*name, opp_table->required_opp_count, index);
6319aee10e5303 Viresh Kumar          2019-05-08  2421  			goto err;
6319aee10e5303 Viresh Kumar          2019-05-08  2422  		}
4f018bc0e1cfde Viresh Kumar          2018-06-26  2423  
6319aee10e5303 Viresh Kumar          2019-05-08  2424  		virt_dev = dev_pm_domain_attach_by_name(dev, *name);
4ea9496cbc959e Tang Bin              2022-05-24  2425  		if (IS_ERR_OR_NULL(virt_dev)) {
d920920f85a82c Manivannan Sadhasivam 2023-07-21  2426  			ret = virt_dev ? PTR_ERR(virt_dev) : -ENODEV;
6319aee10e5303 Viresh Kumar          2019-05-08  2427  			dev_err(dev, "Couldn't attach to pm_domain: %d\n", ret);
6319aee10e5303 Viresh Kumar          2019-05-08  2428  			goto err;
4f018bc0e1cfde Viresh Kumar          2018-06-26  2429  		}
4f018bc0e1cfde Viresh Kumar          2018-06-26  2430  
2a56c462fe5a2e Viresh Kumar          2024-04-09  2431  		/*
2a56c462fe5a2e Viresh Kumar          2024-04-09  2432  		 * The required_opp_tables parsing is not perfect, as the OPP
2a56c462fe5a2e Viresh Kumar          2024-04-09  2433  		 * core does the parsing solely based on the DT node pointers.
2a56c462fe5a2e Viresh Kumar          2024-04-09  2434  		 * The core sets the required_opp_tables entry to the first OPP
2a56c462fe5a2e Viresh Kumar          2024-04-09  2435  		 * table in the "opp_tables" list, that matches with the node
2a56c462fe5a2e Viresh Kumar          2024-04-09  2436  		 * pointer.
2a56c462fe5a2e Viresh Kumar          2024-04-09  2437  		 *
2a56c462fe5a2e Viresh Kumar          2024-04-09  2438  		 * If the target DT OPP table is used by multiple devices and
2a56c462fe5a2e Viresh Kumar          2024-04-09  2439  		 * they all create separate instances of 'struct opp_table' from
2a56c462fe5a2e Viresh Kumar          2024-04-09  2440  		 * it, then it is possible that the required_opp_tables entry
2a56c462fe5a2e Viresh Kumar          2024-04-09  2441  		 * may be set to the incorrect sibling device.
2a56c462fe5a2e Viresh Kumar          2024-04-09  2442  		 *
2a56c462fe5a2e Viresh Kumar          2024-04-09  2443  		 * Cross check it again and fix if required.
2a56c462fe5a2e Viresh Kumar          2024-04-09  2444  		 */
2a56c462fe5a2e Viresh Kumar          2024-04-09  2445  		gdev = dev_to_genpd_dev(virt_dev);
2a56c462fe5a2e Viresh Kumar          2024-04-09  2446  		if (IS_ERR(gdev))
2a56c462fe5a2e Viresh Kumar          2024-04-09 @2447  			return PTR_ERR(gdev);

I have read the comment, but I don't have any context outside this email
so I don't really understand it.  The error handling in this function is
confusing to me.  What are we undoing?  So potentially this is a false
positive.  But Smatch wants a "ret = PTR_ERR(gdev); goto err;" here.

2a56c462fe5a2e Viresh Kumar          2024-04-09  2448  
2a56c462fe5a2e Viresh Kumar          2024-04-09  2449  		genpd_table = _find_opp_table(gdev);
2a56c462fe5a2e Viresh Kumar          2024-04-09  2450  		if (!IS_ERR(genpd_table)) {
2a56c462fe5a2e Viresh Kumar          2024-04-09  2451  			if (genpd_table != opp_table->required_opp_tables[index]) {
2a56c462fe5a2e Viresh Kumar          2024-04-09  2452  				dev_pm_opp_put_opp_table(opp_table->required_opp_tables[index]);
2a56c462fe5a2e Viresh Kumar          2024-04-09  2453  				opp_table->required_opp_tables[index] = genpd_table;
2a56c462fe5a2e Viresh Kumar          2024-04-09  2454  			} else {
2a56c462fe5a2e Viresh Kumar          2024-04-09  2455  				dev_pm_opp_put_opp_table(genpd_table);
2a56c462fe5a2e Viresh Kumar          2024-04-09  2456  			}
2a56c462fe5a2e Viresh Kumar          2024-04-09  2457  		}
2a56c462fe5a2e Viresh Kumar          2024-04-09  2458  
e37440e7e2c276 Viresh Kumar          2023-10-27  2459  		/*
e37440e7e2c276 Viresh Kumar          2023-10-27  2460  		 * Add the virtual genpd device as a user of the OPP table, so
e37440e7e2c276 Viresh Kumar          2023-10-27  2461  		 * we can call dev_pm_opp_set_opp() on it directly.
e37440e7e2c276 Viresh Kumar          2023-10-27  2462  		 *
e37440e7e2c276 Viresh Kumar          2023-10-27  2463  		 * This will be automatically removed when the OPP table is
e37440e7e2c276 Viresh Kumar          2023-10-27  2464  		 * removed, don't need to handle that here.
e37440e7e2c276 Viresh Kumar          2023-10-27  2465  		 */
e37440e7e2c276 Viresh Kumar          2023-10-27  2466  		if (!_add_opp_dev(virt_dev, opp_table->required_opp_tables[index])) {
e37440e7e2c276 Viresh Kumar          2023-10-27  2467  			ret = -ENOMEM;
e37440e7e2c276 Viresh Kumar          2023-10-27  2468  			goto err;
e37440e7e2c276 Viresh Kumar          2023-10-27  2469  		}
e37440e7e2c276 Viresh Kumar          2023-10-27  2470  
e37440e7e2c276 Viresh Kumar          2023-10-27  2471  		opp_table->required_devs[index] = virt_dev;
baea35e4db17a7 Viresh Kumar          2019-07-17  2472  		index++;
6319aee10e5303 Viresh Kumar          2019-05-08  2473  		name++;
6319aee10e5303 Viresh Kumar          2019-05-08  2474  	}
6319aee10e5303 Viresh Kumar          2019-05-08  2475  
17a8f868ae3e85 Viresh Kumar          2019-07-08  2476  	if (virt_devs)
e37440e7e2c276 Viresh Kumar          2023-10-27  2477  		*virt_devs = opp_table->required_devs;
4f018bc0e1cfde Viresh Kumar          2018-06-26  2478  
442e7a1786e628 Viresh Kumar          2022-05-26  2479  	return 0;
6319aee10e5303 Viresh Kumar          2019-05-08  2480  
6319aee10e5303 Viresh Kumar          2019-05-08  2481  err:
48b5aaec596d9a Viresh Kumar          2023-10-12  2482  	_opp_detach_genpd(opp_table);
442e7a1786e628 Viresh Kumar          2022-05-26  2483  	return ret;
6319aee10e5303 Viresh Kumar          2019-05-08  2484  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


