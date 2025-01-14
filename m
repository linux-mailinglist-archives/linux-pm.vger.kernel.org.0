Return-Path: <linux-pm+bounces-20394-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 045E1A0FDEE
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 02:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC85D18851CA
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 01:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8656B487A5;
	Tue, 14 Jan 2025 01:19:05 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2143382;
	Tue, 14 Jan 2025 01:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736817545; cv=fail; b=bH4Qi/HRRES0spgOXGa5kJvZQ1GZCob9PhC6orvlExB0bM8muOPp+E/E+bQEw+0ZKS+QPs6VGj2cVr/qc0Ia2qEc+cA60ARbqjj0wP6S9jBjuGyD9HVcaVoWKo03Nozkn5A9ziFHSGC+mfc4j7SMGcw1+jwiJGDyjCkaLBvNzjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736817545; c=relaxed/simple;
	bh=Ruo0hIy69j70USb79L/p9CEzAKuJjNL0+JxjbIZdMPw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=asqYdi60u9rlG6eAQARGG3zaBuuZELBwJbNMWieocz1LDwfcXFPE03mls8U/HEGvmk/Y5DGSUgREBbGo26foouG7FI7W4y1098ahqL1U/yYhEMn09t0GCSj7WoPlG6UXqLMQERVdARG0Ekrx4PdQnpgT1NIKBxqQ2Lq1wTnKjj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50E1024m018216;
	Tue, 14 Jan 2025 01:18:43 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 443fm8ag0n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 01:18:42 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DY6k/iFfkEKlfijMLvG/la+lfBeTg90ZLYG/vXxfAyQG6GSoAOkXe/7PhZXZs2U9BSfI0FiHDr4xyZDYiW5xpYhr+Q9kpqza+4jfNK+/eq1+uNCUiJWpNYrF+6NF8+Me67fLWFvGVcUi6ayyiId9srBmHsA0+EHcMREH6gXfvcwCsa0G90y3mom18g7MM9JaOZDFUYEZG4iGisf1vroMlUN1BUoCIdObhsEMfwT4OB5kli+TqTiELh5yFKxQ3Ry8p4uKERmos11neml4UGOzGMfhRAl4jgPNfQ3LUzjsJcQIDIXZJkwCBdS9j0iUhyDwiaMOvtjLc7O9DP1AiFbHEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/G8WPhGLyqNj/Ez+71muygePsUGi9nPMLlEE5kFDHw=;
 b=qfxWwSqcz7wgiCyP00agnSIC8l0KnFsfRQW3uZVgnxEyEy4CDdPyoIZClaNX5ZDgLUwBy2lEdD7PHUQGpYr+u7nI+T1kdwXBwa4PZ7BwOrqpzxyynVNKSBTPmL+JUL4d5DVpPsNFTP3T8P5XZaCoNojtPLHk6cgs+kYUKGSNWidc5j6O4YRER6ILFZ6WBLsFd5BTRTmBfbI4SaGmnTBMGEcB3UKLMEr9i1p/UayFyppcT1NbWoPPYUviAQW46/9dQrjkHxVn7236UjM1BLQEnUmS3h3flNTk0undNEBoE7jSsNcIeNDyiJhIyUWKaWkth0TPUsp6Jgipw+8YwsX1Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by SN7PR11MB7994.namprd11.prod.outlook.com (2603:10b6:806:2e6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 01:18:40 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8%7]) with mapi id 15.20.8335.015; Tue, 14 Jan 2025
 01:18:40 +0000
From: Xiaolei Wang <xiaolei.wang@windriver.com>
To: ulf.hansson@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, ping.bai@nxp.com,
        l.stach@pengutronix.de, marex@denx.de, aford173@gmail.com,
        xiaolei.wang@windriver.com
