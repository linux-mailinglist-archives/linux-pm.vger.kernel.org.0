Return-Path: <linux-pm+bounces-32974-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E90C4B3377B
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 09:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05AE03AABA2
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 07:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40CA27FB12;
	Mon, 25 Aug 2025 07:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qttqv92q"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBB0241139;
	Mon, 25 Aug 2025 07:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756105912; cv=fail; b=oE4ViWx586brM4/+RugLaDY3T8mQOTItML9QhYScFKoW+LbvEV7U9WD8L7cVy5Q0MY1yYrcv0le4DT/g/SpdpN41kCrvvObpc6DupBzkfQxk28z2eZMOPYp4rk8CfaDFTkGVSFtYQ8SowVrYyxr9krG6eP722F+IMkQlI44rWk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756105912; c=relaxed/simple;
	bh=bza9b88C+zV3Hv2EghC6rxnfwhOfr5MzhnWA0OyNrFU=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=B/x/w3ztCC11qqr5JMQqwh77O7CQnhMn+YDQ3NzOEJWeuKWvbDN/DSAN5k3fm9Zkp+VprZ2DfL4uD4ZOndd3hWKYWWFXlHso6RyIh2fcNGNx2ao/OWiyAjHeVwfyUA2mlZoIG0VRdnG5NKqsXd5cqvQKvNT+4qYAmgmYRj444u4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qttqv92q; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756105910; x=1787641910;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=bza9b88C+zV3Hv2EghC6rxnfwhOfr5MzhnWA0OyNrFU=;
  b=Qttqv92qyseV8oyz4UENlMJVqZ6RCrf53wGZlwOLrJNb9S2Y7FUMj9U2
   kDBL5MzoZxxg9IXq43QcCtWjv3ib+RLDoEuByK3qyDsOGm53gB0Lna/wz
   ojY0B1FN1T3Fsir79dc22aK6GLapridyWRxl3A+jOrXHIt5Ms3W+7hZJC
   QAg1gjuuOyzcSCpj3UujSNnECmQ5F5f3hqU/23NxPYeV97t+weVqHwEur
   cTNC8+QauMUWS7bkSKLYau8z7+2hQpN2DXwnvoDgslYJZpAzBKH/LiD9x
   80ViSaCj2/++CGyPZLFpsJkcZ5HO0/ZNSqxqTzysvpM/ItuVJ4U/d+e/Z
   A==;
