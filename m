Return-Path: <linux-pm+bounces-40052-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9157CCEA375
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 17:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F964300C289
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 16:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0339F259C84;
	Tue, 30 Dec 2025 16:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J258kGX7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE487B640
	for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 16:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767113232; cv=none; b=LOu2wutveQs06x6BAYVKHli+albnAaY5iRKZnv5hk0Tr5/5sl+kbkWh/AaDtaF3D0AChQXWLoPF6JQ0+hvO0sP1/nuHIQNOSyuYsvlaq6weiEZLyxJZILhqgSUlznQ6XYDU3aUahEd37GGxyG8+6HA9c/LIe6YYsD7b9tpS/aMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767113232; c=relaxed/simple;
	bh=azMGZ+Y/w738X1gTmr+Ft9ox9muQzUuW+4LiLYeeONg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=eyEQAWbPFIbY4KJ5fqcCj97HdPYO6oeIdUj3Qum/meipByViJ0LenhwvxoBfia6cQXLR8n1buuq5DP/zWOhxr/5jh6+bitgXCx3KykkWGSgyRpbhV3jboeORAaBTrXPqPr7Jq+5W37JfL1TqvVfoi5iE9fyh5UmwY8H4YzD4Www=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J258kGX7; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42fb4eeb482so5066015f8f.0
        for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 08:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767113229; x=1767718029; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3pfquFHr2E1uP9KAC57iEkcByjX7EFnU9BkMGY8sqcI=;
        b=J258kGX7uHWdgvpGqbYW7ud/5IBSNeAZqxwB9k1PdRmHQZsOUW3VoAYAh0cVZn95Nn
         aYXQQNmZ1XiAikkM9a1YLUFcFIgO11QmHqRmTMScDOdGMh51pgiBi/5PEbWLa6RY7B92
         DxUf/6/D3TDqo8h43HP0Rf7KXVn7hOJMsh/oDDWc2/MbobvJJXS36MEHcoS1/Erow739
         DOiOHE7aC+Gi+c9yTOnT1puB/DL1DHO2727C5ok0CwmlvI8nasDQn1ZKd4FUZRiJOPUW
         oBP59Hz2525bGQBWgw9TeDoxU0g9yk6333TA/eFlMllKxUu21T6y0IzBB4AODh9+1pDM
         JjDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767113229; x=1767718029;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3pfquFHr2E1uP9KAC57iEkcByjX7EFnU9BkMGY8sqcI=;
        b=pbNkdE3jT5i5XH4hmtlhZSsLkqfEe6njhMBA28B/N8/weYKx+cBFQP/9nt98a1Qvsy
         nyzM+Ho293y1cBKb2g6jl1RRw9haFWV2HrQR0fOUt7VroRoiGbNPJGBg7WB8Cy68oMnl
         Wq+HgzHBti917MEhFZnjhtfYa622Q1Dr7eQg7HrlN8feL+pZuGzz6QFJYLS5+6ZRyaCn
         GTlkX1QKT27myDm+lxDc7SjM2V8u2SgC2/iyYrxqYhECeJ8OuuG1wUduCTAPc0OB6lzL
         1oyFgvz/PJIJoKoe1E+f26gqwu09iS9CxXmzJ7eZLsD7S0d0aQb7m+p5glj88t4wEDMq
         oX3A==
X-Forwarded-Encrypted: i=1; AJvYcCVDu7JNGtfOuNjYFK2Ji0UkK+XxMyw7wbt0CBTXKKAfyibrcVZTTNMf9nslSQFW5Irs+nWmqVpjgg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMWI6lOhMqhlEQQjPoFqjY+Rmjhk4tOH1MhuwEQoQcU4EZH1g3
	UBT1yiYr22UpAKvAR0ls2DWJo5/SFsT4XYVHMFDUmt73fRwUG5kMzusr7kXk6UCi5Gk=
