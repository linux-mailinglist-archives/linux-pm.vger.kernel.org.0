Return-Path: <linux-pm+bounces-42887-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFYlM+dTl2lPxAIAu9opvQ
	(envelope-from <linux-pm+bounces-42887-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 19:18:15 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D13F16196D
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 19:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B080B30A050A
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 18:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771083590BB;
	Thu, 19 Feb 2026 18:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="peeVxc2i"
X-Original-To: linux-pm@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010047.outbound.protection.outlook.com [52.101.201.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15650358D08;
	Thu, 19 Feb 2026 18:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771524893; cv=fail; b=B+snBm4Uy0yhXh2s6Et6sibmJKGm0Oi+mNw9SKjO9vQ++IeTBQSr8CaAeGv+8CPIkp8eRnT75xk9nKV23Pm47l9Ies1r7V64D6xD3dn+VzO3c0hh6j4bSyTo9UOyYxP82+X3s4yrzek5Et0Sx8UyHnjtke5+zxtmYpn4mJoWbq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771524893; c=relaxed/simple;
	bh=phTjtf1/DE6LJCNyx79DblbkgZfDJyq2YGUda8MvAus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VfXpanXQPm5rgEKRaFckRqyAy+mnvcuFdiaZy6Us43jIIkZbho5R6+e3Dri+kDd2I2Gq1tbFQBfNo65xn4ToifrIqfyhzhoHziKJC4uw744qAqnyReVpTT4I1okFA2c5O03pGOHunoWBm8UyIK3oQYutoQpQZdWrMl8gtRCHt9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=peeVxc2i; arc=fail smtp.client-ip=52.101.201.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hx9dEVmsbvYt+IYj+EQ8jTd6x0q8P0fYAZaG7CAYNu12jb9CW7mQvs3KfFkiMGEPrcl4DlUkP9PPm+h2K4Ye0X+U5R+RN0upivgGD0S+C0JdtkzdNIc6oWFuJgiu+fpLGbiNnN8VX9zjr0xixp8wlcVf5hAT24wvzTR4NFeTGoeX+c4gdPhhqoRxhHFLiLe6pIFbLQDwIL1sLpswxdpnzPNJIbrGdAeoutf66f4z1HA7ySdcJ5FQ60hVMD3jjqtd690D+m7Bx5+U1w0uHLEjc6hkejyp+Jogfd+ubOyGuxfhDHjD0cFv9mKUjwrb1BNLIEHfhp6HazO5HAmMXfmBrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oy47FXNBZGUaTYpJSJmSeUbKSVjt3hxBaBvV//CmgPw=;
 b=T0W/dBKJvnHxFeTDO9xR3BF3Yv7FH45NPwPcSM/eHxAlnVpzGmMcioLZ4TIcnjXFVAsRXncbWygLKUkwpsELAdKhhNgM+yUEnmv4twA4o8N+WJWebQX312urTdA7sloawvdzQp2RfIKDE/EH4JzbFUXtOU/je9x5J7aI1zcIhOANTRS23VwKOnNxIeNIq63x9CNsN3nR/Q2sFngvsS81Tj3I18nIfH3RET/jTagYrcnopkkGRKkGbf2d3k0Mb6o5smOv9Ur2UAQrXkW0ceQGu6L6OeTc9QIB2hTIX+rLKP5TmYS8eS/wiCFXxiHK4sMx33+pBDElZbaowSDeD07FPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oy47FXNBZGUaTYpJSJmSeUbKSVjt3hxBaBvV//CmgPw=;
 b=peeVxc2in4sNSiqWtYy8pDTL4R/4Z1lbsys3OnHTnG3j6Dj7S5cgmt9GxlDDHrXRtofNobOgzUzdOTCELM1zDZNGR4gndHzS1wLziS6VLewWAYX6t5rixcjFqNerLO3Nwxgx1I8y1R9eXnS7wrrMg+9MUA52Fim/v+YwAeNLjYYHH/rSXBn6ZUiEYntS13LnusuDzFkY1BEq1NOmI25lBWCqD1FY8oDqV86NizD8Dz6AnR2+Jn9AbLF3DD3k2z/XmxVVmGPkWmnTTEED5yx9ixCWG6ZmUHVKfdRbZHRvf9oFexqdf3AnFxe31mmZKlHx+YRegpBewfRzWF7mysR+Lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 by CH3PR12MB8877.namprd12.prod.outlook.com (2603:10b6:610:170::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Thu, 19 Feb
 2026 18:14:37 +0000
Received: from PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d]) by PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d%4]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 18:14:36 +0000
From: Yury Norov <ynorov@nvidia.com>
To: linux-kernel@vger.kernel.org,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Andrew Morton <akpm@linux-foundation.org>,
	Antoine Tenart <atenart@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Eric Dumazet <edumazet@google.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Ingo Molnar <mingo@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Jerin Jacob <jerinj@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mike Leach <mike.leach@linaro.org>,
	Moritz Fischer <mdf@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Tom Rix <trix@redhat.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Yajun Deng <yajun.deng@linux.dev>,
	Yury Norov <yury.norov@gmail.com>,
	Zhang Rui <rui.zhang@intel.com>,
	hariprasad <hkelam@marvell.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-fpga@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	netdev@vger.kernel.org
