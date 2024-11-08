Return-Path: <linux-pm+bounces-17209-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0755F9C1F0E
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 15:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B16E128535A
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 14:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858E31F1309;
	Fri,  8 Nov 2024 14:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dkSfIlzZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBC11EB9F2
	for <linux-pm@vger.kernel.org>; Fri,  8 Nov 2024 14:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731075587; cv=none; b=mF5LJUrWd/NkbGMM9hw2KBNcSTKfPdN6iP6phDoV3bv9hDdZRjE2tF/CPjuYnFFcd3tRKMzC9+82VXMLIHp81ic0lTH6vNj4sCzgrIPWz0a/W2Fy8DlWtPe/+Be3GmTW8Lmo4vBYhLj8rnk4QRCw0mbsroALZwvZzBG6kIANI74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731075587; c=relaxed/simple;
	bh=ZLLRMH49n6WaYFzMYL7hdn+IuXPLKE4cMZuz6YX2Flw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=cLkeW3fr9ksyjXeYCRqWMBVqadTUd8fGn4sGhm8oqs1+nV8G3jkfxN9GCzbkv7Q/9bzaAITE4pbo7jwq/zx+oAtsII6GT03wPUDY6lqpQhpZKNmCURNU/fXLXbaYCVMFcuJ521RdEjlXXdMIpp7LeA1b2J478peeKnLE41cSh10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dkSfIlzZ; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c9404c0d50so2623049a12.3
        for <linux-pm@vger.kernel.org>; Fri, 08 Nov 2024 06:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731075584; x=1731680384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VGA9Y6BP3dpROBWYVYwafi2ecYshZ4WbiAsNU+E9Uq0=;
        b=dkSfIlzZ01tuUyCJu2Q/ceX4tVXfWxnQIXSJAiL+uxqLTewekRdBIFo8/qfK/gccZX
         w3YJA84ky8AnDTxm2w6A757YV7YhU19lT8/CX/4gGlhrATqdsotN/EI+HWFdTpPgp0u9
         RL12LsIzXLLbh4CifnLIoW6P49qsWPmLdRByDt4IMO2ZNnC8O90waHBTB5TN8k/GL/KU
         Th/X3JLD1mwX73RYNJhKK8tLxwfZ0w5yDB4pqboiWiEttVAE+AeRzU/Pk/RGdP3+tbYH
         fnYt4lVqdpLLVZfXkrTb2+KTl4NyZMiFCwgWo/F3EgokYIgJFcT5WCL7+tBFrwu9i8oB
         VL7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731075584; x=1731680384;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VGA9Y6BP3dpROBWYVYwafi2ecYshZ4WbiAsNU+E9Uq0=;
        b=C43n38sA9DL5ASzUXLo3AF20QYasuDX+60DczDudq1QPfvDBp1Ga74LcmguuXyfrw9
         OcTjhSlz5V8AS+TMqVIVcMBP8h6AgxME4SRpVt4LwBELRsWhb1iuZtU05K4FI66MC+EC
         Ho6SbMdJ0C+YaZnfwnKyIoicoHnUJJiqABeWkJjzoBVqtzUg2L8AHy0LpV1lfYaLXOKw
         ir3ee2P82/eI6L7kvJV8MNdYn0MjnCnrncbTOXriHjOyo4DzD3TH5t4xiXbsaa9JoM2r
         1NxKAsFk0Hucqzsf4LTBjfe/gKlX8/2nLkuq6N2u+zXQKOVivSD+MbOU9wcyWrf2uELZ
         +SXg==
X-Forwarded-Encrypted: i=1; AJvYcCWV6nMhR44Lr3ZGZgt1V03TcdKYAqE8i5nulF1im+Bkhbe3dPA43qiSt9islivmTIS6CtonCtCjJQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YydUrYu8SVrEvkLaZJAbWDSLJOVvygVBcLW3ZXp/L0Fw3t73ErO
	+g1vkjWnpqeOn16W6rPN53w2YRSl/Qopf+WctQiUlFLFr9C+MSYO4cK/Qh9KJuo=
X-Google-Smtp-Source: AGHT+IHmXybQiAHW1OqbfUTN22sas0nIZd7gHqCAPHOaYdpQEeD0jrEFikAP+yhuHydY+dzM1edQDw==
X-Received: by 2002:a05:6402:d0d:b0:5ca:151a:b84c with SMTP id 4fb4d7f45d1cf-5cf0a320706mr2220233a12.18.1731075583567;
        Fri, 08 Nov 2024 06:19:43 -0800 (PST)
