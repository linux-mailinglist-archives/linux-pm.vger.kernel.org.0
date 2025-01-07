Return-Path: <linux-pm+bounces-20042-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FE2A0401C
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 13:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 300191887A7C
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 12:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C36C1F03EF;
	Tue,  7 Jan 2025 12:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8ySdhAY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E815C1F03E2;
	Tue,  7 Jan 2025 12:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736254728; cv=none; b=sUH1DJkUmtjkH8yzwZGR6ey8Rbd+2vl0g5J912yAzl/YYqw5lJh/nDubVcHXK2923TiqsI3X9RoBw7A6EwxMUKOV8F0MsoHphxAeKJRZWdYFph0EWOM0fkWM2hIiiC3ev+3j1Bno4A4to6pEWww1hM/olWH5haswhR0oR1mk/oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736254728; c=relaxed/simple;
	bh=0d8chFQwCQH17RxZgem2YuxeZFD8iqNF18spSTjEvc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kwr3e1Q1wufSrK0wi/FkXAAM9opOvqsi1BYBmPUabmx3lROO9xa4zfd9ky48HQREGct04gYtBqDa2ZN21bmMspThHRKLzuDsIyaWgUZ0YMp5aijfV0JDmBwS5cBRcR4nMfDWMblK5IIGTWqgQDmbSA/QWNPYF719Tiv8KogyUk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8ySdhAY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F014C4CEE2;
	Tue,  7 Jan 2025 12:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736254727;
	bh=0d8chFQwCQH17RxZgem2YuxeZFD8iqNF18spSTjEvc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m8ySdhAYCP+O/e4xmQy+M+8iHJf+MVc/zbwzBVDHy31+rGtRSf95w9/67SxvFbz/4
	 nuEdInTnNN6apCgnGTLsBxOg95cwpbAa5q5bq5RkqGfkPRi1MfygXVkmLpvL7jSiVz
	 mQCYobyHdRyRqzP9dTUKrrwmZUDHhpFognYGe+EcjMPhcCEPavD2oh60E6KVFg/2EI
	 LcEylZoywSRRQzT4iTNN8D+jj8HzLw+cUu089n6lRlOM/vyETC/VWtoVrhZDaiASgp
	 jT+dxh5ubmQnxiIrVrOzc+aoj9Yet8Ls4vJIVa3cbQvLe5AUW1PVy987hCJoXfO21p
	 1mxzDVsIgFTEA==
Date: Tue, 7 Jan 2025 12:58:41 +0000
From: Will Deacon <will@kernel.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: Rob Clark <robdclark@gmail.com>, iommu@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
	Rob Clark <robdclark@chromium.org>,
	"open list:DRM DRIVER for Qualcomm Adreno GPUs" <dri-devel@lists.freedesktop.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Joao Martins <joao.m.martins@oracle.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Sean Paul <sean@poorly.run>
Subject: Re: [PATCH v11 0/4] io-pgtable-arm + drm/msm: Extend iova fault
 debugging
Message-ID: <20250107125840.GB6991@willie-the-truck>
References: <20241210165127.600817-1-robdclark@gmail.com>
 <Z30kWxVxwJXO_z2_@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z30kWxVxwJXO_z2_@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Jan 07, 2025 at 12:55:55PM +0000, Mostafa Saleh wrote:
> On Tue, Dec 10, 2024 at 08:51:18AM -0800, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> > 
> > This series extends io-pgtable-arm with a method to retrieve the page
> > table entries traversed in the process of address translation, and then
> > beefs up drm/msm gpu devcore dump to include this (and additional info)
> > in the devcore dump.
> > 
> > This is a respin of https://patchwork.freedesktop.org/series/94968/
> > (minus a patch that was already merged)
> > 
> > v2:  Fix an armv7/32b build error in the last patch
> > v3:  Incorperate Will Deacon's suggestion to make the interface
> >      callback based.
> > v4:  Actually wire up the callback
> > v5:  Drop the callback approach
> > v6:  Make walk-data struct pgtable specific and rename
> >      io_pgtable_walk_data to arm_lpae_io_pgtable_walk_data
> > v7:  Re-use the pgtable walker added for arm_lpae_read_and_clear_dirty()
> > v8:  Pass pte pointer to callback so it can modify the actual pte
> > v9:  Fix selftests_running case
> > v10: Call visit cb for all nodes traversed, leave the decision about
> >      whether to care about non-leaf nodes to the callback
> > v11: Adjust logic in 3/4 [smostafa@]
> 
> I see the level initialization was not removed as it was in the diff[1], so it
> seems to me that’s redundant as the level is set anyway in the callback, and
> actually looking at that I see it’s not used or printed from the driver,
> so may it can be removed all together, anyway that’s nit that may be Will can
> fix it up while merging.
> 
> Otherwise, For the whole series
> Reviewed-by: Mostafa Saleh <smostafa@google.com>

I'm happy to drop the 'level' field if it's not used. We can add it back
if/when it's needed. Rob?

Will

