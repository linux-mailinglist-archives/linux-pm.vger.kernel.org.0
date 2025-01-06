Return-Path: <linux-pm+bounces-19983-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E78A02242
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2025 10:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9978D1609B8
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2025 09:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B461D79B3;
	Mon,  6 Jan 2025 09:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JYt+RUeL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB95DB676
	for <linux-pm@vger.kernel.org>; Mon,  6 Jan 2025 09:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736157369; cv=none; b=emQsxHwH7c63YKJeHVJSnXsGN0KtVggD+5NjlYEI7wlDfjveqBdgUY56biBsQyOZNENMfH7GSsGDYJuEvwbIdd/rnlQCpMcbDHa3GdQA+Gs7RxluE4oSW8L5bJc3g3dW/g8FWz2kfl4afER3qLqF7u1GLY0QId0CSfYMxI6cfbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736157369; c=relaxed/simple;
	bh=g/OoJEckbiVwHqoVZ/DJIoLLvVB6DKWKjEkArqzX77U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=SU4vYzSmpUh+AaCO8LwhxGekLdL4wN2Fp3jSaaN1IMeSSoIGD1wADOYOnJttLRXvE5gXpdAmbkFERAGGAxyqrbYTNyLwZinTcxlyhxclztMBc3Ufk2dK77UbzoYGDGUeiaYW6Df6uYjJ5O17fBl8FqxfdtcWEu1mTaxKmCe6nUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JYt+RUeL; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-385dece873cso5198971f8f.0
        for <linux-pm@vger.kernel.org>; Mon, 06 Jan 2025 01:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736157366; x=1736762166; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XPxusyoqlnRrNJq7+ups8OMfqGNcbuHMUJVymBouBjo=;
        b=JYt+RUeLSYwLCOVuk296pJMr3wiBC5C+seAPSM68KkOYJ/yjsB2Ya9omlItZaTfmN+
         U3dwDTr3lcWaX3eYyjth51gFBEnOqwBiY1YoSeh6xtDIazhk0ye5uFaRkN+eYIY5Gf9X
         unFBTFgRGlqUI17IZy8RhkMj76AgJv2xqORmtFiOF/WTbd2NVRkgr/M0qBtHdjVTb7Vj
         BaQzDuBSnQL5z0YvX8EOQ7oqmBy6inus9B9rFTcd2xo3fCSLZCRdYIa+hcqiVjkk7LpO
         NlCM1EwhfNkXqiT6K+AkblSFvcw6hp3D8YpmTSx5heUSSXopSzEYvDsuiaYaFlBfjorC
         lykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736157366; x=1736762166;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XPxusyoqlnRrNJq7+ups8OMfqGNcbuHMUJVymBouBjo=;
        b=astM5/OD9VamGWdVw9eghmHUTvApvpn+dpjGP0HgslEdWlHLeBzUuuhAU/3pjsAkxv
         Tp3n40pnwMlnxgoYGOa0keXQUGEGsk0mQscw8DVji+u0EjrGLRE6R7DvxrYmJf0AQfXI
         k+Z5QHIvwC5tbx6xIwBeM4rhdWO26ow9bW5oNlguzDKddaUSUNo5MnuzTir6KhnaR4Py
         k9ylAnvdPMjWABZ3tYu35unrtnvzVfWwfagpQJ2FcyW0J0CAbQRBler0x3R8AwV+ZLir
         4h4g+FGSV57aXCFQgMOYF2lLNaYJom2Ll1q1iwkFDLcuuZd6EizuR/WbN0jLBQ63uxX+
         zJKg==
X-Forwarded-Encrypted: i=1; AJvYcCX3z14L8m4uxIosGniflGj3SAmGgBO9kqBem1SjkDzawRYIqi6z81prgFYVDK3CSv5FtZ9MfClLPA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+SHi6nbPHZMFFZyXGs1gj6ckn6VjZDeLZcG5+fWjovMeT4KMh
	+DUa9Gel2UqZtS5CstZM2gJnYH12D7AE1mGxrgdqau2JQ0p0Rl3MHGBGd70YFFg=
