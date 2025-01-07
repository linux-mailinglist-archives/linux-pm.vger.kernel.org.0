Return-Path: <linux-pm+bounces-20050-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D43AA046EB
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 17:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4C1E3A7136
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 16:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7198F1F7069;
	Tue,  7 Jan 2025 16:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mtt3ghXB"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4221D1F7060;
	Tue,  7 Jan 2025 16:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736268175; cv=none; b=iGS0MxsKzafGWrmTy8yEsxJC1VujU7AL5urCiA7hp0weVJxZyBP8wyJkc5tTXHEZ5qQ9m10tefSguSdrkcLCb9pAwRhZfWpdKK0iryr7b2Ythwjrq5bIJ40PdRVMdTMJT+uQUVk9MkTbN9hPJ5eUl/gIsUSAQkL8K169a4T1DGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736268175; c=relaxed/simple;
	bh=baWwtF1w+geq+KjvSOWUWaiuN8aV6ywKcKbSE05GCq8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LgJLYK4qD0ZJpV00z0GdegclyZP9afIsGV4YKqFfQa9rmSDAEEigpxGmOp9EXf7b72uO7Sy/afpf3iG4q6egSMdy3G0H6zzh9ZgHpsK4hjc33nln8TkNfBocY+v8Xxa5KHzSaSLJ2Nay/h6ufQG2+kVIlQLuYbB8iXA62RYkyKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mtt3ghXB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ADAFC4CED6;
	Tue,  7 Jan 2025 16:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736268175;
	bh=baWwtF1w+geq+KjvSOWUWaiuN8aV6ywKcKbSE05GCq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mtt3ghXB5IecyfyJLJHtV7Unz6mbhvjGhTJ+W3O3LKhKsYiLqGvGfyuNUsKgGbN1w
	 gK85tjzhugigyHQMiMzLBBU9UugJBkLHYEvgFZJMlwt2noxIdKjB3KmlickGp3vJKY
	 2RP2WLTk0lJECxowFX5BOpEcHLse5IefNOj5ZP/3bQGGzsB8gIQd5OiMG66pBMWN5R
	 MJBPvtcLAjlUokaXBgq1S4NmDfJLdSF15W1KlSdcTy9ODAQksfiI5OQr3/qnn4Xq0j
	 XD6z+vdnel5O9AvExLarBUgv6ymUTFeyHc92uVGNcOVWfSgPKtUQG6AktbL1yu87cb
	 bpAeqPOlFmc4A==
From: Will Deacon <will@kernel.org>
To: iommu@lists.linux.dev,
	Rob Clark <robdclark@gmail.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org,
	Mostafa Saleh <smostafa@google.com>,
	Rob Clark <robdclark@chromium.org>,
	dri-devel@lists.freedesktop.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Joao Martins <joao.m.martins@oracle.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Marijn Suijten <marijn.suijten@somainline.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Sean Paul <sean@poorly.run>
Subject: Re: [PATCH v11 0/4] io-pgtable-arm + drm/msm: Extend iova fault debugging
Date: Tue,  7 Jan 2025 16:42:40 +0000
Message-Id: <173626454505.2884304.2651538990179658967.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241210165127.600817-1-robdclark@gmail.com>
References: <20241210165127.600817-1-robdclark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 10 Dec 2024 08:51:18 -0800, Rob Clark wrote:
> This series extends io-pgtable-arm with a method to retrieve the page
> table entries traversed in the process of address translation, and then
> beefs up drm/msm gpu devcore dump to include this (and additional info)
> in the devcore dump.
> 
> This is a respin of https://patchwork.freedesktop.org/series/94968/
> (minus a patch that was already merged)
> 
> [...]

Applied io-pgtable changes to iommu (arm/smmu/updates), thanks!

[1/4] iommu/io-pgtable-arm: Make pgtable walker more generic
      https://git.kernel.org/iommu/c/821500d5c597
[2/4] iommu/io-pgtable-arm: Re-use the pgtable walk for iova_to_phys
      https://git.kernel.org/iommu/c/d9e589e6ad73
[3/4] iommu/io-pgtable-arm: Add way to debug pgtable walk
      https://git.kernel.org/iommu/c/aff028a8192d

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

