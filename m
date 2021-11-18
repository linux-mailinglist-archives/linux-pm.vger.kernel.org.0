Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E34F455A78
	for <lists+linux-pm@lfdr.de>; Thu, 18 Nov 2021 12:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343683AbhKRLhK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Nov 2021 06:37:10 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:20356 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343640AbhKRLhH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Nov 2021 06:37:07 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AIB2Bus031723;
        Thu, 18 Nov 2021 11:32:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=nhUTn6S1O8buFn5Xa3Dk47TjJg+nwkO5vlgzpPLJgSE=;
 b=SuIVDFTjYL+9nS6Adl2VHU4NCEKf9lC54nWGFZiZq1ToWapQNth4YNmq5xZG6CZQ5FKx
 mS8Z2N7QiNk+Mbbhfe/X2DRsI7QC1VkHDVB8IlWQnHa/JAmjhE6q+5+P+/DSme2ECHUd
 faJL0JGyLQYCmxtpxG2pkZbeeYOUAzpc6VXMFMitZQEXyw3DtGFwlcP6tSYiLAmkHPXR
 0aIMssDQL2dTAwC7LUC9ht9yZso7iE5EEmE6Q1fyvlTrXARY8cSo+aNMmNjZ8+xfnWxC
 Xr6qRxaceTTZRU/PRj89kVmZy4/+fu5LZQ2KTHTflejPTrRq4xjg/ozMD9p9Ej9UCbG3 Hg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cd2ajpen4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Nov 2021 11:32:46 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AIBV363033036;
        Thu, 18 Nov 2021 11:32:45 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by aserp3020.oracle.com with ESMTP id 3ca568edju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Nov 2021 11:32:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tk9YZ2jR2cLUm4Z/YZf4ZsemUeOSzKTiIwE+ylLVA7CTDNeiCm0alwzdQuopXZ8/cWamIqH15zOYvZ+p63GQWJu/GvAs6w2yw7vb+kAqPkKEJWCJVDPKjvxaXTkK+5l0Df5CtGV3tSIvgcjml1RXoGVUD4bvPgI29AHT9+JdDeBWdLl0Tn06CwhSzisqeQDB8SlwKfm4aHH0GOFk0GsWSGLiIWgO36Y2rKMfB/W+C80xcY11W7asSU9Jkpd3qqrVs/K6tnVEJiOSu+aIAztak0zlPDX8agO+pbGXMFlTVaNpZtYKISP1zV36hwmdDsFedfupPbezMR+2V07QBPv4Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhUTn6S1O8buFn5Xa3Dk47TjJg+nwkO5vlgzpPLJgSE=;
 b=i757mMafynh9yKKQoqJSp7Fd46si3k3N6mIDE/CVsaiK4siVxHIMoD0eM2jsKb0mEADAUi9KknpgK/hbIbKb1/RYkqn4NPjZiZtNwdZAyaVPljbLJSYZcbAaxENp41nthySvDBHf22ISDFg/TUZcQ60UNsHmYT7H7ATqILqzkyEghC7f4ooszjzXVC8JrmNUZLjOKWXTCZkA9An4ay28KP4xxzG3XPBAwknUL3jdSxp4vE/qJRnKZa3f1rtYs6bVA3BKPVl/y4BlOX9CMbQIy05Qj710iplobWCy/jZTehlUije8bCOm2O05daf6sOjAp9CxZ5dHfudpVKmrJMcBVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhUTn6S1O8buFn5Xa3Dk47TjJg+nwkO5vlgzpPLJgSE=;
 b=AIzZyeTgx1isYANbm/he97jNVrS7Lxo8qAMSzsN8I9VASyB0S4+NydChcbXECX26TAEduA8/uZR+8NMU2WUeMfNOxIKw7z4q5ZhaKTErsBCRn5e2V97Wt1enSKOIYBoBq96cQnEhCNifCQ6J0btkAoIctjMl9nQkzn/+d20qzbM=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1949.namprd10.prod.outlook.com
 (2603:10b6:300:10c::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Thu, 18 Nov
 2021 11:32:43 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4690.016; Thu, 18 Nov 2021
 11:32:42 +0000
Date:   Thu, 18 Nov 2021 14:32:22 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-omap@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] extcon: fix extcon_get_extcon_dev() error handling
Message-ID: <20211118113026.GG1147@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0014.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::24) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (102.222.70.114) by ZR0P278CA0014.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:16::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Thu, 18 Nov 2021 11:32:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b21c3c8-9732-4634-f5ca-08d9aa872295
X-MS-TrafficTypeDiagnostic: MWHPR10MB1949:
X-Microsoft-Antispam-PRVS: <MWHPR10MB19499C99034CC2FA4D8B0E048E9B9@MWHPR10MB1949.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WplJOR/UyQigLqVjxG6Braew2R5+yP0aSSfAlsGNDcfMSLjJo8C1MmxZgMgr9NKDWdw3NnDbSiKz1DSeEMENIxpaDyXkiim1OQAWpZhpbtfJfjWL6eYJWrkDBv5r3GRL5bguV/Bc+JqpQ+vOD6+s8UoK0EHALs+WtoKD2LU40DkEbyDGoxGhgZF/N7SrmLku0iRGe/UGNJOne6bZMZOI01EHS75qD1NmPNu+i83APqXy8iwI+6G6938qHPYGstjWfsmKLmekDADlo00sVqSQR3MDP5dmgJZ+p2Ua2jfTk9SSZpeIpzYRPzQz8gzqheTEmxjv/F099VOyPvwgEcSHsYBgO7m3bsPGgr3Vbl3+3TSMzL14z/izEeFSUZiVA3hf8NfCaFC82nTU82XUeToteuihnNal+Skad1SrhjTt1RKrin0jOc6XIuBmK3wJBrOMkYVBCTpiRAA2aiwRt6IcI5/tFB3pRR5Lgoa6OBQRzm2uTWeLiiby3oGhqdIPGc21rgZ5s1S8C2SXjbQFLtDi9P7RgmaxQFhy05HfYw9n4Q8l6bitnv1187djNe4QcFYXMlDiMSHt6KoF5wU2RRDu7DAsLCRa6jXAXIXrKvyzhMkDajwnUS00WgDnpaYbUuR0bt7oL7T5qAvdZVH17k+O2+zT5GguljxtX0erLFwewdcBcpg6ygh2eKZmHg/A8uOUR+2GnZ4pvDZHGLzlYiE6RA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(2906002)(6666004)(6916009)(33716001)(4326008)(55016002)(54906003)(6496006)(186003)(7416002)(52116002)(5660300002)(33656002)(1076003)(83380400001)(316002)(86362001)(508600001)(956004)(9576002)(38350700002)(66556008)(66476007)(66946007)(38100700002)(26005)(9686003)(44832011)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+dWMIB7P6PCyOu4TIr7AgXtmrCLY5O8befh/Y+PQpheLLHxF76M4d1MH/AFf?=
 =?us-ascii?Q?3Bs9EA6Uhm5fGhWyAcBwPTNd0Q7UqsB+CpCzeBBEkiPhbfn/ikDsdPt1s0Vo?=
 =?us-ascii?Q?IssScfwi6+YuJHID0Ox0Cnk25AxoUInueNsC0ngA6bOFpd/mI6l+eOeLhhsS?=
 =?us-ascii?Q?/RyDAE7K6/iQ6POnqYu4NFO3mrxueQWY29Pn0dEOI3hekfcgTe3MAnd3XvaE?=
 =?us-ascii?Q?Ut5tzAR5cN8SN7aZx5O33OOCdoeHY7/smHlSpSspk/wU7Zc8nUFq/lPSYEpi?=
 =?us-ascii?Q?tyWz2aE9NRCTIUv+jtOnG/RSy+qfF0r6HPN8ClUZBfW7kT6lAvCJdCa2oCXd?=
 =?us-ascii?Q?OI1yXlOKhvQIsOCad1ufZ+0xA8OaGC86O+V0Cwqys3pFLPsuYXRnZiWRQoOy?=
 =?us-ascii?Q?009kcuirMEOLtc7Adu5JKdR2kNXJE7EU2ybGfX9f/YvgXTMQRbO/6XsDJckd?=
 =?us-ascii?Q?C88OyGQArns3gvLM336kqEOEZ4PUaTDay3Ovk9JIVwshPLK6sycNfABrhpuH?=
 =?us-ascii?Q?AM93oteWvW28lDPupNJK27NDLcWIvzhP/LIZfNAzCqbP0G9n73Zl0u5xGTK8?=
 =?us-ascii?Q?H6uKzfkdqQ8PeQrewzN9IqLC150sBKTxGLEXXx/iMRlQNcqS1d9q9mF23pKf?=
 =?us-ascii?Q?bt9mjGHDCl/piVWwudc2hBpERFnJKJ+dosgH0LDYdOLXpAo117QBh9Jaktej?=
 =?us-ascii?Q?4S5mYz2VMoN+x0kyQmRM76nne1yswQO5nkHypzKOQE4VPv18vzUFGK9l+TSW?=
 =?us-ascii?Q?+YKe7cbGcft9l9wASynRSUaGAFLUYIJ5UQOecAMld+cruhphLBTZ3d9KHdUa?=
 =?us-ascii?Q?Y+Wt3m3r9V1kFVQuqf1wANS4em7/A+kQm+CablOLlyC1oRv3d9Zs0/p1T17D?=
 =?us-ascii?Q?02R5SJcbXB2HE70V/gdTIkjCM0YZ1VAcUroJSg6a+yBagCENKx1uB21syQSe?=
 =?us-ascii?Q?BgGHxhUYKHze5GzjKn2IFVV8QudfP/1sjYZGgEfdrJAGjHC8xQCCn5IL9TTu?=
 =?us-ascii?Q?miA4K5eM18Yf0udHcsiRSGO+GCfQI1po1QhJWd8TLi/HN96OeQuY2vQ2T/DO?=
 =?us-ascii?Q?qvBr7KJBNVNsuH3imlfvJDjAziAF+OX1o8KhxfLrCNNZ28KfocKOqg2zIt/G?=
 =?us-ascii?Q?cSaChrayKS+iMZkOTZ9KnA+8iqlQjIl353gzpjOvCcYqLi92DAyM1WTe43oA?=
 =?us-ascii?Q?TBIm1TDWU1vLDycFQCjapc63q0aDJKJ18jrdLVNr8iPmzdqlleAyXu7hJ3Lu?=
 =?us-ascii?Q?SK9z9Ih44ONTrJfcPPXXKoj1o5BdxUe/zSSIfwJLnzslwJ/MBvchms8PWtL9?=
 =?us-ascii?Q?t0myjp7IvUpvuOG3M79RsvjJB2tYfSiDq10AvIhBIO0vVu5x8UMxy9UzzE1H?=
 =?us-ascii?Q?/+TfcZ5lM4hma7dvgUvmmscvG2mnbqR+o+iv6qz0n6cmoMp6xHLF2FiELjLi?=
 =?us-ascii?Q?fZlczGg29GCHgfbYlzAc+xmHnGQ5c5OZ+iRc0Eg8H+IpA+l7cwbdU3+YqkSA?=
 =?us-ascii?Q?w1kuE5o6hMBWqRTrYpTZR57vdE7YqOtHCeuXlhIyeiqjT/6dDJg6x8HQ7EiK?=
 =?us-ascii?Q?+SnnrR82/CBufhDIesNGWsE3Ag7iJ7mtVL9EPs1s+LaowjLaeAXY7hj9MBOJ?=
 =?us-ascii?Q?Gcg/umD4E3vbBRcsrLuCa0IB6F09t/6AmmlRaf7LhsWDHVV561NzUCrRwPkd?=
 =?us-ascii?Q?efPrO19McT1gqjArGyym9K5rJWE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b21c3c8-9732-4634-f5ca-08d9aa872295
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 11:32:42.8575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1pZV/oBlNEfOTo6l31aqKJbBxEGDZ0XoQainqnAIi2qfbTOTBzGDXQLdOKtWDOj3gwqgNczWiB40Zu4/qdxv10/64ft0cf3nhmXgcExeo6Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1949
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10171 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111180067
X-Proofpoint-GUID: x1HW4TBj0hBVYk5MbQohNcLHhnWhpkVd
X-Proofpoint-ORIG-GUID: x1HW4TBj0hBVYk5MbQohNcLHhnWhpkVd
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The extcon_get_extcon_dev() function returns error pointers on error
and NULL when it's a -EPROBE_DEFER defer situation.  There are eight
callers and only two of them handled this correctly.  In the other
callers an error pointer return would lead to a crash.

