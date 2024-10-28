Return-Path: <linux-pm+bounces-16557-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 091A49B29B5
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 09:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B5971C21B24
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 08:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122591D9699;
	Mon, 28 Oct 2024 07:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="362iNxE7"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2047.outbound.protection.outlook.com [40.107.100.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9230A198E80;
	Mon, 28 Oct 2024 07:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730102212; cv=fail; b=TuvlKI6T6n+aOEMuRC6KjHYmdCueM3ZxNiapmMPQPKXRRC1lfg+BZK8vBK5TpxLrMJoFf6tqu9Y0F/zjzDXA3RRlAnDeTip4ylZr51lT9JPpEqYy44eGXBo1A6wzRm3RXSauzc9FVYY4Yr0SnvISTr8ECRNjwcPysNOp6lfeW60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730102212; c=relaxed/simple;
	bh=b0HW307QgDWip3m6eo+jikB6DwFdsVGXFAj6HTHujoE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ma7eDZtsT0dt9vzAXRdCQBLVoTlkHtYhG3ttvMXx5c0xqLlS/yYlUn4Q/Vvi9qvothClQA4ANYyuU++aYczGOgBPGcegytme9FYiPf6pEn3o4cL9z/KrH9Mpiol/IYRFFraMV5S3X2JI7dht5Os8Iia7KzgI8sgcKGzRXvVxpM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=362iNxE7; arc=fail smtp.client-ip=40.107.100.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k2NX+vEzAvrgNIy+aUIh8e1as5/fzgbK+QzoG8CJ3nvNh35UD4lcfNcVUxu9x7OLbTOEuxubK12fNKA4vM9WVSXihbe9do5K8vT49APyfwlwEMfp79kuvV0O/at+mcslSzVwjcdV6ds83nNcXIQwyw8cpK7hy+mSgwUjJl3MZ+J2G9AoOGBwczHic2NA6955mlb0xkwT309/UdcZye6MKzYIbdi6CRbSnKoINiZeQSWvhT1mZvLaSClyFkbOX4NvXgB5abtBLzSUwDuMhjjO1mDrz911WrkMgxsLXV5B0wk7NGwL43WvSepMTUjAoDUkSAcpodgiXA4QNh8XvmHDWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d45GKDiuYPQr++syHXSZZukAGgOOWGJq4iC3tAN1WI0=;
 b=VXXJsfTmMshsRxiHgY1Q8yI5RxYZBfrA1g+XYK8Lx+mNLHy/kBqXiQGeV5VuqXxVbnZ/6dqeZe7AyzSDL1t4HSuY/ho51zh6aGWwY2NPr4An7EEcWh95UAPRlEOyQc8xzP2TkFk5lU57bv9qBIqgsz/RLmrRU6l26OKZ6ZLtRVrdcU2GXDy+RPkWnpzOV9c3bv8cCVSlLQcOf/FraRg+FFjKZgdfkTt9nGyEQgjXjNuQyHEqtjEo/3kxyrx83srb3LJDDGs8iRrNCny2u0almey+B5hSIOQ9umjTt8jswHJe8EGHlYv1las6B33CfSAZe+WI0SarLxHqR/PX+0zDJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d45GKDiuYPQr++syHXSZZukAGgOOWGJq4iC3tAN1WI0=;
 b=362iNxE7fv8wjUD4LO+Qn+NGeGBvwLF5XnWAOEQf+zUl6gQ8QadAW2/3Kepwmq8jc46pV27AzLmou8Vqtl3Y8T6HEFZGoEPY2obPrBxAFp/TxD3wP/lDxor9QXWrwO058HeNbUKMMhAgPd8uRjDVlZFoHOsLOGO6wOCqw365pgA=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by CY8PR12MB7172.namprd12.prod.outlook.com (2603:10b6:930:5b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Mon, 28 Oct
 2024 07:56:47 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf%4]) with mapi id 15.20.8093.018; Mon, 28 Oct 2024
 07:56:47 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>, Borislav Petkov
	<bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: "x86@kernel.org" <x86@kernel.org>, "Shenoy, Gautham Ranjal"
	<gautham.shenoy@amd.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "platform-driver-x86@vger.kernel.org"
	<platform-driver-x86@vger.kernel.org>, "S-k, Shyam-sundar"
	<Shyam-sundar.S-k@amd.com>
