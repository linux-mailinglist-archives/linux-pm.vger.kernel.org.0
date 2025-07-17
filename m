Return-Path: <linux-pm+bounces-30969-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC1DB083CB
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 06:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFBE13A8BA0
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 04:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1311F9EC0;
	Thu, 17 Jul 2025 04:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="enOTDJXh"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A95318C31;
	Thu, 17 Jul 2025 04:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752726679; cv=none; b=CrHaEw/0g+JWXcZH+cS1lbOFzdqWd1YifuY0YWTDghNB30e98LJSbugtnw6om0YgX4H7f4Ehv5NBFPJ9VKY8zfg6W0JkD/tPqd2ngDOam2gLmfHxwEJBZ24ZkV/uGnYeRvAU9QvXbiSbzNaIOO20ET8/bJvzIK8uHoXix+QKDFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752726679; c=relaxed/simple;
	bh=x3k38YgM7pT0R+UbD5jaz5YqCqk54/Ulve4u9NBd+Pk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GJKIwUo+H35oNBMR27c/M8vRIqYyIzufQmuPgPRNkpBSk5mjXH5IcMx3Skrq1vT08EkttshYXM1Z9P5T50YSujDlE3n9zs3dwqajjMJdb6s22nqlEPe7hALHcVyGRmuIczojWeXoKB2fiO8Jf1u5/pngubCWTvIHH2QeeozHC+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=enOTDJXh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6FCDC4CEE3;
	Thu, 17 Jul 2025 04:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752726678;
	bh=x3k38YgM7pT0R+UbD5jaz5YqCqk54/Ulve4u9NBd+Pk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=enOTDJXhI0p2+BgVz7sGN+ipLqHVKXox/clCzv3nCga8X79fuU0izlkdHUyFv//TT
	 P9jL1ijF6+nK7rQi7m2D50n/TiElRvLOPxnHgzGP01T5fuwo85ArM84kY7YFUf+Aen
	 intA4GMXLZI6gHL7FTFvvhh1VSiMf/7uaRAlW5mG2BsCVjOiOSq2fEiZuQyzBVVR5q
	 As2JItT2oR691EnIWGirRvhR1NXPFh0yWLX8PyTenrc4bE/oanX5HA1iD4DcG1RVqL
	 SShiBHPZCoFoawtvB9h70n2T8JMHHGFKLIX1328s1ks1Cb/Kz+P0WWQWTR4SUM4bnV
	 w+PfUP+4s9EgQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Sean Paul <sean@poorly.run>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Aleksandrs Vinarskis <alex.vinarskis@gmail.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v4 0/4] Support for Adreno X1-45 GPU
Date: Wed, 16 Jul 2025 23:30:52 -0500
Message-ID: <175272667115.130869.4357209750133500599.b4-ty@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623-x1p-adreno-v4-0-d2575c839cbb@oss.qualcomm.com>
References: <20250623-x1p-adreno-v4-0-d2575c839cbb@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 23 Jun 2025 19:42:05 +0530, Akhil P Oommen wrote:
> Add support for X1-45 GPU found in X1P41200 chipset (8 cpu core
> version). X1-45 is a smaller version of X1-85 with lower core count and
> smaller memories. From UMD perspective, this is similar to "FD735"
> present in Mesa.
> 
> Tested Glmark & Vkmark on Debian Gnome desktop.
> 
> [...]

Applied, thanks!

[4/4] arm64: dts: qcom: Add GPU support to X1P42100 SoC
      commit: 2c66665d8defe1c36bdd2848b245dc906d4f3ab4

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

