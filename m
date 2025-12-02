Return-Path: <linux-pm+bounces-39058-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB27C9B302
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 11:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D73A3A1507
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 10:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B145A30EF87;
	Tue,  2 Dec 2025 10:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="DSkzvRwG"
X-Original-To: linux-pm@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012000.outbound.protection.outlook.com [52.101.126.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B8C30DEDE;
	Tue,  2 Dec 2025 10:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764671831; cv=fail; b=cpG81iHDaSIdn1CLMkdObMPaLB//ZTXo6jJzjqNWNJx9CnDM26Ebl7amVZ2CPNgDofVw+YaIyW52U+YfBDacbu2XcPiy3/ulYqAg9AtwyjupVdV3tNlCR/02jY7n1kGDhbFohiVP/evDaqvbgELAGo4Jc8chKP/W2635NBKaLOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764671831; c=relaxed/simple;
	bh=cwvlJ3d7e8T4/TQEkAY2QMnFVa9o+a+iracG8lN/tYw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Oh1Fk9IyXNfxMr1l3G1aHINX8UHUoZ27JghAkBy6GMMXNKU2fUvTC328mc6hQuKMRndqtIypf7JHqTQ2PxyhEjGTYyQwWWK0fxru3T5V5Q3m+0vAAnJZ08sleY0tnlUKqaV0G3Mgx7vpBGEKStc2ummGuQ06rg7aWahRQrLmhBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=DSkzvRwG; arc=fail smtp.client-ip=52.101.126.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XX0jRVFGvcr7/aRB3zsxQNbzOvpoLB1MXmC86Y9CordNvwxvdqR/VYEnl9Se3D5YOykzT5jOezVo/+CZBbkRrJudBH9xjqkJ4B2+GAI4gRHSW5wLYgm9msQ8RpF48ZxeWG1U8vSzwpMt3e4Gn9OOIgqsY91DDqEiHjs+kBqOtRHWY88BqzYuaBXjIR/zDIBjAUQfY1sdvM3EbWMH8EbCKjo0/19OYag8ayDM+8uImJLPsbJUTVNTlzdX7Hi02ddVUZWSRA1q3bTx9bn2LcqWWhxXoJQun91ydJaCwsiNypxO8E3hz5H2qGgId+Gxw8GJalWU8P2abNVa82RwcDvc3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mTUYJHa2MDHTSiU2z5n6yPeldmvyNiv9oScoVMdLYjM=;
 b=BJdUacRfUrIQQhbhea9zJ5DjnSNglWVo5u9hi5ZtR5KmdcCuq5lKtDJFkbKSGczGx4ftuc2edAqBDAR6gDA7K13yXY6uOdKcyKYgV73O3LMBilwxohI+sIzdC/lrswmXyMkiN33PJFTX9AndsRVuQFRnDE2aZXE14Zw8YWhHYcOGcO/+e1hRMxQKTgOHuKzDqYDgD5g+xkedvwdzUTF28x2OarKqVScp/qCibLFqV7Yk2J8QgRoEwD0T9feqi4sDPWTCtpHrkhvCCDFFchiEUaQ/gyjCWP4E5dos2TZBanZe33Z+REkcifINzTZXTposYTbsu+mkQICNO4Frmbr1KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTUYJHa2MDHTSiU2z5n6yPeldmvyNiv9oScoVMdLYjM=;
 b=DSkzvRwGHM2Fd5MAfooDP/LWYXuK2ZCv/aBnehwJl4CkMJt5lfQkiCKfwTz5qedItqdSFidy6eKXoPT4AQVt/APfrp6O9aOagTKZM2ANcQlGQQukRKUwiXwrAVFeIak5mosMb++Uw1TV/sy6JxXBtrNd43cON9N+mrEqpfq4Uc2QaFjAzSEMaE/QuqSyWxLabTS2CTg1ydHYVt/+l0HcIhJ2a/v2XZZDcBTIw5ouhyOFMZTehAqahh/RG0QTzvQptsekyPIS80U0inOAyH0yi3HeSI1AvSjkiOOyaUU1SDHPCsEew8dvCPzJW6TrpLYouxe+vJBrQrjnYUSPtLEh8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com (2603:1096:820:146::12)
 by SEYPR06MB5868.apcprd06.prod.outlook.com (2603:1096:101:d1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.22; Tue, 2 Dec
 2025 10:37:02 +0000
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::6f03:984f:82ec:6846]) by KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::6f03:984f:82ec:6846%7]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 10:37:02 +0000
Message-ID: <0b8c07a6-de96-4091-96db-71fa6b95a8f7@vivo.com>
Date: Tue, 2 Dec 2025 18:36:58 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] PM: sleep: Do not flag runtime PM workqueue as
 freezable
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 Ulf Hansson <ulf.hansson@linaro.org>
References: <20251126101636.205505-1-yang.yang@vivo.com>
 <82bcdf73-54c5-4220-86c0-540a5cb59bb7@vivo.com>
 <CAJZ5v0hm=jfSyBXF0qMYnpATJf56JTxQ-+4JBy3YMjS0cMUMHg@mail.gmail.com>
 <6216669.lOV4Wx5bFT@rafael.j.wysocki>
