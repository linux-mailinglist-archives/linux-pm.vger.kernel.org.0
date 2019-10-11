Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30DC7D3DCC
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2019 12:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfJKK4w (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Oct 2019 06:56:52 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:47702 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726885AbfJKK4w (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Oct 2019 06:56:52 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9BAs0BL019686;
        Fri, 11 Oct 2019 06:56:49 -0400
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2056.outbound.protection.outlook.com [104.47.32.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ver39trhe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Oct 2019 06:56:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D6ZgBArBOSLTOh4t2s+VHI7slN9oow2zTbVfPW/PFrvEYQ2MlxDjEqJ6ZJedcfdnttMUSGVtPgVBp53u9gETXhfvtAv9ITL498gepmCiycxY91UHhPGRwPzjvBm8gYzFUM9sNYPnBio/SunL7f4pqGxanc/luq50Lexqpvs9AiDAS83pKxG4+pRY6WtdQqpS9NlnXt4RL0moPc8xY1RLi86WkXUECiZ68OMGAqiN2AWPxWBS6LpX6uhhbAcDC0NhCc3IxGelCwvhGFpTxbhNQjxE9ulpl6LNRm8goM7drQkhkKugvkl+4oi8emL35pspTVUAz4UVGW5E3lpE2aSMpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUz0Mgj6pHxFSPib/25TdciWnwYws0TeatnCKS5FZvw=;
 b=jPLjAk0xPu771UzVmrsbnDcqT6zb9nWVeeSLgQnjmCdYJkYjUS1iWixukSnW5Snk1IpYxMF9Xt1hZ7dbwN0jytk/mphMIY0FQLIgOAZ8Mxw+Y1vqt3FoZwjsOGFpD2ZNcr+nfyiyBe59YDwGIGKZ7cWfVoEyMP+nGPUu5kAnu4cNwI0qWe2R1UkiXvCPJgIe/lnEcw8gWeca7wga0WCfpqs2fxNlixbYOy6hIAYliqx7YxhIhrKqTxE8huovfcWL6bWBXloVVkKCB2l1hvdLsqMWaqTigSsqSe80sQ9uIdDH0SNU4br5T0e8hMClq7RkraQacQ6xpexr4/g9jrkCkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUz0Mgj6pHxFSPib/25TdciWnwYws0TeatnCKS5FZvw=;
 b=N6pkXLkXJeCZWa/61I4TP70i2xF044kNyws+counfk56IBNkoZzXAI2wzuNpd52zIkTYplGeuX5+G+Ea7ue27XoWxLvHHaBlvahQUQdoiYnDxCsxA73NKAj8nv5d9pMrg+VFPYWHwC4jMw8oLqT6mDhy7sMkWb6cWya5+fIPV98=
Received: from MWHPR03CA0019.namprd03.prod.outlook.com (2603:10b6:300:117::29)
 by DM6PR03MB4713.namprd03.prod.outlook.com (2603:10b6:5:181::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16; Fri, 11 Oct
 2019 10:56:46 +0000
Received: from CY1NAM02FT013.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::207) by MWHPR03CA0019.outlook.office365.com
 (2603:10b6:300:117::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16 via Frontend
 Transport; Fri, 11 Oct 2019 10:56:46 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT013.mail.protection.outlook.com (10.152.75.162) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2347.16
 via Frontend Transport; Fri, 11 Oct 2019 10:56:46 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x9BAudfA031229
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 11 Oct 2019 03:56:39 -0700
Received: from saturn.ad.analog.com (10.48.65.112) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 11 Oct 2019 06:56:45 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <sre@kernel.org>, Stefan Popa <stefan.popa@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v3][RESEND] adp5061: Add support for battery charging enable
Date:   Fri, 11 Oct 2019 13:56:49 +0300
Message-ID: <20191011105649.22357-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1523459436-31746-1-git-send-email-stefan.popa@analog.com>
References: <1523459436-31746-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(396003)(136003)(189003)(199004)(316002)(70206006)(246002)(305945005)(14444005)(8676002)(11346002)(44832011)(426003)(446003)(2616005)(76176011)(48376002)(7636002)(336012)(476003)(86362001)(70586007)(126002)(486006)(106002)(50466002)(2906002)(186003)(356004)(107886003)(51416003)(1076003)(36756003)(478600001)(47776003)(4326008)(50226002)(110136005)(54906003)(5660300002)(8936002)(2870700001)(26005)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB4713;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4f27307-987a-4bba-a439-08d74e39b59e
X-MS-TrafficTypeDiagnostic: DM6PR03MB4713:
X-Microsoft-Antispam-PRVS: <DM6PR03MB4713CD26F5C5D19E15777856F9970@DM6PR03MB4713.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0187F3EA14
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FR+bRtLr0a21OujitWy73ewFdyfba3+z4icA+jf7zYNk7W91y5oBOz6qwqXXdZrbn81gB2W6xya1BBq6/qgTigElb5rzbl+H7vHzcaxYLSVDkzoYyyNCUVgRcc+AOMaU87l8WsdUP4E0fwl2QMi3GQHXExC4E3FHX+s+BF+zhNpNcQYMrtzA6DjoUBoASo/OENgrsHm35l0R/SeQG5xMxrceQFliL1ZDo76/A4I0AVOxo/QsRrvlp/ybqjJEyPalipYIDtdDIhE2vSWC4psClSBDz4vLBSkt1xV2fa8H8QUVJEhbMVWMJG8Ievq3RlCBp14tnPyGIsDHPuV+dSxYpdbGhm+NBhpmZaqR2VNOQn5GXN2EPVgcz5mu3oykfp6H+CLQQmWnPu8/TlNPLSei6YaPrIiKpGSbkitKHPjPnoQ=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2019 10:56:46.2128
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4f27307-987a-4bba-a439-08d74e39b59e
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4713
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-11_07:2019-10-10,2019-10-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1011 malwarescore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910110104
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Stefan Popa <stefan.popa@analog.com>

This patch adds the option to enable/disable battery charging. This
option is not configurable via the power_supply properties, therefore,
access via sysfs was provided to examine and modify this attribute on the
fly.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

I could not find any traces about this patch being denied and why.
So this is a RESEND to [re]trigger a discussion if needed.

 .../ABI/testing/sysfs-class-power-adp5061     | 10 +++
 drivers/power/supply/adp5061.c                | 63 +++++++++++++++++++
 2 files changed, 73 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-power-adp5061

diff --git a/Documentation/ABI/testing/sysfs-class-power-adp5061 b/Documentation/ABI/testing/sysfs-class-power-adp5061
new file mode 100644
index 000000000000..0d056aa103b5
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-power-adp5061
@@ -0,0 +1,10 @@
+What: /sys/class/power_supply/adp5061/charging_enabled
+Description:
+	Enable/disable battery charging.
+
+	The ADP5061 charging function can be enabled by setting
+	this attribute to 1. See device datasheet for details.
+
+	Valid values:
+		- 1: enabled
+		- 0: disabled
diff --git a/drivers/power/supply/adp5061.c b/drivers/power/supply/adp5061.c
index 003557043ab3..6e09a6b710e8 100644
--- a/drivers/power/supply/adp5061.c
+++ b/drivers/power/supply/adp5061.c
@@ -74,6 +74,10 @@
 #define ADP5061_CHG_STATUS_2_RCH_LIM_INFO(x)	(((x) >> 3) & 0x1)
 #define ADP5061_CHG_STATUS_2_BAT_STATUS(x)	(((x) >> 0) & 0x7)
 
+/* ADP5061_FUNC_SET_1 */
+#define ADP5061_FUNC_SET_1_EN_CHG_MSK		BIT(0)
+#define ADP5061_FUNC_SET_1_EN_CHG_MODE(x)	(((x) & 0x01) << 0)
+
 /* ADP5061_IEND */
 #define ADP5061_IEND_IEND_MSK			GENMASK(7, 5)
 #define ADP5061_IEND_IEND_MODE(x)		(((x) & 0x07) << 5)
@@ -691,11 +695,64 @@ static const struct power_supply_desc adp5061_desc = {
 	.num_properties		= ARRAY_SIZE(adp5061_props),
 };
 
+static int adp5061_get_charging_enabled(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct power_supply *psy = dev_get_drvdata(dev);
+	struct adp5061_state *st = power_supply_get_drvdata(psy);
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(st->regmap, ADP5061_FUNC_SET_1, &regval);
+	if (ret < 0)
+		return ret;
+
+	regval &= ADP5061_FUNC_SET_1_EN_CHG_MSK;
+	return sprintf(buf, "%d\n", regval);
+}
+
+static int adp5061_set_charging_enabled(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t count)
+{
+	struct power_supply *psy = dev_get_drvdata(dev);
+	struct adp5061_state *st = power_supply_get_drvdata(psy);
+	u8 chg_en;
+	int ret;
+
+	ret = kstrtou8(buf, 0, &chg_en);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_update_bits(st->regmap, ADP5061_FUNC_SET_1,
+				 ADP5061_FUNC_SET_1_EN_CHG_MSK,
+				 ADP5061_FUNC_SET_1_EN_CHG_MODE(!!chg_en));
+
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static DEVICE_ATTR(charging_enabled, 0644, adp5061_get_charging_enabled,
+		   adp5061_set_charging_enabled);
+
+static struct attribute *adp5061_attributes[] = {
+	&dev_attr_charging_enabled.attr,
+	NULL
+};
+
+static const struct attribute_group adp5061_attr_group = {
+	.attrs = adp5061_attributes,
+};
+
 static int adp5061_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
 	struct power_supply_config psy_cfg = {};
 	struct adp5061_state *st;
+	int ret;
 
 	st = devm_kzalloc(&client->dev, sizeof(*st), GFP_KERNEL);
 	if (!st)
@@ -721,6 +778,12 @@ static int adp5061_probe(struct i2c_client *client,
 		return PTR_ERR(st->psy);
 	}
 
+	ret = sysfs_create_group(&st->psy->dev.kobj, &adp5061_attr_group);
+	if (ret < 0) {
+		dev_err(&client->dev, "failed to create sysfs group\n");
+		return ret;
+	}
+
 	return 0;
 }
 
-- 
2.20.1

