Return-Path: <linux-pm+bounces-2083-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3B1829C68
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jan 2024 15:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5DCC1F29C71
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jan 2024 14:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E927B4A98B;
	Wed, 10 Jan 2024 14:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G6F9UR1B"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B5648CCE
	for <linux-pm@vger.kernel.org>; Wed, 10 Jan 2024 14:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704896418; x=1736432418;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=C7x+tjEMzevPM8w1GfUw4G4w9UMVMtVKHIk14HR4SJ8=;
  b=G6F9UR1Bz3oHeGCbOR7PAoHNhLQFgHT0YedeBncLSEuvV+vQge455bcW
   +Hf+6NE84CE8iZGikHOKBLNWok6DOY4yfp1bOfBylh+RQR5wyXnphRkwD
   LPOAw9fIwOIF0g+14htwKwVNeXNYGs4vuWvXvrGiWI7UGDGpZYjPbpiXM
   JyjTS5woSUvK3dJT/psAnq3JOcOI66yaFLuZq/p2jXQJOCov5SKUPYOoy
   3usFXiHqcZ2nyyNR5+x56SVWyZgvEL7iBUEFliyeufQRI5B8vfDdGe50s
   YG12BAsk+OaG1H174rHhx4NVXqc8fw/cmANeVV+Cqq1KKQzDbefOyA+9E
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10948"; a="11876759"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="11876759"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 06:20:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10948"; a="785615978"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="785615978"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jan 2024 06:20:08 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Jan 2024 06:20:09 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Jan 2024 06:20:09 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 10 Jan 2024 06:20:09 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Jan 2024 06:20:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nayjG71mDG1PFzhTOCgTveKPGwg97NAWRFgXZbP7DUKBCo83JQLa3Eg75I7GHKsjvl9A5+Ih6NxAf+BPnKpauD+XhpC1CWjCisWlSfxTkMxSkqoxQDU8+T7aMYH3LWA9kd4JNe63dU+pm3TkHDKCyym2sPeYcXx2WUqFua5+GhJtTY5G94opWaTK/LHbAw1qcXwxSm23p2qS59bhfK+9OBrF6mmIhG2wIsLGOv2gyDcjQhBW9RvGiUXDiJmRf9PM4WBKYchDr/yFsy4G412YIW1nPSwjRzPqz/bADG9ib0/buc1brnHjvJ6ineKUAEERuCP97zKZUS8XnvV6VpHIVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKQ2KyXtgulhgJe4q7+hhItd5o5yMoO0dgZvDzcmogg=;
 b=arqzthDZj/b0YgOxyyOJyuhyZCONI8J+d4fAKi3oy+PY64YFnu+W/C4fu28spnx7tmbqzASykwpkxY0ROssac5H79ZikqcCvQn3l0t5wTgGJLNcxaIUDx8NL8OIPTcL857wmt4ebmeDBiljNESYW+N81u9+rU785z+WLOkkC6sgRRC/uKxGBqBvT/9Z3wkOz/ShFB+zNDRGlOln9ONXGrcpJUQhwjneFbsis0vuCZH1PujQ1v2O+fZjPxAUtLTftqiSGzpLa90x80OBfWhPtiTlyM2QyCOoQcq4vkHnpFDIvHFdgTYqiqFqnFWCyWtWGoxybUx8fJ4vAFXDAb9f5QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6059.namprd11.prod.outlook.com (2603:10b6:208:377::9)
 by MW4PR11MB7032.namprd11.prod.outlook.com (2603:10b6:303:227::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 14:20:04 +0000
Received: from MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::a7f1:384c:5d93:1d1d]) by MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::a7f1:384c:5d93:1d1d%4]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 14:20:03 +0000
Date: Wed, 10 Jan 2024 09:19:57 -0500
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
Subject: Re: [PATCH v2 1/2] pm: runtime: Simplify pm_runtime_get_if_active()
 usage
Message-ID: <ZZ6njcJmZzZwNvB-@intel.com>
References: <20240110122356.142997-1-sakari.ailus@linux.intel.com>
 <20240110122503.143029-1-sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240110122503.143029-1-sakari.ailus@linux.intel.com>
