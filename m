Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D905D3BE9DE
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jul 2021 16:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbhGGOks (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Jul 2021 10:40:48 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:51436 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231737AbhGGOkr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Jul 2021 10:40:47 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 167EWhUn021897;
        Wed, 7 Jul 2021 14:38:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=ix1ELDvixjyXX5XV6W8iQFmYP9OIJ1l4Og5wlieRSwA=;
 b=whtr+01SPtVLGct7i0vSegtSHa2eXw1WIrYfnaxkRJTBbpLCnk/RXKtsGBNx6xDmnUJy
 3kIl7dyGL0He2EGgclAoblX6Q5LCoycrQh2by0wMWxuTJArcUnXRwcFKyJgnsnrI6J7z
 nr6nVuF0OJhCacmZrzGgGKvZKPw/RFvYgp2HGkUvQaWgQQnqC6EvoxAibZ6JMC0XrzNU
 jqk0gGVFRpzwB6k+cr/VUnysViy/dRdprofbG0FH70zFKpCJqnoEXNeMQOzl0HXXDq9i
 T++IuSreJwDZsqgC32OPO0WCAIEwMZT4zFuB3mPguqDzUeytXMUBpxWNl20Q9Y8EeUOJ ZA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39m3mhc8xy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jul 2021 14:38:03 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 167EUZ0l137501;
        Wed, 7 Jul 2021 14:38:02 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by userp3020.oracle.com with ESMTP id 39k1nx8q04-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jul 2021 14:38:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DdeFTqz2oi+XYNU1tJqivcnEhKf4/NT+z839eiJcDUtGXyUoHcRksiZFqv5868T7ihBOCOb6LfiBikrSQVrfPw4l6pUv99G99X/XS1m2AF4u0PZe5dK+y/ozc367WYY2jD6WeBuathGr9qRtDkB0DE4UrfqFxKGp1XTCkdT1A0UyC1ngQc99og2aA1AS1naG295H/ajmFtppr1Ucv217LgwO+T4vT6vUit9ZLc29R5NOdx+KgaOtYfo/Tn8chYTbGyzF2btp9jkZqj+Lqu42lvQ932JAEDHEpvJD9PQVLO6gvIRjyN77tH6Qxh+3QsJDfDy2XBxYzX79/cNwZWBb9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ix1ELDvixjyXX5XV6W8iQFmYP9OIJ1l4Og5wlieRSwA=;
 b=WKC4kRXqTlZjdZ2p+Zl6EEC87I7utaOEfhWjvWBm8E3BZEso1gbh6rZqCnC6ZfXc/Emmc/cMbQp+jSNrsAc7P8R5EwDTR7jVNE4TiCbyPfYFxMBUo6Zxscvmjb+dQ0tkOv6cDR2Twbh+hON+PA+HNR0CF7pmW8euy4vFTMlIAQh4XxaGqbBAL5jKEuLaJoSDKUFQ+OvTVI1DFcom1TiWf82/I5vI1y/cXSNaE9mcSpJ7Qll0PHJrefhYGYCkF9QugFjkdsIEiswsZ1zkTHblUJzqUICEoCSTjPGb+z1u60QwXg0ABC+K8n5hg1AEJGx4VHdupOCYc5dAtErIDiAv5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ix1ELDvixjyXX5XV6W8iQFmYP9OIJ1l4Og5wlieRSwA=;
 b=pej5A7EO2gOtFSDre3iUXAawnGiE5DbchqRj08BdaRGD78RNHLxTnD52KgV4SDHL3Am8A3JdQlkUSO1kq+2M8KAksbb/ODfoSkuRNb2k39RlvpEfk1A8hp+oJ4ZpyyB8dBGISzh9ZS6fbBwqE0ngV2S89oFnyKmElCBI369MHlA=
Authentication-Results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5411.namprd10.prod.outlook.com
 (2603:10b6:5:35e::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.27; Wed, 7 Jul
 2021 14:38:00 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3413:3c61:5067:ba73]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3413:3c61:5067:ba73%5]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 14:38:00 +0000
Date:   Wed, 7 Jul 2021 17:37:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     cw00.choi@samsung.com
Cc:     linux-pm@vger.kernel.org
Subject: [bug report] PM / devfreq: Remove redundant governor_name from
 struct devfreq
