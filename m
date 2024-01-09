Return-Path: <linux-pm+bounces-2020-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFC7828B59
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jan 2024 18:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4690B1C23635
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jan 2024 17:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8F13B781;
	Tue,  9 Jan 2024 17:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OO2p/rX9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AEC3B780
	for <linux-pm@vger.kernel.org>; Tue,  9 Jan 2024 17:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704821737; x=1736357737;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=41Aig2mpf3JzR16dtgBj81jC7BEKkVGeqz3i4LkL6cU=;
  b=OO2p/rX9vmuxfnG8GQl2SPcSOpXq1qS96FFCN7rL7zIR8K2KcH/xdoof
   yj9muX04IYu4JOxnck79n9bcRsp4tf3eW9h+XUei43gIsqbalmYltHVM8
   uztKlAs6Pf3KCTSxIFkLyQ1BprjJvq4OObDoiDxTpSah5idvSHxTBXg4I
   USJueHXKTvBVVHwuY4YTFckDrDHtxWB7sepk0JcNqw3V9Sk9S7ntY5HF0
   Xe9wFPLTEi+w9tSLtzzRZCx/YD56KJjICdxtVlRgMUxNFzJhz3r09KKaG
   uP6P37kQ+NKIr2rVZ+y6A0Eo7k+BbJGY7J1zoiYNFdukr/HJSWYEsRaKy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="429451374"
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="429451374"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 09:35:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="872311215"
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="872311215"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jan 2024 09:35:36 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Jan 2024 09:35:35 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Jan 2024 09:35:35 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Jan 2024 09:35:35 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Jan 2024 09:35:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C1xtRtezNu4gxI9b/W2/6RTrMsmonqNNm0wdPNJzyICsezrBl3wDKYC16LAz63eBxq29qeeQnN+6VKYk8Y/few12Ryms10F68ofH8KufKFrrUBLaX576elz1ktsEhKq7ZwPi0njmdHwjUShRkmtx8N8oCXNOEVgoGBDtiPEg0wj6dCVzYLTv8ujEkXheb1hTWA4tiogzhlPvX6lKE5RWsNqSQaYc8V8LOqqoctzOef9Qp1gkJYXoKhR6znkDdSV2c4jZGdXKpPqEAd8Z9w7zQjAxKVXRyHVLQEtWYj3gDj5yxXCvNu3QNCk5YfcMU+pt5pIu4Zs+/ULDmQnfCR8PGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JuE7Y64rnexzgDazLyxtWYa8eB3CpNWD5m29H7y3BDY=;
 b=jdImBn2hdqMsCRRdqSubdAPqXgDZBtQiRsBhlltr34/b4yIpENmU7WH57Oz3VUTNXSz1D7h5KZPnAY0hcncsDevWrch5PEqp61j6eRlVEjdJqMfo9c1l59Y1LsnX75hFhUuFzf2srH7c7vagZhInMvyWe22s/G8L2gq3WjlGXNJYxmcgAbe4S0p9C5DAtGdDGFaUnnzmv+J0LxKseEg0woZSNzK+ccQYtCScCODFAp9uvwR6Yigkn48DUAX03CJrN7Bsq3ojnfQCvN2B+v71coE7ZBqgIPV7rxk6ba9wq+KIekIeXYyuZmJwns9cqtUVpBTwVCYmktHxyMCmxd8nzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6059.namprd11.prod.outlook.com (2603:10b6:208:377::9)
 by DM6PR11MB4756.namprd11.prod.outlook.com (2603:10b6:5:2a7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 17:35:32 +0000
Received: from MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::a7f1:384c:5d93:1d1d]) by MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::a7f1:384c:5d93:1d1d%4]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 17:35:31 +0000
Date: Tue, 9 Jan 2024 12:35:25 -0500
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
CC: <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>,
	<laurent.pinchart@ideasonboard.com>, Jacek Lawrynowicz
	<jacek.lawrynowicz@linux.intel.com>, Stanislaw Gruszka
	<stanislaw.gruszka@linux.intel.com>, Jani Nikula
	<jani.nikula@linux.intel.com>, Joonas Lahtinen
	<joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin
	<tvrtko.ursulin@linux.intel.com>, David Airlie <airlied@gmail.com>, "Daniel
 Vetter" <daniel@ffwll.ch>, Lucas De Marchi <lucas.demarchi@intel.com>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, Paul Elder
	<paul.elder@ideasonboard.com>, Alex Elder <elder@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Mark Brown
	<broonie@kernel.org>
