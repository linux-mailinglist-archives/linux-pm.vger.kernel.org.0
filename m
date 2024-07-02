Return-Path: <linux-pm+bounces-10374-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9CB924777
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 20:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04535288B40
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 18:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105D11CF3D4;
	Tue,  2 Jul 2024 18:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBwEVRlt"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30251CB33B;
	Tue,  2 Jul 2024 18:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719945867; cv=none; b=p0iFvPZR/kKUZuXdToSd+zUpyxZ//8gpv26VfDUl2aCgryd5o4ZkhbsIA8uU5ep2yGNuSYgqMY/0vwMZHAy6ArELWwTBCTYkQuNWOCNzN2FYolpAn9wCS13ip+Qb77ux27OVORteQjjRax7GAn2374PVh7ls3T7VSzOt8UYKQ/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719945867; c=relaxed/simple;
	bh=I9jO68ZVM9wSlgrc22LMWdinqScq0qmhe88qYrJnnMk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=el1H65+BRYSX3wd2Fz+5KXEKqhg6Ya7cmaWIAzqPBlxghfPVvHp0ca+KEXqt1nYd0bbgFP1WBoa4SR72URVkZLbB2e1EtJVUl2A4io8PYyjjtQA+ySMd2QACLyLj8OoJnbo/L7DtzaUwzmW6FnBVpDWiMQ5tH2dNvF6eRko20d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBwEVRlt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9EE4C4AF0E;
	Tue,  2 Jul 2024 18:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719945866;
	bh=I9jO68ZVM9wSlgrc22LMWdinqScq0qmhe88qYrJnnMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oBwEVRltsFzmkROvJ8fsmi1OBmWnQIMaYRyHFOFpj05+tNKKlkcHdSz8tWc5EW9Ne
	 iuxb5eGTafWtttWsO6his3LxMz10vQWovyxtSgF8uZDhjIahuIKCh9+IQxsmTq0xIZ
	 L1kwIsqZe5baZuMqtxR/60jCdTaQQ8aIWNqDliPpjN5Gnv4xccL4YVKgVd5yEbUS2Z
	 W5RjHY8waJQ3cTxF6JefXfSumfZtnbh/nUP74WVt6WXPgQtVevToXlBSeCgD0b+IGp
	 XOyBzKPQ1brjuQ9oA3kJQMYSiZMwE89uIX2Dsicbj90Updj1HRhXq5Huhb4Dxl1OJ3
	 HFniXrEsOHK5g==
From: Will Deacon <will@kernel.org>
To: iommu@lists.linux.dev,
	Rob Clark <robdclark@gmail.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	Stephen Boyd <swboyd@chromium.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Pranjal Shrivastava <praan@google.com>,
	Rob Clark <robdclark@chromium.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Georgi Djakov <quic_c_gdjako@quicinc.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	Joerg Roedel <jroedel@suse.de>,
	Krishna Reddy <vdumpa@nvidia.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 0/3] iommu/arm-smmu: Prettyify context fault messages
Date: Tue,  2 Jul 2024 19:44:02 +0100
Message-Id: <171993972260.1969375.14801779454631746160.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240701162025.375134-1-robdclark@gmail.com>
References: <20240701162025.375134-1-robdclark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 01 Jul 2024 09:20:09 -0700, Rob Clark wrote:
> v3: Split out the reg bitfield renaming, rework
>     print_context_fault_info() helper
> 
> Rob Clark (3):
>   iommu/arm-smmu: Add CB prefix to register bitfields
>   iommu/arm-smmu-qcom-debug: Do not print for handled faults
>   iommu/arm-smmu: Pretty-print context fault related regs
> 
> [...]

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/3] iommu/arm-smmu: Add CB prefix to register bitfields
      https://git.kernel.org/will/c/d0166022be37
[2/3] iommu/arm-smmu-qcom-debug: Do not print for handled faults
      https://git.kernel.org/will/c/55089781ff77
[3/3] iommu/arm-smmu: Pretty-print context fault related regs
      https://git.kernel.org/will/c/d525b0af0c3b

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

