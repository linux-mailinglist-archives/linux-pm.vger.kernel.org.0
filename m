Return-Path: <linux-pm+bounces-12964-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBE5960B15
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 14:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E20A91F23B67
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 12:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB841BD4ED;
	Tue, 27 Aug 2024 12:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="kXVZoFgz"
X-Original-To: linux-pm@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010055.outbound.protection.outlook.com [52.101.228.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862671BD024;
	Tue, 27 Aug 2024 12:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724763073; cv=fail; b=en2Y9A0Uael/ZTYtO0XCkUb0/vEA9ChdGZhJUr+cvsapLPJfYIpRQs3vrVdz5USjMSWC5fNzaUrdj8tVYaBD1rxjO7qABAzHHTKZ4FENXprBmj67laJ8fuJz679NV4M2zQn/4HobYIZtqSYIQiecbVo+jqbnX4xOJKVEw1ZFf5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724763073; c=relaxed/simple;
	bh=xae1w0+sCjCiCXShj7bbyus+JBaEur0jnTTBX1ZlSiE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TOl8XUw0XwtGerqCwtnD/tQbOcPgnG0wls0V4vWfUbV1kyQeyzVVfWrbGAvhVt9szrUS4+SEvlMBZHPjWrLRLlIxgLw2y5ITzPGr5+6Uvzpp+dkJnYgTR0L4U4D5NGimU+XSUSg+Lshk0+V9MXH0xcQ9w7K2YNxXdUG54iiSWpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=kXVZoFgz; arc=fail smtp.client-ip=52.101.228.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hf3kiGZkQhnIy21fwnfUC0Xn3NGqefO6dMoEvjtD0GaXUF+6n11QnYDkTAoSNkgRFzhIPPZAningvO0VshUlApGygOT/K0i89DeTIaE/sn4bn1zX5MNUXeWeKoNy9RvKwaX8ZRKq6rGIXEH1oUdxrlca95+gVTHXCM6Y3MM3qNle57VvwVM54rBMbaqLP6BbA+XwhM9xtFLbkkFKRw235ADkbhPAvFwG1VRdFowkvpakSJxMceBcgK164g03Voc/+63jwQNJnpjxo0d2PtlsAYp3UoFzmGqm8aO5v2+HnaJvK1mu7D0xrc5YsGimken6H9jdKYwnUsbUJjPsfS4NFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xae1w0+sCjCiCXShj7bbyus+JBaEur0jnTTBX1ZlSiE=;
 b=Od/H7ionCw67BPqHEwszejnye9Nk/z0x/fQc7r2bpxXoc65rv6GHiPI3j9FLmiG2Pv6pz+GprtKDOKGopQc+maV6KskM0HpTyWiAZzzPAkFsVo+CDYiQsiALjgyiNTuGAOSQ4RAAyELlMdXSO4lGPTzdRg5sjukfhJFr/168hV4eSRUhqaNVK7TKgFck0OImVEoPKOcl9Bv2dJiLogfUjyUIjl/TzVl6E6NSqNV+6QEwQRfuVbqaP7TDLnPXLocnlglkGPFwi5zzQgFifNLKo0KcJmmj3NXqON41PiAoOeH2Tj1k0VwGCG3Zhd3Lvs9JA7eaCKVa+HOCk8FVa5iFrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xae1w0+sCjCiCXShj7bbyus+JBaEur0jnTTBX1ZlSiE=;
 b=kXVZoFgzi789JVMUec+NNrE/THABlE4/Xp+AmIb1y90HY7IxrujU6ykOXjVkMXhfLVwjHNsD1qYoFqAnxnNBtITXf/vNgoNPV7fR1DOnYkB9G7c4wTefnDEhmqlwt9zpkmLODv8UtTRlSg5O5Wo9YDE2Fhw/5+HJzRoKvGqkL2Q=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB11639.jpnprd01.prod.outlook.com (2603:1096:400:37f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 12:51:06 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 12:51:06 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, "geert+renesas@glider.be"
	<geert+renesas@glider.be>, "mturquette@baylibre.com"
	<mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
	"wim@linux-watchdog.org" <wim@linux-watchdog.org>, "linux@roeck-us.net"
	<linux@roeck-us.net>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH 3/3] watchdog: rzg2l_wdt: Power on the watchdog domain in
 the restart handler
Thread-Topic: [PATCH 3/3] watchdog: rzg2l_wdt: Power on the watchdog domain in
 the restart handler
Thread-Index: AQHa98xfGZ/E41sgA0mqBISLrIoXOLI7BK6ggAAGLgCAAAP8AA==
Date: Tue, 27 Aug 2024 12:51:06 +0000
Message-ID:
 <TY3PR01MB113464C9751ADB7B0F0356CD686942@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20240826152529.2080248-1-claudiu.beznea.uj@bp.renesas.com>
 <20240826152529.2080248-4-claudiu.beznea.uj@bp.renesas.com>
 <TY3PR01MB11346A223DA7462799B9D103786942@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <4823173e-b024-482f-83a3-560c7abd888c@tuxon.dev>
In-Reply-To: <4823173e-b024-482f-83a3-560c7abd888c@tuxon.dev>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB11639:EE_
x-ms-office365-filtering-correlation-id: 4f863d66-8e0d-48dd-fc83-08dcc696ea78
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?T2llNjJzZG8rSjNKVUlFQUJmTVA3NS9QbTBxK1ZwQTBxYlJobGtxZG1VRkRs?=
 =?utf-8?B?czFmRVNTYzZZQ2d1OUZ3R2tOTlA0VkFoLzhIZzAzeXhybTdDc3pndTVUc014?=
 =?utf-8?B?VFM0T0pJK3Nsc2J1ZERsa1NIT0Z1TTNjalNxc3NraVF0c2pVRk5tNGg2emhE?=
 =?utf-8?B?Wno4d2ZyMDdkVVBpWTJobUNzWCtkeGFIUGpYUjI4b2lDSEltVWxGdFk2enVF?=
 =?utf-8?B?UkFGTnpCZUJVd2hhUVMxNXJweElJVjk1T1gzRG5iaGpDQkNNbWMyQ0RKMnNo?=
 =?utf-8?B?bEpLMHlvVzFJVDBOMFhmZ2ViZkdBWGk4Tk05TllrOFFLczY5UEdyenpwbENN?=
 =?utf-8?B?SnNDN3lzWUlFMGdoMU0zVFZTOWNiNHU0U2U3V1RrR1M3bkxSTzdGOVFnaTRs?=
 =?utf-8?B?MjJHcXMycTJKTjkwa3VxWU5sUEg3dDJ6ak9mL1JFM0xYVDVUWldyOUd1TndP?=
 =?utf-8?B?RVhFVks0dDFrcitpRlRPYlZ2TXIvOTV4ZWIxSkg3dU9lcjR0bzdFZ0NTbzBw?=
 =?utf-8?B?MmVERHkyeHJ4bnBFcEEvbzJsYjA5ak5GM0hYaVhlU2JaSWJpSlU5cjRMcWY1?=
 =?utf-8?B?ZUo3bW41OXhaVWF2Z3MzUXRhOER0SDZHeklyTU5tQUtOdjZQV0V5WitOS1Fz?=
 =?utf-8?B?Sks4WkIyMzRNbVhEY3R4YitBNGVpR2trYWVITDROSjJkK1QzeStzU2FlZE00?=
 =?utf-8?B?eDdWaWZCTmY1Z0ZOYUlIRWlURTR3NXNtYnVXTUpBeXV3Ykw2M1BtbW43V21F?=
 =?utf-8?B?N0FTR3JVc0lVVzZLV3BLYlg1SHhHTEE3QVpUaXRuc0c3RjFRZGp5eFowY3pl?=
 =?utf-8?B?SER4c3kzMkFKTWNJUi9MbTNYbUtyQSs1L1hvaVlLVDRIVHVKdU9iUEdmbWp0?=
 =?utf-8?B?Mkk5T1U5bGtaMG42SmRrcUU2OEt4c1U0cDdoUEt4d1hHZXVmOUdZL0pUYmdV?=
 =?utf-8?B?TS9OcmFYYVZLekFKQUlGaGlibzlSdENlWDYxcmVOY2VtcXdxUFExWm1RVjc2?=
 =?utf-8?B?dmtWTWRjK1FZdjhmTGI1RkQzRzVINXU4UWE1YTd1OUVBbDdFdmkxTVRiQUwr?=
 =?utf-8?B?RmdUYkxSWVFWWFVQd1l6VFpZcWxoQ2VEcXArY3lZM2IwbThpL2tJbU9PUVJH?=
 =?utf-8?B?ZEhHbU9qKytsZkt2WGF3Y04wWWQ5TFoxaUlFZzMwUkg1MWFsbmxkbzZhK2Ey?=
 =?utf-8?B?WGFOamo0N2Z5V0paSnBBNGt1OFNRWDI0OHRFbklWMlpwNjJCb1VORzRHakxt?=
 =?utf-8?B?a1ZKM242YXk1NnQzVzFTNEJCajhZOTJjSmZZUHplSFpSdWk5Vis5KytqVll5?=
 =?utf-8?B?UzFXaE9NekhCK3ZCVGt1eUVkMmc4RUxEb3AzekIxRXQyWUNoZ3Q4TStFT2hp?=
 =?utf-8?B?dnRGNktnRGtXb0d1VWdvcFFpY2laY3dKMThDTGNhRkZYcWJYT2xXWkdjeWx6?=
 =?utf-8?B?VEMvdzd4Zjd2STlhbWdEenFRLzdCeTFhTGJtNWZGWlVQTW9kbUwzTmdtcnNo?=
 =?utf-8?B?K1Y1dko0eGRCRktjNGlpV0NKTkJLdDNLbmN3MjViSEM4ZGZzV1BBVDFENlR5?=
 =?utf-8?B?UzdKVlA0RnQyZnNrZ2lIK0lYeDhOblhObVM5Ni9NdlhVdzhIMm5CeVhqVUhm?=
 =?utf-8?B?OVBxb2wyb0NvRlRlZERCem5CS0RXZWFxL3VMY0x0d3NSeVl2NFNtSEMrcm9L?=
 =?utf-8?B?YWNmRjJkV2pGWlp4SUI5c0Q2UDBOckZacGFUU0hYd1hZUllWeStMd1VmMjdZ?=
 =?utf-8?B?N2VDajBybEMzWkZsTWVYMDlwKzgvYmdib1plT2dMREt6alRyZCtVbDlwWXFj?=
 =?utf-8?B?U09pR3Ftb255dUd3T1FPNGQ1MG5aNmtramlCU3Jyc0lKZkVyUE4xU3U4aUpB?=
 =?utf-8?B?SWtVRGQzZE1Gam4yU0pxQVFTT3N6Z0hKZUFzOExVNjNNcVE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TU5MZk5kbjh2UVhrTkZKR3E0THFQQjFUNnNvbjFHeGY0TU5iWTUzN3E3VlNF?=
 =?utf-8?B?cm9YQnM3VUFJbVBkbUFDRHpqQ1RqbzVhRVpmWVpoOEtVRFVDQUdZZmRpaEUv?=
 =?utf-8?B?VUROQmNVZ3BnL3NDUmYrc1ArSG9YN1E5OVJYT2FpMWJYUjVFT0lkblJ1S0Vj?=
 =?utf-8?B?QlFSV2QybFo1bWNHUzJRVGl2UjhjVDlqS2pIemVjSndoNmgzRHVLYWNsYlky?=
 =?utf-8?B?UzNzZkN0QVpZMzBaSS9laVZWekhtZkF0alNnTmdMUy9pRW5nOFA1eDdkZGFv?=
 =?utf-8?B?RHgxMlA5Q1AzT3dScXZ0WCszeGk5aHJ0aU5GUmdFYm1MZlJhRGtlYW1nem0y?=
 =?utf-8?B?ZlNtYjl2eGZJWW4zeVlKZHpPdFhoWUM2dGVmU1U3c0p5QjU5NkVqczFDTVBE?=
 =?utf-8?B?bE8wcDNuMEFkaHM0Y0d4c2xXa2g1aW1FQUFPbExOZGk5dUx0eDMvNjRmOUpG?=
 =?utf-8?B?MGU3WDg1YTN5bkZPVHhMYWhZR2dMbld6L0lwaUl3YU1Xb0lOZ0NON3U0Ly9k?=
 =?utf-8?B?dDJGd0tJbFVQZXBzdUxuS2ZUT1IzR0xVZktVejI3TUxnc2VmNnhsWVU0L1A2?=
 =?utf-8?B?Y0J2ek9MQzh4aWlUdWtXeDRYek9XbnVZc1hjc0NoR05wTXdvNTdRVWN3Nlhj?=
 =?utf-8?B?dGxjeFRnVTZuSWwyN2VabGljcjZpcFBiRzdDOUkveFdwemFHZnhlVjFkQUZ1?=
 =?utf-8?B?c1FGcDdRZEdncUtPRW12UGFmY0IvYkZBSDh2THFUVVhrWnZNNlkyMEluNmxW?=
 =?utf-8?B?WFJnKzIwTWpNSFFIOVl2QzB1TEJWYS9ibW05QjVNeWs0cncwMHJPd29JR1Q1?=
 =?utf-8?B?QzBkeWJwRUwxYmlySjNTYTNadks3eit4M1ZNWEZ6SXpBaGRqcWVNSW9Femdy?=
 =?utf-8?B?U2hyUFcyWUhTcWk5VWgvalhoQ1B0dWtYbXlLbmhhVkpWMkVmZmMxQm5HdGov?=
 =?utf-8?B?MDBVU3B4QjdPMzd3YXk1dE9mWDcwNkx0Rjc4NGcrenVJQnlEWGtHNlNPNjZC?=
 =?utf-8?B?a2dzczQxVitONnp6SWVzdG1zSUVBRDNTZVhQT2VSVnR3VVl3U1hVQitPZzBj?=
 =?utf-8?B?SFVVWXpkNkFNc3RFVUkwN1pxbys2WVhwRXc5Yml1RkhDSjYvSnAvUW9Kc0ZI?=
 =?utf-8?B?SmYxRXFaQmExbG5UdFQ3VjdyMU03RDF2eU1zRTRLSy90c0d1SWNMcmViUVcw?=
 =?utf-8?B?ZStxeHl0MDdLSERVMmJvMmhrTkFZZ2piMCt4NXpQNUFUUUxMRjZBc3dHejZ4?=
 =?utf-8?B?YmRZbUpZSjIrSHk1VlFXZGZTV0ZuaGtYemRsSXVhZUpyaVRvTlAxcWJHd3VX?=
 =?utf-8?B?TUNrMTNVM09ZVHZ1ajRtcU1MVWtSRlcwQVBrUWZLTi9ucjl6TEhHUGdQSEVu?=
 =?utf-8?B?N1FhVkh6NUhCK2IrcWlVTTJYRVlJem0zcUp4M0l4TVppMzVPMjRmMElYajJq?=
 =?utf-8?B?UW1wODA3d2t2amhuUS9GeTRsOFR3ZHhqb3pWOGVMcktHSDJlN0pCK0ZVSkk4?=
 =?utf-8?B?WGQxbWxiY2plVjBSYmF2c3FiOXQzQ1YrelhBdnJzck1lYm9XNWpHdE9vUGxE?=
 =?utf-8?B?QUZyUGZpdjBTbTBPOVV5YWd3a3NUaytQZ0hESjJpTUx1V01VcmxoTXg2K1FR?=
 =?utf-8?B?Y3JJaDVneXJuR0ptVk1INm53eVpjTml1dTZxL3locUtKZGVHQTExUzVoVTVq?=
 =?utf-8?B?SExOMDBSeWtpNWRDazJJTjYyQloramkxNE9ueGNrTUw3R3BEYnF2c0dUS09Z?=
 =?utf-8?B?WVpnWU15T3p3cmkyeUwwUnJxL1hzaCtLL1pDVXk5SysrVWNKU1U2bnNMMlhR?=
 =?utf-8?B?aDlVSUduQ0VoTld2YzhqOThWSGZMV1FqRFZ4RDFFTENHK01iUmRXaFZYTnBY?=
 =?utf-8?B?ZnRwaFJscFlVZ2lCV1ltem9uUHNaT2RaT2pPS2dGYXV2dkdwYlNOamUycDZt?=
 =?utf-8?B?Q1RIR01ISzIrS2tXNVF4S2RNdW83QjlmR2U3RmdWaUJXeWhqZ3pOaWFKSXBj?=
 =?utf-8?B?ckJVanFnZXdVWG9uMEsyNEt5RVc5cGJWVE5yY1NoN2lPb3BjYTZFa0NvcnU4?=
 =?utf-8?B?MjVUTnVwaFRNVEFtWFNHUHpMOWRKTm9KQmZ5S3JuUWsrb2g0WUE1NENNaEJE?=
 =?utf-8?B?RlVvTkNPSWZMNnE4MFQrd3ZmWG51MzJJYk5WU1RVVkNuNktXeHhxVlFSMFdQ?=
 =?utf-8?B?TUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f863d66-8e0d-48dd-fc83-08dcc696ea78
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2024 12:51:06.0535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y3dqjEL9/FA7L/Bv99LBDY3V0/Hktd6+tgMqgY0k/RoPbntGPjJHYS4zEALNhP+Eo3vX9sSiXV0ZTPQAbZ7HOJwFAZHP03PA0/WdshUnalE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11639

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogY2xhdWRpdSBiZXpuZWEg
PGNsYXVkaXUuYmV6bmVhQHR1eG9uLmRldj4NCj4gU2VudDogVHVlc2RheSwgQXVndXN0IDI3LCAy
MDI0IDE6MzMgUE0NCj4gVG86IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT47
IGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlOyBtdHVycXVldHRlQGJheWxpYnJlLmNvbTsNCj4gc2Jv
eWRAa2VybmVsLm9yZzsgd2ltQGxpbnV4LXdhdGNoZG9nLm9yZzsgbGludXhAcm9lY2stdXMubmV0
OyB1bGYuaGFuc3NvbkBsaW5hcm8ub3JnDQo+IENjOiBsaW51eC1yZW5lc2FzLXNvY0B2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LWNsa0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LQ0KPiB3YXRjaGRvZ0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXBtQHZn
ZXIua2VybmVsLm9yZzsgQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhLnVqQGJwLnJlbmVz
YXMuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDMvM10gd2F0Y2hkb2c6IHJ6ZzJsX3dkdDog
UG93ZXIgb24gdGhlIHdhdGNoZG9nIGRvbWFpbiBpbiB0aGUgcmVzdGFydCBoYW5kbGVyDQo+IA0K
PiBIaSwgQmlqdSwNCj4gDQo+IE9uIDI3LjA4LjIwMjQgMTU6MTUsIEJpanUgRGFzIHdyb3RlOg0K
PiA+IEhpIENsYXVkaXUsDQo+ID4NCj4gPiBUaGFua3MgZm9yIHRoZSBmZWVkYmFjay4NCj4gPg0K
PiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBDbGF1ZGl1IDxjbGF1
ZGl1LmJlem5lYUB0dXhvbi5kZXY+DQo+ID4+IFNlbnQ6IE1vbmRheSwgQXVndXN0IDI2LCAyMDI0
IDQ6MjUgUE0NCj4gPj4gU3ViamVjdDogW1BBVENIIDMvM10gd2F0Y2hkb2c6IHJ6ZzJsX3dkdDog
UG93ZXIgb24gdGhlIHdhdGNoZG9nDQo+ID4+IGRvbWFpbiBpbiB0aGUgcmVzdGFydCBoYW5kbGVy
DQo+ID4+DQo+ID4+IEZyb206IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYS51akBicC5y
ZW5lc2FzLmNvbT4NCj4gPj4NCj4gPj4gT24gUlovRzNTIHRoZSB3YXRjaGRvZyBjYW4gYmUgcGFy
dCBvZiBhIHNvZnR3YXJlLWNvbnRyb2xsZWQgUE0NCj4gPj4gZG9tYWluLiBJbiB0aGlzIGNhc2Us
IHRoZSB3YXRjaGRvZyBkZXZpY2UgbmVlZCB0byBiZSBwb3dlcmVkIG9uIGluDQo+ID4+IHN0cnVj
dCB3YXRjaGRvZ19vcHM6OnJlc3RhcnQgQVBJLiBUaGlzIGNhbiBiZSBkb25lIHRob3VnaA0KPiA+
PiBwbV9ydW50aW1lX3Jlc3VtZV9hbmRfZ2V0KCkgQVBJIGlmIHRoZSB3YXRjaGRvZyBQTSBkb21h
aW4gYW5kIHdhdGNoZG9nIGRldmljZSBhcmUgbWFya2VkIGFzIElSUQ0KPiBzYWZlLg0KPiA+PiBX
ZSBtYXJrIHRoZSB3YXRjaGRvZyBQTSBkb21haW4gYXMgSVJRIHNhZmUgd2l0aCBHRU5QRF9GTEFH
X0lSUV9TQUZFDQo+ID4+IHdoZW4gdGhlIHdhdGNoZG9nIFBNIGRvbWFpbiBpcyByZWdpc3RlcmVk
IGFuZCB0aGUgd2F0Y2hkb2cgZGV2aWNlIHRob3VnaCBwbV9ydW50aW1lX2lycV9zYWZlKCkuDQo+
ID4+DQo+ID4+IEJlZm9yZSBjb21taXQgZTRjZjg5NTk2YzFmICgid2F0Y2hkb2c6IHJ6ZzJsX3dk
dDogRml4ICdCVUc6IEludmFsaWQNCj4gPj4gd2FpdA0KPiA+PiBjb250ZXh0JyIpIHBtX3J1bnRp
bWVfZ2V0X3N5bmMoKSB3YXMgdXNlZCBpbiB3YXRjaGRvZyByZXN0YXJ0IGhhbmRsZXINCj4gPj4g
KHdoaWNoIGlzIHNpbWlsYXIgdG8NCj4gPj4gcG1fcnVudGltZV9yZXN1bWVfYW5kX2dldCgpIGV4
Y2VwdCB0aGUgbGF0ZXIgb25lIGhhbmRsZXMgdGhlIHJ1bnRpbWUgcmVzdW1lIGVycm9ycykuDQo+
ID4+DQo+ID4+IENvbW1pdCBlNGNmODk1OTZjMWYgKCJ3YXRjaGRvZzogcnpnMmxfd2R0OiBGaXgg
J0JVRzogSW52YWxpZCB3YWl0DQo+ID4+IGNvbnRleHQnIikgZHJvcHBlZCB0aGUgcG1fcnVudGlt
ZV9nZXRfc3luYygpIGFuZCByZXBsYWNlZCBpdCB3aXRoDQo+ID4+IGNsa19wcmVwYXJlX2VuYWJs
ZSgpIHRvIGF2b2lkIGludmFsaWQgd2FpdCBjb250ZXh0IGR1ZSB0bw0KPiA+PiBnZW5wZF9sb2Nr
KCkgaW4gZ2VucGRfcnVudGltZV9yZXN1bWUoKSBiZWluZyBjYWxsZWQgZnJvbSBhdG9taWMNCj4g
Pj4gY29udGV4dC4gQnV0DQo+ID4+IGNsa19wcmVwYXJlX2VuYWJsZSgpIGRvZXNuJ3QgZml0IGZv
ciB0aGlzIGVpdGhlciAoYXMgcmVwb3J0ZWQgYnkgVWxmDQo+ID4+IEhhbnNzb24pIGFzIGNsa19w
cmVwYXJlKCkgY2FuIGFsc28gc2xlZXAgKGl0IGp1c3Qgbm90IHRocm93IGludmFsaWQgd2FpdCBj
b250ZXh0IHdhcm5pbmcgYXMgaXQgaXMNCj4gbm90IHdyaXR0ZW4gZm9yIHRoaXMpLg0KPiA+Pg0K
PiA+PiBCZWNhdXNlIHRoZSB3YXRjaGRvZyBkZXZpY2UgaXMgbWFya2VkIG5vdyBhcyBJUlEgc2Fm
ZSAodGhvdWdoIHRoaXMNCj4gPj4gcGF0Y2gpIHRoZQ0KPiA+PiBpcnFfc2FmZV9kZXZfaW5fc2xl
ZXBfZG9tYWluKCkgY2FsbCBmcm9tIGdlbnBkX3J1bnRpbWVfcmVzdW1lKCkNCj4gPj4gcmV0dXJu
cw0KPiA+PiAxIGZvciBkZXZpY2VzIG5vdCByZWdpc3RlcmluZyBhbiBJUlEgc2FmZSBQTSBkb21h
aW4gZm9yIHdhdGNoZG9nIChhcw0KPiA+PiB0aGUgd2F0Y2hkb2cgZGV2aWNlIGlzIElSUSBzYWZl
LCBQTSBkb21haW4gaXMgbm90IGFuZCB3YXRjaGRvZyBQTQ0KPiA+PiBkb21haW4gaXMgYWx3YXlz
LW9uKSwgdGhpcyBiZWluZyB0aGUgY2FzZSBvZiBSWi9HMiBkZXZpY2VzIHRoYXQgdXNlcw0KPiA+
DQo+ID4gUlovRzJMIGFsaWtlIGRldmljZXMgb3IgYmUgc3BlY2lmaWMgUlove0cyTCxHMkxDLEcy
VUwsVjJMfSBhcyBpdCBpcw0KPiA+IG5vdCBhcHBsaWNhYmxlIGZvciBSWi9HMntILE0sTixFfWRl
dmljZXMuDQo+IA0KPiBPSywgYnV0IEkgc2FpZCAiUlovRzIgZGV2aWNlcyB0aGF0IHVzZXMgdGhp
cyBkcml2ZXIiLiBIZXJlIGFyZSBpbmNsdWRlZCBSWi97RzJMLEcyTEMsRzJVTCxWMkx9IEFGQUlD
VC4NCg0KT0suIE5vdCBzdXJlIHlvdSBtaXNzZWQgdGhlIHNhbWUgdGVybWlub2xvZ3kgb24gY29t
bWVudCBzZWN0aW9uLCBzZWUgYmVsb3c/Pw0KDQo+IA0KPiA+DQo+ID4NCj4gPj4gdGhpcyBkcml2
ZXIsIHdlIGNhbiBub3cgZHJvcCBhbHNvIHRoZSBjbGtfcHJlcGFyZV9lbmFibGUoKSBjYWxscyBp
bg0KPiA+PiByZXN0YXJ0IGhhbmRsZXIgYW5kIHJlbHkgb24gcG1fcnVudGltZV9yZXN1bWVfYW5k
X2dldCgpLg0KPiA+Pg0KPiA+PiBUaHVzLCBkcm9wIGNsa19wcmVwYXJlX2VuYWJsZSgpIGFuZCB1
c2UgcG1fcnVudGltZV9yZXN1bWVfYW5kX2dldCgpIGluIHdhdGNoZG9nIHJlc3RhcnQgaGFuZGxl
ci4NCj4gPg0KPiA+IENhbiB0aGlzIHBhdGNoIGJlIGZpeCBmb3IgQ29tbWl0IGU0Y2Y4OTU5NmMx
ZiAoIndhdGNoZG9nOiByemcybF93ZHQ6DQo+ID4gRml4ICdCVUc6IEludmFsaWQgd2FpdA0KPiA+
PiBjb250ZXh0JyIpIG9uIFJaL3tHMkwsRzJMQyxHMlVMLFYyTH0gU29DPz8NCj4gDQo+IE5vdCBz
dXJlLi4uIEkgdGhvdWdodCBhYm91dCBpdCwgdG9vLiBJIGNob3NlIHRvIGhhdmUgaXQgbGlrZSB0
aGlzIHRoaW5raW5nDQo+IHRoYXQ6DQo+IA0KPiAxLyB0aGF0IG1heSBub3QgYXBwbHkgY2xlYW5s
eSBhcyBpdCBkZXBlbmRzIG9uIG90aGVyIGNsZWFudXBzIGRvbmUgb24gdGhpcw0KPiAgICBkcml2
ZXIsIGUuZy4gY29tbWl0IGQ4OTk3ZWQ3OWVkNyAoIndhdGNoZG9nOiByemcybF93ZHQ6IFJlbHkg
b24gdGhlDQo+ICAgIHJlc2V0IGRyaXZlciBmb3IgZG9pbmcgcHJvcGVyIHJlc2V0Iikgc28gaXQg
bWF5IGJlIHdvcnRobGVzcyBmb3INCj4gICAgYmFja3BvcnQgbWFjaGluZXJ5DQo+IDIvIFRoZXJl
IGlzIGFjdHVhbGx5IG5vIHNlZW4gYnVnIHJlcG9ydGVkIGJ5IGxvY2tkZXAgKGFzIHRoZSBjbGtf
cHJlcGFyZSgpDQo+ICAgIGRvZXNuJ3QgaGFuZGxlIGl0KQ0KPiANCj4gRG9uJ3Qga25vdywgSSBj
YW4gcmVwbHkgaGVyZSBhbmQgYWRkIGl0LiBBcHBseWluZyB0aGlzIHBhdGNoIHdpdGggYjQgd2ls
bCB0YWtlIGNhcmUgb2YgaXQuIEJ1dCBub3QNCj4gc3VyZSBhYm91dCBpdC4NCg0KTWF5YmUgbGVh
dmUgaXQuDQoNCj4gPg0KPiA+Pg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBDbGF1ZGl1IEJlem5lYSA8
Y2xhdWRpdS5iZXpuZWEudWpAYnAucmVuZXNhcy5jb20+DQo+ID4+IC0tLQ0KPiA+PiAgZHJpdmVy
cy93YXRjaGRvZy9yemcybF93ZHQuYyB8IDIxICsrKysrKysrKysrKysrKysrKystLQ0KPiA+PiAg
MSBmaWxlIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4+DQo+
ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3dhdGNoZG9nL3J6ZzJsX3dkdC5jDQo+ID4+IGIvZHJp
dmVycy93YXRjaGRvZy9yemcybF93ZHQuYyBpbmRleA0KPiA+PiAyYTM1Zjg5MGEyODguLmU5ZTA0
MDhjOTZmNyAxMDA2NDQNCj4gPj4gLS0tIGEvZHJpdmVycy93YXRjaGRvZy9yemcybF93ZHQuYw0K
PiA+PiArKysgYi9kcml2ZXJzL3dhdGNoZG9nL3J6ZzJsX3dkdC5jDQo+ID4+IEBAIC0xMiw2ICsx
Miw3IEBADQo+ID4+ICAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQo+ID4+ICAjaW5jbHVkZSA8
bGludXgvb2YuaD4NCj4gPj4gICNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCj4g
Pj4gKyNpbmNsdWRlIDxsaW51eC9wbV9kb21haW4uaD4NCj4gPj4gICNpbmNsdWRlIDxsaW51eC9w
bV9ydW50aW1lLmg+DQo+ID4+ICAjaW5jbHVkZSA8bGludXgvcmVzZXQuaD4NCj4gPj4gICNpbmNs
dWRlIDxsaW51eC91bml0cy5oPg0KPiA+PiBAQCAtMTY2LDggKzE2NywyMyBAQCBzdGF0aWMgaW50
IHJ6ZzJsX3dkdF9yZXN0YXJ0KHN0cnVjdCB3YXRjaGRvZ19kZXZpY2UgKndkZXYsDQo+ID4+ICAJ
c3RydWN0IHJ6ZzJsX3dkdF9wcml2ICpwcml2ID0gd2F0Y2hkb2dfZ2V0X2RydmRhdGEod2Rldik7
DQo+ID4+ICAJaW50IHJldDsNCj4gPj4NCj4gPj4gLQljbGtfcHJlcGFyZV9lbmFibGUocHJpdi0+
cGNsayk7DQo+ID4+IC0JY2xrX3ByZXBhcmVfZW5hYmxlKHByaXYtPm9zY19jbGspOw0KPiA+PiAr
CS8qDQo+ID4+ICsJICogSW4gY2FzZSBvZiBSWi9HM1MgdGhlIHdhdGNoZG9nIGRldmljZSBtYXkg
YmUgcGFydCBvZiBhbiBJUlEgc2FmZSBwb3dlcg0KPiA+PiArCSAqIGRvbWFpbiB0aGF0IGlzIGN1
cnJlbnRseSBwb3dlcmVkIG9mZi4gSW4gdGhpcyBjYXNlIHdlIG5lZWQgdG8gcG93ZXINCj4gPj4g
KwkgKiBpdCBvbiBiZWZvcmUgYWNjZXNzaW5nIHJlZ2lzdGVycy4gQWxvbmcgd2l0aCB0aGlzIHRo
ZSBjbG9ja3Mgd2lsbCBiZQ0KPiA+PiArCSAqIGVuYWJsZWQuIFdlIGRvbid0IHVuZG8gdGhlIHBt
X3J1bnRpbWVfcmVzdW1lX2FuZF9nZXQoKSBhcyB0aGUgZGV2aWNlDQo+ID4+ICsJICogbmVlZCB0
byBiZSBvbiBmb3IgdGhlIHJlYm9vdCB0byBoYXBwZW4uDQo+ID4+ICsJICoNCj4gPj4gKwkgKiBG
b3IgdGhlIHJlc3Qgb2YgUlovRzIgZGV2aWNlcyAoYW5kIGZvciBSWi9HM1Mgd2l0aCBvbGQgZGV2
aWNlIHRyZWVzDQoNCk5pdFBpY2s6IEZvciB0aGUgcmVzdCBvZiBSWi9HMiBkZXZpY2VzIHRoYXQg
dXNlcyB0aGlzIGRyaXZlciAoVGhpcyB3aWxsIG1ha2Ugc3VyZQ0KSXQgaXMgbm90IG1lYW50IGZv
ciBSWi9HMntILE0sTixFfSBkZXZpY2VzKQ0KDQpDaGVlcnMsDQpCaWp1DQoNCg0KDQo+ID4+ICsJ
ICogd2hlcmUgUE0gZG9tYWlucyBhcmUgcmVnaXN0ZXJlZCBsaWtlIG9uIFJaL0cyIGRldmljZXMp
IGl0IGlzIHNhZmUNCj4gPj4gKwkgKiB0byBjYWxsIHBtX3J1bnRpbWVfcmVzdW1lX2FuZF9nZXQo
KSBhcyB0aGUNCj4gPj4gKwkgKiBpcnFfc2FmZV9kZXZfaW5fc2xlZXBfZG9tYWluKCkgY2FsbCBp
biBnZW5wZF9ydW50aW1lX3Jlc3VtZSgpDQo+ID4+ICsJICogcmV0dXJucyBub24gemVybyB2YWx1
ZSBhbmQgdGhlIGdlbnBkX2xvY2soKSBpcyBhdm9pZGVkLCB0aHVzLCB0aGVyZQ0KPiA+PiArCSAq
IHdpbGwgYmUgbm8gaW52YWxpZCB3YWl0IGNvbnRleHQgcmVwb3J0ZWQgYnkgbG9ja2RlcC4NCj4g
Pj4gKwkgKi8NCj4gPj4gKwlyZXQgPSBwbV9ydW50aW1lX3Jlc3VtZV9hbmRfZ2V0KHdkZXYtPnBh
cmVudCk7DQo+ID4+ICsJaWYgKHJldCkNCj4gPj4gKwkJcmV0dXJuIHJldDsNCj4gPj4NCj4gPj4g
IAlpZiAocHJpdi0+ZGV2dHlwZSA9PSBXRFRfUlpHMkwpIHsNCj4gPj4gIAkJcmV0ID0gcmVzZXRf
Y29udHJvbF9kZWFzc2VydChwcml2LT5yc3RjKTsNCj4gPj4gQEAgLTI3NSw2ICsyOTEsNyBAQCBz
dGF0aWMgaW50IHJ6ZzJsX3dkdF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ID4+ICpw
ZGV2KQ0KPiA+Pg0KPiA+PiAgCXByaXYtPmRldnR5cGUgPSAodWludHB0cl90KW9mX2RldmljZV9n
ZXRfbWF0Y2hfZGF0YShkZXYpOw0KPiA+Pg0KPiA+PiArCXBtX3J1bnRpbWVfaXJxX3NhZmUoJnBk
ZXYtPmRldik7DQo+ID4+ICAJcG1fcnVudGltZV9lbmFibGUoJnBkZXYtPmRldik7DQo+ID4+DQo+
ID4+ICAJcHJpdi0+d2Rldi5pbmZvID0gJnJ6ZzJsX3dkdF9pZGVudDsNCj4gPj4gLS0NCj4gPj4g
Mi4zOS4yDQo+ID4+DQo+ID4NCg==