What prevents crashes is that errors can only happen in the case of
a bug in the caller or if CONFIG_EXTCON is disabled.  Six out of
eight callers use the Kconfig to either depend on or select
CONFIG_EXTCON.  Thus the real life impact of these bugs is tiny.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
The two callers where the drivers can be built without CONFIG_EXTCON
are TYPEC_FUSB302 and CHARGER_MAX8997.

If we apply this patch, it might be a good idea to send it to -stable
so that backported code that relies on handling error pointers does
not break silently.

 drivers/extcon/extcon.c                |  2 +-
 drivers/power/supply/axp288_charger.c  | 17 ++++++++++-------
 drivers/power/supply/charger-manager.c |  7 ++-----
 drivers/power/supply/max8997_charger.c | 10 +++++-----
 drivers/usb/dwc3/drd.c                 |  9 ++-------
 drivers/usb/phy/phy-omap-otg.c         |  4 ++--
 drivers/usb/typec/tcpm/fusb302.c       |  4 ++--
 drivers/extcon/extcon-axp288.c         |  4 ++--
 8 files changed, 26 insertions(+), 31 deletions(-)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index e7a9561a826d..a35e99928807 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -876,7 +876,7 @@ struct extcon_dev *extcon_get_extcon_dev(const char *extcon_name)
 		if (!strcmp(sd->name, extcon_name))
 			goto out;
 	}
