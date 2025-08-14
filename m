Return-Path: <linux-pm+bounces-32400-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CED8B26851
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 16:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6220C566C7A
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 13:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76CB30101C;
	Thu, 14 Aug 2025 13:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nNda9r2q"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBBD3009E0;
	Thu, 14 Aug 2025 13:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755179693; cv=none; b=b1P0cRFnOtm9Ij7FTewwrlw5e/Hpx6in5Qw/F7fhRyK4gHRAqblCPDgKj9wU3zGRlxxnPpB9QDWUT6rwP8Jy5gjybeBscAcou+utG+wsUAE7uARwlh+qwri8MTxGBdKuNAn4rFdtK3FkDPEUeLrvtbkTqVZ6i2hQF7smlPU/0ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755179693; c=relaxed/simple;
	bh=UBMDjSl7ummaNgM0HnILEzprysQwd6tD6QDipGAZJQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwWjP0RQWbl5llLaXN9SyBmu1qRxT8uU3shYvw2Tff5TWA/raBL08cetglTm0pdcIA+2LzwcezXjHThD/ft0f8ZaXu5FN8YWyxuNEMcCcsjXkd4MoyOvBo/uNQHPdJX1XDjdjasBnSVAEQQq6yEQorzl5intcoW18flS+veqVU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nNda9r2q; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755179692; x=1786715692;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UBMDjSl7ummaNgM0HnILEzprysQwd6tD6QDipGAZJQI=;
  b=nNda9r2qtESaUSv7fS/JffsxEAQpU1Uy6IxwP2qaZFWWSCmVVj2Bg3jp
   eW1za50x5flsisvv4twuvCtBXS0rn9RiylfW3beScmqpeqTqpityXSC5+
   1ZRiwXowc0caFb/9SQ6R53eXP9EHMOW09BePlVzoEUL6dDnSWnL7MfciU
   vtWP8lAkKxUg31sUHpkgUrVGRysJDuX6gd+iIjjDBa0UWwRYaneWwkA+B
   n85vM8pYqUEpMysUdl984iIxVwysVplRkwaM6QQNZkKOKMD+/Kd0h3yfg
   e8ZrkAme27nW2v9VR3dGa06V4xcMtCk+XCfNKXhFI7opk1Cx0ARsWXhny
   A==;
X-CSE-ConnectionGUID: q2ySU4g8TYWaOv58JsmyLg==
X-CSE-MsgGUID: y7YzLHOcQ5Ol3ZgLjo8y/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="82929213"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="82929213"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 06:54:51 -0700
X-CSE-ConnectionGUID: 9rdFQwKYT1Cgnxd6y+D2GA==
X-CSE-MsgGUID: Aje6Omf5QDWGKVTR3HWdPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="203943615"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 14 Aug 2025 06:54:46 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1umYPW-000B0O-1H;
	Thu, 14 Aug 2025 13:54:34 +0000
Date: Thu, 14 Aug 2025 21:54:17 +0800
From: kernel test robot <lkp@intel.com>
To: Cristian Marussi <cristian.marussi@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, linux-pm@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, sudeep.holla@arm.com,
	james.quinlan@broadcom.com, f.fainelli@gmail.com,
	vincent.guittot@linaro.org, etienne.carriere@st.com,
	peng.fan@oss.nxp.com, michal.simek@amd.com, quic_sibis@quicinc.com,
	dan.carpenter@linaro.org, d-gole@ti.com, souvik.chakravarty@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: Re: [PATCH 4/8] firmware: arm_scmi: Add SCMIv4.0 Powercap basic
 support
Message-ID: <202508142109.z6QIwr0w-lkp@intel.com>
References: <20250813114609.1305571-5-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813114609.1305571-5-cristian.marussi@arm.com>

