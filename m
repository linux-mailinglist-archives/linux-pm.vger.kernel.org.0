Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7130E42A282
	for <lists+linux-pm@lfdr.de>; Tue, 12 Oct 2021 12:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236057AbhJLKoQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Oct 2021 06:44:16 -0400
Received: from mail-eopbgr60053.outbound.protection.outlook.com ([40.107.6.53]:44033
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235981AbhJLKoO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 12 Oct 2021 06:44:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NbElXqdoeJjNcQTOJc41lOgshkra6T3SwicMqywfDNiT8pzylp0itIP1OODh5u2xnqe9fZlZ9olM6AzXxeI4n2+VUJTvZ0lzKpN0Uyy7VUdPj6bOxKW6HrYzr98WebmrDOLYA/c5DEF9Pg6SMiWeH+turgWHKOFy6G/9ZZZAJc6WnZ3tZaJgt+kZRDqDg1ucpRR3INRyj9QiHEm/AzCkVjGbXdWUjJe0Gtppfl1klbWb2RMWphkpIbW8ue3PvYcsd5b0uBlpSWTm3TySqjLGUL3hsJnsEK7YuNEH+ySR9FPbkrSxTdzdQJU9ftkIjMmohhIC6miOYTPC0f4XLKsAjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rV/jueGf4i/UzAJrTwYr7gsCgVIF0rTUkFErzDhLiOM=;
 b=fE5/g3HaDZVE1u0Ti7KMjmhDL+LJCyUalp6gjDF0Ah34rF0heJvCHEedK+Pkiwe2VWDVRNvlqMMUERLTSQvHaII08R3iQkuM7CIKe5g+7W6lpLI/+EC16ypZ6geO/xAyLZUSUMcUgz0+xMMM2XgQBZaGSY2sB6zCyFMJkpH6xuSlU15q9isktdZGx6EGm7Dr261g3a+3erTbqkaVrvLxPD2uJqfV3lhS1ECpGG44HMtLE54AomszT19MRthBrtzBpswFVMPxXBtqVLwaT94eIuTDVawmtd0MaDudyN+ANPhtbIIR+BVJ/zgOc/lwlj1Abgx71jv84PaZTb15tYr1Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rV/jueGf4i/UzAJrTwYr7gsCgVIF0rTUkFErzDhLiOM=;
 b=rtPDCws6V2nrukLOdjeeiTXZ9sk7nMQe35VZccCCyJXMEej0jiBcgxbtA5F5puXsVsA/xGgaHh/JCQj696Pmf3PFUZesbdCK+S2gRvoH/2A1tw7tIJsgBmySSG9J/FYmiJhwBEQVqsHj5yaWhAeAxs/WjWk23yu24mZGaA3Q2nU=
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:255::23)
 by DB8PR10MB3737.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:119::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Tue, 12 Oct
 2021 10:42:06 +0000
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dc0f:9e52:6dbb:1144]) by DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dc0f:9e52:6dbb:1144%6]) with mapi id 15.20.4587.026; Tue, 12 Oct 2021
 10:42:06 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>
CC:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Benson Leung <bleung@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "bleung@chromium.org" <bleung@chromium.org>,
        "badhri@google.com" <badhri@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Reichel <sre@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: RE: [RFC PATCH 2/3] power: supply: Add support for PDOs props
Thread-Topic: [RFC PATCH 2/3] power: supply: Add support for PDOs props
Thread-Index: AQHXoEKRtU4w32eDxEeY6U4KQGzJs6uiBmsAgAAaumCAAUDQAIAC9NuAgAAyawCAAD1scIAHpq+AgAUCZYCAFOYpgIAA06KAgAZBMiA=
Date:   Tue, 12 Oct 2021 10:42:06 +0000
Message-ID: <DB9PR10MB4652F5AC42208209BE8BBC5180B69@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
References: <20210902213500.3795948-3-pmalani@chromium.org>
 <YT9SYMAnOCTWGi5P@kuha.fi.intel.com>
 <DB9PR10MB4652B4A6A2A2157018307AE380D99@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <YUB16up3JDwi3HfI@kuha.fi.intel.com> <YULwz8NsoA3+vrhA@google.com>
 <YUMbGp0aemx1HCHv@kuha.fi.intel.com>
 <DB9PR10MB46525E6CA4C6BB101059D93C80DC9@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <YUm5sdbceMcDTvYj@kuha.fi.intel.com>
 <DB9PR10MB46524E3817FB4D836CDC13E180A49@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <CACeCKaem93dbJ11qOG=a+MkJhSrp0Nx-UAPG00Q-5WwMriJD0A@mail.gmail.com>
 <YWAnA1mc5CrlEs7H@kuha.fi.intel.com>