X-ClientProxiedBy: SJ0PR05CA0005.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::10) To MN0PR11MB6059.namprd11.prod.outlook.com
 (2603:10b6:208:377::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6059:EE_|MW4PR11MB7032:EE_
X-MS-Office365-Filtering-Correlation-Id: 01a456ad-54e2-468f-ff32-08dc11e73ca6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0mX8MSYwYwa1Wz6KNFLlu7xhe7TYLj0xvfOjOFYslSLLP10wRPpXIiKoO3E95wYG7GmUvJtf/UdFB+6ooTAJOy0SFgN93qUv6J1egYO8NtqN7hkooKl2dEM4AItao75a1gYuMOLMKR4Tl0ns7XuKDM1v/LCgbk4H8i2Pj9YHk4stNKZ5gJHsISqQJrX0FTjaJrXcocy+SSOopjzsFW+yIN+QREGlyqvMFFAR6rgiGPOIxYuoz696wjrGDasvP3V+m6YwoVJAHSjittSYK72h6dpSTwJY5OSmY/oxu5aKdeROcXaunx6ATucSDtdzVjFZMzSOnekmdNxfvNxaRq3x5nPmbdqdALHT3wkVMBKDNBjkEMpIe0UEdg2FNbLqBPfMh3p7RR1pKbpHk8rpf/aJ2mQEJh4irgowEyI74QR+Nl8zDGE0ZcoYN59gnNchzEQ6BY8szdrXAzlscePkxDdI3FTrrk+cPtPvIaQEhaNu4j2plVRyRWVRMsFiE3V78p7Jx5ltkAo6wAYTnyRhmMT1000G6uACxIP4Q+3+s0FAe00xujWcFr4xFp4aYqQ6WSHW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6059.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(136003)(366004)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(316002)(54906003)(8936002)(8676002)(36756003)(6512007)(83380400001)(44832011)(4326008)(66556008)(6506007)(6666004)(6916009)(66946007)(6486002)(26005)(2616005)(478600001)(66476007)(7416002)(30864003)(38100700002)(2906002)(5660300002)(41300700001)(86362001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v3xiAqObI9zOqwlzU5wb91leOeZgkWmQxKKXZ4zOJ0a7PkP2rCUw1g6vj+KG?=
 =?us-ascii?Q?W3jOII4sw2G0ekMbgFn4X2+eZS2KB/cDB0uKH6liWJRiVTj85YmtCNtPr101?=
 =?us-ascii?Q?cZJcvcVKuO5N8IkjvDB/gXdLDqKqZyl6eeuclMeXPREOMaRx8xwqhBjQJ6eB?=
 =?us-ascii?Q?CQgj154eOH0Isn/CztHltzmt68tcBpus2afYj4mxH+xooGwQwdPxHZ94AyMx?=
 =?us-ascii?Q?3ZPcfPUonm558DUQbkjUCIjactw1v1z4tTGYhXqNXKLpblE3+KnGUD9Jurvx?=
 =?us-ascii?Q?k0hgh1saKkn4kGmMaNJaJ29ukuX21HDrNwk82Cfa3yoUZxxuDfVx9BPR1cd2?=
 =?us-ascii?Q?HNJX5lS9tmUAiUQB0vc+UJz+ZjuSMCLOxHJ+EX9daku7NpKJTH9gMxRWizDD?=
 =?us-ascii?Q?uFzASkBcaP94Th5mnyLESoJva4MjgHK39Cf7qnUIcmdNEVXMeJ4wa6KUaHCm?=
 =?us-ascii?Q?yGl/RYTRTWmDOcBANR4KGf/WKsKRLu8l/NpiLkWZA5pa2uMlcua5zM5k5iL7?=
 =?us-ascii?Q?5IVIqSVdUvsouRWday/zKfxETMLhBeQctw7Vt6QSa/teP9427JLoP/AJSQLN?=
 =?us-ascii?Q?8bjkUUiHhvTiT5IETgiNZ3PMLWE8elf6ekaTyLB2TlnqOIG6rhiuGrAREdYL?=
 =?us-ascii?Q?y5w6dF5pbbH5Yrejdt7Yzqcj7GuSB7f4CqPIXzjp1KgcyGNymzXrZfIQAgea?=
 =?us-ascii?Q?OK5yjBMV8Pap08Tm8nviNNcwp4eRTkACS4X2ws2P1DrHWWwLG6lst5RRgiUV?=
 =?us-ascii?Q?XS+Z6z5D9/+vJ9jYJW/ltjpzEQli9+DcohBNYcpplsAlbcRAXVuPs7qHdpt8?=
 =?us-ascii?Q?bUJzVNrP9A/5nD3E04NNYU1qJ3KbHPpUA4VOPmJaDrndXLamYd0bO39pEURr?=
 =?us-ascii?Q?7MzPtYNoJUUN0XTmoDsbjXWx7YQwAgyjiIjNfocvWv7pz/s3ziPbMvGInZXh?=
 =?us-ascii?Q?Y7VvgXU70CfnENVICeW0I+iTuNjcEUDHjvLAngve4GI/RVMxEgRjtCMb62Qi?=
 =?us-ascii?Q?KwLITR8ZbV6/AsjvXZf5f0s+YpD/b434FyQwQbU1VGH9o1ZkRyeUjRpZUCJw?=
 =?us-ascii?Q?31SsBRqwiHa2M8XyRDWv9r2aOJK4IWEfiNzfcWxLQMEYSF2tnry/swoyYKCc?=
 =?us-ascii?Q?iafWglREFjyACMadpcZpT0L56k8rD+JbNDysasqC91w6CbtUn7M1iI2EE3I3?=
 =?us-ascii?Q?y5s7uXSIJ+BWynoP6aafpsVHf3FUp4z6lGBlUYX2Pc9c9l4OQ0GgU2CmQJgS?=
 =?us-ascii?Q?KtVFokpfhrJ1QAncwNRKDvNaGBvUu+kpRQviaJOwt/WvzxluZx3U4xMzRIJA?=
 =?us-ascii?Q?gBXUfsqcJWV+a4WvBg/3ulTYab97OAZ13szCssQRD/FQzpL29lT1EWs+5KtH?=
 =?us-ascii?Q?f0iPJGIsTjIdNFUQ4jHLe7hoRAOCtvwHxZlQDuxYofXBsRWehb7D8WRo3IHx?=
 =?us-ascii?Q?CX30IWoMSpVDhD5cQ+ybhkACkpwcgMhf8BrQ73nutAYicxaSwwdFVfQEkF3T?=
 =?us-ascii?Q?VmsLjMRXfSM68CSUuIqmJhjekimxVenDnBlKbSzo0z2qSuJ7WmcR9Y+iawxW?=
 =?us-ascii?Q?8BPlA8R69yJUWfG0+C8cj+1vDl6uz6ILA3yhOX3VMnPVjOTTtdfgEjye796S?=
 =?us-ascii?Q?bA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 01a456ad-54e2-468f-ff32-08dc11e73ca6
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6059.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 14:20:03.4940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a2tN5jhdXbPUSBrbjWDqUtmB9owQVmgO9H802NsBuTABavKH0WQwUb/W0QUyKY5xKKnWXQdJZldA2ZMUmwQ7hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7032
X-OriginatorOrg: intel.com

On Wed, Jan 10, 2024 at 02:25:03PM +0200, Sakari Ailus wrote:
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
> pm_runtime_get_conditional().
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Reviewed-by: Alex Elder <elder@linaro.org> # drivers/net/ipa/ipa_smp2p.c
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Acked-by: Takashi Iwai <tiwai@suse.de> # sound/
> Reviewed-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com> # drivers/accel/ivpu/
> Acked-by: Rodrigo Vivi <rodrigo.vivi@intel.com> # drivers/gpu/drm/i915/
> ---
>  Documentation/power/runtime_pm.rst      |  5 ++--
>  drivers/accel/ivpu/ivpu_pm.c            |  2 +-
>  drivers/base/power/runtime.c            | 10 +++++---
>  drivers/gpu/drm/i915/intel_runtime_pm.c |  2 +-
>  drivers/gpu/drm/xe/xe_pm.c              |  2 +-
>  drivers/media/i2c/ccs/ccs-core.c        |  2 +-
>  drivers/media/i2c/ov64a40.c             |  2 +-
>  drivers/media/i2c/thp7312.c             |  2 +-
>  drivers/net/ipa/ipa_smp2p.c             |  2 +-
>  drivers/pci/pci.c                       |  2 +-
>  include/linux/pm_runtime.h              | 32 +++++++++++++++++++++----
>  sound/hda/hdac_device.c                 |  2 +-
>  12 files changed, 45 insertions(+), 20 deletions(-)
> 
> diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
> index 65b86e487afe..da99379071a4 100644
> --- a/Documentation/power/runtime_pm.rst
> +++ b/Documentation/power/runtime_pm.rst
> @@ -396,10 +396,9 @@ drivers/base/power/runtime.c and include/linux/pm_runtime.h:
>        nonzero, increment the counter and return 1; otherwise return 0 without
>        changing the counter
>  
> -  `int pm_runtime_get_if_active(struct device *dev, bool ign_usage_count);`
> +  `int pm_runtime_get_if_active(struct device *dev);`
>      - return -EINVAL if 'power.disable_depth' is nonzero; otherwise, if the
> -      runtime PM status is RPM_ACTIVE, and either ign_usage_count is true
> -      or the device's usage_count is non-zero, increment the counter and
> +      runtime PM status is RPM_ACTIVE, increment the counter and
>        return 1; otherwise return 0 without changing the counter
>  
>    `void pm_runtime_put_noidle(struct device *dev);`
> diff --git a/drivers/accel/ivpu/ivpu_pm.c b/drivers/accel/ivpu/ivpu_pm.c
> index 0af8864cb3b5..c6d93c7a1c58 100644
> --- a/drivers/accel/ivpu/ivpu_pm.c
> +++ b/drivers/accel/ivpu/ivpu_pm.c
> @@ -292,7 +292,7 @@ int ivpu_rpm_get_if_active(struct ivpu_device *vdev)
>  {
>  	int ret;
>  
> -	ret = pm_runtime_get_if_active(vdev->drm.dev, false);
> +	ret = pm_runtime_get_if_in_use(vdev->drm.dev);
>  	drm_WARN_ON(&vdev->drm, ret < 0);
>  
>  	return ret;
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 05793c9fbb84..b4cb3f19b0d8 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1176,7 +1176,7 @@ int __pm_runtime_resume(struct device *dev, int rpmflags)
>  EXPORT_SYMBOL_GPL(__pm_runtime_resume);
>  
>  /**
> - * pm_runtime_get_if_active - Conditionally bump up device usage counter.
> + * pm_runtime_get_conditional - Conditionally bump up device usage counter.
>   * @dev: Device to handle.
>   * @ign_usage_count: Whether or not to look at the current usage counter value.
>   *
> @@ -1196,8 +1196,12 @@ EXPORT_SYMBOL_GPL(__pm_runtime_resume);
>   *
>   * The caller is responsible for decrementing the runtime PM usage counter of
>   * @dev after this function has returned a positive value for it.
> + *
> + * This function is not primarily intended for use in drivers, most of which are
> + * better served by either pm_runtime_get_if_active() or
> + * pm_runtime_get_if_in_use() instead.
>   */
> -int pm_runtime_get_if_active(struct device *dev, bool ign_usage_count)
> +int pm_runtime_get_conditional(struct device *dev, bool ign_usage_count)
>  {
>  	unsigned long flags;
>  	int retval;
> @@ -1218,7 +1222,7 @@ int pm_runtime_get_if_active(struct device *dev, bool ign_usage_count)
>  
>  	return retval;
>  }
> -EXPORT_SYMBOL_GPL(pm_runtime_get_if_active);
> +EXPORT_SYMBOL_GPL(pm_runtime_get_conditional);

everything looks great now

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

>  
>  /**
>   * __pm_runtime_set_status - Set runtime PM status of a device.
> diff --git a/drivers/gpu/drm/i915/intel_runtime_pm.c b/drivers/gpu/drm/i915/intel_runtime_pm.c
> index 860b51b56a92..b5f8abd2a22b 100644
> --- a/drivers/gpu/drm/i915/intel_runtime_pm.c
> +++ b/drivers/gpu/drm/i915/intel_runtime_pm.c
> @@ -246,7 +246,7 @@ static intel_wakeref_t __intel_runtime_pm_get_if_active(struct intel_runtime_pm
>  		 * function, since the power state is undefined. This applies
>  		 * atm to the late/early system suspend/resume handlers.
>  		 */
> -		if (pm_runtime_get_if_active(rpm->kdev, ignore_usecount) <= 0)
> +		if (pm_runtime_get_conditional(rpm->kdev, ignore_usecount) <= 0)
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
> index 7c9b35448563..a212b3008ade 100644
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -72,7 +72,8 @@ extern int pm_runtime_force_resume(struct device *dev);
>  extern int __pm_runtime_idle(struct device *dev, int rpmflags);
>  extern int __pm_runtime_suspend(struct device *dev, int rpmflags);
>  extern int __pm_runtime_resume(struct device *dev, int rpmflags);
> -extern int pm_runtime_get_if_active(struct device *dev, bool ign_usage_count);
> +extern int pm_runtime_get_conditional(struct device *dev,
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
> +	return pm_runtime_get_conditional(dev, true);
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
> +	return pm_runtime_get_conditional(dev, false);
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
> +static inline int pm_runtime_get_conditional(struct device *dev,
> +					     bool ign_usage_count)
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

