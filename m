Return-Path: <linux-pm+bounces-16380-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 027149AE52B
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 14:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD4D11F22D7E
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 12:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C349E1D9668;
	Thu, 24 Oct 2024 12:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pGyz5NUC"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F5E1D2207;
	Thu, 24 Oct 2024 12:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729773611; cv=none; b=LxddlS+PEhxUZYcrvitRpTaskxCCjBicwtNRQg8/4DfDuYPt8oIi+JY50+e+JZvrU/tap2+dmQ05aGI7EcKkDp1+9y3RJNpOEliARQIfUgScG06ZNNcTBxJjTxU8J8bmvsMbWNTV+v9v+Nh7nY9qQdVLFvPsjcNn02dK0yqpzXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729773611; c=relaxed/simple;
	bh=YrCb/mhgDJB269wiz1IB8jtnqMuRua4t7v/e15WwlH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=II6SbCpNZBhmajhaxFphwDNIsNz6SHVhjNyUcnypbi0lAGfxU/OfGEb4DtulR8MsOxi7fuzb0ejyQ49kxN+0yr4t1BEj30xOuwjNNAXGdH/NXvCuaFyXyAJG1cVL+nh1eyoxXVR/2u7iyRf7Dy/3WbPEXBS0PZCuCzZgwS+2EQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pGyz5NUC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F49C4CEC7;
	Thu, 24 Oct 2024 12:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729773611;
	bh=YrCb/mhgDJB269wiz1IB8jtnqMuRua4t7v/e15WwlH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pGyz5NUCk+nC2ylIRx+oMRdFs05jcNmisi1bPlD+0Jwst/J0y5lzPH31hVS+SXI5w
	 99k2CbFOevUjQZS2aI/8M9SEEN0s/RJT//p+s3n7lF/ZSP1Y/hT7B+z8oVuU4ttv+b
	 UXLc8vH0Jh/Fx1hhzbh07HqZ/iFT88szxfKmskAIrDs7fyRfexSNIh1UpAGE6/BggY
	 vq1NObvzg2/DBoRrobabsur48c4hPysH900VGjFoqwjuLvzDSvfe1srsJJQ1sgCq4q
	 zBnZbpwalO8dD/8H0n/gYSCffTy/xbGtwpuIqVd43vwDD9PNwv3kmCd5/B6LxFtdwG
	 u/4omlQXX9cWA==
Date: Thu, 24 Oct 2024 13:40:04 +0100
From: Will Deacon <will@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: =?iso-8859-1?B?QmFybmFi4XMgQ3rpbeFu?= <barnabas.czeman@mainlining.org>,
	iommu@lists.linux.dev, Zhang Rui <rui.zhang@intel.com>,
	Lee Jones <lee@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-gpio@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	linux-arm-msm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, linux-pm@vger.kernel.org,
	Amit Kucheria <amitk@kernel.org>
Subject: Re: [PATCH RFC 10/14] dt-bindings: iommu: qcom,iommu: Add MSM8917
 IOMMU to SMMUv1 compatibles
Message-ID: <20241024124002.GC30704@willie-the-truck>
References: <20241019-msm8917-v1-0-f1f3ca1d88e5@mainlining.org>
 <20241019-msm8917-v1-10-f1f3ca1d88e5@mainlining.org>
 <172934406753.3231809.282041778335117501.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <172934406753.3231809.282041778335117501.robh@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sat, Oct 19, 2024 at 08:21:16AM -0500, Rob Herring (Arm) wrote:
> 
> On Sat, 19 Oct 2024 13:50:47 +0200, Barnabás Czémán wrote:
> > Add MSM8917 compatible string with "qcom,msm-iommu-v1" as fallback
> > for the MSM8917 IOMMU which is compatible with Qualcomm's secure
> > fw "SMMU v1" implementation.
> > 
> > Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> > ---
> >  Documentation/devicetree/bindings/iommu/qcom,iommu.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> 
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241019-msm8917-v1-10-f1f3ca1d88e5@mainlining.org

I don't see any errors in the logs...

Will

