Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03E5C48651A
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jan 2022 14:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239405AbiAFNTs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Jan 2022 08:19:48 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:14402 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231453AbiAFNTs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Jan 2022 08:19:48 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 206AjbEo012787;
        Thu, 6 Jan 2022 13:19:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=vW3WXXw+zKvgHiFDAV27a8c46g1XqzrgXu4WCa/iABg=;
 b=XTx1P/Y/r8LaD5Iua2BDXtC81AZxt39Oxpgt8/5MsLleAQpw6hNMEcVuG/JB9DALsKWZ
 fum2nlM7Iqgz2242di2ofb43uN2VycBW5D7FHXNrRgYS2JMY59AwfGuTKicmixdtHkBi
 S7cQ7iilUyRc8IiZRztxFWcUxVC8GTwgDxqFT3z2SdrUG02tR4wBzRklcznF3R+dkXFb
 89MiGyJtIbA/sTi5ulvmZSoBEpPrjwct67Iw+7uB7hqRjkyw87JrT6Xx3vAZjGeaA/fc
 vwmXLQ2vb/VC9fMf5600eelHU8Q0TvDpbpXvj6qZqrgmL8fxybqcd2Ul9rXGAmxfGQpU kA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ddmpjshxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 13:19:46 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 206DGBvj053970;
        Thu, 6 Jan 2022 13:19:46 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by aserp3030.oracle.com with ESMTP id 3ddmqhk00w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 13:19:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dnYy4vbZmgxzgmfshPTKMdHJMWTcpX27FzdwS1sTiQYIpZIpCxlwFuHPBKXlUToDvwaHueDHjlVVwKN6v3YFZASFctt/h5U/9swxPqtgSYJ9CFHUkrdDYUR1HLc8qjGvByhNVtKs+kQFtaljdQyRbBvkmbKrl8URdJdXWIZGH3f5S3qK+Est5tNguAU9M85YvCNpw99VcViBXxI4t4ONFOUGIjh2gFXFmdw1XBtKjGnxYRDmny7uEuyyaiILpIf1untL0FpalSy7UjoBRwr/HUCJEF7WNqT8gfmr3Jy0nKtWcs5B8ozjoqfIPwedUwrhbEAJdb0K3kvX7Qgsm28MwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vW3WXXw+zKvgHiFDAV27a8c46g1XqzrgXu4WCa/iABg=;
 b=YD1EHgBoxUelds0gcu8SQ3Xdvhpu9sZ25/kF+2ajop+ap2Brw3YDlmCWl9xROZ8D3xbLXYIVlXIv9uDWURy5UHBaVxauOHm7hg5d2297mw7nKiYardtSO25SM6M5tqM2zg1J4KxCMw4Z2zmLmveL4EDn4dBBal+mDVszOMLnL3/d9tZEw8J0w5zXTkA1hHjdep4mudCdNk1dRTWwfx4Rmn39qwqS52KOGdOX8Ej5cj1opCZpDLC+kX4DdaknYSS4Syqx4pb2IKN4WLPelFgeCY8soxjwnw6USDlHYS7WUsq82rCtD+ejdIlz5iktt4F6CJPQl+DnEEhVqypW2bYOtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vW3WXXw+zKvgHiFDAV27a8c46g1XqzrgXu4WCa/iABg=;
 b=Px2qhE/Q8YtFfq74lil+D1VmlR34YdDOa9msl4G8MJ0FlpFCey3qwvslU2y7a1TapyQl9W3FHjFTS0lECYynx6ClCFJHQFjMsHLQqXZCggu136reoTWZt4C3atJiD69XK3RivM8NW9eYH28wy6VNeO/53ih9JFhw8hnxrghr8lU=
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by CY4PR10MB1942.namprd10.prod.outlook.com
 (2603:10b6:903:122::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Thu, 6 Jan
 2022 13:19:44 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::38cc:f6b:de96:1e0e]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::38cc:f6b:de96:1e0e%4]) with mapi id 15.20.4844.016; Thu, 6 Jan 2022
 13:19:44 +0000
