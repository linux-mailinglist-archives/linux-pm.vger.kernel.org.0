Return-Path: <linux-pm+bounces-39229-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A458CA5DD7
	for <lists+linux-pm@lfdr.de>; Fri, 05 Dec 2025 02:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AB43530C0635
	for <lists+linux-pm@lfdr.de>; Fri,  5 Dec 2025 01:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3C326B760;
	Fri,  5 Dec 2025 01:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="voWeLl+1"
X-Original-To: linux-pm@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011062.outbound.protection.outlook.com [40.107.130.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3EE2571B0;
	Fri,  5 Dec 2025 01:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764899736; cv=fail; b=oExBmXP+CU0c8dorMhyBefQ4QM9X/L9LsCPjmO1kX6L/Ss01OPiR9WqfG3Pv0u83fC/mdj49wql+Fqdqkph4j1fKwr8Pqrn7TAF10kfEN/qNtQIb5zD40hemicNfns2zaLnX/o9FlEowdlHLageLd8nUEXUvvG1TZc6C1foocho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764899736; c=relaxed/simple;
	bh=w3AkcZSJPuXcZGgrXJyzaOIcsnoE+vyLI4LmeQqh8ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BGpCPvCoMQ6eQuPO26HGJadpqsQb4ky5kJ4OlfTI4MlMf3rm+8C9nOGZiuSL5yqifZ2yOPqmqykKMjFMqo1DWzY2l/9bvFmtxkUt4YklsGQtUtN34CYCRfm7apvIlYVvmQlqxO7/osqSZbr3KWRTOlZbnpS0yO2qDCE8wq6l8oc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=voWeLl+1; arc=fail smtp.client-ip=40.107.130.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AdQ9WCZiFsS+ySRmsfVQzAGHtMv8vg6n4rbhvMSGqNiMeSledHwvnOodZSKxyvCpB+/IQyvAZw3uYnC4IUWHf7tntLVTZs2qNGG92BPZ/bgPfxclBstbRzRMVB8+egglbepJIYENonCOiup/RWJKkgN23+xVN1dUDj/Q6WVPur6D2ik+sXW+S50xsXWlwwWR5wnN/iNLjb4oPxGLRq0q/vVPxGMX5lz9TlZQ9t2q9O3vH3rLsCofnd3lgy2uJi+ocFUX03OA+97XlvEAOavIkcUmkYJWJq57dLo9ZfIFTh1oZnp/Qt+O263ERb4ctAkMK+XZ1UFqBKyyUBciUbPQdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hpJ6YoIy1/rKrWs/TQywX/W8WuYbpz0EIXfqvy8ec1w=;
 b=muyd33eJUT8ucPBSxRfMICBtvGMNwX6srSSfo6OTNZI+gKhhYuu01FYVmwHMZ8l238BKt7EG6TlJSe1Frm3bX6o7MfhkR1tx1huNoM8XH/SENvCTWc94oj4wN7NEETF+3kIKO00w5ieTQ0QS3dEemJ6hqO/ikwycU9EInYBEs3ZBQK16wp4v2dj+KgpoERvxuJkVjV+peUyMNVUJi/juN+rww1K85NrWzT/amxy9YqEhMfNwmk4XOJ9yxr7aEHYskzd2aN69H3xEt0NYFJcK0+SHA+5s0285nU7yNI0QuQVKGSdLTrRzaz2HACIRG182BovkLr6qkbYsbONVL85Ftw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpJ6YoIy1/rKrWs/TQywX/W8WuYbpz0EIXfqvy8ec1w=;
 b=voWeLl+1BWI3jjqrVK5rdhx9HBX8UAb+yo3EZehvB8LaEl29LLYLiPjxp6+GuSFF/BAysNi1BbWPnojjG2D07mhN6Vaie4a1lkPsr5YZ06eWqRd3vfhGK4wM2MjI/S20ysp3yzPxfMR5ZPvwKE5NhR3PFxwmthiX4AEJ56yI4n8pgso4nd1dNnVd7kYvh9f63BzqQvkMA5i1x1Lh6PPETFFdU5khCu3cwxJV+wzQSq/uPXm96Z/SW2dbqDrFylWubY0gMmu3/BawOJWOcDW54KzT4kWCbIgeR+a10qtZ1U/iygSwTb2n/vZRLfdABoQk69sVqtGu+uS7tZ5RToZcSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com (2603:10a6:102:1cd::24)
 by DB9PR04MB8313.eurprd04.prod.outlook.com (2603:10a6:10:241::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.11; Fri, 5 Dec
 2025 01:55:25 +0000
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::2755:55ac:5d6f:4f87]) by PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::2755:55ac:5d6f:4f87%4]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 01:55:25 +0000
From: ming.qian@oss.nxp.com
To: linux-media@vger.kernel.org
Cc: mchehab@kernel.org,
	hverkuil-cisco@xs4all.nl,
	nicolas@ndufresne.ca,
	benjamin.gaignard@collabora.com,
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
	imx@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 1/3] media: v4l2-mem2mem: Add a kref to the v4l2_m2m_dev structure
