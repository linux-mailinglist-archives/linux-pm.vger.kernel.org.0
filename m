Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5898D3E516B
	for <lists+linux-pm@lfdr.de>; Tue, 10 Aug 2021 05:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235034AbhHJDVf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Aug 2021 23:21:35 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:15516 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233987AbhHJDVf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Aug 2021 23:21:35 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17A3CJ75019010;
        Tue, 10 Aug 2021 03:21:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=aDNn5MUn0UlUn+FaFAYDGrNsI9A/fjMlNqqSQYJVR80=;
 b=P6od2glQmksopu4Eg2NAn9X5++bMwgCMyATlbZnosteBroBHHv3XJO/jYhho0pEXdBMz
 XAl189p3jR21BTn4HHnpWD2rg/i6I+EbcdcUXYSItcCpn2fbEraKuO2sFEcCrvRo9Dnq
 pAq6e0p9yTJvPZlO/ujA/S3RQEoSYsYOzdLl3UHeNgpYaRV9oAbohnr5XiNxePsiNefV
 MACo6gxs/ell6QgNiDddQcJX0wgFeW8bleEaSNZwjYul5sWA2uKpJ6Sw5sxCYSIwfLbp
 97/EMvNYXyj8wsVP28rMsFjv/1bcm2042D5Tdv4mfA6+0gaY69VOUfJApUcutllnM6rr NA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2020-01-29;
 bh=aDNn5MUn0UlUn+FaFAYDGrNsI9A/fjMlNqqSQYJVR80=;
 b=kBH3Rk+56uMr5ebKAgIx8oAFVcNV0N6cI80+iMe/ciZgaRBOJIXDV2My7xF+Ob/3KOpD
 KYFJ34M2p2LwYEiZyW4ZXujM++PLLo/2n6PFdcFcBBMWl3bgyHkn9eM6PWxwcCcXJae+
 qtob9O3+XNKnLRn1iJBVbTV1AjvKT0PlG2I1wLjY27CKpFlNK9qj2WNOyRCdTTMb5mtN
 JTYbT+S/FJQNQXXVXaqTa1VZR0ow4iZwbgHrzGrsNIPS0AE2UniwXqMHkQWReYRTPp5+
 2Isw1ZwrAfqp1fcA6yY1Yfd3BLeM7xzoFmomOibcJ8wXmpUJkzlAjOoOXoTjmo1WXbxW oQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aaq8aatrv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Aug 2021 03:21:06 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17A3A80N085198;
        Tue, 10 Aug 2021 03:21:04 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by userp3030.oracle.com with ESMTP id 3a9f9w34b5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Aug 2021 03:21:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0Vsii4dNnOM4pDk5exVRy8x/6EP9sPI3NcKdasFbfmujJeOPr0vPi7jnswp8BVXANaVO0p/0byQ25u81gVfTgJe2wnJoZHXs9VNB7utdVa0uafG5v2grtHFYDg4PX2TDlRqSRdRohb28v3dND02wYf54JJqlYb/Tk2dzW+NGcxWx3ZppR6oVxCicasR1iFq/CapqjqsmCwilnARI3NFhGr8nrYhX5hHwx6E6kPoMBrGNLSo73BhXLZetN8fQulOj48Jr58plBmj/JbKYgQCsVarxPoOGtXM9O0y6TA/JLuUg51FS+R7dk6OD95VoC/4LTUpAn6eNbHwZ2I8GnvjVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDNn5MUn0UlUn+FaFAYDGrNsI9A/fjMlNqqSQYJVR80=;
 b=j2adXAZ7ICSYgrnX5HnsEjNSOoQQ8wmZATHLg4M80CazvA/pr7JtY1qLPFezWNcIMA7qWMwkifTppC9cdxoRYn05k9psFGY5OPxDDljnpITZKihTf6dYy9hatBYIWMnkUjhJCXksMsZQ7GwJffC9CuqlW/Kf+XHayI5NruB11jaAJKKCfz7jTHfVRfP4eWtzF9VRo6Q0njt8UxWjchxNGuf2Ioy9aZ7e998+qNhoJui9s1oolH7+bmCfyaQ7ZLR+zI5LPaL1LKzxZ7S2S9XOkAyu7xuxGEUfJQemGJpLSSrSyMaArVt9Zhou3V4nAGzEpFi4BTTSEUoE/W8KXWXP8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDNn5MUn0UlUn+FaFAYDGrNsI9A/fjMlNqqSQYJVR80=;
 b=Q8i0iZGpQgp8oveHdiRDNe6wum9YppbZGEaKvKJYQU9fnI+m5U4Y6sRTlcnnRfRpcU78mDN8q3APTxJg2evbpdF8NDNlTlw16mSizUwYK6tw1/1GhVT5cGJTGWoL3gxPpb9XNBo2v0gDItJech8iM0ntVfJ9IZGLhqnuiNVekIQ=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB5563.namprd10.prod.outlook.com (2603:10b6:510:f2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Tue, 10 Aug
 2021 03:21:02 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c0ed:36a0:7bc8:f2dc]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c0ed:36a0:7bc8:f2dc%6]) with mapi id 15.20.4394.023; Tue, 10 Aug 2021
 03:21:02 +0000
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org, Avri Altman <avri.altman@wdc.com>,
        Bean Huo <huobean@gmail.com>, Can Guo <cang@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V5] scsi: ufshcd: Fix device links when BOOT WLUN fails
 to probe
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1pmumvvce.fsf@ca-mkp.ca.oracle.com>
References: <20210716114408.17320-1-adrian.hunter@intel.com>
        <20210716114408.17320-3-adrian.hunter@intel.com>
        <c78aac34-5c55-f6b6-3450-d5c3f09781fa@intel.com>
        <35b2bd0f-5766-debd-2b4c-c642a85df367@acm.org>
        <yq1czqrguch.fsf@ca-mkp.ca.oracle.com>
        <739a1abf-fca0-458e-5c8c-1d6ed90b56e0@intel.com>
        <a1c9bac8-b560-b662-f0aa-58c7e000cbbd@intel.com>
