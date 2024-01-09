Return-Path: <linux-pm+bounces-2004-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B19FF8289F6
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jan 2024 17:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60F52283157
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jan 2024 16:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42993A8C2;
	Tue,  9 Jan 2024 16:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="PtGgdaY/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6B83A1C9
	for <linux-pm@vger.kernel.org>; Tue,  9 Jan 2024 16:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7bedd61c587so23530739f.2
        for <linux-pm@vger.kernel.org>; Tue, 09 Jan 2024 08:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1704817691; x=1705422491; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nby+oSwByD9EHlU56EraVzzwXmfiSFCkU4R70siD1Rc=;
        b=PtGgdaY/O/VySOF6ruAg84gqSePGcVXNjxDpOoblRBanUQmA6+Y7VWPn/6mfpiV60A
         s3j5Eqech0tqGNC++IfUsal6x2f4FKXWv+iMQf9KQ6Ed+lhe9kjx9i1tJlDgC5k2RYIZ
         tJg9EqGJIJnsjuiFMA3uqcBc96Uc4eSuWnezc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704817691; x=1705422491;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nby+oSwByD9EHlU56EraVzzwXmfiSFCkU4R70siD1Rc=;
        b=Btp+p1mPptj1g7C4oqXTSQj6IuWQA3I3BZOJP3jS9ZJUkDu55so3Wo4sMAPXgb4fjP
         G/jjpFZotCPDvhqBZqFop713N3TwXXIBq93K5k8cxk4aXvqw45vW1+Q8v3bGxoY6g9Gx
         6oOaF7IU4Ge8VASRoBHBtBDxUVJCGR2skydyVet+3nV8yM9nAfx2fanMjlBg6YZXntZz
         e0i/thdvdvryDUHAtCwHN779Cfdf9Zz/sCkh7Xa/I/5RRoI2rSJ+I9W69WvvCj1NTL0g
         nJRLWHy9dsCz9V9KwhaSYcHYixj2Uf9Li17r76DicRnckO0vzmuO4WYSruBGcgsl157u
         ynyA==
X-Gm-Message-State: AOJu0YwfS/29xOIusJNE8NeSRQIaaAQukDJLnib+m28InX3l1RZGqJaX
	eQ2UrsZHuI6MtQFoHOyknYjs1naVoSPzQg2Osx2wP320HdvA
X-Google-Smtp-Source: AGHT+IFZANDHlrYQbVqnxa0ellDNxXxwpEYZ0p98XaoK5k8ri1jUTeUsGsc8kvg1NUF1nB6OGAiHjQ==
X-Received: by 2002:a6b:4402:0:b0:7bb:1701:e577 with SMTP id r2-20020a6b4402000000b007bb1701e577mr5547051ioa.42.1704817690709;
        Tue, 09 Jan 2024 08:28:10 -0800 (PST)
Received: from [172.22.22.28] (c-98-61-227-136.hsd1.mn.comcast.net. [98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id e15-20020a6b500f000000b007bedb7d78b3sm404777iob.24.2024.01.09.08.28.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 08:28:10 -0800 (PST)
Message-ID: <5ab94881-052e-4068-ba10-e8c94aa55ec4@ieee.org>
Date: Tue, 9 Jan 2024 10:28:08 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] pm: runtime: Simplify pm_runtime_get_if_active()
 usage
Content-Language: en-US
To: Sakari Ailus <sakari.ailus@linux.intel.com>, linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 laurent.pinchart@ideasonboard.com,
 Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Paul Elder <paul.elder@ideasonboard.com>, Alex Elder <elder@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Mark Brown <broonie@kernel.org>
References: <20240109133639.111210-1-sakari.ailus@linux.intel.com>
 <20240109133657.111258-1-sakari.ailus@linux.intel.com>
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20240109133657.111258-1-sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/9/24 7:36 AM, Sakari Ailus wrote:
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
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

I like it.  For drivers/net/ipa/ipa_smp2p.c:

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>   Documentation/power/runtime_pm.rst      |  5 ++--
>   drivers/accel/ivpu/ivpu_pm.c            |  2 +-
>   drivers/base/power/runtime.c            |  9 ++++---
>   drivers/gpu/drm/i915/intel_runtime_pm.c |  2 +-
>   drivers/gpu/drm/xe/xe_pm.c              |  2 +-
>   drivers/media/i2c/ccs/ccs-core.c        |  2 +-
>   drivers/media/i2c/ov64a40.c             |  2 +-
>   drivers/media/i2c/thp7312.c             |  2 +-
>   drivers/net/ipa/ipa_smp2p.c             |  2 +-
>   drivers/pci/pci.c                       |  2 +-
>   include/linux/pm_runtime.h              | 32 +++++++++++++++++++++----
>   sound/hda/hdac_device.c                 |  2 +-
>   12 files changed, 44 insertions(+), 20 deletions(-)

. . .


