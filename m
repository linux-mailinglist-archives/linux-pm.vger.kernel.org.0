Return-Path: <linux-pm+bounces-22776-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2C0A415BA
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 08:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D296E7A41A9
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 06:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEEF202C34;
	Mon, 24 Feb 2025 06:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fgQF7H8A"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2072.outbound.protection.outlook.com [40.107.241.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92501EDA34
	for <linux-pm@vger.kernel.org>; Mon, 24 Feb 2025 06:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740380390; cv=fail; b=FC197eXIquvz9LhC1ud93jKIuezhOjX119HCecjQpiYVdPxmtIuYiZDlzfgkod6yOEgbAco5rMZ0oudN+Z7l3Y2x1XjzXooJBgF/UEQlQs3wgDGyZ3vFEZppxtKy2FWGsG23C/wNi4TrcYcOyt2WXbQXwBEpb4ih9sUmn0RM68c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740380390; c=relaxed/simple;
	bh=hJL3Ic8P3fFx+dwnXX3gwyBtL8KjKNZ4KdLTqqXZB/A=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=JiWdl9Oa93ADmCjE9yHdMfbPjKlu6iSdSYLapWiLDORQjWwat/hefEV1HlwBbSmeug3GwuX8+pz3r3+ebIaeUZLDidEGOoe15YO8FC3YkhlhIKmovt/yt/IfwYa1CKg0KtGuAHsLJsmTjPFZDcwdo0ad2+z7I0+9rghZN+nILV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fgQF7H8A; arc=fail smtp.client-ip=40.107.241.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wFgHwhaw9YDUFh0q8L/uOo2Ldute1Z07wFQnFfxx/W1i7TlGTexdFOctVTWvlghbOL+fM6MyiJYLGliZKDARZbF9pCUoefKX6YuFhTQq89aX0dIo7vgVTcrENqsMWEkhR0FCO0Kv0c6XnzJFyirHThsWNFY82qUOst234nw7iBlTGMU8XvX/NoUowgNC6VUnyi6L5u1GcOMLhBHrSJEv+HAaoTDQRl/2nIs0ZDfQEhDGlpBAsIsteED0tvjAzahlnSZZXyVKF9QbkzVG5+SvvPUWZr1E0pLv3+5dlIesIplApI72jH3ja3sWk156A6Ew18TYcHIXmFi9ajh/xpl65w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2AUZ+fMss+M5gXKQ243hma0ZQnO2AW0SMSLI71dupWA=;
 b=sWq/12BsXFELcsrEe9fkpMp25tiUJ6yzrifF1cCssDMi6ii+Kc0cHLF2c9C/ITUMerS+fZwe6oEfuoqcNk/s8wA09L4FqSHwA7TN5OmuQYxEPT9bKa71pE9LtH0c4Tmq2GSEEqaKvku1q90kDZ51rF++wXoW1VsJUu1J0cPdu08Slj2kabIE2e02YTKj+D8AcyiqatgSKjqZXblHUH1BVO+1Or3xTGCSwtgUzxtu1FhUUHbldk8d0eLaweLKxWD/N1D6HbizFD24PQPuej5l4F3buHcjkbpg0uV4MRy9YUrm3qI/pRoOlRyxtJZQNCMJ1PRz8UnES7cvJ8NwiywEfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2AUZ+fMss+M5gXKQ243hma0ZQnO2AW0SMSLI71dupWA=;
 b=fgQF7H8A3BEnjVe0rwxvG6JEB+HKIJZRkX/dATZyf4x+bYYSdIga0+AKTpsxXGG92E14gJrwmaar1rtO28a09xX4L0B00NQdiebNkau6WqsfDD626L/YfOB5XlpLTiTJEKQyYKRO4Vmwc/6awkOFz7hTnatLcNd4M0uV45n0Eu26ENvgBdyDg65YOcUeb/0cK2uIOQNY8rkxnXJYX7AGncBI7bVoZgMkNZyq9QgPu/uL6igIR8dNiA5/YE49/nBxjPJbYx7ZOZsuFQ8a1Ohyoh759YTJn0mQW7DpNWaFNflEHcyAcAaQ+ZYWxtuZKrQU+o8Qhq8f1Z305AC0vXDj9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS4PR04MB9689.eurprd04.prod.outlook.com (2603:10a6:20b:4fc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 06:59:44 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%6]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 06:59:44 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: rafael@kernel.org,
	len.brown@intel.com,
	pavel@kernel.org,
	gregkh@linuxfoundation.org,
	dakr@kernel.org,
	stern@rowland.harvard.edu
