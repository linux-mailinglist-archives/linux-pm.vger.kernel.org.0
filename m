Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6907431FCD
	for <lists+linux-pm@lfdr.de>; Sat,  1 Jun 2019 17:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfFAPkm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Sat, 1 Jun 2019 11:40:42 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:45556 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725980AbfFAPkl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 1 Jun 2019 11:40:41 -0400
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x51FajkG009810;
        Sat, 1 Jun 2019 15:40:12 GMT
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        by mx0b-002e3701.pphosted.com with ESMTP id 2sunkf9ftg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 01 Jun 2019 15:40:11 +0000
Received: from G4W9120.americas.hpqcorp.net (exchangepmrr1.us.hpecorp.net [16.210.21.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g9t5008.houston.hpe.com (Postfix) with ESMTPS id CC7C553;
        Sat,  1 Jun 2019 15:40:10 +0000 (UTC)
Received: from G4W9120.americas.hpqcorp.net (2002:10d2:150f::10d2:150f) by
 G4W9120.americas.hpqcorp.net (2002:10d2:150f::10d2:150f) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Sat, 1 Jun 2019 15:40:10 +0000
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (15.241.52.11) by
 G4W9120.americas.hpqcorp.net (16.210.21.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Sat, 1 Jun 2019 15:40:10 +0000
Received: from AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM (10.169.7.147) by
 AT5PR8401MB0868.NAMPRD84.PROD.OUTLOOK.COM (10.169.7.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.17; Sat, 1 Jun 2019 15:40:07 +0000
Received: from AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::207d:29e:1463:8c27]) by AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::207d:29e:1463:8c27%9]) with mapi id 15.20.1943.016; Sat, 1 Jun 2019
 15:40:07 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "khalid@gonehiking.org" <khalid@gonehiking.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "aacraid@microsemi.com" <aacraid@microsemi.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: RE: [PATCH 2/3] drivers: scsi: remove unnecessary #ifdef MODULE
Thread-Topic: [PATCH 2/3] drivers: scsi: remove unnecessary #ifdef MODULE
Thread-Index: AQHVGIKwDGRd9/ojF029uE3ZhMxagaaG7YPg
Date:   Sat, 1 Jun 2019 15:40:07 +0000
Message-ID: <AT5PR8401MB1169E817136F8B8587C7A716AB1A0@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
References: <1559397700-15585-1-git-send-email-info@metux.net>
 <1559397700-15585-3-git-send-email-info@metux.net>
In-Reply-To: <1559397700-15585-3-git-send-email-info@metux.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2601:2c3:877f:e23c:fddd:5eac:59cb:6dc3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2955e4e2-78df-4b3f-1873-08d6e6a76c7c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AT5PR8401MB0868;
x-ms-traffictypediagnostic: AT5PR8401MB0868:
x-microsoft-antispam-prvs: <AT5PR8401MB086894FDA4FA54C0937C570AAB1A0@AT5PR8401MB0868.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 00550ABE1F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(366004)(346002)(136003)(376002)(189003)(199004)(13464003)(14444005)(256004)(86362001)(76176011)(4326008)(6116002)(14454004)(33656002)(2906002)(7416002)(68736007)(71200400001)(55016002)(54906003)(316002)(6436002)(110136005)(9686003)(4744005)(71190400001)(53936002)(6246003)(1250700005)(25786009)(64756008)(66476007)(66556008)(73956011)(76116006)(7736002)(66946007)(99286004)(478600001)(102836004)(52536014)(81156014)(476003)(229853002)(7696005)(5660300002)(6506007)(53546011)(186003)(305945005)(46003)(486006)(8676002)(66446008)(74316002)(81166006)(446003)(11346002)(2501003)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB0868;H:AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cUe5XGW5Vx0es10ssp/xT+psm28KyuBqDYZTpifpOtZ7R/00HOfBonHjWC40gsCmxtx3x+te2ZNTz0CXoXTurt7SIOLgxKe9zAYtSdSQ1QhaXwFdJzzJJSDRG5RbVlOVmx/bM8YkBw83FphIqsKu1cqZwk9wJ4+AansW9fmjHBJ1krFB+RkcDEKuyTfS6v1ySkNaX/nTfAOtz8f+KR9sNdoQhxlFLw2y+BVgmgye9RG+mGat+2EKkupV3KJ35K9neJAcbzXLkPNDtvqEMnjH1Amc/boOzE7wG3THSopjPsaW7pSFc5eo93vOEATr3r+6c/qFB472ZRSSN5MpLaIZ7b5qKcA5ZYEeov+PCbsGMKmaq0ya1C9Jv/sJZVq8ECWLJkjRUx0bCrw/XgW/UvXXGck40o4+lP/m8puYoAWsewg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2955e4e2-78df-4b3f-1873-08d6e6a76c7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2019 15:40:07.2652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: elliott@hpe.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB0868
X-OriginatorOrg: hpe.com
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-01_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=907 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906010112
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org <linux-kernel-
> owner@vger.kernel.org> On Behalf Of Enrico Weigelt, metux IT consult
> Sent: Saturday, June 01, 2019 9:02 AM
> Subject: [PATCH 2/3] drivers: scsi: remove unnecessary #ifdef MODULE
> 
> The MODULE_DEVICE_TABLE() macro already checks for MODULE defined,
> so the extra check here is not necessary.
> 
...
> diff --git a/drivers/scsi/BusLogic.c b/drivers/scsi/BusLogic.c
...
> 
> -#ifdef MODULE
>  static struct pci_device_id dptids[] = {
>  	{ PCI_DPT_VENDOR_ID, PCI_DPT_DEVICE_ID, PCI_ANY_ID,
> PCI_ANY_ID,},
>  	{ PCI_DPT_VENDOR_ID, PCI_DPT_RAPTOR_DEVICE_ID, PCI_ANY_ID,
> PCI_ANY_ID,},
>  	{ 0, }
>  };
> -#endif
> -
>  MODULE_DEVICE_TABLE(pci,dptids);

I don't see any reply to James' comment that these changes result in
static struct definitions that are unused, which should result in
complaints by the compiler like:
    warning: 'dptids' defined by not used [-Wunused-variable]