Date:   Thu, 6 Jan 2022 16:19:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     linus.walleij@linaro.org
Cc:     linux-pm@vger.kernel.org
Subject: [bug report] power: supply_core: Pass pointer to battery info
Message-ID: <20220106131931.GA32698@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0034.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::21) To CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c1d074c-04b7-48e5-b2b9-08d9d117339d
X-MS-TrafficTypeDiagnostic: CY4PR10MB1942:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB1942436826A4CE7AE62B9C638E4C9@CY4PR10MB1942.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U02W8cXvlcGfdMK0y56ZL3cNAznm7/SMnSZ7jx0IRHoRaLEs9QmskA2Xm2qQGaZXenwZmA4H09lIiwEqId9YWxYVKKRcdS1wEFUGlK6/rFFK9nAU/n/JpUzJcOUl+kXbdpdrpSA/cMa3NZ+jrBLxVyzgXb9xJ8OOHneckavoQdqR09j9jdwVR9KLESbQ1xzQmadlL+mgZw6WW1UzXjtEryV7ojDdL3iyR2IFv/fM5kiz9ZJ+AYrRVwWD6OIBoh5moo4kTuEBzg/AKLTTxUYxNk9BxWyb44cIz584z5vssf5pbpoNojv/7KAOpGpXZOBH2xNDDYuPVHtZdvExN7b5PPie5EPTimRSznm5TGnbFKhCWUB9HCMJRXMreQW3OXt2Ii8fNO/1wn9c/FGaeSkVsz6EHsrAjXIGeXq7AvodeCbMoSQ7zBdlwttVp5WEsVaZzqBv/wiLrZfPJcXc/Vabs2TKieRckD1tNITpwoAl31cW316BucXvbQRV3oCQ74Ed2xjRLsnnxLCcRb6i1DyvMWX/ZDCDVHyr4VNSV7QhSq15hBsn3ngWVUOH8XP+/cGBGTDoGCelI4jtNehnZUJJR80XgEv6GH9NjMybRa08n23UIeggLLn6Jt3cMus/TRN+x2Jgxxn/Bj7yhsWAF0E2Sgsx4pdcGK2HJSd7sOUlvqpwEFnqBeNZUq/Cly5j4jgjnH3P0kEIJBhMdRUsXJOsTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(6916009)(33716001)(86362001)(52116002)(508600001)(66556008)(38350700002)(38100700002)(6486002)(44832011)(6506007)(1076003)(4326008)(66476007)(9686003)(66946007)(8676002)(6512007)(8936002)(316002)(83380400001)(26005)(5660300002)(186003)(6666004)(2906002)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fz3wDJz66/0kNoNU7Azn2bEjxfdYLUHehbsFnH9jm3IwBasYps0zarWIPHCy?=
 =?us-ascii?Q?I4NuA+kgf/PDlDdwFdElTOXr5RVamevzKl2Jq7XOfj9xU2U2NPazS7j5G9BL?=
 =?us-ascii?Q?sxeDdJQlIR8Qo35XGAC/N8DBEP/c9DUxddNK8749D7I6k9nb1tbDinVdj84Y?=
 =?us-ascii?Q?9wMoqz5o0///Hskpo1Jht2U46TgoDEOsRTrK6u0jpmVr8HXTI0OOPJmJ48W9?=
 =?us-ascii?Q?UuTP9y5InOhOACrFyQdCHqbYLuAjO4tqj8G5k0TOhuFc+Gcdn2MFoZNd8Uxj?=
 =?us-ascii?Q?TZM9zTc0OVmLUIT8ZzdyybQFMW9uOHHcS3Xp71Qdq12m1MgDmSUjRSd0odXr?=
 =?us-ascii?Q?a9rdA9GWeZh27t71nMU7XVJMJLCp021fhFsstWmXTizOTpGkMC0vwc7dwjmE?=
 =?us-ascii?Q?Nffj8Xv5pjWNWTmHFuDuJgJt1h6eCr6J0fenikFpKLsO3A+WOv8r9bNQ57LP?=
 =?us-ascii?Q?8hnrnw4ebdEoo11PvHHdlCt8DiNN8wx8OXhf9dsq0Fk7eUETmKANApoOjU6T?=
 =?us-ascii?Q?2HXYRj373gpYLuyqo8HtLZkMAn4NzKM7xi465STbjHKjADUGKrJNBSX4iAOs?=
 =?us-ascii?Q?QeEac1GfAjXI2F2LR1Nk+QIlg94Ubv6iykTo9Fb2ea39On3u1f3pYS8RThJF?=
 =?us-ascii?Q?N21f9HqcyIUHR4C+TvpDVY51pSrglrSUdzD/A8Rme9RuwddzZK+aF2rI1f3d?=
 =?us-ascii?Q?DGgcd/88CuHw50Om6l/kf0Y7WD9oM7pYFBFS8XiB4HTwLCyXU5wZXuYIOian?=
 =?us-ascii?Q?5PNpIBPpRFUi0Wojk8wJjb+ObwgAX1L1I44aSoHUpcMx0dBomEFEiYLUK9br?=
 =?us-ascii?Q?cK4p9lMh4em9PhnGedtT+WpObVIP5+tBOdLfgSq1G4MtHcWvs1wh6W99S2+b?=
 =?us-ascii?Q?hu6e6toeD+hH2ZWraw6K6guMZ6I5caWzxhISbVhTSUKk8tKhG6B59uBWwjp2?=
 =?us-ascii?Q?Y5TYPRVRjHjiMc9KHe6uyAnOTzWB/7ZI9iDRkfms1XNERjglE6xvKVW3XkNy?=
 =?us-ascii?Q?ZByoTgL/Jw1zYOVJIJNkkVAV7nNPuCIndB5YvHIdyaKeHs3M5W95Tjw/gmwF?=
 =?us-ascii?Q?cAURMGa5DzVVkzdx9McHVS4S9RBNxKshVmzgZggzEcLI5L6XBbGAeBlD4B1L?=
 =?us-ascii?Q?F5OA2kUA0zZwXqs0BqO11apkDzhJs2SvWyUqsHRkkl9K4cdLbjwyDfl8acaJ?=
 =?us-ascii?Q?9hyC9leMKYGS+aDM86kTKQlPE6dmgQ9A194F6x2t94Mm9PBzKYwlKl9nkprt?=
 =?us-ascii?Q?abSyHJRx77CMKvoY33YeyCZLIzmXauIaDaJIbkdoSTE253bHgIeMOmBbCE8w?=
 =?us-ascii?Q?wlikYbwiyHyKg+iPu7DdXvwon6OALKl1ygQ5PD/yfkWxkioz7hk+SkahMclG?=
 =?us-ascii?Q?PDt0ouYonyK6SYJhwzB6PvthTDloucfGQf6FkJ+HUzS1u14pd7ZuiWmy9Qq7?=
 =?us-ascii?Q?Gk9LzOMeSNGqydpDYiJ7biWn9bVNWK/x2c9ctwPjxW2/Wf7t0NPuO1i/eYxM?=
 =?us-ascii?Q?qXYzUFq2VARTbcQHVSsl6WzLmlmLals7MLfW5OEsog6kD3FpEU0TTY6FGKmN?=
 =?us-ascii?Q?YhNdhaQEpimThyWcmmUtF+Z5tU73nCpohte131Nqs3HlooKvYAgtAb9P6zon?=
 =?us-ascii?Q?aXYY7IYfByKGeATpybi8+sBcIbFTOGrwCaJHv3OzufJ8Be9o564/zG1GsnZE?=
 =?us-ascii?Q?6MHA2LD+zu+BfJkSEuoBU2Iy27o=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c1d074c-04b7-48e5-b2b9-08d9d117339d
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 13:19:43.4592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rzErNrRfw4aTouy91du+tKi3c0fGOROjjChPzxDY8D9CiVTQYzkfJmiAZvegyOnYyJo5IPg74tOHMljkWa+TgL6ia2Ii/sGT00STHemoWqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1942
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10218 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2112160000
 definitions=main-2201060094