-	sd = NULL;
+	sd = ERR_PTR(-EPROBE_DEFER);
 out:
 	mutex_unlock(&extcon_dev_list_lock);
 	return sd;
diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
index ec41f6cd3f93..4acfeb52a44e 100644
--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -848,17 +848,20 @@ static int axp288_charger_probe(struct platform_device *pdev)
 	info->regmap_irqc = axp20x->regmap_irqc;
 
 	info->cable.edev = extcon_get_extcon_dev(AXP288_EXTCON_DEV_NAME);
-	if (info->cable.edev == NULL) {
-		dev_dbg(dev, "%s is not ready, probe deferred\n",
-			AXP288_EXTCON_DEV_NAME);
-		return -EPROBE_DEFER;
+	if (IS_ERR(info->cable.edev)) {
+		dev_err_probe(dev, PTR_ERR(info->cable.edev),
+			      "extcon_get_extcon_dev(%s) failed\n",
+			      AXP288_EXTCON_DEV_NAME);
+		return PTR_ERR(info->cable.edev);
 	}
 
 	if (acpi_dev_present(USB_HOST_EXTCON_HID, NULL, -1)) {
 		info->otg.cable = extcon_get_extcon_dev(USB_HOST_EXTCON_NAME);
-		if (info->otg.cable == NULL) {
-			dev_dbg(dev, "EXTCON_USB_HOST is not ready, probe deferred\n");
-			return -EPROBE_DEFER;
+		if (IS_ERR(info->otg.cable)) {
+			dev_err_probe(dev, PTR_ERR(info->otg.cable),
+				      "extcon_get_extcon_dev(%s) failed\n",
+				      USB_HOST_EXTCON_NAME);
+			return PTR_ERR(info->otg.cable);
 		}
 		dev_info(dev, "Using " USB_HOST_EXTCON_HID " extcon for usb-id\n");
 	}
diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index d67edb760c94..92db79400a6a 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -985,13 +985,10 @@ static int charger_extcon_init(struct charger_manager *cm,
 	cable->nb.notifier_call = charger_extcon_notifier;
 
 	cable->extcon_dev = extcon_get_extcon_dev(cable->extcon_name);
-	if (IS_ERR_OR_NULL(cable->extcon_dev)) {
+	if (IS_ERR(cable->extcon_dev)) {
 		pr_err("Cannot find extcon_dev for %s (cable: %s)\n",
 			cable->extcon_name, cable->name);
-		if (cable->extcon_dev == NULL)
-			return -EPROBE_DEFER;
-		else
-			return PTR_ERR(cable->extcon_dev);
+		return PTR_ERR(cable->extcon_dev);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(extcon_mapping); i++) {
diff --git a/drivers/power/supply/max8997_charger.c b/drivers/power/supply/max8997_charger.c
index 25207fe2aa68..634658adf313 100644
--- a/drivers/power/supply/max8997_charger.c
+++ b/drivers/power/supply/max8997_charger.c
@@ -248,13 +248,13 @@ static int max8997_battery_probe(struct platform_device *pdev)
 		dev_info(&pdev->dev, "couldn't get charger regulator\n");
 	}
 	charger->edev = extcon_get_extcon_dev("max8997-muic");
-	if (IS_ERR_OR_NULL(charger->edev)) {
-		if (!charger->edev)
-			return -EPROBE_DEFER;
-		dev_info(charger->dev, "couldn't get extcon device\n");
+	if (IS_ERR(charger->edev)) {
+		dev_err_probe(charger->dev, PTR_ERR(charger->edev),
+			      "couldn't get extcon device: max8997-muic\n");
+		return PTR_ERR(charger->edev);
 	}
 
-	if (!IS_ERR(charger->reg) && !IS_ERR_OR_NULL(charger->edev)) {
+	if (!IS_ERR(charger->reg)) {
 		INIT_WORK(&charger->extcon_work, max8997_battery_extcon_evt_worker);
 		ret = devm_add_action(&pdev->dev, max8997_battery_extcon_evt_stop_work, charger);
 		if (ret) {
diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
index d7f76835137f..a490f79131c1 100644
--- a/drivers/usb/dwc3/drd.c
+++ b/drivers/usb/dwc3/drd.c
@@ -454,13 +454,8 @@ static struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
 	 * This device property is for kernel internal use only and
 	 * is expected to be set by the glue code.
 	 */
-	if (device_property_read_string(dev, "linux,extcon-name", &name) == 0) {
-		edev = extcon_get_extcon_dev(name);
-		if (!edev)
-			return ERR_PTR(-EPROBE_DEFER);
-
-		return edev;
-	}
+	if (device_property_read_string(dev, "linux,extcon-name", &name) == 0)
+		return extcon_get_extcon_dev(name);
 
 	/*
 	 * Try to get an extcon device from the USB PHY controller's "port"
diff --git a/drivers/usb/phy/phy-omap-otg.c b/drivers/usb/phy/phy-omap-otg.c
index ee0863c6553e..6e6ef8c0bc7e 100644
--- a/drivers/usb/phy/phy-omap-otg.c
+++ b/drivers/usb/phy/phy-omap-otg.c
@@ -95,8 +95,8 @@ static int omap_otg_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	extcon = extcon_get_extcon_dev(config->extcon);
-	if (!extcon)
-		return -EPROBE_DEFER;
+	if (IS_ERR(extcon))
+		return PTR_ERR(extcon);
 
 	otg_dev = devm_kzalloc(&pdev->dev, sizeof(*otg_dev), GFP_KERNEL);
 	if (!otg_dev)
diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
index 7a2a17866a82..8594b59bd527 100644
--- a/drivers/usb/typec/tcpm/fusb302.c
+++ b/drivers/usb/typec/tcpm/fusb302.c
@@ -1706,8 +1706,8 @@ static int fusb302_probe(struct i2c_client *client,
 	 */
 	if (device_property_read_string(dev, "linux,extcon-name", &name) == 0) {
 		chip->extcon = extcon_get_extcon_dev(name);
-		if (!chip->extcon)
-			return -EPROBE_DEFER;
+		if (IS_ERR(chip->extcon))
+			return PTR_ERR(chip->extcon);
 	}
 
 	chip->vbus = devm_regulator_get(chip->dev, "vbus");
diff --git a/drivers/extcon/extcon-axp288.c b/drivers/extcon/extcon-axp288.c
index 7c6d5857ff25..180be768c215 100644
--- a/drivers/extcon/extcon-axp288.c
+++ b/drivers/extcon/extcon-axp288.c
@@ -394,8 +394,8 @@ static int axp288_extcon_probe(struct platform_device *pdev)
 		if (adev) {
 			info->id_extcon = extcon_get_extcon_dev(acpi_dev_name(adev));
 			put_device(&adev->dev);
-			if (!info->id_extcon)
-				return -EPROBE_DEFER;
+			if (IS_ERR(info->id_extcon))
+				return PTR_ERR(info->id_extcon);
 
 			dev_info(dev, "controlling USB role\n");
 		} else {
-- 
2.20.1

