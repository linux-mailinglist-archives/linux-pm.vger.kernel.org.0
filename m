Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1241E339A66
	for <lists+linux-pm@lfdr.de>; Sat, 13 Mar 2021 01:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbhCMARm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 19:17:42 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:45462 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbhCMARa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Mar 2021 19:17:30 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12D0E9bn021646;
        Sat, 13 Mar 2021 00:17:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=NGwGTVdIoEvXMNhp7jOE210/sxelHB8z6X+d9fl3OrU=;
 b=gOGyS3w5SMOWfyEniioa/o+1uPQZyA+x67e3KoIaHxbUQg24bADlcQS0qnntwDJY1KzR
 8BxSY+kxeSxe3B/HNdFb0mi8xeQQli1OLCatcMhh1qoDj9lK2bOnkIyUNWKn2NMlGiMY
 OVGm3nVIVldewiVO682gLhTgiM5jzBsycdXMhyZ04mlDxvJfa7q+iXryugiXZCYJaT9r
 KpSMUIlqiqPpVNPd26MlJPExG0qGykQZXVBqFhJo762rwZtiIzVjEaPwCPt9Qi+790/I
 +fVQkYfIyRnw9XworrXKruWEVl8zev7eweUplM+IAKV98vbZELsDW8GPefArW07Q4JxT 2w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 37415rkkxa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Mar 2021 00:17:06 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12D0FdmT115469;
        Sat, 13 Mar 2021 00:17:06 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2051.outbound.protection.outlook.com [104.47.36.51])
        by userp3030.oracle.com with ESMTP id 378jgt8vjr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Mar 2021 00:17:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=icEX8fCy1qoIm+fB0aSbLn4r9vsp9ElhhE3K8JqTSx7XFbn+4KdB0G4Nyvm1q6NXG+5qQo65sF/bEJOBm8JpeX2vFM6MWkJBoS0gBXqTI3e0AdApVHedUyUEMwE2L/K8PUgnVAIfPWN3c3LX/AggCS5P6axfellmZHE6cD6xT0cE7NQkVRSi0Iu1e6ypQHuvIICk0ChbHceOlOOdqmfaqayxS+QsMzK6p3BgD9O2iiGYTZV80hBLMIQhQzlHLVZ47clW0z/JF7/LrkCWglMs9ObmhBdPqbZ2IeifZDHxQDIZxEOLgzh3/U1R3Y14PPONrzc2yaqfXEGFLdmqbs3ZVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGwGTVdIoEvXMNhp7jOE210/sxelHB8z6X+d9fl3OrU=;
 b=WTNQKtu5ynj4g5KMDNOuzHyAC4JCiG+baGTWPnkb8GXT+k02UU8GOj2WInbPLFdBfJo63US+Zl5pdXJ59eopIvuKyeXR0Z8uhPlHc2hMGydPoXnBHMTYQ7h/3H1MgQRyy338CFnit21T0KDhrfqwSM0ZL/SvoQD2MNvNq3i4GsLTolvsq1XCAvvE18r46aAgEqMiUNLbG8BNKAG5gwOy+KG3nnC14hJLF9+mvAPfeU6c3CNotH3mc11R1zcqWl+Ql6/7h/TOxHV81wR4Q7Mz91iZz9Zz7cWJnREjU8WnuYJr7P5WBV+Q8enRjjo5wSbAX+tRPoQRUR46tLUJr1sjug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGwGTVdIoEvXMNhp7jOE210/sxelHB8z6X+d9fl3OrU=;
 b=WiOhdSaEK/QhmCVzBlpRsKtHGeXt0lmSSeUAVMk1eBca4Syb56pPpn+ALKC4pEqcwWshBXhmSNTDJrte+aA+Npnn7S+BsArY42jegseviDP9XqjQrvfzum71rOGMSeUxk/L+u/9qElxBN/LDC5PO5siFulBxF5yUVCu9PQkMLsE=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB3794.namprd10.prod.outlook.com (2603:10b6:a03:1b2::30)
 by BY5PR10MB3746.namprd10.prod.outlook.com (2603:10b6:a03:1b5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Sat, 13 Mar
 2021 00:16:16 +0000
Received: from BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::21a6:5c60:cd6e:1902]) by BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::21a6:5c60:cd6e:1902%7]) with mapi id 15.20.3912.031; Sat, 13 Mar 2021
 00:16:15 +0000
