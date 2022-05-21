Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F9252F97A
	for <lists+linux-pm@lfdr.de>; Sat, 21 May 2022 09:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbiEUHFU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 21 May 2022 03:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbiEUHFT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 21 May 2022 03:05:19 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08BB5E77A;
        Sat, 21 May 2022 00:05:17 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24L3Z22b008714;
        Sat, 21 May 2022 07:05:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=4s3jxlwAzhZ5vuFZsz9ZD3a+4Ct2AGrZs3S54Q1ZZ7g=;
 b=wtxRR2y7PVaviHUnik1VY8btDUkMkcG9vvpg5eYNzp8u48r48IGrjEGr9o7NkVrdB2Ja
 5qBa1z4GyiSQBl4+W9SJVRpHT9+EKFLfys9nNTTXjnQTj2e1KE2Vn6petxUgmH8G+elH
 68mqpygehPeu1GOOecISq3VcQ0xmTaxb0oUdgHwFxWq0jjDywtF+lZkWxmGIJQ1Sr22k
 3ydrrTnTLoEMAWo4u2dy2QN61NHNCsqt1KB/H6gO41NIpqURSFZxCWPFeG02JeAPQn3k
 7jFuam7s3FU141KsWcRfvqxqoKmqxde1C1RDFLL3MEKmwCd6BjCqWVkqUjzAO9PEdXeQ tQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g6pgbg771-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 21 May 2022 07:05:05 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24L71B5S033970;
        Sat, 21 May 2022 07:05:04 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g6ph047hu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 21 May 2022 07:05:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=COvcbcnCfIpZWk3pQCrAYyqW4uoq3NzAYBNI9yP9hZ85NPU1g1rqPfcKFKFLrRP3+mR4OmjHuTJgX0VlxuYaN0g8OCynpKVG0Ml7ppHew9erMD7Osd1xRDA55XRZcEaGw0CfTD95kPXqULNoHufbK3+NqSPzASCc8H6c5sp2PE8xZtL2/tw2NOSQKl6ha5H+Hlik9KT4ugODXrbgK02OU9n22SQu8R1ZDXgk+ljiFOWg0oQOZK5bNDi0KD2fnnKsvzvRZzQFkmfXMT5hg36T3AHUV3EzTWOrlFCtr1g1lHip65pG9y2UCiHdMkESMz0fFpBFFHKvg4nWplL8toBxyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4s3jxlwAzhZ5vuFZsz9ZD3a+4Ct2AGrZs3S54Q1ZZ7g=;
 b=fZhRPekENZsYRF5JV9+RHYJmcPam9m3y/3LmZ0JThtyZRepExMtJLIrxCfBPmv2URBKLOHAaCkZa31sILElsifyt+j+p92UcoBxuI4Uwd8mdOPtn9BhTKTPyjck1Tz3m+TJX+lgYd5wPUVUUogi/4KtYTT5q1CjiQnHu7wtZevBPEwwTcETurRHynYT8Yg9rcsJnblKL4Hw7/F5SZVAOTvrHI5THitubjmqSiqAK61lnahPYVCShJQvXb9bxJc1IbxJbnFaXpH/be1vrbppbZbX2NHj26+Wj9EjocSX/XRdtxwT5V935RtZ4Vok0Bo0swktQQrOCTwT0uaCNpGQdqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4s3jxlwAzhZ5vuFZsz9ZD3a+4Ct2AGrZs3S54Q1ZZ7g=;
 b=lQvgoApEVixplR9Iurweu2M0I0TnDf4ryOee8THk7LyIIo9oONQFSpcvLtHcBXeYb1RUvgNChXI2hrP3YbbUK+r7yr4t4gyVsoX+p9GeEIt0sJ5tITB2DkTBoJNeN/iloPFFB51y7x4ym6qR7tJV1cebYkPu5uVi5zNifaUqNmY=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH7PR10MB5816.namprd10.prod.outlook.com
 (2603:10b6:510:127::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Sat, 21 May
 2022 07:05:02 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e%2]) with mapi id 15.20.5273.019; Sat, 21 May 2022
 07:05:02 +0000
Date:   Sat, 21 May 2022 10:04:49 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Keerthy <j-keerthy@ti.com>, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] thermal: k3_j72xx_bandgap: Fix array underflow in
 prep_lookup_table()
Message-ID: <20220521070448.GE23160@kadam>
References: <YoetjwcOEzYEFp9b@kili>
 <3061a9fd-5301-4d91-2d60-b85a5d4910e9@linaro.org>
 <20220521065615.GD23160@kadam>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521065615.GD23160@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0091.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:32::31) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0cb83ac-13a0-406f-c1cb-08da3af839d5