Date: Fri,  5 Dec 2025 09:54:24 +0800
Message-ID: <20251205015428.643-2-ming.qian@oss.nxp.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <20251205015428.643-1-ming.qian@oss.nxp.com>
References: <20251205015428.643-1-ming.qian@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:196::10) To PAXPR04MB8254.eurprd04.prod.outlook.com
 (2603:10a6:102:1cd::24)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8254:EE_|DB9PR04MB8313:EE_
X-MS-Office365-Filtering-Correlation-Id: 95512183-fba9-47ac-841e-08de33a15ba4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pU7evh7ats4HNiKpujPYLJG23bz6VD8I9t8j5UqWsTn5lt+C1wKTBrQQo8fz?=
 =?us-ascii?Q?F2RrqHkPWrta/GoaZ5VtZTqKDY6EmYIY67EQSS5b2SLqAcwytgDvpst1xEvz?=
 =?us-ascii?Q?Na9NLxZppnoM/Z3WYxvc7DtD2DaY+G7bMR3lzdb0klSsE3ml2w7PCR9P62Jg?=
 =?us-ascii?Q?9IJa5Bn3hwlFFzGDm+kKtsYJLmTjO0S2wVVXyWWrkbFc0cVdpG40XC1ElevG?=
 =?us-ascii?Q?UP2g/GaiQX/ynUJSFRWBPFzqzc2MxhhVd89A+zx6rQI+qhLe7LXIyte/wyNJ?=
 =?us-ascii?Q?LFv4QaBIs+JywL58wijEQbLp1xU9o4M16owzhzOjPbGopiOQKCKnAnDiqnVi?=
 =?us-ascii?Q?fGE+78U/7KcdJ4dKLBrySGKqxkVytY1/AIWrAwEkMUDXQdvGl8DiOHJYO33n?=
 =?us-ascii?Q?rdF6iQ9ZY6YOFkIJLcI5LLhvIzCTl4DCWXL1CydZfPqTkQX6wIEoZcEa3MVU?=
 =?us-ascii?Q?UpCNfCxcu9pXDbgPw0AKjNr2e8Oz83XFIIqKgm3QA9N753C9kMZpH+7RUX4y?=
 =?us-ascii?Q?QSxp9nhzGx2Hh304UbeI8d4SIJABPgj0ngqTWajWqiZC3cEWFvuqrY7s+J1E?=
 =?us-ascii?Q?jii37UYFdcl2vqChS2KiJPEhDWBNuPfe0aT/SMUK85gnAa9mFBOOjj4PShza?=
 =?us-ascii?Q?UNTCUhY+OMGiiW+L1kfC+NPGvcEcQS5SQnG2OF3VBSQp6zFEGRKSsEWL1T1o?=
 =?us-ascii?Q?imCMvzhJEcO2ENNT7HGa+ZsMYEYF/UZl7i3Fikp4IIgLhd1epi1sxkLMTg36?=
 =?us-ascii?Q?Yif368v1mFndQafcRsch+i2rxbsUvn6J3XbKpKQ7IBKB37/5HFYf2POfSfmX?=
 =?us-ascii?Q?Ro4wCmSYO8LLuviF+ebQ2DbysZ8pVZrj2/PWfYvjDY+ye9C9QX7yXY6fI4an?=
 =?us-ascii?Q?KBbRHUam2IXXLfkR8fDULn+jbCRzNqew7WnCFb7YBSl4S3hALvGFntkmkhhV?=
 =?us-ascii?Q?fsmj1xf0rqlhXBW5lFTm4Et+BMCS25Ni2ihfVRxuFXW25wHJJoQoVE20t9nP?=
 =?us-ascii?Q?Fss5lnGQKTGmVDGWGH/z+qV15t1ZbIkytaeLWKgW88kzkmro2CYvdM/II74x?=
 =?us-ascii?Q?kvZ6k2BxjCnVUa/awJMw3AUQoHBLXXXyiy9qrKgK4q71j9tS1eI8ftN82KwC?=
 =?us-ascii?Q?7enaXaeOx0SSMZdEXBt1asj3kY4YYvMKuqOFyNoniZWq7npFYl3cKdCljku8?=
 =?us-ascii?Q?a9T67pXDJ7g75d4DUjZPSiNMj72sXrbUdJRrqVF426qKgzoYh0uHCqubM1Nz?=
 =?us-ascii?Q?fYSqJ13pG9XkGtNyuiqGKMBJWIJ5DugP719RQYhXj2mNQ+liwOoxCer6HuNe?=
 =?us-ascii?Q?Pc86AS1I7ubBO1Lyg/NZOXizDC9C9z8VoR6G/GkZIOc/7vSByUI6FF6JIbyJ?=
 =?us-ascii?Q?eLD4UBYtClYWkyojoK9iaeR2IUP/zgH5IS1qU/RWO+ipB8Hf8nkDCv3x2e6H?=
 =?us-ascii?Q?8q2iJmWXBd6hHv+K7mTiIL0ZVFUJId99IDZV27f9SV+5CvsQE1om8TtYlJ+j?=
 =?us-ascii?Q?z85IKYK3ASQqlz7gtAn615BrB6dTRJwN4nJE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8254.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DdXJLT1/OlOkKPsod6HvTCX+6t2ypgSUObgj2W01wKC33jJNSirgWQwPiC6H?=
 =?us-ascii?Q?cAiCH9wtW7ghjbBenTu7UaWg+frLK0OyK8SgDRfbz8xR1q8BgO8+J1pYx9b3?=
 =?us-ascii?Q?16X0SAeb9aIcwXGGKeTqCjbGXj1lu535BaLew/Ikk0DxQL2TrZrmyIn6otuV?=
 =?us-ascii?Q?gvM10mfy335OfeBzw+K399yQ6TjJKW7qx/21LgZr14WAJU6CkgKKLR9qtDZL?=
 =?us-ascii?Q?Hs3QJLTVJZvHgI4lD/H8QAAJMtbaDUgsVWTPmnt5vx5HO7NpBi1cPDEn1nw0?=
 =?us-ascii?Q?Nap6SzMy3b5cmAuRswRyXOtCeJSiKqu9sUYZJTA27xr2c9Immp3L7y23Suaz?=
 =?us-ascii?Q?aarYlGYtFtXxta4MkvzlwP2nWVBwImpEJl7tMDaNaR+owJvtube0+dJ+Dvjl?=
 =?us-ascii?Q?kc/1/75ORaSxs13vIzyBcmvWvG2+DPCKqjo/RxHke49gwFdUj9kMOQKeWUQB?=
 =?us-ascii?Q?Ro/II8fJIjY3zbZfo3hgwEwceAp5nxAhWkn6Ljhgepyu1d1EOTF9JhwX7tNJ?=
 =?us-ascii?Q?hZsKXhddrX7u9f3Q/KVAK8mCaUtIUezAPyk6rIy1pO1eEjgoSgqTo1zmy3F7?=
 =?us-ascii?Q?R32DpHgxFCuEHhdSdU0TexX7U8jYk41B7OuAAhPyuVpxCiuxgpJ7AcKPtuTC?=
 =?us-ascii?Q?9jOkTHD3YUW1+5w/NddHCAm6Gu5gLbU9csYYV7oBxmVpQ0Qro1t8iMA9SW4h?=
 =?us-ascii?Q?UHSutn4v+aqRiJ7PH5D5gOj+8r9CjBZgN9e/gFBmDgnUQXuwEsHW3SmvK5/Q?=
 =?us-ascii?Q?u50dXk7E6f3kuU/O6UJdmu4ErEEp6hkuOeSyv3LO/Thdsu4Mye3yqxtxPxiP?=
 =?us-ascii?Q?HFko4KyLhPRWzQxcZe+RoOCvjcU+S8O8E7ELIQJlXJD1EAeS+v0jeCFT+2nq?=
 =?us-ascii?Q?+WGXCQtJa/jOG43ehphE4hu3wJbUT0YKLL0yPWP5Ac61uNnS12GJMVAzM6MI?=
 =?us-ascii?Q?6Yy0gHhROeCetg1DMflqsRSR+kFS5hg5CNQBlWtLN/MXKdEBXozHkBhT8q1D?=
 =?us-ascii?Q?MfCDVIYuosEylM9B8Vlss2cENgQ0Z7wLiOgjEQlOIFGuibV4R+wDnSF0CewL?=
 =?us-ascii?Q?j1c48sG6TakxM5f8f8w8mdBPhYVRzMrsK3DvLVlRbfdSvL9AnRdQpq4jlQ7a?=
 =?us-ascii?Q?n+WHF/7JKZhRPvsP5CUJeJcwLXFB5YNdUPJZV7ByxiAOiFOxiuJvWNZv6pT3?=
 =?us-ascii?Q?CuSj2OQxAXi2ZrrpwxHEsgsordmsbzNNcMSPLrk/U2NjEWLbso94quTyhWYS?=
 =?us-ascii?Q?SwueP0J6oURG5HcSygVdDqAs40YDrc0+2uVTKSJddWH80b4M9MplcB4V7jXb?=
 =?us-ascii?Q?hRbuxDV4hJBzGrL0waOeREIC5vMhTMv+OrqXhSyvvJJkPPwuGLQWfDb2uI56?=
 =?us-ascii?Q?sVX3F1KsQh5EthiNZl/MOwaAk0eTyYQmn8U4L22VhKQZpwsLzufiNLav+s7R?=
 =?us-ascii?Q?D1vHTU0rtyDdlXEGXu8ADCJI66iQpUzkQ0QXt9PJgHlk8U9hYJb6+3CHiC2U?=
 =?us-ascii?Q?vy79Qrjk5tPWbPZqkzFJmpz85Yv83FY5av5josaJf+ebovdgs9mWKJSWNsLq?=
 =?us-ascii?Q?t78w9G4/3WiDM2GPTp91kzAsyHt+3N9As/CJ8C9E?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95512183-fba9-47ac-841e-08de33a15ba4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8254.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 01:55:25.6571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5yaPyV0j6gFLsfKuexoH2Ho6SytVG4bEceRxSRXfdCWMw0PZBQnMXY7lccQslkiFGcwGpMs+Z6GBdpqvcsqEeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8313

