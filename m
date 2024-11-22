Return-Path: <linux-pm+bounces-17936-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1FF9D5693
	for <lists+linux-pm@lfdr.de>; Fri, 22 Nov 2024 01:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EBDE1F2220C
	for <lists+linux-pm@lfdr.de>; Fri, 22 Nov 2024 00:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8BD635;
	Fri, 22 Nov 2024 00:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KENN++4d"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2078.outbound.protection.outlook.com [40.107.103.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8BB17C;
	Fri, 22 Nov 2024 00:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732234426; cv=fail; b=OD1aXvKQIGL5zJml74yzVShEZxYCowPd/WNg6AMHzLbQ91UfK5nhGykUoVIA0aVg3rQqk/MzJOVZ50MHfGwyRK5BIfTSAepta9TvXod38GzSRYqruutRbT/AgUojZRBYVEkdnIsHjLkqKU6u7M9cEdG+D894KbVX4atVeUNRlZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732234426; c=relaxed/simple;
	bh=uTSyZzFp+RwlyO0vZcWIxcmnuKZVF1oLwM1tvMf8jcE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=McrKIqpZFZ3w4fQzb41K+PaXlWFylS8skOdUIXtiOWJWi+t1qc0MEusjBx0z8M85j38T6SC+S86X8GVZubaX/s0v5aoOR69ZjRD863tKNRJw3MqKALnLY6CVQxCGApPipfpjCu9kIYirz3iR7uIwr5QrHxFThV99zv2yl96Dyso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KENN++4d; arc=fail smtp.client-ip=40.107.103.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ScQCbw6yGRVNdjcmEfSR/VwDjRSB4Ax3AMu4EmgsbmnZXoIzmLUpdXGlY9a0XJ6NCryt80HRMyhf8eOr0YobNxRQcREAkWZiIQ6NZQ0RYg/f/Yuz3fJpr0b/jCLDP033gULhw7UPDqOKoR5W8D9F8tnNNBQ6OhTp070FzAsKqHfYu55NxqYoXF/VpRDvI7AyqnLcV3Xhc91oDDmVzgzamjupHIGtQMZjv4sq/apJPhOgXYVXjxvbnQfqQUn1io5xkcjxe+KGiujEge4j0HDGlND6W62CvVl74q+gsYqv91KVsZ6WZa1xu8V/ulyjW8AMgswzVgnyoa/lMj/qILzKIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SMc4H+1sRPVT9Lorat4oVwseDCJqpKwYUpoAkfqPzDs=;
 b=PUYQ+bTrIIWJqldsPpC1MHnOnk/PaXLJ3Y3afJzzhtCv87X29OEomBed826SXGBt1NE8xYg3yNxjy/CIJb3c1olRrbLi33QyuiE2J3CEzALh8bAn9uXPL7VgSWoIsWZXCRQw4zu3XMwLgrL3iEzv1R8y2oR/O48QPzpUvP4nsQZQe9IGWGqs0+fsb+AzMCOhX3Lidb3nUwY66cpJYyziWfIArrEGB0c7vXlU6yZoJdJmFawfKbpbqMY7vNrfSWy7vFXSl28nvFjPjbM+lKjGRR/oe3r8x9mL8oHwqul6l2dy0Sti5SIj8yb6SFERRXfXCkQR/1wg1zD1o6zoWKF+qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMc4H+1sRPVT9Lorat4oVwseDCJqpKwYUpoAkfqPzDs=;
 b=KENN++4dHGrYinjJM0RUXuTmZ/tYkvfvoxH9NpURC+iyoq3uelW7G1fZZpDDuvNyAMrRzOyvLzk4JWMid+d+c6eBRNodpyPlOvbeyGE0rBwiYVGieM0SztiUxEoiSLt9dLv32b/bWE5A8dfkEySuJmPo707Vkf917kEkIY7y4GgWo2AGzMrwAMVTrcFa86DlW8AwXfib9AKEla0nL6ul7gsVkKyrSdGUYBxkLkN6jjwqxBEIa8B2AH8bTbClNA5QyKF2u1kzkndZl9UvA1zMka9E+IXL2mRLrwxHxmdaTvSKkAU2G7Ro3IAr6a8IaV/GXvaGVxGLkgLltaSZtPyW0A==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8814.eurprd04.prod.outlook.com (2603:10a6:102:20d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.15; Fri, 22 Nov
 2024 00:13:40 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8182.016; Fri, 22 Nov 2024
 00:13:40 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>, Thomas Renninger <trenn@suse.com>, Shuah Khan
	<shuah@kernel.org>, "John B. Wyatt IV" <jwyatt@redhat.com>, John Kacur
	<jkacur@redhat.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] pm: cpupower: Makefile: Allow overriding
 cross-compiling env params