Date:   Mon, 09 Aug 2021 23:21:00 -0400
In-Reply-To: <a1c9bac8-b560-b662-f0aa-58c7e000cbbd@intel.com> (Adrian Hunter's
        message of "Fri, 6 Aug 2021 16:04:41 +0300")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0236.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::31) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ca-mkp.ca.oracle.com (138.3.200.58) by SJ0PR03CA0236.namprd03.prod.outlook.com (2603:10b6:a03:39f::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16 via Frontend Transport; Tue, 10 Aug 2021 03:21:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61b97948-84eb-48a2-9995-08d95bade1e5
X-MS-TrafficTypeDiagnostic: PH0PR10MB5563:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR10MB55633D284136F6102A3C36F28EF79@PH0PR10MB5563.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TT1+dWLYryBBQFchAkbKK21FuVyrmerbfnlnvKwASWhXuJVP2+rRl0E1+9DvxjoAxEEtEzcA9oN2NrC4b7y6Tkub2/J1xGKE5y5uyZuhumHiC1hXxQVVtNK+EBL7fVujjQoHpoEzK5Gcco3bKVURN5uwLw+VmViWb5gz4syVqHVH8PFSW+CByScs4vJgRB1frKJwaeTEIlND1gi2hOwSvxdOV242dCUtSaXfnJmuTITXp5Z3oqtM2rTd0lUEARmMQUMMj1QRpK18JvMwPjYTPVs0txfdXCtYIkX/YC+hm4xSFdtrsw6CRxB8Kun1yTVMH01TgZPQBgWH8NL6B+pTlsMxyQqA/aMWfhN16p7tGfKPHo9b2dOwxIpCFkfG/XwnJTOot58qgLr+76iEoRUMoGa1eoHaJ+pWiptwMExBg9PKduZ5loHuBqdu83taaRMi9QndBZLVEnNvLGYBZXbrQAmDl/FL4RIDr6sc+Ha2KPgyJZnrQwKEIBVrJWJz4nic9CknPGeokwkj64QQRINWUmYMcyQsrPn2I6XO1YylJ5/LEkEj53TnXfwd43ocT4Gv9OiP5r0QqFGF6TF30qnWjBQkgxbgLTRfqErPENgtnxjTcrmOAtZSGqZ/OJ7QGhLrjUxdiJcrc1hEcihtwztpKMNT2QHCkvyZZX06/u7wLOVSx0+P3LB8L1M3kuM3Ry4z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(136003)(376002)(396003)(366004)(186003)(4326008)(956004)(55016002)(4744005)(86362001)(26005)(2906002)(7416002)(38100700002)(38350700002)(54906003)(478600001)(6916009)(8936002)(5660300002)(52116002)(36916002)(7696005)(83380400001)(8676002)(66946007)(316002)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XkApIZeUnO2jvCYPiAhxsCrM75mnZ4K+V53bySK/7h9V2sgDm0sjA3F2msn0?=
 =?us-ascii?Q?YiAXoB2rb72AsEhIe5ehv28TbZNXO5ze8VYg9dyynb9mRJedy/biogTw/Nui?=
 =?us-ascii?Q?d2ayaRP/LlYzGcfAMiZLG0qkQyaCLvrOftAxwMLFOI8jTGbCVunJFX+Rfbp5?=
 =?us-ascii?Q?DYD+tvs71Nfpjntp0jNDMwNvCUcb9jerpQ9EvtDuiqLOFnwMw1VBNw5OI7Mh?=
 =?us-ascii?Q?kAmI2P9ZaB6PCZHsbrIJoYzcxtMFiYFnaexb3iX2SxoTkRX9KzNtjyHAOXXA?=
 =?us-ascii?Q?XFVOHq3juI81cAmikishViYy3FfPUi1PNI0IcEZhjnKBSrpFftq0oaRdTBTU?=
 =?us-ascii?Q?m/Ut6MEbrcXo+NHnuMqJF2MsyW4yZyzNHeffQp93jAQGALd0s3ny0IXgQPDs?=
 =?us-ascii?Q?JaMWkz0ajYTUZ04qHnJ3guWmsuYniaIjAWOlyjy7cziyQa+Lk71q4Qro9xSf?=
 =?us-ascii?Q?B+FGC29JboxpyCgRLxXXJQLXgW0B1qXWnr8sJKeF2w25EOzHPLbNRRiObEBy?=
 =?us-ascii?Q?s7L06F1I1k9zC9sttotKazoCcbfGp8SRD1KIvjhM8bDz+KzWgtebpqPHki12?=
 =?us-ascii?Q?YlFHAXq+uKxxwVhArI5EmVQyHtc5ylbahbuzdqFy8xMuqr4NUDZno22qrZ78?=
 =?us-ascii?Q?YFR7EyJ0RMRp9yjz8jG9WtON2KiwW5bR9hJNaL8Y3MyaCJJiz5qJcrh09svf?=
 =?us-ascii?Q?RVfFZL5F+6oYiu2cewJNhU31Pk1+pYbnu6Q9f4f8PhDbkFg0Lwb0FpZesB3B?=
 =?us-ascii?Q?aM5jDXWFLrSWu2Vd0bh/FaLarBP3957ypULCRnNvV1tppr2/TdByGt2IsZN1?=
 =?us-ascii?Q?xHt78Zm5Wvu4+HS5GCISles8BhoAbsHfF1sj+0V2UT+zzaLztursbPGDqfIN?=
 =?us-ascii?Q?thkHz4pjtYaGq9w+rMdzx2qamQDzsRU5Lk1TnvjKMnZWEtFYO9psA1+zmtEm?=
 =?us-ascii?Q?upx0EAz1tI4hG7cGTdq4xjhBQZomjZqRW439waNHqppUjHjruWua7hGQla/H?=
 =?us-ascii?Q?jQ2e3YTucG9LULEBqppfihuXZ7D+aSTRgiHDWY/F+BKYQA240qniLmnsqcFi?=
 =?us-ascii?Q?w9lDa5snqX8cv49uDKzZeI6FoXvmoSfJ5O0bHN8fAPWtpgk0pzCblgEjMfui?=
 =?us-ascii?Q?48ege+IdRr/2j/2z94ezMRmcNNyL1VhfUdHbaOyP5RLvMW1pBoq2FUKNwd/v?=
 =?us-ascii?Q?r5idDYZt0lpkkbjGms45qFW8DOPYyGmkSV6G73/n9AxlbIB5JA3nkUC2pvGa?=
 =?us-ascii?Q?0uuqcAoJUoldSIF9VrlFNf52N7W6YXz9YOAOAs4Y8sUOu+sUfLYl0dEHifMY?=
 =?us-ascii?Q?i7j0xyfyB5Ec2fcXsG+1/ImT?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61b97948-84eb-48a2-9995-08d95bade1e5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 03:21:02.7763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7O5SexZtwfWpn7f1GylJiX8wP1OsC2pJ2s1FdqsuDi/MApu5x3a2gIt/oewVQpZ4YsMFpHrIvliXzd9X9CKqDvqxdyIoq3tp7sBjXRHywu4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5563
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10071 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108100019
X-Proofpoint-ORIG-GUID: b54y-D-c0DvfWQQhZoxIiVUGB-aTl5Mk
X-Proofpoint-GUID: b54y-D-c0DvfWQQhZoxIiVUGB-aTl5Mk
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Adrian,

> Managed device links are deleted by device_del(). However it is
> possible to add a device link to a consumer before device_add(), and
> then discovering an error prevents the device from being used. In that
> case normally references to the device would be dropped and the device
> would be deleted.  However the device link holds a reference to the
> device, so the device link and device remain indefinitely (unless the
> supplier is deleted).

Applied to 5.15/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
