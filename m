Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95B5643590C
	for <lists+linux-pm@lfdr.de>; Thu, 21 Oct 2021 05:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbhJUDny (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Oct 2021 23:43:54 -0400
Received: from mail-bn8nam12on2089.outbound.protection.outlook.com ([40.107.237.89]:42816
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231295AbhJUDnv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 20 Oct 2021 23:43:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JNj8SSivq91m6o1SpGMX3fVnFxtN6i9l+ZwLHEfnwXhKDE0iFfMjb5gBZcFr299QMLvyiq+aPNppLTPKTqhkL1S2WC/EsQW+zwOM/iUL5wuRW8nPGsVNG91CcPIYEE+ihGrcPAhVvGs+KxGGHYOe8bDxZ0oHTeBVonLNdblBvG7v3Q3/l5Aq4YD2BraDokVvDqzjidxK9cdAWAG5Utd1sFAvgwHO0EjYR5ogidAaST8rbiMF5KHXzF3WeSVADbvUB1dE9ct+aN/ROuyUHA/kWHz0tdAi92nm0aRUZqpYc6ecCUt1S+M5ig0enpai10nne2Ojmg4Skxt7+DtS3sN1Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+F/GwM/+AIGSmFwQARC7h9TIiqUZhdHWJIg+HXZN3o=;
 b=V4+OAxHe9+m/pYftlsQQ/mGjL7UG20iWVjmQ5ZiNr5l13JM+fyL2SnbYb7fNpeEtPHvFdofCgQFntVjdUkCME3fFZ4Fi+Xqd2NGmCT0fk2kWZCyFRANZsqpJUCSdIuO6vZijY/kHVpsrl+HsiGrrA+zYKnxZ4tm8zHSL2oGiwvte+Bi8mgCNsjN7sfqmfFGiHUBrD5zvyvH0817alh9QYN9dlT+AnVyhPNRkjdwC/E9fy9Gh0mOLjBEEOCR1elT7aKsLBIkDdP+kYUTCNpFfxOwYA2N8CBPilmjSHYguGgBPcc2SQYTc02LHJq7bh5m8lMefoQUBVvcAG45M5/juxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+F/GwM/+AIGSmFwQARC7h9TIiqUZhdHWJIg+HXZN3o=;
 b=4pjFbd34FcZQbmNZpM6/6bTS5YXMYa/aWNofRUgrBZPsZ7rD3OakxokCuijQDuP4XESaephK9/2ztgIQHzzqyHpjXs/0FY/Q1DCXtkgW8NsnjaLNaE8TBqZfTjF+GUZr3NBUZnvZ319jlqLYSRSLzfGQBOqHi5XctV+V4aw+tmE=
Received: from CY4PR1201MB0246.namprd12.prod.outlook.com
 (2603:10b6:910:23::16) by CY4PR12MB1285.namprd12.prod.outlook.com
 (2603:10b6:903:3e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Thu, 21 Oct
 2021 03:41:29 +0000
Received: from CY4PR1201MB0246.namprd12.prod.outlook.com
 ([fe80::91ce:4fae:eca6:9456]) by CY4PR1201MB0246.namprd12.prod.outlook.com
 ([fe80::91ce:4fae:eca6:9456%9]) with mapi id 15.20.4608.018; Thu, 21 Oct 2021
 03:41:28 +0000
From:   "Huang, Ray" <Ray.Huang@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: RE: [PATCH v2 04/21] ACPI: CPPC: add cppc enable register function
Thread-Topic: [PATCH v2 04/21] ACPI: CPPC: add cppc enable register function
Thread-Index: AQHXsrXQs9OizRhBckanMP3pgJaGBKvasAqAgAERZ+CAAEb3gIAABpTA
Date:   Thu, 21 Oct 2021 03:41:28 +0000
Message-ID: <CY4PR1201MB02464D6A9A6D9E91D167DF3DECBF9@CY4PR1201MB0246.namprd12.prod.outlook.com>
References: <20210926090605.3556134-1-ray.huang@amd.com>
 <20210926090605.3556134-5-ray.huang@amd.com>
 <CAJZ5v0g58vrHNcOEoWUCKmTxraSTuCzVLffzEAgz7TPa8+TNyw@mail.gmail.com>
 <CY4PR1201MB0246A7ECA4E8143CC6E4933DECBE9@CY4PR1201MB0246.namprd12.prod.outlook.com>
 <CAJZ5v0gaBzSCg_SvH1AEJfXf8xSdAy2wN0Wu-ot-k8hv7OVOyQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0gaBzSCg_SvH1AEJfXf8xSdAy2wN0Wu-ot-k8hv7OVOyQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-21T03:41:25Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=6d631fee-ec30-405f-b854-bced1ff1e8a1;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c25b967d-0c4d-4096-a0c1-08d99444aa6e
x-ms-traffictypediagnostic: CY4PR12MB1285:
x-microsoft-antispam-prvs: <CY4PR12MB1285CA349ED1DEFD8470EA6FECBF9@CY4PR12MB1285.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NPBpCIFDDyoMH9Ez+Mk5FmLWTyh+m2AuPdHBZbxm1k6pIiTRZ7d74CrQgziLtho/ab/Nr3tz7xvy+8oF/f6nPvCt8UeTnKfNMkT/9+G9WNg2mooxzfLqxcug3kCAW9KlX9TOZDW4uUBSYnQmcQsD2jEarzUHqW6Ysutahg/LWczpxiS26phwMRxf7fNB4vJ4UGN/qbV0Ir4Oy81pExc+ho5dvlHSBeU1B5Rkj/dSFDbkhxh1scNgLdkPWtoiDEA2Z/H2Td5XO+SlsD/9eKSDW8MGtWfkNMDrhy18OdXCmHJyq/ksDFrSQ2RcuBKTKEdKw3m/bACsXIYkDxXiM19Fh/FRDyFh86BKQ7dUrUhWTa+/ysweSD0OiKpca3F8x6sbHt7Ezyej/6JwYZFbSdVTZgtSjYLX6M4SecFNzcETkmQiT9Ltbd6uLvkPrvrF51ngBn3gzdCWs8WffRzXtqfPl9EW6h0iF/HyR+XAXrxMgCcLgKkP5EZMKBPi7FjUy1dg+9BdXq3nPeq7vnsUb8G77UpzJdXAZBmc/TJdmtJlnv92nGuaYm7Wv7iB+DtSvnIzh2zpe12xRLsqKHHRaTNGb30UAWm9ZGNDR5t4tQWhanhYLbUsRhm6Svca5fdMZ+HS3o1gHlAY5icGgPpVLk69iWTRQG1F8qWPb0Yl9bogBh8NSDTnjr0pQCgmvScaJ4mmFxT2siIrFex6nC+wb1JPIg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0246.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(6916009)(83380400001)(33656002)(52536014)(66946007)(76116006)(508600001)(66476007)(66446008)(66556008)(71200400001)(64756008)(4326008)(316002)(122000001)(2906002)(38070700005)(6506007)(5660300002)(186003)(7416002)(26005)(38100700002)(7696005)(53546011)(8676002)(9686003)(8936002)(86362001)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0s1TDl1WkZxdWx2TVlPSXZ2UmEzZ1o5Rks4aVZ4ZjZ4T2FIZVB4SnlHQ2JH?=
 =?utf-8?B?d29YNFBlUG9hM05EMVl4OW8wcU15aVppVzJBNnJKTkxMcmR1ODVwWUlMTnE4?=
 =?utf-8?B?bjBoa0Q2WS9ZekpzTkZwTTNrWmJuTkdDQmU5OCtnQngzRkVockpDaHlLWWdp?=
 =?utf-8?B?eEdJUXYzOVlsdTk3bnNCOE5Zb3orRnJycHZXTTRmMmFERTNFUCt6YzNudTBQ?=
 =?utf-8?B?WDNMcDhVVlp0ZitFVWdIWHM2WUdJQkdOdTlQYW5GK1AvV3QyRUJhY2o5bWZh?=
 =?utf-8?B?ZXhXTGdZOFp0SG9xM3MzY1ltRWFaUW9Gd0FoQXRWc0VhV3lGNnBJdk1Jaldi?=
 =?utf-8?B?NU4yV0pkZlIrbzFMZktNbGJHK0RzWFl2NnhYTWI3NjN0WUVJU0RjZnEvUUNs?=
 =?utf-8?B?Snc5ZWtGN2g3YkRRekx2N2prcy9qKytZOU9sS3JxVGFSZmMrVG5Ld294TllY?=
 =?utf-8?B?bytjMms1WDRWQW8rM21LR1E4K0YrSExDbGxhMEtlNFdVLzJrQnJlNm81UzIy?=
 =?utf-8?B?dEk5aEQyeDQrRFpDc3dMNGF4REZJcjJ0eG4rY010QVVtdm1tdk10cW9yUm9D?=
 =?utf-8?B?VjIrNng4RGpqOUFEa2pqNmFqSnVWL1N1bzNyemRmT3JRK3pMSHdoUVRRYXV1?=
 =?utf-8?B?Yk9wVVFYMHJhYUxvaVJ1K09kYk1JTWVjYVV4bENoUXhsRjVVRGxnaUpwSVNH?=
 =?utf-8?B?MUtMQnZ1dXFXRTJYc25GaXRNU3BoejVMSW9pNHJnNWYzVEpEL3ZCZHVpVVp0?=
 =?utf-8?B?Z3ZmNytNZ2FYcW4xeWtoTU1MTytOa2RBbVlIRmEycUkrQkorZTNRYnJsMlVK?=
 =?utf-8?B?eTVCZE1kSmMzQ3NObVdrTVM5cjR6MmUzclR6RzFsUmt5RGJ2cVVzb3RqOFpL?=
 =?utf-8?B?TzhTWlFleW9WQnhNd2JBV1ptL0pTRjA1ZTlLbnU2Z1B6NXpYRGl5RVpJUk5h?=
 =?utf-8?B?dHRxckowMGRpYmNCVVVpc3RTcjd0bjdXcXhEL1ZpYllaRTBuWFUwZDlOTDdj?=
 =?utf-8?B?SDJuVElxam1QcWZSOEZUS1hCQVVoVEVQVUxHdjNFMGJkNWFVNFhUMTNFMkRx?=
 =?utf-8?B?RkpVS3ZkWEtQRDFsTUtoL0xneGVaZFU3Nk00cjgvQWhBR0o0T3pZeGpBR0p3?=
 =?utf-8?B?SlM4SGJ5eW9wMXZOT21yVW1ZZlkyTTNMV2RzUjVXWWkzRmV3M0xYYkVYdzNL?=
 =?utf-8?B?SWhPNktzZXFsd1NyS3hVRkh4UWFoL2MrTVdSclpRdm85OEtlMXpYSkU3SHI3?=
 =?utf-8?B?YzZpS2xvaUZMN25xSW9NdTdhQ0N5OFZpU0NncmF6VWZJSDVQcjRuUTFEWkJy?=
 =?utf-8?B?K0dldU0xS0tHL1ZoaWZoYUsyZWdsWFZtL1BScjZPVWprMWV0MHp5Q2dQZUhm?=
 =?utf-8?B?bGdCTVkzRHJKU2hKYjlxWk9GdFNpYVhYdjlFUEJJc2dZdmJpTlBNZjRicXNs?=
 =?utf-8?B?Mk85UXhud09laDBzdjg5L1Rjd25ZRkd1cVRRUzk3bkJxQVhLSVVTVHpPaTlZ?=
 =?utf-8?B?MTdJS2tkUTNSU3NzYkhqWkszbStCWElkakg1aC9nY1NyMzZKVGhQc0lsN0ZT?=
 =?utf-8?B?dXpXTkt2U1Z4dDMrSEoyRXRiRStuQ05CYk1ZRUhiN1pKTTBvSGNncnlCWjlU?=
 =?utf-8?B?OEJGQWtHUllaREEwVFRUZlNXN3hLOVhLSzhxaUFWc1phVnpTenpnOHRBQkxq?=
 =?utf-8?B?UVdvb1FUU1ROclFHOXkvLzIrMVJsM2gwMjZpU0xkU2tqRi9wbUxBbTBmbTJw?=
 =?utf-8?B?dkhhVjBCMXQ5eFJteTFGSXRTeFh4VURLTXdNUEhYd3cyNmRjenpyTHg5ajR6?=
 =?utf-8?B?U3VNR0tKaDBMblYrdVBpZzRsUW92Qk1pbyt2M2R3NzVIQW1oSjdqVjZKc05E?=
 =?utf-8?B?aXo2NXVlMjJYWitNZXpZSVg4WUJ3ZVc1ZFBlY0F5OFEvaHRaQW1NUlJnT1dJ?=
 =?utf-8?Q?0SaaBoVv/XA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0246.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c25b967d-0c4d-4096-a0c1-08d99444aa6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2021 03:41:28.5250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ruihuang@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1285
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiBGcm9tOiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFdl
ZG5lc2RheSwgT2N0b2JlciAyMCwgMjAyMSA5OjMyIFBNDQo+IFRvOiBIdWFuZywgUmF5IDxSYXku
SHVhbmdAYW1kLmNvbT4NCj4gQ2M6IFJhZmFlbCBKLiBXeXNvY2tpIDxyYWZhZWxAa2VybmVsLm9y
Zz47IFJhZmFlbCBKIC4gV3lzb2NraQ0KPiA8cmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb20+OyBW
aXJlc2ggS3VtYXIgPHZpcmVzaC5rdW1hckBsaW5hcm8ub3JnPjsNCj4gU2h1YWggS2hhbiA8c2to
YW5AbGludXhmb3VuZGF0aW9uLm9yZz47IEJvcmlzbGF2IFBldGtvdiA8YnBAc3VzZS5kZT47DQo+
IFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz47IEluZ28gTW9sbmFyIDxtaW5n
b0BrZXJuZWwub3JnPjsNCj4gTGludXggUE0gPGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz47IFNo
YXJtYSwgRGVlcGFrDQo+IDxEZWVwYWsuU2hhcm1hQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5k
ZXINCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBMaW1vbmNpZWxsbywgTWFyaW8NCj4g
PE1hcmlvLkxpbW9uY2llbGxvQGFtZC5jb20+OyBGb250ZW5vdCwgTmF0aGFuDQo+IDxOYXRoYW4u
Rm9udGVub3RAYW1kLmNvbT47IFN1LCBKaW56aG91IChKb2UpIDxKaW56aG91LlN1QGFtZC5jb20+
Ow0KPiBEdSwgWGlhb2ppYW4gPFhpYW9qaWFuLkR1QGFtZC5jb20+OyBMaW51eCBLZXJuZWwgTWFp
bGluZyBMaXN0IDxsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZz47IHRoZSBhcmNoL3g4
NiBtYWludGFpbmVycyA8eDg2QGtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIg
MDQvMjFdIEFDUEk6IENQUEM6IGFkZCBjcHBjIGVuYWJsZSByZWdpc3RlciBmdW5jdGlvbg0KPiAN
Cj4gT24gV2VkLCBPY3QgMjAsIDIwMjEgYXQgMToxMyBQTSBIdWFuZywgUmF5IDxSYXkuSHVhbmdA
YW1kLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5XQ0KPiA+
DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogUmFmYWVsIEou
IFd5c29ja2kgPHJhZmFlbEBrZXJuZWwub3JnPg0KPiA+ID4gU2VudDogV2VkbmVzZGF5LCBPY3Rv
YmVyIDIwLCAyMDIxIDE6MDAgQU0NCj4gPiA+IFRvOiBIdWFuZywgUmF5IDxSYXkuSHVhbmdAYW1k
LmNvbT4NCj4gPiA+IENjOiBSYWZhZWwgSiAuIFd5c29ja2kgPHJhZmFlbC5qLnd5c29ja2lAaW50
ZWwuY29tPjsgVmlyZXNoIEt1bWFyDQo+ID4gPiA8dmlyZXNoLmt1bWFyQGxpbmFyby5vcmc+OyBT
aHVhaCBLaGFuIDxza2hhbkBsaW51eGZvdW5kYXRpb24ub3JnPjsNCj4gPiA+IEJvcmlzbGF2IFBl
dGtvdiA8YnBAc3VzZS5kZT47IFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz47
DQo+ID4gPiBJbmdvIE1vbG5hciA8bWluZ29Aa2VybmVsLm9yZz47IExpbnV4IFBNIDxsaW51eC1w
bUB2Z2VyLmtlcm5lbC5vcmc+Ow0KPiA+ID4gU2hhcm1hLCBEZWVwYWsgPERlZXBhay5TaGFybWFA
YW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlcg0KPiA+ID4gPEFsZXhhbmRlci5EZXVjaGVyQGFt
ZC5jb20+OyBMaW1vbmNpZWxsbywgTWFyaW8NCj4gPiA+IDxNYXJpby5MaW1vbmNpZWxsb0BhbWQu
Y29tPjsgRm9udGVub3QsIE5hdGhhbg0KPiA+ID4gPE5hdGhhbi5Gb250ZW5vdEBhbWQuY29tPjsg
U3UsIEppbnpob3UgKEpvZSkNCj4gPEppbnpob3UuU3VAYW1kLmNvbT47DQo+ID4gPiBEdSwgWGlh
b2ppYW4gPFhpYW9qaWFuLkR1QGFtZC5jb20+OyBMaW51eCBLZXJuZWwgTWFpbGluZyBMaXN0DQo+
ID4gPiA8bGludXgtIGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyB0aGUgYXJjaC94ODYgbWFpbnRh
aW5lcnMNCj4gPiA+IDx4ODZAa2VybmVsLm9yZz4NCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
djIgMDQvMjFdIEFDUEk6IENQUEM6IGFkZCBjcHBjIGVuYWJsZSByZWdpc3Rlcg0KPiA+ID4gZnVu
Y3Rpb24NCj4gPiA+DQo+ID4gPiBPbiBTdW4sIFNlcCAyNiwgMjAyMSBhdCAxMTowNiBBTSBIdWFu
ZyBSdWkgPHJheS5odWFuZ0BhbWQuY29tPg0KPiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4gRnJv
bTogSmluemhvdSBTdSA8SmluemhvdS5TdUBhbWQuY29tPg0KPiA+ID4gPg0KPiA+ID4gPiBBZGQg
YSBuZXcgZnVuY3Rpb24gdG8gZW5hYmxlIENQUEMgZmVhdHVyZS4gVGhpcyBmdW5jdGlvbiB3aWxs
DQo+ID4gPiA+IHdyaXRlIENvbnRpbnVvdXMgUGVyZm9ybWFuY2UgQ29udHJvbCBwYWNrYWdlIEVu
YWJsZVJlZ2lzdGVyIGZpZWxkDQo+ID4gPiA+IG9uIHRoZSBwcm9jZXNzb3IuDQo+ID4gPg0KPiA+
ID4gQW5kIHdoYXQgaXMgZ29pbmcgdG8gdGFrZSBwbGFjZSBhZnRlciB0aGlzIHdyaXRlPw0KPiA+
ID4NCj4gPiA+IEFsc28sIGl0IHdvdWxkIGJlIGdvb2QgdG8gbWVudGlvbiB0aGF0IHRoZSB1c2Vy
IG9mIHRoaXMgZnVuY3Rpb24NCj4gPiA+IHdpbGwgYmUgYWRkZWQgc3Vic2VxdWVudGx5Lg0KPiA+
DQo+ID4gQWZ0ZXIgdGhlIGVuYWJsZSBmbGFnIGlzIHNldCwgdGhlIHByb2Nlc3NvciBoYXJkd2Fy
ZSBjYW4gYWNjZXB0IHRoZQ0KPiBwZXJmb3JtYW5jZSBnb2FscyBzdWNoIGFzIGRlc2lyZWQgcGVy
ZiB0aGF0IHByb2dyYW1lZCBieSBrZXJuZWwgYW5kIGNvbnRyb2wNCj4gdGhlIHByb2Nlc3NvciBm
cmVxdWVuY3kgYWNjb3JkaW5nIHRvIHRoZSBwZXJmb3JtYW5jZSB2YWx1ZS4NCj4gDQo+IElzIHRo
aXMgdGhlIENQUEMgRW5hYmxlUmVnaXN0ZXIgcmVnaXN0ZXIgZGVzY3JpYmVkIGluIFNlY3Rpb24g
OC40LjcuMSBvZiBBQ1BJDQo+IDYuND8gIElmIHNvLCBpdCB3b3VsZCBiZSBnb29kIHRvIHByb3Zp
ZGUgdGhpcyBpbmZvcm1hdGlvbiBpbiB0aGUgY2hhbmdlbG9nDQo+IGVpdGhlci4NCj4gDQoNCkkg
c2VlLCB5ZXMuIFdlIHNob3VsZCBmb2xsb3cgdGhlIHNwZWMgZGVmaW5pdGlvbiBmb3IgZ2VuZXJh
bCBDUFBDIGZ1bmN0aW9uIGhlbHBlci4NCg0KPiA+IEkgd2lsbCBtZW50aW9uIHRoaXMgaW4gdGhl
IGNvbW1lbnQgaW4gVjMuDQo+ID4NCj4gPiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEppbnpo
b3UgU3UgPEppbnpob3UuU3VAYW1kLmNvbT4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogSHVhbmcg
UnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICBkcml2ZXJzL2Fj
cGkvY3BwY19hY3BpLmMgfCA0OA0KPiA+ID4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrDQo+ID4gPiA+ICBpbmNsdWRlL2FjcGkvY3BwY19hY3BpLmggfCAgNSArKysr
Kw0KPiA+ID4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA1MyBpbnNlcnRpb25zKCspDQo+ID4gPiA+DQo+
ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvY3BwY19hY3BpLmMgYi9kcml2ZXJzL2Fj
cGkvY3BwY19hY3BpLmMNCj4gPiA+ID4gaW5kZXgNCj4gPiA+ID4gMmVmZTJiYTk3ZDk2Li5iMjg1
OTYwYzM1ZTcgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvYWNwaS9jcHBjX2FjcGkuYw0K
PiA+ID4gPiArKysgYi9kcml2ZXJzL2FjcGkvY3BwY19hY3BpLmMNCj4gPiA+ID4gQEAgLTEyMjAs
NiArMTIyMCw1NCBAQCBpbnQgY3BwY19nZXRfcGVyZl9jdHJzKGludCBjcHVudW0sIHN0cnVjdA0K
PiA+ID4gPiBjcHBjX3BlcmZfZmJfY3RycyAqcGVyZl9mYl9jdHJzKSAgfQ0KPiA+ID4gPiBFWFBP
UlRfU1lNQk9MX0dQTChjcHBjX2dldF9wZXJmX2N0cnMpOw0KPiA+ID4gPg0KPiA+ID4gPiArLyoq
DQo+ID4gPiA+ICsgKiBjcHBjX3NldF9lbmFibGUgLSBTZXQgdG8gZW5hYmxlIENQUEMgb24gdGhl
IHByb2Nlc3NvciBieQ0KPiA+ID4gPiArd3JpdGluZyB0aGUNCj4gPiA+ID4gKyAqIENvbnRpbnVv
dXMgUGVyZm9ybWFuY2UgQ29udHJvbCBwYWNrYWdlIEVuYWJsZVJlZ2lzdGVyIGZlaWxkLg0KPiA+
ID4gPiArICogQGNwdTogQ1BVIGZvciB3aGljaCB0byBlbmFibGUgQ1BQQyByZWdpc3Rlci4NCj4g
PiA+ID4gKyAqIEBlbmFibGU6IDAgLSBkaXNhYmxlLCAxIC0gZW5hYmxlIENQUEMgZmVhdHVyZSBv
biB0aGUgcHJvY2Vzc29yLg0KPiA+ID4gPiArICoNCj4gPiA+ID4gKyAqIFJldHVybjogMCBmb3Ig
c3VjY2VzcywgLUVSUk5PIG9yIC1FSU8gb3RoZXJ3aXNlLg0KPiA+ID4gPiArICovDQo+ID4gPiA+
ICtpbnQgY3BwY19zZXRfZW5hYmxlKGludCBjcHUsIHUzMiBlbmFibGUpIHsNCj4gPiA+ID4gKyAg
ICAgICBpbnQgcGNjX3NzX2lkID0gcGVyX2NwdShjcHVfcGNjX3N1YnNwYWNlX2lkeCwgY3B1KTsN
Cj4gPiA+ID4gKyAgICAgICBzdHJ1Y3QgY3BjX3JlZ2lzdGVyX3Jlc291cmNlICplbmFibGVfcmVn
Ow0KPiA+ID4gPiArICAgICAgIHN0cnVjdCBjcGNfZGVzYyAqY3BjX2Rlc2MgPSBwZXJfY3B1KGNw
Y19kZXNjX3B0ciwgY3B1KTsNCj4gPiA+ID4gKyAgICAgICBzdHJ1Y3QgY3BwY19wY2NfZGF0YSAq
cGNjX3NzX2RhdGEgPSBOVUxMOw0KPiA+ID4gPiArICAgICAgIGludCByZXQgPSAtMTsNCj4gPiA+
ID4gKw0KPiA+ID4gPiArICAgICAgIC8qIGNoZWNrIHRoZSBpbnB1dCB2YWx1ZSovDQo+ID4gPiA+
ICsgICAgICAgaWYgKGNwdSA8IDAgfHwgY3B1ID4gbnVtX3Bvc3NpYmxlX2NwdXMoKSAtIDEgfHwg
ZW5hYmxlID4NCj4gPiA+ID4gKyAxKQ0KPiA+ID4NCj4gPiA+IFdoeSBub3QgdXNlIGNwdV9wb3Nz
aWJsZSgpPyAgQW5kIHdoeSBlbmFibGUgPiAxIGlzIGEgcHJvYmxlbT8NCj4gPiA+DQo+ID4NCj4g
PiBZZXMsIHlvdSdyZSByaWdodCwgY3B1X3Bvc3NpYmxlKCkgaXMgYmV0dGVyIGhlcmUuDQo+ID4g
V2lsbCByZW1vdmUgImVuYWJsZSA+IDEiLCBhbmQgeWVzLCB3ZSBzaG91bGQgc3VwcG9ydCAiZGlz
YWJsZSIgYXMgd2VsbC4NCj4gPg0KPiA+DQo+ID4gPiA+ICsgICAgICAgICAgICAgICByZXR1cm4g
LUVOT0RFVjsNCj4gPiA+DQo+ID4gPiAtRUlOVkFMDQo+ID4gPg0KPiA+DQo+ID4gVXBkYXRlZC4N
Cj4gPg0KPiA+ID4gPiArDQo+ID4gPiA+ICsgICAgICAgaWYgKCFjcGNfZGVzYykgew0KPiA+ID4N
Cj4gPiA+IGlmIHRoaXMgaXMgY2hlY2tlZCwgdGhlIGNwdV9wb3NzaWJsZSgpIGNoZWNrIGFib3Zl
IGlzIHJlZHVuZGFudC4NCj4gPg0KPiA+IEhtbSwgaWYgYWNwaV9jcHBjX3Byb2Nlc3Nvcl9wcm9i
ZSBnb3QgZmFpbGVkLCBzb21lIG9uZSBvdXRzaWRlIGFjcGkNCj4gZHJpdmVyIHdvdWxkIGxpa2Ug
dG8gY2FsbCB0aGlzIGhlbHBlci4NCj4gPiBJcyB0aGF0IHBvc3NpYmxlIHdlIGdldCBhIG51bGwg
Y3BjIGRlc2NyaXB0b3IgaGVyZT8gT3IgYW55dGhpbmcgSSBtaXNzZWQuDQo+IA0KPiBpZiBjcHVf
cG9zc2libGUoY3B1KSBpcyBmYWxzZSwgdGhlbiBjcGNfZGVzYyBmb3IgY3B1IHdpbGwgYmUgTlVM
TC4gIElmIHlvdSBjaGVjaw0KPiB0aGUgbGF0dGVyLCB0aGVyZSdzIG5vIG5lZWQgdG8gY2hlY2sg
dGhlIGZvcm1lci4gIE9mIGNvdXJzZSwgY3BjX2Rlc2MgbWF5IGJlDQo+IE5VTEwgZm9yIG90aGVy
IHJlYXNvbnMsIGJ1dCB5b3UncmUgY2hlY2tpbmcgaXQgYW55d2F5Lg0KPiANCg0KWWVzLiBJZiB0
aGUgY3BjX2Rlc2MgaXMgaW5pdGlhbGl6ZWQsIHRoZSBjcHUgaGFzIHRvIGJlIGluIHBvc3NpYmxl
IG1hc2suIEkgd2lsbCBjbGVhbiBpdCB1cCBpbiBWMy4NCg0KPiA+ID4NCj4gPiA+ID4gKyAgICAg
ICAgICAgICAgIHByX2RlYnVnKCJObyBDUEMgZGVzY3JpcHRvciBmb3IgQ1BVOiVkXG4iLCBjcHUp
Ow0KPiA+ID4gPiArICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9ERVY7DQo+ID4gPiA+ICsgICAg
ICAgfQ0KPiA+ID4gPiArDQo+ID4gPiA+ICsgICAgICAgZW5hYmxlX3JlZyA9ICZjcGNfZGVzYy0+
Y3BjX3JlZ3NbRU5BQkxFXTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICAgIGlmIChDUENfSU5f
UENDKGVuYWJsZV9yZWcpKSB7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIGlm
IChwY2Nfc3NfaWQgPCAwKQ0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4g
LUVJTzsNCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICAgICAgICAgICAgcmV0ID0gY3BjX3dyaXRl
KGNwdSwgZW5hYmxlX3JlZywgZW5hYmxlKTsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIGlmIChy
ZXQpDQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4gPiA+
ICsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIHBjY19zc19kYXRhID0gcGNjX2RhdGFbcGNjX3Nz
X2lkXTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICAgICAgICAgICAgZG93bl93cml0ZSgmcGNj
X3NzX2RhdGEtPnBjY19sb2NrKTsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIC8qIGFmdGVyIHdy
aXRpbmcgQ1BDLCB0cmFuc2ZlciB0aGUgb3duZXJzaGlwIG9mIFBDQyB0bw0KPiBwbGF0ZnJvbSAq
Lw0KPiA+ID4gPiArICAgICAgICAgICAgICAgcmV0ID0gc2VuZF9wY2NfY21kKHBjY19zc19pZCwg
Q01EX1dSSVRFKTsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIHVwX3dyaXRlKCZwY2Nfc3NfZGF0
YS0+cGNjX2xvY2spOw0KPiA+ID4gPiArICAgICAgIH0NCj4gPiA+DQo+ID4gPiBEb2VzIGl0IHJl
YWxseSBuZWVkIHRvIGRvIG5vdGhpbmcgaWYgdGhlIHJlZ2lzdGVyIGlzIG5vdCBpbiBQQ0M/ICBJ
ZiBzbywgdGhlbg0KPiB3aHk/DQo+ID4gPg0KPiA+DQo+ID4gSG1tLCBkbyB5b3UgbWVhbiB3ZSBz
aG91bGQgdGFrZSBjYXJlIHRoZSBjYXNlcyBmb3IgZW5hYmxpbmcgYmVoYXZpb3IgaWYNCj4gcmVn
aXN0ZXIgaW4gb3RoZXIgc3BhY2VzIHN1Y2ggYXMgU1lTVEVNX01FTU9SWSBvciBGSVhFRF9IQVJE
V0FSRSBvbg0KPiBkaWZmZXJlbnQga2luZHMgb2YgU0JJT1MgaW1wbGVtZW50YXRpb24/DQo+IA0K
PiBUaGlzIGlzIGEgZ2VuZXJpYyBpbnRlcmZhY2UgYW5kIGl0IHNob3VsZCBjb3ZlciBhbGwgb2Yg
dGhlIHZhbGlkIHVzZSBjYXNlcywgc28geWVzLg0KDQpJIGdvdCBpdCwgdGhhbmtzIHRvIHJlbWlu
ZGVyIQ0KDQpUaGFua3MsDQpSYXk=
