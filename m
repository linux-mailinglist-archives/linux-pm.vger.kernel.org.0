Return-Path: <linux-pm+bounces-37444-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D25AFC3519F
	for <lists+linux-pm@lfdr.de>; Wed, 05 Nov 2025 11:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7711A422A4A
	for <lists+linux-pm@lfdr.de>; Wed,  5 Nov 2025 10:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B093019C7;
	Wed,  5 Nov 2025 10:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V4Zqe5D+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A622301499;
	Wed,  5 Nov 2025 10:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762338502; cv=none; b=UHJBATzNcvdCWKWOz2cALy6J6VYyvMExgT/FvoUNfXs74f7mg+cFqpbi6t9uQSAN4mXxxTuI6xK6AysIjzuLsKwLdepDcKkgWBEP1JOg7Avt6GRRAIwJSBJO8ibFCRgEvoGDNWNVx9bXvP3lt1gm3vm11mC0OV3P3+r+BNgwIU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762338502; c=relaxed/simple;
	bh=0dC/tq4T8kP3e6opULtJbVCCkN9WsCU1dzEs1R7MZK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBEIn/xmbGBjqPf+tiPWXMl2PfHq4fX2gQ3He3aVFmObKaivE1MjXk8eA61J0tmtx8nm8DS04lZne9axDNA/P2OUDdZkEwNsZVDNBJvChi51zAjd3SYXkba46Yq0auV0U/kUWyeaCkNDYyFoRx4rhcMbdthwQpzn2bkvhsW7DUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V4Zqe5D+; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762338501; x=1793874501;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0dC/tq4T8kP3e6opULtJbVCCkN9WsCU1dzEs1R7MZK8=;
  b=V4Zqe5D+rKG+tU9x95hLyXpkGJQPXtuGxuPc6lhUMIR7orsYTdZJsEKv
   wGIboRJgZUP7fRvlh8cg8VFjczgaFO0GPMgu7nfxaguYzDpaEk6nGfwtf
   2kmUyfOSAcXQR8zqMqD3zoJM/rsGcf8KhepmzDAp2miQt7gCZjWpCUny5
   rqWE3ROVmo3iZQy+/WFvkEZCIDF2kilj4Ax+Crj/g8uHXQWuJNkCILnOC
   78wjNxyYd80949aPke3zSjNFa64osz8L38nGznN+nnFFioVLO69XEWGUT
   O5KbELuXewhMKm3qFqV6IDbFhHzn8fXvKu3Y8Q/ftczXpydkT2Oxugmzj
   Q==;
X-CSE-ConnectionGUID: 7RXnpzmlSWqeAMbz/6LzmA==
X-CSE-MsgGUID: hHVy7vbBRceraNnJ9zs5Mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="75054761"
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="75054761"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 02:28:20 -0800
X-CSE-ConnectionGUID: 0Omi8tPFS5yDYGVaZI1G/g==
X-CSE-MsgGUID: 6rs9uVHeThW4gtsKSXkn6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="191708597"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 05 Nov 2025 02:28:17 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vGakM-000SQO-1w;
	Wed, 05 Nov 2025 10:28:11 +0000
Date: Wed, 5 Nov 2025 18:27:02 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Ilia Lin <ilia.lin@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Christian Marangi <ansuelsmth@gmail.com>,
	Dmitry Baryshkov <lumag@kernel.org>
Subject: Re: [PATCH v3 1/1] cpufreq: qcom-nvmem: add compatible fallback for
 ipq806x for no SMEM
Message-ID: <202511051843.DLYBg5h3-lkp@intel.com>
References: <20251104140635.25965-2-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104140635.25965-2-ansuelsmth@gmail.com>

Hi Christian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge linus/master v6.18-rc4 next-20251105]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/cpufreq-qcom-nvmem-add-compatible-fallback-for-ipq806x-for-no-SMEM/20251104-221546
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20251104140635.25965-2-ansuelsmth%40gmail.com
patch subject: [PATCH v3 1/1] cpufreq: qcom-nvmem: add compatible fallback for ipq806x for no SMEM
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20251105/202511051843.DLYBg5h3-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251105/202511051843.DLYBg5h3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511051843.DLYBg5h3-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/cpufreq/qcom-cpufreq-nvmem.c: In function 'qcom_cpufreq_ipq8064_name_version':
>> drivers/cpufreq/qcom-cpufreq-nvmem.c:310:26: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     310 |                 msm_id = (int)match->data;
         |                          ^


vim +310 drivers/cpufreq/qcom-cpufreq-nvmem.c

   267	
   268	static int qcom_cpufreq_ipq8064_name_version(struct device *cpu_dev,
   269						     struct nvmem_cell *speedbin_nvmem,
   270						     char **pvs_name,
   271						     struct qcom_cpufreq_drv *drv)
   272	{
   273		int msm_id = -1, ret = 0;
   274		int speed = 0, pvs = 0;
   275		u8 *speedbin;
   276		size_t len;
   277	
   278		speedbin = nvmem_cell_read(speedbin_nvmem, &len);
   279		if (IS_ERR(speedbin))
   280			return PTR_ERR(speedbin);
   281	
   282		if (len != 4) {
   283			dev_err(cpu_dev, "Unable to read nvmem data. Defaulting to 0!\n");
   284			ret = -ENODEV;
   285			goto exit;
   286		}
   287	
   288		get_krait_bin_format_a(cpu_dev, &speed, &pvs, speedbin);
   289	
   290		ret = qcom_smem_get_soc_id(&msm_id);
   291		if (ret == -ENODEV) {
   292			const struct of_device_id *match;
   293			struct device_node *root;
   294	
   295			root = of_find_node_by_path("/");
   296			if (!root) {
   297				ret = -ENODEV;
   298				goto exit;
   299			}
   300	
   301			/* Fallback to compatible match with no SMEM initialized */
   302			match = of_match_node(qcom_cpufreq_ipq806x_match_list, root);
   303			of_node_put(root);
   304			if (!match) {
   305				ret = -ENODEV;
   306				goto exit;
   307			}
   308	
   309			/* We found a matching device, get the msm_id from the data entry */
 > 310			msm_id = (int)match->data;
   311			ret = 0;
   312		} else if (ret) {
   313			goto exit;
   314		}
   315	
   316		switch (msm_id) {
   317		case QCOM_ID_IPQ8062:
   318			drv->versions = BIT(IPQ8062_VERSION);
   319			break;
   320		case QCOM_ID_IPQ8064:
   321		case QCOM_ID_IPQ8066:
   322		case QCOM_ID_IPQ8068:
   323			drv->versions = BIT(IPQ8064_VERSION);
   324			break;
   325		case QCOM_ID_IPQ8065:
   326		case QCOM_ID_IPQ8069:
   327			drv->versions = BIT(IPQ8065_VERSION);
   328			break;
   329		default:
   330			dev_err(cpu_dev,
   331				"SoC ID %u is not part of IPQ8064 family, limiting to 1.0GHz!\n",
   332				msm_id);
   333			drv->versions = BIT(IPQ8062_VERSION);
   334			break;
   335		}
   336	
   337		/* IPQ8064 speed is never fused. Only pvs values are fused. */
   338		snprintf(*pvs_name, sizeof("speed0-pvsXX"), "speed0-pvs%d", pvs);
   339	
   340	exit:
   341		kfree(speedbin);
   342		return ret;
   343	}
   344	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

