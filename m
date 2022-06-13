Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A164549A70
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jun 2022 19:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234667AbiFMRvp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jun 2022 13:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbiFMRv2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jun 2022 13:51:28 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698DD54FB3
        for <linux-pm@vger.kernel.org>; Mon, 13 Jun 2022 06:32:10 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25DDEaRV000491;
        Mon, 13 Jun 2022 13:32:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=5VX39xJ8wbNE2q3O504KSaSAbgJ5FT3a5c4x86SFmVw=;
 b=Ez7W2xcy53TUiG0mDlWr2cauyLNEDSwOvq+cCFkrNCqHibSLl01eZRcumWQSdQFbZVOE
 8xIGZAFiXE6dVysouDTz+mTZRlVEa5uR3CM729Kg5nGYbj/aYSwAcJ4DTVcWWNuIiWmO
 eGdVAgD7HUJSzSlwqIe4Wv95W+KhucWOqsAIfHJsneTIig3caDDEVU61ibT7TAiwp/T3
 PstHOnZw06udBvjTw+ymVnmOmYirQ2IEWxpECQSO6Jt88n0CrTDeTnVQhuGeIuYaCvXR
 EvDUjup1T68EFuM88EP1nN0RVtc8oFYfFl51YlfnBFRruDq50V/f6AMRQ2tRzZtS/aas kg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmjx9b29a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jun 2022 13:32:06 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25DDOl5X037603;
        Mon, 13 Jun 2022 13:32:02 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gp5yv8ca6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jun 2022 13:32:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PtbqW9LWBcWa/i3TSsJtJzXjvF6jZeL3AVO1tuLD7AYZHjSOkTyfATZYsiqs8FFj3ANb5uq+BNpiLjxoZKaLzz+hKKGjo+UAHC6Fg+POZqu523KBNJ8GA61GSt+4NGBiclkLrKftw/bAor8vjMYW9/zEqj+zIqzuu9C6HCFoAjlzaihVqmGrNBOnDQvbU14JV8c985pEcbP2Z9JDhkWkPuFbjTbAXHkhNcKB1W4buLkGBRc1bRO4W+R5j0MRmgWSiYh3UMECa0QddPDmBrWdv7WgU93iyyUDjEau6L1hOIdiCZRVX50fgLh4EEwyDTh33YPtoB24XOSvwTfV+dkN5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5VX39xJ8wbNE2q3O504KSaSAbgJ5FT3a5c4x86SFmVw=;
 b=IzRAOEssnjjVci6OLMHi+efVQtqjvcpsgxLTQKLIkRNC8O1NA7OiRHLeCJsi9mXYkYU4/W9drXxJw650MeYC0m/NeiOV6TEkQdfBFhyPT7K6x2Zv4VvH/WxPj8Du8J+aLtgUFYWh1zErVPqugggq2LBsUjorEsKsN48JLZ9MMPyoRRX9xxCTWUyLluOiXFivj/2wa79JCz15x9Q8JtQnSR+3ut/YbMYvwB30DfsVRccc+JuflLP/IHLnUOvazYYGkVLL0TpxPoFkbYypSFRxFahp/G5U956I/AHxCiaslwpG3R7+00vJaR68AzqEnHd1quzTYxshvYod89tnJ005lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5VX39xJ8wbNE2q3O504KSaSAbgJ5FT3a5c4x86SFmVw=;
 b=EojK8wX2S7wGdTJCfLprMHAolCIcHccJ/4/cV/gLNE3jI2sSr8lKSfg/TdERkQvcG7x+uJq/FdLytN0DhAWKjaddByrKlebAZNJRtrapDLfk6nqjJXv8BiNpq8lHfUzTcNm1fDKt/s3ydU1KNxQ4+RS9xEFu/YD69vrOkZKGtlU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN8PR10MB3683.namprd10.prod.outlook.com
 (2603:10b6:408:b8::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Mon, 13 Jun
 2022 13:22:31 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5332.020; Mon, 13 Jun 2022
 13:22:31 +0000
Date:   Mon, 13 Jun 2022 16:22:18 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org
Subject: [bug report] OPP: Use generic key finding helpers for level key
Message-ID: <Yqc6CgShqb/RId3D@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0020.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::7) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00bec693-5424-4049-6761-08da4d3fc49c
X-MS-TrafficTypeDiagnostic: BN8PR10MB3683:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB368398650C813ED371F7990C8EAB9@BN8PR10MB3683.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uzwzJJ3C15XUW4ZOeyWHjDai+OXeTGyzbNTvQaN4PFsEPvKt9vOOS0rF9MS1OIXIfP4QzYA8lTBm2CllhOlQW0KWwXXbY+fvHKjGlJxEOJrwoPrgdVKlkFFewKvr9EQsFTrxr0KIUgsrnVY6S0wcTK3WDT8omLJQgHCz32NEv3F0W1Ha5ROMnkdhrG/hZxqSBYfHFHvDwQ5ziYIRSf4JGCIQmEHBe0ooo8aA9aeYR9lBU2a/oGRA2CfZEojdmub3TBUJwX3/LYCBQPvp04DSH1XYKlR3u1OBzY4xzOUvwh3+dPrlKdln82ea7VIaoM+80gNk9Y2n4MLHFtdemQN3pi+bcM9ivg2XFJKDqfR0bf1VzkHj2HQhpt2bw8ZqSfXA8f2pyx7T0Bu1y9Iv+0D2QawLxNSFkFeCxGbA5Rmz02TBNQrRb51CvkP3bifnQ71rOqd2JiuAgh8Pe8dlhecwMH9G8hSY16uC1NzcrIRcPJQGTsfPo3f797ZZ2y2u4UY//KCJfmFa4mr7Rf73brhiSmvDcoJuhXokNYy3zxIeLDeUmmO3Ha//M0HeK2ay9gwRQiy40LtieUXjqR2FTmzdqgf+nrdJThIbVqJv33mK7WCW2TySSBdVVRqtrE72lQyE/5QZ8yP0TfgPiffdRab4kHRLQwTqE6tzXgfTF4FP3A4wdiDNuqGp1GTWqcM1CN4i+IPPLQbESQUmyMRk21T50VpQjJV77nru11R0yPuF8QA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(186003)(83380400001)(86362001)(6666004)(38350700002)(6506007)(38100700002)(33716001)(52116002)(26005)(6512007)(9686003)(6916009)(508600001)(316002)(6486002)(4744005)(44832011)(66946007)(2906002)(66476007)(8676002)(5660300002)(8936002)(66556008)(4326008)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HT7k96cT7UN7MQnnejEVCoJr4zv7SuL1BC+LIfKUEoNdXXMjy7rsWMYqT6cJ?=
 =?us-ascii?Q?Yx6H5aHI9sk8Neypi6j9MPC9hdoK9OMw6xq2AdoA09Ix++54vcmdjxate/kN?=
 =?us-ascii?Q?0L/6BsxrNqYeeB2B4uUxRU3BHqYWRwk7JnVO7O3cAf9XolNSvU3Syr53PdIo?=
 =?us-ascii?Q?mpzd2T0YnYTsdtnJopdYTTCczPb5UfJQemNVkQeYThZra8YaFy/NZV9mZE3l?=
 =?us-ascii?Q?nRa5fLzXQYD4Pp3GlijmpxNc4ldKyd7juRthzuyBVE04xSIVWoWG/MbgXHcV?=
 =?us-ascii?Q?h8vy3a92R0Y4/kVWWwvYLfuPGG/3JdYuIrzKOP5peb+a4M6UboijCEbh/MxL?=
 =?us-ascii?Q?IicGNvYSO0TxUnpenpyL6NgsfqKbw5kZFJj2qB72ml9dQxkLDVXnUAYvgnfF?=
 =?us-ascii?Q?bDkZMZ04jBQnHZxY0bpJz90AzVZ3pP8+SrUSOUM+4fi8CKXLaNVolFynkw8E?=
 =?us-ascii?Q?7yKYZXWxgeVy5LXxN3/r5/mRtEq5k0d0oBYmqDNGVVtUTETgHFjKdkx3EOU+?=
 =?us-ascii?Q?TgE6OFkjR4KD7kQkjvVbiZyXMe84sq7QRDMwBEKTm8IY4Fb5AYNA4HLV/6bM?=
 =?us-ascii?Q?WVE04x6BfB2uZ4PpqmMIEqx3qZ6LRi5hqEwe8raLtpWgsXhP3DooPgkUJmBv?=
 =?us-ascii?Q?aOG7sYOjrEfCMqzcMyWGGdzvHG44cP2mYWmNXUgsqtw2chJpCv3KHargpjc5?=
 =?us-ascii?Q?h2szKDY0LLKjeE5+b7SB7enWWRAYYK+vRl+B3EskRjRI+FtluWhIm5xQH947?=
 =?us-ascii?Q?Z5ndluSl4Seld97A6xPU44c7GiftiqC8fKJJu+wz0wjsjKMkjpooJeq27vgL?=
 =?us-ascii?Q?o+Xl5PzgccHp+vIDkfz+E7wifwQvfRfE9WeXInEp5GlSDU9iEsp7JJDQdvsX?=
 =?us-ascii?Q?RJtssVG1t1i1O2E9lGJaUMxo4tvnEuIoElGsE0cPjwekakB+fr+O7cJUVSmf?=
 =?us-ascii?Q?3MAtqObUPClWl/w3SXDasq94WgwB8vx74fyeAx4oedexmzy83tgE4yFF3BvN?=
 =?us-ascii?Q?F5bXLKnqmdGfbTk31EvaBj/yRojyuiVeQI6KbbLPU72dTCMfrx9M4nExTLGP?=
 =?us-ascii?Q?dBZJVpqfC9oICh3w1hvl3Sm9B6HQji3HSrupBBmKEifY5DWDvmHxVmhUNNkb?=
 =?us-ascii?Q?pjBpe00jb/zLPVpxmBlaV1R5G/RAG6wG1432+ViVLgS6B7jL2uoKyi/64s+/?=
 =?us-ascii?Q?ItZ3Y/Wcw2cYIOTqlYlGaSRGes8om60PnHIq88rWfkMQ8sriQ4o9Q/wbj0Bj?=
 =?us-ascii?Q?lT662Hk78beW/m61lPzY3FPHlk75XicmGauxXNJ/eb3GPEkL4U6cX3cGQEG8?=
 =?us-ascii?Q?wWj5O4MnB/V2xZuJ/e8frkdV99V8OqEZvXKEKcpTqSHgB+T/AG4gCHwY0d8F?=
 =?us-ascii?Q?BpQ0WKtkaisWxj2av66YhUa/XOywb2wEqBLWa+GsP5oMlI3iXGgnSnaV6X+z?=
 =?us-ascii?Q?6PaWQQSCyA2HnAJRx0kYe0goOzoGuZFyv/ymNcuKp0FpJ44KAnX6wEM0++5S?=
 =?us-ascii?Q?6lhzY1QGbt0r/MSn7tFNs4BGsjfs39zDK37Bdbj7qY3qMQQGjO3rrDaMZ/5P?=
 =?us-ascii?Q?ZMkri+WAYa+oq7yaB2lLQNiya6QXxEuIGQfcNBD5hiAQnb/DCXXwhiWT2t7n?=
 =?us-ascii?Q?8cEUj47/HM/5gvnqQHLyik1j5vk2So8Zip+cdEQytE4FfRWjkLzbiWVcQg0Y?=
 =?us-ascii?Q?gxrchfrEs2Rfin0LxK/9uxFxsj2HVH9EYHVCOrhlJGNHyMirimLH9hHU16ya?=
 =?us-ascii?Q?iDBxiipYgPqv0zrz8L1M/BYEvU17pUk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00bec693-5424-4049-6761-08da4d3fc49c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 13:22:31.3677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gWzMUmJwUytjBvIAXi0tr4mxUEru90UVzY1Q9KmcgBYcWGRpR4KQ9KWGy2Z0E0beOWRvHGneVrn3VexccNQOIh2r/gYWkZ4ueKDyQ9Ap4Eg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3683
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-13_06:2022-06-13,2022-06-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=802
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206130060
X-Proofpoint-ORIG-GUID: 44kE0SOE8wZVwkFYv2vUunyV4FmGsY9q
X-Proofpoint-GUID: 44kE0SOE8wZVwkFYv2vUunyV4FmGsY9q
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Viresh Kumar,

The patch b26e72f76892: "OPP: Use generic key finding helpers for
level key" from Jun 2, 2022, leads to the following Smatch static
checker warning:

	drivers/opp/core.c:688 dev_pm_opp_find_level_ceil()
	warn: passing casted pointer 'level' to '_find_key_ceil()' 32 vs 64.

drivers/opp/core.c
    678  * ERANGE:        no match found for search
    679  * ENODEV:        if device not found in list of registered devices
    680  *
    681  * The callers are required to call dev_pm_opp_put() for the returned OPP after
    682  * use.
    683  */
    684 struct dev_pm_opp *dev_pm_opp_find_level_ceil(struct device *dev,
    685                                               unsigned int *level)
                                                      ^^^^^^^^^^^^^^^^^^^^
    686 {
    687         return _find_key_ceil(dev, (unsigned long *)level, 0, true,
                                           ^^^^^^^^^^^^^^^^^^^^^^
This will corrupt memory.

Fortunately, there are not callers so we are safe...  Can we just delete
this instead of fixing the corruption?

--> 688                               _read_level);
    689 }

regards,
dan carpenter
