Return-Path: <linux-pm+bounces-41767-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOc+I3N0fGmAMwIAu9opvQ
	(envelope-from <linux-pm+bounces-41767-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 10:05:55 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B3CB8B58
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 10:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E81ED3012CB4
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 09:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525A034BA3A;
	Fri, 30 Jan 2026 09:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JZzAkn18"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD712D9EEF;
	Fri, 30 Jan 2026 09:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769763950; cv=none; b=VB7mKv9FyUPp5bhET5CL4qGGZ0Dm7/3jDAWTWLQVPjfJ2tKSmMJtA13P6R5zckS5Rit03WCbvAv5WAl/u6xhgegmEV64YOSPLJACjN+g3OPtM37T6VZ9eyq2PH0o9whFUNbgrfEwwZ1Lt9Rrw3jUROZK6V7IfvaZdeAIegIS5VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769763950; c=relaxed/simple;
	bh=dtsMVpWsRq542qay1TUukXpTY8xACpf3TP/mKsjjC2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ene3NtQg2m1CJQ9wuOxtgQby6/rLel5oUT5yKN9IOWhMBkWFQzinLkaSDln5CWwx659YvITWAl1rIGksSx2pm2tqQpbOFkQLNjXakSUG6ZTk3H9GciKF5KfIa7Y/IZmmY5Wss9T+QHQjFyIcmjfNppE1voLRqmUMq99hYOhc2M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JZzAkn18; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769763949; x=1801299949;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dtsMVpWsRq542qay1TUukXpTY8xACpf3TP/mKsjjC2c=;
  b=JZzAkn18L3VZy01hBZZEC6VU3HTp/97iqTVsq8i59lKvpF/IKoMBxz6r
   3930hJwK4QYQegSmHJLDmXdE0hAwQV35LzIFWK38rgegF0IYMvSfUkyZJ
   QbsUQEVWk18D1uMV2vqz9G0zSZQ845AZKafWK3dHLTgaLcUcFOBV0HVop
   XFtmXnWlMhz80YmY8rr72y055dsTob1sUeuAbq4yyJzGyqqs4cG3eCJSZ
   oa0r2lIy+s8zSgd7/L8+7xZ+cUUasOz0ChoKw7jjhZehELD672kyu6J1v
   htzFFg7o2VEJAvpM5YLelu4E81xuq3Joblqtpwlms081QaA99X6nqBdAI
   Q==;
X-CSE-ConnectionGUID: g9wl5Ee3TpCj3fedh5AIQA==
X-CSE-MsgGUID: YQt9+7KBSDaGjiQ+kKV59Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="70924156"
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="70924156"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 01:05:49 -0800
X-CSE-ConnectionGUID: 7d0iVYCgS5ObQ74/XIyVXw==
X-CSE-MsgGUID: LLGVLAV/RB+K14r2/yDkOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="231730996"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 30 Jan 2026 01:05:44 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vlkRh-00000000cQ0-3v84;
	Fri, 30 Jan 2026 09:05:41 +0000
Date: Fri, 30 Jan 2026 17:05:19 +0800
From: kernel test robot <lkp@intel.com>
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>, andersson@kernel.org,
	mathieu.poirier@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com,
	konradybcio@kernel.org, mani@kernel.org, casey.connolly@linaro.org,
	amit.kucheria@oss.qualcomm.com
Cc: oe-kbuild-all@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, gaurav.kohli@oss.qualcomm.com,
	manaf.pallikunhi@oss.qualcomm.com
Subject: Re: [PATCH v2 4/8] thermal: qcom: add qmi-cooling driver
Message-ID: <202601301640.GVrYk2iB-lkp@intel.com>
References: <20260127155722.2797783-5-gaurav.kohli@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127155722.2797783-5-gaurav.kohli@oss.qualcomm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41767-lists,linux-pm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,01.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,git-scm.com:url]
X-Rspamd-Queue-Id: 00B3CB8B58
X-Rspamd-Action: no action