Date:   Fri, 12 Mar 2021 17:16:13 -0700
From:   Tom Saeger <tom.saeger@oracle.com>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org, krzk@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Subject: Re: [PATCH V2] cpufreq: Rudimentary typos fix in the file
 s5pv210-cpufreq.c
Message-ID: <20210313001613.j3j66pvmfzxznw5j@brm-x62-17.us.oracle.com>
References: <20210312232621.2083-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312232621.2083-1-unixbhaskar@gmail.com>
X-Originating-IP: [129.157.69.51]
X-ClientProxiedBy: BYAPR05CA0054.namprd05.prod.outlook.com
 (2603:10b6:a03:74::31) To BY5PR10MB3794.namprd10.prod.outlook.com
 (2603:10b6:a03:1b2::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brm-x62-17.us.oracle.com (129.157.69.51) by BYAPR05CA0054.namprd05.prod.outlook.com (2603:10b6:a03:74::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.11 via Frontend Transport; Sat, 13 Mar 2021 00:16:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ffe6d31a-2b20-42da-9e78-08d8e5b53761
X-MS-TrafficTypeDiagnostic: BY5PR10MB3746:
X-Microsoft-Antispam-PRVS: <BY5PR10MB37467ABAC8566192A40758B4FC6E9@BY5PR10MB3746.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:510;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6BZ3o1vXemxNv6faL6GcBRXSUvyTXJ8tufrDognlYpXCtMv1vPRCX6zcfG2SivS995PsMX0VbjdHzCh5n18hMgqiL8t+y5yPa12PCJVVc/rs1v8rYILKipBALqjyMj/MW/1cBd06nYIJGbS8N01C/NvNS+h7j2I39aWGBCDe74ZAKDn9cJtHCKFCq4Mf7SLZXlDOLWhs+TX8jnK4Yd3cPxRVFmkjt1j6CN7XZs2NU82kTibd34iCs5YfKn6VjQey2a4uyEblVo8msp/1dVwg8JWWdmpkLQVZeBeQc9MdQ8CtdpQIPtuRXATBqNtGWF0v8qIRzeOrruq3DgQ37B+1Oj+TuNOCJiRMlg/I1lBdrDZonb8MmYf+22tvCnIWSvPkhW1tWxqdR8yreShCSuTPwR9Q4NE/0UMv4ascYrS9p2mSZJs3LFFWyZ2NfFl0GlPT0gDmYfcojOkrk+M3zkAyiABTwhbETfAg6WS+puKxNA0gm7/ldabuHsTwuWs9MZQCQXwaqtyYdoyWCyCgPKZBpcMknYYZ8Cl3xAc2CRPNuglFsvnTr1RnNCCJlhwchSxl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3794.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(376002)(346002)(136003)(396003)(55016002)(7696005)(16526019)(316002)(66556008)(8676002)(1076003)(956004)(44832011)(558084003)(86362001)(5660300002)(52116002)(6916009)(66476007)(66946007)(2906002)(8936002)(4326008)(26005)(186003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?s3aBeMkUzccBPZwjmjHohJqJBGHRya1qllyL/iYMeF5JJpIIZ4VFn3ubIgpJ?=
 =?us-ascii?Q?hQ77hNcvUVlUsEvsyNNLptwsON49HRjMOoFTmTNm4MR6x09mjlDUFKisCmYq?=
 =?us-ascii?Q?MYnxgd355OyqK1iOtPCVlea3jfeGlXoSDKc/jRCBvoraJNthkpX6FVX6PvEk?=
 =?us-ascii?Q?DeOgm4jHZ/v6S4oVdO/rShsXmPQVYEnedl/7jtFw9npkqFnSrpvRYBfcJk8+?=
 =?us-ascii?Q?9Dp+HJYNvdtB1DGCrZ/He050k/CN6jaoyC078nkcV3DU6Qwl0Z2Eo+z7dNUf?=
 =?us-ascii?Q?R9vC4ECC4f9ocOrffVCwUCt1AhuiTkxM1hY2hhdDae6gR5jWF3YOEMyCZ+JV?=
 =?us-ascii?Q?AdY1BqQb/jeFvH4q9EU2mbKFSexfOtAjrdlZ9qlaJt5AkdwMyPuZOLUhQClP?=
 =?us-ascii?Q?csfq27e5cn4fKwiKBXJj0wRzDqkkCTuzuQqmLstP/yaddjs23abQ+ptv+XMg?=
 =?us-ascii?Q?ShOhs1+dxjQglTrcOThGY7FTt6hjevWvhepGQ36Wk3Iul01wWB4rs35gf2M5?=
 =?us-ascii?Q?ajHx68OFN210dCdAc4qtkz9LGHYVW/g0zgMv2tNxRCensqIXSep7H39FUf3K?=
 =?us-ascii?Q?nlXP8cOaBduz7D2Qv357B/ItYbfa98XPGwOuJGlbw6qbICH8i/wYjbhypdIk?=
 =?us-ascii?Q?45jFnkfHFV/CY6OEGt/0JpRr5PwYD6V7ICW+1q3xk+x5jdbTHuEmB82FxkB/?=
 =?us-ascii?Q?2COlskr+Ro7o1QAdBQDa+e3Ox3HYnGzYTcth4AS3sn8O7b679z11jq5eTXET?=
 =?us-ascii?Q?LgaKQFdIfRA0GUJeFsukKFaJG8hdbuMuFR3OxPD1EKUiKOGSIZBuk4An8FWi?=
 =?us-ascii?Q?dmLuT7+QnvORjdDqYds8mpv8h043hwEwGJNvLeWNvEBdKG5nmvJL42WFYmmX?=
 =?us-ascii?Q?lSDPCVLupVcXuxIGX1OOkt+UaQ+XpOUBtqRdB47jIsMjPOkuC43GZWHw/9Jf?=
 =?us-ascii?Q?EeLZMpaO5sCzJQyDQuEOtrMQ9BYc9XnFUncc3uM2OE75MmAOlOnfgZGtbQh8?=
 =?us-ascii?Q?mTeo06Xf73322uK9p3mGDNWP1rYvdNmlvumBB7nOS3Sine0zSX6n6Vwk5s2q?=
 =?us-ascii?Q?d1K1F+GFIKjK7fzbxD+yUfaDiLYoSzMjG/twcQI6r3VrHSq/2e1CjnYU5w5m?=
 =?us-ascii?Q?GDXGqHwCTTmVhiCEBjziGgp8b376WeMiyNS1W2xG2ZlfptecNn8FWXznmgh7?=
 =?us-ascii?Q?jXZbsc7RmLkJC0rVHZxBFkYFqxQ6+T1anHKNY8wbPdSva7/iyyERay1o/qIM?=
 =?us-ascii?Q?HIq6k1qq0kH62cmfQN6FVlDTOPoeNijVXYmeFkKU3UmozNtl3tGv3vNstGTe?=
 =?us-ascii?Q?CJvmx+vbx2on224WyfQOgvij?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffe6d31a-2b20-42da-9e78-08d8e5b53761
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3794.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2021 00:16:15.7828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ExMIHn+gxZfoo5JFerK1Wg5G3+NDjuCKA3QyAd27jgjSgkygHKVXHCDGfpSi0qn0yqTL3VNcoDzWR7594jnUoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3746
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9921 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103130000
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9921 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 adultscore=0
 phishscore=0 spamscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103130000
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Mar 13, 2021 at 04:56:21AM +0530, Bhaskar Chowdhury wrote:

sent a few additional typo fixes to your V1, can you add those to your patch?

Regards,

--Tom