From: YangYang <yang.yang@vivo.com>
In-Reply-To: <6216669.lOV4Wx5bFT@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::19) To KL1PR06MB7401.apcprd06.prod.outlook.com
 (2603:1096:820:146::12)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB7401:EE_|SEYPR06MB5868:EE_
X-MS-Office365-Filtering-Correlation-Id: 799c5c79-8d49-4476-13c7-08de318ebad6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OWJzdEpBNjFFRHF0ZmtjVFVnR0Z4N1QrVlZPeDdmOG1OTlJHMTA4RUQ3VGxi?=
 =?utf-8?B?V09yeWdBMjNOd3lSYUZCdEQ2ZGtVaUwzS2lTaWdZWkF1bXg1L1FFTGpHVTF6?=
 =?utf-8?B?TEdBblpZaHNCRjY0cW1TWEt2RmpKM1J2RDllMCtrWWpoaDRyM1kyc0ltd3cv?=
 =?utf-8?B?M1BNWVZUN2hQdkdwd3NUQUs1RlJMQ1d0c1N4eTZRWUhwbU8xNE1DL1VFRW91?=
 =?utf-8?B?NXBJWGlhTGIreFFrMUdGK2RJd2ZxVEwzV2NiTURFQjBhamRpczRqWkZpNFBp?=
 =?utf-8?B?ZEdhdEJDTENYS2ttYXRYY3k1TGNDbldsVTVqSnZGeUwzQmk1ck54VDRNTmNQ?=
 =?utf-8?B?RVJUV1ZUdnBscE5jcS9RQmxFN2JKc0F2RFpKbU1rcWJ0THhMTXhENE9vOWFo?=
 =?utf-8?B?aE1MbG43UUI1WDlGWjVBdkdtOTNDL0g1NHFLbDJ4dWt2RGRmbDdGdnl5ZE54?=
 =?utf-8?B?ZHpMUGY5WnRNNVdtdlJXdDl2Mjk5dU16MTRQTzgwOCtDclB6VWlwejBONWFS?=
 =?utf-8?B?NUVGa0l4QnFDSnE1b0FMcmUyaXA4OWQzZzJwWmMwNkx5OFNYdXl3UFZqb09n?=
 =?utf-8?B?ME54RWs1a3c1THpkSmhpN1VOcjRCN1BOZGFibTNuUkxuem8vaVdEc09PK1Zx?=
 =?utf-8?B?cGZFZmk3VE1lMmluVyt2QnFsTTI1MDVyOUkvSmthMDg2QVhDcDVTblhDSlJv?=
 =?utf-8?B?STdZZkdGN0pYTm9NdnRzV1RXNENPOWZka0ZoMDUyMWpLSWdId3FmQ3VqR0R4?=
 =?utf-8?B?MDJLTHpJNkZJdkVHV2ladHdqb2RZYkxicHdWTEFyWkdMVkd1cG41UmFMK2Ni?=
 =?utf-8?B?SVVITDIxbnNBeGhMcmQ4RXZuOVUvNURuUGJ6VmFuNHFlbFQ0QUZmRS8xTWw3?=
 =?utf-8?B?LzVIeWs0TlFLcEN6THJjUnhlN1QvdDFuWUFBd3h0QVpDVDA3dVhFU1U3R0RQ?=
 =?utf-8?B?ZC9pLzFDZnhwZlVtejk2RFVROVFpR09JTjBnaEY4T2ZQZEJLazNnNThNNS9y?=
 =?utf-8?B?WS9rd2UvRUxqWCs5YzVMcFRWYnNGcHhhN1dtYUhYSVVSTE9RZlBWbktYNHV1?=
 =?utf-8?B?Uml6Ti9IZnRQaUNwZE1ZOTVDalpycGl6Z1RyTG9tVnhUN20rSklQbGhYdFZO?=
 =?utf-8?B?eGRIUGo0ZGhuMzVrbVFqYXZOZ0ZLQjU3Z0xxa0pvcE4yYy9WNGVMQVRYQXpo?=
 =?utf-8?B?M3JveUlNWnBvNEF0V011SjkycVRMekFsNTJreEhtbGJsZnBBQUUvRENYVTdO?=
 =?utf-8?B?aEIxMWkxNnJVRjljOGk5U2VDaGl3bzJubi9pclR3MmxhTEJnN2poZ2w1V1RQ?=
 =?utf-8?B?eFdTOVQ4NlJtSHdQb2RoMVY3UVB1YzFpeU1wM21MMmdhb0VLbmFOKy9uaXho?=
 =?utf-8?B?QjI1Q3lFMHBKbFBSaTMxMlJJcVZlVzhyb0h5cXJ0dUs4YWRoczhubWFodHFH?=
 =?utf-8?B?WTNyL0dUbTVLYW5lS1NVKzh4VDgzOVNibW94QlRjZ1hENCttRFpEa1VRc080?=
 =?utf-8?B?TVlVNkw1cERKWmdrZFdOMDNvZjkyMmw2UHN6YjB4Y0U3TVpzS2JIQXJKV1B6?=
 =?utf-8?B?bWVwQjJ5a2FsY0RTTE1MaFZ5SWJqQTU4aUF6TVBrN1JMOHQrUEl0TmtLY1E5?=
 =?utf-8?B?RjdrVWg0bGYwcHlFS21ZaXlITzY3WGdDei84cHBTbGZVeTRZMjBzNHh2V09m?=
 =?utf-8?B?OVk4NGQvK2s2ams5Y0dQWUQreEJ1YkExbC8xcXcyYzNCMjkwZ2FwQ2djNFNo?=
 =?utf-8?B?NHVjWGlpaDdWeXg4V2ZSZXVYVkpPaEhyLytwc2N2ZERaTXUvZDc3amt6QUVv?=
 =?utf-8?B?bWVMU0U4SkFXTEw2YUxwVFlEdGlFWnE3TWJ1R1paWjN4aSt0TnlqNjdmMmNr?=
 =?utf-8?B?RmhWamNMR2JqbGRZdlQvaHArRUFnL1h4c1hJekZiVkVWNzlsbzNyZ1RIUmdv?=
 =?utf-8?Q?7v60HB48E39da7+dVFqMFyF30hhTjGkW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7401.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHMybEdPWElHNTlwOFUwalZmbkVMSnNlNzJxM2xhYUhPNWVmeDNFSnAzZ2JW?=
 =?utf-8?B?WjlhWEc1SHBRZjFBRjlYcG1NZzlacDR6ZllqSzU3MHhCQWNreU85SWkwVC9M?=
 =?utf-8?B?MVltWUkxOUtRNVg2QzNHeFIwdEZNNTBjdDZUT1RrUkh5UG10T0hVR3BMT1Fu?=
 =?utf-8?B?ODkwZ09pU0JNOXVuWGFaVm5Jano1bWZkOFNIY05sb2ovSzl2Q29wYVFHTWN0?=
 =?utf-8?B?Umw1QjRCSGtwZ0Vic1NRZkFsVWdLRnM1WGlCMmZHWjVCY1JlZnVCdXZKVnV1?=
 =?utf-8?B?bEFKSjVVTGN0Si9CTGtmaGFGQXd0dTF6SG5OU3prREVaNHE3WlZ0cER5dFN3?=
 =?utf-8?B?ZHR5WGpBU203cHFnT0RRZ2VQdWlQZ09MblA4R2R1Mk9zV2kxUVV5QVNjV2xL?=
 =?utf-8?B?REVGanhEdmZldW1WTWw5bnF4Q1JmWGVzb2RRZlA3dllTV2ZDRzY2VVpWWFk1?=
 =?utf-8?B?TjI2c3JwOUNhSzBZS3N0RDNndW12Y2pGL05MLzNaa1Vka2ZlS1gxaXRtbXY0?=
 =?utf-8?B?ZWVwMC83UnlTTUNhYWpheVZxZEE3WmoycThybzRoOTFiK3B5NjJVWXpldWEv?=
 =?utf-8?B?OVp2eDBwVFh3aEl5RGhzcFp3WEJsYURsUkRHbWdsbGtxOFNGUlZHSFVFWVpM?=
 =?utf-8?B?eFJBQ005SWpkVmQxRk1meUpDcGJmMjJ4UnZQbXltNkJsWmpDUnM2WDF0MSt0?=
 =?utf-8?B?bDdMOEhJNWdVSFlPRXNxWGg2SnZ5ZnhmUUJ2TFkzaXF4QWJVWG5JRE0zRUxm?=
 =?utf-8?B?M1JmdHV2eS94TWZjb2EvTzVkS0NDZnd2c2pqL1IyRU9MK3lSYkZtdlNYYVM0?=
 =?utf-8?B?NHNOZkUvSUhOdHMvd0RYd3laNndFbGk1NWl2QTNOcWJBdDE2UFpCajc0RWVH?=
 =?utf-8?B?RXgvMEM4MEN2eU5nNXBJU3N1Z1FrTlZIbE54a3o5QkowSlZKWm5oWi9kUTJS?=
 =?utf-8?B?QlNod1dwSVMwNVdOOWZrZ3JGcWU0ajd5VHI5YmkzZEIzb1ExYmgrbUxoMFly?=
 =?utf-8?B?YjB4bEFMQzZYczZ6TFZoRXZNbTFBTEVRMWh1SWNZQ3poLzBobUZ1ekJndW5w?=
 =?utf-8?B?bVpFN0ZxeHI1N2UxemxabE9XTGtCL1dqTUtXVzQ0L3ZHbGg4NU0wbmpzZzVm?=
 =?utf-8?B?dVAvb0lINHdmREtjNkN6czFlQnR1TEo5TVlyY1AzKytvNWE3NUZ2OWJ1aGRF?=
 =?utf-8?B?N0RzUTBobHFJQ3JzNFY3ZTJkeUs4TDBLVmlEMzJYUEFZNVZ2ZDVBcXhBUlFi?=
 =?utf-8?B?bERmNU5TckZLUDhQZE9YM056NXJBUmkxZEtCdzVHbGxaVG5uRHVrdU5SNk1D?=
 =?utf-8?B?Z1d4cDBVazcvczR0dFpSYUZrOTZrNDJMTjhUY0NXWWxab29xU2wwKzZHSVdj?=
 =?utf-8?B?L2NEYktTb0QyZHdQTTBtR0hPYVlFclNWT2pyako1cFBvN3FzZEhZeWlYTlla?=
 =?utf-8?B?TGZUMCtzVEl1RHFSNk5hWGpyMEZkeEV3L1FjR2RLY2JDUklVblB0RUpKQnVQ?=
 =?utf-8?B?TzN1REpZWFEwZkhqZFRGeWJwZjRBb1MyRU1ZQ0dVb0pDR1R2VHRhS1NPaCtk?=
 =?utf-8?B?T0NTQU43eWJPWnBjS0hPVGthbld4d1U0eEpZczN1SmlkTzhHTkJMQk9hQ3NI?=
 =?utf-8?B?bmZoVjNBUzFxaTk4TkF1aHlUbW5vbnpWL0IvbWJtbDJmOXJjc3pLWlg5bC9I?=
 =?utf-8?B?dXp6NVlDNmZRU3VBSFJTU2tKOHhLS01nQW9CZTl3SUM3U2JxMTVYNDlkdllD?=
 =?utf-8?B?emRPRVo0bE1Ka290YTZUTEsvNHdXNnFhdjJQV3hvUi9kc3hsMjA3K1h0WVVx?=
 =?utf-8?B?STFOM2l4aDRGN0pvdUZ4RzBhamJRY1M5THR6YjFrUEhQakVkNGlMYzRHMSty?=
 =?utf-8?B?aDJ2ZEtWYjhDaERLWHo4M2UrK3R1WHZaZCtWclljcm1KS1NqSEVia2FXdTBL?=
 =?utf-8?B?NHVYTFZhY0NORlNxcVJHdlFoTnBvTkNQb2RFcFJ0YWM3RmpGQ0ZqeFpBZjEz?=
 =?utf-8?B?a3lUQk13ektOcGw5TmRwa2txMUQ1YjZPeVduVDBYeG1VUkN0RXo2YXNFMVNW?=
 =?utf-8?B?NzQrRjZuS1RmVTdRMHcxT21TczNrU3hBcENoU0ZVdHhtSXRUQUlVNUorQUpv?=
 =?utf-8?Q?l9k//XAj8n0u6qn3ADevb5MjF?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 799c5c79-8d49-4476-13c7-08de318ebad6
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7401.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 10:37:02.4937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BWY4x2K06qtse44nTrf4rDJ2ZeVNJ7vQ6TL/yAIxSGVo79wQLfFTFAbPaBkbn8FCaLeA/qAtDsRWJ4xA31JkJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5868

