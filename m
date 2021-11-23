Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A86F459E76
	for <lists+linux-pm@lfdr.de>; Tue, 23 Nov 2021 09:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235009AbhKWIq6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Nov 2021 03:46:58 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:47054 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231347AbhKWIq5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Nov 2021 03:46:57 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AN7oqwD024211;
        Tue, 23 Nov 2021 08:43:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=GTSgKI2HTrLVCI1qrVBiJu5pSq1HYOUnkS1ftx3Y8Do=;
 b=FV6Sksmg775kK6+05ihi959/6g+b9tnNgKiM0tXasgSkr/g5ZNk38LaXUU0LKmGJvqKj
 on6F7+eCIe0YIgdNSp6b6CLKJaIYQFxzBxAf8bFrk1XTXI5s+iUMlzWQ2CY624T9XJBQ
 Pg1l0dR3LrNILzT6Obx7nYMEpo8UslgcbqhO+IeIwurJIs/BzAd8NQ02oaemrLJ70AuO
 NY9SsZoE/S1EJekucbu4IxxQuiW0ZQlM6ZXG+BnXkooYqJBa5dz6JKLjKhbGUYzVZ6YN
 5JCgfFQMXdRN+g+30UzjcPVTJWoadq0psjxZ7l34D4fub1qH3jlO5v9Sf6vsMOV6OIXE fw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cg5gj7p1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Nov 2021 08:43:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AN8ZPSV070439;
        Tue, 23 Nov 2021 08:43:24 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by userp3020.oracle.com with ESMTP id 3cfass22aw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Nov 2021 08:43:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ldc1HddVNEYb2anuOng6uPWDU4uxRFCSpAtfKkK8Ruq9d0z3277BNzGsoPkrwoHhU2IJMcKyRe9cml5dM9gCAzOCOm11TEYYF8iuvVfSfKgITwCFR13wYwrF+ddgmJqnhsMSBznhn2BqoCKlrEJZZ/QlIsUrreFWTkvMw2Sm5rjpommtD6ueJMKchx/oD2uXOnC/DZz9mvkMgn+bJ8EeiFtkFWhsMtPeIm38wvJlXd7UYHMG8jdiVgWkXifqf3/cW+x0lmOv9TYW75a+8m5EDMixEKsVDPhQ7dmMu5M7hTjJjh5LIK8dfLKAUrrqVIDfCpUZoHZeBdaW58nyV2bTjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GTSgKI2HTrLVCI1qrVBiJu5pSq1HYOUnkS1ftx3Y8Do=;
 b=OvoE928tfsNP1d3wlJ+F43kq+Ip2rrxfON3x019ZpDPKKM7t3LiQvTWIJaIyYxfm5vxafx7oST7tokvuVyx/kloD9iTFqJXCi6pq2T4l4A4NkbSH9pMm6bd1vEw5z2RYKt7/qQk7maaKsh+WYemWjAGUSB3IxJ4qf8q0ZrieXBcpd55RSdu7MGiDU9NMIXCpmrkrzla6tH1hS4gSNdz0q9Rq5lehcsLGnjxQQZnMvqqfWz/wYQH3OeJwAm/j0kmA92Ey8c05q+4zlJSfSjHPBd0nDBaZVNMmjw60U5/D1K9SjBUu5NweozALlQt9k17lupXiHabkLNduDCCTvcy3pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTSgKI2HTrLVCI1qrVBiJu5pSq1HYOUnkS1ftx3Y8Do=;
 b=r8BH5D0ILtsj/XYaVIhXIUaKwDxPJUilHDbizjVJVOGxQ2QoAlGxQVh9MSmNZc0cgYWGF1FF2Iktt2XLJy/rvhscQ9adq6IJOONn58QAsHUkEdoJkXHP9bWn8TfCxspS2iBRg7z2anVraQPZO2VuwS7S3vXD9gpvF44buK0J7f4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MW4PR10MB5680.namprd10.prod.outlook.com
 (2603:10b6:303:18e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Tue, 23 Nov
 2021 08:43:21 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::495f:a05d:ba7a:682]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::495f:a05d:ba7a:682%6]) with mapi id 15.20.4713.026; Tue, 23 Nov 2021
 08:43:21 +0000