Subject: Re: [PATCH 1/2] pm: runtime: Simplify pm_runtime_get_if_active()
 usage
Message-ID: <ZZ2D3Tv2ZW9NuQoz@intel.com>
References: <20240109133639.111210-1-sakari.ailus@linux.intel.com>
 <20240109133657.111258-1-sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240109133657.111258-1-sakari.ailus@linux.intel.com>
X-ClientProxiedBy: SJ0PR13CA0112.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::27) To MN0PR11MB6059.namprd11.prod.outlook.com
 (2603:10b6:208:377::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6059:EE_|DM6PR11MB4756:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e37d21b-4666-465d-a33c-08dc113960cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hRa1MzVfa+pcNa45Zuc6GzFGQA7NpWC1SFhyFh9vd1Ytnjxem4AUi5Uaryhv0eUd89BUpFNvjq1hQC/sJY+BWjjM8Ija9Xmy0NXVjzK65+xiewgKeEPKi+eriwzITY3dlWY2MAPfB7OKXejMEnG3uc7qVrwsnEhRNnQwHzAmz10ss+yGt9PT6qqYqO+0ukeoZPGYRlVvz2wrrY5K6f7rHRwpRL9sdSmfNO0M7JoPXDFzRZuhhSV6R/zNCADVfPR2PkunYSKYZYUIciKACN6WotYnJEKlDzWXYEQU1OI+zqWfH6MBgOyqJN7N5MS6QEs+eVXfSga0o+SrfMLFM1gr6omLpymp6DDVUXSq8cqhHZU4MdpGV6nDp1V10nfUq/+h0BZrwXgMT8eNNqqvE3AcXu61Wg5+5s2+ZCX0ShEenLL4+xa2obazASCPXWu/jaoWDV/PaAioKUflVcbrUFA0HdoZtGtuvwEZQLaxmTe4SOZWFUO4YCsW2cBRymsRn+81i90RB5V9C1renUnrFKiWZUHEK/hXzKZ8bHn106ao0jqE7OhwIqhY5KgD4evALnQf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6059.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(376002)(346002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(83380400001)(26005)(6512007)(86362001)(36756003)(38100700002)(82960400001)(4326008)(6666004)(7416002)(44832011)(5660300002)(2616005)(66556008)(316002)(8936002)(6916009)(8676002)(66476007)(66946007)(2906002)(478600001)(6506007)(6486002)(54906003)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p3947fCGDdzspMuLXnTrnzo33IUvHnfD+EGM/VyOcXWqCinXC8nsFNq5SpB9?=
 =?us-ascii?Q?p/MciYsvAS48+ecESau2vTGoqva3nL+lcBjnj5d6KoJ59a00efHrF2aIZjB6?=
 =?us-ascii?Q?+nUCseMQv8PU8OVsRedfOHCl4BDe419jtysIeU7RPj2gHaD0keZw72Jtk5g2?=
 =?us-ascii?Q?QbLo5/DeFxQoQY9FzHYWkyOpH+U1f6ilbentxTCrcUynY/9b0/IM3uFC1pKA?=
 =?us-ascii?Q?QK6oJm1SOpTQlSG98JVPEJ4sKuntqO7kjUTdQxfw8DMHDT3KGFp8T1Cr7bL+?=
 =?us-ascii?Q?+5s8yhRI+XIO6dpJ262UrgQZTRgZonspL53lQxDaDzPWbrB4hVqNMImsRmpv?=
 =?us-ascii?Q?TZg/sl07ACQjGhJJAVTmX5wz9bP1vC8Kox6yxYo0FJDXEchElokyQvwB5cgT?=
 =?us-ascii?Q?DYeeuaw7CCUwKynqVAcjK0wdfQm0fgGFG4UiBLnxO7bw6wDdUWBl2ogIogIu?=
 =?us-ascii?Q?TllOamh7fj8tcy1asM1duV5MJ+ZoqKYHc8CFpmY9VmCpRQyba/VaDWWKCcbq?=
 =?us-ascii?Q?tFXoy/G+KH3Dnf7k2Kn6VVrdjeSTeuFF/H7Vgw42uvN1LsVehIjT6iJyP7Vh?=
 =?us-ascii?Q?N82eN1aRrF8FKZxD7BNJwSoNc55SaACKtEkQSzkbBDFeL8b+ObllSUTC2Tvg?=
 =?us-ascii?Q?fR+yd1s6LYp5pxQsafJ61HQXZ7iEZltdo5MMWt/mBfUU0sh7u+v8/a8T3PqS?=
 =?us-ascii?Q?x5vz4bOruTjJaLUqMEQ5ejEeHcZR96nXSSjTuQ1G6qUGCSVY6qH4AN6TkeR/?=
 =?us-ascii?Q?TyTWeXATiRQcept+MNx7PqQkCch4c4zscVMsohfRXaFbY8DMzMj4GXtFGiXq?=
 =?us-ascii?Q?cCgCq8QtRvjSLWgG2nh05YMVinY2TFgAm/FGZ/n24T1DHuSORCe5Fa53frFv?=
 =?us-ascii?Q?05LNm/tJmTTuOOckD7F5W4FTdOP2kwPoP+bQSjZM6UU5ShjIo15mpkIBXAw+?=
 =?us-ascii?Q?mI/Y6qdUFRabnoBTqGhWy/dgN1O2cUC438jm9vtKzHtE3bOC4DtIF7Z6Q0b5?=
 =?us-ascii?Q?mNr/iJgX3aS8YFZ7056tPfaV6DeJWy+KTzgixEhLzSVPJ9djxC7E70P26Itz?=
 =?us-ascii?Q?ung7i17Z3WsGWgKpTBicXQuJ+QwmMDrjNcHMTPNrSJGyQ4N+DJKEqynE2h1Q?=
 =?us-ascii?Q?M/hKOfP5awarI1PGNnuxVFvOn0dt4p6XTzmGJeVvyEOcq7GuaYmrd0hz8MLF?=
 =?us-ascii?Q?Kq8jlFLL5hfuRfMs3XqLd8Hu+2hHrH8UoeK6xTgfH0hb/mNC6jbgEmnbFanf?=
 =?us-ascii?Q?rGF0B/ELFBjkzgJ/k2pjibALIB4LjYZYcR3jYWbUV9AQ0qWf002PB2wPc8Vf?=
 =?us-ascii?Q?jWhnJqkpUXP8SQOW6ltIAgfQqLPtO50ihqKgGRmPQ6RH81mo2mQdlUcFj7Td?=
 =?us-ascii?Q?ixsXXavrLZAlXfUKsPenkMjwBkGi9QrP6skE5p1ZmRQ3me4ie+DsiXzcg6va?=
 =?us-ascii?Q?ZkyHJ+C3DgOb/a0EjFrNzyKSR50x7mK22x849JCWoYu7ETM6tcY8JaTT2ApO?=
 =?us-ascii?Q?FLp09OpV6AOg824c5EsEYMI9O21e7af7zbKEk7FXmxk8ZR+yzB+CvZtgjU4l?=
 =?us-ascii?Q?qi+YqzLlDm16t1vFnfzaXoei4GkobodDI+oRFT2q?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e37d21b-4666-465d-a33c-08dc113960cf
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6059.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 17:35:31.8578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0q8xmYgbH4IuTYD0Zlywvc1bRJp+NC770Lo1Keruu4ePG0bdc9uPcYnz2UW/gK7Jj7iPKnwdqhpw9+9ru6DIIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4756
X-OriginatorOrg: intel.com

On Tue, Jan 09, 2024 at 03:36:57PM +0200, Sakari Ailus wrote:
> There are two ways to opportunistically increment a device's runtime PM
> usage count, calling either pm_runtime_get_if_active() or
> pm_runtime_get_if_in_use(). The former has an argument to tell whether to
> ignore the usage count or not, and the latter simply calls the former with
> ign_usage_count set to false. The other users that want to ignore the
> usage_count will have to explitly set that argument to true which is a bit
> cumbersome.
> 
> To make this function more practical to use, remove the ign_usage_count
> argument from the function. The main implementation is renamed as
> __pm_runtime_get_conditional().

Great idea! I recently found a bug in Xe caused by some confusion
with the ign_usage_count var.

> + * This function is not intended to be called by drivers, use
> + * pm_runtime_get_if_active() or pm_runtime_get_if_in_use() instead.
>   */

Well, it is not intended, but we already have an usage for that.
So, shouldn't we avoid the '__' and just put as recommendation?
Like we have around the get_sync telling that the preferred way is
the resume_and_get for a cleaner code?

> -EXPORT_SYMBOL_GPL(pm_runtime_get_if_active);
> +EXPORT_SYMBOL_GPL(__pm_runtime_get_conditional);

Also the '__' in the exported and documented one doesn't look so nice.
Well, I know that this would be the case even without any driver using
because of the static inline anyway.

>  
>  /**
>   * __pm_runtime_set_status - Set runtime PM status of a device.
> diff --git a/drivers/gpu/drm/i915/intel_runtime_pm.c b/drivers/gpu/drm/i915/intel_runtime_pm.c
> index 860b51b56a92..51cbca330bd5 100644
> --- a/drivers/gpu/drm/i915/intel_runtime_pm.c
> +++ b/drivers/gpu/drm/i915/intel_runtime_pm.c
> @@ -246,7 +246,7 @@ static intel_wakeref_t __intel_runtime_pm_get_if_active(struct intel_runtime_pm
>  		 * function, since the power state is undefined. This applies
>  		 * atm to the late/early system suspend/resume handlers.
>  		 */
> -		if (pm_runtime_get_if_active(rpm->kdev, ignore_usecount) <= 0)
> +		if (__pm_runtime_get_conditional(rpm->kdev, ignore_usecount) <= 0)

Acked-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

>  			return 0;
>  	}
>  
> diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
> index b429c2876a76..dd110058bf74 100644
> --- a/drivers/gpu/drm/xe/xe_pm.c
> +++ b/drivers/gpu/drm/xe/xe_pm.c
> @@ -330,7 +330,7 @@ int xe_pm_runtime_put(struct xe_device *xe)
>  
>  int xe_pm_runtime_get_if_active(struct xe_device *xe)
>  {
> -	return pm_runtime_get_if_active(xe->drm.dev, true);
> +	return pm_runtime_get_if_active(xe->drm.dev);
>  }
>  
>  void xe_pm_assert_unbounded_bridge(struct xe_device *xe)
> diff --git a/drivers/media/i2c/ccs/ccs-core.c b/drivers/media/i2c/ccs/ccs-core.c
> index e21287d50c15..e1ae0f9fad43 100644
> --- a/drivers/media/i2c/ccs/ccs-core.c
> +++ b/drivers/media/i2c/ccs/ccs-core.c
> @@ -674,7 +674,7 @@ static int ccs_set_ctrl(struct v4l2_ctrl *ctrl)
>  		break;
>  	}
>  
> -	pm_status = pm_runtime_get_if_active(&client->dev, true);
> +	pm_status = pm_runtime_get_if_active(&client->dev);
>  	if (!pm_status)
>  		return 0;
>  
> diff --git a/drivers/media/i2c/ov64a40.c b/drivers/media/i2c/ov64a40.c
> index 4fba4c2cb064..541bf74581d2 100644
> --- a/drivers/media/i2c/ov64a40.c
> +++ b/drivers/media/i2c/ov64a40.c
> @@ -3287,7 +3287,7 @@ static int ov64a40_set_ctrl(struct v4l2_ctrl *ctrl)
>  					 exp_max, 1, exp_val);
>  	}
>  
> -	pm_status = pm_runtime_get_if_active(ov64a40->dev, true);
> +	pm_status = pm_runtime_get_if_active(ov64a40->dev);
>  	if (!pm_status)
>  		return 0;
>  
> diff --git a/drivers/media/i2c/thp7312.c b/drivers/media/i2c/thp7312.c
> index 2806887514dc..19bd923a7315 100644
> --- a/drivers/media/i2c/thp7312.c
> +++ b/drivers/media/i2c/thp7312.c
> @@ -1052,7 +1052,7 @@ static int thp7312_s_ctrl(struct v4l2_ctrl *ctrl)
>  	if (ctrl->flags & V4L2_CTRL_FLAG_INACTIVE)
>  		return -EINVAL;
>  
> -	if (!pm_runtime_get_if_active(thp7312->dev, true))
> +	if (!pm_runtime_get_if_active(thp7312->dev))
>  		return 0;
>  
>  	switch (ctrl->id) {
> diff --git a/drivers/net/ipa/ipa_smp2p.c b/drivers/net/ipa/ipa_smp2p.c
> index 5620dc271fac..cbf3d4761ce3 100644
> --- a/drivers/net/ipa/ipa_smp2p.c
> +++ b/drivers/net/ipa/ipa_smp2p.c
> @@ -92,7 +92,7 @@ static void ipa_smp2p_notify(struct ipa_smp2p *smp2p)
>  		return;
>  
>  	dev = &smp2p->ipa->pdev->dev;
> -	smp2p->power_on = pm_runtime_get_if_active(dev, true) > 0;
> +	smp2p->power_on = pm_runtime_get_if_active(dev) > 0;
>  
>  	/* Signal whether the IPA power is enabled */
>  	mask = BIT(smp2p->enabled_bit);
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index d8f11a078924..f8293ae71389 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2510,7 +2510,7 @@ static void pci_pme_list_scan(struct work_struct *work)
>  			 * If the device is in a low power state it
>  			 * should not be polled either.
>  			 */
> -			pm_status = pm_runtime_get_if_active(dev, true);
> +			pm_status = pm_runtime_get_if_active(dev);
>  			if (!pm_status)
>  				continue;
>  
> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> index 7c9b35448563..13cd526634c1 100644
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -72,7 +72,8 @@ extern int pm_runtime_force_resume(struct device *dev);
>  extern int __pm_runtime_idle(struct device *dev, int rpmflags);
>  extern int __pm_runtime_suspend(struct device *dev, int rpmflags);
>  extern int __pm_runtime_resume(struct device *dev, int rpmflags);
> -extern int pm_runtime_get_if_active(struct device *dev, bool ign_usage_count);
> +extern int __pm_runtime_get_conditional(struct device *dev,
> +					bool ign_usage_count);
>  extern int pm_schedule_suspend(struct device *dev, unsigned int delay);
>  extern int __pm_runtime_set_status(struct device *dev, unsigned int status);
>  extern int pm_runtime_barrier(struct device *dev);
> @@ -94,16 +95,33 @@ extern void pm_runtime_release_supplier(struct device_link *link);
>  
>  extern int devm_pm_runtime_enable(struct device *dev);
>  
> +/**
> + * pm_runtime_get_if_active - Bump up runtime PM usage counter if the device is
> + *			      in active state
> + * @dev: Target device.
> + *
> + * Increment the runtime PM usage counter of @dev if its runtime PM status is
> + * %RPM_ACTIVE, in which case it returns 1. If the device is in a different
> + * state, 0 is returned. -EINVAL is returned if runtime PM is disabled for the
> + * device.
> + */
> +static inline int pm_runtime_get_if_active(struct device *dev)
> +{
> +	return __pm_runtime_get_conditional(dev, true);
> +}
> +
>  /**
>   * pm_runtime_get_if_in_use - Conditionally bump up runtime PM usage counter.
>   * @dev: Target device.
>   *
>   * Increment the runtime PM usage counter of @dev if its runtime PM status is
> - * %RPM_ACTIVE and its runtime PM usage counter is greater than 0.
> + * %RPM_ACTIVE and its runtime PM usage counter is greater than 0, in which case
> + * it returns 1. If the device is in a different state or its usage_count is 0,
> + * 0 is returned. -EINVAL is returned if runtime PM is disabled for the device.
>   */
>  static inline int pm_runtime_get_if_in_use(struct device *dev)
>  {
> -	return pm_runtime_get_if_active(dev, false);
> +	return __pm_runtime_get_conditional(dev, false);
>  }
>  
>  /**
> @@ -275,8 +293,12 @@ static inline int pm_runtime_get_if_in_use(struct device *dev)
>  {
>  	return -EINVAL;
>  }
> -static inline int pm_runtime_get_if_active(struct device *dev,
> -					   bool ign_usage_count)
> +static inline int pm_runtime_get_if_active(struct device *dev)
> +{
> +	return -EINVAL;
> +}
> +static inline int __pm_runtime_get_conditional(struct device *dev,
> +					       bool ign_usage_count)
>  {
>  	return -EINVAL;
>  }
> diff --git a/sound/hda/hdac_device.c b/sound/hda/hdac_device.c
> index 7f7b67fe1b65..068c16e52dff 100644
> --- a/sound/hda/hdac_device.c
> +++ b/sound/hda/hdac_device.c
> @@ -612,7 +612,7 @@ EXPORT_SYMBOL_GPL(snd_hdac_power_up_pm);
>  int snd_hdac_keep_power_up(struct hdac_device *codec)
>  {
>  	if (!atomic_inc_not_zero(&codec->in_pm)) {
> -		int ret = pm_runtime_get_if_active(&codec->dev, true);
> +		int ret = pm_runtime_get_if_active(&codec->dev);
>  		if (!ret)
>  			return -1;
>  		if (ret < 0)
> -- 
> 2.39.2
> 

