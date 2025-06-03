Return-Path: <linux-pm+bounces-28033-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB48ACCB42
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 18:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CE79163908
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 16:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A309423C50D;
	Tue,  3 Jun 2025 16:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zv1pNsTB"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B8B1EDA0B;
	Tue,  3 Jun 2025 16:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748968069; cv=fail; b=RfjDspp0CPJlqisySS8UdA9jMLwnmSKb+5HcqbBuygdpyH1V/Vw6jZeHuSNYS7m8mhYIOjgVwaekewqkoRuqtVYwyDVBjKsMRrqBnANez2vkv/DPcMXc5stUC4/fW+kUkM4bTcyKQDeNMcwwizm3rE1Z0HGN22CgBqn7b49HKng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748968069; c=relaxed/simple;
	bh=5du/VAUSxvS/RIGIR9nmjSg/JgrN8R4c0ZaUHiRSErs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TfRED1BqIvQcV13xhSiRyLuDcNscdcClej6AHvcc7YfgVM0uIbifyopRAuds9zuCWE/pr8J+tRPd0HMxfqHgv9WBpth6m5YQLtnziMC2WR7tZ8GdWVG0r6tvWv/XK89BveuVCRSHIP7AlwvcMgZtxIMIr/5O4yqFkBIaGEylmN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zv1pNsTB; arc=fail smtp.client-ip=40.107.94.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z7GTScBY0uXowQWnygw4cKy85dTOr0eZRUWUQ2fxurxC9TSvFH4mFzIZkdr/k3Zpo5fwAtdJyZl8TUajKgtVKqRz6+yJLVLfoLCdDWRGHpdKjmF3GE0MmUKHS7K6nSCMU8bagm3dFWXEaTxP4TgfKmHGADZN4NtSLQCKa/eghmZk4YWxNZkDda44lEWzsddzSEvqcYpc7AUsRTwsN024xg0HcNEdK1uXLMb/QJmdbwLtbdz//4t/nNpBHgKZ+H10QJBOdmyTKVjxq6GobG5tNFXaWAOSNwpZV9I1dNrzqd5l8IDkSHe+Y7rW8mWBwv7ESc6zO/Dw3WOEckHE2GG2ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5du/VAUSxvS/RIGIR9nmjSg/JgrN8R4c0ZaUHiRSErs=;
 b=N6Pp04VtN55FwKWzI7bFJ0IVj+7Xv1mIAwIFRCpOFPWu1FJaWbJbkoPKdftX3/C+yasfniXSo/lOMRXW8tJG1PP7oAeFm9MwI7VGZkH53KGzCyMFI045w/UmC0bwLKAtY5H6C3++33NIxPaBdor5b2Kck/6+tXZ3I0FLI/XCrW/liP7/CAVTi8Orvrgf5KMb1GR5V4rEItRj0pKTECRd+TZ/GJ8ZbIebjCW349PQuvqUTVKpMFJsjSiDXxkwDueVR6/z7JlpGfeg4FLu21lnFub5rsvsTUux700uLRGxVoFIzenmbHVOOS6pKsFp4nLGYTX5VcPQdoWlN27xQLTGmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5du/VAUSxvS/RIGIR9nmjSg/JgrN8R4c0ZaUHiRSErs=;
 b=zv1pNsTBSInrE63sHVO5diK+WXtDLaoV2Xvsun8qhj7LLNor7PPhgKzFFItFTz1zcddhpb+A6FxwO6AfPFtnitqvZE/itZgxZ4vrUJUNQxzMdXRPYeXMVeS7dbVUnSBn/V2YwVSaK7hoYN3R59dC8cg3pvpUKzeElrlOj3fBYh4=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CYYPR12MB8870.namprd12.prod.outlook.com (2603:10b6:930:bb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 16:27:45 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.8769.035; Tue, 3 Jun 2025
 16:27:45 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM
	<linux-pm@vger.kernel.org>
CC: LKML <linux-kernel@vger.kernel.org>, Chris Bainbridge
	<chris.bainbridge@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Saravana
 Kannan <saravanak@google.com>, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v1 3/3] PM: sleep: Add locking to
 dpm_async_resume_children()
Thread-Topic: [PATCH v1 3/3] PM: sleep: Add locking to
 dpm_async_resume_children()