Date:   Tue, 23 Nov 2021 11:43:06 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-omap@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH v2] extcon: fix extcon_get_extcon_dev() error handling
Message-ID: <20211123083925.GA3277@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: AS8PR04CA0010.eurprd04.prod.outlook.com
 (2603:10a6:20b:310::15) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (102.222.70.114) by AS8PR04CA0010.eurprd04.prod.outlook.com (2603:10a6:20b:310::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.20 via Frontend Transport; Tue, 23 Nov 2021 08:43:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2800bd41-c8fe-4410-aa22-08d9ae5d4e02
X-MS-TrafficTypeDiagnostic: MW4PR10MB5680:
X-Microsoft-Antispam-PRVS: <MW4PR10MB56801C6FD2B66CEFAA50A79F8E609@MW4PR10MB5680.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a+tbYWcBTN9tbYsbfcvHloSIbLo/aMdPPWvA3OneFuli/8Sy8RJ1RCJj18ASy8fMzFVUTCguy3udCmI35P2pOYUhCjooBfWW4pqHalFPkaA0jMSjlHuRFGksN3cihzxekd4YFrXJuijpZUWWKkDL56seWYPFvd5MkFyhcGAm8Yrbor2SqfeaKYYMarh3VMN1aEKjNDLH8sOplhC6Nouw4HD4OO3u8z7pye4QzJxgjN/NpNHBn/wH4WTMbrvafOjNAlGwgvLdj6a+gJ0zt84HKIdGZ1Ov12APiTGqvUuE4xv3w4EoWEjODSuDPaVl1eQeicafvX8hINDlDlK2RXxJiKbcy+++do+qD9VmtKgI59h0YJJ3khjbWL9kNOoZ/l8TkOTqliO0K9AncP3EUIA93pQBzWEsGrYdn4Ub3RmvsCHwflcIU6Bn1ZTSqrVNKKBg55HhVX2Q0mSjGkYcAwFuifqWv2EaGyQ0thWLsgmCQjL4zUmRf7gZh9D6m6Qajq1mRJYlX7ebxBJsbhsEiJVCJP/b53pN4HQMBKdfXnTYE+NkCuaMGkApp86ATqhpq8CYajfX4kN/P3bHyR7sI7maOQ3hM8qcHzd0cSib8fndTmu3HUiRJnKB4ocYG8rHAnNsGgHcX1NK1uEBh6Nqx3amvLWpQ1DbbQsUQKlNV0H7Ri4Bb3WelSHpO2tMG025NYjWCrCAf8YXZGcToWi3o11XIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6666004)(66946007)(9576002)(52116002)(956004)(66556008)(26005)(38350700002)(33716001)(508600001)(66476007)(110136005)(83380400001)(8676002)(33656002)(7416002)(38100700002)(6496006)(2906002)(9686003)(5660300002)(86362001)(54906003)(4326008)(1076003)(8936002)(55016003)(44832011)(186003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v246pGFLP7hpa6VpORj3JEYyzG2hGKA4NdGhjZZZtVpcim2sqaNNnF7gHfqK?=
 =?us-ascii?Q?0/V9R0EIdmziN3AoOqomd5YJ/i1DUVLvPFlHVCYnhdk+BrbgEf3U5xMyZJzH?=
 =?us-ascii?Q?JMwmDJayjVZJfd3FrQMYpe7mCpkZq0fHS8r5+Zyvr1OjPHKhj/7owek2B1LC?=
 =?us-ascii?Q?L1bkXWRkyByp0HQ8incrD+YzQFKBfFXPPOQ0VIrQwgAdXatEGPkZGmkU+wil?=
 =?us-ascii?Q?FRVPgSnbJVSSGdIu1zIx9RuLsLPV1Tql23PLUIyaTl1Qjjr2RVMrACHWDvTH?=
 =?us-ascii?Q?Y2b9suKVr+qQQ4RSKlsvMrwB8FuKNLPV2T9VVA8KnNRjvrh7dL3jRZuKCSMV?=
 =?us-ascii?Q?1zIhbEBKuaf50fFdWiDxUmLNgmbki8fThw+MvUwZAlTtxKg1kMnyDVwdYA0l?=
 =?us-ascii?Q?zO8iiA7zv7svQRh2r9Y8Barw8CmZ+i2i9YXoGw/Hannd4Y7N7oNYmCMVJscD?=
 =?us-ascii?Q?xrikeQWdv2lmkE+witlSlYYkGofps+j6fMoeOByo3Kka8hyzwu+UxjLuoqz0?=
 =?us-ascii?Q?4Z75VTyQv+pHv3YMj++4arhqbJmzlYSBw3ZHoOCy/i+BiKVhirpfEwUUBMES?=
 =?us-ascii?Q?s/xA21MASFcE6pvjM72EiHdJGGjHH+gTMrCxXGGiq+vYhOwh7Da/ZCO7W69R?=
 =?us-ascii?Q?uII02AbmVXp1YtRJ6YXJU4rNy1e2A8s7c/oJlwu18YNr3zkIjItzL/S7aCVp?=
 =?us-ascii?Q?kJGfUt6A9DLUw1ZyjgYbvDedzHe7MHYY/0o3RLumdL1o2HjJMiG6zOfGnTEP?=
 =?us-ascii?Q?5e0EcqOKEdrajQ/46yaujYm3c48VJCSmxCVS2109XaGMQ0gPNUjBzL4xfvqZ?=
 =?us-ascii?Q?T+cQT2MLNG/3gYHTpLUYI1WODT1IkkjNZsy27Uv7ASwQoXq5WuWH7ZZQv2j+?=
 =?us-ascii?Q?3iqzyewACqu+dIa/MzZvFFzDAgREqC1Bcmg44SwWAtOZVOLQ1pxw4vAWkp52?=
 =?us-ascii?Q?PtUHuuMw3I50xEcOOb5RfvUOfAhEah4AcH7t9kvQOP515DS+lvUFpNU0ZvKy?=
 =?us-ascii?Q?WhNxqINanqd4Nohg9WQNUFcvo/HBauMZ9yG1dBr6lGlUjIVGUV5hErZoscyj?=
 =?us-ascii?Q?vcARJdWZjuxo1EspScFgZHRFLm4dArYfCxXMDT00urQt0uJMhRUoF5Jr+rU2?=
 =?us-ascii?Q?GnYlsM5iw5JrAM63sHdTWA3Qe7NS6/WOe3lmTtbfneQfQK/tk34Xb8CPEL1g?=
 =?us-ascii?Q?q43Y5L+x9D76Abg6erRsWQrjExg6KCvy3anQZEstpSayU9t8wlAXb8HeFxJH?=
 =?us-ascii?Q?NyJBnKue7fNDoHyUFYwe689jOBQm80Q+Jvg1mFRPBGp3IZOCqzEH/Wfd21Ux?=
 =?us-ascii?Q?cdzdVpt+DHvaaMPiT3KrHQKE5hduT2kXCjmg/SE8/E0ZoyzpLMUbIxzEwN1N?=
 =?us-ascii?Q?U+2wHbjLcXSGASfPeXf+rLGC09RVnEfkk7M3P4WyglR+cxWiABGC2/p6yGeW?=
 =?us-ascii?Q?9mPGkqF9h/RPxBVezhOdAFuHH6uIAfi2SDk7yGbv09yBL3t/77xbrFDi0/D7?=
 =?us-ascii?Q?qv50Td+fredW9VdkshaMquUfO6x6zsRrqOOZtkZX/0sgkTaMjrSF59E0u6G1?=
 =?us-ascii?Q?EFNIlSsNDFXhkCEREMgqMZSwtiF7H+KP0S4FtxtWcRzBFYpR6QPBSNdTNkQM?=
 =?us-ascii?Q?JHmo8aaxaaWqcZE4zc85rokOjv6OZaNkiV63XAz9OVmdV56/dhHkmBrHJ0gv?=
 =?us-ascii?Q?MMrReN5ZDr+LBnwMzlS9oeJf2dw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2800bd41-c8fe-4410-aa22-08d9ae5d4e02
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 08:43:21.5453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SBkLw8INyWZb5vveAjNTvPlglDdX1B/vxkpvzxXK3jQcUbUW5k247bmJIO1rrVwguqG2IxT5EBAYLHoenl2qaZvh6noLq6QmuLIgeYO/rjY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5680
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10176 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111230045
X-Proofpoint-GUID: eyynjpvgnc4G1lXbnwzl-mDJg1EoXDX7
X-Proofpoint-ORIG-GUID: eyynjpvgnc4G1lXbnwzl-mDJg1EoXDX7
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The extcon_get_extcon_dev() function returns error pointers on error,
NULL when it's a -EPROBE_DEFER defer situation, and ERR_PTR(-ENODEV)
when the CONFIG_EXTCON option is disabled.  This is very complicated for
the callers to handle and a number of them had bugs that would lead to
an Oops.

In real life, there are two things which prevented crashes.  First,
error pointers would only be returned if there was bug in the caller
where they passed a NULL "extcon_name" and none of them do that.
Second, only two out of the eight drivers will build when CONFIG_EXTCON
is disabled.

The normal way to write this would be to return -EPROBE_DEFER directly
when appropriate and return NULL when CONFIG_EXTCON is disabled.  Then
the error handling is simple and just looks like:

	dev->edev = extcon_get_extcon_dev(acpi_dev_name(adev));
	if (IS_ERR(dev->edev))
		return PTR_ERR(dev->edev);

For the two drivers which can build with CONFIG_EXTCON disabled, then
extcon_get_extcon_dev() will now return NULL which is not treated as an
error and the probe will continue successfully.  Those two drivers are
"typec_fusb302" and "max8997-battery".  In the original code, the
typec_fusb302 driver had an 800ms hang in tcpm_get_current_limit() but
now that function is a no-op.  For the max8997-battery driver everything
should continue working as is.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v2: return NULL when CONFIG_EXTCON is disabled

If we apply this patch, it might be a good idea to send it to -stable
so that backported code that relies on handling error pointers does
not break silently.

 drivers/extcon/extcon-axp288.c         |    4 ++--
 drivers/extcon/extcon.c                |    2 +-
 drivers/power/supply/axp288_charger.c  |   17 ++++++++++-------
 drivers/power/supply/charger-manager.c |    7 ++-----
 drivers/power/supply/max8997_charger.c |   10 +++++-----
 drivers/usb/dwc3/drd.c                 |    9 ++-------
 drivers/usb/phy/phy-omap-otg.c         |    4 ++--
 drivers/usb/typec/tcpm/fusb302.c       |    4 ++--
 include/linux/extcon.h                 |    2 +-
 9 files changed, 27 insertions(+), 32 deletions(-)

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
diff --git a/include/linux/extcon.h b/include/linux/extcon.h
index 0c19010da77f..685401d94d39 100644
--- a/include/linux/extcon.h
+++ b/include/linux/extcon.h
@@ -296,7 +296,7 @@ static inline void devm_extcon_unregister_notifier_all(struct device *dev,
 
 static inline struct extcon_dev *extcon_get_extcon_dev(const char *extcon_name)
 {
-	return ERR_PTR(-ENODEV);
+	return NULL;
 }
 
 static inline struct extcon_dev *extcon_find_edev_by_node(struct device_node *node)
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
index 72f9001b0792..96c55eaf3f80 100644
--- a/drivers/usb/typec/tcpm/fusb302.c
+++ b/drivers/usb/typec/tcpm/fusb302.c
@@ -1708,8 +1708,8 @@ static int fusb302_probe(struct i2c_client *client,
 	 */
 	if (device_property_read_string(dev, "linux,extcon-name", &name) == 0) {
 		chip->extcon = extcon_get_extcon_dev(name);
-		if (!chip->extcon)
-			return -EPROBE_DEFER;
+		if (IS_ERR(chip->extcon))
+			return PTR_ERR(chip->extcon);
 	}
 
 	chip->vbus = devm_regulator_get(chip->dev, "vbus");

