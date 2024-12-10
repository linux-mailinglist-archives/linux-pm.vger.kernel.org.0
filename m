Return-Path: <linux-pm+bounces-18906-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA3D9EAFA9
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 12:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7BF8188012B
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 11:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847C6210F6A;
	Tue, 10 Dec 2024 11:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPiwb6ii"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5378C2080C3;
	Tue, 10 Dec 2024 11:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733829298; cv=none; b=QhpIVeTAEsU4E5C4U4YOX00bumUmeaSSpL0p9BCP3RKTTL7HU7SOoIgUwIt2ITmEKFqX3j6Tv8GSHOTrAfPoBVYmyCmQLOEGdKq0epIsDXtrNGZAggF592B0zgfJ2MnZRlqNcKZhcQ977z265ocoOmBE6rzEUpR/ZmkFkSwkMts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733829298; c=relaxed/simple;
	bh=lhICE9COOAdzLbeeCIG0N4z0GPEAUpsD9Gqft5qjfv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cjpCoC09h17PNsFpwP4t1ribzWfcKoS7Cq82TKnFb5Jvj/kgMDwUvHnw+zkn/DypUUAuFfKBjxqkeZQ6UUyz0k/6QUrQRGlSa1+B5WMP3Y+R9IoPDFDgBcnQsQ1ZrB15aA33Onwl5GpTK5DDBpcf4w/G3jiMyyxrIZ3WgT9O7wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPiwb6ii; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B3CDC4CED6;
	Tue, 10 Dec 2024 11:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733829297;
	bh=lhICE9COOAdzLbeeCIG0N4z0GPEAUpsD9Gqft5qjfv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oPiwb6iiYNDZ/WGH9n+gRvMNUl6iGEU0HBgF/24GiCfBXOtlBxpMlXU2u10//8QC8
	 WqMttv5upsoZ3Tccjav4vJtLriG2z2rEYDsmEwVN/VvwArcRysn0T6bYIm41crkJJi
	 sl87IZYqvkQV6kkCxvZux0h/iSCXHxL+rzPJIg7IUXYsrf8XX7OdYAOgsTC9Mt6yrS
	 i0cjfLiLJFBKdSeY8auwuEVGyBJjgmQdF1jsB9TmQsBJLu/1gUHvM1k0/M620uRqjc
	 LqySKf6zHG+OnkBUJPKGWGfTB29xpI/OQhVkIq7IrAf3p6AyEoCARe02X2SdIi2UIZ
	 uzdvgQ8KgEQ0Q==
Date: Tue, 10 Dec 2024 11:14:51 +0000
From: Will Deacon <will@kernel.org>
To: Rob Clark <robdclark@gmail.com>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Rob Clark <robdclark@chromium.org>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	"open list:DRM DRIVER for Qualcomm Adreno GPUs" <dri-devel@lists.freedesktop.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Joao Martins <joao.m.martins@oracle.com>,
	Joerg Roedel <jroedel@suse.de>,
	Konrad Dybcio <konradybcio@kernel.org>,
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sean Paul <sean@poorly.run>, Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v10 0/4] io-pgtable-arm + drm/msm: Extend iova fault
 debugging
Message-ID: <20241210111450.GA14735@willie-the-truck>
References: <20241028213146.238941-1-robdclark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028213146.238941-1-robdclark@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Rob,

On Mon, Oct 28, 2024 at 02:31:36PM -0700, Rob Clark wrote:
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
> v2:  Fix an armv7/32b build error in the last patch
> v3:  Incorperate Will Deacon's suggestion to make the interface
>      callback based.
> v4:  Actually wire up the callback
> v5:  Drop the callback approach
> v6:  Make walk-data struct pgtable specific and rename
>      io_pgtable_walk_data to arm_lpae_io_pgtable_walk_data
> v7:  Re-use the pgtable walker added for arm_lpae_read_and_clear_dirty()
> v8:  Pass pte pointer to callback so it can modify the actual pte
> v9:  Fix selftests_running case
> v10: Call visit cb for all nodes traversed, leave the decision about
>      whether to care about non-leaf nodes to the callback

Do you plan to respin this? I see Mostafa left a proposal on patch 3.

Thanks,

Will