Thread-Index: AQHb1KOtL/3IVunxNkK5KORWGwWNNLPxn5eA
Date: Tue, 3 Jun 2025 16:27:45 +0000
Message-ID: <5572ce41-fc9d-4c62-bb70-a8684f8ba989@amd.com>
References: <6166108.lOV4Wx5bFT@rjwysocki.net>
 <13779172.uLZWGnKmhe@rjwysocki.net>
In-Reply-To: <13779172.uLZWGnKmhe@rjwysocki.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|CYYPR12MB8870:EE_
x-ms-office365-filtering-correlation-id: 556dc0f1-7222-4bd4-f3e7-08dda2bb927f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VmZDU3l4cStoVC9hcWd5TjdYcjRlTlZ1T1ZwY3NqOHh2SXIrYWQxVm41Q3B6?=
 =?utf-8?B?djZMMWxad21xM2NINjQ4ajVzeG4wY3I4d3JsalRTbUdWcjBKVndHbkFEWEx6?=
 =?utf-8?B?bmpBcG9LbTlUZld6aUUza1h1d1NkMk5mdlZ0UHNHcy92VnNWYTNDY1BOc2RH?=
 =?utf-8?B?ZDh5OU1nQzJIOWRyZG5xWHZDbU5NWEFwYW5GV01XeWxWb1RGbEtkaStFaFc2?=
 =?utf-8?B?MlY3TWVDNXFiWEIrci8rYWgreXpSOVJZZExOTmRuV28ycHBVL0l1TXJiN2pW?=
 =?utf-8?B?WUw5UGhoWDFjbmZhbmdHcDRHNk41UDR6MmxzZEt0TlUwYysxWW5wN0I0Mkp2?=
 =?utf-8?B?SHlzdk5sc3VERS8yd3Z4N09ZeWtPWkhpaFdKQmFtM0pWR2F6Q1VIeWRFSTdU?=
 =?utf-8?B?a3RzSVRuR0JkNzhrc0ZraHRGVUJIbXpMMWtjOVhIRmFpWTFOYXR5cjRjQit1?=
 =?utf-8?B?aTU5L0NlNnhTL1hXSkNHRzNIQzZQbVpxWWJ3dUpsNkpJbitDYUtWR0tmTUlX?=
 =?utf-8?B?UUxOY2hWdWVwZkpBQ3dLTWN4elVwNXNKa01WazY2Q1BzOVdBVkpFY2FCMElB?=
 =?utf-8?B?M0szYlJ0VHpVTU1RUFgyemdSZnBxbDZ3VGFzQ0tqYURJeVVXMXFWR09UcEh0?=
 =?utf-8?B?YkJIeENoeURab2xFeHBwYVc1R3dnWWVOWmMrZEJYcEwxRCtpSGxXVm1ZaGFL?=
 =?utf-8?B?UElNMXFVaGZLK2o3dGRBcjhVd0hBS0tDK1c5WHpqWjRkTGl1bW4xR3dxc3dZ?=
 =?utf-8?B?Rm5Wc2VvMTBnU084cjhQRUs3M1VVb3BKNlB2QVZmRHBtcG5DdWtLRUxQUksr?=
 =?utf-8?B?TmZvakh4eDVWZjc0eTFFaHFJTWtFL3pGampoUE5MaW5rdlZ1YklWcm5PbmVY?=
 =?utf-8?B?MUxLL1ROYUYwazVnK1owRjMrRE1DV1VWcVdrUDVjdUMvQy9QcmgwL2x2WDBu?=
 =?utf-8?B?cCtVM0hHSTR6SXc3MUJJbzlRbjAvd0NlOWJzSXBlbW10R0NQcFFWNjU3SCt1?=
 =?utf-8?B?aWJ2b21SUXBzSTZVa1poNzQ2eTlENElUZTBFSFJUYmxyeG1DUHNNYVFHZU1W?=
 =?utf-8?B?YWcrdFh0U0svamRNOGpkNjYrM1ZJenBHem9PblVaNnpWS01CM003QytIUjZ5?=
 =?utf-8?B?OXplYjl6UFk2ajFIUkFqcDh0VkRqM1dWMk1CRmswVUpnVDFheSt6VGw1V0VH?=
 =?utf-8?B?L3krUEdwRXJaZ2ZqT01vZEYyWmhLYU5oMkJmQnVlRXN6OVhwT3d2RXQxb3VF?=
 =?utf-8?B?MjkzcUhLSGdVRUFTTkM5K2xMTnNMK2FZV2tvVHFmN1E4MjMwMWRkNmFRRmIw?=
 =?utf-8?B?RG5xU3dTUGdISGNoMmo3L3cxY241TzlaaG5BNTZ0YXRsc3hFUnEybU0rNml3?=
 =?utf-8?B?TzN2WUJ2MXpCUERCb3U2bnFZR3BlRHVqWU1kRUwyekpSTEt4a2tjOEo1Mm5G?=
 =?utf-8?B?NHQxOFJIL0FFWlUvMStJS3FtTWczZ2VlMi9UeUdhNjk3dGwySkFZS0Z3M0dY?=
 =?utf-8?B?OURXSWtacTZSNHdJWEQzV1A4UTF6SUlZQWMyNHV6UDdnb3VmWGlIZCtJbzNr?=
 =?utf-8?B?RHNtVkRlM1JmS0FRRlN1ZzBIMmJBcnQ4dmVETmdTVXd3dkY1TlFWZUdBVkg3?=
 =?utf-8?B?OHY1QXphU3BnWDc3OCtNQmNFdTgrUHVUZVpKMTMzQzlXUWxPRTFNZnJrOUxF?=
 =?utf-8?B?VVc1TE5kb2M4TmIwTStPQllGVXIza1Mzb0ZKRXNMcEdKKy93R1p5S0s1Y1lq?=
 =?utf-8?B?bFlEaUZGbXRaN0wvRE5zZWFoRlNhTk1vVjc1a0dvUzNTS0JjRXZ1ZXV6T0J5?=
 =?utf-8?B?MEJIOUhmUUkvWWM0ajFKRTVycTVuZ0Vvdm9JUlVzQ3JaTVI2U1BGRW9GNThO?=
 =?utf-8?B?bXVpb0VkbUxxR1dGazVPaHBhZGs5ak40VUlIaE9wSk9qS0c2YXp4dEgyZ3Fo?=
 =?utf-8?B?SEw1c2poM3JWd3hVMXhVeklRbm1yREkvTUtsNVRPcDJ4TVFZMCtNMFJyQjFB?=
 =?utf-8?Q?nPPaMGzMfGiBysuE8NKm6xxvBIKYh0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SUhHcURQeHFHSkJrdDRQR0R0ZWxJck1VWDFERDRyMm05bDFvdkQ4dk9jd20x?=
 =?utf-8?B?S1BhblY1T21VOWJadW8wd0xPWnQvWXlrd0Y5UVViUlBveGxjbDBsdGZkNkJM?=
 =?utf-8?B?L1lyWkFCTXYwZUtUOXNvMjBjSzc0ODRXdVdVemU1emtLUHdkeEk1czJBOGJO?=
 =?utf-8?B?UjIwdEYxMGd0V0N6cGxSaTJ5Z0lWdHo0OC8zdmdZYXU4b2RuQmt0Z0xXWUps?=
 =?utf-8?B?MFU1bFo3K09JSk9SY2RsUVpxUG1GckN3QkxtMHdSZUtOMWJmMTlvY1BNS1dI?=
 =?utf-8?B?QUwyQ2FMYjhKSU9CNUtFMkhsMEl5Vnh0eFN6RTNFRDg2ZUk0d3dHMkpjZnBU?=
 =?utf-8?B?MnF4TkJHRXMzVzY5MkpMSWVzeWdqS3lYUk4xSEQzc1Zkb1dzZEpueW1MNTJW?=
 =?utf-8?B?L2V3dWtqRXRtTmkyUmNYQmx6Zk5RejFGSGwxTitvc2J2Y0k3NTNLWlRNYUZX?=
 =?utf-8?B?djRCc1pSNzlOd1ZrN09nMFBiZmNUZWppZ1IrOGhnYlNlN0doTHVyMlg1MlY1?=
 =?utf-8?B?WU9hM3U3Y092cE1sdnRySXlzVW1ZZjBvTVh2OUxDTFcvUzRNb0hVSVJ0V0d6?=
 =?utf-8?B?Qm5LaUJvbGZVazdCaXZvVWZHVzZkYkg2SVQvdGVBVFZXM2VOUGV5c3o1Yk1y?=
 =?utf-8?B?dVo2SVpoUjZaUHF6RzJhYjB3d2RQMUJCZVorTk9VVFFoZjl6aG9IL3hLQXNO?=
 =?utf-8?B?NkRmdVI5NU5BVzZXeFI4RDY3SlJwRHVVc2MrUjhCRWVZY2NDZURNU3hEZ0Ez?=
 =?utf-8?B?ZHU5M0lSK1JWSldVdUsrbHJxWjRiaHlaQm5YSFFCbk9BR2VtWlBhdDZ0eS9S?=
 =?utf-8?B?QTlwWm5xZ2VYUktSNG1wRHIvYjhIVnkzODUyQk5zTk1kelU1YUh0SHhmYTZi?=
 =?utf-8?B?aURpcjh2RzJmNHBVTGFxNWN0L21YbThoVmhDMHR5aklGNTRMeFo2SmdpeWp2?=
 =?utf-8?B?dWRZaURnbXVlU1duYlpqWFY2eXZkTU14YUpzOG5rcnBKeS9PcG5wcE4ySDNG?=
 =?utf-8?B?MStVeTVyYnc1OVdoeUUzd0M0Vm0rYmdrTlNoa2prSkZXSXlhdlZGWDJ0bGJZ?=
 =?utf-8?B?TENUYzlJeXdNMGIwNFd3dXNSdzNUSVJGWG1Td1RmUjFFNGRMUlA0cXh2SlI1?=
 =?utf-8?B?R1J0Skk2VmgrT05xaGJjT1R2L0NHK2hNTzM1NEN5NTNVT2xWVnM5bk90SzR5?=
 =?utf-8?B?cTRteFJyOTQ0cTgwQXZiQ0dDcFhXM1V1aEJ3SjVheFZYWjhOMTQ5K0FWSFY0?=
 =?utf-8?B?MFY2cDJjSFAxSVpGS3hVclBBQWpqWUxsTGllbUJ1N094NjViTDJ3SzVxM0lZ?=
 =?utf-8?B?bVBlTjVadjRNRmJTUkJybmo2aWFrUUx5cko1ZGExaTdzaS9LMjlPeUpyRzBQ?=
 =?utf-8?B?M055OWs5d29LLzVQU2pRRzhvNWI1cm5ZYnhxRHpwWEVjcWlDTXgweWdwWlY1?=
 =?utf-8?B?aXpoQzZ5Q3RvMmJjOWR6dHpKbTRkMUZzM1FMa2hMRTNXMHRyMkZvQ1lTaUR0?=
 =?utf-8?B?OWF6c3hlQXd0R0U4NFVhdnA5OXVqckdvdXdlcFd0TXB4MnovVDc1ZktQR3py?=
 =?utf-8?B?UWY2RFljQUFzclVrSjFsS1JFR1hXUkRLNmN5cDd4cFJMS29PRWIxVmEwa3k0?=
 =?utf-8?B?UWtoM2p2ODB5Z05MT3d3bVYxSGQxWTB2U2J1M3RCMUZWdmhzZnJJaC9jYmZh?=
 =?utf-8?B?NC9uVUdEb3l1ckFMRVFWTjZidHZJRHhZT3ZPcitLcE8yK2w1bVhvTlRud084?=
 =?utf-8?B?ZGtaTUFSb3R1N2ZIUjF1eFkrTmdabFMwc2YvdS9ydlU0ZU1sditBczdNZFp2?=
 =?utf-8?B?WWhoaHUrZ1JyWUUwNDJjTEZWQkdoSUVuUkp5bVBmc0xraWI3RUhpeGl5TTNa?=
 =?utf-8?B?ZnRtSUh0ZzJ4anFQaGgvTW1iNlgxK1ZoZ3ovMHQzRXVyNFNWQU5LQng5dkpl?=
 =?utf-8?B?V2hIVENkVFpxSUtCK3BWZXhpU3pjalg0RE53aHhQdC9uemNFeWFmVVAwYjhh?=
 =?utf-8?B?Z29mNWl1anh0Vm81a0NUTTVpQU5rZHQ1cms4VDN3SnZEVUJzZWpSd0JmUFRS?=
 =?utf-8?B?cjhoNEZxWWdDbWRqU3FreXpQelZhT2JZSUxNaVNJdnIrRUQrTTlwMTA0R1d6?=
 =?utf-8?Q?pdaU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4870DEDAC755DB4BB7B8E59380656E02@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 556dc0f1-7222-4bd4-f3e7-08dda2bb927f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 16:27:45.6228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UiM2uaTuEzy+LktsjwjxTnEYBS/kIMOHEZZFjtfnH60Qcjm2cFTltgwruNuYjpOgrQsT23dyEhXcP7hE4aAymQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8870

