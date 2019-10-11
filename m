Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFC9D3DD8
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2019 13:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfJKLAH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Oct 2019 07:00:07 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:10636 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726885AbfJKLAH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Oct 2019 07:00:07 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9BArAWl021524;
        Fri, 11 Oct 2019 06:59:59 -0400
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2058.outbound.protection.outlook.com [104.47.32.58])
        by mx0b-00128a01.pphosted.com with ESMTP id 2vemxb42sn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Oct 2019 06:59:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lXcqm1htQL6zCp8F1ckZoFBKY86pN9vqurwm90xSLoGBkJayW9YBqBnhRFnw4NJl0myTfAB6M7bq6jYJJQvQ1y8hDDraqoK5+tdgSoMfqxLmONxPmNtOr1tFmZlnFzYfbksUXIQbh/s17nCVDVii7KsconNynZNvyDTrQT0XmAyHs1y3YK9xcZvXimZ8f/uQAHW9UP/oiqdANhqrq/XVi2/PO2RfH2tGaHwFa2CBUd+2D/M4Y/mE/XrvaQjgOBJFVHmgDkKobV2j3I9uNvctI3PwAzHgW3bUJrJYjsLp0KINnbIIczpOyxOu9nce3f2sX1OlDSqP17AoYn9AT6BqPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ru+dB7wNnhc+OGsmvc4KX5kxeeWRKjGRL8Wi2nQmOE4=;
 b=ihX2614jRNbhKMjCET1C2DR/OEabf/l6J+qkTVCDnJ+R1ZsxGVM6+qXMvIksAmhyAgOzCpN/IuZvWKDI3uujW/ZSmPvMha73NAsEF/U/cd37FqmGVHGJrAPEI7ZS8WunToFBBVXrrULZIPEykhUgEikzmTZHU8RUndtp4Q+vEfHza45R86Tr8Cjj83sSUVUSQhvmTik+xgxBxXo6rYBf0lgqJ1BlNwiUS3s+IieQ93E3+PKqrD9ipl4h1V7pNMPbmOkU4jPOzwygcpkGUmq8IzNnV0VE0524q2Swo1f/GxaaW/IbD07LUzp575oUsswFzW+NlS0UR1xOIhbcw8h9SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ru+dB7wNnhc+OGsmvc4KX5kxeeWRKjGRL8Wi2nQmOE4=;
 b=QY/E4dofxdzN0eMo3erHQXrOztp9xrV0NAQGTZNXWIMVqRbpM7ViEI6OtHhVS+yJxYZp3EkxmQoda9s2pTm/jygLNxFWxcUq7jkupHlUhQsCu1SM4ZYjc84oH4RV6M2T5ZRSAaSDoqxxZ9wylVq3s3C9ZbTUrknzCZnMzdOAO1c=
