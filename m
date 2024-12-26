Return-Path: <linux-pm+bounces-19769-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AD39FCCDE
	for <lists+linux-pm@lfdr.de>; Thu, 26 Dec 2024 19:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6010162EC3
	for <lists+linux-pm@lfdr.de>; Thu, 26 Dec 2024 18:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBD71DE2DE;
	Thu, 26 Dec 2024 18:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RgJyNW5x"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9821DE2D2;
	Thu, 26 Dec 2024 18:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735237657; cv=none; b=rqo9rbxjZ83e09AMEvDyn33ftGrwxCF4BPBcjCmOATXncwb6uPMnPj8YEXfvKSZGIyfG24rJMswM7Lq8HDzyPKP0Q09eILeY4rGmYsXNEWDPPQw3H7VyiQXqFd9rc/l4CSfm/M0uvt30UbzDh1GU3tkpX8pTDx/jhAivkJSKnEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735237657; c=relaxed/simple;
	bh=LqJfTVM8Jy9jpRjtSYRK8io97NPjHvFL3uXlihazCzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XnEnyRkmHrDC2uTjeq/kAPt0FWGcxIhipG4XVz8xfvV50iTCXBInidj94oshqfe6vxQc1LssNF5gVXoZS2ADyOIdoZwX1SXAWfB3vXcUlVjGEHyu/s1yb2tniodVk7uwunSWGcmWqUGEqTSVkQW94k2FSyKid6w5DcbQv4K0HqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RgJyNW5x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EAE3C4CEDF;
	Thu, 26 Dec 2024 18:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735237657;
	bh=LqJfTVM8Jy9jpRjtSYRK8io97NPjHvFL3uXlihazCzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RgJyNW5xYDI4CosSFfFADVYnNUSXFoN3JBqHRCVKfAe+GQvLOn4WSE3h1wNDH0ll9
	 G/F+4aQi1FVAuGegMxNRkF1v1WdcNv3LTHH/Gx6Nu72I+oP9upbpYzlJJIRl6ltlde
	 89D4k7H1vJSfbuoeUsQlSpBQRt/6+wl06iF4wlw33w7NOHBxPTBsF8i6vmw/WRMAyK
	 bqmtgy+b+zCoLJHRnTvfMkSM44KluFDT+1TcbwN7rgb1UB0vOIamtz6ojQzz3GaDkt
	 WMTswX20sZ/U600gfYgk7p1Hlap5CGn2W8xxI3BvMlpwPYMRE0q7P4dufHPFUVoE6N
	 QDdMhWL0Pl0rg==
From: Bjorn Andersson <andersson@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Georgi Djakov <djakov@kernel.org>,
	Lijuan Gao <quic_lijuang@quicinc.com>
Cc: kernel@quicinc.com,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 0/2] arm64: qcom: Add BWMON support for QCS615
Date: Thu, 26 Dec 2024 12:26:55 -0600
Message-ID: <173523761379.1412574.4630232060526083229.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218-add_bwmon_support_for_qcs615-v1-0-680d798a19e5@quicinc.com>
References: <20241218-add_bwmon_support_for_qcs615-v1-0-680d798a19e5@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 18 Dec 2024 18:39:37 +0800, Lijuan Gao wrote:
> Document and add CPU and LLCC BWMON nodes and their corresponding OPP
> tables for QCS615 SoC.
> 
> The patch has undergone the following verifications:
> - Successfully passed dt_binding_check with DT_CHECKER_FLAGS=-m for binding
>   file
> - Successfully passed dtbs_check with W=1 for dts
> - Verified each item in the CPU and LLCC OPP tables, and the BCM threshold
>   and clock values meet expectations.
> 
> [...]

Applied, thanks!

[2/2] arm64: dts: qcom: qcs615: Add CPU and LLCC BWMON support
      commit: 89fc83a9472812052610970b41fd44de94224b32

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

