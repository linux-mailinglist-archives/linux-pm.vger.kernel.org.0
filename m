Return-Path: <linux-pm+bounces-37059-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A420C1C512
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 18:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E50C75831BE
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 16:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A732797B5;
	Wed, 29 Oct 2025 16:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LKupeV9K"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F2424C076
	for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2025 16:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761756383; cv=fail; b=FCZci5cq2HZmkyOtLxujKaPllbETd1lhFuURQkl7Nc43lTgXqFInb458IQchO91wGykGXUcBbwQS+8bC+ldiRId6/xEs1ZPnbPEqyVkMMFBreihZTTjbP+Z9jp9AVrc71Q8sBcWRVSzfjqMydd9AT0EqGpxKZjX7decvuHrGpuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761756383; c=relaxed/simple;
	bh=wMThCz/qFopeFHvE53HsjheIiHruhX5SxE960fgs17k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R6qZoj0oGBiZOZtE6L0lFuMRwa+v4ZAjDyQqLxp81NaS6owtMa3gU5waS5G7PmW/49XdRRpJDa00uDsRt52X0C2/XzzQ2TgnwbhtarBSlW1qR6xx8X2kr9+1JyYDhuJI+2CgleDPqhPOq/GUGC77rW9UBuLiEvBccYMDc+0tyJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LKupeV9K; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761756381; x=1793292381;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wMThCz/qFopeFHvE53HsjheIiHruhX5SxE960fgs17k=;
  b=LKupeV9KXZO/tGKw45HWEDnolPuZIpiQVTUwBb6LNJWUb2FXna36vu6+
   7mtJ1HIDQbsZEX3JmSE4IB6x/zyRAF48UiJ0lhpmP/QZ0ItVzO4+wvg/9
   oVgyZvtdJMKqLZxv74hkNaePkKVu3GiQE48dhRLPCNRmeCn035ADzrs+r
   Nk5HTJahcFZ+pm8DXrsKNL5+n6rbAWL5hNXxbrjIlQXOZq/qESvie2uAt
   GFpnd8GKlbgVCCB9kPqTiADR9LcBYOt0Vpnl4dqczP2fGPcPUyuMd+8P9
   AvuCEZjGBT9vwTnQHoQzuahi8X67wDlp3PD2PS+doH45BTVsoHoY5P+3Z
   g==;
X-CSE-ConnectionGUID: oHdnXJ0TTmSyaDaOu/gkSA==
X-CSE-MsgGUID: TUk5zf+YSdW2kb8Hw/ax6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="75003496"
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="75003496"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 09:46:21 -0700
X-CSE-ConnectionGUID: VQV1i444QM2HSNuTRY2O8A==
X-CSE-MsgGUID: Cvz9+xlJQPiw6+nzkic0Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="184963459"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 09:46:21 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 09:46:20 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 29 Oct 2025 09:46:20 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.62) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 09:46:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pbjQ03ZGxNXx8SlCli3z2WuQsZ7Aw0qabZX9b3EJC0n0v5a6z7NbJ5vAMJjVfuFWetMXHkx5KyS990othjfGZR2COlEz/jwyMQgh0MDQasvICMHMm4y7ikSOwJINKPQCUg18aX8IJH9qIYODF/k7O/KL1LERiwz88kT2i9GsuicHnJPYnrKXwqjCwHQDanmGSIGUqZeXtbZLwhBk4Vh3/U+/0VhTj8yFDrhpv5uK6OSBmz16kgV/StGfgKDq44u70dz5eG95ZwYcHmtA/CDcW8nZsF6Re1ecVEwGyy2lFYzGQq4SF40w9SWvv/Aii/aRMZ5ULmYEbM+dMF5ahXGuog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wMThCz/qFopeFHvE53HsjheIiHruhX5SxE960fgs17k=;
 b=Ti4TLTKC9Se8nQRbvvZQPr9uQlbF79RXLLnINxtGiWqtKQmDZ9pEtEhWurCE5HDawH6LxlvSR8Zx+g1Fm5kVhjbGFAk9L11pivzmHNYgsOr/KCVZOwvh0OOPmmdPtjS//rr8mD/8b3hYhkEtHPYuK1Ikc67bQf9JCcPQlCNB9sK0/cc7LmE+JtlEkrJto6zJyW/kzIkwP3E6OwB8EiwKsN4GWsQ+vcIhpkYgAsvcXjEiFXApGofnfDAsqdqBcfK+G316bwNQZmE/0TZ6VbdN3Po0R6gdKrQplMmtJhhol40BDC7o4e/jR/p51JljPcOJt4u3Hnzv2LHPhk9mKAFHcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8768.namprd11.prod.outlook.com (2603:10b6:408:211::19)
 by CY5PR11MB6437.namprd11.prod.outlook.com (2603:10b6:930:36::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 16:46:18 +0000
Received: from LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308]) by LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308%6]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 16:46:18 +0000
From: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: "Luck, Tony" <tony.luck@intel.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>
Subject: RE: [PATCH v3] ACPI: mrrm: Fix memory leaks and improve error
 handling