In-Reply-To: <YWAnA1mc5CrlEs7H@kuha.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none
 header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee247a69-151d-40fb-9b13-08d98d6cef78
x-ms-traffictypediagnostic: DB8PR10MB3737:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR10MB373751A518B746CE688CCED0A7B69@DB8PR10MB3737.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aaB6L9aRV+UZ2IS8QvQw7ANTLAw3KAO+Gg69PxvnEQs6vBPkTafIWjtaLZMOEGOOyc1VEm/sHOOmAyPbyVb2DQJF3n0Y3Po058aR+a39maerdjxW5aakfynSMqEThmfnI7v5JYV7LbPdumGEbWbahc7SkIa9TDsS4P18SnVohjj4q80Ch+7pK/f8NhP+r2hfb/4uWNq1D2MS//Ts00m883FlzkKPkZYsWQiPaDo1OYvbiYLe+KwoEfVjvP61bNbB4B+CcCjvE4XGyPYHTpr4+U7Rh8C1Au9ZpbhNGw8POU3GRsskE+weqfRu5g3ZKD5+XHh7uzDiZxeyX+GwdPg+SrSlk6b6ufoHtlgFpeobHSqF3nlo7dKC2yxYoCPGuELBU4fOM/EfR11qvYw3xtmJ16RdrVceE5vEW2lcucssodW4PSksCb88kdfN2QaakLCvQryybyjvX23r69RFZ2BegNFRLys2aEhLzR2XPRJ72TT0SothF7xA/iTkjxAXtMPs3dZXcRlnYMDkMXpiUp2WAsWwdT08dl3IQMLquVgMmuj5ZQ7vZLab8PtBBxciATUt3dCI8UAgTqreQnkljuPDMft0VAF6ykHbWZNcOJQsG1aDKh8qTOhkcprLKsjM4ztzzHKVVaDL5IeFjCID2EOT+jeLqxtnzdvBBykJVSbEvi1XuNsKqPC1y8b5hUWGc3AJspP8KT2qRWJI98u9VWndmw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(26005)(186003)(54906003)(4326008)(7416002)(122000001)(38100700002)(110136005)(33656002)(316002)(86362001)(55016002)(2906002)(71200400001)(6506007)(53546011)(8936002)(52536014)(66476007)(66446008)(7696005)(66946007)(83380400001)(8676002)(38070700005)(66556008)(76116006)(64756008)(9686003)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JsWRcFLtJoBLFnILB0GVmpzODTSxfaKzQnu5FusP6E5YmFhH5o2Fsq1x6EFn?=
 =?us-ascii?Q?Pxp7gxFq8oI7i/2VQmnwsgGIUHzrq32+PToUFiTqBoRzMZJZF9sKiQHpgxMr?=
 =?us-ascii?Q?i/cvubRt3pCrPKJkWXR8jw6fxNwS4bZFCTiNZcrs7p3ZeCCTjTlLwhYkd7b3?=
 =?us-ascii?Q?FKB/eC0K7UPQTU51SSehrdGja2ZOOyCVg8KPjl3W7abC3PE6//fO6QMZ5Hqi?=
 =?us-ascii?Q?ubSqHpKc/TGS+ViRsT7kILtuT5m2RSlgKVtB00/VF5TOeaDcPenOzPTklSN/?=
 =?us-ascii?Q?vlm2+TjP6xWfNHY30p/FIh4hJ6eL0Y4OR5MJB0pCvJmkPbEJu8x18nhhF39E?=
 =?us-ascii?Q?A8SEkAJ139t/PQvM30aM6M9I1aYSGgkp1TGBwMY0yNYubHJK6A/S3lHr4J2f?=
 =?us-ascii?Q?FCAkNOTuddNsKIXuVvseq+6TFmuIo58TGieE0yATYHSFnHSjPFm8RyJm2Lr1?=
 =?us-ascii?Q?JrTNuQqf9xfEXjL2ldVdSfc1qfb83WnBfTrS1mZtZgtIxGwnOGdYIkeaJc6u?=
 =?us-ascii?Q?BzsgKzNKFlMQouPKosHQU9PxSkR3hEgiScayQCf+0A8yih/KXixfMLo9e2r5?=
 =?us-ascii?Q?v/nFNxQqx8PJIVWQ2hojzn8bJknbuUbGIw0AMD2Q5GLCXYggWoRO0NQ6bHTd?=
 =?us-ascii?Q?dB9KTR+wXOhCVifhjeiOpbJqLNrMFGdVSOXzKgQeOGPuRTGBlaQstSWUP4Mc?=
 =?us-ascii?Q?OFywmXG2i+xh82KunCxrmFnYOOFscGofHN/bv2BY0dcmZFoeex1vxNVZypYz?=
 =?us-ascii?Q?ZmoiAM8aSvI35E1YpE8p7uDOwj0xbrtTTsDGzqSxGhGPVKJJgea4cwmR94sH?=
 =?us-ascii?Q?S1yO6A/7sn4v4AS5jgRZ0rLzzpVvawNBwCgLiVRpc8+yqhXCB0bqdNEZILuA?=
 =?us-ascii?Q?0ljSETvQhYxagUe0aZKMT18bYThnFlPNIgIXxmxuyw6lHpEDgsJbcnDUrEWG?=
 =?us-ascii?Q?YZMNOFDmTu0epvsFJ6z6Z9GQRD3fP1dwoSOV1SQUV6+Ch88h68xLXz5w2rz6?=
 =?us-ascii?Q?OJIWyRSmHR40bTX+2K7/GMZhvirF5hmOEoNNkYGwSGj54EeeFAb71BwYUzlQ?=
 =?us-ascii?Q?Jce/HNqor0EYAtglH0IVU/25nM1h0OLmere96dYqE3GwmH7k/mOVvJTX5D89?=
 =?us-ascii?Q?zUgzj0IE7xMmY6n0NaUQYoQdQf9e1xL8anwZHG+hqgwmTyyJUjaIXEnm3YeQ?=
 =?us-ascii?Q?vuB4oFSBoAR1Yt6OQp6TuYYG7wScxaYzCZfYPBdjWm9dobF0cbaUvDDadVNr?=
 =?us-ascii?Q?3CiYmmVEv0DhuT+uTZLyTnFCq5n/gQE3+Uj8tgGVs3Peom75wo8FHbElxHpE?=
 =?us-ascii?Q?qdjnqn9Bbc/capskUMC+2M4z?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ee247a69-151d-40fb-9b13-08d98d6cef78
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2021 10:42:06.2651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qc7VEWQQnyE/o1UbK32gbxGEkO7NtHFa6LgbSPx4JFPX7kAPqeAESUS5Px0Nb7uUl6/H2YA3facBo/Th/3AmYrk4Z/Mj6iT1cD5L/YH3uwM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3737
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08 October 2021 12:10, Heikki Krogerus wrote:

