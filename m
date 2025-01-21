Return-Path: <linux-pm+bounces-20764-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 250EBA17B14
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 11:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 967287A4980
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 10:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38A81E9B03;
	Tue, 21 Jan 2025 10:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4vNfWTm"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19E91E7C07;
	Tue, 21 Jan 2025 10:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737454189; cv=none; b=oKu/AGqaWvKZcRqbeJva0dewtgPCjVF9Ly0lyYOWh/em4pi+6jUD4paBbPMa9ehLf+Xj3LApxk0XRNUZViiXHuuWxeb7Zw8LNafnNTRggNrw3Y5AMJgCH1P5A6DL9EVokjHZ2n3hphV9SRsPHeLGlSGMIhAS6ctz6Yg/0NUJ7zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737454189; c=relaxed/simple;
	bh=iKXCTaunJbbRfM7uFpg3sysGlHLpmUBaQn4ftpbByNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RD8DUqDB2wYo11pPp+OtAt9A/x+FuzHbX4TTBSMv+nGFPgrf/07M0enUilGpHElEj7KxXXRYQS3EnEaxqun6JlCACZfgnBvwqcH7QZrNe7Jz20fkcGq5TPcKl6hPWq/ydolwk6ueY+K4pNC0LlV3cEJUv4AjyzRR1R06uzfaPY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4vNfWTm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C1A6C4CEDF;
	Tue, 21 Jan 2025 10:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737454189;
	bh=iKXCTaunJbbRfM7uFpg3sysGlHLpmUBaQn4ftpbByNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a4vNfWTm0j9rRNxhZuaSage+sdEk8JCmjCoa3wLc6Z5/AfCSE/L5DZ23foA2UuP/8
	 eZXlut+CC8hHE5fHnUGnxVpiAnr89DM+5ZjN4NZIPc6x9HL5ibNUtdeT6Oj/qTQh4G
	 ruzNd/xMzX95yJ4RDyU+foZRT3hi1ioh3dngg/tOtyEFUlhhMmFNRUatah7N7TdsiQ
	 X4Sw3QA3SvgmLclgpjef4/V9xq47jdsGcY9TNc+VyduufFh+1IZM5ijEiUnRHFmQoU
	 Ctics4OdqCYxK3KkXTIU6egITiZsI7F/SNS7xUid0gegywWRk7zX92P+2sD07bXnUK
	 x2vhHUKEuLTDA==
Date: Tue, 21 Jan 2025 11:09:46 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com, guoren@kernel.org, 
	wefu@redhat.com, jassisinghbrar@gmail.com, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, frank.binns@imgtec.com, 
	matt.coster@imgtec.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, ulf.hansson@linaro.org, 
	jszhang@kernel.org, p.zabel@pengutronix.de, m.szyprowski@samsung.com, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org
Subject: Re: [RFC v3 10/18] dt-bindings: gpu: Add 'resets' property for GPU
 initialization
Message-ID: <20250121-thankful-discreet-hawk-2fdc26@krzk-bin>
References: <20250120172111.3492708-1-m.wilczynski@samsung.com>
 <CGME20250120172133eucas1p232c85cb934148427e52dd939c974a82b@eucas1p2.samsung.com>
 <20250120172111.3492708-11-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250120172111.3492708-11-m.wilczynski@samsung.com>

On Mon, Jan 20, 2025 at 06:21:03PM +0100, Michal Wilczynski wrote:
> Many RISC-V boards featuring Imagination Technologies GPUs require a
> reset line to be de-asserted as part of the GPU power-up sequence. To
> support this, add a 'resets' property (and corresponding 'reset-names')
> to the GPU device tree bindings. This ensures the GPU can be properly
> initialized on these platforms.
> 
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


