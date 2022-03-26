Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993B44E81BB
	for <lists+linux-pm@lfdr.de>; Sat, 26 Mar 2022 16:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbiCZPKo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 26 Mar 2022 11:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbiCZPKo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 26 Mar 2022 11:10:44 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B799606C3
        for <linux-pm@vger.kernel.org>; Sat, 26 Mar 2022 08:09:07 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22QCaiS2004721;
        Sat, 26 Mar 2022 15:08:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=pO1OZ0WGnupDRyCKFbkKQThoUHgtX9XDGFLpXlX+hOc=;
 b=IcMICYqK8T3rbPtZeUqP3oK/V6ejB0T/Qss7hCHAJ/Atve4O18xrC0AhJUWDwoa2CLV3
 iK4+ZsN78BORRZrBfW4kvxLD5NoBDRsns0I/vPv15K26Uf5wIfdJwScCBka5o1d915HU
 T6cnJLv9i2gEvf7ZaadpTTMz5+VBEnJu+LRoxeQsaapAIhEUDA5pN9d3K1LQ0hO279lG
 uItJdMEJlyPP1QL4O2yjmfslabjnaWJ7WK19abKJtkUkW23QK3pfiO7iGiAssXTyTeP3
 EBpv4LuEcxtz5dAqcI39UwcXJY8ZobidyIMHYamUTjA1LmMVUq0Td7HbmrSpkXAuV+3g 6g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1sm28ky4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Mar 2022 15:08:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22QF5wVk123366;
        Sat, 26 Mar 2022 15:08:41 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by userp3020.oracle.com with ESMTP id 3f1v9f8k7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Mar 2022 15:08:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGgH1HkiruFGC3+oa/0n1S0eaIMnCUQQMFAd4rObyI2toWIxGVj9nN/YA0vJvxfg+LEcygbZjuHQ/72LDkmw+dsoIwNeho6kw11EAumu7FbyO3ptBbRf4fRfpaQpx86m+uBD0eo3lZRnLdnNTCMgyUvF3aOw/1m5l33WDGBVyeNMD/WkkxSsLk906Dx+16G5hojDaDa+jPU1cN4Yga6B4Sn18Npa97O6spFYcl4uvkzE/HDSpE09deGm+iWUTzi26PiI0JUjDiE4HQOKRPUsHAGPlUzcjdHO8EweNprU9MRRq50dfikBJ7cdF+HBeCBnHowl0Cunn4uqdbFzs89iRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pO1OZ0WGnupDRyCKFbkKQThoUHgtX9XDGFLpXlX+hOc=;
 b=FdqwDDaAQ/Ty0dApP0vFsZ7AuF2A9omtb/m169v+z5NRL9/5NtZ9m6beY85trfjV+vVH8Ip1THgqYy3So1u2u1pOoarxJAVUVpCOUbaKvq/9/O6132DVGc0IQZKJV6hul++OBgYGSm1YiiC/ND6yzpqm8XyHTK2lMzMXh+p6DhNq2imH+u9+Qnpis5XJWpucZpWyToQeBX7PLSCOlODG/Z7pc/9CbJHgYIr/PW9n0mSgTgRf/CJKpfLe+WsJuihBfGIhgXdf9U/tOwsVWjC0X1E4pa0ghC4wCbvR0WsDF62iWSf+hqqIbv1n8NxOOkaobBVQ89oRTB+Sue+Z9gfIYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pO1OZ0WGnupDRyCKFbkKQThoUHgtX9XDGFLpXlX+hOc=;
 b=LWwZkMkxx2fYXMUBC9HOArXbczZPM+3eS5vuPgEs9w5lT6T0Oir4bJyJQIpOPyHrsFaYuk4Vnht4IuenDyhlRitEbTWyEgSqprq7g2x5mViR7ahWNp9Zo7tlkuhrI7BSAnpls7XvOkGChNCm3xMz6leKAYLx/rBvcYqPkVkY4GY=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Sat, 26 Mar
 2022 15:08:38 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::1b2:b41c:b2f0:c755]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::1b2:b41c:b2f0:c755%9]) with mapi id 15.20.5102.022; Sat, 26 Mar 2022
 15:08:38 +0000
Message-ID: <08ec35ef-9e66-0e52-2630-6f88e16b6734@oracle.com>
Date:   Sat, 26 Mar 2022 11:08:34 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH] xen: don't hang when resuming PCI device
Content-Language: en-US
To:     =?UTF-8?B?SmFrdWIgS8SFZHppb8WCa2E=?= 
        <niedzejkob@invisiblethingslab.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org
