Return-Path: <linux-pm+bounces-10939-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEB592D58E
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2024 17:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D01EB2239A
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2024 15:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6063F194126;
	Wed, 10 Jul 2024 15:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gv5l1UQh"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E35E36AF8;
	Wed, 10 Jul 2024 15:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720627125; cv=none; b=nWQSNFLJhy0hbX4D72NX4hqza662WTdHKSxqFM+gCo941043qwG6SMTfQMwAHD/h5Ub2zuJWTiE+yTUOZF21rKbzE4+EEIFJAPkImukrAB2RWji/ShBrOuGPv3yoWkbXgsorl2n5QT3FOjGQ6vXk3W0k/i3TzPHhoyyRyVdYh1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720627125; c=relaxed/simple;
	bh=MCgividKkiPAMtIGWLi6Kuoy89U947IJlao0MkKnRrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PV+OK9Z169bHLhgsAv/cdVWaxu8RNBQ1I/R53SztSJ64/8xCMEBcqqB+maeCPhw+84DafG7cXecmEFCDp22SauYXI201110zMQJq0GiffMhzdPWpMBReupMKH98EZVtn7CnU+10hCzVu/PTOv/aZMtmyktJcueJ6u/lz2FZyS44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gv5l1UQh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73F0DC32781;
	Wed, 10 Jul 2024 15:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720627124;
	bh=MCgividKkiPAMtIGWLi6Kuoy89U947IJlao0MkKnRrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gv5l1UQhF3p2APCSBvQtCiego4MMJli+JyAxoSAKaP6OVfSwJ39s74YyY1bmMeEkN
	 b0RTll4AlZVFj+xld2AdU+kwFQDjCxB2MNpLqtSoesQK1h+35gOfLNHvHQFi9rSHm1
	 H1BhCA9O5RubEs2/OCAebe+IYOf5ZkBREWQ/AqvX6xEEgtTbgbIeKPFc+2ojMUNWVH
	 pVcI8lnGbg/12z0RoNvy6JHFZHv+R0apzfyzXW6pnBZ+IzQFUatQMmEp91VhoRylnM
	 zJ9ovgx2V1mGHoHNWbzBmM34IS2Nj6GKnkhmCpJjrQAWGquLjaj0ABo75B/Krtf0ln
	 xoJ5/8KPIklXQ==
Date: Wed, 10 Jul 2024 09:58:43 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Adam Skladowski <a39.skl@gmail.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>, linux-pm@vger.kernel.org,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	phone-devel@vger.kernel.org,
	Barnabas Czeman <barnabas.czeman@mainlining.org>,
	Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	~postmarketos/upstreaming@lists.sr.ht,
	Vladimir Lypak <vladimir.lypak@gmail.com>,
	linux-arm-msm@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Georgi Djakov <djakov@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Rohit Agarwal <quic_rohiagar@quicinc.com>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Danila Tikhonov <danila@jiaxyga.com>
Subject: Re: [PATCH v3 3/9] dt-bindings: interconnect: qcom: Add Qualcomm
 MSM8937 NoC
Message-ID: <172062711360.3138994.15245504529891229995.robh@kernel.org>
References: <20240709102728.15349-1-a39.skl@gmail.com>
 <20240709102728.15349-4-a39.skl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709102728.15349-4-a39.skl@gmail.com>


On Tue, 09 Jul 2024 12:22:48 +0200, Adam Skladowski wrote:
> Add bindings for Qualcomm MSM8937 Network-On-Chip interconnect devices.
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> ---
>  .../bindings/interconnect/qcom,msm8939.yaml   |  8 +-
>  .../dt-bindings/interconnect/qcom,msm8937.h   | 93 +++++++++++++++++++
>  2 files changed, 99 insertions(+), 2 deletions(-)
>  create mode 100644 include/dt-bindings/interconnect/qcom,msm8937.h
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


