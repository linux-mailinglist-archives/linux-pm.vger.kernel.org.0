Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1FEC3D6D2B
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jul 2021 06:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbhG0EPv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Jul 2021 00:15:51 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:30544 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229954AbhG0EPs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jul 2021 00:15:48 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16R4C2TR027248;
        Tue, 27 Jul 2021 04:15:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=319nXMEtdSxCgP9tUg3fD73XzUQBKH1V18oi1F47/ko=;
 b=Zh7vAvGKoOgTiApUaskpmetyIRW9dtOvCBnwZnx+yA85YmxAzFrceqQMkp5t9GIAepJS
 4R9h2C+VKmbSPU9Dv5eC4228pZKYVGPvMC1KD6iwWLN3lveQh/eYVSFmI5JA31DIiGjk
 9rnmpIL3B/GlrJAN7VgnBNki2CWq9qdI+cfrXb/zxHkZ53QF2fwXF7+i/PWMtSpvxLCb
 lPpXgTL2pi5XTqDvyG916L1OdEXv1wEzi5jhfn56L+UD6JQpiK5q4k+xOO0xVNY9ovpQ
 d4+cqmyXoKowGM2NPT9Y3Db52pF4MI2+bjam42+5Y86z4LsgBpbJbsEk2AbgOuYs4ekt 4w== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=319nXMEtdSxCgP9tUg3fD73XzUQBKH1V18oi1F47/ko=;
 b=vJndWC6WAYjI9Ra/8r7lxB2T2otd8Vyc358tzUH15ibHKRAUqat56hBB1/uT+3GvdXkx
 yJfno8cA8lZI/TLVthpqflMrzAJScuwDUoZCqOsBhSILEMfiL+RrDMtdN6oEnZxwT8xh
 iwc+hPhdnpO++xS8twGYrOcyBaT8AIOUuLFsAbSYzasiOhSwWQJUKRlv26nZL+H9xXLO
 JNw2aw33sPZIGsovWJmE1CkYBqZj7VVyyLvtJxrofuN/sXI2Ll3n5xF+i72AX6pje4ag
 4PM8vpp8NLmMXOekWZ96Kx+xRyLMfo139gpAC/sBUZtei46SBSUIAFAqLgkNg5lXlhqd ig== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a235drp5q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jul 2021 04:15:04 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16R4Ah81106793;
        Tue, 27 Jul 2021 04:15:03 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by userp3020.oracle.com with ESMTP id 3a234uq4ja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jul 2021 04:15:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZOQtqWgDvz80jklWJDgsXaAK6u1uKDg3t1OSPAXAq/ZvJkhKdHCgqTHQzDKEDVAwtw+XWj818JLxVvY1iHPd1pyLsNEZpo+4XF63pLp+VyMlM5Qd8TORrMlRwsFavMavNW/VAzqy7Ho1oyk9gHHflEc6TqiCaGohXkSP7nc7qd2ZhEcePDYanBPoApDeDowtq8TJE9Btu+CXYgwm5chP7wHbdsm/mzi9emv96RxsOjADsEb59T1SDZC2vfAZj5NHbAk2DNgmEb+DbrJSSBcwf66VM9zHS5LSIafCuMqtESB5eTfVHITIFlPzZ4+XmFlopa3PSpgL5FZcmj3uf/b8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=319nXMEtdSxCgP9tUg3fD73XzUQBKH1V18oi1F47/ko=;
 b=HfdSGMmFq84cOpupVU9Ah+B1UaSAYRUAmfn1nPYNrpKTPhOsHbL2OkQSHtxa2reUGeEXUDQxadOA3E5szwr6ZXb69dzJxAYx4bbb25VQ3AeiCWkLPNiJF3GXSL2iukQ6sJONHdd+4XZTYa64nw5qZ56fkhgDvcN+l5VZDv/+ROL+nLNLrOtfcG4QB0i669dJxtoyVEeVOF9X/PCM6PaYgI1vCtrkgS2Oi9cxoQxFKQ7HLwEHSoty3V0ttWwkd4WksPo40Tf7pWR4Fh56S+w8hOyyz+ubemge1ZzUo+xC5lKYDiGzlvaMFebAUZWGKvT8X3RXAK9fRvxa3yCfa97WUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=319nXMEtdSxCgP9tUg3fD73XzUQBKH1V18oi1F47/ko=;
 b=P8nyw+bMPqr4ks2fVuIXogv6Y4/knPs9KQ0GPx0xJliY8lxv6TXMkJTsevoec7zwWmzm6BSDtlQR+VdSvog6TZb76zOTadXPwjvxMGa7Gn8f+f9bnsu5mA7WfdkclDEw9vXr/6zpcAWlSFidXxHolbBTGftQRYYh8iNcoT7sV/M=
