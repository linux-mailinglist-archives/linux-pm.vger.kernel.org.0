Return-Path: <linux-pm+bounces-25293-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C171A865F9
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 21:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A60FF3B8E7A
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 19:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D43A277801;
	Fri, 11 Apr 2025 19:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cHwZFwGI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372DC27703C;
	Fri, 11 Apr 2025 19:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744398775; cv=none; b=W3/K/TmvEHzpvNqgQSkU1P1r7YTb4m506RuFL+GK8WA3gQqFV7+/dHuu4oRVh7blX/OK6eammj3gqW4ufwLJp6I/uqdKvzSZ2yS0zyOe0jcNavJWVwozXNfsNUro0yvFreVNHKmzea5UBokHiK535JWyz4ASKzC4LGJe/EqOeL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744398775; c=relaxed/simple;
	bh=x5lzlhqUWayiREF1DTdz0Deyy9l2UALfFeK3fvta88s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IappZ+BYL1suPkTb12N4Jsg3uAfuSJ6fx/YGfYT8D4LYrQXVwx4dlYBj5/TLToEEH84235CoPFy9BuNvUExrmmvJmm/MisHEPXIHNNwul9nwtZkz2hHAaWsZLUjoK8jtbMewVHgC3LxWX79G2lw1nGJ5FoJdF/yzQG+A2jMXqp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cHwZFwGI; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744398773; x=1775934773;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x5lzlhqUWayiREF1DTdz0Deyy9l2UALfFeK3fvta88s=;
  b=cHwZFwGIdLH0mvwDcOfxKtCl6ry/m0Z1Up7dbR+7+go9Co9IIoVvO4yM
   Fst41BGaYaRLSsD+roUK6Lu/06UXv3nLQdpHH9p1q4g9umKmkNsygZ8ee
   3rhcdnxpRPXfEPkb8kMgZJzLh7SGfyfevhcOJOJxsWbr5W2Iq2UDArRFY
   /8aHEXNkc/aPBL61y+U40ajfrpdjTnETfYybeuwQ1J/zHhUBYyR8PpZgX
   45rBYfBRYrywpNhkOn+FOoWthAOGzk9AgKQsjLKjNUcHZMAINUH1ipZM/
   dsukBHFuTxUnFCSP9FUrf41xOy2RAXxZZMel4RZ7+j8CECQI9cFPx0U3V
   Q==;
X-CSE-ConnectionGUID: jyCcv2ySRZuRy9b95XUjyw==
X-CSE-MsgGUID: N1Il5Rt7TBiA9/rSoZkkpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="63503479"
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="63503479"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 12:12:52 -0700
X-CSE-ConnectionGUID: xDwBl6seQs627YDvRm9z8g==
X-CSE-MsgGUID: 5YBIxDutQSuWAHUYbvDAiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="129833114"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 11 Apr 2025 12:12:45 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u3Jnv-000BKY-1t;
	Fri, 11 Apr 2025 19:12:43 +0000
Date: Sat, 12 Apr 2025 03:12:24 +0800
From: kernel test robot <lkp@intel.com>
To: Praveen Talari <quic_ptalari@quicinc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, psodagud@quicinc.com, djaggi@quicinc.com,
	quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com,
	quic_arandive@quicinc.com, quic_mnaresh@quicinc.com,
	quic_shazhuss@quicinc.com
Subject: Re: [PATCH v1 7/9] serial: qcom-geni: move clock-rate logic to
 separate function
Message-ID: <202504120237.YIWM0gvQ-lkp@intel.com>
References: <20250410174010.31588-8-quic_ptalari@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410174010.31588-8-quic_ptalari@quicinc.com>

