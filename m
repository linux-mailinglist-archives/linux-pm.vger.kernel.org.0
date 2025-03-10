Return-Path: <linux-pm+bounces-23762-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB2BA596D0
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 14:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C713B169935
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 13:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B2722A4EA;
	Mon, 10 Mar 2025 13:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nFxl9dfN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972121AA7BA
	for <linux-pm@vger.kernel.org>; Mon, 10 Mar 2025 13:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741615106; cv=fail; b=uxL1WLmHO1GTB/eBe0+z0/2S0JpiLA2rzA7h4rVl9kltemkuQnmOxZkl6xYCC7TcHQfYgcaXaOdPQ3JBFm7aBmEEaUD64ANKRMdNZUzaQRDeZgq8BS/uMvrYTFUznKFqpWW/LKSPmEUiPxCIFe6TKsHF8G7GFlM6fTeMTlXCAIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741615106; c=relaxed/simple;
	bh=ADKzVG9xxckNUmcJxqubqhFEZ0aU3jYkTipcRLDmfi4=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=JSB1ppL/QrVrowaIa19MLPdzQ+Hf+VzuboolEmPFytfknb03CvgI9oOEMI7kvRo/EG9s8Es/SnvZ/w3GvropF21l+GPKM9Evhwns/PiR/KPZDa3RaM+alM3ZJTKGjsvL5WbghNSWh7DcxuVpwNPwZnZqKXccCd7uFZgq5wi1tHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nFxl9dfN; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741615100; x=1773151100;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=ADKzVG9xxckNUmcJxqubqhFEZ0aU3jYkTipcRLDmfi4=;
  b=nFxl9dfN0r9nKjFsmBFdbV89juFSvKXp1yQ8f6T2+Ou8Fk9uNqakksek
   iO5x2oMjoLCWGHiIwK2Y//maNgqURVjuG4yadZKioy5j07WPpVYyyTj4f
   NJD/1ZXTj5cZ71WnG4XS4jcslNTLqYCziNnxq4zCznt5nqI98gjTPQ6XX
   SLPN/3UAUJIZ0pFzHF+V4WC3kcqv/oy7AANQlqLGgzmKhL6EGQGVwgZGo
   CWYOuhJoFpVETfN+e89/wBqXX6mKMUdvVM4iCb+9SiKpktwAh6z3tOeLd
   xAbWqOspTbMktWPVFBmIBsBueT6n2wHkTGkIMmlXM8krODnmtVngwzAsi
   Q==;
X-CSE-ConnectionGUID: SwlSmoJUSiCT0EQIAkMRXg==
X-CSE-MsgGUID: SKMy8MiiSLe1G/JBWDHOKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="46520351"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="46520351"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 06:58:18 -0700
X-CSE-ConnectionGUID: /FeLaP1OSkKEwOYl96RSfg==
X-CSE-MsgGUID: +nfSZ8aFS3CR2FfRoJPjoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="143194322"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 06:58:17 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Mon, 10 Mar 2025 06:58:17 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 10 Mar 2025 06:58:17 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Mar 2025 06:58:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qH39EYY4DczVTqW/HXqie4HyuuLf+NJ9EXFhl8eYWOorLeRcC/EsMth76UsVjaMaxWSpQeIT6vrYvRrDTxjoRzGC21ki4yrzllvC3X15wJYwZ5wnkvNH7cZvX3UMnCPk3rQFFiDbMsaFYW1jMDibhhGIvMozoaL3cDT5qLx8P9j6HPkw98xyw2bmQ8WQKztqZ5i5TtyWsO+ds4ayu6OVxl9bqeMOsaUFlw9E6PNs5rp3qipbRKHO7AhC4vDJvwYlvT1WJS/s+Rulm0ZsGL+GyEH5QMoOImiIxTLlzAzlFS1o8RithhDKKXm82IYH1A6w5s1pBtNJYsDwMovcHUKMEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Feh7zmuzIi4s+D3tI80/uAYwtdH1KwOPO6JcF1rg2bQ=;
 b=UbpHwTHtvAKC4BJyJtozjxG1IniWMBg+oWlYXvwfX486fvQyLcuPh0lRqDDRYpGBD/ZRq6Jr5u0fQkWO/HIh80F3ni/nGsHXzmrYXh6EhyX1eiDl0OCpTFqfBJQUah3KWRobrl1ZMaad39b/BMclk+t5rRg0x1mWJ9ZXI7Ai9ioEKPQduVdZUhMJUcxJ+2cuu98W79mu/PRtd+tb8uVpPCYDe9L/frc6gwSUzIW2af1AE39rd0EOoqfZ5PHFjhpKM7VSSboDzRGyYZUucoxQVQJKZFnT2t7xqNfPjHlYKFy86Vc1qeIG9iW9+fiWuhLZBj2TWd7nHe1inp2LYNBDSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 13:58:09 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 13:58:08 +0000
Date: Mon, 10 Mar 2025 21:57:58 +0800
From: kernel test robot <oliver.sang@intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Artem Bityutskiy
	<artem.bityutskiy@linux.intel.com>, Christian Loehle
	<christian.loehle@arm.com>, Aboorva Devarajan <aboorvad@linux.ibm.com>,
	<linux-pm@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [cpuidle]  85975daeaa:
 filebench.sum_operations/s 67.2% improvement
Message-ID: <202503102146.28d80a16-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR0401CA0011.apcprd04.prod.outlook.com
 (2603:1096:820:f::16) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB5984:EE_
X-MS-Office365-Filtering-Correlation-Id: 046e1da3-43f3-4c9e-178d-08dd5fdb9630
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?j/gF1cBPecPWzW4IclxuKhvkTKMTbsxvHDkn34EifH1hbAzWOArbeBvwck?=
 =?iso-8859-1?Q?qpQfBe1+I3Ro0hORUPO+cz+eGE0yK8fay8PMwKNaUfyH0Di2AlA1LVbMsS?=
 =?iso-8859-1?Q?fziLLJhv2NaAqrTcyLde1Z1JhSaT5BHgAUdxgVZ2B+hCM8+puLaYyHSwuD?=
 =?iso-8859-1?Q?nYdJupAL+ycoVcmL90qV9vtBnPTzPj5mNsmDaFa8CQqA4tnnS2BIhWV9Ni?=
 =?iso-8859-1?Q?7ktpqwiRduLflqcIo5QSVarKM9Sq0HuwYPpt30Q7Z36PGOpkf+uv4lWenn?=
 =?iso-8859-1?Q?I48WiuL+nJ85OiTC5ZBJomG+K2p/FZreWwWC9mIeUvNW9UlU/60L2aSlts?=
 =?iso-8859-1?Q?fWUIdqnK3VlCGLuPyN6xceNBVbsHM1qZ+Ex/yd6wDBq76W5rlBww0ivus9?=
 =?iso-8859-1?Q?Fp2AiuVh9p95eCr/xjk+HfZyHHj5Mfn4L2inQhwVYYUiDv6nwbovujHIE5?=
 =?iso-8859-1?Q?x9/DL+g+ZLsTZlwjsu6elTWA7KPd2NI0OkAZLvlJ/Eyb+J0Qpb40FVhBa1?=
 =?iso-8859-1?Q?TYFxa0O5C4M4nJkoiRAISAN0iiFEG3y0J4X8MCniQeZPpf/3t4Ur80TgYR?=
 =?iso-8859-1?Q?ayOG3vkGTnvmyggHtIwPEuEzP467oqnVSzuel97aNj77yLZrNcm+wKN0o0?=
 =?iso-8859-1?Q?2jr5U0nYUC1zGrx3QWw0x4btNomOrs23pbjoD7FSI+H3NCoH35uMtPudqZ?=
 =?iso-8859-1?Q?JzIaYwzJdQtuz7aKF6I97kh30bb0loCNQQpfjMyBeiOtIgCzaado3viWWw?=
 =?iso-8859-1?Q?kxSKU+wuXO48+GL2b3uAztaAOWf3L+dCDOFdDylvHMKn4K1FoirNAR3lHy?=
 =?iso-8859-1?Q?FzQ8IS6sH3/UrVmQzTl9Isrw7ATvZi8PQxzCljGzPXXJT6tspppKDRkyNF?=
 =?iso-8859-1?Q?CpytJxwI/ul/s0noTrst8ODFkGmxoAe4+oh+rTmrkf09aflg6uQuASJcGx?=
 =?iso-8859-1?Q?9mBf0/mTSP6it7JvMXyqCbPe3LFpZTIYxSkBM5+mAW2hlZXgDXRsidASDq?=
 =?iso-8859-1?Q?ehjD48QHqGwUk8EMRaG5Ku4rseReOsMsPz9IaLWDl2ARTlQowWv9n2RjlI?=
 =?iso-8859-1?Q?Ds42tKfu93mrmEHJZwHETdshRnv1cpBfv9Cs5V4dks8moIfIf+lqDgYTpb?=
 =?iso-8859-1?Q?EKYzQscBV5kbVQ3/uPt6U4KCLHaYBF5wpapSAGMBvGKM+EgfPfhWmDVJAX?=
 =?iso-8859-1?Q?BIXi9in4C5XdyqKoamob7po09tSgwBLDi/ddrsEn2xQm50cuSneJAhdG1f?=
 =?iso-8859-1?Q?tF4vw/wG6qqipbll5jjLsT22RczQt7QJzirMmd8Kzlhpnh0XDf7xrqnUtv?=
 =?iso-8859-1?Q?LqP+XYvEtJmlv98qlCeeVuaCX0EAme6wjvebZnZha+gTn0XCNoixkE29lB?=
 =?iso-8859-1?Q?+XU5tmHGEfegczEecVph2tRg2TYaonSA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Bc+Thx4/IAQE5eHa5NZi8HSEH7PDqFQ7rZZ0b+EyvoFCRTt9pm6fRzgkN5?=
 =?iso-8859-1?Q?PIR0+ENqXyaVWCMDYWk5V8ojiy9iTEkWN9GJuCRUIv2NQww19TR3juVhrX?=
 =?iso-8859-1?Q?8JvdsKgMG4aZfrpRw7f0Bbx75RmB1riZFmuJMVeQDVIOccQAJ1Meae9/Ib?=
 =?iso-8859-1?Q?anzgsu1X/hLbUgVtudz5aTYUlgwlpsBhDqRK5T2jH5qYuDq7cLjqdyRwBj?=
 =?iso-8859-1?Q?9Nqlw6PMBXv3C5lxvPEUoQOGrI3zQUN72Zjc18MBZ657lbBbT7DB3s+NwH?=
 =?iso-8859-1?Q?YB7sGT6UIcmAMe67RgoiHSFUdOkSVooUlb5ATV4OAunjX0ukJMhmyDDrZm?=
 =?iso-8859-1?Q?QbGaI8LGpQlwKcQyMkR5R6xzBKxFIUt99+QCdC8O2u3vFWv7voU7tMWT3M?=
 =?iso-8859-1?Q?6H941XJccOKlhQkXvQWNnUHWYjs4j7FSTUUAxhX2bfhiEXw0B8v0xmMnaa?=
 =?iso-8859-1?Q?sRV7Ahw3rc5TEPz5f3jOq5gzpVLGAmg6ehrupUd8s46LvxT0n99DpRHmUN?=
 =?iso-8859-1?Q?/BEWJ/zErrJPz+31iehVLf3zj+cg9tGCgzQEdsSmbDJiJHqaGoAY9ezH7N?=
 =?iso-8859-1?Q?whbSMHn95/VByzicznIOzzsMQND8PkAaLILdchRvp/m/oSjIere0F1/lch?=
 =?iso-8859-1?Q?B95bNfAhiOgQs6NX0ayaUuYPwmFStQC/JJl3aWEfUdwH/PYy8TZnIpNosS?=
 =?iso-8859-1?Q?LXssqnyZ1cABS7ROXl4zX6EjlQRr6wqszmJMXfdFi+Ik9GvKNpBjLRjKtj?=
 =?iso-8859-1?Q?r5cM/Ih0DnV3Esirsn/cg602e2LUlDNDoemiaX529VW6xjYkRhvonIxrC1?=
 =?iso-8859-1?Q?upl4jX40YNmfM93MaWXnqso6QoDHI/Ie9+wfTL3JUgM/C0HvEeU7Vw6O6U?=
 =?iso-8859-1?Q?KMDNXlq1xCQPpMHu9avaELZBvIRP3w50twTQwtR/ke+zb8zftj7spa19+u?=
 =?iso-8859-1?Q?2GIVMh1hTsCCTOPs1pjc5kfAqSy1NWiWM7M2si+Kgv0mf4YaRyJzbjSjQQ?=
 =?iso-8859-1?Q?6WQN/YDjkJ6B7Clm9G8eVjFMh2DrCVr0N/K+2wjepu4GlZSo7hyBcKLie8?=
 =?iso-8859-1?Q?DfBgZbx+3v2fjZHMd4kOApjgP6tQ9YY7uPGk4MJl+r/AaIMZUujwqlWWVO?=
 =?iso-8859-1?Q?CFq0Ly8hA1ps1DQRubcc/m0sT2vy0NACaAcUwDRZcYGHJcQad7KrJ19Wm7?=
 =?iso-8859-1?Q?XJ0+qefYMhoQ7DG/DuoI5psPjck9Z/H4zEDQkTAexHyCPHVMpP1YYBrvGj?=
 =?iso-8859-1?Q?GImo08NQ/MZafLtDJ+3qRlvZfv916fushk74bzodLsUsKicO9hP34Jq3XK?=
 =?iso-8859-1?Q?7VSK57jVShNLu7S6HJU/iXthRuV8/s7yS/JKjJhHh7fBYxGxr/KW3UDmyI?=
 =?iso-8859-1?Q?4HawmqU40RFNdSwHO/evfGhZkxGNypE2bMNXweZVbumEaNeb7YPim8eKys?=
 =?iso-8859-1?Q?OpJbpv2Yes3rgAVMSRV4Bm0lhGute1yoyrf04IBTYJitwA0TNMmHmpXXDn?=
 =?iso-8859-1?Q?ahe0xiu/r5tmZUnqXqgn5dneNMtHFJyzmr2zXioC8zYAikzCvzro1/by+r?=
 =?iso-8859-1?Q?DziuH6voZvqDNUU0WMPCSagwRoHUODrh2iSLaVyARne0yan8fBtUG3kc4V?=
 =?iso-8859-1?Q?y/zDaR0TcC9JbqmfOlgcCYuThC8A5lteWho1qg8BfHLjwlVCR6zurDXQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 046e1da3-43f3-4c9e-178d-08dd5fdb9630
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 13:58:08.7838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0+CJO1ed80l/X45tySOeKyObTtDN+jwUD9cMjIuDoAKzMaCObC+bD69kc/DKULtJAJ4z5iKAuo3imefqQ6VxZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5984
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 67.2% improvement of filebench.sum_operations/s on:


commit: 85975daeaa4d6ec560bfcd354fc9c08ad7f38888 ("cpuidle: menu: Avoid discarding useful information")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master


testcase: filebench
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
parameters:

	disk: 1HDD
	fs: btrfs
	fs2: cifs
	test: makedirs.f
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+------------------------------------------------------------------------------------------------+
| testcase: change | filebench: filebench.sum_operations/s 1.1% improvement                                         |
| test machine     | 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory |
| test parameters  | cpufreq_governor=performance                                                                   |
|                  | disk=1HDD                                                                                      |
|                  | fs2=cifs                                                                                       |
|                  | fs=xfs                                                                                         |
|                  | test=singlestreamwritedirect.f                                                                 |
+------------------+------------------------------------------------------------------------------------------------+
| testcase: change | fxmark: fxmark.ssd_ext4_no_jnl_DRBM_4_directio.works/sec 21.9% improvement                     |
| test machine     | 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory |
| test parameters  | cpufreq_governor=performance                                                                   |
|                  | directio=directio                                                                              |
|                  | disk=1SSD                                                                                      |
|                  | fstype=ext4_no_jnl                                                                             |
|                  | media=ssd                                                                                      |
|                  | test=DRBM                                                                                      |
|                  | thread_nr=4                                                                                    |
+------------------+------------------------------------------------------------------------------------------------+




Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250310/202503102146.28d80a16-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/fs2/fs/kconfig/rootfs/tbox_group/test/testcase:
  gcc-12/performance/1HDD/cifs/btrfs/x86_64-rhel-9.4/debian-12-x86_64-20240206.cgz/lkp-icl-2sp6/makedirs.f/filebench

commit: 
  8de7606f0f ("cpuidle: menu: Eliminate outliers on both ends of the sample set")
  85975daeaa ("cpuidle: menu: Avoid discarding useful information")