Thread-Topic: [PATCH v3] ACPI: mrrm: Fix memory leaks and improve error
 handling
Thread-Index: AQHcSO6RIrxJqn7/BUimhtszDYxQRrTZVKSg
Date: Wed, 29 Oct 2025 16:46:18 +0000
Message-ID: <LV3PR11MB87681EE7CF5103CB6F68F49FF5FAA@LV3PR11MB8768.namprd11.prod.outlook.com>
References: <20251029154329.3939680-1-kaushlendra.kumar@intel.com>
 <CAJZ5v0itwsggK1JwL8h86Pow7vLkgfg6w1TKXaR3wk6rbrfXdw@mail.gmail.com>
In-Reply-To: <CAJZ5v0itwsggK1JwL8h86Pow7vLkgfg6w1TKXaR3wk6rbrfXdw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR11MB8768:EE_|CY5PR11MB6437:EE_
x-ms-office365-filtering-correlation-id: d0d943a1-e870-466c-aeb2-08de170aaecf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?VGhXcnZ3MHF1KzV3VUZVMXJFQVlGdm9BYUFJUWNZR2NIZk9PSXorTGVSSUdx?=
 =?utf-8?B?T2ZtV1NqaHZQVS95c3hMN0F5T1pLR21DVnB6UU1OOTQveXJ4dXlGSnRKUlA4?=
 =?utf-8?B?VUI2L0E0bkp4eFYyRnVBOXozdjI2aUZTSWFkYjZRTldTUU10ekFTK0VEODBX?=
 =?utf-8?B?QmpvZVBmeHh0MTV1d0ZLSmUvZkNkUTZ1dncreVlNYmM2alVBUTJzM1dkbFdH?=
 =?utf-8?B?T2E4MDB6UERKZTlnalJudnJnQTVCb1dPQ3VmcWp5bUU2cVdHb0dwRXdXdngv?=
 =?utf-8?B?NkgzZXVEWUZEKzZ5YURNU0pSWndya3NtN05kdStDS2tvWGFtekJoMVRLVEpa?=
 =?utf-8?B?bU1WRldrQXNUdFJ2RHdidkszMjMvT1NQSjFVTjJ2aFJ0UnhmMjQ2VXUra0Fo?=
 =?utf-8?B?RWxoSjZSRWNiOExHSWtiTkVkRWI2UXBBb2ljVXhCSUJXNDlobnFqOS9JL016?=
 =?utf-8?B?bXkwMHpXWXVWUzlFOThsSU1OQjZQQmpHNks1U2t4TVFidng2RGhZRHpueXhO?=
 =?utf-8?B?Vnp6UDFKb080OHJzakY2Wldtb3lJbE5yWFVxNnVJNjd3RExFL0NkaFJqVXh2?=
 =?utf-8?B?L3J4MUc5eVJlWDBxdG5lR0UxTHNiREdPQzA5UEdKaVl2SU0xVHZWaVJrYzJQ?=
 =?utf-8?B?VWFKWS9ESVF3ZzBhZDM1aC8zOXJlNFJGNkt4UTVOYldQdVllYnMrM056ak5t?=
 =?utf-8?B?dXgxb0Q1b290ZFlqMEJwZFBMcHRiWWI3amlUVjJLT0pOalUrM0dCNXg1eDdU?=
 =?utf-8?B?enpXMUhhOEZnRkJaeUl6QzdSTitIcGp4R1hDYUJGbjBHOWZyOWRpN3hwUStU?=
 =?utf-8?B?bUZGWHVBRE9YME10RFFLUFY1eGlTbk1CQ3dwSWVHNlZTYjFhRWJaNlpSZk8v?=
 =?utf-8?B?eStlY0U4NmNjNGNhV1dUR1EzL3AyZlNybTQvRVFHRFBFcVNNN0o4SkFtbDkx?=
 =?utf-8?B?Z3Q5d21hN2p2V29OUW5LR0RiV3IvS2dYemZVbDdGcG8zMmZvVHh1bkZhcnp3?=
 =?utf-8?B?WFIxVzlsOU9qOXMzMkgwRE8zTjNZMHNVa1JXWVNsMjYxT0FLb2FDQnk0alFh?=
 =?utf-8?B?OTZWUFl3WVVhWmlhN3NJNmpLdEYyTC9lL2xPT0laUEFJd3NzdGJXOTV1bnRr?=
 =?utf-8?B?d0lSNTZLOFd1MEVHWlpRczBEU0RLQ3JOUDlGUnlSVGhzYmFMclpCUzU2eGhx?=
 =?utf-8?B?aHJTM0dyQnVVdWFpaHJIMmNIdnpnWG9JVndQK2F6YzJqQ0h5MWFla0gvOFFW?=
 =?utf-8?B?WXZiZXVOY1VYS3luOE8yK2ljakd1dSthNzEveXkwZGovVjl4ckkvbVJBdlY5?=
 =?utf-8?B?QXU3ODBNSnFOM3V4RW5FRHMwbWNHdk1SdWxnV3RrKzBRbDQrclZwWDVXc3N1?=
 =?utf-8?B?R1Nyb1FxbVJYTGhoY0RjTS9MQmJQRThuLy9saER2S2t4ZExTazNTazRGUTNZ?=
 =?utf-8?B?QXJURmxCNE40dzR6ZW1XWDJjdE8vSnhFQVB1SXNYWU56Zy91dVF4Mi9jQngx?=
 =?utf-8?B?OVkzVmhPVEVEMjN4ZG9XeHZ4RS8rRGRxOGVtZDB0cGx0Vmxlam9PQnB6YkFl?=
 =?utf-8?B?QXVVSGU2N2hKZitCMmE3dU8xbGJVZkNQbzh6d3ppS1JENlZkWXNpSHQ0TnQ5?=
 =?utf-8?B?QWJpVzhkT0VzYklkY1V6N2NobEhUSEZzTXo5OWxOOXRDQVkvdnFHSCtlMGtB?=
 =?utf-8?B?RCtUeCsxNFZMRTlYNTQ1amt2NEhaMzM3dk9yYlIyWEtmbWVvRTVEVlNkTjVY?=
 =?utf-8?B?K3VZVzBFQzFTejJpMVZ2Z3FRSDQxYStrVWM3dWtuQzd6UlhoZUJLOS80R053?=
 =?utf-8?B?K1hHSVh6NXhmZHFyN3ZSZGhtTEdjUjJmV3FUNXhwTG5rbkNpT2VBL1BMZkxV?=
 =?utf-8?B?M1IwRlVyUERnSlpkN2ZOOHQwUlc5a1QraEszTkZFK3VxQmo5M0Jtc29oTUhr?=
 =?utf-8?B?UTVHSVNjSElDZy9kQ0UzcXRIWGhUaUxDK0tLQ2JLOGxjVjYwYThYblRyWjVz?=
 =?utf-8?B?N0p6S0ZtMDU2NDlhd0k1bW5MdXQ3Y1JPeDFkR2VQWSsweXJ2WHhoM0dGVlBZ?=
 =?utf-8?Q?e8HKpC?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDhEMzVlZ3RIMnp4ZW1xNGZnZ2lXaWlmZTNYL1U1TGxXK25qL2ZxZ3JLMUdp?=
 =?utf-8?B?NGRlVUhrZWlYYkJKZW1pekFjUURuWlRGbmhxeWd3eTZUbk5lUzcvcVFyVmZD?=
 =?utf-8?B?WjZaTWpUUGlqTHRQN282UUREd3Z2Yng4eHV2eFhBcENkcXpBVWl4QlFGeHBR?=
 =?utf-8?B?SHc5NjF2Sk5jMjNuK2VOb2EzZUFTa3RwL1lhMm1xeThVWWZFUTZsNHptbGRj?=
 =?utf-8?B?OEFmMHZaU1YwYnJjVkJtb3FrU0VtNk1ieUNMazJ4NzBiblNGZkMvMTUvc2tT?=
 =?utf-8?B?RHNEYkpSUmd1ZEExTG44VUQ2a1o1VTBNMjk5ZS9RUmZ3U1ovUnNncHlBY2xS?=
 =?utf-8?B?OGZDeWc3c3pCQnhPTTFGRHpOU045VGdhaDFOQzYwS2c1dXFNTGFnUysvaDVn?=
 =?utf-8?B?d0pqc2tsTUs1N3pEMWNneGVFMFpOTi9oSXlHUWdFUDJRa1hqR0wrcFF2dHZa?=
 =?utf-8?B?eDZoWmVvQnRIc0RFTDg2NldsdDZWZ2lwRU12T2hndnpWR0R4NTNHL0NXT2Yw?=
 =?utf-8?B?aVg4QnJTTFlRVk15U1dQbmZZVVNTbmgvakRFeEt0S0Q4UmNlOTI5V0Y1K0J1?=
 =?utf-8?B?VDFRM1pmRFhjZjhuN3JQc3FpemZySzRxTE1VS2lJYlFiN1pxNldOTnY1bHhS?=
 =?utf-8?B?OStSMlJzK1MzOG1TeXFyQkEvbjJQQzJ2Q2s5TzcxczhEV29IU0lEQjh1NStw?=
 =?utf-8?B?TWttazdGYVExMkhxM1JhaWpoZzhpd0FmbmpXNmwraXhxOVVQNmVsbE1VR0Zm?=
 =?utf-8?B?OFc1Um5sNmpES1MvaXFKaHI3T3E1dkVDM1IxVDdLWHNzUlNGd1kzeDRjMzNP?=
 =?utf-8?B?bzRacHN3ZURRb2lCbmNrcGpHR2hldEJRUEltb3pSUW1uay9KdWNzei9ORjZR?=
 =?utf-8?B?Y21JUmtYQk9FWGVsWURYcGpOSFVyMHJ6Nk84N3IvR3JSelJKeGJaZXAvUFdD?=
 =?utf-8?B?elB3Q1N0NWtKSW54V2VNQjdKOTZ5TDFZVWRLLzVDMGhMTkI4dXRGb2ZNZ1Bi?=
 =?utf-8?B?d1BKNms0YTFRR1BDTE94bVJicUFDR29jUjRZdGNuQXlKMlViNXVGK1IwWGYz?=
 =?utf-8?B?ZXpLRFRmV1pZTkdlb0dDOFd5VnlKMFVOekUrM1VJeDZmbWtlQzdiTjI0cFVJ?=
 =?utf-8?B?N3h1QjRBdnJoL0lWa3E1Z01SYm1lTzROclNuNDZ4SFYxRXZUZHpYZVozdC9D?=
 =?utf-8?B?ZGFJa094RTBrTjgrKzkyMVlqQjlNdWxhcEdaY2tkREt6NTdVY2V0MlN5anRl?=
 =?utf-8?B?TmxncU5PT01NbHYzeStNd0RuQjAxN2tWdHdCZXZtT0pvazVobEsxUUQ2VXUy?=
 =?utf-8?B?bUJrRXhHL3VscG5ISEFaYzZXOGZ2UzJLZ1E3YlpMeHBsQS9hWW9HanU3K29W?=
 =?utf-8?B?OUYrcFhFNFBxWkZPLzl6R0wxMFltZ055aWkzTGgzcXRzVC9UL2UySWxHeDJo?=
 =?utf-8?B?SXZ4QXhZajBRMEFFRnNJQUhCZ2ZLdlRWeXFUOXhMT3YxejlUbUxKQVJUU29i?=
 =?utf-8?B?K3czSUZ3bE8zMlhqZEhNRVFRc3VqSkFlOTQ4VVZuYkRsNERFcmkzdEhEa1c0?=
 =?utf-8?B?SlFBaHo0TGpoaGR5S0RJakhVMVNoOGZFYW0wbzFjZ0p1OEw5QU1iMzVPV2Fh?=
 =?utf-8?B?RGthOGFxRWV3SjFWY3hOMkdJZ0ZRL012S2xvUXFHMi9NNDJ3S1kzeTZMR3NR?=
 =?utf-8?B?N0Y0MTg0SC9UWWVoU0d5UnJTWURLOVc5OWxBVGx3KzAwMHV2K2RRei9FN25j?=
 =?utf-8?B?MFZlMmZOc2JUd0p6VkdLclVWbm9KSlZHbEZSM0dHN2ZKUWJ2a3YwM3NNYlp2?=
 =?utf-8?B?c2tSZ2RrRCtIdmxudVNqOGpNVDZCSFZuWit1WC9hWTllRjFaMHYyY0p4a3o4?=
 =?utf-8?B?Mm5wNDRaUkRJU1AxSDdFNHZZc1RhYVU5bXNySG00OTgycTVRM1Z3aDZjWVZO?=
 =?utf-8?B?cEltL0dmSC9pSy9vNENSTGJubFJPZUNGT1BOK0FRckNUTXU0dFRpSCt3RjE5?=
 =?utf-8?B?blFFUlY3cncwVmd4a2FBdFFYc002a2dvMW90RDZuVmw0cXVMUFQzK0JIdXVC?=
 =?utf-8?B?U1ptenRlb3BTYTdESUtHZ25idGtGRHlnMVpnRStwOFZ5eE80ZE9SYjVpV0xL?=
 =?utf-8?B?aFFKbllWZThKWTJyZGRSYy83WEJuMlpzOGw2Q0QyeHVnOXRzb1ovT1pzUWpL?=
 =?utf-8?B?L0VBMUoyRFdkTWlBN0IwdVJlc3JVQkdzRStkWVZ2Z3E5L1h6LzZhSm1mL2t3?=
 =?utf-8?B?MmFjc09HVS9BTXc1WHlHeDE4a3F3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0d943a1-e870-466c-aeb2-08de170aaecf
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 16:46:18.2845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: twHKb/Bi4VmxHl8uvvS2U5hu3guMzzYELwhXpFPKgywnKJK8UJ+vtvqhwBldetzmtkjBaZiYs+8Cru2bGfnkrhM2DACOhaGiaRSHoY2OB70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6437
X-OriginatorOrg: intel.com

T24gV2VkLCBPY3QgMjksIDIwMjUgYXQgNDo0NSBQTSBLYXVzaGxlbmRyYSBLdW1hciA8a2F1c2hs
ZW5kcmEua3VtYXJAaW50ZWwuY29tPiB3cm90ZToNCj4gKyAgICAgICAgICAgICAgIHNucHJpbnRm
KG5hbWUsIHNpemVvZihuYW1lKSwgInJhbmdlJWQiLCBpKTsNCj4gDQo+IFNvIHNvbWVvbmUgd2ls
bCBzdWJzZXF1ZW50bHkgc2VuZCBhIHBhdGNoIHRvIHJlcGxhY2UgdGhpcyB3aXRoIHNjbnByaW50
ZigpLg0KDQpHb29kIHBvaW50ISBJJ2xsIHVzZSBzY25wcmludGYoKSBpbiB2NCB0byBiZSBmdXR1
cmUtcHJvb2YgYW5kIGF2b2lkIHRoZSANCnBvdGVudGlhbCBmb2xsb3ctdXAgcGF0Y2guDQoNCkJS
LA0KS2F1c2hsZW5kcmENCg==