Received: from BY5PR03CA0003.namprd03.prod.outlook.com (2603:10b6:a03:1e0::13)
 by CY4PR03MB2533.namprd03.prod.outlook.com (2603:10b6:903:43::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.18; Fri, 11 Oct
 2019 10:59:53 +0000
Received: from SN1NAM02FT061.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by BY5PR03CA0003.outlook.office365.com
 (2603:10b6:a03:1e0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.16 via Frontend
 Transport; Fri, 11 Oct 2019 10:59:52 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT061.mail.protection.outlook.com (10.152.72.196) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2347.16
 via Frontend Transport; Fri, 11 Oct 2019 10:59:52 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x9BAxqZn000305
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 11 Oct 2019 03:59:52 -0700
Received: from saturn.ad.analog.com (10.48.65.112) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 11 Oct 2019 06:59:51 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <sre@kernel.org>, Stefan Popa <stefan.popa@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v3][RESEND] adp5061: Add support for charging voltage limit enable
Date:   Fri, 11 Oct 2019 14:00:03 +0300
Message-ID: <20191011110003.22911-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1523459481-31860-1-git-send-email-stefan.popa@analog.com>
References: <1523459481-31860-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(376002)(136003)(189003)(199004)(36756003)(2906002)(86362001)(107886003)(476003)(126002)(2616005)(246002)(11346002)(44832011)(106002)(2870700001)(110136005)(54906003)(316002)(446003)(486006)(305945005)(7636002)(47776003)(14444005)(4326008)(48376002)(8676002)(8936002)(1076003)(50466002)(50226002)(5660300002)(51416003)(70586007)(7696005)(70206006)(478600001)(76176011)(356004)(6666004)(336012)(186003)(426003)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB2533;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d5c72d1-1a7b-4a21-8cff-08d74e3a24bc
X-MS-TrafficTypeDiagnostic: CY4PR03MB2533:
X-Microsoft-Antispam-PRVS: <CY4PR03MB2533DD126D55F774D8345F96F9970@CY4PR03MB2533.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0187F3EA14
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i6tLXEVoAxWO5KDhIvKtNwPRwOz074RhJiF3buRN6r9WdZwFGRa+Uf1Jis7pqjdynPYMiT0sMJqsKzzGMPNwZTuHU5WJaczKKl/4vfk5ryPXN/54cXgOps5W06azfL+ygHyT8JRQCm7Jhi34+Ep7FJTp013BEAzQtU5eS/a/4jlVaaQaN1c/DtGHvDRiO+0yiKKN1hxBhcvwxKT0MuRoZ3sITeotgiG6qh6d4hBpDi2V4CGkuaClWLWyZ7lp7WLD7SBPrVIbj3ZE5w8Xrdp4gHSgrGvrnk6mryh8vCtJ8hRwC09GsfLkEleSdKHm4uWKLiXIf6zieLzdMHiEHmAdCpwQLI1Kz+23QaOI+9LCo35ky3JpftR/hEaF7J21s+WIs5hE/lD27Ol0hucD9CNyXkV81EsnFdYdDBJ8miPQHHw=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2019 10:59:52.6519
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d5c72d1-1a7b-4a21-8cff-08d74e3a24bc
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2533
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-11_07:2019-10-10,2019-10-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 bulkscore=0 phishscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910110104
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Stefan Popa <stefan.popa@analog.com>

This patch adds the option to activate/deactivate the charging voltage
limit. If activated, the charger prevents charging until the battery
voltage drops below the VCHG_VLIM threshold.

This option is not configurable via the power_supply properties,
therefore, access via sysfs was provided to examine and modify this
attribute on the fly.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

I could not find any traces about this patch being denied and why.
So this is a RESEND to [re]trigger a discussion if needed.

 .../ABI/testing/sysfs-class-power-adp5061     | 13 +++++
 drivers/power/supply/adp5061.c                | 47 +++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power-adp5061 b/Documentation/ABI/testing/sysfs-class-power-adp5061
index 0d056aa103b5..25064c13ea7b 100644
--- a/Documentation/ABI/testing/sysfs-class-power-adp5061
+++ b/Documentation/ABI/testing/sysfs-class-power-adp5061
@@ -8,3 +8,16 @@ Description:
 	Valid values:
 		- 1: enabled
 		- 0: disabled
+
+What: /sys/class/power_supply/adp5061/charging_vlim_enabled
+Description:
+	Enable/disable charging voltage limit
+
+	The ADP5061 charging voltage limit can be enabled by setting
+	this attribute to 1. When enabled, the charger prevents charging
+	until the battery voltage drops bellow the VCHG_VLIM threshold.
+	See device datasheet for details.
+
+	Valid values:
+		- 1: enabled
+		- 0: disabled
diff --git a/drivers/power/supply/adp5061.c b/drivers/power/supply/adp5061.c
index 6e09a6b710e8..41b24cadd2c9 100644
--- a/drivers/power/supply/adp5061.c
+++ b/drivers/power/supply/adp5061.c
@@ -78,6 +78,10 @@
 #define ADP5061_FUNC_SET_1_EN_CHG_MSK		BIT(0)
 #define ADP5061_FUNC_SET_1_EN_CHG_MODE(x)	(((x) & 0x01) << 0)
 
+/* ADP5061_FUNC_SET_2 */
+#define ADP5061_FUNC_SET_2_EN_CHG_VLIM_MSK	BIT(5)
+#define ADP5061_FUNC_SET_2_EN_CHG_VLIM_MODE(x)	(((x) & 0x01) << 5)
+
 /* ADP5061_IEND */
 #define ADP5061_IEND_IEND_MSK			GENMASK(7, 5)
 #define ADP5061_IEND_IEND_MODE(x)		(((x) & 0x07) << 5)
@@ -735,11 +739,54 @@ static int adp5061_set_charging_enabled(struct device *dev,
 	return count;
 }
 
+static int adp5061_get_chg_vlim_enabled(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct power_supply *psy = dev_get_drvdata(dev);
+	struct adp5061_state *st = power_supply_get_drvdata(psy);
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(st->regmap, ADP5061_FUNC_SET_2, &regval);
+	if (ret < 0)
+		return ret;
+
+	regval = (regval & ADP5061_FUNC_SET_2_EN_CHG_VLIM_MSK) >> 5;
+	return sprintf(buf, "%d\n", regval);
+}
+
+static int adp5061_set_chg_vlim_enabled(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t count)
+{
+	struct power_supply *psy = dev_get_drvdata(dev);
+	struct adp5061_state *st = power_supply_get_drvdata(psy);
+	u8 chg_vlim_en;
+	int ret;
+
+	ret = kstrtou8(buf, 0, &chg_vlim_en);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_update_bits(st->regmap, ADP5061_FUNC_SET_2,
+			ADP5061_FUNC_SET_2_EN_CHG_VLIM_MSK,
+			ADP5061_FUNC_SET_2_EN_CHG_VLIM_MODE(!!chg_vlim_en));
+
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
 static DEVICE_ATTR(charging_enabled, 0644, adp5061_get_charging_enabled,
 		   adp5061_set_charging_enabled);
+static DEVICE_ATTR(charging_vlim_enabled, 0644, adp5061_get_chg_vlim_enabled,
+		   adp5061_set_chg_vlim_enabled);
 
 static struct attribute *adp5061_attributes[] = {
 	&dev_attr_charging_enabled.attr,
+	&dev_attr_charging_vlim_enabled.attr,
 	NULL
 };
 
-- 
2.20.1

