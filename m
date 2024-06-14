Return-Path: <linux-pm+bounces-9139-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B6E9081CE
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 04:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF2AE1C21540
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 02:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68410183099;
	Fri, 14 Jun 2024 02:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TlP9Ows3"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBA9183094;
	Fri, 14 Jun 2024 02:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718333003; cv=fail; b=mGIN54QJNMr7Fdu9u0OMUWqS9Q0tyWFo2voAP6ZB81RG5jqbdi7YCIr4Cb/vMDpF4PXqyxGmcMlD07oLeFahDal8OLzeLqiMq4XOqihOd/rZkfMBz+uIEiwKpCNwRnMRDq/G/5+WBqDyNMkEMKKsc8Gk8Yuh61IZlw71VsYm9e8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718333003; c=relaxed/simple;
	bh=gDjoK1OQ24W3bQluk4pVYkDv35W7SmWl0arbDwrfYo0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=me4OJGSqi93jgUMT3Ti84bEOf/YYp5xPRdD46a94xyx8UKJdxHCkgtzIXhat69xJCyarWP8TLLT6I+o0BTBLfUU6P0NcIf1vWKz7PaFQCbYxPLsHFofqnWMeb1E+N+DP+4ulrNCCfTaPV36ZU3AHNC/R1ZQSFOEOFUb/bLxbxLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TlP9Ows3; arc=fail smtp.client-ip=40.107.93.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EIBBCu45UNaPHqjKyZRjL6a0Y5zI8iiC1yrQg93z+QYP+EWekQGnF1XkNIKWcghPlE7BHWE99W1c75Fv1Ch1GCFwMjSkFXghM9Vqqxe7fLE8ZLQXtyoQfY4lkK1aAcnYEcaOwhDT4GYaF0gR7UASG/aqfn6e+BxqGSoF/lM0ehxvbgHia/BZE5h12U0Ay/bojJKqdVWOd3bhmV5lQ82On+pD+ybym1lI0f0RHaEF7y816i3gXOtlSR7yzI8bk1IukT/wnDtkveHbm1kQhmz/3jf7vwwjLzg/CYJBmsj7xaUJ4Z+bsYtZe4iPyzQ15MzXvLn14EXKFKK5HnEPPDyNkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gDjoK1OQ24W3bQluk4pVYkDv35W7SmWl0arbDwrfYo0=;
 b=TByb6V+QUIKSkq/ZoH4smY4njaQWCDhX2R8L89kWqmhCVl2mCUbb/gTjKNx3XPIg+SKvaS230UGhMP4NLDJ5bCzhnEWVSqIhoLZxIudk46EoGUWdi5lYePisvXkKGWdIgy3BS3Gdp/bQ46Z3OyDY9+mhCgIe4kb34FT0EPPKi52eLzRs9s4MjacPjeI1ZWdtn2TiAY8gpqa+JR2DNKoOqPD5NNoiGfA50Bq9FCyjPM4x+UDLabioX5Cz9oVyu7EMXcnSnl9sXz6QKoInDo8yDRtieVB1cJA7e2E5vcXWMrGD8uuYN5+rL0ZR+yh2M1/uYQtJHGRn6IUhwtdpzk/FCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDjoK1OQ24W3bQluk4pVYkDv35W7SmWl0arbDwrfYo0=;
 b=TlP9Ows3aVQalkMmls9wIyncv/eGmdYFa1tLhAFS1vreeOJJCE055YFeQ3gxLODJxSdzNLYpvcD2RSLTwvBbIYY/+esoT0xDp8j4oK6X/814YwQWWs/w7PY5qqYm7XppWnz9JaiG35Xtm8fAGT0LbwTz2FeG7jwhFVd3+MbTJFs=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by DM4PR12MB8497.namprd12.prod.outlook.com (2603:10b6:8:180::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 02:43:18 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf%6]) with mapi id 15.20.7633.037; Fri, 14 Jun 2024
 02:43:18 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>, "Shenoy, Gautham Ranjal"
	<gautham.shenoy@amd.com>, "Petkov, Borislav" <Borislav.Petkov@amd.com>
