Return-Path: <linux-pm+bounces-11785-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C868944192
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 05:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFE121F23051
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 03:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FCA13D2BC;
	Thu,  1 Aug 2024 03:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dolnJojq"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2761113D283;
	Thu,  1 Aug 2024 03:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722481985; cv=fail; b=HIiV/AvZ5tXqRK8bdPxMdrmJkg2V7zO9tnFnx2v6lBUhUlu7d2zTXIyh2JVAVmC3PlrYDc8cHqhHWt46zfcJnBXsa/Da/XnE2K4AS7LNrXP6c7jvQPEGR5MdvKXOyGugnP6MPyX8sHf6dQVU0ZMlIKI/PfufndKdjGtVDDHQIcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722481985; c=relaxed/simple;
	bh=yBjDbrnBbdZoCr3AWEkRXspOza3VPVo77DxGzK6zmnY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CvGNeemjAuwENZ3tkhaPsamH1wKIw1sZVandryayiOsdOQ722sx9cy0LQGQxwFT3OxgSnT4zEZ2Nxi2XVT0lvK7pNx6AxR3sIfBHyXY+9Jb+xyEwaryWFTQ+FDsXEmK5gVRLVu9/cVumeL8tAt+5Mh02p2X79c883dw0NaUa1ZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dolnJojq; arc=fail smtp.client-ip=40.107.236.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FRu1/ylBWi5AaXmRbhfey7zFJNnJjvuapb/vQENXGqPhCXk6ZAsOwdg0Rn65oadKjazFIPLNXXw6rAmJH0VmH4sLmOn0dbja/zP5t24ZeHGT12qUMGVezGYC+GQkn4Uwx8fOiJv+FC4+R9N93od9WrBqvVvXXYfCZetfL8/K74QkWuIDI339p4zzcmRVRpa/qEcxAEKCE6nV/kWa9BrVZSRUdFgdJVqjzJmoBam8R3GvAda6mpux57OL/aTpDHebS3VrRv3xJxf2i/FnqL1w1uXu0ZXK1eXbLVbVBZ1grPZ+MVl0mMTHlGfBfQOBi+SSI8wnbPbagNRNIpnPcdJJ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yBjDbrnBbdZoCr3AWEkRXspOza3VPVo77DxGzK6zmnY=;
 b=NGXGZ2wRkg1ECulRTfpB7kDjd1vH+iKJNZvIxv8ZGLaDZeAkmFMMX5ynyotJfVtYDCJgv3REnPD2jERX8jxiATtN5nLhqdj523PkFT3dOncr5sHs3rjTzk7s0/zpUGy0ay0dbDCcjHLJQ8dke431ulJFAjamaAbtLQMnF17/diUOv+K/0TQ3bsIv4q9giQGSGmeEcPca+hmw9QIizC7fKyGO2881AeuW8MAg9tvxGDIbrPzSwmY4AEhSJJle5BD/t/BCR5lNZQjQRuPosPgNqaIC6XTnJ//TNcxUMONmahcnwOJtLohB0sgD+UfdAeQheEEjp2O0UEQ7ZeoKmGAnWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yBjDbrnBbdZoCr3AWEkRXspOza3VPVo77DxGzK6zmnY=;
 b=dolnJojqvpy4WC/yfO2Qf2nW9gFx3MItWR0C5keWvYFmiMLMfcYD5cwOPcFZCZKZ9mnOd7zUAfQwRk9XUkwrjxCSL6QraTYcxAeMB+5aLoBPYt3rmuMiIzWQxoU3fKIpLWessVmyvYsIaZd5OiirKGZVgu/Rjpzrc7vdx+1idvE=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by CH3PR12MB7593.namprd12.prod.outlook.com (2603:10b6:610:141::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Thu, 1 Aug
 2024 03:13:01 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf%5]) with mapi id 15.20.7828.021; Thu, 1 Aug 2024
 03:13:00 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: "Ugwekar, Dhananjay" <Dhananjay.Ugwekar@amd.com>, "Shenoy, Gautham Ranjal"
	<gautham.shenoy@amd.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rafael@kernel.org" <rafael@kernel.org>, "viresh.kumar@linaro.org"
	<viresh.kumar@linaro.org>, "Huang, Ray" <Ray.Huang@amd.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>
