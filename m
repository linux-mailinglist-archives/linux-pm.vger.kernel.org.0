Return-Path: <linux-pm+bounces-826-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F4031809A1A
	for <lists+linux-pm@lfdr.de>; Fri,  8 Dec 2023 04:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E7DE1F21306
	for <lists+linux-pm@lfdr.de>; Fri,  8 Dec 2023 03:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46A6210F;
	Fri,  8 Dec 2023 03:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oB/Kt1MU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702BF3C3F;
	Fri,  8 Dec 2023 03:14:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEF22C433C7;
	Fri,  8 Dec 2023 03:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702005272;
	bh=i6QahoY2i38BfqMi3CMYz8694XkKFslWp28QY+7R8so=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oB/Kt1MUzpve4cuyWfLwcdPfWPjfKd1brAJqAdcmDB45PNmSarB7vHpg2mc1nFKaS
	 C/Ei/enQhoa6E1+VoLGO4tIkdDJ7U3oS+HgTwN6jNdpuMEEdwylL3aI6U8DhFqyd2u
	 Xs7nMqoUpvY+qAgCO/Si4DR9LkaqwKM0j3nBAtxSMzq/17Fg6diykAjusr/E047o7+
	 vQpbsDL+yPW7fsACxlY2ljO7IB00BlPYZDLUpSzhC2AExFHx3z/hBha7cxNH1pW4xP
	 /Biy1XyydK/9QGic6jAkKlM3nDPPfSNwJyi7Y9UUOZFoDZY1UQA/SWrEky7IHbfesb
	 Sc17wN/CHXqyw==
Date: Thu, 7 Dec 2023 19:19:08 -0800
From: Bjorn Andersson <andersson@kernel.org>
To: Georgi Djakov <djakov@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Abel Vesa <abel.vesa@linaro.org>
Subject: Re: [PATCH v2 0/2] interconnect: qcom: Introduce support for SM8650
Message-ID: <36ip3gmodvx2afl2lbdphyevzmo2nwcujnlie3njj5d36kwdeh@qzo43f5g3a52>
References: <20231123-topic-sm8650-upstream-interconnect-v2-0-7e050874f59b@linaro.org>
 <7fbe4090-94cd-4aaf-98b6-07f2a089d51a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fbe4090-94cd-4aaf-98b6-07f2a089d51a@kernel.org>

On Mon, Nov 27, 2023 at 04:08:37PM +0200, Georgi Djakov wrote:
> On 23.11.23 15:32, Neil Armstrong wrote:
> > This covers the RPMh Network-On-Chip Interconnect bindings
> > and driver for the interconnect framework.
> 
> Thanks Neil!
> 
> > As reported for earlier Interconnect drivers, the IDs
> > for multi-rsc voting has been removed from this driver
> > so the proper solution can be developed without having
> > to remove entries later on.
> > 
> > To easy Bjorn into merging the DT bits, would it be possible
> > to have an immutable branch with bindings shared with Bjorn once
> > this patchset have been properly reviewed and accepted ?
> 
> Hi Bjorn,
> 
> Here is a stable branch with the DT bindings header that might be needed
> for SM8650 dts patches.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git/log/?h=icc-sm8650
> 

Very nice, thank you Georgi

Regards,
Bjorn

