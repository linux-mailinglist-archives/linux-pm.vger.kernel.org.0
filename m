Return-Path: <linux-pm+bounces-9067-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2171090674B
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 10:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A3861C218B1
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 08:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335D713DDDC;
	Thu, 13 Jun 2024 08:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NIRPetyG"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280CA13C9A1;
	Thu, 13 Jun 2024 08:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718268246; cv=fail; b=arRd/1S9cQSHGvi1/DBV89AOxSpyXNKdefheW5zsbXDXX46SrjrwloNIkSix6+YNtbIBN/f0PM90nG7V25FcWTeXNQXfs0MLQ/viUUQFOznqxS6AjBNZx9S3wF5ikMzRhLalVEySrmSCzAnWlX7K5flxHOKsj79XNA6T1Ag9Ff8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718268246; c=relaxed/simple;
	bh=RfCxNp9lCjI0LyLdR1kfj4PjmIV91oJqDGvxKLP2/5s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nKV13wz73uo4vB1fmJqclxaBjEui3oIFPKZPdJW30AL7LAbRsQbQbUF0Z5AjSF75i1PL36k0iDmAl/YI1+AiDjWKkXY08PO39OJzoZ4uLN90TuBdGnUNfKsETZO1w2QoPtwUtqsusn+SsmoxM3NFfqj46D0n7OJ/urD/Hr2Ei0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NIRPetyG; arc=fail smtp.client-ip=40.107.93.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvuAALkmIdM3kBbKcWGy1TZ5nYhvbjuh2fMIn88D0osgDEaFMZkreqzRoYVBkTCtYosKvEEFZS7gzz1UAxSZSpkE8kSW5C9k+3dpmwZFyE4bfCt29VaQA/uaoz7TdcX9s8T/wjWO0R0nsJE/NkfmflxMvCVIV5JmWnoYdGz4qDrN9FXB/YJG30VzfAcu5VnjIDp7TbwjrTUYs14tEUFTiiQ12igWvKmS8DRX/SKUpFT/DRcmRKV4HvUYQLZmqZrwJWa4GRAS8pAQvnzADw74yKUfpYQeUw+fKt+tBq5dxrX45S47k5JRx65Fvw1zb5fzV+6D7H6pKJ1lC7F+jRFdeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfCxNp9lCjI0LyLdR1kfj4PjmIV91oJqDGvxKLP2/5s=;
 b=g1u+sOSy9GZzYrXx6oavuy47HQW2mehKJJ4DD7Uy40W9sAvXaFtOPy9piHSBZfeVP2DVsIsC+zSxCFUgAzV1tnTPJqVjpl9mqsowi1clOChG4zyfQ2E780ctiF9we7k3HPeMTMbPmoxrJaBd3PFfdFxE/4MRMIrMT2gKu5fA1DLqYhmDW7PVvVfoFiUx3vTBrKS37MOEBAzNJ+8tFxULn9Es4eOIF0oCL5frrHNICOFrT0EV56VtiKtXd6ZestRG4fLZNwXhkRZm1JBMnLQ4ePVi+8OhCAjnIlVIydwvBFBVClqMAnv9NDkpHp84W0GQfLYuNYuh4CSlz3KtllolyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfCxNp9lCjI0LyLdR1kfj4PjmIV91oJqDGvxKLP2/5s=;
 b=NIRPetyGjp4FKHovsKciYmrQUciv39IWDjrwf8hb6dH0l/sTbWrNdTChg+cL5HWLTiAYmF2WCRF4Z/SmdQ89OoeXOtF8SagAHMbEm4VnJuQp/LtcTRoBHMyEqlJIJgA/iUb53E/RRPWXAZOa9zF/LAK5nN1CH0xfWj2X6sT1OIo=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by SJ0PR12MB6991.namprd12.prod.outlook.com (2603:10b6:a03:47c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Thu, 13 Jun
 2024 08:44:01 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf%6]) with mapi id 15.20.7633.037; Thu, 13 Jun 2024
 08:44:01 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>, "Limonciello, Mario"
	<Mario.Limonciello@amd.com>
CC: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
	"viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "Huang, Ray"
	<Ray.Huang@amd.com>, "Petkov, Borislav" <Borislav.Petkov@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Huang, Shimmer"
	<Shimmer.Huang@amd.com>, "Du, Xiaojian" <Xiaojian.Du@amd.com>, "Meng, Li
 (Jassmine)" <Li.Meng@amd.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 10/10] cpufreq: amd-pstate: automatically load pstate
 driver by default
Thread-Topic: [PATCH v3 10/10] cpufreq: amd-pstate: automatically load pstate
 driver by default
