Return-Path: <linux-pm+bounces-41590-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEf8EVKDeWmexQEAu9opvQ
	(envelope-from <linux-pm+bounces-41590-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 04:32:34 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A92E49CB7C
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 04:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18B413019BB1
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 03:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEFB32F749;
	Wed, 28 Jan 2026 03:31:55 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022125.outbound.protection.outlook.com [52.101.96.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AAF30AACA;
	Wed, 28 Jan 2026 03:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769571115; cv=fail; b=uBulcZKiCcIsYS9MNLfovBsg2nV3AMRI5YSDWhlpqO6qwcEa8mGwLumAW0PHgIhXaMU4ZpJx5iUXAmFQFR4TUPSUsZme7Bp8TnckK+2clHUf7oj8gXhArZKJUYRxs7r2E4T76aqKxqyWayzuoDZFRC5ZYpgyz/aDOxmX08kO8Fs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769571115; c=relaxed/simple;
	bh=1Q6u0KHYl2iAlnf0VO3BHYtxQif/xdvC/JrBzPiEPfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UHf5o9PqvjR5eAh5lNHCQaqn2tdZ5YpimJPk3t7qXsxKSSHMPJNjmLfRMURWAd2kglvjvRVwq9beZXOduQ1YVpGCqBMybI6O1VKvgIPtVnJwX0Fpaw/W5OOuP0J7rp0XtjYN37jIw8++iRyHtHjIgUJYN9xbxxzVh9ED8xDANC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=miDBho8XxpzAwc53tJCa1dfBFu4Ws7sPCjQ6usOzLDbGnE54kDx7seCsVtIrDI3p53vK8DBDBJoqazFZAX4ASkjW735cUiENrH6fN9lhXGaigRuFErhK41uDHDoitgKO7clb7MfmlwyNDCkjdeBxIP1RnGh554Rz+A7CTO4OsX3nw+2HtcMPTtUfgPNgjFsoDRZy5xSDhFcaN4mkzWgh/pbBf7MmorLGSLAINbvXa9esN/Z8TmLbRhjr279XmVHRycqeq0VRcpP5lwhiqgYXMSQGrRs7gqpeuB2kvQMH0Im3jsHfdnXL+W74YViGMJaN/6UiKiFrH7s1PphGBMKqFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7QnFQD2jpl8wtuiox+4rEavhIZjDr6zW6FKUks+aags=;
 b=tKfX1v4wKtd3x5cpW5VrgDP27E4THZ7PBucY9nZrRETawuvg0sr4whIuuLOErVAyJeaBkNR/tovVM7Pkd6GjM3SAcTKdYIm0Q5QCEFMnDAEqAX7t7Hg/1EAi9sGhOjvysFfcLpT3OdztFTSnGIhLZWk+pzs/pffySV0iybd3jzm6SSMpRC6fnIHK3CEOpm5dOJSVl5xdqEN6pPLn7ZQVkfIQbSmz0VizwmS99j1jahlpbz3r798KVm8D0K6cnUr7YeIobu8L6gdUB/WLoefVaT+Sc3jI8lay+zE7zjvPQrGeVK6SiEU60t3wi2nm8cBGBaaWsOv69STyXRlLYRldHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWXP123MB3222.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:39::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Wed, 28 Jan
 2026 03:31:52 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9542.015; Wed, 28 Jan 2026
 03:31:52 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: rafael@kernel.org,
	dakr@kernel.org,
	pavel@kernel.org,
	lenb@kernel.org
Cc: akpm@linux-foundation.org,
	bp@alien8.de,
	pmladek@suse.com,
	rdunlap@infradead.org,
	feng.tang@linux.alibaba.com,
	pawan.kumar.gupta@linux.intel.com,
	kees@kernel.org,
	elver@google.com,
	arnd@arndb.de,
	fvdl@google.com,
	lirongqing@baidu.com,
	bhelgaas@google.com,
	neelx@suse.com,
	sean@ashe.io,
	mproche@gmail.com,
	chjohnst@gmail.com,
	nick.lange@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [v2 PATCH 1/1] PM: QoS: Introduce boot parameter pm_qos_resume_latency_us
Date: Tue, 27 Jan 2026 22:31:43 -0500
Message-ID: <20260128033143.3456074-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260128033143.3456074-1-atomlin@atomlin.com>
References: <20260128033143.3456074-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN1PR14CA0001.namprd14.prod.outlook.com
 (2603:10b6:408:e3::6) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWXP123MB3222:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f338ea1-0b95-441f-b670-08de5e1dc6f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LRlUoN+armdWy/9N031o4IuJTWjun6fYjOUkBAjpdGOfrTOdblUARWprDJ6X?=
 =?us-ascii?Q?BY1yrrjQjnPgtqfSnNi7sN8zk1ndFtIx6V7H9bIhPkR0Iq50BSLIlge+X1Lw?=
 =?us-ascii?Q?AGbiidAU7LC/wLfRA/aTlP6hhMfZPPvbmCNVT8ck5CE+N2VKmzVAVkQcrjDo?=
 =?us-ascii?Q?wypjFaQe7XnK+5TVMqlRKn/xk+q3HNGLDjXuJ1rpk58dvxz6Yo2sadf1k5sf?=
 =?us-ascii?Q?pu92lReouWXhwvXWqbf6AcLMSfJE3Bmpcgsm2F1LN2HnOLHDTR0sqW3IYTdE?=
 =?us-ascii?Q?2wl5uWHCucFxAw67tZpMYYs3sEZDNp6muwznLdGX2ZCuMc1L58KJgTKGSy1d?=
 =?us-ascii?Q?DLp4Cce2U79ZKk15UXcwvhUtj2CNAk23xUuV/EbaElVc1itljrHuUmhCpmNt?=
 =?us-ascii?Q?Nw5H91fShlwA1zfwUhi4cpFPjCe9CIWLolYBegwwX6zTWiiXwTvTUzXFHtbV?=
 =?us-ascii?Q?+03xsE2gDmkqDI5HGjNIKjkzJpmUlG5D1IEFMTMs8yy4UeWSleQCv1LeFHsw?=
 =?us-ascii?Q?3kvOM4niSzyQtzsKygDSHImF93O0Iki1BBaWFI2hFjQ3JQNVs/gW91SUARAg?=
 =?us-ascii?Q?p+U9/4NHWHzQp7ECxCaGNcKhN+si/QbLfjQBEQ75XOvOlFaaymiuCSKm0TRI?=
 =?us-ascii?Q?wck+DK6IYHn2KEybBvNWkDYWgLuEZGfiZGeelZDvlW7YIIhWc+Kw7f3l9GHv?=
 =?us-ascii?Q?yBDgpJbEQ89D4LpkcRJ4CU8hdoQ9kCKFpBa4lMpcVkcaZFU5KPMz/3YwwASX?=
 =?us-ascii?Q?Da4NoXCjddMoyNYt/ubZimbkHhnlB+aDhIyxpUoIrOU4bg806nCDi5OIG6fn?=
 =?us-ascii?Q?a65FkhiaPDtKoqY4mokKe4zpHJcdcf9JZq3u70hhgDmN/Z+yyIEYUgqOAVIN?=
 =?us-ascii?Q?84Es4szSC3O9UNghrMkKW1NNVGMW0BQ7Xj+TSEfjW32/XI+xYIH+Z4Nz0lPj?=
 =?us-ascii?Q?cSFWmmBob99ZS8ypbu3NedUMSVqA0dgWgAnmqCPCQtUki62iPHlS9C6Be/ER?=
 =?us-ascii?Q?XKqOnX6ETI6escwPs+Dzo1xVjQLLBWtZYdM7BhfLmGDZXsSYfFshTNEj315I?=
 =?us-ascii?Q?wnQfzaoZM43kIOzSnxEySwxQZXDGg1v18Ag6X8LyRUVkiLiDxUYOLJhNKhCf?=
 =?us-ascii?Q?jIIMEdhXnOu1F2akHLa4Oglly39532DMrfGikrWr9stIGaXQCiR8+HbSCB9l?=
 =?us-ascii?Q?eqbJ2pWMKYmrP3DElMtZ8vhzOf8O+XiyWJT+sXpWYAvuots2OiOwV8Q/rHIx?=
 =?us-ascii?Q?P61X+FSKXKZt/AoJo4NRKDFx+mSzWPwqzWTG6FpnwqlIKjLVJLxrbZLixVQ+?=
 =?us-ascii?Q?F5sNx/4mdu4PKJCqMgqjrd+VbbKkoRY/eYyiS4fhVJTPv63nHOlelLqts1JW?=
 =?us-ascii?Q?yyNDHSYUUStJ/MBjqjW7NbhFL5tnjfecLpJOP7CbApBnn7neV88GJaMjesNr?=
 =?us-ascii?Q?dSkJK73vH7Jh0gdpShubprEy0azUUwJSFTRg3JnppdcH96RLth0147ZIbhCZ?=
 =?us-ascii?Q?O+onBulp/Ez0Um0AccwV4z75oanVcqYTM0Gl1/lTkZFghAtcUYSn3hr8mkav?=
 =?us-ascii?Q?H8vr6Rq9dpeUbcvnb+Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/Q+S+xiwuGbj/861Pk8eeIdMLizUj75AD1aR74QQSd0lT6TSVf8TjUIeQ3WW?=
 =?us-ascii?Q?/EiWL2PDczvB5NCSMWEZ72QqQ4Sj8VSnl52FjxLqiTGBLii5DXsCLV/H+2a0?=
 =?us-ascii?Q?G5usI5++OT+/0KpIbyX5Zeqzmu4rDTG6YmsmgT+yg4BG6XR1zyCItVLkUO/k?=
 =?us-ascii?Q?BmyiYCETxTkjo4c31m5kAB2VScBIQd8qLEc9RLpJXGcZeAUNuVFfzxbTIRfE?=
 =?us-ascii?Q?97PZPG6n/CPZ/N66l7dMVZC8fVumBjattesxSb1ToVxgSspZOc2SHUnk8GrE?=
 =?us-ascii?Q?vyPS/P0PqvecEnLd8NWV78+2IXLNDlo3+/0U4A9LA6aDbi/HxsvDQzB8hxeQ?=
 =?us-ascii?Q?hCZCSSV2pf1G81PhLKk4elUW4Ya+WZEB/VG8GWc2BPrKoJX/5VPSwJhzYqS7?=
 =?us-ascii?Q?S/iUiPUwoBMIsqvlu0Xr9Mib3LLasKMc+KPve5XEZmCQZHEAs6aO8X+jKJkH?=
 =?us-ascii?Q?8FPGmbbT2j2yc9pZrXsqBmG3AKrUv5x9EWp2EOchHnWrBY2U8KBETkQwmzCj?=
 =?us-ascii?Q?5pzBz4+nZm9UbWD+FAHSXz9TT67YxLH4fTVJC0qf+DmpCjfFfZvn5SBUk7+7?=
 =?us-ascii?Q?iO5kusPplNCAtSJXYCAqMmDbvDAA4VQSyhNnoxGmNStVqec7cnLFSj8ibWCx?=
 =?us-ascii?Q?i7JBXyZIWibSAFPwKOrrdeq010Of1mkP/KeDaaBPJMzvrffY7dhD2lflZp0A?=
 =?us-ascii?Q?kxtt6zyP25utKiQYaCocaO+251MOAQqhGaG9n5Mig9eQMpI57DnyCkatj8Ym?=
 =?us-ascii?Q?JWWJvpvVPj7R96tein8YpZgN4iIs7KbC+9bHYT0xHOkZbz+J/UxvMe1DCerm?=
 =?us-ascii?Q?t5iyXRMK0Z63ZG8aNdq/H/uJtiIQ7MKzBppd/lyEXbuFUAy7aCq690Y29lbo?=
 =?us-ascii?Q?3j9c+N2t4b8kN+S+RGvNs/gQQ9luJDOVGthKSZaCGFKmWejwWkxr7Mg8VH3g?=
 =?us-ascii?Q?7nmXU7QWxq0m50Q9QFInf4lsoXDrFw0xmv1hxdGs9vLxn9ZLq/Xi9SG9YZ9q?=
 =?us-ascii?Q?Dl7vow4ULxUDz5Hgb+sUufnU4tqvUToKJLe/ow0TYSbAosZ2nQ0J+uD7+3L0?=
 =?us-ascii?Q?PHdU9i1fMvLX1h9qeHNPDn1yQLvQDrJ2zWLH8/kbM4hrBf/jHJUf55UQv6MK?=
 =?us-ascii?Q?ezdXzNA7eiDah0crf0LvEWVVFZr3Psbkav56Bm+BySa932w3rWdMzvdpnEZ/?=
 =?us-ascii?Q?5jS4WjmltPTXU/KI+xeMoikeAdLi5zojl1NgtW29mc2OVw7KvndSStrbWYZv?=
 =?us-ascii?Q?SKvxIeDNWwYHDNN/4zXtKhqFvO58fPo0iRlljg6UIWO/Ui3EsXKZArrGhlmq?=
 =?us-ascii?Q?v6auIqcgPjc8upLb3VRE/fJEA17xDHmz3n5N5Z9y/Rcty83iVQXoExHQ6k8j?=
 =?us-ascii?Q?BLIzx76TZPVIS+nFlMyZWT3AA3OJfxDPnQ9/+m9SQ/L2uvzkWLEhiwWvYfrM?=
 =?us-ascii?Q?A3o3Ka9Mc2lueivc2JdzaAFgXmHlBLBtkKXv4IvDjJcFcfOk7VHDaOW3JUc0?=
 =?us-ascii?Q?A2huyjYtC5K76s/66GgN1pMjIJLglPrMB4n6SPXfBhmwwiGvAztpBQZHXFoI?=
 =?us-ascii?Q?gmzPl2sMXCVqsC8VTtxbNwla7Z1+5CBB3IoqbVTsDpI7rdpg7ZyrrZIXI3tK?=
 =?us-ascii?Q?rRrNQTCkS7vmK0FHK6FqRh8Fvm6UdsDIhuNU6OcuQRj3bzzaBjRj7NFIL/PG?=
 =?us-ascii?Q?1z2WI+D2sL1b88eDKB2VgDMqOwQpexJfhm0xI87ni5oPKaC9RhtC1WAQzwBW?=
 =?us-ascii?Q?NWVH4dD2ig=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f338ea1-0b95-441f-b670-08de5e1dc6f9
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 03:31:52.1756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RL/hl7/82p35cjc/6K9yJWI/MhF7SoJlFHXUPa8j3aWcDCiu2kQJc8e9rSGoenFB3YQvrO+JUieiOqwjcQ8/zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3222
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-41590-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[atomlin.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atomlin@atomlin.com,linux-pm@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,alien8.de,suse.com,infradead.org,linux.alibaba.com,linux.intel.com,kernel.org,google.com,arndb.de,baidu.com,ashe.io,gmail.com,vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.898];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A92E49CB7C
X-Rspamd-Action: no action

Users currently lack a mechanism to define granular, per-CPU PM QoS
resume latency constraints during the early boot phase.

While the idle=poll boot parameter exists, it enforces a global
override, forcing all CPUs in the system to "poll". This global approach
is not suitable for asymmetric workloads where strict latency guarantees
are required only on specific critical CPUs, while housekeeping or
non-critical CPUs should be allowed to enter deeper idle states to save
energy.

Additionally, the existing sysfs interface
(/sys/devices/system/cpu/cpuN/power/pm_qos_resume_latency_us) becomes
available only after userspace initialisation. This is too late to
prevent deep C-state entry during the early kernel boot phase, which may
be required for debugging early boot hangs related to C-state
transitions or for workloads requiring strict latency guarantees
immediately upon system start.

This patch introduces the pm_qos_resume_latency_us kernel boot
parameter, which allows users to specify distinct resume latency
constraints for specific CPU ranges.

	Syntax: pm_qos_resume_latency_us=range:value,range:value...

Unlike the sysfs interface which accepts the special string "n/a" to
remove a constraint, this boot parameter strictly requires integer
values. The special value "n/a" is not supported; the integer 0 must be
used to represent a 0 us latency constraint (polling).

For example:

	"pm_qos_resume_latency_us=0:0,1-15:20"

Forces CPU 0 to poll on idle; constrains CPUs 1-15 to not enter a sleep
state that takes longer than 20 us to wake up. All other CPUs will have
the default (no resume latency) applied.

Implementation Details:

	- The parameter string is captured via __setup() and parsed in
	  an early_initcall() to ensure suitable memory allocators are
	  available.

	- Constraints are stored in a read-only linked list.

	- The constraints are queried and applied in register_cpu().
	  This ensures the latency requirement is active immediately
	  upon CPU registration, effectively acting as a "birth"
	  constraint before the cpuidle governor takes over.

	- The parsing logic enforces a "First Match Wins" policy: if a
	  CPU falls into multiple specified ranges, the latency value
	  from the first matching entry is used.

	- The constraints persist across CPU hotplug events.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 .../admin-guide/kernel-parameters.txt         |  23 +++
 drivers/base/cpu.c                            |   5 +-
 include/linux/pm_qos.h                        |   5 +
 kernel/power/qos.c                            | 141 ++++++++++++++++++
 4 files changed, 172 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6a3d6bd0746c..afba39ecfdee 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2238,6 +2238,29 @@ Kernel parameters
 	icn=		[HW,ISDN]
 			Format: <io>[,<membase>[,<icn_id>[,<icn_id2>]]]
 
+	pm_qos_resume_latency_us=	[KNL,EARLY]
+			Format: <cpu-list>:<value>[,<cpu-list>:<value>...]
+
+			Establish per-CPU resume latency constraints. These constraints
+			are applied immediately upon CPU registration and persist
+			across CPU hotplug events.
+
+			For example:
+				"pm_qos_resume_latency_us=0:0,1-15:20"
+
+			This restricts CPU 0 to a 0us resume latency (effectively
+			forcing polling) and limits CPUs 1-15 to C-states with a
+			maximum exit latency of 20us. All other CPUs remain
+			unconstrained by this parameter.
+
+			Unlike the sysfs interface, which accepts the string "n/a" to
+			remove a constraint, this boot parameter strictly requires
+			integer values. To specify a 0us latency constraint (polling),
+			the integer 0 must be used.
+
+			NOTE: The parsing logic enforces a "First Match Wins" policy.
+			If a CPU is included in multiple specified ranges, the latency
+			value from the first matching entry takes precedence.
 
 	idle=		[X86,EARLY]
 			Format: idle=poll, idle=halt, idle=nomwait
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index c6c57b6f61c6..1dea5bcd76a0 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -416,6 +416,7 @@ EXPORT_SYMBOL_GPL(cpu_subsys);
 int register_cpu(struct cpu *cpu, int num)
 {
 	int error;
+	s32 resume_latency;
 
 	cpu->node_id = cpu_to_node(num);
 	memset(&cpu->dev, 0x00, sizeof(struct device));
@@ -436,8 +437,8 @@ int register_cpu(struct cpu *cpu, int num)
 
 	per_cpu(cpu_sys_devices, num) = &cpu->dev;
 	register_cpu_under_node(num, cpu_to_node(num));
-	dev_pm_qos_expose_latency_limit(&cpu->dev,
-					PM_QOS_RESUME_LATENCY_NO_CONSTRAINT);
+	resume_latency = pm_qos_get_boot_cpu_latency_limit(num);
+	dev_pm_qos_expose_latency_limit(&cpu->dev, resume_latency);
 	set_cpu_enabled(num, true);
 
 	return 0;
diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index 6cea4455f867..556a7dff1419 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -174,6 +174,7 @@ static inline s32 cpu_wakeup_latency_qos_limit(void)
 #ifdef CONFIG_PM
 enum pm_qos_flags_status __dev_pm_qos_flags(struct device *dev, s32 mask);
 enum pm_qos_flags_status dev_pm_qos_flags(struct device *dev, s32 mask);
+s32 pm_qos_get_boot_cpu_latency_limit(unsigned int cpu);
 s32 __dev_pm_qos_resume_latency(struct device *dev);
 s32 dev_pm_qos_read_value(struct device *dev, enum dev_pm_qos_req_type type);
 int dev_pm_qos_add_request(struct device *dev, struct dev_pm_qos_request *req,
@@ -218,6 +219,10 @@ static inline s32 dev_pm_qos_raw_resume_latency(struct device *dev)
 		pm_qos_read_value(&dev->power.qos->resume_latency);
 }
 #else
+static inline s32 pm_qos_get_boot_cpu_latency_limit(unsigned int cpu)
+{
+	return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
+}
 static inline enum pm_qos_flags_status __dev_pm_qos_flags(struct device *dev,
 							  s32 mask)
 			{ return PM_QOS_FLAGS_UNDEFINED; }
diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index f7d8064e9adc..e23223e3c7e8 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -34,6 +34,11 @@
 #include <linux/kernel.h>
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
+#include <linux/cpumask.h>
+#include <linux/cpu.h>
+#include <linux/list.h>
+
+#include <asm/setup.h>
 
 #include <linux/uaccess.h>
 #include <linux/export.h>
@@ -46,6 +51,10 @@
  */
 static DEFINE_SPINLOCK(pm_qos_lock);
 
+static LIST_HEAD(pm_qos_boot_list);
+
+static char pm_qos_resume_latency_cmdline[COMMAND_LINE_SIZE] __initdata;
+
 /**
  * pm_qos_read_value - Return the current effective constraint value.
  * @c: List of PM QoS constraint requests.
@@ -209,6 +218,138 @@ bool pm_qos_update_flags(struct pm_qos_flags *pqf,
 	return prev_value != curr_value;
 }
 
+struct pm_qos_boot_entry {
+	struct list_head node;
+	struct cpumask mask;
+	s32 latency;
+};
+
+static int __init pm_qos_resume_latency_us_setup(char *str)
+{
+	strscpy(pm_qos_resume_latency_cmdline, str,
+		sizeof(pm_qos_resume_latency_cmdline));
+	return 1;
+}
+__setup("pm_qos_resume_latency_us=", pm_qos_resume_latency_us_setup);
+
+/* init_pm_qos_resume_latency_us_setup - Parse the pm_qos_resume_latency_us boot parameter.
+ *
+ * Parses the kernel command line option "pm_qos_resume_resume_latency_us=" to establish
+ * per-CPU resume latency constraints. These constraints are applied
+ * immediately when a CPU is registered.
+ *
+ * Syntax: pm_qos_resume_latency_us=<cpu-list>:<value>[,<cpu-list>:<value>...]
+ * Example: pm_qos_resume_latency_us=0-3:0,4-7:20
+ *
+ * The parsing logic enforces a "First Match Wins" policy. If a CPU is
+ * covered by multiple entries in the list, only the first valid entry
+ * applies. Any subsequent overlapping ranges for that CPU are ignored.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+static int __init init_pm_qos_resume_latency_us_setup(void)
+{
+	char *token, *cmd = pm_qos_resume_latency_cmdline;
+	struct pm_qos_boot_entry *entry, *tentry;
+	cpumask_var_t covered;
+
+	if (!zalloc_cpumask_var(&covered, GFP_KERNEL)) {
+		pr_warn("pm_qos: Failed to allocate memory for parsing boot parameter\n");
+		return -ENOMEM;
+	}
+
+	while ((token = strsep(&cmd, ",")) != NULL) {
+		char *str_range, *str_val;
+
+		str_range = strsep(&token, ":");
+		str_val = token;
+
+		if (!str_val) {
+			pr_warn("pm_qos: Missing value range %s\n",
+				str_range);
+			continue;
+		}
+
+		entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+		if (!entry) {
+			pr_warn("pm_qos: Failed to allocate memory for boot entry\n");
+			goto cleanup;
+		}
+
+		if (cpulist_parse(str_range, &entry->mask)) {
+			pr_warn("pm_qos: Failed to parse cpulist range %s\n",
+				str_range);
+			kfree(entry);
+			continue;
+		}
+
+		cpumask_andnot(&entry->mask, &entry->mask, covered);
+		if (cpumask_empty(&entry->mask)) {
+			pr_warn("pm_qos: Entry %s already covered, ignoring\n",
+				str_range);
+			kfree(entry);
+			continue;
+		}
+		cpumask_or(covered, covered, &entry->mask);
+
+		if (kstrtos32(str_val, 0, &entry->latency)) {
+			pr_warn("pm_qos: Invalid latency requirement value %s\n",
+				str_val);
+			kfree(entry);
+			continue;
+		}
+
+		if (entry->latency < 0) {
+			pr_warn("pm_qos: Latency requirement cannot be negative: %d\n",
+				entry->latency);
+			kfree(entry);
+			continue;
+		}
+
+		list_add_tail(&entry->node, &pm_qos_boot_list);
+	}
+
+	free_cpumask_var(covered);
+	return 0;
+
+cleanup:
+	list_for_each_entry_safe(entry, tentry, &pm_qos_boot_list, node) {
+		list_del(&entry->node);
+		kfree(entry);
+	}
+
+	free_cpumask_var(covered);
+	return 0;
+}
+early_initcall(init_pm_qos_resume_latency_us_setup);
+
+/**
+ * pm_qos_get_boot_cpu_latency_limit - Get boot-time latency limit for a CPU.
+ * @cpu: Logical CPU number to check.
+ *
+ * Checks the read-only boot-time constraints list to see if a specific
+ * PM QoS latency override was requested for this CPU via the kernel
+ * command line.
+ *
+ * Return: The latency limit in microseconds if a constraint exists,
+ * or PM_QOS_RESUME_LATENCY_NO_CONSTRAINT if no boot override applies.
+ */
+s32 pm_qos_get_boot_cpu_latency_limit(unsigned int cpu)
+{
+	struct pm_qos_boot_entry *entry;
+
+	if (list_empty(&pm_qos_boot_list))
+		return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
+
+	list_for_each_entry(entry, &pm_qos_boot_list, node) {
+		if (cpumask_test_cpu(cpu, &entry->mask))
+			return entry->latency;
+	}
+
+	return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
+}
+EXPORT_SYMBOL_GPL(pm_qos_get_boot_cpu_latency_limit);
+
 #ifdef CONFIG_CPU_IDLE
 /* Definitions related to the CPU latency QoS. */
 
-- 
2.51.0


