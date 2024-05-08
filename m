Return-Path: <linux-pm+bounces-7661-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9FD8C00DB
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 17:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCDE4B214BA
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 15:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1F4126F27;
	Wed,  8 May 2024 15:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UwN/b8WP"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C9354FA3;
	Wed,  8 May 2024 15:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715181860; cv=fail; b=KQ+56v63p5eDL8VRX2DmF3r2k91uk2BWfePseBCYvLvli8fBAg6IMBWfhS+94/gBg/2TsCtw+Kao4Nyln4jJhGdm0lUMBGHvv2fsDDyIa/TISyHQgGOMFobSXXKFPvyynuY3tWdjoDjt1C3cudPVHruf9KlfBGpZ1KjJtxWV10g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715181860; c=relaxed/simple;
	bh=et/gtyHYWloKZZOdDCjOrHTXMn14Izpjl2iv5CiUW4w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LhGFImkKtjMs0vuqORzR4RiZ29wxxx1HnqBz0uzs8G+erwW+X94XtR94Du5rMWwGqTFd6mZY5477aos8iH4KT7Mp+k+/QvKjvenJZQFSzn63y0JqLL2EDvDsJO64bVGJ2Ho5xmoewbpy2do1usKNV42r8U/gyeBTag4S1di21ps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UwN/b8WP; arc=fail smtp.client-ip=40.107.220.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4Cj9a4rNOE6XFjD0KZ73Eo8lVm8achh1pCnn+8nHJHhxL1pgcoAAHs6Ob+VLGPm/lYCvGwj8kjY6V3KRE0Y2kln0iioUUBGAnLjhi1fZMtLb1AmHtef/Y6b29sq4SY07OCGs6CiEO1bTuJAs2WJ7+C4H3wn/vAZ0j/tCpU7Znoru9coEVbhzdUSHPoVPDXIqJKeyjZoT7zPQWE8lfmzeIlnSg8Yyyq7tdQa685AquoCg+EwyuRMvSux+4Q9m3EB8MzT2+B0M0xqdxT9Wyq4ndpIM+WREpRHgJvej/GKOl9WpPI48t/xEyZMBxXQqFxckKjLwWJuws+P1kzZ6iJ+Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=et/gtyHYWloKZZOdDCjOrHTXMn14Izpjl2iv5CiUW4w=;
 b=cyOy3dI7D44+tdLdQ/GB/6X/3+dR6QG8jSXDpIT9loywYS9TzBSUqqFjUpQ9Zhz1kAmrnZputHqIuosRYCTGeiN5SibpT+HHHDaq3BOE3kh0xC06fasDE6pVciT4oDJ8A5rakToICEMdK+5euhSuOjfZysQAlRu3D8gJ1ZiRXQf0Yeyh6ndHVyUEHro5KLVDS874+2g+scfuta6SvC4VhedZoNXQE4So92HyTbUTHrocjRzPngDi17BTtREBEruJ9URSwn1dCOMy3bi6fDphS61UP6LXJ/A5VXd+O/eR7ANVL9RhCiYrt4r7Gh0vfNrX3XT9SE62186AogNGfjSknQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=et/gtyHYWloKZZOdDCjOrHTXMn14Izpjl2iv5CiUW4w=;
 b=UwN/b8WPItwb2MN8yfMlKfDShF2K+rQvMMAlsVFWaUpcSLfQl+1U+0EbiPit77wOKf0TLCjb/aqiy+ZRNjuhnWC2NSHqTzrF0+2ELP9/IpfLpuaPR0+9FJoZft0IjZ6eKB8EMM2rna1Zsh8Oho0QP2AHSuggeRXqDeK9mEVzzjM=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by CH3PR12MB8305.namprd12.prod.outlook.com (2603:10b6:610:12e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Wed, 8 May
 2024 15:24:12 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf%6]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 15:24:07 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: Oleksandr Natalenko <oleksandr@natalenko.name>,
	"rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
	"viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "Huang, Ray"
	<Ray.Huang@amd.com>, "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
	"Petkov, Borislav" <Borislav.Petkov@amd.com>, "Limonciello, Mario"
	<Mario.Limonciello@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang, Shimmer"
	<Shimmer.Huang@amd.com>, "Du, Xiaojian" <Xiaojian.Du@amd.com>, "Meng, Li
 (Jassmine)" <Li.Meng@amd.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 11/11] cpufreq: amd-pstate: automatically load pstate
 driver by default
Thread-Topic: [PATCH 11/11] cpufreq: amd-pstate: automatically load pstate
 driver by default
