Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B4D52F96B
	for <lists+linux-pm@lfdr.de>; Sat, 21 May 2022 08:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240411AbiEUG5H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 21 May 2022 02:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240400AbiEUG5B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 21 May 2022 02:57:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A2A17995F;
        Fri, 20 May 2022 23:57:00 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24L3w065001885;
        Sat, 21 May 2022 06:56:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=4ofVN3Qr3BVGj14jAn5p+lGltnjS4wXmT3nLTkVOJkk=;
 b=aihNRgWQPBFP7Nr6R6JJH9L9M+x0M6PuAffgWBvJQuE+BVUL+G4Iu5hCS8GzGtUU9Xb1
 gyy4IB+u9kORQMWtgJwVd35MvdrG8Q62nKErBVAIEMpEgzbP3hboK8otNoJe+KYPnBB7
 fLOgG/vyiQoIMD+udcbnfRsUVDIrL4yBTz2eaJC1+Gmk95etZ+Qc6190szTMReFvyam+
 rIfPscHFB+6wFG4Ozjqye7glTg2WS2fUQVftZkVZHaOAMmEJtbBBChom/q9ynXBC5I/s
 oDLIXtsUuKbY85uN+H0JrdOmuzlC16oa2+i1qZm66mBPY3oZHxxCi9ow++1rV21Cms/v 1Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g6rmtr4ak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 21 May 2022 06:56:55 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24L6ZrDM014558;
        Sat, 21 May 2022 06:56:54 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g6pgyvc1m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 21 May 2022 06:56:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJlQBzSQ+XWTmTxd0SQx24BEycN5ebmseMEeyQWUzfbQdsLKsv1LchOY2moLbvuZdAjjFUu5tkL4Pt/oh0+e+6Wsd4Dx4Xv9XaneD31Eaoyi0d2WOjSwzQiS2OLC9LGaLwZvc13yvT7RmuEwCfDApXlaQWtEmea3Oq313QZEwjHpXF9tC1YgHle6Jmh6dhNSFiJVfYWQdQ1NCBck1bpHCEQsemAifmUNE5GEXCg7xY2pyzQAGYYcvUNTjG27Wze2UT57BYFUJ/L+qwQ1etz6OCtHIa7OBY5WL0IM6cpl5CU1DZTgN/n432asxTOHjzvoi1Sy9U0VxC5yasw9VeiR5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ofVN3Qr3BVGj14jAn5p+lGltnjS4wXmT3nLTkVOJkk=;
 b=JNR/QpGLGdZcYQteQdkCzEwZhCS8WDUFTcOdt7VgPfjIDs3FD8TF/hoV9aL+JrKnFXuoxbMfabLX4wmgR/r3c1LsJHVgEnOn/l+w+uXgSJ9BdIltMuLn+3gMSwNq8FfjKUgy0QXxn/uT3+SLuYQmFbUx+kzMzHNRWKZysbS5KJshL0FsCltMInjeN4OIwwzoAq952vBWxadMdamqe/zd7wnds5PQiCwGEd2MDDrfmiJ+ESY5QrswQUfSB5pbUznr0mMIUnbR1o3vY8bCLrBKUTDzTlXzC1bbEAXHLoS0CC9cW+3z33jvPCSpon6S5nK87JYQW6yA9MsMOQaxs1k0sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ofVN3Qr3BVGj14jAn5p+lGltnjS4wXmT3nLTkVOJkk=;
 b=AJhTE/pfxWhWOvlUT/S+6F20OOJjmpslMWx8480jgxBlaNT712n1vYORSGiXVyjQXxu9b1ViwT2vUj1AfIk+OCLojWimRi8pUX6BozQBxxhh8iIauP/seyKVJPNNWc66EurRdPTt2AhBFr+rlFIiv3ZnePQxDLA4vjgv1gG+l5M=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SN6PR10MB2878.namprd10.prod.outlook.com
 (2603:10b6:805:d6::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Sat, 21 May
 2022 06:56:52 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e%2]) with mapi id 15.20.5273.019; Sat, 21 May 2022
 06:56:52 +0000
Date:   Sat, 21 May 2022 09:56:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Keerthy <j-keerthy@ti.com>, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] thermal: k3_j72xx_bandgap: Fix array underflow in
 prep_lookup_table()
Message-ID: <20220521065615.GD23160@kadam>
References: <YoetjwcOEzYEFp9b@kili>
 <3061a9fd-5301-4d91-2d60-b85a5d4910e9@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3061a9fd-5301-4d91-2d60-b85a5d4910e9@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0005.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::17)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d760617-05cc-4bfc-3089-08da3af71597
