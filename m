Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51B2145ECB7
	for <lists+linux-pm@lfdr.de>; Fri, 26 Nov 2021 12:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241532AbhKZLhY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Nov 2021 06:37:24 -0500
Received: from mail-bn8nam12on2066.outbound.protection.outlook.com ([40.107.237.66]:61473
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243109AbhKZLfY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 26 Nov 2021 06:35:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EaloWhOdvuMhUmUL4bNM9Kn1VvgKRvzarB/47aedi0b6S0uT54zx6mDs9vQ7yHELssBj8uhJxmscRpSU8OAp121ocqmtqDdvHo8mSqP9y0u+jM4TQ5geMNyLPV6k80WqwlX+aSzazA4uR+lRsy7IiVP1sHk8C4DbiXbYRY+fHTYn/pipabpqoEVM3DPq3lb1Mz6rzlnBcHZ3+sM86wdKTnvCL7Q2DhYRNvw8iflMtOVDVPbrTCR5TxftRQgyvn4SXb55efePcL7TBnUilHwoEqOzbuVgsultH1/+hCsRDDWUic10r1PecRGC0PUvmAVXreMRZguj3O4jrdBByABlBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oy0ZJRtTJDzrDGby/nptEpPM2U8lsf8HUa1wMaRVyCU=;
 b=hHYjThhY3YssFQGNvJtGvDDjGGqsxTpHeQR6t0b1LEZnfo4QTq1eKacv7wxDmCC2K6ioXfU9G3XciDqiCIiJCuvz4Je7IgnPW6wcJENX6C/piTJP4oKHD2DC3fs+iVEAcEcKsInTKApNOsF9O3XW3cK6+/jR8FsO84aF+sNsxqsP8RSEfAhRNJeU86fEPBQBbh9QFcE0Rb4mk4RTY7XRX3VJcOTNqiZxLizlDesDhopYTCVypsSi6jPFUcL8cE6DVxz/9HHSIJQAem52kcgEqzg5N8P4pdTV/WwHSpkJdcJPT7L1tPZGBbtW0n5PWvhwQtpK6NZX0tOpNQCBTA5lhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oy0ZJRtTJDzrDGby/nptEpPM2U8lsf8HUa1wMaRVyCU=;
 b=VwI3XSCebOWuihwlqznrCCxaccwSGQ6REJrqho3c7WCSXdE+idhQ+IpnUZrS7epEtH4FtBb0GGyJff5cYOtJiVHgsYsNFtuZtn9omBLXJZtPd70A7TQlnrIn7GFP9FTyiLFYAL3AOOikS7600XNceduuP2neJesGvW356TZJQdo=
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.25; Fri, 26 Nov
 2021 11:32:10 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::e95d:8a23:c590:e07a]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::e95d:8a23:c590:e07a%9]) with mapi id 15.20.4713.022; Fri, 26 Nov 2021
 11:32:10 +0000
From:   "Du, Xiaojian" <Xiaojian.Du@amd.com>
To:     Mike Lothian <mike@fireburn.co.uk>,
        "Huang, Ray" <Ray.Huang@amd.com>
CC:     Linux PM list <linux-pm@vger.kernel.org>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>
Subject: RE: AMD Pstate
Thread-Topic: AMD Pstate
Thread-Index: AQHX3sPmr0+T0QmQMkGaSsYdoOeWM6wQ8YMAgAAIdwCAAAFFAIAAAuGAgADVnQCAADuAgIAAe6aAgAMeVYCAAAeY0A==
Date:   Fri, 26 Nov 2021 11:32:10 +0000
Message-ID: <DM4PR12MB513676A292976E478227E133F1639@DM4PR12MB5136.namprd12.prod.outlook.com>
References: <CAHbf0-FnmdCAwuML4cxM3UAaOWqZ0sxJSF3iRw_aAmZEq6RfSQ@mail.gmail.com>
 <CAHbf0-E5Zrs9-bWYMm8A-RQ7xd0DOCZopzZ2GjtH8xcFf4wVtA@mail.gmail.com>
 <YZzN4Nc2tcclbVIO@hr-amd>
 <CAHbf0-GPqod-W5exGt4c63YYVG27M4qdSi25wwqmFfC_ypTFyw@mail.gmail.com>
 <YZzRW3pjIoJ4k4O4@hr-amd>
 <CAHbf0-HnJzS7+DaX5o2v4bruVRgpSynDeUvSBhrZnn0NYGkRRw@mail.gmail.com>
 <YZ22dYQ8dgQTwqnh@amd.com>
 <CAHbf0-FnFpkmZ2bkfS2S=Cw_RLbK1y7eSHySAFGVecs+t+-aVg@mail.gmail.com>
 <CAHbf0-F2v_tziWORHFkAOBS0oRK15XcPZpTkDbxsOp4ibTX+wQ@mail.gmail.com>