Authentication-Results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=oracle.com;
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB4776.namprd10.prod.outlook.com (2603:10b6:510:3f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.28; Tue, 27 Jul
 2021 04:15:01 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::153e:22d1:d177:d4f1]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::153e:22d1:d177:d4f1%8]) with mapi id 15.20.4352.031; Tue, 27 Jul 2021
 04:15:01 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     bvanassche@acm.org, Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        stern@rowland.harvard.edu, hch@infradead.org, jejb@linux.ibm.com,
        linux-pm@vger.kernel.org, kernel@puri.sm
Subject: Re: [PATCH v6 0/3] fix runtime PM for SD card readers
Date:   Tue, 27 Jul 2021 00:14:55 -0400
Message-Id: <162735928263.14097.780228342442715900.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210704075403.147114-1-martin.kepplinger@puri.sm>
References: <20210704075403.147114-1-martin.kepplinger@puri.sm>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0102.namprd04.prod.outlook.com
 (2603:10b6:806:122::17) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ca-mkp.mkp.ca.oracle.com (138.3.201.9) by SN7PR04CA0102.namprd04.prod.outlook.com (2603:10b6:806:122::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24 via Frontend Transport; Tue, 27 Jul 2021 04:15:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 832ef073-a0f9-42f6-c56b-08d950b51a32
X-MS-TrafficTypeDiagnostic: PH0PR10MB4776:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR10MB47768A08B3877C4D0B781DA98EE99@PH0PR10MB4776.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oIKxuPvTjetb2m91abi/eKNdrEYKnoCT2MQLrS88qZYxFtce8cd+1VLsryLbqX/GPt6pMtFuXercmwBNw3aLfoTJiLJ2zowi7EQcUwgEeInyyS3ron1h5OuYVybyzqdAOrC0iUOiib2ALwNNfNvY8LmVbAo4/PYMtnA2Hhtuzw3ak0vgVEtmUOXzc/bDm3m35eanLwJuqoVW9/w0kFAUPlBbQaHpGZwiS/DJRwtmNwsB/nUaywBe8nt3mC6qKOCaAPuWCvujU4THLvpuZbwijnuvTiYjcd+4csILcM37GhHYK0uWTprpi9fHYsc9aHjCTgMetibbCrrLvnm289kbVIpau5qUzwKOP9jeUZc3LPgu4kNPxLPwddK1a+QfmnIUogovVV0P0wb5klwCh+o1JApEqG426VwLHjbWoNKTvW8d/4sDxu7jZSE9dqFoMMHrCP2YeFSMf/jq3qASFssoKTvIv7GjAmiSF8EVTADmyUlBC45MtOHj/7dtgdoilPhMePucgeyRWEwiCr7KvAqWeudHDbWMspJv6PV/sVXF2s0VQUMIbhAlN9yM2IF7v4uW5cyNNdImyBUPo754ddrALecaKaZ916+TKqyFG+SPIDpPWaOptGjy6y9IdXWQACdXcsRRt0d0E9wvdUqKzr8pUqDfDw/qAZKZRoVgpXfX8qOAlZ1vFMtlwYiqfRFI/C1GMjBPB1sS/WElQ9KnijjrBJKdSeaPkE5GVTLIfXG4GJ4vQvys1pV6HZYA7fx6hiSHqw0XOnMuNOT5s4PPJ/MRRfCcGugduoGv4piRtW1FO9K+6JFRkWdXWrOqu49+QdX6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(366004)(396003)(346002)(376002)(38100700002)(86362001)(26005)(6916009)(38350700002)(4744005)(966005)(6666004)(66946007)(66556008)(7696005)(52116002)(478600001)(6486002)(4326008)(956004)(66476007)(8676002)(5660300002)(2616005)(36756003)(83380400001)(316002)(2906002)(8936002)(186003)(103116003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2w1U0xyWWdiRGt5WjErRlJGcjlSeGJYWmYzQTJISlo0ZmFZaVJ6ZGc1S2E4?=
 =?utf-8?B?NWFhYVFmemIxNFRXdUE3VTQ0dDNVeVo5WjE1VCt3Z0c2VmJvRGQwWWxYcUN0?=
 =?utf-8?B?eHBXMEpNYldwdmVXOFIybkxQbVlENjk2VVF2RExaTTdKOFBmZmpUcENjeVJz?=
 =?utf-8?B?WXVUR1R6Y2Z0Mzl6TDluSktiQ2ZLL0FhaFJOMGJLOTZFU1NSSnFiYTVUSHM5?=
 =?utf-8?B?OUJQelVkZUpMVGhMZVpIcnR5UFpmTTNlMDg5VDNGbFY0RGRlMVIvTW9ZK3ZE?=
 =?utf-8?B?ZHFPQjF5SDY4UU5ia3FlT0J3Rlk3LzE4UTdIUTc2VUtuUC82M241eGUzNklo?=
 =?utf-8?B?QXAyRjFQZXRhR0FJcVpGUmNpRC9rNWQyWTZQaUh6WmhPbGFPV1F1ZFNxN0lS?=
 =?utf-8?B?N21sQ28yWFlHOFJyTnAzOGZZb1NZRGhKdVpuSys5VDczL3JSQ3NuNHN3RHBF?=
 =?utf-8?B?aUJBMTBrOHhyQ0UxbEo4ZExQTmJlalFGc0QrMEJsUzVIcTFFdGVpUVNXQ0NR?=
 =?utf-8?B?YmJOODd3YlNFbTFFWWhHQzJYVlM2blRyMkM0T0cvUWsyV1pTc1NkcXFMenU4?=
 =?utf-8?B?T3lSZ1JNbGVlb2x2UFhyNE5sLzFXWVF0T1l3TWVmK0tERytjd1NMeEk1WnZC?=
 =?utf-8?B?T0lWMFBTWFNYRmdSUEtDbVE2bUp0R0wzWmdrR3paYXRCV0hZNjZZemM0YVN1?=
 =?utf-8?B?TXJpQ1dtSFJwa0w3emJvbTZna1dZaHhSOGdub05CVnhrcTU0WmRGUVZLek40?=
 =?utf-8?B?Qzd2VDB6RlMwS1pQcjNhRWdrbnlVZWFKTVExeXA3ZytGejhMZzFBUC9qWUw2?=
 =?utf-8?B?emRWejNlTUpyL3ptOUNaZVdDNnhCNGZzV0VIeXNlY2ZsN2dpeHk5RlNiekQx?=
 =?utf-8?B?QWZoc1NuK3RzTEIrV25aV0F1ajNyTDduMmlWL2o4MStlVnQrNWY1T21iL2pm?=
 =?utf-8?B?UUozQ3VXeVNtWDlDdVBuUTliRzJ4Tjk4QTJucUo5TkZOanRMSFpkajhxWUxI?=
 =?utf-8?B?T0Y1YW5JTG0rbVBMSkpBdnFLRThUVGEzb01lZ2FNMkxzL0VaUlpNekovVHUw?=
 =?utf-8?B?UnUzMW90ZjJUYjUvdDdMZ0xDd3N2Q0EvNk8wOFZpTmlYNms3RmZtaE4weTNJ?=
 =?utf-8?B?RHNqTlFjWXkxaDgxTTFvYWhNcUEvUFp0MkZGcWZNUER1MGJwbUlKZkZiWU5D?=
 =?utf-8?B?UmJGbTIvN3o4TUJxUGhVc08vcURLSnJOVGpyMHZGdFZWSlBpZGl5bExXeEcz?=
 =?utf-8?B?OC82N3VQRVVQL1V5cEgxaytZNUNHUzNoQ2FQVElqWWlqNU5aZGlYeVBDaEdt?=
 =?utf-8?B?K1RiOER1cGxST3dybnFqZnZGYnUyVTFqV2M2MXJCLzh3NVhOYllQOCtLTy9z?=
 =?utf-8?B?QzRqMTdZS1JRUWpBaTBTZ2tlRzFwOTFHVFovVnY5QVJTeTQ2TFNXUENzbFI2?=
 =?utf-8?B?czNlM3NhV1ZLVHRVRkpRWlhFNDg3ME1HbWxrdGFrWGhIV1VEaTI4VThod3FB?=
 =?utf-8?B?RVdHZVVqR0pQbjgrb0N6WkhYZDN3L1c2UnZySmFLNi9YOWlLYTIyTlBwUUJm?=
 =?utf-8?B?OXZ4d1JPeGFwNjBFajcxQ1VBZkJrVEtXVEV6S1I3ZUxFUjJGNTFqYitOY2pH?=
 =?utf-8?B?UzhqSTEzK0Zyb2lCRXJaTXQrZHo3dFc3K3RZb1pSbzY5L3pSVGdjeWVIbUVp?=
 =?utf-8?B?OC8wU1NkOC8yY00vZ3I5cWpFWHJLVG1XR09SK2RJYkY5K1pMa2M4MHRhQ2xD?=
 =?utf-8?Q?VOctAh8NZZBGc5tXiCOFJVceDGsl3U8OJgAkBfJ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 832ef073-a0f9-42f6-c56b-08d950b51a32
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2021 04:15:01.0683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 91u0V+vJuu9WPqvlRlnS/r2SaomfPJ+liqwcf56U7KiMW1R5fz4ZcNVmMloQZ2/AC3YGPoaHXIg24RBGXiiLl02O/BcpqZm9l3MEdToZ7Kg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4776
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10057 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=988 bulkscore=0 mlxscore=0 phishscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107270023
X-Proofpoint-GUID: LqtmHlewBOmL2lwgVJhuHyRKi7OShw0G
X-Proofpoint-ORIG-GUID: LqtmHlewBOmL2lwgVJhuHyRKi7OShw0G
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 4 Jul 2021 09:54:00 +0200, Martin Kepplinger wrote:

> (According to Alan Stern, "as far as I know, all") SD card readers send
> MEDIA_CHANGED unit attention notification on (runtime) resume. We cannot
> use runtime PM with these devices as I/O always fails in that case.
> 
> This fixes runtime PM for SD cardreaders. I'd appreciate any feedback.
> 
> To enable runtime PM for an SD cardreader number 0:0:0:0, do:
> 
> [...]

Applied to 5.15/scsi-queue, thanks!

[1/3] scsi: devinfo: add new flag BLIST_MEDIA_CHANGE
      https://git.kernel.org/mkp/scsi/c/f591a2e0548d
[2/3] scsi: sd: send REQUEST SENSE for BLIST_MEDIA_CHANGE devices in runtime_resume()
      https://git.kernel.org/mkp/scsi/c/ed4246d37f3b
[3/3] scsi: devinfo: add BLIST_MEDIA_CHANGE for Ultra HS-SD/MMC usb cardreaders
      https://git.kernel.org/mkp/scsi/c/9abe677951d1

-- 
Martin K. Petersen	Oracle Linux Engineering
