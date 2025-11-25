Return-Path: <linux-pm+bounces-38522-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C3454C833B4
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 04:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6FED934C01D
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 03:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9772F223DE5;
	Tue, 25 Nov 2025 03:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VwCDSMHA"
X-Original-To: linux-pm@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010009.outbound.protection.outlook.com [52.101.201.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE28E221FCC;
	Tue, 25 Nov 2025 03:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764041377; cv=fail; b=oEiNluIQJTPt80Ey71h+Uu3ji4XG6Cdc93qHErz29n4tPF/5FmeppvW09LzdPGdMeT+prNA2DO0evODAr3jQyQA7NOvUgdk62MI11JJLpIOE7P01RB+3fmoq4zZA+L54H3tMGrnakRKwc/OeQFS9J4Pwr6iVIb/lArFw395qVpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764041377; c=relaxed/simple;
	bh=esauUQz+zp8G4hekKAjqfH8ijYq5ayDldvLN7dHcI/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nA1jK7HvUgTse9CWDGYGGDe7jlbuO0gPDwlXc/sI9B9JmXwQTyNNOSYOaZSu+w3/1bkesoUnP011nd8hszBXmA9y9pfmqA6f58+cRBZ/FcYNo0yueBSijkzbnFF3P7IVAHpIq8xPlA5sNtLKlAu8flMEeEPUXUhvh9X++Ktxppc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VwCDSMHA; arc=fail smtp.client-ip=52.101.201.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h1IKAwCLPEZaGqXGUevQmajKj2Q8i1EVYIeNHb/pJmWKqd8grbavpiWOEx/eZ3renw3tK24ooXGTvQaKPnRE9I+Iz3w+Gj1oENRaMzK3o/ZLvxvTB1jBhPeHCl4W15+rny7POTTVCO0HkToJE+B7yhttwc2J1HmI66GiECWgy23xjAZ4k5tW7H5bxIUDyhzYS2z683mNFpM7WNgoU2w9p3jF9MGv7XWICclmIqsD4hXfgonN2LG1Wjoq0VAOu4FuQQgiCXZLQzfRv73TjQWWyjiVruUq3tuk0DX99LVThU2nHbJvy+rAAH7Mk4slFEWUpeCjzJRGFGyJ75KgGr+U1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vg18pHPYC976K6ciHjy1WCB2Oe/XucF75Sfx9em74EY=;
 b=WgF9XEj7GHFDuwFzfqiHSfBIwvjPsCyGbzLGv2eEPVb7jRCXufMxjxLKE2bgKIneh3iJkXyz0Nq0zf9bvSYtbClQoPBQ4ITb+Ha4NQMvkjb3arwS2TmQH6JQj/irSxOq0z8yuacDAj6KySJbTc+hKVLSNjCrQMAHNEXzfgZiTwDgXoT1eeDtNQ6ON32COfT9NFuIIt6KhfCXXdaNcUmD7BZx194MuMW91WrU6WSLG/4Blzf1xC8zuh2Ft9kK9kj8Fcb1H3H+y8WaBRkVCx+NTgFvgJBjc4K8xkxx7/CQmAPwq2bdRIbOCQIwUG9gEwggfYKrp8tDFVuFNcIPjqW5Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vg18pHPYC976K6ciHjy1WCB2Oe/XucF75Sfx9em74EY=;
 b=VwCDSMHAaMePye4e2UcoUH6riJmoEmpIgVilnONQgSuCAHJewu+eUr/7Lg8HFiQT9l/mUP27G0rHy22g1Y4Ynx5GrURtuybJfFFsAbNtF6L8kjPVac8kF+3mIXwBEPyO3Wwf9VqBj3V4IHUdistldTT9X4GAiFHows3bnOimYEn8Z+b+ISh6aOpGO/pqvLohZMerD8/kQwfkdVmDpHlEnRcbvai8r7yMOSVwFZmhkPpBtDm229nqnUSgQJHOWvWXha93spaucynK+qPA2cvn05pV7yQzat+JOtjr+AMDpXbSezxyW2uSu6V0cL/+L4H9MKU7RL9HMPQqtDbHv8VTYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DS7PR12MB5790.namprd12.prod.outlook.com (2603:10b6:8:75::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.18; Tue, 25 Nov
 2025 03:29:21 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::1f16:244a:2a9d:2c93]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::1f16:244a:2a9d:2c93%3]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 03:29:21 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding <treding@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Prashant Gaikwad <pgaikwad@nvidia.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Dmitry Osipenko <digetx@gmail.com>, MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 08/11] memory: tegra: Add Tegra114 EMC driver
Date: Tue, 25 Nov 2025 12:29:11 +0900
Message-ID: <6698349.AJdgDx1Vlc@senjougahara>
In-Reply-To:
 <CAPVz0n02T6L70gaKiyUqDWNKAfs9nyQBTEMXPbf4S5DSWBMDEw@mail.gmail.com>
References:
 <20250915080157.28195-1-clamor95@gmail.com> <6076984.k3LOHGUjKi@senjougahara>
 <CAPVz0n02T6L70gaKiyUqDWNKAfs9nyQBTEMXPbf4S5DSWBMDEw@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCP286CA0332.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::18) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DS7PR12MB5790:EE_
X-MS-Office365-Filtering-Correlation-Id: fb2944da-840a-4d16-4b08-08de2bd2d2e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MjU2L3JybkNqT0JHU0d3bkZDckZ4K0pLV2NvbVg1amRMQS9ZU01ubTdvaksx?=
 =?utf-8?B?dnlsOS9pMzJ1cEZQcFB6ZGE5ZWJNYlJKa21sd2hRZXFNYWNMSEluRzFRQ0Nw?=
 =?utf-8?B?d21vNU5LZ3VEV09MeGVCOEplbDZWRS9iODA5TWFtMmtTZ1JFSjA1dnZMWk44?=
 =?utf-8?B?aVFWM25SRzJPdWt3NUt6a3V6OHowNlBvQ1hLZFZZb1I1UDZWOVJ6REp0c2lT?=
 =?utf-8?B?amlSWkZsR3hXQjh0ZjBkYWY3cjZxamtQajQ1MmU1Y2VucDZtaTlUOFZxSllj?=
 =?utf-8?B?U05iakYxQ0dhZDdtRlhlWVFYQXJpb2RxejM5Q3VyR1Z6TG5ubUF1VHhSTFNG?=
 =?utf-8?B?anBwNW5YUmdBTlVjbmNZZ2UxZWJ6ZDUvcjFxNWNqdnlKU0RwTEhwRHU5TEtz?=
 =?utf-8?B?TVNKdzZkUTlZN0hNRmRVczMycFJDaFRZa2xQSjBiVCs3czA1NXdHRXQvNlp5?=
 =?utf-8?B?Z2Y3YlpZWG1DZGd6ci9ZRGdiMkQ4akdNWCtLK0lWcFcyQ1FpYmtqMUNKTXEr?=
 =?utf-8?B?ZDV3Y1NLTGVKbU9LcEMyVlFxb3FZMUZjcnc5ODlCRTJqWldEZ1VLVUV1SEJ5?=
 =?utf-8?B?MDhBRDVqSlBWU3FpR1QzbFdvc25BTzZNU0FRTytvNGQxaU4zVHNOT0lYWkNW?=
 =?utf-8?B?Nm9kYXYzVUx2TWJ6MnFFYnpVS040eFNzaW9pR1BXTnpBYkRYdEFQRUZHM0Zn?=
 =?utf-8?B?bGw4V1ZJZnk4dE9QR05sdkxFRzhQZ3ZtS3E4NkR4S3Y2OHo4bGFwbjB3Sjd0?=
 =?utf-8?B?enM1by9SMmluQzJwWTk0dEJUSGVlaXF6cElaMTlBZDV4Z09VNkhBMmFTcmYx?=
 =?utf-8?B?dTJuQ0ZmSlg5MXVhLzRpRWFBeGdYNnJQb0V5VG5SazU2d0dLdnh3dS81U2lS?=
 =?utf-8?B?RE9xZUUyVDJQYkl2NU5nUTg2VHhjZEgrV0dxdGViMlBDdGZydWVwMS8vOHFl?=
 =?utf-8?B?SjFBMWJrRHVjcDhmOStGd1JUTGZIRmJXc0N6Vlk0cHU1aURkQWJYS3FRSzBt?=
 =?utf-8?B?cDlsUGNmYVdNNitrbnlsVFpLcytNRHBiMnpJY015QXg3QUxlbVIzc0plTStX?=
 =?utf-8?B?TVRuRzJHa0dqdFZMTk1TSkZvL0JHcDBjZkU4U3U1emZTT2EzN2x0MDBHNlo5?=
 =?utf-8?B?aFVpNnFCMVJxdXY0QjI4L0FzbktUN2s1dmoreUJYbW01blBNbmV6cGhudlQ0?=
 =?utf-8?B?aS8yQjJCc0lXSERYTy9pZk5ONXR0WVE0d1RQNW9zSnZkVnRyME5qZisxY2hz?=
 =?utf-8?B?Mi9DZE1oRTNXS0p5clF5ZUpxKys0bzlPeWlNQkNMajUyekQzQzBRWnZ3YkM5?=
 =?utf-8?B?QlVEQXBVZWdqZWFQN3ZCaVQxSFNMR3BCNTRvY05VN0RKbWJGWEVtTkNDRjRz?=
 =?utf-8?B?eklTalVWOW9wV0pqTTYvOXdtbDJhMEJHREtBMkVEajVPamN2Ny9XSCtuVVJF?=
 =?utf-8?B?Q2R0UUJXUDJzR1hlUm1Kem0zMDdkZGN1Qk9obnNLdU0xNXhxNkI2Zmw1Nm9M?=
 =?utf-8?B?b1pwVHFURVhFeXVVVFIwb3JuVlRFQXJpcHpGZ0NBVnBmSjNwNTVFZ1JvQmUw?=
 =?utf-8?B?ZyttWCs1WlVNTVlVTUQzYnMzb0FVdnRRTEw2dE5BU01iVmlBMGZoV2hFTmx4?=
 =?utf-8?B?anpXQUdWK09pUUFqanl2MnBYT3VybEtBMWgrOUgrNXNYWHN6cjY4My9iSmpQ?=
 =?utf-8?B?dzJsdm9FRFNNbndWMmNlYkNyUHlvenA0UXpoRXU2c3JKL2xURmZoWFd4bWRI?=
 =?utf-8?B?RUIvT00vSzV0aThyUkNoOG9XS1Bxamt5VVFkVER1cWVKVzdzUzFmeGMwMmsz?=
 =?utf-8?B?RURHWTZlZS95UXQ3N2dETUpNZWE0bWIzZ3RQd3F1YXp6QVVoRVhZWER5OFpj?=
 =?utf-8?B?eWtzeU15RUtiYzFZVDFSQVdGQVE1M3Bja1hKRkpZUE1QZHpaK0lUWmkxdEd5?=
 =?utf-8?Q?t21UXF6OfqtEb8pJSQaUUue56jNzxZjW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YVJHNUVtUWV0WjFuRHhuZFpyQXNQSmNFVGhtTnVNM0k4ank1ZHpLSHVQd1lV?=
 =?utf-8?B?RG9PYUhmSDJRQUJYSWpmbm9qZmc5VHZvN05oRVd6RkYzOEtkMDNpRjlOK2lV?=
 =?utf-8?B?VlN0RFNFWTk4aFhMZEZjeHN3RXBqSmE5T1JyZFM0MXYxOHJIZTY4YVJ3WDlQ?=
 =?utf-8?B?MGIxT0Y3WnpGQkJhVWxub0VUMEdTWThPY1l2dmVSTGVRbXF2V0VnNmdtV0lQ?=
 =?utf-8?B?azdKVWJCbVV3eWtvdll2UTlEeUNZWkt0UUw5ekt1YWIzN24xQVJVUjZveHlJ?=
 =?utf-8?B?ak5wVE5iR20rUDdseC9rUVJJempjbG1rYlV5OWVNZzJaemRiNUpDeTVuMEds?=
 =?utf-8?B?R21IYjBYTW1kN2tmbXlxWkdzWEJnbit1SHhlWDJMOUVXTDVxRkhzOXBLWklT?=
 =?utf-8?B?MUt4UDZ6MFdqSzhCdWFwdVQrb2hvU2FJSi9wSUNWeGRLSnVJTDNPbjhZUkda?=
 =?utf-8?B?WXhQc0w2emJVOHNRR0FUV29PRHh1b3N3THpONXJpeU1Kam9pSm0yK1JpV2Rt?=
 =?utf-8?B?RjhhdGJ6alIxY2N1Z3hQNWt4ZTVxTkJNbzM0TnA0amxFQ0s1NzF2elM2djhG?=
 =?utf-8?B?cThHUmNhMm9rWmlIbzJvSHhuZ0pGSUNjYlM5WkNjT2pESTM1SWpEanExOExX?=
 =?utf-8?B?SXNxdGtjT0pESk1zNWNCaEpjcUhQOVA3Z1FraFo0QkVvK1FLR0RGR29RVFNq?=
 =?utf-8?B?bkZ6V21sdzRERWQ4dDJKTWxPd3oxaHBCVnJPVFNpb1dDNDNEZFdLNFRHL2Jv?=
 =?utf-8?B?WkVHSkNNMGlTZnlCTjN0SisySHlxdTVtMzl6NnNHZGQzdVMwd1RTbU53bVQ2?=
 =?utf-8?B?cU1DUkdmWWNFWmRXalVwRUR3UmdLOTRGSEtXUHF1Y1pCOGVXaGVKdEViVFdh?=
 =?utf-8?B?MUdZUUtKbm5yV0JDVG9rUk1vOUlJeVhCZU5LTE5CVGJqVTlTUXZaaFFMZEZm?=
 =?utf-8?B?L0JDYW9LSHFuRW5Id0lTWDI5RnoxWjRVa2N0ZDFRRXRpaXpJTVd2VnZGbUU1?=
 =?utf-8?B?Z3ZwLzcyRTFqd25BUWs0U2d0SGFWbkNnNVJRNDVLNkZmNnFqTW9oQi9Tb0g1?=
 =?utf-8?B?TmgrZ2RmYVp2aVJDdFBSbjZyRSs3akFtLzJsZHYwU2ptR2lUdU1HUG1hNlQ2?=
 =?utf-8?B?OGo3aGsvWDNkYUtnSnNBcUhZTjkxZkRsMDcwLzJhZlpKVHdwZXJWRmpUemhv?=
 =?utf-8?B?eHNJV0lVS054TGhENW5wQk9uUnZIQm8yVkpHN0VmMFg5RDVFYnpPNUhvM1Uw?=
 =?utf-8?B?SFpOb1BzRUlYMkRocTZ1MkZSclcreVlncktTMkhXSzVObG5qcjVEREtNampG?=
 =?utf-8?B?c2tFc291Y2J3Rk4xOWlidjJXcHBzeGJIVFBWNVNKVUhFVzFSNEIrcTJYRVFm?=
 =?utf-8?B?RHQweWlBanRhUnNISlFLajRJNUo0SFFKZEE0elVVK3VhZDIwcGIzRm9aNXdw?=
 =?utf-8?B?ZE1HdXl3K092SXI4ZE9xRjc3SEtIZkhXaUZ6YUZuYmZ6Um11NU5OUG1Udk1r?=
 =?utf-8?B?V01ndVJEekxtOFU0VzgzQVF5UU56M0xDM1pNK2RPeEpPUVZEOXNsVDFkbVJ0?=
 =?utf-8?B?YmczTldkUXRnRUE0R3Y0STZOTC9kYlpmWE1jWGZQMjJnc2RTUUM0cEZ4cFNH?=
 =?utf-8?B?T2FWa1ZhZzd1MXNUWGFtNXMzK3paWGVldkJ4UzhycU4zRlpNTXEwRTJ3MUZk?=
 =?utf-8?B?dkczbms2all1UzBRa1diQUtIN05WbTR1cmc3QWgzdzZPcUxlbW9ZeTkxbklx?=
 =?utf-8?B?dThjSmtzTHlGZzNlY3MxL29sMVdZejRGOU1ic0VQRmZwY1ZROU16TkFTQmhw?=
 =?utf-8?B?dDV2ekJaci9XMzU4UFVMT0c0eG9nVEdwd2kyVnVlcmpoRUJ3REJvSmk0Q0Jy?=
 =?utf-8?B?UC9qZFlBMmJEcnJpZDd4dkJCMk03ZndnTGx5M1VUOER5N2RXdTQ3OGxkVUN3?=
 =?utf-8?B?ZUtmZXZlWnFSclB0V3hyNkxkWDhtRjBEL3NwKzVHYWRkWlJOWWZiZUlmZHZy?=
 =?utf-8?B?Y0NPMXZDZGJIbzJCbS9GTzlJNURnekJNV2tnQmphMmtLUGlHUm9UVkY2YVpU?=
 =?utf-8?B?Y3VmL01ZS3ZFR1RVVUN0MXZwRmZRMC8yN2dkZ0txa1VZUE4zcXNBVTBneDlO?=
 =?utf-8?B?Q2plTVFONE92dnhKV0JWOEtJZk1HdEJPL2VXS2xOb3dhSnEyb2pQWmE1b3BW?=
 =?utf-8?B?ZzNtUmdBbmRBdFZxdmhqazVOakVXYzg5UEw1RnhPb0ptOUEzc2VJRTNXbElv?=
 =?utf-8?B?VFVDVnZka3N3bGt5ZmtVNUpGWnlRPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb2944da-840a-4d16-4b08-08de2bd2d2e0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 03:29:21.8267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s4FkaN0PvEK09TokQCXmzCHqaFICW2fuV3L2oVT+yx8gOA0APD8T6iFCtZsYerlvt0//fXULEcuXt5ZChAKFwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5790

