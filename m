Return-Path: <linux-pm+bounces-31109-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF54AB0B360
	for <lists+linux-pm@lfdr.de>; Sun, 20 Jul 2025 05:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AB293B8FB0
	for <lists+linux-pm@lfdr.de>; Sun, 20 Jul 2025 03:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E61191F92;
	Sun, 20 Jul 2025 03:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRDc55/N"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450A117BA5;
	Sun, 20 Jul 2025 03:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752982741; cv=none; b=kEATSz5O7y4Yna7F1uv+G6Kj5z27Z6lxUlzQv24BK7csUVwok1rfaoj8aoNc0P5QQQLJ/4g3s2isO3urDoDal4MPbS8r7G7OnMvMHBf2dmoReanWIseWW69Zyq/eX6RzwpvwsahpnI+D2oNsd6JG7EtiuB/raL/f2CeDREKRI/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752982741; c=relaxed/simple;
	bh=YDDYMG/ezn0uH3sxHtd5aXYJhAf6c1+tQeVupNNhiaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=thpHvS7iQIbuoa1qVRNdOI2C2YBv7iTmNy/3xdQwR71Inv/VGnrvjGBsKOVSA8jULAPmDEwDYAQyuNcamintyXDb6A35iJ/3fsJAhQu4Ckc2cJQYGW3bp+cjbwVqvLU6AEfvpbAtDBnb/x0k95ufhZ/y6ZksYAtbzN6C9i6LvHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aRDc55/N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61071C4CEF4;
	Sun, 20 Jul 2025 03:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752982741;
	bh=YDDYMG/ezn0uH3sxHtd5aXYJhAf6c1+tQeVupNNhiaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aRDc55/NHXUPhYf73To8ul2POOuQv0nTYea1pSDoxowSkJBC6PFsQ5QJgbNHGMtHK
	 sCfhEQ3jrvIgETtVoc1QxQ0biFhbAYdl10Ys5/oWD2mJAH2trjNl9VmY5a/34VwMvl
	 kZyA3zXyqauvfQMG5uaHgF9LhNZh9e9UojAXGdssPYDBOqKiSY70L90nhH25YkiS0C
	 3QZtZay7ntJk5ZOpRU1cd3nQ0lSFxn/hpgvX+tbQQKPmWn7Xm3BQ/geoOBZuB0RRKO
	 ORFK48rO36MIQTE0lqZREJ3TuOHtEUoNBn7zqk459wGa/DIJnR9UGB7LMezP2z311o
	 XVITnnL44aCZg==
Date: Sat, 19 Jul 2025 22:38:58 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/8] pmdomain: qcom: sort out RPMh and RPM power domain
 indices
Message-ID: <4bdxuzk7gyzww2kckotihch6ljyiofs5gm6ntnpjst3crm462j@z6svwllfcqwk>
References: <20250718-rework-rpmhpd-rpmpd-v1-0-eedca108e540@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718-rework-rpmhpd-rpmpd-v1-0-eedca108e540@oss.qualcomm.com>

On Fri, Jul 18, 2025 at 07:13:38PM +0300, Dmitry Baryshkov wrote:
> - Separate RPMh power domain bindings from RPM PD bindings
> 
> - Drop now-unused (after [1] is merged) binding indices for RPMh
>   platforms
> 
> - Introduce generic bindings for RPM power domains controller
> 
> Two last patches (marked as [DO NOT MERGE]) should only be merged after
> corresponding DT cleanup lands ([1] and DTS parts of this patchset).
> 

Ulf, please feel free to pick the DT changes through your tree so we
don't need to wait a whole cycle.

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> [1] https://lore.kernel.org/r/20250717-fix-rpmhpd-abi-v1-0-4c82e25e3280@oss.qualcomm.com
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
> Dmitry Baryshkov (8):
>       dt-bindings: power: qcom-rpmpd: split RPMh domains definitions
>       dt-bindings: power: qcom-rpmpd: sort out entries
>       dt-bindings: power: qcom-rpmpd: add generic bindings for RPM power domains
>       pmdomain: qcom: rpmpd: switch to RPMPD_* indices
>       arm64: dts: qcom: dts: switch to RPMPD_* indices
>       ARM: dts: qcom: dts: switch to RPMPD_* indices
>       [DO NOT MERGE] dt-bindings: power: qcom-rpmpd: drop compatibility defines
>       [DO NOT MERGE] dt-bindings: power: qcom,rpmhpd: drop duplicate defines
> 
>  arch/arm/boot/dts/qcom/qcom-msm8226.dtsi |   4 +-
>  arch/arm64/boot/dts/qcom/msm8916.dtsi    |   8 +-
>  arch/arm64/boot/dts/qcom/msm8917.dtsi    |  10 +-
>  arch/arm64/boot/dts/qcom/msm8976.dtsi    |   4 +-
>  arch/arm64/boot/dts/qcom/msm8998.dtsi    |  16 +-
>  arch/arm64/boot/dts/qcom/sdm630.dtsi     |  16 +-
>  arch/arm64/boot/dts/qcom/sm6125.dtsi     |  12 +-
>  drivers/pmdomain/qcom/rpmpd.c            | 112 ++++-----
>  include/dt-bindings/power/qcom,rpmhpd.h  | 175 +++++++++++++++
>  include/dt-bindings/power/qcom-rpmpd.h   | 375 ++++---------------------------
>  10 files changed, 306 insertions(+), 426 deletions(-)
> ---
> base-commit: d086c886ceb9f59dea6c3a9dae7eb89e780a20c9
> change-id: 20250717-rework-rpmhpd-rpmpd-13352a10cbd5
> 
> Best regards,
> -- 
> With best wishes
> Dmitry
> 