CC: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
	"viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "Deucher, Alexander"
	<Alexander.Deucher@amd.com>, "Huang, Shimmer" <Shimmer.Huang@amd.com>, "Du,
 Xiaojian" <Xiaojian.Du@amd.com>, "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v11 3/9] cpufreq: introduce init_boost callback to
 initialize boost state for pstate drivers
Thread-Topic: [PATCH v11 3/9] cpufreq: introduce init_boost callback to
 initialize boost state for pstate drivers
Thread-Index: AQHavWMB1NG+IowdL06z3LsAsb7zDrHF+vAAgACRwFA=
Date: Fri, 14 Jun 2024 02:43:18 +0000
Message-ID:
 <CYYPR12MB8655F6EF9F01A71A8A1288669CC22@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <cover.1718262992.git.perry.yuan@amd.com>
 <688d8e1ce875655c344ac3b29876da5dc0456739.1718262992.git.perry.yuan@amd.com>
 <cc26e5fd-ee67-4720-bc58-322fa1ed0329@amd.com>
In-Reply-To: <cc26e5fd-ee67-4720-bc58-322fa1ed0329@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=f34bc95f-8c0d-46cf-a411-9fa43c47eafe;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-14T02:37:00Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|DM4PR12MB8497:EE_
x-ms-office365-filtering-correlation-id: 576d1802-00cf-4590-febd-08dc8c1bbfad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230035|1800799019|366011|376009|38070700013;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZUMxV21sYzBNRmQ4Vy95eHZPQkFhN2xFMEw0YkdUTk1wOHc0UVZaalBlQTEv?=
 =?utf-8?B?ZW56Y2QvbE5hWDl1L1ZmWlh3c2NZOUhvelAzZjVOMlF3S2phc2JvL2JQTkM3?=
 =?utf-8?B?K3U3enFLMy9SSDJUVnVReThRWStPS3dVcFNPTjdVdXNwTERaaGU2SUtvNVdV?=
 =?utf-8?B?c1pMS2VrSGMxTHcxekNJVG1jcU9YaXd5YnJGV0JHVm1zdzhrV1BZdmRMV29l?=
 =?utf-8?B?UndQQWlqWXpKUXFIRDlBdVYrRGh0K0JnalZiWlRKZm5uQmw3UUVoOHdHeUw2?=
 =?utf-8?B?bkFlWklXQkZlTk12VllSZDN0NVBYVWFFK0NJZzhzdUdVaWtGSTRCaml6aXIx?=
 =?utf-8?B?VU5JR0JkaFZqNk1YMmhXbXdCT1k0c3hZdG51QS9VSjZlN1lVMlJ6d2F5dXB3?=
 =?utf-8?B?QitlQ0tCbFIzOTd4TzVIdW5LbVMwcXNRc0pHeUI4SnNpMHpZR0xNU2cwTVlG?=
 =?utf-8?B?ZzFTTWxndi9hc085U2wzcG96eVBNZHRoekcraHpmcm1RaWdvSGhCa29pYzRT?=
 =?utf-8?B?Yk1Pc2h0VXFmOERTQkNtclRpbDRsUCs3ekQvUFNDS09uMzE5Z1oxUGZJOXV2?=
 =?utf-8?B?dkFIcCsybWhKYTJsUUh2L1hXblQrWkJiVWRGbnZUR1p6cDhLV1RYNWRRdnBj?=
 =?utf-8?B?OEoxZTg2cDlORnk1OFpOT3F1WmVNa3p5eGxyMTF1elIwWUlnRE4xOSs4b3J6?=
 =?utf-8?B?T1NBSkpibVZZUWphOWJJS0xYQWVyNHNiWGh2dXBCdnRsMXh4NUI5QVdFWGlu?=
 =?utf-8?B?RE9PWXQ4dFd4S1MvTytFbk1sWUhoSVhHa0QycWQ3V25iSFlYM0dRUVVNRDlM?=
 =?utf-8?B?VEhnanlpeXJBcUhseEJONDM4TndxSzJsRlY4cHJjZnZOeHhUVTJIOWd6bzNO?=
 =?utf-8?B?ZDZaeldhZjAraTlaanJ0b21WSG1qTXJFWWdRQjNzRHU3clVaMlduK1doajJp?=
 =?utf-8?B?K3pXNEE4OEg3WE5KUUZqK05GV3VpTk9WRUM5TUdIeG51Y1d0WUpjaFl6NHJr?=
 =?utf-8?B?YU5yWWhLRlJ3M1R6cmJXUzhNSWlxK0pOakJtcXYzd1UxZmx5dHgwckdQTzdQ?=
 =?utf-8?B?emJHa3RlSG5INmZyK0xHTUNWY3pEdEdMbDJKN0M3Q0RVdHF5Q0JFOW1WTVBT?=
 =?utf-8?B?Q1ZTSS9Db1dGRWduSjJmU2ZmRklxTGp5b2pIYzdrTk1GNzdITzlOaEhqU0xR?=
 =?utf-8?B?UWFDejhYMGJhdFVJL2x5WU55L1lZQU9GQzQ4SDZVMk94S3dDS3F1NGY0Y21C?=
 =?utf-8?B?Uk9xemVHL29wL290OUw1RE5hRXBtN0J4d0RYY3VXbUI0dVBDM1h0Zm5HWVhF?=
 =?utf-8?B?ZTViOTRLT284M29XNzRLK21KV0RoM3RHV3RQNFhMS3EydjlLRXFJTHc2ZmVr?=
 =?utf-8?B?aXRWcC9sRHUrMWovZE9lYjlselNmMnRPeGlIMjNQSy9PUy9XVVJwR3c0NTJN?=
 =?utf-8?B?TUsxaWJSakxMZmZ3QUtDRlhwbkx1RytSdWxSdWZhUzVYcENwWmFoaWE4dTdK?=
 =?utf-8?B?QkhYMU84VXgwWTFkeXY3eU5OYmZpSm9iRUo0Q1VvQkNyWnBaMEdOd0dGeWt0?=
 =?utf-8?B?aGEyWHdNVko4RUJ1MkliQnlFS1Vqd09xYldZSlg2RVlrNDZrRVFWSC9ocFhJ?=
 =?utf-8?B?dlJ4d09BZG1vZUo0TFNkT2Z3Q3ZZRlpHU3pqcVpac0FEZ2tqeTVvUDZLb0dX?=
 =?utf-8?B?bWduVmF4NCs3UmZVK3BaRmpta3AvVjVOaXB5LzE0a3ZiajdqejRiaVFOWlJz?=
 =?utf-8?B?ZXJnZkVkLyttTVFaYnRqRkRscUR6M01jQzF1N2l3M1RzRXVydzQrNCtCcytQ?=
 =?utf-8?Q?Fo8zPlX8zYu07yvABfr8GS9TY430ORuudgr94=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(376009)(38070700013);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dm1yTkdGQVpwUFRGS21seVZqRnBuZW1aR0wwYm9LMCsxQUZQMmxhNSt3OVFF?=
 =?utf-8?B?VVpFcXBXY3JGL1NKOUZNQVdXb25yOE42cHJDYVIxaktFektqb0dYRGhTOEll?=
 =?utf-8?B?TU1GRVhsaUlZRnI3V3V4aFIycXhDZnNnVlhGVmtjZ1crK2lQOVh3SlRpODFQ?=
 =?utf-8?B?UnIxZTNmTDNCMm9ONHF6MzBIOGxvajJqZ01TRDBLd2x3QjFqak05Znh5KzlR?=
 =?utf-8?B?V096VitqTnB5TXh5ZTVNU0FlRC9XeUdMYjM4b0JIclZuWFRyR0RIUmNjU1dl?=
 =?utf-8?B?amw2ODZlNGxRQUtLelRCVUJzZWk0UE9lQjdaSEpoRjR4UlFkN0ZVR01rN25t?=
 =?utf-8?B?ai9DTlRTTDR0THhtaktZK0J1QlVlQmNMb1NGeU5vMXJFUHRmK21aSHFYM3BK?=
 =?utf-8?B?NjBuMVpiSFZNRTJiN2MwYndFRjErbmp4R2pqMkwva3M1STdOMXpzcWJ6YXNC?=
 =?utf-8?B?alU2ek1IS1pqUmRwZDcvT0N0VC9JMys4MDdPTGszZTUvazJHOFQrazBhaUwx?=
 =?utf-8?B?dXNPR1dWV3dyVkxuUzBzQTdZUEtFajZYekpiV2RZZGhMdjFaTGR4bmtMcUVE?=
 =?utf-8?B?Y2h4SVRjN0tvV05Dbmx3MGlPS1BuV2tGUWpOVCt0MHUxMDRyY2ZRL1NiWkFO?=
 =?utf-8?B?MUNFLy8yU3VSeUF1emFQeWR4WWlQVHpYRUVIMFJlQ2lCZGJYMWw1b1Fia0tn?=
 =?utf-8?B?YlFYWnk5M3ZIajVkOFpyL3V0aWFCWnpQVEZIcVhmdEVuMGVvYXdBYityT25J?=
 =?utf-8?B?ZXdxZ1dpWkphWFlaYk9YWU1pVUE5Q3NOeWVDWWE3REsvSXFEMFFYc3RKWGp6?=
 =?utf-8?B?MnFoazlOTDB3c3ZkUis2dUU3bnY4Tm4zUCtVSkIvYWdQVHFXOUtOWWI2RG10?=
 =?utf-8?B?UHlVMkptc2l2OXRMaUY4ZUQzZy96U3dsSjQ2Qm9UcmRJeU9nT3dQMnVjOHVY?=
 =?utf-8?B?VkdjVGxaUDJaZlJ2dWdFek5ZanVLcnJwL0Y3QmJueXVkaytTamErcnBSZGtR?=
 =?utf-8?B?OFpFejFQUUxHQzJhekFVYjJrdTZxVnFCbVZKcjdGdHUzYVpBTWR2VjRHZTE4?=
 =?utf-8?B?WTZjOFZhbFJDeGpUc0swUWl4WmVKL2RMdXJsbHZOaHJEZm5zK2hnNXhyWUw2?=
 =?utf-8?B?RFdaU25TODJid3ZYUk9FTjh1blZLWnEyZlVTM24zY2JqUVhqbE5hQzF2ajJx?=
 =?utf-8?B?bVBsRktZUjFaUUJDaHdrNkRDdko4Y3hhK2xrK0Nidzc1VUtHNmlDK0V0SUph?=
 =?utf-8?B?TEgvT0VtVUxFNXFwU1NXL1drN2xUVFh2aHlRSk54dEdTOXVIMVVJUjR1bksz?=
 =?utf-8?B?MXM2Sy9OcnVWM2I4QkpqRllBMU5qSmhZZ2JRM05RRVFjR3lSRWtMZ0MvcGxF?=
 =?utf-8?B?MkVlbE40NUZHbHZWelpScXg5alVqTnhjdVBISXl0L0p2cTh6TFd5UlVsejZJ?=
 =?utf-8?B?VkhKZENONUQ0WHNCc1Nqb2U2NXF4ZUJHVGdzSW45bG5JZ3p2RnZJMXkwaUNm?=
 =?utf-8?B?cFNZRjEwSlFqai9QbmFCeURUUzgyMCt5YkF0dnJnT1poUXB2ZlRlUlVEZE10?=
 =?utf-8?B?eENPS25aaVgxQnRyeG0vTngyTUZ4N1F2YzR0bk1IcStTYVc4L0tYMzl4Q0RY?=
 =?utf-8?B?UWp5cCtYbHZxV051emw5ZkU3SE1TdHBleDl5UnVvSWpXakZqVjZOamJYUzhP?=
 =?utf-8?B?Ry9NZnFmR1BrWWE4Y3FTU0lCODNmem95SlN3bll6azBVcXMwSXhhVTF1Wkdr?=
 =?utf-8?B?VUtRVktYQlZyL2Qra0s3QzFtOTlObnpSMlpETFgwbHdRT2k1MHU0cGdGSkw1?=
 =?utf-8?B?MzZaODZBZWljOVZWd25ReWxwaTZldVFsbithQWliQWNhaW1VNDdrYzQ2aE1l?=
 =?utf-8?B?a3JZM1pwMjlHeDJSeHBlK0xxaWRMQUVRVHFpeTNJdkMwV3BzM0wwYWdSL0hs?=
 =?utf-8?B?bjFDL3VQOHFOSE84WkpjOVVDdGxOUmtxR1ZFYnd4SndvTDBFc0Z1TVFCQ2Ey?=
 =?utf-8?B?U0t6UXR2eUgrQ1Evd1g5N1lJb3JtcU1kRFlsc21ld2FSaXdSNzBiNUdPNXoz?=
 =?utf-8?B?WUw2RXlFa3ZLZ2dMbFJ4U0VPR3ByRVNHL1JkQXIySCtJQ1pvM042eWliNVlY?=
 =?utf-8?Q?OCI4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8655.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 576d1802-00cf-4590-febd-08dc8c1bbfad
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2024 02:43:18.7542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CTizjFgD6N9R3ngOlGrkeYk/IWadVj2gOencp7a6n+LX5lI1qLaRrF6O9DuiOZDJXvguZ9apEPbau3jkP3x/WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8497

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMaW1vbmNpZWxsbywgTWFy
aW8gPE1hcmlvLkxpbW9uY2llbGxvQGFtZC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgSnVuZSAxNCwg
MjAyNCAxOjU1IEFNDQo+IFRvOiBZdWFuLCBQZXJyeSA8UGVycnkuWXVhbkBhbWQuY29tPjsgU2hl
bm95LCBHYXV0aGFtIFJhbmphbA0KPiA8Z2F1dGhhbS5zaGVub3lAYW1kLmNvbT47IFBldGtvdiwg
Qm9yaXNsYXYgPEJvcmlzbGF2LlBldGtvdkBhbWQuY29tPg0KPiBDYzogcmFmYWVsLmoud3lzb2Nr
aUBpbnRlbC5jb207IHZpcmVzaC5rdW1hckBsaW5hcm8ub3JnOyBEZXVjaGVyLCBBbGV4YW5kZXIN
Cj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBIdWFuZywgU2hpbW1lcg0KPiA8U2hpbW1l
ci5IdWFuZ0BhbWQuY29tPjsgRHUsIFhpYW9qaWFuIDxYaWFvamlhbi5EdUBhbWQuY29tPjsgTWVu
ZywNCj4gTGkgKEphc3NtaW5lKSA8TGkuTWVuZ0BhbWQuY29tPjsgbGludXgtcG1Admdlci5rZXJu
ZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIHYxMSAzLzldIGNwdWZyZXE6IGludHJvZHVjZSBpbml0X2Jvb3N0IGNhbGxiYWNrIHRv
DQo+IGluaXRpYWxpemUgYm9vc3Qgc3RhdGUgZm9yIHBzdGF0ZSBkcml2ZXJzDQo+DQo+IE9uIDYv
MTMvMjAyNCAwMjoyNSwgUGVycnkgWXVhbiB3cm90ZToNCj4gPiBJbnRyb2R1Y2UgYSBuZXcgaW5p
dF9ib29zdCBjYWxsYmFjayBpbiBjcHVmcmVxIHRvIGluaXRpYWxpemUgdGhlIGJvb3N0DQo+ID4g
c3RhdGUgZm9yIHNwZWNpZmljIHBzdGF0ZSBkcml2ZXJzLiBUaGlzIGluaXRpYWxpemF0aW9uIGlz
IHJlcXVpcmVkDQo+ID4gYmVmb3JlIGNhbGxpbmcgdGhlIHNldF9ib29zdCBpbnRlcmZhY2UgZm9y
IGVhY2ggQ1BVLg0KPiA+DQo+ID4gVGhlIGluaXRfYm9vc3QgY2FsbGJhY2sgd2lsbCBzZXQgdXAg
YW5kIHN5bmNocm9uaXplIGVhY2ggQ1BVJ3MgY3VycmVudA0KPiA+IGJvb3N0IHN0YXRlIGJlZm9y
ZSBpbnZva2luZyB0aGUgc2V0X2Jvb3N0IGZ1bmN0aW9uLiBXaXRob3V0IHRoaXMgc3RlcCwNCj4g
PiB0aGUgYm9vc3Qgc3RhdGUgbWF5IGJlIGluY29uc2lzdGVudCBhY3Jvc3MgQ1BVcy4NCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IFBlcnJ5IFl1YW4gPHBlcnJ5Lnl1YW5AYW1kLmNvbT4NCj4gPiAt
LS0NCj4gPiAgIGRyaXZlcnMvY3B1ZnJlcS9jcHVmcmVxLmMgfCAxMiArKysrKysrKysrLS0NCj4g
PiAgIGluY2x1ZGUvbGludXgvY3B1ZnJlcS5oICAgfCAgMiArKw0KPiA+ICAgMiBmaWxlcyBjaGFu
Z2VkLCAxMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvY3B1ZnJlcS9jcHVmcmVxLmMgYi9kcml2ZXJzL2NwdWZyZXEvY3B1ZnJlcS5j
DQo+ID4gaW5kZXggMWZkYWJiNjYwMjMxLi5lMWE0NzMwZjRmOGMgMTAwNjQ0DQo+ID4gLS0tIGEv
ZHJpdmVycy9jcHVmcmVxL2NwdWZyZXEuYw0KPiA+ICsrKyBiL2RyaXZlcnMvY3B1ZnJlcS9jcHVm
cmVxLmMNCj4gPiBAQCAtMTQyOSw4ICsxNDI5LDE2IEBAIHN0YXRpYyBpbnQgY3B1ZnJlcV9vbmxp
bmUodW5zaWduZWQgaW50IGNwdSkNCj4gPiAgICAgICAgICAgICAgICAgICAgIGdvdG8gb3V0X2Zy
ZWVfcG9saWN5Ow0KPiA+ICAgICAgICAgICAgIH0NCj4gPg0KPiA+IC0gICAgICAgICAgIC8qIExl
dCB0aGUgcGVyLXBvbGljeSBib29zdCBmbGFnIG1pcnJvciB0aGUgY3B1ZnJlcV9kcml2ZXINCj4g
Ym9vc3QgZHVyaW5nIGluaXQgKi8NCj4gPiAtICAgICAgICAgICBwb2xpY3ktPmJvb3N0X2VuYWJs
ZWQgPSBjcHVmcmVxX2Jvb3N0X2VuYWJsZWQoKSAmJg0KPiBwb2xpY3lfaGFzX2Jvb3N0X2ZyZXEo
cG9saWN5KTsNCj4gPiArICAgICAgICAgICAvKiBpbml0IGJvb3N0IHN0YXRlIHRvIHByZXBhcmUg
c2V0X2Jvb3N0IGNhbGxiYWNrIGZvciBlYWNoIENQVQ0KPiAqLw0KPiA+ICsgICAgICAgICAgIGlm
IChjcHVmcmVxX2RyaXZlci0+aW5pdF9ib29zdCkgew0KPiA+ICsgICAgICAgICAgICAgICAgICAg
cmV0ID0gY3B1ZnJlcV9kcml2ZXItPmluaXRfYm9vc3QocG9saWN5KTsNCj4gPiArICAgICAgICAg
ICAgICAgICAgIGlmIChyZXQpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgIHByX2Rl
YnVnKCIlczogJWQ6IGluaXRpYWxpemF0aW9uIGJvb3N0DQo+IGZhaWxlZFxuIiwgX19mdW5jX18s
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgX19MSU5FX18pOw0KPg0K
PiBUaGUgbWVzc2FnZSBzaG91bGQgaGF2ZSB0aGUgc3ViamVjdCBhdCB0aGUgYmVnaW5uaW5nLiAg
SUU6DQo+DQo+ICJib29zdCBpbml0aWFsaXphdGlvbiBmYWlsZWRcbiINCj4NCj4gQWxzbywgaXNu
J3QgdGhpcyBmYXRhbCBpZiBpbml0IGZhaWxlZD8gIElFIHNob3VsZG4ndCBmYWlsaW5nIGhhdmUg
YToNCg0KDQpGaXJzdGx5LCBJIGFsc28gYWRkIHRoZSAiIGdvdG8gb3V0X2ZyZWVfcG9saWN5Iiwg
YW5kIHJlbW92ZWQgbGF0ZXIsICBiZWNhdXNlIEkgdGhpbmsgaXQgaXMgYSBsaXR0bGUgcmlza3kg
dG8gZmFpbCB0aGUgd2hvbGUgb25saW5lIHByb2Nlc3MgaWYgZHJpdmVyIGluaXQgYm9vc3QgY2Fs
bGJhY2sgZmFpbGVkLg0KSWYgZHJpdmVyIGluaXQgYm9vc3QgZmFpbGVkLCBpdCBqdXN0IGxldCBi
b29zdCBjb250cm9sIGZ1bmN0aW9uIGxvc3QsIGJ1dCBvbmxpbmUgaW5pdGlhbGl6ZSBmYWlsZWQg
YW5kIGdvIHRvIGZyZWUgdGhlIHBvbGljeSwgIGl0IGlzIGEgYmlnIHByb2JsZW0uDQpJIGFtIG9r
IHRvIGFkZCB0aGUgZXJyb3IgaGFuZGxpbmcgaWYgbWFpbnRhaW5lciBhZ3JlZSB0byBzZWUgdGhl
IHBvdGVudGlhbCBvbmxpbmUgZnVuY3Rpb24gYWJvcnRpbmcuIPCfmIoNCg0KUGVycnkuDQoNCj4N
Cj4gICAgICAgZ290byBvdXRfZnJlZV9wb2xpY3k7DQo+DQo+ID4gKyAgICAgICAgICAgfSBlbHNl
IHsNCj4gPiArICAgICAgICAgICAgICAgICAgIC8qIExldCB0aGUgcGVyLXBvbGljeSBib29zdCBm
bGFnIG1pcnJvciB0aGUNCj4gY3B1ZnJlcV9kcml2ZXIgYm9vc3QgZHVyaW5nIGluaXQgKi8NCj4g
PiArICAgICAgICAgICAgICAgICAgIHBvbGljeS0+Ym9vc3RfZW5hYmxlZCA9IGNwdWZyZXFfYm9v
c3RfZW5hYmxlZCgpDQo+ICYmIHBvbGljeV9oYXNfYm9vc3RfZnJlcShwb2xpY3kpOw0KPiA+ICsg
ICAgICAgICAgIH0NCj4gPg0KPiA+ICAgICAgICAgICAgIC8qDQo+ID4gICAgICAgICAgICAgICog
VGhlIGluaXRpYWxpemF0aW9uIGhhcyBzdWNjZWVkZWQgYW5kIHRoZSBwb2xpY3kgaXMgb25saW5l
Lg0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2NwdWZyZXEuaCBiL2luY2x1ZGUvbGlu
dXgvY3B1ZnJlcS5oIGluZGV4DQo+ID4gMjBmN2U5OGVlOGFmLi4wNjk4YzAyOTJkOGYgMTAwNjQ0
DQo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC9jcHVmcmVxLmgNCj4gPiArKysgYi9pbmNsdWRlL2xp
bnV4L2NwdWZyZXEuaA0KPiA+IEBAIC00MDksNiArNDA5LDggQEAgc3RydWN0IGNwdWZyZXFfZHJp
dmVyIHsNCj4gPiAgICAgYm9vbCAgICAgICAgICAgIGJvb3N0X2VuYWJsZWQ7DQo+ID4gICAgIGlu
dCAgICAgICAgICAgICAoKnNldF9ib29zdCkoc3RydWN0IGNwdWZyZXFfcG9saWN5ICpwb2xpY3ks
IGludCBzdGF0ZSk7DQo+ID4NCj4gPiArICAgLyogaW5pdGlhbGl6ZSBib29zdCBzdGF0ZSB0byBi
ZSBjb25zaXN0ZW50IGJlZm9yZSBjYWxsaW5nIHNldF9ib29zdCAqLw0KPiA+ICsgICBpbnQgICAg
ICAgICAgICAgKCppbml0X2Jvb3N0KShzdHJ1Y3QgY3B1ZnJlcV9wb2xpY3kgKnBvbGljeSk7DQo+
ID4gICAgIC8qDQo+ID4gICAgICAqIFNldCBieSBkcml2ZXJzIHRoYXQgd2FudCB0byByZWdpc3Rl
ciB3aXRoIHRoZSBlbmVyZ3kgbW9kZWwgYWZ0ZXIgdGhlDQo+ID4gICAgICAqIHBvbGljeSBpcyBw
cm9wZXJseSBpbml0aWFsaXplZCwgYnV0IGJlZm9yZSB0aGUgZ292ZXJub3IgaXMgc3RhcnRlZC4N
Cg0K

