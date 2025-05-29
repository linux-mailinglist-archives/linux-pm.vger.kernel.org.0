Return-Path: <linux-pm+bounces-27816-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D448AC811A
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 18:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6098E3A6FC4
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 16:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAE022D78C;
	Thu, 29 May 2025 16:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Y7YB6Ov3"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136B71362;
	Thu, 29 May 2025 16:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748537091; cv=fail; b=BiwYiDWqL4EAXkPwQXTQuuGJFATGSR+uJnUj3E5nctPOM2xRkqI3bFebi5oaA0RO6IVosNvFxu1aQ7fZtQ0DJWfhmaEv+BYmQRgA7obXAuMsMTyP2noc4Q/OKTM7io6FbYt21TYRYyFntF96ch2QKs+tw1VAgmJepXUx09G+vhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748537091; c=relaxed/simple;
	bh=OSjRlUedPbn+gFz16D7DSDQE/L2uf563QIdWLW02CSE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iA3EgUnUm4FX02+1G8q+Os7RyuJ8yaZJdf0iWS7NoTlxqCaYR8DubDu7kngXtjqC1B/GfoJvkag4WvA9GCbUtVMqT3IkPyN3lBGQ2i9vmCpkyDv08hqwNuhKtbWef8cCSj78bwT15IUGKjeaPoI5cDwbui+ncA8UifutvcrACFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Y7YB6Ov3; arc=fail smtp.client-ip=40.107.243.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uwetvLl+A1Epg59kdGOYJIvtrhwle6cBETu1I/vj8xSJrGvxS/c4WkouRBw78GEPE5pHna+M4KW3uJ6XHscSk34z+TrwP/+xfX+hK/dg6UAxygEg9B9qroXGCxJTeHS7zdzkIB9qK7AbnIxL0gxy1ebDTl8HJutoaU56MfvnJ8nVid/hQNmn4uHzLiL9U704ZruoycxoCuvnyJjwAApezBtZy+8BQq21bAYAxLCnlmK9/2lUqcNm916br5GV66a/Djf+Mdtrljak+43VyALWI19awi8GMIdL7uU49sRpJNwUlBIcQU2cpk9hhoX63SDleT+fH0DQLQeMk17D21jE7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSjRlUedPbn+gFz16D7DSDQE/L2uf563QIdWLW02CSE=;
 b=NmOcoBl9IQ10uEEl592qw9xI75vnBVL0y8+OIr4USpHvgxbQINlAUrW4PNuexhO7cbxQ93DaWAiaFOfXHIZjuF8xczazqO5S7DbkabaPT9jqyzG6hgcJHjK47AjqrfJSQ8AxgbDkigzGx9Gja1/NOwA9JOrhHrR5lel9Kkh/deE5iZxH8+JUeBktoF94eQxVCWCY3xBwJ76XshuGg4nD69DwEsbg44cNgIwbrTJ4meTozMNJ4CjudIYBhze0lqskJ/V3pxfcPQ7zVgTujEHCVDSM/K11a1D7xVVSt8lKLqvvI0nFvo/vKQSKIAzx+Iur5UeSmli2Cf9zUUxaFfwPFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSjRlUedPbn+gFz16D7DSDQE/L2uf563QIdWLW02CSE=;
 b=Y7YB6Ov37ji/7NuNKZT51B0OmHvxJJMAxnpL9fJHxJsrLjLh716uWqXBIDtSb8ZJ62fYehLmB/IkQMvavG0sEY4w45qlM/LaRkmaTnO4nb3iU2Sltgae6zu6r7i3WvjnX9eTqU0R8VQym5Ot+/OGX/BY5mug/oby/PAnUp9soUE=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB4387.namprd12.prod.outlook.com (2603:10b6:5:2ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.31; Thu, 29 May
 2025 16:44:46 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.8769.025; Thu, 29 May 2025
 16:44:46 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: Manu Bretelle <chantr4@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>
CC: "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>, Viresh Kumar
	<viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] acpi-cpufreq: Fix nominal_freq units to KHz in
 get_max_boost_ratio()