On 2025/12/2 3:58, Rafael J. Wysocki wrote:
> On Monday, December 1, 2025 7:47:46 PM CET Rafael J. Wysocki wrote:
>> On Mon, Dec 1, 2025 at 10:46 AM YangYang <yang.yang@vivo.com> wrote:
> 
> [cut]
> 
>> If blk_queue_enter() or __bio_queue_enter() is allowed to race with
>> disabling runtime PM for q->dev, failure to resume q->dev is alway
>> possible and there are no changes that can be made to
>> pm_runtime_disable() to prevent that from happening.  If
>> __pm_runtime_disable() wins the race, it will increment
>> power.disable_depth and rpm_resume() will bail out when it sees that
>> no matter what.
>>
>> You should not conflate "runtime PM doesn't work when it is disabled"
>> with "asynchronous runtime PM doesn't work after freezing the PM
>> workqueue".  They are both true, but they are not the same.
> 
> So I've been testing the patch below for a few days and it will eliminate
> the latter, but even after this patch runtime PM will be disabled in
> device_suspend_late() and if the problem you are facing is still there
> after this patch, it will need to dealt with at the driver level.
> 
> Generally speaking, driver involvement is needed to make runtime PM and
> system suspend/resume work together in the majority of cases.
> 

Thank you. I'll perform some tests with this patch applied.