Subject: RE: [PATCH v5 11/13] cpufreq/amd-pstate: Disable preferred cores on
 designs with workload classification
Thread-Topic: [PATCH v5 11/13] cpufreq/amd-pstate: Disable preferred cores on
 designs with workload classification
Thread-Index: AQHbKN2WK53nmrm34Eejxnz83bfon7Kby3OA
Date: Mon, 28 Oct 2024 07:56:47 +0000
Message-ID:
 <CYYPR12MB86550A940AFAA3FE846D7CCE9C4A2@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <20241028020251.8085-1-mario.limonciello@amd.com>
 <20241028020251.8085-12-mario.limonciello@amd.com>
In-Reply-To: <20241028020251.8085-12-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=257f7249-84a5-428e-ba0c-b84712af418a;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-28T07:54:18Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|CY8PR12MB7172:EE_
x-ms-office365-filtering-correlation-id: 4b8ec204-5a64-4923-094a-08dcf72612ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?44riqgh7VfFYSyN4RqIHpDRFXIO877CYHdCpxEbIGDJUTuCVbjDdnvH6NP?=
 =?iso-8859-1?Q?P1lqHsFXaxtIjbGbcNMzgCIo/eS3WMYmgU68Xw8dVkoUXT44kkXmwhI096?=
 =?iso-8859-1?Q?ksI35+j2E4ZLfM/muFhfr2NgIkP/9JFTuhf5EuIQE4Wl2Dq4N5Y2Hizlh0?=
 =?iso-8859-1?Q?tFIPceOTN03nKyE3sZRBxcI4hY+N6IXZYu2H2BuFb9qReFYadsc/rdCy61?=
 =?iso-8859-1?Q?bii35VIB7RVMVrA90qWrNPTWyk/Xdo9fBLtEehFvBCPiKu6cz0QvUkBt0P?=
 =?iso-8859-1?Q?qEq6O2nDzSwYWLzbJLYwIB/plBtUsdcOXXAh7n7MwwnR8VIxop7kKfrK9N?=
 =?iso-8859-1?Q?I6J13md5l7QZQli1G9jZDTXkhI0B3aGuODAyp1qW98EBcH1fDTLM+z+/fC?=
 =?iso-8859-1?Q?yzZ7wTL7m0KmdTPSqoLddnZDD4PCxCmftIwKeBC63tpwwx1a2HXNM4UUjH?=
 =?iso-8859-1?Q?XctJBoQuj3/0FWutdygckipJsZNjACqoX9rA4N6K7PkxGnOj5OEloDAqiS?=
 =?iso-8859-1?Q?fKWtwuo+i+SuoXyACdWQCGR5OHQ4VBK5SIUBNd1H15Q69Jty91NaQYMeWF?=
 =?iso-8859-1?Q?zceWBEO+aXiaRmwGV84Jd6FxXPS7SebQ5IkXguYnWrocXc5n/sUhy+tb/6?=
 =?iso-8859-1?Q?5Xbf2Hr2FHviVWyK9ENRY7gr5R2skonzGucDLkIwylnO2mSKIH5ux1EoV5?=
 =?iso-8859-1?Q?MPZjUhj1+hBr1gc2tO8dAdijKxUo4OQrHvx3Ff5D0nEuLixs/jTXSJJ5J3?=
 =?iso-8859-1?Q?YOgBFr7YlC8Pn3hwWQPnIBPcMB/hOUMJU8KWizcJk8h+XGTB71pB55b31D?=
 =?iso-8859-1?Q?KgiKSA6EirsZY+rvkC+7/qw8RWB705kIdFrsP025t8PPwYj/lGym6PNmyH?=
 =?iso-8859-1?Q?O6bQQwtNa4x27JeKcYQHvz8nN/R6uf+e6rkAz20T7hgfMLb/FxHFuDO/6r?=
 =?iso-8859-1?Q?z4kdjp1ildVsV3PCITAm1Kh2I5o9ZapvvqKPF1oEp0ttVqH1EXdHsgmjxt?=
 =?iso-8859-1?Q?WMqybH0JcsuloOocqy2BW1xxNucs/OgdkLBlgmI/k7DYa5oH9dELDH8C8D?=
 =?iso-8859-1?Q?ggMrEiNRzGoBbAvhJtctKERp8K8UudCOcg3rZf54oYL5nuC0U2G+Gy6NUk?=
 =?iso-8859-1?Q?7YQAN24xzJ460QKBwWaYt8kVk02Bc/WrCMjvZGagW+UizJZJlIJr+VtfKw?=
 =?iso-8859-1?Q?hvvER6RrwxIIdc3MXk/c+GsRg/AAnKN82hpvpV18Su/jKiH/1qD5mKL4zi?=
 =?iso-8859-1?Q?v7xefiOkE+su+KMV5zGsKLT3bvEYBdEhndCG8dG+yTYE+Sidy52dgi+VQC?=
 =?iso-8859-1?Q?kNySzhg3cDO5eRnRZLtmiyTm9B628yhA6IJyr5dEAzP92cLGSScnmBws5C?=
 =?iso-8859-1?Q?2+QlHBFCA2/F/IjMvxY7p4QUB2AtoKJtKWBU9VpCMARLdQxhModVE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?8PwZ41cs3Uw5KH60KJGMEfvX0T4u4yzd1AI12tj7bv7mKtUhx6tC8bK7Kj?=
 =?iso-8859-1?Q?dKgYZKwi2EnSJKwXez9ZAMLb6FS1kKB1G9iQ/xeKM1/aIzCG9asE5dgKEy?=
 =?iso-8859-1?Q?spRUAehCyLr2Ag8YIK7Gct01OAPy+dj2Yt/CLDNm5AvF7op7MJIJA/h/01?=
 =?iso-8859-1?Q?81yQRR7NhSiKI/5s5nvJW/0wCDnHaPfFNiJpcauAW9/ZYzsLl4sMKRoSBH?=
 =?iso-8859-1?Q?wTwr/0z2uIeD4cmoYwD74bsR0wc9MIA3s7aVIITDst4IQqISMFIQZM2PKs?=
 =?iso-8859-1?Q?wLejzNE0UORh3WFefsm6NaSCt7CingM9vIbRWTpoRvW/9DINE8WMJDh+gv?=
 =?iso-8859-1?Q?wgeJwDbiIsh+5Sk+pdUpjwRLcasWFxBcrfR0kQhiO6f2inw9vR2SatmQVj?=
 =?iso-8859-1?Q?0tqN0ws7ggIwJJ3PIQnCQCDwqlZtTLBRXyQAzcrLd+E65fdGxn3WMDG8wV?=
 =?iso-8859-1?Q?8bHAloMu7WHSk3eWQH7K53jB/PzZn+oqNZy/BvphEAb9Tm5UwYTozx7X78?=
 =?iso-8859-1?Q?H01/Os9Zt2EQF+/2V6dMjtoFAjMP/ynqakF+yL//nMVoelievumKV3AdXS?=
 =?iso-8859-1?Q?+qHITXLektQ57qMPZVGMGp6VBx41hc5f6qnIzJZTQJJ6YOVJi7UlfbwA0q?=
 =?iso-8859-1?Q?pSRR60uEDZxozSng+H/tE3W5/T1NKNkBqQ9oMkXd5kMKbcH0OCU4n1Zd7i?=
 =?iso-8859-1?Q?fC0rHYncrkonloXq+vD/zlC/K6qk3kVDQCRvw/UXG/YNytfnVbEPxQgWrG?=
 =?iso-8859-1?Q?pfTa2QC5dJAOwkQR7dvbZuECbVlLj5dNBu8iMORi+uDQvGGwpUD8t9RHqd?=
 =?iso-8859-1?Q?P5VA7X9JnY9nM0ZVOZIUHYe71VT74DkvIuZzB26IlTyfqbSQoboRpL+H3j?=
 =?iso-8859-1?Q?BCy2+tKEBxrXRNjp+Ny79NdM6lplWImqQ9bprjJ8oV6rEwdnr40VcFb2bj?=
 =?iso-8859-1?Q?GMOYbca958sF+mfEgPMXfE/bEJ6g5TuTf4i4x3mqJNHuGLbKjO2W+By/Zq?=
 =?iso-8859-1?Q?JMs1XDrAYcggG9+H5afBL96LRNd/l+/AhEeBcrxolucbObaVBVG+/yF0cE?=
 =?iso-8859-1?Q?5KIYC+OxGwyMV55fR1RhllcciqsFPr1PdAGU4HX8ng6gIFGA3QOvLfyzCh?=
 =?iso-8859-1?Q?NLZJb16vmjZ8eZ8+DRUAULaDhmgVvZi5HLyhSLMXcVIOk0pPzQ1z3KbJNH?=
 =?iso-8859-1?Q?k3Ydkzr+6+ULtyfHSFlRSgbaZ4quLY64gttjwEZUuHbioGlOULFLuVLvKn?=
 =?iso-8859-1?Q?VMIMWu96gT8Zw3XqvbbiF2GYiJMDQqOvZgb6PIrIwH/KfY2YF/CuhqWzHk?=
 =?iso-8859-1?Q?NsAlig76Ihe/TAhLjNjJtiqzcO5F8NuIokFMwxN/w/dgOsOqrf6KTdkXa0?=
 =?iso-8859-1?Q?04qGWSLcc29gqydMGIHMFGBTbzaJjV07kX6yOB3zY+4Ahb9473Mxc+xSZV?=
 =?iso-8859-1?Q?IxKF+zWI2AfX/9pDwzvMkA8FKZqmoIahOPxOsyOFBW7ChvvYXxnHDeikCC?=
 =?iso-8859-1?Q?T1e1VjYlCzE9Lc4d9a4niXW5eJtOP+CfAi2ZTQW5SfC0tV93QK0HQUN6H3?=
 =?iso-8859-1?Q?dH4+vzrs7QVpjjgpT4m6YdJrm04FR8MZPvkxJrV81Twd2buzsVJLspNM3K?=
 =?iso-8859-1?Q?atHIbIjUgHMVI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8655.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b8ec204-5a64-4923-094a-08dcf72612ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 07:56:47.8061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ns21kJgaEMJJKdHcev+uFwiJV8JooK1LJOUnj5+fcxH0Hmy4jJ14y9RYQmQsYrHyL1QGC4y8N6zQ+BLURGiUgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7172

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Limonciello, Mario <Mario.Limonciello@amd.com>
> Sent: Monday, October 28, 2024 10:03 AM
> To: Borislav Petkov <bp@alien8.de>; Hans de Goede <hdegoede@redhat.com>;
> Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> Cc: x86@kernel.org; Shenoy, Gautham Ranjal <gautham.shenoy@amd.com>;
> Limonciello, Mario <Mario.Limonciello@amd.com>; Yuan, Perry
> <Perry.Yuan@amd.com>; linux-kernel@vger.kernel.org; linux-doc@vger.kernel=
.org;
> linux-pm@vger.kernel.org; platform-driver-x86@vger.kernel.org; S-k, Shyam=
-
> sundar <Shyam-sundar.S-k@amd.com>
> Subject: [PATCH v5 11/13] cpufreq/amd-pstate: Disable preferred cores on =
designs
> with workload classification
>
> On designs that have workload classification, it's preferred that the amd=
-hfi driver is
> used to provide hints to the scheduler of which cores to use instead of t=
he amd-
> pstate driver.
>
> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c =
index
> 32ddbf37a9f0a..c60cc84866982 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -780,6 +780,12 @@ static void amd_pstate_init_prefcore(struct amd_cpud=
ata
> *cpudata)
>       /* user disabled or not detected */
>       if (!amd_pstate_prefcore)
>               return;
> +     /* should use amd-hfi instead */
> +     if (boot_cpu_has(X86_FEATURE_AMD_WORKLOAD_CLASS) &&
> +         IS_ENABLED(CONFIG_AMD_HFI)) {
> +             amd_pstate_prefcore =3D false;
> +             return;
> +     }
>
>       cpudata->hw_prefcore =3D true;
>
> --
> 2.43.0

LGTM, the legacy prefer core need to be disabled when HFI loaded.

Reviewed-by: Perry Yuan <perry.yuan@amd.com>

