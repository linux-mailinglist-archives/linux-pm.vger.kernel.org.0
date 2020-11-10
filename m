Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65F692ADB1C
	for <lists+linux-pm@lfdr.de>; Tue, 10 Nov 2020 17:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731514AbgKJQCr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Nov 2020 11:02:47 -0500
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:4996 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730200AbgKJQCr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Nov 2020 11:02:47 -0500
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AAG0NAS021949;
        Tue, 10 Nov 2020 11:02:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=uS/funqnymFG2hO5Ot6CXjxwxhD1v9Os0lVN04q/U/Y=;
 b=fiC93pziVwByh3YjbYjzWyD5ce0TX31XGiXT3NiNmq2bgOIOAiUQLMNwPvFI32OvtawU
 /J2AsAAmCadpq7Mp07zZJ7ltlqVXmxv663/IsNkgYIi6CekNbbRaNBoKLbpJFTHV9GHl
 ePvHIJl5O8XudJWt19Cbp7lpFZR3cfn30HMLBA/Ve7Jw+s67rA8SUaKFuLo6JUfFKRY0
 DadhhQvAwL12/PIEhTxm7+pSKlRTTdxtzE9yGWjCZbyPI4YXUe0bZUirDlRodcA9Yb31
 6bLwktgA4XoOG74ZLKJ+0gnOF9DYvpk2FI7N+zGSpiB3gLEYPkt142ixI1hjJpFkj+tW Pg== 
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 34nq18fvd2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Nov 2020 11:02:39 -0500
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AAFwV95139041;
        Tue, 10 Nov 2020 11:02:39 -0500
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2058.outbound.protection.outlook.com [104.47.45.58])
        by mx0b-00154901.pphosted.com with ESMTP id 34qvwphvsa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Nov 2020 11:02:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G3cb8sVHF/AzXfI9Qc1Py4ZH8TK8Y7MnnmjP39Zj9ITQnCcqdMjkvXc/TbUYV7jJtIeRcMnsMJh5klzY46BBVvdwGfH6A4jJD4zuKBX+A0b1v5nnYFrhvwo8UvFzhU05WpuFR3jwqvak3/rdZE4CNgT/0/X6KRKkmJ50DJ51Yglg8u08y0OjhbkBPTd3xN+y3mlzDsM4Y0ixX+pwvFG5wC0yzf9WVjxRahkUz0nHb6LYA3mFR1eUjTAwRx5XcOEpaSnx46IGxZBWuQPhnQQuL7tH7lsxXMoUYgEGpXrrGzbhRWnNdNDnfCY8BDY7fT/1m1C77cEYz5PgtG0Iowcbng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uS/funqnymFG2hO5Ot6CXjxwxhD1v9Os0lVN04q/U/Y=;
 b=QgxoAbtRnb0IR9QyI9eJfElou485gmRtKv+V/Uf83zau9RshTY2xOB2XgwsQNETzIve5f39EZro/b4OB2hwejJ2sAs40qgRn7uXge1U/f1gAD/yhxMHitV/+NVaeDYpq/LLI5qKcltBvydB1iHVYbb0qDa5vAPwY5liJKQx5oTT0qrQONut+DYRFi3ZWdyTGS5POI9T4Cr2VP8xOXRPOnTb7F4U76Uatc/q/fGdRu0trzTrQ7WFiv7ldAFrB1A91JvhQa7N4HacelLapxuGzHhEClQSQpwRnOj99nx8fcrf9HWslTZd/kEN2Y/tVG4SfAnazyCsSJTaYhonyptMkog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uS/funqnymFG2hO5Ot6CXjxwxhD1v9Os0lVN04q/U/Y=;
 b=T1cySow/afI1afdThg7d9odV+OF2NxpNG6iPBHoJp6ctVIhqhGD6sNd3lv7BB7V/SRrYv79Op9tbvceJv809SE+Fuec4I2DnqIrNHFHC40btZ1TBwklSkxmYcHVGQnYDLOor6SCzmTtDuIEiQJQJ0wCRmrpR8Dfr5D61iuytgfU=
