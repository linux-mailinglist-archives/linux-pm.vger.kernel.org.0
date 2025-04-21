Return-Path: <linux-pm+bounces-25816-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0738A95627
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 20:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0B647A6E2C
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 18:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D941E5B99;
	Mon, 21 Apr 2025 18:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpuxiXiO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55580DDAB;
	Mon, 21 Apr 2025 18:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745261398; cv=none; b=fn1w/cdPjbgVP8lomRnKBNPdunrkni8HulJmDNlpYCR9TOPSkDlmaum0x+hClimNKvp06QnFGZxoDl6YQ6EgrQ8GuivVRC2Db3xkwLhB1KhZJ65edms/+Lgqw7rSHxTrCv/Hh1t/WWBvbhioRzb8pt6eA824fDIgCr7kMyv1ZOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745261398; c=relaxed/simple;
	bh=lDbftSNIEikgRhntgpA6Z4L2uXGo5/b2EApsGIWA/8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gBdQ/F7+3oM2wo5HCC0vkpi6NP9615rJTyR7oDkMQyv6+1w6/a/54jcFDHkqdt8JqBWOttdVTq6Ivfkw2gzdrJps5MCOCmaJgWIyWU8cXFwbMYGJD4FlLBFDyLeA3bMsu0Ix/06REsCK06uNJpt7HmV+H0a5QQrj8Cs2/JbTvTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WpuxiXiO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DED2C4CEE4;
	Mon, 21 Apr 2025 18:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745261396;
	bh=lDbftSNIEikgRhntgpA6Z4L2uXGo5/b2EApsGIWA/8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WpuxiXiOyhaxU8OB68p5G21YEFTX1lbQF+2MUlJMDdpxVDIGw6mHogL+/UTZU7zC+
	 QyBh+RQP3WwCE0DXAoiCCtscNjSWAygCiP+V7Qvu7BZIUlRTw8osQ1iFpGFULWJ/Ok
	 vOM+6BEMRVv1wQNDYo1T2zXGi6bsOWATx5iEt7JpjA2D+CbME5aK6bMRudyvRUwDuj
	 hMMa+TOpSPLaJhqzzmpHBIL7IGruKHFaBgHGD1b8QJVeClraZw9BAt4NaxyZr0HAiv
	 y7lbfIEilr9qarI2WeriEF/ERU+DkqENj7wPpDmuJukyNmTVwJdcbn2n0xQdTVL99v
	 2y8yO5j7npbyA==
Date: Mon, 21 Apr 2025 13:49:55 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Georgi Djakov <djakov@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: sm8650: document the
 MASTER_APSS_NOC
Message-ID: <174526139452.2609990.4054781869897634300.robh@kernel.org>
References: <20250415-topic-sm8650-upstream-icc-apss-noc-v1-0-9e6bea3943d8@linaro.org>
 <20250415-topic-sm8650-upstream-icc-apss-noc-v1-1-9e6bea3943d8@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415-topic-sm8650-upstream-icc-apss-noc-v1-1-9e6bea3943d8@linaro.org>


On Tue, 15 Apr 2025 16:03:47 +0200, Neil Armstrong wrote:
> Document the MASTER_APSS_NOC interconnect node for the SM8650
> SoC system NoC.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  include/dt-bindings/interconnect/qcom,sm8650-rpmh.h | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