X-CSE-ConnectionGUID: 8Zi9i7bZR7qV6jSRzb44tA==
X-CSE-MsgGUID: FiqN8Ko8S6KPG49sfq47OA==
X-IronPort-AV: E=McAfee;i="6800,10657,11532"; a="57514577"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="57514577"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 00:11:49 -0700
X-CSE-ConnectionGUID: XOru2IfTRTO2LD8O4TfOwQ==
X-CSE-MsgGUID: CFn28+ZlSj6iYWYSiXd1wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="174526157"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 00:11:49 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 25 Aug 2025 00:11:48 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 25 Aug 2025 00:11:48 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.86)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 25 Aug 2025 00:11:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j7ceoQQS6aLp4fRsnoTh02B26eVXWpfR4VQ/9J9/yIgJ3oP58v87c4uvOsbhmM98TBbXpsLp6nLmqK4sW5awpNNtrPxW2Ydr4zx3+ElJEK3pJhRMSzmF3ThL8Zv6kpxBZXvkZMzRSC1LjQN7toVvl0auwr5p7SWqoYnCydC3JqQ7Ggul807T+RRlK/qgFZDc9GO0QKZ3Qdm3QSX1ZO4kCsKWYw7GB9ilsJPyoUh/m8vWzjoMTtxC3EIGw+rzwGEljfSmoq7moom/b3mFewtpkXPAfubm8jXaQQJBgLHzBgIEvotgJd6oc+yEvVPCRsNR2SpXteIohhsaDbwqEWtJAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHd8zqzIgUZvQuY+9tdVVkHlR1h/gvzXVnFZOTRWnLY=;
 b=VuW1NcshKsIEyq7YgeMiabwC4tcNar3xvG6z5FUMPlpJ1IlBW2EUAsGhiQrlj5BUF6+mEV5LbqqFF53f3q/kShBgQTM2i1UBmEk8RT6z/iaNnEDkZT42VHomNsJWtEW40c3ArlSUCXSlNH0TCcZXDEGdA4e3cxEtiKAzh64Rb0BHC4iRjKTmNg0XPxiog8AU2wOkvAigLLeMdrsvARK7eYkwCUERMJP62mPMHHS/V4oCiS/E46bOF+GBYpwwsI4joqOeiPm50aAuwUj+GEnQnnoIMrzykX1hp6QZHh2HEVkbIubjkNcLaKN3Be+1Meky+n+Awzj/QTFJm97T+453vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH3PR11MB7390.namprd11.prod.outlook.com (2603:10b6:610:14e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 07:11:41 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 07:11:41 +0000
Date: Mon, 25 Aug 2025 15:11:32 +0800
From: kernel test robot <oliver.sang@intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Christian Loehle <christian.loehle@arm.com>, <linux-pm@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [cpuidle]  779b1a1cb1:
 perf-bench-sched-pipe.ops_per_sec 12.9% regression
Message-ID: <202508251419.d8117ed7-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:3:18::18) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH3PR11MB7390:EE_
X-MS-Office365-Filtering-Correlation-Id: 234e97db-8d57-4c08-2efe-08dde3a6a3d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?dAFy1XSPmLyh7czvJdpnTXmhcbnm67jrux6pLeiary6IQqCL6nhyIXvpTy?=
 =?iso-8859-1?Q?U+y7jqZuXzUz4dP70IUN0sskPP00udWoDYTmC94HrfMrnOtn/chz1q2gNF?=
 =?iso-8859-1?Q?YyonL3etPFIq9isEKXelMUJrLIkpk30+Aeodv+fqxHpuEIDZTNfvBq8Xwg?=
 =?iso-8859-1?Q?g9Hju/OZ/PUVjBBZYyJ/AQtw+yrM58DG0zrgBfC48xYEQ24lpokJJqjBcP?=
 =?iso-8859-1?Q?mEk7lyDQsFHgi/Ocunl0w9zEVpi4TSFxPFUQJr/3uWLEEKYYNsp40Gbx6D?=
 =?iso-8859-1?Q?3pdPCgLRkrGR3/pQsI4I/Vg4Lof0c+/fDQ6lve/ZSAbiYtIuEuFt2KBWOI?=
 =?iso-8859-1?Q?jvE1nKi6kH7zXY/PaRlZpR6MO5ijzYQv0nWlK6cv2SuM/OKxCQG7OSG/k5?=
 =?iso-8859-1?Q?K7bK2BrF6fG2071QZRQcC3/N7CKKc/9g7ODeksDVGejSF1fHhFFe2Pm3Ke?=
 =?iso-8859-1?Q?0XmAgntY1m7F8wQjtHkyCzFIBG1mOMdyU5i4th60YEeqQDhaw0EEe1+Rso?=
 =?iso-8859-1?Q?hk5PK8bz2nSRE/+m/Q0uU76KU7WvYDKDEgXgnFDvZqEWy4PU2AvZmijH21?=
 =?iso-8859-1?Q?WG8NfLDNvjGm2248A/SC/anheg1N/11vUQPzcROD2kUiyomuU+1eFcCxQ2?=
 =?iso-8859-1?Q?AW0BkZy+AAQP9DQ+MdA4aFZxLqc58eG6NzOmWh7frgla9x6Bpvm0nme8io?=
 =?iso-8859-1?Q?IYWtDpULyg9PjXshuIHrxRUbMr23rhRnr6Ri+zydIT8X3Yp/oTzKqEA6oL?=
 =?iso-8859-1?Q?B5NoYMNZ1EX7kluXfZ8gpjwJy1Eaq5aOopKFjFBh9S/8Gh1LB7Sjln/FGL?=
 =?iso-8859-1?Q?H+mA5GE3vfgbVno2w7OE0/PvnWk9YvO1A3mEY/hv+c+ag7LegXZ/kgjWk5?=
 =?iso-8859-1?Q?6XaXyjin306NkNM0tHG10y1rR/luopApRV9IY4YcUuyHZElKMP++lDg+85?=
 =?iso-8859-1?Q?Yu4fRH6BstCDHDW+zY52xvetAXDxPy8PiCIuFnR96AtKZDzqHjUxYUb/J+?=
 =?iso-8859-1?Q?tr0W3JCCmWl0ks+jRYYwvyqex0WtxfH4vCqbvVwHyZSM7ojAxvTcma52rZ?=
 =?iso-8859-1?Q?gPnD1HV/1ek990kQDUAx5F1GwhnHGt4DWI02u9LkPFY3hdrp+Us8lRuY0h?=
 =?iso-8859-1?Q?/RoU2mMZ8p1UtvaEIqBx72yJiG/hccQRA4Ej2g7FD6MRJ1DBWVNpERBj30?=
 =?iso-8859-1?Q?U/ozvK4Zd+S7BM3XetN4GigoeUuxVZC6Rd5fgS2pjg3UkWQQE2FgAscPsA?=
 =?iso-8859-1?Q?ZAPekvQrCnnHRstHhqVEOQy1Sc3UuMizs746VodgErRoGhaEEomWgXlki7?=
 =?iso-8859-1?Q?YnQ+ZwPmefKeYxQt1OV91io/ixxBrRl6G0pH6GbkyTNRHQBbzf0vEChbrC?=
 =?iso-8859-1?Q?6bzoIDRFJDL9UArpVEulmlHF7P7hVdq3uTjEmJwQVvppvWke9m1wfFz2q2?=
 =?iso-8859-1?Q?1HdMxkm3s9ZkanAZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?+ce4hDRQewqDUzXCSVrisVXe0CLLFc9uHRD2FPauKwEsVw0XbLjdI/uhmy?=
 =?iso-8859-1?Q?kdYQUV98Sc12bu147BA1JYoFiqZpzmymgFP38A6rJ/985KGnGGL4Ue7s25?=
 =?iso-8859-1?Q?WdwGbH1M4xvY42+Xl0rnMZWLfR8KtOygZg8YxOMAtWlzv2t/q1HPqJWMlQ?=
 =?iso-8859-1?Q?7JmF0GKf6+trF6QQbXS1BS5dJt+UjzuYxM4bjRK8Sm2fd7FntE0YGMEZdc?=
 =?iso-8859-1?Q?eXXachxELjvVvrK8KxiVOpdDAsOI7AF/Cx3SpKwiN0aBynR8AUxi4Om6FM?=
 =?iso-8859-1?Q?+h8EXtWJUcpomdFlON5oNp++1W2mNwxzDV7VbFHE5RC8mAz11Dvb0SmGWG?=
 =?iso-8859-1?Q?eFmNKvEq57x9XEKu5lpnHBzUWBfLV/yFbkxFFTODW539Mp/M1yesZtKCsx?=
 =?iso-8859-1?Q?zoOVYczd3tsl+98g4nKdGXN9vmvpbRoBeB5pwU9+KovbMbfnsVftNQ9+DA?=
 =?iso-8859-1?Q?mutIk4X0+DBZr4VwT529qEJjMPwLsGM6t5YSPLS99y1xz96k/wMkI21m8V?=
 =?iso-8859-1?Q?N3QHKlPGmdpXDdxzZWIKJqHz57huW761oM4FCjznD1IzpfNNGbOmIzGyf/?=
 =?iso-8859-1?Q?voOBEqIULEqcVsRlRd879DezJLS7kFlv4vRqTHb4ZwV2xP1XzJ9GrQnOUU?=
 =?iso-8859-1?Q?D2tTFT+6WEkgm3fYXPc5KxS9RvCvSMGs7Y8I1UNca5XPMATFrPfe42k2jG?=
 =?iso-8859-1?Q?IOUpyX4PauXgqcrKXBBPzMFsiyu4zs8mzC2Jp3pv5g2IVJj5rA6bJv+AHr?=
 =?iso-8859-1?Q?OQbePcxCAaDCCScsYkh2zjksUJyWMcgvXz4fgcWwNBKGdQiRKW9F+Klfmh?=
 =?iso-8859-1?Q?RLUitcRrBIzYVPpWaAZm8CVWvzcyf/XCFbHgP814PAWLKT/JirEKTPn7VH?=
 =?iso-8859-1?Q?JzIRWGrYSOcdDm8YIp2Pb+eihE7cu6pOCPkk0HGaMjJrtcVE/hF1Gq4eM8?=
 =?iso-8859-1?Q?t0FrzK3hzhF8aEnxmtMIcXO15TZwp97TIDgShf3HwmG+kS2MzjMMjDeDvA?=
 =?iso-8859-1?Q?FdTKKpknRauV2fYS+hp5BCZwHeEwP0ZzKgPdFxRJNRq/uoyjkkX6aw90g2?=
 =?iso-8859-1?Q?MOUkR7gGFXc1tXuD7MiLdUv/o7CXlMuUmKfqIhBG2/W3D/LX+oD1fK6ELi?=
 =?iso-8859-1?Q?7Nm0Pg7Ra7J2nSCXdr/6AYxhAaRc68+4nOxSfRU06HYAGLAWx+p6s/MmFo?=
 =?iso-8859-1?Q?CAdspEWI2LZHEaHdlvwrI8h+5dF1jN2xdDKOgItCxW+PgSVg6TU8PVS7AE?=
 =?iso-8859-1?Q?M9fVmwSatWwNyQtm1D/kr5Y15YLm+vmuMRSSMw5z7dIwJU3pgocjSaUmGC?=
 =?iso-8859-1?Q?xjDvv9AT6e2NsnIosdsPw+0bUOnAJI18XCp9aKDWaY39rfvRJtt4zsjTj8?=
 =?iso-8859-1?Q?Exyu9msQIhhAr1jjNMQhZ3HKGE+4iobuuJBWxFDf7XjKKN9YP3LOMFniM2?=
 =?iso-8859-1?Q?7L7FN1o8TTTx/y2s7oPSfe6sNCiJtY1ASjn+JSTOeBaEgkUBsOFRgU9poz?=
 =?iso-8859-1?Q?oHrdPzNPZQxNPtpL/5x33C6y0/MLwUrWCkqkmOXT4AwYYQglOt3M+xN9NX?=
 =?iso-8859-1?Q?W5hVmqGNIegtia8ZdjLYvDLvfpWyi1Pe8hTp467RjQymPrpdAmOE99hEUB?=
 =?iso-8859-1?Q?aLnm5KoV92C3sqWLfr0qXd7pFnRZ3eUBnEIJNh1NqEs1RtWuW+KnKvew?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 234e97db-8d57-4c08-2efe-08dde3a6a3d1
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 07:11:41.0965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tc6L9iijMw+qM9BImZIXic44ggLglQjb+fdpOalOvjdMq6dXwYyTS2Fn0aOxumccTjrAOby3psvlV1k6+KWmgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7390
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 12.9% regression of perf-bench-sched-pipe.ops_per_sec on:


