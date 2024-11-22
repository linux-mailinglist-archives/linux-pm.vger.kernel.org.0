Return-Path: <linux-pm+bounces-17951-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D91B9D5A3D
	for <lists+linux-pm@lfdr.de>; Fri, 22 Nov 2024 08:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD91E1F23374
	for <lists+linux-pm@lfdr.de>; Fri, 22 Nov 2024 07:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E38917B4E1;
	Fri, 22 Nov 2024 07:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qhLcJcVY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D53175D44;
	Fri, 22 Nov 2024 07:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732261758; cv=none; b=Rsfa3zzSnwZlzxj34oZ0f4/X/vKoUK8qBXdQW92qGuxkorP/EXCHYNhy4wwvEr0WYREJw7nlxqRRwdoDf8U5JHcKt9q09DDrtZKZZ2FdKloFpVY+C+ENQ8M2tlOLXcO9GbNxFHVfYtNEa7erbCb7vxqPBqbtn53ZiH7+g4wAZhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732261758; c=relaxed/simple;
	bh=S+qNBPkjkTjMFUl0CwAxU9iquNF+lNSPF4WWI6IeZ1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nBbjsl5o/8C2YAghX2x0o/9QvnxcheHuS6qwd/7LbUnHFLLc7Ij3uwTglgJRisohDQJVR6JDir/FZ7OCvgTo1ZiO2S+8WwMvzjPDSasbVlQWG1aMGYnt3NwdSUUf/zvQxcHxkewUfPkuJm/xOv9qKV9WKuCgStM30DTGE3m189I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qhLcJcVY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA12C4CECE;
	Fri, 22 Nov 2024 07:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732261757;
	bh=S+qNBPkjkTjMFUl0CwAxU9iquNF+lNSPF4WWI6IeZ1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qhLcJcVYCiPouCekC36rvLGUitMNUMMFkrWn3TCuJjEWt3gWny/l9HRmAjxKdnvqO
	 5NJxW84aKV+ExKhZDgikWWcpnkv2iwwF9t437CGv/GaJtY6TwuE9wGLJiW2fKps2Ka
	 LgeAHePnZ9oa0jF0m3B8+rhpbQiZ27TImOcFsPx1GkLf+xXfBURDIr/zuSdmmbEtTH
	 P/mQ5TU6+1hkwwOIyQk2rDgiffX7GI08xqRKpazwEdAMUBaNuuFVCmUXttNewSlW3Q
	 uLHR4drxlArP1s9p/B7HAQfHr6oJQxe219wm32VIjpVJydOp70ejDFDFKnG/nhDdif
	 30Uv1XrJkpBEQ==
Date: Fri, 22 Nov 2024 08:49:14 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sung-Chi Li <lschyi@chromium.org>
Cc: Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, chrome-platform@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: mfd: cros-ec: add properties for
 thermal cooling cells
Message-ID: <4f5sahkxxqb5qonh676igaiadkxv2pbhbibu6wtx4yenplfn4o@yvidi4ujavhr>
References: <20241122-extend_power_limit-v1-0-a3ecd87afa76@chromium.org>
 <20241122-extend_power_limit-v1-2-a3ecd87afa76@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241122-extend_power_limit-v1-2-a3ecd87afa76@chromium.org>

On Fri, Nov 22, 2024 at 11:47:22AM +0800, Sung-Chi Li wrote:
> The cros_ec supports limiting the input current to act as a passive
> thermal cooling device. Add the property '#cooling-cells' bindings, such
> that thermal framework can recognize cros_ec as a valid thermal cooling
> device.
> 
> Signed-off-by: Sung-Chi Li <lschyi@chromium.org>
> ---
>  Documentation/devicetree/bindings/mfd/google,cros-ec.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> index aac8819bd00b..2b6f098057af 100644
> --- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> +++ b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> @@ -96,6 +96,9 @@ properties:
>    '#gpio-cells':
>      const: 2
>  
> +  '#cooling-cells':
> +    const: 2

This is not a cooling device. BTW, your commit msg is somehow circular.
"Add cooling to make it a cooling device because it will be then cooling
device."

Power supply already provides necessary framework for managing charging
current and temperatures. If this is to stay, you need to explain why
this is suitable to be considered a thermal zone or system cooling
device (not power supply or input power cooling).

Best regards,
Krzysztof