Cc: linux-pm@vger.kernel.org,
	imx@lists.linux.dev,
	jun.li@nxp.com
Subject: [PATCH v3] PM: sleep: core: Clear is_prepared if both no_pm_callbacks and direct_complete is set
Date: Mon, 24 Feb 2025 15:00:49 +0800
Message-Id: <20250224070049.3338646-1-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::12) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AS4PR04MB9689:EE_
X-MS-Office365-Filtering-Correlation-Id: 50749e6f-5fab-4c83-134a-08dd54a0d16a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S9xRhNnzj2aPxztRYA2ImKby2boLVt5seHnqJKRxwjTW8vZYO3j2AOQI/dZ6?=
 =?us-ascii?Q?XC17ugz3TeNwjRgt8ubAKop/Y7b3xbvzGnT03EyGQvATRITnQ6R+ek9989fy?=
 =?us-ascii?Q?JguPNKngK6yub/1dFJB3taESVk3nj25uGCUBrvX/gSXvYdEywM9cwLcC6LB6?=
 =?us-ascii?Q?S/CtUOg97mcW8+ol/ikbpNVLxEdPy7W2aCSaLU8x3UuyVJ9iAWOjceCkwSnz?=
 =?us-ascii?Q?cD6vXYmGovUMA7Z0oLeZWgpagMt1w9LQaf3hW0ly86UHYXCZ1v6cYsq0/+eT?=
 =?us-ascii?Q?2i4f5s+O3UkUNJNElYzG0+ONIEIezLwE5IWwM3FNoS9XgXYfjRtxD/a+IbrZ?=
 =?us-ascii?Q?xG0WBklEJ0IK6zjK0geu/Xcvx2E13sIYbyPhkWSiIdvDD3cvomGZkyqeQh2m?=
 =?us-ascii?Q?6O8byMuZShfa1DFxArTTWyQOl8Sx9avXMs7ndt+118FY3IIYiSTTQcNG7151?=
 =?us-ascii?Q?t+7MXeiHef3Bm+OXkin2DU4U4P4Ajz06KsVYqj0beVVEdtlbmRS94y0E/8Vd?=
 =?us-ascii?Q?+Ip+j5NuK1gAdPFh1s0bW5jxsQ5Txc/hPjTSNQo5mJPd1vxTWfMSR/Z89izf?=
 =?us-ascii?Q?jwIUMSiUbLhuMgIYsIbjxw0YyDhrNK/W4KDEwUOvkBo2LR7PZCTjJdVfG8kh?=
 =?us-ascii?Q?SY+K55+771X/9++lubGP94Y5RjedPHtBKX5jlqxaOkkd4u2QHmxr8Avz/QoL?=
 =?us-ascii?Q?iWnWM8I+F4B88aQzeiYo79Ln3b2a8qJoCzg110wT4yCKCR7pJZOwrGomOK57?=
 =?us-ascii?Q?C570HkJTCzsKmiFPlUDVRsGzyTcsuQGtZDaFcbyQeWHvp5UBqiTP++00G2h7?=
 =?us-ascii?Q?eyGwbwN74Fg0E5o/CetWaeNrqJJyhCUXHUhSuViqlqeIFG9/hM8+3N31Mnbc?=
 =?us-ascii?Q?i/XOWcCzqlGZyBftr7yU7irPEkWGM/OahO6Mok7I9B6L/fqaDyd+Zq+Gz3ZX?=
 =?us-ascii?Q?YHD+xWd7p9l5RB5BDRJeY9oKGZeg0AT1X150SiIk8L3mkvV+ouWXzLfzucjQ?=
 =?us-ascii?Q?oXB7g8E0yZP0BxGTR/PpywjDI9jy4qVWHNBqlGwv3fM7LaXQLIjZtpwbZXmK?=
 =?us-ascii?Q?7X7RMJs7l7GENf2yWXn9TUs5e7ZtiXwHf5PUctEEWomIrPhqxxAweMFqIb4w?=
 =?us-ascii?Q?SjDCBj1KE8zznKvfyrvXSWWUxO7okw1rHDib487T2eAMTY3FELLHiyq0afUv?=
 =?us-ascii?Q?XO1c75c8WKmzqyhOmsyUVEz1qoVxYoAAKiwpa/HTH0zJgcknBOSFVEE2EnS2?=
 =?us-ascii?Q?qvQi0yjTvNBVGlD0LsuWJU3pPWODv0iFb0A4n/j/FHgCUWzYM7bUkOH94s5A?=
 =?us-ascii?Q?HDfg0PN/SaZ+klmkEdkh/6qrNs3reNhlNukTbtETXKv2d4+LRKNRZn23YQCn?=
 =?us-ascii?Q?Yh4rsZzO7q0KINooadsRw4olIj6Rw1RYU/a++Qyvv6J/RLA2uo0XP7+M00j+?=
 =?us-ascii?Q?uSxCGw7t5GKTHfr+Me7MBc/GH/ZKs2e0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?agyhknbObQmWYgyR8icb9G6GoZrMPHxPfin/50ikj6xx+nr+U+Xjy5XFnbXC?=
 =?us-ascii?Q?IbooLahNKbY0zlZgSQuugjUWtnc+ZgKN/srbOoiGpe+TuLLHfbLQs3BhTCfl?=
 =?us-ascii?Q?+1MQdCKx36hQikcTV8hM2iEKJr50yLOKHoJXh2JlvY/XSc1PAB+8JhcYtuW/?=
 =?us-ascii?Q?I45sNNYZGUkQGom3xbNgQyjdN6zwbQCm03KKu78MjeoEiUtG+SaubBl5qbbc?=
 =?us-ascii?Q?giVVcwTMwB9WUAT82nY5kK5BIG/wjMrVv0ptDpAGfAitpJJfDK3sxI0gzYLL?=
 =?us-ascii?Q?8yT4XmExYW6IB5W/Kt+tCXXMReAfbXxiClROVN5IYeToqDtSakhME9irLqnE?=
 =?us-ascii?Q?OBEDmTB6piGUGil7Otb55oIc1rxBY7hHHGsh3WT1L9LL0KLkRk0ags3fR7Qs?=
 =?us-ascii?Q?OWHy7TthDRgZQpgcgxl3Ui7uYxbmfK3ca2axuesf4CMLtAL5PxFddU0aN6Gs?=
 =?us-ascii?Q?UPd6QSDHW3W3+T5B9zaSk80Fn0f6eIdgtHY+EsRlRV13M/waNofdhruu0a4A?=
 =?us-ascii?Q?DeqmwpJaLRH35Zs9axjJdOel3i26WL9UEfQH35AK6LaZcC2rg2kW4Z5Nb4WA?=
 =?us-ascii?Q?BX5IjS+oqGPhX7kHG01Grocd8ohApJJKA4cue3D62f6OwoyOdTC/DbREgUhB?=
 =?us-ascii?Q?lxxyQzMkmrLH9Wwi/NmxV9D2gzAZF4wBQ3t4wFxcmitYSJTB08xxXtduPOWW?=
 =?us-ascii?Q?DZDSoJLhcjxpl9AggJCl4stwWTXmRUDtUFGwg5akZIyg3qpfgprp/VkHWmKa?=
 =?us-ascii?Q?GivIckz2JQl3imWUjWyjl6m15SoI6np7UmzBLaOTyajLM/6wHK4jYm/JZf6W?=
 =?us-ascii?Q?2owmccWvvrTd49zyfAA1doFbj9xZRTouu7lsworj3vSes3AZo6ZgaWaqX7Vz?=
 =?us-ascii?Q?IIQ4afaop3aPx7t8I8WXkd1E6w+yBeED/FxXSC2NaCTgIqPIPP5esVRMonAu?=
 =?us-ascii?Q?hEmKXH+PW4n5gpsUNp1kjXgA1rIrzMIoIQ4dj5gilw4p/LQqV38QF6yKXSeG?=
 =?us-ascii?Q?8SiXX2oKFSQ0r4EYPucyKKJxJ44d9loYsPbZUCbpFl6EU/OlwaYRqRIjBVhR?=
 =?us-ascii?Q?4T/Y29YuILaTIafKsy4cw6Pf0yRb0IQ2i9rp/W2ptV/EE7yHWBC4noICJ6DE?=
 =?us-ascii?Q?rIYctbMAOrT6kzzyJq00o4CFOmNJPZr0VRrzt98aMbE3TTDqkFKI40k8D2j8?=
 =?us-ascii?Q?9fzaSoAFTY1morc14oB9HttglNSgb2aj6mkAQDJ9i4EsCBAggODk2JDIKmP6?=
 =?us-ascii?Q?LRwEwGK4YI0ePwoZYdhSo5QBvDIgMeVRqRKU0e+o/4bOQdz74BBGm1LQ4pab?=
 =?us-ascii?Q?3J5MiVkpZ7t50hDoitGPW2KQ5f8KJF3nIar+TASNKhwVxAKkN28VNT9gbyjZ?=
 =?us-ascii?Q?RPqmlUhLe71YzCRGUW+iOGAAPAK9+Sd4JyZlDG6IaWlD1ounRgYu6yziLVma?=
 =?us-ascii?Q?epw5fTxmGubDrnw3j4uIvp2UO4AR6dwGAS2vVKWKhhPb/c2SdfmnKexf29Uk?=
 =?us-ascii?Q?qHyClUJ8A0O+jn9cXSAQigk80cm3vnxpr22Qt5JjFw8kI3SxrR3p+SH6fZMx?=
 =?us-ascii?Q?R6J+NWqk8w0atNNnVeIWPvSa1MZ78BbmTFLzHzlG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50749e6f-5fab-4c83-134a-08dd54a0d16a
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 06:59:44.3544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oow7uyoJse7ADRdwN3PrrOtlb0ZNnosDncaedFcRAmXuUPw9qxFpUpYglADX/yipgvNuJ5SBLjxj9BIDxraSuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9689