Received: from localhost ([154.14.63.34])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03bb765asm2025429a12.48.2024.11.08.06.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 06:19:43 -0800 (PST)
Date: Fri, 8 Nov 2024 17:19:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Shawn Lin <shawn.lin@rock-chips.com>,
	Rob Herring <robh+dt@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	YiFeng Zhao <zyf@rock-chips.com>, Liang Chen <cl@rock-chips.com>,
	linux-scsi@vger.kernel.org, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 4/7] pmdomain: core: Introduce
 dev_pm_genpd_rpm_always_on()
Message-ID: <54ad5572-3ad6-4c8d-80cd-b2f975ad91bf@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1730705521-23081-5-git-send-email-shawn.lin@rock-chips.com>

Hi Shawn,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shawn-Lin/dt-bindings-ufs-Document-Rockchip-UFS-host-controller/20241104-191810
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git for-next
patch link:    https://lore.kernel.org/r/1730705521-23081-5-git-send-email-shawn.lin%40rock-chips.com
patch subject: [PATCH v4 4/7] pmdomain: core: Introduce dev_pm_genpd_rpm_always_on()
config: loongarch-randconfig-r073-20241107 (https://download.01.org/0day-ci/archive/20241108/202411080432.5dWP6wRt-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202411080432.5dWP6wRt-lkp@intel.com/

New smatch warnings:
drivers/pmdomain/core.c:898 genpd_power_off() warn: curly braces intended?

vim +898 drivers/pmdomain/core.c

2da835452a08758 drivers/base/power/domain.c Ulf Hansson     2017-02-17  850  static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
2da835452a08758 drivers/base/power/domain.c Ulf Hansson     2017-02-17  851  			   unsigned int depth)
1f8728b7adc4c2b drivers/base/power/domain.c Ulf Hansson     2017-02-17  852  {
1f8728b7adc4c2b drivers/base/power/domain.c Ulf Hansson     2017-02-17  853  	struct pm_domain_data *pdd;
1f8728b7adc4c2b drivers/base/power/domain.c Ulf Hansson     2017-02-17  854  	struct gpd_link *link;
1f8728b7adc4c2b drivers/base/power/domain.c Ulf Hansson     2017-02-17  855  	unsigned int not_suspended = 0;
f63816e43d90442 drivers/base/power/domain.c Ulf Hansson     2020-09-24  856  	int ret;
1f8728b7adc4c2b drivers/base/power/domain.c Ulf Hansson     2017-02-17  857  
1f8728b7adc4c2b drivers/base/power/domain.c Ulf Hansson     2017-02-17  858  	/*
1f8728b7adc4c2b drivers/base/power/domain.c Ulf Hansson     2017-02-17  859  	 * Do not try to power off the domain in the following situations:
1f8728b7adc4c2b drivers/base/power/domain.c Ulf Hansson     2017-02-17  860  	 * (1) The domain is already in the "power off" state.
1f8728b7adc4c2b drivers/base/power/domain.c Ulf Hansson     2017-02-17  861  	 * (2) System suspend is in progress.
1f8728b7adc4c2b drivers/base/power/domain.c Ulf Hansson     2017-02-17  862  	 */
41e2c8e0060db25 drivers/base/power/domain.c Ulf Hansson     2017-03-20  863  	if (!genpd_status_on(genpd) || genpd->prepared_count > 0)
1f8728b7adc4c2b drivers/base/power/domain.c Ulf Hansson     2017-02-17  864  		return 0;
1f8728b7adc4c2b drivers/base/power/domain.c Ulf Hansson     2017-02-17  865  
ffaa42e8a40b7f1 drivers/base/power/domain.c Ulf Hansson     2017-03-20  866  	/*
ffaa42e8a40b7f1 drivers/base/power/domain.c Ulf Hansson     2017-03-20  867  	 * Abort power off for the PM domain in the following situations:
ffaa42e8a40b7f1 drivers/base/power/domain.c Ulf Hansson     2017-03-20  868  	 * (1) The domain is configured as always on.
ffaa42e8a40b7f1 drivers/base/power/domain.c Ulf Hansson     2017-03-20  869  	 * (2) When the domain has a subdomain being powered on.
ffaa42e8a40b7f1 drivers/base/power/domain.c Ulf Hansson     2017-03-20  870  	 */
ed61e18a4b4e445 drivers/base/power/domain.c Leonard Crestez 2019-04-30  871  	if (genpd_is_always_on(genpd) ||
ed61e18a4b4e445 drivers/base/power/domain.c Leonard Crestez 2019-04-30  872  			genpd_is_rpm_always_on(genpd) ||
ed61e18a4b4e445 drivers/base/power/domain.c Leonard Crestez 2019-04-30  873  			atomic_read(&genpd->sd_count) > 0)
1f8728b7adc4c2b drivers/base/power/domain.c Ulf Hansson     2017-02-17  874  		return -EBUSY;
1f8728b7adc4c2b drivers/base/power/domain.c Ulf Hansson     2017-02-17  875  
e7d90cfac5510f8 drivers/base/power/domain.c Ulf Hansson     2022-02-17  876  	/*
e7d90cfac5510f8 drivers/base/power/domain.c Ulf Hansson     2022-02-17  877  	 * The children must be in their deepest (powered-off) states to allow
e7d90cfac5510f8 drivers/base/power/domain.c Ulf Hansson     2022-02-17  878  	 * the parent to be powered off. Note that, there's no need for
e7d90cfac5510f8 drivers/base/power/domain.c Ulf Hansson     2022-02-17  879  	 * additional locking, as powering on a child, requires the parent's
e7d90cfac5510f8 drivers/base/power/domain.c Ulf Hansson     2022-02-17  880  	 * lock to be acquired first.
e7d90cfac5510f8 drivers/base/power/domain.c Ulf Hansson     2022-02-17  881  	 */
e7d90cfac5510f8 drivers/base/power/domain.c Ulf Hansson     2022-02-17  882  	list_for_each_entry(link, &genpd->parent_links, parent_node) {
e7d90cfac5510f8 drivers/base/power/domain.c Ulf Hansson     2022-02-17  883  		struct generic_pm_domain *child = link->child;
e7d90cfac5510f8 drivers/base/power/domain.c Ulf Hansson     2022-02-17  884  		if (child->state_idx < child->state_count - 1)
e7d90cfac5510f8 drivers/base/power/domain.c Ulf Hansson     2022-02-17  885  			return -EBUSY;
e7d90cfac5510f8 drivers/base/power/domain.c Ulf Hansson     2022-02-17  886  	}
e7d90cfac5510f8 drivers/base/power/domain.c Ulf Hansson     2022-02-17  887  
1f8728b7adc4c2b drivers/base/power/domain.c Ulf Hansson     2017-02-17  888  	list_for_each_entry(pdd, &genpd->dev_list, list_node) {
1f8728b7adc4c2b drivers/base/power/domain.c Ulf Hansson     2017-02-17  889  		/*
1f8728b7adc4c2b drivers/base/power/domain.c Ulf Hansson     2017-02-17  890  		 * Do not allow PM domain to be powered off, when an IRQ safe
1f8728b7adc4c2b drivers/base/power/domain.c Ulf Hansson     2017-02-17  891  		 * device is part of a non-IRQ safe domain.
1f8728b7adc4c2b drivers/base/power/domain.c Ulf Hansson     2017-02-17  892  		 */
1f8728b7adc4c2b drivers/base/power/domain.c Ulf Hansson     2017-02-17  893  		if (!pm_runtime_suspended(pdd->dev) ||
7a02444b8fc25ac drivers/base/power/domain.c Ulf Hansson     2022-05-11  894  			irq_safe_dev_in_sleep_domain(pdd->dev, genpd))

{

1f8728b7adc4c2b drivers/base/power/domain.c Ulf Hansson     2017-02-17  895  			not_suspended++;
f0f6da10152fb8f drivers/pmdomain/core.c     Ulf Hansson     2024-11-04  896  
f0f6da10152fb8f drivers/pmdomain/core.c     Ulf Hansson     2024-11-04  897  			/* The device may need its PM domain to stay powered on. */
f0f6da10152fb8f drivers/pmdomain/core.c     Ulf Hansson     2024-11-04 @898  			if (to_gpd_data(pdd)->rpm_always_on)
f0f6da10152fb8f drivers/pmdomain/core.c     Ulf Hansson     2024-11-04  899  				return -EBUSY;

}

1f8728b7adc4c2b drivers/base/power/domain.c Ulf Hansson     2017-02-17  900  	}
1f8728b7adc4c2b drivers/base/power/domain.c Ulf Hansson     2017-02-17  901  
3c64649d1cf9f32 drivers/base/power/domain.c Ulf Hansson     2017-02-17  902  	if (not_suspended > 1 || (not_suspended == 1 && !one_dev_on))
1f8728b7adc4c2b drivers/base/power/domain.c Ulf Hansson     2017-02-17  903  		return -EBUSY;
1f8728b7adc4c2b drivers/base/power/domain.c Ulf Hansson     2017-02-17  904  
1f8728b7adc4c2b drivers/base/power/domain.c Ulf Hansson     2017-02-17  905  	if (genpd->gov && genpd->gov->power_down_ok) {
1f8728b7adc4c2b drivers/base/power/domain.c Ulf Hansson     2017-02-17  906  		if (!genpd->gov->power_down_ok(&genpd->domain))

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