On Friday, November 21, 2025 5:54=E2=80=AFPM Svyatoslav Ryhel wrote:
> =D0=BF=D1=82, 21 =D0=BB=D0=B8=D1=81=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 06=
:04 Mikko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Tuesday, November 18, 2025 5:05=E2=80=AFPM Svyatoslav Ryhel wrote:
> > > =D0=B2=D1=82, 18 =D0=BB=D0=B8=D1=81=D1=82. 2025=E2=80=AF=D1=80. =D0=
=BE 09:08 Mikko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > > >
> > > > On Monday, September 15, 2025 5:01=E2=80=AFPM Svyatoslav Ryhel wrot=
e:
> > > > > Introduce driver for the External Memory Controller (EMC) found i=
n Tegra114
> > > > > SoC. It controls the external DRAM on the board. The purpose of t=
his
> > > > > driver is to program memory timing for external memory on the EMC=
 clock
> > > > > rate change.
> > > > >
> > > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > > ---
> > > > >  drivers/memory/tegra/Kconfig        |   12 +
> > > > >  drivers/memory/tegra/Makefile       |    1 +
> > > > >  drivers/memory/tegra/tegra114-emc.c | 1487 +++++++++++++++++++++=
++++++
> > > > >  3 files changed, 1500 insertions(+)
> > > > >  create mode 100644 drivers/memory/tegra/tegra114-emc.c
> > > > >
> > > > > diff --git a/drivers/memory/tegra/Kconfig b/drivers/memory/tegra/=
Kconfig
> > > > > index fc5a27791826..11e7cc357d39 100644
> > > > > --- a/drivers/memory/tegra/Kconfig
> > > > > +++ b/drivers/memory/tegra/Kconfig
> > > > > @@ -35,6 +35,18 @@ config TEGRA30_EMC
> > > > >         This driver is required to change memory timings / clock =
rate for
> > > > >         external memory.
> > > > >
> > > > > +config TEGRA114_EMC
> > > > > +     tristate "NVIDIA Tegra114 External Memory Controller driver=
"
> > > > > +     default y
> > > > > +     depends on ARCH_TEGRA_114_SOC || COMPILE_TEST
> > > > > +     select TEGRA124_CLK_EMC if ARCH_TEGRA
> > > > > +     select PM_OPP
> > > > > +     help
> > > > > +       This driver is for the External Memory Controller (EMC) f=
ound on
> > > > > +       Tegra114 chips. The EMC controls the external DRAM on the=
 board.
> > > > > +       This driver is required to change memory timings / clock =
rate for
> > > > > +       external memory.
> > > > > +
> > > > >  config TEGRA124_EMC
> > > > >       tristate "NVIDIA Tegra124 External Memory Controller driver=
"
> > > > >       default ARCH_TEGRA_124_SOC
> > > > > diff --git a/drivers/memory/tegra/Makefile b/drivers/memory/tegra=
/Makefile
> > > > > index 0750847dac3c..d36be28efc4a 100644
> > > > > --- a/drivers/memory/tegra/Makefile
> > > > > +++ b/drivers/memory/tegra/Makefile
> > > > > @@ -15,6 +15,7 @@ obj-$(CONFIG_TEGRA_MC) +=3D tegra-mc.o
> > > > >
> > > > >  obj-$(CONFIG_TEGRA20_EMC)  +=3D tegra20-emc.o
> > > > >  obj-$(CONFIG_TEGRA30_EMC)  +=3D tegra30-emc.o
> > > > > +obj-$(CONFIG_TEGRA114_EMC) +=3D tegra114-emc.o
> > > > >  obj-$(CONFIG_TEGRA124_EMC) +=3D tegra124-emc.o
> > > > >  obj-$(CONFIG_TEGRA210_EMC_TABLE) +=3D tegra210-emc-table.o
> > > > >  obj-$(CONFIG_TEGRA210_EMC) +=3D tegra210-emc.o
> > > > > diff --git a/drivers/memory/tegra/tegra114-emc.c b/drivers/memory=
/tegra/tegra114-emc.c
> > > > > new file mode 100644
> > > > > index 000000000000..b986b5509f41
> > > > > --- /dev/null
> > > > > +++ b/drivers/memory/tegra/tegra114-emc.c
> > > > > @@ -0,0 +1,1487 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > > +/*
> > > > > + * Tegra114 External Memory Controller driver
> > > > > + *
> > > > > + * Based on downstream driver from NVIDIA and tegra124-emc.c
> > > > > + * Copyright (C) 2011-2014 NVIDIA Corporation
> > > > > + *
> > > > > + * Copyright (C) 2024 Svyatoslav Ryhel <clamor95@gmail.com>
> > > > > + */
> > > > > +
> > > > > +#include <linux/clk-provider.h>
> > > > > +#include <linux/clk.h>
> > > > > +#include <linux/clkdev.h>
> > > > > +#include <linux/clk/tegra.h>
> > > > > +#include <linux/debugfs.h>
> > > > > +#include <linux/delay.h>
> > > > > +#include <linux/interconnect-provider.h>
> > > > > +#include <linux/interrupt.h>
> > > > > +#include <linux/io.h>
> > > > > +#include <linux/module.h>
> > > > > +#include <linux/mutex.h>
> > > > > +#include <linux/of_address.h>
> > > > > +#include <linux/of_platform.h>
> > > > > +#include <linux/platform_device.h>
> > > > > +#include <linux/pm_opp.h>
> > > > > +#include <linux/sort.h>
> > > > > +#include <linux/string.h>
> > > > > +
> > > > > +#include <soc/tegra/fuse.h>
> > > > > +#include <soc/tegra/mc.h>
> > > > > +
> > > > > +#include "mc.h"
> > > > > +
> > > > > +#define EMC_INTSTATUS                                0x0
> > > > > +#define EMC_REFRESH_OVERFLOW_INT             BIT(3)
> > > > > +#define EMC_INTSTATUS_CLKCHANGE_COMPLETE     BIT(4)
> > > >
> > > > This naming is inconsistent. I'd prefer using EMC_INTSTATUS_REFRESH=
_OVERFLOW and EMC_INTSTATUS_CLKCHANGE_COMPLETE.
> > > >
> > > > > +
> > > > > +#define EMC_INTMASK                          0x4
> > > > > +
> > > > > +#define EMC_DBG                                      0x8
> > > > > +#define EMC_DBG_READ_MUX_ASSEMBLY            BIT(0)
> > > > > +#define EMC_DBG_WRITE_MUX_ACTIVE             BIT(1)
> > > > > +#define EMC_DBG_FORCE_UPDATE                 BIT(2)
> > > > > +#define EMC_DBG_CFG_PRIORITY                 BIT(24)
> > > > > +
> > > > > +#define EMC_CFG                                      0xc
> > > > > +#define EMC_CFG_DRAM_CLKSTOP_PD                      BIT(31)
> > > > > +#define EMC_CFG_DRAM_CLKSTOP_SR                      BIT(30)
> > > > > +#define EMC_CFG_DRAM_ACPD                    BIT(29)
> > > > > +#define EMC_CFG_DYN_SREF                     BIT(28)
> > > > > +#define EMC_CFG_PWR_MASK                     ((0xF << 28) | BIT(=
18))
> > > > > +#define EMC_CFG_DSR_VTTGEN_DRV_EN            BIT(18)
> > > >
> > > > Ordering from first to last register would be more consistent.
> > > >
> > > > > +
> > > > > +#define EMC_ADR_CFG                          0x10
> > > > > +#define EMC_ADR_CFG_EMEM_NUMDEV                      BIT(0)
> > > > > +
> > > > > +#define EMC_REFCTRL                          0x20
> > > > > +#define EMC_REFCTRL_DEV_SEL_SHIFT            0
> > > > > +#define EMC_REFCTRL_ENABLE                   BIT(31)
> > > > > +
> > > > > +#define EMC_TIMING_CONTROL                   0x28
> > > > > +#define EMC_RC                                       0x2c
> > > > > +#define EMC_RFC                                      0x30
> > > > > +#define EMC_RAS                                      0x34
> > > > > +#define EMC_RP                                       0x38
> > > > > +#define EMC_R2W                                      0x3c
> > > > > +#define EMC_W2R                                      0x40
> > > > > +#define EMC_R2P                                      0x44
> > > > > +#define EMC_W2P                                      0x48
> > > > > +#define EMC_RD_RCD                           0x4c
> > > > > +#define EMC_WR_RCD                           0x50
> > > > > +#define EMC_RRD                                      0x54
> > > > > +#define EMC_REXT                             0x58
> > > > > +#define EMC_WDV                                      0x5c
> > > > > +#define EMC_QUSE                             0x60
> > > > > +#define EMC_QRST                             0x64
> > > > > +#define EMC_QSAFE                            0x68
> > > > > +#define EMC_RDV                                      0x6c
> > > > > +#define EMC_REFRESH                          0x70
> > > > > +#define EMC_BURST_REFRESH_NUM                        0x74
> > > > > +#define EMC_PDEX2WR                          0x78
> > > > > +#define EMC_PDEX2RD                          0x7c
> > > > > +#define EMC_PCHG2PDEN                                0x80
> > > > > +#define EMC_ACT2PDEN                         0x84
> > > > > +#define EMC_AR2PDEN                          0x88
> > > > > +#define EMC_RW2PDEN                          0x8c
> > > > > +#define EMC_TXSR                             0x90
> > > > > +#define EMC_TCKE                             0x94
> > > > > +#define EMC_TFAW                             0x98
> > > > > +#define EMC_TRPAB                            0x9c
> > > > > +#define EMC_TCLKSTABLE                               0xa0
> > > > > +#define EMC_TCLKSTOP                         0xa4
> > > > > +#define EMC_TREFBW                           0xa8
> > > > > +#define EMC_QUSE_EXTRA                               0xac
> > > > > +#define EMC_ODT_WRITE                                0xb0
> > > > > +#define EMC_ODT_READ                         0xb4
> > > > > +#define EMC_WEXT                             0xb8
> > > > > +#define EMC_CTT                                      0xbc
> > > > > +#define EMC_RFC_SLR                          0xc0
> > > > > +#define EMC_MRS_WAIT_CNT2                    0xc4
> > > > > +
> > > > > +#define EMC_MRS_WAIT_CNT                     0xc8
> > > > > +#define EMC_MRS_WAIT_CNT_SHORT_WAIT_SHIFT    0
> > > > > +#define EMC_MRS_WAIT_CNT_SHORT_WAIT_MASK     \
> > > > > +     (0x3FF << EMC_MRS_WAIT_CNT_SHORT_WAIT_SHIFT)
> > > > > +#define EMC_MRS_WAIT_CNT_LONG_WAIT_SHIFT     16
> > > > > +#define EMC_MRS_WAIT_CNT_LONG_WAIT_MASK              \
> > > > > +     (0x3FF << EMC_MRS_WAIT_CNT_LONG_WAIT_SHIFT)
> > > > > +
> > > > > +#define EMC_MRS                                      0xcc
> > > > > +#define EMC_MODE_SET_DLL_RESET                       BIT(8)
> > > > > +#define EMC_MODE_SET_LONG_CNT                        BIT(26)
> > > > > +#define EMC_EMRS                             0xd0
> > > > > +#define EMC_REF                                      0xd4
> > > > > +#define EMC_PRE                                      0xd8
> > > > > +
> > > > > +#define EMC_SELF_REF                         0xe0
> > > > > +#define EMC_SELF_REF_CMD_ENABLED             BIT(0)
> > > > > +#define EMC_SELF_REF_DEV_SEL_SHIFT           30
> > > > > +
> > > > > +#define EMC_MRW                                      0xe8
> > > > > +
> > > > > +#define EMC_MRR                                      0xec
> > > > > +#define EMC_MRR_MA_SHIFT                     16
> > > > > +#define LPDDR2_MR4_TEMP_SHIFT                        0
> > > > > +
> > > > > +#define EMC_XM2DQSPADCTRL3                   0xf8
> > > > > +#define EMC_FBIO_SPARE                               0x100
> > > > > +
> > > > > +#define EMC_FBIO_CFG5                                0x104
> > > > > +#define      EMC_FBIO_CFG5_DRAM_TYPE_MASK            0x3
> > > > > +#define      EMC_FBIO_CFG5_DRAM_TYPE_SHIFT           0
> > > >
> > > > Inconsistent to indent here and not elsewhere. My preference is not=
 to indent.
