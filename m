Return-Path: <linux-pm+bounces-40393-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A984BCFF1C3
	for <lists+linux-pm@lfdr.de>; Wed, 07 Jan 2026 18:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 97CA330052C2
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jan 2026 17:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF69E358D26;
	Wed,  7 Jan 2026 17:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Ku9ayUmy";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Ku9ayUmy"
X-Original-To: linux-pm@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011034.outbound.protection.outlook.com [52.101.70.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7F2357A37;
	Wed,  7 Jan 2026 17:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.34
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767807113; cv=fail; b=ngxnNdZEXDuwMBnRg0C4xknzCmo1ZDfO6IDT/Axmz7o2NHcrxeyycVFjrIgZ3xaF+r+k21D3S6FV3sqNNUa8+FHWMNvmmFJd99Ivknz0jxKA8yJc+tyQILCGWfnbxoDlN/WyBp++QJOvQkprv3S1HTrehNsrP8nVaTfTFSbcGYQ=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767807113; c=relaxed/simple;
	bh=2jEz98P0K4ZC+OwiIPVhm9BbuBX13r5M4Q1Ofse1gp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BhKEurOTtSeM+qfelPh9Ps8bxw7KCqS95jBhq3/2MBsuWcI5H1UNDWzbM8f/0t5rU+tBiseWSof0nu73SAS6b7eqBntq7hq9wXIuISeicYzbGEnC7MHLpos+k8WfLi18coWFFgXLfTreWa7ICRhNqa6MYCX12s0Kpk1I8NDJZQo=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Ku9ayUmy; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Ku9ayUmy; arc=fail smtp.client-ip=52.101.70.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=AhLH75Wqn/MrOtCprXI1Ibz3NcsaeHYYxrpJCTzsdIYEeVwdbBX3yD0crVqm7XPxRZ0a+NFJu3uRNIaqL6AYgxm6p99WmeB7AeNEk2ggGD3XCyQNX5aOvVjvxQtqzegy/EY+9Vhq0+0kPZeU6RGXo/K2BsE9ZHWqkmtuVRozjvnJ88HkHsB7lzGSZA2LBLmhh2jHbFT/8DJCOY7VyQ5WjMTY1eqJxjM2Qfpe6oIHCXje52DfZmTLkOONdxkQ2Gw0AXyOQWGblWhZJA/Xt3fCePo71sZ7viYw1QY7rOU4CTpeAmIaREBcQl4ftLM7y0NS94vUa099kjvbNSB2dhp+hg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fusSCnYT1RF9D6fDmeqsWRt/pruCzRTAS3NTH3aM5Sc=;
 b=ALSrWE9SOjggeU5ZPuA3GUMjJRZ7JpG4Fmpn+APd5ebfDxCJuLCsRPQFWLw+WAu0IFKdeU/6UL9twBNVKRhSni/OpzIIjIvX0r/tof8Yi1OATCTCHNy8nKHfzAFAyi5tz4Dv0nzm1ggrtpc9jqw3LFxhMAsREBErXBgwdxLxJbF17jJtK/un/VKOok2LEMPK0DiCuInMyqzCrViTcLuZo3cfl11F74eVMXdiB1HYxhJq7W5u6HZCrUHIuyEP422krmJvLBGzvioEUB+Uu/q0cNgYqQHZNPcbEOWTWCi3YYDSbR5s83dNugZ91/VqM7cxAtHg3GlaZNYf9eL1TBjrng==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fusSCnYT1RF9D6fDmeqsWRt/pruCzRTAS3NTH3aM5Sc=;
 b=Ku9ayUmyxrq7lgNyvtdE1bLkKybl7rhPgek3Nl3TbaizSYqyR3gKPNncFjJ0sJ0eSybGXnKPW10au/kCUo16c0u4go8a8Is8NX/oAlFgd3SzobDIhHqK4pK88b2yiQxLmM9D0c0A86kA0nRUqAAoN0FEhAU/TjvVKMl1MDNp5vE=
Received: from DU6P191CA0002.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::19)
 by VI1PR08MB10007.eurprd08.prod.outlook.com (2603:10a6:800:1cc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 7 Jan
 2026 17:31:45 +0000
Received: from DU2PEPF00028D08.eurprd03.prod.outlook.com
 (2603:10a6:10:540:cafe::96) by DU6P191CA0002.outlook.office365.com
 (2603:10a6:10:540::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Wed, 7
 Jan 2026 17:31:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D08.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.1
 via Frontend Transport; Wed, 7 Jan 2026 17:31:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lvSSK4XifAFKo9NWsmHL1Bl6b7OrZZx7whOl1O10pXyxnw3XDXsIZWY3vl1/51bN7DV5TrUGZ3KvPDLxU2IMDzDv0ctg6CSmn+AE+LWbj+xQRKtDD+SYEoyrVwje1/8qgFO0hBXykwavtRz+5xcWWkgWOtbX8jjYxC/9J9HYTLQGrLp4Wh9KROa6ptkbUo17L4ZFesoreMjfOaRzk0gK/Nel0rEiIGr3IS/CdNMZoayTAM4DpSFHbuDORaU3ONRJ/yTmZmHaHFxT5bugumD3vHGMGsBTm5JfUbya86MbmWEWJulT4UHvRH+XleSWXZtWTZ41dtEEgRq6PWGjHhIwBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fusSCnYT1RF9D6fDmeqsWRt/pruCzRTAS3NTH3aM5Sc=;
 b=t3yto9oISK2s/ro/SqJCXyUtHKGam1gs2BHyJxgJWGsIVuSJ7fXRanty4JPpdBcpwIWI+saCbS2CbfwMRCOP3YpfMkrVGILwmDb/j6O3/TTaxbqexGykFwBXr+YR0V+iDl6nl6T/Plt7+LKQ369QlPKVpfHpClTN3V8575tSznA3s7+Pis79LoSi7guwxRA70IlbWGOnv92VwudWEk61rvgOzUXgQDI9N9/Jk3+triEa3J1VlyGgeVdxkjY/8EduB3LStLgEKzwxKS+XQ7tL0tO+m8uFMo5B91uQpAB2fqwxVRDiXZ5lUQHMnbrR8+Nc0zeAvk6PRg0b3JVC4NJl/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fusSCnYT1RF9D6fDmeqsWRt/pruCzRTAS3NTH3aM5Sc=;
 b=Ku9ayUmyxrq7lgNyvtdE1bLkKybl7rhPgek3Nl3TbaizSYqyR3gKPNncFjJ0sJ0eSybGXnKPW10au/kCUo16c0u4go8a8Is8NX/oAlFgd3SzobDIhHqK4pK88b2yiQxLmM9D0c0A86kA0nRUqAAoN0FEhAU/TjvVKMl1MDNp5vE=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by PAWPR08MB8959.eurprd08.prod.outlook.com
 (2603:10a6:102:33f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 17:30:42 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%3]) with mapi id 15.20.9478.004; Wed, 7 Jan 2026
 17:30:42 +0000
Date: Wed, 7 Jan 2026 17:30:39 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, rafael@kernel.org, pavel@kernel.org,
	catalin.marinas@arm.com, will@kernel.org, anshuman.khandual@arm.com,
	ryan.roberts@arm.com, yang@os.amperecomputing.com,
	joey.gouly@arm.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64: fix cleared E0POE bit after
 cpu_suspend()/resume()
Message-ID: <aV6YPyLV1quaOkyw@e129823.arm.com>
References: <20260107162115.3292205-1-yeoreum.yun@arm.com>
 <846e1998-b508-4433-9db6-3a52ff23552f@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <846e1998-b508-4433-9db6-3a52ff23552f@arm.com>
X-ClientProxiedBy: LO4P265CA0074.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::13) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|PAWPR08MB8959:EE_|DU2PEPF00028D08:EE_|VI1PR08MB10007:EE_
X-MS-Office365-Filtering-Correlation-Id: e745cb87-37a0-4b51-bb6c-08de4e12a0f3
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?uM2+7ZPzZDru0Aa3lBqphMa+erGdw/dDWPCcOgPkZ1llyHBcZ46GvHiXU0yz?=
 =?us-ascii?Q?QtRXfBRib0dQoeS9mWEpW7EUIV3kQwsUpy83cx345YLa90nK1S4vWLTw4xO3?=
 =?us-ascii?Q?W1tur9BxpD8B/jYvTIF0uMFTI9VwdCdUoS81FkO3PhMA/7dgYqi6Dmljn0ba?=
 =?us-ascii?Q?lZR/pY6Cmv5O815+e4dm9dGrwBJ4pWf0kF+YL85wNJ9+ZzbY/QxD9fBPYv0j?=
 =?us-ascii?Q?cET150Ts+1nyszZEwnl0C6gC0Xb3okcfy3tr1IzFoPq1/BuOAGan//kHBzww?=
 =?us-ascii?Q?nDMSxOjUD3AKxEa5gyw5s9ezFoTNs6U7o7iGJh77zphlxMsQY4DIBDZg6bYW?=
 =?us-ascii?Q?n9i+sbROOMu0QDHMHEvECZxdRQaVQpeHda3Tlc0OdZ+XGln4NqU72ZJyBkSK?=
 =?us-ascii?Q?jUDWW7PVDBlCfkzoPzUpV8zKKTe8HsgMAkHDfrfT7LbsUV7z5neCm+rXltER?=
 =?us-ascii?Q?NvCFveNtavj5s9kd1o0T/KeJ9R13lrPVD3uZtJSibRhPBR3hr2H4Qnt5uQBF?=
 =?us-ascii?Q?NMY3xMpCwqphER5i130EGQMaJw3BZ5sc4SqnQ9qZYIdYWH/hciNynbuUVSiZ?=
 =?us-ascii?Q?0siuyo7Yq4nszOZc3QqvsxOebHzrkxUL/HZT86ZrnTTdkQTo61IoX75NG96i?=
 =?us-ascii?Q?sMtiBOT3lk29r71oTMt+Igs8h/E5XbPlZ8lulWnlrhfVeVgLIrXkU2/yVk7D?=
 =?us-ascii?Q?JyGa1h1QKU7mLqSnqL4cLJuNpULDLs72QDpby9H/9GZii/qtHaWcuneOZ4P4?=
 =?us-ascii?Q?LEimXPvI8WGkq6j66anglzoSKq2cN2KlfmT+2zUZCnDG1G7KOy87ngu3KwCu?=
 =?us-ascii?Q?QgOGnqJXH7pOdS+M9SJzn+ygIAwFPx1W8lYV6QCOJPJm0vh0ZyOkOPyfmxD0?=
 =?us-ascii?Q?hMdcETzfn66aFtn6Hp7Djux10r9Fsxg8a4HX5pd0O/a5n9yy+eyoj6TXZc+H?=
 =?us-ascii?Q?PVgKUgpz15Jnb282IT9mqurgCi6mWes4Egv9O6e+8nO0OkY661NSQWScvtqZ?=
 =?us-ascii?Q?+Pc+3bc7xMTXMy41wWDnpbFTaTOyKFIXaf1KCx0OykBkFb5BPXAJM+Ec6j5j?=
 =?us-ascii?Q?P0exGJheeXTP1RUzbGZG3UbO4+Cosxu0AnKypGruawdwYtJ6VQUEjdHbAdRS?=
 =?us-ascii?Q?u9wUCLIe01YNkNsgHpY9xb24ppRUgsQvqm7Fj5uYlae++FbI/bm6hbPdFHJt?=
 =?us-ascii?Q?HXdGHpOdDTpZJpXruN0Op4M5gwE3dPYz/3L9Gs1yd2pkX0U1ii5PGsYEFFa6?=
 =?us-ascii?Q?woLozxFo7wDs8woGHZLNV8+C3g/16v9owWqJsRYH04g1XUQJxnOcjc5LKXbo?=
 =?us-ascii?Q?Jb8honyt8LRSpsdRGfcUFj1ye2X06qv0F8AwMJjKCxwmF3xb5PSD5uZn6f/W?=
 =?us-ascii?Q?RBanF45/nylj5P8OMfHd9SZ9VdRAB+FtEje9th5GD01G/AUIWsOokeM8cnYb?=
 =?us-ascii?Q?INKZtzycIH7nkcxZ9scDb4w8GOyJhIFY?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB8959
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D08.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	fdc1d1ec-3b39-4a72-77b3-08de4e127b96
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|82310400026|376014|35042699022|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lcE5xTGuUmSFGf9n7lTJ+HuLCiwGASVeYsHTZyMMA7rYoCcXnySlDASkP9TF?=
 =?us-ascii?Q?IKUu3JnqD10j/kOGFPhs+SD3JmG7hJmUUNXnelTTQs+cfxC++YbLZ+rPmMSi?=
 =?us-ascii?Q?buANVtTYJqVMh8e4UenZETyDoAXnv0HyAtGzI5CWeU7/fit1o+GcXP1SWT2O?=
 =?us-ascii?Q?J+RCq6Xb3ak0BanXIkNvJioWD8OfHPp+IteLtq9G51zYbdl79QLv6QuJAPmH?=
 =?us-ascii?Q?YqIOxuePqWyKaLHzLdYFc08WElWbVw2UtuUhMcQXku0v3xe4LfA/XSU/la6F?=
 =?us-ascii?Q?M9yL0be9otFC45ZAsLMyVy8p1JwWvqmznyC2JszqF38JEGXTfcTcKCRWWnbS?=
 =?us-ascii?Q?SC1OtaqK/dI19EZztn0gUw21OCkoNF3y9V+yiZJpdoRZCEC5EyNOTncUmhTi?=
 =?us-ascii?Q?NW82jSaNRoCILu4mpEET8Cz+pFtLYJXukmjewHaV6Hgr34F0x3vK84eDUHVd?=
 =?us-ascii?Q?cjzEtmXixZvhLnvPBBund1rFElBHR5XHYGQMoVhk4svjVW7cHRVIJeebg1e4?=
 =?us-ascii?Q?zyiR4YilJYcq785qVUAlm++wJFcaUlQLdfFSa0NgtJ0YiMS+D8nplStYtBl8?=
 =?us-ascii?Q?km8EUrQq8vtkvfXaEvTJUFjh0zwzjNGuZ93qlNlUgBK/rl9s5UZYFmdlDIbW?=
 =?us-ascii?Q?uvBXn8vSYEbbKGoXAW0/ypvhj4N/cA/Y7y8OPdPLwRKjPlCCVvqRxXpOKqXC?=
 =?us-ascii?Q?K50qGgeJKRgjH1IkWh/sRGGNcxpDJwXIO4lwFPDQsl0/j91l1ib7eUoC1GFG?=
 =?us-ascii?Q?CfDix2tSsnvjHlkA/SDMT/s5Yhtw0b72m8b9g0jEKnCq2BTD9eR20cKoa6Ox?=
 =?us-ascii?Q?/IrVhzytaLNE2fewTrPcGx6r21dUjoQHODzb40tK1J4UatA7VbJmK3eBOarB?=
 =?us-ascii?Q?kv2EcWpOWvG9ybnm4Gc6GYtuVSX9CpMqZ/u9pmS9P8494S7IxWuKjeAavFIE?=
 =?us-ascii?Q?b2RhlVWqJkleTzjQF3aYv1MSY+dluFFNm0pFRtWXl1b0KZReVqRmBPUEu9CR?=
 =?us-ascii?Q?C/esox4L0TYFCVUv50EhyzCx1mKkgsuzBuFudNyhN08QGrB7gVSPhB/5BbM4?=
 =?us-ascii?Q?MOx/CqikewdbI/YAQNfL8fjtCVi40zX4AzxEzF/oyME7GpO9yp/WTEXZbW5j?=
 =?us-ascii?Q?KJtJuy3vXbsuRlJsHivChaJdmavz4ZovHYcDt2QBV2P9dRn6WOw6CQ3CAZl4?=
 =?us-ascii?Q?8w4CJ7pzYFNFqiIFWCBLJNQ7zbZcs3I/HkOre/9Nb9CBUMpTSNWIb485uw8H?=
 =?us-ascii?Q?RdRlo6Z9tz3vi/+85FIz/q1tH+P3iIDx57ynaS2Qa7R3Fcbtg8pfnk6tNe/K?=
 =?us-ascii?Q?T56ZFOvtozX062nB3MugESVGRgXrU+uNQW4ipztWozW6Koxr7bHCJcxfh/aX?=
 =?us-ascii?Q?hNyjg9byCO23OODoDcfzElVi78Gqi6merBVlzrjIFYYhfZsEllj1J++Y6kZy?=
 =?us-ascii?Q?I9PNSvHMt4d/HQ5w2wlKhp3QK8+fMJKc9W9J/KXEzQ5Ux0AZGcOD1/lPa/eD?=
 =?us-ascii?Q?TJiRlu4JCqfxshZsFC6OMyqPRMhSAIu8i/yNhbO3yO4N9wPGvT6ePMFahoB1?=
 =?us-ascii?Q?4m81+YWQVA8SNKVbKIE=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(82310400026)(376014)(35042699022)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 17:31:44.8896
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e745cb87-37a0-4b51-bb6c-08de4e12a0f3
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D08.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10007

Hi Kevin,

[...]

> > @@ -144,6 +148,10 @@ SYM_FUNC_START(cpu_do_resume)
> >  	msr	tcr_el1, x8
> >  	msr	vbar_el1, x9
> >  	msr	mdscr_el1, x10
> > +alternative_if ARM64_HAS_TCR2
> > +	ldr	x2, [x0, #104]
> > +	msr	REG_TCR2_EL1, x2
> > +alternative_else_nop_endif
>
> Maybe this could be pushed further down cpu_do_resume, next to DISR_EL1
> maybe (since it's also conditional)? Otherwise the diff LGTM:

Sorry but IIUC, currently there is no DISR_EL1 save/restore not yet?
and I think current place is good where before restore SCTLR_EL1 which
before MMU enabled.

Am I missing something?

Thanks.


--
Sincerely,
Yeoreum Yun

