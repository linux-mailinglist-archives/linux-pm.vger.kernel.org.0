Return-Path: <linux-pm+bounces-11993-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C8C94BC12
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 13:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 413071F21E87
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 11:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F6F18A6DF;
	Thu,  8 Aug 2024 11:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RziUNJKe"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD1010F9;
	Thu,  8 Aug 2024 11:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723115880; cv=fail; b=mDscVK7FnGETet80og12YBp3vcd/ywmmCAuWKMvWdOxDBUPCKmhNMYMrIrcBAGL/HfX9zLx6YRL9T4hHLIBcZLWpn3l/lmSk1+frQvjnzpTn43Bnm72I4RBK5RBhppZwT4H+CYJddQmib3FDrihkloEV1ZRxO4O+PLqOxySKteM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723115880; c=relaxed/simple;
	bh=Vqg+7Mxl7xXAtFpF1h4Q8ML+lh6DDQcWQ8UZQBRG6Zo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FrRXf8AC6aPopN66ETmAIwpjt3ZkTpC+VH6FIh8I/2RyqnjMMHrHGwbQ25GdwWNwgawwM81hs1aYpPP9UvebgOCXkVE5NTFZWN01qd4qqKd/JmbjNg78VVdQ1omYjA2diU1ueaj044mEhhFFnrJR2NoyH3mCcgZitU3hSS+pzlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RziUNJKe; arc=fail smtp.client-ip=40.107.236.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E/WAqdLURMO7abinbeU8CaomiFjUPVqN/66uvHQ48qsnraCrVBN9uTwDwWGBwwUNGXI+OreYPBAXUbYqJ2Ys4DOZoqd1ksuVbWLzJrmXqcKA7Yc0Jh9TTHeSN6BQJl5RuAcxPN6ZKpbk9ANqdXINHpsoXoh8uhX8jYoKFPWKdY0tKXrC0YhtGkCDBYqFzG1QzAjGaCwKeeoswZussaxih2/AuOs2NImzQPHMMuq6x4+9+Dr6edjMx3IbP+4ev0m9rQ8SGq4yZzkKXTsyBmv08tUh7orK0D0i+xJp/jogHA367Cb1J60OEnv3Ms1CrlTGmkPns2YcgdcWcFRjcoUeNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZznD5QBFyAVtBERQAOBWN09kfxTdxjr1nLGsngs6cDk=;
 b=dD4q9hjxG9MJjUsQ45zRCOSI/a9FifYXJNzPOyv7H8MCUpOt97S8JyDW3BC70c52jgYATSNYrrlgcLab9I/rugGY9k9WiQ/kUwiPMRqOln5SgJDGtdaucCpeaPvoVAOS2IEMQ8cpDLzRj/VjvTY1EcqU/iHX193798Fxd5Du71iAr3ewv/xVwhHcHuk0rGGMm/qpyC1oXf8hy/1mn5USLQUVOve5j31EDGit7ZTZeVTKQhdgD1XWC1B/vaRbXAt/9C3iFooLpF7utESg0ltPJuXiac8m6HHw9gQTR7GssVkZl34gZHBUvo1zn/ueXyKcz9Y7Ss0S4HJev2s2gAnKAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZznD5QBFyAVtBERQAOBWN09kfxTdxjr1nLGsngs6cDk=;
 b=RziUNJKe6Ou6L0o+UBA1GyiXl6ORS6RCRTzBPqx1i7venIfKknID54zDiTu++ibEZasK3+bPzqQnPQx/Egq2IunKVYFLkQATyKDqWA0qLQL2xF17TEVgAn2oCBwk70gOu3PzxIkk9tIdPmxBjY53b/l7UTgU/Tz1c5CLOMVMOog=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by MW4PR12MB6952.namprd12.prod.outlook.com (2603:10b6:303:207::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.15; Thu, 8 Aug
 2024 11:17:52 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%4]) with mapi id 15.20.7828.021; Thu, 8 Aug 2024
 11:17:52 +0000