X-Gm-Gg: AY/fxX5sM0CKNqOcD33rUEIR23FIaeaHfMqFPIj4YfcF4q8+XzefuKvIyBG6owxmf+d
	AeIwTTjn/01CBvDOFJY4i2EcD+yHabVDnSSsKIw/+VLmNl21uf0j7gGDk+B1FfizedRNb33mtc2
	6ifJIwBroyl26ZyGsebKqC1OyOYkZ4x4Xb+dEYg42SMGAggyrCgFO35uO4biFacW5wCNXDe/Ym+
	KWVMXHB1Nyjw/LTE79NpYCEmQp1XSjswg5CrQiEW+k8XabKmxuqWx1djgPzb2YiPiAInN0ErqCJ
	bVbaPjZO/RE8FB0o9bN1OldKNj+EfGO2JcmipnMcf1LVhkLXQlubyxA5kXG2G569DBV2fdAnhbe
	rxoN5ZPqBidnBLC5aKzww2iRFIDGGEMehr7RrTRq4lelNZZmKkdSYAEdqU3R6n5W5tpo8eOIoU8
	7L3kByi5aSdgi8Vwh7
X-Google-Smtp-Source: AGHT+IHMq3rkyfVIFLOAgqrtI8Kd81444k2H0h1pzFPyc4MxuoT1oRDzP4THcxMscABTwCEuwuAx4Q==
X-Received: by 2002:a05:6000:144c:b0:430:ff81:2965 with SMTP id ffacd0b85a97d-4324e50bb11mr43495198f8f.49.1767113228812;
        Tue, 30 Dec 2025 08:47:08 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43277b82a58sm35493375f8f.6.2025.12.30.08.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 08:47:08 -0800 (PST)
Date: Tue, 30 Dec 2025 19:47:05 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev,
	Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
	Sebastian Reichel <sre@kernel.org>,
	Bartosz Golaszewski <bgolasze@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Subject: Re: [PATCH v22 2/2] power: reset: reboot-mode: Expose sysfs for
 registered reboot_modes
Message-ID: <202512271806.n2lycyZw-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227-next-15nov_expose_sysfs-v22-2-2d153438ba19@oss.qualcomm.com>

