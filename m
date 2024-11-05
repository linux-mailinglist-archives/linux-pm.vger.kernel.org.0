Return-Path: <linux-pm+bounces-17015-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB929BC838
	for <lists+linux-pm@lfdr.de>; Tue,  5 Nov 2024 09:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 218D51F24941
	for <lists+linux-pm@lfdr.de>; Tue,  5 Nov 2024 08:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860221CEAAA;
	Tue,  5 Nov 2024 08:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDkhomjQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F001188587;
	Tue,  5 Nov 2024 08:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730796203; cv=none; b=QGouR8/MGQH6XEeZff/zy0trZLguTBAYOuf0QF9Dl6/0AQRK5xxoL9xypzFaRypJEy3D9paTJFmZOjmfdGyc3sjOkEGxLMe8x2jpS5bF3g74Y0QHMn0Q+JuaRFr7hGX+ZiCsfCOD1pvpHni07yA2FP0QqiStEmjbIKelqt6AevE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730796203; c=relaxed/simple;
	bh=gyfZE/1KNcSq7DWlF+mJasS+2BK+x9eS4IU5T7OAb/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCHp3rgPAUZwb5E6KF0y91RoaCjlRF1U5hXWh9G8VaRCICCKjLefqWwUz7vdqlxQzF7/dDyOaT6T0mPasF/Rwc0hXe10MISK+9EymNH2JKZwIBBB5zkTWToGcIENiCoC3OaT0kiGC+SPNgMuZu9QFc7Ijwv3DB5aicGQ3bIPDYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDkhomjQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AD61C4CED0;
	Tue,  5 Nov 2024 08:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730796202;
	bh=gyfZE/1KNcSq7DWlF+mJasS+2BK+x9eS4IU5T7OAb/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nDkhomjQ7IqI+H3IzfCax9QW2cDgkGqDIsxbVX1+Na3laqDxk3xPu0gMTH080X7tJ
	 NeTRUD0IlW9P8m8MGmAb71qJ0r1J90ym0vK/ws+8ZMu55O6Pj4OECRDPL/zuAJi5a7
	 xNpEC9G3RdYC5xh0/TTqDicURHj+RW+ZmjdY3tPwKELxxrHIBGl+Ji1Z17CUyJBWtD
	 K4s8XsYH63sWpiNo+CJ6m5mPDoZYLLekQj04JDuCNVWZrl9tidbempRL0+FyfRXC/3
	 g/8cSnAW4Y7e5Py/kqRNFyd7LZOuaFNUllg4Ee0RxhtlKLrttjV/COOjqN+IVmHwns
	 KUDnO7lBdCQRg==
Date: Tue, 5 Nov 2024 09:43:19 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
Cc: srinivas.kandagatla@linaro.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org, 
	daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com, andersson@kernel.org, 
	konradybcio@kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, quic_srichara@quicinc.com, 
	quic_varada@quicinc.com
Subject: Re: [PATCH v6 2/7] dt-bindings: nvmem: Add compatible for IPQ5424
Message-ID: <lvl6fcivxivil52d5epwtgip3hwz6tbhl3venitndbolx6urbg@hogoiuvlj7ec>
References: <20241104124413.2012794-1-quic_mmanikan@quicinc.com>
 <20241104124413.2012794-3-quic_mmanikan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241104124413.2012794-3-quic_mmanikan@quicinc.com>

On Mon, Nov 04, 2024 at 06:14:08PM +0530, Manikanta Mylavarapu wrote:
> Document the QFPROM block found on IPQ5424
> 
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> ---
>  Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