Message-ID: <3c6e2fb3-4b51-4cda-a5ca-71bed94d47b9@amd.com>
Date: Thu, 8 Aug 2024 16:47:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] powercap/intel_rapl: Fix the energy-pkg event for
 AMD CPUs
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, tglx@linutronix.de,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 rui.zhang@intel.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 ananth.narayan@amd.com, gautham.shenoy@amd.com, kprateek.nayak@amd.com,
 ravi.bangoria@amd.com, Michael Larabel <michael@michaellarabel.com>
References: <20240730044917.4680-1-Dhananjay.Ugwekar@amd.com>
 <20240730044917.4680-3-Dhananjay.Ugwekar@amd.com>
 <CAJZ5v0h4GAVCpUnbCMHMophsSZ522kkReAbUMdfFgRJfd0vHkw@mail.gmail.com>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <CAJZ5v0h4GAVCpUnbCMHMophsSZ522kkReAbUMdfFgRJfd0vHkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0186.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::7) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|MW4PR12MB6952:EE_
X-MS-Office365-Filtering-Correlation-Id: 2995c471-10a2-4414-9064-08dcb79bbe13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWJ4UmxYRm5GdnlnV0FEeTlucnB2UTNGenNOS1Z0c2JTZ1JTNFA4WnNXamk4?=
 =?utf-8?B?b0FERm4rdWs0Q1hxRnZhUU9rcG5FWnNWUWNXdFFORlkwNERXdWdJRFh4b2dr?=
 =?utf-8?B?VGV4V2lXdm4zd09Eb1pwMU4wMWlIV0JoTG8zK1p1eFhqTytNT2VqSTYzaGZN?=
 =?utf-8?B?ejVSKzdOSHdIOGJycDhnMThaMFFhc1Q4QWlTb28wT3BNRCtKRGNkQUlzYmtV?=
 =?utf-8?B?dEJnWmUyTnY2YWYvQmFNbElQbVAwTDdOMHBqWGVyd25ULzNmbWpLQ3MxaHRL?=
 =?utf-8?B?aUd4NG5qUGY5NmltWTJIZmpQQ1krOUQ1VDdxY0xFdllRcHVXeGc0OUs1cVhT?=
 =?utf-8?B?bEZTR1ZsZHMwOHZjR3dPVDRjcGI0aWExV25FbTBZUjF2eGs0eFF1MVV3dFZM?=
 =?utf-8?B?SlR5ek5kQWhrbXpUeU9YWk1POWVmK3ZJRG9nVGs5VDNFbU9PUmFOOGhvN3pW?=
 =?utf-8?B?RWR2K29oaHlLRFVXL2FFNDVRN2h6VWRvcXZUdmUyVWdORmpQaHhhaWkySEV2?=
 =?utf-8?B?M2U5SFR2Ulpobmt3eS8vY1h5YUxFdEd2eGh5UDBuNzA1RU9ReVRUTmlQdUQ2?=
 =?utf-8?B?Y0c5bCtCRGlHdzZvMzhqblYrRmRGcFRYaFpjREEvRytDMGlzMCtjcWFQVlFB?=
 =?utf-8?B?RjI4cjBVU2lPVmtudG9FQWdVaXRQR3RMU1lLZHgrMEpwNUxSUHE0eWdlSTB1?=
 =?utf-8?B?TXJ4UWNRMzRCQk5TRjVYUmZMaDNXdS9xelFjR2xEMjlyOExZYk5rMnlBKzZk?=
 =?utf-8?B?bG83NUNQVEl3eE9URzl6VTFPZVBYTzUzOGFVTHpjY2oyL3ZNYURFMVIyUC82?=
 =?utf-8?B?SFhpbmlDMUZoS25FRzVKYmE4azVOR21zb1hOaHZ6bkFsQXJtRitPMmlZelg1?=
 =?utf-8?B?UDNHSW04N2d1YXZSeEtGSzBwckx3TENnaVNxemx6Z2xhbjFDN29WK04rcUtT?=
 =?utf-8?B?ZzJUeEV6MGlBZjMyaWVheUh1dUtvN2M4WXVrVldWRXNhcTVGWDlIdGdaWTZ5?=
 =?utf-8?B?b2N0czdjVmMrVjduanAweG84K1VhK1hhUjFDRWlvc09IZXhHbEQ0eEpqK0JC?=
 =?utf-8?B?SnB4Ykd0UFp4TGdOVXlTakRCci9GOHAzbU93NHlCeXN5TTMxOFhBMXlTQ2d5?=
 =?utf-8?B?a3liZGM2QnRQVHNNd0p6N3FNREhXM2xEejRzVzRWWFgremN5Tm1tNzBzMkE3?=
 =?utf-8?B?TjRHaXlMeXVKYklxbHdndUZHZ1prcE9UaTFHd0xvazdsWE84WUFvblYwbDgw?=
 =?utf-8?B?d2kraFJKaGhSaHRtVW5ZeWZvalF0MWE5c0JXUU8remhqQTRUMjZWR3Y5bzBN?=
 =?utf-8?B?QkVwVkxIMGNMMldUNTlNRDBxQ05DcE9mNGNyVGlwd2gveTU1Z1lIVi9OeXFU?=
 =?utf-8?B?WU1RaG13UWd3TVExaHg5K0VXQ1ZiSEUrTWJwWWYxeTFDYkFzWFpTM04wWWow?=
 =?utf-8?B?ZnNOdXZLYXhReVZuWW5CU0x0aWZ0MDN6bDBuTWhhMFNtVVl4OUtDYzlpeE84?=
 =?utf-8?B?bFhndm9HZUJoSHRSYzhhZ1pCMyswVGRxT1VLYVZVWWMvY0E2cXdtRUNaOVJQ?=
 =?utf-8?B?eUpiVDJyVHBtZlYwRUdoOUlKd0pOaTUrZ0pPeGhMejRPRkNvb2lwREtHUzJZ?=
 =?utf-8?B?aFVMVXo0elBnSlg4NWMzQWdJaThYMU84aU1nMjl6bkVKdzUwcDFaRm5xK0dB?=
 =?utf-8?B?T0tYb3czYVVWVjZtdGoxNk1ySmVyVkd4OXNTUForS28xMFNQbG15Q3pvYTFx?=
 =?utf-8?B?bWJJUDRPS01WaGZOY1NyRmZiTzRGcjhrZXdqRXlLNjF4T25ITnlaaWd6aDZF?=
 =?utf-8?B?bi9CSWZBZ2xJSjlWcDg1Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGJiRldLSG9GZVEwTUhWMU9ERG9yVTFIVVIrcVpiaFF5dmM5T3NBZEpCRGNL?=
 =?utf-8?B?blptTnVUTWVGQ2trcWtsTWI4M0tHVmpjdWF6TDdYS1I4QWpWbEdjc0s1S3c1?=
 =?utf-8?B?U2JIMlU5T2Q0S1lGV1JhMTFYenVCLytnWkRERHVrRjBoTjlDTlFOSzRLREZJ?=
 =?utf-8?B?cW44VkJFZ1RBdVlkemtwNGNDNUZycER6aFdhTlFqd0F4WDRkemtUMmtSU2ps?=
 =?utf-8?B?YlpETmJPSjlQcGFRb2VNdGcrWmhVUVZnUW5EaUVtWHJhNFRUcjBqcG5XWktn?=
 =?utf-8?B?c2NPWCt2dGQ1UEtyT0g3dkpwRGNpeU9TYVBNNy9FcnlOQ2NBdElMcWxxYkV1?=
 =?utf-8?B?MjJzTFM3K0s3aTN5dXpSTURZaExyY1ZHbnU4U0FjN3M3ZnVFdjhDMnkzdzhs?=
 =?utf-8?B?cTZXRjZiUU40ZENuWHVvWW94YjZXQUtzblRUdnFsN0N4eU9UbGtOZmxlVnVp?=
 =?utf-8?B?bWFvL1JsUDhiT0hQS1loenJTV3FSdHZhMW55UFZGYmN2UW9laHJ4em9xOFNL?=
 =?utf-8?B?TDNiNTJGQmt3cUYvQ1lRY2g0RHJpVzh3K2x1RnVwNkhBbXpUd2R3S0JOdTY3?=
 =?utf-8?B?KzFhbGVJM24yVnE4MExyRDhvd1gvN3lTVkdQaUFqUTZjcEtiSGlJTENkL1RT?=
 =?utf-8?B?SW5aN3JTbm8xZ0o0ZWNtNy9Zemo1eXJEbVVGeFdLejEzMFFmTTJMN0Zkczho?=
 =?utf-8?B?L3o1NUpDWjZ3dXRReHBya0U3WTA3dWF4OTFhekgrL0RPWnZEOTZ3d0o0b2ls?=
 =?utf-8?B?cDRPUXdudlNXNXNXMjZEeENXSjFoRlRXeVlNcXFnTHY0NWlJZ0Z3NW1GbkdI?=
 =?utf-8?B?eVdIVHZEbzdUU0d5SklQUVd6Z2ZtTDd6dFhFNllrQkIxQy9kOHFZYmpISU9Z?=
 =?utf-8?B?T3BOcG80TlJkRFNYSjJOb2U1ZnV2d2N0Q05xQmVRWEVxUkl4RHAvaWp4L2Vh?=
 =?utf-8?B?WGZYWXQwWTA3ZlQ2N3kvd2xMK0dVRWp1U1Z6THN6NVpPNmdDM3VVWWExV1hD?=
 =?utf-8?B?MERKWXlZZVlqZHVadnc3cGR0TnNWY0gwelZrcEhVbUdVMCtFZ1VnSDM4MVdj?=
 =?utf-8?B?Y1UwOUxIZG1kVWpNM1FLSkhPM1dZTnhmSitUeWNGbnV6eDl3YXpRNUJBN0th?=
 =?utf-8?B?WmovMXJBdENnSVBmTXk4R3NzdWFjS3JQVkgvdC9GaTg2UTMzY0ZydnZXeVdx?=
 =?utf-8?B?TEJTcGdIZ1FoL0xEcnh4eDJvRDZsOVpxd1hUQUlaZ0ZPaUlTYTVzbGcvdGxR?=
 =?utf-8?B?dHpGQStxTHhYcU9VNjB3eFBTakZjT1B4bTg5Tk9USHAyNmtnL3Q5ZHZBeWpy?=
 =?utf-8?B?QUhWZ2lDYU4yQjFyZ0RCSldqcWJJNGU3bEZxb1pFdmNqVjZGQnZETkQwa3c3?=
 =?utf-8?B?dUZPc3IxRnhKUEtMbmhRUXh2c1VyelF0SXFLaUJESHdsYkZFa3BVM0pxTXdh?=
 =?utf-8?B?Wng3enpYMUlBREdDQ0lqYkkxVS83THpHU1VDeTMwVDRmNUE4ZTlzMURzWm1q?=
 =?utf-8?B?Tms0STNrZnlLREpSTWpIY056M1VDMnU1dTRFc1RKdm1QcDJFcDc2cGoxd3dE?=
 =?utf-8?B?cmlyY3EvRS9TK2tjUXJUdTVNTlFNLzZoaTM1MVJlWHk1K0dOZWJRd1B4RVpn?=
 =?utf-8?B?T3RtNkJWU3QvakduS0hkc3ZkdmFaRTdMRHpkK09KZS83RUJVYStZUVRsY1JE?=
 =?utf-8?B?OTVGR08wUktKNGNuQjEzNlVyajRlY3o5S1RkQ2RWdnZjeEtPMnBMalhoenFS?=
 =?utf-8?B?WDNHbjlxR3hnM0VDL0t1THZwY2ZXeGtjbFpqblVwNUNjd2lCa2FDY2F4L3Fa?=
 =?utf-8?B?cW9nMnFQeTJremxWTzFvUmYrM3pTYm5lYTRWaHJIeGY3S3BscnhxSHprYWZu?=
 =?utf-8?B?bjhkUlJqTjlBekcyUTBzT1NWK3FjVzVrRGJ6Z29rS3c2Zzg5eEdNOW1Tb2N2?=
 =?utf-8?B?WEk5WnhSam9TZys4NWVITGZOSHF3dHYzTWlPWjZlNlFJa1VKK2t0ZEd5cmoy?=
 =?utf-8?B?WSsvanNzenhGSnk3ZngxYkxKalNDckE0bkd2VlVReUhhSk5qY1dWVWR1dCtx?=
 =?utf-8?B?eFJRVEh3anpUVGpFU0lsS2w2amxHditYNUljb3pNOVl3cUZ2bGpWQlRyY1FC?=
 =?utf-8?Q?4w+7CwAKdgOKnsVjLJvWy/cle?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2995c471-10a2-4414-9064-08dcb79bbe13
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 11:17:51.9429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UuxNC6/VX4/X31QH7LtfWmLX72YJBjeQHPpWV1XD/3ZB4eqSPQ4rvOa3qJwI0DhFh1h7ekUdRrVUc5225nSpmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6952

