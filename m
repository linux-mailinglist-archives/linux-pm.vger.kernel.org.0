Return-Path: <linux-pm+bounces-41765-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qF8eAgVwfGk/MgIAu9opvQ
	(envelope-from <linux-pm+bounces-41765-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 09:47:01 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7260EB89D7
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 09:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8AE44306C4EE
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 08:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423903469F7;
	Fri, 30 Jan 2026 08:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HKia3Xvp"
X-Original-To: linux-pm@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010029.outbound.protection.outlook.com [52.101.84.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74603446D8;
	Fri, 30 Jan 2026 08:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769762561; cv=fail; b=I81Iit+P/SN36px/cAdL/sdpkHc3ExTgmv5b0f1G8UB7G9b8MfotOEBRGTHhVWMPg6fh3tH4KkKfNWTLoWtAqEhQucyZzxF9CqTsEX/gFQlvkRmjk9SE0FV05kA1xCFNRK+TA0T5tD8OIWMgewqjyl1KwmGxQ4eCIZxYSyUvZDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769762561; c=relaxed/simple;
	bh=VthYA/B3X4fUdpn208dmXtlQu6iEEFK681nOUsOOkEg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=IjLZH6cCMBxAunZLLB5B8aKUUYZqwJx/Hs+wifvDsYUa6RkYFXgo4kmiIW64kKtliJAxSQEnNaIrxrZTeTRh3Y44jPnvgRMmX4MIGPbwCR2+y1/MtYxBxZopXew052aoziYdZhofFWpaynMxKaYW0GYi+FQC03TPbShFspmsGB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=HKia3Xvp; arc=fail smtp.client-ip=52.101.84.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oB7WYaqaCAoGDVTokA8VSHUTqqBRqPlShDhkBOWCODRCsubgvAJQhmimOWEdW2mEKHzp3VHhVYaOMTJlENZBqNh8h6p2seCYKtTpebSjjyDOCBbP88n/qMxwimAIeqsqbGiSxlYti2dRjdf1/OknmzO9pVwjTps6xO9T8IID/SgdoaaHiKZS1kxuqWGclmQ/pnCuVnv4yoacEOWj52r3b/a9HzG6TVXSOn1BRP9+kRX0SJES+U2vpMRF1L+RT/h/QkwceERKcimLVJEp8Rq25q2RKAAW3bxNAn5phz39bh09QLbYi0Y8UxTmWkqCcVxm6XhaMekwtWkIpb5xaUykIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/lg9AXY+i+OvgvlZTeAfHtQg4jup1zYxCUBq6vjApA=;
 b=BB6/EJHC7NE1Ia1ML+x+sLsJtLmZxwOGK3OeoIhQAWWBdgNWP5QP/OiTndxQ2VjR5Ig9umtKUBnWVh/tjGsRiAZU4yW762NEGKsTQw5iiR7xDkgigCuQdec8B6X23guxxts64JVzC4uCnqVsNL5UgUnfsG8Rr9mds/OxOdsoVOmUikDSyAphP3HmbXLIQNaPFOpFrNo0nMpIonTEjBDV7GY1wMBqz/vTLBhhVxhJvZTsTfrDgggJhkxPtzm77nqi5ieUygAe7jJvqcWkINVe72YGgWJWMdIGWCgDGnydyszDGrI8qa7xQ9lZSnof9G0dRIw/TOb4Z115g535id+r1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/lg9AXY+i+OvgvlZTeAfHtQg4jup1zYxCUBq6vjApA=;
 b=HKia3Xvpkx+grmYF4M31A3+pgE50A2ykAciJDFwrmQ7m6dL7XrSsR60FDn6TSH3+r7n88ySUryAbv0mhrKy88jZDM6WMx1IVoL88iYmBmKLxbZEUMCy+Ovvm7W31LbCyo4rp5QtnqLlWIO8xLI4tjoV+j+Z1Z2FDN9VNru8+00kJwYtcAbljPvlZMqf+EANSanzrjd4PGeF0QFjixhBYuXmb+G4xy6LdbtJQbZiWq5bdy0mmV0HYz+4FaeLWabQYGzf4juBIHNDmuHjyH1SIYfSFwGvQs84gycR3O6s60qbssA/NQhdhSb/6hLzbb3jJXFkNOsXmUKcjxsquMkblDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com (2603:10a6:102:1cd::24)
 by VI0PR04MB10232.eurprd04.prod.outlook.com (2603:10a6:800:241::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Fri, 30 Jan
 2026 08:42:34 +0000
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::2755:55ac:5d6f:4f87]) by PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::2755:55ac:5d6f:4f87%4]) with mapi id 15.20.9564.006; Fri, 30 Jan 2026
 08:42:34 +0000
