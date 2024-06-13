Return-Path: <linux-pm+bounces-9068-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6889067E9
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 10:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23690287EB3
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 08:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AFC13D276;
	Thu, 13 Jun 2024 08:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iJu7aqYA"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8AA39FCE;
	Thu, 13 Jun 2024 08:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718269158; cv=fail; b=gWd03xXchpCyQIqmlKkTRfFjadPtSm+Mz+Tfp5U7lPeCH+HDIvCwp2/8NfyyNHrNFzleCQj6aW2LW5uoIikRRahQMSrtqO241ctznI6QPsYXRZI6A/RcX9QH5kO/HAv9sRH29mdpRs9O3A/bUHdUvOPjbmDYflKZTU6Asqw/2bQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718269158; c=relaxed/simple;
	bh=jbaAIDeLIersN65OKKSE4N135PVrtqENapV48zJL1JM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=asYz4oTWLnF7BuyCMsv02UA/2a5xFCpcREPPSQHnoy/PBgo5/im1XL6KhMeABdNSVwISZ8iKVA3/VBnCoeJER06SJwsSsqajh9wPPZ2cGLbEQiwDdjlyZ5LmTVg1z3NJLhr/WFMdTWgfJYTrYS0oo6mlSKIf1Vg4WhIOo/mpt/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iJu7aqYA; arc=fail smtp.client-ip=40.107.243.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OCmThgywxbLjKd45J9N5FcBACNYJtb+oNiEH8aabP7x0R0P5cnEDG4kq31zig/ATmz4xVIokqgc/2/OykBoe05lwFLOF4/j6yO5W17dBs8pxC7WjGgTC4A188xmjY2znXu9aB8BrADclIMXu67mMBXc7TcYTG+OKpmu64Wfj+KrfPs5qy/l8hm42fXWV5QWwXNMdZkG552yQDNC/jc0w/ssrt/5XFsvkBzY4G9LXC6mP62BLbS19dDCG6hgKyaARoXLU2kxacwidiJdZIaibYwoRxKbUfqjMc2CQW9LclDaZ+kLRz/DRi9U/OXSFKMLxCkFg1Yyj8ef8CVy4fDp5NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbaAIDeLIersN65OKKSE4N135PVrtqENapV48zJL1JM=;
 b=FhYUQNjjKburDI8+9a2aE/QXmvR5LQDoOBDAFfHb4oiA3yVSJfCadf07WICw/bJkx5qCW5s8CqeV/OO5Htr8rfvIaqtT3PesH/wPW7X3VbWq+vOb8U68eUD8arzZwyocprOGxSS+tbh6WfOWogoVyeDWmuuboY0FlN97zPbAHvBIs+2A69MDnaE2/h+ks6IDOzzLtV+S+nowK8Td6fhfDzBsEw5qczeu1grkMaVJ7nZivrix9XacHPeDrEq4e2a4PoLxLBLMlYOlrg4IhhZ+QBLMzZtfOM1nsBXi8T3CyKLJB/e5gvEpwGTQ1m9lr5OTnR6Goe/Dsd2n/Gg0Qepn0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbaAIDeLIersN65OKKSE4N135PVrtqENapV48zJL1JM=;
 b=iJu7aqYAUfjkt2rpOvSp4CbN7EaGkRyDjOgWpz7lP10UcFNPoW3oCRO+tjr+Sj6Tmngl/L6qqYC8lsUqHgYJs0FnFEYpFGuUE5Dx25d9QRwRTG5Rl4q1ylDuPhFLCvaaCsdkxZNHcG3hjitJEy1eqyBbkodyDuved3XZMXbe+do=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by BL1PR12MB5803.namprd12.prod.outlook.com (2603:10b6:208:393::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Thu, 13 Jun
 2024 08:59:12 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf%6]) with mapi id 15.20.7633.037; Thu, 13 Jun 2024
 08:59:11 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: Borislav Petkov <bp@alien8.de>, "Limonciello, Mario"
	<Mario.Limonciello@amd.com>
CC: "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
	"rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
	"viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "Huang, Ray"
	<Ray.Huang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
	"Huang, Shimmer" <Shimmer.Huang@amd.com>, "Du, Xiaojian"
	<Xiaojian.Du@amd.com>, "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 08/10] x86/cpufeatures: Add feature bits for AMD
 heterogeneous processor
Thread-Topic: [PATCH v3 08/10] x86/cpufeatures: Add feature bits for AMD
 heterogeneous processor