X-Gm-Gg: ASbGncspTPYEN5NclCsNNu3tRFnUmOwk9072DHwikVsYhHa5hBKxpBulkf8AyORhsJi
	yG3jsUVrVw0w6IYXgOYY0L8taSx11ZSWuBZDX6fO8iavH5uvknR5A8IjS9InpyNGXXbcAQ9uqqc
	A3HTun8RhKfQ5vrQeg2X/PiSKIdKb+SR4SW3bQ9HrdaDgU8nW867GpRQelSKm6mlWxLIc0x03Wr
	68hzr4jvUFjEl5fHDzQqNOIYcuHafNnyn8bn0KFFGzXWh89kjfNsXlq/+oYEg==
X-Google-Smtp-Source: AGHT+IGhWRISLmROsfexY/7S1VN3olm0rXAnp4XlnaP5acP2aBFiZteVn7JIK9wCL3+4yp5Vobvaww==
X-Received: by 2002:a5d:6484:0:b0:388:da10:ea7e with SMTP id ffacd0b85a97d-38a221faea2mr45331915f8f.24.1736157366234;
        Mon, 06 Jan 2025 01:56:06 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43661219a08sm568953115e9.25.2025.01.06.01.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 01:56:05 -0800 (PST)
Date: Mon, 6 Jan 2025 12:56:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Peter Geis <pgwipeout@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	Peter Geis <pgwipeout@gmail.com>, Caesar Wang <wxt@rock-chips.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Finley Xiao <finley.xiao@rock-chips.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Kevin Hilman <khilman@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 1/6] pmdomain: rockchip: fix rockchip_pd_power error
 handling
Message-ID: <e3a5c27e-cab1-409d-b118-7dc96962db36@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210013010.81257-2-pgwipeout@gmail.com>

