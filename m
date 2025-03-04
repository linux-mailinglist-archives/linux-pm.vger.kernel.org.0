Return-Path: <linux-pm+bounces-23353-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD43A4DBDF
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 12:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C69A188DE49
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 11:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153861FF5EC;
	Tue,  4 Mar 2025 11:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="T+Tec2xQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013020.outbound.protection.outlook.com [40.107.162.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D590E1FF1C6;
	Tue,  4 Mar 2025 11:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741086534; cv=fail; b=TJq31eQrWM/fE8FYpOLkRR0BV+byxGqnG6WlBDYxVvZwtd8nOPxqc0TPZCv6hrPZpMshliyJ1j+391rA4//S1gt6lJmCKRhQfo007gfVXEnCZZZs/NgboUX8/5qUSLvmVRcQsYAlEQQw9DwLDUausNjzbjzyowjL72ElhPh350Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741086534; c=relaxed/simple;
	bh=+GSfnE+nJ5Ui88DWeNo0VGNo5CLoVDhS4qyHiQTRVHk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ckblbH62h1Ooc4g6hThXhLoJcawfWjO9b8CgsSC1khI6RV5THSo+jnF7gNDpKHijZfeTWAjBLmgqsPZmqbEHCCGLQaGSQdRJ22chNI0wM4D3Vx1jS9nptWXYpGjXWCngkLF9CZzWEdbPnBPRqFqrHvs1irQR9CwV/CUQW6lsLFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=T+Tec2xQ; arc=fail smtp.client-ip=40.107.162.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lJQM1q85K/iZYXoJN8YqLrWlk+DA893gNsyECJBJ4xaGmOQp2SpRefbgMGfmuwcWp6BXGIN++qlQ+vgj2UUORVFIukD3vrJUgPdCQCaRsEBgZk4DHYmK0MswT677jaGj8u1o2am56FG2wva4rsHW3LNEHIzhfCQfVK1e0kU0uUcuLVmafSE76D92rcSYTjXgZ1vqz361N0BOHsg+n5U2TYMZfPbUjaFiAFPfsrOwDfo1ADjEjsRvp0c/t59E6kkE3B8fz3TPjLeeb+rku6P7teEdDWBkXvDcQdvNrAZ1qHRco1lMwplpKD0MSOl9ynMlsalf0mvDSCHBeDR5Mp75kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=exyVt/8Gfu/L/J6UCZVZdEHOqIfqxeBNqM8DQ3k10mE=;
 b=kcmbsv8azTSLqoxDTX9UIQTp1UUA9ldJLRQnRyhTNhQ8R08z8pfeLj8zGo9y1lmUgz+0aEJ4ZsqbMsqmsnSArPdgT9+6yUyZk88cBOFp9gmLHkUmt2250/+yW2g9F34d+M66P3c+1+yKxJNx2kx1WyU4h+ZZso75q1QmYlKcEb6k4GoPNKtG+aptFS7ZDFFh7IJ6NofwC7TOrJduVaTnU5lJAhyZG7O1gxf3ymIG9IuaP+dEoOoK6dk09ry9IdGp9YiL/xd00u4gRrRdWroI7dzih7dO087Tf14x2/ElLmjR7VMmnK2iyeDGDCCro70brhoE3aq/W5tk9SG2afGqbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exyVt/8Gfu/L/J6UCZVZdEHOqIfqxeBNqM8DQ3k10mE=;
 b=T+Tec2xQtu5SPEHrMf/uL9g5nY9UTggvJDdmpS0VllkXPti/bGqkqF7DCDHdtLZAfMb4tbto00z+AB2sl/+DM0jrlQ2p4ArXuEPkUXosA8YSQrl7vFSSKvDo5TrAeotGqPHfoiLUqS6MBIBM1He5d2qo6dBYgsXVdGgff0X9eC83aQ29+rmoYoVRl+H6Q3N6yqBPdA+gXqdRgdPVMaeJVHlBtQPyzL7F6z6bylQW+T6ZF6Oz+6u9KEakpjtfeZLBYwH4IEXc2aOfCKORJjnBe51z7aPLS6kU7EkH0M51vzxHVFqaNTai5UiX1NoIMLz+d2qn4/MMx57dYnjx0r4uzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DB9PR04MB8233.eurprd04.prod.outlook.com (2603:10a6:10:24b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 11:08:49 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%6]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 11:08:48 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: rafael@kernel.org,
	len.brown@intel.com,
	pavel@kernel.org,
	gregkh@linuxfoundation.org,
	dakr@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH] PM: sleep: wakeirq: Introduce device-managed devm_pm_set_dedicated_wake_irq()