8de7606f0fe2bf5a 85975daeaa4d6ec560bfcd354fc 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     19.50 ±  6%     +36.8%      26.67 ± 18%  perf-c2c.HITM.remote
     33.03            +2.6%      33.88 ±  2%  boot-time.boot
      3722            +2.5%       3814 ±  2%  boot-time.idle
      8340            -6.0%       7838        proc-vmstat.nr_shmem
    531751 ±  2%      -3.1%     515338        proc-vmstat.pgfault
      5650            +7.2%       6057        vmstat.system.cs
      4031 ±  3%     +11.4%       4489 ±  5%  vmstat.system.in
    883.77 ±  4%     +67.2%       1478 ±  9%  filebench.sum_operations/s
     17.30 ±  3%     -41.7%      10.08 ±  8%  filebench.sum_time_ms/op
    118.36            -5.5%     111.90        filebench.time.elapsed_time
    118.36            -5.5%     111.90        filebench.time.elapsed_time.max
      0.08 ±  3%     -18.6%       0.06 ± 11%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.10 ± 27%     -92.7%       0.01 ±223%  perf-sched.sch_delay.avg.ms.usleep_range_state.cifs_readv_from_socket.cifs_read_from_socket.cifs_demultiplex_thread
      0.10 ± 27%     -92.7%       0.01 ±223%  perf-sched.sch_delay.max.ms.usleep_range_state.cifs_readv_from_socket.cifs_read_from_socket.cifs_demultiplex_thread
    994.71 ± 82%    +104.7%       2035 ± 27%  perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      2.03           -83.4%       0.34 ±223%  perf-sched.wait_time.avg.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
    994.71 ± 82%    +104.7%       2035 ± 27%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      2.03           -83.4%       0.34 ±223%  perf-sched.wait_time.max.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
   6521081 ± 36%     -42.7%    3735458 ± 26%  sched_debug.cfs_rq:/.avg_vruntime.max
   6521081 ± 36%     -42.7%    3735458 ± 26%  sched_debug.cfs_rq:/.min_vruntime.max
   1086103 ±110%    -100.0%     250.38 ±  4%  sched_debug.cfs_rq:/.runnable_avg.avg
  96446011 ± 85%    -100.0%       1277 ± 17%  sched_debug.cfs_rq:/.runnable_avg.max
   9551724 ± 90%    -100.0%     309.57 ±  5%  sched_debug.cfs_rq:/.runnable_avg.stddev
    942.00 ± 14%     +35.7%       1278 ± 17%  sched_debug.cfs_rq:/.util_avg.max
    228.25 ± 30%     +35.5%     309.24 ±  5%  sched_debug.cfs_rq:/.util_avg.stddev
 3.378e+08            +4.8%  3.539e+08        perf-stat.i.branch-instructions
      3.50 ±  3%      +0.2        3.74 ±  2%  perf-stat.i.cache-miss-rate%
  22983457 ±  2%     -21.0%   18161711        perf-stat.i.cache-references
    266.65 ±  2%      -3.9%     256.36 ±  3%  perf-stat.i.cpu-migrations
 1.684e+09            +4.4%  1.758e+09        perf-stat.i.instructions
      5.14            -0.2        4.95        perf-stat.overall.branch-miss-rate%
      4.21 ±  5%      +1.2        5.37 ±  5%  perf-stat.overall.cache-miss-rate%
      1.04            -4.8%       0.99 ±  2%  perf-stat.overall.cpi
      0.96            +5.1%       1.01 ±  2%  perf-stat.overall.ipc
 3.356e+08            +4.4%  3.505e+08        perf-stat.ps.branch-instructions
  23142109 ±  2%     -22.3%   17992823        perf-stat.ps.cache-references
    268.25            -5.6%     253.17 ±  3%  perf-stat.ps.cpu-migrations
 1.673e+09 ±  2%      +4.1%  1.742e+09        perf-stat.ps.instructions
     47.47           -20.7       26.76 ±  8%  perf-profile.calltrace.cycles-pp.common_startup_64
     42.13 ±  3%     -18.5       23.67 ±  8%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
     42.13 ±  3%     -18.4       23.69 ±  8%  perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
     42.06 ±  3%     -18.4       23.65 ±  8%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     36.65 ±  4%     -17.6       19.00 ±  9%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     32.40 ±  3%     -15.2       17.17 ± 10%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     32.43 ±  4%     -14.5       17.94 ± 10%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     14.06 ±  5%     -10.6        3.45 ± 36%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     12.38 ±  5%      -9.2        3.22 ± 38%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      8.31 ±  6%      -5.8        2.55 ± 34%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
      8.26 ±  6%      -5.7        2.54 ± 35%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.18 ± 10%      -4.8        1.41 ± 47%  perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      6.18 ± 10%      -4.8        1.41 ± 47%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      6.18 ± 10%      -4.8        1.41 ± 47%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.execve
      6.18 ± 10%      -4.8        1.41 ± 47%  perf-profile.calltrace.cycles-pp.execve
      6.13 ±  9%      -4.7        1.38 ± 46%  perf-profile.calltrace.cycles-pp.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      5.18 ±  7%      -4.3        0.88 ± 37%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      5.77 ±  9%      -4.3        1.50 ± 42%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      5.67 ±  9%      -4.2        1.48 ± 42%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
     10.06 ± 12%      -4.1        5.91 ± 11%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
     10.06 ± 12%      -4.1        5.91 ± 11%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
     10.06 ± 12%      -4.1        5.91 ± 11%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
     15.90 ±  8%      -3.7       12.18 ±  4%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      4.58 ± 11%      -3.5        1.03 ± 39%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      4.66 ± 11%      -3.5        1.18 ± 44%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      4.23 ±  8%      -3.2        0.98 ± 37%  perf-profile.calltrace.cycles-pp.read
      4.08 ± 11%      -3.2        0.90 ± 42%  perf-profile.calltrace.cycles-pp.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.26 ± 14%      -3.1        1.12 ± 32%  perf-profile.calltrace.cycles-pp.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      4.02 ±  7%      -3.1        0.93 ± 35%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
      4.00 ±  7%      -3.1        0.93 ± 35%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      4.05 ± 15%      -3.0        1.07 ± 32%  perf-profile.calltrace.cycles-pp.handle_softirqs.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      3.97 ± 11%      -3.0        1.02 ± 33%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault
      3.44 ± 14%      -2.9        0.56 ± 80%  perf-profile.calltrace.cycles-pp.__schedule.schedule.smpboot_thread_fn.kthread.ret_from_fork
      3.44 ± 14%      -2.9        0.57 ± 80%  perf-profile.calltrace.cycles-pp.schedule.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      3.72 ±  9%      -2.8        0.90 ± 37%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      3.63 ± 15%      -2.8        0.81 ± 46%  perf-profile.calltrace.cycles-pp.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64
      3.61 ± 16%      -2.8        0.80 ± 46%  perf-profile.calltrace.cycles-pp.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve
      3.52 ±  7%      -2.8        0.74 ± 68%  perf-profile.calltrace.cycles-pp.evlist_cpu_iterator__next.read_counters.process_interval.dispatch_events.cmd_stat
      3.71 ± 15%      -2.8        0.94 ± 41%  perf-profile.calltrace.cycles-pp.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      3.31 ± 14%      -2.8        0.54 ± 81%  perf-profile.calltrace.cycles-pp.__pick_next_task.__schedule.schedule.smpboot_thread_fn.kthread
      3.50 ± 15%      -2.7        0.79 ± 47%  perf-profile.calltrace.cycles-pp.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common
      3.50 ± 11%      -2.7        0.81 ± 54%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
      3.48 ± 11%      -2.7        0.80 ± 54%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      3.24 ± 13%      -2.5        0.73 ± 55%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      3.03 ±  7%      -2.5        0.53 ± 87%  perf-profile.calltrace.cycles-pp.sched_setaffinity.evlist_cpu_iterator__next.read_counters.process_interval.dispatch_events
      2.93 ± 14%      -2.4        0.48 ± 80%  perf-profile.calltrace.cycles-pp.balance_fair.__pick_next_task.__schedule.schedule.smpboot_thread_fn
      2.92 ± 14%      -2.4        0.48 ± 80%  perf-profile.calltrace.cycles-pp.sched_balance_newidle.balance_fair.__pick_next_task.__schedule.schedule
      2.93 ±  6%      -2.4        0.51 ± 86%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.sched_setaffinity.evlist_cpu_iterator__next.read_counters
      2.93 ±  6%      -2.4        0.51 ± 86%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.sched_setaffinity.evlist_cpu_iterator__next.read_counters.process_interval
      4.12 ± 16%      -2.4        1.76 ± 30%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      3.01 ± 13%      -2.3        0.69 ± 56%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      5.34 ± 23%      -2.3        3.07 ± 24%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.rest_init.start_kernel.x86_64_start_reservations.x86_64_start_kernel
      5.34 ± 23%      -2.3        3.07 ± 24%  perf-profile.calltrace.cycles-pp.rest_init.start_kernel.x86_64_start_reservations.x86_64_start_kernel.common_startup_64
      5.34 ± 23%      -2.3        3.07 ± 24%  perf-profile.calltrace.cycles-pp.start_kernel.x86_64_start_reservations.x86_64_start_kernel.common_startup_64
      5.34 ± 23%      -2.3        3.07 ± 24%  perf-profile.calltrace.cycles-pp.x86_64_start_kernel.common_startup_64
      5.34 ± 23%      -2.3        3.07 ± 24%  perf-profile.calltrace.cycles-pp.x86_64_start_reservations.x86_64_start_kernel.common_startup_64
      5.33 ± 23%      -2.3        3.07 ± 24%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.rest_init.start_kernel.x86_64_start_reservations
      2.60 ±  5%      -2.2        0.37 ±108%  perf-profile.calltrace.cycles-pp.__x64_sys_sched_setaffinity.do_syscall_64.entry_SYSCALL_64_after_hwframe.sched_setaffinity.evlist_cpu_iterator__next
      3.62 ± 29%      -2.2        1.46 ±  8%  perf-profile.calltrace.cycles-pp.do_softirq.flush_smp_call_function_queue.do_idle.cpu_startup_entry.rest_init
      3.68 ± 28%      -2.1        1.59 ±  7%  perf-profile.calltrace.cycles-pp.flush_smp_call_function_queue.do_idle.cpu_startup_entry.rest_init.start_kernel
      2.43 ±  5%      -2.1        0.35 ±110%  perf-profile.calltrace.cycles-pp.sched_setaffinity.__x64_sys_sched_setaffinity.do_syscall_64.entry_SYSCALL_64_after_hwframe.sched_setaffinity
      2.74 ± 11%      -2.1        0.67 ± 62%  perf-profile.calltrace.cycles-pp.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.58 ± 13%      -2.0        0.56 ± 83%  perf-profile.calltrace.cycles-pp.update_process_times.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      2.65 ± 13%      -2.0        0.65 ± 62%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call.do_syscall_64
      2.65 ± 13%      -2.0        0.65 ± 62%  perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.65 ± 13%      -2.0        0.65 ± 61%  perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.61 ± 21%      -2.0        1.64 ± 31%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      3.61 ± 29%      -2.0        1.65 ± 12%  perf-profile.calltrace.cycles-pp.handle_softirqs.do_softirq.flush_smp_call_function_queue.do_idle.cpu_startup_entry
      3.59 ± 29%      -2.0        1.64 ± 11%  perf-profile.calltrace.cycles-pp._nohz_idle_balance.handle_softirqs.do_softirq.flush_smp_call_function_queue.do_idle
      2.50 ± 17%      -1.3        1.16 ±  8%  perf-profile.calltrace.cycles-pp.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      2.44 ± 19%      -1.2        1.20 ± 23%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
      2.45 ± 19%      -1.2        1.23 ± 25%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.58 ± 23%      -0.8        0.78 ± 17%  perf-profile.calltrace.cycles-pp.sched_balance_domains._nohz_idle_balance.handle_softirqs.do_softirq.flush_smp_call_function_queue
      1.47 ± 26%      -0.8        0.71 ± 20%  perf-profile.calltrace.cycles-pp.sched_balance_rq.sched_balance_domains._nohz_idle_balance.handle_softirqs.do_softirq
      0.63 ± 49%      +0.6        1.18 ± 13%  perf-profile.calltrace.cycles-pp.enqueue_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue
      0.00            +0.6        0.57 ±  6%  perf-profile.calltrace.cycles-pp.tcp_sock_set_cork.__smb_send_rqst.smb_send_rqst.compound_send_recv.smb2_query_dir_first
      0.65 ± 48%      +0.6        1.24 ± 13%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle
      0.49 ± 71%      +0.6        1.08 ± 13%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.enqueue_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue
      0.00            +0.6        0.63 ± 10%  perf-profile.calltrace.cycles-pp.malloc
      0.00            +0.6        0.65 ± 12%  perf-profile.calltrace.cycles-pp.__btrfs_update_delayed_inode.btrfs_commit_inode_delayed_inode.btrfs_evict_inode.evict.__dentry_kill
      0.00            +0.8        0.75 ± 12%  perf-profile.calltrace.cycles-pp.btrfs_commit_inode_delayed_inode.btrfs_evict_inode.evict.__dentry_kill.dput
      0.00            +0.8        0.79 ± 17%  perf-profile.calltrace.cycles-pp.__smb_send_rqst.smb_send_rqst.compound_send_recv.cifs_send_recv.SMB2_query_directory
      0.00            +0.8        0.79 ± 17%  perf-profile.calltrace.cycles-pp.smb_send_rqst.compound_send_recv.cifs_send_recv.SMB2_query_directory.find_cifs_entry
      0.73 ± 49%      +0.8        1.54 ± 13%  perf-profile.calltrace.cycles-pp.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry
      0.00            +0.8        0.81 ±  5%  perf-profile.calltrace.cycles-pp.__smb_send_rqst.smb_send_rqst.compound_send_recv.smb2_query_dir_first._initiate_cifs_search
      0.00            +0.8        0.82 ±  5%  perf-profile.calltrace.cycles-pp.smb_send_rqst.compound_send_recv.smb2_query_dir_first._initiate_cifs_search.cifs_readdir
      0.00            +0.8        0.84 ± 10%  perf-profile.calltrace.cycles-pp.tcp_recvmsg_locked.tcp_recvmsg.inet6_recvmsg.sock_recvmsg.____sys_recvmsg
      0.00            +0.9        0.87 ± 17%  perf-profile.calltrace.cycles-pp.link_path_walk.path_lookupat.filename_lookup.filename_getxattr.path_getxattrat
      0.00            +0.9        0.91 ± 10%  perf-profile.calltrace.cycles-pp.tcp_recvmsg.inet6_recvmsg.sock_recvmsg.____sys_recvmsg.___sys_recvmsg
      0.09 ±223%      +0.9        1.00 ±  9%  perf-profile.calltrace.cycles-pp.path_lookupat.filename_lookup.vfs_statx.vfs_fstatat.__do_sys_newfstatat
      0.00            +0.9        0.91 ± 10%  perf-profile.calltrace.cycles-pp.__smb_send_rqst.smb_send_rqst.compound_send_recv.smb2_compound_op.smb2_rmdir
      0.00            +0.9        0.92 ± 10%  perf-profile.calltrace.cycles-pp.inet6_recvmsg.sock_recvmsg.____sys_recvmsg.___sys_recvmsg.__sys_recvmsg
      0.00            +0.9        0.92 ±  9%  perf-profile.calltrace.cycles-pp.smb_send_rqst.compound_send_recv.smb2_compound_op.smb2_rmdir.cifs_rmdir
      0.00            +0.9        0.94 ±  8%  perf-profile.calltrace.cycles-pp.sock_recvmsg.____sys_recvmsg.___sys_recvmsg.__sys_recvmsg.do_syscall_64
      0.10 ±223%      +1.0        1.05 ±  8%  perf-profile.calltrace.cycles-pp.filename_lookup.vfs_statx.vfs_fstatat.__do_sys_newfstatat.do_syscall_64
      0.88 ± 18%      +1.0        1.84 ± 15%  perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary
      0.00            +1.0        0.97 ± 23%  perf-profile.calltrace.cycles-pp.btrfs_getxattr.__vfs_getxattr.do_getxattr.filename_getxattr.path_getxattrat
      0.00            +1.0        0.98 ± 21%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      0.00            +1.0        0.99 ± 20%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.syscall
      0.00            +1.0        1.00 ±  9%  perf-profile.calltrace.cycles-pp.____sys_recvmsg.___sys_recvmsg.__sys_recvmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.0        1.00 ± 14%  perf-profile.calltrace.cycles-pp.compound_send_recv.cifs_send_recv.__SMB2_close.cifs_closedir.__fput
      0.00            +1.0        1.00 ± 14%  perf-profile.calltrace.cycles-pp.cifs_send_recv.__SMB2_close.cifs_closedir.__fput.__x64_sys_close
      0.00            +1.0        1.00 ± 28%  perf-profile.calltrace.cycles-pp.tcp_sock_set_cork.__smb_send_rqst.smb_send_rqst.compound_send_recv.cifs_send_recv
      0.00            +1.0        1.03 ± 12%  perf-profile.calltrace.cycles-pp.__btrfs_unlink_inode.btrfs_rmdir.vfs_rmdir.do_rmdir.__x64_sys_unlinkat
      0.00            +1.0        1.05 ± 20%  perf-profile.calltrace.cycles-pp.__vfs_getxattr.do_getxattr.filename_getxattr.path_getxattrat.do_syscall_64
      0.00            +1.0        1.05 ± 15%  perf-profile.calltrace.cycles-pp.cifs_send_recv.SMB2_query_directory.find_cifs_entry.cifs_readdir.iterate_dir
      0.00            +1.0        1.05 ± 15%  perf-profile.calltrace.cycles-pp.compound_send_recv.cifs_send_recv.SMB2_query_directory.find_cifs_entry.cifs_readdir
      1.10 ± 18%      +1.0        2.15 ±  5%  perf-profile.calltrace.cycles-pp.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      0.00            +1.1        1.08 ± 13%  perf-profile.calltrace.cycles-pp.__SMB2_close.cifs_closedir.__fput.__x64_sys_close.do_syscall_64
      0.00            +1.1        1.12 ± 14%  perf-profile.calltrace.cycles-pp.cifs_closedir.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.1        1.12 ± 17%  perf-profile.calltrace.cycles-pp.tcp_rcv_established.tcp_v6_do_rcv.tcp_v6_rcv.ip6_protocol_deliver_rcu.ip6_input_finish
      0.00            +1.1        1.13 ± 26%  perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_hrtimeout_range.ep_poll.do_epoll_wait
      0.00            +1.1        1.13 ± 17%  perf-profile.calltrace.cycles-pp.tcp_v6_do_rcv.tcp_v6_rcv.ip6_protocol_deliver_rcu.ip6_input_finish.__netif_receive_skb_one_core
      0.00            +1.1        1.14 ± 10%  perf-profile.calltrace.cycles-pp.___sys_recvmsg.__sys_recvmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe.recvmsg
      0.00            +1.1        1.15 ± 13%  perf-profile.calltrace.cycles-pp.SMB2_query_directory.find_cifs_entry.cifs_readdir.iterate_dir.__x64_sys_getdents64
      0.00            +1.2        1.15 ± 16%  perf-profile.calltrace.cycles-pp.syscall
      0.00            +1.2        1.15 ± 16%  perf-profile.calltrace.cycles-pp.tcp_recvmsg_locked.tcp_recvmsg.inet6_recvmsg.sock_recvmsg.cifs_readv_from_socket
      0.00            +1.2        1.17 ± 13%  perf-profile.calltrace.cycles-pp.find_cifs_entry.cifs_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64
      0.00            +1.2        1.17 ± 27%  perf-profile.calltrace.cycles-pp.schedule.schedule_hrtimeout_range.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.00            +1.2        1.17 ± 11%  perf-profile.calltrace.cycles-pp.compound_send_recv.smb2_query_dir_first._initiate_cifs_search.cifs_readdir.iterate_dir
      0.00            +1.2        1.18 ±  8%  perf-profile.calltrace.cycles-pp.__sys_recvmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe.recvmsg
      0.00            +1.2        1.24 ±  8%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.recvmsg
      0.00            +1.2        1.25 ±  8%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.recvmsg
      0.00            +1.3        1.25 ± 14%  perf-profile.calltrace.cycles-pp.inet6_recvmsg.sock_recvmsg.cifs_readv_from_socket.cifs_read_from_socket.cifs_demultiplex_thread
      0.00            +1.3        1.26 ± 14%  perf-profile.calltrace.cycles-pp.sock_recvmsg.cifs_readv_from_socket.cifs_read_from_socket.cifs_demultiplex_thread.kthread
      0.00            +1.3        1.26 ±  9%  perf-profile.calltrace.cycles-pp.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close_nocancel
      0.00            +1.3        1.28 ± 10%  perf-profile.calltrace.cycles-pp.path_listxattrat.do_syscall_64.entry_SYSCALL_64_after_hwframe.listxattr
      0.00            +1.3        1.29 ±  7%  perf-profile.calltrace.cycles-pp.compound_send_recv.smb2_compound_op.smb2_rmdir.cifs_rmdir.vfs_rmdir
      0.00            +1.3        1.31 ± 10%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.listxattr
      0.00            +1.3        1.31 ± 10%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.listxattr
      0.00            +1.3        1.33 ± 19%  perf-profile.calltrace.cycles-pp.tcp_recvmsg.inet6_recvmsg.sock_recvmsg.cifs_readv_from_socket.cifs_read_from_socket
      0.00            +1.4        1.37 ± 20%  perf-profile.calltrace.cycles-pp.do_getxattr.filename_getxattr.path_getxattrat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.4        1.37 ± 10%  perf-profile.calltrace.cycles-pp.recvmsg
      0.00            +1.4        1.39 ± 11%  perf-profile.calltrace.cycles-pp.listxattr
      0.00            +1.4        1.41 ± 18%  perf-profile.calltrace.cycles-pp.tcp_v6_rcv.ip6_protocol_deliver_rcu.ip6_input_finish.__netif_receive_skb_one_core.process_backlog
      0.10 ±223%      +1.4        1.52 ±  8%  perf-profile.calltrace.cycles-pp.vfs_statx.vfs_fstatat.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.4        1.42 ± 26%  perf-profile.calltrace.cycles-pp.schedule_hrtimeout_range.ep_poll.do_epoll_wait.__x64_sys_epoll_wait.do_syscall_64
      0.00            +1.4        1.44 ± 15%  perf-profile.calltrace.cycles-pp.cifs_readv_from_socket.cifs_read_from_socket.cifs_demultiplex_thread.kthread.ret_from_fork
      0.00            +1.4        1.44 ± 12%  perf-profile.calltrace.cycles-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close_nocancel
      0.00            +1.4        1.45 ± 18%  perf-profile.calltrace.cycles-pp.ip6_protocol_deliver_rcu.ip6_input_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll
      0.00            +1.5        1.46 ± 16%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.openat64
      0.00            +1.5        1.46 ± 18%  perf-profile.calltrace.cycles-pp.ip6_input_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action
      0.00            +1.5        1.46 ± 16%  perf-profile.calltrace.cycles-pp.cifs_read_from_socket.cifs_demultiplex_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00            +1.5        1.50 ± 15%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.openat64
      0.00            +1.5        1.50 ± 13%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close_nocancel
      0.00            +1.5        1.52 ± 12%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close_nocancel
      0.00            +1.5        1.53 ± 14%  perf-profile.calltrace.cycles-pp.path_lookupat.filename_lookup.filename_getxattr.path_getxattrat.do_syscall_64
      0.00            +1.5        1.53 ± 18%  perf-profile.calltrace.cycles-pp.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action.handle_softirqs
      0.00            +1.5        1.54 ± 14%  perf-profile.calltrace.cycles-pp.filename_lookup.filename_getxattr.path_getxattrat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.6        1.56 ± 15%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.openat64
      0.00            +1.6        1.56 ± 10%  perf-profile.calltrace.cycles-pp.smb2_query_dir_first._initiate_cifs_search.cifs_readdir.iterate_dir.__x64_sys_getdents64
      0.00            +1.6        1.57 ± 17%  perf-profile.calltrace.cycles-pp.process_backlog.__napi_poll.net_rx_action.handle_softirqs.do_softirq
      0.00            +1.6        1.57 ± 17%  perf-profile.calltrace.cycles-pp.__napi_poll.net_rx_action.handle_softirqs.do_softirq.__local_bh_enable_ip
      0.00            +1.6        1.58 ± 15%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.openat64
      0.00            +1.6        1.58 ± 12%  perf-profile.calltrace.cycles-pp.__close_nocancel
      0.00            +1.6        1.59 ± 10%  perf-profile.calltrace.cycles-pp._initiate_cifs_search.cifs_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64
      0.00            +1.7        1.66 ± 13%  perf-profile.calltrace.cycles-pp.btrfs_rmdir.vfs_rmdir.do_rmdir.__x64_sys_unlinkat.do_syscall_64
      0.00            +1.7        1.73 ± 29%  perf-profile.calltrace.cycles-pp.tcp_write_xmit.__tcp_push_pending_frames.tcp_sock_set_cork.__smb_send_rqst.smb_send_rqst
      0.00            +1.7        1.73 ±  9%  perf-profile.calltrace.cycles-pp.smb2_compound_op.smb2_rmdir.cifs_rmdir.vfs_rmdir.do_rmdir
      0.00            +1.7        1.73 ±  8%  perf-profile.calltrace.cycles-pp.btrfs_evict_inode.evict.__dentry_kill.dput.__fput
      0.00            +1.7        1.74 ± 28%  perf-profile.calltrace.cycles-pp.__tcp_push_pending_frames.tcp_sock_set_cork.__smb_send_rqst.smb_send_rqst.compound_send_recv
      0.00            +1.7        1.74 ±  9%  perf-profile.calltrace.cycles-pp.smb2_rmdir.cifs_rmdir.vfs_rmdir.do_rmdir.__x64_sys_unlinkat
      0.00            +1.8        1.79 ± 14%  perf-profile.calltrace.cycles-pp.openat64
      0.00            +1.8        1.80 ± 10%  perf-profile.calltrace.cycles-pp.cifs_rmdir.vfs_rmdir.do_rmdir.__x64_sys_unlinkat.do_syscall_64
      0.00            +1.8        1.81 ±  8%  perf-profile.calltrace.cycles-pp.evict.__dentry_kill.dput.__fput.__x64_sys_close
      0.00            +1.8        1.85 ± 19%  perf-profile.calltrace.cycles-pp.net_rx_action.handle_softirqs.do_softirq.__local_bh_enable_ip.__dev_queue_xmit
      0.00            +2.1        2.11 ±  7%  perf-profile.calltrace.cycles-pp.vfs_fstatat.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe.fstatat64
      0.00            +2.1        2.11 ±  8%  perf-profile.calltrace.cycles-pp.__dentry_kill.dput.__fput.__x64_sys_close.do_syscall_64
      0.00            +2.1        2.12 ± 23%  perf-profile.calltrace.cycles-pp.handle_softirqs.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip6_finish_output2
      0.00            +2.1        2.13 ± 23%  perf-profile.calltrace.cycles-pp.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip6_finish_output2.ip6_finish_output
      0.00            +2.2        2.16 ±  7%  perf-profile.calltrace.cycles-pp.dput.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +2.2        2.16 ± 22%  perf-profile.calltrace.cycles-pp.__local_bh_enable_ip.__dev_queue_xmit.ip6_finish_output2.ip6_finish_output.ip6_xmit
      0.00            +2.2        2.19 ± 25%  perf-profile.calltrace.cycles-pp.ep_poll.do_epoll_wait.__x64_sys_epoll_wait.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +2.3        2.25 ± 25%  perf-profile.calltrace.cycles-pp.do_epoll_wait.__x64_sys_epoll_wait.do_syscall_64.entry_SYSCALL_64_after_hwframe.epoll_wait
      0.00            +2.3        2.32 ±  9%  perf-profile.calltrace.cycles-pp.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      0.00            +2.3        2.33 ± 25%  perf-profile.calltrace.cycles-pp.__x64_sys_epoll_wait.do_syscall_64.entry_SYSCALL_64_after_hwframe.epoll_wait
      0.00            +2.5        2.54 ± 18%  perf-profile.calltrace.cycles-pp.inet6_csk_xmit.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_locked
      0.00            +2.6        2.59 ± 25%  perf-profile.calltrace.cycles-pp.__dev_queue_xmit.ip6_finish_output2.ip6_finish_output.ip6_xmit.inet6_csk_xmit
      0.00            +2.6        2.59 ± 24%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.epoll_wait
      0.00            +2.6        2.59 ± 24%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.epoll_wait
      0.00            +2.6        2.60 ±  7%  perf-profile.calltrace.cycles-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      0.00            +2.6        2.65 ±  8%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      0.00            +2.7        2.66 ±  8%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close
      0.00            +2.7        2.66 ± 26%  perf-profile.calltrace.cycles-pp.ip6_finish_output2.ip6_finish_output.ip6_xmit.inet6_csk_xmit.__tcp_transmit_skb
      0.00            +2.7        2.72 ± 14%  perf-profile.calltrace.cycles-pp.cifs_demultiplex_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00            +2.7        2.72 ± 25%  perf-profile.calltrace.cycles-pp.ip6_finish_output.ip6_xmit.inet6_csk_xmit.__tcp_transmit_skb.tcp_write_xmit
      0.00            +2.8        2.79 ± 17%  perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg
      0.00            +2.8        2.80 ±  8%  perf-profile.calltrace.cycles-pp.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe.fstatat64
      0.00            +2.8        2.85 ±  8%  perf-profile.calltrace.cycles-pp.__close
      0.00            +2.9        2.85 ± 22%  perf-profile.calltrace.cycles-pp.epoll_wait
      0.00            +3.0        2.99 ± 13%  perf-profile.calltrace.cycles-pp.filename_getxattr.path_getxattrat.do_syscall_64.entry_SYSCALL_64_after_hwframe.getxattr
      0.00            +3.0        3.00 ± 28%  perf-profile.calltrace.cycles-pp.ip6_xmit.inet6_csk_xmit.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames
      0.00            +3.1        3.06 ±  9%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.fstatat64
      0.00            +3.1        3.08 ± 16%  perf-profile.calltrace.cycles-pp.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg.____sys_sendmsg
      0.00            +3.1        3.10 ± 16%  perf-profile.calltrace.cycles-pp.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg.____sys_sendmsg.___sys_sendmsg
      0.00            +3.1        3.10 ±  9%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.fstatat64
      0.00            +3.1        3.14 ± 10%  perf-profile.calltrace.cycles-pp.cifs_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +3.2        3.19 ± 13%  perf-profile.calltrace.cycles-pp.path_getxattrat.do_syscall_64.entry_SYSCALL_64_after_hwframe.getxattr
      0.00            +3.3        3.25 ± 13%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.getxattr
      0.00            +3.3        3.26 ± 13%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.getxattr
      0.00            +3.4        3.39 ± 13%  perf-profile.calltrace.cycles-pp.getxattr
      0.00            +3.6        3.65 ± 11%  perf-profile.calltrace.cycles-pp.fstatat64
      0.00            +3.8        3.79 ± 16%  perf-profile.calltrace.cycles-pp.tcp_sendmsg_locked.tcp_sendmsg.____sys_sendmsg.___sys_sendmsg.__sys_sendmsg
      0.00            +3.8        3.80 ± 10%  perf-profile.calltrace.cycles-pp.vfs_rmdir.do_rmdir.__x64_sys_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +3.9        3.89 ± 16%  perf-profile.calltrace.cycles-pp.tcp_sendmsg.____sys_sendmsg.___sys_sendmsg.__sys_sendmsg.do_syscall_64
      0.00            +4.0        4.01 ± 11%  perf-profile.calltrace.cycles-pp.do_rmdir.__x64_sys_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlinkat
      0.00            +4.1        4.06 ± 11%  perf-profile.calltrace.cycles-pp.__x64_sys_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlinkat
      0.00            +4.1        4.09 ± 11%  perf-profile.calltrace.cycles-pp.iterate_dir.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe.getdents64
      0.00            +4.1        4.10 ± 11%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlinkat
      0.00            +4.1        4.10 ± 11%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.unlinkat
      0.00            +4.2        4.18 ± 11%  perf-profile.calltrace.cycles-pp.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe.getdents64
      0.00            +4.2        4.19 ± 11%  perf-profile.calltrace.cycles-pp.unlinkat
      0.00            +4.3        4.28 ± 11%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.getdents64
      0.00            +4.3        4.29 ± 11%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.getdents64
      0.00            +4.4        4.44 ± 12%  perf-profile.calltrace.cycles-pp.getdents64
      0.00            +4.5        4.46 ± 16%  perf-profile.calltrace.cycles-pp.____sys_sendmsg.___sys_sendmsg.__sys_sendmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +4.7        4.65 ± 16%  perf-profile.calltrace.cycles-pp.___sys_sendmsg.__sys_sendmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendmsg
      0.00            +4.7        4.70 ± 17%  perf-profile.calltrace.cycles-pp.__sys_sendmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendmsg
      0.00            +4.8        4.77 ± 16%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendmsg
      0.00            +4.8        4.77 ± 16%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.sendmsg
      0.00            +4.9        4.92 ± 16%  perf-profile.calltrace.cycles-pp.sendmsg
     47.47           -20.7       26.76 ±  8%  perf-profile.children.cycles-pp.common_startup_64
     47.47           -20.7       26.76 ±  8%  perf-profile.children.cycles-pp.cpu_startup_entry
     47.42           -20.7       26.74 ±  8%  perf-profile.children.cycles-pp.do_idle
     42.13 ±  3%     -18.4       23.69 ±  8%  perf-profile.children.cycles-pp.start_secondary
     38.10 ±  4%     -17.8       20.30 ±  9%  perf-profile.children.cycles-pp.cpuidle_idle_call
     33.63 ±  3%     -15.4       18.24 ± 10%  perf-profile.children.cycles-pp.cpuidle_enter
     33.49 ±  3%     -15.3       18.15 ± 10%  perf-profile.children.cycles-pp.cpuidle_enter_state
     14.26 ±  4%     -10.1        4.15 ± 29%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
     13.24 ±  5%      -9.4        3.84 ± 30%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      7.10 ±  3%      -5.6        1.53 ± 44%  perf-profile.children.cycles-pp.dispatch_events
      7.10 ±  3%      -5.6        1.53 ± 44%  perf-profile.children.cycles-pp.cmd_stat
      7.08 ±  3%      -5.6        1.53 ± 44%  perf-profile.children.cycles-pp.process_interval
      6.96 ±  4%      -5.5        1.48 ± 44%  perf-profile.children.cycles-pp.read_counters
      6.44 ±  6%      -5.0        1.42 ± 35%  perf-profile.children.cycles-pp.read
      6.25 ±  9%      -4.8        1.42 ± 47%  perf-profile.children.cycles-pp.__x64_sys_execve
      6.20 ±  8%      -4.8        1.40 ± 46%  perf-profile.children.cycles-pp.do_execveat_common
      6.18 ± 10%      -4.8        1.41 ± 47%  perf-profile.children.cycles-pp.execve
      6.36 ±  6%      -4.6        1.81 ± 33%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
     10.50 ± 11%      -4.5        6.01 ± 11%  perf-profile.children.cycles-pp.ret_from_fork_asm
      5.70 ±  5%      -4.4        1.25 ± 42%  perf-profile.children.cycles-pp.sched_setaffinity
     10.45 ± 11%      -4.4        6.00 ± 11%  perf-profile.children.cycles-pp.ret_from_fork
      5.95 ± 11%      -4.4        1.52 ± 36%  perf-profile.children.cycles-pp.asm_exc_page_fault
      6.20 ±  6%      -4.4        1.78 ± 33%  perf-profile.children.cycles-pp.hrtimer_interrupt
      5.59 ±  5%      -4.3        1.28 ± 36%  perf-profile.children.cycles-pp.ksys_read
     10.06 ± 12%      -4.1        5.91 ± 11%  perf-profile.children.cycles-pp.kthread
      5.30 ±  6%      -4.1        1.24 ± 37%  perf-profile.children.cycles-pp.vfs_read
      5.15 ± 12%      -3.9        1.29 ± 34%  perf-profile.children.cycles-pp.do_user_addr_fault
      5.16 ± 12%      -3.9        1.30 ± 34%  perf-profile.children.cycles-pp.exc_page_fault
     16.15 ±  8%      -3.7       12.41 ±  4%  perf-profile.children.cycles-pp.intel_idle
      5.11 ±  9%      -3.7        1.44 ± 34%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      4.86 ± 13%      -3.6        1.24 ± 37%  perf-profile.children.cycles-pp.handle_mm_fault
      4.58 ± 11%      -3.5        1.03 ± 39%  perf-profile.children.cycles-pp.smpboot_thread_fn
      4.55 ± 13%      -3.4        1.16 ± 37%  perf-profile.children.cycles-pp.__handle_mm_fault
      5.26 ± 13%      -3.3        1.94 ± 22%  perf-profile.children.cycles-pp.sched_balance_rq
      4.18 ± 11%      -3.3        0.92 ± 41%  perf-profile.children.cycles-pp.bprm_execve
      4.56 ± 15%      -3.1        1.48 ± 24%  perf-profile.children.cycles-pp.__irq_exit_rcu
      4.54 ± 14%      -3.0        1.56 ± 25%  perf-profile.children.cycles-pp.sched_balance_find_src_group
      4.14 ± 13%      -3.0        1.18 ± 29%  perf-profile.children.cycles-pp.tick_nohz_handler
      4.46 ± 14%      -2.9        1.52 ± 26%  perf-profile.children.cycles-pp.update_sd_lb_stats
      3.65 ± 15%      -2.8        0.81 ± 46%  perf-profile.children.cycles-pp.exec_binprm
      3.62 ± 15%      -2.8        0.80 ± 46%  perf-profile.children.cycles-pp.search_binary_handler
      3.64 ±  6%      -2.8        0.82 ± 48%  perf-profile.children.cycles-pp.evlist_cpu_iterator__next
      4.61 ±  9%      -2.8        1.80 ± 15%  perf-profile.children.cycles-pp.__pick_next_task
      4.73 ± 23%      -2.8        1.96 ± 13%  perf-profile.children.cycles-pp._nohz_idle_balance
      4.03 ± 16%      -2.7        1.30 ± 28%  perf-profile.children.cycles-pp.update_sg_lb_stats
      3.50 ± 15%      -2.7        0.79 ± 47%  perf-profile.children.cycles-pp.load_elf_binary
      4.12 ± 16%      -2.4        1.76 ± 30%  perf-profile.children.cycles-pp.worker_thread
      6.97 ±  8%      -2.4        4.62        perf-profile.children.cycles-pp.__schedule
      3.34 ± 11%      -2.3        1.00 ± 24%  perf-profile.children.cycles-pp.sched_balance_newidle
      2.93 ± 14%      -2.3        0.60 ± 42%  perf-profile.children.cycles-pp.balance_fair
      3.04 ± 12%      -2.3        0.74 ± 49%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      3.00 ± 12%      -2.3        0.73 ± 50%  perf-profile.children.cycles-pp.do_mmap
      5.34 ± 23%      -2.3        3.07 ± 24%  perf-profile.children.cycles-pp.rest_init
      5.34 ± 23%      -2.3        3.07 ± 24%  perf-profile.children.cycles-pp.start_kernel
      5.34 ± 23%      -2.3        3.07 ± 24%  perf-profile.children.cycles-pp.x86_64_start_kernel
      5.34 ± 23%      -2.3        3.07 ± 24%  perf-profile.children.cycles-pp.x86_64_start_reservations
      3.10 ± 10%      -2.1        0.96 ± 36%  perf-profile.children.cycles-pp.x64_sys_call
      2.67 ±  5%      -2.1        0.58 ± 39%  perf-profile.children.cycles-pp.__x64_sys_sched_setaffinity
      2.74 ±  9%      -2.1        0.67 ± 50%  perf-profile.children.cycles-pp.__mmap_region
      2.78 ± 12%      -2.0        0.73 ± 45%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      2.78 ± 12%      -2.0        0.73 ± 45%  perf-profile.children.cycles-pp.do_group_exit
      2.95 ± 11%      -2.0        0.90 ± 30%  perf-profile.children.cycles-pp.update_process_times
      2.77 ± 12%      -2.0        0.73 ± 45%  perf-profile.children.cycles-pp.do_exit
      3.61 ± 21%      -2.0        1.64 ± 31%  perf-profile.children.cycles-pp.process_one_work
      2.54 ± 11%      -1.9        0.62 ± 39%  perf-profile.children.cycles-pp.do_pte_missing
      2.36 ±  8%      -1.8        0.52 ± 41%  perf-profile.children.cycles-pp.__sched_setaffinity
      2.38 ± 11%      -1.8        0.56 ± 35%  perf-profile.children.cycles-pp.seq_read_iter
      2.23 ± 11%      -1.8        0.43 ± 37%  perf-profile.children.cycles-pp.readn
      2.45 ± 14%      -1.8        0.66 ± 42%  perf-profile.children.cycles-pp.__mmput
      2.27 ± 11%      -1.8        0.49 ± 42%  perf-profile.children.cycles-pp.setlocale
      2.42 ± 14%      -1.8        0.64 ± 43%  perf-profile.children.cycles-pp.exit_mmap
      2.19 ± 14%      -1.7        0.50 ± 40%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
      2.12 ± 17%      -1.6        0.47 ± 39%  perf-profile.children.cycles-pp.kernel_clone
      4.89 ± 12%      -1.6        3.28 ±  2%  perf-profile.children.cycles-pp.schedule
      2.04 ±  9%      -1.6        0.45 ± 43%  perf-profile.children.cycles-pp.__set_cpus_allowed_ptr
      2.06 ± 15%      -1.6        0.50 ± 38%  perf-profile.children.cycles-pp.do_read_fault
      1.89 ± 18%      -1.5        0.37 ± 47%  perf-profile.children.cycles-pp.evsel__read_counter
      2.69 ± 17%      -1.4        1.27 ± 17%  perf-profile.children.cycles-pp.sched_balance_domains
      1.84 ± 16%      -1.4        0.46 ± 38%  perf-profile.children.cycles-pp.filemap_map_pages
      1.91 ± 17%      -1.4        0.54 ± 48%  perf-profile.children.cycles-pp.exit_mm
      1.73 ± 23%      -1.3        0.42 ± 38%  perf-profile.children.cycles-pp.irq_enter_rcu
      2.58 ± 17%      -1.3        1.27 ±  6%  perf-profile.children.cycles-pp.menu_select
      1.66 ± 24%      -1.3        0.41 ± 38%  perf-profile.children.cycles-pp.tick_irq_enter
      1.58 ±  8%      -1.2        0.35 ± 37%  perf-profile.children.cycles-pp.__vfork
      1.51 ± 19%      -1.2        0.30 ± 45%  perf-profile.children.cycles-pp.copy_process
      1.50 ± 24%      -1.2        0.31 ± 73%  perf-profile.children.cycles-pp.irq_work_run_list
      1.49 ± 23%      -1.2        0.30 ± 73%  perf-profile.children.cycles-pp.__sysvec_irq_work
      1.49 ± 23%      -1.2        0.30 ± 73%  perf-profile.children.cycles-pp._printk
      1.49 ± 23%      -1.2        0.30 ± 73%  perf-profile.children.cycles-pp.asm_sysvec_irq_work
      1.49 ± 23%      -1.2        0.30 ± 73%  perf-profile.children.cycles-pp.irq_work_run
      1.49 ± 23%      -1.2        0.30 ± 73%  perf-profile.children.cycles-pp.irq_work_single
      1.49 ± 23%      -1.2        0.30 ± 73%  perf-profile.children.cycles-pp.sysvec_irq_work
      1.30 ± 25%      -1.1        0.20 ± 78%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      3.35 ± 13%      -1.1        2.26 ± 14%  perf-profile.children.cycles-pp.__x64_sys_openat
      3.27 ± 11%      -1.1        2.19 ± 10%  perf-profile.children.cycles-pp.path_openat
      3.29 ± 11%      -1.1        2.22 ± 10%  perf-profile.children.cycles-pp.do_filp_open
      1.51 ± 22%      -1.1        0.45 ± 32%  perf-profile.children.cycles-pp.sched_tick
      1.31 ± 33%      -1.1        0.25 ± 39%  perf-profile.children.cycles-pp.tmigr_handle_remote
      1.39 ± 11%      -1.1        0.34 ± 49%  perf-profile.children.cycles-pp.__mmap_new_vma
      1.33 ± 21%      -1.0        0.30 ± 47%  perf-profile.children.cycles-pp.__open64_nocancel
      1.29 ± 13%      -1.0        0.29 ± 35%  perf-profile.children.cycles-pp.perf_read
      1.26 ± 18%      -1.0        0.27 ± 35%  perf-profile.children.cycles-pp.__x64_sys_vfork
      1.22 ± 34%      -1.0        0.24 ± 41%  perf-profile.children.cycles-pp.tmigr_handle_remote_up
      1.13 ±  8%      -0.9        0.22 ± 35%  perf-profile.children.cycles-pp.perf_evsel__read
      1.15 ± 23%      -0.9        0.24 ± 42%  perf-profile.children.cycles-pp.__set_cpus_allowed_ptr_locked
      1.17 ± 13%      -0.9        0.30 ± 54%  perf-profile.children.cycles-pp.elf_load
      1.12 ± 14%      -0.9        0.27 ± 56%  perf-profile.children.cycles-pp._Fork
      1.39 ± 34%      -0.8        0.56 ± 22%  perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      1.05 ± 22%      -0.8        0.22 ± 39%  perf-profile.children.cycles-pp.__do_set_cpus_allowed
      1.06 ± 16%      -0.8        0.25 ± 61%  perf-profile.children.cycles-pp.pipe_read
      1.03 ± 33%      -0.8        0.22 ± 37%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.97 ± 17%      -0.8        0.20 ± 47%  perf-profile.children.cycles-pp.__lookup_slow
      1.03 ± 20%      -0.8        0.27 ± 50%  perf-profile.children.cycles-pp.unmap_vmas
      1.19 ± 15%      -0.8        0.44 ± 17%  perf-profile.children.cycles-pp.idle_cpu
      0.95 ± 18%      -0.8        0.20 ± 48%  perf-profile.children.cycles-pp.__mmap
      0.93 ± 14%      -0.7        0.19 ± 38%  perf-profile.children.cycles-pp.migration_cpu_stop
      0.94 ± 15%      -0.7        0.20 ± 40%  perf-profile.children.cycles-pp.cpu_stopper_thread
      0.93 ± 14%      -0.7        0.20 ± 59%  perf-profile.children.cycles-pp.alloc_bprm
      0.92 ± 27%      -0.7        0.18 ± 37%  perf-profile.children.cycles-pp.proc_reg_read_iter
      0.89 ± 12%      -0.7        0.17 ± 36%  perf-profile.children.cycles-pp.move_queued_task
      0.95 ± 14%      -0.7        0.24 ± 27%  perf-profile.children.cycles-pp.tick_nohz_stop_tick
      0.95 ± 14%      -0.7        0.25 ± 27%  perf-profile.children.cycles-pp.tick_nohz_idle_stop_tick
      0.92 ± 21%      -0.7        0.23 ± 28%  perf-profile.children.cycles-pp.begin_new_exec
      0.86 ± 18%      -0.7        0.20 ± 49%  perf-profile.children.cycles-pp.__do_sys_clone
      0.88 ± 37%      -0.7        0.22 ± 30%  perf-profile.children.cycles-pp.do_anonymous_page
      0.85 ± 13%      -0.6        0.20 ± 44%  perf-profile.children.cycles-pp.affine_move_task
      0.92 ± 24%      -0.6        0.29 ± 44%  perf-profile.children.cycles-pp.delay_tsc
      0.82 ± 18%      -0.6        0.19 ± 34%  perf-profile.children.cycles-pp.tlb_finish_mmu
      0.80 ± 42%      -0.6        0.17 ± 30%  perf-profile.children.cycles-pp.update_sg_wakeup_stats
      0.81 ± 43%      -0.6        0.18 ± 25%  perf-profile.children.cycles-pp.sched_balance_find_dst_group
      0.79 ± 25%      -0.6        0.16 ± 50%  perf-profile.children.cycles-pp.alloc_pages_mpol_noprof
      2.19 ±  9%      -0.6        1.57 ±  8%  perf-profile.children.cycles-pp.enqueue_task
      0.90 ± 22%      -0.6        0.28 ± 42%  perf-profile.children.cycles-pp.next_uptodate_folio
      1.21 ± 22%      -0.6        0.59 ± 32%  perf-profile.children.cycles-pp.rcu_core
      1.17 ± 12%      -0.6        0.56 ± 20%  perf-profile.children.cycles-pp.tick_nohz_idle_exit
      1.04 ± 23%      -0.6        0.43 ± 15%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.81 ± 15%      -0.6        0.20 ± 22%  perf-profile.children.cycles-pp.tick_nohz_restart_sched_tick
      0.78 ± 15%      -0.6        0.17 ± 86%  perf-profile.children.cycles-pp.mas_store_prealloc
      1.07 ± 24%      -0.6        0.47 ± 20%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.86 ± 24%      -0.6        0.26 ± 54%  perf-profile.children.cycles-pp.unmap_page_range
      0.74 ± 28%      -0.6        0.15 ± 51%  perf-profile.children.cycles-pp.__alloc_pages_noprof
      0.82 ± 24%      -0.6        0.24 ± 48%  perf-profile.children.cycles-pp.zap_pmd_range
      3.34 ± 13%      -0.6        2.76 ±  9%  perf-profile.children.cycles-pp.do_sys_openat2
      0.80 ± 22%      -0.6        0.24 ± 45%  perf-profile.children.cycles-pp.zap_pte_range
      0.74 ± 15%      -0.6        0.18 ± 23%  perf-profile.children.cycles-pp.exec_mmap
      0.69 ± 23%      -0.6        0.12 ± 34%  perf-profile.children.cycles-pp.wp_page_copy
      0.71 ± 15%      -0.6        0.15 ± 64%  perf-profile.children.cycles-pp.d_alloc_parallel
      0.81 ± 23%      -0.6        0.26 ± 45%  perf-profile.children.cycles-pp.__split_vma
      1.47 ± 21%      -0.6        0.92 ± 28%  perf-profile.children.cycles-pp.wait_for_lsr
      0.68 ± 30%      -0.5        0.13 ± 36%  perf-profile.children.cycles-pp.seq_read
      0.67 ± 22%      -0.5        0.12 ± 81%  perf-profile.children.cycles-pp.mm_init
      0.77 ± 25%      -0.5        0.24 ± 56%  perf-profile.children.cycles-pp.__mmap_prepare
      0.64 ± 23%      -0.5        0.11 ± 40%  perf-profile.children.cycles-pp.vmstat_start
      0.69 ± 19%      -0.5        0.17 ± 21%  perf-profile.children.cycles-pp.clockevents_program_event
      1.49 ± 23%      -0.5        0.97 ± 28%  perf-profile.children.cycles-pp.serial8250_console_write
      0.64 ± 18%      -0.5        0.14 ± 32%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
      0.64 ± 18%      -0.5        0.14 ± 32%  perf-profile.children.cycles-pp.__tlb_batch_free_encoded_pages
      0.70 ± 27%      -0.5        0.19 ± 39%  perf-profile.children.cycles-pp.vms_gather_munmap_vmas
      0.60 ± 34%      -0.5        0.09 ± 72%  perf-profile.children.cycles-pp.tick_do_update_jiffies64
      0.62 ± 11%      -0.5        0.12 ± 36%  perf-profile.children.cycles-pp.__pte_offset_map_lock
      1.93 ± 11%      -0.5        1.44 ± 10%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.54 ±109%      -0.5        0.05 ±103%  perf-profile.children.cycles-pp.need_update
      0.88 ± 26%      -0.5        0.40 ± 15%  perf-profile.children.cycles-pp.sched_balance_update_blocked_averages
      0.56 ± 25%      -0.5        0.11 ± 53%  perf-profile.children.cycles-pp.setup_arg_pages
      0.66 ± 22%      -0.5        0.20 ± 40%  perf-profile.children.cycles-pp.zap_present_ptes
      0.81 ± 19%      -0.4        0.36 ± 20%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.56 ± 14%      -0.4        0.12 ± 20%  perf-profile.children.cycles-pp.__cmd_record
      0.56 ± 14%      -0.4        0.12 ± 20%  perf-profile.children.cycles-pp.cmd_record
      0.54 ± 16%      -0.4        0.10 ± 48%  perf-profile.children.cycles-pp.folios_put_refs
      0.74 ± 12%      -0.4        0.30 ± 16%  perf-profile.children.cycles-pp.finish_task_switch
      1.11 ± 19%      -0.4        0.67 ± 11%  perf-profile.children.cycles-pp.hrtimer_start_range_ns
      0.59 ± 17%      -0.4        0.16 ± 33%  perf-profile.children.cycles-pp.vma_interval_tree_insert
      0.48 ±117%      -0.4        0.06 ± 98%  perf-profile.children.cycles-pp.acpi_os_execute_deferred
      0.62 ± 32%      -0.4        0.20 ± 51%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.54 ± 19%      -0.4        0.12 ± 63%  perf-profile.children.cycles-pp.dup_mm
      0.92 ± 29%      -0.4        0.50 ± 31%  perf-profile.children.cycles-pp.rcu_do_batch
      0.48 ±120%      -0.4        0.06 ± 98%  perf-profile.children.cycles-pp.acpi_ev_asynch_execute_gpe_method
      0.54 ± 16%      -0.4        0.13 ± 60%  perf-profile.children.cycles-pp.d_alloc
      0.76 ± 27%      -0.4        0.35 ± 17%  perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      0.54 ± 33%      -0.4        0.14 ± 26%  perf-profile.children.cycles-pp.wait4
      0.57 ± 24%      -0.4        0.16 ± 74%  perf-profile.children.cycles-pp.copy_strings
      0.52 ± 34%      -0.4        0.12 ± 47%  perf-profile.children.cycles-pp.wake_up_new_task
      0.52 ± 14%      -0.4        0.12 ± 34%  perf-profile.children.cycles-pp.fold_vm_zone_numa_events
      0.49 ± 42%      -0.4        0.08 ± 64%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.54 ± 14%      -0.4        0.13 ± 52%  perf-profile.children.cycles-pp.perf_event_read
      0.60 ± 21%      -0.4        0.20 ±  9%  perf-profile.children.cycles-pp.timerqueue_del
      0.46 ±121%      -0.4        0.06 ± 98%  perf-profile.children.cycles-pp.acpi_ns_evaluate
      0.50 ± 33%      -0.4        0.11 ± 46%  perf-profile.children.cycles-pp.dup_task_struct
      0.44 ±125%      -0.4        0.06 ±100%  perf-profile.children.cycles-pp.acpi_ps_execute_method
      0.52 ± 11%      -0.4        0.13 ± 52%  perf-profile.children.cycles-pp.generic_exec_single
      0.47 ± 17%      -0.4        0.08 ± 30%  perf-profile.children.cycles-pp.slab_show
      0.49 ± 10%      -0.4        0.10 ± 54%  perf-profile.children.cycles-pp.__perf_event_read
      0.45 ± 32%      -0.4        0.07 ±118%  perf-profile.children.cycles-pp.pcpu_alloc_noprof
      0.51 ± 12%      -0.4        0.12 ± 50%  perf-profile.children.cycles-pp.smp_call_function_single
      0.54 ± 28%      -0.4        0.16 ± 51%  perf-profile.children.cycles-pp.free_pgtables
      0.50 ± 11%      -0.4        0.12 ± 44%  perf-profile.children.cycles-pp.get_arg_page
      0.43 ±132%      -0.4        0.06 ±100%  perf-profile.children.cycles-pp.acpi_ps_parse_aml
      0.48 ±  9%      -0.4        0.11 ± 37%  perf-profile.children.cycles-pp.try_address
      0.54 ± 17%      -0.4        0.17 ± 49%  perf-profile.children.cycles-pp.pipe_write
      0.48 ±  9%      -0.4        0.12 ± 44%  perf-profile.children.cycles-pp.__i2c_transfer
      0.48 ±  9%      -0.4        0.12 ± 44%  perf-profile.children.cycles-pp.ast_vga_connector_helper_detect_ctx
      0.48 ±  9%      -0.4        0.12 ± 44%  perf-profile.children.cycles-pp.bit_xfer
      0.48 ±  9%      -0.4        0.12 ± 44%  perf-profile.children.cycles-pp.drm_connector_helper_detect_from_ddc
      0.48 ±  9%      -0.4        0.12 ± 44%  perf-profile.children.cycles-pp.drm_do_probe_ddc_edid
      0.48 ±  9%      -0.4        0.12 ± 44%  perf-profile.children.cycles-pp.drm_helper_probe_detect_ctx
      0.48 ±  9%      -0.4        0.12 ± 44%  perf-profile.children.cycles-pp.drm_probe_ddc
      0.48 ±  9%      -0.4        0.12 ± 44%  perf-profile.children.cycles-pp.i2c_transfer
      0.48 ±  9%      -0.4        0.12 ± 44%  perf-profile.children.cycles-pp.output_poll_execute
      0.52 ± 27%      -0.4        0.16 ± 38%  perf-profile.children.cycles-pp.do_vmi_munmap
      0.48 ± 27%      -0.4        0.12 ± 53%  perf-profile.children.cycles-pp.mprotect_fixup
      0.46 ± 24%      -0.4        0.11 ± 29%  perf-profile.children.cycles-pp.vma_link_file
      0.41 ± 27%      -0.4        0.05 ± 76%  perf-profile.children.cycles-pp.run_posix_cpu_timers
      0.51 ± 30%      -0.4        0.16 ± 38%  perf-profile.children.cycles-pp.__vm_munmap
      0.51 ± 30%      -0.4        0.16 ± 38%  perf-profile.children.cycles-pp.do_vmi_align_munmap
      0.42 ± 33%      -0.4        0.08 ± 56%  perf-profile.children.cycles-pp.relocate_vma_down
      0.46 ± 45%      -0.3        0.11 ± 40%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.56 ± 11%      -0.3        0.22 ± 51%  perf-profile.children.cycles-pp.mod_objcg_state
      0.40 ± 19%      -0.3        0.06 ± 52%  perf-profile.children.cycles-pp.set_pte_range
      0.40 ± 42%      -0.3        0.06 ± 17%  perf-profile.children.cycles-pp.__run_timers
      0.46 ± 15%      -0.3        0.12 ± 33%  perf-profile.children.cycles-pp.__x64_sys_mprotect
      0.44 ± 46%      -0.3        0.10 ± 74%  perf-profile.children.cycles-pp.perf_event_mmap
      0.43 ± 36%      -0.3        0.09 ± 22%  perf-profile.children.cycles-pp.do_wait
      0.43 ± 36%      -0.3        0.09 ± 22%  perf-profile.children.cycles-pp.kernel_wait4
      0.45 ± 14%      -0.3        0.12 ± 35%  perf-profile.children.cycles-pp.do_mprotect_pkey
      0.38 ± 43%      -0.3        0.05 ± 75%  perf-profile.children.cycles-pp.strnlen_user
      0.78 ± 19%      -0.3        0.45 ± 13%  perf-profile.children.cycles-pp.update_rq_clock
      0.42 ± 29%      -0.3        0.09 ± 72%  perf-profile.children.cycles-pp.do_open_execat
      0.38 ± 20%      -0.3        0.06 ± 73%  perf-profile.children.cycles-pp._IO_fwrite
      0.38 ±149%      -0.3        0.05 ± 91%  perf-profile.children.cycles-pp.acpi_ps_parse_loop
      0.42 ± 54%      -0.3        0.09 ± 80%  perf-profile.children.cycles-pp.perf_event_mmap_event
      0.41 ± 39%      -0.3        0.09 ± 47%  perf-profile.children.cycles-pp.rcu_pending
      0.54 ± 24%      -0.3        0.22 ± 40%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.45 ± 32%      -0.3        0.14 ± 25%  perf-profile.children.cycles-pp.sched_balance_softirq
      0.34 ± 42%      -0.3        0.03 ±102%  perf-profile.children.cycles-pp.create_elf_tables
      0.45 ± 26%      -0.3        0.14 ± 63%  perf-profile.children.cycles-pp.__wait_for_common
      0.40 ± 31%      -0.3        0.09 ± 31%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.38 ± 25%      -0.3        0.07 ± 53%  perf-profile.children.cycles-pp.__queue_work
      0.36 ± 38%      -0.3        0.06 ± 13%  perf-profile.children.cycles-pp.call_timer_fn
      0.38 ± 21%      -0.3        0.08 ± 28%  perf-profile.children.cycles-pp.copy_string_kernel
      0.39 ± 27%      -0.3        0.09 ± 58%  perf-profile.children.cycles-pp.schedule_tail
      0.38 ± 28%      -0.3        0.09 ± 73%  perf-profile.children.cycles-pp.__perf_read_group_add
      0.38 ±  8%      -0.3        0.09 ± 42%  perf-profile.children.cycles-pp.i2c_outb
      0.42 ± 24%      -0.3        0.13 ± 48%  perf-profile.children.cycles-pp.__mmdrop
      0.39 ± 29%      -0.3        0.10 ± 55%  perf-profile.children.cycles-pp.dup_mmap
      0.36 ± 35%      -0.3        0.07 ± 63%  perf-profile.children.cycles-pp.vma_alloc_folio_noprof
      0.48 ± 23%      -0.3        0.20 ± 27%  perf-profile.children.cycles-pp.local_clock_noinstr
      0.36 ± 34%      -0.3        0.07 ± 92%  perf-profile.children.cycles-pp.__d_alloc
      0.38 ± 34%      -0.3        0.09 ± 49%  perf-profile.children.cycles-pp.alloc_thread_stack_node
      0.37 ± 21%      -0.3        0.09 ± 34%  perf-profile.children.cycles-pp.get_user_pages_remote
      0.36 ± 32%      -0.3        0.08 ± 59%  perf-profile.children.cycles-pp.cpu_stop_queue_work
      0.40 ± 22%      -0.3        0.12 ± 46%  perf-profile.children.cycles-pp.cpu_util
      0.35 ± 35%      -0.3        0.07 ± 88%  perf-profile.children.cycles-pp.folio_alloc_mpol_noprof
      0.33 ± 39%      -0.3        0.04 ±110%  perf-profile.children.cycles-pp.rmqueue
      0.36 ± 36%      -0.3        0.08 ± 65%  perf-profile.children.cycles-pp.__vmalloc_node_range_noprof
      0.34 ± 28%      -0.3        0.06 ± 68%  perf-profile.children.cycles-pp.mas_wr_node_store
      0.34 ± 23%      -0.3        0.06 ± 79%  perf-profile.children.cycles-pp.seq_printf
      0.36 ± 26%      -0.3        0.09 ± 34%  perf-profile.children.cycles-pp.__get_user_pages
      0.75 ± 22%      -0.3        0.47 ± 14%  perf-profile.children.cycles-pp.update_load_avg
      0.31 ± 35%      -0.3        0.04 ±107%  perf-profile.children.cycles-pp.kick_pool
      0.36 ± 53%      -0.3        0.08 ± 32%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.39 ± 29%      -0.3        0.12 ± 41%  perf-profile.children.cycles-pp.sync_regs
      0.38 ± 34%      -0.3        0.11 ± 60%  perf-profile.children.cycles-pp.vms_clear_ptes
      0.30 ± 32%      -0.3        0.03 ±111%  perf-profile.children.cycles-pp.mas_preallocate
      0.31 ± 46%      -0.3        0.05 ± 79%  perf-profile.children.cycles-pp.evlist__id2sid
      0.38 ± 40%      -0.3        0.12 ± 55%  perf-profile.children.cycles-pp.tmigr_requires_handle_remote
      0.66 ± 14%      -0.3        0.40 ± 24%  perf-profile.children.cycles-pp.__memcg_slab_free_hook
      0.39 ± 20%      -0.3        0.14 ± 37%  perf-profile.children.cycles-pp._find_next_and_bit
      0.30 ± 48%      -0.3        0.05 ± 85%  perf-profile.children.cycles-pp.evlist__id2evsel
      0.34 ± 44%      -0.3        0.08 ± 68%  perf-profile.children.cycles-pp.vma_prepare
      0.33 ± 42%      -0.2        0.08 ± 42%  perf-profile.children.cycles-pp.hrtimer_update_next_event
      0.34 ±  6%      -0.2        0.09 ± 26%  perf-profile.children.cycles-pp.perf_mmap__push
      0.38 ± 32%      -0.2        0.13 ± 48%  perf-profile.children.cycles-pp.show_stat
      0.31 ± 28%      -0.2        0.06 ± 64%  perf-profile.children.cycles-pp.rep_stos_alternative
      0.31 ± 42%      -0.2        0.06 ± 88%  perf-profile.children.cycles-pp.quiet_vmstat
      0.34 ±  6%      -0.2        0.10 ± 22%  perf-profile.children.cycles-pp.record__mmap_read_evlist
      0.31 ± 44%      -0.2        0.07 ± 98%  perf-profile.children.cycles-pp.mas_wr_bnode
      0.30 ± 48%      -0.2        0.06 ± 90%  perf-profile.children.cycles-pp.mas_split
      0.28 ± 40%      -0.2        0.04 ± 73%  perf-profile.children.cycles-pp.folio_add_file_rmap_ptes
      0.32 ± 22%      -0.2        0.08 ± 41%  perf-profile.children.cycles-pp.shmem_file_write_iter
      0.40 ± 28%      -0.2        0.16 ± 27%  perf-profile.children.cycles-pp.ct_idle_exit
      0.45 ± 30%      -0.2        0.21 ± 13%  perf-profile.children.cycles-pp.open_last_lookups
      0.34 ± 24%      -0.2        0.11 ± 55%  perf-profile.children.cycles-pp.__x64_sys_munmap
      0.30 ± 34%      -0.2        0.07 ± 64%  perf-profile.children.cycles-pp.vms_complete_munmap_vmas
      0.31 ± 34%      -0.2        0.08 ± 20%  perf-profile.children.cycles-pp.__do_wait
      0.28 ± 32%      -0.2        0.06 ± 76%  perf-profile.children.cycles-pp.wake_up_q
      0.31 ± 22%      -0.2        0.08 ± 41%  perf-profile.children.cycles-pp.generic_perform_write
      0.30 ± 33%      -0.2        0.08 ± 18%  perf-profile.children.cycles-pp.rb_next
      0.36 ± 33%      -0.2        0.14 ± 29%  perf-profile.children.cycles-pp.tsc_verify_tsc_adjust
      0.28 ± 19%      -0.2        0.06 ± 55%  perf-profile.children.cycles-pp.__perf_event_read_value
      0.30 ± 31%      -0.2        0.08 ± 51%  perf-profile.children.cycles-pp.fdget_pos
      0.36 ± 30%      -0.2        0.13 ±  8%  perf-profile.children.cycles-pp.update_irq_load_avg
      0.28 ± 35%      -0.2        0.06 ±134%  perf-profile.children.cycles-pp.kmem_cache_alloc_lru_noprof
      0.37 ± 35%      -0.2        0.15 ± 27%  perf-profile.children.cycles-pp.arch_cpu_idle_enter
      0.28 ± 28%      -0.2        0.07 ± 77%  perf-profile.children.cycles-pp.vma_modify
      0.28 ± 28%      -0.2        0.07 ± 77%  perf-profile.children.cycles-pp.vma_modify_flags
      0.28 ± 38%      -0.2        0.07 ± 50%  perf-profile.children.cycles-pp.__hrtimer_next_event_base
      0.27 ± 39%      -0.2        0.06 ± 51%  perf-profile.children.cycles-pp.wait_task_zombie
      0.28 ± 43%      -0.2        0.07 ± 77%  perf-profile.children.cycles-pp.dev_attr_show
      0.28 ± 43%      -0.2        0.07 ± 77%  perf-profile.children.cycles-pp.sysfs_kf_seq_show
      0.29 ± 44%      -0.2        0.08 ± 30%  perf-profile.children.cycles-pp.alloc_anon_folio
      0.27 ± 14%      -0.2        0.06 ± 76%  perf-profile.children.cycles-pp.writen
      0.71 ± 16%      -0.2        0.50 ± 13%  perf-profile.children.cycles-pp.enqueue_entity
      0.26 ± 56%      -0.2        0.06 ± 14%  perf-profile.children.cycles-pp.tick_check_oneshot_broadcast_this_cpu
      0.32 ± 41%      -0.2        0.12 ± 44%  perf-profile.children.cycles-pp.load_elf_interp
      0.26 ± 15%      -0.2        0.06 ± 78%  perf-profile.children.cycles-pp.record__pushfn
      0.23 ± 36%      -0.2        0.03 ±111%  perf-profile.children.cycles-pp.error_entry
      0.34 ± 24%      -0.2        0.14 ± 27%  perf-profile.children.cycles-pp.ct_kernel_enter
      0.25 ± 31%      -0.2        0.05 ± 76%  perf-profile.children.cycles-pp.lock_vma_under_rcu
      0.38 ± 30%      -0.2        0.18 ± 32%  perf-profile.children.cycles-pp.rcu_gp_fqs_loop
      0.27 ± 37%      -0.2        0.07 ± 27%  perf-profile.children.cycles-pp.update_other_load_avgs
      0.25 ± 25%      -0.2        0.06 ± 51%  perf-profile.children.cycles-pp.mas_find
      0.25 ± 34%      -0.2        0.06 ± 97%  perf-profile.children.cycles-pp.perf_event_task_tick
      0.28 ± 31%      -0.2        0.10 ± 62%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.32 ± 29%      -0.2        0.14 ± 28%  perf-profile.children.cycles-pp.should_we_balance
      0.23 ± 41%      -0.2        0.05 ±113%  perf-profile.children.cycles-pp.folio_batch_move_lru
      0.21 ± 22%      -0.2        0.03 ±111%  perf-profile.children.cycles-pp.tmigr_cpu_activate
      0.26 ± 41%      -0.2        0.08 ±100%  perf-profile.children.cycles-pp.get_jiffies_update
      0.21 ± 50%      -0.2        0.03 ±103%  perf-profile.children.cycles-pp.lru_add_drain
      0.26 ± 23%      -0.2        0.09 ± 24%  perf-profile.children.cycles-pp.get_cpu_device
      0.22 ± 43%      -0.2        0.04 ± 73%  perf-profile.children.cycles-pp.unlink_anon_vmas
      0.21 ± 20%      -0.2        0.04 ±111%  perf-profile.children.cycles-pp.sclhi
      0.21 ± 48%      -0.2        0.04 ±118%  perf-profile.children.cycles-pp.check_cpu_stall
      0.20 ± 25%      -0.2        0.03 ±101%  perf-profile.children.cycles-pp.irqtime_account_process_tick
      0.26 ± 31%      -0.2        0.09 ± 43%  perf-profile.children.cycles-pp.__percpu_counter_sum
      0.20 ± 37%      -0.2        0.04 ±118%  perf-profile.children.cycles-pp.perf_iterate_sb
      0.21 ± 60%      -0.2        0.05 ±114%  perf-profile.children.cycles-pp.__get_unmapped_area
      0.55 ± 17%      -0.2        0.38 ± 10%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.22 ± 31%      -0.2        0.06 ± 68%  perf-profile.children.cycles-pp.__do_fault
      0.22 ± 37%      -0.2        0.07 ± 94%  perf-profile.children.cycles-pp.irqentry_enter
      0.20 ± 63%      -0.2        0.05 ±114%  perf-profile.children.cycles-pp.arch_get_unmapped_area_topdown
      0.22 ± 44%      -0.2        0.06 ± 49%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.21 ± 35%      -0.2        0.06 ±125%  perf-profile.children.cycles-pp.force_qs_rnp
      0.33 ± 16%      -0.1        0.18 ± 19%  perf-profile.children.cycles-pp.__remove_hrtimer
      0.19 ± 37%      -0.1        0.04 ±116%  perf-profile.children.cycles-pp.flush_tlb_mm_range
      0.18 ± 64%      -0.1        0.03 ±103%  perf-profile.children.cycles-pp.__anon_vma_prepare
      0.20 ± 37%      -0.1        0.06 ± 76%  perf-profile.children.cycles-pp.mas_walk
      0.19 ± 49%      -0.1        0.05 ± 51%  perf-profile.children.cycles-pp.release_task
      0.18 ± 27%      -0.1        0.05 ± 80%  perf-profile.children.cycles-pp.arch_scale_cpu_capacity
      0.22 ± 30%      -0.1        0.09 ± 48%  perf-profile.children.cycles-pp.arch_scale_freq_tick
      0.25 ± 33%      -0.1        0.12 ± 17%  perf-profile.children.cycles-pp.mutex_unlock
      0.16 ± 38%      -0.1        0.03 ±103%  perf-profile.children.cycles-pp.vm_area_dup
      0.22 ± 27%      -0.1        0.10 ± 31%  perf-profile.children.cycles-pp.__get_user_8
      0.23 ± 21%      -0.1        0.11 ± 12%  perf-profile.children.cycles-pp.up_write
      0.16 ± 24%      -0.1        0.06 ± 48%  perf-profile.children.cycles-pp.cpuidle_not_available
      0.14 ± 19%      -0.1        0.05 ± 76%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.12 ± 51%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.shmem_get_folio_gfp
      0.12 ± 48%      -0.1        0.04 ± 75%  perf-profile.children.cycles-pp.rcu_nocb_flush_deferred_wakeup
      0.10 ± 45%      -0.1        0.04 ±106%  perf-profile.children.cycles-pp.free_unref_page
      0.04 ± 70%      +0.0        0.08 ± 20%  perf-profile.children.cycles-pp.fdget
      0.02 ±142%      +0.1        0.07 ± 24%  perf-profile.children.cycles-pp.security_inode_getattr
      0.02 ±141%      +0.1        0.08 ± 14%  perf-profile.children.cycles-pp.mntput_no_expire
      0.01 ±223%      +0.1        0.06 ± 24%  perf-profile.children.cycles-pp.path_parentat
      0.00            +0.1        0.06 ± 15%  perf-profile.children.cycles-pp.fsp_get_pathref_fd
      0.02 ±141%      +0.1        0.08 ± 27%  perf-profile.children.cycles-pp.check_stack_object
      0.01 ±223%      +0.1        0.07 ± 23%  perf-profile.children.cycles-pp.__filename_parentat
      0.00            +0.1        0.07 ± 22%  perf-profile.children.cycles-pp.openat_pathref_dirfsp_nosymlink
      0.00            +0.1        0.07 ± 28%  perf-profile.children.cycles-pp.rep_memset_s
      0.00            +0.1        0.07 ± 28%  perf-profile.children.cycles-pp.allocate_buffers
      0.00            +0.1        0.07 ± 28%  perf-profile.children.cycles-pp.d_hash_and_lookup
      0.00            +0.1        0.07 ± 28%  perf-profile.children.cycles-pp.dequeue_mid
      0.00            +0.1        0.07 ± 21%  perf-profile.children.cycles-pp.iov_buf
      0.00            +0.1        0.07 ± 24%  perf-profile.children.cycles-pp.ndr_pull_xattr_DosInfo
      0.00            +0.1        0.07 ± 20%  perf-profile.children.cycles-pp.cifs_d_revalidate
      0.07 ± 61%      +0.1        0.14 ± 32%  perf-profile.children.cycles-pp.filp_flush
      0.00            +0.1        0.07 ± 23%  perf-profile.children.cycles-pp.next_codepoint
      0.00            +0.1        0.07 ± 23%  perf-profile.children.cycles-pp.talloc_strdup
      0.00            +0.1        0.08 ± 25%  perf-profile.children.cycles-pp._tevent_loop_once
      0.01 ±223%      +0.1        0.08 ± 14%  perf-profile.children.cycles-pp.security_inode_permission
      0.00            +0.1        0.08 ± 24%  perf-profile.children.cycles-pp.__tls_get_addr
      0.03 ±150%      +0.1        0.10 ± 29%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.00            +0.1        0.08 ± 35%  perf-profile.children.cycles-pp._talloc_set_destructor@plt
      0.00            +0.1        0.08 ± 20%  perf-profile.children.cycles-pp.btrfs_cow_block
      0.00            +0.1        0.08 ± 20%  perf-profile.children.cycles-pp.btrfs_force_cow_block
      0.00            +0.1        0.08 ± 31%  perf-profile.children.cycles-pp.filename_convert_dirfsp
      0.00            +0.1        0.08 ± 27%  perf-profile.children.cycles-pp._talloc_steal_loc
      0.00            +0.1        0.08 ± 25%  perf-profile.children.cycles-pp.remove_smb2_chained_fsp
      0.00            +0.1        0.08 ± 34%  perf-profile.children.cycles-pp.ndr_push_uint16
      0.00            +0.1        0.08 ± 32%  perf-profile.children.cycles-pp.messaging_server_id
      0.02 ±141%      +0.1        0.10 ± 25%  perf-profile.children.cycles-pp.__errno_location
      0.00            +0.1        0.08 ± 37%  perf-profile.children.cycles-pp.talloc_named_const
      0.00            +0.1        0.09 ± 18%  perf-profile.children.cycles-pp._raw_read_lock_irqsave
      0.02 ±142%      +0.1        0.11 ± 22%  perf-profile.children.cycles-pp.cpus_share_cache
      0.01 ±223%      +0.1        0.10 ± 20%  perf-profile.children.cycles-pp.list_lru_del_obj
      0.00            +0.1        0.09 ± 33%  perf-profile.children.cycles-pp.cifs_handle_standard
      0.00            +0.1        0.09 ± 24%  perf-profile.children.cycles-pp.evict_refill_and_join
      0.00            +0.1        0.09 ± 25%  perf-profile.children.cycles-pp.readdir64
      0.00            +0.1        0.09 ± 34%  perf-profile.children.cycles-pp.cifs_compound_callback
      0.00            +0.1        0.09 ± 28%  perf-profile.children.cycles-pp.task_dump_owner
      0.00            +0.1        0.10 ± 24%  perf-profile.children.cycles-pp.getgroups
      0.00            +0.1        0.10 ± 23%  perf-profile.children.cycles-pp.inode_get_bytes
      0.00            +0.1        0.10 ± 27%  perf-profile.children.cycles-pp.cifs_small_buf_get
      0.00            +0.1        0.10 ± 34%  perf-profile.children.cycles-pp.tcp_current_mss
      0.04 ± 71%      +0.1        0.14 ± 27%  perf-profile.children.cycles-pp.tick_nohz_idle_enter
      0.00            +0.1        0.10 ± 47%  perf-profile.children.cycles-pp.unlock_up
      0.01 ±223%      +0.1        0.11 ± 13%  perf-profile.children.cycles-pp.d_lru_del
      0.00            +0.1        0.10 ± 19%  perf-profile.children.cycles-pp.btrfs_tree_read_lock_nested
      0.00            +0.1        0.10 ± 21%  perf-profile.children.cycles-pp.mem_cgroup_uncharge_skmem
      0.03 ±152%      +0.1        0.13 ± 32%  perf-profile.children.cycles-pp.__mod_timer
      0.02 ±142%      +0.1        0.12 ± 48%  perf-profile.children.cycles-pp.putname
      0.00            +0.1        0.10 ± 27%  perf-profile.children.cycles-pp._talloc_get_type_abort@plt
      0.01 ±223%      +0.1        0.11 ± 31%  perf-profile.children.cycles-pp.generic_fillattr
      0.00            +0.1        0.10 ± 34%  perf-profile.children.cycles-pp.smbd_smb2_request_process_query_directory
      0.00            +0.1        0.10 ± 35%  perf-profile.children.cycles-pp.__skb_clone
      0.00            +0.1        0.10 ± 50%  perf-profile.children.cycles-pp.btrfs_destroy_inode
      0.00            +0.1        0.11 ± 20%  perf-profile.children.cycles-pp.ndr_pull_align
      0.00            +0.1        0.11 ± 23%  perf-profile.children.cycles-pp.release_extent_buffer
      0.00            +0.1        0.11 ± 20%  perf-profile.children.cycles-pp.tcp_schedule_loss_probe
      0.00            +0.1        0.11 ± 13%  perf-profile.children.cycles-pp.vfs_stat_fsp
      0.00            +0.1        0.11 ± 26%  perf-profile.children.cycles-pp.__sk_mem_reduce_allocated
      0.00            +0.1        0.11 ± 47%  perf-profile.children.cycles-pp.btrfs_delete_delayed_dir_index
      0.00            +0.1        0.11 ± 35%  perf-profile.children.cycles-pp.inet6_csk_route_socket
      0.00            +0.1        0.11 ± 32%  perf-profile.children.cycles-pp.alloc_skb_with_frags
      0.00            +0.1        0.11 ± 34%  perf-profile.children.cycles-pp.ndr_pull_uint32
      0.00            +0.1        0.11 ± 25%  perf-profile.children.cycles-pp.wake_affine
      0.00            +0.1        0.11 ± 21%  perf-profile.children.cycles-pp.memset@plt
      0.00            +0.1        0.11 ± 32%  perf-profile.children.cycles-pp.tid_fd_revalidate
      0.09 ± 76%      +0.1        0.20 ± 15%  perf-profile.children.cycles-pp.__legitimize_mnt
      0.00            +0.1        0.11 ± 22%  perf-profile.children.cycles-pp.btrfs_opendir
      0.00            +0.1        0.12 ± 33%  perf-profile.children.cycles-pp.next_codepoint_handle_ext
      0.05 ± 84%      +0.1        0.16 ± 33%  perf-profile.children.cycles-pp.vfs_getattr_nosec
      0.00            +0.1        0.12 ± 29%  perf-profile.children.cycles-pp.synthetic_smb_fname
      0.00            +0.1        0.12 ± 37%  perf-profile.children.cycles-pp.tcp_check_space
      0.00            +0.1        0.12 ± 29%  perf-profile.children.cycles-pp.convert_string_error_handle
      0.00            +0.1        0.12 ± 23%  perf-profile.children.cycles-pp.free_extent_buffer
      0.00            +0.1        0.12 ± 15%  perf-profile.children.cycles-pp.__kfree_skb
      0.00            +0.1        0.12 ± 34%  perf-profile.children.cycles-pp.tcp_send_mss
      0.00            +0.1        0.12 ± 38%  perf-profile.children.cycles-pp.pid_revalidate
      0.06 ± 81%      +0.1        0.18 ± 31%  perf-profile.children.cycles-pp.generic_permission
      0.00            +0.1        0.12 ± 54%  perf-profile.children.cycles-pp.vfs_getxattr
      0.07 ± 57%      +0.1        0.19 ± 29%  perf-profile.children.cycles-pp.__kmalloc_cache_noprof
      0.00            +0.1        0.12 ± 43%  perf-profile.children.cycles-pp.__build_path_from_dentry_optional_prefix
      0.00            +0.1        0.12 ± 17%  perf-profile.children.cycles-pp.btrfs_read_lock_root_node
      0.01 ±223%      +0.1        0.13 ± 37%  perf-profile.children.cycles-pp.fdget_raw
      0.00            +0.1        0.12 ± 27%  perf-profile.children.cycles-pp.messaging_send_iov_from
      0.00            +0.1        0.12 ± 40%  perf-profile.children.cycles-pp.next_codepoint_handle
      0.00            +0.1        0.12 ± 25%  perf-profile.children.cycles-pp.smbd_dirptr_get_entry
      0.00            +0.1        0.13 ± 51%  perf-profile.children.cycles-pp.init_stat_ex_from_stat
      0.00            +0.1        0.13 ± 33%  perf-profile.children.cycles-pp.SMB2_open_init
      0.00            +0.1        0.13 ± 24%  perf-profile.children.cycles-pp.btrfs_get_16
      0.00            +0.1        0.13 ± 27%  perf-profile.children.cycles-pp.utf8_to_utf32
      0.00            +0.1        0.13 ± 24%  perf-profile.children.cycles-pp.__btrfs_release_delayed_node
      0.00            +0.1        0.13 ± 17%  perf-profile.children.cycles-pp.btrfs_get_32
      0.00            +0.1        0.13 ± 29%  perf-profile.children.cycles-pp.smb2_setup_request
      0.00            +0.1        0.13 ± 36%  perf-profile.children.cycles-pp.sock_alloc_send_pskb
      0.00            +0.1        0.13 ± 26%  perf-profile.children.cycles-pp.__btrfs_end_transaction
      0.00            +0.1        0.13 ± 38%  perf-profile.children.cycles-pp.sk_reset_timer
      0.00            +0.1        0.13 ± 25%  perf-profile.children.cycles-pp.skb_page_frag_refill
      0.00            +0.1        0.14 ± 45%  perf-profile.children.cycles-pp.btrfs_del_orphan_item
      0.00            +0.1        0.14 ± 26%  perf-profile.children.cycles-pp.getegid
      0.00            +0.1        0.14 ± 35%  perf-profile.children.cycles-pp.path_put
      0.00            +0.1        0.14 ± 23%  perf-profile.children.cycles-pp.proc_fd_link
      0.00            +0.1        0.14 ± 23%  perf-profile.children.cycles-pp.__smb2_plain_req_init
      0.00            +0.1        0.14 ± 15%  perf-profile.children.cycles-pp._talloc_array
      0.00            +0.1        0.14 ± 35%  perf-profile.children.cycles-pp.smb2_reconnect
      0.00            +0.1        0.14 ± 27%  perf-profile.children.cycles-pp.mem_cgroup_charge_skmem
      0.00            +0.1        0.14 ± 23%  perf-profile.children.cycles-pp.sk_page_frag_refill
      0.00            +0.1        0.14 ± 25%  perf-profile.children.cycles-pp._talloc_memdup
      0.00            +0.1        0.14 ± 19%  perf-profile.children.cycles-pp.btrfs_lookup_inode
      0.00            +0.1        0.14 ±  7%  perf-profile.children.cycles-pp.file_free
      0.00            +0.1        0.15 ± 19%  perf-profile.children.cycles-pp.__smb2_find_mid
      0.00            +0.1        0.15 ± 25%  perf-profile.children.cycles-pp.ndr_pull_udlong
      0.00            +0.1        0.15 ± 37%  perf-profile.children.cycles-pp.ndr_push_udlong
      0.00            +0.1        0.15 ± 26%  perf-profile.children.cycles-pp.smbd_smb2_request_done_ex
      0.00            +0.1        0.15 ± 23%  perf-profile.children.cycles-pp.close_file_smb
      0.00            +0.2        0.15 ± 32%  perf-profile.children.cycles-pp.__do_sys_getcwd
      0.00            +0.2        0.15 ± 23%  perf-profile.children.cycles-pp._nettle_chacha_core
      0.00            +0.2        0.15 ± 31%  perf-profile.children.cycles-pp.ndr_push_uint8
      0.10 ± 69%      +0.2        0.25 ± 28%  perf-profile.children.cycles-pp.cfree
      0.00            +0.2        0.16 ± 20%  perf-profile.children.cycles-pp.cifs_prime_dcache
      0.00            +0.2        0.16 ± 24%  perf-profile.children.cycles-pp.smbd_smb2_request_process_create
      0.07 ± 55%      +0.2        0.22 ± 38%  perf-profile.children.cycles-pp.call_function_single_prep_ipi
      0.00            +0.2        0.16 ± 17%  perf-profile.children.cycles-pp.tcp_event_new_data_sent
      0.00            +0.2        0.16 ± 13%  perf-profile.children.cycles-pp.tdb_parse_record
      0.14 ± 47%      +0.2        0.30 ± 31%  perf-profile.children.cycles-pp.__smp_call_single_queue
      0.02 ±141%      +0.2        0.18 ± 28%  perf-profile.children.cycles-pp.destroy_inode
      0.00            +0.2        0.16 ± 20%  perf-profile.children.cycles-pp._talloc_set_destructor
      0.00            +0.2        0.16 ± 14%  perf-profile.children.cycles-pp.try_to_unlazy_next
      0.00            +0.2        0.16 ± 33%  perf-profile.children.cycles-pp.ndr_push_expand
      0.00            +0.2        0.17 ± 35%  perf-profile.children.cycles-pp.__import_iovec
      0.00            +0.2        0.17 ± 28%  perf-profile.children.cycles-pp._talloc_pooled_object
      0.00            +0.2        0.17 ± 28%  perf-profile.children.cycles-pp.btrfs_delayed_update_inode
      0.04 ±115%      +0.2        0.20 ± 14%  perf-profile.children.cycles-pp.select_idle_sibling
      0.11 ± 56%      +0.2        0.27 ± 20%  perf-profile.children.cycles-pp.llist_reverse_order
      0.00            +0.2        0.17 ± 30%  perf-profile.children.cycles-pp._talloc_tos
      0.00            +0.2        0.17 ± 19%  perf-profile.children.cycles-pp.btrfs_lookup_dir_item
      0.12 ± 70%      +0.2        0.29 ± 16%  perf-profile.children.cycles-pp.path_init
      0.03 ±150%      +0.2        0.20 ± 17%  perf-profile.children.cycles-pp.__radix_tree_lookup
      0.00            +0.2        0.17 ± 18%  perf-profile.children.cycles-pp.__unix_dgram_recvmsg
      0.00            +0.2        0.17 ± 17%  perf-profile.children.cycles-pp.available_idle_cpu
      0.00            +0.2        0.17 ± 44%  perf-profile.children.cycles-pp.smbd_dirptr_lanman2_entry
      0.00            +0.2        0.17 ± 29%  perf-profile.children.cycles-pp.btrfs_match_dir_item_name
      0.01 ±223%      +0.2        0.18 ± 34%  perf-profile.children.cycles-pp.memcpy@plt
      0.00            +0.2        0.18 ± 25%  perf-profile.children.cycles-pp.geteuid
      0.00            +0.2        0.18 ± 36%  perf-profile.children.cycles-pp.import_iovec
      0.00            +0.2        0.18 ± 18%  perf-profile.children.cycles-pp._talloc_zero
      0.00            +0.2        0.18 ± 22%  perf-profile.children.cycles-pp.cp_smb_filename
      0.00            +0.2        0.18 ± 55%  perf-profile.children.cycles-pp.napi_consume_skb
      0.00            +0.2        0.18 ± 41%  perf-profile.children.cycles-pp.wait_for_xmitr
      0.00            +0.2        0.18 ± 31%  perf-profile.children.cycles-pp.loopback_xmit
      0.00            +0.2        0.19 ± 19%  perf-profile.children.cycles-pp.skb_attempt_defer_free
      0.00            +0.2        0.19 ± 34%  perf-profile.children.cycles-pp.dev_hard_start_xmit
      0.00            +0.2        0.19 ± 41%  perf-profile.children.cycles-pp.tcp_rcv_space_adjust
      0.15 ± 18%      +0.2        0.35 ± 20%  perf-profile.children.cycles-pp.user_path_at
      0.08 ±104%      +0.2        0.27 ± 16%  perf-profile.children.cycles-pp.rcu_all_qs
      0.00            +0.2        0.20 ± 33%  perf-profile.children.cycles-pp.ndr_push_uint32
      0.02 ±142%      +0.2        0.22 ± 26%  perf-profile.children.cycles-pp.sprintf
      0.00            +0.2        0.20 ± 21%  perf-profile.children.cycles-pp.read_extent_buffer
      0.00            +0.2        0.20 ± 47%  perf-profile.children.cycles-pp.memmove_extent_buffer
      0.27 ± 42%      +0.2        0.48 ± 13%  perf-profile.children.cycles-pp.select_task_rq
      0.00            +0.2        0.20 ± 21%  perf-profile.children.cycles-pp.btrfs_free_path
      0.00            +0.2        0.20 ±  7%  perf-profile.children.cycles-pp.btrfs_dirty_inode
      0.16 ± 23%      +0.2        0.38 ± 31%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.00            +0.2        0.22 ± 18%  perf-profile.children.cycles-pp.cifs_filldir
      0.00            +0.2        0.22 ± 28%  perf-profile.children.cycles-pp.lock_sock_nested
      0.00            +0.2        0.22 ± 23%  perf-profile.children.cycles-pp.btrfs_update_inode
      0.00            +0.2        0.22 ± 25%  perf-profile.children.cycles-pp.debuglevel_get_class@plt
      0.00            +0.2        0.23 ± 27%  perf-profile.children.cycles-pp.btrfs_insert_empty_items
      0.00            +0.2        0.23 ± 19%  perf-profile.children.cycles-pp.btrfs_set_token_32
      0.00            +0.2        0.23 ± 32%  perf-profile.children.cycles-pp.fgetxattr
      0.00            +0.2        0.24 ± 14%  perf-profile.children.cycles-pp.find_extent_buffer_nolock
      0.00            +0.2        0.24 ± 24%  perf-profile.children.cycles-pp.__alloc_skb
      0.00            +0.2        0.24 ± 24%  perf-profile.children.cycles-pp.tevent_common_invoke_fd_handler
      0.08 ± 57%      +0.2        0.32 ± 20%  perf-profile.children.cycles-pp._copy_to_user
      0.00            +0.2        0.24 ± 23%  perf-profile.children.cycles-pp.btrfs_get_token_32
      0.00            +0.2        0.24 ± 32%  perf-profile.children.cycles-pp.sock_poll
      0.00            +0.2        0.24 ± 29%  perf-profile.children.cycles-pp.getcwd
      0.00            +0.3        0.25 ± 13%  perf-profile.children.cycles-pp.__libc_fcntl64
      0.06 ±115%      +0.3        0.31 ± 16%  perf-profile.children.cycles-pp.complete_walk
      0.07 ±108%      +0.3        0.32 ± 14%  perf-profile.children.cycles-pp.vfs_fstat
      0.00            +0.3        0.26 ± 11%  perf-profile.children.cycles-pp.cifsConvertToUTF16
      0.00            +0.3        0.26 ± 17%  perf-profile.children.cycles-pp.start_transaction
      0.00            +0.3        0.26 ± 14%  perf-profile.children.cycles-pp.__inet6_lookup_established
      0.04 ±165%      +0.3        0.30 ± 11%  perf-profile.children.cycles-pp._copy_from_iter
      0.00            +0.3        0.26 ± 24%  perf-profile.children.cycles-pp.messaging_send_iov
      0.04 ±115%      +0.3        0.30 ± 21%  perf-profile.children.cycles-pp.proc_self_get_link
      0.00            +0.3        0.26 ± 19%  perf-profile.children.cycles-pp.release_sock
      0.00            +0.3        0.26 ± 22%  perf-profile.children.cycles-pp.proc_pid_get_link
      0.00            +0.3        0.27 ± 29%  perf-profile.children.cycles-pp.btrfs_insert_orphan_item
      0.00            +0.3        0.27 ± 18%  perf-profile.children.cycles-pp.simple_copy_to_iter
      0.00            +0.3        0.28 ± 33%  perf-profile.children.cycles-pp.skb_release_data
      0.00            +0.3        0.28 ± 16%  perf-profile.children.cycles-pp.__inet6_lookup_skb
      0.00            +0.3        0.28 ± 29%  perf-profile.children.cycles-pp.btrfs_orphan_add
      0.00            +0.3        0.28 ± 24%  perf-profile.children.cycles-pp._talloc_get_type_abort
      0.00            +0.3        0.28 ± 20%  perf-profile.children.cycles-pp.btrfs_release_path
      0.29 ± 29%      +0.3        0.57 ± 17%  perf-profile.children.cycles-pp.check_heap_object
      0.00            +0.3        0.30 ± 31%  perf-profile.children.cycles-pp.copy_msghdr_from_user
      0.00            +0.3        0.30 ± 16%  perf-profile.children.cycles-pp.smbd_smb2_request_dispatch
      0.00            +0.3        0.30 ± 12%  perf-profile.children.cycles-pp.skb_do_copy_data_nocache
      0.00            +0.3        0.31 ± 17%  perf-profile.children.cycles-pp.posix_lock_inode
      0.00            +0.3        0.31 ± 29%  perf-profile.children.cycles-pp.tcp_stream_alloc_skb
      0.00            +0.3        0.31 ± 29%  perf-profile.children.cycles-pp.__do_sys_setgroups
      0.00            +0.3        0.32 ± 26%  perf-profile.children.cycles-pp._talloc_free
      0.00            +0.3        0.32 ± 14%  perf-profile.children.cycles-pp.btrfs_getattr
      0.40 ± 41%      +0.3        0.73 ±  9%  perf-profile.children.cycles-pp.__d_lookup_rcu
      0.25 ± 51%      +0.3        0.58 ± 13%  perf-profile.children.cycles-pp.schedule_timeout
      0.04 ±109%      +0.3        0.37 ± 26%  perf-profile.children.cycles-pp.__x64_sys_chdir
      0.00            +0.3        0.34 ± 16%  perf-profile.children.cycles-pp.find_extent_buffer
      0.08 ± 66%      +0.3        0.43 ± 34%  perf-profile.children.cycles-pp.poll_idle
      0.17 ± 45%      +0.3        0.52 ±  9%  perf-profile.children.cycles-pp.inode_permission
      0.00            +0.3        0.35 ± 30%  perf-profile.children.cycles-pp.ep_item_poll
      0.02 ±142%      +0.3        0.37 ± 24%  perf-profile.children.cycles-pp.cp_new_stat
      0.01 ±223%      +0.4        0.36 ± 12%  perf-profile.children.cycles-pp.vfs_statx_path
      0.10 ± 93%      +0.4        0.45 ± 21%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.00            +0.4        0.37 ± 24%  perf-profile.children.cycles-pp.tdb_jenkins_hash
      0.28 ± 34%      +0.4        0.66 ±  9%  perf-profile.children.cycles-pp.malloc
      0.00            +0.4        0.40 ± 31%  perf-profile.children.cycles-pp.btrfs_bin_search
      0.00            +0.4        0.42 ± 29%  perf-profile.children.cycles-pp.memcpy_extent_buffer
      0.00            +0.4        0.43 ± 17%  perf-profile.children.cycles-pp._raw_spin_lock_bh
      0.00            +0.4        0.44 ± 14%  perf-profile.children.cycles-pp.fcntl_setlk
      0.01 ±223%      +0.4        0.45 ± 17%  perf-profile.children.cycles-pp.ep_autoremove_wake_function
      0.00            +0.4        0.45 ± 16%  perf-profile.children.cycles-pp.debuglevel_get_class
      0.44 ± 27%      +0.5        0.90 ± 10%  perf-profile.children.cycles-pp.__check_object_size
      0.00            +0.5        0.46 ± 22%  perf-profile.children.cycles-pp.tcp_clean_rtx_queue
      0.00            +0.5        0.47 ± 16%  perf-profile.children.cycles-pp.cifs_strndup_to_utf16
      0.00            +0.5        0.48 ± 16%  perf-profile.children.cycles-pp.cifs_convert_path_to_utf16
      0.00            +0.5        0.48 ± 24%  perf-profile.children.cycles-pp.unix_dgram_sendmsg
      0.29 ± 42%      +0.5        0.77 ± 11%  perf-profile.children.cycles-pp.strncpy_from_user
      0.00            +0.5        0.49 ± 21%  perf-profile.children.cycles-pp.btrfs_truncate_inode_items
      0.00            +0.5        0.50 ± 12%  perf-profile.children.cycles-pp.do_fcntl
      0.00            +0.5        0.50 ± 17%  perf-profile.children.cycles-pp.wait_woken
      0.00            +0.5        0.50 ± 15%  perf-profile.children.cycles-pp.btrfs_listxattr
      0.00            +0.5        0.51 ± 21%  perf-profile.children.cycles-pp.standard_receive3
      0.00            +0.5        0.52 ± 22%  perf-profile.children.cycles-pp.chdir
      0.19 ± 26%      +0.5        0.71 ± 15%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.82 ± 29%      +0.5        1.35 ± 12%  perf-profile.children.cycles-pp.try_to_block_task
      0.00            +0.5        0.54 ± 14%  perf-profile.children.cycles-pp.__wake_up_sync
      0.00            +0.5        0.54 ± 21%  perf-profile.children.cycles-pp.__do_sys_openat2
      0.02 ±223%      +0.6        0.57 ± 14%  perf-profile.children.cycles-pp.__x64_sys_fcntl
      0.00            +0.6        0.58 ± 25%  perf-profile.children.cycles-pp.read_block_for_search
      0.00            +0.6        0.60 ± 13%  perf-profile.children.cycles-pp.__memmove
      0.00            +0.6        0.60 ± 26%  perf-profile.children.cycles-pp.ep_send_events
      0.00            +0.6        0.61 ± 20%  perf-profile.children.cycles-pp.btrfs_real_readdir
      0.35 ± 31%      +0.6        0.98 ± 16%  perf-profile.children.cycles-pp.clear_bhb_loop
      0.00            +0.6        0.64 ± 26%  perf-profile.children.cycles-pp.__write_extent_buffer
      0.70 ± 26%      +0.6        1.34 ±  5%  perf-profile.children.cycles-pp.lookup_fast
      0.00            +0.6        0.65 ± 12%  perf-profile.children.cycles-pp.__btrfs_update_delayed_inode
      0.40 ± 34%      +0.7        1.05 ±  9%  perf-profile.children.cycles-pp.getname_flags
      0.56 ± 34%      +0.7        1.23 ±  5%  perf-profile.children.cycles-pp.step_into
      0.00            +0.7        0.67 ± 16%  perf-profile.children.cycles-pp.sk_wait_data
      0.01 ±223%      +0.7        0.68 ± 10%  perf-profile.children.cycles-pp.ep_poll_callback
      0.00            +0.7        0.70 ± 21%  perf-profile.children.cycles-pp.tcp_ack
      0.00            +0.7        0.72 ± 20%  perf-profile.children.cycles-pp.wait_for_response
      0.00            +0.7        0.72 ± 37%  perf-profile.children.cycles-pp.devkmsg_emit
      0.00            +0.7        0.72 ± 37%  perf-profile.children.cycles-pp.devkmsg_write
      0.18 ± 50%      +0.7        0.92 ± 10%  perf-profile.children.cycles-pp.pick_link
      0.00            +0.7        0.74 ± 13%  perf-profile.children.cycles-pp.sock_sendmsg
      0.00            +0.8        0.75 ± 12%  perf-profile.children.cycles-pp.btrfs_commit_inode_delayed_inode
      0.00            +0.8        0.75 ± 13%  perf-profile.children.cycles-pp.smb_send_kvec
      0.00            +0.8        0.78 ± 13%  perf-profile.children.cycles-pp.__skb_datagram_iter
      0.87 ± 23%      +0.8        1.65 ±  7%  perf-profile.children.cycles-pp.sched_ttwu_pending
      0.00            +0.8        0.80 ± 13%  perf-profile.children.cycles-pp.skb_copy_datagram_iter
      0.00            +0.8        0.81 ± 27%  perf-profile.children.cycles-pp.btrfs_lookup_xattr
      0.24 ± 45%      +0.9        1.16 ±  5%  perf-profile.children.cycles-pp.__wake_up_common
      1.06 ± 12%      +0.9        1.99 ±  7%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.25 ± 31%      +1.0        1.22 ±  8%  perf-profile.children.cycles-pp.__wake_up_sync_key
      0.00            +1.0        1.03 ± 12%  perf-profile.children.cycles-pp.__btrfs_unlink_inode
      0.54 ± 35%      +1.1        1.62 ±  6%  perf-profile.children.cycles-pp.vfs_statx
      0.00            +1.1        1.08 ± 25%  perf-profile.children.cycles-pp.btrfs_getxattr
      0.00            +1.1        1.09 ± 13%  perf-profile.children.cycles-pp.__SMB2_close
      0.00            +1.1        1.12 ± 14%  perf-profile.children.cycles-pp.cifs_closedir
      0.00            +1.1        1.15 ± 13%  perf-profile.children.cycles-pp.SMB2_query_directory
      0.00            +1.2        1.16 ± 23%  perf-profile.children.cycles-pp.__vfs_getxattr
      0.00            +1.2        1.17 ± 13%  perf-profile.children.cycles-pp.find_cifs_entry
      0.00            +1.2        1.18 ±  9%  perf-profile.children.cycles-pp.____sys_recvmsg
      0.00            +1.2        1.18 ± 16%  perf-profile.children.cycles-pp.syscall
      0.00            +1.2        1.18 ±  9%  perf-profile.children.cycles-pp.sock_def_readable
      0.00            +1.3        1.28 ± 10%  perf-profile.children.cycles-pp.path_listxattrat
      0.00            +1.3        1.35 ±  9%  perf-profile.children.cycles-pp.___sys_recvmsg
      0.00            +1.4        1.38 ±  8%  perf-profile.children.cycles-pp.btrfs_del_items
      0.00            +1.4        1.39 ±  8%  perf-profile.children.cycles-pp.__sys_recvmsg
      0.02 ±141%      +1.4        1.43 ± 26%  perf-profile.children.cycles-pp.schedule_hrtimeout_range
      0.12 ± 63%      +1.5        1.63 ± 10%  perf-profile.children.cycles-pp.__close_nocancel
      0.00            +1.5        1.53 ± 21%  perf-profile.children.cycles-pp.do_getxattr
      0.67 ± 34%      +1.6        2.22 ±  5%  perf-profile.children.cycles-pp.vfs_fstatat
      0.00            +1.6        1.57 ± 10%  perf-profile.children.cycles-pp.smb2_query_dir_first
      0.00            +1.6        1.59 ± 10%  perf-profile.children.cycles-pp._initiate_cifs_search
      0.00            +1.6        1.61 ± 10%  perf-profile.children.cycles-pp.recvmsg
      0.00            +1.6        1.63 ± 18%  perf-profile.children.cycles-pp.btrfs_search_slot
      0.00            +1.7        1.66 ± 13%  perf-profile.children.cycles-pp.btrfs_rmdir
      0.00            +1.7        1.73 ±  8%  perf-profile.children.cycles-pp.btrfs_evict_inode
      0.00            +1.7        1.74 ±  9%  perf-profile.children.cycles-pp.smb2_rmdir
      0.00            +1.8        1.76 ± 10%  perf-profile.children.cycles-pp.smb2_compound_op
      0.00            +1.8        1.80 ± 10%  perf-profile.children.cycles-pp.cifs_rmdir
      0.00            +1.8        1.82 ± 13%  perf-profile.children.cycles-pp.openat64
      0.02 ±223%      +1.9        1.89 ±  8%  perf-profile.children.cycles-pp.evict
      0.00            +1.9        1.91 ± 14%  perf-profile.children.cycles-pp.cifs_readv_from_socket
      0.26 ± 73%      +1.9        2.18 ±  7%  perf-profile.children.cycles-pp.__dentry_kill
      0.00            +2.0        1.95 ± 14%  perf-profile.children.cycles-pp.cifs_read_from_socket
      0.00            +2.0        1.99 ± 11%  perf-profile.children.cycles-pp.listxattr
      0.00            +2.1        2.06 ± 12%  perf-profile.children.cycles-pp.cifs_send_recv
      0.00            +2.1        2.14 ± 12%  perf-profile.children.cycles-pp.tcp_rcv_established
      0.00            +2.2        2.15 ± 12%  perf-profile.children.cycles-pp.tcp_v6_do_rcv
      0.76 ± 30%      +2.2        2.93 ±  7%  perf-profile.children.cycles-pp.__do_sys_newfstatat
      0.01 ±223%      +2.2        2.19 ± 25%  perf-profile.children.cycles-pp.ep_poll
      0.46 ± 32%      +2.2        2.65 ±  6%  perf-profile.children.cycles-pp.dput
      0.01 ±223%      +2.2        2.26 ± 25%  perf-profile.children.cycles-pp.do_epoll_wait
      0.00            +2.3        2.31 ± 10%  perf-profile.children.cycles-pp.tcp_sock_set_cork
      0.01 ±223%      +2.3        2.34 ± 25%  perf-profile.children.cycles-pp.__x64_sys_epoll_wait
      0.00            +2.4        2.36 ± 13%  perf-profile.children.cycles-pp.tcp_recvmsg_locked
      0.00            +2.6        2.56 ± 11%  perf-profile.children.cycles-pp.tcp_recvmsg
      0.00            +2.6        2.58 ± 11%  perf-profile.children.cycles-pp.inet6_recvmsg
      0.00            +2.6        2.62 ± 11%  perf-profile.children.cycles-pp.tcp_v6_rcv
      0.21 ± 29%      +2.7        2.89 ±  8%  perf-profile.children.cycles-pp.__close
      0.00            +2.7        2.68 ± 12%  perf-profile.children.cycles-pp.ip6_protocol_deliver_rcu
      0.00            +2.7        2.69 ± 12%  perf-profile.children.cycles-pp.ip6_input_finish
      0.00            +2.7        2.72 ± 14%  perf-profile.children.cycles-pp.cifs_demultiplex_thread
      0.74 ± 34%      +2.8        3.53 ±  6%  perf-profile.children.cycles-pp.filename_lookup
      0.00            +2.8        2.79 ± 10%  perf-profile.children.cycles-pp.sock_recvmsg
      0.00            +2.8        2.80 ± 12%  perf-profile.children.cycles-pp.__netif_receive_skb_one_core
      0.02 ±141%      +2.8        2.84 ± 12%  perf-profile.children.cycles-pp.__napi_poll
      0.00            +2.8        2.84 ± 12%  perf-profile.children.cycles-pp.process_backlog
      0.03 ±150%      +2.8        2.86 ± 22%  perf-profile.children.cycles-pp.epoll_wait
      0.00            +3.0        2.99 ± 13%  perf-profile.children.cycles-pp.filename_getxattr
      0.00            +3.1        3.14 ± 10%  perf-profile.children.cycles-pp.cifs_readdir
      0.74 ± 33%      +3.2        3.96 ±  6%  perf-profile.children.cycles-pp.path_lookupat
      0.00            +3.3        3.26 ± 10%  perf-profile.children.cycles-pp.__smb_send_rqst
      0.00            +3.3        3.28 ± 10%  perf-profile.children.cycles-pp.smb_send_rqst
      0.02 ±141%      +3.3        3.34 ± 14%  perf-profile.children.cycles-pp.net_rx_action
      0.00            +3.4        3.36 ± 13%  perf-profile.children.cycles-pp.path_getxattrat
      0.27 ± 29%      +3.4        3.64 ±  8%  perf-profile.children.cycles-pp.__fput
      0.00            +3.4        3.40 ± 13%  perf-profile.children.cycles-pp.getxattr
      0.39 ± 31%      +3.4        3.84 ± 10%  perf-profile.children.cycles-pp.fstatat64
      0.00            +3.6        3.61 ± 14%  perf-profile.children.cycles-pp.__local_bh_enable_ip
      0.00            +3.8        3.80 ± 10%  perf-profile.children.cycles-pp.vfs_rmdir
      0.26 ± 29%      +3.8        4.08 ±  8%  perf-profile.children.cycles-pp.__x64_sys_close
      0.00            +3.9        3.92 ± 15%  perf-profile.children.cycles-pp.__dev_queue_xmit
      0.00            +4.0        4.01 ± 11%  perf-profile.children.cycles-pp.do_rmdir
      0.00            +4.0        4.02 ± 16%  perf-profile.children.cycles-pp.ip6_finish_output2
      0.00            +4.1        4.06 ± 11%  perf-profile.children.cycles-pp.__x64_sys_unlinkat
      0.00            +4.1        4.10 ± 12%  perf-profile.children.cycles-pp.iterate_dir
      0.00            +4.1        4.11 ± 16%  perf-profile.children.cycles-pp.ip6_finish_output
      0.00            +4.2        4.18 ± 11%  perf-profile.children.cycles-pp.__x64_sys_getdents64
      0.00            +4.2        4.20 ± 11%  perf-profile.children.cycles-pp.unlinkat
      0.00            +4.2        4.24 ± 15%  perf-profile.children.cycles-pp.ip6_xmit
      0.00            +4.4        4.40 ± 15%  perf-profile.children.cycles-pp.inet6_csk_xmit
      0.00            +4.4        4.42 ± 15%  perf-profile.children.cycles-pp.tcp_sendmsg_locked
      0.00            +4.5        4.46 ± 15%  perf-profile.children.cycles-pp.____sys_sendmsg
      0.00            +4.5        4.47 ± 12%  perf-profile.children.cycles-pp.getdents64
      0.00            +4.5        4.54 ± 10%  perf-profile.children.cycles-pp.compound_send_recv
      0.00            +4.6        4.62 ± 15%  perf-profile.children.cycles-pp.tcp_sendmsg
      0.00            +4.7        4.66 ± 16%  perf-profile.children.cycles-pp.___sys_sendmsg
      0.00            +4.7        4.70 ± 17%  perf-profile.children.cycles-pp.__sys_sendmsg
      0.00            +4.8        4.82 ± 14%  perf-profile.children.cycles-pp.__tcp_transmit_skb
      0.00            +4.9        4.94 ± 16%  perf-profile.children.cycles-pp.sendmsg
      0.00            +5.4        5.36 ± 13%  perf-profile.children.cycles-pp.tcp_write_xmit
      0.00            +5.4        5.38 ± 13%  perf-profile.children.cycles-pp.__tcp_push_pending_frames
     30.83 ±  3%     +10.0       40.86 ±  2%  perf-profile.children.cycles-pp.do_syscall_64
     30.92 ±  3%     +10.2       41.08 ±  2%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     16.14 ±  8%      -3.7       12.40 ±  4%  perf-profile.self.cycles-pp.intel_idle
      2.82 ± 22%      -2.0        0.86 ± 30%  perf-profile.self.cycles-pp.update_sg_lb_stats
      1.57 ± 18%      -1.1        0.44 ± 30%  perf-profile.self.cycles-pp.cpuidle_enter_state
      1.30 ± 25%      -1.1        0.20 ± 78%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      1.11 ± 12%      -0.7        0.42 ± 15%  perf-profile.self.cycles-pp.idle_cpu
      0.92 ± 24%      -0.6        0.29 ± 44%  perf-profile.self.cycles-pp.delay_tsc
      0.77 ± 22%      -0.5        0.24 ± 50%  perf-profile.self.cycles-pp.next_uptodate_folio
      0.66 ± 55%      -0.5        0.16 ± 34%  perf-profile.self.cycles-pp.update_sg_wakeup_stats
      0.62 ± 32%      -0.4        0.20 ± 51%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.52 ± 17%      -0.4        0.11 ± 34%  perf-profile.self.cycles-pp.fold_vm_zone_numa_events
      0.56 ± 20%      -0.4        0.16 ± 34%  perf-profile.self.cycles-pp.vma_interval_tree_insert
      0.50 ± 16%      -0.4        0.10 ± 59%  perf-profile.self.cycles-pp.filemap_map_pages
      0.94 ± 31%      -0.4        0.58 ±  9%  perf-profile.self.cycles-pp.menu_select
      0.41 ± 27%      -0.4        0.04 ±100%  perf-profile.self.cycles-pp.run_posix_cpu_timers
      0.38 ± 32%      -0.3        0.04 ±101%  perf-profile.self.cycles-pp.read_counters
      0.38 ± 43%      -0.3        0.05 ± 75%  perf-profile.self.cycles-pp.strnlen_user
      0.61 ± 29%      -0.3        0.28 ± 11%  perf-profile.self.cycles-pp.update_rq_clock
      0.40 ± 31%      -0.3        0.09 ± 31%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.36 ± 17%      -0.3        0.06 ± 73%  perf-profile.self.cycles-pp._IO_fwrite
      0.39 ± 29%      -0.3        0.12 ± 41%  perf-profile.self.cycles-pp.sync_regs
      0.30 ± 51%      -0.3        0.05 ± 79%  perf-profile.self.cycles-pp.evlist__id2sid
      0.33 ± 24%      -0.2        0.09 ± 35%  perf-profile.self.cycles-pp.zap_present_ptes
      0.30 ± 33%      -0.2        0.07 ± 22%  perf-profile.self.cycles-pp.rb_next
      0.30 ± 31%      -0.2        0.07 ± 56%  perf-profile.self.cycles-pp.fdget_pos
      0.38 ± 30%      -0.2        0.17 ± 40%  perf-profile.self.cycles-pp.update_load_avg
      0.34 ± 26%      -0.2        0.13 ± 44%  perf-profile.self.cycles-pp._find_next_and_bit
      0.29 ± 23%      -0.2        0.09 ± 52%  perf-profile.self.cycles-pp.cpu_util
      0.27 ± 37%      -0.2        0.06 ± 76%  perf-profile.self.cycles-pp.tsc_verify_tsc_adjust
      0.26 ± 31%      -0.2        0.05 ± 76%  perf-profile.self.cycles-pp.__hrtimer_next_event_base
      0.26 ± 56%      -0.2        0.06 ± 14%  perf-profile.self.cycles-pp.tick_check_oneshot_broadcast_this_cpu
      0.29 ± 21%      -0.2        0.10 ± 20%  perf-profile.self.cycles-pp.sched_balance_newidle
      0.26 ± 41%      -0.2        0.08 ±103%  perf-profile.self.cycles-pp.get_jiffies_update
      0.21 ± 41%      -0.2        0.03 ±111%  perf-profile.self.cycles-pp.error_entry
      0.29 ± 35%      -0.2        0.11 ± 19%  perf-profile.self.cycles-pp.update_irq_load_avg
      0.23 ± 26%      -0.2        0.06 ± 87%  perf-profile.self.cycles-pp.__percpu_counter_sum
      0.26 ± 23%      -0.2        0.09 ± 22%  perf-profile.self.cycles-pp.get_cpu_device
      0.21 ± 48%      -0.2        0.04 ±118%  perf-profile.self.cycles-pp.check_cpu_stall
      0.20 ± 25%      -0.2        0.03 ±101%  perf-profile.self.cycles-pp.irqtime_account_process_tick
      0.23 ± 29%      -0.2        0.08 ± 49%  perf-profile.self.cycles-pp.ct_kernel_enter
      0.24 ± 31%      -0.2        0.09 ± 50%  perf-profile.self.cycles-pp.down_write
      0.21 ± 35%      -0.1        0.06 ± 81%  perf-profile.self.cycles-pp.sysvec_apic_timer_interrupt
      0.20 ± 37%      -0.1        0.06 ± 74%  perf-profile.self.cycles-pp.mas_walk
      0.17 ± 26%      -0.1        0.03 ±102%  perf-profile.self.cycles-pp.menu_reflect
      0.22 ± 56%      -0.1        0.08 ± 33%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.25 ± 33%      -0.1        0.12 ± 16%  perf-profile.self.cycles-pp.mutex_unlock
      0.22 ± 30%      -0.1        0.09 ± 48%  perf-profile.self.cycles-pp.arch_scale_freq_tick
      0.17 ± 55%      -0.1        0.05 ± 79%  perf-profile.self.cycles-pp.obj_cgroup_charge
      0.16 ± 31%      -0.1        0.04 ±106%  perf-profile.self.cycles-pp.pick_task_fair
      0.20 ± 27%      -0.1        0.09 ± 26%  perf-profile.self.cycles-pp.__get_user_8
      0.15 ± 32%      -0.1        0.04 ± 80%  perf-profile.self.cycles-pp.folios_put_refs
      0.16 ± 24%      -0.1        0.06 ± 51%  perf-profile.self.cycles-pp.cpuidle_not_available
      0.21 ± 31%      -0.1        0.10 ± 13%  perf-profile.self.cycles-pp.up_write
      0.19 ± 39%      -0.1        0.08 ± 55%  perf-profile.self.cycles-pp._nohz_idle_balance
      0.12 ± 48%      -0.1        0.04 ± 72%  perf-profile.self.cycles-pp.rcu_nocb_flush_deferred_wakeup
      0.12 ± 20%      -0.1        0.07 ± 71%  perf-profile.self.cycles-pp.ct_kernel_exit_state
      0.04 ± 70%      +0.0        0.08 ± 16%  perf-profile.self.cycles-pp.fdget
      0.02 ±141%      +0.1        0.07 ± 26%  perf-profile.self.cycles-pp.check_stack_object
      0.02 ±141%      +0.1        0.08 ± 17%  perf-profile.self.cycles-pp.pick_link
      0.02 ±141%      +0.1        0.08 ± 29%  perf-profile.self.cycles-pp.__errno_location
      0.01 ±223%      +0.1        0.07 ± 16%  perf-profile.self.cycles-pp.mntput_no_expire
      0.01 ±223%      +0.1        0.07 ± 32%  perf-profile.self.cycles-pp.schedule_idle
      0.00            +0.1        0.06 ± 23%  perf-profile.self.cycles-pp.ndr_pull_xattr_DosInfo
      0.00            +0.1        0.06 ± 27%  perf-profile.self.cycles-pp._tevent_loop_once
      0.00            +0.1        0.07 ± 30%  perf-profile.self.cycles-pp.sock_poll
      0.00            +0.1        0.07 ± 14%  perf-profile.self.cycles-pp.vfs_stat_fsp
      0.01 ±223%      +0.1        0.08 ± 33%  perf-profile.self.cycles-pp.__mod_timer
      0.00            +0.1        0.07 ± 37%  perf-profile.self.cycles-pp.tcp_schedule_loss_probe
      0.00            +0.1        0.08 ± 35%  perf-profile.self.cycles-pp.__local_bh_enable_ip
      0.00            +0.1        0.08 ± 34%  perf-profile.self.cycles-pp.memset@plt
      0.07 ± 27%      +0.1        0.15 ± 26%  perf-profile.self.cycles-pp.__check_object_size
      0.00            +0.1        0.08 ± 38%  perf-profile.self.cycles-pp.btrfs_del_items
      0.00            +0.1        0.09 ± 18%  perf-profile.self.cycles-pp._raw_read_lock_irqsave
      0.00            +0.1        0.09 ± 24%  perf-profile.self.cycles-pp.ip6_finish_output
      0.00            +0.1        0.09 ± 53%  perf-profile.self.cycles-pp.ip6_finish_output2
      0.00            +0.1        0.09 ± 41%  perf-profile.self.cycles-pp.ndr_pull_uint32
      0.02 ±142%      +0.1        0.11 ± 22%  perf-profile.self.cycles-pp.cpus_share_cache
      0.00            +0.1        0.09 ± 27%  perf-profile.self.cycles-pp.smbd_smb2_request_process_query_directory
      0.00            +0.1        0.09 ± 30%  perf-profile.self.cycles-pp.__smb2_find_mid
      0.00            +0.1        0.09 ± 28%  perf-profile.self.cycles-pp.read_extent_buffer
      0.00            +0.1        0.09 ± 15%  perf-profile.self.cycles-pp.release_extent_buffer
      0.00            +0.1        0.09 ± 30%  perf-profile.self.cycles-pp.synthetic_smb_fname
      0.00            +0.1        0.09 ± 42%  perf-profile.self.cycles-pp.unlock_up
      0.02 ±142%      +0.1        0.11 ± 26%  perf-profile.self.cycles-pp.lookup_fast
      0.00            +0.1        0.10 ± 18%  perf-profile.self.cycles-pp.close_file_smb
      0.02 ±142%      +0.1        0.11 ± 45%  perf-profile.self.cycles-pp.putname
      0.09 ± 76%      +0.1        0.18 ± 16%  perf-profile.self.cycles-pp.__legitimize_mnt
      0.00            +0.1        0.10 ± 19%  perf-profile.self.cycles-pp.start_transaction
      0.00            +0.1        0.10 ± 24%  perf-profile.self.cycles-pp._talloc_get_type_abort@plt
      0.00            +0.1        0.10 ± 39%  perf-profile.self.cycles-pp.next_codepoint_handle_ext
      0.04 ± 71%      +0.1        0.14 ± 32%  perf-profile.self.cycles-pp.vfs_getattr_nosec
      0.00            +0.1        0.10 ± 25%  perf-profile.self.cycles-pp._talloc_set_destructor
      0.00            +0.1        0.10 ± 40%  perf-profile.self.cycles-pp.next_codepoint_handle
      0.00            +0.1        0.10 ± 26%  perf-profile.self.cycles-pp._talloc_array
      0.00            +0.1        0.11 ± 32%  perf-profile.self.cycles-pp._talloc_memdup
      0.00            +0.1        0.11 ± 27%  perf-profile.self.cycles-pp.convert_string_error_handle
      0.00            +0.1        0.11 ± 22%  perf-profile.self.cycles-pp.ip6_xmit
      0.00            +0.1        0.11 ± 33%  perf-profile.self.cycles-pp.smbd_dirptr_get_entry
      0.05 ± 82%      +0.1        0.16 ± 31%  perf-profile.self.cycles-pp.generic_permission
      0.00            +0.1        0.11 ± 34%  perf-profile.self.cycles-pp.ndr_push_uint8
      0.01 ±223%      +0.1        0.12 ± 34%  perf-profile.self.cycles-pp.fdget_raw
      0.00            +0.1        0.11 ± 37%  perf-profile.self.cycles-pp.tcp_check_space
      0.11 ± 40%      +0.1        0.22 ± 25%  perf-profile.self.cycles-pp.inode_permission
      0.06 ± 80%      +0.1        0.17 ± 43%  perf-profile.self.cycles-pp.step_into
      0.00            +0.1        0.12 ± 33%  perf-profile.self.cycles-pp.utf8_to_utf32
      0.00            +0.1        0.12 ± 21%  perf-profile.self.cycles-pp.__smb_send_rqst
      0.00            +0.1        0.12 ± 30%  perf-profile.self.cycles-pp.btrfs_get_16
      0.00            +0.1        0.12 ± 13%  perf-profile.self.cycles-pp.btrfs_get_32
      0.00            +0.1        0.12 ± 40%  perf-profile.self.cycles-pp.tcp_write_xmit
      0.00            +0.1        0.12 ± 30%  perf-profile.self.cycles-pp._talloc_pooled_object
      0.00            +0.1        0.12 ± 22%  perf-profile.self.cycles-pp.ndr_pull_udlong
      0.00            +0.1        0.12 ± 23%  perf-profile.self.cycles-pp.cifsConvertToUTF16
      0.01 ±223%      +0.1        0.14 ± 34%  perf-profile.self.cycles-pp.memcpy@plt
      0.00            +0.1        0.13 ± 22%  perf-profile.self.cycles-pp.skb_page_frag_refill
      0.00            +0.1        0.13 ± 19%  perf-profile.self.cycles-pp.btrfs_getattr
      0.00            +0.1        0.13 ± 39%  perf-profile.self.cycles-pp.smbd_smb2_request_process_create
      0.00            +0.1        0.13 ± 44%  perf-profile.self.cycles-pp.tcp_ack
      0.00            +0.1        0.14 ± 34%  perf-profile.self.cycles-pp.ndr_push_expand
      0.00            +0.1        0.14 ± 21%  perf-profile.self.cycles-pp.tdb_parse_record
      0.08 ± 91%      +0.1        0.21 ± 20%  perf-profile.self.cycles-pp.try_to_wake_up
      0.00            +0.1        0.14 ± 16%  perf-profile.self.cycles-pp._talloc_zero
      0.00            +0.1        0.14 ± 25%  perf-profile.self.cycles-pp.smbd_smb2_request_done_ex
      0.00            +0.1        0.14 ± 26%  perf-profile.self.cycles-pp._nettle_chacha_core
      0.26 ± 27%      +0.1        0.40 ±  8%  perf-profile.self.cycles-pp.__schedule
      0.00            +0.2        0.15 ± 24%  perf-profile.self.cycles-pp.cp_smb_filename
      0.00            +0.2        0.15 ± 41%  perf-profile.self.cycles-pp.smbd_dirptr_lanman2_entry
      0.00            +0.2        0.15 ± 25%  perf-profile.self.cycles-pp.tcp_clean_rtx_queue
      0.00            +0.2        0.16 ± 33%  perf-profile.self.cycles-pp.ndr_push_uint32
      0.05 ± 84%      +0.2        0.20 ± 11%  perf-profile.self.cycles-pp.rcu_all_qs
      0.00            +0.2        0.16 ± 21%  perf-profile.self.cycles-pp.skb_attempt_defer_free
      0.07 ± 55%      +0.2        0.22 ± 39%  perf-profile.self.cycles-pp.call_function_single_prep_ipi
      0.00            +0.2        0.16 ± 24%  perf-profile.self.cycles-pp.tcp_rcv_established
      0.11 ± 56%      +0.2        0.27 ± 21%  perf-profile.self.cycles-pp.llist_reverse_order
      0.00            +0.2        0.16 ± 17%  perf-profile.self.cycles-pp.available_idle_cpu
      0.03 ±150%      +0.2        0.20 ± 21%  perf-profile.self.cycles-pp.__radix_tree_lookup
      0.00            +0.2        0.17 ± 25%  perf-profile.self.cycles-pp.fstatat64
      0.00            +0.2        0.17 ± 22%  perf-profile.self.cycles-pp.debuglevel_get_class@plt
      0.06 ± 81%      +0.2        0.24 ± 33%  perf-profile.self.cycles-pp.link_path_walk
      0.00            +0.2        0.18 ± 26%  perf-profile.self.cycles-pp.__tcp_transmit_skb
      0.12 ± 62%      +0.2        0.31 ± 19%  perf-profile.self.cycles-pp.__cond_resched
      0.00            +0.2        0.19 ± 39%  perf-profile.self.cycles-pp._talloc_get_type_abort
      0.00            +0.2        0.19 ± 26%  perf-profile.self.cycles-pp.__skb_datagram_iter
      0.00            +0.2        0.20 ± 23%  perf-profile.self.cycles-pp.btrfs_search_slot
      0.06 ± 56%      +0.2        0.25 ± 30%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.00            +0.2        0.20 ± 29%  perf-profile.self.cycles-pp.tcp_sendmsg_locked
      0.00            +0.2        0.21 ± 16%  perf-profile.self.cycles-pp.__inet6_lookup_established
      0.00            +0.2        0.22 ± 20%  perf-profile.self.cycles-pp.btrfs_get_token_32
      0.00            +0.2        0.22 ± 20%  perf-profile.self.cycles-pp.btrfs_set_token_32
      0.04 ±165%      +0.2        0.27 ± 17%  perf-profile.self.cycles-pp._copy_from_iter
      0.00            +0.2        0.23 ± 22%  perf-profile.self.cycles-pp._talloc_free
      0.00            +0.2        0.24 ± 30%  perf-profile.self.cycles-pp.skb_release_data
      0.07 ± 59%      +0.2        0.30 ± 19%  perf-profile.self.cycles-pp._copy_to_user
      0.00            +0.2        0.24 ± 27%  perf-profile.self.cycles-pp.net_rx_action
      0.12 ± 38%      +0.3        0.37 ± 20%  perf-profile.self.cycles-pp.check_heap_object
      0.00            +0.3        0.27 ± 14%  perf-profile.self.cycles-pp.smbd_smb2_request_dispatch
      0.00            +0.3        0.28 ± 20%  perf-profile.self.cycles-pp.debuglevel_get_class
      0.25 ± 56%      +0.3        0.56 ± 17%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.39 ± 40%      +0.3        0.71 ± 10%  perf-profile.self.cycles-pp.__d_lookup_rcu
      0.00            +0.3        0.34 ± 23%  perf-profile.self.cycles-pp.tdb_jenkins_hash
      0.00            +0.3        0.34 ± 22%  perf-profile.self.cycles-pp.tcp_recvmsg_locked
      0.10 ± 93%      +0.3        0.44 ± 24%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.06 ± 83%      +0.4        0.42 ± 33%  perf-profile.self.cycles-pp.poll_idle
      0.00            +0.4        0.39 ± 30%  perf-profile.self.cycles-pp.btrfs_bin_search
      0.21 ± 48%      +0.4        0.61 ± 10%  perf-profile.self.cycles-pp.malloc
      0.00            +0.4        0.42 ± 17%  perf-profile.self.cycles-pp._raw_spin_lock_bh
      0.00            +0.6        0.60 ± 13%  perf-profile.self.cycles-pp.__memmove
      0.35 ± 31%      +0.6        0.98 ± 15%  perf-profile.self.cycles-pp.clear_bhb_loop


