Return-Path: <linux-pm+bounces-24480-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E7AA6E472
	for <lists+linux-pm@lfdr.de>; Mon, 24 Mar 2025 21:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA0E53B046B
	for <lists+linux-pm@lfdr.de>; Mon, 24 Mar 2025 20:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821C91DB13E;
	Mon, 24 Mar 2025 20:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DStJ6ymg"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCE21D86E8;
	Mon, 24 Mar 2025 20:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742848207; cv=none; b=l12GfGgd+Fiur6w4aSStfhOGvZnUVfI0xasXfKVsDz/ve/ba+1vJPj3gXnT539zxnORPIlIulO2k24j9sSeixiOIpKlw/4Sj576i+cjvvY3+kd/Ghn9zTdnNUn/naqdlCbfclgqaAGdEJ7G5m/A/O5Zsbjlsc76FQADIBB5dSNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742848207; c=relaxed/simple;
	bh=s4xMzRu0WiyyVnttHYG7UiBAlNMQhlSBsq1IAukCPq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QCg3HSJEOQ48kpfP9jKoptquDunSGc3u+X5Foaq8C2mcuDDWZIGCoT3vZCSm6rlzraz83HjhL8KtYYAPQxO5i1ktI6u6+jyUFTYc6i6KaDejSXU83xYQV/7VC6WckViybeg9jpGOvxq7u8mPxxJl85PnkGWCuaxK7gQihcFgceY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DStJ6ymg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A90C4CEDD;
	Mon, 24 Mar 2025 20:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742848204;
	bh=s4xMzRu0WiyyVnttHYG7UiBAlNMQhlSBsq1IAukCPq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DStJ6ymgnRoTs2Wgvg5rPjCy0ComvY7VMkUc5tJWROEX5ACBzW0X+W0ieeznT3liF
	 DSLtCu4cdj01QXU5LrE8uTEi/CgPG/1EsvdWoBPyJell8zGHhIOhrEVf5lY7Fi4JZE
	 GeHdcQHZpCMi6K3fvVDiMeF2ZrY3idsKwDrMAVYZIJC7jTGL4fyQ6DYsARGtTPaqqO
	 494ZNR5UNMuIT29kJSebGL02EEfTUKsuAJJZIFlPCDkQ1V3ix2IY1NZrk7DFHMRE/L
	 3ajmfGbLI3SxHERK4RATM7OD3K5TA0kehg/Riv9JKdQmb0q1fxa32ZflTinIIt+3Kh
	 OhlU9tH5xviig==
Date: Mon, 24 Mar 2025 15:30:03 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Brian Masney <masneyb@onstation.org>,
	Odelu Kukatla <quic_okukatla@quicinc.com>,
	Rohit Agarwal <quic_rohiagar@quicinc.com>,
	Georgi Djakov <djakov@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Barnabas Czeman <barnabas.czeman@mainlining.org>,
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	Konrad Dybcio <konradybcio@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: interconnect: Correct indentation and style
 in DTS example
Message-ID: <174284820333.817795.6420015432546061746.robh@kernel.org>
References: <20250324125302.82167-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324125302.82167-1-krzysztof.kozlowski@linaro.org>


On Mon, 24 Mar 2025 13:53:02 +0100, Krzysztof Kozlowski wrote:
> DTS example in the bindings should be indented with 2- or 4-spaces and
> aligned with opening '- |', so correct any differences like 3-spaces or
> mixtures 2- and 4-spaces in one binding.  While re-indenting, drop
> unused labels.
> 
> No functional changes here, but saves some comments during reviews of
> new patches built on existing code.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/interconnect/qcom,msm8939.yaml   |  8 +++---
>  .../bindings/interconnect/qcom,msm8953.yaml   | 20 ++++++-------
>  .../bindings/interconnect/qcom,msm8974.yaml   | 18 ++++++------
>  .../bindings/interconnect/qcom,rpm.yaml       | 12 ++++----
>  .../bindings/interconnect/qcom,rpmh.yaml      | 28 +++++++++----------
>  .../interconnect/qcom,sdx75-rpmh.yaml         | 16 +++++------
>  6 files changed, 51 insertions(+), 51 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