Thread-Topic: [PATCH v2 2/2] pm: cpupower: Makefile: Allow overriding
 cross-compiling env params
Thread-Index: AQHbCotjTSksRUq1mEyXqNdymTcGi7LBikwAgACE5UCAAEobgIAAeDyQ
Date: Fri, 22 Nov 2024 00:13:40 +0000
Message-ID:
 <PAXPR04MB84595BA5BEAE2D21F015036688232@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240919-pm-v2-0-0f25686556b5@nxp.com>
 <20240919-pm-v2-2-0f25686556b5@nxp.com>
 <48c0adb5-4ae8-48bc-8e83-3d1c413f6861@broadcom.com>
 <DB9PR04MB846134093D2302B6D67E7E6288222@DB9PR04MB8461.eurprd04.prod.outlook.com>
 <16411b6f-3e1d-4d52-a047-8c322774ec8c@broadcom.com>
In-Reply-To: <16411b6f-3e1d-4d52-a047-8c322774ec8c@broadcom.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PAXPR04MB8814:EE_
x-ms-office365-filtering-correlation-id: 6769b0ae-3f15-42d1-10d9-08dd0a8a84be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?BcMRqe/msYTiRkRK55VtXbUvjLlxzIY52nT2FdiA0IImZBfjFMK9DICTg3vQ?=
 =?us-ascii?Q?nCQ7b1vgD11n8DkRYu6k8+dWq1pnZzYbou4QCyWQQxHvEeS+QU98VXGpPE8a?=
 =?us-ascii?Q?LhYIJvDnl+FQwmCXUInUOUs3BIlBNcVH3MeJtKOwEQQEVU6LWUrnwqrmHRWS?=
 =?us-ascii?Q?ToYRyokenZwsdAAEMc1M6DJIww/iHT5CmfkGEbE54IBj08HKcjqfw2WB11WU?=
 =?us-ascii?Q?c9RoeHj+ppdNwT+fmAURE32PVkhSOMNPBSZBngS9Sng2Ok5nmu11tda1MkhY?=
 =?us-ascii?Q?Y+oaNBBeBR+iup1y7TrYVHH9MK9Fa2YS9LRCKj8XeceHrG8pysDBRWa9hYjD?=
 =?us-ascii?Q?CZ8suwRWpmrsuUe4bFr8Co87bokGd5a/ddz0zK13Fl36FYWhn6NLmORaV28V?=
 =?us-ascii?Q?u8S0CDcwA3PLkance5NVk6XI00ChcIxxyiqtZsqYS5jYSKGVghLRf7iB9/76?=
 =?us-ascii?Q?dW6QokTwhvH6qyM8rCnP446EX7CjKSN4q0KzeahAmeDL1VDQAiAwWBb+8ZTA?=
 =?us-ascii?Q?tyvSOY1Uu/ilrtauLV8RVjRkvR4il0THCsEkqBTNAHCHh3i+gWkgkmeMiGVS?=
 =?us-ascii?Q?ymoXI1lTT9fYsDoBK8w0xb7s2Dvv+ODo/mt5/LPw0E+tBbJEGGHpakSTUGyk?=
 =?us-ascii?Q?ZV5RPskky0SAu6qI1/R7ZaoKsDbvoQ0msEfITuWh8VF1mmS0jj7M06pN5IeT?=
 =?us-ascii?Q?elBcW+PEQWQ55e4fF5uFXMKgkDVKk61MVjBTCxEVADkl4lncLU2B7QDfn7B1?=
 =?us-ascii?Q?yL+WGCY1sEphOXPmL0HsCLY+AxTxjVlsvaDkZAI7lhPFEsQwZahssNWVo9aK?=
 =?us-ascii?Q?SHfsUnBy1WfN27NiARRNfpLOWsOc7ukqihid4TwS1E1Wtc/sa/1XdSwsGOPq?=
 =?us-ascii?Q?8VZqeqHy19/hI/yQPLEPMZICr1VV71O7XbhVSprjuqAHQklbJQaFHh856Z3Q?=
 =?us-ascii?Q?/gwY7yxxxT8xnS0b5cR4i6x/Nl4AlYzQEtoOaQqxUX65YPFkUGvzn1m9JWZb?=
 =?us-ascii?Q?cJpT+94Hens9fLttP/dzb/zDFDN0ojTHVoa4zG2PtCl4T/aHGc5Fzzw9FjOr?=
 =?us-ascii?Q?GrLxWXRMwpN8WmEL05+MMlbiPXOyxZJWoDrySEULE7aRofc+k6OA1FbXWckC?=
 =?us-ascii?Q?KygvLXwM17BMOmvGmdskyuhqLbi21gSh4pldeuf+xMzWpiXUX64ZPVsI3iuR?=
 =?us-ascii?Q?kR86wGrXi1LhJOvSH5tVgbmP6wv5dp4hHRWqf5eCs1eXdYb0thIdO7KdvZMZ?=
 =?us-ascii?Q?9s9+qWwEX3Y761ASc4NEDqFZjkJCCFrLkiw4ZGeMQUtujR+MV260HJgRilPZ?=
 =?us-ascii?Q?nSdfliIib7Kv6KuFtB6krsgQ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?s+eZLQwRGhgWZ0EdayiUfQrFUSCya8G4Hg7CJyjZvlHOUlQkl5iUtsCUdWjE?=
 =?us-ascii?Q?yctwDC2ZuCh5eIFJrWlQa0yWF3peFqnznQnKkclzt+nBi3SHt7v7y+AkGF6D?=
 =?us-ascii?Q?1S//w4XIvVlfyJ+7odX4Gtl/IwDCcnWDaDejgbO4lsOEI5GHQ74v73BsgB/R?=
 =?us-ascii?Q?eICXLiE5Ys3NCGhsK0yD8RKLSymDqHe327k3BB4or4O0M6KiX184d/bI0W+m?=
 =?us-ascii?Q?OEByhOCz9TSVbtqk28mEIFOXSpybJn5SCJSi81WMVsS4ypZ8IupwAFJVqS3w?=
 =?us-ascii?Q?/KNXspPV8oRRccNsu8iGtQdmkfseuWvAuG8iwTDQlaehXkXy3W3tvNpYmwSs?=
 =?us-ascii?Q?qSn0U4BQPsJ2kCDtoKfAfVobuSXl9eZ5BLuXC/C+aU1QflQiN5hnDszjmN40?=
 =?us-ascii?Q?2YcbrBiu6v+WfrshveoSMZIFxWic3ZzxysIiTKe/+6HE99EXCb0QWXstDyEx?=
 =?us-ascii?Q?JhnvUjyUNbfgtHoc2MgCtxhHl5u23v+5bFum9q+htNvoRo194WgEaoHrXVT0?=
 =?us-ascii?Q?PyVt98ZdbbyrjKBKDUNZuJPv4jc2gqrvTDQz7LSHpwPrgJHgHn/JwFJLxsJX?=
 =?us-ascii?Q?7b59I0F0WBpRFncKcK/4ENr+tqtg12Qvh7S8fzDoEq07+7rgNnGuNXgqtqpf?=
 =?us-ascii?Q?rmuMBoumtpBLCF//AnmjE/yitGoZYpIQQhs7WDj5jp38yRIryJuC7Yftuu2y?=
 =?us-ascii?Q?mXtkfr92VA/wfxVF9hdBM3eO5cfYMgFTJ1xUf8hH8LCivFGqxme0cnMBCYDH?=
 =?us-ascii?Q?NYUXaOIR7WGnxWwo4SA/WnlREnsaCFomLDyLUAzZ9CnKB2rEUMaTLbc+bNxU?=
 =?us-ascii?Q?xKHRi4gi+5Q22MMMO/X4xRIDalTTQMHw7qFh/v8m25R7hY4vRuU0dsdjVTS/?=
 =?us-ascii?Q?InxxLotdR4k78ygjs6HaM4791S4RQPeHZvfqACcTQQO0gmwKfE8GmNJ1ISIF?=
 =?us-ascii?Q?QpyJ8uJxntcN4VE2xY/M+tmsEFf9cxxnSyWJYVCX5T47hNQJB99cEemrHzM+?=
 =?us-ascii?Q?8A5EvR1qWfwSgYv8ywRd7zo2Rf0EqifnB/+93yGGv9BQoJRVdD/6nH/xPfD5?=
 =?us-ascii?Q?VdDt5TtPHf5lYLIwIsnu6MWyaVfhDE8CIb1tiK4Ysnj5nBNb6X2vKYF10ZrT?=
 =?us-ascii?Q?BPEuJ7z6s1Y0YQ90HQEWgal4jrI+MaXCTBTVihkQ50t6XfbibyLWDKc/JSp1?=
 =?us-ascii?Q?XqJmS/NBTGwg0ZpCdmM+n8ZtBKEuJNGOgJ0xv8MlGKv7eqAr5eZTMcb8wnxM?=
 =?us-ascii?Q?TQP1nTA7CdthoTtypBvf4MEx8uE68CX+R7rQIaD+VuSiVOMsmOTFvrPfioJ9?=
 =?us-ascii?Q?+4I49blMa1GNN7T1K4rYUNVsCXfXgoDpibFZjK8rkfPpcSnAk5lIA4nVBXn3?=
 =?us-ascii?Q?Z5xxe/Qak8ym6a8ogdeO7O4aAocgUcJeHCQ1JzidJf+7Ib6xCDknfiYY2ruN?=
 =?us-ascii?Q?L7o7h/aOc87IBOBP6W7lhab61LRtMZPS1bIqzDXXMvLZ4n9t5laoCiDQ+sZb?=
 =?us-ascii?Q?1wVeJ+Jasimiwpt+JCz8oP9a8MXLsVj8CUAjmD1qSp7WI7RWud/7ORb0Qy6P?=
 =?us-ascii?Q?DJB+sLpzqJ6p/gNthIU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6769b0ae-3f15-42d1-10d9-08dd0a8a84be
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2024 00:13:40.4759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B8R+o8paq/E4+ZktNgDkgIdOJRqY/l9fjt6VPHxLVCkaXLvtlwzYXPbVWHIEfAGvD09vN4UgMpcO3AqJ+eK0qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8814

