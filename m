Return-Path: <linux-pm+bounces-41047-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 665EDD38E51
	for <lists+linux-pm@lfdr.de>; Sat, 17 Jan 2026 12:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 15E9F302081A
	for <lists+linux-pm@lfdr.de>; Sat, 17 Jan 2026 11:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1256B2C11DB;
	Sat, 17 Jan 2026 11:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UphNA9ij"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E096D72622;
	Sat, 17 Jan 2026 11:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768650416; cv=none; b=CGvPWYDBOSGOxYqi4DxSmm5IHN2n0AYeXO7Is4DXe9UCJeZShJHT7PrYXwH/5MrKTdvEQ86dqJYbAbMzXJHilUUMaH2a0Kh/U0Cb+jRSf9dqrO8h0a+AuVMJjCMNhmdIUTQBUwmh4DbNet9+vtu0iUu+2Q4gA8p43xHpdVwynME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768650416; c=relaxed/simple;
	bh=0BDMRZjZ+cF68tCc8y83Q2hV4mWRimaps4LDJoli4OA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IC9rdmHwREcDxI8Ozvn5W81irUrzejFHIPh7WVYmUP/EZdgccc9+W1GT8uO27yOyJzvNCGOe0zzt0NQROet8FOpuLjaPRZE5IbQ+h+roudPp6jIRada/ycuSVDgOytDPRPZ88R1sss7M6CR7ucbokmykYEY3JNYAomup28hq29g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UphNA9ij; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E94B6C4CEF7;
	Sat, 17 Jan 2026 11:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768650415;
	bh=0BDMRZjZ+cF68tCc8y83Q2hV4mWRimaps4LDJoli4OA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UphNA9ijerNgx0WLGbB4jQY09R5Y8tXcV0nXuw0XFsx9tr9FszPLBDisX0iBhnajn
	 yx13skeXjRHDwhheu47HNctI8ZCfujRlJESrbicC5Pxwt9Wa3CWV7UJT4RhAV5m3Y1
	 Z8FYs6WSCCEhk7lMltgUcP7IKdUv7zPkuln94bVilgYchrIfU/d1vU3Mn73M9bIAaQ
	 ybrTOUrq9s1S1wnH2TJyuKZLU/8B2kqjKLa5RtkqBvcGY40lFDCYfahy6nUR2psyue
	 EXImBbUKQNU2ZOu7hDKbx600MyvJiDGxng0uAB62eqbi+rU06d63wZaXbe93TT6H1V
	 hCH2HqFaxe1Gw==
Date: Sat, 17 Jan 2026 12:46:53 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Georgi Djakov <djakov@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, ~postmarketos/upstreaming@lists.sr.ht, 
	phone-devel@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/5] dt-bindings: clock: qcom,milos-camcc: Document
 interconnect path
Message-ID: <20260117-efficient-fractal-sloth-aaf7c2@quoll>
References: <20260116-milos-camcc-icc-v1-0-400b7fcd156a@fairphone.com>
 <20260116-milos-camcc-icc-v1-2-400b7fcd156a@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260116-milos-camcc-icc-v1-2-400b7fcd156a@fairphone.com>

On Fri, Jan 16, 2026 at 02:17:21PM +0100, Luca Weiss wrote:
> Document an interconnect path for camcc that's required to enable
> the CAMSS_TOP_GDSC power domain.

I find it confusing. Enabling GDSC power domains is done via power
domains, not via interconnects. Do not represent power domains as
interconnects, it's something completely different.

> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  Documentation/devicetree/bindings/clock/qcom,milos-camcc.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,milos-camcc.yaml b/Documentation/devicetree/bindings/clock/qcom,milos-camcc.yaml
> index f63149ecf3e1..707b25d2c11e 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,milos-camcc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,milos-camcc.yaml
> @@ -25,6 +25,10 @@ properties:
>        - description: Sleep clock source
>        - description: Camera AHB clock from GCC
>  
> +  interconnects:
> +    items:
> +      - description: Interconnect path to enable the MultiMedia NoC

And since when clock controllers are part of interconnect path... Even
more questions....

Best regards,
Krzysztof


