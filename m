Return-Path: <linux-pm+bounces-22604-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5156FA3ED0B
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 07:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B26219C3527
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 06:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232AB1FE463;
	Fri, 21 Feb 2025 06:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="KxfnF4na"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04olkn2084.outbound.protection.outlook.com [40.92.45.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499191FC7C7;
	Fri, 21 Feb 2025 06:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.45.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740120781; cv=fail; b=XuVKSMmR6Jw9hNBZVCYzxlUYHG2BDwPy7tW3qf94DMoLXitmHsaDSCvnFBzOlUeVEgasT6Y4ZIkcysNjq9NT57q2tpjPciTU2X4HTY3BaN9h7VTpEL2HMIiOXd6C3Ho87fgkX3f2kVsMxZb9gFVX0rkHcPgzNy6Xt2quZemYG4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740120781; c=relaxed/simple;
	bh=FF3dMhHeECdMxjQ2HCQeI3Sz7MYPHtTItMHYBVZKTQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RT8IFuMwrahDTGDuRZG3pvHtrmC2EFHLGdb9xpGs+94BzSW9+cBgf3SqkbMt8IAkhCTuQyabRH228DmW/NyvvBZG69BdjTk0YRxSfQsKdxElJFfHRGqGmHHoQCOctHt9ZqBODtUrqLiUX2/9eB0eARMB1oCYVIDGZSvMHGSAtGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=KxfnF4na; arc=fail smtp.client-ip=40.92.45.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vrhhP+nZVTUn+PhRkzSNmirx55I/RTfLLcrTxtXRS+R2h2JG0DU/1Jpq4sC3b3ii1QJuUdCIQOoEth3LL27jiRmirwZapVvHmbPZmDJWuUjHHi9t8TuKNp8EsP4I+RTGXY7MzifsLCzvZQXw7eib1wD7UsLmLgotQrWPgTkJibIdBTKZWR4g5EiQZD4HdDCeWQ5A67VJf4c2WNLVo4roJ6SLIJHP88z5OXZhbmWe+e9f8yKKxQXemNvlLZ61HWSu4uq9ErdOxprhSTRB/TjlTCDqsoTxtbb9dDSyq+rjU5mo1uDACutTgNMQ0UEePXjRtCid9v0hNKl9egIgMxoByw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NX4GTad7JPODaBVDWMxGW+ImaBcZeDTwL6qMqm2ZRNQ=;
 b=NPxYaX5XQs9Gnl8Q6YUVVROZbbIuV5lRDFal0fYTTKUOzGPZZpwzvvjU7GdjVU4Aign7QVkrlWy/U75CArkJC+jwAw2W32CKPly0CnrcBVqLJ9pPjoh4O0FIBdCb/LEnoqsF/hMcDng0Srb072ROQSUVTBYggM9lWjZYDKBZt4YDFJgJlCKiLzrLAXWu/ohhhpCTzQkl7jqwk1+lUP4sgq3TFf88eZEwj/lMyYjnVAZBlHfeLp2fRqdqYADr3YqLeWxtdjVAD/dTg4iMcxSfzJolu8MzUPMND2P2drXdXsotDYF5ijGWochnLefa6kM41lHAPIjJAq60FNl0sa7ryQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NX4GTad7JPODaBVDWMxGW+ImaBcZeDTwL6qMqm2ZRNQ=;
 b=KxfnF4na6B7KDxl3sbVcietJROHSiwimJ7HlfbJXPnFSY15HQwB0SJpVSrX/nRcgViLqMzda9ANrDisTxb/wkOpYQa6Dc+4EN/NHHBmqtb7E24xvtb6qbvr5mulNWFwTdmvLHsc1doB0nyy0QYWQtE4XESvZP9OmyAWghuR+BciqzacExUVsGdEvY6wGcaRW7cy0xQ+xXg0ykqpYxeIOo0KQ2Fpk7+6MWK0b5AjHQOO11Q/Oj/VSF21nsNa5XIzoDFEhgZfuYAzlsNu8PBS1Eqjirzhiq9QkHFV7HkeNw5nwpcfcjR2SR39Mh3XF6QBFHdn0k8nzwftH3IeHu8cxkQ==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by LV8PR19MB8323.namprd19.prod.outlook.com (2603:10b6:408:1ff::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Fri, 21 Feb
 2025 06:52:57 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 06:52:57 +0000
From: George Moussalem <george.moussalem@outlook.com>
To: linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	amitk@kernel.org,
	thara.gopinath@gmail.com,
	dmitry.baryshkov@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	quic_srichara@quicinc.com
Cc: George Moussalem <george.moussalem@outlook.com>
Subject: [PATCH v4 3/5] thermal: drivers: qcom: Add new feat for soc without rpm
Date: Fri, 21 Feb 2025 10:52:17 +0400
Message-ID:
 <DS7PR19MB888304998351819597F9A0839DC72@DS7PR19MB8883.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250221065219.17036-1-george.moussalem@outlook.com>
References: <20250221065219.17036-1-george.moussalem@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DX0P273CA0088.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:5d::8) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <20250221065219.17036-4-george.moussalem@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|LV8PR19MB8323:EE_
X-MS-Office365-Filtering-Correlation-Id: dd7d02a9-f109-4f87-504c-08dd52445f48
X-MS-Exchange-SLBlob-MailProps:
	WaIXnCbdHrPgu9FUvYZ88hunKvKD6srS6wPizTPkXadUhetmscJavsX+KMn00rrRWsSBXx/qCq2U0RkXuAluFpD/udJ1Fbsx3hs5MRV+PnioK9AojFB2Ye4MwNFrc7cAb3kgAqD8UEwlobOrO/8iuGDMgpBVnJPImpIVPiEcqXVxP8gbzohdf1jilN53Rcp2FLMjq3Gf2zFEs3WyJdkgltSb9hkRl8DD7lj32P3Dk4c4httshtmJF+Bzoe4n3T1jF43dCRcIqWkv0UT19bxW6eDnli5R5nZm0yKL28v0xoOu67SiywaO8VoAJFqhTS8Sa0cRV92rl74lVtVidSMB/mh1mncbqCaj3iCIyGBI28gbv8JLANc8a9pERBmKc2JQ+HHC82ZPQ3+g6s4GmX9iUzIxgWWdtAVFPZ90ha2UY3vzCZjAOr5lzLVav4j6UYAi10F4RjXzqWt2tLo8K7d4FiDuGJAmrUQhytYV3qU9r+zpG1OXYDkcLyuH/asB1U9vrNSTNtBHKAFPtEHbrnKlhtRF9IfAxGa34PzBNNCJhlQaRsg96aSKwwncYvZgugnrNA/c+gaKXvIQ58n2UDnwYXIxlVCUV9ZXD/eOo+CVL+qvRmjbe2LmU6ScrLyPzK2MHZ/maw8vhSrSQbtwBLMzRpjP+I/89Rk1L5Je2e3HldR4ZuZamU9netf+3RFoHxlLCyUuQ21IB4JEatFzNOYan2Ts8+nvPH1ojbKFDt2pTTiB73FPj8/YetQlMYCgXPW7kOuOCOBhbRo=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|15080799006|7092599003|8060799006|19110799003|5072599009|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A1xgOU5jz9ETQgXU8omERbo9YTpeV1jdV7sfYX9jGqBoirHSZJx+J8ncJib4?=
 =?us-ascii?Q?HllJfzmRsNg8TpnfjYJIQX/3sGIDYhb5Y/H6zwDMxORb1LP8wXv6mAZyNDzD?=
 =?us-ascii?Q?ac4NXOsjSF1udZ7s355GtmybQ2zfvHh9uTcYmxbaivgJowfjMFuA4tvvIMK0?=
 =?us-ascii?Q?sfIGW1V79Gh6Tgo2AJ1A0MtevVYswfzlqDnr7HhOi0TcI/5dEAQyEniKBH0o?=
 =?us-ascii?Q?1zMV5lKzvVH1xz3GDquUidC8BqVtiE2g0buzac+OR4Hraw9mBig/HFW68JWd?=
 =?us-ascii?Q?Q8pbJJZRlj1apZzgPYKNAKn+8tONq0YK9YAcPUjhGewwE3KZyMr/ozlBdoOi?=
 =?us-ascii?Q?JQrpPsnCxGmkPzR2QT96z9oKTwbaNvXzxE+osc1a1FJSrqOT/tCwPy7PamBf?=
 =?us-ascii?Q?s1yGuuNn8YWJK/WMczOWf+eNh7m0knmXotn19acIU8rlmDaGeX07nErzLXBG?=
 =?us-ascii?Q?4UI4/n7TUfTIMsY1zfI0X7bLBoIbDXz8r2X3+yTlRdFd4q2t8Dw30FUxz4Oe?=
 =?us-ascii?Q?tDrI4D12j2MyjbTiWldZeAKe0A2xXRjdaxY1LswFygTd5bSeYKtFyxOT9iXd?=
 =?us-ascii?Q?2WcWXky/C2bvVC+T5c9J8l61KvPvVyTEq0sft/5Nt9XvjA1hY28/eTwPFCyu?=
 =?us-ascii?Q?65eh4AlA0TpaWt1MrWtndYOiks5v1xXJhUItFtDc7491TtfAD2pWfBm5WD37?=
 =?us-ascii?Q?eai49dNo0oyXD5fefjYYQMF1w3j6iRR95FBAcb8ZxaBsbddX6MTfLfTjuFGy?=
 =?us-ascii?Q?2VTCOpX0uq8qd2MYNy8T3LdSxuR6pek2MolHJXHa4vQpa/h7VuaiY7DGCotz?=
 =?us-ascii?Q?AFsTOiHOLOZcnELag4ZkjbNX6Co1I6NOwF8I4ukwMov8PTPCgN00VEZTdOEJ?=
 =?us-ascii?Q?OMIk/9nRI1NF2G93/dvlnwNkcanyN7UlMnA6x4MV0WpNdKOlORx1G7MZcWPq?=
 =?us-ascii?Q?8/IIeJBJojW2TP4+HmL1KpmTSCc8umD4kvBAOdSj7tOtJBOXdCQt0wlcY2a5?=
 =?us-ascii?Q?brN2WLz83QssQRSib0mPlipOIpglfEZHygeskDAvTGq465T0+1c1LoUrtpsU?=
 =?us-ascii?Q?MDMBiPkk84YNS+j7GLCYNGCipgSqT29MFvJeixwibmEpXjV8G04=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/2E93v2xbblfm50OlWtttzhTZD2AydHu1x2BeQO4RIq5/wsLt0kRj2KATc20?=
 =?us-ascii?Q?MHjufAbik5MAWV20CQL6QsvhR59XQtVm4c2ma6XX/38gnt9KWDvzslj/FRWa?=
 =?us-ascii?Q?qMlHL63RNmcCZv8axnTIaMLIcFUEj0mU1/8kpe53PbIQk8WdYuQvj6h1hLhg?=
 =?us-ascii?Q?USJIL38bFrwo11JJWOvi11cbyf1+T+iwJH88E21Mn493qb/QQmxrmQZw/1BW?=
 =?us-ascii?Q?m0EuZDxtaOebv2OyuSjfP1DmW8rYuT+BnS9ChOOkKuXo/Xrt8i3FmCpIHwoY?=
 =?us-ascii?Q?WU72obps1PyBmlrVWmK2Drwz+YaJhA347pO0Jc9p+MnWhpAqZWhOXmw2dcBM?=
 =?us-ascii?Q?V3pyVM6lLBGZd2PgxN4epD4nm6tc4skqlSJISsOGioMKCHxw5qO/9odjaSKt?=
 =?us-ascii?Q?ie4cU+KG3FN2sUXGCDs2kgTiXVOF49vOqVfL6gf3y0383FjFzX7CoarZ3uae?=
 =?us-ascii?Q?yIRArEHQ7+eW8Xx9TZeZF185NPaaQGPYDPZSJy+xwc5lSBKyvaRkzlFcGvi5?=
 =?us-ascii?Q?ot7hJuvPafsrLdSd80uDvIgnEP70oAbTUz+KcolChoNpsgnOojmcYS8/F0dW?=
 =?us-ascii?Q?jmJvnsnr6t8oPVyukyK93J4JYA+b1iGAdVDa2ajUj41KdguowoQPnvd3yH8T?=
 =?us-ascii?Q?zhrpzlyO0nfAWdKx3D+ElqRbwHLiVRXSe0o8IeXU4paeCyokYCL3c93ujHJm?=
 =?us-ascii?Q?FXIAVjAiBt0y7tCSEZizlpJ94iW54JQEaZAm4hi+ZF+6RLg3DcWVeYoQOyaY?=
 =?us-ascii?Q?75FOqYcIn7R2BW8MfVdq/OJrj3B41MGCZNFGdEXxeEzFVeLVUdH3MdcOWya7?=
 =?us-ascii?Q?ZBRJT26Kv4tE/rdz968R+sHoqki4vxc7eccQjDg7naFWAEW20bI73JieK95o?=
 =?us-ascii?Q?NPO5u0XCczfYrYDudvRYHnHaQwMdG3y6DsVj99ajE0SL3qL7F9TvnVZ2Ay06?=
 =?us-ascii?Q?4i5/6DCc8ae4wD0K3F/wB0FsTbSsMUiq31SLNf7tq/UUWA8i7Eg3ifIhZKnl?=
 =?us-ascii?Q?BfpDX7RAKAEnVWW/1NLiDc/+reOgt78GhTyItnPr6TyJo8VoF4JJpKPxllqZ?=
 =?us-ascii?Q?DecV5ShLfAoCI2KPnUwV1dLwd49SrkPsYtMgDUfEi+MrFDu5ICb9X2PwHkSh?=
 =?us-ascii?Q?fsc/v6oZ22LKO4QSid+quG4aF+fh9iG82z/oGmosv/mZRpkKboWjQpATe3ed?=
 =?us-ascii?Q?Q8eR84gD86WRn9JGEmXnEONsUIgEhf8dRRCFoTPr0bQiwfLIrtzkxxknN8uE?=
 =?us-ascii?Q?ONknjK18EFl+yID9ZB4N?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd7d02a9-f109-4f87-504c-08dd52445f48
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 06:52:57.2744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR19MB8323

From: Sricharan Ramabadhran <quic_srichara@quicinc.com>

In IPQ5018, Tsens IP doesn't have RPM. Hence the early init to
enable tsens would not be done. So add a flag for that in feat
and skip enable checks. Without this, tsens probe fails.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 drivers/thermal/qcom/tsens.c | 2 +-
 drivers/thermal/qcom/tsens.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 3aa3736181aa..a25ca17adf1a 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -975,7 +975,7 @@ int __init init_common(struct tsens_priv *priv)
 	ret = regmap_field_read(priv->rf[TSENS_EN], &enabled);
 	if (ret)
 		goto err_put_device;
-	if (!enabled) {
+	if (!enabled && !(priv->feat->ignore_enable)) {
 		dev_err(dev, "%s: device not enabled\n", __func__);
 		ret = -ENODEV;
 		goto err_put_device;
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 7b36a0318fa6..90bf11fba563 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -505,6 +505,8 @@ enum regfield_ids {
  * @srot_split: does the IP neatly splits the register space into SROT and TM,
  *              with SROT only being available to secure boot firmware?
  * @has_watchdog: does this IP support watchdog functionality?
+ * @ignore_enable: does this IP reside in a soc that does not have rpm to
+ *                 do pre-init.
  * @max_sensors: maximum sensors supported by this version of the IP
  * @trip_min_temp: minimum trip temperature supported by this version of the IP
  * @trip_max_temp: maximum trip temperature supported by this version of the IP
@@ -516,6 +518,7 @@ struct tsens_features {
 	unsigned int adc:1;
 	unsigned int srot_split:1;
 	unsigned int has_watchdog:1;
+	unsigned int ignore_enable:1;
 	unsigned int max_sensors;
 	int trip_min_temp;
 	int trip_max_temp;
-- 
2.39.5