Thread-Index: AQHau90SCSK+jHugRkOl4Y61/+jgTLHFXQeAgAABuSA=
Date: Thu, 13 Jun 2024 08:44:01 +0000
Message-ID:
 <CYYPR12MB865521EE6384529BF5E739E39CC12@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <cover.1718095377.git.perry.yuan@amd.com>
 <39b55abeb278d9ae1688c0b87cb7ec8a3e37932a.1718095377.git.perry.yuan@amd.com>
 <87wmmti7b0.fsf@BLR-5CG11610CF.amd.com>
In-Reply-To: <87wmmti7b0.fsf@BLR-5CG11610CF.amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=baf8624a-7c2d-44d5-86da-66a1f1d41ef5;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-13T08:25:24Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|SJ0PR12MB6991:EE_
x-ms-office365-filtering-correlation-id: e73e56c6-8a7e-4efb-131b-08dc8b84f965
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230034|376008|1800799018|366010|38070700012;
x-microsoft-antispam-message-info:
 =?utf-8?B?U1pKS0N4N2VWdHlDbmIrLzZQUkNRQlp3QlYvdjRsdVJuSkdTZXNjU0V4eEcw?=
 =?utf-8?B?Y0ZWclVXa0ovUG92MmQ1WlRaK2M4UE5Pb005T3AyYUlXaDZWKzFOamdHOG4v?=
 =?utf-8?B?S1pnL2tZTmswYUpKaFhWbWVkNmN4Umdsci95TUc2RVZVeDdPd0RPSURaeDVn?=
 =?utf-8?B?T2JUUGR6WWVQc1lNUlJRU1pFeGVJZDZrc2hrSVAvTUpVZGxlSTN0S2piRTND?=
 =?utf-8?B?NWdRSmQ0UHZZejltODhGTXZmSjhmOHZkYjB6MzBPZjE5ZkJTVzdhYlI2dndU?=
 =?utf-8?B?NENpMDRBb2ZxbW9DcllBWFQ5cUc3VisxaXZKTkJIOUIyRjdMMUI4ZW1uRVds?=
 =?utf-8?B?MG4zUktmK2tlNjloR250MkRwTys5b01aQlo3Z0ZMQkwvdlJwTzVGTW1nclVt?=
 =?utf-8?B?dkZpa0s4dkVHWWNnbmdQNzJHckxjUmlLOEFCVVdrQ2xHL2FGbUJOT2NSQ2wr?=
 =?utf-8?B?ZlJPaXV2UHBwQ0ZkbFVscnAwNG9vMHFUdENCMnA2Zm0rM3ZRTkZqQjIwVW4z?=
 =?utf-8?B?T25IM1NHeXdyUDA4d290MEZkT0tNS1FpNVFFWG5ESmhJdlhYdU9jckh5dzZK?=
 =?utf-8?B?N3FSVmQ0L2V2dnVqMHBJWXFtUTBGZGtKb09jWnRDR2xCTWlyUVllRVBkUWNS?=
 =?utf-8?B?eDZyTTNBYngxaUZnQi9RSkJSaWhXaGdhQ0NjKzZkT2RFUHdOcnpiZWVDd1or?=
 =?utf-8?B?ZkdXTk1Kb0gxdFJ5eVlrbXdWVnJWbzZPUURyYitUSWNmYW91dHhCZEhoeDhM?=
 =?utf-8?B?aEFuQ3ErUmQ5R0dQeWhKY3h6WUoxQ3NpN3dDS251VHVod1plSHkrKzVoZEIv?=
 =?utf-8?B?MHAyTzcwT1VQQ2hVbUhJWDI3TjgxR2pJcXlKOTJTVnZqSlBzMFh5NE91Mnl5?=
 =?utf-8?B?alBWQjgwK1MxeXR6Mnc5VHBmNFlORlQrSC85WGFUNkRYVG1RYWl3a0kvSjhY?=
 =?utf-8?B?bjNEbWpMaHRzaUhXN1JPSVc0cUxENVFNay95OGcwKzZDNXl5Y282cjZSMGdp?=
 =?utf-8?B?d2ZXNlVHdDRnNkVmbXhHU1JHd3FXL3hjVDBma2xPMVZmT3htOE9VVXZYSERZ?=
 =?utf-8?B?NVY4R2N2cEhaRS9qc242RThZTmdSNHBlUi9VdUtjMTNtbzVnT3JEblZWaTE4?=
 =?utf-8?B?NUo3SUZzSVpTY0xYMWd6ZlZRVVZ2OEZuNlQ1Z2RhZzBDbTVqR0hLNWRpanRu?=
 =?utf-8?B?TGhia3FnbmlqMlU1VW9QVWIvbkNTZEJrOGNOcDFZdW83U05LWEJHTUtoQTEv?=
 =?utf-8?B?TU9ZMGZPb1VqVjZkYWExTW95amIxOUwrR0F4Q3Y2cmk0d0pSdWNKTjZBSzVs?=
 =?utf-8?B?bWJHd2h2RFhXM0hDbWR6Vkg4RVZDWVJ0d213TTMzS2xOcDJKWjJWTHhaYzhP?=
 =?utf-8?B?NnZvaFp1K055anR3NndNd0hKTTh5MjdnaVVKQTd4alFMV2ZRUUEzUHp4RjBF?=
 =?utf-8?B?VlNKMGhTQ2NmeUt4S3pCR2hyZEorc2krdDN1dUpJdnNwS2twMjdVK2dZK0lS?=
 =?utf-8?B?Wjd2cVVON0VDYXVTbjhYTzA1N1dQenMxSFRQVDN5MldGcW9TTmYrRFBma3RG?=
 =?utf-8?B?TE54cXBlMVVWTytnWVZEZ1dTcTBqTHRUalRPMm9aTGZ5N2EzcTBEbXlnZmpF?=
 =?utf-8?B?WGpGeWFGNjZYN2s4ZEdDRWhiNWs5WmVaL2ErL3pLYjJ1ekVSZ0F6YWI2Vm44?=
 =?utf-8?B?OG9UdGdXZEFyc3RRUi9STmpxdmhtbTJ4djhSK2NsZlJSMW9rUDROZzV3S21O?=
 =?utf-8?Q?I9lRk+0INUqRFP5uwjICACL1Q/hphR6cJmt8F5J?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230034)(376008)(1800799018)(366010)(38070700012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b1FqQTZLYUVEYzZYdFVuQmJXS0lhUjRldzNPMDlOMUcvRXhaUU9sYXNhYVNS?=
 =?utf-8?B?UXpPK2FTMGdnOW1UTVQzNHVCZVE3UWgxano5dEdneThob0ZieVhiVWlqU2Z6?=
 =?utf-8?B?SXJXR1Q1MStheW5TNHNrS2Y0RGpiWUlLdHgvOStEbWIxSlBBQVkyMHpkYVlo?=
 =?utf-8?B?cUd3TUNGRzFQbHpEMkJUckthcndHMGxBQm9Yd2d6bkJTZEUrL0RWQnlVTFow?=
 =?utf-8?B?RDRrNmZMRkR6ZzdibGxMeE1vSkxaaGZPTjhyNjh3eTJ0bVJCUDl0Vkt4RWZt?=
 =?utf-8?B?WW1XSlFzQkhrTmIxQjd1NC8rb2N1Rnd6eU1pc3Nla1VnRmU4QU14WDlyN2NE?=
 =?utf-8?B?a2Z0UkhXWUVYa0diTkVHcXl6VkFZM2V0SkxmYjFIckZtZ3V1bXRoL1ovU2pL?=
 =?utf-8?B?UzI4ZTBTaTBrVkdKTzV1cVE0bTRQUFpTbVRkbDhPcWsxYkNrNFcvOVZIUTBM?=
 =?utf-8?B?RVJja1J2YWpQajVkTjhPY1lLdEpxTmZ1M1FuM3ZzcThYZEd0Wnh2Zit2eVRX?=
 =?utf-8?B?bkVCTTdnMWxlbGNIRGhqclJjL294NWd2NGNuc2d6aGc1d1YwRnZoT0l1a0Ro?=
 =?utf-8?B?c05iSmdYVTVLSXdaR3pXa0xNUjJTSW9scVNRNTZaM3RUeUkyZ0FRVHgxbjlZ?=
 =?utf-8?B?blRXVmt0N1ZNWTNaMlVaMitkTnd1ekJhUXZDNnlyQmVZTGZZalJnTWVEOENQ?=
 =?utf-8?B?TG1remFHV1FrUm1HcExzejgyaldzSVdYekZFRTV0ZVNHSjJaVGtpZm5WYzE0?=
 =?utf-8?B?NkF1aDhvTmllQnVJZnNhQVByTXU0OERQanhnenJlbFBCekxQdzdmT2oyb1pv?=
 =?utf-8?B?WDI2dW5vemxDNlUxQ09YVEhGM3BxWGNheTFoaVNUWVVFdjNQSFE3RlhReVAz?=
 =?utf-8?B?Z1hnVk1sSFZpdUFSb1M0UkQ3bUZQUXZqZEpYUVpqYU94c2FXV0pORFFWN1Iv?=
 =?utf-8?B?eHJTTkQxV2dHMFhMRitKaTJndENKVXA2SDNEQnFraW9qeGpXcXV5SXlyREFU?=
 =?utf-8?B?YXZLMjd6L1FZeFF0b2FXVHp1cEhHMFh3MzdhaU9oeXZBc3E4MWZpVWFIMmpX?=
 =?utf-8?B?ODNlQ1dLZm1uS2RVQnZVNXVYenE0bTlweWNtekNJaFdYanpOazVKZkw3dXJS?=
 =?utf-8?B?S0JmeGgzRWVDOGtBK1FWYnlEWGY2SVU0K3Y4Q2cxWWlnbkJWWTRLanphRlJk?=
 =?utf-8?B?Y3RPWWZDSmhEdW5teTRwU2M4Y2dKZDZ0SXFuQStsT1NKM3NEakJWRmNTbk9v?=
 =?utf-8?B?UDIrYjJkanZxSDAyaEJyQzc1aHRiSVFkSnBQTlRYUXFiSWpqUEZmRDlabmJ5?=
 =?utf-8?B?WEtraFd0cXpBQ1dEOWpHWHQ1QS8xN2MwNTJnQUZlU0NEd1pHYXg3SEsxTE51?=
 =?utf-8?B?ZmtTNEdXM294N0V4S1NZTUJURVlla3V0Z1ZFNFhTS2djVnNNeEdCaHpxdVl0?=
 =?utf-8?B?RHA5R3BIT2Q4M1Erd1Q4WWEwM0gvOTFNREw2WDF3OHF6VDZrRkF3R3l2WFhY?=
 =?utf-8?B?clhsVllXUFZYaThudkRadW5rOWQ1T1BsamVCMWxzWmM2Y2hyaDJTQ21XOVl1?=
 =?utf-8?B?V0tuSWlJM3RHeEtMMkNMdFJ0RE10eCt6RE5EMkVkcmI4QnN1akNIZ05hTXhx?=
 =?utf-8?B?STFiNTUvYVpoTlgzU1VVd0w5ckpsK2dUc3h1dC9GU3hGQWtXVUlWdmsxcGV3?=
 =?utf-8?B?VHdlbUpzY3hIcXV2SjJ4WUxxY0JQMExQQmNXcjlXZTVOdCtQZEExTHh0Y2R0?=
 =?utf-8?B?Y0c4WXAycWZVYjVMVUFJUy90UDI1TDVHU2ZxNmlZWktsR1gxbml0YVpKVFI1?=
 =?utf-8?B?RXNOYld0WHcxeHZjV1FCSkJaY1NXS2hvTHROZjFybVFNS1JrK255MzlRSmgr?=
 =?utf-8?B?R1N1L0lRUldsOWY4SGpjajYxU294OHNWME1EYjBnNE9xSmo3cGNFMGdjVnhK?=
 =?utf-8?B?L0x1NjNFM1E1MUg0T2VmZVBiMWRDdklaQW8zbGNNYXQzamxnZm5SZlNucTVx?=
 =?utf-8?B?VmEzaTZKaVZTQ3BxRCs5NEpOTHBOZE84VGN6UW1ETmtkNmVzSU9kaFZBZXZE?=
 =?utf-8?B?aXBDMTU4VW00U0JSOHdZRExmRUR4V1VNUjdMSFJXT2dDY3N2eTJTMVlvdEJX?=
 =?utf-8?Q?8En4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e73e56c6-8a7e-4efb-131b-08dc8b84f965
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2024 08:44:01.5490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d1OgyFqS3JjVy3CI4UY+SW1YQ5GA1d+Ga9M/eLv/SE8YYMf0ThArMzKK/u8e6ig9GiNexdoQhAVnI638k08hvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6991

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGkgR2F1dGhhbQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFNo
ZW5veSwgR2F1dGhhbSBSYW5qYWwgPGdhdXRoYW0uc2hlbm95QGFtZC5jb20+DQo+IFNlbnQ6IFRo
dXJzZGF5LCBKdW5lIDEzLCAyMDI0IDQ6MTkgUE0NCj4gVG86IFl1YW4sIFBlcnJ5IDxQZXJyeS5Z
dWFuQGFtZC5jb20+OyBMaW1vbmNpZWxsbywgTWFyaW8NCj4gPE1hcmlvLkxpbW9uY2llbGxvQGFt
ZC5jb20+DQo+IENjOiByYWZhZWwuai53eXNvY2tpQGludGVsLmNvbTsgdmlyZXNoLmt1bWFyQGxp
bmFyby5vcmc7IEh1YW5nLCBSYXkNCj4gPFJheS5IdWFuZ0BhbWQuY29tPjsgUGV0a292LCBCb3Jp
c2xhdiA8Qm9yaXNsYXYuUGV0a292QGFtZC5jb20+Ow0KPiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFs
ZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBIdWFuZywgU2hpbW1lcg0KPiA8U2hpbW1lci5IdWFu
Z0BhbWQuY29tPjsgRHUsIFhpYW9qaWFuIDxYaWFvamlhbi5EdUBhbWQuY29tPjsgTWVuZywNCj4g
TGkgKEphc3NtaW5lKSA8TGkuTWVuZ0BhbWQuY29tPjsgbGludXgtcG1Admdlci5rZXJuZWwub3Jn
OyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IHYzIDEwLzEwXSBjcHVmcmVxOiBhbWQtcHN0YXRlOiBhdXRvbWF0aWNhbGx5IGxvYWQgcHN0YXRl
DQo+IGRyaXZlciBieSBkZWZhdWx0DQo+DQo+IEhlbGxvIFBlcnJ5LA0KPg0KPg0KPiBQZXJyeSBZ
dWFuIDxwZXJyeS55dWFuQGFtZC5jb20+IHdyaXRlczoNCj4NCj4gPiBJZiB0aGUgYGFtZC1wc3Rh
dGVgIGRyaXZlciBpcyBub3QgbG9hZGVkIGF1dG9tYXRpY2FsbHkgYnkgZGVmYXVsdCwgaXQNCj4g
PiBpcyBiZWNhdXNlIHRoZSBrZXJuZWwgY29tbWFuZCBsaW5lIHBhcmFtZXRlciBoYXMgbm90IGJl
ZW4gYWRkZWQuDQo+ID4gVG8gcmVzb2x2ZSB0aGlzIGlzc3VlLCBpdCBpcyBuZWNlc3NhcnkgdG8g
Y2FsbCB0aGUNCj4gPiBgYW1kX3BzdGF0ZV9zZXRfZHJpdmVyKClgIGZ1bmN0aW9uIHRvIGVuYWJs
ZSB0aGUgZGVzaXJlZCBtb2RlDQo+ID4gKHBhc3NpdmUvYWN0aXZlL2d1aWRlZCkgYmVmb3JlIHJl
Z2lzdGVyaW5nIHRoZSBkcml2ZXIgaW5zdGFuY2UuDQo+ID4gVGhpcyBlbnN1cmVzIHRoYXQgdGhl
IGRyaXZlciBpcyBsb2FkZWQgY29ycmVjdGx5IHdpdGhvdXQgcmVseWluZyBvbg0KPiA+IHRoZSBr
ZXJuZWwgY29tbWFuZCBsaW5lIHBhcmFtZXRlci4NCj4gPg0KPiA+IE1lYW53aGxlLCB1c2VyIGNh
biBhZGQgZHJpdmVyIG1vZGUgaW4gY29tbWFuZCBsaW5lIHdoaWNoIHdpbGwgb3ZlcnJpZGUNCj4g
PiB0aGUga2VybmVsIGNvbmZpZyBkZWZhdWx0IG9wdGlvbi4NCj4gPg0KPiA+IFsgICAgMC45MTc3
ODldIHVzYiB1c2I2OiBNYW51ZmFjdHVyZXI6IExpbnV4IDYuOS4wLXJjNi1hbWQtcHN0YXRlLW5l
dy1maXgtDQo+IHYxIHhoY2ktaGNkDQo+ID4gWyAgICAwLjk4MjU3OV0gYW1kX3BzdGF0ZTogZmFp
bGVkIHRvIHJlZ2lzdGVyIHdpdGggcmV0dXJuIC0yMg0KPiA+DQo+ID4gUmVwb3J0ZWQtYnk6IEFu
ZHJlaSBBbXVyYXJpdGVpIDxhbmRhbXVAcG9zdGVvLm5ldD4NCj4gPiBDbG9zZXM6IGh0dHBzOi8v
YnVnemlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MjE4NzA1DQo+ID4gU2lnbmVkLW9m
Zi1ieTogUGVycnkgWXVhbiA8cGVycnkueXVhbkBhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2
ZXJzL2NwdWZyZXEvYW1kLXBzdGF0ZS5jIHwgMjcgKysrKysrKysrKysrKysrKysrLS0tLS0tLS0t
DQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0K
PiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMNCj4gPiBi
L2RyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMgaW5kZXggZmE0ODZkZmFhN2U4Li42ZTVjMzk4
ODEwYmYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9jcHVmcmVxL2FtZC1wc3RhdGUuYw0KPiA+
ICsrKyBiL2RyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMNCj4gPiBAQCAtMTg0MSwyOCArMTg0
MSwzNyBAQCBzdGF0aWMgaW50IF9faW5pdCBhbWRfcHN0YXRlX2luaXQodm9pZCkNCj4gPiAgICAg
LyogY2hlY2sgaWYgdGhpcyBtYWNoaW5lIG5lZWQgQ1BQQyBxdWlya3MgKi8NCj4gPiAgICAgZG1p
X2NoZWNrX3N5c3RlbShhbWRfcHN0YXRlX3F1aXJrc190YWJsZSk7DQo+ID4NCj4gPiAtICAgc3dp
dGNoIChjcHBjX3N0YXRlKSB7DQo+ID4gLSAgIGNhc2UgQU1EX1BTVEFURV9VTkRFRklORUQ6DQo+
ID4gKyAgIC8qDQo+ID4gKyAgICAqIGdldCBkcml2ZXIgbW9kZSBmb3IgbG9hZGluZyBmcm9tIGNv
bW1hbmQgbGluZSBjaG9pY2Ugb3Iga2VybmVsDQo+IGNvbmZpZw0KPiA+ICsgICAgKiBjcHBjX3N0
YXRlIHdpbGwgYmUgQU1EX1BTVEFURV9VTkRFRklORUQgaWYgbm8gY29tbWFuZCBsaW5lDQo+IGlu
cHV0DQo+ID4gKyAgICAqIGNvbW1hbmQgbGluZSBjaG9pY2Ugd2lsbCBvdmVycmlkZSB0aGUga2Nv
bmZpZyBvcHRpb24NCj4gPiArICAgICovDQo+ID4gKyAgIGlmIChjcHBjX3N0YXRlID09IEFNRF9Q
U1RBVEVfVU5ERUZJTkVEKSB7DQo+ID4gKyAgICAgICAgICAgcHJfZXJyKCJweXVhbiBjcHBjX3N0
YXRlID09IEFNRF9QU1RBVEVfVU5ERUZJTkVEIFxuIik7DQo+DQo+IEFzIE1hcmlvIHBvaW50ZWQg
b3V0LCB0aGlzIG5lZWRzIHRvIGJlIHJlbW92ZWQgOi0pDQpZZXAgLCBJIGZvcmdldCB0byBkZWxl
dGUgaXQgd2hlbiBzZW5kaW5nIHRoZSBwYXRjaGVzIOKYuQ0KDQo+DQo+IFRoZSBmb2xsb3dpbmcg
cmV2aWV3IGNvbW1lbnRzIGFyZSBhc3N1bWluZyB0aGF0IHlvdSB3YW50IHRoaXMgcGF0Y2ggc28N
Cj4gdGhhdCBhbWQtcHN0YXRlIGlzIHRoZSBkZWZhdWx0IGRyaXZlciBvbiBzaGFyZWQtbWVtb3J5
IG5vbi1zZXJ2ZXINCj4gcGxhdGZvcm1zLg0KPg0KPg0KPiA+ICAgICAgICAgICAgIC8qIERpc2Fi
bGUgb24gdGhlIGZvbGxvd2luZyBjb25maWdzIGJ5IGRlZmF1bHQ6DQo+ID4gICAgICAgICAgICAg
ICogMS4gVW5kZWZpbmVkIHBsYXRmb3Jtcw0KPiA+ICAgICAgICAgICAgICAqIDIuIFNlcnZlciBw
bGF0Zm9ybXMNCj4gPiAgICAgICAgICAgICAgKiAzLiBTaGFyZWQgbWVtb3J5IGRlc2lnbnMNCj4N
Cj4gVGhlIGNvbW1lbnQgc2F5cyB0aGUgZHJpdmVyIG5lZWRzIHRvIGJlIGRpc2FibGVkIG9uIHRo
ZSBzaGFyZWQgbWVtb3J5DQo+IGRlc2lnbnMgYnkgZGVmYXVsdC4gQnV0Li4uDQoNClRoZSBjb21t
ZW50cyBuZWVkIHRvIGJlIHVwZGF0ZWQgbG9va3MgbGlrZS4NCg0KPg0KPg0KPg0KPiA+ICAgICAg
ICAgICAgICAqLw0KPiA+ICAgICAgICAgICAgIGlmIChhbWRfcHN0YXRlX2FjcGlfcG1fcHJvZmls
ZV91bmRlZmluZWQoKSB8fA0KPiA+IC0gICAgICAgICAgICAgICBhbWRfcHN0YXRlX2FjcGlfcG1f
cHJvZmlsZV9zZXJ2ZXIoKSB8fA0KPiA+IC0gICAgICAgICAgICAgICAhY3B1X2ZlYXR1cmVfZW5h
YmxlZChYODZfRkVBVFVSRV9DUFBDKSkgew0KPg0KPiAuLi50aGUgY2hlY2sgZm9yIHNoYXJlZC1t
ZW1vcnkgZGVzaWduIGhhcyBiZWVuIHJlbW92ZWQuIElzIHRoaXMNCj4gaW50ZW50aW9uYWwgPyBT
byBkbyB5b3Ugd2FudCB0aGUgY29tbWVudCB0byBiZSBmaXhlZCBzbyB0aGF0IGl0IGlzIGNsZWFy
IHRoYXQNCj4gd2Ugd2FudCBhbWQtcHN0YXRlIHRvIGJlIHRoZSBkZWZhdWx0IGRyaXZlciBvbiBu
b24tc2VydmVyIHBsYXRmb3JtcyA/DQoNCldlIGFyZSBnb2luZyB0byBtYWtlIHRoZSBwc3RhdGUg
ZHJpdmVyIGFzIGRlZmF1bHQgZHJpdmVyIG9uIGNsaWVudCBDUFVzLCBzZXJ2ZXIgQ1BVIHdpbGwg
bm90IGxvYWQgcHN0YXRlIGRyaXZlcnMgd2hlbiBubyBkcml2ZXIgbW9kZSBjb21tYW5kIGxpbmUg
YWRkZWQuDQoNCkkgYmVsaWV2ZSBpdCB3aWxsIHJldHVybiBUUlVFIG9uIGFsbCBzZXJ2ZXIgQ1BV
cyB3aXRoICIgYW1kX3BzdGF0ZV9hY3BpX3BtX3Byb2ZpbGVfc2VydmVyKCkgIiwgc28gc2VydmVy
IENQVSBpcyBub3QgaW1wYWN0ZWQuDQpFdmVuIHRoZSBzaGFyZWQgbWVtb3J5IHR5cGUgY2xpZW50
IHN5c3RlbSwgSSBndWVzcyBpdCBpcyBPSyB0byBsb2FkIHBzdGF0ZSBkcml2ZXIgc2luY2UgdGhp
cyBjaGFuZ2UuKEp1c3QgYSBmZXcgZ2VuZXJhdGlvbnMgQ1BVIHVzaW5nIHNoYXJlZCBtZW1vcnkp
DQpTb21lICBjdXN0b21lcnMgcmVwb3J0ZWQgdGhhdCBUUjQwIHN5c3RlbShzaGFyZWQgbWVtb3J5
KSBoYXMgYmV0dGVyIHBlcmZvcm1hbmNlIHRoYW4gYWNwaV9jcHVmcmVxLg0KDQpVc2VycyBjYW4g
ZGlzYWJsZSB0aGUgcHN0YXRlIGRyaXZlciBmcm9tIGtlcm5lbCBjb25maWcgb3IgY29tbWFuZCBs
aW5lLCAgZnJvbSB0aGUgaW5pdGlhbCBrZXJuZWwgY29uZmlnIHBhdGNoZXMgbWFkZSBieSBNYXJp
bywgdGhlIHB1cnBvc2UgaXMgbG9hZCBFUFAgZHJpdmVyIGJ5IGRlZmF1bHQuDQpJdCBqdXN0IGhh
ZCBhIGZldyB1bmV4cGVjdGVkIGxvYWRpbmcgaXNzdWVzIGZpeGVkIGJ5IHRoaXMgcGF0Y2guDQoN
Cj4NCj4NCj4NCj4gPiArICAgICAgICAgICAgICAgYW1kX3BzdGF0ZV9hY3BpX3BtX3Byb2ZpbGVf
c2VydmVyKCkpIHsNCj4gPiAgICAgICAgICAgICAgICAgICAgIHByX2luZm8oImRyaXZlciBsb2Fk
IGlzIGRpc2FibGVkLCBib290IHdpdGggc3BlY2lmaWMNCj4gbW9kZSB0byBlbmFibGUgdGhpc1xu
Iik7DQo+ID4gICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVOT0RFVjsNCj4gPiAgICAgICAg
ICAgICB9DQo+ID4gLSAgICAgICAgICAgcmV0ID0NCj4gYW1kX3BzdGF0ZV9zZXRfZHJpdmVyKENP
TkZJR19YODZfQU1EX1BTVEFURV9ERUZBVUxUX01PREUpOw0KPiA+IC0gICAgICAgICAgIGlmIChy
ZXQpDQo+ID4gLSAgICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiA+IC0gICAgICAgICAg
IGJyZWFrOw0KPiA+ICsgICAgICAgICAgIC8qIGdldCBkcml2ZXIgbW9kZSBmcm9tIGtlcm5lbCBj
b25maWcgb3B0aW9uIFsxOjRdICovDQo+ID4gKyAgICAgICAgICAgY3BwY19zdGF0ZSA9IENPTkZJ
R19YODZfQU1EX1BTVEFURV9ERUZBVUxUX01PREU7DQo+DQo+IElmIHNvbWVvbmUgYm9vdGVkIHRo
ZSBzeXN0ZW0gd2l0aCAiYW1kX3BzdGF0ZT1kaXNhYmxlIiwgdGhlIGFib3ZlIHdpbGwNCj4gb3Zl
cndyaXRlIHRoYXQgcHJlZmVyZW5jZSwgbm8gPw0KDQpDb21tYW5kIGxpbmUgd2lsbCBvdmVycmlk
ZSBrZXJuZWwgY29uZmlnIGFueXdheS4gYW1kX3BzdGF0ZT1kaXNhYmxlIHdpbGwgd29yayBvciBk
aXNhYmxlIGZyb20gS2NvbmZpZy4NCg0KPg0KPiA+ICsgICB9DQo+ID4gKw0KPiA+ICsgICBzd2l0
Y2ggKGNwcGNfc3RhdGUpIHsNCj4gPiAgICAgY2FzZSBBTURfUFNUQVRFX0RJU0FCTEU6DQo+ID4g
KyAgICAgICAgICAgcHJfaW5mbygiZHJpdmVyIGxvYWQgaXMgZGlzYWJsZWQsIGJvb3Qgd2l0aCBz
cGVjaWZpYyBtb2RlIHRvDQo+IGVuYWJsZQ0KPiA+ICt0aGlzXG4iKTsNCj4gPiAgICAgICAgICAg
ICByZXR1cm4gLUVOT0RFVjsNCj4NCj4gLi4uLmFuZCB0aGlzICJjYXNlIiBzdGF0ZW1lbnQgd2ls
bCBuZXZlciBiZSByZWFjaGFibGUgaW4gdGhlIGFmb3JlbWVudGlvbmVkDQo+IGNhc2UuDQoNCkl0
IHdpbGwgYmUgY2FsbGVkIHdoZW4ga2VybmVsIGNvbmZpZyBzZXQgImRpc2FibGUiIHN0YXRlIGZy
b20ga2VybmVsIGJvb3RpbmcuDQoNCg0KPg0KPg0KPiA+ICAgICBjYXNlIEFNRF9QU1RBVEVfUEFT
U0lWRToNCj4gPiAgICAgY2FzZSBBTURfUFNUQVRFX0FDVElWRToNCj4gPiAgICAgY2FzZSBBTURf
UFNUQVRFX0dVSURFRDoNCj4gPiArICAgICAgICAgICByZXQgPSBhbWRfcHN0YXRlX3NldF9kcml2
ZXIoY3BwY19zdGF0ZSk7DQo+ID4gKyAgICAgICAgICAgaWYgKHJldCkNCj4gPiArICAgICAgICAg
ICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4gICAgICAgICAgICAgYnJlYWs7DQo+ID4gICAgIGRl
ZmF1bHQ6DQo+ID4gICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4gQEAgLTE4ODMsNyAr
MTg5Miw3IEBAIHN0YXRpYyBpbnQgX19pbml0IGFtZF9wc3RhdGVfaW5pdCh2b2lkKQ0KPiA+ICAg
ICAvKiBlbmFibGUgYW1kIHBzdGF0ZSBmZWF0dXJlICovDQo+ID4gICAgIHJldCA9IGFtZF9wc3Rh
dGVfZW5hYmxlKHRydWUpOw0KPiA+ICAgICBpZiAocmV0KSB7DQo+ID4gLSAgICAgICAgICAgcHJf
ZXJyKCJmYWlsZWQgdG8gZW5hYmxlIHdpdGggcmV0dXJuICVkXG4iLCByZXQpOw0KPiA+ICsgICAg
ICAgICAgIHByX2VycigiZmFpbGVkIHRvIGVuYWJsZSBkcml2ZXIgbW9kZSglZClcbiIsIGNwcGNf
c3RhdGUpOw0KPiA+ICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4gICAgIH0NCj4gPg0KPiA+
IC0tDQo+ID4gMi4zNC4xDQo=

