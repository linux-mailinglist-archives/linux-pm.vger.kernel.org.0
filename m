Return-Path: <linux-pm+bounces-10940-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D28A092D5C0
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2024 18:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7600DB2505F
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2024 16:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7EC194AEB;
	Wed, 10 Jul 2024 16:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NP/PYYX7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B2B194AC4;
	Wed, 10 Jul 2024 16:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720627725; cv=none; b=ZYP3McViXO0XLlv6Q3biMRkdyT68rR2DdV3F1j/XmTc4UwF/wbsFuVXc0OFnf1EXPWrqEcKhpJgKPF1gR7G6MMnxli5kLtqA2EqX5PeMRAbr2bWtztN0ieKiMiq63UbqcZ8cm0G+VEdWGiV3Yzg96H9LyZrDD13Zb6mpLs23uBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720627725; c=relaxed/simple;
	bh=Slb/lgr8C6eVl3N9fbK03RUMCv8Lbr55/6hSROwKJRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rxfWZ6QaRrpQ3D2GUUzV7+SjkhvqFUHW8pEt7Y1rUg/hJxOdL1TDfkaqpml+XiIxGI5gxWyhDT4vw8d40RgwkhzTFpPkxwk0S3+cX0omesA/BhtCMDxSyPV5Des4sqJ7l/h5laZDR7HelE7d69GNUk5RKJXTDwNKijjWfb5BPOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NP/PYYX7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE1CC32781;
	Wed, 10 Jul 2024 16:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720627724;
	bh=Slb/lgr8C6eVl3N9fbK03RUMCv8Lbr55/6hSROwKJRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NP/PYYX7fsCll8Zx6GTprJEyqYgz0l9RyGPiowVNRqNbW1YG9D2i3JG3QSY15p1N/
	 /S4BjphjdA6LXf7XUdeCJyoN6YhWTldJzwd5XJnh8v788nhfMpgt0LxqYh1DLtr+BQ
	 dCrxsxHKbat5T5FKG/BBdf3HdxswCt+/GC+yei+hFMAsroVkPv2O94edwdpLUws51N
	 3siJrx6P8iV+pdkY9nCKMvHR/YMEULFpgKMz9wE5N9B18/dz5cEfAP3po3NQkMx6hM
	 rufIyHWLgbEtHih663MwJNjkSy2fDXcA3nQjDbYJc2Rs+Pj4itaaOKmXsmLDZMiI+T
	 pDXcOT7L5iZoA==
Date: Wed, 10 Jul 2024 10:08:43 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Adam Skladowski <a39.skl@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Rohit Agarwal <quic_rohiagar@quicinc.com>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	Vladimir Lypak <vladimir.lypak@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Georgi Djakov <djakov@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	~postmarketos/upstreaming@lists.sr.ht,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Barnabas Czeman <barnabas.czeman@mainlining.org>,
	phone-devel@vger.kernel.org, Sibi Sankar <quic_sibis@quicinc.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Danila Tikhonov <danila@jiaxyga.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 7/9] dt-bindings: interconnect: qcom: msm8939: Fix
 example
Message-ID: <172062768089.3154425.11877424132610061384.robh@kernel.org>
References: <20240709102728.15349-1-a39.skl@gmail.com>
 <20240709102728.15349-8-a39.skl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709102728.15349-8-a39.skl@gmail.com>


On Tue, 09 Jul 2024 12:22:52 +0200, Adam Skladowski wrote:
> For now example list snoc_mm as children of bimc which is obviously
> not valid, drop bimc and move snoc_mm into snoc.
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> ---
>  .../devicetree/bindings/interconnect/qcom,msm8939.yaml      | 6 ------
>  1 file changed, 6 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