> Subject: Re: [PATCH v2 2/2] pm: cpupower: Makefile: Allow overriding
> cross-compiling env params
>=20
> On 11/21/24 04:40, Peng Fan wrote:
> >> Subject: Re: [PATCH v2 2/2] pm: cpupower: Makefile: Allow
> overriding
> >> cross-compiling env params
> >>
> >> Hi Peng,
> >>
> >> On 9/19/2024 5:08 AM, Peng Fan (OSS) wrote:
> >>> From: Peng Fan <peng.fan@nxp.com>
> >>>
> >>> Allow overriding the cross-comple env parameters to make it
> easier
> >> for
> >>> Yocto users. Then cross-compiler toolchains to build cpupower
> with
> >>> only two steps:
> >>> - source (toolchain path)/environment-setup-armv8a-poky-linux
> >>> - make
> >>
> >> This patch breaks the way that buildroot builds cpupower:
> >>
> >>
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F
> >> git.buildroot.net%2Fbuildroot%2Ftree%2Fpackage%2Flinux-
> >> tools%2Flinux-tool-
> >>
> cpupower.mk.in&data=3D05%7C02%7Cpeng.fan%40nxp.com%7C246da9
> >>
> 2d8b6243d138c808dd09e6d644%7C686ea1d3bc2b4c6fa92cd99c5c3
> >>
> 01635%7C0%7C0%7C638677609234547728%7CUnknown%7CTWFpb
> >>
> GZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJX
> >>
> aW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdat
> >>
> a=3DnL1YUl%2F07Vd8F0GpW7uRqdpZT74avOku1ox9N3%2FFkUg%3D&r
> >> eserved=3D0
> >>
> >> and after enabling verbose it becomes clear as to why, see below:
> >>
> >>   >>> linux-tools  Configuring
> >>   >>> linux-tools  Building
> >> GIT_DIR=3D.
> >> PATH=3D"/local/users/fainelli/buildroot-
> >> upstream/output/arm/host/bin:/local/users/fainelli/buildroot-
> >>
> upstream/output/arm/host/sbin:/projects/firepath/tools/bin:/home/ff
> >>
> 944844/bin:/home/ff944844/.local/bin:/opt/stblinux/bin:/usr/local/sb
> >> in:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local
> >> /ga mes:/snap/bin:/opt/toolchains/metaware-vctools-0.4.1/bin/"
> >> /usr/bin/make -j97
> >> CROSS=3D/local/users/fainelli/buildroot-
> >> upstream/output/arm/host/bin/arm-linux-
> >> CPUFREQ_BENCH=3Dfalse NLS=3Dfalse LDFLAGS=3D"-L.
> >> -L/local/users/fainelli/buildroot-
> upstream/output/arm/target/usr/lib"
> >> DEBUG=3Dfalse V=3D1 -C
> >> /local/users/fainelli/buildroot-upstream/output/arm/build/linux-
> >> custom/tools
> >> cpupower
> >> mkdir -p power/cpupower && /usr/bin/make
> subdir=3Dpower/cpupower
> >> --no-print-directory -C power/cpupower cc -DVERSION=3D\"6.12.0\" -
> >> DPACKAGE=3D\"cpupower\"
> >> -DPACKAGE_BUGREPORT=3D\"linux-pm@vger.kernel.org\" -
> D_GNU_SOURCE -pipe
> >> -Wall -Wchar-subscripts -Wpointer-arith -Wsign- compare
> >> -Wno-pointer-sign -Wdeclaration-after-statement -Wshadow - Os
> >> -fomit-frame-pointer -fPIC -o lib/cpufreq.o -c lib/cpufreq.c
> >
> > You are building on an ARM host? Or you are cross compiling with cc
> is
> > actually arm gcc?
>=20
> This is cross compiling targeting ARM, which is why CROSS is set to
> ../arm-linux-
>=20
> >
> >>
> >> Here we use cc, aka host compiler, rather than $(CROSS)gcc as we
> >> should, so we are no longer cross compiling at all.
> >
> > I not understand. CROSS was set, but using cc to compile for host?
>=20
> See below.
>=20
> >
> >>
> >> The issue is the use of the lazy set if absent for *all* of CC, LD,
> >> AR, STRIP, RANLIB, rather than just for CROSS. The following fixes it
> for me:
> >>
> >> diff --git a/tools/power/cpupower/Makefile
> >> b/tools/power/cpupower/Makefile index
> >> 175004ce44b2..96bb1e5f3970 100644
> >> --- a/tools/power/cpupower/Makefile
> >> +++ b/tools/power/cpupower/Makefile
> >> @@ -87,11 +87,11 @@ INSTALL_SCRIPT =3D ${INSTALL} -m 644
> >>    # to something more interesting, like "arm-linux-".  If you want
> >>    # to compile vs uClibc, that can be done here as well.
> >>    CROSS ?=3D #/usr/i386-linux-uclibc/usr/bin/i386-uclibc-
> >> -CC ?=3D $(CROSS)gcc
> >> -LD ?=3D $(CROSS)gcc
> >> -AR ?=3D $(CROSS)ar
> >> -STRIP ?=3D $(CROSS)strip
> >> -RANLIB ?=3D $(CROSS)ranlib
> >> +CC =3D $(CROSS)gcc
> >> +LD =3D $(CROSS)gcc
> >> +AR =3D $(CROSS)ar
> >> +STRIP =3D $(CROSS)strip
> >> +RANLIB =3D $(CROSS)ranlib
> >
> > The ? is just allow to override CC/LD/AR.., so in your env, CC is set,
> > but should not be used for cpupower compling?
>=20
> Adding debug to show the origin of the CC variable shows the following:
>=20
> CROSS=3D/local/users/fainelli/buildroot-
> upstream/output/arm/host/bin/arm-linux-
> CC origin is (default) and value is (cc) LD origin is (default) and value=
 is