Thread-Topic: [PATCH] acpi-cpufreq: Fix nominal_freq units to KHz in
 get_max_boost_ratio()
Thread-Index: AQHb0Hb0f0lQZnilcEGIJRlnCWkrfbPpmNwAgAA1ZwCAAALHAA==
Date: Thu, 29 May 2025 16:44:46 +0000
Message-ID: <d3926d39-5981-4528-a505-ca478eb3de36@amd.com>
References: <20250529085143.709-1-gautham.shenoy@amd.com>
 <CAJZ5v0h27Re4UwoyCrauNfQupojpfwKSOzSppC9mwR-ATWD3Vg@mail.gmail.com>
 <CAArYzrKT2zMBL54i6AKj1kEASLA3D8W4-d191cuqADaC6NGbjw@mail.gmail.com>
In-Reply-To:
 <CAArYzrKT2zMBL54i6AKj1kEASLA3D8W4-d191cuqADaC6NGbjw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|DM6PR12MB4387:EE_
x-ms-office365-filtering-correlation-id: 30f50a33-4d56-482c-7af7-08dd9ed01f05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NFdQZGxHNGViWUxwYVYyT1AzQndlUFNkT1JBT0NTY2NhSElFVmZ4K24yaXFP?=
 =?utf-8?B?MGFEVEJNUDZNTms5Rk1JY2l2UXB2N1lqM2hjSXBWdTA4MGNLNnNLZ0NuT0dG?=
 =?utf-8?B?S0owVDhQREdyaWpROUJlR3dYMHFqNHZMSEQrS2l6eFFLYnNJN0hEUTRsbkZY?=
 =?utf-8?B?VDV6SWJnSzZuZFp1Vy9acGZCLzNxQTluSnI3cmVmaW80T29tL2VqNkNSL29w?=
 =?utf-8?B?VFdSZmZyNHRPUldLeUtxSFl3TGJHa0JyaVF6aDhuNnVSYW1TZjY2OXJRVnov?=
 =?utf-8?B?b3RBeHNLczkwL0N0NG1EaVU4QWttT01qSmI3cVc4Y3JzMWJFS3A4ZWlCQW1p?=
 =?utf-8?B?dTg1UXI5Wk9JWSt3dHZSQ2RBWlYrYTloQmVNcWYwL2lZTUFoWm1pam51U0Ev?=
 =?utf-8?B?TUhIR1hFWXMxazVvYzd6cDlwc2dMbEZWZG9VVHc2WHlaZnl5RUFlUEhPSlZ5?=
 =?utf-8?B?MHZHdTVDTURtYkk1S0hGUjhZVVEvMDJ0bHptQlV6T0w3ak9WZGdyL0F3Y1h2?=
 =?utf-8?B?U3FObkc5OEt6K3BRSWRvSXdiWEd4ek10RStnL09pb0kyMzhuVDJyQS84NXVK?=
 =?utf-8?B?MTYxMlltRkpBM2xBL2gwMHlJVnNMbWh0NUFwRUZkNGw2ekNwVko1ZmRxSW1j?=
 =?utf-8?B?Q0pJVVJWSXNta294MWtETitrOHlIcTV2MDZiSG8ydU1zcng5ZGFFRmVFTjJq?=
 =?utf-8?B?dmx1R3lmdnpST1FwaWs0eThaWHNsdWhqcGhqQUtPbUZDZ0ZWNzBYbDBvakM5?=
 =?utf-8?B?WWMybmN3SU14RnhvcUdPbEdlWW1EZWlxcEZYczNkVFV1bnk1WDBWRmkvdGky?=
 =?utf-8?B?Vy9IbGNWaHFSRFhCd3FyUlBmMmt2YXJxTVRUbmhSYTQ5bUpUR2FOV0R2aEts?=
 =?utf-8?B?TUxPcUNpdGFVTllRWkx1RjF4MCtRdUdIUU8rcWJCSmYyRzk2VDlMczBhamUw?=
 =?utf-8?B?ZWc2OENzc1Q4aTFGbDc5TVRscDJ6Z2x4TWRVMHpNNXhkNG8yYk1oL05HS05R?=
 =?utf-8?B?MW9RRzQ0S3pQdWQyV21zSXNwaUxsSjBDMjFmbWdDYnVVMmF3M1c1ZEF1WDlQ?=
 =?utf-8?B?VWtYYm95WENQRm5Bc1ovejFlS0xlM1RGVDAxUFRqY3ArYysvTEphWnNBd3pL?=
 =?utf-8?B?dXd1STJmM0t0dE9GSU96dWxUUEZtby9yS1FkeTFCNnhGUEJHbDJBS2pvZFFn?=
 =?utf-8?B?NzVVbTJQZjRveVJwMnJhQlNOKzJIQVJlNVdnRVA2ejZHcFhKdWk5L1FmbUdx?=
 =?utf-8?B?L0tPamI2b1o0amQvVmRGNzNMeFE1SGdBbWcxQnpKZUZXdHhkMGhoNXVNaXR0?=
 =?utf-8?B?TkJmbGtYNzUvWndSTHQxdm5rb0NycmIrTFZUM1dQSkpCSHFxbXF2ZDRRT3lT?=
 =?utf-8?B?VnlONEFQcFpKMGVFL2RQbFdjODEwWGdoVldxLzl0TTF4UDJRYzEzM3NLa1Ar?=
 =?utf-8?B?MXp2T25aZ0JxZGw4cHlPejQ5dzhWeXpNK1dVMjNiMEhTNWpCbm5YcnlTOGgr?=
 =?utf-8?B?Ky9oRjlSZkZXRkk3bnZqd0hPbzBuTlBnZkJJOXd2QjU3b1hrRnVGOTNGeXE5?=
 =?utf-8?B?WDRhQVFLN3lvYVpjUFJEaFRtQ3FVcWtCelo5dEdrNEovdGRmaks4UitXNnRT?=
 =?utf-8?B?ZGd2cG55TE5JbmZtY1R0NFhRYlN1M2dYZTRuZGM4YndpTm9abkRCYlJLQUJN?=
 =?utf-8?B?OS9ocXBab2tDTGNHQWx4alc1TXd5VHNXVWFXODhNdXZjWmlBM0haNno4SFpJ?=
 =?utf-8?B?YlVSZkl0aG9SWFV4Z2Fib3EzU21nK3dkVmZtWEF6T0hzQy9PbGt0NUJHZW0r?=
 =?utf-8?B?RVpEMFVha0VQNTgzcTJ3S0Y5NXdXeXhUM253RmYzR1BUVEdlcmRlclBEZlJ5?=
 =?utf-8?B?R3NXV3hRaFBQVDNUUXR0MDJ2U0g2Vm4zOHpWMjlGaWdpVEhvUEtXM1ZGVGRq?=
 =?utf-8?B?eElYWTNjVnhibVJLeFRBYVkrS1hRMGJoR00wMEc5QUZZWnVDOE9QbytvZElT?=
 =?utf-8?Q?wPvkU4YD0YPzJKPmdnepLjn9p5KYXA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VWdSSlptYXlDQTRTb1FrS3VyWlFFZVdTZUhaRmlTV3NwTEMrd1FCVlBPS3Mz?=
 =?utf-8?B?RUFRTVB6WEdPVU0vZFJIWnpZUHdaV1hMMnR5MGNCaGNLWWxZYU54NDk3NEZw?=
 =?utf-8?B?WW5ZcllxOUFlOXR0Q2NXd3NQT3Q0SE9tZk1RT3lzZWpOVDROdUwyUXFlWWU5?=
 =?utf-8?B?ZlVmc0g5QUM3Tmp5aXhaRXdNcitZRE0xSnNEdHpDSjQ0NUVRY242WUxMTnRk?=
 =?utf-8?B?aytHcnNyZXdhUDZobjl0MHBTVWRyVHhENm45RVlGU0FMNjZscktKM1FkV1FJ?=
 =?utf-8?B?TmdJVUtCR3p2cXVWTXJvWkx1ejNrd1NtS3dteWQ3QXpoZ29TQnhidVA0RU5N?=
 =?utf-8?B?L1FJUktGMERmRmtiOWNoZWJyS0lJekFiRGIwWU95VUhuVllhSCtGZUtydHNY?=
 =?utf-8?B?ME9xeVVURnl5emJnVEZFdS9HSnpHeVJVbUw0WE9nZGQ3SXlhV3h4cndLdHZQ?=
 =?utf-8?B?R1FkUWtpVXNLUktWOWF4cE1seTFFR0dkN1poeTI0czRHYk1xcU9PZGtFeFZL?=
 =?utf-8?B?WVlPUGFON1gyK1lsNVlCNFJzZlVCcXg1V0Q4Y0t1N3luZTAzTWdGeFJxUU9j?=
 =?utf-8?B?U0tMY01XY0ZIN2p3SzJmMTVIZStDOGJ6RXlKdEdXdFFFYkxGVkIwekRBcDE5?=
 =?utf-8?B?eGIwMU81eU41Z3M1OFdsUTNLUFcrQUpUWnBWNjVEV21qVFJ2clM3VDFFQ1Bu?=
 =?utf-8?B?MzlYYzIzcGZqTEtsZjBCa0o3bGhQVHZzNWRkaE1WTk01MUtLT1lTOUJSMDlG?=
 =?utf-8?B?UHc4QXdoRXNhRHJVdGRyWnNhL1hpbWlkZFlSVWFHZ0VPN21LUTlZV3NnR2dD?=
 =?utf-8?B?VEt1UmVYcWJWdzlEZ05TWUZ1MXJFa1QzbjJySng5ZUllYm9sUWhvU0daY1ZC?=
 =?utf-8?B?MVN1eFZVZDVWRms1N3h4Y0hCOXhaN1RUUW9EcUxUWEdTQnlLRlV2cmdmLzJo?=
 =?utf-8?B?ZUJLeStSWWJmRDRLZUZ6WmhuQTRuZGpkT2ZIUWgwZXhiMmxQQ2VoY1RicG1F?=
 =?utf-8?B?SEQ2eUp3M0NuODZNYzNBWGVZWFhWc2tJNUF2VlpUOTdFUzR0eEg0QTI5ZWdE?=
 =?utf-8?B?c1VZRVVTL1QrK09pakFPWHkvdVB6S1NrQVZkZGp0RkkwU0lOa1lSU2xVSWZC?=
 =?utf-8?B?UkV1Y0hkT0txaVNGZTVmWlJwK3R2bTJEZU9hRWxzcHdxb09vRmloTG9rZVZ4?=
 =?utf-8?B?UGxPeDdPdE5FVU5TY3lMVmhWL2FyWFlqZGhhbHRLRC84RnZDQ2FRV2NHeUpa?=
 =?utf-8?B?WG5uNTdVZ0NwNU8weVQzcUtjbTdxMkJtcVpyczRSVlgzaHlmRDlvM0lTZGg2?=
 =?utf-8?B?dmV4WmtSNXJKdUVFRmFNdkJSTG9WVUVtbFBzbEF1VGJBZG1sS1BCUjZNOUN4?=
 =?utf-8?B?SDFLL3RSNGlKVHNCUVJCZTVXVkF4Q2orQXA2M2M3aEo4NWtadW1VanJKbERO?=
 =?utf-8?B?VDRVdVUySVZrQy9IN2V4bnBxeDY4Uzhza0VMd3pzczBIemI2aHBWbHQ4Zm12?=
 =?utf-8?B?UkRLTnlBYVU5UzZ2NW9QTkJkMThObjhpb1pCbDB5T015dFY1eS9pbW1hNTVR?=
 =?utf-8?B?aHlWenVQcHlpZnBmbHR3V200T3VYK0tyL0lZeVdFc2xjaDNzcFZ2UXVTdHZz?=
 =?utf-8?B?N0V4OTMzTENVMTQrbFJwcFkrdzhQNzdacFdKQTY4a1Q2NWZ5VzZXRXoyNW9u?=
 =?utf-8?B?SkhHODNOeUQ3WHN5d2R6U0FyZER4dHVsY1lGVnlkKzcvV0drdnp5Nlh1WmlI?=
 =?utf-8?B?OHIxWlZ3VW5QZGRwWkJTN3BoQ2lKV2lEZ1dudUxjNStZTFdYeWJxQ1FRbE5N?=
 =?utf-8?B?V3VyeTlLN2dGV1ppcDB2bGl3b2Z1NGUwSWRPc2czT3ZsR1FVVEVmcTJqZUYv?=
 =?utf-8?B?K2NEQXVHL09vN0RsR2xiMGI3M3dFN2pLZDlKY1hGeU5TaEVRQnlmQTVEbHVN?=
 =?utf-8?B?czR4V0haZi9UZ09yREI0ZmNYMlBOdk5WdGNUSkRvZFRjM1ZPUElTWXdxT2NN?=
 =?utf-8?B?RXhNYzArZllOZVhDR3NkVytWQkxudzk1U0dKMXN3cE91N3EwZTNFNnJHR244?=
 =?utf-8?B?bndaQjV0NFJ4R3Q4QUtycFl2U1FkbG12WUd0QXBDN3ZwekZMVFdQUjFWNHNq?=
 =?utf-8?Q?1xeo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3928E482004FAA459F58FD081EF6E6B7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30f50a33-4d56-482c-7af7-08dd9ed01f05
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2025 16:44:46.6740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9TzSCornt5VRK1NQ+l/9qJiekc3QVtlo77Sa9oqsIdMdvzJEqhZLxcl2YzL/msSM/qjL+YALb9h+q99wbQn/tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4387