Hi Shivendra,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Shivendra-Pratap/Documentation-ABI-Add-sysfs-class-reboot-mode-reboot_modes/20251227-025914
base:   cc3aa43b44bdb43dfbac0fcb51c56594a11338a8
patch link:    https://lore.kernel.org/r/20251227-next-15nov_expose_sysfs-v22-2-2d153438ba19%40oss.qualcomm.com
patch subject: [PATCH v22 2/2] power: reset: reboot-mode: Expose sysfs for registered reboot_modes
config: x86_64-randconfig-161-20251227 (https://download.01.org/0day-ci/archive/20251227/202512271806.n2lycyZw-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202512271806.n2lycyZw-lkp@intel.com/

smatch warnings:
drivers/power/reset/reboot-mode.c:147 reboot_mode_create_device() error: we previously assumed 'head' could be null (see line 112)

vim +/head +147 drivers/power/reset/reboot-mode.c

e5f49083a20ae0 Shivendra Pratap 2025-12-27  103  static int reboot_mode_create_device(struct reboot_mode_driver *reboot)
e5f49083a20ae0 Shivendra Pratap 2025-12-27  104  {
e5f49083a20ae0 Shivendra Pratap 2025-12-27  105  	struct sysfs_data *sysfs_info;
e5f49083a20ae0 Shivendra Pratap 2025-12-27  106  	struct sysfs_data *next;
e5f49083a20ae0 Shivendra Pratap 2025-12-27  107  	struct list_head *head;
e5f49083a20ae0 Shivendra Pratap 2025-12-27  108  	struct mode_info *info;
e5f49083a20ae0 Shivendra Pratap 2025-12-27  109  	int ret;
e5f49083a20ae0 Shivendra Pratap 2025-12-27  110  
e5f49083a20ae0 Shivendra Pratap 2025-12-27  111  	head = kzalloc(sizeof(*head), GFP_KERNEL);
e5f49083a20ae0 Shivendra Pratap 2025-12-27 @112  	if (!head) {
e5f49083a20ae0 Shivendra Pratap 2025-12-27  113  		ret = -ENOMEM;
e5f49083a20ae0 Shivendra Pratap 2025-12-27  114  		goto error;

This should just be return -ENOMEM;

e5f49083a20ae0 Shivendra Pratap 2025-12-27  115  	}
e5f49083a20ae0 Shivendra Pratap 2025-12-27  116  
e5f49083a20ae0 Shivendra Pratap 2025-12-27  117  	INIT_LIST_HEAD(head);
e5f49083a20ae0 Shivendra Pratap 2025-12-27  118  
e5f49083a20ae0 Shivendra Pratap 2025-12-27  119  	list_for_each_entry(info, &reboot->head, list) {
e5f49083a20ae0 Shivendra Pratap 2025-12-27  120  		sysfs_info = kzalloc(sizeof(*sysfs_info), GFP_KERNEL);
e5f49083a20ae0 Shivendra Pratap 2025-12-27  121  		if (!sysfs_info) {
e5f49083a20ae0 Shivendra Pratap 2025-12-27  122  			ret = -ENOMEM;
e5f49083a20ae0 Shivendra Pratap 2025-12-27  123  			goto error;
e5f49083a20ae0 Shivendra Pratap 2025-12-27  124  		}
e5f49083a20ae0 Shivendra Pratap 2025-12-27  125  
e5f49083a20ae0 Shivendra Pratap 2025-12-27  126  		sysfs_info->mode = kstrdup_const(info->mode, GFP_KERNEL);
e5f49083a20ae0 Shivendra Pratap 2025-12-27  127  		if (!sysfs_info->mode) {
e5f49083a20ae0 Shivendra Pratap 2025-12-27  128  			kfree(sysfs_info);
e5f49083a20ae0 Shivendra Pratap 2025-12-27  129  			ret = -ENOMEM;
e5f49083a20ae0 Shivendra Pratap 2025-12-27  130  			goto error;
e5f49083a20ae0 Shivendra Pratap 2025-12-27  131  		}
e5f49083a20ae0 Shivendra Pratap 2025-12-27  132  
e5f49083a20ae0 Shivendra Pratap 2025-12-27  133  		list_add_tail(&sysfs_info->list, head);
e5f49083a20ae0 Shivendra Pratap 2025-12-27  134  	}
e5f49083a20ae0 Shivendra Pratap 2025-12-27  135  
e5f49083a20ae0 Shivendra Pratap 2025-12-27  136  	reboot->reboot_mode_device = device_create(&reboot_mode_class, NULL, 0,
e5f49083a20ae0 Shivendra Pratap 2025-12-27  137  						   (void *)head, reboot->dev->driver->name);
e5f49083a20ae0 Shivendra Pratap 2025-12-27  138  
e5f49083a20ae0 Shivendra Pratap 2025-12-27  139  	if (IS_ERR(reboot->reboot_mode_device)) {
e5f49083a20ae0 Shivendra Pratap 2025-12-27  140  		ret = PTR_ERR(reboot->reboot_mode_device);
e5f49083a20ae0 Shivendra Pratap 2025-12-27  141  		goto error;
e5f49083a20ae0 Shivendra Pratap 2025-12-27  142  	}
e5f49083a20ae0 Shivendra Pratap 2025-12-27  143  
e5f49083a20ae0 Shivendra Pratap 2025-12-27  144  	return 0;
e5f49083a20ae0 Shivendra Pratap 2025-12-27  145  
e5f49083a20ae0 Shivendra Pratap 2025-12-27  146  error:
e5f49083a20ae0 Shivendra Pratap 2025-12-27 @147  	list_for_each_entry_safe(sysfs_info, next, head, list) {
                                                                                                   ^^^^
But it is a crash instead.

e5f49083a20ae0 Shivendra Pratap 2025-12-27  148  		list_del(&sysfs_info->list);
e5f49083a20ae0 Shivendra Pratap 2025-12-27  149  		kfree_const(sysfs_info->mode);
e5f49083a20ae0 Shivendra Pratap 2025-12-27  150  		kfree(sysfs_info);
e5f49083a20ae0 Shivendra Pratap 2025-12-27  151  	}
e5f49083a20ae0 Shivendra Pratap 2025-12-27  152  
e5f49083a20ae0 Shivendra Pratap 2025-12-27  153  	kfree(head);
e5f49083a20ae0 Shivendra Pratap 2025-12-27  154  	reboot->reboot_mode_device = NULL;
e5f49083a20ae0 Shivendra Pratap 2025-12-27  155  	return ret;
e5f49083a20ae0 Shivendra Pratap 2025-12-27  156  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