Hi Gaurav,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20260126]
[also build test WARNING on v6.19-rc7]
[cannot apply to robh/for-next rafael-pm/thermal remoteproc/rproc-next linus/master v6.19-rc7 v6.19-rc6 v6.19-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gaurav-Kohli/thermal-Add-Remote-Proc-cooling-driver/20260128-000753
base:   next-20260126
patch link:    https://lore.kernel.org/r/20260127155722.2797783-5-gaurav.kohli%40oss.qualcomm.com
patch subject: [PATCH v2 4/8] thermal: qcom: add qmi-cooling driver
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20260130/202601301640.GVrYk2iB-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260130/202601301640.GVrYk2iB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601301640.GVrYk2iB-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/soc/qcom/qmi-cooling.c: In function 'qmi_tmd_alloc_cdevs':
>> drivers/soc/qcom/qmi-cooling.c:377:29: warning: unused variable 'subnode' [-Wunused-variable]
     377 |         struct device_node *subnode;
         |                             ^~~~~~~
   In file included from drivers/soc/qcom/qmi-cooling.c:24:
   drivers/soc/qcom/qmi-cooling.h: At top level:
>> drivers/soc/qcom/qmi-cooling.h:402:35: warning: 'tmd_mitigation_level_report_ind_msg_v01_ei' defined but not used [-Wunused-const-variable=]
     402 | static const struct qmi_elem_info tmd_mitigation_level_report_ind_msg_v01_ei[] = {
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/soc/qcom/qmi-cooling.h:377:9: warning: 'tmd_deregister_notification_mitigation_level_resp_msg_v01_ei' defined but not used [-Wunused-const-variable=]
     377 |         tmd_deregister_notification_mitigation_level_resp_msg_v01_ei[] = {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/soc/qcom/qmi-cooling.h:352:9: warning: 'tmd_deregister_notification_mitigation_level_req_msg_v01_ei' defined but not used [-Wunused-const-variable=]
     352 |         tmd_deregister_notification_mitigation_level_req_msg_v01_ei[] = {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/soc/qcom/qmi-cooling.h:327:9: warning: 'tmd_register_notification_mitigation_level_resp_msg_v01_ei' defined but not used [-Wunused-const-variable=]
     327 |         tmd_register_notification_mitigation_level_resp_msg_v01_ei[] = {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/soc/qcom/qmi-cooling.h:302:9: warning: 'tmd_register_notification_mitigation_level_req_msg_v01_ei' defined but not used [-Wunused-const-variable=]
     302 |         tmd_register_notification_mitigation_level_req_msg_v01_ei[] = {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/soc/qcom/qmi-cooling.h:243:35: warning: 'tmd_get_mitigation_level_resp_msg_ei' defined but not used [-Wunused-const-variable=]
     243 | static const struct qmi_elem_info tmd_get_mitigation_level_resp_msg_ei[] = {
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/soc/qcom/qmi-cooling.h:216:35: warning: 'tmd_get_mitigation_level_req_msg_v01_ei' defined but not used [-Wunused-const-variable=]
     216 | static const struct qmi_elem_info tmd_get_mitigation_level_req_msg_v01_ei[] = {
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
>> Warning: drivers/soc/qcom/qmi-cooling.c:72 struct member 'node' not described in 'qmi_tmd'
>> Warning: drivers/soc/qcom/qmi-cooling.c:82 expecting prototype for struct qmi_instance_id. Prototype was for struct qmi_instance_data instead
--
>> Warning: drivers/soc/qcom/qmi-cooling.c:72 struct member 'node' not described in 'qmi_tmd'


vim +/subnode +377 drivers/soc/qcom/qmi-cooling.c

   371	
   372	/* Parse the controls and allocate a qmi_tmd for each of them */
   373	static int qmi_tmd_alloc_cdevs(struct qmi_tmd_client *client)
   374	{
   375		struct device *dev = client->dev;
   376		struct device_node *node = dev->of_node;
 > 377		struct device_node *subnode;
   378		struct qmi_tmd *tmd;
   379		int ret;
   380	
   381		for_each_available_child_of_node_scoped(node, subnode) {
   382			const char *name;
   383	
   384			tmd = devm_kzalloc(dev, sizeof(*tmd), GFP_KERNEL);
   385			if (!tmd)
   386				return dev_err_probe(client->dev, -ENOMEM,
   387						     "Couldn't allocate tmd\n");
   388	
   389			tmd->type = devm_kasprintf(client->dev, GFP_KERNEL, "%s",
   390						   subnode->name);
   391			if (!tmd->type)
   392				return dev_err_probe(dev, -ENOMEM,
   393						     "Couldn't allocate cooling device name\n");
   394	
   395			if (of_property_read_string(subnode, "label", &name))
   396				return dev_err_probe(client->dev, -EINVAL,
   397						     "Failed to parse dev name for %s\n",
   398						     subnode->name);
   399	
   400			ret = strscpy(tmd->qmi_name, name,
   401				      QMI_TMD_MITIGATION_DEV_ID_LENGTH_MAX_V01 + 1);
   402			if (ret == -E2BIG)
   403				return dev_err_probe(dev, -EINVAL, "TMD label %s is too long\n",
   404						     name);
   405	
   406			tmd->client = client;
   407			tmd->np = subnode;
   408			tmd->cur_state = 0;
   409			list_add(&tmd->node, &client->cdev_list);
   410		}
   411	
   412		if (list_empty(&client->cdev_list))
   413			return dev_err_probe(client->dev, -EINVAL,
   414					     "No cooling devices specified for client %s (%#x)\n",
   415					     client->name, client->id);
   416	
   417		return 0;
   418	}
   419	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