commit: 779b1a1cb13ae17028aeddb2fbbdba97357a1e15 ("cpuidle: governors: menu: Avoid selecting states with too much latency")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[still regression on      linus/master 1b237f190eb3d36f52dffe07a40b5eb210280e00]
[still regression on linux-next/master 0f4c93f7eb861acab537dbe94441817a270537bf]

testcase: perf-bench-sched-pipe
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 192 threads 4 sockets Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz (Cascade Lake) with 176G memory
parameters:

	loops: 10000000ops
	mode: threads
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+-----------------------------------------------------------------------------+
| testcase: change | qperf: qperf.udp.latency 8.1% regression                                    |
| test machine     | 8 threads Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz (Skylake) with 16G memory |
| test parameters  | cluster=cs-localhost                                                        |
|                  | cpufreq_governor=performance                                                |
|                  | runtime=600s                                                                |
+------------------+-----------------------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202508251419.d8117ed7-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250825/202508251419.d8117ed7-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/loops/mode/rootfs/tbox_group/testcase:
  gcc-12/performance/x86_64-rhel-9.4/10000000ops/threads/debian-12-x86_64-20240206.cgz/lkp-csl-2sp10/perf-bench-sched-pipe

commit: 
  v6.17-rc2
  779b1a1cb1 ("cpuidle: governors: menu: Avoid selecting states with too much latency")

       v6.17-rc2 779b1a1cb13ae17028aeddb2fbb 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 9.124e+09           +14.6%  1.045e+10        cpuidle..time
     32.00 ± 23%     +37.5%      44.00 ± 10%  perf-c2c.DRAM.remote
      0.01 ± 22%     +55.3%       0.01 ± 18%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    805462           -12.0%     708615        vmstat.system.cs
     47.14 ±  4%      +8.9%      51.35 ±  5%  boot-time.boot
      8181 ±  5%      +9.4%       8955 ±  5%  boot-time.idle
     43305 ±  9%     +17.8%      51027 ±  6%  meminfo.AnonHugePages
    284445           +20.6%     343101        meminfo.Shmem
      0.50            -0.1        0.43        mpstat.cpu.all.sys%
      0.45 ±  2%      -0.1        0.40 ±  2%  mpstat.cpu.all.usr%
     70114 ± 40%     -74.6%      17817 ±146%  numa-vmstat.node3.nr_anon_pages
     68448 ±  3%     +22.0%      83539        numa-vmstat.node3.nr_shmem
     96.76 ±  2%     +11.5%     107.92 ±  2%  uptime.boot
     17588 ±  2%     +12.0%      19695 ±  3%  uptime.idle
    280480 ± 40%     -74.6%      71234 ±146%  numa-meminfo.node3.AnonPages
    323960 ± 34%     -69.7%      98297 ±102%  numa-meminfo.node3.AnonPages.max
     49659 ± 55%     -35.6%      32001 ±  3%  numa-meminfo.node3.Mapped
    273725 ±  3%     +21.4%     332416        numa-meminfo.node3.Shmem
    217049           -12.9%     189123        perf-bench-sched-pipe.ops_per_sec
     46.09           +14.8%      52.90        perf-bench-sched-pipe.time.elapsed_time
     46.09           +14.8%      52.90        perf-bench-sched-pipe.time.elapsed_time.max
     91.83           -12.2%      80.67        perf-bench-sched-pipe.time.percent_of_cpu_this_job_got
    243570            +5.6%     257111        proc-vmstat.nr_active_anon
    956368            +1.5%     970579        proc-vmstat.nr_file_pages
     28172            -5.2%      26711        proc-vmstat.nr_mapped
     71358           +19.9%      85579        proc-vmstat.nr_shmem
    243570            +5.6%     257111        proc-vmstat.nr_zone_active_anon
    454916            +4.5%     475605        proc-vmstat.pgfault
     49587 ±  4%      +8.5%      53826 ±  4%  sched_debug.cpu.clock.avg
     49598 ±  4%      +8.5%      53836 ±  4%  sched_debug.cpu.clock.max
     49568 ±  4%      +8.6%      53812 ±  4%  sched_debug.cpu.clock.min
     49456 ±  4%      +8.6%      53686 ±  4%  sched_debug.cpu.clock_task.avg
     49580 ±  4%      +8.5%      53811 ±  4%  sched_debug.cpu.clock_task.max
     49577 ±  4%      +8.5%      53816 ±  4%  sched_debug.cpu_clk
     48580 ±  4%      +8.7%      52811 ±  4%  sched_debug.ktime
     50297 ±  4%      +9.3%      54960 ±  5%  sched_debug.sched_clk
 2.211e+09           -15.9%  1.859e+09 ±  3%  perf-stat.i.branch-instructions
  60344331 ±  2%     -13.6%   52146391 ±  2%  perf-stat.i.branch-misses
   4974491 ±  5%     -15.9%    4185197 ±  7%  perf-stat.i.cache-misses
  80956268 ±  3%     -12.0%   71234171 ±  7%  perf-stat.i.cache-references
    854948           -12.6%     747062        perf-stat.i.context-switches
      1.19            +3.9%       1.24 ±  2%  perf-stat.i.cpi
 1.148e+10 ±  2%     -13.9%  9.886e+09        perf-stat.i.cpu-cycles
 1.031e+10           -14.7%   8.79e+09 ±  3%  perf-stat.i.instructions
      4.45           -12.7%       3.89        perf-stat.i.metric.K/sec
      7605 ±  2%      -7.4%       7042 ±  2%  perf-stat.i.minor-faults
      7605 ±  2%      -7.4%       7042 ±  2%  perf-stat.i.page-faults
      2.73            +0.1        2.80        perf-stat.overall.branch-miss-rate%
 2.162e+09           -15.7%  1.823e+09 ±  3%  perf-stat.ps.branch-instructions
  58974968 ±  2%     -13.3%   51107382 ±  2%  perf-stat.ps.branch-misses
   4857873 ±  5%     -15.6%    4100205 ±  7%  perf-stat.ps.cache-misses
  79195784 ±  3%     -11.8%   69883377 ±  7%  perf-stat.ps.cache-references
    836709           -12.4%     733164        perf-stat.ps.context-switches
 1.123e+10 ±  2%     -13.7%  9.698e+09        perf-stat.ps.cpu-cycles
 1.008e+10           -14.5%   8.62e+09 ±  3%  perf-stat.ps.instructions
      7359 ±  2%      -7.1%       6839 ±  2%  perf-stat.ps.minor-faults
      7359 ±  2%      -7.1%       6839 ±  2%  perf-stat.ps.page-faults
      3.97 ±107%      -3.2        0.75 ±223%  perf-profile.calltrace.cycles-pp.console_flush_all.console_unlock.vprintk_emit.devkmsg_emit.devkmsg_write
      3.97 ±107%      -3.2        0.75 ±223%  perf-profile.calltrace.cycles-pp.console_unlock.vprintk_emit.devkmsg_emit.devkmsg_write.vfs_write
      3.97 ±107%      -3.2        0.75 ±223%  perf-profile.calltrace.cycles-pp.devkmsg_emit.devkmsg_write.vfs_write.ksys_write.do_syscall_64
      3.97 ±107%      -3.2        0.75 ±223%  perf-profile.calltrace.cycles-pp.devkmsg_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.97 ±107%      -3.2        0.75 ±223%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      3.97 ±107%      -3.2        0.75 ±223%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
      3.97 ±107%      -3.2        0.75 ±223%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      3.97 ±107%      -3.2        0.75 ±223%  perf-profile.calltrace.cycles-pp.vprintk_emit.devkmsg_emit.devkmsg_write.vfs_write.ksys_write
      3.97 ±107%      -3.2        0.75 ±223%  perf-profile.calltrace.cycles-pp.write
      3.61 ±106%      -3.0        0.62 ±223%  perf-profile.calltrace.cycles-pp.serial8250_console_write.console_flush_all.console_unlock.vprintk_emit.devkmsg_emit
      3.45 ±105%      -2.9        0.56 ±223%  perf-profile.calltrace.cycles-pp.wait_for_lsr.serial8250_console_write.console_flush_all.console_unlock.vprintk_emit
      1.80 ± 53%      +1.0        2.84 ± 44%  perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.80 ± 53%      +1.0        2.84 ± 44%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call.do_syscall_64
      1.80 ± 53%      +1.0        2.84 ± 44%  perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.80 ± 53%      +1.0        2.84 ± 44%  perf-profile.calltrace.cycles-pp.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.97 ±107%      -3.2        0.75 ±223%  perf-profile.children.cycles-pp.console_flush_all
      3.97 ±107%      -3.2        0.75 ±223%  perf-profile.children.cycles-pp.console_unlock
      3.97 ±107%      -3.2        0.75 ±223%  perf-profile.children.cycles-pp.devkmsg_emit
      3.97 ±107%      -3.2        0.75 ±223%  perf-profile.children.cycles-pp.devkmsg_write
      3.97 ±107%      -3.2        0.75 ±223%  perf-profile.children.cycles-pp.vprintk_emit
      3.61 ±106%      -3.0        0.62 ±223%  perf-profile.children.cycles-pp.serial8250_console_write
      3.45 ±105%      -2.9        0.56 ±223%  perf-profile.children.cycles-pp.wait_for_lsr
      1.80 ± 53%      +1.0        2.84 ± 44%  perf-profile.children.cycles-pp.__x64_sys_exit_group


