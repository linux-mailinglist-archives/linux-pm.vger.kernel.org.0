Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB535A6F1F
	for <lists+linux-pm@lfdr.de>; Tue, 30 Aug 2022 23:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbiH3V3N (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Aug 2022 17:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiH3V3M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Aug 2022 17:29:12 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2137.outbound.protection.outlook.com [40.107.212.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A2685FC5;
        Tue, 30 Aug 2022 14:29:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mhYdSSyTN8veDDI0wMfCTiW3fv8jPdFyPyuo3ZqVzfFxPl/Os+O0Mq+3dfMjH8gPmNSYVfKJxheKx0LU6W0AtkmcuAfJk9HRHNqPkjxWoWziUfUXVHCjCeOONH8gPVEC67l/0cLUttgz+8S+YN9ouXk9kpBf9t2Es5vZ4ahbUZGI4tMzCUmu+dmofOikfCVN3Ug0L4tI41eD2MynVbyh8bv+K7nAU261whRJmXj7PxFEGW+vGRCBcFcdxZSljopVlWTT5NxycOUnwJu2ZdCNQCJH+OGdu54li1+k8u9Uj3OMgzOR3IJie3PJd1br15v/ZVX4tEHHEt3iWqwWrOy7Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3B4JCiaeFSjD8U/HEEaVytHvRYAMcO2zr6OF3yBcYrM=;
 b=eE7ZLjBdj5kDu6QXqZnZFKl2ZGKsCf8J3XnKRmI1i0hMBgHI4o9J5RJ7gGoShBopJ+lpalrUI0UYO74x9uxBsgqIp0E2XTjIj/IPhS3EFw6gSQ81T0e90a7vkSsE3JQ2L+M1gbdjGgN39/YadpO38zBtgHJMzCCVRXI1b87dryC/HcwVzsxmXKFqi8cVj9pkD90nzjGzdPLqAUTUHd/W3LKQTg4HJfJ7G8OX1Ni7mPlLzkw1tTmMaCqV3FBXjs7/6pqRfjzsW/IIOmGmAjHPlsQt8HRfkMp8vOjpptKo/sPlQhqk84AvTNkyAyZ95D+LQZ18cefWBDH+wqoAWpv7eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3B4JCiaeFSjD8U/HEEaVytHvRYAMcO2zr6OF3yBcYrM=;
 b=EOSbf+aOrVNrZ2LcHE4mSizaShUgYm7Ly7hJi6SMj7RmRyNO3SXN4SPa/mZuS10HSRPicdykF6ybK6MlMuQqkZPEWhExsUcOWkCoDIP2dqL29Gim4iD617nTW8Wk68hwsoD28BLxE1lHrM/wMP/oUlg15gqje6URS6iADGee5rs=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by MN0PR21MB3777.namprd21.prod.outlook.com (2603:10b6:208:3d1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.3; Tue, 30 Aug
 2022 21:29:02 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::3ef0:68d0:970e:24be]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::3ef0:68d0:970e:24be%5]) with mapi id 15.20.5612.002; Tue, 30 Aug 2022
 21:29:01 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Mark Brown <broonie@kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        "Jamet, Michael" <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: RE: [PATCH v2 5/5] ACPI: Drop parent field from struct acpi_device
Thread-Topic: [PATCH v2 5/5] ACPI: Drop parent field from struct acpi_device
Thread-Index: AQHYt9r5ZuMaGsJ/TE24NR6GViGoSa3H/Ctg
Date:   Tue, 30 Aug 2022 21:29:00 +0000
Message-ID: <BYAPR21MB1688D855C1A2A59C2114CFB1D7799@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <12036348.O9o76ZdvQC@kreacher> <2196460.iZASKD2KPV@kreacher>
 <5857822.lOV4Wx5bFT@kreacher>