Cc: linux-pm@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] pmdomain: imx8mp-blk-ctrl: add missing loop break condition
Date: Tue, 14 Jan 2025 09:18:18 +0800
Message-Id: <20250114011818.2401479-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0018.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::19) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|SN7PR11MB7994:EE_
X-MS-Office365-Filtering-Correlation-Id: 32ea469b-e380-40bd-2f89-08dd3439612a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|7416014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VJa9Gi9+hrMyVgLGdYhYa7p6SCBDvWLzSyIUUNLpRHIJnrj7kLrPzHSJRY20?=
 =?us-ascii?Q?mohyz2hW1m1JsvPHZ7Iwd31nS05g5mZlHkwPRVpI/gvP5MBtIuAUymTgWrIy?=
 =?us-ascii?Q?zPb8uSePNHcg01XtDpdTJwvDm5tqfYqZ438R+c6oTwkNuMZf9xWYVkzU/oBp?=
 =?us-ascii?Q?GtlBm2XLMZdgcmiIOeWuo1vzLZenpXRNhg/VicAyvC4Hlu7kt52qNl+odUhL?=
 =?us-ascii?Q?p3jgFVxjpCv7JdqArqDa3D3ZKBLTrwclGQSBpQDMm7eeODjf5FBwe1DY8yON?=
 =?us-ascii?Q?/3sKext7/MGrHEhubgV5TluFzIgkFf/3jJOfQe4kqM3tbl1EzierE1KNwBu/?=
 =?us-ascii?Q?CgVGE2WNdBhfYvg8xgg3UlVkFzkM5+sNFaviUgpVILZJMXO79zdn5s/7TuqJ?=
 =?us-ascii?Q?yi4NrilCraS2hlO5cOZNHlFTDU4qvZvDOgN9DLGilyA+uiOR0Bl42SREHqc5?=
 =?us-ascii?Q?8Q5nA6XdmBtomWy3VSKoV7Fd6C4GwUJqdBeovZYqfj2shi93BeGf7EyOvjz5?=
 =?us-ascii?Q?oQ5hKP5D7qoisYTxMNAGd99/vc75rBYsax84I2xnFKN4BTY/zbg6r3Q/yJNH?=
 =?us-ascii?Q?rt0iJZakXP1bdT+/OCqGtkCZY1DOXHcxv92mBF6dkyMOjrxo2sVTKwAtAkV5?=
 =?us-ascii?Q?kxG6UVzExNIO76Z9S4Dzhb8lS+2erSeKsm/72eg9ZRB2ANxmBuZIUn9q3YtI?=
 =?us-ascii?Q?tfKfXbFuZfrcFXPoruQoDahGzecQ/QaW62/ifmLZX54gsNg2gtvFhxHd7cD5?=
 =?us-ascii?Q?s5cnb5jodRvHS7/ABA9hWxdM3Xhk+h2E3jsyeLiOXPw4C+l9KqKXv+H+M0Sf?=
 =?us-ascii?Q?7H5jQqnBRFh1JzhNWYMPGZwfUW8Kdems4BZrdgaEYcIRxed8P9FgsYqNE+EM?=
 =?us-ascii?Q?ufb+eFqjKfS7SEW7XnVve5Au+WNgtdyEWwuYSeHlsNeH0QRSQ8pe5hgh/A7+?=
 =?us-ascii?Q?HDE2tmdJaurJtYT8Mty1NPtUOzZ7tmQfCkJ1KWA07PxQEbA9Ka9ghAiHXkxO?=
 =?us-ascii?Q?rFNV8+/Wka/1OteIqNElxuiseuTYgZHY6qQMGvvrLVrqMzboQdeSQGjcZAlj?=
 =?us-ascii?Q?umqmpRZ8I7zeDHsr9GeeMzwQLK4cEKQb5jx8TsYKphCe1R9oshVKl4BbR7VO?=
 =?us-ascii?Q?2QotWFhGSihAdrhK62clX0gN/BLkbfslelmXizZ1daSVqg0L7G9JlUvp355n?=
 =?us-ascii?Q?7CRJiI7DGDEoPk17PxlHrYZnOE5I5ZLzERjujNc579s4cRdp21ygEexrp4Q7?=
 =?us-ascii?Q?A/9bB5jVs+lyjghwFbwAhOZF1m4ObBvnXOZKV7zGhybHaS+oanqIPh0krB9H?=
 =?us-ascii?Q?3QqR6zIDdIUfEKA7+hsDRwnh8ir5Ebp5KaaOfffejDuu4+3LFEzyJ1AnG/R9?=
 =?us-ascii?Q?APdDauxyRiQm4BKW2/d0NZP9t/toP5bUpxM4a1JctCJuM3AJwThdPHtGCyx2?=
 =?us-ascii?Q?6ytUofC09qc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(7416014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9PRDBbwpwRXejGbkkg1WeoeHt2In01u31VuHHvnEUf+1fxVzVZZ6C26ijORK?=
 =?us-ascii?Q?i8wohj7eXncDbmGIZjG1aZxKvFf6KQzLCihueyQgPR2IcP2L4WfPavAjrXKZ?=
 =?us-ascii?Q?/eukCtJpZauGCvBCXlvWA9Rzco7vduFVcHSuyaOc61mzKC/5763DTfjUYOFS?=
 =?us-ascii?Q?Ydr6C91XDRBWrms/aI/tZaKVWl61umMVfm71F55elzxdrl8sstTH5az1vX55?=
 =?us-ascii?Q?Mp0dgQ8OFseCtZPc3G7e35mJCLbDQy4XGhNR9TTTxnrWfsO2h3ZoyTHbLEgV?=
 =?us-ascii?Q?UvyLl+COHD21QoFvJkTKJiOwqLKik9mEtRbGljRBmb4QD3CYrqa7kr9UHrMt?=
 =?us-ascii?Q?Kb5Ej1sPfeEo3EYZrIfb5RfvlLPOcqZN/T7RDXbPqZaBIsrq54iCFcUgoqQM?=
 =?us-ascii?Q?EttcMnemcVG1eHmUNkPmjJc50PFcxavqCbplmQI1IQR/kRglkmCVBcG46+jy?=
 =?us-ascii?Q?ValwQukF1cwzbWKKFg6p2VezcXAXAAYVHa8aKAZcYYvBrxFGWxkq/AUNhCOl?=
 =?us-ascii?Q?GtF6CrHilaOwz6Zd5hpNkIM0pIVmPwAJgq+ea0Y3BOJIYd6d/Tl+dLs7899u?=
 =?us-ascii?Q?bHDs0ZLmZOn/sgirqOdp5oUxbVG3Wwz+dNxFQY2pTCyESV6dc4z+Tof5hS8W?=
 =?us-ascii?Q?2o2QxvOneXWk07Z1NLP3gswxuvRONmB2Ue7qzSTtgPnwpnQX3lu2ssUD+Sqs?=
 =?us-ascii?Q?MY0QSaTOm+H+HS0zqyJv8Sw+qcoV5EmCXbBR11Z9suI2ZfwUHqWYNdXFBWkU?=
 =?us-ascii?Q?GvL2ZujYhh3rj6vmL1uG/E57vYLNqG+NtyuGHk/MTlSliZ5iIA7R6mXy6L1J?=
 =?us-ascii?Q?epj3/QbNSF14EvC0SBJzYs82JFPj7+6kjfwbNow938LVjZAVjZzN3UWJ+Img?=
 =?us-ascii?Q?tHVlROddg/8C7bkMwrrF/caWC+5ztLVn3le+PHfWAVts4HlTSoi0oIifakUV?=
 =?us-ascii?Q?J/fk0T1YErwjdkKcB5zSsj69GgA8NKEuE05hglst5HuEqPMl9MB07p/jMe/s?=
 =?us-ascii?Q?CLKRh8aKM3gsxhpVyyEOD1AEzj64SeID4Ivf8k+/xW/jA7TniDWXtZEhoPgx?=
 =?us-ascii?Q?5+2SXsonxwakW4YLxdFRZzZWZ7l3eECJ3kpDqwy8fwOZxbl3M8u1/eXZt4BQ?=
 =?us-ascii?Q?ueAnBmuP/aoWeyRtMD6uq8tsCZgIC4k0LYJkZc6XbT6goU4A91sfF1D8KA8w?=
 =?us-ascii?Q?V/jA6WOTJr/iZ84EouShlVxBnc5gkbnAAo4b+5JiQcC7G/DvSvkv81sUvu6b?=
 =?us-ascii?Q?F+PnXYYnPZQo6B2SmvBbfMe6XNL0skGUyZ8wLg3ac/LRKEpw8v426DyEVpV2?=
 =?us-ascii?Q?rJMalEEdqF2q9+8TBWEecmxEia0s/bVviV3kS8gcoTgsv0OqhmwlMY965J4T?=
 =?us-ascii?Q?xMSKy5vcRHd1cUstW9lg7EVEeSTKkYC1xrt/Yvdi0/gc7VDFjjdvzlYcFnKE?=
 =?us-ascii?Q?DhGXB6w88/X3djKQ6x25HQ2XBf9vuISB6Mq+RdWS4n9xrPT5Gv5M0gEhlccy?=
 =?us-ascii?Q?vS86hQ4WXrPzd/CiJUKiYRt7BdFXSwmLobg/8OTk0hPJ7KotWegd0khAyg7o?=
 =?us-ascii?Q?/5yyLiEeYmvb4ei5pXqrYeZI+s5Fj0MxLdPLCxtK3X0fExcMLvBRkk0hbrjH?=
 =?us-ascii?Q?wQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32ea469b-e380-40bd-2f89-08dd3439612a
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 01:18:40.6051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dITe2xIpqnMXA1NcEUAY0lP19yxvz2DVsESNJOUTv8mQlrXsZJJGXHBpOnj2HT/cjGEH/rN3y0ayt0lJgsnU9EyRSjuYbVrUuU6IW7Z/lzk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7994
X-Authority-Analysis: v=2.4 cv=Mtmo63ae c=1 sm=1 tr=0 ts=6785bb72 cx=c_pps a=7V8mf9/socFTThwl5N0qNQ==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VdSt8ZQiCzkA:10 a=bRTqI5nwn0kA:10 a=VwQbUJbxAAAA:8
 a=t7CeM3EgAAAA:8 a=7giN54SSlXpMncPZmE0A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: 80LRkXYX8ZZG6wc68yZbQA8CFbEDt89H
X-Proofpoint-GUID: 80LRkXYX8ZZG6wc68yZbQA8CFbEDt89H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-13_10,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 phishscore=0 clxscore=1015 mlxlogscore=999 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 spamscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2411120000 definitions=main-2501140008

Currently imx8mp_blk_ctrl_remove() will continue the for loop
until an out-of-bounds exception occurs.

pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : dev_pm_domain_detach+0x8/0x48
lr : imx8mp_blk_ctrl_shutdown+0x58/0x90
sp : ffffffc084f8bbf0
x29: ffffffc084f8bbf0 x28: ffffff80daf32ac0 x27: 0000000000000000
x26: ffffffc081658d78 x25: 0000000000000001 x24: ffffffc08201b028
x23: ffffff80d0db9490 x22: ffffffc082340a78 x21: 00000000000005b0
x20: ffffff80d19bc180 x19: 000000000000000a x18: ffffffffffffffff
x17: ffffffc080a39e08 x16: ffffffc080a39c98 x15: 4f435f464f006c72
x14: 0000000000000004 x13: ffffff80d0172110 x12: 0000000000000000
x11: ffffff80d0537740 x10: ffffff80d05376c0 x9 : ffffffc0808ed2d8
x8 : ffffffc084f8bab0 x7 : 0000000000000000 x6 : 0000000000000000
x5 : ffffff80d19b9420 x4 : fffffffe03466e60 x3 : 0000000080800077
x2 : 0000000000000000 x1 : 0000000000000001 x0 : 0000000000000000
Call trace:
 dev_pm_domain_detach+0x8/0x48
 platform_shutdown+0x2c/0x48
 device_shutdown+0x158/0x268
 kernel_restart_prepare+0x40/0x58
 kernel_kexec+0x58/0xe8
 __do_sys_reboot+0x198/0x258
 __arm64_sys_reboot+0x2c/0x40
 invoke_syscall+0x5c/0x138
 el0_svc_common.constprop.0+0x48/0xf0
 do_el0_svc+0x24/0x38
 el0_svc+0x38/0xc8
 el0t_64_sync_handler+0x120/0x130
 el0t_64_sync+0x190/0x198
Code: 8128c2d0 ffffffc0 aa1e03e9 d503201f

Fixes: 556f5cf9568a ("soc: imx: add i.MX8MP HSIO blk-ctrl")
Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
---
v1:
  https://patchwork.kernel.org/project/imx/patch/20250113045609.842243-1-xiaolei.wang@windriver.com/

v2:
  Update commit subject

 drivers/pmdomain/imx/imx8mp-blk-ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
index e3a0f64c144c..3668fe66b22c 100644
--- a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
+++ b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
@@ -770,7 +770,7 @@ static void imx8mp_blk_ctrl_remove(struct platform_device *pdev)
 
 	of_genpd_del_provider(pdev->dev.of_node);
 
-	for (i = 0; bc->onecell_data.num_domains; i++) {
+	for (i = 0; i < bc->onecell_data.num_domains; i++) {
 		struct imx8mp_blk_ctrl_domain *domain = &bc->domains[i];
 
 		pm_genpd_remove(&domain->genpd);
-- 
2.25.1


