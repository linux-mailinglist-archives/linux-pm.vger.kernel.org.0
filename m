Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 004123E21E3
	for <lists+linux-pm@lfdr.de>; Fri,  6 Aug 2021 04:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbhHFCv1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Aug 2021 22:51:27 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:12708 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229503AbhHFCv0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Aug 2021 22:51:26 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1762fd1V023238;
        Fri, 6 Aug 2021 02:51:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=m34oYQkECH8ChBXWmZnhtB83Yir4MXDvRwQuIGoa6Ds=;
 b=WCaCoo2PlNP77M8wfk6bN3vV6+id68lzwxkdpApJDb/Ab2WqWvi2VGgPq5Hr4Q0n9Rz+
 vMSHRBttfsgPBhSRM8BLatDKeFBksflH1uEjxBY4zwXw3qDapxzxxam8t5V0buLbgYb9
 01uqhDYcfxD04M0kuBB2O4lXFs3AGBRXsHOBCQVNwKXSC5MUBTleF+p6lluBrVaQFQGa
 l0LHE4Px0jpOQfzJGGNbSiVkGi7hDwvtyNVSRbNcyi2mS2Krls+4meDGRq04C1zzASD1
 I9cvBON9wqgaQOxyVB0nAsNvrK92YEVuv8JB3Yiw1cAEwUW94AWZZ+9hPChlbzMX9OKJ EQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2020-01-29;
 bh=m34oYQkECH8ChBXWmZnhtB83Yir4MXDvRwQuIGoa6Ds=;
 b=JqeAAGXqY+adqMowLkFGV4Xz0d6jxe5+ph6YVKVZwDgazVjKqCywNqr48cDESbXoyY3D
 FgEiIAKBfKKRRIDc+cgvZenfKZru782IegoD/lNroffTLFnjvPcun4saLlwlTz+aHqC4
 waX3UpKNXTKbPrup777wXh6QJTWym8bRhW9nAMFNk/5+rL2QLeKLHNZB7U0lr2k207tw
 6zSw/fSD5Y5RXgwdvDvC+UddV7jY8Yyo3tS7AhYph5E7JCaWxDaRGoU59ApT4afTZeWe
 w4zdY8AukMq5DZRxdsLpKFkOJYGZMUzThcmjfkDNWr1dUPUOXDuN3CggSUHhAXTCP410 AQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a8p6rgj0a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Aug 2021 02:51:01 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1762o8jn084205;
        Fri, 6 Aug 2021 02:51:00 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2046.outbound.protection.outlook.com [104.47.56.46])
        by aserp3020.oracle.com with ESMTP id 3a7r4au6bx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Aug 2021 02:51:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3ii/CBEHSRhZPWOpWk7q5E5htZWOJx10+QstCr6CZWec83E3zAI4UTVdEocQHY7+HD6LkM8RZ+P1jTJf8EfMaDXmHtxjRT6g/ji1DsU3GsTgQvOJCVT69I858AQYltmxQi0/kGgNd157dkqn3Zgtwn1Wr4NeBqNt92LM1MkJQ/CZLQtj2Jb5rXwGswRa4lGIpgMRaLRjTUGTQAftmMoMn6qtV6yaPa0uVcWxFeeJ6/RqocFWO4B0mkAOLYWKZKNPz2k/jDaxhu/u301tF3tdmX8wJmWpEu8pBdRMjcp77bJ1eKzgV+WIL3K8+QZ8igb59iSOK3hg1Ym0+WiKljKYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m34oYQkECH8ChBXWmZnhtB83Yir4MXDvRwQuIGoa6Ds=;
 b=jlD04nvys6ACsidPYXZOap7CCAFMvlbMaemm9lebNL2TdVlUghWOiZLKVrOjlpSmOnxv96LSqzB/D9GoTCx5OY6nHvMMVqZbfev9UXebAvFYzWZCA88PSgRzY6OdOGdcknjh5AHLPCQKXxnng6rtgHwKO4BA3u7b/TnWKAQCXgCX2pHd2Oo2MIAQ2g8Jodu33s/LkSiZxbeMkKy3tjl0xqCUUEUmvXQ2nYa7inZo5QE03BdamICraX3RixWQ3FPbnaCJq8l2sEC+rkjcnLMSPhjDsj7AU0nUhFM+XFny2bV8bVXWMfeyaogY5dDCV0ZvwqC4jVH+rXfjP5c3W7oBpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m34oYQkECH8ChBXWmZnhtB83Yir4MXDvRwQuIGoa6Ds=;
 b=OmgqwM3gNgZ9z1ihYTDmmDjQIcJYCJ+IEFT7MySGLtobuI1T47N84pw7Rh5Aktg0eHIK3C52MDzb9ju/5mVfnx8VX0Nr0dNz1ZOq4uXyLnfjCgBFBi3JkORakkU16mgYt+6fsITy/ZPuz5+COd6jBrRyCGNHh0Qhc6Q4mT4eGuw=