Thread-Index: AQHau90G8QVrcguDBEaZ7RGMpjsNobHCYyuAgAA9UQCAAAIegIACxTWQ
Date: Thu, 13 Jun 2024 08:59:11 +0000
Message-ID:
 <CYYPR12MB8655D1333B53BB6DC83E45649CC12@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <cover.1718095377.git.perry.yuan@amd.com>
 <7a2817ce6e8e6a2787bed8285dba8d81423d8414.1718095377.git.perry.yuan@amd.com>
 <20240611105216.GAZmgsYC-J_yLfdupF@fat_crate.local>
 <e41fd460-6b50-4792-9328-3eda370672e4@amd.com>
 <20240611143929.GEZmhhoW1qCvIWS0SK@fat_crate.local>
In-Reply-To: <20240611143929.GEZmhhoW1qCvIWS0SK@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=065c465c-63a0-4c64-8a9e-248229debf76;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-13T08:57:49Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|BL1PR12MB5803:EE_
x-ms-office365-filtering-correlation-id: 946150f1-527a-4470-f64b-08dc8b8717fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230034|376008|1800799018|366010|38070700012;
x-microsoft-antispam-message-info:
 =?utf-8?B?WkNteVRCNE9XTmRmRW5hSHBvanJnOVlGMjBxZmhLbk0zOFA3QUo5ZXEvNE5n?=
 =?utf-8?B?SU1URGlyTW5TUFhCUWVkMmJ5cXZCOXl0RnlUeFZyanZDczRQdnIyOFRsa0Yx?=
 =?utf-8?B?RHY5eFBNVFg4VVdCZUZzOVJGZ2dMaEpiOG9YSWNDbzV3M1p5dGVDbEd3STVz?=
 =?utf-8?B?aU5VWGY1N1N3Z1ZMamNDK3M5dFdyK29Vc0U0WnZaRzY1anhnQy9rL0ZWNFJJ?=
 =?utf-8?B?L1hNem95Qk9adEQwZ3pXNXd1WlgvOXVHRjdvMDNUU000anJ1M3ZuTVRWbWlS?=
 =?utf-8?B?TzMvUXVzS2tpeVVqdjdxcTFweTdSVWdNUzFVQjBWK0NTNVQ4WVhtZ0wrZG9N?=
 =?utf-8?B?WVJPSmFaUzVoUXJnQXFkZjJWN0tKR0FRbWhCOTliSFJIcnh3LzJYSnF1ZElS?=
 =?utf-8?B?Mk5Fck5pRnRnNktXUEZwdkpUQVB6Mi9nYTJxZVNGMkY5cnU4d2VCdnIwS2RT?=
 =?utf-8?B?S0dwT25BU0pHRmd1Ym56VyttZHQzNjNROEVDNy9wRzBrZ2Fhd2xXc1hNVHlQ?=
 =?utf-8?B?Y1VId3Y2V3RPeUpOYUYxMVQ1eHVyODRvaENUdXY5YlhDbUdjT3g0Nm5mYkpi?=
 =?utf-8?B?cGRwbTl0T2pqOWhVbTNIWXM0dHRyQ3ZvTTVhMzMrcFMwWHpVSU5KTXBvc0VT?=
 =?utf-8?B?bGprWXBmc1FqTE13MFFxS3E0QVpTZGVDOGpVajQ1TXJyMks4NkQ1OU8vUDdE?=
 =?utf-8?B?NXBBVVoxSU5FRVZuUk95aS9yT1dYdFZKMmRmRDA1cnJSOTUrUWUwc3I4em9J?=
 =?utf-8?B?QURTclVyc1BnM0xSN0hrd0VmZjZhSzZaNWsrRzZTbzAzM1pNTnluYWFjR1k0?=
 =?utf-8?B?QWorelcrSloyYnpJVVU0S2M5TWhWR25tT01yV1JRQTZIdnVrM2NlQ204clQz?=
 =?utf-8?B?NE51cVhmSnJGVTI1RFhDczdDSmh3OWR3QmJIaGtUTFpvRzA0c0d0bW5FQUkz?=
 =?utf-8?B?Yjh2dHVXaGVNN3NPM25HTTNDNDFTVFhRMXFGZVN1eHRPOGo5RkhXRis1b2Uv?=
 =?utf-8?B?djNEb3NmaXo2R2dRQ3NKYVZNVHlOTk92eXZGSDZla2RQRjN6M2F2bnJUMTFK?=
 =?utf-8?B?YXpkc1ZLUENFcVloVVJ6OGY1NUlCU2NDTDhUSUVrS1JaVUlzY3hFL2VRcnIr?=
 =?utf-8?B?Y0VCMTVQMWNuT01pNTdMVWIxczE0QmtZTklWYnkxT0FOUUhVMnVkbVJDb0hN?=
 =?utf-8?B?bVZTSUpQb1p0amhwbzhhaGFLZTJBMXJobGR5OGZUbXhCUVNuN0l1cnpYeXlK?=
 =?utf-8?B?V1pjNmpZeVdWYmljS1dCN0gxNlhmamhEMTRtd092OGRDTW4vakNmZWwzZzU0?=
 =?utf-8?B?U0l6OU81SUpVK2svaHFIRVExYUJjczQwem5JejJVSVdHektobjFnU3k0Rm5v?=
 =?utf-8?B?VGFFTFowZVZBOVdvR1l2cGJmSERaQzl5NzdTeVFzbWwzSkxtNGNkeVQzTGht?=
 =?utf-8?B?Q2JMMUtOZXViR2lhNDlkb2ZURjJ1bHVqeXdCVTg0Rk95Nk0xdFlPK1NuS2dy?=
 =?utf-8?B?TSt5ZjgxTzY0RnEzbkM1bXh4OVVCREY5NGJaR2VTRmxYZ3dNVlZBbVRzR1E4?=
 =?utf-8?B?WHZhbjRJeUNFWWh2YVg1VTBVN3RiNjZkNTlRSSszUG9VbmhxOHNSd3IzWlFs?=
 =?utf-8?B?a0xjT29xNExjQ1UyTXppOEVvMmZ4Tm9vMi83SWFJMUZTVVNMaXB5ME44MEhB?=
 =?utf-8?B?KzRTa2lQc2xLL2hrQ3FTTTU4QWZ2R2dZZ1pwYysrcHRUckRzK1k5aS9RK3BG?=
 =?utf-8?B?U20wNzJyZWlPWW01NkpYY2o3WG55SDNXV01UWDhOaFh3RE9hdVdWenlrazVQ?=
 =?utf-8?Q?CWROHQinvvK6HtxEkJK9tO7sV4GE3KXetmT5M=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230034)(376008)(1800799018)(366010)(38070700012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?clFEakdkeUtmNnRQMjY0cnRlWCtCTFQ3TVJLUVJpM0hSOWl5YkNkUUtIOHQz?=
 =?utf-8?B?RlUxWmJ4SUNmOVM3OHk2Vkt5czVWK0l1U3Q0UGE4cDZRSjBOMlNLMzRlMmti?=
 =?utf-8?B?amIzeHI5Z3NuUEZ6S1NQZ0s5U0NhUnNUaEJyMktmbXowNW1OZmI2OUxjbXg4?=
 =?utf-8?B?TDV2OXFnVlVnbmdGdzJqMUdmTGo4LzY1bWlqeVdEcjgrcTRQVnJRd3NhOE9u?=
 =?utf-8?B?cmtKTDh4MXd3eXRZbitDTUJHYitsOFFVRnBzTkRCMGhxSEJDTjdtN3dzNWdy?=
 =?utf-8?B?SXE4M20yanFVZkM2bXF1N1lIdnE2Q1VEK2dWUDc4T003dGtVem9tWUVBcTh5?=
 =?utf-8?B?a2h6RzRHbDc1ZXAxbWVvdTV4WWRVQkpFcTIrMUxJZmVRRHBQZTRwcTJENXF6?=
 =?utf-8?B?OGdGZS9wajhrK282THdwQzVwU2lRK0VvSmVraFBqdEF1enJZWGhtUE9WK2NL?=
 =?utf-8?B?R3hPQWdUdzNYSVgxdW1CRUZMSE0xOWpaQmtINnVoeXY3aU1CWWdmKzU4TEVi?=
 =?utf-8?B?RnlrWjFacXdZVTFNTi9TeEdVZ2VFSlRmK1ovVUdhOTY4Vk9pdndsQ1Jydkk1?=
 =?utf-8?B?MmYvVURsV0w0bkxKTXlkRDhaRWVFVXFJVkZOWi9IMjdwcUppQ3l4emE3QzdC?=
 =?utf-8?B?bFpqTFA4ZER5b2JVd0xUQm05amcvS2pNNGJDbmR6TVZpdmNMMnh1c3pObnVk?=
 =?utf-8?B?SnNlM3FXVDFGZytZSzFvenkvOGZSaEFCTVpXY0E4K3h5blB5T0lXTXROY0Js?=
 =?utf-8?B?c0JyOG1nbWRROVVLbEJhNG5STnMwc0tpT1JBeVJqeFIxQlZxU0lFNDZkdE1L?=
 =?utf-8?B?VjhZTXB0eGRLTDAwNDI2VDlhL25NTU4rTnB0NmFqbGRodjNGVVJ5QWdyY3Yv?=
 =?utf-8?B?Mjd1dkx1eUIybXh2cXE5aEN3THE5U04wZ2EwNFBjUHQ4WTJ2NC9WOUFHSHFR?=
 =?utf-8?B?RUx4STlsdml3NDhBWUpEU1RHRnlRNng0Ylp6VTFuU21NSCtYTklrTDVsT3d3?=
 =?utf-8?B?YTNENGdRU09CbC9YdVQyU3l2bmwxMUJJajFDWHhFcDVWSXNwTmRLdjJkbG1s?=
 =?utf-8?B?bVJyZnV3dU5PVi90QytaNXFHVGJZMUtKcGgyTHdTRHNGb0lJWjYyOS96VDBw?=
 =?utf-8?B?YnN2ZjQyL0hoeXFVeDdoSlZtYkVDUFFEaUtHMTY2Y3QyZGJ1WFZrSVoxMEhL?=
 =?utf-8?B?a0JtTWdHZzFqQUJHZDhNNVNnL1loa3ZXMmRwMjZrNzhPTDk2NWRvMFU1TVJw?=
 =?utf-8?B?cGRrem9JRnpPK2dvT3lIUVJwWXpaZHBsblRIZUJxNDFLTTJsSU5xbndYZlpl?=
 =?utf-8?B?SDZBd010RndkVU1jeERSUDF6NklldkVLc1U5OElEaUVqYTFZYnp4WHUvTk9W?=
 =?utf-8?B?NmFDU0wwdmpZUXk0WllSdDVNOTI5eWJReDQvblVWcG1oRTh5OHNwa29QNE5p?=
 =?utf-8?B?UkhBNTc0aGdyd0kwVHBhZGlUNmVPUFFlU2FoMjJwMjdJMXB3OVdmUFRlUHhx?=
 =?utf-8?B?dm9tMVJwTEdId2ljWmx6Z0w4dldtNjRiditzTHVqbktDWEVrK1MwYzNpS09q?=
 =?utf-8?B?enNNbFBYZzN1anlKZGlpUUs2bGdWenR3WXIzbXR5c01SRWxMeDlXMmk5QUcr?=
 =?utf-8?B?OUdCUjRCV0ZMQjROOXlSOG1TUUQ1d3Q1Rm4zMktodERvcDFBc0RZK2ZmbkZt?=
 =?utf-8?B?NDNFWTFmYVlVeGlOZmJidjVwQitwVHJXeEptSzdPaVVrMXI1Sml3RHpnUzll?=
 =?utf-8?B?ZXdMbTBXcm5zdHRWTXRFdnUydWk4M1g1dWlEVExiWHVSL1lPcjlTOUJmVXFa?=
 =?utf-8?B?dHUwcWEvMHVtakxPNDAyQ1hPQm12c0hkTnRYRXJvZjZhemZtdVZFV1g0Wnow?=
 =?utf-8?B?ZklXVTEvSzRkdzJJL2FucjFxaC9iTmNlN3ZhcFNtUTE0bkJ1QXIzYlZKbWJW?=
 =?utf-8?B?Vnl6a0hJelRSYnl6d0RYQkJiV05Eb0NLYjl4UDAvSnQ0VXZmaGxaMXYvVmJF?=
 =?utf-8?B?aVpDblNpZGFxODhnMVpiQUFvQXFzb2NheXJjK0tBOUhVUXZvTko4OXp2Wkdz?=
 =?utf-8?B?SHJ2SW5FcCtVaGhwSG9lZzExRGNldkUxZzVNZTFqMUNLR25JYzE2SzZTdzJZ?=
 =?utf-8?Q?ru08=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 946150f1-527a-4470-f64b-08dc8b8717fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2024 08:59:11.8695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9gcBY92eyTgI+XN+vUHsC8XfSiVayS2jfs9ah6kChmG/Jcgx9v4leyxr1vkOs5Ndwxi+CCUHI5u+vpUuUGQ04w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5803

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGkgQm9yaXMsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQm9y
aXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+DQo+IFNlbnQ6IFR1ZXNkYXksIEp1bmUgMTEsIDIw
MjQgMTA6MzkgUE0NCj4gVG86IExpbW9uY2llbGxvLCBNYXJpbyA8TWFyaW8uTGltb25jaWVsbG9A
YW1kLmNvbT4NCj4gQ2M6IFl1YW4sIFBlcnJ5IDxQZXJyeS5ZdWFuQGFtZC5jb20+OyBTaGVub3ks
IEdhdXRoYW0gUmFuamFsDQo+IDxnYXV0aGFtLnNoZW5veUBhbWQuY29tPjsgcmFmYWVsLmoud3lz
b2NraUBpbnRlbC5jb207DQo+IHZpcmVzaC5rdW1hckBsaW5hcm8ub3JnOyBIdWFuZywgUmF5IDxS
YXkuSHVhbmdAYW1kLmNvbT47IERldWNoZXIsDQo+IEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNo
ZXJAYW1kLmNvbT47IEh1YW5nLCBTaGltbWVyDQo+IDxTaGltbWVyLkh1YW5nQGFtZC5jb20+OyBE
dSwgWGlhb2ppYW4gPFhpYW9qaWFuLkR1QGFtZC5jb20+OyBNZW5nLA0KPiBMaSAoSmFzc21pbmUp
IDxMaS5NZW5nQGFtZC5jb20+OyBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBr
ZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMDgvMTBdIHg4
Ni9jcHVmZWF0dXJlczogQWRkIGZlYXR1cmUgYml0cyBmb3IgQU1EDQo+IGhldGVyb2dlbmVvdXMg
cHJvY2Vzc29yDQo+DQo+IE9uIFR1ZSwgSnVuIDExLCAyMDI0IGF0IDA5OjMxOjU0QU0gLTA1MDAs
IE1hcmlvIExpbW9uY2llbGxvIHdyb3RlOg0KPiA+IEFub3RoZXIgb3B0aW9uIGlzIHRvIHVwbG9h
ZCBpdCBhIG5vbiBlcGhlbWVyYWwgbG9jYXRpb24gbGlrZSBhIGtlcm5lbA0KPiA+IEJ1Z3ppbGxh
IGFuZCBsaW5rIHRvIHRoYXQuICBJIGRvIHJlY2FsbCB0aGVyZSBpcyBhIGJ1ZyBhbHJlYWR5IG9w
ZW5lZA0KPiA+IGZvciB0aGlzIHB1cnBvc2UgaW4gdGhlIHBhc3QuDQo+DQo+IFlvdSBtZWFuLCBh
ZnRlciB3aGF0LCAzMCB5ZWFycyBvZiBzZWFyY2ggZW5naW5lIHRlY2hub2xvZ3kgdGhleSBjYW4n
dCBkbw0KPiBvbmUgc2ltcGxlIHRoaW5nIG9mIGZpbmRpbmcgYSBkb2Mgb24gdGhlIHdlYiBhZnRl
ciBpbmRleGluZyBpdHMgbmV3IGxvY2F0aW9uDQo+IGVhY2ggdGltZSB0aGUgY29ycG9yYXRlIHdl
YnNpdGUgZGVjaWRlcyB0byB1cGRhdGUgdG8gdGhlIGxhdGVzdCBmYW5jeSBDUk0NCj4gZ2x1ZT8N
Cj4NCj4gOi1QDQo+DQo+IC0tDQo+IFJlZ2FyZHMvR3J1c3MsDQoNCldpbGwgdXBkYXRlIHRoZSBQ
UFIgcmVmZXJlbmNlIGxpa2UgYmVsb3cgaW4gVjQuDQoNCiAgICBMaW5rOiBodHRwczovL3d3dy5h
bWQuY29tL2NvbnRlbnQvZGFtL2FtZC9lbi9kb2N1bWVudHMvcHJvY2Vzc29yLXRlY2gtZG9jcy9w
cm9ncmFtbWVyLXJlZmVyZW5jZXMvNTY3MTMtQjFfM18wNS56aXANCiAgICBTZWUgdGhlIHBhZ2Ug
MTE5IG9mIFBQUiBmb3IgQU1EIEZhbWlseSAxOWggTW9kZWwgNjFoIEIxLCBkb2NJRCA1NjcxMw0K
DQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+ICAgICBCb3Jpcy4NCj4NCj4gaHR0cHM6
Ly9wZW9wbGUua2VybmVsLm9yZy90Z2x4L25vdGVzLWFib3V0LW5ldGlxdWV0dGUNCg==