Thread-Index: AQHaoE7TuubOf8ZfN06yZ7opzewwX7GL2KyAgAGdR4CAAAB8cA==
Date: Wed, 8 May 2024 15:24:07 +0000
Message-ID:
 <CYYPR12MB865554562BE018D46FF0108C9CE52@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <cover.1715065568.git.perry.yuan@amd.com>
 <60bdfbeb426512d74faa91597453fd7960ebd7b5.1715065568.git.perry.yuan@amd.com>
 <3cd5fe9d-514c-4a09-a895-47d97a5c6b94@amd.com>
 <2728771.mvXUDI8C0e@natalenko.name>
In-Reply-To: <2728771.mvXUDI8C0e@natalenko.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=9966eb67-1048-4eb6-bdee-cf38a4f32f15;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-05-08T15:22:22Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|CH3PR12MB8305:EE_
x-ms-office365-filtering-correlation-id: 9aaf472f-c527-45e3-caba-08dc6f72e75f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|1800799015|366007|376005|38070700009|921011;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZjN3b0ZDYkZrVEtXdHM4QVRvWncxdEVyVndDeENOck00eFU5SVRka24vYkRy?=
 =?utf-8?B?cGpMV3RoeDA4YkJZQUQxRWYzb1ZBRGhzQitINzFSN00vcmtJOGYzZGlJVk0z?=
 =?utf-8?B?ZEZVTnBTWkVBbVVZWDlFbE5Md0d6NWVOM3hibVBiTFlIWllnL0dxbnNOTk5P?=
 =?utf-8?B?L2dvTis5V1dyUXBwczl6a0tua0l2Ylg5RE1QL3FCT1dWYmlxd1cvTjZEV2FG?=
 =?utf-8?B?aVNkY1ZzckkwM24xc0tnOXVFMngvclRUOEM5N0V0azRpYkZ5Y3V2bW5BdHlD?=
 =?utf-8?B?eFB1dDF5alZpYmlxRmpXUjJKaExlL0l6NmFlNXdsUHBQYUFoMk4rM2toc2RN?=
 =?utf-8?B?MUJtWDdMdm44S09pc0dxVFBrZTFiNjk3M1FKUlZ3K2tEQjJ4NjFPWmJ3cW84?=
 =?utf-8?B?d1lnSnRYa0lhdXl2VWp4Y29RZ01RdFdWVDU1bGJ4aFBKbjJxVEIvSGpPZFhp?=
 =?utf-8?B?RzZ4L2s1a1dvdDJBME1GNkJjKzhXbmZpU2ZOZWNuakZ5QmF3aTFlMzg3ODdT?=
 =?utf-8?B?Z0ZRajc3VmhOazREMStJRFB2WGdoT0hMVDNGZnloWVlBRndtdFQyblRuKzRW?=
 =?utf-8?B?Ui9Gb1NMbzd5RXhBUm9yRHJXSWtwUFFzUVhNd0VBS1RyMkMrL0RaWjcwcVBq?=
 =?utf-8?B?VkNFREVoalc5aUc2UnhkTjZWMC8rRlNXMzVZMTMzbnplODk4bG02a2hVbHVW?=
 =?utf-8?B?cGxCcWdwMGMwQmM4ajBSUG5JOEl2M1QwTUNyYzA3ZXB5YzNFOGNURU1DdnhZ?=
 =?utf-8?B?UDBlWW5YY1lZWkdIdFBGNm5hcFdoRGVTN2xkdEluU3Y3TzN2MVI1Nlp5Yk41?=
 =?utf-8?B?UEhGNHgzR0p6MHhhbHk3UGxDQTlvNnZwR0EyeCtYWFFGN0M0VXE4UG1ZVk0z?=
 =?utf-8?B?Ym9takxJWWUvTXBIMFhzNHpMK0I5N3N1NzFaMDQwS3JocTdzVDRnQmxBNzZs?=
 =?utf-8?B?SXFTenprRHZQeXV3M3Z2dmxLVWZDMHdjdUFmRytTcG5nY1NHa0U3Um5TR1VI?=
 =?utf-8?B?SXFnRkQzWXZ1d2JYTGhuM3A2ZWFmVXBTcW9pUFp0TmhpUVhIYUFwQ0F3TjdX?=
 =?utf-8?B?WG00dm5Sb2ZSWFdQMUVLb0pGa21iUXh6UmE5eFR3cGV5bmZyVjVFMS9QblE3?=
 =?utf-8?B?Skt3bEwxSzdmYnUyR1lmcXhJM3dueFExSGFTTDllTTBSM1BwTjB2Ujh0RXVZ?=
 =?utf-8?B?MElHTUpEcUlSS2xSOUZTcHBKTGJkWE53Nmd4eGkxU2lqRnJvdTZLN1NJZnFT?=
 =?utf-8?B?RnRUbkdtSW1BZm8xYnowTGtjc3RsdlVnNHdOYUhrMDFoNnRqQkg4U0pvY1gw?=
 =?utf-8?B?eHB6VEJaYSthclVGVG84cGJxbEtBbytSbXJ5MC9ENFpNNFV6UHN5cEUyUVJr?=
 =?utf-8?B?UHY3SFhnQ1pxZDhCSW9sV3RNQzN1dlZUUk1BbzVhNWE1NjFBNklIUHZMeW02?=
 =?utf-8?B?ai9KNmRrL3NlazN3NW5OL3NtTzR2NGF0YkVZQ1d5SVZ6b0tFNTA5WXhNVGtC?=
 =?utf-8?B?RmQveklLaTZ4ZWNhWjZPc2tsL1RoaUJTVjU0WCtXbXNHbkRJRVBZSndvelFQ?=
 =?utf-8?B?TU5QK2tEUjVpT1g0M2pMRDRhWHhGRE9BZzVNUXhkelhnQ0RsUGsyM2dVeXR3?=
 =?utf-8?B?SDRKMmh3a2k5bEFuZy9ia0JkdmNHdXRwR3FqeTV3azQvVGc0Tys3QTA0YUx1?=
 =?utf-8?B?dGlMVEYwbnRRZ0YyMk5MQ0owdEtnQWRKZDAzUWNyMEJvOWlWK0NicHQwQW1K?=
 =?utf-8?Q?HGuRdjW09UwgCXwSD0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UFNMRTVlNnBseDk4NmtVbDYybFdjTnVtL2xCeWQ5QlE3ZnhCNStDZUlTMFlI?=
 =?utf-8?B?dkVQcXdTRENBckFYSG9BVlFob09lZkczM0xKN3hxb05WUURMbThHTHRBSGk0?=
 =?utf-8?B?cnlNbmxRSDg5NWI5MkVaRXRWZDZVZkQvNGo2Y2cvVUR3eUZVaHZQMUFOdnVD?=
 =?utf-8?B?Um5MSTVSUHZ3T1FqTXF4QWozb0ZNbVlzbFprMi82K2UyMldmaWZBQXJOQVRx?=
 =?utf-8?B?c1hZY253bDNvb09FNkdWWlF0djRSQ1ZKUjR5eU9xT1JWMFJWOXVJVHNlKzlU?=
 =?utf-8?B?blE0MTJGN0dGczFudGx5Z2Nua0hiajRLckNFZEN5RzJpQkl5Y0FUNkRFenB3?=
 =?utf-8?B?ZjR1T2krS1htUm5xeUxQNXBZY1FJeHFmU1ltVGdyUE5xbk5GbTkvNmFETG1v?=
 =?utf-8?B?Z0lPSGd2dXc0QWJjdHBOR0hNTm5OekpSY29tYnFNa1ozbFY5VkozUFY0dUVr?=
 =?utf-8?B?eWdhTENsc3MxUlY0YVRRM0NlWVA2YlVCelNxUStQL0doSWgyOWF5RG1hbHNE?=
 =?utf-8?B?MTlwem1EdG1YUHhPZlFIMk9EYytjYk9uSDNNYXE0ellkRmFDY3lIVUpkRXNK?=
 =?utf-8?B?N1ExcXhGNzlKbVh4Q2s4Zm1ia0d4bzR4R2ZLYnFQcmtPd2JrcVZhMzhRaGVt?=
 =?utf-8?B?SFhPTHJWSXkvcW9zZng5WW5GR2NsMWRrMnB6b1ZURzNidU9ENmpjL0pMYk0v?=
 =?utf-8?B?alpScEdBdHlPWDVpcUp4UGtHQVRqQ1R5N0JXVXBkYmZ4enNISkl3WTRJL21Z?=
 =?utf-8?B?b0xzUDErN21lMzY2TW51dEZyb25GRUE2c0ozY2hXU20yZ1R5UW94emxad3lk?=
 =?utf-8?B?bjZzV1lrb1FOY1laV1FNbVd0LzdGZHJaN2hBbFlXaHFxSGcwMlFma0swamo5?=
 =?utf-8?B?T09mejhkemYwNDlvYkdQWnRmS21MMVMrNGpiVGRaOXJMd0pwamsrblJwc2kx?=
 =?utf-8?B?b2dPOUk0azJGdFVTeGlFVXZEMG9yVUJZS0p1T3haR0lvWUJQT3RnVmZ0R0JY?=
 =?utf-8?B?RThPOTJLcW45YlFKSUdTdkxWeE56Y0FhSkR6ZWVRYm45R2NRMm1uK1U2OFdG?=
 =?utf-8?B?M0lzOS9UY3RJdlA0eUpCdWM0TjFSMm1PYjJpSklFQ2FoMWdvdXN6K0JDOTZh?=
 =?utf-8?B?cERPZkt4d3ZvemdKZGtydXhObkRlVk4wU2svUG9SZGRyVHM1Nll1MHFXajFt?=
 =?utf-8?B?cFQ5N2tGY0JNaExTaGtIbjJtRXJEdHdoUDhXWmRxM0RRTWJnaExaNWdaNGNj?=
 =?utf-8?B?ZkVLaERCTXBpTTBpVldtQmp1RG4yYkxBZnNYYWcvaFlzUlFBYzlBNVAzR0RZ?=
 =?utf-8?B?bnpneFNTMVU0Z1pQMHIxejgzaDZpMUlyNXZjWkZvbHd3NmtuYVZxU2s4dW1U?=
 =?utf-8?B?LzU1YzFxcmVRSDV5bElkTWd4WGhNRVZaRklSN0tZQ05JQmo5bVBVUlJkVTJJ?=
 =?utf-8?B?U3liQVhZSnJhUDlRQ2paRFgvNzRqY293VytDeURVSDBRTVpYbklGMU5yTkMr?=
 =?utf-8?B?d1pJY2xIWXhWNGdjSE5aZ1ZCZkFpdEpVTElnTTh5M1YrdXp0NStMS0d6MjBC?=
 =?utf-8?B?WFNEK3hveEQvT0dBOWNGWVFrS1dSUmRBMWM4OFNWVkNzL25aeGh2dWF3NU5H?=
 =?utf-8?B?enVXUlpjbTNZMnRGeE9OWUdYUlpjc25EanFnQVUvUC9jd0RLdGEwT0VTS01j?=
 =?utf-8?B?U3ZJMTh3S1liVW1qNHQ1d01GaVMvSnVaUWdqZDMrN1AyVTVEd3M4RTYweU5o?=
 =?utf-8?B?cUZ1cTVEeEUvVlBRTmtVNmtUUjBTSjV3VjNtbUR0bGRuMWhXc1F3MVdrUHZI?=
 =?utf-8?B?MlcrR1hXckdYSURlS0ZIVng5RW5yWlpjNmRoTGdFVjQvV2NyMC9KYzJRdG01?=
 =?utf-8?B?cU9UZWpaelF3VVErdHQ0SkJkd1IrTGMvM0FNMmptRHRqeDIxTFdHb2FFMGF2?=
 =?utf-8?B?WHdtekhBN3JTeldvSWE1cERUZDFIRTNKT0RKcjFub0FWYlhWKzNnR2tiVzZt?=
 =?utf-8?B?MVIrT0xGN2I4Q09xTjBnNmNvUjRsU2VUYjhsYW5aZWF0ZGNmNzRVSHlFUUVY?=
 =?utf-8?B?MEFsMUIycGZGeWczTzdYZjRRaWZxaUNBR09yUjJ6M1RhdzdQRWZyTGs3VjNx?=
 =?utf-8?Q?5Hsk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aaf472f-c527-45e3-caba-08dc6f72e75f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2024 15:24:07.8242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rKLZzCkFfAJU95zUFpGhXB2jY7GCfCqjuzqBptNeXAgs3wESBs7cSjvhoCsplJMr12qmMGIBivZGuQWtTWioCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8305

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogT2xla3NhbmRyIE5hdGFsZW5rbyA8b2xla3NhbmRyQG5hdGFsZW5r
by5uYW1lPg0KPiBTZW50OiBXZWRuZXNkYXksIE1heSA4LCAyMDI0IDExOjIxIFBNDQo+IFRvOiBZ
dWFuLCBQZXJyeSA8UGVycnkuWXVhbkBhbWQuY29tPjsgcmFmYWVsLmoud3lzb2NraUBpbnRlbC5j
b207DQo+IHZpcmVzaC5rdW1hckBsaW5hcm8ub3JnOyBIdWFuZywgUmF5IDxSYXkuSHVhbmdAYW1k
LmNvbT47IFNoZW5veSwNCj4gR2F1dGhhbSBSYW5qYWwgPGdhdXRoYW0uc2hlbm95QGFtZC5jb20+
OyBQZXRrb3YsIEJvcmlzbGF2DQo+IDxCb3Jpc2xhdi5QZXRrb3ZAYW1kLmNvbT47IExpbW9uY2ll
bGxvLCBNYXJpbw0KPiA8TWFyaW8uTGltb25jaWVsbG9AYW1kLmNvbT4NCj4gQ2M6IERldWNoZXIs
IEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEh1YW5nLCBTaGltbWVyDQo+
IDxTaGltbWVyLkh1YW5nQGFtZC5jb20+OyBEdSwgWGlhb2ppYW4gPFhpYW9qaWFuLkR1QGFtZC5j
b20+OyBNZW5nLA0KPiBMaSAoSmFzc21pbmUpIDxMaS5NZW5nQGFtZC5jb20+OyBsaW51eC1wbUB2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggMTEvMTFdIGNwdWZyZXE6IGFtZC1wc3RhdGU6IGF1dG9tYXRpY2FsbHkg
bG9hZCBwc3RhdGUNCj4gZHJpdmVyIGJ5IGRlZmF1bHQNCj4NCj4gSGVsbG8uDQo+DQo+IE9uIMO6
dGVyw70gNy4ga3bEm3RuYSAyMDI0IDE2OjQxOjI5LCBTRUzEjCBNYXJpbyBMaW1vbmNpZWxsbyB3
cm90ZToNCj4gPiBPbiA1LzcvMjAyNCAwMjoxNSwgUGVycnkgWXVhbiB3cm90ZToNCj4gPiA+IElm
IHRoZSBgYW1kLXBzdGF0ZWAgZHJpdmVyIGlzIG5vdCBsb2FkZWQgYXV0b21hdGljYWxseSBieSBk
ZWZhdWx0LA0KPiA+ID4gaXQgaXMgYmVjYXVzZSB0aGUga2VybmVsIGNvbW1hbmQgbGluZSBwYXJh
bWV0ZXIgaGFzIG5vdCBiZWVuIGFkZGVkLg0KPiA+ID4gVG8gcmVzb2x2ZSB0aGlzIGlzc3VlLCBp
dCBpcyBuZWNlc3NhcnkgdG8gY2FsbCB0aGUNCj4gPiA+IGBhbWRfcHN0YXRlX3NldF9kcml2ZXIo
KWAgZnVuY3Rpb24gdG8gZW5hYmxlIHRoZSBkZXNpcmVkIG1vZGUNCj4gPiA+IChwYXNzaXZlL2Fj
dGl2ZS9ndWlkZWQpIGJlZm9yZSByZWdpc3RlcmluZyB0aGUgZHJpdmVyIGluc3RhbmNlLg0KPiA+
ID4gVGhpcyBlbnN1cmVzIHRoYXQgdGhlIGRyaXZlciBpcyBsb2FkZWQgY29ycmVjdGx5IHdpdGhv
dXQgcmVseWluZyBvbg0KPiA+ID4gdGhlIGtlcm5lbCBjb21tYW5kIGxpbmUgcGFyYW1ldGVyLg0K
PiA+ID4NCj4gPiA+IFsgICAgMC45MTc3ODldIHVzYiB1c2I2OiBNYW51ZmFjdHVyZXI6IExpbnV4
IDYuOS4wLXJjNi1hbWQtcHN0YXRlLW5ldy0NCj4gZml4LXYxIHhoY2ktaGNkDQo+ID4gPiBbICAg
IDAuOTgyNTc5XSBhbWRfcHN0YXRlOiBmYWlsZWQgdG8gcmVnaXN0ZXIgd2l0aCByZXR1cm4gLTIy
DQo+ID4gPg0KPiA+ID4gUmVwb3J0ZWQtYnk6IEFuZHJlaSBBbXVyYXJpdGVpIDxhbmRhbXVAcG9z
dGVvLm5ldD4NCj4gPiA+IENsb3NlczogaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3df
YnVnLmNnaT9pZD0yMTg3MDUNCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFBlcnJ5IFl1YW4gPHBlcnJ5
Lnl1YW5AYW1kLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gICBkcml2ZXJzL2NwdWZyZXEvYW1kLXBz
dGF0ZS5jIHwgMzkgKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLQ0KPiAtLQ0KPiA+
ID4gICAxIGZpbGUgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgMTggZGVsZXRpb25zKC0pDQo+
ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMNCj4g
PiA+IGIvZHJpdmVycy9jcHVmcmVxL2FtZC1wc3RhdGUuYyBpbmRleCAzZmYzODFjNGVkZjcuLmY1
MzY4NDk3ZWU3OQ0KPiA+ID4gMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL2NwdWZyZXEvYW1k
LXBzdGF0ZS5jDQo+ID4gPiArKysgYi9kcml2ZXJzL2NwdWZyZXEvYW1kLXBzdGF0ZS5jDQo+ID4g
PiBAQCAtNjYsNyArNjYsNyBAQA0KPiA+ID4gICBzdGF0aWMgc3RydWN0IGNwdWZyZXFfZHJpdmVy
ICpjdXJyZW50X3BzdGF0ZV9kcml2ZXI7DQo+ID4gPiAgIHN0YXRpYyBzdHJ1Y3QgY3B1ZnJlcV9k
cml2ZXIgYW1kX3BzdGF0ZV9kcml2ZXI7DQo+ID4gPiAgIHN0YXRpYyBzdHJ1Y3QgY3B1ZnJlcV9k
cml2ZXIgYW1kX3BzdGF0ZV9lcHBfZHJpdmVyOyAtc3RhdGljIGludA0KPiA+ID4gY3BwY19zdGF0
ZSA9IEFNRF9QU1RBVEVfVU5ERUZJTkVEOw0KPiA+ID4gK3N0YXRpYyBpbnQgY3BwY19zdGF0ZTsN
Cj4gPiA+ICAgc3RhdGljIGJvb2wgY3BwY19lbmFibGVkOw0KPiA+ID4gICBzdGF0aWMgYm9vbCBh
bWRfcHN0YXRlX3ByZWZjb3JlID0gdHJ1ZTsNCj4gPiA+ICAgc3RhdGljIHN0cnVjdCBxdWlya19l
bnRyeSAqcXVpcmtzOyBAQCAtMTc2Miw2ICsxNzYyLDE2IEBAIHN0YXRpYw0KPiA+ID4gaW50IF9f
aW5pdCBhbWRfcHN0YXRlX2luaXQodm9pZCkNCj4gPiA+ICAgICAgICAgICBpZiAoYm9vdF9jcHVf
ZGF0YS54ODZfdmVuZG9yICE9IFg4Nl9WRU5ET1JfQU1EKQ0KPiA+ID4gICAgICAgICAgICAgICAg
ICAgcmV0dXJuIC1FTk9ERVY7DQo+ID4gPg0KPiA+ID4gKyAvKiBEaXNhYmxlIG9uIHRoZSBmb2xs
b3dpbmcgY29uZmlncyBieSBkZWZhdWx0Og0KPiA+ID4gKyAgKiAxLiBVbmRlZmluZWQgcGxhdGZv
cm1zDQo+ID4gPiArICAqIDIuIFNlcnZlciBwbGF0Zm9ybXMNCj4gPiA+ICsgICovDQo+ID4gPiAr
IGlmIChhbWRfcHN0YXRlX2FjcGlfcG1fcHJvZmlsZV91bmRlZmluZWQoKSB8fA0KPiA+ID4gKyAg
ICAgICAgIGFtZF9wc3RhdGVfYWNwaV9wbV9wcm9maWxlX3NlcnZlcigpKSB7DQo+ID4gPiArICAg
ICAgICAgcHJfaW5mbygiZHJpdmVyIGxvYWQgaXMgZGlzYWJsZWQgZm9yIHNlcnZlciBvciB1bmRl
ZmluZWQNCj4gcGxhdGZvcm1cbiIpOw0KPiA+ID4gKyAgICAgICAgIHJldHVybiAtRU5PREVWOw0K
PiA+ID4gKyB9DQo+ID4gPiArDQo+ID4gPiAgICAgICAgICAgLyogc2hvdyBkZWJ1ZyBtZXNzYWdl
IG9ubHkgaWYgQ1BQQyBpcyBub3Qgc3VwcG9ydGVkICovDQo+ID4gPiAgICAgICAgICAgaWYgKCFh
bWRfY3BwY19zdXBwb3J0ZWQoKSkNCj4gPiA+ICAgICAgICAgICAgICAgICAgIHJldHVybiAtRU9Q
Tk9UU1VQUDsNCj4gPiA+IEBAIC0xNzgxLDI4ICsxNzkxLDIxIEBAIHN0YXRpYyBpbnQgX19pbml0
IGFtZF9wc3RhdGVfaW5pdCh2b2lkKQ0KPiA+ID4gICAgICAgICAgIC8qIGNoZWNrIGlmIHRoaXMg
bWFjaGluZSBuZWVkIENQUEMgcXVpcmtzICovDQo+ID4gPiAgICAgICAgICAgZG1pX2NoZWNrX3N5
c3RlbShhbWRfcHN0YXRlX3F1aXJrc190YWJsZSk7DQo+ID4gPg0KPiA+ID4gKyAvKiBnZXQgZGVm
YXVsdCBkcml2ZXIgbW9kZSBmb3IgbG9hZGluZyovDQo+ID4gPiArIGNwcGNfc3RhdGUgPSBDT05G
SUdfWDg2X0FNRF9QU1RBVEVfREVGQVVMVF9NT0RFOw0KPiA+DQo+ID4gUmF0aGVyIHRoYW4gc2V0
dGluZyBpdCBoZXJlIHdpdGhpbiBhbWRfcHN0YXRlX2luaXQoKSBJIHRoaW5rIHlvdSBjYW4NCj4g
PiBqdXN0IHNldCBpdCBhdCBsaW5lIDY3IHRvIENPTkZJR19YODZfQU1EX1BTVEFURV9ERUZBVUxU
X01PREUuDQo+DQo+IFRvIG1lIGl0IHNlZW1zIGxpa2Ugc2V0dGluZyBpdCBoZXJlIGtpbGxzIGEg
cG9zc2liaWxpdHkgdG8gc2V0IHRoZSBtb2RlIHZpYSB0aGUNCj4ga2VybmVsIGNtZGxpbmUuIFJl
Z2FyZGxlc3Mgb2Ygd2hhdCB3aWxsIGJlIHNldCBpbiBgYW1kX3BzdGF0ZT1gLA0KPiBgQ09ORklH
X1g4Nl9BTURfUFNUQVRFX0RFRkFVTFRfTU9ERWAgd2lsbCBiZSB1c2VkIGluc3RlYWQuDQoNCllv
dSBhcmUgcmlnaHQsICB0aGUga2VybmVsIGNvbW1hbmQgbGluZSB3aWxsIGJlIG1pc3NlZCBieSB0
aGlzIGNoYW5nZSwgIHdpbGwgZml4IGl0IGluIG5leHQgdmVyc2lvbi4NClRoYW5rcw0KDQpQZXJy
eS4NCg0KPg0KPiA+DQo+ID4gPiArIHByX2RlYnVnKCJjcHBjIHdvcmtpbmcgc3RhdGUgc2V0IHRv
IG1vZGU6JWRcbiIsIGNwcGNfc3RhdGUpOw0KPiA+DQo+ID4gSSB0aGluayB0aGlzIGRlYnVnIGxp
bmUgaXMgZ29pbmcgdG8gYmUgdW5uZWNlc3Nhcnkgd2hlbiBpdCdzIGFscmVhZHkNCj4gPiBoYXJk
Y29kZWQgdG8ga2VybmVsIGNvbmZpZy4NCj4gPg0KPiA+ID4gKw0KPiA+ID4gICAgICAgICAgIHN3
aXRjaCAoY3BwY19zdGF0ZSkgew0KPiA+ID4gLSBjYXNlIEFNRF9QU1RBVEVfVU5ERUZJTkVEOg0K
PiA+ID4gLSAgICAgICAgIC8qIERpc2FibGUgb24gdGhlIGZvbGxvd2luZyBjb25maWdzIGJ5IGRl
ZmF1bHQ6DQo+ID4gPiAtICAgICAgICAgICogMS4gVW5kZWZpbmVkIHBsYXRmb3Jtcw0KPiA+ID4g
LSAgICAgICAgICAqIDIuIFNlcnZlciBwbGF0Zm9ybXMNCj4gPiA+IC0gICAgICAgICAgKiAzLiBT
aGFyZWQgbWVtb3J5IGRlc2lnbnMNCj4gPiA+IC0gICAgICAgICAgKi8NCj4gPiA+IC0gICAgICAg
ICBpZiAoYW1kX3BzdGF0ZV9hY3BpX3BtX3Byb2ZpbGVfdW5kZWZpbmVkKCkgfHwNCj4gPiA+IC0g
ICAgICAgICAgICAgYW1kX3BzdGF0ZV9hY3BpX3BtX3Byb2ZpbGVfc2VydmVyKCkgfHwNCj4gPiA+
IC0gICAgICAgICAgICAgIWNwdV9mZWF0dXJlX2VuYWJsZWQoWDg2X0ZFQVRVUkVfQ1BQQykpIHsN
Cj4gPiA+IC0gICAgICAgICAgICAgICAgIHByX2luZm8oImRyaXZlciBsb2FkIGlzIGRpc2FibGVk
LCBib290IHdpdGggc3BlY2lmaWMNCj4gbW9kZSB0byBlbmFibGUgdGhpc1xuIik7DQo+ID4gPiAt
ICAgICAgICAgICAgICAgICByZXR1cm4gLUVOT0RFVjsNCj4gPiA+IC0gICAgICAgICB9DQo+ID4g
PiAtICAgICAgICAgcmV0ID0NCj4gYW1kX3BzdGF0ZV9zZXRfZHJpdmVyKENPTkZJR19YODZfQU1E
X1BTVEFURV9ERUZBVUxUX01PREUpOw0KPiA+ID4gLSAgICAgICAgIGlmIChyZXQpDQo+ID4gPiAt
ICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiA+ID4gLSAgICAgICAgIGJyZWFrOw0KPiA+
ID4gICAgICAgICAgIGNhc2UgQU1EX1BTVEFURV9ESVNBQkxFOg0KPiA+ID4gKyAgICAgICAgIHBy
X2luZm8oImRyaXZlciBsb2FkIGlzIGRpc2FibGVkLCBib290IHdpdGggc3BlY2lmaWMgbW9kZSB0
bw0KPiA+ID4gK2VuYWJsZSB0aGlzXG4iKTsNCj4gPiA+ICAgICAgICAgICAgICAgICAgIHJldHVy
biAtRU5PREVWOw0KPiA+ID4gKyBjYXNlIEFNRF9QU1RBVEVfVU5ERUZJTkVEOg0KPiA+DQo+ID4g
V2l0aCB0aGUgaW50ZW50IG9mIHRoaXMgcGF0Y2ggSSBubyBsb25nZXIgc2VlIGEgbmVlZCBmb3IN
Cj4gPiBBTURfUFNUQVRFX1VOREVGSU5FRCBpbiB0aGUgcmVzdCBvZiB0aGUgZHJpdmVyIChvciBp
biB0aGlzIGNhc2UNCj4gPiBzdGF0ZW1lbnQgZXZlbikuDQo+ID4NCj4gPiBJIGZlZWwgeW91IGNh
biBkcm9wIGl0IGZyb20gYW1kLXBzdGF0ZS5oLg0KPiA+DQo+ID4gPiAgICAgICAgICAgY2FzZSBB
TURfUFNUQVRFX1BBU1NJVkU6DQo+ID4gPiAgICAgICAgICAgY2FzZSBBTURfUFNUQVRFX0FDVElW
RToNCj4gPiA+ICAgICAgICAgICBjYXNlIEFNRF9QU1RBVEVfR1VJREVEOg0KPiA+ID4gKyAgICAg
ICAgIHJldCA9IGFtZF9wc3RhdGVfc2V0X2RyaXZlcihjcHBjX3N0YXRlKTsNCj4gPiA+ICsgICAg
ICAgICBpZiAocmV0KQ0KPiA+ID4gKyAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gPiA+
ICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+ID4gICAgICAgICAgIGRlZmF1bHQ6DQo+ID4g
PiAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gPiA+IEBAIC0xODIzLDcgKzE4
MjYsNyBAQCBzdGF0aWMgaW50IF9faW5pdCBhbWRfcHN0YXRlX2luaXQodm9pZCkNCj4gPiA+ICAg
ICAgICAgICAvKiBlbmFibGUgYW1kIHBzdGF0ZSBmZWF0dXJlICovDQo+ID4gPiAgICAgICAgICAg
cmV0ID0gYW1kX3BzdGF0ZV9lbmFibGUodHJ1ZSk7DQo+ID4gPiAgICAgICAgICAgaWYgKHJldCkg
ew0KPiA+ID4gLSAgICAgICAgIHByX2VycigiZmFpbGVkIHRvIGVuYWJsZSB3aXRoIHJldHVybiAl
ZFxuIiwgcmV0KTsNCj4gPiA+ICsgICAgICAgICBwcl9lcnIoImZhaWxlZCB0byBlbmFibGUgZHJp
dmVyIG1vZGUoJWQpIHdpdGggcmV0dXJuICVkXG4iLA0KPiA+ID4gK2NwcGNfc3RhdGUsIHJldCk7
DQo+ID4gPiAgICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiA+ID4gICAgICAgICAgIH0N
Cj4gPiA+DQo+ID4NCj4gPg0KPiA+DQo+DQo+DQo+IC0tDQo+IE9sZWtzYW5kciBOYXRhbGVua28g
KHBvc3QtZmFjdHVtKQ0K

