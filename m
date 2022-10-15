Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03145FF925
	for <lists+linux-pm@lfdr.de>; Sat, 15 Oct 2022 10:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiJOI1V (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 15 Oct 2022 04:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJOI1U (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 15 Oct 2022 04:27:20 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2862E3A49E;
        Sat, 15 Oct 2022 01:27:20 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29F8C0LX012272;
        Sat, 15 Oct 2022 08:27:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=6Lv8G4+DoRGZnojy4aZlNlqEY3NiuuYII0yl6e0dPy0=;
 b=xU5pSULTbnr8D+ljyZHxaJyqu61sabruNUE7UVkne+RYWuLu00Y3HUNGXkeTRRIlo7Sl
 VzzTagZx0lSrw8MFpv2sbK3lCbyJLQtBPZyqGFtPHO1GyMRPtNN7Fxjfsm+OE8IDWSYu
 F0QcwSttMVQV9j9Y5tm2LZqZRP/hG7XK8ZYyhFh7Jp4QnPTH/MykNnH5uedJyljxpIG+
 oCFzN/X67ux4PyqPxuU/tbKO/ug4Jicd12kwD3Yamb6umolU+qeQtFZIjTxYEgD009lt
 mq0HZpfxrcle7Kd2q3ELxmkU2ge5QWSMI1L2n6BG8n3rsYhPsxOvPPFTzWy8LEg0ZCDY nw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7mw3872g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 Oct 2022 08:27:15 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29F3DBxG005439;
        Sat, 15 Oct 2022 08:27:14 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k7ka7vx45-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 Oct 2022 08:27:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IfkuO3JWqJ4DzLZNtYD9ww6CCP9yWj654FY0OMmUKcy8W5XQ8dOZtR+LE0nSeZd7eW9QhxTvYUmZr3FoVeAq6+EjUIvm4D2rIAQuvWOyuJ2LcdTNAnyxuCDuyV0mzy6GfvCc4XK4X+3RWfCmJYx1xOFk9DBT6jSqJR2iHXY7zLHxFFpHaJeCPt7l8HYSDMivfkxHneCYciNrRUB5KG+9IUZEuWG/JVBPCnS2Cgd69Z/x9qQoG8usr6eTthoGPIlUWmuC25ZjuBTxeF+OzurImMxZfPvgtsimQgWGi/YLkpE7nn765V/NYRaBC8clcpWTnxBb1M1mYfNfDPjPurhC9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Lv8G4+DoRGZnojy4aZlNlqEY3NiuuYII0yl6e0dPy0=;
 b=RralulRjgJr/mMazJ0FDODbp0iykq1vycVLauj5ksq25PwQ6exOZZWA2NRkQ8ubYzz+S2gf2y4UYCenJ7bWyUPIlvz8XQqei3jW4IRg+x0jJhEgd0RM1BQfzgs81pbHOlQ0NqYz6oxvWfAKCsPGcbg9Ou5WIkiQtUnqgTsVgANbX0zH4/G67u4GIoKBZ9DJkR0xSXlWxnNWP4W4+d4QnHXy6nRCFsUDq9FshN7o4xhYzLbRa3/Rw+2nXHJKRVChEFjdUVcEVwa7nN/8FZ6cN5xKdvjADxaIN4xnJJOfQxifZJ5veFPi9BfL9TU1jEyh2TPZlknayZIDaadzi+NUSkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Lv8G4+DoRGZnojy4aZlNlqEY3NiuuYII0yl6e0dPy0=;
 b=Cswzmj03eZ9RxzSsRsJMudmZIeAC30onxjN0LNs4gjL7eQFv9lRWDfcHN4etmJMtSZI33TUs9/4S/YX4LgsOhOVKI0Gf8VPgG0THpv4JFQ76Gx2QmckRtpU37WLccGn5FSc01z/hvwSOTn+4+m3jzN3KLBRfk3BA+3R+oFGsgm0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH0PR10MB5595.namprd10.prod.outlook.com
 (2603:10b6:510:f7::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Sat, 15 Oct
 2022 08:27:12 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec%4]) with mapi id 15.20.5676.031; Sat, 15 Oct 2022
 08:27:12 +0000
Date:   Sat, 15 Oct 2022 11:27:04 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] thermal/sysfs: remove unnecessary check in
 trip_point_hyst_show()