Received: from DM6PR19MB2636.namprd19.prod.outlook.com (2603:10b6:5:15f::15)
 by DM5PR19MB1225.namprd19.prod.outlook.com (2603:10b6:3:b6::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21; Tue, 10 Nov 2020 16:02:34 +0000
Received: from DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a8ff:e803:ee80:e59a]) by DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a8ff:e803:ee80:e59a%3]) with mapi id 15.20.3499.032; Tue, 10 Nov 2020
 16:02:34 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@dell.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Bastien Nocera <hadess@hadess.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     Linux PM <linux-pm@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: RE: How to enable auto-suspend by default
Thread-Topic: How to enable auto-suspend by default
Thread-Index: AQHWt1BE6l+LjsERUU+/FRV4X0h3ganBPDeAgABA9KA=
Date:   Tue, 10 Nov 2020 16:02:33 +0000
Message-ID: <DM6PR19MB2636C94B56D5FBC0BD98A1B0FAE90@DM6PR19MB2636.namprd19.prod.outlook.com>
References: <fe8ab4cab3740afd261fa902f14ecae002a1122d.camel@hadess.net>
 <X6p6ubTOoMPUPPXi@kroah.com>
In-Reply-To: <X6p6ubTOoMPUPPXi@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: mika.westerberg@linux.intel.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-11-10T16:00:52.3510380Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=492c7d9d-e599-4b5a-9021-11a3ebe77535;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=Dell.com;
x-originating-ip: [76.251.167.31]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 89a3c84a-0144-4c02-d4ef-08d885920948
x-ms-traffictypediagnostic: DM5PR19MB1225:
x-microsoft-antispam-prvs: <DM5PR19MB122595ECCED9A89AF8481D5CFAE90@DM5PR19MB1225.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1GKqMv4QPgphAff/8632dukZvNdF+34iPFkAICjmMw5YlWF8zsR2O246tZrI9DpMRoGgN7GCZtbW+jo3UqnGo+y4zkJVDgnoOpxtde2jV25u65KsZZ/uVEH4WPaQtT8V5HTdzC56nUTomdcOE5KiS303aseaoEEQUKt/4wn42dJNywaYL4zrz2R1f+hgxM1Ts6dKKnLTvRIuU+KtARY5TVexFExUc6aR/6/+qZ3PUzmTjieK8+Cc6eIW4z9KgnmjCDUFqY6Ot/A7Aq8cUsKdc4If0pbbT0yYnFra2Lj02pFG36uXZGlDZ2TEpKu+RraqT5ceNXonazEu2WJ6pJYidr5YzvVmrvYEnz9GxHg1z4sFdhgbUENwvCrAVWYEpEHWwgcu1de43B4DGiIhIod3Gw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB2636.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(366004)(396003)(136003)(6506007)(316002)(71200400001)(76116006)(55016002)(478600001)(52536014)(83380400001)(186003)(54906003)(8676002)(86362001)(26005)(9686003)(5660300002)(8936002)(66946007)(66476007)(7696005)(110136005)(64756008)(66556008)(786003)(15650500001)(2906002)(33656002)(966005)(4326008)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Z+otPKw8H0cQy7lyYtfZ8irdwMpXZMwgLSDQP9i4O8h9OdteaKVS3klzWhaXomPHdCd0P62xWYkAf/UnzZS6wBsHDePMpd5w8eg+KWh38i507icJYJoTmXqQ9Z4Vx2vVvM6wa4qg4lh/vwkbFZnr3yh0ev/mXxGIUMHpfOajw082qEkfvkA2wLFvm9+Oc/30tdmfa5UCEh7oE0yXzwchV5qAEb8Kc1OS3ykPaj890ZePnugS96Iodx2qJR+jXvJLTVyc8BBdxiXEANn7pfsl33RLedWs3ZIjvV7BeU8E1XX8yh+kmW8vthu0y7tS+NsV+Fk/o68Mbn6oSqpMxUCHxL3lzmskEuPQcdvqPbce0vKNJD/e5aWdmuLbU77OMbVsJERKB4YFZIrmOI5hQVSKDGt4UhU1gpVaVtH415LgTVqvUJqjlh36msxj3QnFm/vGNVtj3+b4KK69ig/GoDRsqBXGDYHeo91PlvX6Yyl6ufrT0ATLniDwlBTpgAoHiyZbXCRcIVm2rzANLYnk6ohGHLV8MJ2j+ZCjvcA9rendVcommLOKECOntKPuoz02hUhc0aSQyiuEASd1Ri6qyJmrn0sAYy+P3P22sxFeGDHU/KBuqhnmbS8iUywKRefv/QZxQ3aUwpcJQeW1z7v0yuUaLw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB2636.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89a3c84a-0144-4c02-d4ef-08d885920948
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2020 16:02:33.8593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vvOWi1nmlLsdWrmLo9hmYXLSIqNv6SuxOVluETjzo15X3zDVd4wWiGYxGIq9lIug/rJfjV0XZlwvD5d95j+ttXokJgwDz/n3IZnfidKJzuA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR19MB1225
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-10_06:2020-11-10,2020-11-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 mlxscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 bulkscore=0 mlxlogscore=966 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011100112
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011100112
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