Hello Rafael,

On 8/2/2024 6:05 PM, Rafael J. Wysocki wrote:
> On Tue, Jul 30, 2024 at 6:53 AM Dhananjay Ugwekar
> <Dhananjay.Ugwekar@amd.com> wrote:
>>
>> After commit ("x86/cpu/topology: Add support for the AMD 0x80000026 leaf"),
>> on AMD processors that support extended CPUID leaf 0x80000026, the
>> topology_logical_die_id() macros, no longer returns package id, instead it
>> returns the CCD (Core Complex Die) id. This leads to the energy-pkg
>> event scope to be modified to CCD instead of package.
>>
>> For more historical context, please refer to commit 32fb480e0a2c
>> ("powercap/intel_rapl: Support multi-die/package"), which initially changed
>> the RAPL scope from package to die for all systems, as Intel systems
>> with Die enumeration have RAPL scope as die, and those without die
>> enumeration are not affected. So, all systems(Intel, AMD, Hygon), worked
>> correctly with topology_logical_die_id() until recently, but this changed
>> after the "0x80000026 leaf" commit mentioned above.
>>
>> Future multi-die Intel systems will have package scope RAPL counters,
>> but they will be using TPMI RAPL interface, which is not affected by
>> this change.
>>
>> Replacing topology_logical_die_id() with topology_physical_package_id()
>> conditionally only for AMD and Hygon fixes the energy-pkg event.
>>
>> On an AMD 2 socket 8 CCD Zen4 server:
>>
>> Before:
>>
>> linux$ ls /sys/class/powercap/
>> intel-rapl      intel-rapl:4    intel-rapl:8:0  intel-rapl:d
>> intel-rapl:0    intel-rapl:4:0  intel-rapl:9    intel-rapl:d:0
>> intel-rapl:0:0  intel-rapl:5    intel-rapl:9:0  intel-rapl:e
>> intel-rapl:1    intel-rapl:5:0  intel-rapl:a    intel-rapl:e:0
>> intel-rapl:1:0  intel-rapl:6    intel-rapl:a:0  intel-rapl:f
>> intel-rapl:2    intel-rapl:6:0  intel-rapl:b    intel-rapl:f:0
>> intel-rapl:2:0  intel-rapl:7    intel-rapl:b:0
>> intel-rapl:3    intel-rapl:7:0  intel-rapl:c
>> intel-rapl:3:0  intel-rapl:8    intel-rapl:c:0
>>
>> After:
>>
>> linux$ ls /sys/class/powercap/
>> intel-rapl  intel-rapl:0  intel-rapl:0:0  intel-rapl:1  intel-rapl:1:0
>>
>> Only one sysfs entry per-event per-package is created after this change.
>>
>> Fixes: 63edbaa48a57 ("x86/cpu/topology: Add support for the AMD 0x80000026 leaf")
>> Reported-by: Michael Larabel <michael@michaellarabel.com>
>> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
>> Reviewed-by: Zhang Rui <rui.zhang@intel.com>
>> ---
>> Changes in v2:
>> * Updated scope description comment, commit log
>> * Rename rapl_pmu_is_pkg_scope() to rapl_msrs_are_pkg_scope()
>> * Check topology_logical_(die/package)_id return value
> 
> This patch does not depend on the first one in the series if I'm not
> mistaken, in which case I can pick it up separately if you want me to
> do that, so please let me know.