Date: Tue,  4 Mar 2025 19:09:30 +0800
Message-Id: <20250304110930.2034394-1-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0167.apcprd04.prod.outlook.com (2603:1096:4::29)
 To DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|DB9PR04MB8233:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e3af015-2046-4158-a375-08dd5b0cf00c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sW4b0Wb+KxIj3WmFBSTKge/8DfuVMM6PHPFxFKsvB7LfG75ZhFWh8y6ETXYn?=
 =?us-ascii?Q?i7oQb5BLbEDHNvLNuOzcjrhEZ2OB6FcqgHafYWBAvmZHAe1TlLOwB4HWttrb?=
 =?us-ascii?Q?iVIBKHZyxOuMmFYykoe6JhhsgacuXm0VSvk/uuMqE47skZqyeLkMr9BTlJro?=
 =?us-ascii?Q?8i7SFV72f7fYaB16qQ5VY4ED32uoCLKJ1Sm4SiJKgdKBj9HDk8OFlSw2A02i?=
 =?us-ascii?Q?iZYveMCPnFmkWKmaf4LTO1EjJ/0hdzxe/N8TRrns2CotSMyAu+DwAbNOqNCQ?=
 =?us-ascii?Q?9AGvnU9TSy65F/r5t+CHuUvcuJWGuKu5SD+cnSpMlowYQzbtm8YN8z2Wlbrn?=
 =?us-ascii?Q?DWhWKbsdrSJaip8gYXem/NzMAnqnVgbd+1TATRiPDhdU6s6CeKRjoypMVNRE?=
 =?us-ascii?Q?mpDI58AlfoMiV+UbHz6YwNDBfkOL9vGET1lrvC/lVqlCnwtgmIpH4uHANBLL?=
 =?us-ascii?Q?JAsufPFXnWqotn/nJS6KSELKJPQfuj3nr6mXpgJPy10uikVGcp5EnY46cLKl?=
 =?us-ascii?Q?CZ9KkyQxfyI8I/N3RO0cj5UJJm6lrqxZGxW1eHzW/gLaa6qEBzYdDSXa1iwv?=
 =?us-ascii?Q?g2dx02mNtvLr8OJpE7Bn/RjvneWEcz2boCk77lykb1CHsfQQFOhVKpllwKeX?=
 =?us-ascii?Q?KgJ84bvM+O3OcTvKFqtqd4ZyBqDgv5UJgRfgs8aeQ0PteZyb83O8+dIyg43R?=
 =?us-ascii?Q?X3oXT97jX6lhmx/Frdc1UPukDOWjipFoiOt+58djkCVKkxa3WaIA9gj/Z9Uo?=
 =?us-ascii?Q?o+Zwgml38uLisH5MehepJlJSdop5S2xNvGvZujNc7U3vK12ENAFH89ZqCOEb?=
 =?us-ascii?Q?8Dy0oActRjWmqm0DHQ7fJprGaIMxCgPaRW0rWr03sZDbTtuMYfPHpVx+lKzQ?=
 =?us-ascii?Q?w2Pxsr+b7dWXgO2uRJ7dns3rK9uoUMrbb5zz0xU3vOdX3+REDoSl0eCOyDup?=
 =?us-ascii?Q?If+l51SiP3SLDycwnbBNIG8ElTZM8OvFI4I04VSjH88T1YxiYf5E9hs8zKrt?=
 =?us-ascii?Q?vVbv/Il+9QGtGic73C/QQpld9Ra2Hma2VT+b1tD0TS7XEt4z+IIGRblllGcP?=
 =?us-ascii?Q?niAtFzPPb4lQZECn6AhGwIn7LebxjywtvXfzct87rfyRkwzHMfne/zd+E8oF?=
 =?us-ascii?Q?zDS4Wz58L8DblriiENud9pGDdFqBJf/dGpGEM98IQNCoZ7muNDSfmbUFYAqu?=
 =?us-ascii?Q?0M4az6NMGG7vgUgglc89LNKKJu60nf86TCiuZ/AJvVXzxUg063WCO+pOW+az?=
 =?us-ascii?Q?BIJk+3qLOlFs8yDfnu+uUVswzqol7GOx+ZLtHQiUuewkKbl88/vg4rhPS38h?=
 =?us-ascii?Q?FNjIS3kM02orC3ZTfDXwqMxOAsYPiBpwA0QHLxQiczm1EeFv5LYXmhYEpolt?=
 =?us-ascii?Q?a/Bcb7+dtNwl4zjZYWo/MCJWiaI8TGoDUgxfL30eIlV25H4T8/zZNEhg3eYJ?=
 =?us-ascii?Q?tln8OU1vulF2/Gfg5tCNwan0784JI51t?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K6JXzFMu7gSs6Wb2o0BB6Nqmg4MYK0L8rf+OGt+za4Yz54RBudeJH42Zq0kN?=
 =?us-ascii?Q?Fm7Exs1M5RrpEAtTNIQ13jmjnCqORHI4zh2MCBi6Z0FIUqUG9ZWx1AUCIC12?=
 =?us-ascii?Q?cHYJaBnNyXTTOppXjG50S1V1tL+QEXPI4BNI2pO1PBQCHyJovBD/+/FF/rcU?=
 =?us-ascii?Q?kV9vTyC7Ky2dk2Z2eEUCPfb73hNjq4juA+ZROrlZXAVixuZ7xQl3/tAzK/EC?=
 =?us-ascii?Q?fXiUHWdlDpiSZryUcCNr9bNh+9mKDlFNo4qM5I0ZxCdSLwFaOKlH2xD6QAfi?=
 =?us-ascii?Q?9K5eG+y3opyNTosdY3+SidbLMzdLWVvSEb1clC5Oh36vOPpydCCrYmtFRy9E?=
 =?us-ascii?Q?GR7Z+F5l7L/q74BvO4DvY2mEWdS7xqOQP9DpGLInHgqHg3/ME8sR2rMzsGnp?=
 =?us-ascii?Q?Sxn+JkAsPoDsHNkm9DqoJSQie00q9XfYczlGShxam2KbNabUHyoXUdifAuI/?=
 =?us-ascii?Q?01uosyoqL5MloFqvLNQo6kszjFTkXSHCaZuX/FQes9CrnsM0j6lFl6H2ecUN?=
 =?us-ascii?Q?WxVSQPaHIRDBmizYwSOLV6m43QhLGTOxD9yL1hRjTnCYs+BBftfs0Vi2Ee3h?=
 =?us-ascii?Q?wDGNBduTvSSMmD/vK/nwLdvEiU36c0pxAcScti0GOuqnp58aQccl9sppE8L/?=
 =?us-ascii?Q?EYVgH7nz8LEpI3EppnuUjiZpuH0+UTX2tob1w9CZ2zRDCbsUzujBilO23z0J?=
 =?us-ascii?Q?ZweWGRBw4pH1kiqugkJAB43+8FiT8Fpv+VNq2Na2F/beLoQPWLLHkdjNeBbO?=
 =?us-ascii?Q?7Uh1tyI0xv/fVM8SMMqD4LuvYIhSGN/n6XPyf1dMYDyhvx4NpO0shUSXIoZ6?=
 =?us-ascii?Q?EZ7UlnSL/nsEDI/PXV9XLVl1B/rJ4QPys+67ED6Yb7tbEwdW0aIyJ5jVwvUI?=
 =?us-ascii?Q?EWzYDS/lx/naurH/gjJ+Iasisi6vjfAVCbnQCu0J5TlkvC3lqV1zv60HdT2z?=
 =?us-ascii?Q?V3/SGALijtvG3Eu3s4E6LnaOXjAy+ASWIzqjLsWo6eAa9H4gBl6EVsIsWd+a?=
 =?us-ascii?Q?oADCYLp/KoFgOImbWctiS2kyOOod3b0xFu+iH1Nm5R+ohVazVcL0i1ylz3nF?=
 =?us-ascii?Q?Voj99jxaroL/QAYxZUZiZHptwNFsH5aDYYF6csDcTgb2X8RF7IbXNH32BJL2?=
 =?us-ascii?Q?zOeAOxSUtPxU8w+/BDc7vCashYT27B/JuxddSPDdcEsMne5sV/BF8Ezt772+?=
 =?us-ascii?Q?G4pQXaR8cxZroqfraJqq4Oe2QhF3nE/171Lj4uv1x89ZJUhgeW/tOzjKM59V?=
 =?us-ascii?Q?+fF3zvpsy6xO/M+mfkztrjdCglMS52RGrVRg0tpDl/Ga32ySokmJ45fgaD4z?=
 =?us-ascii?Q?5j8kurWPoPLYypMagzYnocapmZ/IP9lpRzFU4Sfue7j+ImYp4u+hruOFa8Bb?=
 =?us-ascii?Q?malaNaWIWIuZ/+WV91wYw2CDcRRQ6N5hSo47AwJl1IlphsdyKo6yN5xtT0Vz?=
 =?us-ascii?Q?mnBkDuYmrNOaxdYS16EX7sYjj9uKOMAGAaaL/Vmb3gWDvVnei+NYNr8VVv8i?=
 =?us-ascii?Q?wVXY+jzYPs5aa5TJtUiJMhvc14ymbT5IFKtDtmTWewJhbn/J4sLlbiAIlMPI?=
 =?us-ascii?Q?W9aTmLPcGyTSah1ghDu668At8pw7G7Jo4nL3T6qI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e3af015-2046-4158-a375-08dd5b0cf00c
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 11:08:48.3782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nKuYIewsrv8MoELq/a8XyCil3dmnQHDsh/XuXGld6W17nwRbSC5gpxYUh/4jekgd5p5cBWGIK+Zlg3ZW00Xxow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8233