***************************************************************************************************
lkp-skl-d07: 8 threads Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz (Skylake) with 16G memory
=========================================================================================
cluster/compiler/cpufreq_governor/kconfig/rootfs/runtime/tbox_group/testcase:
  cs-localhost/gcc-12/performance/x86_64-rhel-9.4/debian-12-x86_64-20240206.cgz/600s/lkp-skl-d07/qperf

commit: 
  v6.17-rc2
  779b1a1cb1 ("cpuidle: governors: menu: Avoid selecting states with too much latency")

       v6.17-rc2 779b1a1cb13ae17028aeddb2fbb 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    861.00 ± 26%     -29.1%     610.40 ± 19%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    280319            -4.7%     267006        vmstat.system.cs
      4510            +4.3%       4706        qperf.tcp.latency
     13138 ± 17%     -28.1%       9451 ± 17%  qperf.time.involuntary_context_switches
  34417677            -4.8%   32782157        qperf.time.voluntary_context_switches
      3362            +8.1%       3634        qperf.udp.latency
 8.011e+08            -4.6%  7.642e+08        perf-stat.i.branch-instructions
  12882352            -3.6%   12424168        perf-stat.i.branch-misses
    281595            -4.7%     268383        perf-stat.i.context-switches
      1.54            -5.3%       1.46        perf-stat.i.cpi
 5.769e+09           -10.5%  5.161e+09        perf-stat.i.cpu-cycles
     44.97 ±  2%      -8.6%      41.11 ±  3%  perf-stat.i.cpu-migrations
     16208 ±  2%     -13.4%      14038 ±  3%  perf-stat.i.cycles-between-cache-misses
 4.094e+09            -4.1%  3.927e+09        perf-stat.i.instructions
      0.68            +7.6%       0.73        perf-stat.i.ipc
     35.20            -4.7%      33.55        perf-stat.i.metric.K/sec
      1.41           -16.0%       1.18 ± 33%  perf-stat.overall.cpi
 7.999e+08           -13.9%  6.888e+08 ± 33%  perf-stat.ps.branch-instructions
  12865498           -13.0%   11190853 ± 33%  perf-stat.ps.branch-misses
    281062           -14.2%     241224 ± 33%  perf-stat.ps.context-switches
  5.76e+09           -19.2%  4.652e+09 ± 33%  perf-stat.ps.cpu-cycles
     44.89 ±  2%     -17.5%      37.01 ± 33%  perf-stat.ps.cpu-migrations
 4.088e+09           -13.4%  3.539e+09 ± 33%  perf-stat.ps.instructions
 2.458e+12           -13.4%  2.128e+12 ± 33%  perf-stat.total.instructions
     24.74 ±  5%     -24.7        0.00        perf-profile.calltrace.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      5.80 ±  4%      -0.5        5.30 ±  3%  perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_udp
      1.01 ± 11%      +0.3        1.27 ± 12%  perf-profile.calltrace.cycles-pp.entry_SYSRETQ_unsafe_stack.read
      0.22 ±122%      +0.4        0.66 ±  8%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.16 ±152%      +0.5        0.62 ±  8%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      6.05 ±  3%      +0.6        6.64 ±  4%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      5.92 ±  3%      +0.6        6.51 ±  4%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      6.73 ±  3%      +0.8        7.51 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
      6.69 ±  3%      +0.8        7.48 ±  4%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     22.08 ±  5%     +19.4       41.52 ±  7%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     24.80 ±  6%     -24.8        0.00        perf-profile.children.cycles-pp.poll_idle
      0.38 ±  9%      -0.2        0.19 ± 19%  perf-profile.children.cycles-pp.local_clock_noinstr
      0.93 ±  6%      -0.2        0.76 ±  5%  perf-profile.children.cycles-pp.native_sched_clock
      0.35 ± 10%      -0.1        0.28 ±  7%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.14 ± 11%      -0.0        0.09 ± 14%  perf-profile.children.cycles-pp.call_function_single_prep_ipi
      0.22 ± 12%      -0.0        0.17 ± 12%  perf-profile.children.cycles-pp.get_cpu_device
      0.19 ±  8%      +0.1        0.25 ±  9%  perf-profile.children.cycles-pp.rseq_update_cpu_node_id
      0.48 ±  6%      +0.1        0.55 ±  4%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.49 ±  7%      +0.1        0.56 ±  4%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.16 ± 15%      +0.1        0.24 ±  9%  perf-profile.children.cycles-pp.run_client_udp_lat
      0.28 ± 12%      +0.1        0.36 ±  9%  perf-profile.children.cycles-pp.__softirqentry_text_end
      0.00            +0.1        0.09 ± 23%  perf-profile.children.cycles-pp.write@plt
      0.25 ± 13%      +0.1        0.34 ± 13%  perf-profile.children.cycles-pp.__netif_rx
      0.46 ±  7%      +0.1        0.56 ±  8%  perf-profile.children.cycles-pp.check_heap_object
      0.24 ± 14%      +0.1        0.35 ± 12%  perf-profile.children.cycles-pp.move_addr_to_user
      0.09 ± 14%      +0.1        0.19 ± 18%  perf-profile.children.cycles-pp.siphash_3u32
      0.19 ± 19%      +0.1        0.32 ± 11%  perf-profile.children.cycles-pp.__ip_select_ident
      0.59 ±  7%      +0.2        0.76 ±  7%  perf-profile.children.cycles-pp.__rseq_handle_notify_resume
      0.87 ±  9%      +0.2        1.04 ±  6%  perf-profile.children.cycles-pp.__check_object_size
      0.59 ± 11%      +0.2        0.78 ±  9%  perf-profile.children.cycles-pp.__ip_make_skb
      0.88 ±  9%      +0.2        1.09 ±  9%  perf-profile.children.cycles-pp.exit_to_user_mode_loop
      3.18 ±  3%      +0.3        3.43 ±  5%  perf-profile.children.cycles-pp.schedule_idle
      3.59 ±  6%      +0.5        4.09 ±  7%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      3.83 ±  6%      +0.5        4.37 ±  6%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      5.92 ±  3%      +0.6        6.51 ±  4%  perf-profile.children.cycles-pp.vfs_read
      6.05 ±  3%      +0.6        6.65 ±  4%  perf-profile.children.cycles-pp.ksys_read
     22.08 ±  5%     +19.5       41.53 ±  7%  perf-profile.children.cycles-pp.intel_idle
     24.57 ±  6%     -24.6        0.00        perf-profile.self.cycles-pp.poll_idle
      0.90 ±  7%      -0.2        0.73 ±  5%  perf-profile.self.cycles-pp.native_sched_clock
      0.13 ± 11%      -0.0        0.08 ± 18%  perf-profile.self.cycles-pp.call_function_single_prep_ipi
      0.21 ± 12%      -0.0        0.17 ± 11%  perf-profile.self.cycles-pp.get_cpu_device
      0.08 ± 25%      +0.0        0.12 ± 10%  perf-profile.self.cycles-pp.write
      0.19 ±  7%      +0.1        0.25 ±  9%  perf-profile.self.cycles-pp.rseq_update_cpu_node_id
      0.11 ± 18%      +0.1        0.18 ± 10%  perf-profile.self.cycles-pp.run_client_udp_lat
      0.11 ± 12%      +0.1        0.19 ± 13%  perf-profile.self.cycles-pp.recvfrom
      0.12 ± 17%      +0.1        0.20 ± 14%  perf-profile.self.cycles-pp.run_server_udp_lat
      0.21 ± 15%      +0.1        0.29 ± 17%  perf-profile.self.cycles-pp.enqueue_entity
      0.00            +0.1        0.08 ± 22%  perf-profile.self.cycles-pp.write@plt
      0.25 ±  9%      +0.1        0.33 ±  7%  perf-profile.self.cycles-pp.__softirqentry_text_end
      0.10 ± 18%      +0.1        0.19 ± 11%  perf-profile.self.cycles-pp.read
      0.09 ± 13%      +0.1        0.19 ± 19%  perf-profile.self.cycles-pp.siphash_3u32
      0.22 ± 15%      +0.1        0.34 ± 12%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.47 ± 13%      +0.1        0.60 ± 11%  perf-profile.self.cycles-pp.do_syscall_64
      0.29 ± 14%      +0.2        0.45 ± 12%  perf-profile.self.cycles-pp.schedule_timeout
      0.31 ± 10%      +0.3        0.61 ± 12%  perf-profile.self.cycles-pp.__skb_recv_udp
     22.08 ±  5%     +19.4       41.52 ±  7%  perf-profile.self.cycles-pp.intel_idle





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


