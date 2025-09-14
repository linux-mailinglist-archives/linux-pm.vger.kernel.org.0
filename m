Return-Path: <linux-pm+bounces-34599-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBDAB56812
	for <lists+linux-pm@lfdr.de>; Sun, 14 Sep 2025 13:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2893A3B6C89
	for <lists+linux-pm@lfdr.de>; Sun, 14 Sep 2025 11:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E498E25783C;
	Sun, 14 Sep 2025 11:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="fvcpS+Q/"
X-Original-To: linux-pm@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012039.outbound.protection.outlook.com [40.107.75.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F3D254855;
	Sun, 14 Sep 2025 11:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757850375; cv=fail; b=VMgdGoTnYzRezF0UpDAiCVr9f3DSWMAR4E8ayUvWVrGrZvXVkM618IgN62PtXVdmUS4C+pd0gvDP9ny+9H9eEQjyimVlOUwNckp7GB5U/JbtCpYP4pJUwvdZ/t9cmHUxa7qP5MWRseEXQp1q0/ZL3pjlFpfNdcBhPsabtXqSjSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757850375; c=relaxed/simple;
	bh=If6Holx211C7CbJ9v0GngNlDuhhATNZyB3GROHE/71s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TctdnB/RoIBVtuL6NWF2phJ4F9NGyQ1RlyPN8Ti0cybcV+A74/EiSK+Jmi2csl8QKcMnKzsznnlFBplhuYB/hUSF599511XafBn0sRtMTfT3MRblb/e1oRQ/8Pf6ajiJBtZgqQmRauIWFk8W/KFyZ3Xb7fhnVb6d6Z3kveST0uM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=fvcpS+Q/; arc=fail smtp.client-ip=40.107.75.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qSOozBCqIDjSaMN75+dXRuMy0CKi69FGnqpsJY3eyfAyw/lYIC+5Aqr6Q5tVRK7nF8Myg7GjpJFGMeLRq8xIqutVQpKIMCRxpq077tRlyPHIQEG68UkACGxDNtd78dqKrViPb8beOBj+wONNaxcV+5TdOg2BUtAZa/DKSy6f1L27uT/aEEqhBAZnvl2eFZXKhy3kqrueA4RIiZz/UwPOypax19qXeNMsNpE+7oBn3gJhDFt0gIeNP3OUCJImJ8NdPzPhb7u+dQP0B2siTRzhvRRp0bWZJqUsbEle2nV0rYSfi6ihA9ZziflMfRjgUmmWFtafWoCJmOVsI5EY+Kr3rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0wIfkvjBSpCzevTS7itqa7KFgIrbMnDwPuoCZ13sGPg=;
 b=IEGDtf1wCOLgf4fonj7WQT/dpLAQGrIe3lMkslooEuXBnyEiJdcitJhmEY55ZeXfHXTB1A1+E3OLOZIKZWgbB7tGodFdhnZdf9oVJofKt0xX2QvqdkL8jq4piRBtYzfnTYD0PhqhGD/qcYxFecwzuU6Lpcnm8THuYe5oiyL+BdLwo0n73+mKYvtTHN7bKnLdtbcP9xiL/IDn9bFLS5WjRIjtcrX4FEtSJTyUF/MXnSCH3BcyfMOJoZyZGbZ6Kx5B/lyTz3PMxlZimRV0lKWT4CYtgJ6IFndkIRLzBng0KaWPWLgHz/y3BhOr52blfgUBvHzBFgu0FW1jzVvfhsZznQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0wIfkvjBSpCzevTS7itqa7KFgIrbMnDwPuoCZ13sGPg=;
 b=fvcpS+Q/uTnfliJ4S406EWed0/5yZ9dTeVfsSGwcyS7YohueHq+7D2Uu4YnLjc2+T4qDi4GUeqmVZygWpK3qTu070Zn1QC0TbLqTEFt3Z8PHjvmMywt5FgGOMHrrg1c58iOzr8m4D/wt/q7tWeOl92lF4GMjk/ikZ9vsCJTDUkyxhU6VGDuXOv0StMambIxU6K0cl1dcf/ps3nZ/MF6XwVt4SgXM7LdS0afcoa8H4Ce7+zfetE563x/SyY4mSobE8ue1OjjQZrgn5bwuFb4MsbpV5TOugROmLI7IyBiRvPiPLQfPPJrF6cuwgk2eJNrAKIPPq4cWP1GeaVhM46nsnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI6PR06MB7475.apcprd06.prod.outlook.com (2603:1096:4:242::11)
 by KL1PR06MB6044.apcprd06.prod.outlook.com (2603:1096:820:d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Sun, 14 Sep
 2025 11:46:11 +0000
Received: from SI6PR06MB7475.apcprd06.prod.outlook.com
 ([fe80::a41:1dd9:dc0e:5cd0]) by SI6PR06MB7475.apcprd06.prod.outlook.com
 ([fe80::a41:1dd9:dc0e:5cd0%3]) with mapi id 15.20.9094.021; Sun, 14 Sep 2025
 11:46:11 +0000
From: Wang Jianzheng <wangjianzheng@vivo.com>
To: Jens Axboe <axboe@kernel.dk>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Wang <peter.wang@mediatek.com>,
	Bean Huo <beanhuo@micron.com>,
	"Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: Wang Jianzheng <wangjianzheng@vivo.com>
Subject: [PATCH 1/3] block/genhd: add sysfs knobs for the device frequency PM QoS
Date: Sun, 14 Sep 2025 19:45:44 +0800
Message-Id: <20250914114549.650671-2-wangjianzheng@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250914114549.650671-1-wangjianzheng@vivo.com>
References: <20250914114549.650671-1-wangjianzheng@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0024.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::11) To SI6PR06MB7475.apcprd06.prod.outlook.com
 (2603:1096:4:242::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI6PR06MB7475:EE_|KL1PR06MB6044:EE_
X-MS-Office365-Filtering-Correlation-Id: 03e266bb-756a-419b-0182-08ddf3844d41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?42AeiwEzZ3Bpo4Hw3+3cYM5Ny6+3FirK/6HR0wkoDfRhGF2tpC6hy8NxHuTj?=
 =?us-ascii?Q?VuvGpjZA3iwzBXmqi08EEYSvasuQkPfPhGTjPQyFPCOdBp5BY1J6WPCtSrwA?=
 =?us-ascii?Q?9KjYqlNNB3tq03PfGV0m8Z/m5zb04K3nc9QZbqs8yeTGkfzvGB1+WzQortmN?=
 =?us-ascii?Q?dqRXvUwecRep1JcXwv3anz2NF19GR1bOUoRgh5TfjkC41rTtfXIbSfbwRmmv?=
 =?us-ascii?Q?ZJpvYKK7K48rwWETatJu+hRriy4xE1/Krb9GB8rNgRfQ5RoDxRSp70BmKk4Q?=
 =?us-ascii?Q?vqU2xOelJeA9QNH4vFHWq0EQ8ikGwc+52P356J1MPVSsTXpHp5DXqMLgYas9?=
 =?us-ascii?Q?nuGH2PfS6BquFa7IJwuctsup68QkbARyKFyiQywvEskN2BMUJivlUeXUpRsI?=
 =?us-ascii?Q?dLui+tRA6kR4MeXkM86IbgcIKvt4Ro9LCSd4qLAloBUasdpW9eM77unb2ihc?=
 =?us-ascii?Q?hGB+h5a0Ohb6XyP94zbcl+oCtjIx2Zv7HQ6vTKXJqm61ScXkS6Nxijkupfv4?=
 =?us-ascii?Q?QvLH8nFzVtmUlCscuf3qjX/E9RRLMowHsYa8CdMXfsGTKEKcHoKtUCrw2CyC?=
 =?us-ascii?Q?r5ZYPDRVrUg0CO3Ka4jpnfNhYkZ1l4uNI5nbWt46GsjjID/3/wsPHoGg1NkL?=
 =?us-ascii?Q?GeYgFkuVUhfMUWM0bCZBcMfS8el+7OqmyAmPca72dCkQMGhwPYsH7ncfreeV?=
 =?us-ascii?Q?rFOvq/ynO4zGXh3JkhYgPfEA6xGpEaGgL3ptxesMW2Aog3RXVtOPaFp0/pl8?=
 =?us-ascii?Q?sqhpOuvPgO2b1JCLJFnaf8iE3AYXrq9KAkpggGGk3hzSRRdX2Dih4IWx44mN?=
 =?us-ascii?Q?cpCGouNAK3hkARYbZ2zy5PupovrvqcZH/S1IePW89Mbpr+sOJKA/BhnWJrCI?=
 =?us-ascii?Q?pHhcpksRQ0QZuB1ffh/DY7Bu/66U6MFtBRydf/a651fQYxVW129z1GTLX8Bs?=
 =?us-ascii?Q?fdfs3f95lMqQn71vzZeuC4kLD6bfVvaTBDCW9WRaVYQEjI2F0cFDPZDl38nU?=
 =?us-ascii?Q?/NYPOr8d1gZ70JMA/eysIXzBDt1npFboIydRFu45Pvwy+Q+dq9jERyuiIeNn?=
 =?us-ascii?Q?G/tGsV8k7l1mhPB1elcMRRJJVLd30ymYTnpbINlnbtvCvzcCr+ZPp9+UcErM?=
 =?us-ascii?Q?daa9hhhDYnwk6sy58616SBva8DSTX0lRZXCY+dLmn81BgqES2uiCVr/FLr/m?=
 =?us-ascii?Q?ft5MaRi5kToqi1XhYgCzaRwSb4ZNZAyWBv6L5EPuBNKcpuDKNpQv4e/3GXev?=
 =?us-ascii?Q?z18X/8Hg8omldDyXw2LqzTTEh/YihiCTLpfGsMIvg/VrvFuEO20jEmgs0K9c?=
 =?us-ascii?Q?UczYfEQiCpxHZzCcUVEn55bqnZWfvYrOhxVoz1V3XErG947j5Co2/qO4N9b8?=
 =?us-ascii?Q?JDKIPtShuxyw7wbTTnAY7pFrRsWKWTwS0oR8dpk/DdtTRm0GfLLcKXRXRxGI?=
 =?us-ascii?Q?DoTq/YZMoVXwcX+8AyBVFFsIX6QZhTHl8Peij23moRcoj4fkhNudfzar2TAp?=
 =?us-ascii?Q?poWLiEJ+AXOjfLY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI6PR06MB7475.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?umNX3M4ev3M+ZK1ZoQ0yWCkvd824jophpC/l+Ot6pLH9fF4nJrd8vF7XSwzN?=
 =?us-ascii?Q?CII0oy5eT2KRBlUWcCuGxDlowDzq/P07uMB1R0tA6+A35zZqiBpCt/4d7Ma3?=
 =?us-ascii?Q?J/BfKP9DtizS9iMty5HkNoNU6wmjqvrIHZeRaZL2plQXesPECv8MlXR352fg?=
 =?us-ascii?Q?3/Va1zXAh5RX6eTHoWCzTKX8J+FV1btOSNLFwtSz2gSQ9MrbbKr9YINyvho9?=
 =?us-ascii?Q?/JcIYDze+DPmkV2lFcR7KO1uPaaDiVpGyoreX2OWldhARQBfWpGIKCuatdYU?=
 =?us-ascii?Q?CUIKCD2fIbD0d8K3QjG8K8/QfUiWkC2F2MOlkfn5stE+Jgi26yZAdytDTjVa?=
 =?us-ascii?Q?Wf/4K3GiSsYBEePOUc86jhuUCYOuV3tXVvpdvH4UvnDkACzlRft/7YtRV0FW?=
 =?us-ascii?Q?R7IaIduSURLmYQ5HMCS+G86Peth6zYxIq4pAMnBdmRllBEdf8/DdntfqyRsP?=
 =?us-ascii?Q?Fs29XXgcuxXT17fk2TcclEhYpJJktGhB6oCPPbbqY1pSra672VXkjzNZiZZC?=
 =?us-ascii?Q?awZr6qmBTM9AS6ds/J0ED9c8uvFvkc64NBU0yY3MuXnaY+yBuH9bt0ylqPl2?=
 =?us-ascii?Q?EdVNoUdMbVPKQsrvQZ2qKfbkmwjR7bFbMqEqwYkU7Dtfr2twQST8vTj0PEXc?=
 =?us-ascii?Q?2tjOGh/CCpjUsLKEz86zV3Ev+tKErEkNEhjm+zDa+EFmWE2XGWH80se/0S0a?=
 =?us-ascii?Q?3QBMuAyVsBRsvdNDVTsNrgWrfkLympCBIeOeJXD0ep494NJ2XAMdOcoH2HrD?=
 =?us-ascii?Q?eynhIn/8OuUd5kowMhFr7D9JToCxA33p8Dcr26wY7b7elNUNFFaWryq5M8TM?=
 =?us-ascii?Q?Y4L/v3Z5O26gRzKgVcP0qn5Gxm6zGdjbAnqRsU8BQfa/rLJ0m9L6hnY8gGc+?=
 =?us-ascii?Q?qy9ALp4dRzV/1WfTO9ip42uxSH93EUoc4Hy2gdumKcRTPUkjKfVkoKOH3Ed/?=
 =?us-ascii?Q?uvQS8fHI5t7pXav9zDJ1WY9fEoIIf+QWs5QKkNfWMeEa20c1iGmephEgbx1E?=
 =?us-ascii?Q?LDLIErjEG02zr/ZOkDIXQ4RWMgE/kpWZ71cr+t+A42LK/F0berFQCvOiVLqX?=
 =?us-ascii?Q?B1OiKaX9mUlOBBhVioRs9eAT4tddD7D7+AR+Ra05pGg9CWKj1cHrOVRnlkxr?=
 =?us-ascii?Q?jUG5w2jmvBsoLi3cw6UML69tws5eRKbIBTMLGdMuJ5duYX9iEX9bx7nHKpyR?=
 =?us-ascii?Q?FQGXLkeEtZqMVbvseqb1d03/csPpaE9Mp4PUw0QGPqzxe1lTE5n11yQ61Zed?=
 =?us-ascii?Q?Z1N6r3kFMs7dx685i6Bv1u1dnR06jwZdrD4oVD9liGcurya+O4rO6UYOTe53?=
 =?us-ascii?Q?iHiBnibPEtg6wH7Lp1t6bpKF+kONF8rxK8Sy7TGANrHsPIVWpv2ldcQ58mFz?=
 =?us-ascii?Q?7pDi8r7V9L7C7ntshdACHGjfHFeFwNmKIrX65z86xWKw8dOmXeZnGjQzSi9/?=
 =?us-ascii?Q?GYyHIcWzwvEXNZFOUiIDyM05hVZTItZvpIICPfAnxJZ5waW9g+HVib3fQTW/?=
 =?us-ascii?Q?ucl0h558x/8Qyuu8gkHYFDuRhIVOQiAJ50LP3jWjKuIW9YTLsqYLK8yj00AM?=
 =?us-ascii?Q?F7wwp3NwIXxnjUgknPTHcjDTHO0PMOo0H2+OPhN9?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e266bb-756a-419b-0182-08ddf3844d41
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7475.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2025 11:46:11.4659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KFteSgJa4m8EQfZEMRoDt9uB638+4F/TEdLfxNa902XMBOaVTDCXfGaI+za1o5ov2K2o/IwacFh03eMwpMwt1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6044

Add sysfs knobs for the following parameters:

    dev_freq_timeout_ms: for clearing up the device frequency limit when
                        latency-intensive block IO is complete

This can be used to prevent delayed responses to latency-sensitive block
I/O operations when storage device operate at low frequency. By
implementing the "dev_freq_timeout_ms", it automatically restores device
frequency constraints throug PM QoS.

Signed-off-by: Wang Jianzheng <wangjianzheng@vivo.com>
---
 block/genhd.c          | 23 +++++++++++++++++++++++
 include/linux/blkdev.h |  2 ++
 2 files changed, 25 insertions(+)

diff --git a/block/genhd.c b/block/genhd.c
index 9bbc38d12792..9462a81501a8 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1159,6 +1159,27 @@ static ssize_t partscan_show(struct device *dev,
 	return sysfs_emit(buf, "%u\n", disk_has_partscan(dev_to_disk(dev)));
 }
 
+static ssize_t dev_freq_timeout_ms_show(struct device *dev,
+					 struct device_attribute *attr, char *buf)
+{
+	struct gendisk *disk = dev_to_disk(dev);
+
+	return sprintf(buf, "%d\n", disk->dev_freq_timeout);
+}
+
+static ssize_t dev_freq_timeout_ms_store(struct device *dev,
+					  struct device_attribute *attr,
+					  const char *buf, size_t count)
+{
+	struct gendisk *disk = dev_to_disk(dev);
+	int i;
+
+	if (count > 0 && !kstrtoint(buf, 10, &i))
+		disk->dev_freq_timeout = i;
+
+	return count;
+}
+
 static DEVICE_ATTR(range, 0444, disk_range_show, NULL);
 static DEVICE_ATTR(ext_range, 0444, disk_ext_range_show, NULL);
 static DEVICE_ATTR(removable, 0444, disk_removable_show, NULL);
@@ -1173,6 +1194,7 @@ static DEVICE_ATTR(inflight, 0444, part_inflight_show, NULL);
 static DEVICE_ATTR(badblocks, 0644, disk_badblocks_show, disk_badblocks_store);
 static DEVICE_ATTR(diskseq, 0444, diskseq_show, NULL);
 static DEVICE_ATTR(partscan, 0444, partscan_show, NULL);
+static DEVICE_ATTR_RW(dev_freq_timeout_ms);
 
 #ifdef CONFIG_FAIL_MAKE_REQUEST
 ssize_t part_fail_show(struct device *dev,
@@ -1224,6 +1246,7 @@ static struct attribute *disk_attrs[] = {
 	&dev_attr_events_poll_msecs.attr,
 	&dev_attr_diskseq.attr,
 	&dev_attr_partscan.attr,
+	&dev_attr_dev_freq_timeout_ms.attr,
 #ifdef CONFIG_FAIL_MAKE_REQUEST
 	&dev_attr_fail.attr,
 #endif
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index fe1797bbec42..950ad047dd81 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -213,6 +213,8 @@ struct gendisk {
 	u64 diskseq;
 	blk_mode_t open_mode;
 
+	int dev_freq_timeout;
+
 	/*
 	 * Independent sector access ranges. This is always NULL for
 	 * devices that do not have multiple independent access ranges.
-- 
2.34.1