In-Reply-To: <5857822.lOV4Wx5bFT@kreacher>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5fd760a1-1484-4ffb-b17e-d5b1ec13d73a;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-08-30T21:17:41Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|MN0PR21MB3777:EE_
x-ms-office365-filtering-correlation-id: 8213fa3f-b523-415c-87af-08da8acea7b8
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kFyoaXuZdzUnNE8LlGgbXAKtrQ7I4rVKSwDJR6eDVfhDFO39+SEF5mmU75Fr+AIEKexMhXigZnlE+Xha4qvhIKiwds8DZbW/i8iqZqfPPb0ya2GIGzvcjXFXyoYnFOiESEEOhDT2sVHWC4BkbI976yvqDgUVrhbplPjnAC3fshn7e1uwn7vF6bGM1daWMthihagr3n3jUYg0/H2QZaw4dU/js8QI8F5xPXOxl4tPonBLVx0oSYa5rPb8/HDThK767j92BTk+PDQbHfsq2orRIC56Ila0gruqpK7GXCKt5YGcrJCz2Nt55k31s3rG6ynOUqsLPHlvvfkGa59hOyI/aOVY0/7L+35B1y2cxltAoRYMbbyVnySS5VFF6ztA9u483mCpOH0AdN1nv+zQ180vD5P++PsGuvLODeP1/jVaybXyIF3321ps8bnN48BEDNFm/BE8G7kFybpuG4Q6Au1lD1fB4gT8NlI1g11r27gxZxF28tR1+O9yRK2iGDvSfAziguDmVCpy9wK/GD90jlQHGVXzManbMonr84EMNG8FywHAIwn5zYPqg1YlGnkuXP3LeMk36LwgU0if7AnY2eeMkuxeApAaVs49T6fkNaHV/3068SAmaPMPIVlOT1EfLaxN13OH+KKEZFmlRIZUHZoAWwkakoS3KLulIMmVZa2H0ex6vBYp0xoNo/tmSu0rbF03DbJI0DPq40da4fZiyVw+TYsEw9yNZomrQi4Rprbz9+JjdGtrKzFZ2Xd0rfaH5HA5RTl5FQiq3kUHvjGc0VRQ7RWNRCVbrPPwTEpaa/s9QAm/U8XXpFnn8hB4I6XnXe+tTrydjvHNLUfiuj45wRlGWdUUj++YtGaUg+ZWcDSAXdQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(451199009)(33656002)(83380400001)(82950400001)(82960400001)(478600001)(122000001)(52536014)(66476007)(8676002)(38070700005)(66556008)(4326008)(7416002)(8936002)(66946007)(76116006)(5660300002)(30864003)(64756008)(66446008)(316002)(84970400001)(2906002)(54906003)(38100700002)(86362001)(186003)(55016003)(41300700001)(9686003)(7696005)(71200400001)(26005)(110136005)(6506007)(8990500004)(10290500003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SFF6NExCK09DOTRFSnZxQ3N4cWZaakhjcnRxdStYZEkyNlJiSEZKaDl2RXZV?=
 =?utf-8?B?Y1h0eE82MytQd2lNQ3Nja29WVFVvUUdCMzBFTmN3WndRUEowSnRmSTdRZnhQ?=
 =?utf-8?B?QVJhVjJPWE5rZXpraWR3bXA1VTNuV2VFSUVyQW9KRGxWb1BWQWZSNlBJdmJD?=
 =?utf-8?B?eG1ld3hVd1pWS3ZWeHZ4ZjVCSDhkQ2l4Q2dQZ3cvYzV0TExvazBEN1JDcnVk?=
 =?utf-8?B?dlBPMUwzWWJyTDN3TWMwelNCZkFsWlpMTzUxVkMwOWx2TDBTVnFtNGt6OU82?=
 =?utf-8?B?YmZla3NxZ2xOUC9MYWgydjVoM2hjd0R5RmdQSkR1em85aFk3ZXdodVQzMW1N?=
 =?utf-8?B?R2trY2dZU0dYMjBtNnM1OUkzVkEyVkF6LzErcC93NmtMMU0rdGhNYzRtSTZP?=
 =?utf-8?B?MjVxekdZd3JBbHorclE0Tkw5VVF0eGp4SUJwYzJKTFViZnlIMnZZMTJvbU5q?=
 =?utf-8?B?WjJjQ0tmMHpPVmRES2hZRXZZNkpjN0lyTnZSempTWHRMYkcyQUxPaGxqU3JR?=
 =?utf-8?B?dE1rMFd5VTI3UGo2Z0RBaExFQm5CQ0ROYVZ2bGtNK00vZERaTFNSRzJ4Nnlx?=
 =?utf-8?B?UEtWZlcvbTI5VFdpTUpkL3dadHIrUFhzYXZGMVFETTJ3dTJCVGxtN29ZSENm?=
 =?utf-8?B?eE4xS1gxNkJjTUlMK2JKL05Vc3RmZFRxUGRWSUxnQWpMVGJNTXpGSmVseUxR?=
 =?utf-8?B?c1FYZGtTa2M5VHdtY1YwMVJKdHpxQjRFOElYL3V2c2dDM0hVMFZuZkwrVElt?=
 =?utf-8?B?WThSN2QvT0x1Vi9RVnVWZ0Jlc2tnUXlleVQzZXBKMW9NcVZ3OENJdmFGM1lr?=
 =?utf-8?B?c0RxNVhiQWtxRHdSZ1QvTWEzRWFYQng1V0Z6bzZPRUVVeDhOZkJKOEpIeGlT?=
 =?utf-8?B?dUcwZ1FGV0FpbEtldjkzSTBtSmdOQ2RwMXczSGxwTDdHZ3ZRUUVsMmZsbGo0?=
 =?utf-8?B?Z1hCVkxFVXJZb0F4UXJEUkd2YUxrY1VqUmsxWklDZUliS1BaZGdlMjJKMXlW?=
 =?utf-8?B?V0pHMVhudmdRN2YraTBtY1ZJSmZjWXQ0L2JhVitGdTd3L1RRWTQ3Y2F3Ym1T?=
 =?utf-8?B?TWFnR2dWMU5tek1laXVBYnFheUJQYWJHL1VLT2Y2OEpPd1pFZ2d2YTN2M2xi?=
 =?utf-8?B?cUJQNHBTM3lkWTZxdnF0TFdyNysyR1d4MjN6RFFnTFNNb0dRT3pobzNWdGNi?=
 =?utf-8?B?cU1aV0w4eXpuOVY5VlNnMXlZZWpQVzNWOWZFekJPK2ZFOFE0TUdQYWtLUU5t?=
 =?utf-8?B?M1RMdEhERlRKenpmNkVHNHJ6K3VTSFh1Z3JDR1hEZXZLOTlKTjE0UzFTWE00?=
 =?utf-8?B?c21VeGFzc1VaUkIzeGRrK094YWJpa1VlMkU0VHNpcWtBcG1hTUpBdWlHeVlF?=
 =?utf-8?B?TTVzVDdkekZQLzFuYWc3cWtKTjJlbU52WG1iMXZuK3h2VU5ybGpVWGU3S0V6?=
 =?utf-8?B?RFEyeXA3ME1lbFRYb2lRSXVUbTVRTDBKc1dJU3pxSzJ2c0ZuaGE4U3A5Q00r?=
 =?utf-8?B?Q0hwZzh0UW9FNlozVkRRSnMzSm5uN2VYWHRONmsrV0JnWlhYeU9FV2xhZUd2?=
 =?utf-8?B?bGxqdUlDWjZXaHdJM2trUjMwQnFXRDJFZFU0dnc3Zm0rQ1ljU3pndE0wTlor?=
 =?utf-8?B?REdmRGFmaVBGTjJaVStGeld4NmliZDZyYTMvRmRrODdOb2VvalRnU0M0aDU2?=
 =?utf-8?B?Vys5bnBOaGRuYlQvODAzTXhWem4zekVkMWJYZnZjRUEwb2ROVVpKRHV5SnZX?=
 =?utf-8?B?enRGLy9KOWhIekhCMjZ5c3RHUWZ3ZjZPKzM5SkZGYUhQTFlFNmJLbFpmS1Fp?=
 =?utf-8?B?WWlDTUM1cno2dmQwZHovcXd4ZkJ1OU4rOGxZUWIxR0JpZTFYejl5R1dzN1oz?=
 =?utf-8?B?WGgzdzFXUCs4V3NkUklOUm9sRC9pb052U0lldFdtdGhBVUg0c2hyV0EwTld6?=
 =?utf-8?B?U1owZ0IyM3pwc2NUb3g3QmxKTDB0WnhaeEJYL09JZ0ZBellwYzlISUlRNWww?=
 =?utf-8?B?Y1RjS1JEc1Z0bUtXeFdRclVOTEsweVROcDdkWXE2ZVdUbDJyekZPamRuWnlM?=
 =?utf-8?B?bE1kUGdwN29aa0FWODh6UDBBQzR5RnIwMnp6ak1nVWs5Q1FsUU1uZGgybmlm?=
 =?utf-8?B?aE9oZmx0dGN3dkYwbzFpMmdGT2hxeTdKWWNJUFNidll5dlZsbVl0c1lRYnpj?=
 =?utf-8?B?cGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3777
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

RnJvbTogUmFmYWVsIEouIFd5c29ja2kgPHJqd0Byand5c29ja2kubmV0PiBTZW50OiBXZWRuZXNk
YXksIEF1Z3VzdCAyNCwgMjAyMiAxMDowMCBBTQ0KPiANCj4gVGhlIHBhcmVudCBmaWVsZCBpbiBz
dHJ1Y3QgYWNwaV9kZXZpY2UgaXMsIGluIGZhY3QsIHJlZHVuZGFudCwNCj4gYmVjYXVzZSB0aGUg
ZGV2LnBhcmVudCBmaWVsZCBpbiBpdCBlZmZlY3RpdmVseSBwb2ludHMgdG8gdGhlIHNhbWUNCj4g
b2JqZWN0IGFuZCBpdCBpcyB1c2VkIGJ5IHRoZSBkcml2ZXIgY29yZS4NCj4gDQo+IEFjY29yZGlu
Z2x5LCB0aGUgcGFyZW50IGZpZWxkIGNhbiBiZSBkcm9wcGVkIGZyb20gc3RydWN0IGFjcGlfZGV2
aWNlDQo+IGFuZCBmb3IgdGhpcyBwdXJwb3NlIGRlZmluZSBhY3BpX2Rldl9wYXJlbnQoKSB0byBy
ZXRyaWV2ZSBhIHBhcmVudA0KPiBzdHJ1Y3QgYWNwaV9kZXZpY2UgcG9pbnRlciBmcm9tIHRoZSBk
ZXYucGFyZW50IGZpZWxkIGluIHN0cnVjdA0KPiBhY3BpX2RldmljZS4gIE5leHQsIHVwZGF0ZSBh
bGwgb2YgdGhlIHVzZXJzIG9mIHRoZSBwYXJlbnQgZmllbGQNCj4gaW4gc3RydWN0IGFjcGlfZGV2
aWNlIHRvIHVzZSBhY3BpX2Rldl9wYXJlbnQoKSBpbnN0ZWFkIG9mIGl0IGFuZA0KPiBkcm9wIGl0
Lg0KPiANCj4gV2hpbGUgYXQgaXQsIGRyb3AgdGhlIEFDUElfSVNfUk9PVF9ERVZJQ0UoKSBtYWNy
byB0aGF0IGlzIG9ubHkgdXNlZA0KPiBpbiBvbmUgcGxhY2UgaW4gYSBjb25mdXNpbmcgd2F5Lg0K
PiANCj4gTm8gaW50ZW50aW9uYWwgZnVuY3Rpb25hbCBpbXBhY3QuDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb20+DQo+IEFj
a2VkLWJ5OiBNYXJrIEJyb3duIDxicm9vbmllQGtlcm5lbC5vcmc+DQo+IEFja2VkLWJ5OiBNaWth
IFdlc3RlcmJlcmcgPG1pa2Eud2VzdGVyYmVyZ0BsaW51eC5pbnRlbC5jb20+DQo+IEFja2VkLWJ5
OiBXZWkgTGl1IDx3ZWkubGl1QGtlcm5lbC5vcmc+DQo+IFJldmlld2VkLWJ5OiBQdW5pdCBBZ3Jh
d2FsIDxwdW5pdC5hZ3Jhd2FsQGJ5dGVkYW5jZS5jb20+DQoNClRlc3RlZCB0aGUgZnVsbCBwYXRj
aCBzZXJpZXMgaW4gQXp1cmUgVk1zIHJ1bm5pbmcgb24gSHlwZXItViAtLQ0Kb25lIHg4Ni94NjQg
YW5kIG9uZSBBUk02NC4gIFRlc3RpbmcgaW5jbHVkZXMgc3RhbmRhcmQgVk1idXMNCmRldmljZXMg
YXMgd2VsbCBhcyB2aXJ0dWFsIFBDSSBkZXZpY2VzIChNZWxsYW5veCBDWC01IFZpcnR1YWwNCkZ1
bmN0aW9uKS4gICBWZXJpZmllZCB0aGF0IEFDUEkgZGV2aWNlIGNhY2hlIGNvaGVyZW5jZSBwcm9w
ZXJ0eSBpcw0KcHJvcGFnYXRlZCB0aHJvdWdoIHRoZSBoaWVyYXJjaHkgb2YgZGV2aWNlcyB0aGF0
IHRoZSBWTWJ1cyBhbmQNCkh5cGVyLVYgdmlydHVhbCBQQ0kgZHJpdmVycyBzZXQgdXAuDQoNClRl
c3RlZC1ieTogTWljaGFlbCBLZWxsZXkgPG1pa2VsbGV5QG1pY3Jvc29mdC5jb20+DQoNCj4gLS0t
DQo+IA0KPiB2MSAtPiB2MjoNCj4gICAgKiBDb3ZlciAzIG1vcmUgdXNlcnMgb2YgdGhlIHBhcmVu
dCBmaWVsZCBpbiBzdHJ1Y3QgYWNwaV9kZXZpY2UuDQo+ICAgICogQWRkIHRhZ3MgY29sbGVjdGVk
IHNvIGZhci4NCj4gDQo+IC0tLQ0KPiAgZHJpdmVycy9hY3BpL2FjcGlfYW1iYS5jICAgICB8ICAg
IDUgKysrLS0NCj4gIGRyaXZlcnMvYWNwaS9hY3BpX3BsYXRmb3JtLmMgfCAgICA2ICsrKy0tLQ0K
PiAgZHJpdmVycy9hY3BpL2FjcGlfdmlkZW8uYyAgICB8ICAgIDIgKy0NCj4gIGRyaXZlcnMvYWNw
aS9kZXZpY2VfcG0uYyAgICAgfCAgIDE5ICsrKysrKysrKystLS0tLS0tLS0NCj4gIGRyaXZlcnMv
YWNwaS9wcm9wZXJ0eS5jICAgICAgfCAgICA2ICsrKystLQ0KPiAgZHJpdmVycy9hY3BpL3Nicy5j
ICAgICAgICAgICB8ICAgIDIgKy0NCj4gIGRyaXZlcnMvYWNwaS9zYnNoYy5jICAgICAgICAgfCAg
ICAyICstDQo+ICBkcml2ZXJzL2FjcGkvc2Nhbi5jICAgICAgICAgIHwgICAxNyArKysrKystLS0t
LS0tLS0tLQ0KPiAgZHJpdmVycy9odi92bWJ1c19kcnYuYyAgICAgICB8ICAgIDMgKystDQo+ICBk
cml2ZXJzL3BlcmYvYXJtX2RzdV9wbXUuYyAgIHwgICAgNCArKy0tDQo+ICBkcml2ZXJzL3BlcmYv
cWNvbV9sM19wbXUuYyAgIHwgICAgMyArKy0NCj4gIGRyaXZlcnMvc3BpL3NwaS5jICAgICAgICAg
ICAgfCAgICAyICstDQo+ICBkcml2ZXJzL3RodW5kZXJib2x0L2FjcGkuYyAgIHwgICAgMiArLQ0K
PiAgaW5jbHVkZS9hY3BpL2FjcGlfYnVzLmggICAgICB8ICAgMTAgKysrKysrKysrLQ0KPiAgMTQg
ZmlsZXMgY2hhbmdlZCwgNDYgaW5zZXJ0aW9ucygrKSwgMzcgZGVsZXRpb25zKC0pDQo+IA0KPiBJ
bmRleDogbGludXgtcG0vZHJpdmVycy9hY3BpL3NjYW4uYw0KPiA9PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+IC0tLSBs
aW51eC1wbS5vcmlnL2RyaXZlcnMvYWNwaS9zY2FuLmMNCj4gKysrIGxpbnV4LXBtL2RyaXZlcnMv
YWNwaS9zY2FuLmMNCj4gQEAgLTI5LDggKzI5LDYgQEAgZXh0ZXJuIHN0cnVjdCBhY3BpX2Rldmlj
ZSAqYWNwaV9yb290Ow0KPiAgI2RlZmluZSBBQ1BJX0JVU19ISUQJCQkiTE5YU1lCVVMiDQo+ICAj
ZGVmaW5lIEFDUElfQlVTX0RFVklDRV9OQU1FCQkiU3lzdGVtIEJ1cyINCj4gDQo+IC0jZGVmaW5l
IEFDUElfSVNfUk9PVF9ERVZJQ0UoZGV2aWNlKSAgICAoIShkZXZpY2UpLT5wYXJlbnQpDQo+IC0N
Cj4gICNkZWZpbmUgSU5WQUxJRF9BQ1BJX0hBTkRMRQkoKGFjcGlfaGFuZGxlKWVtcHR5X3plcm9f
cGFnZSkNCj4gDQo+ICBzdGF0aWMgY29uc3QgY2hhciAqZHVtbXlfaGlkID0gImRldmljZSI7DQo+
IEBAIC0xMTEwLDcgKzExMDgsNyBAQCBzdGF0aWMgdm9pZCBhY3BpX2RldmljZV9nZXRfYnVzaWQo
c3RydWN0DQo+ICAJICogVGhlIGRldmljZSdzIEJ1cyBJRCBpcyBzaW1wbHkgdGhlIG9iamVjdCBu
YW1lLg0KPiAgCSAqIFRCRDogU2hvdWxkbid0IHRoaXMgdmFsdWUgYmUgdW5pcXVlICh3aXRoaW4g
dGhlIEFDUEkgbmFtZXNwYWNlKT8NCj4gIAkgKi8NCj4gLQlpZiAoQUNQSV9JU19ST09UX0RFVklD
RShkZXZpY2UpKSB7DQo+ICsJaWYgKCFhY3BpX2Rldl9wYXJlbnQoZGV2aWNlKSkgew0KPiAgCQlz
dHJjcHkoZGV2aWNlLT5wbnAuYnVzX2lkLCAiQUNQSSIpOw0KPiAgCQlyZXR1cm47DQo+ICAJfQ0K
PiBAQCAtMTY0Niw3ICsxNjQ0LDcgQEAgc3RhdGljIHZvaWQgYWNwaV9pbml0X2NvaGVyZW5jeShz
dHJ1Y3QgYQ0KPiAgew0KPiAgCXVuc2lnbmVkIGxvbmcgbG9uZyBjY2EgPSAwOw0KPiAgCWFjcGlf
c3RhdHVzIHN0YXR1czsNCj4gLQlzdHJ1Y3QgYWNwaV9kZXZpY2UgKnBhcmVudCA9IGFkZXYtPnBh
cmVudDsNCj4gKwlzdHJ1Y3QgYWNwaV9kZXZpY2UgKnBhcmVudCA9IGFjcGlfZGV2X3BhcmVudChh
ZGV2KTsNCj4gDQo+ICAJaWYgKHBhcmVudCAmJiBwYXJlbnQtPmZsYWdzLmNjYV9zZWVuKSB7DQo+
ICAJCS8qDQo+IEBAIC0xNjkwLDcgKzE2ODgsNyBAQCBzdGF0aWMgaW50IGFjcGlfY2hlY2tfc2Vy
aWFsX2J1c19zbGF2ZShzDQo+IA0KPiAgc3RhdGljIGJvb2wgYWNwaV9pc19pbmRpcmVjdF9pb19z
bGF2ZShzdHJ1Y3QgYWNwaV9kZXZpY2UgKmRldmljZSkNCj4gIHsNCj4gLQlzdHJ1Y3QgYWNwaV9k
ZXZpY2UgKnBhcmVudCA9IGRldmljZS0+cGFyZW50Ow0KPiArCXN0cnVjdCBhY3BpX2RldmljZSAq
cGFyZW50ID0gYWNwaV9kZXZfcGFyZW50KGRldmljZSk7DQo+ICAJc3RhdGljIGNvbnN0IHN0cnVj
dCBhY3BpX2RldmljZV9pZCBpbmRpcmVjdF9pb19ob3N0c1tdID0gew0KPiAgCQl7IkhJU0kwMTkx
IiwgMH0sDQo+ICAJCXt9DQo+IEBAIC0xNzY3LDEwICsxNzY1LDcgQEAgdm9pZCBhY3BpX2luaXRf
ZGV2aWNlX29iamVjdChzdHJ1Y3QgYWNwaQ0KPiAgCUlOSVRfTElTVF9IRUFEKCZkZXZpY2UtPnBu
cC5pZHMpOw0KPiAgCWRldmljZS0+ZGV2aWNlX3R5cGUgPSB0eXBlOw0KPiAgCWRldmljZS0+aGFu
ZGxlID0gaGFuZGxlOw0KPiAtCWlmIChwYXJlbnQpIHsNCj4gLQkJZGV2aWNlLT5wYXJlbnQgPSBw
YXJlbnQ7DQo+IC0JCWRldmljZS0+ZGV2LnBhcmVudCA9ICZwYXJlbnQtPmRldjsNCj4gLQl9DQo+
ICsJZGV2aWNlLT5kZXYucGFyZW50ID0gcGFyZW50ID8gJnBhcmVudC0+ZGV2IDogTlVMTDsNCj4g
IAlkZXZpY2UtPmRldi5yZWxlYXNlID0gcmVsZWFzZTsNCj4gIAlkZXZpY2UtPmRldi5idXMgPSAm
YWNwaV9idXNfdHlwZTsNCj4gIAlmd25vZGVfaW5pdCgmZGV2aWNlLT5md25vZGUsICZhY3BpX2Rl
dmljZV9md25vZGVfb3BzKTsNCj4gQEAgLTE4NjcsOCArMTg2Miw4IEBAIHN0YXRpYyBpbnQgYWNw
aV9hZGRfc2luZ2xlX29iamVjdChzdHJ1Y3QNCj4gIAlhY3BpX2RldmljZV9hZGRfZmluYWxpemUo
ZGV2aWNlKTsNCj4gDQo+ICAJYWNwaV9oYW5kbGVfZGVidWcoaGFuZGxlLCAiQWRkZWQgYXMgJXMs
IHBhcmVudCAlc1xuIiwNCj4gLQkJCSAgZGV2X25hbWUoJmRldmljZS0+ZGV2KSwgZGV2aWNlLT5w
YXJlbnQgPw0KPiAtCQkJCWRldl9uYW1lKCZkZXZpY2UtPnBhcmVudC0+ZGV2KSA6ICIobnVsbCki
KTsNCj4gKwkJCSAgZGV2X25hbWUoJmRldmljZS0+ZGV2KSwgZGV2aWNlLT5kZXYucGFyZW50ID8N
Cj4gKwkJCQlkZXZfbmFtZShkZXZpY2UtPmRldi5wYXJlbnQpIDogIihudWxsKSIpOw0KPiANCj4g
IAkqY2hpbGQgPSBkZXZpY2U7DQo+ICAJcmV0dXJuIDA7DQo+IEluZGV4OiBsaW51eC1wbS9pbmNs
dWRlL2FjcGkvYWNwaV9idXMuaA0KPiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+IC0tLSBsaW51eC1wbS5vcmlnL2lu
Y2x1ZGUvYWNwaS9hY3BpX2J1cy5oDQo+ICsrKyBsaW51eC1wbS9pbmNsdWRlL2FjcGkvYWNwaV9i
dXMuaA0KPiBAQCAtMzY1LDcgKzM2NSw2IEBAIHN0cnVjdCBhY3BpX2RldmljZSB7DQo+ICAJaW50
IGRldmljZV90eXBlOw0KPiAgCWFjcGlfaGFuZGxlIGhhbmRsZTsJCS8qIG5vIGhhbmRsZSBmb3Ig
Zml4ZWQgaGFyZHdhcmUgKi8NCj4gIAlzdHJ1Y3QgZndub2RlX2hhbmRsZSBmd25vZGU7DQo+IC0J
c3RydWN0IGFjcGlfZGV2aWNlICpwYXJlbnQ7DQo+ICAJc3RydWN0IGxpc3RfaGVhZCB3YWtldXBf
bGlzdDsNCj4gIAlzdHJ1Y3QgbGlzdF9oZWFkIGRlbF9saXN0Ow0KPiAgCXN0cnVjdCBhY3BpX2Rl
dmljZV9zdGF0dXMgc3RhdHVzOw0KPiBAQCAtNDU4LDYgKzQ1NywxNCBAQCBzdGF0aWMgaW5saW5l
IHZvaWQgKmFjcGlfZHJpdmVyX2RhdGEoc3RyDQo+ICAjZGVmaW5lIHRvX2FjcGlfZGV2aWNlKGQp
CWNvbnRhaW5lcl9vZihkLCBzdHJ1Y3QgYWNwaV9kZXZpY2UsIGRldikNCj4gICNkZWZpbmUgdG9f
YWNwaV9kcml2ZXIoZCkJY29udGFpbmVyX29mKGQsIHN0cnVjdCBhY3BpX2RyaXZlciwgZHJ2KQ0K
PiANCj4gK3N0YXRpYyBpbmxpbmUgc3RydWN0IGFjcGlfZGV2aWNlICphY3BpX2Rldl9wYXJlbnQo
c3RydWN0IGFjcGlfZGV2aWNlICphZGV2KQ0KPiArew0KPiArCWlmIChhZGV2LT5kZXYucGFyZW50
KQ0KPiArCQlyZXR1cm4gdG9fYWNwaV9kZXZpY2UoYWRldi0+ZGV2LnBhcmVudCk7DQo+ICsNCj4g
KwlyZXR1cm4gTlVMTDsNCj4gK30NCj4gKw0KPiAgc3RhdGljIGlubGluZSB2b2lkIGFjcGlfc2V0
X2RldmljZV9zdGF0dXMoc3RydWN0IGFjcGlfZGV2aWNlICphZGV2LCB1MzIgc3RhKQ0KPiAgew0K
PiAgCSooKHUzMiAqKSZhZGV2LT5zdGF0dXMpID0gc3RhOw0KPiBAQCAtNDc4LDYgKzQ4NSw3IEBA
IHZvaWQgYWNwaV9pbml0aWFsaXplX2hwX2NvbnRleHQoc3RydWN0IGENCj4gIC8qIGFjcGlfZGV2
aWNlLmRldi5idXMgPT0gJmFjcGlfYnVzX3R5cGUgKi8NCj4gIGV4dGVybiBzdHJ1Y3QgYnVzX3R5
cGUgYWNwaV9idXNfdHlwZTsNCj4gDQo+ICtzdHJ1Y3QgYWNwaV9kZXZpY2UgKmFjcGlfZGV2X3Bh
cmVudChzdHJ1Y3QgYWNwaV9kZXZpY2UgKmFkZXYpOw0KPiAgaW50IGFjcGlfYnVzX2Zvcl9lYWNo
X2RldihpbnQgKCpmbikoc3RydWN0IGRldmljZSAqLCB2b2lkICopLCB2b2lkICpkYXRhKTsNCj4g
IGludCBhY3BpX2Rldl9mb3JfZWFjaF9jaGlsZChzdHJ1Y3QgYWNwaV9kZXZpY2UgKmFkZXYsDQo+
ICAJCQkgICAgaW50ICgqZm4pKHN0cnVjdCBhY3BpX2RldmljZSAqLCB2b2lkICopLCB2b2lkICpk
YXRhKTsNCj4gSW5kZXg6IGxpbnV4LXBtL2RyaXZlcnMvYWNwaS9wcm9wZXJ0eS5jDQo+ID09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT0NCj4gLS0tIGxpbnV4LXBtLm9yaWcvZHJpdmVycy9hY3BpL3Byb3BlcnR5LmMNCj4gKysr
IGxpbnV4LXBtL2RyaXZlcnMvYWNwaS9wcm9wZXJ0eS5jDQo+IEBAIC0zMDQsOCArMzA0LDEwIEBA
IHN0YXRpYyB2b2lkIGFjcGlfaW5pdF9vZl9jb21wYXRpYmxlKHN0cnUNCj4gIAkJcmV0ID0gYWNw
aV9kZXZfZ2V0X3Byb3BlcnR5KGFkZXYsICJjb21wYXRpYmxlIiwNCj4gIAkJCQkJICAgIEFDUElf
VFlQRV9TVFJJTkcsICZvZl9jb21wYXRpYmxlKTsNCj4gIAkJaWYgKHJldCkgew0KPiAtCQkJaWYg
KGFkZXYtPnBhcmVudA0KPiAtCQkJICAgICYmIGFkZXYtPnBhcmVudC0+ZmxhZ3Mub2ZfY29tcGF0
aWJsZV9vaykNCj4gKwkJCXN0cnVjdCBhY3BpX2RldmljZSAqcGFyZW50Ow0KPiArDQo+ICsJCQlw
YXJlbnQgPSBhY3BpX2Rldl9wYXJlbnQoYWRldik7DQo+ICsJCQlpZiAocGFyZW50ICYmIHBhcmVu
dC0+ZmxhZ3Mub2ZfY29tcGF0aWJsZV9vaykNCj4gIAkJCQlnb3RvIG91dDsNCj4gDQo+ICAJCQly
ZXR1cm47DQo+IEluZGV4OiBsaW51eC1wbS9kcml2ZXJzL2FjcGkvZGV2aWNlX3BtLmMNCj4gPT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PQ0KPiAtLS0gbGludXgtcG0ub3JpZy9kcml2ZXJzL2FjcGkvZGV2aWNlX3BtLmMNCj4g
KysrIGxpbnV4LXBtL2RyaXZlcnMvYWNwaS9kZXZpY2VfcG0uYw0KPiBAQCAtNzQsNiArNzQsNyBA
QCBzdGF0aWMgaW50IGFjcGlfZGV2X3BtX2V4cGxpY2l0X2dldChzdHJ1DQo+ICAgKi8NCj4gIGlu
dCBhY3BpX2RldmljZV9nZXRfcG93ZXIoc3RydWN0IGFjcGlfZGV2aWNlICpkZXZpY2UsIGludCAq
c3RhdGUpDQo+ICB7DQo+ICsJc3RydWN0IGFjcGlfZGV2aWNlICpwYXJlbnQgPSBhY3BpX2Rldl9w
YXJlbnQoZGV2aWNlKTsNCj4gIAlpbnQgcmVzdWx0ID0gQUNQSV9TVEFURV9VTktOT1dOOw0KPiAg
CWludCBlcnJvcjsNCj4gDQo+IEBAIC04Miw4ICs4Myw3IEBAIGludCBhY3BpX2RldmljZV9nZXRf
cG93ZXIoc3RydWN0IGFjcGlfZGUNCj4gDQo+ICAJaWYgKCFkZXZpY2UtPmZsYWdzLnBvd2VyX21h
bmFnZWFibGUpIHsNCj4gIAkJLyogVEJEOiBOb24tcmVjdXJzaXZlIGFsZ29yaXRobSBmb3Igd2Fs
a2luZyB1cCBoaWVyYXJjaHkuICovDQo+IC0JCSpzdGF0ZSA9IGRldmljZS0+cGFyZW50ID8NCj4g
LQkJCWRldmljZS0+cGFyZW50LT5wb3dlci5zdGF0ZSA6IEFDUElfU1RBVEVfRDA7DQo+ICsJCSpz
dGF0ZSA9IHBhcmVudCA/IHBhcmVudC0+cG93ZXIuc3RhdGUgOiBBQ1BJX1NUQVRFX0QwOw0KPiAg
CQlnb3RvIG91dDsNCj4gIAl9DQo+IA0KPiBAQCAtMTIyLDEwICsxMjIsMTAgQEAgaW50IGFjcGlf
ZGV2aWNlX2dldF9wb3dlcihzdHJ1Y3QgYWNwaV9kZQ0KPiAgCSAqIHBvaW50LCB0aGUgZmFjdCB0
aGF0IHRoZSBkZXZpY2UgaXMgaW4gRDAgaW1wbGllcyB0aGF0IHRoZSBwYXJlbnQgaGFzDQo+ICAJ
ICogdG8gYmUgaW4gRDAgdG9vLCBleGNlcHQgaWYgaWdub3JlX3BhcmVudCBpcyBzZXQuDQo+ICAJ
ICovDQo+IC0JaWYgKCFkZXZpY2UtPnBvd2VyLmZsYWdzLmlnbm9yZV9wYXJlbnQgJiYgZGV2aWNl
LT5wYXJlbnQNCj4gLQkgICAgJiYgZGV2aWNlLT5wYXJlbnQtPnBvd2VyLnN0YXRlID09IEFDUElf
U1RBVEVfVU5LTk9XTg0KPiAtCSAgICAmJiByZXN1bHQgPT0gQUNQSV9TVEFURV9EMCkNCj4gLQkJ
ZGV2aWNlLT5wYXJlbnQtPnBvd2VyLnN0YXRlID0gQUNQSV9TVEFURV9EMDsNCj4gKwlpZiAoIWRl
dmljZS0+cG93ZXIuZmxhZ3MuaWdub3JlX3BhcmVudCAmJiBwYXJlbnQgJiYNCj4gKwkgICAgcGFy
ZW50LT5wb3dlci5zdGF0ZSA9PSBBQ1BJX1NUQVRFX1VOS05PV04gJiYNCj4gKwkgICAgcmVzdWx0
ID09IEFDUElfU1RBVEVfRDApDQo+ICsJCXBhcmVudC0+cG93ZXIuc3RhdGUgPSBBQ1BJX1NUQVRF
X0QwOw0KPiANCj4gIAkqc3RhdGUgPSByZXN1bHQ7DQo+IA0KPiBAQCAtMTU5LDYgKzE1OSw3IEBA
IHN0YXRpYyBpbnQgYWNwaV9kZXZfcG1fZXhwbGljaXRfc2V0KHN0cnUNCj4gICAqLw0KPiAgaW50
IGFjcGlfZGV2aWNlX3NldF9wb3dlcihzdHJ1Y3QgYWNwaV9kZXZpY2UgKmRldmljZSwgaW50IHN0
YXRlKQ0KPiAgew0KPiArCXN0cnVjdCBhY3BpX2RldmljZSAqcGFyZW50ID0gYWNwaV9kZXZfcGFy
ZW50KGRldmljZSk7DQo+ICAJaW50IHRhcmdldF9zdGF0ZSA9IHN0YXRlOw0KPiAgCWludCByZXN1
bHQgPSAwOw0KPiANCj4gQEAgLTE5MSwxMiArMTkyLDEyIEBAIGludCBhY3BpX2RldmljZV9zZXRf
cG93ZXIoc3RydWN0IGFjcGlfZGUNCj4gIAkJcmV0dXJuIC1FTk9ERVY7DQo+ICAJfQ0KPiANCj4g
LQlpZiAoIWRldmljZS0+cG93ZXIuZmxhZ3MuaWdub3JlX3BhcmVudCAmJiBkZXZpY2UtPnBhcmVu
dCAmJg0KPiAtCSAgICBzdGF0ZSA8IGRldmljZS0+cGFyZW50LT5wb3dlci5zdGF0ZSkgew0KPiAr
CWlmICghZGV2aWNlLT5wb3dlci5mbGFncy5pZ25vcmVfcGFyZW50ICYmIHBhcmVudCAmJg0KPiAr
CSAgICBzdGF0ZSA8IHBhcmVudC0+cG93ZXIuc3RhdGUpIHsNCj4gIAkJYWNwaV9oYW5kbGVfZGVi
dWcoZGV2aWNlLT5oYW5kbGUsDQo+ICAJCQkJICAiQ2Fubm90IHRyYW5zaXRpb24gdG8gJXMgZm9y
IHBhcmVudCBpbiAlc1xuIiwNCj4gIAkJCQkgIGFjcGlfcG93ZXJfc3RhdGVfc3RyaW5nKHN0YXRl
KSwNCj4gLQkJCQkgIGFjcGlfcG93ZXJfc3RhdGVfc3RyaW5nKGRldmljZS0+cGFyZW50LQ0KPiA+
cG93ZXIuc3RhdGUpKTsNCj4gKwkJCQkgIGFjcGlfcG93ZXJfc3RhdGVfc3RyaW5nKHBhcmVudC0+
cG93ZXIuc3RhdGUpKTsNCj4gIAkJcmV0dXJuIC1FTk9ERVY7DQo+ICAJfQ0KPiANCj4gSW5kZXg6
IGxpbnV4LXBtL2RyaXZlcnMvYWNwaS9hY3BpX3BsYXRmb3JtLmMNCj4gPT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiAt
LS0gbGludXgtcG0ub3JpZy9kcml2ZXJzL2FjcGkvYWNwaV9wbGF0Zm9ybS5jDQo+ICsrKyBsaW51
eC1wbS9kcml2ZXJzL2FjcGkvYWNwaV9wbGF0Zm9ybS5jDQo+IEBAIC03OCw3ICs3OCw3IEBAIHN0
YXRpYyB2b2lkIGFjcGlfcGxhdGZvcm1fZmlsbF9yZXNvdXJjZSgNCj4gIAkgKiBJZiB0aGUgZGV2
aWNlIGhhcyBwYXJlbnQgd2UgbmVlZCB0byB0YWtlIGl0cyByZXNvdXJjZXMgaW50bw0KPiAgCSAq
IGFjY291bnQgYXMgd2VsbCBiZWNhdXNlIHRoaXMgZGV2aWNlIG1pZ2h0IGNvbnN1bWUgcGFydCBv
ZiB0aG9zZS4NCj4gIAkgKi8NCj4gLQlwYXJlbnQgPSBhY3BpX2dldF9maXJzdF9waHlzaWNhbF9u
b2RlKGFkZXYtPnBhcmVudCk7DQo+ICsJcGFyZW50ID0gYWNwaV9nZXRfZmlyc3RfcGh5c2ljYWxf
bm9kZShhY3BpX2Rldl9wYXJlbnQoYWRldikpOw0KPiAgCWlmIChwYXJlbnQgJiYgZGV2X2lzX3Bj
aShwYXJlbnQpKQ0KPiAgCQlkZXN0LT5wYXJlbnQgPSBwY2lfZmluZF9yZXNvdXJjZSh0b19wY2lf
ZGV2KHBhcmVudCksIGRlc3QpOw0KPiAgfQ0KPiBAQCAtOTcsNiArOTcsNyBAQCBzdGF0aWMgdm9p
ZCBhY3BpX3BsYXRmb3JtX2ZpbGxfcmVzb3VyY2UoDQo+ICBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
ICphY3BpX2NyZWF0ZV9wbGF0Zm9ybV9kZXZpY2Uoc3RydWN0IGFjcGlfZGV2aWNlICphZGV2LA0K
PiAgCQkJCQkJICAgIGNvbnN0IHN0cnVjdCBwcm9wZXJ0eV9lbnRyeQ0KPiAqcHJvcGVydGllcykN
Cj4gIHsNCj4gKwlzdHJ1Y3QgYWNwaV9kZXZpY2UgKnBhcmVudCA9IGFjcGlfZGV2X3BhcmVudChh
ZGV2KTsNCj4gIAlzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2ID0gTlVMTDsNCj4gIAlzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlX2luZm8gcGRldmluZm87DQo+ICAJc3RydWN0IHJlc291cmNlX2Vu
dHJ5ICpyZW50cnk7DQo+IEBAIC0xMzcsOCArMTM4LDcgQEAgc3RydWN0IHBsYXRmb3JtX2Rldmlj
ZSAqYWNwaV9jcmVhdGVfcGxhdA0KPiAgCSAqIGF0dGFjaGVkIHRvIGl0LCB0aGF0IHBoeXNpY2Fs
IGRldmljZSBzaG91bGQgYmUgdGhlIHBhcmVudCBvZiB0aGUNCj4gIAkgKiBwbGF0Zm9ybSBkZXZp
Y2Ugd2UgYXJlIGFib3V0IHRvIGNyZWF0ZS4NCj4gIAkgKi8NCj4gLQlwZGV2aW5mby5wYXJlbnQg
PSBhZGV2LT5wYXJlbnQgPw0KPiAtCQlhY3BpX2dldF9maXJzdF9waHlzaWNhbF9ub2RlKGFkZXYt
PnBhcmVudCkgOiBOVUxMOw0KPiArCXBkZXZpbmZvLnBhcmVudCA9IHBhcmVudCA/IGFjcGlfZ2V0
X2ZpcnN0X3BoeXNpY2FsX25vZGUocGFyZW50KSA6IE5VTEw7DQo+ICAJcGRldmluZm8ubmFtZSA9
IGRldl9uYW1lKCZhZGV2LT5kZXYpOw0KPiAgCXBkZXZpbmZvLmlkID0gLTE7DQo+ICAJcGRldmlu
Zm8ucmVzID0gcmVzb3VyY2VzOw0KPiBJbmRleDogbGludXgtcG0vZHJpdmVycy9hY3BpL2FjcGlf
dmlkZW8uYw0KPiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09DQo+IC0tLSBsaW51eC1wbS5vcmlnL2RyaXZlcnMvYWNwaS9h
Y3BpX3ZpZGVvLmMNCj4gKysrIGxpbnV4LXBtL2RyaXZlcnMvYWNwaS9hY3BpX3ZpZGVvLmMNCj4g
QEAgLTIwMzAsNyArMjAzMCw3IEBAIHN0YXRpYyBpbnQgYWNwaV92aWRlb19idXNfYWRkKHN0cnVj
dCBhY3ANCj4gIAlhY3BpX3N0YXR1cyBzdGF0dXM7DQo+IA0KPiAgCXN0YXR1cyA9IGFjcGlfd2Fs
a19uYW1lc3BhY2UoQUNQSV9UWVBFX0RFVklDRSwNCj4gLQkJCQlkZXZpY2UtPnBhcmVudC0+aGFu
ZGxlLCAxLA0KPiArCQkJCWFjcGlfZGV2X3BhcmVudChkZXZpY2UpLT5oYW5kbGUsIDEsDQo+ICAJ
CQkJYWNwaV92aWRlb19idXNfbWF0Y2gsIE5VTEwsDQo+ICAJCQkJZGV2aWNlLCBOVUxMKTsNCj4g
IAlpZiAoc3RhdHVzID09IEFFX0FMUkVBRFlfRVhJU1RTKSB7DQo+IEluZGV4OiBsaW51eC1wbS9k
cml2ZXJzL2FjcGkvc2JzLmMNCj4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiAtLS0gbGludXgtcG0ub3JpZy9kcml2
ZXJzL2FjcGkvc2JzLmMNCj4gKysrIGxpbnV4LXBtL2RyaXZlcnMvYWNwaS9zYnMuYw0KPiBAQCAt
NjMyLDcgKzYzMiw3IEBAIHN0YXRpYyBpbnQgYWNwaV9zYnNfYWRkKHN0cnVjdCBhY3BpX2RldmkN
Cj4gDQo+ICAJbXV0ZXhfaW5pdCgmc2JzLT5sb2NrKTsNCj4gDQo+IC0Jc2JzLT5oYyA9IGFjcGlf
ZHJpdmVyX2RhdGEoZGV2aWNlLT5wYXJlbnQpOw0KPiArCXNicy0+aGMgPSBhY3BpX2RyaXZlcl9k
YXRhKGFjcGlfZGV2X3BhcmVudChkZXZpY2UpKTsNCj4gIAlzYnMtPmRldmljZSA9IGRldmljZTsN
Cj4gIAlzdHJjcHkoYWNwaV9kZXZpY2VfbmFtZShkZXZpY2UpLCBBQ1BJX1NCU19ERVZJQ0VfTkFN
RSk7DQo+ICAJc3RyY3B5KGFjcGlfZGV2aWNlX2NsYXNzKGRldmljZSksIEFDUElfU0JTX0NMQVNT
KTsNCj4gSW5kZXg6IGxpbnV4LXBtL2RyaXZlcnMvYWNwaS9zYnNoYy5jDQo+ID09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0N
Cj4gLS0tIGxpbnV4LXBtLm9yaWcvZHJpdmVycy9hY3BpL3Nic2hjLmMNCj4gKysrIGxpbnV4LXBt
L2RyaXZlcnMvYWNwaS9zYnNoYy5jDQo+IEBAIC0yNjYsNyArMjY2LDcgQEAgc3RhdGljIGludCBh
Y3BpX3NtYnVzX2hjX2FkZChzdHJ1Y3QgYWNwaQ0KPiAgCW11dGV4X2luaXQoJmhjLT5sb2NrKTsN
Cj4gIAlpbml0X3dhaXRxdWV1ZV9oZWFkKCZoYy0+d2FpdCk7DQo+IA0KPiAtCWhjLT5lYyA9IGFj
cGlfZHJpdmVyX2RhdGEoZGV2aWNlLT5wYXJlbnQpOw0KPiArCWhjLT5lYyA9IGFjcGlfZHJpdmVy
X2RhdGEoYWNwaV9kZXZfcGFyZW50KGRldmljZSkpOw0KPiAgCWhjLT5vZmZzZXQgPSAodmFsID4+
IDgpICYgMHhmZjsNCj4gIAloYy0+cXVlcnlfYml0ID0gdmFsICYgMHhmZjsNCj4gIAlkZXZpY2Ut
PmRyaXZlcl9kYXRhID0gaGM7DQo+IEluZGV4OiBsaW51eC1wbS9kcml2ZXJzL3NwaS9zcGkuYw0K
PiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09DQo+IC0tLSBsaW51eC1wbS5vcmlnL2RyaXZlcnMvc3BpL3NwaS5jDQo+ICsr
KyBsaW51eC1wbS9kcml2ZXJzL3NwaS9zcGkuYw0KPiBAQCAtNDM3NSw3ICs0Mzc1LDcgQEAgc3Rh
dGljIGludCBhY3BpX3NwaV9ub3RpZnkoc3RydWN0IG5vdGlmaQ0KPiANCj4gIAlzd2l0Y2ggKHZh
bHVlKSB7DQo+ICAJY2FzZSBBQ1BJX1JFQ09ORklHX0RFVklDRV9BREQ6DQo+IC0JCWN0bHIgPSBh
Y3BpX3NwaV9maW5kX2NvbnRyb2xsZXJfYnlfYWRldihhZGV2LT5wYXJlbnQpOw0KPiArCQljdGxy
ID0gYWNwaV9zcGlfZmluZF9jb250cm9sbGVyX2J5X2FkZXYoYWNwaV9kZXZfcGFyZW50KGFkZXYp
KTsNCj4gIAkJaWYgKCFjdGxyKQ0KPiAgCQkJYnJlYWs7DQo+IA0KPiBJbmRleDogbGludXgtcG0v
ZHJpdmVycy90aHVuZGVyYm9sdC9hY3BpLmMNCj4gPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiAtLS0gbGludXgtcG0u
b3JpZy9kcml2ZXJzL3RodW5kZXJib2x0L2FjcGkuYw0KPiArKysgbGludXgtcG0vZHJpdmVycy90
aHVuZGVyYm9sdC9hY3BpLmMNCj4gQEAgLTQyLDcgKzQyLDcgQEAgc3RhdGljIGFjcGlfc3RhdHVz
IHRiX2FjcGlfYWRkX2xpbmsoYWNwaQ0KPiAgCSAqLw0KPiAgCWRldiA9IGFjcGlfZ2V0X2ZpcnN0
X3BoeXNpY2FsX25vZGUoYWRldik7DQo+ICAJd2hpbGUgKCFkZXYpIHsNCj4gLQkJYWRldiA9IGFk
ZXYtPnBhcmVudDsNCj4gKwkJYWRldiA9IGFjcGlfZGV2X3BhcmVudChhZGV2KTsNCj4gIAkJaWYg
KCFhZGV2KQ0KPiAgCQkJYnJlYWs7DQo+ICAJCWRldiA9IGFjcGlfZ2V0X2ZpcnN0X3BoeXNpY2Fs
X25vZGUoYWRldik7DQo+IEluZGV4OiBsaW51eC1wbS9kcml2ZXJzL2h2L3ZtYnVzX2Rydi5jDQo+
ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT0NCj4gLS0tIGxpbnV4LXBtLm9yaWcvZHJpdmVycy9odi92bWJ1c19kcnYuYw0K
PiArKysgbGludXgtcG0vZHJpdmVycy9odi92bWJ1c19kcnYuYw0KPiBAQCAtMjQyNyw3ICsyNDI3
LDggQEAgc3RhdGljIGludCB2bWJ1c19hY3BpX2FkZChzdHJ1Y3QgYWNwaV9kZQ0KPiAgCSAqIFNv
bWUgYW5jZXN0b3Igb2YgdGhlIHZtYnVzIGFjcGkgZGV2aWNlIChHZW4xIG9yIEdlbjINCj4gIAkg
KiBmaXJtd2FyZSkgaXMgdGhlIFZNT0QgdGhhdCBoYXMgdGhlIG1taW8gcmFuZ2VzLiBHZXQgdGhh
dC4NCj4gIAkgKi8NCj4gLQlmb3IgKGFuY2VzdG9yID0gZGV2aWNlLT5wYXJlbnQ7IGFuY2VzdG9y
OyBhbmNlc3RvciA9IGFuY2VzdG9yLT5wYXJlbnQpIHsNCj4gKwlmb3IgKGFuY2VzdG9yID0gYWNw
aV9kZXZfcGFyZW50KGRldmljZSk7IGFuY2VzdG9yOw0KPiArCSAgICAgYW5jZXN0b3IgPSBhY3Bp
X2Rldl9wYXJlbnQoYW5jZXN0b3IpKSB7DQo+ICAJCXJlc3VsdCA9IGFjcGlfd2Fsa19yZXNvdXJj
ZXMoYW5jZXN0b3ItPmhhbmRsZSwgTUVUSE9EX05BTUVfX0NSUywNCj4gIAkJCQkJICAgICB2bWJ1
c193YWxrX3Jlc291cmNlcywgTlVMTCk7DQo+IA0KPiBJbmRleDogbGludXgtcG0vZHJpdmVycy9h
Y3BpL2FjcGlfYW1iYS5jDQo+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4gLS0tIGxpbnV4LXBtLm9yaWcvZHJpdmVy
cy9hY3BpL2FjcGlfYW1iYS5jDQo+ICsrKyBsaW51eC1wbS9kcml2ZXJzL2FjcGkvYWNwaV9hbWJh
LmMNCj4gQEAgLTQ4LDYgKzQ4LDcgQEAgc3RhdGljIHZvaWQgYW1iYV9yZWdpc3Rlcl9kdW1teV9j
bGsodm9pZA0KPiAgc3RhdGljIGludCBhbWJhX2hhbmRsZXJfYXR0YWNoKHN0cnVjdCBhY3BpX2Rl
dmljZSAqYWRldiwNCj4gIAkJCQljb25zdCBzdHJ1Y3QgYWNwaV9kZXZpY2VfaWQgKmlkKQ0KPiAg
ew0KPiArCXN0cnVjdCBhY3BpX2RldmljZSAqcGFyZW50ID0gYWNwaV9kZXZfcGFyZW50KGFkZXYp
Ow0KPiAgCXN0cnVjdCBhbWJhX2RldmljZSAqZGV2Ow0KPiAgCXN0cnVjdCByZXNvdXJjZV9lbnRy
eSAqcmVudHJ5Ow0KPiAgCXN0cnVjdCBsaXN0X2hlYWQgcmVzb3VyY2VfbGlzdDsNCj4gQEAgLTk3
LDggKzk4LDggQEAgc3RhdGljIGludCBhbWJhX2hhbmRsZXJfYXR0YWNoKHN0cnVjdCBhYw0KPiAg
CSAqIGF0dGFjaGVkIHRvIGl0LCB0aGF0IHBoeXNpY2FsIGRldmljZSBzaG91bGQgYmUgdGhlIHBh
cmVudCBvZg0KPiAgCSAqIHRoZSBhbWJhIGRldmljZSB3ZSBhcmUgYWJvdXQgdG8gY3JlYXRlLg0K
PiAgCSAqLw0KPiAtCWlmIChhZGV2LT5wYXJlbnQpDQo+IC0JCWRldi0+ZGV2LnBhcmVudCA9IGFj
cGlfZ2V0X2ZpcnN0X3BoeXNpY2FsX25vZGUoYWRldi0+cGFyZW50KTsNCj4gKwlpZiAocGFyZW50
KQ0KPiArCQlkZXYtPmRldi5wYXJlbnQgPSBhY3BpX2dldF9maXJzdF9waHlzaWNhbF9ub2RlKHBh
cmVudCk7DQo+IA0KPiAgCUFDUElfQ09NUEFOSU9OX1NFVCgmZGV2LT5kZXYsIGFkZXYpOw0KPiAN
Cj4gSW5kZXg6IGxpbnV4LXBtL2RyaXZlcnMvcGVyZi9hcm1fZHN1X3BtdS5jDQo+ID09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT0NCj4gLS0tIGxpbnV4LXBtLm9yaWcvZHJpdmVycy9wZXJmL2FybV9kc3VfcG11LmMNCj4gKysr
IGxpbnV4LXBtL2RyaXZlcnMvcGVyZi9hcm1fZHN1X3BtdS5jDQo+IEBAIC02MzksNiArNjM5LDcg
QEAgc3RhdGljIGludCBkc3VfcG11X2R0X2dldF9jcHVzKHN0cnVjdCBkZQ0KPiAgc3RhdGljIGlu
dCBkc3VfcG11X2FjcGlfZ2V0X2NwdXMoc3RydWN0IGRldmljZSAqZGV2LCBjcHVtYXNrX3QgKm1h
c2spDQo+ICB7DQo+ICAjaWZkZWYgQ09ORklHX0FDUEkNCj4gKwlzdHJ1Y3QgYWNwaV9kZXZpY2Ug
KnBhcmVudF9hZGV2ID0gYWNwaV9kZXZfcGFyZW50KEFDUElfQ09NUEFOSU9OKGRldikpOw0KPiAg
CWludCBjcHU7DQo+IA0KPiAgCS8qDQo+IEBAIC02NTMsOCArNjU0LDcgQEAgc3RhdGljIGludCBk
c3VfcG11X2FjcGlfZ2V0X2NwdXMoc3RydWN0DQo+ICAJCQljb250aW51ZTsNCj4gDQo+ICAJCWFj
cGlfZGV2ID0gQUNQSV9DT01QQU5JT04oY3B1X2Rldik7DQo+IC0JCWlmIChhY3BpX2RldiAmJg0K
PiAtCQkJYWNwaV9kZXYtPnBhcmVudCA9PSBBQ1BJX0NPTVBBTklPTihkZXYpLT5wYXJlbnQpDQo+
ICsJCWlmIChhY3BpX2RldiAmJiBhY3BpX2Rldl9wYXJlbnQoYWNwaV9kZXYpID09IHBhcmVudF9h
ZGV2KQ0KPiAgCQkJY3B1bWFza19zZXRfY3B1KGNwdSwgbWFzayk7DQo+ICAJfQ0KPiAgI2VuZGlm
DQo+IEluZGV4OiBsaW51eC1wbS9kcml2ZXJzL3BlcmYvcWNvbV9sM19wbXUuYw0KPiA9PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09DQo+IC0tLSBsaW51eC1wbS5vcmlnL2RyaXZlcnMvcGVyZi9xY29tX2wzX3BtdS5jDQo+ICsr
KyBsaW51eC1wbS9kcml2ZXJzL3BlcmYvcWNvbV9sM19wbXUuYw0KPiBAQCAtNzQyLDcgKzc0Miw4
IEBAIHN0YXRpYyBpbnQgcWNvbV9sM19jYWNoZV9wbXVfcHJvYmUoc3RydWMNCj4gDQo+ICAJbDNw
bXUgPSBkZXZtX2t6YWxsb2MoJnBkZXYtPmRldiwgc2l6ZW9mKCpsM3BtdSksIEdGUF9LRVJORUwp
Ow0KPiAgCW5hbWUgPSBkZXZtX2thc3ByaW50ZigmcGRldi0+ZGV2LCBHRlBfS0VSTkVMLCAibDNj
YWNoZV8lc18lcyIsDQo+IC0JCSAgICAgIGFjcGlfZGV2LT5wYXJlbnQtPnBucC51bmlxdWVfaWQs
IGFjcGlfZGV2LT5wbnAudW5pcXVlX2lkKTsNCj4gKwkJICAgICAgYWNwaV9kZXZfcGFyZW50KGFj
cGlfZGV2KS0+cG5wLnVuaXF1ZV9pZCwNCj4gKwkJICAgICAgYWNwaV9kZXYtPnBucC51bmlxdWVf
aWQpOw0KPiAgCWlmICghbDNwbXUgfHwgIW5hbWUpDQo+ICAJCXJldHVybiAtRU5PTUVNOw0KPiAN
Cj4gDQo+IA0KDQo=