Subject: RE: [PATCH] cpufreq/amd-pstate: Add the missing cpufreq_cpu_put()
Thread-Topic: [PATCH] cpufreq/amd-pstate: Add the missing cpufreq_cpu_put()
Thread-Index: AQHa4yQqYXC8TvkDXEeSQrzn+CH/m7IQg92AgAE0EKA=
Date: Thu, 1 Aug 2024 03:13:00 +0000
Message-ID:
 <CYYPR12MB8655553BA7F283D787981B929CB22@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <20240731083200.169985-1-Dhananjay.Ugwekar@amd.com>
 <cda28ad6-43a7-49f8-bf40-980486d9e17e@amd.com>
In-Reply-To: <cda28ad6-43a7-49f8-bf40-980486d9e17e@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=b2e2f304-fe58-4612-bab8-e17c26166645;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-01T03:01:29Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|CH3PR12MB7593:EE_
x-ms-office365-filtering-correlation-id: a4632fa0-8e82-4fd0-bd3d-08dcb1d7d9a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZHhJOTVicGZIWWNTVXFRVVRxcnYzNlR2eE1ObWNRUlBZVEhacTVvTS9IM0N0?=
 =?utf-8?B?aW5zWDBoUGRQb1FDMkhOOUxLN1gxTW1ZMVhxYk5RQktsc3VvZDd0blI3b3ph?=
 =?utf-8?B?RDRwSUNFbWU3MVl1Z2l6V3VaUjBEbUhCVkdkQlV2SnpPRHFUVmYrYUdTcGx1?=
 =?utf-8?B?NTVBQTVKY1hSWE1jaHJvOXZTdkRSRjI2WFBUVHdEbGFVMUpZbnJzWUNPTTJV?=
 =?utf-8?B?b1MvY0hZb3JtcTU5cERCaEQxU05lTm9sTFlLTVY0bmFWRXdaMEw2SG1Rd2py?=
 =?utf-8?B?MVA3a3ZpQjdmL2NRaDIra0h6dHNHd2p3RlJINU9rT05OTWhZNXpzMjRiZzBM?=
 =?utf-8?B?dVI4azBPZjgxQ0xyVEhFdnIyYzVkTXFVNUV0NDhiY2hiOS9NT3ZZT1FDV2ts?=
 =?utf-8?B?V2xxLzRCN0dHR1pScWkxWWgzeld0MEZsMW1Fb1UvTjFrVTYyK0dDa3dOL04w?=
 =?utf-8?B?MGd4VWlmTXRwcDFVRzlOR25jMEpTWE8yQ1lnWVB4WTRtNWVmSFdsYlRRaXJw?=
 =?utf-8?B?T29UQlgzZS9SWDRtOHBueDJWQnJLd3p4M09zQkFGOWY5ckZINDdqZk5NRXFl?=
 =?utf-8?B?YVA5VTR5YkVIaHJmUDdTYkYvMmFEUmpaSGhERThUM0tpNUJtMHJkK0dTSElI?=
 =?utf-8?B?U1RmK1k4c3pjVEd3MWpsU1JRdGs2SDA2UzRyUWVzZUw2SHhOc1Z6ZFNobzFX?=
 =?utf-8?B?SjZ6QThEV3pVdGhUUU1McGVOMTl2cEZxYTlIWW12WTlLb3NNNVBxOVhUby93?=
 =?utf-8?B?SkxVNGY0WThUY0VIU2lZd0pXaFB0RTZvT0pNSEdXa1U5cHFKaHZ5SkJiUVR4?=
 =?utf-8?B?aUJvZzV4TTNkbGIvb3NybkticEoyRU4rSVhPekFVQUMvSWZTMm9FVDBCcGpS?=
 =?utf-8?B?RW4wTjRFMURjcmdPVU1YakVTM292QmVOQlZtZExMUXhCVVlZTVE0SmllaXZ1?=
 =?utf-8?B?RlptSjd6OVVBdWRyYWl2OU9ySUlGUTRWeENVZW9nL0p5Ly8rdE9nYUVRbnVz?=
 =?utf-8?B?RmlZcmdOa2FOanUvVDNuWVh2Wk5kOUJEVEJac2JtMlpRVnN1ZGFFYjJUaEp1?=
 =?utf-8?B?RXpUeThVNFU3SFBoYzEyVE9nSHBKOWphTVhQcUlycjkxa1hjbjBrUXhRZTB0?=
 =?utf-8?B?dHdPM0pQM3J1YlNTNkNvU2NSS0hJR3E3SlhEU2hOUGYvZHBBdHV4b1JoNEJl?=
 =?utf-8?B?aHhhZHRnUjhUaWM1MEl6R1pYNU9rUTR2cDJlaUJmV0k5SVpYNzBvTWU4RTll?=
 =?utf-8?B?L095U2xLS2V1OGhKZFRVdzZxakg4M09TUzBvTXl1cWtFbjBSanVHdXArWmZX?=
 =?utf-8?B?M2RKMC80dEpuSERmL2tpMVFUekMrZ0ZPblROTDF0RnBPZ2dKcFBWeXdhdUlz?=
 =?utf-8?B?OUpoQ2ZBVFlPK1ovOFgzcDdyK1kxKzJlMkhKWXVSZ2tIRjhhQmtDRm00Qksz?=
 =?utf-8?B?ZFFMTlp0M0g5ZzVIbHBqOG5uZTZiWXRCS2NsNldHbUx1cVBCdlBXOEJFQ1No?=
 =?utf-8?B?V05WMmNiNTZEMUNtV3orVzdQNVZHKzNUZXVSQUw1a0FwdGJ2YkFnS3V2TDVt?=
 =?utf-8?B?MTNlTG5ZamxibzdSc0xrczd0NGVTWjM5RmpDMTRMdlljM2F2NmdicTN6QWVM?=
 =?utf-8?B?Qmd1eEtCOWtjZGovcEJzVGx1bm0vQ2ZuaEdwc1Q2cmE5czlXT0ZiRDdKblp6?=
 =?utf-8?B?MWhkbFlNdllhK00raDFCL2pFWkloUlUzWE4rK3BLZmFjQlY4MldRN2xYdEMr?=
 =?utf-8?B?ZFB0RGdXUmxwdEh6eGY2a05leHBHcHV3ZjhBSmxWeDVuMVpKN2h3NHF1UmVy?=
 =?utf-8?B?cXJ2ZXZlUTJhSzNBQkhMVHEyVTlidWtjTE1weEFBMk5FS0Z3NHNsUkhmYVdu?=
 =?utf-8?B?VWZyajlhcXlMYkJlemJjSHd6c0lLV21yRHUvVDhLa3BVMFE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y3g4bWYwaUVXcHVDckFZNjcyeE9wVVJZdWg4aTV4RnFhand5eVZuVSszZ2JY?=
 =?utf-8?B?SVU2cndHL0xSbHpaK0grZ3laWFNOR3BNdFhPbEhubkM0STBFNWZWVml0YzVr?=
 =?utf-8?B?ZWlyWDY1MW9DOUd4QkM1cUpXYzhIaFY1eDVueU9oaU9pbTVKdFZ5c2VjbnZV?=
 =?utf-8?B?VTN4QWhtbmNXUXRtWlBoWlpJSXpQTDg2VW5rTmhyaG1pbXozdldNOHFXMDRw?=
 =?utf-8?B?UXVXTnhqTnFhc3oxT0ZlVE9KUkIyZHROcGc2S1gyY3AzQWp0MlhhdFdySUdM?=
 =?utf-8?B?U29nNUVCM0J0Nksxci82Q3RJeUxPc0lnZm16cWd1M0JwQnU4UHV6eEJuOUJX?=
 =?utf-8?B?SDBQMXBiMGgrZXlhRE5pek5hQUwwMkdVbWVQVFphcWZDcEIzMlBqbnlaUUhq?=
 =?utf-8?B?YTJveWF6Um5haEpLd3FGV1R1ejAyNGoyR3dheC9xRkIyTUJaMXVZcERNczds?=
 =?utf-8?B?V0NMN0NZWXlVV2dLNGgrY2ZsRWZuOTdtalM4U3NsNHlZWnY5UjRJYW95KzNn?=
 =?utf-8?B?bEtwQ2t5SEZ4YTNMbndxQ0IydkE3U1dUMTRwaDdQaXNQZ09mWXE4M3hDbGpS?=
 =?utf-8?B?di9abGJDNm16dFdPNEh0bDliVGxjK0k3VlVINVA2TmNPSUp3Q3JSZ2UycUx4?=
 =?utf-8?B?bkd1bFJrbWduQUJpVGlIVW9leFBzS2UzQTFabGxjbzgybGgvUFF0M2srTkFm?=
 =?utf-8?B?Tm53VXY0dk9oR0Rqdm9hTXZBK0lWR3BiTHBwWXpTVzJtSVVPbzJpOXZEREox?=
 =?utf-8?B?ZWxmclFndFV1M0o0TGF3YkRvRDh2TWRzdTBYVVlVdEUzNEQ0Rk9PU1hodDNP?=
 =?utf-8?B?c0d3NHo2bGlWc1VlR21PaHV6N2pISzZBWHR0clFvUmRoVjdDSFJqY1R6RFlY?=
 =?utf-8?B?dkFHcEI4dzdaSElTT09QSUMwWGROOTkxWjRhN3BRSVRxNjgrN1ZNUDJuOS9N?=
 =?utf-8?B?VjI5UTcxL1JYemlSSTJGUHpxbEJqUER5bkQwT09GOGhoRXEvakNNZnV5a2da?=
 =?utf-8?B?SEVZdSt1NTdiK1ZNV1orQkNKUncvdllDZWlHaVg5MnhwaEpzcjdjL1prc0tJ?=
 =?utf-8?B?VVNHbVhqcEViTEFSa2JqU0swc0srRHlDNVJ2QmxTTWI1UVFrZE5hK1VGalJR?=
 =?utf-8?B?SjFuay9PUlNUSzFuUDFrVUp3eDhiYVRRVVd0cnFDbDAwcU9NLzZNalduMExR?=
 =?utf-8?B?TGwrOHBoUGVzSWhrODF5STJVRUlBRSt4V2lMRG9HNVYyT3BJWEdIclZiSzRt?=
 =?utf-8?B?UXhnNXloeDBWdWtKS0xzUUdiWllidXZvREMzVmVLUkVtY3VDMkI1cUEyQjBz?=
 =?utf-8?B?S3dSNUl4bXNqZ25OODdLR3FERUFQT0d4bk1CMFFUUm5OZWJHOS9lV3FHQTJ0?=
 =?utf-8?B?STR2UmZQbGgzajBTNis2bXFHODRiVlNXdDlrSUJ1a2VxN1lBaHdnR1NYSWlH?=
 =?utf-8?B?bncvdnhrcU9zdDN0QnhRK3cxS2Z6V2hFa1FZWFUrUmN4djNVT3duclBNMkh6?=
 =?utf-8?B?UlRUb2hOVXRXNWlQSnRMZURFVnBRdGJiSURiQnFWVTVHMy9Odk91S0t0Vysy?=
 =?utf-8?B?QmJMWDBublp4dEhlUzdoYmpGM09JckRpb09ZRUMvTitxeWp3dVh4REdSVy84?=
 =?utf-8?B?Z0E3ZnZiWkhZcXAzbEJuY0pXbFVaSVV1Wm1EVW5JdVZ4WERKZVF6V3IxQ0xE?=
 =?utf-8?B?Zmdtb05yTHZRaS9nMnlXVzd2eHJ2K2h2ejFLSWJGUlJ1SE14YXFtWEJoL2RF?=
 =?utf-8?B?RlAva1ozbmtnbjk2d2w0VG5kZUd5OW5KZWdLZEh1bHFOSXp6L1l2L09NYm9i?=
 =?utf-8?B?R2c4bXY3WHQ0YnNEaXF5bWFiWDNNRVMxUnRsMUJoeGQzWkUrSXhBMWY2OUEr?=
 =?utf-8?B?VWZndzNvMHJrM25Tc1lwTVlFRi8rZGlVRlJjTXZOaU5MUm5WVm9BUGRBa1lQ?=
 =?utf-8?B?Y01xekZSdFYwbWZBVkgyWkFKSlZ1cmpUSWg1U0xuYnE2T0s5cjY4bmZhbHNs?=
 =?utf-8?B?cWdYTmh5Q1ZVbWYvMVdVU2ZpTGhadmlyZ1NueHIvcjlabGlCTE5sK0ZsdExR?=
 =?utf-8?B?SjNRTXFEeHJnanZyWmtYUHlLRWRITGY0ZHBsWm1XcVpwNCsvZWNjRkhNTXBi?=
 =?utf-8?Q?tafI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a4632fa0-8e82-4fd0-bd3d-08dcb1d7d9a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2024 03:13:00.7054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ht3SbrxSrx2D0vDktFhaBxexRr/j0AZ1Q5dRwQuq91EVIuPH5dqCxARLyk1lbCTq497PgSiOPVXotEBh0IfTAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7593

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGkgRGhhbmFuamF5DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
VWd3ZWthciwgRGhhbmFuamF5IDxEaGFuYW5qYXkuVWd3ZWthckBhbWQuY29tPg0KPiBTZW50OiBX
ZWRuZXNkYXksIEp1bHkgMzEsIDIwMjQgNDozOSBQTQ0KPiBUbzogSHVhbmcsIFJheSA8UmF5Lkh1
YW5nQGFtZC5jb20+OyBTaGVub3ksIEdhdXRoYW0gUmFuamFsDQo+IDxnYXV0aGFtLnNoZW5veUBh
bWQuY29tPjsgTGltb25jaWVsbG8sIE1hcmlvDQo+IDxNYXJpby5MaW1vbmNpZWxsb0BhbWQuY29t
PjsgWXVhbiwgUGVycnkgPFBlcnJ5Lll1YW5AYW1kLmNvbT47DQo+IHJhZmFlbEBrZXJuZWwub3Jn
OyB2aXJlc2gua3VtYXJAbGluYXJvLm9yZw0KPiBDYzogbGludXgtcG1Admdlci5rZXJuZWwub3Jn
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGNw
dWZyZXEvYW1kLXBzdGF0ZTogQWRkIHRoZSBtaXNzaW5nIGNwdWZyZXFfY3B1X3B1dCgpDQo+DQo+
IEZvcmdvdCB0aGUgZml4ZXMgdGFnLA0KPg0KPiBPbiA3LzMxLzIwMjQgMjowMiBQTSwgRGhhbmFu
amF5IFVnd2VrYXIgd3JvdGU6DQo+ID4gRml4IHRoZSByZWZlcmVuY2UgY291bnRpbmcgb2YgY3B1
ZnJlcV9wb2xpY3kgb2JqZWN0IGluDQo+ID4gYW1kX3BzdGF0ZV91cGRhdGUoKSBmdW5jdGlvbiBi
eSBhZGRpbmcgdGhlIG1pc3NpbmcgY3B1ZnJlcV9jcHVfcHV0KCkuDQo+ID4NCj4NCj4gRml4ZXM6
IGU4ZjU1NWRhYWNkMyAoImNwdWZyZXEvYW1kLXBzdGF0ZTogZml4IHNldHRpbmcgcG9saWN5IGN1
cnJlbnQNCj4gZnJlcXVlbmN5IHZhbHVlIikNCj4NCj4gVGhhbmtzLA0KPiBEaGFuYW5qYXkNCj4g
PiBTaWduZWQtb2ZmLWJ5OiBEaGFuYW5qYXkgVWd3ZWthciA8RGhhbmFuamF5LlVnd2VrYXJAYW1k
LmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9jcHVmcmVxL2FtZC1wc3RhdGUuYyB8IDIgKysN
Cj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMNCj4gPiBiL2RyaXZlcnMvY3B1ZnJlcS9h
bWQtcHN0YXRlLmMgaW5kZXggODA0ZmFiNGViYjI2Li4zNmVkYWU0MGRiMWENCj4gMTAwNjQ0DQo+
ID4gLS0tIGEvZHJpdmVycy9jcHVmcmVxL2FtZC1wc3RhdGUuYw0KPiA+ICsrKyBiL2RyaXZlcnMv
Y3B1ZnJlcS9hbWQtcHN0YXRlLmMNCj4gPiBAQCAtNTYwLDYgKzU2MCw4IEBAIHN0YXRpYyB2b2lk
IGFtZF9wc3RhdGVfdXBkYXRlKHN0cnVjdCBhbWRfY3B1ZGF0YQ0KPiA+ICpjcHVkYXRhLCB1MzIg
bWluX3BlcmYsDQo+ID4NCj4gPiAgICAgYW1kX3BzdGF0ZV91cGRhdGVfcGVyZihjcHVkYXRhLCBt
aW5fcGVyZiwgZGVzX3BlcmYsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgbWF4X3Bl
cmYsIGZhc3Rfc3dpdGNoKTsNCj4gPiArDQo+ID4gKyAgIGNwdWZyZXFfY3B1X3B1dChwb2xpY3kp
Ow0KPiA+ICB9DQo+ID4NCj4gPiAgc3RhdGljIGludCBhbWRfcHN0YXRlX3ZlcmlmeShzdHJ1Y3Qg
Y3B1ZnJlcV9wb2xpY3lfZGF0YSAqcG9saWN5KQ0KDQpUaGFua3MgZm9yIHRoZSBmaXgsICAgaXQg
bmVlZHMgdG8gc2VuZCB2MiB3aXRoIHRoZSBGaXhlcyB0YWcuDQoNClJldmlld2VkLWJ5OiBQZXJy
eSBZdWFuIDxwZXJyeS55dWFuQGFtZC5jb20+DQoNCkJlc3QgUmVnYXJkcy4NCg0KUGVycnkuDQo=

