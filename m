Return-Path: <linux-pm+bounces-40784-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 645D7D1CDA6
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 08:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D420930124F7
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 07:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A169836212A;
	Wed, 14 Jan 2026 07:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pBZAJV31"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5563B3624A0;
	Wed, 14 Jan 2026 07:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768375922; cv=none; b=DPhtdsbF9TNkdsUcbguGenbah6I8h4SExsarE+IXBwQPu9tAck3TKAODciEYlsHVMG5UCyzRlHdXVqoDe1ctzNoqpctI5VgU8YF2XXuGGJA1rY9xkegfITjX/SWLt8w/L/gDd5U6DOBTnk32qhIQv+KR2e5gWaonJ6AV8fneMfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768375922; c=relaxed/simple;
	bh=orcwKbiN7UgOJj304kfxPoo8ZOOnHKD4pLKX5LgxnVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xou8BiF7VUJ/xSpdXH8Lhw2/Pvl+uGskDQG/mCBFFCQk0bpBwXuS4txKFRCdB1i+ANymAbir40Kg588FtLc0QEkMFxzTWx3XraDoVxwhDowic0IYsJi+7jE98OvWWPBsauk54Km/CActykrcoriWRXcGRh5sgFbNgbzXqpj6nOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pBZAJV31; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2517FC4CEF7;
	Wed, 14 Jan 2026 07:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768375921;
	bh=orcwKbiN7UgOJj304kfxPoo8ZOOnHKD4pLKX5LgxnVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pBZAJV31mQg2RRApzC2Efuxi+GRtdWpVi13qsQteRGqABdi0Gvl+qAUQ5j5/qexNx
	 FgZZJOvq7kaTP8ZFwklFn7chW2MuDKaWSHy+suy2R/CAxv79sH1+E6HVlk72yd9YHA
	 2BCMkmZCNhSX3AXHyWUxtWR82wpI9WLNJV7/d/lNeXuFYIArWCTtxB8gsRXdZ+Ox0n
	 tPIG2mL6IvNkDJCq66CwVQJsjlj/sVh05AwFdW9QyXp5rF+kP36Z4P0bwh2wRA8cGY
	 hGvnsO5oYQjehioerAnKzktCGy4Byjumiy8v+cSNBRYOm4t3wFPpmsbhWQRPyDDNBo
	 7D/iuflB4Bbzw==
Date: Wed, 14 Jan 2026 08:31:59 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, dmitry.torokhov@gmail.com, sre@kernel.org, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, 
	jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH v4 5/6] dt-bindings: sound: google,goldfish-audio:
 Convert to DT schema
Message-ID: <20260114-gainful-mutant-lemur-92ede9@quoll>
References: <20260113092602.3197681-1-visitorckw@gmail.com>
 <20260113092602.3197681-6-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260113092602.3197681-6-visitorckw@gmail.com>

On Tue, Jan 13, 2026 at 09:26:01AM +0000, Kuan-Wei Chiu wrote:
> Convert the Android Goldfish Audio binding to DT schema format.
> Move the file to the sound directory to match the subsystem.
> Update the example node name to 'sound' to comply with generic node
> naming standards.
> 
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
>  .../devicetree/bindings/goldfish/audio.txt    | 17 ---------
>  .../bindings/sound/google,goldfish-audio.yaml | 38 +++++++++++++++++++
>  2 files changed, 38 insertions(+), 17 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/goldfish/audio.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/google,goldfish-audio.yaml

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