X-Proofpoint-ORIG-GUID: jPZUkCVvlks5fPVXC1j1u3uC_uWFMOxM
X-Proofpoint-GUID: jPZUkCVvlks5fPVXC1j1u3uC_uWFMOxM
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Linus Walleij,

The patch 25fd330370ac: "power: supply_core: Pass pointer to battery
info" from Dec 15, 2021, leads to the following Smatch static checker
warning:

	drivers/power/supply/bq256xx_charger.c:1529 bq256xx_hw_init()
	error: potentially dereferencing uninitialized 'bat_info'.

drivers/power/supply/bq256xx_charger.c
    1505 static int bq256xx_hw_init(struct bq256xx_device *bq)
    1506 {
    1507         struct power_supply_battery_info *bat_info;
    1508         int wd_reg_val = BQ256XX_WATCHDOG_DIS;
    1509         int ret = 0;
    1510         int i;
    1511 
    1512         for (i = 0; i < BQ256XX_NUM_WD_VAL; i++) {
    1513                 if (bq->watchdog_timer == bq256xx_watchdog_time[i]) {
    1514                         wd_reg_val = i;
    1515                         break;
    1516                 }
    1517                 if (bq->watchdog_timer > bq256xx_watchdog_time[i] &&
    1518                     bq->watchdog_timer < bq256xx_watchdog_time[i + 1])
    1519                         wd_reg_val = i;
    1520         }
    1521         ret = regmap_update_bits(bq->regmap, BQ256XX_CHARGER_CONTROL_1,
    1522                                  BQ256XX_WATCHDOG_MASK, wd_reg_val <<
    1523                                                 BQ256XX_WDT_BIT_SHIFT);
    1524 
    1525         ret = power_supply_get_battery_info(bq->charger, &bat_info);

If the first allocation in power_supply_get_battery_info() fails then
bat_info is uninitialized.  (It's not really possible unless you do
failure injection).

    1526         if (ret) {
    1527                 dev_warn(bq->dev, "battery info missing, default values will be applied\n");
    1528 
--> 1529                 bat_info->constant_charge_current_max_ua =
    1530                                 bq->chip_info->bq256xx_def_ichg;
    1531 
    1532                 bat_info->constant_charge_voltage_max_uv =
    1533                                 bq->chip_info->bq256xx_def_vbatreg;
    1534 
    1535                 bat_info->precharge_current_ua =
    1536                                 bq->chip_info->bq256xx_def_iprechg;
    1537 
    1538                 bat_info->charge_term_current_ua =
    1539                                 bq->chip_info->bq256xx_def_iterm;
    1540 
    1541                 bq->init_data.ichg_max =
    1542                                 bq->chip_info->bq256xx_max_ichg;
    1543 
    1544                 bq->init_data.vbatreg_max =
    1545                                 bq->chip_info->bq256xx_max_vbatreg;
    1546         } else {
    1547                 bq->init_data.ichg_max =
    1548                         bat_info->constant_charge_current_max_ua;
    1549 
    1550                 bq->init_data.vbatreg_max =
    1551                         bat_info->constant_charge_voltage_max_uv;
    1552         }
    1553 
    1554         ret = bq->chip_info->bq256xx_set_vindpm(bq, bq->init_data.vindpm);
    1555         if (ret)
    1556                 return ret;
    1557 
    1558         ret = bq->chip_info->bq256xx_set_iindpm(bq, bq->init_data.iindpm);
    1559         if (ret)
    1560                 return ret;
    1561 
    1562         ret = bq->chip_info->bq256xx_set_ichg(bq,
    1563                                 bat_info->constant_charge_current_max_ua);
    1564         if (ret)
    1565                 return ret;
    1566 
    1567         ret = bq->chip_info->bq256xx_set_iprechg(bq,
    1568                                 bat_info->precharge_current_ua);
    1569         if (ret)
    1570                 return ret;
    1571 
    1572         ret = bq->chip_info->bq256xx_set_vbatreg(bq,
    1573                                 bat_info->constant_charge_voltage_max_uv);
    1574         if (ret)
    1575                 return ret;
    1576 
    1577         ret = bq->chip_info->bq256xx_set_iterm(bq,
    1578                                 bat_info->charge_term_current_ua);
    1579         if (ret)
    1580                 return ret;
    1581 
    1582         power_supply_put_battery_info(bq->charger, bat_info);
    1583 
    1584         return 0;
    1585 }

regards,
dan carpenter
