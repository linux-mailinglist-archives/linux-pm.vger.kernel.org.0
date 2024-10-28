Return-Path: <linux-pm+bounces-16569-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD969B2F55
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 12:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48A351F20F30
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 11:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F4D1D5ADE;
	Mon, 28 Oct 2024 11:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i3rTyWpk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAF01D0E38
	for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 11:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730116422; cv=none; b=egCUgdlvfkOYrcfcl30TnjpvTkvZAFLogPFfbynBpnT/C65ynafp8xlOGnkieQUn9wcSg7gwWVnCZep5YVxWUdRAR40Y4Mr3INiVpd/PwMPYpLph8+2IlYkMb/IEJv91KQnRmzDtxaKkmR9DZOJYtJOJQGR4YhcDpd4ZYy1xhcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730116422; c=relaxed/simple;
	bh=6QkgyBDKShlQ0y/cx9QH4amUPnbLqaaOreh4ogVY54Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCuqgqxh2AGb5hjug7EP/KZLeTY+YBd+ZbMf9VakcP2kXdS5S7qw8qPSRXZ607cAWK6TCQ6YZ6eDAf8jP75VPTeo3Jzd6G3rGjX1NqJjYvDrUdWOXREdCoaZCqTyJPWcdJzBmCUeohKrlBcc1DLHooGpGhIJsgeZR2qs+0ynkXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i3rTyWpk; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43150ea2db6so148155e9.0
        for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 04:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730116417; x=1730721217; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s8ohfpnIEvg7feisWnyEQsAMOz4YBMRZ4DT963EvlJY=;
        b=i3rTyWpk70CIPABaFlYyKNgHbGBH7oZCMF1MT9tY3/9GcRuFks3uXvY60ei17WiDD0
         VQldY0CHYYyK4RFwFCX93Gxyywx093b7CrL6KjpTPQlweuzN3jDv0kWYpxUn9NAYAZ5A
         vXQeMHufEkVjXI9pEZ/QGsSK2JAFkp0I1gjqq9Klaw+pqNLAv9piOMNVQhe/R2xMjTCd
         Vj9Fy3Zn1XowaC/1Y6/ofY7vWwkLPqVujCmI9zR5s4KsUYHQjCWWg6s0TP1MD1eJTmGS
         ihu5oaYTJbgFhJgLViPU1Fi+a+uF3dB2/40fZ7q6mbOIoJg6ikXBMAvB2ajQqXrjf+i5
         Arlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730116417; x=1730721217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8ohfpnIEvg7feisWnyEQsAMOz4YBMRZ4DT963EvlJY=;
        b=fqbQ6bu3hC2N8LayBmnVNcB1Mt/+QJ4irOCDKSV1zZQTx4sQwNM0zN8Lc9iMCp+tua
         hR2NbIg2XavvSRtip/wK7rDynV95ML5yT6GbqEQkXCUiRJmYH6KuPocA+WUH9ES4yG7E
         Af/BhlnMmDnrLvSZbx15gtWeOqsnzHEVA+CEA2AkJiS38xGunzd7ZLI+4StrAnPDIA6U
         6HmqU+YuJwDc/WFauho+vCIns1+f5ncKJBLCTYmbWnnlYCsPfrosPaoFvhzVdvLa+QS5
         9tEzPbcySCxEr3RydBpuUqn2KSmcXbYFGbifoN2VYREAQVQPbCQNRpCEB31xEMFvU45u
         sXPg==
X-Forwarded-Encrypted: i=1; AJvYcCXNspqSmgZ/8WsgsIORaXsfZWpHTUT9TPEq3WeihFSNupqzP5+NlWSn27KvlRFjnA+028XpfKZxkA==@vger.kernel.org
X-Gm-Message-State: AOJu0YymF+0m8knVG38B55baCB8FG6uACNGmkq6cWPeQlMvntbm2dIxf
	iCMm/VFor0pYy5IztE9pbPU/clFeI3j6Qu6ix7UznEpKVJ1GFND0EHvB36NZCg==
X-Google-Smtp-Source: AGHT+IFAG1wQgZSHD4GZ1FDVInCNhg5i9ZX5wl+jOWzRo1tsON7IOnOTabrNuttxFekm1NvUnzUp2w==
X-Received: by 2002:a05:600c:1e8f:b0:426:66a0:6df6 with SMTP id 5b1f17b1804b1-4319ab034e8mr4472705e9.0.1730116417455;
        Mon, 28 Oct 2024 04:53:37 -0700 (PDT)
Received: from google.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4319359527asm106666165e9.16.2024.10.28.04.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 04:53:36 -0700 (PDT)
Date: Mon, 28 Oct 2024 11:53:33 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Rob Clark <robdclark@gmail.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Clark <robdclark@chromium.org>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	"open list:DRM DRIVER for Qualcomm Adreno GPUs" <dri-devel@lists.freedesktop.org>,
	"open list:DRM DRIVER for Qualcomm Adreno GPUs" <freedreno@lists.freedesktop.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Joao Martins <joao.m.martins@oracle.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
	"open list:DRM DRIVER for Qualcomm Adreno GPUs" <linux-arm-msm@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sean Paul <sean@poorly.run>, Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v9 0/4] io-pgtable-arm + drm/msm: Extend iova fault
 debugging
Message-ID: <Zx97PU7cUEVCnpPl@google.com>
References: <20240827181717.187245-1-robdclark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827181717.187245-1-robdclark@gmail.com>

Hi Rob,

On Tue, Aug 27, 2024 at 11:17:08AM -0700, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> This series extends io-pgtable-arm with a method to retrieve the page
> table entries traversed in the process of address translation, and then
> beefs up drm/msm gpu devcore dump to include this (and additional info)
> in the devcore dump.
> 
> This is a respin of https://patchwork.freedesktop.org/series/94968/
> (minus a patch that was already merged)
> 
> v2: Fix an armv7/32b build error in the last patch
> v3: Incorperate Will Deacon's suggestion to make the interface
>     callback based.
> v4: Actually wire up the callback
> v5: Drop the callback approach
> v6: Make walk-data struct pgtable specific and rename
>     io_pgtable_walk_data to arm_lpae_io_pgtable_walk_data
> v7: Re-use the pgtable walker added for arm_lpae_read_and_clear_dirty()
> v8: Pass pte pointer to callback so it can modify the actual pte
> v9: Fix selftests_running case
> 
> Rob Clark (4):
>   iommu/io-pgtable-arm: Make pgtable walker more generic
>   iommu/io-pgtable-arm: Re-use the pgtable walk for iova_to_phys
>   iommu/io-pgtable-arm: Add way to debug pgtable walk
>   drm/msm: Extend gpu devcore dumps with pgtbl info

Do you have plans to post another version of this series, as I am
working on some patches, that would use some of the common page walk
logic, so it would be more convenient to have them upstream.
Otherwise, I can have your series as a dependency.

Thanks,
Mostafa


> 
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c |  10 ++
>  drivers/gpu/drm/msm/msm_gpu.c           |   9 ++
>  drivers/gpu/drm/msm/msm_gpu.h           |   8 ++
>  drivers/gpu/drm/msm/msm_iommu.c         |  22 ++++
>  drivers/gpu/drm/msm/msm_mmu.h           |   3 +-
>  drivers/iommu/io-pgtable-arm.c          | 149 +++++++++++++++---------
>  include/linux/io-pgtable.h              |  15 +++
>  7 files changed, 160 insertions(+), 56 deletions(-)
> 
> -- 
> 2.46.0
> 