> > To downscope this issue for the time being, one of our immediate goals
> > is to expose the PDOs
> > to userspace for metrics reporting and potentially for some power
> > policy control through other
> > channels (like Chrome OS Embedded Controller).
> >
> > Would it be acceptable to revise this series to drop the power supply
> > support for now (since I don't yet
> > see a consensus on how to implement it for the partner), and just add
> > sysfs nodes for each PDO ?
> > This would be akin to how it's being done for identity VDOs right now.
> >
> > So we would have :
> >
> > /sys/class/typec/<port>-partner/source_pdos/pdo{1-13}
> >
> > and
> >
> > /sys/class/typec/<port>-partner/sink_pdos/pdo{1-13}
> >
> > and similarly for the port device.
> >
> > If we want to add additional parsing of the  Fixed Supply PDO into
> > individual properties for the partner/port,
> > those can of course be added later.
> >
> > WDYT?
>=20
> I don't think we should use sysfs to expose and control any of these
> objects. It does not really matter under which subsystem we are
> working. Sysfs is just the wrong interface for this kind of data.
>=20
> I'm now preparing a proof-of-concept patches where I create character
> device for every USB PD capable device (port, plug and partner). The
> idea is that we could use those char devices to tap into the USB PD
> protocol directly. Right now I'm thinking the nodes would look like
> this (with the first Type-C port):
>=20
>         /dev/pd0/port
>         /dev/pd0/plug0 - you only get this node with full featured cables
>         /dev/pd0/plug1 - ditto
>         /dev/pd0/partner - and this is here only if you are connected
>=20
> So in this case you would use those char devices to send the actual
> Get_Source_Cap and Get_Sink_Cap messages to get the PDOs.
>=20
> The problem is that it's not going to be possible to always support
> every type of command. For example with UCSI we are pretty much
> limited to the capability control messages. But I still think this is
> the right way to do this.
>=20
> Let me know what you think.

My two pence worth; this feels like a more appropriate mechanism to access =
that
data. Look forward to seeing the POC.
