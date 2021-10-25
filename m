Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C00ED439965
	for <lists+linux-pm@lfdr.de>; Mon, 25 Oct 2021 16:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbhJYO6f (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Oct 2021 10:58:35 -0400
Received: from mail-vi1eur05on2058.outbound.protection.outlook.com ([40.107.21.58]:51040
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233699AbhJYO5v (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 25 Oct 2021 10:57:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODhMEdDl5zeIMeYUZGwG8+JO2j/RoBStjml6DmT+GhY=;
 b=e78V2T0tK93h5PElKi7widwM6cogfdm5uSt5lsEJzWvC2+R7BZcEQ/VdpaYCXBlh1bOUTmeJWvedPjSJJaxZn9E3YtBenqaYCV7qaH5ylX0bJ2C9ztwU3VaGQlZt6jSs/p1DcU3wz9EKSeCcW9ZhE0klw26JGVKWrKJYsYmt7fU=
Received: from DB6PR0802CA0028.eurprd08.prod.outlook.com (2603:10a6:4:a3::14)
 by DB6PR0801MB2085.eurprd08.prod.outlook.com (2603:10a6:4:79::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 14:55:26 +0000
Received: from DB5EUR03FT014.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:a3:cafe::10) by DB6PR0802CA0028.outlook.office365.com
 (2603:10a6:4:a3::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Mon, 25 Oct 2021 14:55:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT014.mail.protection.outlook.com (10.152.20.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.18 via Frontend Transport; Mon, 25 Oct 2021 14:55:26 +0000
Received: ("Tessian outbound e27daf245730:v103"); Mon, 25 Oct 2021 14:55:26 +0000
X-CR-MTA-TID: 64aa7808
Received: from f34e748eb168.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 50BBB044-9188-4E3F-94FC-1B7DF86945EE.1;
        Mon, 25 Oct 2021 14:55:21 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id f34e748eb168.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 25 Oct 2021 14:55:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oz0aY+GBCmoCoLNo3B6Q2mXkRckJAl6+tActk3D8WY5JSN71nNJGeytCsvn/UlktVmEhHYe8xJw24iimtT1WDwSEy85knTSilDHARjqpXS0B2NWVKGdOpqHc1asHzNbELuV/D00OWn42/mqGqABwNS3m/S2J3YxhrvCXzJnawwD82CI/CgD5F3pM+q5rnHlW/KuPDyWulCoFS253MnW7h54MsXl1DpohugyV5HsSx2XisA1L8dSoZlWl/yoqTR97h1ksqL9nQaWstSThhrB93R39VUAPsuH7nyrNmBSw9rKAcJNUljelX0MQTHef5A7RKzJGBeSZCL7Opncd/9L6+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ODhMEdDl5zeIMeYUZGwG8+JO2j/RoBStjml6DmT+GhY=;
 b=IhZ4ExwGvUmzSk1fEg6iWE1Fo5Cvkof1c1ZU7bO+b1+0CYAPm23FPd9a3jmQLQTse+u66mMUDspPhVFpM8HLLkEar6oMhWlxu0+TyrnlH/wFlGWqjZjjcP0ewMkQD4HoElqIBwXlVF4WynmG0ntgbod/Usx9JH+oo+zCyMiJtidf/IxM7Cv31NuvNqVkT/Ywzx8FBwrHC94vsqRk7kKj2EK22bOxr9vhKCumjigoDPnAW9erHIAGjt+8b6nLYWOk0OtvMe+qLRl8Y+1ZqQLJzcACdLiI3fVL++QgCTGNvmXmrzE6Aeipt2x4Mr4NYT38N/aEqYaCcg3ah2qKreb6dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODhMEdDl5zeIMeYUZGwG8+JO2j/RoBStjml6DmT+GhY=;
 b=e78V2T0tK93h5PElKi7widwM6cogfdm5uSt5lsEJzWvC2+R7BZcEQ/VdpaYCXBlh1bOUTmeJWvedPjSJJaxZn9E3YtBenqaYCV7qaH5ylX0bJ2C9ztwU3VaGQlZt6jSs/p1DcU3wz9EKSeCcW9ZhE0klw26JGVKWrKJYsYmt7fU=
Received: from DU2PR08MB7237.eurprd08.prod.outlook.com (2603:10a6:10:2d0::8)
 by DU2PR08MB7311.eurprd08.prod.outlook.com (2603:10a6:10:2e6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Mon, 25 Oct
 2021 14:55:18 +0000
Received: from DU2PR08MB7237.eurprd08.prod.outlook.com
 ([fe80::ed47:2ce3:e5b3:e976]) by DU2PR08MB7237.eurprd08.prod.outlook.com
 ([fe80::ed47:2ce3:e5b3:e976%9]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 14:55:18 +0000
From:   Souvik Chakravarty <Souvik.Chakravarty@arm.com>
To:     Georgi Djakov <djakov@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linaro-open-discussions@op-lists.linaro.org" 
        <linaro-open-discussions@op-lists.linaro.org>
CC:     Sudeep Holla <Sudeep.Holla@arm.com>,
        Cristian Marussi <Cristian.Marussi@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: RE: SCMI protocol for interconnect scaling
Thread-Topic: SCMI protocol for interconnect scaling
Thread-Index: AQHXxmu3LCNKBAt84EqLnzwDEWZYz6vj0GRw
Date:   Mon, 25 Oct 2021 14:55:18 +0000
Message-ID: <DU2PR08MB723772CAC1CEE69963675CF682839@DU2PR08MB7237.eurprd08.prod.outlook.com>
References: <42432cc2-5cb2-ea74-0980-8575e3a343fd@kernel.org>
In-Reply-To: <42432cc2-5cb2-ea74-0980-8575e3a343fd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 2AB9619EBB05D34E898BD8468EC70D76.0
x-checkrecipientchecked: true
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 666c60fa-8362-4d1f-8bad-08d997c77afb
x-ms-traffictypediagnostic: DU2PR08MB7311:|DB6PR0801MB2085:
X-Microsoft-Antispam-PRVS: <DB6PR0801MB20857E2DE416A1B4B298662882839@DB6PR0801MB2085.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Nk5L/tb///FG6Bxdj3GD99n/eb/90tugwaPeKXVJERQkCch/RoHS0MJhI9EWJvPRcAotptc3YPWugrxgGjdDRTMKU/LY4WevJiBLK6yi2rFeD3UuyqRcxPG2mex9R1tkAMoDmUbndCQ69yZWqJWulY63wMW1K/HiwmxGS1xS+PxXok6TyKIfMa+vlKPWtVnIzDDxQiAMZO1XJqwPSn8Ubqr7dnVSgjCGSxeENSt+X8RJXx95lVJQvbOJgtP4bFtt8t/jiqaW2g6seQlBFjkj03oCdAFNG6dwR1U96uuMqK9A8FwKTGJGQOlMBHSQg6xTFNBsBHVAQY+d/cUuIKel1n5QD+0NGBOA56ro2b9JW3P6NQatdbXwb5P5ypiHsJ1d69S5kQW9pffkDU0SuRInVxw6bAtX86AdXoy1+8UuDKseEg6xie47dZ+2K5p8J6f0zI7q2kuBgTSv0hpq/QYASGJT+wUOZTyapfwZxRnX7b284TJpW673qeM8L27419GV/xQueDW9Y0xQiB+qrtOTxoU8Pg5Px1bVaL070OH4bYxWJUVy0ieip2+1F1y64vL5srGtogjYWIu48zrSzz6svJXa7/zL8pPwDySyoYG8ojSOGN6A4tIDBuD2qqL7l73JE5rU2/Y2Ard4zHh6xtX/unfTuiKrvbNpIovB3M7wvIbJzttd/AtmamA1fSoQ89iBLfGXCKeZBU0OV2b+i5GS7Q==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR08MB7237.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(54906003)(71200400001)(4326008)(55016002)(508600001)(26005)(8676002)(186003)(66946007)(6506007)(66556008)(33656002)(76116006)(66446008)(64756008)(83380400001)(7696005)(66476007)(38070700005)(122000001)(55236004)(52536014)(5660300002)(8936002)(86362001)(9686003)(38100700002)(2906002)(110136005);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB7311
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT014.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 7fe8449b-039a-4986-6d65-08d997c7760d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tRlwxxPx/j44dq/7cd0dR4nED4GVipjaR4O/1iqEzT39GHq1qOIVQ/4rZPj4Vad4PRATF8IusYXMyJqmUidrgW1UqNiCS7VqEbQIbLQGE5CyTKtzn/+W7m5kADx63Hp+C6raknaaFYokqE5tsTnqCC8owGZAWSjmmPEb/EsatY9cWSRBo1YxSSCgzd6NtpfLs0S2hkrWJfBug55k1cxOsIVnDTxy8jA3fXWwaLtZHzS5mQwFTWad/bqHS7ofLQl1tMEazuM3EfzV7TBJMNLwRCSn+8RcJTWlpoKK6LEjgz6LWwl8p3gaYmNYypGGMbwlkgzHneB/GdYfuWofEHDTeNeRRvfE44GWWEIJXE/eqGkygn08veahFUyY7uDX0QPDE7wPl4zSPPMLLO9n5He1ZLHjz6Ssqxw2mP0gxVE2qwRvxuFL8wL3FYQ0NcIro9EPGsQDB5Gixv3tJftYVBrX7bvywYtxjwkgi1Mqs2enkfL7A8Gh5qzGdOSRpChXa0Ddb+MSNs+LoYWPEZxIjOCQuSb9vzCfw0z6xHGMOJFjxqrnjmejtE5rXZjHEXU60lE2CnWHDsL0icOmPfI9Q8LxuDL3VTwgHfycR3R23p6gWcCOshD+fiTRJLecnQ2PF+nG8FcSwFL8DZZX1gJoZSxeWDt7kAsfDG3saj9+ByQyI1CNksYtu1v2PkBNEJz1zjR1LNr/B8bxT5GaDezOd3yN6Q==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(110136005)(54906003)(9686003)(70206006)(86362001)(82310400003)(107886003)(186003)(26005)(47076005)(356005)(2906002)(83380400001)(508600001)(81166007)(52536014)(336012)(5660300002)(36860700001)(8936002)(4326008)(6506007)(7696005)(8676002)(316002)(33656002)(55016002)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 14:55:26.7147
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 666c60fa-8362-4d1f-8bad-08d997c77afb
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT014.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB2085
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

VGhhbmtzIEdlb3JnaSBmb3IgaW5pdGlhdGluZyB0aGlzLg0KRG9u4oCZdCBoYXZlIHRvbyBtdWNo
IHRvIGFkZCwganVzdCBzb21lIGluaXRpYWwgdGhpbmtpbmcgb24gbXkgcGFydCBiZWxvdy4NCg0K
PiBGcm9tOiBHZW9yZ2kgRGpha292IDxkamFrb3ZAa2VybmVsLm9yZz4NCj4gU2VudDogVGh1cnNk
YXksIE9jdG9iZXIgMjEsIDIwMjEgMTI6MDYgUE0NCj4NCj4NCj4gSGkgYWxsLA0KPg0KPiBJIGFt
IHJlY2VudGx5IGdldHRpbmcgcXVlc3Rpb25zIGFib3V0IGhvb2tpbmcgdGhlIGludGVyY29ubmVj
dCBmcmFtZXdvcmsgdG8NCj4gU0NNSSwgc28gaSBhbSBzdGFydGluZyBhIGRpc2N1c3Npb24gb24g
dGhpcyBwcm9ibGVtIGFuZCBzZWUgd2hvIG1pZ2h0IGJlDQo+IGludGVyZXN0ZWQgaW4gaXQuDQo+
DQo+IFRoZSBTQ01JIHNwZWMgY29udGFpbnMgdmFyaW91cyBwcm90b2NvbHMgbGlrZSB0aGUgIlBl
cmZvcm1hbmNlIGRvbWFpbg0KPiBtYW5hZ2VtZW50IHByb3RvY29sIi4gQnV0IG5vbmUgb2YgdGhl
IHByb3RvY29scyBtZW50aW9uZWQgaW4gdGhlIGN1cnJlbnQNCj4gc3BlYyAoMy4wKSBzZWVtIHRv
IGZpdCB3ZWxsIGludG8gdGhlIGNvbmNlcHQgd2UgYXJlIHVzaW5nIHRvIHNjYWxlIGludGVyY29u
bmVjdA0KPiBiYW5kd2lkdGggaW4gTGludXguIEkgc2VlIHRoYXQgcGVvcGxlIGFyZSB3b3JraW5n
IGluIHRoaXMgYXJlYSBhbmQgdGhlcmUgaXMNCj4gYWxyZWFkeSBzb21lIHN1cHBvcnQgZm9yIGNs
b2NrcywgcmVzZXRzIGV0Yy4gSSBhbSB3b25kZXJpbmcgd2hhdCB3b3VsZCBiZSB0aGUNCj4gcmln
aHQgYXBwcm9hY2ggdG8gc3VwcG9ydCBhbHNvIGludGVyY29ubmVjdCBidXMgc2NhbGluZyB2aWEg
U0NNSS4NCg0KWW91IGFyZSByaWdodCAtIHRoZSBjdXJyZW50IFBlcmZvcm1hbmNlIERvbWFpbiBN
Z210LiBQcm90b2NvbCBpcyBub3QgZml0IGZvcg0KcHVycG9zZSBmb3IgdGhpcyByZXF1aXJlbWVu
dC4NCg0KPg0KPiBUaGUgaW50ZXJjb25uZWN0IGZyYW1ld29yayBpcyBwYXJ0IG9mIHRoZSBsaW51
eCBrZXJuZWwgYW5kIGl0J3MgZ29hbCBpcyB0byBtYW5hZ2UNCj4gdGhlIGhhcmR3YXJlIGFuZCB0
dW5lIGl0IHRvIHRoZSBtb3N0IG9wdGltYWwgcG93ZXItIHBlcmZvcm1hbmNlIHByb2ZpbGUNCj4g
YWNjb3JkaW5nIHRvIHRoZSBhZ2dyZWdhdGVkIGJhbmR3aWR0aCBkZW1hbmQgYmV0d2VlbiB0aGUg
dmFyaW91cyBlbmRwb2ludHMNCj4gaW4gdGhlIHN5c3RlbSAoU29DKS4gVGhpcyBpcyBiYXNlZCBv
biB0aGUgcmVxdWVzdHMgY29taW5nIGZyb20gY29uc3VtZXIgZHJpdmVycy4NCj4NCj4gQXMgaW50
ZXJjb25uZWN0cyBzY2FsaW5nIGRvZXMgbm90IG1hcCBkaXJlY3RseSB0byBhbnkgb2YgdGhlIGN1
cnJlbnRseSBhdmFpbGFibGUNCj4gcHJvdG9jb2xzIGluIHRoZSBTQ01JIHNwZWMsIGkgYW0gY3Vy
aW91cyB3aGV0aGVyIHRoZXJlIGlzIHdvcmsgaW4gcHJvZ3Jlc3Mgb24NCj4gc29tZSBvdGhlciBw
cm90b2NvbCB0aGF0IGNvdWxkIHN1cHBvcnQgbWFuYWdpbmcgcmVzb3VyY2VzIGJhc2VkIG9uIHBh
dGgNCj4gZW5kcG9pbnRzIChpbnN0ZWFkIG9mIGEgc2luZ2xlIElEKS4gVGhlIGludGVyY29ubmVj
dCBmcmFtZXdvcmsgZG9lc24ndCBwb3B1bGF0ZQ0KPiBldmVyeSBwb3NzaWJsZSBwYXRoLCBidXQg
aXQgZXhwb3NlcyBlbmRwb2ludHMgdG8gY2xpZW50IGRyaXZlcnMgYW5kIHRoZSBwYXRoDQo+IGxv
b2t1cCBpcyBkeW5hbWljLCBiYXNlZCBvbiB3aGF0IHRoZSBjbGllbnRzIHJlcXVlc3QuIE1heWJl
IHRoZSBTQ01JIGhvc3QNCj4gY291bGQgYWxzbyBleHBvc2UgYWxsIHBvc3NpYmxlIGVuZHBvaW50
cyBhbmQgbGV0IHRoZSBndWVzdCByZXF1ZXN0IGEgcGF0aCBmcm9tDQo+IHRoZSBob3N0LCBiYXNl
ZCBvbiB0aG9zZSBlbmRwb2ludHMuDQo+DQo+IFRoZXJlIGFyZSBhbHJlYWR5IHN1Z2dlc3Rpb25z
IHRvIGNyZWF0ZSB2ZW5kb3Itc3BlY2lmaWMgU0NNSSBwcm90b2NvbHMgZm9yIHRoYXQsDQo+IGJ1
dCBpIGZlYXIgdGhhdCB3ZSBtYXkgZW5kIHVwIHdpdGggbW9yZSB0aGFuIG9uZSBwcm90b2NvbCBm
b3IgdGhlIHNhbWUgdGhpbmcsDQo+IHNvIHRoYXQncyB3aHkgaXQgbWlnaHQgYmUgYmVzdCB0byBk
aXNjdXNzIGl0IGluIHB1YmxpYyBhbmQgaGF2ZSBhIGNvbW1vbiBzb2x1dGlvbg0KPiB0aGF0IHdv
cmtzIGZvciBldmVyeW9uZS4NCg0KKzEuIElmIHRoZXJlIGlzIGEgY29tbW9uIHJlcXVpcmVtZW50
IHRvIGJlIGZvdW5kIHRoYXQgaXMgYWx3YXlzIHRoZSBiZXN0LiBWZW5kb3Igc3BlY2lmaWMNCnBy
b3RvY29scyBtaWdodCBlbmQgdXAgd2l0aCBleHRlbnNpYmlsaXR5IGlzc3VlcyBvbmNlIGEgc2lt
aWxhciBwcm90b2NvbCBnZXRzDQpzdXBwb3J0ZWQgaW4gYSBmdXR1cmUgdmVyc2lvbiBvZiB0aGUg
c3BlY2lmaWNhdGlvbi4NCg0KUmVnYXJkcywNClNvdXZpaw0KDQo+DQo+IFRoYW5rcywNCj4gR2Vv
cmdpDQpJTVBPUlRBTlQgTk9USUNFOiBUaGUgY29udGVudHMgb2YgdGhpcyBlbWFpbCBhbmQgYW55
IGF0dGFjaG1lbnRzIGFyZSBjb25maWRlbnRpYWwgYW5kIG1heSBhbHNvIGJlIHByaXZpbGVnZWQu
IElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQsIHBsZWFzZSBub3RpZnkgdGhl
IHNlbmRlciBpbW1lZGlhdGVseSBhbmQgZG8gbm90IGRpc2Nsb3NlIHRoZSBjb250ZW50cyB0byBh
bnkgb3RoZXIgcGVyc29uLCB1c2UgaXQgZm9yIGFueSBwdXJwb3NlLCBvciBzdG9yZSBvciBjb3B5
IHRoZSBpbmZvcm1hdGlvbiBpbiBhbnkgbWVkaXVtLiBUaGFuayB5b3UuDQo=