Authentication-Results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=oracle.com;
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB5564.namprd10.prod.outlook.com (2603:10b6:510:f3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Fri, 6 Aug
 2021 02:50:58 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::153e:22d1:d177:d4f1]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::153e:22d1:d177:d4f1%8]) with mapi id 15.20.4373.026; Fri, 6 Aug 2021
 02:50:58 +0000
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org, Avri Altman <avri.altman@wdc.com>,
        Bean Huo <huobean@gmail.com>, Can Guo <cang@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V4 2/2] scsi: ufshcd: Fix device links when BOOT WLUN
 fails to probe
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1czqrguch.fsf@ca-mkp.ca.oracle.com>
References: <20210716114408.17320-1-adrian.hunter@intel.com>
        <20210716114408.17320-3-adrian.hunter@intel.com>
        <c78aac34-5c55-f6b6-3450-d5c3f09781fa@intel.com>
        <35b2bd0f-5766-debd-2b4c-c642a85df367@acm.org>
Date:   Thu, 05 Aug 2021 22:50:55 -0400
In-Reply-To: <35b2bd0f-5766-debd-2b4c-c642a85df367@acm.org> (Bart Van Assche's
        message of "Thu, 5 Aug 2021 14:49:30 -0700")
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0004.namprd11.prod.outlook.com
 (2603:10b6:806:d3::9) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ca-mkp.ca.oracle.com (138.3.200.58) by SA0PR11CA0004.namprd11.prod.outlook.com (2603:10b6:806:d3::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Fri, 6 Aug 2021 02:50:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2dbeaef9-d388-48fc-eec6-08d9588504b9
X-MS-TrafficTypeDiagnostic: PH0PR10MB5564:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR10MB5564B1B9F21F2D337BF145F38EF39@PH0PR10MB5564.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YEvLVM4t3qr0b6YHUQ2CZftBK9A9hmTgdMLnK3DlJRT3wPW0WBb7fR9tJsQXZufD3TYvx30+4sLHHsoLwZFi9WoV0VcAQy/GkOwlutUCzjcNTtv1bv7+xiFa1SeDQS//XUj2eblDrDJJgachr3rfpEjXaijHf+e2C3dt0CQ5cUC3DFGub1OptJV/PxOyzN1nfD/70R8wgMKsqB+PO9DS6/AHooS4/KgT5Ol00DPP6S9MXMj7PzX8/H44tyK/XadyMo9LdSXac0N/GRpnrfo8lLd3eHprRJxKfV8NADpycr+TLiuSSKdDPLVoUupF6fFhMRhk9y62aRRZndZlKRZIbAuZWzDbPD+2diBSL3xakxcEN85b46/PJnFRkClXOs1bDLM04/bx70z5ES3LMIZSNe2iwqlUpdx70drE+FWaLZFOe56XSw2y8Pkvn2o0So5y4ixtxocRqz1uZAvP9XthRu2wwC/Sb2uw2dXK3/iJHLSmGjpHHwRXE7JrP53YXHxoZQLoeUwOJVTnqxDwhZXz7kCFVemFwmimSgWSYuC+Q8Pyxli3Fyr32Ttsk3upEWjkP7j6asiwNkEXOmcyyzF1tDFGfxWdIwbItwODNXt1mX3Y8cerQIBRaD6GTHErAfJSEOMldPXThQGV9ZBxkOzoI+IiA9TP83dRPnsCKCpsqn9aAxlD59mjZPvAsJ4OW3IiR4cPAH8BKmR/gfuL3bSpxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(366004)(39860400002)(136003)(376002)(66556008)(186003)(66476007)(4326008)(36916002)(8676002)(66946007)(8936002)(316002)(86362001)(7416002)(4744005)(55016002)(7696005)(38100700002)(38350700002)(956004)(5660300002)(478600001)(52116002)(2906002)(26005)(54906003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ubdPtDTtjQZSNA4Hrc3rxrnDHK6iRg7CFVAvbiPxD9jJfbVc+wWkWa6fh+rJ?=
 =?us-ascii?Q?oaH0u8ko+RozfA6ysUkqIns2Y+esaorVyMZHn3ZZARHaOpk5rjb67HnG+QRV?=
 =?us-ascii?Q?f4e78O4IhiKxfzcTMBfVqdC9LuyREuualJUfVGtnCgvbVCHrPE4M6f/oP91S?=
 =?us-ascii?Q?oBPpE7D6vxUNfMQCAWZAy83IXTST9wEoGSb0Lv462chGmwbCj9YH0/OREUdR?=
 =?us-ascii?Q?kfNC1xnyuzJCgX8H0kqVDcGm8y6zdPdJBw1YMJ/vFq7r7XCjWekDM81yVw2Q?=
 =?us-ascii?Q?K9rAoJAO7mn9l/cGzEmNifLdRIglytY1gmvLMOIcgpipFM4HzCHQfUGr9de3?=
 =?us-ascii?Q?n+aA0uS7DGKnobHAbtMq4fZLYSQPW7fe4jcbcVsm47LEJK4NdXg1ODJXRmWB?=
 =?us-ascii?Q?yaZmwAFHK7SCrBKWv4JC/Oj1pLIs5YPqCvycCnts14Mi6oEnmgOj5xhhH05I?=
 =?us-ascii?Q?INRQFP/eWVr+S9TmWbtmNKIj4hbvdJBWlCPSkrTXfh5oYbA8DhUSmIYivZHO?=
 =?us-ascii?Q?aIDyBuUlmCQdjnC50Dd9Kuq1K0N3NQuLm8TNsgQlnxQu4croHFa+jYE/AcEn?=
 =?us-ascii?Q?n3PPBOot3rLLKF/Dm/a55/DpPdY37NiP25KDGksdlsL49KB2BU3Nnh+hMTGh?=
 =?us-ascii?Q?po4ngYvgD4s5TEeij1Q+J+JvurKeS1wJvNsbCiysS1/Or2FgPKN3CseFRL5H?=
 =?us-ascii?Q?KOiGbLWw7obJqzohYcagXjjMOM1kfQJBXhprTGLd+L+Nk7LOoxto66riwMXm?=
 =?us-ascii?Q?zEyh7Vbt9aPPQPTO0Fm/E+g/J+MK7vV2Dlj2JSgla2uLLytOkPRiurUTNOUI?=
 =?us-ascii?Q?1eAXZHSnETOfyiF8kiM7aBbLAvuMjRN1pepslOrGQxFL7mjZx2jS+yM+f/DW?=
 =?us-ascii?Q?WDwaAvB3/qvMBMBP5S+3YhmwNsldDeeXFBnLwUJSNd0167DYYgNImRcmytof?=
 =?us-ascii?Q?Bq6bj4RH6rNFvKGbxMg4xZF7QG6Owwlzoepwg3LNDkOv4qsHXCs5UZ+IYSYw?=
 =?us-ascii?Q?MXDuI0qVRRmxLpaCtqoIjgvL5IQh0xNxOGKI9DZgJBG84ZU3kIK/8rrQemGI?=
 =?us-ascii?Q?Oh/nX5ALnBjDqyTtfdQmjWUZDJAlqePPAur/q8hw/ZQdUOoWFjf/oaLPzs5B?=
 =?us-ascii?Q?xz86a11+0bXWlKUrZvcrNpZSl2LOkQ572bCr5JB1LfqRqBBPbbeHv3fRSCr6?=
 =?us-ascii?Q?CW2vSjBQiW48K3Av7vng8x+wyfj1ZA8Wl0R1fZDGal8lZVS5u9PXZi6cVCxJ?=
 =?us-ascii?Q?CiTy3yYuVT2791ncLCaIxt1fSCquhq1peCw/ovGtGdS2oXBXwZujXNdg6MA5?=
 =?us-ascii?Q?yD+ShatTC+4Tbdb7GylDgnkv?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dbeaef9-d388-48fc-eec6-08d9588504b9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2021 02:50:58.4308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oxAjS7oa6QmZ/H7Mp00Eb5u0yzUZ2BoCxE+oonQ3FQsTjA4OkoOOzCya8K5Jv94z6l+yLWrCOE0znWiKo9ZFy3gK7NC0nrxFfgmh1DaANrg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5564
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10067 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108060015
X-Proofpoint-ORIG-GUID: Mev_vRKpXFMxWcawbAqssymaSZ48L-Gm
X-Proofpoint-GUID: Mev_vRKpXFMxWcawbAqssymaSZ48L-Gm
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


> Since patch 1/2 went in through Greg's tree, if patch 2/2 goes
> upstream via Martin's tree, will the resulting kernel be bisectable if
> Linus pulls Martin's tree before he pulls Greg's tree?

Also, this patch will need to be rebased on top of 5.15/scsi-staging due
to all the UFS churn in this release.

-- 
Martin K. Petersen	Oracle Linux Engineering