X-MS-TrafficTypeDiagnostic: PH7PR10MB5816:EE_
X-Microsoft-Antispam-PRVS: <PH7PR10MB5816F69C58F9AA70F717CA648ED29@PH7PR10MB5816.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7JzGGKdRBCuWF0iL92fNjFJkBbCK7W2tGUr8qQ6tXCguZl+hRZvzFLLla4FFLkkOotaRa5Vo14YjqwTkfe5IrfLbzYy+NpyASFyh4k0roL2coBqKLgT4oHSorVO9NbhIf8Wi2DCdudF2k7rnzjDM0Jwvnzh6WEhFhM4Xz+MAZawEjFG/bhHi/jrD5qlXlXX5tiPXnhN0BOobz+rFxgndPbavjUa4bpOl4lkku3z2YLN3TuAIrwcKbxi0ZTgvVJTS0PT23R1mqywon6xOW/xM7+ViIz4/rgWMsYNNO+RILI0ZaIQwmRopHgqxfYWoQZjzwseaJumDSHhcEN7RI31WU4sZrgzZEXJbspeBVD33o3qAvkghGKMkJIUla+NGegglmkxEF+yEPdLnNF+0BdhdWiQs3MEbMZOSBj+vpPXWcGf3gF7Qg1VXjgHH6xojLg5HOpvvC4/UgO6TRYRxtksp9xzDS4OhXqck4ssW6GNBt89wM6UKxxhnD+vgmDodpGxjUaRwaZsBOO1IMHg/0+ikIvf0ESe0Id/0E5EooxriFJMQEHvWVysQNJwt3l/1QLqsHntVWwRt0HailbxboC5AARj5niV7iXuws5SDvL6cl9A1gl3n3H3N12EDiw1uw6d5W9pCGqb9+3S2lr8LtHyk7oLR4CtkmcY/P9nXvWkKeEj1upjulwribWS8X7wSCdzXo+EwSq57CjW/dzs8WO+JpcxwH5UXkH9DIfH28w5YaAoDwO1gBmfPbXJyP2T7356JW1wBs2h5u8o8t2JmHFgD6RcDhVo4TdNQ3olvlSFk/7o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(1076003)(26005)(44832011)(508600001)(6512007)(86362001)(6486002)(966005)(38100700002)(38350700002)(5660300002)(316002)(6916009)(54906003)(8936002)(4744005)(186003)(9686003)(33656002)(8676002)(4326008)(66946007)(6506007)(53546011)(52116002)(6666004)(2906002)(66556008)(66476007)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eqab4Y+u+m52/gXmgoh3ISmoSydS5YjlSbLRBafj8vurYmY4du4b6AHoHly0?=
 =?us-ascii?Q?rCExb9zW/WPai57epfhfYi3WBP3wP0A5Ah9/CI9BXiAAD80SsoD+xCnovsqo?=
 =?us-ascii?Q?vizh3cXZmYbhv5NgLZZCPXO1e10z2rmlgpHLWPKtgrRmQOHPRQedcyJ4jFEo?=
 =?us-ascii?Q?d9FlH4hLiodeIxBMs3yB4aWo2f8w03tpObHYkpw4lYNfWGQdAB13JV76f6wu?=
 =?us-ascii?Q?RnCRjFoEpTL55Xp9rWahn5baqVOqID0pG7CpizFt17oyQBM389URwNtjbynf?=
 =?us-ascii?Q?UPLAKZI2BHPWu679GO1NLJg6uB4TkN6nUEwDU95THrVlnq6Xsg+dnNduYcPF?=
 =?us-ascii?Q?ylmpaItLKIMgTiZcGshkU5ShcMGHgBgHnQz28Qk6nJhQ66olOVEb7nW0ncoh?=
 =?us-ascii?Q?kHAgm8Olqlhlbi1FYOJBaMpQGX4B7sA3JGPA+mxqoHL8nQKESVnRBixoOMXJ?=
 =?us-ascii?Q?bT7Hu+6d1qyNt0yltozUziRF3naaKUyd6CYEmJ+fPSKm6kPuAU4ZdLq/xuGU?=
 =?us-ascii?Q?1V7u6GlZK++KEFbMDrBAD/lfk57csKW5K9YCd6PWaG7HVxAVSEmIANwq2GAu?=
 =?us-ascii?Q?ae1oygI75vlbQ0reWL9S2v8lM1FtloOWzZw4yEwKo2/daC1ZOmb+lH8g2NDh?=
 =?us-ascii?Q?ZiUq92XpVbrQaJis2HalZ1qTvzuCt5Sc9bHu82qsVWycFDs+j0g+LNEmNKfL?=
 =?us-ascii?Q?bBe86QU4TjtAocG8RQ6rNSIzqoCfK+T9P99mwsMBbauQNm/0yUdsu1k7Yro5?=
 =?us-ascii?Q?n/Hz4bBXrmcwqMt307XmXGZtQu9uJ1CyPiXFCWcEfAF7ZHr+iLogWDG+LB8Q?=
 =?us-ascii?Q?7Q/5MpBjHbp0UKj+Sevp6Q/bd+rGZHNKRau0jVpU+5g8Z90hY8Sgzcm0MV4k?=
 =?us-ascii?Q?j3cXdRgRdz5jimJFD99sjEUURm4U70LE3dJG+AGaAD5o2YeGX17YzpnXjq3o?=
 =?us-ascii?Q?eaDxBAvfBx7zjZzEjT7CeFNLEfsQIMfNe7RNzR1MGwt9NfhCasvT873+Z92M?=
 =?us-ascii?Q?geiru5/XPO2agpzwNMB4L0YU93oCksyansYZLinj2mMr6fWCYc3gk7TM+P9x?=
 =?us-ascii?Q?uTaR9OUTH2tbr6zu9dn+K+8t1ikaXfNfiWulHvCWEVMPdrc1VuE+iDSQLX0f?=
 =?us-ascii?Q?p29wyVqNzoApRRI1zzDuS9B5oOF+yIhYY86/ZtQX+6Y6w1svR38uOZx70Qax?=
 =?us-ascii?Q?ZBGlLBBrNaxAeDFSNDeGJ9/VMGB3QHltQCz8vZ0locUidqDUlnl8/Uu0J6/2?=
 =?us-ascii?Q?ywzeto6V3e5VZZUjWoFmBZ7FhGsnljjvpZEFufHcUs2fey3eM+IcaHGYJ18k?=
 =?us-ascii?Q?FiRra6QvToQ0zNI4gJgsQzBHMPnlNO3eetgSEah1qgfOI5GFztmAc1BM6aNZ?=
 =?us-ascii?Q?/MjfWl9Hd9SzcBZY4p4YB28kcUipJMdL+RvpmvfHACeUheF9hbzkXzORpUgJ?=
 =?us-ascii?Q?C6QzvkWGdhAE/FzWVRht1wIqGUOuFBrMFNot8TnyujP7ivKhd5Z0N23u6tzW?=
 =?us-ascii?Q?yQho610W3kyDIPLIN+K6+hdzI5MCZmPWmRBm5VwJDrGCXoYgyqXQ5L5lLnuc?=
 =?us-ascii?Q?3uC+92hSOWVRsqsOALWa5VU+6K/gIKbOZLRlhJA8uJp+/sBa1UBmuFdrJeEm?=
 =?us-ascii?Q?4Zj1FkzMvmaCgz88dbamwyoVO1+iKzEMRVWqrT8VTGzuIFQDN4dZERabjOsa?=
 =?us-ascii?Q?EyXBiGu4rYVkfgADrNWmo6EzDc/JkrFymBrZxnWs84/IjslCGHhxJDACKj04?=
 =?us-ascii?Q?lOJSJRQWPfts2rCOPE5Eb+faqQ6y+t0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0cb83ac-13a0-406f-c1cb-08da3af839d5
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2022 07:05:02.6238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ijhD7V9u3B6B7unWkirbnUhSsVEn0P4dn5HlGsXSR1bFq+2zRA5/mEf2et43pZs1ICK5XLMaEtzn6RY7P2mjVGyVALSj7OpvNBFU6imJVGA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5816
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-20_08:2022-05-20,2022-05-20 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 malwarescore=0 mlxlogscore=983 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205210039
X-Proofpoint-ORIG-GUID: oUWXOQP7Xi10VULXoFigcBawbR99rmXi
X-Proofpoint-GUID: oUWXOQP7Xi10VULXoFigcBawbR99rmXi
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, May 21, 2022 at 09:56:16AM +0300, Dan Carpenter wrote:
> On Fri, May 20, 2022 at 05:25:56PM +0200, Daniel Lezcano wrote:
> > On 20/05/2022 17:02, Dan Carpenter wrote:
> > > This while loop exits with "i" set to -1 and so then it sets:
> > 
> > Won't it exit with 'i' set to '0' ?
> > 
> 
> Wow.  You made me worried there.  I had to make a test case just to be
> sure:
> 
>         int i = 10;
> 
>         while (i--)
>                 printf("in %d\n", i);
>         printf("out %d\n", i);
> 
> Yep.  Ends on on -1.

I wrote a blog about this a few days back.

https://staticthinking.wordpress.com/2022/05/17/i-or-i/

I really think the most readable way is to say:

	while (--i >= 0)
		derived_table[i] = derived_table[i + 1] - 300;

Some people like while (i--) because it works on unsigned variables but
that doesn't apply here and "unsigned int i;" is dumb.

regards,
dan carpenter