T24gNS8yOS8yNSAxMTozNCBBTSwgTWFudSBCcmV0ZWxsZSB3cm90ZToNCj4gT24gVGh1LCBNYXkg
MjksIDIwMjUgYXQgNjoyM+KAr0FNIFJhZmFlbCBKLiBXeXNvY2tpIDxyYWZhZWxAa2VybmVsLm9y
Zz4gd3JvdGU6DQo+IA0KPj4NCj4+IEFwcGxpZWQsIHRoYW5rcyENCj4gDQo+IFRoYW5rcyBSYWZh
ZWwhDQo+IA0KPiBJIHNlZSBpdCB3YXMgbWVyZ2VkIGludG8gcG0vbGludXgtbmV4dCwgd2lsbCBp
dCBtYWtlIGl0IGludG8gdGhlIG5leHQNCj4gNS4xNSBMVFMgcmVsZWFzZT8NCj4gSSBkaWQgbm90
IGZpbmQgd2hhdCB0aGUgcHJvY2VzcyBpcyBmb3IgTFRTIGJhY2twb3J0IGFuZCB3b3VsZCBsaWtl
IHRvDQo+IG1ha2Ugc3VyZSB0aGlzIHRyaWNrbGVzDQo+IGRvd24gdG8gTFRTIGtlcm5lbHMuDQo+
IFRoYW5rcw0KDQpIZXJlIGlzIHRoZSBwb2xpY3kgZm9yIHN0YWJsZToNCmh0dHBzOi8vd3d3Lmtl
cm5lbC5vcmcvZG9jL2h0bWwvbGF0ZXN0L3Byb2Nlc3Mvc3RhYmxlLWtlcm5lbC1ydWxlcy5odG1s
DQoNCkl0IGRvZXNuJ3QgZXhwbGljaXRseSBjb250YWluIGEgc3RhYmxlIHRhZywgYnV0IGJlY2F1
c2UgaXQgaGFzIGEgZml4ZXMgDQp0YWcgaXQncyB2ZXJ5IGxpa2VseSB0aGF0IGl0IGdldHMgYmFj
a3BvcnRlZCBieSBBVVRPU0VMIGxhdGVyLg0KDQoNCg==

