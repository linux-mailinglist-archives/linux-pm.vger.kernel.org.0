Return-Path: <linux-pm+bounces-9527-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF94C90E1D6
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 05:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 990382851F1
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 03:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04C7537E9;
	Wed, 19 Jun 2024 03:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="STPewZvn"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E1080C;
	Wed, 19 Jun 2024 03:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718766542; cv=fail; b=fhn4dPFizX1SHlX9bWyDiCck0INK2WDg+o9XPY3g1WS7IsqV94UHAJBtAHsFEV9E8Kqd1jUm+c0/IyttgC9/BbHaHXtKYqVyFMUofCNVtBAFETZKWil0ROFXNebR9V5MKc8D3YnREP7qmTPZjs5jO8L0vUkDTs1HbC3KlIM3q3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718766542; c=relaxed/simple;
	bh=E1RvNlSbLReThU1WnrkMi4L7OkhIYa9UOI7jtOj9pk0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FvwUCy6WYYqv7nNqpE4VQjFv8FGnK/wyZLrF46yGwKQVrHOxotIMNleWXUrG/UN3PLnJ4y1eXVTefh/Slw5BpYjhRJtdJFxKJ6TMNCicS3lnZnEoBlSz6uZ6IJ4cAeODHSLBn4NdMsGptSb1bwPoIFVuv9sKE9NBXBNxzBcxdmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=STPewZvn; arc=fail smtp.client-ip=40.107.220.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=asLX2YiOG/HboRINYkjKVidTQujQYJGVDcUg0zWMPAJSY5kP1HbB4hBujUlimc5DkhgfmJm3FUuDTzv7N7v2ipzu1MdGXSG33UBe0UGniFot/LW46UQV7Df7N/wNDpc5Ty7JZ+qrysiVdy4OeaWeDg15QDcpmpSXJlsWbKKLDsjwIOeJNJEJAz+hcobIPv617qXEINfHM/opJiOMdoIkjTuqilbIZto52b63d65rjwnZo+RVEyAQnvU0A5MwkUkU15j25rlrnmphkoW7a7Y8ULXaE5pEWkNnhyQ3/783USffKS972VDwPH2THCVi+/AixSi3kx/MhrWpLc9hdmnaEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E1RvNlSbLReThU1WnrkMi4L7OkhIYa9UOI7jtOj9pk0=;
 b=gmnhNzm6z76hHQor7+mlPkj4YeF6ITW6UR2uX0C7Nuq35TacYw22Rh4MGmmgcK9lLjnR+rUdYQKd1dMo+m7MHpFxsn36pYfeytsSduVmTqU/GlETM6WHSCGlW7D7MA6tc0T9RFQvNK6rRNvasYZVgpXPxGSkKK3ThWm1PUzgPW+VgDl6wKkyDg6PwM2BJo4Uns0QEXNqz5x4/GRugXGB5WrhwEx8dA9iVrAqgyjaS1V98/hYN59vPQ4Py2F/FVJK3zcqhnrWXJDP3VTLoWK5+AnEs1XCFsEjY/yaej04YzKvzNt8fGk8bUCaGpSzJM7J/Vls/T0JQSq5NDlPf1X3Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E1RvNlSbLReThU1WnrkMi4L7OkhIYa9UOI7jtOj9pk0=;
 b=STPewZvnT9cQIIj/P7KhBj6HEkB+N35/8+IgNWeNfqohM4JSmqNwbo2xOM36GRvXu0zDP1q37FEta++Y2opsFedWOatcdXTKVyKTyK6n3xmaqhhKdqVtYoZHhTVAY7FiH11NCXG75DLoMVI4yTiXMPmoENC5FxT6clg91kZmL0E=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by CH3PR12MB8458.namprd12.prod.outlook.com (2603:10b6:610:155::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Wed, 19 Jun
 2024 03:08:55 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf%6]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 03:08:55 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
	"rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
	"viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "Huang, Ray"
	<Ray.Huang@amd.com>, "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
	"Petkov, Borislav" <Borislav.Petkov@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang, Shimmer"
	<Shimmer.Huang@amd.com>, "Du, Xiaojian" <Xiaojian.Du@amd.com>, "Meng, Li
 (Jassmine)" <Li.Meng@amd.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 10/11] cpufreq: amd-pstate: auto-load pstate driver by
 default
Thread-Topic: [PATCH v4 10/11] cpufreq: amd-pstate: auto-load pstate driver by
 default