Currently, if power.no_callbacks is true for a device, device_prepare()
will also set power.direct_complete to true. When device_resume() check
power.direct_complete, setting power.is_prepared will be skipped if it
can directly complete. This will cause a warning when add new devices
during resume() stage.

Although power.is_prepared should be cleared in complete() state, commit
(f76b168b6f11 PM: Rename dev_pm_info.in_suspend to is_prepared) allow
clear it in earlier resume() stage. However, we need also set is_prepared
to false if both power.no_callbacks and power.direct_complete are true.

Take USB as example:
The usb_interface is such a device which setting power.no_callbacks to
true. Then if the user call usb_set_interface() during resume() stage,
the kernel will print below warning since the system will create and
add ep devices.

[  186.461414] usb 1-1: reset high-speed USB device number 3 using ci_hdrc
[  187.102681]  ep_81: PM: parent 1-1:1.1 should not be sleeping
[  187.105010] PM: resume devices took 0.936 seconds

Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
v3: combined checking no_pm_callbacks and direct_complete
v2: clear is_prepared before check syscore as suggested by Rafael
---
 drivers/base/power/main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index dffa2aa1ba7d..b9b1fd43427d 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -930,6 +930,13 @@ static void device_resume(struct device *dev, pm_message_t state, bool async)
 		goto Complete;
 
 	if (dev->power.direct_complete) {
+		/*
+		 * Allow new children to be added in the resume stage for
+		 * devices with no PM callbacks and can be completed directly.
+		 */
+		if (dev->power.no_pm_callbacks)
+			dev->power.is_prepared = false;
+
 		/* Match the pm_runtime_disable() in device_suspend(). */
 		pm_runtime_enable(dev);
 		goto Complete;
-- 
2.34.1