***************************************************************************************************
lkp-icl-2sp6: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
=========================================================================================
compiler/cpufreq_governor/disk/fs2/fs/kconfig/rootfs/tbox_group/test/testcase:
  gcc-12/performance/1HDD/cifs/xfs/x86_64-rhel-9.4/debian-12-x86_64-20240206.cgz/lkp-icl-2sp6/singlestreamwritedirect.f/filebench

commit: 
  8de7606f0f ("cpuidle: menu: Eliminate outliers on both ends of the sample set")
  85975daeaa ("cpuidle: menu: Avoid discarding useful information")

8de7606f0fe2bf5a 85975daeaa4d6ec560bfcd354fc 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     33.75            -1.7%      33.18        boot-time.boot
    119687 ±  9%      -8.3%     109763 ±  5%  sched_debug.cpu.avg_idle.stddev
    105051            +1.8%     106938        vmstat.io.bo
    823752 ± 46%     -54.1%     377859 ± 45%  numa-numastat.node1.local_node
    878984 ± 41%     -47.2%     463834 ± 40%  numa-numastat.node1.numa_hit
      2.63 ±209%     -94.9%       0.13 ±  7%  perf-sched.sch_delay.max.ms.bit_wait.__wait_on_bit.out_of_line_wait_on_bit.netfs_unbuffered_write_iter_locked
      1.32 ±197%     -91.1%       0.12 ±  4%  perf-sched.sch_delay.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    732.99 ± 10%     -15.5%     619.68 ± 12%  perf-sched.wait_and_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    732.96 ± 10%     -15.5%     619.64 ± 12%  perf-sched.wait_time.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    456.12            +1.1%     461.26        filebench.sum_bytes_mb/s
     27370            +1.1%      27678        filebench.sum_operations
    456.13            +1.1%     461.27        filebench.sum_operations/s
      2.19            -1.1%       2.17        filebench.sum_time_ms/op
    456.00            +1.1%     461.20        filebench.sum_writes/s
  14427847 ± 26%     +33.4%   19245919 ±  6%  numa-meminfo.node0.FilePages
  11464303 ± 32%     +43.0%   16389081 ±  6%  numa-meminfo.node0.Inactive
  11464303 ± 32%     +43.0%   16389081 ±  6%  numa-meminfo.node0.Inactive(file)
  50157370 ±  7%      -9.4%   45419877 ±  2%  numa-meminfo.node0.MemFree
  15498401 ± 24%     +30.6%   20235895 ±  6%  numa-meminfo.node0.MemUsed
   7006849            +1.1%    7085773        proc-vmstat.nr_dirtied
   4204805            +2.3%    4302911        proc-vmstat.nr_dirty
   7214537            +2.4%    7386476        proc-vmstat.nr_file_pages
   6371446            +2.7%    6544461        proc-vmstat.nr_foll_pin_acquired
   6371330            +2.7%    6544348        proc-vmstat.nr_foll_pin_released
   6306394            +2.7%    6478320        proc-vmstat.nr_inactive_file
   4350806            +1.6%    4421837        proc-vmstat.nr_written
   6306394            +2.7%    6478320        proc-vmstat.nr_zone_inactive_file
   4220646            +2.3%    4319236        proc-vmstat.nr_zone_write_pending
  17403444            +1.6%   17687571        proc-vmstat.pgpgout
   3174870 ± 32%     +42.3%    4518963 ±  7%  numa-vmstat.node0.nr_dirtied
   3604142 ± 26%     +33.5%    4811989 ±  6%  numa-vmstat.node0.nr_file_pages
   2124183 ±141%    +208.1%    6545089        numa-vmstat.node0.nr_foll_pin_acquired
   2124146 ±141%    +208.1%    6544976        numa-vmstat.node0.nr_foll_pin_released
  12542179 ±  7%      -9.5%   11354469 ±  2%  numa-vmstat.node0.nr_free_pages
   2863250 ± 32%     +43.1%    4097775 ±  6%  numa-vmstat.node0.nr_inactive_file
   2863250 ± 32%     +43.1%    4097774 ±  6%  numa-vmstat.node0.nr_zone_inactive_file
   4248173 ± 70%    -100.0%      91.00 ±122%  numa-vmstat.node1.nr_foll_pin_acquired
   4248097 ± 70%    -100.0%      91.00 ±122%  numa-vmstat.node1.nr_foll_pin_released
    878743 ± 41%     -47.2%     463596 ± 40%  numa-vmstat.node1.numa_hit
    823511 ± 46%     -54.1%     377621 ± 45%  numa-vmstat.node1.numa_local
  12119619            -1.9%   11893902        perf-stat.i.branch-misses
  35828930            -6.7%   33423670        perf-stat.i.cache-references
      1.84            -2.4%       1.79        perf-stat.i.cpi
      0.61            +3.6%       0.63        perf-stat.i.ipc
      5.34            -0.2        5.17        perf-stat.overall.branch-miss-rate%
      9.87            +0.9       10.74 ±  6%  perf-stat.overall.cache-miss-rate%
      1.17            -2.6%       1.13        perf-stat.overall.cpi
      0.86            +2.7%       0.88        perf-stat.overall.ipc
  12058384            -1.5%   11877207        perf-stat.ps.branch-misses
  36139557            -6.1%   33925047        perf-stat.ps.cache-references
      3730            +1.3%       3779        perf-stat.ps.context-switches
      1.11 ± 13%      -0.3        0.81 ± 18%  perf-profile.calltrace.cycles-pp.tick_nohz_idle_stop_tick.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      1.07 ± 12%      -0.3        0.79 ± 19%  perf-profile.calltrace.cycles-pp.tick_nohz_stop_tick.tick_nohz_idle_stop_tick.cpuidle_idle_call.do_idle.cpu_startup_entry
      0.55 ± 46%      +0.3        0.87 ± 16%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel.setlocale
      0.55 ± 46%      +0.3        0.87 ± 16%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel
      1.20 ± 13%      -0.4        0.85 ± 15%  perf-profile.children.cycles-pp.tick_nohz_idle_stop_tick
      1.15 ± 12%      -0.3        0.82 ± 15%  perf-profile.children.cycles-pp.tick_nohz_stop_tick
      1.43 ± 10%      -0.3        1.12 ±  9%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.30 ± 26%      -0.1        0.17 ± 21%  perf-profile.children.cycles-pp.__get_unmapped_area
      0.38 ± 14%      -0.1        0.26 ± 40%  perf-profile.children.cycles-pp.nr_iowait_cpu
      0.46 ± 18%      -0.1        0.36 ± 15%  perf-profile.children.cycles-pp.show_stat
      0.14 ± 29%      -0.1        0.05 ± 64%  perf-profile.children.cycles-pp.list_add_leaf_cfs_rq
      0.04 ± 86%      +0.1        0.15 ± 30%  perf-profile.children.cycles-pp._exit
      0.03 ±108%      +0.1        0.14 ± 30%  perf-profile.children.cycles-pp.filemap_get_pages
      0.03 ±108%      +0.1        0.14 ± 30%  perf-profile.children.cycles-pp.filemap_get_read_batch
      0.02 ±223%      +0.1        0.14 ± 39%  perf-profile.children.cycles-pp.__ata_qc_complete
      0.10 ± 26%      +0.2        0.26 ±  8%  perf-profile.children.cycles-pp.filemap_read
      0.37 ± 35%      +0.2        0.53 ± 10%  perf-profile.children.cycles-pp.__run_timers
      0.66 ± 12%      +0.2        0.83 ±  9%  perf-profile.children.cycles-pp.finish_task_switch
      0.04 ± 71%      +0.2        0.29 ±142%  perf-profile.children.cycles-pp.__folio_end_writeback
      0.04 ± 71%      +0.2        0.29 ±142%  perf-profile.children.cycles-pp.folio_end_writeback
      1.23 ± 17%      +0.3        1.58 ±  8%  perf-profile.children.cycles-pp.try_to_wake_up
      2.62 ± 12%      +0.4        3.05 ±  5%  perf-profile.children.cycles-pp.x64_sys_call
      2.68 ±  6%      +0.5        3.15 ± 12%  perf-profile.children.cycles-pp.sched_balance_newidle
      0.38 ± 14%      -0.1        0.26 ± 40%  perf-profile.self.cycles-pp.nr_iowait_cpu
      0.14 ± 29%      -0.1        0.05 ± 64%  perf-profile.self.cycles-pp.list_add_leaf_cfs_rq
      0.05 ± 80%      +0.1        0.15 ± 27%  perf-profile.self.cycles-pp.alloc_vmap_area
      0.26 ± 22%      +0.2        0.44 ± 20%  perf-profile.self.cycles-pp.kmem_cache_alloc_noprof



