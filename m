Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40ED936B152
	for <lists+linux-pm@lfdr.de>; Mon, 26 Apr 2021 12:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbhDZKLo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Apr 2021 06:11:44 -0400
Received: from mail-db8eur05on2060.outbound.protection.outlook.com ([40.107.20.60]:27489
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232178AbhDZKLn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 26 Apr 2021 06:11:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JeP0QTxeVs5OXj+zfLNK/9hYweK1KXje7QYxcoHgCQc=;
 b=TOqcuyT7We08eJ6aEjBMNyWy2kJTz76tzxIr/+D3yhzSMvKUMrphLTWTZ8YqFycPEMltqqkTplgUdqXTEFi2ocexE46KLOzpHRu6aJ7aae+TeMlM24pnH7pqRbnhVM8EUFpV/5Dq+gLpd/gQbQDQPez3etTcCJJUMHkt7+vx4xo=
Received: from DB6PR07CA0114.eurprd07.prod.outlook.com (2603:10a6:6:2c::28) by
 AM0PR08MB3940.eurprd08.prod.outlook.com (2603:10a6:208:124::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22; Mon, 26 Apr
 2021 10:10:58 +0000
Received: from DB5EUR03FT053.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:6:2c:cafe::45) by DB6PR07CA0114.outlook.office365.com
 (2603:10a6:6:2c::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.16 via Frontend
 Transport; Mon, 26 Apr 2021 10:10:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT053.mail.protection.outlook.com (10.152.21.119) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.21 via Frontend Transport; Mon, 26 Apr 2021 10:10:58 +0000
Received: ("Tessian outbound 81a4524e9a48:v90"); Mon, 26 Apr 2021 10:10:58 +0000
X-CR-MTA-TID: 64aa7808
Received: from aaf70c25bc81.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id E0E069B0-CB3B-42EA-BB71-D28ED77A3D0B.1;
        Mon, 26 Apr 2021 10:10:48 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id aaf70c25bc81.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 26 Apr 2021 10:10:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YeOqFMsKeulDI4nI7yYINcyww42lpt2Y47zEfTKagycu1j2L/38LUPyOwPVqGxvJBH6ptI5BU4CATlcfrELG/NjSufHhmBJeIN5eions0Oee8gtMj2Zr2TGFhpZic9wCRMgeoeu6x7K0Xh0JxhmOORJ90ARvn3Ds03aey4QqSLA+5m6X9Z3NZvyAHISSwPApGgxCX3jDft66HTLJ37rMSTiHxrjCdWNuedJb9CIjAVVSeSrkYr/XP5LbXX71+zxsltsjraaRFNXDJDQD+D/KtWP3FflUpQT4RsqyvCzO3RhucQYr9LYQ+oipNS8XeeQ3ymmr0lgTsw4S2WJYv9gMMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JeP0QTxeVs5OXj+zfLNK/9hYweK1KXje7QYxcoHgCQc=;
 b=LRhvgG+Gnmja2XHAplUY7yPmEu5yQOs2Q7opgj69ym3S0SLtkvkDOUxg9BDD+zghu1DlTBSJ7jEnLBG3d0yShGLIThZkAfhNbVUZnzSq143sa/pUTSIXJOj3w/nsdVKboy5fJfNon2SKXTnMKFqQ7ENwY2GBrOcXYnsQclRKV7VrIEr8GTMCdAgXxIXpM3ULuS8Kf68ersrntw4MCJuTIqqTff/BwkoSip+5IYmcnF8pp/TE7VudkWsHGJ0Otxlt+4rKgEk+UIsnWeQs79/7oGXAbaJ+8aR4dlsqWfRi986JodmGfm7iujY8hVpP/QW91bLOQTBq7n9PPRFFB4hgvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JeP0QTxeVs5OXj+zfLNK/9hYweK1KXje7QYxcoHgCQc=;
 b=TOqcuyT7We08eJ6aEjBMNyWy2kJTz76tzxIr/+D3yhzSMvKUMrphLTWTZ8YqFycPEMltqqkTplgUdqXTEFi2ocexE46KLOzpHRu6aJ7aae+TeMlM24pnH7pqRbnhVM8EUFpV/5Dq+gLpd/gQbQDQPez3etTcCJJUMHkt7+vx4xo=
Received: from AM6PR08MB3656.eurprd08.prod.outlook.com (2603:10a6:20b:51::10)
 by AM7PR08MB5399.eurprd08.prod.outlook.com (2603:10a6:20b:104::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Mon, 26 Apr
 2021 10:10:45 +0000
Received: from AM6PR08MB3656.eurprd08.prod.outlook.com
 ([fe80::bcc3:e5b4:e738:d92c]) by AM6PR08MB3656.eurprd08.prod.outlook.com
 ([fe80::bcc3:e5b4:e738:d92c%6]) with mapi id 15.20.4065.027; Mon, 26 Apr 2021
 10:10:45 +0000
From:   Souvik Chakravarty <Souvik.Chakravarty@arm.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        Lukasz Luba <Lukasz.Luba@arm.com>
CC:     Sudeep Holla <Sudeep.Holla@arm.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "ksitaraman@nvidia.com" <ksitaraman@nvidia.com>,
        "sanjayc@nvidia.com" <sanjayc@nvidia.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [RFC PATCH 0/4] Support for passing runtime state idle time to
 TF-A
Thread-Topic: [RFC PATCH 0/4] Support for passing runtime state idle time to
 TF-A
Thread-Index: AQHXN7Z5Vp5HtofuNUqzimcKM7DQHarCi8uAgAAjvICAA+gakA==
Date:   Mon, 26 Apr 2021 10:10:45 +0000
Message-ID: <AM6PR08MB3656190AAF022E0457BEBF9282429@AM6PR08MB3656.eurprd08.prod.outlook.com>
References: <1619123448-10138-1-git-send-email-skomatineni@nvidia.com>
 <064341f7-dce3-5ad4-e69b-9568115035c1@arm.com>
 <486856be-1e66-fd77-e306-949b91bcdb1d@nvidia.com>
In-Reply-To: <486856be-1e66-fd77-e306-949b91bcdb1d@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: A01C3D6BE873924D903A83CF42063F01.0
x-checkrecipientchecked: true
Authentication-Results-Original: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=arm.com;
x-originating-ip: [2a02:c7f:1e66:2200:1528:49ba:a5:1390]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 64f6a5b7-b8b4-4117-8653-08d9089b9649
x-ms-traffictypediagnostic: AM7PR08MB5399:|AM0PR08MB3940:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB39403B14DCD7ED8F7ACD82CF82429@AM0PR08MB3940.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: R1Pz0xhUALeYmkQOcZrz1O/sgJFNOfkOrfzX8RVr6kZc65hn8Hi72aCmYxuM+q2SFaLMfS89iHE8GJ1rsyRpq0FbLsWBFjbZQdOmqjB3gKcHSQDXhjIH/Kri26Oh80XmWlCFmp9i8YipL189LmlWq+ViEQSK7Tcsr9DpXHOWq0jCQ974qhTvZGnUixfwa6XsthiXONtbieT+h/XrTeMBGeIuiSjMl12R0ZniKK7RUYnUviALG6GO8FTFsREyYw7fsAluARSvB9npvyOVDM6VsuO0EASrlnGlY2p1FEA6kEcA9vlmh8X7Aqula/zKk98KhzmCdw5zGWChbejQrOhkQZuHmbehsamG6KUwKP77Yeo7vbCi/1O7x7jXlldyGKrkJ7zLLmfFCwsA9UX2vA9aLpBfxSVZGSn5v069iet+b8/DN72kmia4nZ6xvl49drgdXsvF0Q4kPnCfIBPMZnY/ZSHFLLVp4YolZIBZxPGYHg7qim7sFzSeX6owQlOI8wgCx+0ZojhKD8YMbwUx6ODmRrGmpW7EB9UVkSf3mQ8ZnL9My43C6j/pP4uY3pDZznSdFovKp2on2PSVbK3pq4EuwN2/rGwocBgGZIqqJkPIWsE=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3656.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(76116006)(2906002)(38100700002)(66476007)(55016002)(122000001)(9686003)(83380400001)(53546011)(7696005)(71200400001)(478600001)(8676002)(186003)(6506007)(66946007)(4326008)(8936002)(54906003)(110136005)(66446008)(33656002)(52536014)(64756008)(66556008)(7416002)(5660300002)(6636002)(86362001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ajBLRlpERmd0TlZUTldmaGlObGFXcm1RT0RrUERJbnNxcW05aFdBbmV0R01u?=
 =?utf-8?B?UHdQSUtJT2x2ZW1OVTh0NUoyWmVNcld3ZERYejFzZkljcHZScjhxSTZhR3JW?=
 =?utf-8?B?NWtaNDUyMm01djdVanlLalZYRlRzV05PYWMxUDc3bitPOUUxajFONnRmbDl3?=
 =?utf-8?B?aE1velhwblpVYlpzT25nZGJuY3dEdWFWdWpJeHdoMWhLcFJNN0phaUpBN1Rw?=
 =?utf-8?B?dXN3N2FWeGN4V2w5ZDZLNFN1QkZEeHdsN285QnlEMWhmemE5QmNsS3hGeXM2?=
 =?utf-8?B?SzRsTkV6Mzkvenl3a3VHK256VG1mYTFZZDVJZDcvTDAzQmpNekI4K1Zla3Bv?=
 =?utf-8?B?YnZ4bS9hVnVXSk5EcE5wV3NPamZnYWxHb3l3YXI2K0VWWWFiZ2ZOYmlJSVV1?=
 =?utf-8?B?cHZkMnQ1SERtNTVHaHN4bjkxMG5wVGdybUw3RFBYQkVJWUFwN3RlQmFieHAy?=
 =?utf-8?B?SERoSzllT2dSQ0E2MmxZQm8yeERDVXFuWXJJRWdNWEd4K3dwd05yV0tobUt0?=
 =?utf-8?B?Mit2c3EwZHFiVjhwc1QwejdyRG05VVhMM3FSSlUwalRGeXErSnlhQ0wvYnR3?=
 =?utf-8?B?dk96Y1cxTFFRRmloRXk0akZKYlBQTVRiSjFNQVRkSmhDcE8zRGdZdFd0SnFm?=
 =?utf-8?B?NWNMSGlhL2ZiVW1FYXpSZVdDcjV5OHhFeGJWL3VWSkFzeTlncnV6cDJ0N0Rh?=
 =?utf-8?B?WEcrZnVwN2tZOWI5aGgvamZNcWMzR1ZnZTVKVG1jbnlxRi9YNFNkbVV6dFVs?=
 =?utf-8?B?SWMxSzM0QmdyVmtrR2ppME80SHdYbWJwbkFPZFoyZFQ1OHlsM3czdzN5UWI3?=
 =?utf-8?B?amQraUlxUU50TndjSGVFMCtvWGcrVlRrSkxiSTU0eGM2d0M3VkUvQ1JEbll2?=
 =?utf-8?B?NHE5TUNuQVRFYnZSRGxiemo2R09SNkxCL3Z6ZkdNMHY5UFplUXh0ZjI1YUJW?=
 =?utf-8?B?VlpaZlJ2bEY0SmZGUFdhbVVVUHU0VGd5bjFLNmRWUW9SUWxxZ1daZ0oxbzVy?=
 =?utf-8?B?NkJwdzVkM1hQcGxFK3FTaDVsTlcvYm9yeTdqaHQ0OFdqRkNlSDdmdzZIeTFB?=
 =?utf-8?B?RzMwVFp5RElMd3d6SWVRMG1CZVFLZlZ0RXFjYlhwSktLZmFIdkkyUzdld05m?=
 =?utf-8?B?aFdoL0VHTEVBZTZwRXV1dEJiY1VpVFZtMEFBak4yZ2VSeFVLSWZIZis1SDdU?=
 =?utf-8?B?NmJwclBaL1Z0aFlrV3pWSi9hWnJsejRTWHcwdzFjYXd0Vlp0VWpMbm1xSTlN?=
 =?utf-8?B?N0RNT0svZHh1STFSc2VwL1p2T1E0bklBUHlqRzJJRU1vd0Y1bWROK1pxWkVR?=
 =?utf-8?B?dVlDSHM5KzJCY1ZHdEJraVdmOFliRUtVKytwY0ZPR0g0WGg3eFljUHpXMno2?=
 =?utf-8?B?cCtJNjErU25QSUt2UkEvOFVNN1dvOGNGWUZnZ3lVd1I4TVo0WUtXZ1FZZW5i?=
 =?utf-8?B?bVVQNWRTVWViUGhjdzVGMGZGMS9QMDVkaGZ1VGtPSnBlS016ejhPMnVnVDNn?=
 =?utf-8?B?Y2E2TFlYSSs5dklkS0RYbG1KNGdDaStvQklaTXJTZjJzMEYzZDg5UU5LWVdK?=
 =?utf-8?B?SFBSZ2c1UHVUWjlxVnpKVjNLekdPMGNkZnpBT0ExWmd1WE4vS1dvME9YcDdM?=
 =?utf-8?B?T1F3a01ZN3I1SGJ1Qll0MEMwdjBCYVY4YUhlOVVqV1BCd2ZXbnNLNVIwL3J6?=
 =?utf-8?B?eWxyN2ZxQTk0SEt4S0c3TFc3SjlQdzFZaCtteEgzVVMzV2pDZTlrbHJKNEV6?=
 =?utf-8?B?bkJBRDhxMndrSGpVdnpwdks0b1RJSTFtckhIbVlnMEZ6dlBoejR3QndZbURS?=
 =?utf-8?Q?g8P6VdafMdr5FMQ1Im7ibtApvjWwVBWQ6/kIY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5399
Original-Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT053.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: a9e40715-8abd-4564-c10b-08d9089b8e8b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IsrwHUZX0BlHjn0meYi7ppKzWOWqYbi1p1/zzROTuPVCjA+cC9A2kZSRMImwnin6lR3I3svCMi66HiFq1HV/vCD3Vzt6XdDnCP/s8GJiv6OCyZPQLDuS8MgfdKZkyYfm+N0AqI6zr3D/DViUvMZr/I2kQA+WzGG+G8Njna/LUJ/vGHv1SU0gK6wFJYjPXGjFkA/9f90nKqxRna8NTBBoxRwrOr+JbZQ+IkHxDURXjdGgrK3BFrDBLOs0AQCoi/PAUuau/0Qm7KGl16WFSe8fIa+Uhu/qo1sX1IH7s7VZw3PVBdN6BbT/2riHDSxhMN7jpoZmxVKGBJQ1HJZLPrQUExytE/x7pH7OSy2eNA24MdMWLp3IQM9qNkY4AX4o4MI+OHQLE9PYR226FVIqfmUax0qmJ5hc1dwv1FN4ddQUTwA0xLQ2n+O7HGHaX0fV66GGB/hs+ragdpaJkfbeaqZQ4Xkq9LqAgvO0JTFZhhzxp8iA/VhUcJ3tPEeXzrts15B8T75wTvvQWEgPyAwTriqDuDtm4bPW5C+hcxsOdj5A94lYaa5RubFzAAbMANYAlM6iu/UCMWDCtBAR9KMV3m88fg7haVWKWorYtyHP/XFFDDXbfjF2tvQ2UdwsG3CKIVgdryIvyBioDAmw1ZwJAi0SkABnjHRUFF6szps5FLipXbQqPN/huN46Bl0i5rkLwE6P
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(396003)(376002)(46966006)(36840700001)(70586007)(8676002)(70206006)(47076005)(4326008)(9686003)(82740400003)(86362001)(186003)(336012)(8936002)(26005)(316002)(356005)(52536014)(55016002)(450100002)(53546011)(83380400001)(7696005)(36860700001)(81166007)(6636002)(82310400003)(34020700004)(5660300002)(478600001)(33656002)(2906002)(6506007)(110136005)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2021 10:10:58.3789
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64f6a5b7-b8b4-4117-8653-08d9089b9649
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT053.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3940
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgU293amFueWEsDQoNCj4gRnJvbTogU293amFueWEgS29tYXRpbmVuaQ0KPiBTZW50OiBGcmlk
YXksIEFwcmlsIDIzLCAyMDIxIDExOjI1IFBNDQo+IA0KPiBPbiA0LzIzLzIxIDE6MTYgUE0sIEx1
a2FzeiBMdWJhIHdyb3RlOg0KPiA+IEhpIFNvd2phbnlhLA0KPiA+DQo+ID4gT24gNC8yMi8yMSA5
OjMwIFBNLCBTb3dqYW55YSBLb21hdGluZW5pIHdyb3RlOg0KPiA+PiBUZWdyYTE5NCBhbmQgVGVn
cmExODYgcGxhdGZvcm1zIHVzZSBzZXBhcmF0ZSBNQ0UgZmlybXdhcmUgZm9yIENQVXMNCj4gPj4g
d2hpY2ggaXMgaW4gY2hhcmdlIG9mIGRlY2lkaW5nIG9uIHN0YXRlIHRyYW5zaXRpb24gYmFzZWQg
b24gdGFyZ2V0DQo+ID4+IHN0YXRlLCBzdGF0ZSBpZGxlIHRpbWUsIGFuZCBzb21lIG90aGVyIFRl
Z3JhIENQVSBjb3JlIGNsdXN0ZXIgc3RhdGVzDQo+ID4+IGluZm9ybWF0aW9uLg0KPiA+Pg0KPiA+
PiBDdXJyZW50IFBTQ0kgc3BlY2lmaWNhdGlvbiBkb24ndCBoYXZlIGZ1bmN0aW9uIGRlZmluZWQg
Zm9yIHBhc3NpbmcNCj4gPj4gcnVudGltZSBzdGF0ZSBpZGxlIHRpbWUgcHJlZGljdGVkIGJ5IGdv
dmVybm9yIChiYXNlZCBvbiBuZXh0IGV2ZW50cw0KPiA+PiBhbmQgc3RhdGUgdGFyZ2V0DQo+ID4+
IHJlc2lkZW5jeSkgdG8gQVJNIHRydXN0ZWQgZmlybXdhcmUuDQo+ID4NCj4gPiBEbyB5b3UgaGF2
ZSBzb21lIG51bWJlcnMgZnJvbSBleHBlcmltZW50cyBzaG93aW5nIHRoYXQgdGhlc2UgaWRsZQ0K
PiA+IGdvdmVybm9yIHByZWRpY3Rpb24gdmFsdWVzLCB3aGljaCBhcmUgcGFzc2VkIGZyb20ga2Vy
bmVsIHRvIE1DRQ0KPiA+IGZpcm13YXJlLCBhcmUgbWFraW5nIGEgZ29vZCAnZ3Vlc3MnPw0KPiA+
IEhvdyBtdWNoIHByZWNpc2lvbiAoMXVzPyAxbXM/KSBpbiB0aGUgdmFsdWVzIGRvIHlvdSBuZWVk
IHRoZXJlPw0KPiANCj4gaXQgY291bGQgYWxzbyBiZSBpbiBmZXcgbXMgZGVwZW5kaW5nIG9uIHdo
ZW4gbmV4dCBjcHUgZXZlbnQvYWN0aXZpdHkgbWlnaHQNCj4gaGFwcGVuIHdoaWNoIGlzIG5vdCB0
cmFuc3BhcmVudCB0byBNQ0UgZmlybXdhcmUuDQo+IA0KPiA+DQo+ID4gSUlSQyAocHJvYmFibHkg
UmFmYWVsJ3MgcHJlc2VudGF0aW9ucykgcHJlZGljdGluZyBpbiB0aGUga2VybmVsDQo+ID4gc29t
ZXRoaW5nIGxpa2UgQ1BVIGlkbGUgdGltZSByZXNpZGVuY3kgaXMgbm90IGEgdHJpdmlhbCB0aGlu
Zy4NCj4gPg0KPiA+IEFub3RoZXIgaWRlYSAoZGVwZW5kaW5nIG9uIERUIHN0cnVjdHVyZSBhbmQg
UFNDSSBiaXRzKToNCj4gPiBDb3VsZCB0aGlzIGJlIHNvbHZlZCBkaWZmZXJlbnRseSwgYnV0IGp1
c3QgaGF2aW5nIGEga25vd2xlZGdlIHRoYXQgaWYNCj4gPiB0aGUgZ292ZXJub3IgcmVxdWVzdGVk
IHNvbWUgQy1zdGF0ZSwgdGhpcyBtZWFucyBnb3Zlcm5vciAncHJlZGljdGVkJw0KPiA+IGFuIGlk
bGUgcmVzaWRlbmN5IHRvIGJlIGdyZWF0ZXIgdGhhdCBtaW5fcmVzaWRlbmN5IGF0dGFjaGVkIHRv
IHRoaXMNCj4gPiBDLXN0YXRlPw0KPiA+IFRoZW4sIHdoZW4gdGhhdCByZXF1ZXN0IHNob3dzIHVw
IGluIHlvdXIgRlcsIHlvdSBrbm93IHRoYXQgaXQgbXVzdCBiZQ0KPiA+IGF0IGxlYXN0IG1pbl9y
ZXNpZGVuY3kgYmVjYXVzZSBvZiB0aGlzIEMtc3RhdGUgaWQuDQo+IEM2IGlzIHRoZSBvbmx5IGRl
ZXBlc3Qgc3RhdGUgZm9yIFRlZ3JhMTk0IENhcm1lbCBDUFUgdGhhdCB3ZSBzdXBwb3J0IGluDQo+
IGFkZGl0aW9uIHRvIEMxIChXRkkpIGlkbGUgc3RhdGUuDQo+IA0KPiBNQ0UgZmlybXdhcmUgZ2V0
cyBzdGF0ZSBjcm9zc292ZXIgdGhyZXNob2xkcyBmb3IgQzEgdG8gQzYgdHJhbnNpdGlvbiBmcm9t
IFRGLQ0KPiBBIGFuZCB1c2VzIGl0IGFsb25nIHdpdGggc3RhdGUgaWRsZSB0aW1lIHRvIGRlY2lk
ZSBvbiBDNiBzdGF0ZSBlbnRyeSBiYXNlZCBvbg0KPiBpdHMgYmFja2dyb3VuZCB3b3JrLg0KPiAN
Cj4gQXNzdW1pbmcgZm9yIG5vdyBpZiB3ZSB1c2UgbWluX3Jlc2lkZW5jeSBhcyBzdGF0ZSBpZGxl
IHRpbWUgd2hpY2ggaXMgc3RhdGljDQo+IHZhbHVlIGZyb20gRFQsIHRoZW4gaXQgZW50ZXJzIGlu
dG8gZGVlcGVzdCBzdGF0ZSBDNiBhbHdheXMgYXMgd2UgdXNlDQo+IG1pbl9yZXNpZGVuY3kgdmFs
dWUgd2UgdXNlIGlzIGFsd2F5cyBoaWdoZXIgdGhhbiBzdGF0ZSBjcm9zc292ZXIgdGhyZXNob2xk
Lg0KPiANCj4gQnV0IE1DRSBmaXJtd2FyZSBpcyBub3QgYXdhcmUgb2Ygd2hlbiBuZXh0IGNwdSBl
dmVudCBjYW4gaGFwcGVuIHRvDQo+IHByZWRpY3QgaWYgbmV4dCBldmVudCBjYW4gdGFrZSBsb25n
ZXIgdGhhbiBzdGF0ZSBtaW5fcmVzaWRlbmN5IHRpbWUuDQo+IA0KPiBVc2luZyBtaW4gcmVzaWRl
bmN5IGluIHN1Y2ggY2FzZSBpcyB2ZXJ5IGNvbnNlcnZhdGl2ZSB3aGVyZSBNQ0UgZmlybXdhcmUN
Cj4gZXhpdHMgQzYgc3RhdGUgZWFybHkgd2hlcmUgd2UgbWF5IG5vdCBoYXZlIGJldHRlciBwb3dl
ciBzYXZpbmcuDQo+IA0KPiBCdXQgd2l0aCBNQ0UgZmlybXdhcmUgYmVpbmcgYXdhcmUgb2Ygd2hl
biBuZXh0IGV2ZW50IGNhbiBoYXBwZW4gaXQgY2FuDQo+IHVzZSB0aGF0IHRvIHN0YXkgaW4gQzYg
c3RhdGUgd2l0aG91dCBlYXJseSBleGl0IGZvciBiZXR0ZXIgcG93ZXIgc2F2aW5ncy4NCg0KVGhp
cyBwYXJ0IGNvbmZ1c2VzIG1lLiBBcmUgeW91IHNheWluZyB0aGF0IHRoZSBmaXJtd2FyZSB3aWxs
IGZvcmNlZnVsbHkgd2FrZSB1cA0KdGhlIGNvcmUsIGV2ZW4gaWYgbm8gd2FrZXVwcyBhcmUgcGVu
ZGluZywgd2hlbiBtaW4gcmVzaWRlbmN5IGZvciBDNiBleHBpcmVzPw0KDQpSZWdhcmRzLA0KU291
dmlrDQoNCj4gDQo+ID4gSXQgd291bGQgZGVwZW5kIG9uIG51bWJlciBvZiBhdmFpbGFibGUgc3Rh
dGVzLCBtYXhfcmVzaWRlbmN5LCBzY2FsZQ0KPiA+IHRoYXQgeW91IHdvdWxkIGNob29zZSB3aGls
ZSBhc3NpZ25pbmcgdmFsdWVzIGZyb20gWzAsIG1heF9yZXNpZGVuY3ldDQo+ID4gdG8gZWFjaCBz
dGF0ZS4NCj4gPiBJSVJDIHRoZXJlIGNhbiBiZSBtYW55IHN0YXRlIElEcyBmb3IgaWRsZSwgc28g
aXQgd291bGQgZGVwZW5kIG9uDQo+ID4gbnVtYmVyIG9mIGJpdHMgZW5jb2RpbmcgdGhpcyBzdGF0
ZSwgYW5kIHlvdXIgbmVlZHMuIEV4YW1wbGUgb2YgbGluZWFyDQo+ID4gc2NhbGU6DQo+ID4gNC1i
aXRzIGVuY29kaW5nIGlkbGUgc3RhdGUgYW5kIG1heCBwcmVkaWN0ZWQgcmVzaWRlbmN5IDEwbXNl
YywgdGhhdA0KPiA+IG1lYW5zIDEwMDAwdXMgLyAxNiBzdGF0ZXMgPSA2MjV1cy9zdGF0ZS4NCj4g
PiBUaGUgbWF4X3Jlc2lkZW5jeSBtaWdodCBiZSBzcGxpdCBkaWZmZXJlbnRseSwgdXNpbmcgZGlm
ZmVyZW50IHRoYW4NCj4gPiBsaW5lYXIgZnVuY3Rpb24sIHRvIGhhdmUgc29tZSByYWdlIG1vcmUg
cHJlY2lzZWQuDQo+ID4NCj4gPiBPcGVuIHF1ZXN0aW9uIGlzIGlmIHRoZXNlIGlkbGUgc3RhdGVz
IG11c3QgYmUgYWxsIHJlcHJlc2VudGVkIGluIERULA0KPiA+IG9yIHRoZXJlIGlzIGEgd2F5IG9m
IGRlc2NyaWJpbmcgYSAnc2V0IG9mIGlkbGUgc3RhdGVzJw0KPiA+IGF1dG9tYXRpY2FsbHkuDQo+
IFdlIG9ubHkgc3VwcG9ydCBDNiBzdGF0ZSB0aHJvdWdoIERUIGFzIEM2IGlzIHRoZSBvbmx5IGRl
ZXBlc3Qgc3RhdGUgZm9yDQo+IFRlZ3JhMTk0IGNhcm1lbCBDUFUuIFdGSSBpZGxlIHN0YXRlIGlz
IGNvbXBsZXRlbHkgaGFuZGxlZCBieSBrZXJuZWwgYW5kDQo+IGRvZXMgbm90IHJlcXVpcmUgTUNF
IHNlcXVlbmNlcyBmb3IgZW50cnkvZXhpdC4NCj4gPg0KPiA+IFJlZ2FyZHMsDQo+ID4gTHVrYXN6
DQo=