Cc: Yury Norov <ynorov@nvidia.com>
Subject: [PATCH 11/12] cpumask: switch cpumap_print_to_pagebuf() to using scnprintf()
Date: Thu, 19 Feb 2026 13:14:03 -0500
Message-ID: <20260219181407.290201-12-ynorov@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219181407.290201-1-ynorov@nvidia.com>
References: <20260219181407.290201-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0172.namprd04.prod.outlook.com
 (2603:10b6:408:eb::27) To PH0PR12MB8800.namprd12.prod.outlook.com
 (2603:10b6:510:26f::12)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8800:EE_|CH3PR12MB8877:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d14f2c4-0f2b-4a6e-ebae-08de6fe2bd89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2vFePeYXt4kq2Zsx3jqZZtlpjnLyB2VeKiShk4v3N19zxFQJduNzrWemwyst?=
 =?us-ascii?Q?iFH308GR9cHki/U2Itc6yObClSwNAyvAmq/2RRuuOnH/FU0abjrI0bxl7rVA?=
 =?us-ascii?Q?oq+kIkoB/AKTa41Dw3yOMpsKKQLMHHbO3jMShXX8mtroFH/W/zbDN0j1r7bT?=
 =?us-ascii?Q?Tcd8A2mGRCcDvD0sdjn94f4s1PT7RA7h7oKQ+QzCwM11EJ7OMg2arEpBmbRn?=
 =?us-ascii?Q?fS9ySjMdJjLZ6l7wQwgZLUAjAVHKwI2OpGdpjKMIminj/xsCyIjtK/26yLaH?=
 =?us-ascii?Q?7D/Kic3gNfmHoPO38cnHTGmSwmhdDovzSmEAm2/g5xB7dwyuUUkayQeK0nef?=
 =?us-ascii?Q?ILElkYuF/GjThkb0DDqLy2UBpZQNtan04/vQOLMIR1JHWj2uQuctMNf6ruog?=
 =?us-ascii?Q?f47xXD3V9wK1E2i89pNnNar9o2l6AyOrXZYplT6r3b3GqJLkJsfcclfJAUnp?=
 =?us-ascii?Q?WLktM7qj3W1egZdFY25enG1V9ogciJ5w9KXr8LC3j4hsqmdrlvynb3+Vurvr?=
 =?us-ascii?Q?5l+dMv7fQESCjAcjoCha58pkaj9XBYZ6NCisylvjqGvVKIgeGusde9oTxGnF?=
 =?us-ascii?Q?xBi2gWd5S/CLXeN7YNdh20jmGTF7NOUBXvqXVhDA9tXnfnR3foKlEZix3DM9?=
 =?us-ascii?Q?0d2gsBizB31rw9gUpTKHzY1gGOg2pTc4gnLtUXZy4StLs8YC1ZhwJp52aNmb?=
 =?us-ascii?Q?h9HcavRmYrJ5MTfuyP+FT9TSv3icNAO/otRC1mZNA1lzfiBOFeWHH2lzBPTh?=
 =?us-ascii?Q?jJqCVbgcVRp3TJ2qcVNAzRBAygkDDVm4F+UWr5ASAoSLV6sYuupGISnRcJxl?=
 =?us-ascii?Q?/XAZXdOYDY6P2y0QYE5BuRcMFrI7cmBBOrNzrpQZtSm0upBp7Uo3RdCOJsBD?=
 =?us-ascii?Q?m3a+fNoa0H6yO3HIsGYVWVkLVkhtceQJwNvWbrySUitrawuGtuGcRU/xZFKV?=
 =?us-ascii?Q?fHx5zuZBO2cpuWmt9B2pfF3B6ad82BW9yQ4rMjwXa8q0Q/2IVqHCHe4gilui?=
 =?us-ascii?Q?dxQGL+wTZsktwdIXRc0kYkJdtU+mc5Scwrp9BrOwAbFy1jsUM0SUNHAopCF7?=
 =?us-ascii?Q?HOgXh2xfxwiOcZvfpSxNSHfiQ7tPBqVg4hqBzGfl+8Fl6YhV5xdNGZUmx8hG?=
 =?us-ascii?Q?bMXm1bNyAlsahgymDflb3HKVjUyYqacCI9fGDWhqAFGIty/JalkvEGXXJMxe?=
 =?us-ascii?Q?Sgt3ivM1lGWiDbZVuTOPUSXCAbBdnPTqGl/K3Jov4d21tXC6JvspoMzvROAD?=
 =?us-ascii?Q?HR3AbX5LuOdBOOThwvsbvkwULUSdEHI24HQdcQAJH3xU+AR2w3/gu+OkbfwL?=
 =?us-ascii?Q?2+HyGBnvdvfpEZKAami89op94eDWSGjlq3mDReYGXY6Oi4f52nAX0hpWM0R2?=
 =?us-ascii?Q?cnnXMMs7aMEGVc8cY5Bsg3r8eWWfPTbjHQA2TpSXsEGr0ajSIaboCikqdLY1?=
 =?us-ascii?Q?VEgssbMpGN6EiiCBRBxPrPkTJVjzjUJrqjBVBI409023GbCOS9vBKTWLW1mG?=
 =?us-ascii?Q?7P36bWqPs31Gn5YdI2HsNySxhFY0mTVMVCAOM15USERBgsb+1sJHzVgCbd6d?=
 =?us-ascii?Q?NbWPQLx37405NMkNBBqMp8Toz4EfNR0B+B4M647iEyi2ni4TILXGl5wGJXIY?=
 =?us-ascii?Q?XA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8800.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(10070799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kBbMo4KuTao0PnQXG7RErFhQGRQYG83wa/+ZG3xhbCzuKSB3Z/Ninv8P61xX?=
 =?us-ascii?Q?w4aQXhaJbSwl7FBbXONP8kc5VY3fSFImkIssTB6mb3YgOXd54UGAm+eP4QPX?=
 =?us-ascii?Q?zWp3G8qEOLflWJ0f5AA9uqrhZcXIUjLs4eFvnTewfi4yXqXxo3SGUzFOSjc4?=
 =?us-ascii?Q?6ctxepoGRKLDueitoWSdXDhoZN//hvidueFJ4ayszqEbqfdyVRVpLDZrcM6B?=
 =?us-ascii?Q?cjXFDDUHhWUtgkPcCWQbMsciZi+UitkwhWm3BCOG7iNmq1VTW+hgmzVLn6tg?=
 =?us-ascii?Q?E0ZB9BlvrV66bJpm1heO/KHy6Wceb9NVSgYYGuajcBv8ufS36BnzBN4KZY4i?=
 =?us-ascii?Q?aMVXXUh5slwmcV2S2DKuxQCjnJx/l8M93ao5DlzuTJvKXbAgF/uwpg50mc4t?=
 =?us-ascii?Q?tVkp6Y2mJHQb6sDUsoT2z9AgPF1fSFPwObrSx4aIIDrNZRbDbtnyvfn78jzz?=
 =?us-ascii?Q?5L70310VwDpO50ye4wOS1ANNsqV+8oI4Fa08P3kGx+5WuEcwh9BM+VNFmSuJ?=
 =?us-ascii?Q?pF5RlDFPEa2IpSRLKOwTv5HX/mV4OFX2XT3ewT3yJfj4v1HhMCkFtuGwHK7U?=
 =?us-ascii?Q?JgF045S2zI5/mUcLQF1haJAOEUD97GskgS/4E6LWcvu8ztoLsCGvqJrOAisI?=
 =?us-ascii?Q?OW7O+xv4ShH+VpYwSbi7DDgb21b81VMPW5mEKIPxFqF9nckxgEvjr21LvLmk?=
 =?us-ascii?Q?Dq1k5+glvfIW9yMBeFD9jlE3etOjPrDcbob4Dogf2k2IqcoHDHCAIfCmJCzk?=
 =?us-ascii?Q?8YKVVqEHCGHieq2xrjf1UC625BV3VeAAlk3sJesN+hDqCB0OhtJ4Dv2wgjee?=
 =?us-ascii?Q?MopkWLIkkzjg6NO4+tfMz5+rh5OQ5vlW/cNvHpfkneLU+V8T13ZLfc/L2nnS?=
 =?us-ascii?Q?xahu+sGaP99pcDaeXGHRjCO/SKfM0/U84I2O+CQzwKs6dY7Jx98B1/Dk04uQ?=
 =?us-ascii?Q?maShJFglZd3Lv5RwQURDzM8Xqf1ZAt5MnmKhHuTf0EaFpGAEtqyrpmsnIpBC?=
 =?us-ascii?Q?Kvq9skNBWgpJIsirZGOmF1Ocjxca4ArMCDFWFYjlJFlh4Ymi2LmaYkCEqw8g?=
 =?us-ascii?Q?/3SPE45n7jlFzidyJIBf7JbM/60wOs0OyAkRrmELnYPCTsN8IYB64x4KlGcK?=
 =?us-ascii?Q?qCm3jNkJMgg6LWFeC6oFpSYjzVLsZmrflql1eIlXxuTy8IlV+Gtr6a7uTKeA?=
 =?us-ascii?Q?DeZjGsVmSr2OjBi/O6QtxMJSCrY2dhzhstMrkzWWDVrK59VkrNWZl/b8ytkW?=
 =?us-ascii?Q?9jbyP2jfC4ah+aBfK9xSk4PF1N8vjY/MBblx7KAhLPEDGMjvoRsIGfylmjmU?=
 =?us-ascii?Q?qckWrZGQYcDjVpVe0/cqdlWhNAqaAxznQK7gt6Smm9AOh5KYrLuW54+bPFsq?=
 =?us-ascii?Q?nCdpxc4PMXf0FsOckxDyeqRREGIfvARQ4lBf0V7v7hfzKxv7Kq1pIGkzs+3F?=
 =?us-ascii?Q?SlDOFyf1C3QcmzZqNQAcPY96n5mwHTFkGtNqSq+OCKkSluLIp0rTRWxJ7xRc?=
 =?us-ascii?Q?IpL+92rBubDiCzZUiRuX4rfLDcfYMmH12/TZcBpFiYWiCzLuI1Wf4HAhZ470?=
 =?us-ascii?Q?WFyP2b6OLsGvGKwhhZF8jnwSsVvk6dic14/1PdLTPkvt1zOGH1FNgW9KT9Jd?=
 =?us-ascii?Q?LIaHZ2Dw73WunHsjRNldaTvpKtzXlYnlTpqKIGPkEZ/IFc2YoXggANj3MQmA?=
 =?us-ascii?Q?oFVHfX40g/gSWw77EHBRiN0M4VLq0ra3yiFrAKdrvKSmBEKi7kSBeCnH/gxu?=
 =?us-ascii?Q?8XsdxGJ2ps7spiTePRz4KvkcNpSFxxA2V2A2ClglpmeJXP8Mg+uk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d14f2c4-0f2b-4a6e-ebae-08de6fe2bd89
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8800.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 18:14:36.8437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J7y4iHkfwB+akd8ztVchywbeuAY2Qn2p6i4jXM2KLlCokwqYMxjXy/hjD81g/Z3MB+zQMfDpDOLqhU2tFw0QZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8877
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,davemloft.net,infradead.org,linux.intel.com,lunn.ch,linux-foundation.org,linaro.org,google.com,marvell.com,arm.com,linux.ibm.com,ellerman.id.au,gmail.com,redhat.com,rasmusvillemoes.dk,fomichev.me,intel.com,linux.dev,lists.linaro.org,lists.infradead.org,lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[44];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42887-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm,netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0D13F16196D
X-Rspamd-Action: no action

In preparation for removing bitmap_print_to_pagebuf(), switch
cpumap_print_to_pagebuf() to using scnprintf("%*pbl").

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 include/linux/cpumask.h | 17 +----------------
 lib/cpumask.c           | 17 +++++++++++++++++
 2 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 80211900f373..02cae16c941a 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -1313,22 +1313,7 @@ static __always_inline bool cpu_dying(unsigned int cpu)
 }
 #endif /* NR_CPUS > BITS_PER_LONG */
 