***************************************************************************************************
lkp-icl-2sp5: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
=========================================================================================
compiler/cpufreq_governor/directio/disk/fstype/kconfig/media/rootfs/tbox_group/test/testcase/thread_nr:
  gcc-12/performance/directio/1SSD/ext4_no_jnl/x86_64-rhel-9.4/ssd/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp5/DRBM/fxmark/4

commit: 
  8de7606f0f ("cpuidle: menu: Eliminate outliers on both ends of the sample set")
  85975daeaa ("cpuidle: menu: Avoid discarding useful information")

8de7606f0fe2bf5a 85975daeaa4d6ec560bfcd354fc 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   1131064           +41.5%    1600002        cpuidle..usage
    486.00 ±  5%    +201.5%       1465 ±  6%  perf-c2c.HITM.local
      0.03 ± 20%     -50.3%       0.01 ± 36%  perf-sched.total_sch_delay.average.ms
  14347312 ± 38%     -49.3%    7267323 ± 72%  sched_debug.cfs_rq:/.avg_vruntime.max
  14347312 ± 38%     -49.3%    7267323 ± 72%  sched_debug.cfs_rq:/.min_vruntime.max
      0.81            +0.1        0.92 ±  2%  mpstat.cpu.all.irq%
      0.48 ±  2%      -0.2        0.26 ±  3%  mpstat.cpu.all.soft%
      2.57            -0.8        1.75 ±  3%  mpstat.cpu.all.sys%
     14804 ±  2%     +19.9%      17749 ±  2%  perf-stat.i.context-switches
      3.73 ±  2%     +19.7%       4.47 ±  3%  perf-stat.i.metric.K/sec
     14608 ±  2%     +19.9%      17512 ±  2%  perf-stat.ps.context-switches
    209850 ±  3%     +20.6%     253026 ±  3%  proc-vmstat.nr_foll_pin_acquired
    209859 ±  3%     +20.6%     253060 ±  3%  proc-vmstat.nr_foll_pin_released
   2377832           +21.9%    2898307        proc-vmstat.pgpgin
     25347 ±  2%     +22.8%      31128 ±  2%  vmstat.io.bi
     14877 ±  2%     +18.9%      17694 ±  2%  vmstat.system.cs
      9122 ±  3%     +41.6%      12915 ±  3%  vmstat.system.in
     24960 ± 36%     +73.1%      43214 ± 19%  numa-vmstat.node0.nr_active_anon
     18828 ± 41%     +85.6%      34938 ± 26%  numa-vmstat.node0.nr_anon_pages
    210207 ±  3%     +20.4%     253189 ±  3%  numa-vmstat.node0.nr_foll_pin_acquired
    210215 ±  3%     +20.5%     253223 ±  3%  numa-vmstat.node0.nr_foll_pin_released
     24960 ± 36%     +73.1%      43214 ± 19%  numa-vmstat.node0.nr_zone_active_anon
     44782 ± 17%     -36.4%      28468 ± 32%  numa-vmstat.node1.nr_active_anon
     44121 ± 17%     -36.8%      27905 ± 32%  numa-vmstat.node1.nr_anon_pages
     44782 ± 17%     -36.4%      28468 ± 32%  numa-vmstat.node1.nr_zone_active_anon
      2910            +3.9%       3025        turbostat.Bzy_MHz
     10130 ±  3%     +49.9%      15185 ±  3%  turbostat.C1
    569864 ±  2%    +140.2%    1368997        turbostat.C1E
      0.56 ±  2%      +0.8        1.37 ±  2%  turbostat.C1E%
    537096           -61.9%     204460        turbostat.C6
      1.74           +86.0%       3.24 ±  2%  turbostat.CPU%c1
    820197           +42.1%    1165477        turbostat.IRQ
      8915 ±  8%     +19.4%      10645 ±  4%  turbostat.POLL
     99588 ± 36%     +73.4%     172697 ± 19%  numa-meminfo.node0.Active
     99588 ± 36%     +73.4%     172697 ± 19%  numa-meminfo.node0.Active(anon)
     37742 ± 73%    +139.5%      90377 ± 39%  numa-meminfo.node0.AnonHugePages
     75122 ± 41%     +85.7%     139500 ± 26%  numa-meminfo.node0.AnonPages
     84070 ± 39%     +88.5%     158506 ± 25%  numa-meminfo.node0.AnonPages.max
    179088 ± 17%     -36.4%     113845 ± 32%  numa-meminfo.node1.Active
    179088 ± 17%     -36.4%     113845 ± 32%  numa-meminfo.node1.Active(anon)
    137933 ± 23%     -43.0%      78637 ± 43%  numa-meminfo.node1.AnonHugePages
    176447 ± 17%     -36.8%     111602 ± 32%  numa-meminfo.node1.AnonPages
    205517 ±  6%     -37.1%     129348 ± 32%  numa-meminfo.node1.AnonPages.max
     13.36 ± 84%      -8.4        4.94 ± 51%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
     13.36 ± 84%      -8.4        4.94 ± 51%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     13.36 ± 84%      -8.4        4.94 ± 51%  perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
      0.79 ±141%      +2.0        2.81 ± 31%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.79 ±141%      +2.0        2.81 ± 31%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
     13.36 ± 84%      -8.4        4.94 ± 51%  perf-profile.children.cycles-pp.start_secondary
     12.54 ± 67%      -6.8        5.71 ± 35%  perf-profile.children.cycles-pp.cpuidle_idle_call
      0.79 ±141%      +2.0        2.81 ± 31%  perf-profile.children.cycles-pp.do_filp_open
      0.79 ±141%      +2.0        2.81 ± 31%  perf-profile.children.cycles-pp.path_openat
      0.79 ±141%      +2.8        3.58 ± 49%  perf-profile.children.cycles-pp.__x64_sys_openat
      0.79 ±141%      +2.8        3.58 ± 49%  perf-profile.children.cycles-pp.do_sys_openat2
      0.18 ±  5%     -44.9%       0.10 ±  3%  fxmark.ssd_ext4_no_jnl_DRBM_4_directio.idle_sec
      0.09 ±  5%     -45.5%       0.05 ±  3%  fxmark.ssd_ext4_no_jnl_DRBM_4_directio.idle_util
      2.36           +17.8%       2.78        fxmark.ssd_ext4_no_jnl_DRBM_4_directio.irq_sec
      1.21           +16.4%       1.41        fxmark.ssd_ext4_no_jnl_DRBM_4_directio.irq_util
      1.50 ±  2%     -50.4%       0.75 ±  3%  fxmark.ssd_ext4_no_jnl_DRBM_4_directio.softirq_sec
      0.77 ±  2%     -51.0%       0.38 ±  4%  fxmark.ssd_ext4_no_jnl_DRBM_4_directio.softirq_util
      6.48           -45.6%       3.53        fxmark.ssd_ext4_no_jnl_DRBM_4_directio.sys_sec
      3.31           -46.2%       1.78        fxmark.ssd_ext4_no_jnl_DRBM_4_directio.sys_util
      0.69 ±  4%     -23.1%       0.53 ±  9%  fxmark.ssd_ext4_no_jnl_DRBM_4_directio.user_sec
      0.35 ±  4%     -24.0%       0.27 ±  9%  fxmark.ssd_ext4_no_jnl_DRBM_4_directio.user_util
    593614           +21.9%     723733        fxmark.ssd_ext4_no_jnl_DRBM_4_directio.works
     11872           +21.9%      14474        fxmark.ssd_ext4_no_jnl_DRBM_4_directio.works/sec
   1203810 ±  7%     +19.3%    1436084        fxmark.time.file_system_inputs
    160248 ±  7%     +18.1%     189302        fxmark.time.voluntary_context_switches





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