From: ming.qian@oss.nxp.com
To: linux-media@vger.kernel.org
Cc: mchehab@kernel.org,
	hverkuil-cisco@xs4all.nl,
	nicolas@ndufresne.ca,
	benjamin.gaignard@collabora.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	sebastian.fricke@collabora.com,
	shawnguo@kernel.org,
	ulf.hansson@linaro.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	l.stach@pengutronix.de,
	Frank.li@nxp.com,
	peng.fan@nxp.com,
	eagle.zhou@nxp.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: dts: imx8mq: Restore VPU G2 clock to 600MHz for 4K60fps decoding
Date: Fri, 30 Jan 2026 16:41:31 +0800
Message-ID: <20260130084133.2159-1-ming.qian@oss.nxp.com>
X-Mailer: git-send-email 2.48.1.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0032.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::23) To PAXPR04MB8254.eurprd04.prod.outlook.com
 (2603:10a6:102:1cd::24)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8254:EE_|VI0PR04MB10232:EE_
X-MS-Office365-Filtering-Correlation-Id: 1df3c2b6-7f7b-4afe-9b19-08de5fdb83a6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|19092799006|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5pSBDrHsKBl/2NFDzG7mWm29Q+E8gCAn74UCRUSqe9gKhiDYTb4pLAo4gf0Z?=
 =?us-ascii?Q?POmurSN36YioNUWfEf+j9QoUzcBprsJTTaANDwIX7GgO3mcy8fO1/49QgjjK?=
 =?us-ascii?Q?yDs8nc2Ikzl2HFH1FeQhDLL9yuRPq5V69GkDL1lkQ+zQYwoFhjSsaRcF/F+b?=
 =?us-ascii?Q?lczlLztP8E/VHnRCH6R4NLwSeVnEoDdHLWjt9Mf0hlWGQc27G51aNx7YdyZY?=
 =?us-ascii?Q?M+esk4beiKnmQjfqrcDi3yLGbVMH2uevJDU59Euahk3QWJPzluQ8e+2b2aQb?=
 =?us-ascii?Q?2/u68QaAtVruRfDqF2zUgH4OGZYUKuMb0l1Ih2GkWXb7MynjfZ7O3XvNEZey?=
 =?us-ascii?Q?auiw9p6X3BtaRWR2B5cokX11hRRRv0XnU0WG/BsSpWaZSPoRUc4dvqfCcjF6?=
 =?us-ascii?Q?y6+xm0SLa2GtM6Zj+pn6w3+URdkhz3gjzJFPx+AEbzo+vICjDR+O7W+O4iR9?=
 =?us-ascii?Q?jUe0UXY/5DAxPe+i+kW7cgvDFjGQ7wTnuTHoAuF7E5xqKJk6LoKo9b6Suosr?=
 =?us-ascii?Q?b9my1aAzXN+vcvnSUBZNqYcg47aqVYJEpXsiGWC0BW0dhNO51n6tpeQ7zN4C?=
 =?us-ascii?Q?U9fNUSZO1Rpmaup4IgTZ/lOMRj2wiv+p3j0VGQ9iZOA+eDw/lVs6AmGG1OjY?=
 =?us-ascii?Q?SWizIiD1CvQSNVxajMuIVP56bA3DdZ5YlRjErhzUMPQd5JMm8P1ReItyE4k0?=
 =?us-ascii?Q?6YWsGNaXwHkuzNgwvK8JeQq/zHYvCWTxAXcZbaefQSxxHdAHZKYcmEFklyMm?=
 =?us-ascii?Q?ncrCuZaR2rabRohxzgnwi9CGriGLylRf4GiI1SgicPaynjdkm5jRsDC54qXY?=
 =?us-ascii?Q?uw+bY6Dfd/tjqpa5Xo4SsNC1vPhDHHnQDcxr+bEdzYT+4YXGLLKhkcqb5pdX?=
 =?us-ascii?Q?JZsLokajDUGG3rhYeBOvRkGhAu5yHDTaOxKw1mr8q2BYLgDIpAaomIVPSLHE?=
 =?us-ascii?Q?IgiLR1Nn3wTTyJTcCGZMumAAT9YSJfPANYz2q3q6w3DzfU0GTa0buZX3qAZ+?=
 =?us-ascii?Q?0nu6cpR2/r8TcMhdiPb7xRW6uJecdpUN9e0+8poxSeTrmcJYXSg5inxH08qV?=
 =?us-ascii?Q?IGZoBaKXkInN5G/0xnSHXuXuS8LdcdBunNPw1BzTri8linpfNToDYJh8D1+b?=
 =?us-ascii?Q?blQ8UX5bEbqfbPdzR6AndiccWQWJRmHxc1LbMSLmqDrf6PPFAcmOlsd9qT+/?=
 =?us-ascii?Q?Yjq8XjAluBh3dcxm2lhAoPYvM7p/8jZE1OAhOzBRkAQs7nTKMmzw0fYJIb4N?=
 =?us-ascii?Q?5PoFzzC6ev1UriGXrq8CYiK/yUNt0QVi/eQZ18roBPmr+WylcRySXpKPxj/A?=
 =?us-ascii?Q?vCBuCp9oQxraqQMGjQpMf3rjBq5ATzwjENusvUufiaX/ywPm8+/KFIa+AvIU?=
 =?us-ascii?Q?kDJDsyJ8qcV7uYjrU1smJfK8SoL7YJjeRrz9OHuEHc3JCH9zffOkREPKVM+X?=
 =?us-ascii?Q?cnB7ZK7uSNGei1kz8bHl0bgzEy9LIbFRp/H5TFNym46vofAYULp9/iItzUNJ?=
 =?us-ascii?Q?2SlDM39KhG0hMvzQKiqT1qia+SY9sTi4bbOINkbGTZ02rGgEmJOfmhZ20NET?=
 =?us-ascii?Q?BJ4CUJ2NZZAFVq9XcEa0q22sA9wpyxssnFQduSS6XWKgRuOPbUvFKq0BInXD?=
 =?us-ascii?Q?tV8k94BGL3n9+QIWnubyYn0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8254.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(19092799006)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p4Ka+1ngRKN+YcRO8snRF0izU2xrY4VzgyjpotnsBqfhvUhlSXBz9PYnkojA?=
 =?us-ascii?Q?0Ng6tMAH9tNWVIn6UXNxIkO8F/WhhltLALRsCvszUVz3R/OYalvhSR2F2j0M?=
 =?us-ascii?Q?xGrZ8ztmk8l7hIWBCRaO63zcRVYNpn8AeOKnd1/5MOcymHfD5OLiD0CaNxAe?=
 =?us-ascii?Q?eslA2HBL8D930SJ15/loInqZPSwoPRmznVPSCeNr8hEt9/obUWciibbVuN2H?=
 =?us-ascii?Q?NnjoKkTZPlK0CxCi/SgOi59wlolxe/Twc16wtmnU8/yQo9RIzZ/pkO5jOiVu?=
 =?us-ascii?Q?qx3+EkFA317AqIlw40LwdByHDEmkctGyGAUYwLTCj0dpF0plGG9dtFkDZToV?=
 =?us-ascii?Q?bZ9G4IL4ojVEIRYfiF7WluifRy5cbENLXDeYy/7c74qCuvHJ9ghM2lPfyPw6?=
 =?us-ascii?Q?V/+zyJ88XyO/IRveiEgp6ej9MEqscU2mYaRPnkzh8vSLzScMFdOI4MO8Ejwn?=
 =?us-ascii?Q?0QuWIwTU6F6282KaUdGp1UJvEf4A6KqF80lDcK4xcki0g3SP9xpRtZ0nibY3?=
 =?us-ascii?Q?tH0XHPUPf/ZktfYavbTW+nivGqUau5jlin0JCp1Zqli86e33XFEvJZwnukpB?=
 =?us-ascii?Q?pfrvLrrtSBO+c07mLPolOKTHELlGtzPxS9KYsUTX1t43t/Q3Cuaa4Q4sNP3G?=
 =?us-ascii?Q?IxEjIBsF5s2XFNySti+S/VicwAl3Qnw+vyoe5e/5fSQ1HqFkFp9dUzcx47Je?=
 =?us-ascii?Q?PNgtFZZ5S9HT0ydqY8SZ/+gLa2ArpvOHw9Ixaj7Mk9hQ+L6o8jDUzzfVf5+q?=
 =?us-ascii?Q?0wlSfgFDCNol+a0PqTZt5972IQmZu/gD3f3gJH73qN79mIcPbjcQ4KWsdQ7S?=
 =?us-ascii?Q?xfi6jFPqmq4t9oN7mEk5zJ4zSuB8yV/6p5C5eOvVcTDoZIE67C2PFgmOmlXV?=
 =?us-ascii?Q?CxJBwF750kLqmnNoIcoqqWHbcD1MgruqpU1ThUqf70DR8I1yg5VMod7vF6xE?=
 =?us-ascii?Q?C0kKTCoFmVL16r9npkCke0wYpEckEKyjNTa2kHrrCJ5i+we35rICEJI9elIF?=
 =?us-ascii?Q?tTCyAieFhC3Q+cNwnLezaPOI/uTcC4JFidGkD90Q9RRSOf8NueSU6V5osgaA?=
 =?us-ascii?Q?hdXv6rJ/MojEefKiqKq/VKbN0/SGxqTXi0roNpQq+Uc6XPdCPy2kNtJMf3UK?=
 =?us-ascii?Q?hGT9I9jQWyNYD+EI5ESjooSnk8KM0KTBiaMJkEW4Uzgrrcav8/adr9heQnPx?=
 =?us-ascii?Q?lxHDudCsJsiK6nxasjhn2jnj8TneNdbQxuH2UTf/2CO0MmWpteqevdk6x78i?=
 =?us-ascii?Q?ZNd6rglQ/Ci2csBYVMPrDn60OyT+hILUyBSnBfkVxSaX8u499Qm/KE9K6cWm?=
 =?us-ascii?Q?dYxbhx+Fhe7WWfvqSqU2jsTRdJ8akqa89Mp081r5gCYEkHidZOEWKE7GXC22?=
 =?us-ascii?Q?WT7qvsSNms3145j1r6MkBDYuTNjBtT0R2sRlOld11wb5zaJwzBtJhSuxnK6I?=
 =?us-ascii?Q?9rryLG6zVQdzrcDcZg1PP2qRZFG96wnSUj0c8DrprDXtg/W/Cj9U7e1zhlHf?=
 =?us-ascii?Q?DHpDERofHMaqS20G8PCAFpUh1yQQmnMqoSIy9/NLPYVmh4FwZ8H9jptHFTBo?=
 =?us-ascii?Q?9uc17sY2cZdrPQp68uXxeS6HMrgyazpq7hLcU/fVwdzWNleatC1d6XtD+6Z+?=
 =?us-ascii?Q?OzHm3mdoxF6dbsUwPG8AptEmTJtrbi0LUEx14PDgoyLbCdsVB77jq1r9OneZ?=
 =?us-ascii?Q?wGg216ZFQmrZ+qBfFR9GS42Sxwh1yGKmqqGpfpEPWy+H5BuCDFtYfdEjIfmJ?=
 =?us-ascii?Q?+5ugvqigcA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1df3c2b6-7f7b-4afe-9b19-08de5fdb83a6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8254.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 08:42:34.7560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fVihaxs9h4kpLxXiVDKhSa5OkhrR1GlGpn0a54dlwt1fS5xSoBU8uJlRCvqRuM0yX66lNNs+ptHrMHGD/ytMww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10232
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,xs4all.nl,ndufresne.ca,collabora.com,pengutronix.de,linaro.org,gmail.com,nxp.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41765-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ming.qian@oss.nxp.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[NXP1.onmicrosoft.com:dkim,oss.nxp.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,60fps:email,nxp.com:email,0.0.0.6:email]
X-Rspamd-Queue-Id: 7260EB89D7
X-Rspamd-Action: no action