PiANCj4gT24gVHVlLCBOb3YgMTAsIDIwMjAgYXQgMTE6NTc6MDdBTSArMDEwMCwgQmFzdGllbiBO
b2NlcmEgd3JvdGU6DQo+ID4gSGV5LA0KPiA+DQo+ID4gc3lzdGVtZCBoYXMgYmVlbiBzaGlwcGlu
ZyB0aGlzIHNjcmlwdCB0byBlbmFibGUgYXV0by1zdXNwZW5kIG9uIGENCj4gPiBudW1iZXIgb2Yg
VVNCIGFuZCBQQ0kgZGV2aWNlczoNCj4gPg0KPiBodHRwczovL2dpdGh1Yi5jb20vc3lzdGVtZC9z
eXN0ZW1kL2Jsb2IvbWFzdGVyL3Rvb2xzL2Nocm9taXVtb3MvZ2VuX2F1dG9zdXNwZW4NCj4gZF9y
dWxlcy5weQ0KPiA+DQo+ID4gVGhlIHByb2JsZW0gaGVyZSBpcyB0d29mb2xkLiBGaXJzdCwgdGhl
IGxpc3Qgb2YgZGV2aWNlcyBpcyB1cGRhdGVkIGZyb20NCj4gPiBDaHJvbWVPUywgYW5kIHRoZSBv
cmlnaW5hbCBsaXN0IG9idmlvdXNseSB3b24ndCBiZSB1cGRhdGVkIGJ5IENocm9tZU9TDQo+ID4g
ZGV2ZWxvcGVycyB1bmxlc3MgYSBkZXZpY2UgbGlzdGVkIGV4aXN0cyBpbiBhIENocm9tZUJvb2sg
Y29tcHV0ZXIsDQo+ID4gd2hpY2ggbWVhbnMgYSBudW1iZXIgb2YgZGV2aWNlcyB0aGF0IGRvIHN1
cHBvcnQgYXV0b3N1c3BlbmQgYXJlbid0DQo+ID4gbGlzdGVkLg0KPiA+DQo+ID4gVGhlIG90aGVy
IHByb2JsZW0gaXMgdGhhdCB0aGlzIGxpc3QgbmVlZHMgdG8gZXhpc3QgYXQgYWxsLCBhbmQgdGhh
dCBpdA0KPiA+IGRvZXNuJ3Qgc2VlbSBwb3NzaWJsZSBmb3IgZGV2aWNlIGRyaXZlciBkZXZlbG9w
ZXJzIChhdCB2YXJpb3VzIGxldmVscw0KPiA+IG9mIHRoZSBzdGFjaykgdG8gb3B0LWluIHRvIGF1
dG8tc3VzcGVuZCB3aGVuIGFsbCB0aGUgdmFyaWFudHMgb2YgdGhlDQo+ID4gZGV2aWNlIChvciBh
dCBsZWFzdCBkZXRlY3RhYmxlIG9uZXMpIHN1cHBvcnQgYXV0by1zdXNwZW5kLg0KPiANCj4gQSBk
cml2ZXIgY2FuIHNheSB0aGV5IHN1cHBvcnQgYXV0b3N1c3BlbmQgdG9kYXksIGJ1dCBJIHRoaW5r
IHlvdSBhcmUNCj4gY29uY2VybmVkIGFib3V0IHRoZSBkZXZpY2VzIHRoYXQgYXJlIGNvbnRyb2xs
ZWQgYnkgY2xhc3MtY29tcGxpYW50DQo+IGRyaXZlcnMsIHJpZ2h0PyAgQW5kIGZvciB0aG9zZSwg
bm8sIHdlIGNhbid0IGRvIHRoaXMgaW4gdGhlIGtlcm5lbCBhcw0KPiB0aGVyZSBhcmUganVzdCB0
b28gbWFueSBicm9rZW4gZGV2aWNlcyBvdXQgdGhlcmUuDQo+IA0KDQpJIGd1ZXNzIHdoYXQgQmFz
dGllbiBpcyBnZXR0aW5nIGF0IGlzIGZvciBuZXdlciBkZXZpY2VzIHN1cHBvcnRlZCBieSBjbGFz
cw0KZHJpdmVycyByYXRoZXIgdGhhbiBoYXZpbmcgdG8gc3RvcmUgYW4gYWxsb3dsaXN0IGluIHVk
ZXYgcnVsZXMsIGNhbiB3ZSBzZXQNCnRoZSBhbGxvd2xpc3QgaW4gdGhlIGtlcm5lbCBpbnN0ZWFk
LiAgVGhlbiBkaXN0cmlidXRpb25zIHRoYXQgZWl0aGVyIGRvbid0DQp1c2Ugc3lzdGVtZCBvciBk
b24ndCByZWd1bGFybHkgdXBkYXRlIHVkZXYgcnVsZXMgZnJvbSBzeXN0ZW1kIGNhbiB0YWtlDQph
ZHZhbnRhZ2Ugb2YgYmV0dGVyIGRlZmF1bHRzIG9uIG1vZGVybiBoYXJkd2FyZS4NCg0KVGhlIG9u
ZSBpdGVtIHRoYXQgc3Rvb2Qgb3V0IHRvIG1lIGluIHRoYXQgcnVsZXMgZmlsZSB3YXMgODA4Njph
MGVkLg0KSXQncyBsaXN0ZWQgYXMgIlZvbHRlZXIgWEhDSSIsIGJ1dCB0aGF0IHNhbWUgZGV2aWNl
IElEIGlzIGFjdHVhbGx5IHByZXNlbnQNCmluIGFuIFhQUyA5MzEwIGluIGZyb250IG9mIG1lIGFz
IHdlbGwgYW5kIHVzZWQgYnkgdGhlIHhoY2ktcGNpIGtlcm5lbCBtb2R1bGUuDQoNCkdpdmVuIHdl
J3JlIGVmZmVjdGl2ZWx5IGVuZGluZyB1cCB3aXRoIHRoZSBjb21iaW5hdGlvbiBvZiBydW50aW1l
IFBNIHR1cm5lZA0Kb24gYnkgdWRldiBydWxlcywgZG8gd2UgbmVlZCBzb21ldGhpbmcgbGlrZSB0
aGlzIGZvciB0aGF0IElEOg0KDQpodHRwczovL2dpdGh1Yi5jb20vdG9ydmFsZHMvbGludXgvY29t
bWl0LzZhN2M1MzNkNGExODU0ZjU0OTAxYTA2NWQ4YzY3MmU4OTA0MDBkOGENCg0KQE1pa2EgV2Vz
dGVyYmVyZyBzaG91bGQgODA4NjphMGVkIGJlIHF1aXJrZWQgbGlrZSB0aGUgVENTUyB4SENJIHRv
bz8NCg0KPiBBcyBwcm9vZiBvZiB0aGlzLCBsb29rIGF0IG90aGVyIG9wZXJhdGluZyBzeXN0ZW1z
LiAgVGhleSBoYWQgdG8NCj4gaW1wbGVtZW50IHRoZSBzYW1lIHR5cGUgb2YgImFsbG93ZWQgZGV2
aWNlcyIgbGlzdCB0aGF0IHdlIGRvLiAgSW4gZmFjdCwNCj4gd2UgZGlkIHRoaXMgZm9yIExpbnV4
IGJlY2F1c2UgdGhleSBkaWQgdGhpcywgd2hpY2ggbWVhbnMgdGhhdCB3aGVuDQo+IGhhcmR3YXJl
IG1hbnVmYWN0dXJlcnMgdGVzdCB0aGVpciBkZXZpY2UsIHRoZXkgb25seSB0ZXN0IHdpdGggb3Ro
ZXINCj4gb3BlcmF0aW5nIHN5c3RlbXMgYW5kIG5vdCBMaW51eCBhbmQgc28sIHdlIG5lZWQgdG8g
bWF0Y2ggd2hhdCB0aG9zZQ0KPiBvdGhlciBPU2VzIGRvIGFzIHdlbGwuDQo+IA0KDQooaW5zZXJ0
ICJzb21lIiDwn5iKKQ0K