Message-ID: <Y0pu2M6kKzIlhCMw@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0082.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::15) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|PH0PR10MB5595:EE_
X-MS-Office365-Filtering-Correlation-Id: 10b7d9fc-993a-4b95-676b-08daae870ee5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4ptTEHgEUYDgw3fCcXDdp4eynDpsH6yiPoy9VmHmhfnMhHDNmHLyx1hPKvsicxyKLb/rgfnbP4PF38OPj7xUUelEbAYN9AhXZaUHADXSMwqA5hNoFK1xZo/dPMtKgAbLJatUE9kyfBUA+u0acn8CXts8vwhrHMM/0V+E+TOVRpJ0lolhkUwUhxqpwy+xUK74mKuqMUnpP492TNpU0o9XH+Y79V8KG1L5Wh1fNtS6OpA91T/8jJN9li3666Mu9MTvYP5N9a4jNW7NJ302Tv56c7aO4a22N3XzhgA0B1WhZ/KGB2LRFM8p/gBBvhyf7MuGGoFI2xne6mLtozRNcds5FUcS+2xeegTG3xNPtTo9Xx1GlhK1DWYA91aD6GWc4Hn4nsZ7RItIed0zziA+S3ElDH7kpXkngk7GHHzSFrauMiGWkfqjxA12IePEH6i2MJmphU3f0Yhx+UEOp2iJxiJrpKmP7VhVhyN2mhK+1l1yEV4HIYHTmMKbNrRtaKIy9Fy6qrBAO9vl5t+Pdx0ZP19v75pDDzEfU7Lrq2J8BDhllbkm3J9zQ9LO6+9ZcjleHqrmBRQIyN33+ZyUk0iSwfa4ECqr+hqQhj3C+0zoy+mqaHp1C9bkAlkGwCr9fcwB3tbI2liHQ4Vx7HBsO4VlNwwMVEt2bg2Id0MUrP8z1PKBc/RvP9CCMcn5gvHAvAfNPGZC3C7VbkmCI1ncj6yJ2+7C1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(376002)(366004)(136003)(346002)(39860400002)(451199015)(66556008)(54906003)(110136005)(8936002)(38100700002)(4744005)(5660300002)(6506007)(186003)(86362001)(66476007)(316002)(8676002)(9686003)(6666004)(83380400001)(4326008)(6512007)(44832011)(478600001)(6486002)(33716001)(2906002)(41300700001)(26005)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PEIVklqXeKzbSavOixQYNxoaJQepARcRqgz/QQdeS7B/h85XAFSkqm5WMvT1?=
 =?us-ascii?Q?r87Ogc9PXOYw02gN7QD6VlyWBmrYkkgpX2OOydv64Qlb8b0Z9n8hvv2in6ir?=
 =?us-ascii?Q?PZVWBkjZ2QU6sTDNyaxm65BDcBaKkDeaZI4+bLjCDdD3gK7V+U/fWRHxpXTj?=
 =?us-ascii?Q?RxmvCN9p9bLLI1+uAlcvJjbZbciS2myUlW0eoKgoq7tgcbGipIt0NBE6Wtam?=
 =?us-ascii?Q?0x4Y4Qoa7cS844QcST+ZQOdM0D0couwI9UE8wqdO42eScwCyV9Rl/ZA09/U6?=
 =?us-ascii?Q?gFeCw19qL6rOLsOGrm8zoQgHjViLKOdJ3XRK+l6Br3UqKB7Qf+1sIpu2ZEW2?=
 =?us-ascii?Q?EjAUtf3WnezB1GFhD9iLvO+H1fGCiIak+HtPlmu71M4pOFD7QLq6BOFjPXVK?=
 =?us-ascii?Q?hKIE87eiTX8/jivtNNrOU0t1AgLYNYSeJxbiqw7+MDXcmB/c+pwrFB/fS7f1?=
 =?us-ascii?Q?JxtfbpuoymGeX3sTpASzTlQGOsdiH4tV6CvgRoiz/4ujfuMsHT0lD6SjSLZR?=
 =?us-ascii?Q?GkzDgj+WtdHh2TsE3K545mYvP7rP5uV9qQNd4pcZWlfMKnRmRlRRsjKySIR/?=
 =?us-ascii?Q?ODSz0TVDkEyPkk4V/V6qRhur19YeEnERDKKtwX2ePc2DEhyBzjIv/A+X+5tZ?=
 =?us-ascii?Q?kfKSFqi+UKxJvKwnsHJ/2R1fIE7sDBk97M8QzTg/M2DTtqtMWXKNoRve5z4j?=
 =?us-ascii?Q?QhMOYF6Z+9bs2h42hKM4eO6qIusQ0zX8zM0oUINOyl28kOjkK9U9p3zjyxAX?=
 =?us-ascii?Q?lClLpbjE6502hHdPsP99uNw1KjMTMPcjDLqYPp3fx+kXUEOdsb+wHmHashcP?=
 =?us-ascii?Q?khl02PUl/tchXEPGkjwAtfaRAulxyQd8ONsY8kef3thDOLzDhWjdz1Xt6jDg?=
 =?us-ascii?Q?gf1IpQ8CTUpP8uzvcCbUZWD+64W4T9kLTv5g1TpW+XwqlEEJSVejduYL89Ci?=
 =?us-ascii?Q?kG5a8t6KF296l+6zWzF5wQ+Xi+DtN3dJVqJhfGYnIZdPOKAYcs2orlC9AoPI?=
 =?us-ascii?Q?waO2mTbpFceX7s0TbJ7ug6LKwu2mTGT0v9exheK9tVubM7vSMUrELDMkuwN6?=
 =?us-ascii?Q?bOo2M8P7DFu+jQihgEpQdJT55eDZ5yhG1n4g5D24dyo881qMfmVu/XCXAe7T?=
 =?us-ascii?Q?5SfeIdA6jNmvKF7bGMRhXOHgXa/QnuoXgnCjqrXQl5+NEBmVRewQHSfhSNaJ?=
 =?us-ascii?Q?eKjEfhuPi0GTWCQ6ukBV6P77eMLRa7OxIXcZcEipaUZoDdpPFDNt/1v4zhg/?=
 =?us-ascii?Q?nZaJknHa9VKL+oAzZgoD7n8Z4ksNynRMMZqUsq1GM/syn+TQlvS12u5vLdBl?=
 =?us-ascii?Q?KLszbaHsyZtwZgKbuWGRgTso73JikBSe6VpCBC87EuNbtCtOskdZAxjCagmG?=
 =?us-ascii?Q?1ZurzGPBi0VvlYIDdDilqXDDCcVZ1DAQfcTKg/gQfu9/IBB+RVVTxNrFmrfJ?=
 =?us-ascii?Q?yFlgiYFGOEuI6r/D9CW/MDq3m/ZqpysfqMbYswjYqqI1S/rRNM1RWOyoCD0i?=
 =?us-ascii?Q?uNCqd5tJulLylWgfZej+eyEYLkvGyZpA2I+RMjbsgpWTX71/fU8OZxkF8X5q?=
 =?us-ascii?Q?8jBc8g4CcfXR3ze2joZba1EoLrtKw2EhdrmPwbcglvHa8RMs34lMQyev8lt9?=
 =?us-ascii?Q?iw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b7d9fc-993a-4b95-676b-08daae870ee5
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2022 08:27:12.1329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0En8TBpGO7SpZkXaZBrTF1fIj5uR648pXOFkeNJFwZHPh72wln2McjRohS3p57RxHUt6Gu5lTyan2yU0TaOJwalWXnmADGKMDuh8rzGP5Pc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5595
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-15_04,2022-10-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210150047
X-Proofpoint-ORIG-GUID: DyPq3Cc_7NExqBY_E5x10Aq8L-N73f1s
X-Proofpoint-GUID: DyPq3Cc_7NExqBY_E5x10Aq8L-N73f1s
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The "ret" variable is zero at this point.  No need to check.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/thermal/thermal_sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 8d7b25ab67c2..af3dced054f3 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -190,7 +190,7 @@ trip_point_hyst_show(struct device *dev, struct device_attribute *attr,
 	if (ret)
 		return ret;
 
-	return ret ? ret : sprintf(buf, "%d\n", trip.hysteresis);
+	return sprintf(buf, "%d\n", trip.hysteresis);
 }
 
 static ssize_t
-- 
2.35.1

