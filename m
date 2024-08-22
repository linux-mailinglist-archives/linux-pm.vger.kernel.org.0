Return-Path: <linux-pm+bounces-12705-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C79A95AF93
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 09:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FCC01F2179B
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 07:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A424716B750;
	Thu, 22 Aug 2024 07:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="dPdyGXr/"
X-Original-To: linux-pm@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2071.outbound.protection.outlook.com [40.107.215.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC979166F3D;
	Thu, 22 Aug 2024 07:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724312764; cv=fail; b=qYhqRIizoRHsIfGtQs6V87xpQdbLi6bIjpirL7n/9YakorbeyoOwXHlQ28ghmcUyhcwogIkly1ttflEKwlulhKRzewQBhcTECv5gg20605j7z86A7kGtq9wOY+olSpPbpC3zAIYAiyyCh+J17Xikk3gxKxx+mgdMsYwe+mb4RaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724312764; c=relaxed/simple;
	bh=uMvtEmXebRwhAtNimt2Dh+jzXOvfEE9+6fgrBsufHY8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=toGT78J/0TSK2k4Eb+BiuZYnEX+U5oPDrIT8AbonsoPLbcSgf0ADq+7X4/jYvVv3eWgKaVfOVbOoD8bX3MEgBtFSa+ZolRLj9WWQrNzL98xLrdf0tBevYIEOMx82jQ1k7gpgCkXtspOJ0DpfB05zQxshBN3PQYcAMvMhaiBMIos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=dPdyGXr/; arc=fail smtp.client-ip=40.107.215.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pESfIyur8iPLV5w3VeKw2x1tLTx1VrzNpBKvNDYkG9tn8K9u+KJ/2+3Bt4OytgGYRUsDOLdDhfu1mC2mrUBuHZKRrDPGSKInU6kRn+XdwaZ3w4F48eI39VqhUBwlwTjlVKSAq5jQolk0QnN0FOhcTutkmI74rFltF3tdQ14YS6e8WlXRNfsgvI+KJ62FnXT702HZrf8BLgClDk8NZLV5i5KWCX4qlY4L49aA1XJcxS8jUKicQn0ZtUF20oVevIOeAhXRT0JFOPKpXD9ShVPHs/Xy8FxAXX9+d7OvHkR3rcjfUtj8v6PYdcGMn+WelIv+5V8J1LxyWzkqOyVQ3MWLBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OmiKKt8tHHGJlM4tjABkx9wxhxJ/65PnMgNFmmYhqkI=;
 b=NsW5v82FmhZDcjAEBQX15y2nxk2fZPglg4ojIzI8F5RH8803pd8KQ1Swafn0NlupdwcnmT1MK09/BtJJT2NL4O8GCKTYJoVIRnl1VgRfAbZmG59PZyHuc5quTLp40QJz51rFbknVdc05AA1w9kWsdPvK6sPXAgdbPIEEVbMyS/ZWJTl4XA93umST4OyEmqMtIwzXQWhaoJcReglW37OdJC1h6pRVmHDSR6/+PoQa4HGdAi211FFu022amrYbOIfWQ+2SOZEPpboM2rfetzu0XyJuuHfd0qT5bkmwp6yd9tTqoORq7Ykhd50br7TTsDvja0NXh6dxjD5p7iKoLfGLBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OmiKKt8tHHGJlM4tjABkx9wxhxJ/65PnMgNFmmYhqkI=;
 b=dPdyGXr/WzxBfQsROMDtZJ+Fb1i4HRntmgNTxO8m18ZJLhh0iQ8f3SvKFhZdgp/gOBaNIx2NG31pN0E/yMxxNxGscnfIXVZGGbT87ViGdeUTc2a0kqqZNX5X8eW7e4Gh9D3m01o+GnsaUuaQmWrujOMxYix61u/Y21QaxiGCOHhuiRAeMg3EHo0XdaPso58B+pYnzJMzdU77HMRNUckngLdooX8kPh/aPa1GzwPMZYRL4RBrmBQEt+M9Bl7+KCZJooChynlHDYYHnYNxTo5Lo4mjIw3OAa33Y3WUikjei9IB+dpo7QhmZSLUcRZmiVNFk2S/FL5PsiP/n8faihvMQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com (2603:1096:400:33d::14)
 by TY0PR06MB5777.apcprd06.prod.outlook.com (2603:1096:400:270::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Thu, 22 Aug
 2024 07:45:58 +0000
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268]) by TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268%6]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 07:45:58 +0000
From: Yang Ruibin <11162571@vivo.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Yang Ruibin <11162571@vivo.com>
Subject: [PATCH v1] drivers:cpufreq:Use max macro
Date: Thu, 22 Aug 2024 15:45:48 +0800
Message-Id: <20240822074548.1365390-1-11162571@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0163.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::10) To TYZPR06MB6263.apcprd06.prod.outlook.com
 (2603:1096:400:33d::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6263:EE_|TY0PR06MB5777:EE_
X-MS-Office365-Filtering-Correlation-Id: c1a56a65-1c97-45be-9c76-08dcc27e75d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014|81742002;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?043rtx/v2KlnfYu2KNbl/YI+Z3pyLonQ8q5sSSVwcGmaYfMxi4fFEbsofdiF?=
 =?us-ascii?Q?a8oxcJC/th+847GNcNjPWZCzDY/Dpa3f9J0VynmTKC8SH59SddGkAl30M4Y6?=
 =?us-ascii?Q?/xHwkZCYNUfMgEePVI08SpWPAOMpQqaiBQCOtGhlFiXGTkxG5hkUVXamLHwP?=
 =?us-ascii?Q?uPHlwAHgYmUFTphTCAqCAQmtEcUPK6KJvv/VBwevqO1PERHvExMnKLS6KqJR?=
 =?us-ascii?Q?pFPMNaRxchN+e1fw/POyC9MNC5sXXslC9GlZKSHXowiRAo+XzdrclhhB1d7c?=
 =?us-ascii?Q?ZEPEDuf5NRO9ou6vyIfEykbptmrMfytBDvEx9v7kJcNt/zC4ruMDz9MS0zNO?=
 =?us-ascii?Q?6yHAJdqiNpMwsJUciuoJ7bzrHc4kwqLOxTbbfI157ZZZvRtppZUtxgvBD/Bv?=
 =?us-ascii?Q?GMzi7ZMXKhjKPAmlzJqVp80vdgjsk4xeF6NWXZnMqPv0ezVjtYjUGMBywCBa?=
 =?us-ascii?Q?CLaju0fWeaNm9cGtgvwMh77nQ4/oqDdkhI5j7Za3p8rqKd4q125P1APhlS7G?=
 =?us-ascii?Q?v7okpH9lelFfx5QZNZXoNSs1ZsYOaATip5qSCoz9ASzCYhg+kyQdd5FZq7gh?=
 =?us-ascii?Q?eeE9AQzopueLe5uTCO7gjlg/da039hPMcz4vuHorTpcQ7ENtkPchInAs8uU2?=
 =?us-ascii?Q?/siaGFmVcv/GK/3r5wBRiWZVPCkK6MHI7yYnAMv+ukWgE6tcymHIGt7SGvmT?=
 =?us-ascii?Q?agqZGD+DoFUJ6XEBqdNVsF0OzMg/1dS4p9zrAhGMpXqwRjVKOPixn5fOBr/b?=
 =?us-ascii?Q?rBml0/21ylKhAmIkVkqO8KVIres0gS6ze6OMiobGoqFWAnBDYC4Fvm+cWWR4?=
 =?us-ascii?Q?acSkzutgH7b3Sws/+qWpBIBQaaTnRUqsRCr0vLMoO5xuYPnPZmmwID3VGvzR?=
 =?us-ascii?Q?xbUvGDmUUseCjPkfAjGRqkV95Vd6WgQhyP3YBF9fMdvLG2PP/1kHRpBcNPbH?=
 =?us-ascii?Q?a4yI9FT8bDzA4kRKxweBKciG/8Mu+7iJNrWZoCGahsDtVX7MtXbbX8LD/wwC?=
 =?us-ascii?Q?97Eg8atuVCvIXa14t/s+vEQNWHGa+2DZh7GOTyomm6V3f9+/lR+5r2ldPFzN?=
 =?us-ascii?Q?kSv1MkOZxfuXiDo5/crYkTnVzfT0gYo/tncAP29HDb5+tEixlvBygjhpNaO/?=
 =?us-ascii?Q?va5XD2cfYEg8LiFCzFgBKx3YBO4LFAAyY30+g35YP22Y5M9JuoffjMtGHEbq?=
 =?us-ascii?Q?qToBqBtB+BCHA3cx27UV7qLQzK+iPZ5ioKK/ONri+//NfA00VaBeI4aqD5oj?=
 =?us-ascii?Q?X6KhgWdR4o8j7Xzoh8yxZAn76CP326QJvR/UVU4Q6c8qPnIaEv4G0zD2iipa?=
 =?us-ascii?Q?kZ77JZcNv5ycvHOfXMWjx/kax2JO25zOs4dDa+CkoOFhtH/aKcfa5EiXgpNg?=
 =?us-ascii?Q?VeudwJ5m5Cer0k/j6rdogQ8Sop6fyIvRRrMAozmyBUB4bvny/Pvaqdj31rwq?=
 =?us-ascii?Q?iFEybthvtVM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6263.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014)(81742002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+SqMtAn0EapD8+zrAuDG7OrwynDsyT6ZwIJy8ln8xXVj8CxZrwZrxWyzsu0Y?=
 =?us-ascii?Q?DjMEsS2cn+hAbESpQODK+TNfAkDFhULLZH+7Gmrx18vajvzzldActj4euKUD?=
 =?us-ascii?Q?fSEdtAniUPpDlv+FFzG1wVVW7f6ioE4weFVdw1iYYxCybtqiUP513PWHt3V7?=
 =?us-ascii?Q?T6mDvXQqbOvKmCnTdnnXk5y2rJH57139Qie4uAHU6XXSlRd9Cy3UGcVdb6z9?=
 =?us-ascii?Q?BfFHy7J4fcsutiHOUazWUnCC5iEEYp8d/rD/GVXdXTon7WneH82qhXbeVQlh?=
 =?us-ascii?Q?o7FLkMr1lutMtKeU7zOwwN/erTo6JrMbREsJatgDbVV0AImvfIrUsDBmS6KU?=
 =?us-ascii?Q?Mpwwtj+9EScHZU+3Sup+n07rPHaVHnTC+hj2wKBDn9jJR6R2/j3n1SOZDjNS?=
 =?us-ascii?Q?fEX4UKwaq4vKUkzNYahcX886uC0VFee7VndJxxbE74+5gU6TxFhnOGVVIy2c?=
 =?us-ascii?Q?J/Vur22uzBR2LaaQZ9F6MptaNOhhDavyRmzQNN0yO/4QrYJurxMFvRUasDvg?=
 =?us-ascii?Q?rR9FhB07C+sXmHvlbwfJrCej8wCALnZk5yY8boy/bm8lPK9hcT9Vi096Lpxe?=
 =?us-ascii?Q?HMgfNXWJevNeHKi0FEieZyfxiwylWqv0dFpbx8ABRdarC09K5onFWGwsIky4?=
 =?us-ascii?Q?R9Eo908csHqtl/ppq8sDRldKy6lRApPrz6G973yJYYR3Q2pgN9KXyaWfMqKJ?=
 =?us-ascii?Q?KvmbE5AFJGIvImKoVNiPguUH9muH5qACgNNY1heWApW56bJF9PTAyifTS9Ju?=
 =?us-ascii?Q?Uyq1ouzf6yROmBQjSt5GonT1xGQaiSg/E7pOwRo1xOIMbKm7P8pyIlj6o6fb?=
 =?us-ascii?Q?yiKOZ1vk/Z6q9iijJvr0FGz+jbxpNyvcX4N9JVo/7Xt52j7cAfURmFtb95H7?=
 =?us-ascii?Q?B+hw9C3Z4gEHp7M5BMPBsN/qJvim+QxGAzVVAVsK5Ww8CUtQ+OpjUnOqYeNt?=
 =?us-ascii?Q?IC+aIXMEGjmuK3N8O1+QiJewG8NbSSZtw01M3MEn+M+aHZ7uYbV+EOkwpZmc?=
 =?us-ascii?Q?Db42XsWKwXU33GwxJaR6nQg3Y492jsx4TgV4N1BW5mODgxmj0/8oZ5Dw2cHX?=
 =?us-ascii?Q?VKe1jeOHHdt5OHN2yknjCackxbTKwJ6GzMKsl5Wo+1Mz7Cjkjr64bzYs2HRn?=
 =?us-ascii?Q?7l4gXzWAfwCVgqIQd1if4A46mr1LQG7O5sGC/dveNZenuddAUzh1egAFtjIG?=
 =?us-ascii?Q?SxB05l7ClLYwP/LaIL5wzbcFPSC+jqCeaGRY89/MB8UnpupnoZf5aLfdBS3/?=
 =?us-ascii?Q?hsBCVlI78dBYkmk80zGaFvj6yuEPID/aNWq9S9IVVdBX5bmBAttvIH4jsviu?=
 =?us-ascii?Q?90QZXb5nRkZ0dIToQiQ5OCzCZV7LG/tFbK146EanRp8i8Rq2ePpGk7QU8sKF?=
 =?us-ascii?Q?awMA+0iLv1KApC68H9K9HtfSJWgerT8rJGOcc4u38n8OEUkpBqdoAlOtyBLa?=
 =?us-ascii?Q?otAEBgGFTfq3gGeiInbA03HTSAKa7DXT9jxp3zur69wl0WuNBg0QYh7yL1Ik?=
 =?us-ascii?Q?EmeHN6UI0/u2zTCiyoC8x5rRpzT/TVpGij2CzSNdOsGPWttnpIgzQ7m2cG99?=
 =?us-ascii?Q?gusRIsO4Wj2Y/RrNWBOK8BY9J+Gcgi6ZAULUbD+G?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a56a65-1c97-45be-9c76-08dcc27e75d5
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6263.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 07:45:58.0760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vwaMeR0RXT26iH23zsYwSbBYY65vji92Qi9a/qNDSWwhDava3VGfte2+IfkwIVUxz24K24q62r9e+xCcYIS+vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5777

Instead of using the max() implementation of
the ternary operator, use real macros.

Signed-off-by: Yang Ruibin <11162571@vivo.com>
---
 drivers/cpufreq/armada-37xx-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/armada-37xx-cpufreq.c b/drivers/cpufreq/armada-37xx-cpufreq.c
index bea41ccab..f4aa3e84d 100644
--- a/drivers/cpufreq/armada-37xx-cpufreq.c
+++ b/drivers/cpufreq/armada-37xx-cpufreq.c
@@ -269,7 +269,7 @@ static void __init armada37xx_cpufreq_avs_configure(struct regmap *base,
 	 */
 
 	target_vm = avs_map[l0_vdd_min] - 100;
-	target_vm = target_vm > MIN_VOLT_MV ? target_vm : MIN_VOLT_MV;
+	target_vm = max(target_vm, MIN_VOLT_MV);
 	dvfs->avs[1] = armada_37xx_avs_val_match(target_vm);
 
 	/*
-- 
2.34.1