> > > >
> > > > > +
> > > > > +#define EMC_FBIO_CFG6                                0x114
> > > > > +#define EMC_EMRS2                            0x12c
> > > > > +#define EMC_MRW2                             0x134
> > > > > +#define EMC_MRW4                             0x13c
> > > > > +#define EMC_EINPUT                           0x14c
> > > > > +#define EMC_EINPUT_DURATION                  0x150
> > > > > +#define EMC_PUTERM_EXTRA                     0x154
> > > > > +#define EMC_TCKESR                           0x158
> > > > > +#define EMC_TPD                                      0x15c
> > > > > +
> > > > > +#define EMC_AUTO_CAL_CONFIG                  0x2a4
> > > > > +#define EMC_AUTO_CAL_CONFIG_AUTO_CAL_START   BIT(31)
> > > > > +#define EMC_AUTO_CAL_INTERVAL                        0x2a8
> > > > > +#define EMC_AUTO_CAL_STATUS                  0x2ac
> > > > > +#define EMC_AUTO_CAL_STATUS_ACTIVE           BIT(31)
> > > > > +#define EMC_STATUS                           0x2b4
> > > > > +#define EMC_STATUS_TIMING_UPDATE_STALLED     BIT(23)
> > > > > +
> > > > > +#define EMC_CFG_2                            0x2b8
> > > > > +#define EMC_CLKCHANGE_REQ_ENABLE             BIT(0)
> > > > > +#define EMC_CLKCHANGE_PD_ENABLE                      BIT(1)
> > > > > +#define EMC_CLKCHANGE_SR_ENABLE                      BIT(2)
> > > >
> > > > Better to prefix with EMC_CFG_2
> > > >
> > > > > +
> > > > > +#define EMC_CFG_DIG_DLL                              0x2bc
> > > > > +#define EMC_CFG_DIG_DLL_PERIOD                       0x2c0
> > > > > +#define EMC_RDV_MASK                         0x2cc
> > > > > +#define EMC_WDV_MASK                         0x2d0
> > > > > +#define EMC_CTT_DURATION                     0x2d8
> > > > > +#define EMC_CTT_TERM_CTRL                    0x2dc
> > > > > +#define EMC_ZCAL_INTERVAL                    0x2e0
> > > > > +#define EMC_ZCAL_WAIT_CNT                    0x2e4
> > > > > +
> > > > > +#define EMC_ZQ_CAL                           0x2ec
> > > > > +#define EMC_ZQ_CAL_CMD                               BIT(0)
> > > > > +#define EMC_ZQ_CAL_LONG                              BIT(4)
> > > > > +#define EMC_ZQ_CAL_LONG_CMD_DEV0             \
> > > > > +     (DRAM_DEV_SEL_0 | EMC_ZQ_CAL_LONG | EMC_ZQ_CAL_CMD)
> > > > > +#define EMC_ZQ_CAL_LONG_CMD_DEV1             \
> > > > > +     (DRAM_DEV_SEL_1 | EMC_ZQ_CAL_LONG | EMC_ZQ_CAL_CMD)
> > > > > +
> > > > > +#define EMC_XM2CMDPADCTRL                    0x2f0
> > > > > +#define EMC_XM2DQSPADCTRL                    0x2f8
> > > > > +#define EMC_XM2DQSPADCTRL2                   0x2fc
> > > > > +#define EMC_XM2DQSPADCTRL2_RX_FT_REC_ENABLE  BIT(0)
> > > > > +#define EMC_XM2DQSPADCTRL2_VREF_ENABLE               BIT(5)
> > > > > +#define EMC_XM2DQPADCTRL                     0x300
> > > > > +#define EMC_XM2DQPADCTRL2                    0x304
> > > > > +#define EMC_XM2CLKPADCTRL                    0x308
> > > > > +#define EMC_XM2COMPPADCTRL                   0x30c
> > > > > +#define EMC_XM2VTTGENPADCTRL                 0x310
> > > > > +#define EMC_XM2VTTGENPADCTRL2                        0x314
> > > > > +#define EMC_XM2QUSEPADCTRL                   0x318
> > > > > +#define EMC_XM2DQSPADCTRL4                   0x320
> > > > > +#define EMC_DLL_XFORM_DQS0                   0x328
> > > > > +#define EMC_DLL_XFORM_DQS1                   0x32c
> > > > > +#define EMC_DLL_XFORM_DQS2                   0x330
> > > > > +#define EMC_DLL_XFORM_DQS3                   0x334
> > > > > +#define EMC_DLL_XFORM_DQS4                   0x338
> > > > > +#define EMC_DLL_XFORM_DQS5                   0x33c
> > > > > +#define EMC_DLL_XFORM_DQS6                   0x340
> > > > > +#define EMC_DLL_XFORM_DQS7                   0x344
> > > > > +#define EMC_DLL_XFORM_QUSE0                  0x348
> > > > > +#define EMC_DLL_XFORM_QUSE1                  0x34c
> > > > > +#define EMC_DLL_XFORM_QUSE2                  0x350
> > > > > +#define EMC_DLL_XFORM_QUSE3                  0x354
> > > > > +#define EMC_DLL_XFORM_QUSE4                  0x358
> > > > > +#define EMC_DLL_XFORM_QUSE5                  0x35c
> > > > > +#define EMC_DLL_XFORM_QUSE6                  0x360
> > > > > +#define EMC_DLL_XFORM_QUSE7                  0x364
> > > > > +#define EMC_DLL_XFORM_DQ0                    0x368
> > > > > +#define EMC_DLL_XFORM_DQ1                    0x36c
> > > > > +#define EMC_DLL_XFORM_DQ2                    0x370
> > > > > +#define EMC_DLL_XFORM_DQ3                    0x374
> > > > > +#define EMC_DLI_TRIM_TXDQS0                  0x3a8
> > > > > +#define EMC_DLI_TRIM_TXDQS1                  0x3ac
> > > > > +#define EMC_DLI_TRIM_TXDQS2                  0x3b0
> > > > > +#define EMC_DLI_TRIM_TXDQS3                  0x3b4
> > > > > +#define EMC_DLI_TRIM_TXDQS4                  0x3b8
> > > > > +#define EMC_DLI_TRIM_TXDQS5                  0x3bc
> > > > > +#define EMC_DLI_TRIM_TXDQS6                  0x3c0
> > > > > +#define EMC_DLI_TRIM_TXDQS7                  0x3c4
> > > > > +#define EMC_STALL_THEN_EXE_AFTER_CLKCHANGE   0x3cc
> > > > > +#define EMC_SEL_DPD_CTRL                     0x3d8
> > > > > +#define EMC_SEL_DPD_CTRL_DATA_SEL_DPD                BIT(8)
> > > > > +#define EMC_SEL_DPD_CTRL_ODT_SEL_DPD         BIT(5)
> > > > > +#define EMC_SEL_DPD_CTRL_RESET_SEL_DPD               BIT(4)
> > > > > +#define EMC_SEL_DPD_CTRL_CA_SEL_DPD          BIT(3)
> > > > > +#define EMC_SEL_DPD_CTRL_CLK_SEL_DPD         BIT(2)
> > > > > +#define EMC_SEL_DPD_CTRL_DDR3_MASK   \
> > > > > +     ((0xf << 2) | BIT(8))
> > > > > +#define EMC_SEL_DPD_CTRL_MASK \
> > > > > +     ((0x3 << 2) | BIT(5) | BIT(8))
> > > > > +#define EMC_PRE_REFRESH_REQ_CNT                      0x3dc
> > > > > +#define EMC_DYN_SELF_REF_CONTROL             0x3e0
> > > > > +#define EMC_TXSRDLL                          0x3e4
> > > > > +#define EMC_CCFIFO_ADDR                              0x3e8
> > > > > +#define EMC_CCFIFO_DATA                              0x3ec
> > > > > +#define EMC_CCFIFO_STATUS                    0x3f0
> > > > > +#define EMC_CDB_CNTL_1                               0x3f4
> > > > > +#define EMC_CDB_CNTL_2                               0x3f8
> > > > > +#define EMC_XM2CLKPADCTRL2                   0x3fc
> > > > > +#define EMC_AUTO_CAL_CONFIG2                 0x458
> > > > > +#define EMC_AUTO_CAL_CONFIG3                 0x45c
> > > > > +#define EMC_IBDLY                            0x468
> > > > > +#define EMC_DLL_XFORM_ADDR0                  0x46c
> > > > > +#define EMC_DLL_XFORM_ADDR1                  0x470
> > > > > +#define EMC_DLL_XFORM_ADDR2                  0x474
> > > > > +#define EMC_DSR_VTTGEN_DRV                   0x47c
> > > > > +#define EMC_TXDSRVTTGEN                              0x480
> > > > > +#define EMC_XM2CMDPADCTRL4                   0x484
> > > > > +
> > > > > +#define DRAM_DEV_SEL_ALL                     0
> > > > > +#define DRAM_DEV_SEL_0                               BIT(31)
> > > > > +#define DRAM_DEV_SEL_1                               BIT(30)
> > > > > +
> > > > > +#define EMC_CFG_POWER_FEATURES_MASK          \
> > > > > +     (EMC_CFG_DYN_SREF | EMC_CFG_DRAM_ACPD | EMC_CFG_DRAM_CLKSTO=
P_SR | \
> > > > > +     EMC_CFG_DRAM_CLKSTOP_PD | EMC_CFG_DSR_VTTGEN_DRV_EN)
> > > > > +#define EMC_REFCTRL_DEV_SEL(n) ((((n) > 1) ? 0 : 2) << EMC_REFCT=
RL_DEV_SEL_SHIFT)
> > > > > +#define EMC_DRAM_DEV_SEL(n) (((n) > 1) ? DRAM_DEV_SEL_ALL : DRAM=
_DEV_SEL_0)
> > > > > +
> > > > > +/* Maximum amount of time in us. to wait for changes to become e=
ffective */
> > > > > +#define EMC_STATUS_UPDATE_TIMEOUT            1000
> > > > > +
> > > > > +enum emc_dram_type {
> > > > > +     DRAM_TYPE_DDR3,
> > > > > +     DRAM_TYPE_DDR1,
> > > > > +     DRAM_TYPE_LPDDR2,
> > > > > +     DRAM_TYPE_DDR2
> > > > > +};
> > > > > +
> > > > > +enum emc_dll_change {
> > > > > +     DLL_CHANGE_NONE,
> > > > > +     DLL_CHANGE_ON,
> > > > > +     DLL_CHANGE_OFF
> > > > > +};
> > > > > +
> > > > > +static const unsigned long emc_burst_regs[] =3D {
> > > > > +     EMC_RC,
> > > > > +     EMC_RFC,
> > > > > +     EMC_RAS,
> > > > > +     EMC_RP,
> > > > > +     EMC_R2W,
> > > > > +     EMC_W2R,
> > > > > +     EMC_R2P,
> > > > > +     EMC_W2P,
> > > > > +     EMC_RD_RCD,
> > > > > +     EMC_WR_RCD,
> > > > > +     EMC_RRD,
> > > > > +     EMC_REXT,
> > > > > +     EMC_WEXT,
> > > > > +     EMC_WDV,
> > > > > +     EMC_WDV_MASK,
> > > > > +     EMC_QUSE,
> > > > > +     EMC_IBDLY,
> > > > > +     EMC_EINPUT,
> > > > > +     EMC_EINPUT_DURATION,
> > > > > +     EMC_PUTERM_EXTRA,
> > > > > +     EMC_CDB_CNTL_1,
> > > > > +     EMC_CDB_CNTL_2,
> > > > > +     EMC_QRST,
> > > > > +     EMC_QSAFE,
> > > > > +     EMC_RDV,
> > > > > +     EMC_RDV_MASK,
> > > > > +     EMC_REFRESH,
> > > > > +     EMC_BURST_REFRESH_NUM,
> > > > > +     EMC_PRE_REFRESH_REQ_CNT,
> > > > > +     EMC_PDEX2WR,
> > > > > +     EMC_PDEX2RD,
> > > > > +     EMC_PCHG2PDEN,
> > > > > +     EMC_ACT2PDEN,
> > > > > +     EMC_AR2PDEN,
> > > > > +     EMC_RW2PDEN,
> > > > > +     EMC_TXSR,
> > > > > +     EMC_TXSRDLL,
> > > > > +     EMC_TCKE,
> > > > > +     EMC_TCKESR,
> > > > > +     EMC_TPD,
> > > > > +     EMC_TFAW,
> > > > > +     EMC_TRPAB,
> > > > > +     EMC_TCLKSTABLE,
> > > > > +     EMC_TCLKSTOP,
> > > > > +     EMC_TREFBW,
> > > > > +     EMC_QUSE_EXTRA,
> > > > > +     EMC_FBIO_CFG6,
> > > > > +     EMC_ODT_WRITE,
> > > > > +     EMC_ODT_READ,
> > > > > +     EMC_FBIO_CFG5,
> > > > > +     EMC_CFG_DIG_DLL,
> > > > > +     EMC_CFG_DIG_DLL_PERIOD,
> > > > > +     EMC_DLL_XFORM_DQS0,
> > > > > +     EMC_DLL_XFORM_DQS1,
> > > > > +     EMC_DLL_XFORM_DQS2,
> > > > > +     EMC_DLL_XFORM_DQS3,
> > > > > +     EMC_DLL_XFORM_DQS4,
> > > > > +     EMC_DLL_XFORM_DQS5,
> > > > > +     EMC_DLL_XFORM_DQS6,
> > > > > +     EMC_DLL_XFORM_DQS7,
> > > > > +     EMC_DLL_XFORM_QUSE0,
> > > > > +     EMC_DLL_XFORM_QUSE1,
> > > > > +     EMC_DLL_XFORM_QUSE2,
> > > > > +     EMC_DLL_XFORM_QUSE3,
> > > > > +     EMC_DLL_XFORM_QUSE4,
> > > > > +     EMC_DLL_XFORM_QUSE5,
> > > > > +     EMC_DLL_XFORM_QUSE6,
> > > > > +     EMC_DLL_XFORM_QUSE7,
> > > > > +     EMC_DLI_TRIM_TXDQS0,
> > > > > +     EMC_DLI_TRIM_TXDQS1,
> > > > > +     EMC_DLI_TRIM_TXDQS2,
> > > > > +     EMC_DLI_TRIM_TXDQS3,
> > > > > +     EMC_DLI_TRIM_TXDQS4,
> > > > > +     EMC_DLI_TRIM_TXDQS5,
> > > > > +     EMC_DLI_TRIM_TXDQS6,
> > > > > +     EMC_DLI_TRIM_TXDQS7,
> > > > > +     EMC_DLL_XFORM_DQ0,
> > > > > +     EMC_DLL_XFORM_DQ1,
> > > > > +     EMC_DLL_XFORM_DQ2,
> > > > > +     EMC_DLL_XFORM_DQ3,
> > > > > +     EMC_XM2CMDPADCTRL,
> > > > > +     EMC_XM2CMDPADCTRL4,
> > > > > +     EMC_XM2DQPADCTRL2,
> > > > > +     EMC_XM2CLKPADCTRL,
> > > > > +     EMC_XM2COMPPADCTRL,
> > > > > +     EMC_XM2VTTGENPADCTRL,
> > > > > +     EMC_XM2VTTGENPADCTRL2,
> > > > > +     EMC_XM2DQSPADCTRL3,
> > > > > +     EMC_XM2DQSPADCTRL4,
> > > > > +     EMC_DSR_VTTGEN_DRV,
> > > > > +     EMC_TXDSRVTTGEN,
> > > > > +     EMC_FBIO_SPARE,
> > > > > +     EMC_ZCAL_WAIT_CNT,
> > > > > +     EMC_MRS_WAIT_CNT2,
> > > > > +     EMC_CTT,
> > > > > +     EMC_CTT_DURATION,
> > > > > +     EMC_DYN_SELF_REF_CONTROL,
> > > > > +};
> > > >
> > > > How was this list determined? It doesn't seem to match the trees I =
can find, or the list in the TRM (which is also different from the downstre=
am source code).
> > > >
> > >
> > > Hm, IIRC, I used Tegra114 3.4 kernel sources, specifically
> > > tegratab/macallan memory board files as my base and then tried to
> > > align them closer to list used by Tegra124 (not identical obviously
> > > since lists have different lengths). This list contains burst and
> > > trimmer registers with some of them excluded as a dedicated entries i=
n
> > > emc_timing structure below (yet again - similar to Tegra124). If you
> > > have any ideas how to group registers better I would be happy to hear=
.
> >
> > That sounds fine by me if we're programming all registers the downstrea=
m sequence is programming (except for ones not related to the DRAM configur=
ation like the latency allowance stuff that's better done otherwise). I was=
 just wondering.
> >
> > >
> > > > > +
> > > > > +struct emc_timing {
> > > > > +     unsigned long rate;
> > > > > +
> > > > > +     u32 emc_burst_data[ARRAY_SIZE(emc_burst_regs)];
> > > > > +
> > > > > +     u32 emc_auto_cal_config;
> > > > > +     u32 emc_auto_cal_config2;
> > > > > +     u32 emc_auto_cal_config3;
> > > > > +     u32 emc_auto_cal_interval;
> > > > > +     u32 emc_cfg;
> > > > > +     u32 emc_ctt_term_ctrl;
> > > > > +     u32 emc_mode_1;
> > > > > +     u32 emc_mode_2;
> > > > > +     u32 emc_mode_4;
> > > > > +     u32 emc_mode_reset;
> > > > > +     u32 emc_mrs_wait_cnt;
> > > > > +     u32 emc_sel_dpd_ctrl;
> > > > > +     u32 emc_xm2dqspadctrl2;
> > > > > +     u32 emc_zcal_cnt_long;
> > > > > +     u32 emc_zcal_interval;
> > > > > +};
> > > > > +
> > > > > +enum emc_rate_request_type {
> > > > > +     EMC_RATE_DEBUG,
> > > > > +     EMC_RATE_ICC,
> > > > > +     EMC_RATE_TYPE_MAX,
> > > > > +};
> > > > > +
> > > > > +struct emc_rate_request {
> > > > > +     unsigned long min_rate;
> > > > > +     unsigned long max_rate;
> > > > > +};
> > > > > +
> > > > > +struct tegra_emc {
> > > > > +     struct device *dev;
> > > > > +
> > > > > +     struct tegra_mc *mc;
> > > > > +
> > > > > +     void __iomem *regs;
> > > > > +
> > > > > +     unsigned int irq;
> > > > > +
> > > > > +     struct clk *clk;
> > > >
> > > > Nit: I don't think all the empty lines are needed.
> > > >
> > > > > +
> > > > > +     enum emc_dram_type dram_type;
> > > > > +     unsigned int dram_num;
> > > > > +
> > > > > +     struct emc_timing last_timing;
> > > > > +     struct emc_timing *timings;
> > > > > +     unsigned int num_timings;
> > > > > +
> > > > > +     struct {
> > > > > +             struct dentry *root;
> > > > > +             unsigned long min_rate;
> > > > > +             unsigned long max_rate;
> > > > > +     } debugfs;
> > > > > +
> > > > > +     struct icc_provider provider;
> > > > > +
> > > > > +     /*
> > > > > +      * There are multiple sources in the EMC driver which could=
 request
> > > > > +      * a min/max clock rate, these rates are contained in this =
array.
> > > > > +      */
> > > > > +     struct emc_rate_request requested_rate[EMC_RATE_TYPE_MAX];
> > > > > +
> > > > > +     /* protect shared rate-change code path */
> > > > > +     struct mutex rate_lock;
> > > > > +};
> > > > > +
> > > > > +static irqreturn_t tegra_emc_isr(int irq, void *data)
> > > > > +{
> > > > > +     struct tegra_emc *emc =3D data;
> > > > > +     u32 intmask =3D EMC_REFRESH_OVERFLOW_INT;
> > > > > +     u32 status;
> > > > > +
> > > > > +     status =3D readl_relaxed(emc->regs + EMC_INTSTATUS) & intma=
sk;
> > > > > +     if (!status)
> > > > > +             return IRQ_NONE;
> > > > > +
> > > > > +     /* notify about HW problem */
> > > > > +     if (status & EMC_REFRESH_OVERFLOW_INT)
> > > > > +             dev_err_ratelimited(emc->dev,
> > > > > +                                 "refresh request overflow timeo=
ut\n");
> > > > > +
> > > > > +     /* clear interrupts */
> > > > > +     writel_relaxed(status, emc->regs + EMC_INTSTATUS);
> > > > > +
> > > > > +     return IRQ_HANDLED;
> > > > > +}
> > > > > +
> > > > > +/* Timing change sequence functions */
> > > > > +
> > > > > +static void emc_ccfifo_writel(struct tegra_emc *emc, u32 value,
> > > > > +                           unsigned long offset)
> > > > > +{
> > > > > +     writel(value, emc->regs + EMC_CCFIFO_DATA);
> > > > > +     writel(offset, emc->regs + EMC_CCFIFO_ADDR);
> > > > > +}
> > > > > +
> > > > > +static void emc_seq_update_timing(struct tegra_emc *emc)
> > > > > +{
> > > > > +     unsigned int i;
> > > > > +     u32 value;
> > > > > +
> > > > > +     writel(1, emc->regs + EMC_TIMING_CONTROL);
> > > > > +
> > > > > +     for (i =3D 0; i < EMC_STATUS_UPDATE_TIMEOUT; ++i) {
> > > > > +             value =3D readl(emc->regs + EMC_STATUS);
> > > > > +             if ((value & EMC_STATUS_TIMING_UPDATE_STALLED) =3D=
=3D 0)
> > > > > +                     return;
> > > > > +             udelay(1);
> > > > > +     }
> > > >
> > > > This can be replaced with readl_poll_timeout_atomic
> > > >
> > > > > +
> > > > > +     dev_err(emc->dev, "timing update timed out\n");
> > > > > +}
> > > > > +
> > > > > +static void emc_seq_disable_auto_cal(struct tegra_emc *emc)
> > > > > +{
> > > > > +     unsigned int i;
> > > > > +     u32 value;
> > > > > +
> > > > > +     writel(0, emc->regs + EMC_AUTO_CAL_INTERVAL);
> > > > > +
> > > > > +     for (i =3D 0; i < EMC_STATUS_UPDATE_TIMEOUT; ++i) {
> > > > > +             value =3D readl(emc->regs + EMC_AUTO_CAL_STATUS);
> > > > > +             if ((value & EMC_AUTO_CAL_STATUS_ACTIVE) =3D=3D 0)
> > > > > +                     return;
> > > > > +             udelay(1);
> > > > > +     }
> > > >
> > > > Likewise
> > > >
> > > > > +
> > > > > +     dev_err(emc->dev, "auto cal disable timed out\n");
> > > > > +}
> > > > > +
> > > > > +static void emc_seq_wait_clkchange(struct tegra_emc *emc)
> > > > > +{
> > > > > +     unsigned int i;
> > > > > +     u32 value;
> > > > > +
> > > > > +     for (i =3D 0; i < EMC_STATUS_UPDATE_TIMEOUT; ++i) {
> > > > > +             value =3D readl(emc->regs + EMC_INTSTATUS);
> > > > > +             if (value & EMC_INTSTATUS_CLKCHANGE_COMPLETE)
> > > > > +                     return;
> > > > > +             udelay(1);
> > > > > +     }
> > > >
> > > > Likewise
> > > >
> > > > > +
> > > > > +     dev_err(emc->dev, "clock change timed out\n");
> > > > > +}
> > > > > +
> > > > > +static struct emc_timing *tegra_emc_find_timing(struct tegra_emc=
 *emc,
> > > > > +                                             unsigned long rate)
> > > > > +{
> > > > > +     struct emc_timing *timing =3D NULL;
> > > > > +     unsigned int i;
> > > > > +
> > > > > +     for (i =3D 0; i < emc->num_timings; i++) {
> > > > > +             if (emc->timings[i].rate =3D=3D rate) {
> > > > > +                     timing =3D &emc->timings[i];
> > > > > +                     break;
> > > > > +             }
> > > > > +     }
> > > > > +
> > > > > +     if (!timing) {
> > > > > +             dev_err(emc->dev, "no timing for rate %lu\n", rate)=
;
> > > > > +             return NULL;
> > > > > +     }
> > > > > +
> > > > > +     return timing;
> > > > > +}
> > > > > +
> > > > > +static int tegra_emc_prepare_timing_change(struct tegra_emc *emc=
,
> > > > > +                                        unsigned long rate)
> > > > > +{
> > > > > +     struct emc_timing *timing =3D tegra_emc_find_timing(emc, ra=
te);
> > > > > +     struct emc_timing *last =3D &emc->last_timing;
> > > > > +     enum emc_dll_change dll_change;
> > > > > +     unsigned int pre_wait =3D 0;
> > > > > +     u32 val, mask;
> > > > > +     bool update =3D false;
> > > > > +     unsigned int i;
> > > > > +
> > > > > +     if (!timing)
> > > > > +             return -ENOENT;
> > > > > +
> > > > > +     if ((last->emc_mode_1 & 0x1) =3D=3D (timing->emc_mode_1 & 0=
x1))
> > > > > +             dll_change =3D DLL_CHANGE_NONE;
> > > > > +     else if (timing->emc_mode_1 & 0x1)
> > > >
> > > > This looks incorrect. DLL is enabled if bit 0 is off. Now, I'm gues=
sing that comes from the other drivers, originally from tegra124-emc.c, whi=
ch was written by.. me :) I can send a patch for the other chips.
> > > >
> > >
> > > Noted
> > >
> > > > > +             dll_change =3D DLL_CHANGE_ON;
> > > > > +     else
> > > > > +             dll_change =3D DLL_CHANGE_OFF;
> > > > > +
> > > > > +     /* Clear CLKCHANGE_COMPLETE interrupts */
> > > > > +     writel(EMC_INTSTATUS_CLKCHANGE_COMPLETE, emc->regs + EMC_IN=
TSTATUS);
> > > > > +
> > > > > +     /* Disable dynamic self-refresh */
> > > > > +     val =3D readl(emc->regs + EMC_CFG);
> > > > > +     if (val & EMC_CFG_PWR_MASK) {
> > > >
> > > > This doesn't strictly match downstream Tegra114 EMC code or the TRM=
 -- it is the later sequence version for Tegra124. However, my hunch is tha=
t the Tegra124 sequence would be compatible and probably more reliable as i=
t would have received more testing. So it's probably not a bad idea to use =
it.
> > > >
> > > > There are other places in the sequence that have changed between ve=
rsions, but I don't think we need to change them. If issues are seen in the=
 future, we can check again.
> > > >
> > >
> > > It does not strictly match, yes, but overall logic is preserved. I
> > > have tested these on my Tegra114 devices and I did not observe any
> > > notable issues.
> > >
> >
> > Sounds good.
> >
> > > > > +             val &=3D ~EMC_CFG_POWER_FEATURES_MASK;
> > > > > +             writel(val, emc->regs + EMC_CFG);
> > > > > +
> > > > > +             pre_wait =3D 5;
> > > > > +     }
> > > > > +
> > > > > +     /* Disable SEL_DPD_CTRL for clock change */
> > > > > +     if (emc->dram_type =3D=3D DRAM_TYPE_DDR3)
> > > > > +             mask =3D EMC_SEL_DPD_CTRL_DDR3_MASK;
> > > > > +     else
> > > > > +             mask =3D EMC_SEL_DPD_CTRL_MASK;
> > > > > +
> > > > > +     val =3D readl(emc->regs + EMC_SEL_DPD_CTRL);
> > > > > +     if (val & mask) {
> > > > > +             val &=3D ~mask;
> > > > > +             writel(val, emc->regs + EMC_SEL_DPD_CTRL);
> > > > > +     }
> > > > > +
> > > > > +     /* Prepare DQ/DQS for clock change */
> > > > > +     val =3D readl(emc->regs + EMC_XM2DQSPADCTRL2);
> > > > > +     if (timing->emc_xm2dqspadctrl2 & EMC_XM2DQSPADCTRL2_VREF_EN=
ABLE &&
> > > > > +         !(val & EMC_XM2DQSPADCTRL2_VREF_ENABLE)) {
> > > > > +             val |=3D EMC_XM2DQSPADCTRL2_VREF_ENABLE;
> > > > > +             update =3D true;
> > > > > +     }
> > > > > +
> > > > > +     if (timing->emc_xm2dqspadctrl2 & EMC_XM2DQSPADCTRL2_RX_FT_R=
EC_ENABLE &&
> > > > > +         !(val & EMC_XM2DQSPADCTRL2_RX_FT_REC_ENABLE)) {
> > > > > +             val |=3D EMC_XM2DQSPADCTRL2_RX_FT_REC_ENABLE;
> > > > > +             update =3D true;
> > > > > +     }
> > > > > +
> > > > > +     if (update) {
> > > > > +             writel(val, emc->regs + EMC_XM2DQSPADCTRL2);
> > > > > +             if (pre_wait < 30)
> > > > > +                     pre_wait =3D 30;
> > > > > +     }
> > > > > +
> > > > > +     /* Wait to settle */
> > > > > +     if (pre_wait) {
> > > > > +             emc_seq_update_timing(emc);
> > > > > +             udelay(pre_wait);
> > > > > +     }
> > > > > +
> > > > > +     /* Program CTT_TERM control */
> > > > > +     if (last->emc_ctt_term_ctrl !=3D timing->emc_ctt_term_ctrl)=
 {
> > > > > +             emc_seq_disable_auto_cal(emc);
> > > > > +             writel(timing->emc_ctt_term_ctrl,
> > > > > +                    emc->regs + EMC_CTT_TERM_CTRL);
> > > > > +             emc_seq_update_timing(emc);
> > > > > +     }
> > > > > +
> > > > > +     /* Program burst shadow registers */
> > > > > +     for (i =3D 0; i < ARRAY_SIZE(timing->emc_burst_data); ++i)
> > > > > +             writel(timing->emc_burst_data[i],
> > > > > +                    emc->regs + emc_burst_regs[i]);
> > > > > +
> > > > > +     writel(timing->emc_xm2dqspadctrl2, emc->regs + EMC_XM2DQSPA=
DCTRL2);
> > > > > +     writel(timing->emc_zcal_interval, emc->regs + EMC_ZCAL_INTE=
RVAL);
> > > > > +
> > > > > +     tegra_mc_write_emem_configuration(emc->mc, timing->rate);
> > > > > +
> > > > > +     val =3D timing->emc_cfg & ~EMC_CFG_POWER_FEATURES_MASK;
> > > > > +     emc_ccfifo_writel(emc, val, EMC_CFG);
> > > > > +
> > > > > +     /* Program AUTO_CAL_CONFIG */
> > > > > +     if (timing->emc_auto_cal_config2 !=3D last->emc_auto_cal_co=
nfig2)
> > > > > +             emc_ccfifo_writel(emc, timing->emc_auto_cal_config2=
,
> > > > > +                               EMC_AUTO_CAL_CONFIG2);
> > > > > +
> > > > > +     if (timing->emc_auto_cal_config3 !=3D last->emc_auto_cal_co=
nfig3)
> > > > > +             emc_ccfifo_writel(emc, timing->emc_auto_cal_config3=
,
> > > > > +                               EMC_AUTO_CAL_CONFIG3);
> > > > > +
> > > > > +     if (timing->emc_auto_cal_config !=3D last->emc_auto_cal_con=
fig) {
> > > > > +             val =3D timing->emc_auto_cal_config;
> > > > > +             val &=3D EMC_AUTO_CAL_CONFIG_AUTO_CAL_START;
> > > > > +             emc_ccfifo_writel(emc, val, EMC_AUTO_CAL_CONFIG);
> > > > > +     }
> > > > > +
> > > > > +     /* DDR3: predict MRS long wait count */
> > > > > +     if (emc->dram_type =3D=3D DRAM_TYPE_DDR3 &&
> > > > > +         dll_change =3D=3D DLL_CHANGE_ON) {
> > > > > +             u32 cnt =3D 512;
> > > > > +
> > > > > +             if (timing->emc_zcal_interval !=3D 0 &&
> > > > > +                 last->emc_zcal_interval =3D=3D 0)
> > > > > +                     cnt -=3D emc->dram_num * 256;
> > > > > +
> > > > > +             val =3D (timing->emc_mrs_wait_cnt
> > > > > +                     & EMC_MRS_WAIT_CNT_SHORT_WAIT_MASK)
> > > > > +                     >> EMC_MRS_WAIT_CNT_SHORT_WAIT_SHIFT;
> > > > > +             if (cnt < val)
> > > > > +                     cnt =3D val;
> > > > > +
> > > > > +             val =3D timing->emc_mrs_wait_cnt
> > > > > +                     & ~EMC_MRS_WAIT_CNT_LONG_WAIT_MASK;
> > > > > +             val |=3D (cnt << EMC_MRS_WAIT_CNT_LONG_WAIT_SHIFT)
> > > > > +                     & EMC_MRS_WAIT_CNT_LONG_WAIT_MASK;
> > > > > +
> > > > > +             writel(val, emc->regs + EMC_MRS_WAIT_CNT);
> > > > > +     }
> > > > > +
> > > > > +     /* DDR3: Turn off DLL and enter self-refresh */
> > > > > +     if (emc->dram_type =3D=3D DRAM_TYPE_DDR3 && dll_change =3D=
=3D DLL_CHANGE_OFF)
> > > > > +             emc_ccfifo_writel(emc, timing->emc_mode_1, EMC_EMRS=
);
> > > > > +
> > > > > +     /* Disable refresh controller */
> > > > > +     emc_ccfifo_writel(emc, EMC_REFCTRL_DEV_SEL(emc->dram_num),
> > > > > +                       EMC_REFCTRL);
> > > > > +     if (emc->dram_type =3D=3D DRAM_TYPE_DDR3)
> > > > > +             emc_ccfifo_writel(emc, EMC_DRAM_DEV_SEL(emc->dram_n=
um) |
> > > > > +                                    EMC_SELF_REF_CMD_ENABLED,
> > > > > +                               EMC_SELF_REF);
> > > > > +
> > > > > +     /* Flow control marker */
> > > > > +     emc_ccfifo_writel(emc, 1, EMC_STALL_THEN_EXE_AFTER_CLKCHANG=
E);
> > > > > +
> > > > > +     /* DDR3: Exit self-refresh */
> > > > > +     if (emc->dram_type =3D=3D DRAM_TYPE_DDR3)
> > > > > +             emc_ccfifo_writel(emc, EMC_DRAM_DEV_SEL(emc->dram_n=
um),
> > > > > +                               EMC_SELF_REF);
> > > > > +     emc_ccfifo_writel(emc, EMC_REFCTRL_DEV_SEL(emc->dram_num) |
> > > > > +                            EMC_REFCTRL_ENABLE,
> > > > > +                       EMC_REFCTRL);
> > > > > +
> > > > > +     /* Set DRAM mode registers */
> > > > > +     if (emc->dram_type =3D=3D DRAM_TYPE_DDR3) {
> > > > > +             if (timing->emc_mode_1 !=3D last->emc_mode_1)
> > > > > +                     emc_ccfifo_writel(emc, timing->emc_mode_1, =
EMC_EMRS);
> > > > > +             if (timing->emc_mode_2 !=3D last->emc_mode_2)
> > > > > +                     emc_ccfifo_writel(emc, timing->emc_mode_2, =
EMC_EMRS2);
> > > > > +
> > > > > +             if (timing->emc_mode_reset !=3D last->emc_mode_rese=
t ||
> > > > > +                 dll_change =3D=3D DLL_CHANGE_ON) {
> > > > > +                     val =3D timing->emc_mode_reset;
> > > > > +                     if (dll_change =3D=3D DLL_CHANGE_ON) {
> > > > > +                             val |=3D EMC_MODE_SET_DLL_RESET;
> > > > > +                             val |=3D EMC_MODE_SET_LONG_CNT;
> > > > > +                     } else {
> > > > > +                             val &=3D ~EMC_MODE_SET_DLL_RESET;
> > > > > +                     }
> > > > > +                     emc_ccfifo_writel(emc, val, EMC_MRS);
> > > > > +             }
> > > > > +     } else {
> > > > > +             if (timing->emc_mode_2 !=3D last->emc_mode_2)
> > > > > +                     emc_ccfifo_writel(emc, timing->emc_mode_2, =
EMC_MRW2);
> > > > > +             if (timing->emc_mode_1 !=3D last->emc_mode_1)
> > > > > +                     emc_ccfifo_writel(emc, timing->emc_mode_1, =
EMC_MRW);
> > > > > +             if (timing->emc_mode_4 !=3D last->emc_mode_4)
> > > > > +                     emc_ccfifo_writel(emc, timing->emc_mode_4, =
EMC_MRW4);
> > > > > +     }
> > > > > +
> > > > > +     /*  Issue ZCAL command if turning ZCAL on */
> > > > > +     if (timing->emc_zcal_interval !=3D 0 && last->emc_zcal_inte=
rval =3D=3D 0) {
> > > > > +             emc_ccfifo_writel(emc, EMC_ZQ_CAL_LONG_CMD_DEV0, EM=
C_ZQ_CAL);
> > > > > +             if (emc->dram_num > 1)
> > > > > +                     emc_ccfifo_writel(emc, EMC_ZQ_CAL_LONG_CMD_=
DEV1,
> > > > > +                                       EMC_ZQ_CAL);
> > > > > +     }
> > > > > +
> > > > > +     /*  Write to RO register to remove stall after change */
> > > > > +     emc_ccfifo_writel(emc, 0, EMC_CCFIFO_STATUS);
> > > > > +
> > > > > +     /* Disable AUTO_CAL for clock change */
> > > > > +     emc_seq_disable_auto_cal(emc);
> > > > > +
> > > > > +     /* Read register to wait until programming has settled */
> > > > > +     mc_readl(emc->mc, MC_EMEM_ADR_CFG);
> > > > > +
> > > > > +     return 0;
> > > > > +}
> > > > > +
> > > > > +static void tegra_emc_complete_timing_change(struct tegra_emc *e=
mc,
> > > > > +                                          unsigned long rate)
> > > > > +{
> > > > > +     struct emc_timing *timing =3D tegra_emc_find_timing(emc, ra=
te);
> > > > > +     struct emc_timing *last =3D &emc->last_timing;
> > > > > +
> > > > > +     if (!timing)
> > > > > +             return;
> > > > > +
> > > > > +     /* Wait until the state machine has settled */
> > > > > +     emc_seq_wait_clkchange(emc);
> > > > > +
> > > > > +     /* Restore AUTO_CAL */
> > > > > +     if (timing->emc_ctt_term_ctrl !=3D last->emc_ctt_term_ctrl)
> > > > > +             writel(timing->emc_auto_cal_interval,
> > > > > +                    emc->regs + EMC_AUTO_CAL_INTERVAL);
> > > > > +
> > > > > +     /* Restore dynamic self-refresh */
> > > > > +     if (timing->emc_cfg & EMC_CFG_PWR_MASK)
> > > > > +             writel(timing->emc_cfg, emc->regs + EMC_CFG);
> > > > > +
> > > > > +     /* Set ZCAL wait count */
> > > > > +     writel(timing->emc_zcal_cnt_long, emc->regs + EMC_ZCAL_WAIT=
_CNT);
> > > > > +
> > > > > +     /* Wait for timing to settle */
> > > > > +     udelay(2);
> > > > > +
> > > > > +     /* Reprogram SEL_DPD_CTRL */
> > > > > +     writel(timing->emc_sel_dpd_ctrl, emc->regs + EMC_SEL_DPD_CT=
RL);
> > > > > +     emc_seq_update_timing(emc);
> > > > > +
> > > > > +     emc->last_timing =3D *timing;
> > > > > +}
> > > > > +
> > > > > +/* Initialization and deinitialization */
> > > > > +
> > > > > +static void emc_read_current_timing(struct tegra_emc *emc,
> > > > > +                                 struct emc_timing *timing)
> > > > > +{
> > > > > +     unsigned int i;
> > > > > +
> > > > > +     for (i =3D 0; i < ARRAY_SIZE(emc_burst_regs); ++i)
> > > > > +             timing->emc_burst_data[i] =3D
> > > > > +                     readl(emc->regs + emc_burst_regs[i]);
> > > > > +
> > > > > +     timing->emc_cfg =3D readl(emc->regs + EMC_CFG);
> > > > > +
> > > > > +     timing->emc_auto_cal_interval =3D 0;
> > > > > +     timing->emc_zcal_cnt_long =3D 0;
> > > > > +     timing->emc_mode_1 =3D 0;
> > > > > +     timing->emc_mode_2 =3D 0;
> > > > > +     timing->emc_mode_4 =3D 0;
> > > > > +     timing->emc_mode_reset =3D 0;
> > > >
> > > > Hmm. I wonder why these aren't being read. It seems like it would b=
e a good idea, since the some of these are checked for last_timing in the s=
equence.
> > > >
> > >
> > > This stems from Tegra124 emc driver, so maybe it has some sense. In
> > > any case, adding readl is not an issue whatsoever.
> > >
> >
> > Looks like they are set to zero in the downstream code as well, which s=
till doesn't make much sense, but it does seem to work. So leaving at zero =
should be fine.
> >
> > > > > +}
> > > > > +
> > > > > +static int emc_init(struct tegra_emc *emc)
> > > > > +{
> > > > > +     u32 emc_cfg, emc_dbg;
> > > > > +     u32 intmask =3D EMC_REFRESH_OVERFLOW_INT;
> > > > > +     const char *dram_type_str;
> > > > > +
> > > > > +     emc->dram_type =3D readl(emc->regs + EMC_FBIO_CFG5);
> > > > > +
> > > > > +     emc->dram_type &=3D EMC_FBIO_CFG5_DRAM_TYPE_MASK;
> > > > > +     emc->dram_type >>=3D EMC_FBIO_CFG5_DRAM_TYPE_SHIFT;
> > > > > +
> > > > > +     emc->dram_num =3D tegra_mc_get_emem_device_count(emc->mc);
> > > > > +
> > > > > +     emc_cfg =3D readl_relaxed(emc->regs + EMC_CFG_2);
> > > > > +
> > > > > +     /* enable EMC and CAR to handshake on PLL divider/source ch=
anges */
> > > > > +     emc_cfg |=3D EMC_CLKCHANGE_REQ_ENABLE;
> > > > > +
> > > > > +     /* configure clock change mode accordingly to DRAM type */
> > > > > +     switch (emc->dram_type) {
> > > > > +     case DRAM_TYPE_LPDDR2:
> > > > > +             emc_cfg |=3D EMC_CLKCHANGE_PD_ENABLE;
> > > > > +             emc_cfg &=3D ~EMC_CLKCHANGE_SR_ENABLE;
> > > > > +             break;
> > > > > +
> > > > > +     default:
> > > > > +             emc_cfg &=3D ~EMC_CLKCHANGE_SR_ENABLE;
> > > > > +             emc_cfg &=3D ~EMC_CLKCHANGE_PD_ENABLE;
> > > > > +             break;
> > > > > +     }
> > > >
> > > > This doesn't match the source trees I have (either Tegra114 or Tegr=
a124). Those don't touch EMC_CLKCHANGE_SR_ENABLE. TRM seems to be contradic=
tory about this. It says to leave it at reset value of DISABLED, but then l=
ater says that the reset value is ENABLED. I would err on the side of the c=
ode. In any case, I think this would be cleaner to write as an if statement
> > > >
> > > > emc_cfg |=3D EMC_CLKCHANGE_REQ_ENABLE;
> > > >
> > > > if (emc->dram_type =3D=3D DRAM_TYPE_LPDDR2)
> > > >         emc_cfg |=3D EMC_CLKCHANGE_PD_ENABLE;
> > > > else
> > > >         emc_cfg &=3D ~EMC_CLKCHANGE_PD_ENABLE;
> > > >
> > >
> > > Noted. Yes, TRM in Software programming sequence on the Tegra 4 clock
> > > change sequence states Keep these register fields in reset values:
> > > CLKCHANGE_REQ_ENABLE =3D ENABLED
> > > CLKCHANGE_SR_ENABLE =3D DISABLED
> > >
> > > Hence I have added emc_cfg &=3D ~EMC_CLKCHANGE_SR_ENABLE
> >
> > I think it might be worth checking what the reset value actually is (by=
 reading the register after boot). The register's section in the TRM has a =
different name for the field (REF_AFTER_SREF) and it says the reset value s=
hould be ENABLED, not DISABLED. The EMC_CFG_2 register is part of burst reg=
s for Tegra124, so I checked some EMC tables and it seems the bit is always=
 set for those tables; and for Tegra114 the code never changes the bit from=
 reset values. So I think the programming sequence section could be wrong (=
perhaps the register was changed after it was written but it was never upda=
ted).
> >
>=20
> I have read 0x7001b000 + 0x2b8 which is EMCB + EMC_CFG_2
>=20
> Both U-Boot coldboot and chainload result in this:
> (bootloader) 7001b2b8: 000008c5
>=20
> CLKCHANGE_REQ_ENABLE - ENABLED (Bit 0)
> CLKCHANGE_PD_ENABLE - DISABLED (Bit 1)
> REF_AFTER_SREF or CLKCHANGE_SR_ENABLE - ENABLED (Bit 2)
>=20
> TRM description of EMC_CFG_2_0 register seems to match behavior after boo=
t.
>=20
> So what should I do with CLKCHANGE_SR_ENABLE?

Thanks for checking. In that case I think safest to go with the downstream =
code's behavior of not modifying the value of REF_AFTER_SREF / CLKCHANGE_SR=
_ENABLE. Perhaps put in a comment explaining the discrepancy in the TRM.

>=20
> > >
> > > > > +
> > > > > +     writel_relaxed(emc_cfg, emc->regs + EMC_CFG_2);
> > > > > +
> > > > > +     /* initialize interrupt */
> > > > > +     writel_relaxed(intmask, emc->regs + EMC_INTMASK);
> > > > > +     writel_relaxed(0xffffffff, emc->regs + EMC_INTSTATUS);
> > > > > +
> > > > > +     /* ensure that unwanted debug features are disabled */
> > > > > +     emc_dbg =3D readl_relaxed(emc->regs + EMC_DBG);
> > > > > +     emc_dbg |=3D EMC_DBG_CFG_PRIORITY;
> > > > > +     emc_dbg &=3D ~EMC_DBG_READ_MUX_ASSEMBLY;
> > > > > +     emc_dbg &=3D ~EMC_DBG_WRITE_MUX_ACTIVE;
> > > > > +     emc_dbg &=3D ~EMC_DBG_FORCE_UPDATE;
> > > > > +     writel_relaxed(emc_dbg, emc->regs + EMC_DBG);
> > > > > +
> > > > > +     switch (emc->dram_type) {
> > > > > +     case DRAM_TYPE_DDR1:
> > > > > +             dram_type_str =3D "DDR1";
> > > > > +             break;
> > > > > +     case DRAM_TYPE_LPDDR2:
> > > > > +             dram_type_str =3D "LPDDR2";
> > > > > +             break;
> > > > > +     case DRAM_TYPE_DDR2:
> > > > > +             dram_type_str =3D "DDR2";
> > > > > +             break;
> > > > > +     case DRAM_TYPE_DDR3:
> > > > > +             dram_type_str =3D "DDR3";
> > > > > +             break;
> > > > > +     }
> > > > > +
> > > > > +     dev_info_once(emc->dev, "%u %s %s attached\n", emc->dram_nu=
m,
> > > > > +                   dram_type_str, emc->dram_num =3D=3D 2 ? "devi=
ces" : "device");
> > > > > +
> > > > > +     emc_read_current_timing(emc, &emc->last_timing);
> > > > > +
> > > > > +     return 0;
> > > > > +}
> > > > > +
> > > > > +static int load_one_timing_from_dt(struct tegra_emc *emc,
> > > > > +                                struct emc_timing *timing,
> > > > > +                                struct device_node *node)
> > > > > +{
> > > > > +     u32 value;
> > > > > +     int err;
> > > > > +
> > > > > +     err =3D of_property_read_u32(node, "clock-frequency", &valu=
e);
> > > > > +     if (err) {
> > > > > +             dev_err(emc->dev, "timing %pOFn: failed to read rat=
e: %d\n",
> > > > > +                     node, err);
> > > > > +             return err;
> > > > > +     }
> > > > > +
> > > > > +     timing->rate =3D value;
> > > > > +
> > > > > +     err =3D of_property_read_u32_array(node, "nvidia,emc-config=
uration",
> > > > > +                                      timing->emc_burst_data,
> > > > > +                                      ARRAY_SIZE(timing->emc_bur=
st_data));
> > > > > +     if (err) {
> > > > > +             dev_err(emc->dev,
> > > > > +                     "timing %pOFn: failed to read emc burst dat=
a: %d\n",
> > > > > +                     node, err);
> > > > > +             return err;
> > > > > +     }
> > > > > +
> > > > > +#define EMC_READ_PROP(prop, dtprop) { \
> > > > > +     err =3D of_property_read_u32(node, dtprop, &timing->prop); =
\
> > > > > +     if (err) { \
> > > > > +             dev_err(emc->dev, "timing %pOFn: failed to read " #=
prop ": %d\n", \
> > > > > +                     node, err); \
> > > > > +             return err; \
> > > > > +     } \
> > > > > +}
> > > > > +
> > > > > +     EMC_READ_PROP(emc_auto_cal_config, "nvidia,emc-auto-cal-con=
fig")
> > > > > +     EMC_READ_PROP(emc_auto_cal_config2, "nvidia,emc-auto-cal-co=
nfig2")
> > > > > +     EMC_READ_PROP(emc_auto_cal_config3, "nvidia,emc-auto-cal-co=
nfig3")
> > > > > +     EMC_READ_PROP(emc_auto_cal_interval, "nvidia,emc-auto-cal-i=
nterval")
> > > > > +     EMC_READ_PROP(emc_cfg, "nvidia,emc-cfg")
> > > > > +     EMC_READ_PROP(emc_ctt_term_ctrl, "nvidia,emc-ctt-term-ctrl"=
)
> > > > > +     EMC_READ_PROP(emc_mode_1, "nvidia,emc-mode-1")
> > > > > +     EMC_READ_PROP(emc_mode_2, "nvidia,emc-mode-2")
> > > > > +     EMC_READ_PROP(emc_mode_4, "nvidia,emc-mode-4")
> > > > > +     EMC_READ_PROP(emc_mode_reset, "nvidia,emc-mode-reset")
> > > > > +     EMC_READ_PROP(emc_mrs_wait_cnt, "nvidia,emc-mrs-wait-cnt")
> > > > > +     EMC_READ_PROP(emc_sel_dpd_ctrl, "nvidia,emc-sel-dpd-ctrl")
> > > > > +     EMC_READ_PROP(emc_xm2dqspadctrl2, "nvidia,emc-xm2dqspadctrl=
2")
> > > > > +     EMC_READ_PROP(emc_zcal_cnt_long, "nvidia,emc-zcal-cnt-long"=
)
> > > > > +     EMC_READ_PROP(emc_zcal_interval, "nvidia,emc-zcal-interval"=
)
> > > > > +
> > > > > +#undef EMC_READ_PROP
> > > > > +
> > > > > +     return 0;
> > > > > +}
> > > > > +
> > > > > +static int cmp_timings(const void *_a, const void *_b)
> > > > > +{
> > > > > +     const struct emc_timing *a =3D _a;
> > > > > +     const struct emc_timing *b =3D _b;
> > > > > +
> > > > > +     if (a->rate < b->rate)
> > > > > +             return -1;
> > > > > +     else if (a->rate =3D=3D b->rate)
> > > > > +             return 0;
> > > > > +     else
> > > > > +             return 1;
> > > > > +}
> > > > > +
> > > > > +static int tegra_emc_load_timings_from_dt(struct tegra_emc *emc,
> > > > > +                                       struct device_node *node)
> > > > > +{
> > > > > +     int child_count =3D of_get_child_count(node);
> > > > > +     struct device_node *child;
> > > > > +     struct emc_timing *timing;
> > > > > +     unsigned int i =3D 0;
> > > > > +     int err;
> > > > > +
> > > > > +     emc->timings =3D devm_kcalloc(emc->dev, child_count, sizeof=
(*timing),
> > > > > +                                 GFP_KERNEL);
> > > > > +     if (!emc->timings)
> > > > > +             return -ENOMEM;
> > > > > +
> > > > > +     emc->num_timings =3D child_count;
> > > > > +
> > > > > +     for_each_child_of_node(node, child) {
> > > > > +             timing =3D &emc->timings[i++];
> > > > > +
> > > > > +             err =3D load_one_timing_from_dt(emc, timing, child)=
;
> > > > > +             if (err) {
> > > > > +                     of_node_put(child);
> > > > > +                     return err;
> > > > > +             }
> > > > > +     }
> > > > > +
> > > > > +     sort(emc->timings, emc->num_timings, sizeof(*timing), cmp_t=
imings,
> > > > > +          NULL);
> > > > > +
> > > > > +     return 0;
> > > > > +}
> > > > > +
> > > > > +static struct device_node *
> > > > > +tegra_emc_find_node_by_ram_code(struct device_node *node, u32 ra=
m_code)
> > > > > +{
> > > > > +     struct device_node *np;
> > > > > +     int err;
> > > > > +
> > > > > +     for_each_child_of_node(node, np) {
> > > > > +             u32 value;
> > > > > +
> > > > > +             err =3D of_property_read_u32(np, "nvidia,ram-code",=
 &value);
> > > > > +             if (err || value !=3D ram_code)
> > > > > +                     continue;
> > > > > +
> > > > > +             return np;
> > > > > +     }
> > > > > +
> > > > > +     return NULL;
> > > > > +}
> > > > > +
> > > > > +static void tegra_emc_rate_requests_init(struct tegra_emc *emc)
> > > > > +{
> > > > > +     unsigned int i;
> > > > > +
> > > > > +     for (i =3D 0; i < EMC_RATE_TYPE_MAX; i++) {
> > > > > +             emc->requested_rate[i].min_rate =3D 0;
> > > > > +             emc->requested_rate[i].max_rate =3D ULONG_MAX;
> > > > > +     }
> > > > > +}
> > > > > +
> > > > > +static int emc_request_rate(struct tegra_emc *emc,
> > > > > +                         unsigned long new_min_rate,
> > > > > +                         unsigned long new_max_rate,
> > > > > +                         enum emc_rate_request_type type)
> > > > > +{
> > > > > +     struct emc_rate_request *req =3D emc->requested_rate;
> > > > > +     unsigned long min_rate =3D 0, max_rate =3D ULONG_MAX;
> > > > > +     unsigned int i;
> > > > > +     int err;
> > > > > +
> > > > > +     /* select minimum and maximum rates among the requested rat=
es */
> > > > > +     for (i =3D 0; i < EMC_RATE_TYPE_MAX; i++, req++) {
> > > > > +             if (i =3D=3D type) {
> > > > > +                     min_rate =3D max(new_min_rate, min_rate);
> > > > > +                     max_rate =3D min(new_max_rate, max_rate);
> > > > > +             } else {
> > > > > +                     min_rate =3D max(req->min_rate, min_rate);
> > > > > +                     max_rate =3D min(req->max_rate, max_rate);
> > > > > +             }
> > > > > +     }
> > > > > +
> > > > > +     if (min_rate > max_rate) {
> > > > > +             dev_err_ratelimited(emc->dev, "%s: type %u: out of =
range: %lu %lu\n",
> > > > > +                                 __func__, type, min_rate, max_r=
ate);
> > > > > +             return -ERANGE;
> > > > > +     }
> > > > > +
> > > > > +     /*
> > > > > +      * EMC rate-changes should go via OPP API because it manage=
s voltage
> > > > > +      * changes.
> > > > > +      */
> > > > > +     err =3D dev_pm_opp_set_rate(emc->dev, min_rate);
> > > > > +     if (err)
> > > > > +             return err;
> > > > > +
> > > > > +     emc->requested_rate[type].min_rate =3D new_min_rate;
> > > > > +     emc->requested_rate[type].max_rate =3D new_max_rate;
> > > > > +
> > > > > +     return 0;
> > > > > +}
> > > > > +
> > > > > +static int emc_set_min_rate(struct tegra_emc *emc, unsigned long=
 rate,
> > > > > +                         enum emc_rate_request_type type)
> > > > > +{
> > > > > +     struct emc_rate_request *req =3D &emc->requested_rate[type]=
;
> > > > > +     int ret;
> > > > > +
> > > > > +     mutex_lock(&emc->rate_lock);
> > > > > +     ret =3D emc_request_rate(emc, rate, req->max_rate, type);
> > > > > +     mutex_unlock(&emc->rate_lock);
> > > > > +
> > > > > +     return ret;
> > > > > +}
> > > > > +
> > > > > +static int emc_set_max_rate(struct tegra_emc *emc, unsigned long=
 rate,
> > > > > +                         enum emc_rate_request_type type)
> > > > > +{
> > > > > +     struct emc_rate_request *req =3D &emc->requested_rate[type]=
;
> > > > > +     int ret;
> > > > > +
> > > > > +     mutex_lock(&emc->rate_lock);
> > > > > +     ret =3D emc_request_rate(emc, req->min_rate, rate, type);
> > > > > +     mutex_unlock(&emc->rate_lock);
> > > > > +
> > > > > +     return ret;
> > > > > +}
> > > > > +
> > > > > +/*
> > > > > + * debugfs interface
> > > > > + *
> > > > > + * The memory controller driver exposes some files in debugfs th=
at can be used
> > > > > + * to control the EMC frequency. The top-level directory can be =
found here:
> > > > > + *
> > > > > + *   /sys/kernel/debug/emc
> > > > > + *
> > > > > + * It contains the following files:
> > > > > + *
> > > > > + *   - available_rates: This file contains a list of valid, spac=
e-separated
> > > > > + *     EMC frequencies.
> > > > > + *
> > > > > + *   - min_rate: Writing a value to this file sets the given fre=
quency as the
> > > > > + *       floor of the permitted range. If this is higher than th=
e currently
> > > > > + *       configured EMC frequency, this will cause the frequency=
 to be
> > > > > + *       increased so that it stays within the valid range.
> > > > > + *
> > > > > + *   - max_rate: Similarly to the min_rate file, writing a value=
 to this file
> > > > > + *       sets the given frequency as the ceiling of the permitte=
d range. If
> > > > > + *       the value is lower than the currently configured EMC fr=
equency, this
> > > > > + *       will cause the frequency to be decreased so that it sta=
ys within the
> > > > > + *       valid range.
> > > > > + */
> > > > > +
> > > > > +static bool tegra_emc_validate_rate(struct tegra_emc *emc, unsig=
ned long rate)
> > > > > +{
> > > > > +     unsigned int i;
> > > > > +
> > > > > +     for (i =3D 0; i < emc->num_timings; i++)
> > > > > +             if (rate =3D=3D emc->timings[i].rate)
> > > > > +                     return true;
> > > > > +
> > > > > +     return false;
> > > > > +}
> > > > > +
> > > > > +static int tegra_emc_debug_available_rates_show(struct seq_file =
*s,
> > > > > +                                             void *data)
> > > > > +{
> > > > > +     struct tegra_emc *emc =3D s->private;
> > > > > +     const char *prefix =3D "";
> > > > > +     unsigned int i;
> > > > > +
> > > > > +     for (i =3D 0; i < emc->num_timings; i++) {
> > > > > +             seq_printf(s, "%s%lu", prefix, emc->timings[i].rate=
);
> > > > > +             prefix =3D " ";
> > > > > +     }
> > > > > +
> > > > > +     seq_puts(s, "\n");
> > > > > +
> > > > > +     return 0;
> > > > > +}
> > > > > +
> > > > > +DEFINE_SHOW_ATTRIBUTE(tegra_emc_debug_available_rates);
> > > > > +
> > > > > +static int tegra_emc_debug_min_rate_get(void *data, u64 *rate)
> > > > > +{
> > > > > +     struct tegra_emc *emc =3D data;
> > > > > +
> > > > > +     *rate =3D emc->debugfs.min_rate;
> > > > > +
> > > > > +     return 0;
> > > > > +}
> > > > > +
> > > > > +static int tegra_emc_debug_min_rate_set(void *data, u64 rate)
> > > > > +{
> > > > > +     struct tegra_emc *emc =3D data;
> > > > > +     int err;
> > > > > +
> > > > > +     if (!tegra_emc_validate_rate(emc, rate))
> > > > > +             return -EINVAL;
> > > > > +
> > > > > +     err =3D emc_set_min_rate(emc, rate, EMC_RATE_DEBUG);
> > > > > +     if (err < 0)
> > > > > +             return err;
> > > > > +
> > > > > +     emc->debugfs.min_rate =3D rate;
> > > > > +
> > > > > +     return 0;
> > > > > +}
> > > > > +
> > > > > +DEFINE_DEBUGFS_ATTRIBUTE(tegra_emc_debug_min_rate_fops,
> > > > > +                      tegra_emc_debug_min_rate_get,
> > > > > +                      tegra_emc_debug_min_rate_set, "%llu\n");
> > > > > +
> > > > > +static int tegra_emc_debug_max_rate_get(void *data, u64 *rate)
> > > > > +{
> > > > > +     struct tegra_emc *emc =3D data;
> > > > > +
> > > > > +     *rate =3D emc->debugfs.max_rate;
> > > > > +
> > > > > +     return 0;
> > > > > +}
> > > > > +
> > > > > +static int tegra_emc_debug_max_rate_set(void *data, u64 rate)
> > > > > +{
> > > > > +     struct tegra_emc *emc =3D data;
> > > > > +     int err;
> > > > > +
> > > > > +     if (!tegra_emc_validate_rate(emc, rate))
> > > > > +             return -EINVAL;
> > > > > +
> > > > > +     err =3D emc_set_max_rate(emc, rate, EMC_RATE_DEBUG);
> > > > > +     if (err < 0)
> > > > > +             return err;
> > > > > +
> > > > > +     emc->debugfs.max_rate =3D rate;
> > > > > +
> > > > > +     return 0;
> > > > > +}
> > > > > +
> > > > > +DEFINE_DEBUGFS_ATTRIBUTE(tegra_emc_debug_max_rate_fops,
> > > > > +                      tegra_emc_debug_max_rate_get,
> > > > > +                      tegra_emc_debug_max_rate_set, "%llu\n");
> > > > > +
> > > > > +static void emc_debugfs_init(struct device *dev, struct tegra_em=
c *emc)
> > > > > +{
> > > > > +     unsigned int i;
> > > > > +     int err;
> > > > > +
> > > > > +     emc->debugfs.min_rate =3D ULONG_MAX;
> > > > > +     emc->debugfs.max_rate =3D 0;
> > > > > +
> > > > > +     for (i =3D 0; i < emc->num_timings; i++) {
> > > > > +             if (emc->timings[i].rate < emc->debugfs.min_rate)
> > > > > +                     emc->debugfs.min_rate =3D emc->timings[i].r=
ate;
> > > > > +
> > > > > +             if (emc->timings[i].rate > emc->debugfs.max_rate)
> > > > > +                     emc->debugfs.max_rate =3D emc->timings[i].r=
ate;
> > > > > +     }
> > > > > +
> > > > > +     if (!emc->num_timings) {
> > > > > +             emc->debugfs.min_rate =3D clk_get_rate(emc->clk);
> > > > > +             emc->debugfs.max_rate =3D emc->debugfs.min_rate;
> > > > > +     }
> > > > > +
> > > > > +     err =3D clk_set_rate_range(emc->clk, emc->debugfs.min_rate,
> > > > > +                              emc->debugfs.max_rate);
> > > > > +     if (err < 0) {
> > > > > +             dev_err(dev, "failed to set rate range [%lu-%lu] fo=
r %pC\n",
> > > > > +                     emc->debugfs.min_rate, emc->debugfs.max_rat=
e,
> > > > > +                     emc->clk);
> > > > > +             return;
> > > > > +     }
> > > > > +
> > > > > +     emc->debugfs.root =3D debugfs_create_dir("emc", NULL);
> > > > > +
> > > > > +     debugfs_create_file("available_rates", 0444, emc->debugfs.r=
oot, emc,
> > > > > +                         &tegra_emc_debug_available_rates_fops);
> > > > > +     debugfs_create_file("min_rate", 0644, emc->debugfs.root,
> > > > > +                         emc, &tegra_emc_debug_min_rate_fops);
> > > > > +     debugfs_create_file("max_rate", 0644, emc->debugfs.root,
> > > > > +                         emc, &tegra_emc_debug_max_rate_fops);
> > > > > +}
> > > > > +
> > > > > +static inline struct tegra_emc *
> > > > > +to_tegra_emc_provider(struct icc_provider *provider)
> > > > > +{
> > > > > +     return container_of(provider, struct tegra_emc, provider);
> > > > > +}
> > > > > +
> > > > > +static struct icc_node_data *
> > > > > +emc_of_icc_xlate_extended(const struct of_phandle_args *spec, vo=
id *data)
> > > > > +{
> > > > > +     struct icc_provider *provider =3D data;
> > > > > +     struct icc_node_data *ndata;
> > > > > +     struct icc_node *node;
> > > > > +
> > > > > +     /* External Memory is the only possible ICC route */
> > > > > +     list_for_each_entry(node, &provider->nodes, node_list) {
> > > > > +             if (node->id !=3D TEGRA_ICC_EMEM)
> > > > > +                     continue;
> > > > > +
> > > > > +             ndata =3D kzalloc(sizeof(*ndata), GFP_KERNEL);
> > > > > +             if (!ndata)
> > > > > +                     return ERR_PTR(-ENOMEM);
> > > > > +
> > > > > +             /*
> > > > > +              * SRC and DST nodes should have matching TAG in or=
der to have
> > > > > +              * it set by default for a requested path.
> > > > > +              */
> > > > > +             ndata->tag =3D TEGRA_MC_ICC_TAG_ISO;
> > > > > +             ndata->node =3D node;
> > > > > +
> > > > > +             return ndata;
> > > > > +     }
> > > > > +
> > > > > +     return ERR_PTR(-EPROBE_DEFER);
> > > > > +}
> > > > > +
> > > > > +static int emc_icc_set(struct icc_node *src, struct icc_node *ds=
t)
> > > > > +{
> > > > > +     struct tegra_emc *emc =3D to_tegra_emc_provider(dst->provid=
er);
> > > > > +     unsigned long long peak_bw =3D icc_units_to_bps(dst->peak_b=
w);
> > > > > +     unsigned long long avg_bw =3D icc_units_to_bps(dst->avg_bw)=
;
> > > > > +     unsigned long long rate =3D max(avg_bw, peak_bw);
> > > > > +     unsigned int dram_data_bus_width_bytes =3D 4;
> > > > > +     const unsigned int ddr =3D 2;
> > > > > +     int err;
> > > > > +
> > > > > +     /*
> > > > > +      * Tegra114 EMC runs on a clock rate of SDRAM bus. This mea=
ns that
> > > > > +      * EMC clock rate is twice smaller than the peak data rate =
because
> > > > > +      * data is sampled on both EMC clock edges.
> > > > > +      */
> > > > > +     do_div(rate, ddr * dram_data_bus_width_bytes);
> > > > > +     rate =3D min_t(u64, rate, U32_MAX);
> > > > > +
> > > > > +     err =3D emc_set_min_rate(emc, rate, EMC_RATE_ICC);
> > > > > +     if (err)
> > > > > +             return err;
> > > > > +
> > > > > +     return 0;
> > > > > +}
> > > > > +
> > > > > +static int tegra_emc_interconnect_init(struct tegra_emc *emc)
> > > > > +{
> > > > > +     const struct tegra_mc_soc *soc =3D emc->mc->soc;
> > > > > +     struct icc_node *node;
> > > > > +     int err;
> > > > > +
> > > > > +     emc->provider.dev =3D emc->dev;
> > > > > +     emc->provider.set =3D emc_icc_set;
> > > > > +     emc->provider.data =3D &emc->provider;
> > > > > +     emc->provider.aggregate =3D soc->icc_ops->aggregate;
> > > > > +     emc->provider.xlate_extended =3D emc_of_icc_xlate_extended;
> > > > > +
> > > > > +     icc_provider_init(&emc->provider);
> > > > > +
> > > > > +     /* create External Memory Controller node */
> > > > > +     node =3D icc_node_create(TEGRA_ICC_EMC);
> > > > > +     if (IS_ERR(node)) {
> > > > > +             err =3D PTR_ERR(node);
> > > > > +             goto err_msg;
> > > > > +     }
> > > > > +
> > > > > +     node->name =3D "External Memory Controller";
> > > > > +     icc_node_add(node, &emc->provider);
> > > > > +
> > > > > +     /* link External Memory Controller to External Memory (DRAM=
) */
> > > > > +     err =3D icc_link_create(node, TEGRA_ICC_EMEM);
> > > > > +     if (err)
> > > > > +             goto remove_nodes;
> > > > > +
> > > > > +     /* create External Memory node */
> > > > > +     node =3D icc_node_create(TEGRA_ICC_EMEM);
> > > > > +     if (IS_ERR(node)) {
> > > > > +             err =3D PTR_ERR(node);
> > > > > +             goto remove_nodes;
> > > > > +     }
> > > > > +
> > > > > +     node->name =3D "External Memory (DRAM)";
> > > > > +     icc_node_add(node, &emc->provider);
> > > > > +
> > > > > +     err =3D icc_provider_register(&emc->provider);
> > > > > +     if (err)
> > > > > +             goto remove_nodes;
> > > > > +
> > > > > +     return 0;
> > > > > +
> > > > > +remove_nodes:
> > > > > +     icc_nodes_remove(&emc->provider);
> > > > > +err_msg:
> > > > > +     dev_err(emc->dev, "failed to initialize ICC: %d\n", err);
> > > > > +
> > > > > +     return err;
> > > > > +}
> > > > > +
> > > > > +static int tegra_emc_opp_table_init(struct tegra_emc *emc)
> > >
> > > In v4 I will switch to devm_tegra_core_dev_init_opp_table used in
> > > tegra30 emc with required adjustments to it if you don't mind.
> >
> > Sounds good.
> >
> > >
> > > > > +{
> > > > > +     u32 hw_version =3D BIT(tegra_sku_info.soc_speedo_id);
> > > > > +     int opp_token, err;
> > > > > +
> > > > > +     err =3D dev_pm_opp_set_supported_hw(emc->dev, &hw_version, =
1);
> > > > > +     if (err < 0) {
> > > > > +             dev_err(emc->dev, "failed to set OPP supported HW: =
%d\n", err);
> > > > > +             return err;
> > > > > +     }
> > > > > +     opp_token =3D err;
> > > > > +
> > > > > +     err =3D dev_pm_opp_of_add_table(emc->dev);
> > > > > +     if (err) {
> > > > > +             if (err =3D=3D -ENODEV)
> > > > > +                     dev_err(emc->dev, "OPP table not found, ple=
ase update your device tree\n");
> > > > > +             else
> > > > > +                     dev_err(emc->dev, "failed to add OPP table:=
 %d\n", err);
> > > > > +
> > > > > +             goto put_hw_table;
> > > > > +     }
> > > > > +
> > > > > +     dev_info_once(emc->dev, "OPP HW ver. 0x%x, current clock ra=
te %lu MHz\n",
> > > > > +                   hw_version, clk_get_rate(emc->clk) / 1000000)=
;
> > > > > +
> > > > > +     /* first dummy rate-set initializes voltage state */
> > > > > +     err =3D dev_pm_opp_set_rate(emc->dev, clk_get_rate(emc->clk=
));
> > > > > +     if (err) {
> > > > > +             dev_err(emc->dev, "failed to initialize OPP clock: =
%d\n", err);
> > > > > +             goto remove_table;
> > > > > +     }
> > > > > +
> > > > > +     return 0;
> > > > > +
> > > > > +remove_table:
> > > > > +     dev_pm_opp_of_remove_table(emc->dev);
> > > > > +put_hw_table:
> > > > > +     dev_pm_opp_put_supported_hw(opp_token);
> > > > > +
> > > > > +     return err;
> > > > > +}
> > > > > +
> > > > > +static void devm_tegra_emc_unset_callback(void *data)
> > > > > +{
> > > > > +     tegra124_clk_set_emc_callbacks(NULL, NULL);
> > > > > +}
> > > > > +
> > > > > +static int tegra_emc_probe(struct platform_device *pdev)
> > > > > +{
> > > > > +     struct device_node *np;
> > > > > +     struct tegra_emc *emc;
> > > > > +     u32 ram_code;
> > > > > +     int err;
> > > > > +
> > > > > +     emc =3D devm_kzalloc(&pdev->dev, sizeof(*emc), GFP_KERNEL);
> > > > > +     if (!emc)
> > > > > +             return -ENOMEM;
> > > > > +
> > > > > +     mutex_init(&emc->rate_lock);
> > > > > +     emc->dev =3D &pdev->dev;
> > > > > +
> > > > > +     emc->regs =3D devm_platform_ioremap_resource(pdev, 0);
> > > > > +     if (IS_ERR(emc->regs))
> > > > > +             return PTR_ERR(emc->regs);
> > > > > +
> > > > > +     emc->mc =3D devm_tegra_memory_controller_get(&pdev->dev);
> > > > > +     if (IS_ERR(emc->mc))
> > > > > +             return PTR_ERR(emc->mc);
> > > > > +
> > > > > +     ram_code =3D tegra_read_ram_code();
> > > > > +
> > > > > +     np =3D tegra_emc_find_node_by_ram_code(pdev->dev.of_node, r=
am_code);
> > > > > +     if (np) {
> > > > > +             err =3D tegra_emc_load_timings_from_dt(emc, np);
> > > > > +             of_node_put(np);
> > > > > +             if (err)
> > > > > +                     return err;
> > > > > +     } else {
> > > > > +             dev_info_once(&pdev->dev,
> > > > > +                           "no memory timings for RAM code %u fo=
und in DT\n",
> > > > > +                           ram_code);
> > > > > +     }
> > > > > +
> > > > > +     err =3D emc_init(emc);
> > > > > +     if (err) {
> > > > > +             dev_err(&pdev->dev, "EMC initialization failed: %d\=
n", err);
> > > > > +             return err;
> > > > > +     }
> > > > > +
> > > > > +     platform_set_drvdata(pdev, emc);
> > > > > +
> > > > > +     tegra124_clk_set_emc_callbacks(tegra_emc_prepare_timing_cha=
nge,
> > > > > +                                    tegra_emc_complete_timing_ch=
ange);
> > > > > +
> > > > > +     err =3D devm_add_action_or_reset(&pdev->dev, devm_tegra_emc=
_unset_callback,
> > > > > +                                    NULL);
> > > > > +     if (err)
> > > > > +             return err;
> > > > > +
> > > > > +     err =3D platform_get_irq(pdev, 0);
> > > > > +     if (err < 0)
> > > > > +             return err;
> > > > > +
> > > > > +     emc->irq =3D err;
> > > > > +
> > > > > +     err =3D devm_request_irq(&pdev->dev, emc->irq, tegra_emc_is=
r, 0,
> > > > > +                            dev_name(&pdev->dev), emc);
> > > > > +     if (err) {
> > > > > +             dev_err(&pdev->dev, "failed to request irq: %d\n", =
err);
> > > > > +             return err;
> > > > > +     }
> > > > > +
> > > > > +     emc->clk =3D devm_clk_get(&pdev->dev, "emc");
> > > > > +     if (IS_ERR(emc->clk)) {
> > > > > +             err =3D PTR_ERR(emc->clk);
> > > > > +             dev_err(&pdev->dev, "failed to get EMC clock: %d\n"=
, err);
> > > > > +             return err;
> > > > > +     }
> > > > > +
> > > > > +     err =3D tegra_emc_opp_table_init(emc);
> > > > > +     if (err)
> > > > > +             return err;
> > > > > +
> > > > > +     tegra_emc_rate_requests_init(emc);
> > > > > +
> > > > > +     if (IS_ENABLED(CONFIG_DEBUG_FS))
> > > > > +             emc_debugfs_init(&pdev->dev, emc);
> > > > > +
> > > > > +     tegra_emc_interconnect_init(emc);
> > > > > +
> > > > > +     /*
> > > > > +      * Don't allow the kernel module to be unloaded. Unloading =
adds some
> > > > > +      * extra complexity which doesn't really worth the effort i=
n a case of
> > > > > +      * this driver.
> > > > > +      */
> > > > > +     try_module_get(THIS_MODULE);
> > > > > +
> > > > > +     return 0;
> > > > > +};
> > > > > +
> > > > > +static const struct of_device_id tegra_emc_of_match[] =3D {
> > > > > +     { .compatible =3D "nvidia,tegra114-emc" },
> > > > > +     {}
> > > > > +};
> > > > > +MODULE_DEVICE_TABLE(of, tegra_emc_of_match);
> > > > > +
> > > > > +static struct platform_driver tegra_emc_driver =3D {
> > > > > +     .probe =3D tegra_emc_probe,
> > > > > +     .driver =3D {
> > > > > +             .name =3D "tegra114-emc",
> > > > > +             .of_match_table =3D tegra_emc_of_match,
> > > > > +             .suppress_bind_attrs =3D true,
> > > > > +             .sync_state =3D icc_sync_state,
> > > > > +     },
> > > > > +};
> > > > > +module_platform_driver(tegra_emc_driver);
> > > > > +
> > > > > +MODULE_AUTHOR("Svyatoslav Ryhel <clamor95@gmail.com>");
> > > > > +MODULE_DESCRIPTION("NVIDIA Tegra114 EMC driver");
> > > > > +MODULE_LICENSE("GPL");
> > > > >
> > > >
> > > >
> > > >
> >
> >
> >
> >





