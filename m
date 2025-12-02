Return-Path: <linux-pm+bounces-39028-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DF9C99C8A
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 02:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C7F513445FE
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 01:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838131A262A;
	Tue,  2 Dec 2025 01:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WyYfw2NK"
X-Original-To: linux-pm@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012012.outbound.protection.outlook.com [52.101.43.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED42C1494C2;
	Tue,  2 Dec 2025 01:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764639518; cv=fail; b=Oyww80gLbekAeixl0ilFAehT7aMCJRPXbW4k9ZCVwuVaj9721UDOVWqVCT1txRRWDdVKxM0c+4TxH66Df8NFrxzDHa/frdbE+qWmwtMiMe6qyqwaXpElL0GVG8geo04OG+dR4MDRf0W56VaRSstG2n/6134UCczIBEvCppln0ho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764639518; c=relaxed/simple;
	bh=qBVFJBM40ieFL9CmmKdMIlRDjxglraecY1Z042IHKvM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rP4T9q1LKG+ccP/dOLh01qFqilamVF8KJ2hT0CgNqLWwot1ksolV4ZI6rtIqtIXBLCd8fmbjhAuquHwHEQzbY0RmGOWWM4TvOe1RG36UiZuK44glrEYEJW7Xoy937TnBcOUsVyV53Lnast61VXrp9F4ISF0td87XM+PNszpupUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WyYfw2NK; arc=fail smtp.client-ip=52.101.43.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OFnrbLLoGPeolE3axTgJuH/JyTgMKm1VaBrHkkkkTCdeg15MbcFObfgqb9OqvQOMVWYMNSDoyysQIt3wyQxOf4UkXehtUzIeoFoQP77XguUhwHHqwxnqxQDiRH32UvSH2xWvy9l52RHJym7VI/GcT9iJyv6nhCgxeric2R6RsAdwbxGW9fHxUNak4iRfzfOhkh0DIyzHgXnF7i6tLacRFzHWbHX5x6iqqZcigANkNBw5lr4wdYQetOuJ+O0dAFL9XW8sFY2gB8VChyhRb0JUlC7df1FP6rVdhe0wTWc3u+p55WCcPAnx3l6JFwYXSBedDZcKLu+srl8SBIQ+bx2BZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I0V6hjdOskXcgA8aSCN1EguLeb7I7oIDOEBHwA07nvc=;
 b=jxlnwfRWiFmM9Zv5kUdrY/n2N3aTc48qqUP90ZcRMP5H/TSiMGF3CuwwT/1I5J+DMSKUkvqysJaYDddm4b/ZhBY+CF7uhZT01QX+XNpNney22J+0mcKQTB1TPrP+htDsqXJzjsgLL9O0lEx5dbaEFup3dQHsU5pGE9ErArARg+Bx9WN4051dyXK2n6Pzgz523HaguM1536ASOcNsi7tr1AaL+eEgFGjxfeVxSDbUYgtXlBryLllY0cxsKNW+gYPc2Dm61PqEQs8ruF8vN30ah27DStJKryfda2XhltS/O2H7JtRF1FXhT/lJgd7ZQx9SZW+qlwCh7+DbcrfHttCwcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0V6hjdOskXcgA8aSCN1EguLeb7I7oIDOEBHwA07nvc=;
 b=WyYfw2NKU+GEpIoEprAGKWSj4gtD6iF6V5Lp5H8FNoL+Yn0ZQXaNn3viCPQdmxQ7QbzrLHNxLGocUDFDc3tpbT2lFjtgXjcMoxMa44OA6kr9uDeolmch+MpqHgEiCg/ztpTQajHrpY9tWbaww677kBedpPknJNwcGrVb1JsAvDqnPD1iWo/eYQn2x9759wl1G0zGbEGZT1X/SpIXQ6c18OLWfNuFnjKtQ5mK2U3fqJwsuAXxWU4x7ogbDMfxN5GWvYYQZBJPyBUDQgimZ4kpSZzDsegar8dGuYLqTj3WFJkR8OI4MdoIfZlUnzEBdaC68mRvtBnqXA2AcAElinn3/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 PH7PR12MB6420.namprd12.prod.outlook.com (2603:10b6:510:1fc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 01:38:34 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%7]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 01:38:34 +0000
Message-ID: <64d47186-d904-45c3-9471-9a06af4e94b5@nvidia.com>
Date: Mon, 1 Dec 2025 17:38:32 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] rust: build_assert: add instructions for use with
 function arguments
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Will Deacon <will@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, Joel Fernandes <joelagnelf@nvidia.com>
References: <20251128-io-build-assert-v2-0-a9ea9ce7d45d@nvidia.com>
 <20251128-io-build-assert-v2-1-a9ea9ce7d45d@nvidia.com>
 <db6a6b28-c0be-4bd8-a0b4-70431df7737a@nvidia.com>
 <CANiq72nGUuK9VTYJGob7pnXU5zuuCzqfw6fezAFpbqvte1sDFg@mail.gmail.com>
 <46b5eef7-2e8d-4801-93d0-6cea10f62dc9@nvidia.com>
 <CANiq72mhXajwj7HjiW_HQq9nO4o-HwBFUya3wjT8pRkWx3xjZw@mail.gmail.com>
 <7d157605-4c59-4e04-8c41-1f7a4c86b34c@nvidia.com>
 <CANiq72n0UkuAtW=2JZK9Y7TK4VO8rKsMSvpv52BsW5+C2z9Dew@mail.gmail.com>
 <ea455598-fc0e-4768-b540-5091f7ccd025@nvidia.com>
 <CANiq72kAnY2035vc2vvXDpUV-_vM=0W2_-mBts846jHo1ri3Yw@mail.gmail.com>
 <fccc4878-a205-45cf-b651-53c151e48d25@nvidia.com>
 <CANiq72kKsJz=SCjsTiPk=C=KWdJ_h2=A7AZsdEz_u0iemvuzJQ@mail.gmail.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CANiq72kKsJz=SCjsTiPk=C=KWdJ_h2=A7AZsdEz_u0iemvuzJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY1P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::15) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|PH7PR12MB6420:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b84443d-3894-4e9b-05f7-08de314381b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R2xpaHBSVzlPOXRrckRiTC9hZ056ZkhCRUdMUk9HaHc4SWp3WHBuUW12SDBW?=
 =?utf-8?B?REd6eXpjNHBBL05xRmNCNE12Wi9NVi9pUkxMODFSc1N2bEU5Y0QxR2lrWjhp?=
 =?utf-8?B?ZzVCajhGdWE2MWJRVU93MnNVODFMRyttdzhPVTc4VW1LTXlzV2Q1T0t3ejRB?=
 =?utf-8?B?UEpKOEMvMmw5NlhZZzZsdmNsN2JpSkZqNHNRZDJwM2VZM1JXY3VpM2N1bWVt?=
 =?utf-8?B?QjZxTXN0b1dTWkpYanV3MGJRakVtbjdOOUR3UjAweVdOYmJRdk5NTHZSN3hh?=
 =?utf-8?B?N2RkM1FxUWs1YzM0aW1JN3krVkMva2hIVi9IbjZKZjhneC9TMndpdFhIZ2p0?=
 =?utf-8?B?MEZGSFRFZWJmOFZEVHQ2S1hUalNJU0wrNHFta3NPbC9tVFdTZ1dxVHBUemlv?=
 =?utf-8?B?OEZOUitxVjhYRHJNTWZkZVlTR1h1NS9uTFhPYW9rMDM1dnhhK00yUDVBL05J?=
 =?utf-8?B?cnQwOWtsbU1QM0xGVzEvNHpBTFFZZGJIYXV4WnhHd0xMQkgzMVFHUjJ0eW9x?=
 =?utf-8?B?bU51RGg3K2JFOWhKcVIrWDM3YkRMMDhoQVRWRksxaHdTdlBwVWZrRjlnemgz?=
 =?utf-8?B?TXlLUDhuZFNnVUYzS0J3MmNNd2M5aGNMMy9aYnBhdktQQ0FGVlFvcWRMaFh5?=
 =?utf-8?B?M1NZYVVjNHZIeGg4TnRPOFBZK2lSNno3M3ByNTBFMWI4cE83R1pzMjUyZGNO?=
 =?utf-8?B?UFFUWWQ1OURHb29LSW01MTdUb0hRV20xUlhXc2wrc1BWOW43QWVVRk8xNUJX?=
 =?utf-8?B?b3V2UDVzQXpBa2JxWURoQU5GYkRQMGphakl2S25hZ0pnL0tIQ0ErUlY1Ukwy?=
 =?utf-8?B?aFZGamQ1elZzRkVQdUp3RHNvd1NkcnpkN0ZYa0FIR1VTazVjNkJxT0lWRjl1?=
 =?utf-8?B?cUZSMmJ2Rmp5ek40L0xkKzJCVWFMY2p2KzBhU01MNXFhSWlWME0zS0pHaGVW?=
 =?utf-8?B?TGFsN09UN29XWFVrZHVlR29PWExpT1kvbXVWYnhGL3N2SmsybHVwY3h1emk5?=
 =?utf-8?B?bnpsbEdoRk56ZnNpV2VhSVRIdFhJTDdPUjhxN3JmVVpiaDdQVGc3RUZqZUR3?=
 =?utf-8?B?SE1lTERneHBmK0V3VHR3WGhVVWJlc1FoWmJmOGtvT2Q1YWNrY2NxS2YxS09z?=
 =?utf-8?B?WlBKRzBlZEFVTVR1cFRCSThhYm9QTkhPak5lMHBYaWRQNmtjdGlFc2NvakN2?=
 =?utf-8?B?MlVFYnBoMlZKUzBoTjY2ZS9VR1lKTXBiWG9SMnd0cmpPRDdIM0FoWFVWN1Ri?=
 =?utf-8?B?Vk0yNHZKbUEwVENydk1CSk13cmpMUk11MVRBRDVGVGptUTdhWjluc0NmM25D?=
 =?utf-8?B?YmF1UndHa29TTCtnR0drTTYxSkpvZWtIOHJvM1k1d0dkZ0t1VmQ5SVpDT0hQ?=
 =?utf-8?B?VW9DbHlxbDZmOGR2eDhEYlhYdHlldWVWblVCQTB6ZzY0NndzUzMrT2ZjdFg2?=
 =?utf-8?B?TVdwV2M3YVhuZ0wyY1RnUUgxUnptd1JnTnlVN2x4MnJobWkzMytHZTc5SGNB?=
 =?utf-8?B?eSsvQUI2ZkRkVjRmS3B0TnBrYnJKM2tmTnIxaUJzSy9ZOE45eis1WTBsMktY?=
 =?utf-8?B?SDBFZjQ1em1YZmp6NlRwL3pVUnRMTlB3ekpZRUFnWXVoUm5ndHdpVDB2cXVx?=
 =?utf-8?B?dVU5N2FRWUhFRXppQysyM29YK1NSU1pyZWtYUGZmUXA1NXlYN2tmUFp2SFh2?=
 =?utf-8?B?cjdWRW9ETzA2aXUwdUR2WURxcFNILzkzU245cUNvV3pnMmZ0NUdZeFFvaWgr?=
 =?utf-8?B?TlpXVlBMUTlrN1cyanV5cVcyS3AxT1pyc0R6MDlYSjdKYXhzZnRmTzN4dHVS?=
 =?utf-8?B?b2VVRjcvbHd6aEg5VUJBRHUxY1dTMk1vZDhwK2Vtdm96VGdWR0xxVXdWWTZB?=
 =?utf-8?B?QzVsZ2VUdC9CNWtwSVdJVStuejFtbGdITlA5QThNOTcwRFlIS3NlWGtBUDFJ?=
 =?utf-8?Q?ltTKRIfSMi/gWK30Fl0xjW/ThMs8w26G?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR12MB9416.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkR6cHZiMVZIL1RYbnZydExYbzJSQzJWTWVkWlVxNjV1TkxYZ29mUStaaGFP?=
 =?utf-8?B?eWtuNU9NellRU2RDVEFISXJWTklhejRvNWFiTk9aK0lPVGVoNm1wUmE3WUtQ?=
 =?utf-8?B?NVErRGErYUlTeW00NDZBYlBSbVpyYjVkYXRGL1YvZFVBT1hhKy9qTk9HVUJu?=
 =?utf-8?B?OGxMRW9LYStadUV0SElmeTBIekw4TDdYSVFzQ2R0TzlsQS9QQXJEQnhkemJI?=
 =?utf-8?B?VWtLNEk0WXBDOW9wWEZtYmMvbU1wN0JhQVZkVjFhZVNxYlNKRXFZNmtYRUNR?=
 =?utf-8?B?Tm5pZWJTekh3OU9JNDZxNTdXUzdhQnI0K0MxS3I2V2RNaXpqWU02WnhaWnpB?=
 =?utf-8?B?Sk12d1RPZWF1L1IzME9tSUNhREhmUzdva2dNOHFaT3kydUxqakNXNzhHbWRK?=
 =?utf-8?B?VGVvbk1YM01mcGZNN2JLejdvWXk2MzNRT1N2MDdKZGRqZUdCaVdJVGlQUTNp?=
 =?utf-8?B?N2N3OFBnc0dUN29KQlczTlF4RGhDTktGMDlJaDJibHE0SUQwREFKRFhKbnA2?=
 =?utf-8?B?VWJyS0NrTVBWeXZ3cmFGSmV1L0xoNFpvNmpiKzNEWEFoVjRtVEUweW5MSCtn?=
 =?utf-8?B?dys3YWFJa1hFaGJ3V3k5Q2prRzJKaWlhdHBjaHJUbkhiTm1yZTVIdWZORlZE?=
 =?utf-8?B?WjVQc1lsOW5xZlVuZFVJWkhobSsxUElXYWVBRjNGZkNKUS9pWGtBbjBMMThX?=
 =?utf-8?B?ZENSTWc4cGdWaWlKR2toTTNYNnNYL1EvY2IvdmJzSXhRV1ZTRlhFazB0UlVh?=
 =?utf-8?B?WUtMNExaTGhvaFlERmc5SXo3bTBXQUhJT2ZIcEhib2lSZmNsVzkyMitodUtm?=
 =?utf-8?B?by9idGJsM2JBZ2QvMWUvWWJzV250ZjEyN0orY29ITFF3MDdYeGRReW4xVTN3?=
 =?utf-8?B?N256NnZSQ3diYXV4VWU2S2lUMngvelBaRWU5b0lORnVQOFhWNjAwL05LMzZO?=
 =?utf-8?B?MXRDKzRJaWJWQVl1dEl1dnBLZDkvaWpNSU9RYnNXUzlHZklhMlZBTjhKK09x?=
 =?utf-8?B?MWhFdWRwQk5sTUk2MlZaVmZrSWlGUkZJdlJBN1Y1b25UT0tjUVNGT1NMMTQ1?=
 =?utf-8?B?YjlWbC9EcHZxMkthZU84ZUpQWEQyRmRLZGhQb2l3bEJqZXVZVDBnY3ZQREI5?=
 =?utf-8?B?blF4NkVsajIzMFdhOVB4enkzMzRSWDI4N292T241L3d4dmp4alpPMmtTZkV1?=
 =?utf-8?B?NG54T0dkTHg4WUt0NXNpdTN5TEwzU1ZKWWNKZlU0dmhyQnJ3a3RrMjExWmlO?=
 =?utf-8?B?bTVURWdrMFJBYXhULzZWczc2b3d1bXB5MjB5S1BqQ0VLekx3VWhsYTAybUlm?=
 =?utf-8?B?RnBTK3RrZi83M0NYV29YSytqNDBYRU5sZG4vYTAwcHhmNWtjeVZpOUJXdmcx?=
 =?utf-8?B?ZzFVaStNSFN2QTBkbjBiZ1BUSVltN2o3N2Q2T2x5MlU2c2phTVlNR3A4RkJZ?=
 =?utf-8?B?SlgxVndiVTN2eU5xTnpQTEJjWTZadUhneHNrNzlzemphcE1VZGVuN2lQdndm?=
 =?utf-8?B?U0JSZ05MQjFYa1ZYM2dwUGhiZFBFcTFCaktjYTJUTkgyWmpnZDI2bU5oWXI3?=
 =?utf-8?B?VjVTdWNWTWJCdmUvWlJjeFFzMEJMNm55akppcDRJSVFZc1BGMk9YdUVhblYy?=
 =?utf-8?B?YUt5VkRpYThEOGR3WERMajArb3J0OGc0VFNaOWNEOUorN3Z4V3dQZXFERzJW?=
 =?utf-8?B?Qi9ESjB6YlpIZXRGUlBNcy9IRXdRNkdtRXk2c05GZ3ozdTVTOUtCcTVENU5x?=
 =?utf-8?B?SGtGaTJCU1lIS0ZBcnA2SlQ4QWhOdEp5Z1o2SDg2eHJ0a0k5c3pCOEVYUW9V?=
 =?utf-8?B?NDdsZEhteVpsZ3FSRVRIWmJFNlVnenRXVTB4ODNJVTBuOGx6MVZKeXVvdXFl?=
 =?utf-8?B?anFxNStlSWNkR0hBZm1NZGs3RFFNZVlBS2ZSc1A1bitxNm5VMVgvRDFWbmJQ?=
 =?utf-8?B?S3lFRTRMTldkSFVJdVBScko0OWp6Q2s1bUZMWjdDcFNJMExyL2xBR05kYjdJ?=
 =?utf-8?B?ZFU0YitEU0RBOHNranE0LzNLYXFLMjIyNVM1SzZwSUJyRGQ1clhadXFTT0Zp?=
 =?utf-8?B?YXNVdGxpVE8xVDBhZFNzZC9aLzg2cVhWM1pWcldVaWtKU0hZcktTVkw3aCtP?=
 =?utf-8?Q?kdWsX6vmYb2WqYYn16ZYSfGSA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b84443d-3894-4e9b-05f7-08de314381b2
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 01:38:34.3043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JS4w4HWl2E2/K0TOUkXy2oy05C0H7h+1IqjeZF8E9jspSCTA676lIRy0CEzvXmB8can1XocqMPWEU6/fuwHW1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6420