X-MS-TrafficTypeDiagnostic: SN6PR10MB2878:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB2878725F63B5CA350AB92C388ED29@SN6PR10MB2878.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: noGEDH2/iBRT8VDiE78T/CA3iKyk8J+dmQ3K+RQ0lkobCYsHiX4DJplaxLXajQK9Uym8a+eW3wEGBL9RGdpow3vLlPLGaSptvOzb6jc6rjgu2Fb5sktb+XVP2+ZWnT+7iPbqBKh2G9DQf34cRM3wJ/qu6IQau0sIrxqVTFYMSUfC1Ysr7T0e7I5neJrWDW4VLhAiuEM8QDRUjOpSxKrNyeYnzFCF+uF4v6FF5iYV8p6alXSN7aQsdz0MnIi3q7a4G1IKp3QYJkbB8qJAjiZ08w91GuaWXf0QorSVQsY0krItWOwG2UGzEJYHAEYIFpT3ROMeq4qIv26Ond8tTnL2E+0UowQCzxostiyUKae8dKMn6IE3fmbHDhXaM/ZGxYys8FrZUcFS0L7j6w0GWozVHYuh3DHgRtAoyHUqtra9VSNBpxxXKfGObqUSt0Y9jwIkABOlcTkUTFl2ltkn04aa4rHBGagxbjXOqvl8P7QnMRqsYoeN155jI56ufd2swy91GyZe1HnGWFH7M2CxJIVMGmh3JMXP+XtHPsJCA/HUj/AEEbi74ijzFGkHu35MT1kBOnz2qTt9GyOQV4VS7gB77tfNVZ6JlPFKrflm5mrqwrdbjfvT5ylf3KMfzmYJ4f7B5RAUkVaOePCZbrHEjCcFyrAb2RrlvOYpacJicnnbKNqqUgii1Rn+hmtOzKO37rbIVHbZFhHxXWFmdsifsZVKOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(52116002)(2906002)(33716001)(9686003)(6666004)(33656002)(26005)(6512007)(186003)(1076003)(6506007)(53546011)(38100700002)(38350700002)(4744005)(5660300002)(6486002)(8676002)(66556008)(66476007)(86362001)(6916009)(54906003)(316002)(8936002)(508600001)(4326008)(44832011)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DjtU/mx9pynyDQ2p9nzAP2f820k4RL/Xx872q2iXm58nOGr7gLeOPrDaSShH?=
 =?us-ascii?Q?tO4W8kvIRE1oPEUZNxk9XypHXs0m95nMioSD4I9T6CmEkQ+61V0XMXZNJvJS?=
 =?us-ascii?Q?TE3wq4u2rk+9khpO9mNUIA1TmWeh3j9jb8ly0r+Xq8lVLhLYs9yrd2yFJUqf?=
 =?us-ascii?Q?ZC9h/aUIfzE6f8ba06AlE+WLHiD/OTdo1nI84FFK+E/AeN6k5K6oMyuKGwUP?=
 =?us-ascii?Q?cAwkFwM2izRVSoJyxxYUVc3oFazo324kKH0yJktUlgvyPvdG2Tj/vYymozeF?=
 =?us-ascii?Q?S2c3tzcC6s5hpzNAjYFD1LRp7H8osYy3fe9qwI+dwuoAItFXKltMfEsAWQUp?=
 =?us-ascii?Q?C8wOMQzhIyEE+Wi7c0+lCFbSysreyGu2R6jHxyYlrHzZq0Qlcn9FQnVAubaB?=
 =?us-ascii?Q?77njvis063nmw/RVgprGXYqr7gsyqJIy17mOEzmfueTMUjtQ5J417gLOvyaB?=
 =?us-ascii?Q?TICUntxDDdmOUQ4fYRk8ToYZ4q7N75qr/8mrmy+fX+q85xQATg+d7qrxwY+G?=
 =?us-ascii?Q?PLJ1ZJvT0KvyN+3tc8+u+pXUY3Y4sKcb7Y0YgO+zzo59nLm3BVQqavlWaly3?=
 =?us-ascii?Q?gQMKD0qhWTCKXiUSweoYHXnlYOb2IEE9OyzTPX04HEbdXg8AFtRxIPUwEnfo?=
 =?us-ascii?Q?j3LHzLMB7DL4+sTP2kpYrrAX+NUW9ytVoKPbnmIm744AM9QKFwnOvOldyx7z?=
 =?us-ascii?Q?WcCWJjpoq+MVU6l6jBim2YgR0e4tUTjkXINn6arbjtvNsmvCZTtVgdskNXlt?=
 =?us-ascii?Q?CVSmW0St4Ah2ugO3UqfrJLcyxGe8m1COURzre4fifylVvAkNVUz3HcWXQUm6?=
 =?us-ascii?Q?zI8HZXuyWuKPguILhOvgnDpvExGSN2wx4WD5AX2V1tMFJRBDEkt6JZiD91pH?=
 =?us-ascii?Q?spHdHaJtZplnq8FW7Q9R1CLAmjW++KyfU7xYQvsvDqSfYal1VDE4sSjV/brL?=
 =?us-ascii?Q?iZpOdBB045cu5dyQy4ESICUNs+8stEyc0zhCYtXiQZmyun9J3EPuzYM/DzNK?=
 =?us-ascii?Q?NIchF8oOCOB75QLTznjjXc/HpvbWgx71ewH+AC+zJPc4C9jiTrfxRS677wM0?=
 =?us-ascii?Q?woTqcbb4vdI87jEIkZV9wKSAoqq0aO5WY/Trr4QWteXh2cBd88qE1RPkvsau?=
 =?us-ascii?Q?J48bP1sGUvfkCBUa+/uB66gkgs9U8N5fXCBZULcOFrMDQG4lgXi2UtQfPjRd?=
 =?us-ascii?Q?jz3Q24mPsSGoN9YRAlGAlBnSUKkN5ZYjxZP92LcPNQLFjihAZPQa9f5lwpFH?=
 =?us-ascii?Q?Y0eckIt1sxOUL/Ko7IV059BSXl2UuIqrc9y1W3ni5ymWQFEN61RRf3I3XGav?=
 =?us-ascii?Q?++eXyr9v17FHfdWsXEBpacZRyxnK9B/zhdmpI/gXX+q8zMZ6tAD/RRxSPcSI?=
 =?us-ascii?Q?afXl0Wxw/35aiXkxx5sAz3ofsOTjXxvUU/aec/6IlWR7gFYncRG8F0pSBQ/z?=
 =?us-ascii?Q?7txH8EXbWaJLE+4PqcT2A9x0GNmyMSqhXJb1FDuT/WHTf5WCL805dcIvNQBg?=
 =?us-ascii?Q?MqZx6G+23QbQqWDgjb5s2gsJMjlj1aGa1mO3AMxu1Xyy7HiBknp+x63WfF7H?=
 =?us-ascii?Q?b5xe1TOch+JoQH+ja9d20vHab6q7zoJt+yaa7YECDdHdP2WkJ/NDKW5IO6TR?=
 =?us-ascii?Q?OTkv9nL3cV3TwFDwQ5WbgxRfZGGpMTKIEblNLlIQRdyChqJc7BFRtJbHUObN?=
 =?us-ascii?Q?gnTWJsVou7RKXg1gcM7UWaL5uSt2UQkAj8scVE+Of2+pBBPIf87lNQLNX104?=
 =?us-ascii?Q?ahmKh/90aXb/6Uv9WCEAPV+PdnTUxY4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d760617-05cc-4bfc-3089-08da3af71597
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2022 06:56:52.2721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K4JRiFHw1fnHUkLvg9eCs9WHkHwbBRL7+wHdABSaxnUJnHA7TkfOuNkEWsh42Bgi4efCeUq8BzsL1MHJ8ADCtU1+XJ9ALGeaJqtzACyfgdI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2878
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-20_08:2022-05-20,2022-05-20 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=975 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205210038
X-Proofpoint-GUID: z_JWBJtyTbHPtNq50Gt8BEv9bNeb5jV8
X-Proofpoint-ORIG-GUID: z_JWBJtyTbHPtNq50Gt8BEv9bNeb5jV8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 20, 2022 at 05:25:56PM +0200, Daniel Lezcano wrote:
> On 20/05/2022 17:02, Dan Carpenter wrote:
> > This while loop exits with "i" set to -1 and so then it sets:
> 
> Won't it exit with 'i' set to '0' ?
> 

Wow.  You made me worried there.  I had to make a test case just to be
sure:

        int i = 10;

        while (i--)
                printf("in %d\n", i);
        printf("out %d\n", i);

Yep.  Ends on on -1.

regards,
dan carpenter