Hi Peter,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Peter-Geis/pmdomain-rockchip-fix-rockchip_pd_power-error-handling/20241210-093424
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
patch link:    https://lore.kernel.org/r/20241210013010.81257-2-pgwipeout%40gmail.com
patch subject: [PATCH 1/6] pmdomain: rockchip: fix rockchip_pd_power error handling
config: powerpc-randconfig-r072-20241223 (https://download.01.org/0day-ci/archive/20241224/202412240015.MfjYhpNz-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202412240015.MfjYhpNz-lkp@intel.com/

smatch warnings:
drivers/pmdomain/rockchip/pm-domains.c:614 rockchip_pd_power() warn: inconsistent returns '&pmu->mutex'.

vim +614 drivers/pmdomain/rockchip/pm-domains.c

7c696693a4f54d drivers/soc/rockchip/pm_domains.c      Caesar Wang     2015-09-08  572  static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
7c696693a4f54d drivers/soc/rockchip/pm_domains.c      Caesar Wang     2015-09-08  573  {
d909072d0521a8 drivers/soc/rockchip/pm_domains.c      Jeffy Chen      2018-02-28  574  	struct rockchip_pmu *pmu = pd->pmu;
d909072d0521a8 drivers/soc/rockchip/pm_domains.c      Jeffy Chen      2018-02-28  575  	int ret;
7c696693a4f54d drivers/soc/rockchip/pm_domains.c      Caesar Wang     2015-09-08  576  
d909072d0521a8 drivers/soc/rockchip/pm_domains.c      Jeffy Chen      2018-02-28  577  	mutex_lock(&pmu->mutex);
7c696693a4f54d drivers/soc/rockchip/pm_domains.c      Caesar Wang     2015-09-08  578  
7c696693a4f54d drivers/soc/rockchip/pm_domains.c      Caesar Wang     2015-09-08  579  	if (rockchip_pmu_domain_is_on(pd) != power_on) {
d909072d0521a8 drivers/soc/rockchip/pm_domains.c      Jeffy Chen      2018-02-28  580  		ret = clk_bulk_enable(pd->num_clks, pd->clks);
d909072d0521a8 drivers/soc/rockchip/pm_domains.c      Jeffy Chen      2018-02-28  581  		if (ret < 0) {
d909072d0521a8 drivers/soc/rockchip/pm_domains.c      Jeffy Chen      2018-02-28  582  			dev_err(pmu->dev, "failed to enable clocks\n");
d909072d0521a8 drivers/soc/rockchip/pm_domains.c      Jeffy Chen      2018-02-28  583  			mutex_unlock(&pmu->mutex);
d909072d0521a8 drivers/soc/rockchip/pm_domains.c      Jeffy Chen      2018-02-28  584  			return ret;
d909072d0521a8 drivers/soc/rockchip/pm_domains.c      Jeffy Chen      2018-02-28  585  		}
7c696693a4f54d drivers/soc/rockchip/pm_domains.c      Caesar Wang     2015-09-08  586  
8b579881de295d drivers/pmdomain/rockchip/pm-domains.c Detlev Casanova 2024-08-29  587  		rockchip_pmu_ungate_clk(pd, true);
8b579881de295d drivers/pmdomain/rockchip/pm-domains.c Detlev Casanova 2024-08-29  588  
7c696693a4f54d drivers/soc/rockchip/pm_domains.c      Caesar Wang     2015-09-08  589  		if (!power_on) {
074c6a422d86ff drivers/soc/rockchip/pm_domains.c      Elaine Zhang    2016-04-14  590  			rockchip_pmu_save_qos(pd);
7c696693a4f54d drivers/soc/rockchip/pm_domains.c      Caesar Wang     2015-09-08  591  
7c696693a4f54d drivers/soc/rockchip/pm_domains.c      Caesar Wang     2015-09-08  592  			/* if powering down, idle request to NIU first */
a15817772c0ae6 drivers/pmdomain/rockchip/pm-domains.c Peter Geis      2024-12-10  593  			ret = rockchip_pmu_set_idle_request(pd, true);
a15817772c0ae6 drivers/pmdomain/rockchip/pm-domains.c Peter Geis      2024-12-10  594  			if (ret < 0)
a15817772c0ae6 drivers/pmdomain/rockchip/pm-domains.c Peter Geis      2024-12-10  595  				return ret;

mutex_unlock(&pmu->mutex);

7c696693a4f54d drivers/soc/rockchip/pm_domains.c      Caesar Wang     2015-09-08  596  		}
7c696693a4f54d drivers/soc/rockchip/pm_domains.c      Caesar Wang     2015-09-08  597  
7c696693a4f54d drivers/soc/rockchip/pm_domains.c      Caesar Wang     2015-09-08  598  		rockchip_do_pmu_set_power_domain(pd, power_on);
7c696693a4f54d drivers/soc/rockchip/pm_domains.c      Caesar Wang     2015-09-08  599  
7c696693a4f54d drivers/soc/rockchip/pm_domains.c      Caesar Wang     2015-09-08  600  		if (power_on) {
7c696693a4f54d drivers/soc/rockchip/pm_domains.c      Caesar Wang     2015-09-08  601  			/* if powering up, leave idle mode */
a15817772c0ae6 drivers/pmdomain/rockchip/pm-domains.c Peter Geis      2024-12-10  602  			ret = rockchip_pmu_set_idle_request(pd, false);
a15817772c0ae6 drivers/pmdomain/rockchip/pm-domains.c Peter Geis      2024-12-10  603  			if (ret < 0)
a15817772c0ae6 drivers/pmdomain/rockchip/pm-domains.c Peter Geis      2024-12-10  604  				return ret;

mutex_unlock(&pmu->mutex);

7c696693a4f54d drivers/soc/rockchip/pm_domains.c      Caesar Wang     2015-09-08  605  
074c6a422d86ff drivers/soc/rockchip/pm_domains.c      Elaine Zhang    2016-04-14  606  			rockchip_pmu_restore_qos(pd);
7c696693a4f54d drivers/soc/rockchip/pm_domains.c      Caesar Wang     2015-09-08  607  		}
7c696693a4f54d drivers/soc/rockchip/pm_domains.c      Caesar Wang     2015-09-08  608  
8b579881de295d drivers/pmdomain/rockchip/pm-domains.c Detlev Casanova 2024-08-29  609  		rockchip_pmu_ungate_clk(pd, false);
d909072d0521a8 drivers/soc/rockchip/pm_domains.c      Jeffy Chen      2018-02-28  610  		clk_bulk_disable(pd->num_clks, pd->clks);
7c696693a4f54d drivers/soc/rockchip/pm_domains.c      Caesar Wang     2015-09-08  611  	}
7c696693a4f54d drivers/soc/rockchip/pm_domains.c      Caesar Wang     2015-09-08  612  
d909072d0521a8 drivers/soc/rockchip/pm_domains.c      Jeffy Chen      2018-02-28  613  	mutex_unlock(&pmu->mutex);
7c696693a4f54d drivers/soc/rockchip/pm_domains.c      Caesar Wang     2015-09-08 @614  	return 0;
7c696693a4f54d drivers/soc/rockchip/pm_domains.c      Caesar Wang     2015-09-08  615  }
7c696693a4f54d drivers/soc/rockchip/pm_domains.c      Caesar Wang     2015-09-08  616  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