From: Ming Qian <ming.qian@oss.nxp.com>

The VPU G2 clock was reduced from 600MHz to 300MHz in commit
b27bfc5103c7 ("arm64: dts: freescale: Fix VPU G2 clock") to address
pixel errors with high-resolution HEVC postprocessor output.

However, testing shows the 300MHz clock rate is insufficient for
4K60fps decoding and the original pixel errors no longer occur at
600MHz with current drivers.

Test results with 3840x2160@60fps HEVC stream decoded to NV12
(the same scenario that exhibited pixel errors previously):

300MHz performance:
- Severe frame dropping throughout playback
- Only 336 frames rendered in 11:53 (0.471 fps)
- Continuous "A lot of buffers are being dropped" warnings
- Completely unusable for 4K video

600MHz performance:
- Smooth playback with only 1 frame dropped at startup
- 37981 frames rendered in 10:34 (59.857 fps)
- Achieves target 60fps performance
- No pixel errors or artifacts observed

Restore the clock to 600MHz to enable proper 4K60fps decoding
capability while maintaining stability.

Test pipeline:
  gst-launch-1.0 filesrc location=<4K60_HEVC.mkv> ! \
    video/x-matroska ! aiurdemux ! h265parse ! \
    v4l2slh265dec ! video/x-raw,format=NV12 ! \
    queue ! waylandsink

Fixes: b27bfc5103c7 ("arm64: dts: freescale: Fix VPU G2 clock")
Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 607962f807be..731142176625 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -960,7 +960,7 @@ pgc_vpu: power-domain@6 {
 									 <&clk IMX8MQ_SYS1_PLL_800M>,
 									 <&clk IMX8MQ_VPU_PLL>;
 						assigned-clock-rates = <600000000>,
-								       <300000000>,
+								       <600000000>,
 								       <800000000>,
 								       <0>;
 					};

base-commit: c824345288d11e269ce41b36c105715bc2286050
prerequisite-patch-id: 0000000000000000000000000000000000000000
-- 
2.52.0