T24gNi8zLzI1IDExOjIxIEFNLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90ZToNCj4gRnJvbTogUmFm
YWVsIEouIFd5c29ja2kgPHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29tPg0KPiANCj4gQ29tbWl0
IDBjYmVmOTYyY2UxZiAoIlBNOiBzbGVlcDogUmVzdW1lIGNoaWxkcmVuIGFmdGVyIHJlc3VtaW5n
IHRoZQ0KPiBwYXJlbnQiKSBpbnRyb2R1Y2VkIGEgc3VidGxlIGNvbmN1cnJlbmN5IGlzc3VlIHRo
YXQgbWF5IGxlYWQgdG8gYSBrZXJuZWwNCj4gY3Jhc2ggaWYgc3lzdGVtIHN1c3BlbmQgaXMgYWJv
cnRlZCBhbmQgbWF5IGFsc28gc2xvdyBkb3duIGFzeW5jaHJvbm91cw0KPiBkZXZpY2UgcmVzdW1l
IG90aGVyd2lzZS4NCj4gDQo+IE5hbWVseSwgdGhlIGluaXRpYWwgbGlzdCB3YWxrcyBpbiBkcG1f
bm9pcnFfcmVzdW1lX2RldmljZXMoKSwNCj4gZHBtX3Jlc3VtZV9lYXJseSgpLCBhbmQgZHBtX3Jl
c3VtZSgpIGNhbGwgZHBtX2NsZWFyX2FzeW5jX3N0YXRlKCkgZm9yDQo+IGV2ZXJ5IGRldmljZSBh
bmQgYXR0ZXBtdCB0byBhc3luY2hyb25vdXNseSByZXN1bWUgaXQgaWYgaXQgaGFzIG5vDQoNCnMv
YXR0ZXBtdC9hdHRlbXB0cy8NCg0KPiBjaGlsZHJlbiAoc28gaXQgaXMgYSAicm9vdCIgZGV2aWNl
KS4gIFRoZSBhc3luY2hyb25vdXMgcmVzdW1lIG9mIGENCj4gcm9vdCBkZXZpY2UgdHJpZ2dlcnMg
YW4gYXR0ZW1wdCB0byBhc3luY2hyb25vdXNseSByZXN1bWUgaXRzIGNoaWxkcmVuDQo+IHdoaWNo
IG1heSB0YWtlIHBsYWNlIGJlZm9yZSBjYWxsaW5nIGRwbV9jbGVhcl9hc3luY19zdGF0ZSgpIGZv
ciB0aGVtDQo+IGR1ZSB0byB0aGUgbGFjayBvZiBzeW5jaHJvbml6YXRpb24gYmV0d2VlbiBkcG1f
YXN5bmNfcmVzdW1lX2NoaWxkcmVuKCkNCj4gYW5kIHRoZSBjb2RlIGNhbGxpbmcgZHBtX2NsZWFy
X2FzeW5jX3N0YXRlKCkuICBJZiB0aGlzIGhhcHBlbnMsIHRoZQ0KPiBkcG1fY2xlYXJfYXN5bmNf
c3RhdGUoKSB0aGF0IGNvbWVzIGluIGxhdGUsIHdpbGwgY2xlYXINCj4gcG93ZXIud29ya19pbl9w
cm9ncmVzcyBmb3IgdGhlIGdpdmVuIGRldmljZSBhZnRlciBpdCBoYXMgYmVlbiBzZXQgYnkNCj4g
X19kcG1fYXN5bmMoKSwgc28gdGhlIHN1c3BlbmQgY2FsbGJhY2sgd2lsbCBiZSBhbGxvd2VkIHRv
IHJ1biBvbmNlDQo+IGFnYWluIGZvciB0aGUgc2FtZSBkZXZpY2UgZHVyaW5nIHRoZSBzYW1lIHRy
YW5zaXRpb24uICBUaGlzIGxlYWRzIHRvDQo+IGEgd2hvbGUgcmFuZ2Ugb2YgaW50ZXJlc3Rpbmcg
YnJlYWthZ2UuDQo+IA0KPiBGb3J0dW5hdGVseSwgaWYgdGhlIHN1c3BlbmQgdHJhbnNpdGlvbiBp
cyBub3QgYWJvcnRlZCwgcG93ZXIud29ya19pbl9wcm9ncmVzcw0KPiBpcyBzZXQgYnkgaXQgZm9y
IGFsbCBkZXZpY2VzLCBzbyBkcG1fYXN5bmNfcmVzdW1lX2NoaWxkcmVuKCkgd2lsbCBub3QNCj4g
c2NoZWR1bGUgYXN5bmNocm9ub3VzIHJlc3VtZSBmb3IgdGhlbSB1bnRpbCBkcG1fY2xlYXJfYXN5
bmNfc3RhdGUoKQ0KPiBjbGVhcnMgdGhhdCBmbGFnLCBidXQgdGhpcyBtZWFucyBtaXNzaW5nIGFu
IG9wcG9ydHVuaXR5IHRvIHN0YXJ0IHRoZQ0KPiByZXN1bWUgb2YgdGhvc2UgZGV2aWNlcyBlYXJs
aWVyLg0KPiANCj4gQWRkcmVzcyB0aGUgYWJvdmUgaXNzdWUgYnkgYWRkaW5nIGRwbV9saXN0X210
eCBsb2NraW5nIHRvDQo+IGRwbV9hc3luY19yZXN1bWVfY2hpbGRyZW4oKSwgc28gaXQgd2lsbCB3
YWl0IGZvciB0aGUgZW50aXJlIGluaXRpYWwNCj4gbGlzdCB3YWxrIGFuZCB0aGUgaW52b2NhdGlv
biBvZiBkcG1fY2xlYXJfYXN5bmNfc3RhdGUoKSBmb3IgYWxsIGRldmljZXMNCj4gdG8gYmUgY29t
cGxldGVkIGJlZm9yZSBzY2hlZHVsaW5nIGFueSBuZXcgYXN5bmNocm9ub3VzIHJlc3VtZSBjYWxs
YmFja3MuDQo+IA0KPiBGaXhlczogMGNiZWY5NjJjZTFmICgiUE06IHNsZWVwOiBSZXN1bWUgY2hp
bGRyZW4gYWZ0ZXIgcmVzdW1pbmcgdGhlIHBhcmVudCIpDQo+IFJlcG9ydGVkLWFuZC10ZXN0ZWQt
Ynk6IENocmlzIEJhaW5icmlkZ2UgPGNocmlzLmJhaW5icmlkZ2VAZ21haWwuY29tPg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb20+
DQo+IC0tLQ0KPiAgIGRyaXZlcnMvYmFzZS9wb3dlci9tYWluLmMgfCAgICA3ICsrKysrKysNCj4g
ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspDQo+IA0KPiAtLS0gYS9kcml2ZXJzL2Jh
c2UvcG93ZXIvbWFpbi5jDQo+ICsrKyBiL2RyaXZlcnMvYmFzZS9wb3dlci9tYWluLmMNCj4gQEAg
LTYzOCw2ICs2MzgsMTMgQEANCj4gICBzdGF0aWMgdm9pZCBkcG1fYXN5bmNfcmVzdW1lX2NoaWxk
cmVuKHN0cnVjdCBkZXZpY2UgKmRldiwgYXN5bmNfZnVuY190IGZ1bmMpDQo+ICAgew0KPiAgIAkv
Kg0KPiArCSAqIFByZXZlbnQgcmFjaW5nIHdpdGggZHBtX2NsZWFyX2FzeW5jX3N0YXRlKCkgZHVy
aW5nIGluaXRpYWwgbGlzdA0KPiArCSAqIHdhbGtzIGluIGRwbV9ub2lycV9yZXN1bWVfZGV2aWNl
cygpLCBkcG1fcmVzdW1lX2Vhcmx5KCksIGFuZA0KPiArCSAqIGRwbV9yZXN1bWUoKS4NCj4gKwkg
Ki8NCj4gKwlndWFyZChtdXRleCkoJmRwbV9saXN0X210eCk7DQo+ICsNCj4gKwkvKg0KPiAgIAkg
KiBTdGFydCBwcm9jZXNzaW5nICJhc3luYyIgY2hpbGRyZW4gb2YgdGhlIGRldmljZSB1bmxlc3Mg
aXQncyBiZWVuDQo+ICAgCSAqIHN0YXJ0ZWQgYWxyZWFkeSBmb3IgdGhlbS4NCj4gICAJICoNCj4g
DQo+IA0KPiANCg0K