On 12/1/25 3:06 PM, Miguel Ojeda wrote:
> On Mon, Dec 1, 2025 at 8:31 PM John Hubbard <jhubbard@nvidia.com> wrote:
>>
>> Mainly just: is there a way to automatically "derive" (generate) an
>> always-inline directive for any function that attempts to call
>> build_assert!() on any of its arguments? And in fact, *force* the
>> always-inline, if it is not forced hard enough today.
>>
>> Something along those lines.
> 
> "Wide-scoped" macros can do passes like that, i.e. like some projects
> do to add extra syntax everywhere. Not sure we want to get into that
> world, though.
> 
> Instead, if we are just talking about checking, then I think we could
> have an attribute macro to mark such functions, and then
> `build_assert!` could fail "by default" unless inside one of those,
> and it would get rewritten into the proper form by the macro, so any
> call without it would fail. It is always nice to mark special
> functions anyway, just like our `export` one.
> 
> Otherwise, for more than just checking, I guess a custom tool like
> Klint could also do it for us (I am sure Gary has ideas here).
> 
>> I will bring this up (along with the KSYM_NAME_LEN hashed symbol project)
>> to our internal Rust groups. Both of these seem like nice, self-contained
>> projects that someone could really get into.
> 
> That is great -- thanks!

For the build_assert!() project, I didn't even get that far, because it
turns out that Joel Fernandes  (+Cc) is already working hard on this.

> 
> On related news, Antoni (Cc'd) told me yesterday that he noticed
> `inline(always)` was needed when using the GCC backend too, so this
> series will help him too.
> 
> Cheers,
> Miguel


thanks,
-- 
John Hubbard