Hi Praveen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tty/tty-testing]
[also build test WARNING on tty/tty-next tty/tty-linus robh/for-next driver-core/driver-core-testing driver-core/driver-core-next driver-core/driver-core-linus usb/usb-testing usb/usb-next usb/usb-linus linus/master v6.15-rc1 next-20250411]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Praveen-Talari/opp-add-new-helper-API-dev_pm_opp_set_level/20250411-015310
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20250410174010.31588-8-quic_ptalari%40quicinc.com
patch subject: [PATCH v1 7/9] serial: qcom-geni: move clock-rate logic to separate function
config: arm-randconfig-002-20250412 (https://download.01.org/0day-ci/archive/20250412/202504120237.YIWM0gvQ-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250412/202504120237.YIWM0gvQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504120237.YIWM0gvQ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/device.h:15:0,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from arch/arm/include/asm/cpu.h:11,
                    from arch/arm/include/asm/smp_plat.h:12,
                    from arch/arm/include/asm/irq_work.h:5,
                    from include/linux/irq_work.h:64,
                    from include/linux/console.h:19,
                    from drivers/tty/serial/qcom_geni_serial.c:8:
   drivers/tty/serial/qcom_geni_serial.c: In function 'geni_serial_set_rate':
>> drivers/tty/serial/qcom_geni_serial.c:1289:4: warning: format '%u' expects argument of type 'unsigned int', but argument 3 has type 'long unsigned int' [-Wformat=]
       "Couldn't find suitable clock rate for %u\n",
       ^
   include/linux/dev_printk.h:110:16: note: in definition of macro 'dev_printk_index_wrap'
      _p_func(dev, fmt, ##__VA_ARGS__);   \
                   ^~~
   include/linux/dev_printk.h:154:49: note: in expansion of macro 'dev_fmt'
     dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
                                                    ^~~~~~~
   drivers/tty/serial/qcom_geni_serial.c:1288:3: note: in expansion of macro 'dev_err'
      dev_err(port->se.dev,
      ^~~~~~~
   drivers/tty/serial/qcom_geni_serial.c:1294:24: warning: format '%u' expects argument of type 'unsigned int', but argument 4 has type 'long unsigned int' [-Wformat=]
     dev_dbg(port->se.dev, "desired_rate = %u, clk_rate = %lu, clk_div = %u\n",
                           ^
   include/linux/dev_printk.h:139:28: note: in definition of macro 'dev_no_printk'
       _dev_printk(level, dev, fmt, ##__VA_ARGS__); \
                               ^~~
   include/linux/dev_printk.h:171:33: note: in expansion of macro 'dev_fmt'
     dev_no_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__)
                                    ^~~~~~~
   drivers/tty/serial/qcom_geni_serial.c:1294:2: note: in expansion of macro 'dev_dbg'
     dev_dbg(port->se.dev, "desired_rate = %u, clk_rate = %lu, clk_div = %u\n",
     ^~~~~~~
   drivers/tty/serial/qcom_geni_serial.c: In function 'qcom_geni_serial_pm':
   drivers/tty/serial/qcom_geni_serial.c:1666:32: warning: unused variable 'port' [-Wunused-variable]
     struct qcom_geni_serial_port *port = to_dev_port(uport);
                                   ^~~~


vim +1289 drivers/tty/serial/qcom_geni_serial.c

c4f528795d1add Karthikeyan Ramasubramanian 2018-03-14  1269  
68765ed6fdd109 Praveen Talari              2025-04-10  1270  static int geni_serial_set_rate(struct uart_port *uport, unsigned long baud)
c4f528795d1add Karthikeyan Ramasubramanian 2018-03-14  1271  {
00ce7c6e86b5d1 Bartosz Golaszewski         2022-12-29  1272  	struct qcom_geni_serial_port *port = to_dev_port(uport);
c4f528795d1add Karthikeyan Ramasubramanian 2018-03-14  1273  	unsigned long clk_rate;
7cf563b2c84624 Akash Asthana               2020-06-23  1274  	unsigned int avg_bw_core;
68765ed6fdd109 Praveen Talari              2025-04-10  1275  	unsigned int clk_div;
68765ed6fdd109 Praveen Talari              2025-04-10  1276  	u32 ver, sampling_rate;
68765ed6fdd109 Praveen Talari              2025-04-10  1277  	u32 ser_clk_cfg;
ce734600545fc7 Vivek Gautam                2019-08-01  1278  
ce734600545fc7 Vivek Gautam                2019-08-01  1279  	sampling_rate = UART_OVERSAMPLING;
ce734600545fc7 Vivek Gautam                2019-08-01  1280  	/* Sampling rate is halved for IP versions >= 2.5 */
ce734600545fc7 Vivek Gautam                2019-08-01  1281  	ver = geni_se_get_qup_hw_version(&port->se);
c9ca43d42ed8d5 Paras Sharma                2020-09-30  1282  	if (ver >= QUP_SE_VERSION_2_5)
ce734600545fc7 Vivek Gautam                2019-08-01  1283  		sampling_rate /= 2;
ce734600545fc7 Vivek Gautam                2019-08-01  1284  
c2194bc999d41e Vijaya Krishna Nivarthi     2022-05-16  1285  	clk_rate = get_clk_div_rate(port->se.clk, baud,
c2194bc999d41e Vijaya Krishna Nivarthi     2022-05-16  1286  		sampling_rate, &clk_div);
c474c775716edd Vijaya Krishna Nivarthi     2022-07-16  1287  	if (!clk_rate) {
c474c775716edd Vijaya Krishna Nivarthi     2022-07-16  1288  		dev_err(port->se.dev,
0fec518018cc5c Douglas Anderson            2022-08-02 @1289  			"Couldn't find suitable clock rate for %u\n",
c474c775716edd Vijaya Krishna Nivarthi     2022-07-16  1290  			baud * sampling_rate);
68765ed6fdd109 Praveen Talari              2025-04-10  1291  		return -EINVAL;
c474c775716edd Vijaya Krishna Nivarthi     2022-07-16  1292  	}
c474c775716edd Vijaya Krishna Nivarthi     2022-07-16  1293  
18536cc8fab81f Johan Hovold                2023-07-14  1294  	dev_dbg(port->se.dev, "desired_rate = %u, clk_rate = %lu, clk_div = %u\n",
c474c775716edd Vijaya Krishna Nivarthi     2022-07-16  1295  			baud * sampling_rate, clk_rate, clk_div);
c4f528795d1add Karthikeyan Ramasubramanian 2018-03-14  1296  
c4f528795d1add Karthikeyan Ramasubramanian 2018-03-14  1297  	uport->uartclk = clk_rate;
8ece7b754bc34f Johan Hovold                2023-07-14  1298  	port->clk_rate = clk_rate;
a5819b548af0cc Rajendra Nayak              2020-06-15  1299  	dev_pm_opp_set_rate(uport->dev, clk_rate);
c4f528795d1add Karthikeyan Ramasubramanian 2018-03-14  1300  	ser_clk_cfg = SER_CLK_EN;
c4f528795d1add Karthikeyan Ramasubramanian 2018-03-14  1301  	ser_clk_cfg |= clk_div << CLK_DIV_SHFT;
c4f528795d1add Karthikeyan Ramasubramanian 2018-03-14  1302  
7cf563b2c84624 Akash Asthana               2020-06-23  1303  	/*
7cf563b2c84624 Akash Asthana               2020-06-23  1304  	 * Bump up BW vote on CPU and CORE path as driver supports FIFO mode
7cf563b2c84624 Akash Asthana               2020-06-23  1305  	 * only.
7cf563b2c84624 Akash Asthana               2020-06-23  1306  	 */
7cf563b2c84624 Akash Asthana               2020-06-23  1307  	avg_bw_core = (baud > 115200) ? Bps_to_icc(CORE_2X_50_MHZ)
7cf563b2c84624 Akash Asthana               2020-06-23  1308  						: GENI_DEFAULT_BW;
7cf563b2c84624 Akash Asthana               2020-06-23  1309  	port->se.icc_paths[GENI_TO_CORE].avg_bw = avg_bw_core;
7cf563b2c84624 Akash Asthana               2020-06-23  1310  	port->se.icc_paths[CPU_TO_GENI].avg_bw = Bps_to_icc(baud);
7cf563b2c84624 Akash Asthana               2020-06-23  1311  	geni_icc_set_bw(&port->se);
7cf563b2c84624 Akash Asthana               2020-06-23  1312  
68765ed6fdd109 Praveen Talari              2025-04-10  1313  	writel(ser_clk_cfg, uport->membase + GENI_SER_M_CLK_CFG);
68765ed6fdd109 Praveen Talari              2025-04-10  1314  	writel(ser_clk_cfg, uport->membase + GENI_SER_S_CLK_CFG);
68765ed6fdd109 Praveen Talari              2025-04-10  1315  	return 0;
68765ed6fdd109 Praveen Talari              2025-04-10  1316  }
68765ed6fdd109 Praveen Talari              2025-04-10  1317  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