-/**
- * cpumap_print_to_pagebuf  - copies the cpumask into the buffer either
- *	as comma-separated list of cpus or hex values of cpumask
- * @list: indicates whether the cpumap must be list
- * @mask: the cpumask to copy
- * @buf: the buffer to copy into
- *
- * Return: the length of the (null-terminated) @buf string, zero if
- * nothing is copied.
- */
-static __always_inline ssize_t
-cpumap_print_to_pagebuf(bool list, char *buf, const struct cpumask *mask)
-{
-	return bitmap_print_to_pagebuf(list, buf, cpumask_bits(mask),
-				      nr_cpu_ids);
-}
+ssize_t cpumap_print_to_pagebuf(bool list, char *buf, const struct cpumask *mask);
 
 /**
  * cpumap_print_bitmask_to_buf  - copies the cpumask into the buffer as
diff --git a/lib/cpumask.c b/lib/cpumask.c
index 5adb9874fbd0..f5148253da6d 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -166,3 +166,20 @@ unsigned int cpumask_any_distribute(const struct cpumask *srcp)
 	return next;
 }
 EXPORT_SYMBOL(cpumask_any_distribute);
+
+/**
+ * cpumap_print_to_pagebuf  - copies the cpumask into the buffer either
+ *	as comma-separated list of cpus or hex values of cpumask
+ * @list: indicates whether the cpumap must be list
+ * @mask: the cpumask to copy
+ * @buf: the buffer to copy into
+ *
+ * Return: the length of the (null-terminated) @buf string, zero if
+ * nothing is copied.
+ */
+ssize_t cpumap_print_to_pagebuf(bool list, char *buf, const struct cpumask *mask)
+{
+	return scnprintf(buf, rest_of_page(buf),
+			 list ? "%*pbl\n" : "%*pb\n", cpumask_pr_args(mask));
+}
+EXPORT_SYMBOL(cpumap_print_to_pagebuf);
-- 
2.43.0


