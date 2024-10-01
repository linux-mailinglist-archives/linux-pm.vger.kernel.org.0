Return-Path: <linux-pm+bounces-14998-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D683098B518
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 09:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93B14281FF8
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 07:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A909E1BC9F3;
	Tue,  1 Oct 2024 07:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sPBkQEnk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BA0197512;
	Tue,  1 Oct 2024 07:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727766210; cv=none; b=eXM2qpxa8s+mgy6OT3HHn+1oAnTCSD7DIA7jedPozbm2LqRDoVIoc9HRgczZEy8sjId9QyuICJCAwmsttLlsI+/piKXl/AagXxDIElhPYcF2Itsnrf1d7G//rREeShVq0r4g0ADF53NeT52WzfQSYdrbCQaKL4zDfdRYUieyBDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727766210; c=relaxed/simple;
	bh=giW38/Jr2OriJfpRZd499uWn9qePO8iOv9QP2qTGkho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJMa56+ioZmbohV+Uz/UY4QB73EOrX+00xTClb5T0UgzYSqmnHTST/V30OEY80N+gNSeAMUcBqaf+r2fQ0AygsRmMc7vHP1Zs2UGNSv3PbB0q4H9BfIUG8yoQMBjvAQFP9tDE2221Luu6vDtnrSBBZ7WuXGsvam1X0D+cUNQPNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sPBkQEnk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E130FC4CEC6;
	Tue,  1 Oct 2024 07:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727766210;
	bh=giW38/Jr2OriJfpRZd499uWn9qePO8iOv9QP2qTGkho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sPBkQEnkvDrdj1MvoN9JLxXF+YAbZoaiwiobABRDDYhBlWckP5ZBAGtUyGpZCQjNo
	 ODy2Q2zGCyDTfGuwJlWbHg1mUr1eV+vLVxV9k0qkU3W7akd1xRu2sli3LOMSfN5Qpt
	 0MxSzmsi+Pgrp8xggctnbvXni58KxGmclwNZPiuKYYRyP2mZUXtZyy1VGhpW4DNqtQ
	 gD/urD4xdOpGlM8G135qU5iySFTvc8DnYgIZzd/W/MBSzCLHPrQDddSESMdzLM0sJF
	 6iwweKVCYLu035m4vfr/wecI0Xq3tyf06w/FC6ry5He+gGGlcJvHt3stil7/5FsCBy
	 JNv/atcR//JFg==
Date: Tue, 1 Oct 2024 09:03:27 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-pm@vger.kernel.org, 
	Conor Dooley <conor+dt@kernel.org>, tony@atomide.com, linux-kernel@vger.kernel.org, 
	linux-omap@vger.kernel.org, Lee Jones <lee@kernel.org>, devicetree@vger.kernel.org, 
	Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: mfd: twl: add charger node also for
 TWL603x
Message-ID: <dda44pt5prwebl5qcxr5mtyihyjjhs3fkqnocwd2ptpudicbda@pdch2x2hlkta>
References: <20240930155404.1275702-1-andreas@kemnade.info>
 <20240930155404.1275702-3-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240930155404.1275702-3-andreas@kemnade.info>

On Mon, Sep 30, 2024 at 05:54:03PM +0200, Andreas Kemnade wrote:
> Also the TWL603X devices have a charger, so allow to specify it here.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  .../devicetree/bindings/mfd/ti,twl.yaml       | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ti,twl.yaml b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
> index e94b0fd7af0f8..488d419b211d1 100644
> --- a/Documentation/devicetree/bindings/mfd/ti,twl.yaml
> +++ b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
> @@ -105,6 +105,12 @@ allOf:
>              regulator-initial-mode: false
>  
>        properties:
> +        charger:

Properties should be defined in top-level, mot in allOf. You can
disallow them for certain variants.

Best regards,
Krzysztof