From: Nicolas Dufresne <nicolas.dufresne@collabora.com>

Adding a reference count to the v4l2_m2m_dev structure allow safely
sharing it across multiple hardware nodes. This can be used to prevent
running jobs concurrently on m2m cores that have some internal resource
sharing.

Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
---
v4
- Add my Signed-off-by

 drivers/media/v4l2-core/v4l2-mem2mem.c | 23 +++++++++++++++++++++++
 include/media/v4l2-mem2mem.h           | 21 +++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
index fec93c1a9231..ae0de54d4c3e 100644
--- a/drivers/media/v4l2-core/v4l2-mem2mem.c
+++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
@@ -90,6 +90,7 @@ static const char * const m2m_entity_name[] = {
  * @job_work:		worker to run queued jobs.
  * @job_queue_flags:	flags of the queue status, %QUEUE_PAUSED.
  * @m2m_ops:		driver callbacks
+ * @kref:		device reference count
  */
 struct v4l2_m2m_dev {
 	struct v4l2_m2m_ctx	*curr_ctx;
@@ -109,6 +110,8 @@ struct v4l2_m2m_dev {
 	unsigned long		job_queue_flags;
 
 	const struct v4l2_m2m_ops *m2m_ops;
+
+	struct kref kref;
 };
 
 static struct v4l2_m2m_queue_ctx *get_queue_ctx(struct v4l2_m2m_ctx *m2m_ctx,
@@ -1200,6 +1203,7 @@ struct v4l2_m2m_dev *v4l2_m2m_init(const struct v4l2_m2m_ops *m2m_ops)
 	INIT_LIST_HEAD(&m2m_dev->job_queue);
 	spin_lock_init(&m2m_dev->job_spinlock);
 	INIT_WORK(&m2m_dev->job_work, v4l2_m2m_device_run_work);
+	kref_init(&m2m_dev->kref);
 
 	return m2m_dev;
 }
@@ -1211,6 +1215,25 @@ void v4l2_m2m_release(struct v4l2_m2m_dev *m2m_dev)
 }
 EXPORT_SYMBOL_GPL(v4l2_m2m_release);
 
+void v4l2_m2m_get(struct v4l2_m2m_dev *m2m_dev)
+{
+	kref_get(&m2m_dev->kref);
+}
+EXPORT_SYMBOL_GPL(v4l2_m2m_get);
+
+static void v4l2_m2m_release_from_kref(struct kref *kref)
+{
+	struct v4l2_m2m_dev *m2m_dev = container_of(kref, struct v4l2_m2m_dev, kref);
+
+	v4l2_m2m_release(m2m_dev);
+}
+
+void v4l2_m2m_put(struct v4l2_m2m_dev *m2m_dev)
+{
+	kref_put(&m2m_dev->kref, v4l2_m2m_release_from_kref);
+}
+EXPORT_SYMBOL_GPL(v4l2_m2m_put);
+
 struct v4l2_m2m_ctx *v4l2_m2m_ctx_init(struct v4l2_m2m_dev *m2m_dev,
 		void *drv_priv,
 		int (*queue_init)(void *priv, struct vb2_queue *src_vq, struct vb2_queue *dst_vq))
diff --git a/include/media/v4l2-mem2mem.h b/include/media/v4l2-mem2mem.h
index bf6a09a04dcf..ca295c660c7f 100644
--- a/include/media/v4l2-mem2mem.h
+++ b/include/media/v4l2-mem2mem.h
@@ -547,6 +547,27 @@ v4l2_m2m_register_media_controller(struct v4l2_m2m_dev *m2m_dev,
  */
 void v4l2_m2m_release(struct v4l2_m2m_dev *m2m_dev);
 
+/**
+ * v4l2_m2m_get() - take a reference to the m2m_dev structure
+ *
+ * @m2m_dev: opaque pointer to the internal data to handle M2M context
+ *
+ * This is used to share the M2M device across multiple devices. This
+ * can be used to avoid scheduling two hardware nodes concurrently.
+ */
+void v4l2_m2m_get(struct v4l2_m2m_dev *m2m_dev);
+
+/**
+ * v4l2_m2m_put() - remove a reference to the m2m_dev structure
+ *
+ * @m2m_dev: opaque pointer to the internal data to handle M2M context
+ *
+ * Once the M2M device have no more references, v4l2_m2m_realse() will be
+ * called automatically. Users of this method should never call
+ * v4l2_m2m_release() directly. See v4l2_m2m_get() for more details.
+ */
+void v4l2_m2m_put(struct v4l2_m2m_dev *m2m_dev);
+
 /**
  * v4l2_m2m_ctx_init() - allocate and initialize a m2m context
  *
-- 
2.52.0