Hi Cristian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge soc/for-next trace/for-next linus/master v6.17-rc1 next-20250814]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Cristian-Marussi/firmware-arm_scmi-Add-an-optional-custom-parameter-to-fastchannel-helpers/20250813-195150
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20250813114609.1305571-5-cristian.marussi%40arm.com
patch subject: [PATCH 4/8] firmware: arm_scmi: Add SCMIv4.0 Powercap basic support
config: arm64-randconfig-r111-20250814 (https://download.01.org/0day-ci/archive/20250814/202508142109.z6QIwr0w-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.3.0
reproduce: (https://download.01.org/0day-ci/archive/20250814/202508142109.z6QIwr0w-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508142109.z6QIwr0w-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/firmware/arm_scmi/powercap.c:302:48: sparse: sparse: restricted __le32 degrades to integer
>> drivers/firmware/arm_scmi/powercap.c:353:25: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] flags @@     got restricted __le32 [usertype] attributes @@
   drivers/firmware/arm_scmi/powercap.c:353:25: sparse:     expected unsigned int [usertype] flags
   drivers/firmware/arm_scmi/powercap.c:353:25: sparse:     got restricted __le32 [usertype] attributes

vim +302 drivers/firmware/arm_scmi/powercap.c

   289	
   290	static int
   291	iter_powercap_cpls_process_response(const struct scmi_protocol_handle *ph,
   292					    const void *response,
   293					    struct scmi_iterator_state *st, void *priv)
   294	{
   295		const struct scmi_msg_resp_powercap_cpc *r = response;
   296		struct scmi_cpls_priv *p = priv;
   297		struct scmi_powercap_cpl_info *cpl;
   298	
   299		cpl = &p->cpli[st->desc_index + st->loop_idx];
   300	
   301		cpl->id = le32_to_cpu(r->desc[st->loop_idx].cpli);
 > 302		cpl->cap_config = r->desc[st->loop_idx].flags & BIT(0);
   303	
   304		cpl->min_power_cap = le32_to_cpu(r->desc[st->loop_idx].min_power_cap);
   305		cpl->max_power_cap = le32_to_cpu(r->desc[st->loop_idx].max_power_cap);
   306		cpl->power_cap_step = le32_to_cpu(r->desc[st->loop_idx].power_cap_step);
   307		if (!cpl->power_cap_step && cpl->min_power_cap != cpl->max_power_cap)
   308			return -EINVAL;
   309	
   310		cpl->min_avg_ivl = le32_to_cpu(r->desc[st->loop_idx].min_cai);
   311		cpl->max_avg_ivl = le32_to_cpu(r->desc[st->loop_idx].max_cai);
   312		cpl->avg_ivl_step = le32_to_cpu(r->desc[st->loop_idx].cai_step);
   313		if (!cpl->avg_ivl_step && cpl->min_avg_ivl != cpl->max_avg_ivl)
   314			return -EINVAL;
   315	
   316		cpl->avg_ivl_config = cpl->min_avg_ivl != cpl->max_avg_ivl;
   317	
   318		strscpy(cpl->name, r->desc[st->loop_idx].name, SCMI_SHORT_NAME_MAX_SIZE);
   319	
   320		return 0;
   321	}
   322	
   323	static int scmi_powercap_cpls_enumerate(const struct scmi_protocol_handle *ph,
   324						struct scmi_powercap_info *dom_info)
   325	{
   326		void *iter;
   327		struct scmi_iterator_ops ops = {
   328			.prepare_message = iter_powercap_cpls_prepare_message,
   329			.update_state = iter_powercap_cpls_update_state,
   330			.process_response = iter_powercap_cpls_process_response,
   331		};
   332		struct scmi_cpls_priv cpriv = {
   333			.domain_id = dom_info->id,
   334			.cpli = dom_info->cpli,
   335		};
   336	
   337		iter = ph->hops->iter_response_init(ph, &ops, dom_info->num_cpli,
   338						    POWERCAP_CPC_ATTRIBUTES,
   339						    sizeof(struct scmi_msg_powercap_cpc),
   340						    &cpriv);
   341		if (IS_ERR(iter))
   342			return PTR_ERR(iter);
   343	
   344		return ph->hops->iter_response_run(iter);
   345	}
   346	
   347	static int
   348	scmi_powercap_domain_attrs_process(const struct scmi_protocol_handle *ph,
   349					   struct powercap_info *pinfo,
   350					   struct scmi_powercap_info *dom_info, void *r)
   351	{
   352		struct scmi_msg_resp_powercap_domain_attributes *resp = r;
 > 353		u32 flags = resp->attributes;
   354		bool cap_config;
   355		int ret;
   356	
   357		cap_config = SUPPORTS_POWERCAP_CAP_CONFIGURATION(flags);
   358		if (PROTOCOL_REV_MAJOR(pinfo->version) < 0x3) {
   359			dom_info->num_cpli = 1;
   360		} else {
   361			dom_info->num_cpli = le32_get_bits(resp->attributes,
   362							   GENMASK(18, 15));
   363			if (cap_config && !dom_info->num_cpli)
   364				return -EINVAL;
   365		}
   366	
   367		dom_info->cpli = devm_kcalloc(ph->dev, dom_info->num_cpli,
   368					      sizeof(*dom_info->cpli), GFP_KERNEL);
   369		if (!dom_info->cpli)
   370			return -ENOMEM;
   371	
   372		if (pinfo->notify_cap_cmd) {
   373			if (PROTOCOL_REV_MAJOR(pinfo->version) < 0x3)
   374				dom_info->notify_powercap_cap_change =
   375					SUPPORTS_POWERCAP_CAP_CHANGE_NOTIFY(flags);
   376			else
   377				dom_info->notify_powercap_cap_change =
   378					SUPPORTS_POWERCAP_CAP_CHANGE_NOTIFY_V3(flags);
   379		}
   380	
   381		if (pinfo->notify_measurements_cmd)
   382			dom_info->notify_powercap_measurement_change =
   383				SUPPORTS_POWERCAP_MEASUREMENTS_CHANGE_NOTIFY(flags);
   384	
   385	
   386		dom_info->extended_names = SUPPORTS_EXTENDED_NAMES(flags);
   387	
   388		dom_info->async_powercap_cap_set =
   389			SUPPORTS_ASYNC_POWERCAP_CAP_SET(flags);
   390	
   391		dom_info->powercap_monitoring =
   392			SUPPORTS_POWERCAP_MONITORING(flags);
   393		dom_info->powercap_scale_mw =
   394			SUPPORTS_POWER_UNITS_MW(flags);
   395		dom_info->powercap_scale_uw =
   396			SUPPORTS_POWER_UNITS_UW(flags);
   397		dom_info->fastchannels =
   398			SUPPORTS_POWERCAP_FASTCHANNELS(flags);
   399	
   400		strscpy(dom_info->name, resp->name, SCMI_SHORT_NAME_MAX_SIZE);
   401	
   402		dom_info->sustainable_power =
   403			le32_to_cpu(resp->sustainable_power);
   404		dom_info->accuracy = le32_to_cpu(resp->accuracy);
   405	
   406		dom_info->parent_id = le32_to_cpu(resp->parent_id);
   407		if (dom_info->parent_id != SCMI_POWERCAP_ROOT_ZONE_ID &&
   408		    (dom_info->parent_id >= pinfo->num_domains ||
   409		     dom_info->parent_id == dom_info->id)) {
   410			dev_err(ph->dev,
   411				"Platform reported inconsistent parent ID for domain %d - %s\n",
   412				dom_info->id, dom_info->name);
   413			return -ENODEV;
   414		}
   415	
   416		dom_info->cpli[0].id = CPL0;
   417		if (PROTOCOL_REV_MAJOR(pinfo->version) < 0x3)
   418			dom_info->cpli[0].avg_ivl_config =
   419				SUPPORTS_POWERCAP_PAI_CONFIGURATION(flags);
   420		else
   421			dom_info->cpli[0].avg_ivl_config =
   422				SUPPORTS_POWERCAP_CAI_CONFIGURATION(flags);
   423	
   424		if (PROTOCOL_REV_MAJOR(pinfo->version) < 0x3) {
   425			dom_info->cpli[0].min_avg_ivl = le32_to_cpu(resp->min_pai);
   426			dom_info->cpli[0].max_avg_ivl = le32_to_cpu(resp->max_pai);
   427			dom_info->cpli[0].avg_ivl_step = le32_to_cpu(resp->pai_step);
   428		} else {
   429			struct scmi_msg_resp_powercap_domain_attributes_v3 *resp = r;
   430	
   431			dom_info->cpli[0].min_avg_ivl = le32_to_cpu(resp->min_cai);
   432			dom_info->cpli[0].max_avg_ivl = le32_to_cpu(resp->max_cai);
   433			dom_info->cpli[0].avg_ivl_step = le32_to_cpu(resp->cai_step);
   434		}
   435	
   436		ret = scmi_powercap_validate(dom_info->cpli[0].min_avg_ivl,
   437					     dom_info->cpli[0].max_avg_ivl,
   438					     dom_info->cpli[0].avg_ivl_step,
   439					     dom_info->cpli[0].avg_ivl_config);
   440		if (ret) {
   441			dev_err(ph->dev,
   442				"Platform reported inconsistent PAI config for domain %d - %s\n",
   443				dom_info->id, dom_info->name);
   444			return ret;
   445		}
   446	
   447		dom_info->cpli[0].cap_config = cap_config;
   448		dom_info->cpli[0].min_power_cap = le32_to_cpu(resp->min_power_cap);
   449		dom_info->cpli[0].max_power_cap = le32_to_cpu(resp->max_power_cap);
   450		dom_info->cpli[0].power_cap_step = le32_to_cpu(resp->power_cap_step);
   451		ret = scmi_powercap_validate(dom_info->cpli[0].min_power_cap,
   452					     dom_info->cpli[0].max_power_cap,
   453					     dom_info->cpli[0].power_cap_step,
   454					     dom_info->cpli[0].cap_config);
   455		if (ret) {
   456			dev_err(ph->dev,
   457				"Platform reported inconsistent CAP config for domain %d - %s\n",
   458				dom_info->id, dom_info->name);
   459			return ret;
   460		}
   461		/* Just using same short name */
   462		strscpy(dom_info->cpli[0].name, dom_info->name, SCMI_SHORT_NAME_MAX_SIZE);
   463	
   464		return 0;
   465	}
   466	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

