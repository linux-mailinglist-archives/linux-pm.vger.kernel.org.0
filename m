Return-Path: <linux-pm+bounces-43732-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Q7/fCIE9qmmSNwEAu9opvQ
	(envelope-from <linux-pm+bounces-43732-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 03:35:45 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 736E721AA2E
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 03:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E8DB302A6B9
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 02:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2364D34B43F;
	Fri,  6 Mar 2026 02:35:42 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021123.outbound.protection.outlook.com [52.101.100.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFCD13A244;
	Fri,  6 Mar 2026 02:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772764542; cv=fail; b=jEh0SmSOlc5OcJJHu3JcwnAZHtkUMUvNdwl5M5hb98EtvTXJBjv9rP6q7cYTcuVRz6ZUxwjz2OU0yzFmbkVRFsugaLm/IjMf67c2O9uWqI06F5P+dhDuXS6aFYkMRfGafokS6OIP1wWxX+UCElzsUrIyQqdbD4N3PWSqwsnOPDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772764542; c=relaxed/simple;
	bh=j9LVpehyBcqmT3ACl/nIFzM7g9JKDxJEU04nRCJeKfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rEbg5f7HCWEnluPwqg5HGOCH1Q5y7ycOEqvr0T2xCqFSPF/KiR0Mxh9JtGSG/g+D1R+pQWNN4xA4u9nUYALPBgZHQpQqgcuW7+mGjB6dCMfhDazjCDJpk0TkiHj6PZfgo+2lUKfKzFNjCBfZLBpfla0xjWbx/bkqxutYtcUko4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XNo67p913a/ClRHspksuEfxGdl7QCELt05QRktgcQlskIbp3BN00SRRPHlqTiZbl4ledadpUuOhlU/K8w6ppaggRDqFYC9LI/9r/pNVHXHV/zAxOshdGD80YwsBdYqkTAJ4WV2Ln+Jb7/5kW1q4xw7n4chzhaFEVMCJoKqEMUVOt3w6wxzWbrbYREa96T3e4wh/AqG024IMKoNWyd1yR9hXaXSn/clnVqzysjV7bwm7bo6BoDkOqRsIamWWy6jTYytSimX33jJSpQgBPrKmIqE2tobvft/ul/Z+yxLZlKrohkHpaHRH8W1qXjIONEqPw/xsSz5QzLHWRKta7WLwLcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NzPj8K6JSMekJkWmN5k4L1muPntt271p8CiT8od+BrE=;
 b=WLL5hvo2HjwfWK1lyJglyP9gOyOPokJZSY0rK6PVf9tr/3hnvW69PbsJOSMVXfZCvXhxH1Ldh9J6i+mQF5+FtQj8L8mlynfgTrGhdFjIXARWK0uG1snm0UvDOobLuIBHavaAQu8o/WJx6qs4aMWzr8W01meVm/KPfqiCj733Xmteeo/4AAhtSZRg3/Y/znAzFmL+23jEiSA2hWU3XVljGVAVisx5/vS3oUacyDwJpfPiVorFqL84w0+4VpIJtuna/7fhfhIgmtf2pAHqwnmW2wg8HdL1T6ZBse/gZHdWYG4b1QAJF6fMmK+0JsIq4z3kaHsDobM+F8BPuxa1tqA43A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWLP123MB4100.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:8e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Fri, 6 Mar
 2026 02:35:36 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 02:35:35 +0000
Date: Thu, 5 Mar 2026 21:35:30 -0500
From: Aaron Tomlin <atomlin@atomlin.com>
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: rafael@kernel.org, dakr@kernel.org, pavel@kernel.org, lenb@kernel.org, 
	akpm@linux-foundation.org, bp@alien8.de, pmladek@suse.com, rdunlap@infradead.org, 
	feng.tang@linux.alibaba.com, pawan.kumar.gupta@linux.intel.com, kees@kernel.org, 
	elver@google.com, arnd@arndb.de, fvdl@google.com, lirongqing@baidu.com, 
	bhelgaas@google.com, neelx@suse.com, sean@ashe.io, mproche@gmail.com, 
	chjohnst@gmail.com, nick.lange@gmail.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [v2 PATCH 1/1] PM: QoS: Introduce boot parameter
 pm_qos_resume_latency_us
Message-ID: <ywpvfvyxv5wg72twleuhxbnaibzdb7efrevqul4kqr4zxoocew@yweo2as3cblj>
References: <20260128033143.3456074-1-atomlin@atomlin.com>
 <20260128033143.3456074-2-atomlin@atomlin.com>
 <d19eed6d-48ca-4df2-9739-0455f47f1485@oss.qualcomm.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ceyilhu7u5lxla4h"
Content-Disposition: inline
In-Reply-To: <d19eed6d-48ca-4df2-9739-0455f47f1485@oss.qualcomm.com>
X-ClientProxiedBy: BN9PR03CA0498.namprd03.prod.outlook.com
 (2603:10b6:408:130::23) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWLP123MB4100:EE_
X-MS-Office365-Filtering-Correlation-Id: a363dd36-323a-47b5-14f6-08de7b290b21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	Kmagv3wB5QTSHcMIklS9bG7fsV/MXDkgeo7ZLDMqu7S2vBlZ6pYc13RYLqWW7xZPEjbHDkAiGQLD4FeyT/wAthbfvBJN9AwZFz56aOMAeGjBRAEmas2qpDtRk5IxlFCwT71wrVDL4PH0A1XpuDPR61s26HToET2qHV24Majib4Ug7xLvwpGkn46B/iXZnN+LscQtLEuCOz0GJ0lYrg5Robsgbwc81bAWHdNmsl4J1vtyMlNWNCmB4Q6udB9NoCIm2vRejjS8v1VXukoAQz+/VM/ZwnldYHs27Jpgm8gzZc6QIV5Q2MQzgqMKX2bIgC47+JeJIJXSw5IGgivgkPcWn9DAtyP0TbB14vK+EwDHyS/Qj4CGfvxxrvpJ7LKL8Ks441nEtuLrpUDhrr9z838uNl0pbBJdGMeh2WdHM5/oe0wsIxwJHqJHoXDkQgrnQXCeUiya6gJvD/MnKLRHju1f6glDDILbiYwysKshT64W9Quym/CWl4QfNZDN/AkntRBkkE1OyEiu/cdC8VIjRWzU7u3rRFhbSLxTqJ54VClV4SXgkVTjzvQAR1icku7VLzfTeaXX7sqMYvk+RkpvIIGH0FSbm0mO3KdNsndWUuJ7WK/obzttcp16SXQVZ7bwhN9OdU7I//MdwwtqQ45EBwX76F3JcWK0IVKOTDJVSSms61/HlKWU55lA4mevipEsAXzsr54k1rUHjb+jxlHXwm2D7ndi16LteCB9xDSebSfF12w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SDJtajYrcUUrUFZsSHhKbEc2cEY1L1hYSVRZblkzQXdTdnZiTm43a05QdFEy?=
 =?utf-8?B?VlNGcktQOExXRUpXamg5VjZ4S0ZqTmxLUm00QVFnMTJJR1RTN1hVbXNKaFhB?=
 =?utf-8?B?TWNuNEhBVkkvS2IrMzhkQ3p0NVduMmxSVU9DQWtINGlkTXRrMnpvd21qZjVq?=
 =?utf-8?B?NUo3bkxnTEx6LzViL0g1dWVWMkZlK2txRndmUzMrTHo5dlJVNUtiQ0FkTHlU?=
 =?utf-8?B?dXZmYXV2LzFuQThxWWhkbkhoWExIeGdobStvY0lZNFZJbVJBZ2IwWmlkMmM3?=
 =?utf-8?B?RE1odjkwMUxZVEZaL1N1WTBuenlGaktvSVUvVVM1Y0RJZG40U2JWZGI5RjBM?=
 =?utf-8?B?QVNLUjJqakdQVlR6UFlqWmJwS0R3TzRzR2FEeStTSm04WTNlOGg4NDczbkRi?=
 =?utf-8?B?ZnlER0xEZ1JtU1RvVERmdmgvRWV2b2ZvQ09OMm0rN2M5TTVTbk5lLyswMjA5?=
 =?utf-8?B?K1hrd1Y3ZEZhQTBjTEZNOUxLOGFzZEpvK0dGS1dTUHErQ0txaWZOYnhCWXlh?=
 =?utf-8?B?K0ZtWmhBS1pVcEFWUnJwZXJ0bGFFU3dLYnIyaWlleEhyNm1FeWNxL1J4K1kw?=
 =?utf-8?B?TWpSZHlnR1N2QU9SSkRVOU4yZ1d3K2h1RWx3Q2U3QVY2MFhORGtmenRQSjdO?=
 =?utf-8?B?NzRGMHpoNFkxRkxNd2h1SGFHRVZmcFdXTzArbm8vdFdDZUZZUjFVVkNyYisv?=
 =?utf-8?B?R2t4VEtKeXJkQmJWZWlTelhCOFFnQ0RvQlNrWlUwTkp6RlV2TUt2cE9CdGFX?=
 =?utf-8?B?bDlEZ0FSUldqNzhOZlRTUWR3N2hLUFZ0Y2RSbkU5N3UrbGYzaWhNRXpyTlI0?=
 =?utf-8?B?ZVVSNnA1Zk5FVURjUHA3RmhuS3FJRG5SWC9OWWpZQiszRVdMaW0rNzk1bzYv?=
 =?utf-8?B?cFFMOG00SndsZ0JjaTVMb2ZyYXE2OFBZbUVETEMzdWt6bDFTT2hRam5HckNH?=
 =?utf-8?B?VnBnVjZlYVUveFFPekFkamNaTU1aVHJvZlorbG14ZG9mZm14UkhzejVFcXZo?=
 =?utf-8?B?YndldWFRWVBwaEY1bnduZ2YvQzQ3MnQ1c2pUNjUyNnMvRTdNQjEycGJ5Y3ho?=
 =?utf-8?B?VmRtdDVhRFgzc0RxL1lsUVlLeFNJbXF3R1F6eTlOaGFPeHpQbk54cldlSi9M?=
 =?utf-8?B?SC9LbGk0WnBaeklxOGtVTmR0R2U0TURkRjJWZGJwNmVISE1rUm5FTHJ0WU5l?=
 =?utf-8?B?RUFvTDVnMjdlS1Y5UjgzUjEwWEE0K2N2T3YxTWw5OG9qNEZIT1RvVFdHQmJQ?=
 =?utf-8?B?ZDdTVnpLdTk2dWZnTlNtNzk2ZlBLby8rZlk3VUV3SGRVdGtXbkNlY3I5Ymxl?=
 =?utf-8?B?b3JkeENNVmN1Nk40MzhxdVdnN21oNld4NGdsb05iV3lLRGQ2NVBrcU11UTVa?=
 =?utf-8?B?VGV4U0RjRE1QVCswbUZtUnhTM0pNL0xHeTZKYm15K0tld25TZWhKbjdhNUF0?=
 =?utf-8?B?VlhYZzNISGlHZGtVaXlYQklmQ1pGK3lrVTcvRVdtUjltWmd3UnJLNGJhRFVE?=
 =?utf-8?B?RTJaVGJSV2Z0b3pPTzlkYjNhZUIvbXg0MkpIUGR6amxZTm5QalpDcVduODg2?=
 =?utf-8?B?RkR1dGNWKzRPMEFmcXdMQ3N4aFBJajlMeC82c2JSVkhzWnVxRU5OaVlNa0Iy?=
 =?utf-8?B?Rkc1NTQ1RjczSU0xdkVQbWd5V3JyMS9rdUJKVk44V2ZSaXNvMnkzd2U3VXk1?=
 =?utf-8?B?dVpNQlhmaDl3bzc4SzltcFZ6Ni9Pc2FRNFlLRW84Q25rRDdrTUhuRW41aFhY?=
 =?utf-8?B?cUlTbURTR0kzNDRlLzliaWVZV0c5YXAramVuY1pLRUtYTExKR2p3TWY0SXJP?=
 =?utf-8?B?V3M2dFAzRjZpdkU5Rm41djJMaEJJNHJZWkpHaE9KbmVrTEovNUsrWkVhM1U2?=
 =?utf-8?B?a3ZEVzJxSHFJWGgxNjlCMkszbUZ6eWlMdm1OVlFTZE40VTQyVUl4dkQ0dDU0?=
 =?utf-8?B?SERkZjR0aHUrNFBqR21hQmVmZmcxdzZkcmJJd0tEVHliZlVyR0RGMDU5TExU?=
 =?utf-8?B?VS94QWQxZnRGVGNEV0x4aER1a1pLYkkybFR1ZElaU3lzek9xL3NEc2k3M05J?=
 =?utf-8?B?dE9pQ0lIVnU2T2p6WlhZK20xdFdTSXJEYTBiL3FycEJOZjRXOGJCM0RrdVM5?=
 =?utf-8?B?YWZ6a2I5TTdsb2F0Y2tlb1FwQ2s2V1JtcnBFZSt1YWhteVoxVUF6d3ErOHBS?=
 =?utf-8?B?Tm4waFp3WHNZNndtb3M3STE2bllRUEV5TlJ3YmNxUlhUSWM2dWs2dXhXS2Fv?=
 =?utf-8?B?MS9oRmxCRStWZTk2b1RKQ2tub0RkUmN6Vis0VXhUUkE0UEM5REFKZm4wZTdj?=
 =?utf-8?B?blRiZWpucklZSm1CbjM3cFRuWXlUd0Fnb0ZXRitmaU9hR1FMVzZsdz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a363dd36-323a-47b5-14f6-08de7b290b21
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 02:35:35.3799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NJsOP5Ue6crHEuT1RkMqXTBSnMQVHYAfCvqC5dtJsH4568Lwg0E8VNVZhty5xgohvr+dxGIB3gF4vEkPG5hirg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB4100
X-Rspamd-Queue-Id: 736E721AA2E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.44 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43732-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[atomlin.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,alien8.de,suse.com,infradead.org,linux.alibaba.com,linux.intel.com,google.com,arndb.de,baidu.com,ashe.io,gmail.com,vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atomlin@atomlin.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.951];
	TAGGED_RCPT(0.00)[linux-pm];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

--ceyilhu7u5lxla4h
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [v2 PATCH 1/1] PM: QoS: Introduce boot parameter
 pm_qos_resume_latency_us
MIME-Version: 1.0

On Wed, Mar 04, 2026 at 05:05:13PM +0800, Zhongqiu Han wrote:
> Hello Aaron,
>=20
> Therefore, once a PM QoS constraint is set via boot parameters, it
> cannot be relaxed afterward by any means, except by applying a stricter
> constraint, right?

Hi Zhongqiu,

Thank you for your feedback.

This is a perfectly logical assumption, but it is actually incorrect.
The boot parameter serves only to establish the initial latency limit when
dev_pm_qos_expose_latency_limit() is invoked during CPU registration.

Once the system has booted and userspace is fully initialised, an
administrator retains full control via the standard sysfs interface
(i.e., /sys/devices/system/cpu/cpuN/power/pm_qos_resume_latency_us).
Writing a numerical value, or the special string "n/a", to this sysfs node
will successfully relax or completely remove the constraint.  The boot
parameter acts as a crucial "birth constraint" to protect early boot
phases, rather than a permanent, immutable ceiling.

> > 	- The parsing logic enforces a "First Match Wins" policy: if a
> > 	  CPU falls into multiple specified ranges, the latency value
> > 	  from the first matching entry is used.
>=20
> May I know would it be more reasonable to apply the minimum constraint?

Enforcing a "First Match Wins" parsing policy keeps the early-boot logic
deliberately simple, predictable, and deterministic. It avoids the
computational overhead of iteratively resolving and comparing overlapping
cpumask conflicts during a sensitive phase of the kernel boot process.
Given that this parameter is intended for deliberate, static configuration,
I favoured parsing simplicity. That being said, if there is a strong
consensus that evaluating for the minimum constraint provides a far more
intuitive user experience, I am certainly open to revising this logic in
v3.

> > +#include <linux/list.h>
> > +
> > +#include <asm/setup.h>
>=20
> Including <asm/setup.h> in generic PM/QoS code seems not appropriate,
> and pulling in an arch specific header creates unnecessary coupling and
> potential portability issues.

I completely agree with your assessment. Introducing an
architecture-specific header into generic power management code is poor
practice. I will refactor the parameter handling in the next iteration to
eliminate the reliance on COMMAND_LINE_SIZE entirely. Likely by retaining a
pointer to the original command-line string or dynamically duplicating the
string. Thus cleanly removing the need for <asm/setup.h>.

> > +struct pm_qos_boot_entry {
> > +	struct list_head node;
>=20
> How about to use array instead of list to optimize lookup and cache
> hitting? but array may use more memory.

While an array would theoretically improve spatial locality and cache hit
rates, we anticipate the number of boot-time entries provided by users to
be exceptionally small (typically just one or two discrete ranges).

For such a diminutive dataset, the overhead of traversing a linked list
during CPU registration is virtually immeasurable. Utilising a list allows
the code to gracefully accommodate any number of user-defined ranges
without imposing arbitrary hard limits or engineering complex dynamic array
reallocations. Consequently, I believe the linked list remains the most
pragmatic and robust choice for this specific scenario.


> > +__setup("pm_qos_resume_latency_us=3D", pm_qos_resume_latency_us_setup);
> > +
> > +/* init_pm_qos_resume_latency_us_setup - Parse the pm_qos_resume_laten=
cy_us boot parameter.
>=20
> Nit: style issue, /**

Acknowledged.

> > +		if (entry->latency < 0) {
> > +			pr_warn("pm_qos: Latency requirement cannot be negative: %d\n",
> > +				entry->latency);
>=20
> Nit: It would be cleaner to use pr_fmt() for the log prefix rather than
> embedding "pm_qos:" in every message such as:
>=20
> #define pr_fmt(fmt) "pm_qos_boot: " fmt

Thank you for pointing this out. That is an elegant and standard approach.
I shall incorporate the pr_fmt() macro definition to ensure the logging
remains tidy and consistent.

> > +		list_add_tail(&entry->node, &pm_qos_boot_list);
>=20
> I saw there is no protect for pm_qos_boot_list, my understanding is that
> during early boot, pm_qos_boot_list is fully initialized before any
> other register_cpu() calls. For CPU hotplug, there only reads the list
> and it=E2=80=99s never modified afterward, so there shouldn=E2=80=99t be =
a race.

Your understanding is perfectly correct. The pm_qos_boot_list is populated
entirely within an early_initcall(). At this specific stage of the boot
sequence, execution is strictly single-threaded on the boot CPU, occurring
well before SMP initialisation or any secondary CPU bring-up (and
consequently, before register_cpu() is invoked for non-boot CPUs).

Once this early initialisation phase concludes, the list becomes strictly
read-only for the remainder of the system's uptime. Therefore, lockless
traversal during CPU registration and subsequent CPU hotplug events is
entirely safe. Introducing a lock or RCU protection here would merely add
unnecessary overhead to a static data structure.


> > +	free_cpumask_var(covered);
> > +	return 0;
>=20
> The function comment says "return a negative error code on failure",
> but in the cleanup context the function unconditionally returns 0.
> should it be:
>=20
> set "ret =3D -ENOMEM;" before goto cleanup and then just return ret?

Thank you for catching this oversight; you are absolutely right. The
cleanup path erroneously returns 0 despite the function's documentation
explicitly stating that a negative error code should be returned upon
failure.

Your suggested approach is exactly how this should be handled. This logic
will be rectified in the v3 patch.



Kind regards,
--=20
Aaron Tomlin

--ceyilhu7u5lxla4h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmmqPW0ACgkQ4t6WWBnM
d9YY3hAAiLmW77sn+tqS33OCBeUxKtzglyDoPb/Sa0/eQ31bi+HKnNMhwegtv0O2
s3oxu+a7ajpUNfvZqOkVD0tKYiG3Zh95UAWuOv8j2w4s3DMYqU4SQ/7QyaDHGh9n
nSntXP5p39Avq/hwBrDtIIC1ahOvqZinmV5JaS6YmnnZyYLeJWySUmoom17/+yJS
bNiJ+vj3Iuh3wyRodWO2QsHKtaP7CLP0TEj0m0eC6/yDKdNEeQAYcxlXIGoPGK6F
896i8HsbDQvW6lX4f+e3hT4UTceP2aqLsV1V2MNKOQ2+fVvYLJyQp/n+thtCjb6E
UolqMRyluKlgQRnXuAjSDfKkEKYN0YM8N4BKkoDevp61uRmSMzCFmFZa/2kbl+04
CRqh6p4lI4iG1Y8K3XxQm/FatS7QUZzSs38y4sND9FFYQhc/C8kPSYZ4VwxfkKKc
7/Jil360+TghdWPP+CzgxPwF1cil3GarBFkVfuwvPqClunJCzY8loQZBXqR5ohcf
EFN+4MmlisfW6SPjjNmvgNTZqmbHVum2m3dCBYkf3/YQfw3bEVjbsx8ZzhIVueAj
dcZFoQTgnjLq3tICh0lSEKpCRmhfaaa9a6xnWM/3UcC0t6LccWBC0VZPhR624mvF
dYp9kR/MKyMHGgm6SCIRg18CKtHF8YiP8+v+Exfcj/JAggyJtZ4=
=93Wl
-----END PGP SIGNATURE-----

--ceyilhu7u5lxla4h--