Sorry for the late reply, was out sick,

Yes, please pick this patch separately, it is independent from the first one.

Thanks,
Dhananjay

> 
> Thanks!
> 
>> ---
>>  drivers/powercap/intel_rapl_common.c | 34 ++++++++++++++++++++++++----
>>  1 file changed, 30 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
>> index 3cffa6c79538..4bc56acb99d6 100644
>> --- a/drivers/powercap/intel_rapl_common.c
>> +++ b/drivers/powercap/intel_rapl_common.c
>> @@ -2128,6 +2128,21 @@ void rapl_remove_package(struct rapl_package *rp)
>>  }
>>  EXPORT_SYMBOL_GPL(rapl_remove_package);
>>
>> +/*
>> + * RAPL Package energy counter scope:
>> + * 1. AMD/HYGON platforms use per-PKG package energy counter
>> + * 2. For Intel platforms
>> + *     2.1 CLX-AP platform has per-DIE package energy counter
>> + *     2.2 Other platforms that uses MSR RAPL are single die systems so the
>> + *          package energy counter can be considered as per-PKG/per-DIE,
>> + *          here it is considered as per-DIE.
>> + *     2.3 New platforms that use TPMI RAPL doesn't care about the
>> + *         scope because they are not MSR/CPU based.
>> + */
>> +#define rapl_msrs_are_pkg_scope()                              \
>> +       (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||  \
>> +        boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
>> +
>>  /* caller to ensure CPU hotplug lock is held */
>>  struct rapl_package *rapl_find_package_domain_cpuslocked(int id, struct rapl_if_priv *priv,
>>                                                          bool id_is_cpu)
>> @@ -2135,8 +2150,14 @@ struct rapl_package *rapl_find_package_domain_cpuslocked(int id, struct rapl_if_
>>         struct rapl_package *rp;
>>         int uid;
>>
>> -       if (id_is_cpu)
>> -               uid = topology_logical_die_id(id);
>> +       if (id_is_cpu) {
>> +               uid = rapl_msrs_are_pkg_scope() ?
>> +                     topology_physical_package_id(id) : topology_logical_die_id(id);
>> +               if (uid < 0) {
>> +                       pr_err("topology_logical_(package/die)_id() returned a negative value");
>> +                       return ERR_PTR(-EINVAL);
>> +               }
>> +       }
>>         else
>>                 uid = id;
>>
>> @@ -2168,9 +2189,14 @@ struct rapl_package *rapl_add_package_cpuslocked(int id, struct rapl_if_priv *pr
>>                 return ERR_PTR(-ENOMEM);
>>
>>         if (id_is_cpu) {
>> -               rp->id = topology_logical_die_id(id);
>> +               rp->id = rapl_msrs_are_pkg_scope() ?
>> +                        topology_physical_package_id(id) : topology_logical_die_id(id);
>> +               if ((int)(rp->id) < 0) {
>> +                       pr_err("topology_logical_(package/die)_id() returned a negative value");
>> +                       return ERR_PTR(-EINVAL);
>> +               }
>>                 rp->lead_cpu = id;
>> -               if (topology_max_dies_per_package() > 1)
>> +               if (!rapl_msrs_are_pkg_scope() && topology_max_dies_per_package() > 1)
>>                         snprintf(rp->name, PACKAGE_DOMAIN_NAME_LENGTH, "package-%d-die-%d",
>>                                  topology_physical_package_id(id), topology_die_id(id));
>>                 else
>> --
>> 2.43.0
>>
>>