Add device-managed variant of dev_pm_set_dedicated_wake_irq() and
dev_pm_set_dedicated_wake_irq_reverse() which automatically
free and clear the wake irq on device destruction to simplify error
handling.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
---
 drivers/base/power/wakeirq.c | 43 ++++++++++++++++++++++++++++++++++++
 include/linux/pm_wakeirq.h   | 12 ++++++++++
 2 files changed, 55 insertions(+)

diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
index 8aa28c08b289..dc2c9cbf40e9 100644
--- a/drivers/base/power/wakeirq.c
+++ b/drivers/base/power/wakeirq.c
@@ -129,6 +129,49 @@ int devm_pm_set_wake_irq(struct device *dev, int irq)
 }
 EXPORT_SYMBOL_GPL(devm_pm_set_wake_irq);
 
+/**
+ * devm_pm_set_dedicated_wake_irq - device-managed variant of
+ *                                  dev_pm_set_dedicated_wake_irq
+ * @dev: Device entry
+ * @irq: Device IO interrupt
+ *
+ * Request a dedicated wake-up interrupt, same with dev_pm_set_dedicated_wake_irq,
+ * but the device will be auto clear wake capability on driver detach.
+ */
+int devm_pm_set_dedicated_wake_irq(struct device *dev, int irq)
+{
+	int ret;
+
+	ret = dev_pm_set_dedicated_wake_irq(dev, irq);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev, devm_pm_clear_wake_irq, dev);
+}
+EXPORT_SYMBOL_GPL(devm_pm_set_dedicated_wake_irq);
+
+/**
+ * devm_pm_set_dedicated_wake_irq_reverse - device-managed variant of
+ *                                          dev_pm_set_dedicated_wake_irq_reverse
+ * @dev: Device entry
+ * @irq: Device IO interrupt
+ *
+ * Request a dedicated wake-up interrupt with reverse enable ordering, same with
+ * dev_pm_set_dedicated_wake_irq_reverse, but the device will be auto clear wake
+ * capability on driver detach.
+ */
+int devm_pm_set_dedicated_wake_irq_reverse(struct device *dev, int irq)
+{
+	int ret;
+
+	ret = dev_pm_set_dedicated_wake_irq_reverse(dev, irq);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev, devm_pm_clear_wake_irq, dev);
+}
+EXPORT_SYMBOL_GPL(devm_pm_set_dedicated_wake_irq_reverse);
+
 /**
  * handle_threaded_wake_irq - Handler for dedicated wake-up interrupts
  * @irq: Device specific dedicated wake-up interrupt
diff --git a/include/linux/pm_wakeirq.h b/include/linux/pm_wakeirq.h
index 25b63ed51b76..98a532cd92fe 100644
--- a/include/linux/pm_wakeirq.h
+++ b/include/linux/pm_wakeirq.h
@@ -11,6 +11,8 @@ extern int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq);
 extern int dev_pm_set_dedicated_wake_irq_reverse(struct device *dev, int irq);
 extern void dev_pm_clear_wake_irq(struct device *dev);
 extern int devm_pm_set_wake_irq(struct device *dev, int irq);
+extern int devm_pm_set_dedicated_wake_irq(struct device *dev, int irq);
+extern int devm_pm_set_dedicated_wake_irq_reverse(struct device *dev, int irq);
 
 #else	/* !CONFIG_PM */
 
@@ -38,5 +40,15 @@ static inline int devm_pm_set_wake_irq(struct device *dev, int irq)
 	return 0;
 }
 
+static inline int devm_pm_set_dedicated_wake_irq(struct device *dev, int irq)
+{
+	return 0;
+}
+
+static inline int devm_pm_set_dedicated_wake_irq_reverse(struct device *dev, int irq)
+{
+	return 0;
+}
+
 #endif	/* CONFIG_PM */
 #endif	/* _LINUX_PM_WAKEIRQ_H */
-- 
2.34.1