Thread-Index: AQHawISFpQgO1gihJ0mc54YfKbU1nLHN6YCAgACA76A=
Date: Wed, 19 Jun 2024 03:08:55 +0000
Message-ID:
 <CYYPR12MB8655A0B7F40FD0EE0DCB33B29CCF2@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <cover.1718606975.git.perry.yuan@amd.com>
 <0a4699e224e1931c09d6ede2620d585382b7d168.1718606975.git.perry.yuan@amd.com>
 <09f985e8-5e53-47ed-84a8-baaee52dd483@amd.com>
In-Reply-To: <09f985e8-5e53-47ed-84a8-baaee52dd483@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=28880aba-4ae2-416a-8bad-c7c4484a07f9;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-19T03:06:53Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|CH3PR12MB8458:EE_
x-ms-office365-filtering-correlation-id: d2cac8de-5f5c-4868-a053-08dc900d2788
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230037|366013|376011|1800799021|38070700015|921017;
x-microsoft-antispam-message-info:
 =?utf-8?B?Rld3UXVLS2ZwYi8vTmtCWDBGNEsyeWtjd2lTcFM5RXBZQ2x4WVBOS3QxUTRO?=
 =?utf-8?B?NTUrTlgxTHhLajBzYnYxNGtKYm5hc3JscUVVK3lXTU0wcmtuNTM4WW1HSnJs?=
 =?utf-8?B?S0xYdW1CMnpoMk9qNjJ6aHFCcjdPSjNDLzFKOUorcWdPZklmbnVKUjBVQzZO?=
 =?utf-8?B?ZkJWM0tlRTZyamR6cjJRTjNTeERxc3E5b1hxTGcrWjhxa0RCa1RpbEhoWGk2?=
 =?utf-8?B?cGl4WHNCclRXbExMdHRMSTI1OEFkZ09Md2lUU05DNXRodXFKSjduYnlKcU5S?=
 =?utf-8?B?cDY5ZmpiQ3RYWUdpQmxudWhyQ1R4QkpnZUNsMnhzWUJnZkhUMWpRK09lM3VC?=
 =?utf-8?B?bS9nZXhuZURrNUtSSHdaUG9JMUZmL3hTSjJ5NlNHWUl4UE11SitoSVRUdnBt?=
 =?utf-8?B?ZTJZaWdrbFpxakY0NEFaNTRDa3hqdytaVUYzTkZLZGp3bzlJRVlvcVV3TEZw?=
 =?utf-8?B?OEhOQ1RmUEtVQ2thSjVIdjRCMWdhRVJPZXhOTDA0TWhkTVNxdkZEYkxSamNE?=
 =?utf-8?B?anRtRjJaZndYell4Mi9DU2JZR3NIajFXWE1qN3diQUFUelIyd0N6N1NVYmpl?=
 =?utf-8?B?RDNZcFd3YkViN0VvYkpkeW5DTmU0SFNJdmt0Lyt1SFR2ZzdlWTZEVlhvZ0Q0?=
 =?utf-8?B?TnBKRlNwL0tWYU51cjdKVkZpSFpzR0hmS3VIdS82cWZhNGdLZHFyQlJyUktV?=
 =?utf-8?B?UEtUVm54Tkx5dTNtVG9rQ3o1Q3duTUtMSmQxZjBqR0ZWRVc5TkZUUFhKdWpl?=
 =?utf-8?B?d3N1eXdVaS9UbEpkYW5lOW9hQXZSckJqNFlUQWFtUGNLd0VHNTRpa01sK0Zh?=
 =?utf-8?B?UFR2LzNUcmdXUm1UMlprdkkvNURqUlFNMEJ3aEt1UjR4S3ZQNnJESjBxMXVI?=
 =?utf-8?B?OGhJYWY5QkFFdTN4Um5GVDl6WURnbndCSUtqRWV3U0hDU2E0U0dqUFBZNlF3?=
 =?utf-8?B?QzdUWmRNaFJ2VUhFQy9xU0FvMEJMQjJsOEMyeFhJSWROL0NUVnNGTXV4RWhQ?=
 =?utf-8?B?YkpXVFBWcmdXWkdwR2VJNVhkNlF3SGRGWmdWaTNQQjVsR3BWbHNZamlWMThL?=
 =?utf-8?B?bEoxNXYyTjdDSUJFL3JlVHBVcUxHemUxQlByZHN4clNmdzgwOU11bE5qOUlQ?=
 =?utf-8?B?cUZsUnNWTDZYcTlkREcwZmo1eEhVRnVPV0JtYzlEZkpKVmpKaTdPR0pBQTMw?=
 =?utf-8?B?czgyWllzODgrUXU2NXhiNFdlZjJWd0VKNXZBM2tobDIwcTVYZGxvSTVXTTFP?=
 =?utf-8?B?cW5KWUtYbi9ERUR3cWt5cEp3djRBeEx3b3U3cU84ZlBRNGxXUlhkN1BNTXJV?=
 =?utf-8?B?VDZMTW1leS96NnhzbS80ZzQwSWxidjBRK3JxTW1KNVYrRERlU0k0ZVZWSmdS?=
 =?utf-8?B?NmQvd2FpQ0NVdk03eFJ0dTZwYlNOTTYvd1Z5S1VqcWFsRSt4T2xEQ1hjUlMv?=
 =?utf-8?B?WExEcTlIQWYvbGhUWmZka1pHUWJZOTA0SVpDZlRQd0F4c2VqVS9LWWNJWmZ5?=
 =?utf-8?B?dm9ZV3hoNmtuYVJwSEFKZnlaRUJDMExEN29jb1RBbmEzOGJ3VXJFNDhDaGli?=
 =?utf-8?B?UVBsd3dwNHBRdG9oQlZxczlWSHRZSVcvOGJWNE5KTmp4NHovWU1qdFB0R0Ez?=
 =?utf-8?B?OVR4SFhvZ0F4bEtQZjNxaXduWXdJQTMyTk5qTG1aWTdEWjZha2RzZW9ST3Ji?=
 =?utf-8?B?cURGRTZHdkZOSWdNSkcxdzUyUG1CV213Y3BHWkZTOThiRGpMaTY3RC9MemQx?=
 =?utf-8?B?eFlWZzVxUlRLUGtMdmtxWUFlQmNrSk5zaXZ4c1Voa21POHlpb3ZGZUZxeFRJ?=
 =?utf-8?B?VlhkYWY2YmV5bSt1Rm1vUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(38070700015)(921017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?azgvdVRyYWI4QlBkRWRlc2t3ZUtQL1g5dW9HSFRmaktpczI1RXFoSDVEUFgx?=
 =?utf-8?B?ZHM5UkNvd1NJVi9TQ0oweTI2R3ZJTHpvNUQwYzl0Yjl5UDNqZnQ5Z1JLMnNs?=
 =?utf-8?B?WXREc2RTUDZYQmRTRldRMW9DWlNrNTRHV2poQkMvejdVQk9jMFVuOTJNS3pR?=
 =?utf-8?B?cjRtYWlDa2taMVJKaXhidWhSRXF4NDg1eWttSVppbDV3eTlBeDIxSE5Ya1R6?=
 =?utf-8?B?QnNqWEdVS0lSdGRVbFlVTEo5bEFWcThkRnBCZnRRc21DNTdScWVieDVQSzJU?=
 =?utf-8?B?R3VMbTh4bE9rZkx3Umd4b1hFa0JMUUZ0SlZ2a01DcXV3RmsyVkRFRWtTZXZs?=
 =?utf-8?B?S0M5cmFWQVA4cVAvY0lpeGt1bHNPaFNxWkU1VjRCWTVpWDlNQnA5Y2dQUkNs?=
 =?utf-8?B?eU5nMHVUU1lYd1lmTGcrbEN2bjd6Y0FiaTlWSXBFTWdyekNJQ3NRSXBBdzc4?=
 =?utf-8?B?UUpDeTdWZmJ6UlJ4dnV5L0lOTzg3NVdORXlaZ3k5amJjWGJ6MncyazRta3Zz?=
 =?utf-8?B?MmNIbHd3d1RTSit4R1daSUlHbmtkRkhwV1pnc3dIL29sUWVrd2tOOVRTV3dT?=
 =?utf-8?B?em1pRGN2YkErZTdNS0MxR29PQkhXYnVLbS9LelBzZkVWbS81Y1R4WDBiUG84?=
 =?utf-8?B?VExzcFV5VWNGTnZxd3VDVHlwdnZwVS93N1RicXhVd1dNVmc3eG9DakpENG11?=
 =?utf-8?B?OHlnR3UwRXVCemtrMFo5ZFVaQkRmcWhUN0JZZnFuUVpQS1JkNFJURUZPaFFr?=
 =?utf-8?B?cXZQRFZRSDdPWWF5ejFGVE1yU0k3Wk1jN05tNDZ5NUc2bzU2VEdDWlVydDll?=
 =?utf-8?B?NFJDZVd2Q0Q0UUxIVkgzTWNEelhqZ2JMRXM1TlNRTnUvVi8zWkNMd0Y4L0xJ?=
 =?utf-8?B?RjZMUks5ZHJmVS9IS3d2a0dibXNyZk1SZklDajd2OHFhNUorbmk5T0Vsd1RV?=
 =?utf-8?B?aWNxbmxVRi9qTlJ0V2k1VWJWN1ZGUEZkN2d1NHIwS2s4cWZ1a3hmanAxbFRl?=
 =?utf-8?B?MFhITE1ZN0QvdVgzU3JGelVVa3dscW5paWlXTmhWOG5oNUhQRHJUaTJOMzlq?=
 =?utf-8?B?QnFNYlFBSG04bGtoYXZZOTljL1NVWGV1SGUrUmdLMlZzbWtyNm96R0M1ZnVG?=
 =?utf-8?B?UWJYZkkwT1RKSXpJK3N1QlhyNmN0QWFqSG1MU09mZm92Y3VyZWxFRDZIRHF0?=
 =?utf-8?B?dmltUlVPQk56S28vb2xxeUtXRUs3OU9pQ2NLaVJaRWR1K1pISU1iRmYvUERY?=
 =?utf-8?B?SGlubTM5TERDYjFZZzlnUUVVbUd1dTBXSTZmVHFBS1ZFTzJBK21Ib3JNVEw2?=
 =?utf-8?B?bkYraStSUXVQMHJkVVdUOGREaWtXNEt2NGdNSTNkNW5mbGlSZDhsNVRtR3NM?=
 =?utf-8?B?SkZFUXhlUFdIbjhvR0lOVGFTak1SZnhkV0pwUXJHSDJRUnJtQitDZ0dhZzRl?=
 =?utf-8?B?Yzc5VmIwTmE1RXA5bGNrSU5sc04vc2VDMVF0SmtoWmVQbDhNc0dHblU1akMz?=
 =?utf-8?B?TTN2VXNoaXVoRWp4VUc3S1pYNWJHZzRIOURkYzlhb3RqL3lEQmFLQlZaNlE3?=
 =?utf-8?B?di84VU9OSVVJYjZRazFmOWRGYlQvZW9McDlBREV2RmZaZm1sWDlzWVRXK0VK?=
 =?utf-8?B?N2RNK0lEVnZBZ1g1SHFTaXdKelpGb0ZyY0Uyd0p4VDcvQWlLbHNTV1pRYTMr?=
 =?utf-8?B?R3BVeDdJUndBNndUYUxHZnVPbjRrSWMyTDVIR3dHYTVDZU1jWjVUOHNRMjNC?=
 =?utf-8?B?UVdJTlY1cVNOYi9UMUdBaUJNaXlzR0Q4Vk52SDRJbGxvQ012V3lRdHE0R0xj?=
 =?utf-8?B?SzBRQWt0R1AwWXVlT2pxOFU0azZ4TWNDMXIxOGxKR1h3M2hKWUt6aDVQdmFH?=
 =?utf-8?B?MGdTQnVKNmx6Y0NhUjhPYTlxZ2l6Rk9RaWJNdHlkRlRiVGV3K3BWYm1ydDVL?=
 =?utf-8?B?SFE0dFRsN0daczUvUXZhVEVYdDFSRG1jOTZTWUdCSXBLTDllNWY2Mk1PT2k3?=
 =?utf-8?B?S3JlQ1JKMHY4WjVHczBaN2JMVHphaW9TNXVCNU81enlqVW84UVY5bkI3L2N2?=
 =?utf-8?B?ZlJrblhqbVJiK05nclI0aDVkMkQra2pwOEdGL1drczI2bjdCdHdWL3ZXbEJ2?=
 =?utf-8?Q?6JZE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d2cac8de-5f5c-4868-a053-08dc900d2788
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 03:08:55.1578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XtFNOVTDR6WzUgHst/LhNu5pX6fRDhwPLd7K9KFxG1guZG4DDo6O8AHeW88sknTfjZQbWuys8ml4sVVmU2gDvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8458

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGkgTWFyaW8NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMaW1v
bmNpZWxsbywgTWFyaW8gPE1hcmlvLkxpbW9uY2llbGxvQGFtZC5jb20+DQo+IFNlbnQ6IFdlZG5l
c2RheSwgSnVuZSAxOSwgMjAyNCAzOjI1IEFNDQo+IFRvOiBZdWFuLCBQZXJyeSA8UGVycnkuWXVh
bkBhbWQuY29tPjsgcmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb207DQo+IHZpcmVzaC5rdW1hckBs
aW5hcm8ub3JnOyBIdWFuZywgUmF5IDxSYXkuSHVhbmdAYW1kLmNvbT47IFNoZW5veSwNCj4gR2F1
dGhhbSBSYW5qYWwgPGdhdXRoYW0uc2hlbm95QGFtZC5jb20+OyBQZXRrb3YsIEJvcmlzbGF2DQo+
IDxCb3Jpc2xhdi5QZXRrb3ZAYW1kLmNvbT4NCj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxl
eGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEh1YW5nLCBTaGltbWVyDQo+IDxTaGltbWVyLkh1YW5n
QGFtZC5jb20+OyBEdSwgWGlhb2ppYW4gPFhpYW9qaWFuLkR1QGFtZC5jb20+OyBNZW5nLA0KPiBM
aSAoSmFzc21pbmUpIDxMaS5NZW5nQGFtZC5jb20+OyBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
djQgMTAvMTFdIGNwdWZyZXE6IGFtZC1wc3RhdGU6IGF1dG8tbG9hZCBwc3RhdGUgZHJpdmVyIGJ5
DQo+IGRlZmF1bHQNCj4NCj4gT24gNi8xNy8yMDI0IDAxOjU5LCBQZXJyeSBZdWFuIHdyb3RlOg0K
PiA+IElmIHRoZSBgYW1kLXBzdGF0ZWAgZHJpdmVyIGlzIG5vdCBsb2FkZWQgYXV0b21hdGljYWxs
eSBieSBkZWZhdWx0LCBpdA0KPiA+IGlzIGJlY2F1c2UgdGhlIGtlcm5lbCBjb21tYW5kIGxpbmUg
cGFyYW1ldGVyIGhhcyBub3QgYmVlbiBhZGRlZC4NCj4gPiBUbyByZXNvbHZlIHRoaXMgaXNzdWUs
IGl0IGlzIG5lY2Vzc2FyeSB0byBjYWxsIHRoZQ0KPiA+IGBhbWRfcHN0YXRlX3NldF9kcml2ZXIo
KWAgZnVuY3Rpb24gdG8gZW5hYmxlIHRoZSBkZXNpcmVkIG1vZGUNCj4gPiAocGFzc2l2ZS9hY3Rp
dmUvZ3VpZGVkKSBiZWZvcmUgcmVnaXN0ZXJpbmcgdGhlIGRyaXZlciBpbnN0YW5jZS4NCj4gPg0K
PiA+IFRoaXMgZW5zdXJlcyB0aGF0IHRoZSBkcml2ZXIgaXMgbG9hZGVkIGNvcnJlY3RseSB3aXRo
b3V0IHJlbHlpbmcgb24NCj4gPiB0aGUga2VybmVsIGNvbW1hbmQgbGluZSBwYXJhbWV0ZXIuDQo+
ID4NCj4gPiBXaGVuIHRoZXJlIGlzIG5vIHBhcmFtZXRlciBhZGRlZCB0byBjb21tYW5kIGxpbmUs
IEtlcm5lbCBjb25maWcgd2lsbA0KPiA+IHByb3ZpZGUgdGhlIGRlZmF1bHQgbW9kZSB0byBsb2Fk
Lg0KPiA+DQo+ID4gTWVhbndobGUsIHVzZXIgY2FuIGFkZCBkcml2ZXIgbW9kZSBpbiBjb21tYW5k
IGxpbmUgd2hpY2ggd2lsbCBvdmVycmlkZQ0KPg0KPiBNZWFud2hpbGUNCj4NCj4gPiB0aGUga2Vy
bmVsIGNvbmZpZyBkZWZhdWx0IG9wdGlvbi4NCj4NCj4gSSB0aGluayB5b3UnbGwgcHJvYmFibHkg
d2FudCB0byBzd2FwIHRoZSBvcmRlciBvZiBwYXRjaCAxMCBhbmQgcGF0Y2ggMTEuDQoNClN1cmUs
IHRoYXQgd2lsbCBiZSBtb3JlIHJlYXNvbmFibGUgdG8gc2V0IGVwcCBsb2FkZWQgYnkgZGVmYXVs
dCBmb3IgTVNSIGFuZCBzaGFyZWQgbWVtb3J5IHN5c3RlbXMuDQpMZXQgbWUgc3dhcCB0aGVtIGlu
IHY1Lg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KDQoNCj4NCj4gPg0KPiA+IFJlcG9ydGVkLWJ5
OiBBbmRyZWkgQW11cmFyaXRlaSA8YW5kYW11QHBvc3Rlby5uZXQ+DQo+ID4gQ2xvc2VzOiBodHRw
czovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTIxODcwNQ0KPiA+IFNpZ25l
ZC1vZmYtYnk6IFBlcnJ5IFl1YW4gPHBlcnJ5Lnl1YW5AYW1kLmNvbT4NCj4NCj4gUmV2aWV3ZWQt
Ynk6IE1hcmlvIExpbW9uY2llbGxvIDxtYXJpby5saW1vbmNpZWxsb0BhbWQuY29tPg0KPg0KPiA+
IC0tLQ0KPiA+ICAgZHJpdmVycy9jcHVmcmVxL2FtZC1wc3RhdGUuYyB8IDI0ICsrKysrKysrKysr
KysrKysrLS0tLS0tLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDcg
ZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jcHVmcmVxL2FtZC1w
c3RhdGUuYw0KPiA+IGIvZHJpdmVycy9jcHVmcmVxL2FtZC1wc3RhdGUuYyBpbmRleCBjZjY4MzQz
MjE5ZDEuLmI0OGZkNjBjYmM2ZA0KPiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2NwdWZyZXEv
YW1kLXBzdGF0ZS5jDQo+ID4gKysrIGIvZHJpdmVycy9jcHVmcmVxL2FtZC1wc3RhdGUuYw0KPiA+
IEBAIC0xODU3LDggKzE4NTcsMTMgQEAgc3RhdGljIGludCBfX2luaXQgYW1kX3BzdGF0ZV9pbml0
KHZvaWQpDQo+ID4gICAgIC8qIGNoZWNrIGlmIHRoaXMgbWFjaGluZSBuZWVkIENQUEMgcXVpcmtz
ICovDQo+ID4gICAgIGRtaV9jaGVja19zeXN0ZW0oYW1kX3BzdGF0ZV9xdWlya3NfdGFibGUpOw0K
PiA+DQo+ID4gLSAgIHN3aXRjaCAoY3BwY19zdGF0ZSkgew0KPiA+IC0gICBjYXNlIEFNRF9QU1RB
VEVfVU5ERUZJTkVEOg0KPiA+ICsgICAvKg0KPiA+ICsgICAqIGRldGVybWluZSB0aGUgZHJpdmVy
IG1vZGUgZnJvbSB0aGUgY29tbWFuZCBsaW5lIG9yIGtlcm5lbA0KPiBjb25maWcuDQo+ID4gKyAg
ICogSWYgbm8gY29tbWFuZCBsaW5lIGlucHV0IGlzIHByb3ZpZGVkLCBjcHBjX3N0YXRlIHdpbGwg
YmUNCj4gQU1EX1BTVEFURV9VTkRFRklORUQuDQo+ID4gKyAgICogY29tbWFuZCBsaW5lIG9wdGlv
bnMgd2lsbCBvdmVycmlkZSB0aGUga2VybmVsIGNvbmZpZyBzZXR0aW5ncy4NCj4gPiArICAgKi8N
Cj4gPiArDQo+ID4gKyAgIGlmIChjcHBjX3N0YXRlID09IEFNRF9QU1RBVEVfVU5ERUZJTkVEKSB7
DQo+ID4gICAgICAgICAgICAgLyogRGlzYWJsZSBvbiB0aGUgZm9sbG93aW5nIGNvbmZpZ3MgYnkg
ZGVmYXVsdDoNCj4gPiAgICAgICAgICAgICAgKiAxLiBVbmRlZmluZWQgcGxhdGZvcm1zDQo+ID4g
ICAgICAgICAgICAgICogMi4gU2VydmVyIHBsYXRmb3Jtcw0KPiA+IEBAIC0xODcwLDE1ICsxODc1
LDIwIEBAIHN0YXRpYyBpbnQgX19pbml0IGFtZF9wc3RhdGVfaW5pdCh2b2lkKQ0KPiA+ICAgICAg
ICAgICAgICAgICAgICAgcHJfaW5mbygiZHJpdmVyIGxvYWQgaXMgZGlzYWJsZWQsIGJvb3Qgd2l0
aCBzcGVjaWZpYw0KPiBtb2RlIHRvIGVuYWJsZSB0aGlzXG4iKTsNCj4gPiAgICAgICAgICAgICAg
ICAgICAgIHJldHVybiAtRU5PREVWOw0KPiA+ICAgICAgICAgICAgIH0NCj4gPiAtICAgICAgICAg
ICByZXQgPQ0KPiBhbWRfcHN0YXRlX3NldF9kcml2ZXIoQ09ORklHX1g4Nl9BTURfUFNUQVRFX0RF
RkFVTFRfTU9ERSk7DQo+ID4gLSAgICAgICAgICAgaWYgKHJldCkNCj4gPiAtICAgICAgICAgICAg
ICAgICAgIHJldHVybiByZXQ7DQo+ID4gLSAgICAgICAgICAgYnJlYWs7DQo+ID4gKyAgICAgICAg
ICAgLyogZ2V0IGRyaXZlciBtb2RlIGZyb20ga2VybmVsIGNvbmZpZyBvcHRpb24gWzE6NF0gKi8N
Cj4gPiArICAgICAgICAgICBjcHBjX3N0YXRlID0gQ09ORklHX1g4Nl9BTURfUFNUQVRFX0RFRkFV
TFRfTU9ERTsNCj4gPiArICAgfQ0KPiA+ICsNCj4gPiArICAgc3dpdGNoIChjcHBjX3N0YXRlKSB7
DQo+ID4gICAgIGNhc2UgQU1EX1BTVEFURV9ESVNBQkxFOg0KPiA+ICsgICAgICAgICAgIHByX2lu
Zm8oImRyaXZlciBsb2FkIGlzIGRpc2FibGVkLCBib290IHdpdGggc3BlY2lmaWMgbW9kZSB0bw0K
PiBlbmFibGUNCj4gPiArdGhpc1xuIik7DQo+ID4gICAgICAgICAgICAgcmV0dXJuIC1FTk9ERVY7
DQo+ID4gICAgIGNhc2UgQU1EX1BTVEFURV9QQVNTSVZFOg0KPiA+ICAgICBjYXNlIEFNRF9QU1RB
VEVfQUNUSVZFOg0KPiA+ICAgICBjYXNlIEFNRF9QU1RBVEVfR1VJREVEOg0KPiA+ICsgICAgICAg
ICAgIHJldCA9IGFtZF9wc3RhdGVfc2V0X2RyaXZlcihjcHBjX3N0YXRlKTsNCj4gPiArICAgICAg
ICAgICBpZiAocmV0KQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gPiAg
ICAgICAgICAgICBicmVhazsNCj4gPiAgICAgZGVmYXVsdDoNCj4gPiAgICAgICAgICAgICByZXR1
cm4gLUVJTlZBTDsNCj4gPiBAQCAtMTg5OSw3ICsxOTA5LDcgQEAgc3RhdGljIGludCBfX2luaXQg
YW1kX3BzdGF0ZV9pbml0KHZvaWQpDQo+ID4gICAgIC8qIGVuYWJsZSBhbWQgcHN0YXRlIGZlYXR1
cmUgKi8NCj4gPiAgICAgcmV0ID0gYW1kX3BzdGF0ZV9lbmFibGUodHJ1ZSk7DQo+ID4gICAgIGlm
IChyZXQpIHsNCj4gPiAtICAgICAgICAgICBwcl9lcnIoImZhaWxlZCB0byBlbmFibGUgd2l0aCBy
ZXR1cm4gJWRcbiIsIHJldCk7DQo+ID4gKyAgICAgICAgICAgcHJfZXJyKCJmYWlsZWQgdG8gZW5h
YmxlIGRyaXZlciBtb2RlKCVkKVxuIiwgY3BwY19zdGF0ZSk7DQo+ID4gICAgICAgICAgICAgcmV0
dXJuIHJldDsNCj4gPiAgICAgfQ0KPiA+DQoNCg==