Message-ID: <YOW8OfCxLDXe1XdF@mwanda>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: SG2PR01CA0094.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::20) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mwanda (2a02:6900:8208:1848::16ae) by SG2PR01CA0094.apcprd01.prod.exchangelabs.com (2603:1096:3:15::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21 via Frontend Transport; Wed, 7 Jul 2021 14:37:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc231565-900d-454d-9893-08d94154d1d7
X-MS-TrafficTypeDiagnostic: CO6PR10MB5411:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR10MB5411065AEE72437D545913E58E1A9@CO6PR10MB5411.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:800;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TQG2rSc5SaBUMA1TezzcE4CnjPLkiM3lYZLiGKyb3mrCcOolqAB3zATLOuDyBaIIMJJtQ/ffRPhgdbIkTXezGPm+g91fHDhcE50P7zSShI/rgRAb3rz8P10F4VWk+tIEoBYpt3bqSiXrqSzTs9jJ3WjDeSxbfIF59HWV83JKGGEkMtpazM/SVQ4iLWgqB26GVh5OOs0R2/fSdgzM3pO3npwJYCbJ7BRBbDDjNT2XhZ9eixb7kNeopXljVwh1Wjk8O6tiM2m9dES70IDSRlZXNaKTq/33oR0Uyejl/SqxfjkZ6I3jOSAKlldISbI2skOudsNLOjAynRhxlHQ92S40ldNOYIA63i5n6uznGW4XFL+BOHarcmqNhT8Go0mYPea92iS4kEjswfXWgIxTweBnri3rwaxQT2B9+aBZlqrYmaJSWxjBKsRGcg1M0WBc/Q4sjnopPF7+/l3DYw7yxoA+F/qulTSxlYJxQGn8ZFmZZKCI2YvqcrqhooeqESvFdn7yTasd4g9t2rJGUlh5nkDdk8rcB64pq/Xy9n11rrSpcf4zS4CVI4lt4XHUqMEoRrDiQqXGYVtWrR5dRMfsIm4j1klPNRqGpsQ6E01yv7PS1UiA+v29wZlFy8UBGaSK1ZYmv/HA2mDTnjBsDoRcsY9x8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(366004)(396003)(346002)(39860400002)(478600001)(9686003)(66476007)(86362001)(44832011)(55016002)(83380400001)(316002)(66556008)(66946007)(2906002)(6666004)(8676002)(33716001)(5660300002)(8936002)(6916009)(4744005)(186003)(6496006)(38100700002)(52116002)(4326008)(9576002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4xQYLTFm7eCHfJA7vdfqcjlXAbqYMZJcE4PcvyeI30pfsKAxyQMGewW4LoPy?=
 =?us-ascii?Q?eg4zZuvriLPnFjnBboZY2wlhaZ9hvvRt7JZXdztQmLHenqX7TaZe18TO68/Y?=
 =?us-ascii?Q?deU5Ls8Rl7ci4PWSl5BysEBfho9uMJd82iJsoSdMZfDmspF/C4Bgk4NpJjyf?=
 =?us-ascii?Q?gma1o6SZyYxu5dJgi+ynVFI8wgnqY/dTA7O7LeLEnPy7ViMuP3O+mE0nMxiw?=
 =?us-ascii?Q?PwitzgU9TYb5hANiQCZcXzFdK9sRXlVKfi/F2lp00BJ/vDJQEtGcr1E3ysmu?=
 =?us-ascii?Q?Vo82bDsGoCGIYic7hRl7IsMPmml36H6arWz6MwqSVDQ0v9rod113+5EiK2CG?=
 =?us-ascii?Q?mW7q+otMTu3cKUE5/lIyo6Dtjw4k1rkycvURliY0HtXwQwaoj3mgMwEd6f1o?=
 =?us-ascii?Q?WM6cBkSr7cop5woSI70r09MAmK4XriXO1bQLET1jFKY92kMHiymP0/UhI3Ow?=
 =?us-ascii?Q?EQN+t/vMLVRFDQaH+8CWv1+aI43SueXHU7D3hblgSViU2wqKYAS9X11Zip+C?=
 =?us-ascii?Q?uXNyLs3B32I6GTfxyERxat6RGvPEnqNasvjLHHk0d3FsKf3bVBHZRINZcqhZ?=
 =?us-ascii?Q?65BPgg6RIKWEtmzfW4XlupfGGNmRrrrxt5rbpFF530L8t0wWe7ew87dF9EvF?=
 =?us-ascii?Q?VZiqc34O0sd1VCsCg/qoOqmjW2LSsKNuqNDbnWU1cTqq80aG49jvU3sldkGz?=
 =?us-ascii?Q?9od1BHVMrZAlHanA3itvVsic+kW8g433G2WIPQ0aRcbTXgNruX7H9bUvPSXp?=
 =?us-ascii?Q?8VtNegMmaRbeMwCNQglThU/QTlDaNkvy71Y7SxR5WDPtJYOBb/NY0y+BWJvL?=
 =?us-ascii?Q?9W6oGSFIAAg4KiVK/JAz+zL9tXliitvmiqhB0hyc05vmbmUNvU0IWoWY4MZl?=
 =?us-ascii?Q?Ccai9Ea9gh/oFFvNxfurb3HcsKXMTtVQoBEncR1FQQtheURKXgxsRZWEb9yj?=
 =?us-ascii?Q?iO0EYoudA3bF7vXvGIPjFAxKP29bC/mFGTM7AHIbzmpjfCPjz60rexHXG+ld?=
 =?us-ascii?Q?zwvyAkR66VNX/duR/kGN45FvN8BMnhubeOcFrjEOxNxCvcHmTjiBv9H7q3mK?=
 =?us-ascii?Q?hhnCWckO27xV/XIXR5QhqgODSHPMfPPYRQiMoQoTaXnazNZ+vdTYeE9+2LDT?=
 =?us-ascii?Q?j4XP5wUBxcabnszBSfdn22aapuLvHuqZ46g+D2kIoo173nA/KulECrCZuI+t?=
 =?us-ascii?Q?EUvIYYt4Lx417jPfey0lQN2i/peHQEUU2LfY3GemvgKfVtHE74W+ksbbanck?=
 =?us-ascii?Q?nfyNTcG8ALLQvjCKg5CFfEUy+ywfpIK5j3+Lhnlv1BpI5Nq0r0FGnjkBsGu5?=
 =?us-ascii?Q?Mxt/lr4A9XuVLr0s3HZuCHgUecuN+AhxznbMAyUnUTIA0xSVUUCQ4foIdU/t?=
 =?us-ascii?Q?OxoXZTI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc231565-900d-454d-9893-08d94154d1d7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 14:38:00.4590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gdzhcq7Xkyu5Zhp+lmt17mUcGSogn1D1s9e3VBEt61HR+CoaPqVMugLdVLKIbIToj5Xmv7y4pPRuG8R9becA13dHnuVQ7eiXyvgXlzEGrjY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5411
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10037 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107070086
X-Proofpoint-GUID: qX6xEf-UGJ6v_l-4kBx5SiNPq8Ii99jV
X-Proofpoint-ORIG-GUID: qX6xEf-UGJ6v_l-4kBx5SiNPq8Ii99jV
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

[ It's so weird that I never reported this and also that no one else
  seems to have fixed it... ]

Hello Chanwoo Choi,

This is a semi-automatic email about new static checker warnings.

The patch 96ffcdf239de: "PM / devfreq: Remove redundant governor_name
from struct devfreq" from Oct 20, 2020, leads to the following Smatch
complaint:

    drivers/devfreq/devfreq.c:1272 devfreq_add_governor()
    warn: variable dereferenced before check 'devfreq->governor' (see line 1269)

drivers/devfreq/devfreq.c
  1268	
  1269			if (!strncmp(devfreq->governor->name, governor->name,
                                     ^^^^^^^^^^^^^^^^^^^^^^^^
Dereference

  1270				     DEVFREQ_NAME_LEN)) {
  1271				/* The following should never occur */
                                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
What?!?

  1272				if (devfreq->governor) {
                                    ^^^^^^^^^^^^^^^^^
Checked too late.

  1273					dev_warn(dev,
  1274						 "%s: Governor %s already present\n",

regards,
dan carpenter
