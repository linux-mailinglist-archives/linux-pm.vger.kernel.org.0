Return-Path: <linux-pm+bounces-40649-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD19D117A8
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 10:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4847B305373D
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 09:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D31A346FD1;
	Mon, 12 Jan 2026 09:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VwuBDUyY"
X-Original-To: linux-pm@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010064.outbound.protection.outlook.com [40.93.198.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D5430B536;
	Mon, 12 Jan 2026 09:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768209721; cv=fail; b=QZG/Fvc9TprfWyJaKYUAYcNtKh84/kUJxU3I4VHAS1WKoO2j23xQT9+mWozZwnKVwJUnEJ1KgygHwVjozoWJ5qdSs/z8R48QsU/0RXgYBL7bPygeOeeUB9paC3dAHa0lcEcoBkWQi8tudbJexCJbn5eRhFLpKRW3FOU876SxhEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768209721; c=relaxed/simple;
	bh=Eqr3Y7AKrNKgjQD12LQngl1GFYa/Z6zv7Sqm/fLjL7Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l5kI4IlpERj7LQ5IzEsX26kxuysoTkRIPoMnpLyso5Ul1p8h+gW/6620iOkcJM5L/ZhWWb/2gjRdrXFERIxQt6JL6UbbYl6L70he9kU58rcobRmo2OaTZTOr2sIUBACuGjkbErV1KL50prv/RSzgUE0CpbyDW9uU4wBS5Gx0pyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VwuBDUyY; arc=fail smtp.client-ip=40.93.198.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A/NvL7pv2CRaSWxvTzdfg/70tpIcNz2pABob5ohMUpSoBFs2SU3O+4uKcMxEdjHO1dPJKI22Gfc1JOZBeggp7fwjKwdOvjAjGC53qa6UOhhwlhAh/xx7uJb0VJJGHWb16c7JG9Bgiy/ZnWbbQ7Tpc8pXA2+Gvwe4FOa11fhUHCzq8moGK4hWHchme9rtgUPAMfILTE/KyKMmnTzhHSn5+a/+6CnCYra28+yipmVwMseNILM0o5NSezwLTWBsF9Y9Vw57kR8g+1lv7BlFapyW2UpPxKO8AFT31CKF8Cwz8zwwnYB9zQ0OowdoSACqW7TZQCzt34TMFgIEonsFW8hloA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xoGtONIWQypE1adY+vE0B5muxOnVUX19oOserKBkwOc=;
 b=A1XJKv1kBzAWbEG/cFRboHkw+2cr2x46ULodowrWJSpmnUl3XbVn9Nlg7UZ9EWWEQ9sZt+vKbwNPZfuCmIvP4LNNEB8AP8XASQtsJpcYuDJlcgewmuYW2hMUwnpKv4iRPgd9AbJ/e6q7NQViA3T2AljBrwquc1V74fwfS+RIRfrxSwSSeRbm7dKzAb1s8A2s4aNdGGBE5pWEzBfEjt+ovdLNtvM5aeJgRllwPwBJB4TQHn+OASc9NB3zcM46qPX4sMHkakfyU58xeZ+GO46Q85Kty+qVjqlgpR2M75ZwuiyxUuI8eAyxhRQtWdj809nmB25qHm+kpVWSr3rZ3O8Eew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xoGtONIWQypE1adY+vE0B5muxOnVUX19oOserKBkwOc=;
 b=VwuBDUyYgRt55P3aU+4rn15gTHAEGwQRw44wXhWQ+xAUeUhy+2lle+1Vxps7r7F7EiXI9LNfUwadsM3/Y+3lGBmUjfZcu5n/d/V3WQhCY0qO/VWGZXTpV+GGgETl9QbYgZ7nvG15ikjqCn4P/XKudN9gKL10QGwlffq51kFKTGI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MW4PR12MB7013.namprd12.prod.outlook.com (2603:10b6:303:218::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 09:21:56 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 09:21:56 +0000
Message-ID: <9330d0af-3482-4f64-b11f-a1a3a62371e0@amd.com>
Date: Mon, 12 Jan 2026 10:21:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpuidle: zynq: Switch Michal Simek's email to new one
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, git@amd.com
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 "moderated list:ARM/ZYNQ ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:CPU IDLE TIME MANAGEMENT FRAMEWORK" <linux-pm@vger.kernel.org>
References: <ebfbf945d90b0efff3ce0dc17fb7f1f0db5b6628.1765787278.git.michal.simek@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <ebfbf945d90b0efff3ce0dc17fb7f1f0db5b6628.1765787278.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0104.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::19) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MW4PR12MB7013:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e1abe51-72cb-4533-01b2-08de51bc07e6
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WnBQTEU5NXVRTjNUZ042T3FodnNkNDY3Yng5ZEU2THBZZmJNR1VqYWR0VnJl?=
 =?utf-8?B?dUJENXNzN3poOUNpRjViYkdzdTREa1BUQ0IwdEtjdGxGVWJYdmlNZ00xUzg4?=
 =?utf-8?B?dTlJaVpwWHFqb3F2OVdLRVJHY2dQejBjYmFzdERkUFNCMHJsOXUvMHYvV0Yv?=
 =?utf-8?B?aUE1TzFUcTZXODBaak5MclBUUkdEaXJUYmJkWWZqRS9aVzdETEdyWWc5Y1E4?=
 =?utf-8?B?cGozY1FjNWd0cUJKaVVKY0JWYkQ5Zm1jVGpvOWpROWZPTCs2RERJMU5YdmNR?=
 =?utf-8?B?M0lzcnM0amlueStIMVp2eDhkaHRCTDYveCtFblNLNWdBc29kbzdZQ2szWjlr?=
 =?utf-8?B?R3g3aFl1dkNBTENtYVp3T2lzZTFwWEdlK2svaFJWWXExb3p4RWhlOURNcm1F?=
 =?utf-8?B?SklxemhlRUp0NUYrZmxlZnFhUlV5blViVHpFMVdZYnJENVorTEtBaTZYNlJm?=
 =?utf-8?B?SHlQQW1TRnVZNkQrakdCcDJZWExDdHVRTG9nWkZoVHRTZ1NsVDQ2djIxaGRH?=
 =?utf-8?B?bzZEeTZkMk9Pa1VoZU01MlZ5akN0YW1Fck5DeTFzS1RqT0lSVkVJMUJNajFa?=
 =?utf-8?B?TVgzNGs4MjFXWktnTGVKYVlFeGpnRStUOTFBcGR6SnAwcWl4a1VzUEVWUDcv?=
 =?utf-8?B?Q21FMnlGc2xlOXdldGh4emNMY1ZKN1lPdlM1TUFGQWRXYlJ1OHQwaEJuSWwr?=
 =?utf-8?B?OFFrN2hkTzVaWXYrVVBNaDhPYW03Z1pDZWlSbnZIZythRXFkSVkwVjQ2Q0tI?=
 =?utf-8?B?aXpqaVp3bzFESVRHUnJnWXhqUHJKMURJZTdiM1hJcEFlM1VkRHdoQWd5am1a?=
 =?utf-8?B?b3JwZkoyTS9XekF5bTE2VTl0Y1AwSVI2NWJqS0N0eU9oVm0rWW5EaytzcEhY?=
 =?utf-8?B?N3BJMU9Deng3Sk1rWkZ3c1o5WFVHQm1HNHAwOENQcmJQVWJQeFU1SDMyRDJt?=
 =?utf-8?B?N1BzQnhlQlkyZEpFNWF5aGxFOUFtTCtNR3ZhU24yL25KckZ1SVhCZU9TSVdu?=
 =?utf-8?B?VjRYbmFEaHhPSWx3Z3h4QzJLSER4dmlVTWN4YVFaNnlRVkttSnVrMFozNlBz?=
 =?utf-8?B?ZUdpR0dzY0FlZUduVndLL0MwcVNaYTB5TnJueDU2M1ZzODNyZThtVGx1WGFr?=
 =?utf-8?B?UUlWWW5GUHZlbFhNTkM2VnptUklzdllLWnBPWGN3T1JDSVFGRGo3aG1MTW5z?=
 =?utf-8?B?NXZqRnlVSEMwMi9UZk9kVWRmKzB1SlAzRk9iQ0x2aEsvajhaa2kxRThNUnVn?=
 =?utf-8?B?NFBwYk5HSjRnN1lJYjlabDM4Vytvc3k1K2NlUVUzb3NFUFl5cHhxUnVGN1JO?=
 =?utf-8?B?THpUS21JN3FkTUR4TnZkbFB2RnQxdGlmQ1ErN0N1SWJuQ3d1aEtBUTViL1o1?=
 =?utf-8?B?bkxQRkZrdXh2ODVHb0pNdFozZVdZY2IvMDFISUNuYnZRV1ZPVEsweFRlL093?=
 =?utf-8?B?U0VQUWRNNzlLUmFNL2hKWUM4bDRSMm5GSTQ2WjdKdE12dFoxOFNpc2Q4cXFt?=
 =?utf-8?B?TkVnQXNBNFhMOXVOSTNXREtzRnh5eHNuZ2o2MGdkMklUcnI1ejU5RWFsSE1S?=
 =?utf-8?B?Y0J0R3FjYTJ5bVlKcGI3NDRjNDFNS01IcjVQZ1MyeGxFU0J2T1JEMnh3THBE?=
 =?utf-8?B?MUk0MWFBZjlQUlo2UitvQ29ibDNhODFOZGhyekp5V3ZiTW14Yy9VSkdqcEJZ?=
 =?utf-8?B?MDFYTXIzd2tKNy9veDU2WFVTWmVXd1psN0JlUmFlbTFVbjlFeHdoMkpWMjBj?=
 =?utf-8?B?VS9NWnNTODdMczhkQ0dhS1lYTmFlWW13ZUYzKzRTcWlrQzlNVHZqMGsvQjBk?=
 =?utf-8?B?Rkgwdk5OdTNvL2JNMDVidkZ2Q29LT1Z0UGM3aGV0VkgzQlEwV0tWZEYzUVhM?=
 =?utf-8?B?cVNVejlXRFFZNGxZQzdkLy9BcCtOdHFYajlEUmE3ZXhScDh5OFk2VzkvZXpI?=
 =?utf-8?Q?0Z4HMwlU+Xocg1UC1x6YB5aqFmoUpPUG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VU9EcGRsajNKcU5hQ3lQdndCZWd3N2RWV2ZlNkNPYmo5TVNQajdNM21WUnBr?=
 =?utf-8?B?Y1dNLzVrVlE3TzdWeTJ4SUk5anA2SDJPNGQzR3BHd1ZQU2FDNGJkbTJrK2JH?=
 =?utf-8?B?RXNJT0M4OTU2K3Q5TFVkQWtWR3lzYnhFbTZTMnZ4L1oyR1E2dzkvcGN2aW9w?=
 =?utf-8?B?SmxwUXErdlQza3cwN0NMd0xnblJRU2lDdERnYUFINWJtWGxWbzJJVXNsM0xS?=
 =?utf-8?B?RmdkeklwYkF1WWtrY0NDeDR3RFJrSHBxT0FvMnE1c3lEQVM1aWpraHZRaXFX?=
 =?utf-8?B?NXVlU3U3NVVveTJLbGZOdUVDWjl4M3ByZ3JCcHBMZTdFQ3pYUmxBc0JyOWs3?=
 =?utf-8?B?SzNJYU5pTUd5Q0ljMEtETlNycE10K1BEdFZubFF5c1ZiMnBKWXBmK3JDN2lD?=
 =?utf-8?B?NWtQcmlvZ3FWb2hPbXYzclBLekV6bSsyQWNndHJ0ZE5ldWhZZitSUXc5ZlRr?=
 =?utf-8?B?UjFKdTIwMzdaQUFsWkVOOW9SbGhZRUNzcEd0TTBYZEREZmF1VEw5ZUNEQ1lq?=
 =?utf-8?B?U0Fmc0R1UDBjNFRST0dlVXlPeFp3Q3FIYnZUamdsUjkybjRuK1Q0Z3VMelJ3?=
 =?utf-8?B?SXU3T0FzRXV6ZVNFdG0rWmIzZEs4WFNMcUhrL1VPSU4vampXQnBrTTFMN21F?=
 =?utf-8?B?eEsrM2ZVNFJjYlVQR2ZrK1RQR2RJeGJJK0QyYS8vMmpTU1VJbnZqNjVlMEtF?=
 =?utf-8?B?ZnNteHRaZUMwVDg3NXBzWjluRjVJY0QwQ1dzSkdkWDBZQnBaVDgySjN2b2VY?=
 =?utf-8?B?T25ISm9qckVQMmY3VTErbjhTN2FUYmpNSGJlQUxhbTY5TTdYaTkwWXhKY0gv?=
 =?utf-8?B?eTc4cTNkKzRYZmJIc1VCZ01kcWVVWHNTeWdsVWR2NjE1bEE4ME5zNU4rTXhw?=
 =?utf-8?B?ejFBRmtuVlptUTJ6ZXArWXpCajEyd2NEVVZueTNoRHJlYWIyeUlyVXJZeFp5?=
 =?utf-8?B?a2hEY3F1Z0pWVTZPWFk2azdEVUxZcUZFa0QzT2wvTUpNTmdZMW16UVJlZnRG?=
 =?utf-8?B?ZTJMZG95eEtZVHJjdko4SXpKRlBGa0VueitHZTdObStNeG5nOWkvdk55SHdw?=
 =?utf-8?B?Sy9IanVWdkhjQURyb0IvWkVGYUZGNlptRDRFekdBUC9veWF5cUVjM2hZcU1E?=
 =?utf-8?B?ZzRXKzU4ZEpDT05iSkhGaExRU0dUNXZzVGVGV0NQMVNHZFE2ck0xaHI3cUVm?=
 =?utf-8?B?bnBUNDhBMlNsWDdwdDlDMCt6YjAvOEwvdlJVMTkyeDdTT0h1TUJneTN0cFND?=
 =?utf-8?B?ZXpGQU02ajZHdXlZTXJiVHJmYmZDZFpCN0tNWG02VHlqQW95a2x5Um4wT1Ja?=
 =?utf-8?B?bHJ1bVBqVWFwQ3UxUVRobXJyZGZDeU81dzFaVC81UEoxaTJ3c05EYTJEUzI2?=
 =?utf-8?B?eXArUnk3Wk45a25ZSWR0VTJyNjZwd0pDaVJrdk5sQW4zeTNmRzdtcFNuZkdE?=
 =?utf-8?B?VG01UE9VbGFMRFBEd1JDRisrWGNpM3BHUjZXa3NRdjhHTGozRnZPa0VQaDhp?=
 =?utf-8?B?a1lTSHIycGJTV2JDeDk3SkZpQ0tiOW11cTZaRkxtSDFNWk1mWVZTNUkxRGNW?=
 =?utf-8?B?Qm8rM3Qxb01JUXM1ZkZaQzA2Z0RidlVWcW1GRXNXQ2J1L0h3TW9LckpMMjJM?=
 =?utf-8?B?ZHdkODB3REFhZThuSzZuSHRMbVA4T2tvQUpsY2N6OG9mdXduTFR3R2p6NUow?=
 =?utf-8?B?b3BnZk0wSXFYTERnM0dvR05DSXNZZ3YrUUxoaVUwUm5wSk5LaFB5b0xaRjRk?=
 =?utf-8?B?aGd4NnhmYkdMV1BEbXF1Wk5UWDhTMFNJNHFoT3M1RjRnUm0yK1pmemFWZWww?=
 =?utf-8?B?dUhTQXVGcUpmbmF1emZXMzZtNktrRjV0d25rNGNmQ2JjbHYwc3AwYm1tWUI4?=
 =?utf-8?B?ako1WFU0WktoaTg4MzE2TW9meWpSNHIvV1ZxUCtRcGM2eXg1MUs4eTR4UmhZ?=
 =?utf-8?B?bUNlOE5wWXc2dUlRNGJRejlncEE3T1FpWXNiQk81MVJBdkxaazVGUXRyVlpw?=
 =?utf-8?B?cWlDUHpGMkp2QWFYcGEzalVwV0pzTEFwSldrOGgwOU1yNzQwMWR5M1k2OHJK?=
 =?utf-8?B?bnZiZmorclkwL2JJZS9BZm9PZGl0akJOVk13eFNDYitaaWxieEZaRWNWLzh3?=
 =?utf-8?B?cjNicHErNHI4WlNaSTFJYjh0ZCtzZXkraFZ4aUlpcGthRDBuZlcvQ2FMTlZ1?=
 =?utf-8?B?Z1FQY0JzUGtWdTRQN0dGZzBDUWpPUmhwL0x3WmQ5bFkxMm5iYUNLYjVnS0hn?=
 =?utf-8?B?THlVMkpwMWJ3ejZyNHp1amJYcWE3TTI0SUVqN1JaZlUzOEs3dGdKeVZJL25j?=
 =?utf-8?B?MkxPajBGNXpJd3lJVHU3bnVSRzcrYjd3YUdicHR5OHVMZHh2bkF6dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e1abe51-72cb-4533-01b2-08de51bc07e6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 09:21:56.2778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ou/N1JemAwcR09Pvzd0v99pZu377K8zHFGWvs5jnH+PowxpqFqUM64t8C9zaAVS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7013



On 12/15/25 09:28, Michal Simek wrote:
> @xilinx.com is still working but better to switch to new amd.com after
> AMD/Xilinx acquisition.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   drivers/cpuidle/cpuidle-zynq.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-zynq.c b/drivers/cpuidle/cpuidle-zynq.c
> index a79610e723b3..89448ae4845c 100644
> --- a/drivers/cpuidle/cpuidle-zynq.c
> +++ b/drivers/cpuidle/cpuidle-zynq.c
> @@ -11,7 +11,7 @@
>    * #1 wait-for-interrupt
>    * #2 wait-for-interrupt and RAM self refresh
>    *
> - * Maintainer: Michal Simek <michal.simek@xilinx.com>
> + * Maintainer: Michal Simek <michal.simek@amd.com>
>    */
>   
>   #include <linux/init.h>

I have applied to my tree and will go via soc tree.

Thanks,
Michal

