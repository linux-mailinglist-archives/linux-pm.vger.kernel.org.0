Return-Path: <linux-pm+bounces-40887-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D045FD212CF
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 21:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 473F9300CF16
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 20:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EF1350293;
	Wed, 14 Jan 2026 20:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBUv0zxu"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE67339719;
	Wed, 14 Jan 2026 20:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768422434; cv=none; b=L8h4XaVZqgxUq544pBVTJedp//+vcEq1qakkpjNjE9s1AsJb9zHLNOhkQ/8C1DmPEz2zUub9MtoXxTMHCajiuCR7BzUsVUwyZWQo1bUh0dTOFLRl7yPSHbbcmcqPWzbKoNeHEK2hs9p+S7nVJEJtnLY5yYwQfk0m1UwUGWM4Xq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768422434; c=relaxed/simple;
	bh=eV4ndeTq5LWYE9boQjw7KvAeUJ9TpCAcZkHCoVpVQWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJus5egZESBnPi+s+Hw5SML0MnUIvdHB6cPNklHG/seUjdExSnR9KCK+kgw8288fhF9x1uCRrSfLErtBGVgky6qYA38cw1tmXu4WH1XT3LenilQx3os565BD0s2G5VV9DG+/ymRF/srmU/tB6ODzHavXMT1BxnkvwtRzmSuugug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBUv0zxu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA60C4CEF7;
	Wed, 14 Jan 2026 20:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768422434;
	bh=eV4ndeTq5LWYE9boQjw7KvAeUJ9TpCAcZkHCoVpVQWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jBUv0zxuoGaNzDy21D4G1u4AI8LjtJ4MetoZmUuzHcAkxtfSbW48qy3gPZVw7BBCj
	 VbRMzhUZZTXgMRPKm3af84TvB1+SxK+CUl8d43rIsstnU8OcwvJgEqWQMyPw9kUE2A
	 78JTx3T5Z3mxdDTMJLFGKkxCMxyboANnyakdiIu2t8ggaz8+Sfv5fF//hY6sxHZJ2d
	 mNRFlVPj2JbuoeYKb/EWwwSz1XUqMY2pwVGtudZUwO5fzGaI08nbPF01pAJTsTA5ww
	 /IXFR7fza1SWaUHqFzb5wLDKHRaZPLbxJjfLm23YNIo8OnOlKVfxwjmdikvccRvGWt
	 UI1928JIH1ljQ==
Date: Wed, 14 Jan 2026 14:27:13 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, conor+dt@kernel.org,
	linux-serial@vger.kernel.org, simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com, eleanor15x@gmail.com,
	airlied@gmail.com, linux-pm@vger.kernel.org, tzimmermann@suse.de,
	dri-devel@lists.freedesktop.org, mripard@kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	linux-sound@vger.kernel.org, gregkh@linuxfoundation.org,
	jserv@ccns.ncku.edu.tw, krzk+dt@kernel.org,
	dmitry.torokhov@gmail.com, devicetree@vger.kernel.org,
	jirislaby@kernel.org, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, sre@kernel.org
Subject: Re: [PATCH v4 2/6] dt-bindings: misc: google,android-pipe: Convert
 to DT schema
Message-ID: <176842243303.3160426.3438138297635940140.robh@kernel.org>
References: <20260113092602.3197681-1-visitorckw@gmail.com>
 <20260113092602.3197681-3-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113092602.3197681-3-visitorckw@gmail.com>


On Tue, 13 Jan 2026 09:25:58 +0000, Kuan-Wei Chiu wrote:
> Convert the Android Goldfish QEMU Pipe binding to DT schema format.
> Move the file to the misc directory as it represents a miscellaneous
> communication device.
> Update the example node name to 'pipe' to comply with generic node
> naming standards and fix the mismatch between unit address and reg
> property in the original example.
> 
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
> Changes in v4:
> - Use decimal format for interrupts in the example.
> 
>  .../devicetree/bindings/goldfish/pipe.txt     | 17 ---------
>  .../bindings/misc/google,android-pipe.yaml    | 38 +++++++++++++++++++
>  2 files changed, 38 insertions(+), 17 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/goldfish/pipe.txt
>  create mode 100644 Documentation/devicetree/bindings/misc/google,android-pipe.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


