Return-Path: <linux-pm+bounces-31255-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD347B0D36E
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 09:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EA35188E59A
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 07:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51352C325B;
	Tue, 22 Jul 2025 07:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="BDtWVpnN"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa9.fujitsucc.c3s2.iphmx.com (esa9.fujitsucc.c3s2.iphmx.com [68.232.159.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A35E56A;
	Tue, 22 Jul 2025 07:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169506; cv=fail; b=F5fEat2G4ohtsss2rRJnxAOv0KDVqhIg/YC5lCmaUoIK+zH36L5tQuH3GIZmnTpeLhbOVLXhYZ4pdW9xW9CoCIOMHKCGWzAt6UzUDqQ50NnO+juchnSfcDhCdsd4nncUv7+5pVJuh9gcJpDrBpKo8D7w7s4NEKW34I3J8/kBkg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169506; c=relaxed/simple;
	bh=ulRsRiLmmuK3kfA2ZEnN+j39Vrmu2D2WP0Nt4ZOpxoU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gT0DG7Kuq1FqjSkbC/bOaXgfUvHKmWljBAf1ofIVPPUVhEc1nn1yKgFAzhSyQREJ72RdHI2tSpjbdV8e7yt7w9mJ8KCEFkK+GTtGZs6b0v6EP5h5fT1MKL0iNJJ7UkQoSURhgKKIRWs811HU1lZeitSUDRS61LkOT3k0KDMrg7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=BDtWVpnN; arc=fail smtp.client-ip=68.232.159.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1753169505; x=1784705505;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ulRsRiLmmuK3kfA2ZEnN+j39Vrmu2D2WP0Nt4ZOpxoU=;
  b=BDtWVpnN/65TleSIiDUC2Zp/R5wkm4OqVs6MbjZ2SzTMOogbOpEsT2n0
   NJf8INC4VEDQx7kKERE5P5yx19ttPTDr2JqA62DQEBtrCSTqEYlIQkbx6
   N1exEl/O9RWWATbW7ImIaADjUpxbrAqYxoTyWT+gSLuHWlbXQ1W2EqAHo
   avquJkNH1+Uq4SzlOA6TFYfvcUfIdSKj28pfErxFSe24D573kvwMsqzPq
   +zxMHDfKK+tNjiEc/+IVPlfyAjuc7jrsKpnqVWnjwI66YWkBKhhVf4TCx
   HqqqiJQNFA+8bDXfrcwyPFV1rdeLuIUq5gNDu6nhCq5zffi5xk5wnDzXP
   g==;
X-CSE-ConnectionGUID: PV5Mg2wYS6S5N/rtz5xKRQ==
X-CSE-MsgGUID: 6NDRd/8XSoW9W5Pg94Brpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="162195203"
X-IronPort-AV: E=Sophos;i="6.16,330,1744038000"; 
   d="scan'208";a="162195203"
Received: from mail-japaneastazon11011040.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([52.101.125.40])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 16:30:31 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HP1JI46OL1jcKetUYRdb+npr5XM3FeFMM85AYPwxtT4UmkwNazVhXsktvIasvF93n2fNextRDzzp5iEzNHqywjL5jJLi/Kwj4vaIwaBsBgwQloKuabD789wsbuKQQFDHggxBwZ1Qtd6lQZAwarLXzXPwv6LHSMyTUtk3YS7jC5FSHVE8TCKe9zFjfLouVVJ34KCe0Sa+o3wYjSl24acxaZtDh3gWYkA1iuF17nn7kdM6/JUt0MjH3ak1nMGms1vBqHn4Vbf4wgMQFm+wSoao0Me1goTs/VYAVevLS8hHe0iZ2e0oIaIXDpxU9tqN00QVdL3/nN221dqGfBSNMWqviw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ulRsRiLmmuK3kfA2ZEnN+j39Vrmu2D2WP0Nt4ZOpxoU=;
 b=rZYlTZZfVlOHFOtF/yDpcZ0d1Qq+00qK2i7Nqkij+bHzdRidBrxPLr9Z+jDnfq0Dh6RJO6vS9kxTjuuR8Pdx6mrpWIGR6A+lNWiSWzVtzjv7pAvG4sGW6DOJ1eP7dBWpj9xxnKy6QF8X7VVteqYBU/kl9YF9Cg+Fayp7Wwn1ZfBh1CuUe1goPggcYIfmek8UJ880CjqGaksUmv6nqG27K9YT2VlJi6Zttb3TCDJ5u1O8jXPlMGlezop2jQqqlUL+vOWCy5GdwWRYEp5G8l11c8KteQwD4otWLLSprMjFy8W6JZ4sffOR8FMlumJEgTEqoJliFUrLDZn9YDh3oou+1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS9PR01MB14003.jpnprd01.prod.outlook.com
 (2603:1096:604:361::13) by TY3PR01MB11825.jpnprd01.prod.outlook.com
 (2603:1096:400:404::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 07:30:28 +0000
Received: from OS9PR01MB14003.jpnprd01.prod.outlook.com
 ([fe80::bf61:4fd9:7b06:2485]) by OS9PR01MB14003.jpnprd01.prod.outlook.com
 ([fe80::bf61:4fd9:7b06:2485%6]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 07:30:27 +0000
From: "Shinji Nomoto (Fujitsu)" <fj5851bi@fujitsu.com>
To: "'John B. Wyatt IV'" <jwyatt@redhat.com>, Shuah Khan
	<skhan@linuxfoundation.org>
CC: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>, John
 Kacur <jkacur@redhat.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Shinji Nomoto (Fujitsu)"
	<fj5851bi@fujitsu.com>
Subject: RE: [PATCH 0/2] cpupower: Allow control of boost feature on non-x86
 based systems with boost support.
Thread-Topic: [PATCH 0/2] cpupower: Allow control of boost feature on non-x86
 based systems with boost support.
Thread-Index: AQHbyuBa+atM0fAVk0qKi5bwr9ll97PpiVOAgAeOYkCAGInLAIAC2a0AgDGicvA=
Date: Tue, 22 Jul 2025 07:30:27 +0000
Message-ID:
 <OS9PR01MB1400335E9E14CF505B8AD26DED95CA@OS9PR01MB14003.jpnprd01.prod.outlook.com>
References: <20250522061122.2149188-1-fj5851bi@fujitsu.com>
 <aDhJdTWzDihchywc@thinkpad2024>
 <OS9PR01MB14003E72236096AD987D2D4CED96DA@OS9PR01MB14003.jpnprd01.prod.outlook.com>
 <0053926a-7b0a-4e49-9acf-fcb1d73134cc@linuxfoundation.org>
 <aFWZyPs4eBwGcKPu@thinkpad2024>
In-Reply-To: <aFWZyPs4eBwGcKPu@thinkpad2024>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=098ccca4-fbce-4232-a9fd-d3e6e8a5e151;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2025-07-22T07:24:40Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS9PR01MB14003:EE_|TY3PR01MB11825:EE_
x-ms-office365-filtering-correlation-id: 24f235fc-35b7-4ce0-57af-08ddc8f1a154
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?aVI5cEdRa0tSUmg0T2lQWFZycGpZV0JxWnpDYUovOWpSTHJtTUxIVngy?=
 =?iso-2022-jp?B?NmhYbk40U1E5cTN3REZRYldvcmRHcXNGMTU2SWs1ZkhkRUEzVUdKWERi?=
 =?iso-2022-jp?B?bXluUzE3aS9lZCsyemovaHJzYzREUEpDSHU1NjdPQm5rYldOa2pnZGZ0?=
 =?iso-2022-jp?B?Mjk3ZHVtbHdCUGY5RVZ5OTVPTE9CNUtFanpwUUZJcENTL3NwTmR0YXFw?=
 =?iso-2022-jp?B?V0hzZ0FKQmNob2VseGo2WDk1WXNXa0FsWSs4Y3cvdXdmKzN4UTcxUlJQ?=
 =?iso-2022-jp?B?cVBVU2ZiZVM3dTR0akp4TWEzUVkvSnlUaDdsSzJ2RFJxZHBhYlFNM3Ev?=
 =?iso-2022-jp?B?OGpFWmluak55ZTdreVJyUFNVd284dnFGYVZLTDNYVnBnc3NXNWE0d2li?=
 =?iso-2022-jp?B?RjBnOUpnbDNMbzE2QytzSDhmWDF6elBVNmRnUGc2OTFFNTdvM3pSZklr?=
 =?iso-2022-jp?B?VS93L29RdzFaenZ1RlljLyt0bXZsWjdFV3F6U1hPU0VkaTE2QXoyS21U?=
 =?iso-2022-jp?B?dDJHek4vZGJoNFNqYk52MVM4clZpcjl6ZjRUN0JBWW1LajhOSURtQTFw?=
 =?iso-2022-jp?B?aDlVL1VpZWp2MTBZVElBUi9ZeThBZmhrdXR6L0lmMkF3cC9rNEJOMklI?=
 =?iso-2022-jp?B?NmZhVWJFU3cxZms5czhJMk5PZUlVM2FhVmtvaGpxT1NKTWptN2dnaEVN?=
 =?iso-2022-jp?B?MUZTL0JSQlZoRU9FZHNJZUR5QjBtSDc5U201VGdaWW41dkQ5SUd6ZFJs?=
 =?iso-2022-jp?B?Q1JvclpSZmg1YmJOM1hmNWw3YjIyWDVkMElZNFZSWUkrOUtLSFNPSTY2?=
 =?iso-2022-jp?B?MjVGRTZFMEtiZUppZEo3RmtQZ3pVZ25GeU55ZGNkYUVMalR2T3ROTXc1?=
 =?iso-2022-jp?B?TFliaXU0QkltTmhXNHRabUZzZnpNMitYelVRVUFaVEJLUVZSZkc1QjdS?=
 =?iso-2022-jp?B?c1RCSTJJaWJSQ3ZMUmtJNHBXM0NuVjNBdEwzT25UalpsMEVodEJGUThV?=
 =?iso-2022-jp?B?YmxkTzBDZVVMM2JkcWZCVkZLUjJNSjJnWkxzT0xKRmpEM3Y1TEowa08w?=
 =?iso-2022-jp?B?ZjBIQXoyZHdXVmpPMW10MjhiWTRqOStJTFd0amd2WlZUM2tqSjB2QWs5?=
 =?iso-2022-jp?B?VVN5dGNkNE82N0ZuM04wZmxRTHQvRDVyVlRoUWtTMjBOQmtCUTJuU0Vy?=
 =?iso-2022-jp?B?WUt4bUIrSytLWXQ3Z1FpNU1CV0VaQVlkNzYyUEFWcjhmWVc5VDZ2TkFi?=
 =?iso-2022-jp?B?b3I0RUpzVGpPVnlaY2t6ZC9vY3N2WFZuY2ZpTzVLRG9pdFdEY2xpUzNx?=
 =?iso-2022-jp?B?cTVRb0pQaVVlUTk1ZUp4SVg2MlZackQ4L2U0ZnErSlRoUFZSczdZdW16?=
 =?iso-2022-jp?B?eGJNRjlKODAyVENWdG9zWVZwQ3kycUkycldKUkVEWjM3aDhEMkE3TkpS?=
 =?iso-2022-jp?B?SjFBU21CQTVVbzZrbElEZ0VPUEJnVEJ4UnNKV2IzVFZjbGd6TXBOYVhP?=
 =?iso-2022-jp?B?UDdRQlVWU3BCUXNMV3JmemR2S3NEcGEzVzdsalpUOXpyKzJqUWhqeWZn?=
 =?iso-2022-jp?B?dGxiOWhTdVVBaUZFS3Vqc1RwUU1rcHRUOWxGSzYzY0poZXJDbkxrRVRh?=
 =?iso-2022-jp?B?R2lhYlcrcWN3bFFwby9tU1hhWlFSLzZ4ZmQzcXR4eDc4MGI2MHFYYnFZ?=
 =?iso-2022-jp?B?aHV1MzRrb3FhNkFzbWk5L2JzbjRFekV1QUtrN0JGZ2Q3OVNKOEFiTzRD?=
 =?iso-2022-jp?B?NnFnTWRtblN0b1Z3SkNvRFE5OEhhRlNGZ3NOVDhNYWdjMUhoL0FNSG5z?=
 =?iso-2022-jp?B?YXM0Vm0wWHBBc1Zub3g0eWFMa3MxdW0yeWZSWUZkdnBFcmk5Q0Jic3dC?=
 =?iso-2022-jp?B?QWc2VGVLSlY2NDc0ekxFR2xkT0MxbTNZNS94TXQ3Y0pjcFZaWDdGODA2?=
 =?iso-2022-jp?B?K0F1bkNvUXFNT1FmQks1YkR3OXdrSnRqZXBsVkcySHJ5QTlDZU5xVTRz?=
 =?iso-2022-jp?B?cVIxcVkzVHNGeENqbUR0WWdOUXcwZHZxbnVWcjV6UVdBeitNR2UxZmY2?=
 =?iso-2022-jp?B?TTBFZy9NU0tIUkFiZWVQenFDVW9FZTV1aVp1RGRXVExadGtBVjdyTDky?=
 =?iso-2022-jp?B?dzNhd1BQVE12ZmxxU0xjSUZKVXMxYllzaE9KRCtFdUx6NzhqNWF1MjNz?=
 =?iso-2022-jp?B?OWJYVm1OTHozQXZYc0NWZkF0cTdEMGRS?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB14003.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?Z3QzblNKRmo0U3Vpd0ltZnFGaE1heUNURlVjSlZMYURseU1ndHVYZEJU?=
 =?iso-2022-jp?B?WElMTGlGWlJMU1NQTVY3UHlTWkhqSEg0NEtvZm5lS01BWDNJK1RUbEJE?=
 =?iso-2022-jp?B?ZmFDd0gvRjB5SHVtNUtWVU9hZ3Jzbkx4dk5ubWdxRDY1QmVsa0tsSEtJ?=
 =?iso-2022-jp?B?dkZRRDhkNTU0bkFIZ1dMbUt4Q3c3YnJ2Mm9yQmo3Z3VCaVNaMjlhTHFz?=
 =?iso-2022-jp?B?cVBvcXM5M3h1UW5uMm9hVGtWeGJBYkEzNmtsV1QrS1RmbHQrcE9mbm0r?=
 =?iso-2022-jp?B?MUg3eXpEcmdERVZ3QU9DOXc2a3hHRUJHSms1MDVqSHhhWFNxdmFhMW5G?=
 =?iso-2022-jp?B?dSszS0lvK2hOcEhvSDNYc2dEVXJ4V1NLRHp3a1hKelVLMENtaWkxdTJu?=
 =?iso-2022-jp?B?aTFVM3VnTlp0TDJpUmFROUhLTHhiL2xkQWowMWZWYTQ2R055MDl1ckNa?=
 =?iso-2022-jp?B?ZWE0ZTFRazdRczZhcDZJRUx5eUZlL3o3YjVhZEFLZ0YyL3ovdnl4eWw4?=
 =?iso-2022-jp?B?bzdRMFFzWEtFb3VHbkdUKzljb3lVekcvN2x2M3ZYdTM1UlRPMmpJYito?=
 =?iso-2022-jp?B?bUYyc3dBOE0vTkp4WWNYWkEyd1N6Ty9HRkxJU1lFbWhqSU1mVjkySkhj?=
 =?iso-2022-jp?B?S1dSUUp3T2tBRGhRYjloVFRhRzZxWFp0enZJUmFBSzFPZ01iM0NHMS8z?=
 =?iso-2022-jp?B?M1Q0SnEvZkhCa2t1RHIweFVjSWxvRVFBZnNXOWQ3ZmVFdzF6Zk9hTFpZ?=
 =?iso-2022-jp?B?Nkd4TVgyL3JReTd5NVVXMWhCVzQzUm9Xc05ZMkNaK2FyZlBhVFFUVVFJ?=
 =?iso-2022-jp?B?dXRDWmpwZW04dFdiVld2SGowWjBKcHBCbURSRGUvQkFKc21Cd3FLcFNM?=
 =?iso-2022-jp?B?eGljcWhHNlFaaDNZNm5wUURBOFpzYzdPdTVBK241WUYrQzI3Rk11Nmti?=
 =?iso-2022-jp?B?dFlZaVpENmpwdytMdGZ1cEMvaWJ1RW1peWhaRXVRdFJZZy9nUHk5U2dv?=
 =?iso-2022-jp?B?N1NLRy9YcmtJUmVucWNOYTkzaVBJcldWSlBvYUdNUmdSZU1xbTE0Smgx?=
 =?iso-2022-jp?B?R2Z0UkUvcTBSK1g5RjNGTzZ5NVAvRUFPbzdHcVVzVHJOdDVSdVpoYjly?=
 =?iso-2022-jp?B?aC9WM2hXR2d3TjJnaW1BVXM1YVV5ZUNmUWx5QnJubUtnek9VRmoxMnFF?=
 =?iso-2022-jp?B?WWNuUEoyeGxjVG5EMG9VT0hZckkzZHdWb2JvTlJ2RGZVY2NId0xUeENs?=
 =?iso-2022-jp?B?OTNlN0twc2Qvb3c0aXk2SjIrMnV1Q2tXZWFDWXhqblA5YjBxWXlNKzBw?=
 =?iso-2022-jp?B?U2tacjhTK3RFSzlnVU93cXZ4MVlTSXZNU21TaTVJQ2NmVGR4MThUbVQ3?=
 =?iso-2022-jp?B?OGRTMUZnZWg5ZEVIaDhKc1RNa0pEMDQ3ZEtRbEYzZGQxWjVWV09mbit3?=
 =?iso-2022-jp?B?ckhsb3VOR1dKcEhWMXA5WjBEZ1hyTW16MUVrR2JQTnIrR29MSUJaNGNB?=
 =?iso-2022-jp?B?N24yMWF5R2tUWFpsMHROd2I5bEl6K2dSejdVQVNzUGluZlh6eHBTQWp6?=
 =?iso-2022-jp?B?UnZVVEpmcWx3UFIwN2xHSVZYR05WU1NoRHcxTFZBUk5kMXYyNGRTN252?=
 =?iso-2022-jp?B?K3I5ZzhuTE5rWjlrd1U2Yjl4YVhZakowNTNDaEZiSGordWFEV0RUSkw2?=
 =?iso-2022-jp?B?Q01PVzdPaVFneFJnbE10Y3JoQXpEcER5eWdEWjJVU3FFdEMybmtVN0pJ?=
 =?iso-2022-jp?B?c2dLYU5tZTNDVkhWVGg3c09hMWxWa1BHaEJwWTZSaDZvTVRXWWdjSnRa?=
 =?iso-2022-jp?B?R0hsYkRGYm4zKy81S2V0UHZHQjRNbWtCeUdURWtNdWFmVVFBalBlUS9n?=
 =?iso-2022-jp?B?aDhGaW5hNTdOcnVUdThYdDEwS0Jxc3RKN0d6ZzZQN0ZINzBMaWlGNnht?=
 =?iso-2022-jp?B?SENXQVFMUGl3TnRLelNpWHZIczlub3JnakRBSEVJYzIxMnpSOFcyNy9N?=
 =?iso-2022-jp?B?SXBhOGRpZERhZ0VNeThBVjRPT0FaQ1lFWk5wZDg1NDE3ZkZyUjZrWHox?=
 =?iso-2022-jp?B?WmhSRXdjSUwxbHBqdjMxaDJMRVVFRWtMK2hYejlBYmZsUjZ5QmpaVHJF?=
 =?iso-2022-jp?B?d3dCQUpnTXFkUmlVajhqeVV0VWlKUjRKdEgvRitFTmV3d1UvUXVvVzBZ?=
 =?iso-2022-jp?B?NmhnY09kc0JwTVl1QlpObE5lMnY0Vlo2cDNid3M5bzk0ZzNka3hzVzN2?=
 =?iso-2022-jp?B?V1lyV2pwVE04Vi9UcmxucFMzYlIrRU1aOVlMbjg5eU91NHM4RVpIVWJN?=
 =?iso-2022-jp?B?ck54TlZXVW4yZk9md1BLbkgzYTVBKzhNUHc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AT1ljG3j9Qwz9BLfp/TCWVTEYX4ibV6iNEtn2y01m6AZE96rRspOpbFtpDe9HlQF6JqndEqkGVUJCo8TuGwQ2CIieZzIHIXcg8ZStK1g5V7BnrejrnUORo1Hw7QoZswra8pa3Ew9/7bbFX7n532gx8FiHQ7OafjNOEpv0hU42XY8VDBYpJBGX/V3lI5RW+vtTzDxHs3I8nw1eA7eiYKvufHsMTHkgE7nZaOhK/81HyvndtbkmUwZH6cBMjdcaDvafYFABUPX/ZvW9L+kNBawiz58fZ1vjKXfN2lG8U28JEP2Q7rlTLwIiTk6Q5/LDS0+c6uE5EKI26S8bPZXr2/9Z0Nq8ZKFUh5D10TpT0bXreTg7n68wuIviEhfH7BcIBMcavVedWwpHVT9QvmBtiQtjIOE5jhoDqxfv6I9wE0syL6pHeQuhTie9OrWZ9ow1CrZWKDZiupoRNyB/czpYjOj4Eb52MVTeilUr/1i/HE/ja0Q+9GHkzJDa0UocxjdcxWnddaE+41Xokz/j+9DIXocVx1ADVl8ySnU8fwa23oBZKX+mpSMl4AsjEBSSQgh5ct1Mb1lBiJ8PCUsOBX5KXtRAvhz1uM1I5vnodOl3SnC7uAqKTl4JMPtYGo/5wOJhUwX
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB14003.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f235fc-35b7-4ce0-57af-08ddc8f1a154
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 07:30:27.5502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x57h+EiBfSZLnCiwol5uJTij8CCEEs41suUdLSRqq2uQ465ay9669vEKvWs4hzFxzhnKSMK3PGmg6RUSG+bAj3YZmF5RChtuEzAUQc4MHvM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11825

Hi, John and Shuah

Regarding the subject, I submitted patches to cpupower, but so far I haven'=
t received confirmation that the content has been approved, nor does it app=
ear to have been merged into the shuah/linux.git master branch.
Could you please inform me about the current status of the patches?

Thank you for your time and consideration.

----
Shinji Nomoto

-----Original Message-----
From: John B. Wyatt IV <jwyatt@redhat.com>=20
Sent: Saturday, June 21, 2025 2:27 AM
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Nomoto, Shinji/=1B$BLnK\=1B(B =1B$B??Fs=1B(B <fj5851bi@fujitsu.com>; Th=
omas Renninger <trenn@suse.com>; Shuah Khan <shuah@kernel.org>; John Kacur =
<jkacur@redhat.com>; linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] cpupower: Allow control of boost feature on non-x8=
6 based systems with boost support.

On Wed, Jun 18, 2025 at 03:54:56PM -0600, Shuah Khan wrote:
> On 6/3/25 01:16, Shinji Nomoto (Fujitsu) wrote:
> > John Wyatt wrote:
> > > Did you test this on non-x86 systems? If so, would you please provide=
 details on those architectures and systems?
> >=20
> > Hello,
> >=20
> > This patch has been tested on Arm-based systems.
> >=20
> > * It was tested on our internal simulator based on QEMU which supports =
boost.
> > * It was tested on the Nvidia grace system (which does not support boos=
t).
> > * The cppc_cpufreq driver is working on both of the above systems.
> >=20
> > We have also confirmed that it continues to work as expected on AMD sys=
tems.
> >=20
>=20
> John,
>=20
> Let me know if you are good with this testing details.

I have not tested it, but I the testing details are fine.

--=20
Sincerely,
John Wyatt
Software Engineer, Core Kernel
Red Hat