Cc:     marmarek@invisiblethingslab.com
References: <20220323012103.2537-1-niedzejkob@invisiblethingslab.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <20220323012103.2537-1-niedzejkob@invisiblethingslab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0501CA0143.namprd05.prod.outlook.com
 (2603:10b6:803:2c::21) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cfcd5c70-164b-45d7-b51f-08da0f3a81b4
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4429:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB44296C971FFC74B5C288A34F8A1B9@SJ0PR10MB4429.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UwvsMmgb0MVKlV2BHIwHi0Z2HnfdXinx2a77QAF+GIR45mjjQBYURSpto9qMOCV16BmXRC9lnzqFC9EU4wa3beqNDx4yxoh72k2Fgos6RmKJWTKTaKG0NrEUjutz6fBK7dYwD4NTJDT0n8QtuLUv8K1T6uRw2N+VxAFRXKQ3wnQ5UldaeS7IdbytvPwQ/u0+HL7AMd8R5Pm70UN4+JoOgbZo9RBkv+BlNiagOzo8E0+Oo041/znEkD1JqyX00XCPKtMVCK6OjQyGspxs/KGCLKRiTqhuEQ7ORW4dkzCQ2DuEu1EtjslGoLpWhKmDdo1BEFXgmnUHcsOQhbkpdFeu4Zs+Zd+W9js0UDoNE+HgmV6k6FS6mawJKhSuGgN7YhwRVGWZ6AtOF5rxaUX2zjA+jydVpTgQkusNV5ORQtDy5W6ZcSfBPxKCvV5mv+tnI4CMuR1n9epsWwPQsGOR8pL8/SmdOUt1QgpRi0cKqXi5bT/PrXoZR/KmTf+6NXGhH7+bR80m4P5hf4IOhdrrDYOmnHA758x0HV/WVU0SvMdTnP+PViGBKVmQcDr/HbLAElMmxx7R92bXcAps0Xn6bj9KsaOrm276gCtX/QGPhIVP1f3yNzLqN6Y+i7xZVdvY0hTdDa9X/S5lbO9kw+zkEmwoqoxxfgD23GNiOVNQ0joKkIjVY0jiLdp7ZneBqk4XvdpUtdrN7e8Bn2G9UVWms3yC5IdTBqrFGVexpVUpkc8WOVs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(36756003)(4326008)(26005)(6506007)(2906002)(6666004)(316002)(8676002)(53546011)(38100700002)(110136005)(66476007)(66556008)(8936002)(186003)(66946007)(6486002)(4744005)(5660300002)(508600001)(2616005)(44832011)(83380400001)(31686004)(31696002)(66574015)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjkybVUzSU9seXJlVzZtZjQ3a2RaVkFGL3I4azFXMFlXeHlCcitTWGQwbjh1?=
 =?utf-8?B?VzB2VDNJdHR1RHV0VFhyZDU0UG5uUUVHQmZ0Tjk1Rks0QUk3cXRlNmdCSUVj?=
 =?utf-8?B?ZXFhQ1phK1dHNDBnRDdiV2NFSytoQ3BCb2FGZERWL1BlQm9zeEk2elo4QmRv?=
 =?utf-8?B?YnBuNW5lNVhTeDJ4RithMWhRWmJrcyt2VmJaT0RjeHdPNy9OS1Fic1c1cU5G?=
 =?utf-8?B?YW9kcUtoUTl1ejFwVGR3T0orKzlyZngxaWxCWFREb0lKWXFpWFpBckE5NWEz?=
 =?utf-8?B?MUpnRlF2L0V1OURieVdDV3dJR3MyNEpHS2pnR1RGcXNGS0dGczRkV3BvM1gy?=
 =?utf-8?B?b0ZzRUxPOUNSV3lHaVdYS29oL0tEUitiRlB3VlBNem1DK1kvdWQzVGVlcHBV?=
 =?utf-8?B?bWhJbVlLendIc3JMN1U4NXRSSHlDWXJ0SjhneHJVcDF5Q0x3cUU2d3paQVBZ?=
 =?utf-8?B?ZVBrN1M4akUvMW9kTmtweTZhSkpFR0dMSllsdHFCVlFGN1F2Y3JlM3MrNTY1?=
 =?utf-8?B?MGhqekcrNW9JS0tvVm9CWE5wdGUvNk5LQzc4cVhGQ1o2bDJidlhoQm8wa3pl?=
 =?utf-8?B?eVB0UXZwRDlqT3JEb2xUTEszUENCVVVrTzN3dGxzWFNwL1FIamRwYTdseExa?=
 =?utf-8?B?NFlOVHU2OG43RFFZQ0J4b3BUZjNlTlVJeTJNS1lOakZ0S2ZYUURaaEVmcGVn?=
 =?utf-8?B?WEE3UzdHMjhyOVRFREtFK2gwd0p2TWcrbkhDdnVTTGMzYkd0ckUxeTVSY1F0?=
 =?utf-8?B?SEZtSXg2U0VCNXBUSWcyZ3NGZ1NRUkNsa2lNaTdtcjJDZG1TaDFSQlc5UVZV?=
 =?utf-8?B?ejlsc08xWVZuZkVWeHNuaThZY096aXZCOFpLUjdycnhhdGxuRTk4bW1oWkxV?=
 =?utf-8?B?ak9sT3hlams5ZXBucnp2aTdiM2dNK2l3UGxqaVR1anlzUjZ0MWJPaUNUSnJz?=
 =?utf-8?B?WU9oZVRteUFpZGQzQW16WTdJK1ZhcDhFYnZtK0pJOUxmanNBNEl2Z3I4SW9j?=
 =?utf-8?B?cHg1ZHAvbldFQzA5UkZ2b0w2N1ZBVEFDdUd3WGh5UFZVYU5NK3hNc2k0RlZk?=
 =?utf-8?B?SnFOOW04SC9MTzNHeFpIWURXVTNHQWtvOEtNTTJJNm5xVzYydGoxR1dUclRM?=
 =?utf-8?B?dlVMNk1iR3hzZHpQRktHQ0lYbGluNmR6WW9xRDFhZGZsODk2ZlVLZGhHYU00?=
 =?utf-8?B?UGZxOE5sTlNScEVoeHpoNDFrOU1rRW10MWVEMm5KNUg2R2ozYkN6NmV0ejk5?=
 =?utf-8?B?eEVrdGw0eXVzbU5hT1pLWXh0TEVNbDlCOU9BRWNZR2c3b1dOYUxQbW9NbnNC?=
 =?utf-8?B?Y1JkWDZMckRQd3VyUjlicDRZQUh0SUhRNzZ2RmN2UkZYTEM1M3dMeExKVGhl?=
 =?utf-8?B?NE1MbFBVZmxPbjh0cU0xcjlScHAvSnB4NHJQMkZWRFErUjVpdUoyak5pQnhr?=
 =?utf-8?B?b1dENmtzVXp4a1ZwRjJsWWxWUStpOVlXdkhnUFoxbytBc09meWtPbmcwQmNp?=
 =?utf-8?B?ZTB6Q3JaMHBBeW9sdmRUdFdwRXVKMjJNNUJ3ZXRJOUFJajdXT29aWTFvcFFh?=
 =?utf-8?B?VVplOCtiTmR0eE1FRjZweEFHSmlreUNoMHZxOUlaV1Y2Y1ZoWm1rU3BjSSt4?=
 =?utf-8?B?L2lSTDB6RFlGbllGNlJlM0k5aGFEcVRKRlB0QVpqTnlHSzQxdlU4d3JsU1pE?=
 =?utf-8?B?T1pOSFlYdGprWG40SGVJZkJpUnVxMmdqUENvbUJGQ0ZyeHk3SXRYU2h1RGJ2?=
 =?utf-8?B?R0pXQzBvT2tKamJQbzIrVmNiSEZva3BxOXVIbWxVY1BlRFBZNmY2cDNkTGFO?=
 =?utf-8?B?V2xPcVJ3TVVESnc5cUVFbElOSG9obFVZTDNvTXN5UitEU2Jsb0RwUFpkaEQw?=
 =?utf-8?B?b0dKNzZrM3h1a296WlNrVVhCYUs2cmY4b2hUL3I0R0o1R0x3WElBb1F1U2Y0?=
 =?utf-8?B?WnJERWpLbUpkSEw3SmVyeFZ5RGU2NTI2Wnl1MndHUTV2RW5mZEJCYVdZRXpv?=
 =?utf-8?B?WDBZQVJRVHJBPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfcd5c70-164b-45d7-b51f-08da0f3a81b4
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2022 15:08:38.6531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bjGtzB6+EAlP7tUJgHyVAdl3zHrKCJhnIudYUamX9PgKJwZ3diM0NFgmR3DFEm1d4yNsaZR/qTh/TDVI7qBcZ4A6qD+vLuuwRxE05mhaYrM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4429
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10298 signatures=694973
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 adultscore=0 mlxlogscore=848 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203260098
X-Proofpoint-ORIG-GUID: f_SShd_JlmsJhYHbOQaVofZkcmvn5oyg
X-Proofpoint-GUID: f_SShd_JlmsJhYHbOQaVofZkcmvn5oyg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 3/22/22 9:21 PM, Jakub Kądziołka wrote:
> If a xen domain with at least two VCPUs has a PCI device attached which
> enters the D3hot state during suspend, the kernel may hang while
> resuming, depending on the core on which an async resume task gets
> scheduled.
>
> The bug occurs because xen's do_suspend calls dpm_resume_start while
> only the timer of the boot CPU has been resumed (when xen_suspend called
> syscore_resume), before calling xen_arch_suspend to resume the timers of
> the other CPUs. This breaks pci_dev_d3_sleep.
>
> Thus this patch moves the call to xen_arch_resume before the call to
> dpm_resume_start, eliminating the hangs and restoring the stack-like
> structure of the suspend/restore procedure.
>
> Signed-off-by: Jakub Kądziołka <niedzejkob@invisiblethingslab.com>


Applied to for-linus-5.18