> (ld) CC=3Dcc LD=3Dld AR=3Dar STRIP=3D RANLIB=3D


How about
CROSS ?=3D #/usr/i386-linux-uclibc/usr/bin/i386-uclibc-
ifneq ($(CROSS), )
CC =3D $(CROSS)gcc
LD =3D $(CROSS)gcc
AR =3D $(CROSS)ar
STRIP =3D $(CROSS)strip
RANLIB =3D $(CROSS)ranlib
else
CC ?=3D $(CROSS)gcc
LD ?=3D $(CROSS)gcc
AR ?=3D $(CROSS)ar
STRIP ?=3D $(CROSS)strip
RANLIB ?=3D $(CROSS)ranlib
Endif

Thanks,
Peng.

>=20
> See
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F
> www.gnu.org%2Fsoftware%2Fmake%2Fmanual%2Fhtml_node%2FOrig
> in-Function.html%23Origin-
> Function&data=3D05%7C02%7Cpeng.fan%40nxp.com%7C02c643288e1e
> 456e69e108dd0a4e58d7%7C686ea1d3bc2b4c6fa92cd99c5c301635%
> 7C0%7C0%7C638678053808856433%7CUnknown%7CTWFpbGZsb3d8
> eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiI
> sIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DL4xd4j
> ijUJXibguQnxUTzcAUA%2FGSUGUQzmA5FfVaaAQ%3D&reserved=3D0
> --
> Florian