In-Reply-To: <CAHbf0-F2v_tziWORHFkAOBS0oRK15XcPZpTkDbxsOp4ibTX+wQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=f3673b3e-5db9-49c1-bdd2-2ef08b57025a;MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP
 2.0;MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-26T11:17:17Z;MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a283a00-7134-4bff-615c-08d9b0d06290
x-ms-traffictypediagnostic: DM4PR12MB5278:
x-microsoft-antispam-prvs: <DM4PR12MB5278B35304B69CCE05E2BC7AF1639@DM4PR12MB5278.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sLGXcgdYhiT57qJmimYC4mLS8lSpmktVl27i1a8d6f6RQLGCc0yJUGh52jwyfdpVqQyU4nw+K7a2j9I20fLbfKtcEm5mD+BJvJyOZyjM7RB80HdoyvjoXCIcu9XLw6RcVon6wVVybt4VeiY3Hd8nIWStaWjYZcX+/g6VWBLYGkNQT/i8+PKq5a0xBf57dFrwNx7cMFr5X9xvx0uej1BakEEbtuzyP61j2qtqtV027LKJlJLnF1RTvP/2Nmrf++xwQwZg7FKwTTYHzDIXwec3a467SoJbS0Dp+nPahd3e0+/ycHu13H35Z0XXamtyMXjFZd40QO4j6UFzjk7LcrUrLVtPCvUgnElRo3Ub3+khcsONOjFgNu7bOAU/66zv4o0z37g+5pP+MHzoGqXuBYIlCQPnKHqoCFn0Arpjh+U4mpn3Lzs1HQTjwkdRdZKI+pFOSOcV1Jn8TiBcxGFIMQtbIgEUtgqcevfWqSgAUT05FL77tCgkGr3DgQO8dUoWRdxGX0cldWF8HK6HKz3pJj4OYuRHAlx8y2mT8Ubg0u75ijWWg2jjtDs2+kL4jGgf0PwMNu3dsJerDNFdQvqBcxXXgJpivl23Z86istGbtfNtZj6Cp+D33zjp+6TMrmBS41qtDpCZ1IHUQd7Yt1WxHSaG0N9PhoNGrF0EPkFb3mYjyb5K/tRkYNFLQWgGKc/CdRGF+iolW9LCZqnv8Hev0brgdw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5136.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(71200400001)(8676002)(6636002)(7696005)(508600001)(66446008)(2906002)(53546011)(26005)(86362001)(5660300002)(64756008)(52536014)(83380400001)(9686003)(316002)(55016003)(8936002)(3480700007)(54906003)(66946007)(4326008)(66556008)(6506007)(66476007)(7116003)(38100700002)(186003)(110136005)(122000001)(76116006)(38070700005)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dzVBbWFDTHBwTkdjRVBMTkNidGFGOHp6Um5LSlRNZ3BXZmxLdXVpV29IWWsz?=
 =?utf-8?B?bWxtYjlhSlVyUUpTdldhUmUxVGdha0NNM2RobjdUcFJzNEVQN0NlQmRFUW81?=
 =?utf-8?B?UmFvdHFtOXFncmdneDVjaVAyM3A0SERtd0VDcGtISkVSWmlzaDh1M1gzUFdN?=
 =?utf-8?B?M2tuazFkTU81WU1qbkp0ZGg3eFJhQmk1TUNDY1NFL3FQbzJhOTVUSTY5dVpI?=
 =?utf-8?B?dURqeU0rcTRVUHdxRmZXREQxLzZlZmxpQzl5WUQ3WCt3Y2FCOHZINTVRT1Uz?=
 =?utf-8?B?TFdpY0xOc0RLbmxMUSthbUcrYTZJeWZzbXlxZCtrRmN3d0NDNklxU0R2bTdO?=
 =?utf-8?B?Mkt2QkhETlp3NDJrN0NrbnBHVlNjM0trbTlEcXpLd0hVelhsZ2tEOTBNbXZp?=
 =?utf-8?B?T1U2OUIydVBRSjN5Nk1VcS9BSFBoMk81UkE0QUt1OHZuajFqd2J6RkhFLzht?=
 =?utf-8?B?VDF0amRkQWxXWmJvSjhXYTBVbnl6TWF3eC81WDBBRU5oT3ZsYzVadlJRNWVB?=
 =?utf-8?B?Nm9IeldZRWxYR3kzeGFuOVRuSkJnZU1KaW9GKzN5enE2cW4rZVdaMWY2L09D?=
 =?utf-8?B?R1hTOTV4T053Z3cvbGJnTlVrWTlPTzJJcGhzMitBZDFqamdaS2pYZEswWGdj?=
 =?utf-8?B?NlVNbzFNWVdNT1B0OFlpeFlsVFliV0NrTk5NbFhjZEZzaWN0d0R2K3p5MmQ1?=
 =?utf-8?B?VThRaEpzSVV0aC8rN3d0U0E2TkNYSUhMZE9paHE5bStZYW1yQ21zZE9EM1g3?=
 =?utf-8?B?blpvYzhJTFBWNkFwNUZQemFZQnhsczYvWTUzdmVDME4xNVJVNUZybWsvQ3hJ?=
 =?utf-8?B?cWFxbDgra0pkVGd6L2lGTmg2K2dCYjQ4OXRYOFd6bHZJU1p6SHdLdnJYNGlS?=
 =?utf-8?B?TmI4ZXIwNFVRNHd4WE5sYkxWLzRETnh6d3hxSHpCUTFEemJVcXRNU3ljN05F?=
 =?utf-8?B?ciswdXovTUxGYllKV1ZmeGNLOTJnQVVvTXVweHJSMjNKcytSRlN0KzdOaWVi?=
 =?utf-8?B?TTd3dXIwZk9LSWVFNjA1NW11elRHWkllaXFxcWwwQjlPMUV1T0plZktFWjV2?=
 =?utf-8?B?UFpUWDIyV3NqdnpOY0JkQkFIaHJKV29URWNteEFwdk5GU1JDbEFCTXk1dU1P?=
 =?utf-8?B?SncveHVKdnZ6ay9ScXVpTFFxdWYreGh1TmRjSFllR3psVWlyUlByeUlCOUI5?=
 =?utf-8?B?VEVpVFFaMnByeTBIRDF5YTFvaHl5d3QzWU9POHZGTldXWE9rSkNMTXhFMDYy?=
 =?utf-8?B?TEx0VTliTFVMM3NVdkI5QStVcWNjNXRMS3JkZnFIanJGTnVCS0ptT01DSEVt?=
 =?utf-8?B?OHFqM2tyYlFSUFhjaFZlZ012d0wzSWIyN1hoM0M3UXhTUmFTemxZUEtyaTM0?=
 =?utf-8?B?amFrNjdDQjFEbTFqWi84YUkwWk9kVGY1UHd2emFYbTNSUjZrMW1aZDBjUWtF?=
 =?utf-8?B?YVhWbWYrOEZmVS9HSTN4UzV3bzRsejRyeGViWjdIeTE3cUU5cmhqbkxKWlFr?=
 =?utf-8?B?d1U0Qm5ldDB6NWkya3U0SThWVE1PYkNkdmIzYUlLWWZRY2YrUmVlL1BFUkZS?=
 =?utf-8?B?YVpTSzBjYmpiK1NFVXg2dUw3K1VjMDJXdS92WHBJTUZxczZheHNYZHJ3QzEx?=
 =?utf-8?B?UjVESnVXZVc5Rk9XZnEwK0ZHTzlFT3Q2VFRPd2lwNEZma1NJT1Brbm91UHFl?=
 =?utf-8?B?SktGNTFyQW1rTkF4MUkyOUwwR1ZLSThmRzdQb0VtSE5BZ3JqNVRnWFREOTlU?=
 =?utf-8?B?eDdzNndMNzliN29KQzlnS1lMR1lNNmpnKzdBWlBwT0F2MTBKdXNPSW1IbUVp?=
 =?utf-8?B?QnVPNjhVY01uVGxHcjhFcFJFVlRQTmlUbXhwM3BOZVA0WGJRaVhIVC9FWDFl?=
 =?utf-8?B?L1orUndMMHRyaXVsbTJTWlBqQ0EzQnVJSkpuakhiS3RscTNBT0l2b1lDbUxR?=
 =?utf-8?B?RnJFcmtLejBlaSt3c3o0SUlDai9scG1TU0pydFZiZE9abTI3TUZYaUZOLzBn?=
 =?utf-8?B?Sk5GbnhsSlBtSkIxZktjTFdFdDF5Unh6cTNOYUFjcVNWM2NOV2l2RzE0VXNB?=
 =?utf-8?B?dk5sZDBqNm8wSnJ3TU1pVGhycm9zK1JRK2dDQlVxUGpEbGUwNXZqV0tkd2tO?=
 =?utf-8?B?dmNyNmdFR0lKeGJFN2dvK2R5NXovdGNLNWlqdkpiYWV4ZzliRFVTaEk5M1Fl?=
 =?utf-8?Q?9ebq+d4hsP/pLPI8N1uWyEE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a283a00-7134-4bff-615c-08d9b0d06290
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2021 11:32:10.1846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PmqekshTF2yipGkTpXsTmv/gpyr9xxsWhxYs909Yi1YjZDHb1wc1HKRS5cH+m8+jdYsBYW0BJ95mcR4Xdcy4gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5278
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KSGkgTWlrZQ0KDQpDb3VsZCB5b3UgY2hlY2sgdGhl
IHNtYyBmaXJtd2FyZSB2ZXJzaW9uPw0KQU1ELVBzdGF0ZSBkcml2ZXIgd2lsbCBjb21tdW5pY2F0
ZSB3aXRoIFNNVSwgc28gd2UgbmVlZCB0byBjb25maXJtIHlvdXIgY3VycmVudCBzbWMgZmlybXdh
cmUgdmVyc2lvbiBpcyBub3Qgb2xkZXIgdGhhbiBvdXJzLg0KDQpPdXIgdGVzdCBwbGF0Zm9ybSBp
cyBCNTUwLCBzbWMgZmlybXdhcmUgdmVyc2lvbiBpczoNClNNQyBmZWF0dXJlIHZlcnNpb246IDAs
IGZpcm13YXJlIHZlcnNpb246IDB4MDAyODMzMDANCg0KWW91IGNhbiBmZXRjaCB0aGlzIGluZm8g
bGlrZSB0aGlzOg0KDQokc3VkbyBzdSAoc3dpdGNoIHRvIHJvb3QpDQokY2QgIC9zeXMva2VybmVs
L2RlYnVnL2RyaS8gICAoZW50ZXIgdGhlIHN5c2ZzIG5vZGUgZm9sZGVyKQ0KJGxsICh0byBsaXN0
IHRoZSBHUFUgZGV2aWNlKHMpKQ0KJGNkIDAgKGlmIHlvdXIgcGxhdGZvcm0gaGFzIG9ubHkgb25l
IEdQVSwgdGhlICIwIiBtZWFucyB0aGlzIEdQVSBkZXZpY2UgZXhhY3RseTsgYnV0IGlmIHlvdSBo
YXZlIG9uZSBpR1BVIGFuZCBvbmUgZEdQVSBvbiB5b3VyIHBsYXRmb3JtLCB5b3UgbmVlZCB0byBo
YXZlIGEgdHJ5LCBsaWtlICIwIiBvciAiMSIpDQokY2F0IGFtZGdwdV9maXJtd2FyZV9pbmZvIChp
ZiB5b3UgaGF2ZSB0d28gQU1EIEdQVXMsIHlvdSBuZWVkIHRvIGNhcHR1cmUgYm90aCBvZiB0aGVt
KQ0KDQpJdCB3aWxsIHByaW50IGxpa2UgdGhpczoNClZDRSBmZWF0dXJlIHZlcnNpb246IDAsIGZp
cm13YXJlIHZlcnNpb246IDB4MDAwMDAwMDANClVWRCBmZWF0dXJlIHZlcnNpb246IDAsIGZpcm13
YXJlIHZlcnNpb246IDB4MDAwMDAwMDANCk1DIGZlYXR1cmUgdmVyc2lvbjogMCwgZmlybXdhcmUg
dmVyc2lvbjogMHgwMDAwMDAwMA0KTUUgZmVhdHVyZSB2ZXJzaW9uOiAzMSwgZmlybXdhcmUgdmVy
c2lvbjogMHgwMDAwMDA1ZQ0KUEZQIGZlYXR1cmUgdmVyc2lvbjogMzEsIGZpcm13YXJlIHZlcnNp
b246IDB4MDAwMDAwOGYNCkNFIGZlYXR1cmUgdmVyc2lvbjogMzEsIGZpcm13YXJlIHZlcnNpb246
IDB4MDAwMDAwMjUNClJMQyBmZWF0dXJlIHZlcnNpb246IDEsIGZpcm13YXJlIHZlcnNpb246IDB4
MDAwMDAwNGMNClJMQyBTUkxDIGZlYXR1cmUgdmVyc2lvbjogMCwgZmlybXdhcmUgdmVyc2lvbjog
MHgwMDAwMDAwMA0KUkxDIFNSTEcgZmVhdHVyZSB2ZXJzaW9uOiAwLCBmaXJtd2FyZSB2ZXJzaW9u
OiAweDAwMDAwMDAwDQpSTEMgU1JMUyBmZWF0dXJlIHZlcnNpb246IDAsIGZpcm13YXJlIHZlcnNp
b246IDB4MDAwMDAwMDANCk1FQyBmZWF0dXJlIHZlcnNpb246IDMxLCBmaXJtd2FyZSB2ZXJzaW9u
OiAweDAwMDAwMDg3DQpNRUMyIGZlYXR1cmUgdmVyc2lvbjogMzEsIGZpcm13YXJlIHZlcnNpb246
IDB4MDAwMDAwODcNClNPUyBmZWF0dXJlIHZlcnNpb246IDAsIGZpcm13YXJlIHZlcnNpb246IDB4
MDAxNjAwNTINCkFTRCBmZWF0dXJlIHZlcnNpb246IDAsIGZpcm13YXJlIHZlcnNpb246IDB4MjEw
MDAwMzYNClRBIFhHTUkgZmVhdHVyZSB2ZXJzaW9uOiAwLCBmaXJtd2FyZSB2ZXJzaW9uOiAweDAw
MDAwMDAwDQpUQSBSQVMgZmVhdHVyZSB2ZXJzaW9uOiAwLCBmaXJtd2FyZSB2ZXJzaW9uOiAweDAw
MDAwMDAwDQpTTUMgZmVhdHVyZSB2ZXJzaW9uOiAwLCBmaXJtd2FyZSB2ZXJzaW9uOiAweDAwMzUx
ZjAwDQpTRE1BMCBmZWF0dXJlIHZlcnNpb246IDUwLCBmaXJtd2FyZSB2ZXJzaW9uOiAweDAwMDAw
MDI0DQpTRE1BMSBmZWF0dXJlIHZlcnNpb246IDUwLCBmaXJtd2FyZSB2ZXJzaW9uOiAweDAwMDAw
MDI0DQpWQ04gZmVhdHVyZSB2ZXJzaW9uOiAwLCBmaXJtd2FyZSB2ZXJzaW9uOiAweDA1MTBhMDBk
DQpETUNVIGZlYXR1cmUgdmVyc2lvbjogMCwgZmlybXdhcmUgdmVyc2lvbjogMHgwMDAwMDAwMA0K
VkJJT1MgdmVyc2lvbjogMTEzLUQzMjMxMDAwLTEwMQ0KDQpBbmQgd2UgbmVlZCB0aGUgInNtYyBm
aXJtd2FyZSB2ZXJzaW9uIiBhbmQgIlZCSU9TIHZlcnNpb24iLg0KQlRXLCB0aGFuayBmb3IgeW91
ciB0ZXN0IGFuZCBmZWVkYmFjay4NCg0KVGhhbmtzLA0KWGlhb2ppYW4NCg0KDQotLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTWlrZSBMb3RoaWFuIDxtaWtlQGZpcmVidXJuLmNvLnVr
Pg0KU2VudDogMjAyMeW5tDEx5pyIMjbml6UgMTg6NTANClRvOiBIdWFuZywgUmF5IDxSYXkuSHVh
bmdAYW1kLmNvbT4NCkNjOiBMaW51eCBQTSBsaXN0IDxsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmc+
OyBTdSwgSmluemhvdSAoSm9lKSA8SmluemhvdS5TdUBhbWQuY29tPjsgRHUsIFhpYW9qaWFuIDxY
aWFvamlhbi5EdUBhbWQuY29tPg0KU3ViamVjdDogUmU6IEFNRCBQc3RhdGUNCg0KSXMgdGhlcmUg
YW55IGV4dHJhIGluZm8gdGhhdCBtaWdodCBiZSB1c2VmdWwgdG8gZGVidWcgdGhpcz8NCg==
