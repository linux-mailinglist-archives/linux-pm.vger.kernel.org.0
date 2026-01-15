Return-Path: <linux-pm+bounces-40943-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC6FD26D86
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 18:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E9C2C3012A9D
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 17:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65693BFE2E;
	Thu, 15 Jan 2026 17:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HaIYSOFk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903CA3AA1A8;
	Thu, 15 Jan 2026 17:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768498919; cv=none; b=EsYTqlUUdNhkLhj6NcGnaQSuoX4+Vs2IHDzpEqa5lc7qTOMCC/EGjyVWVSGFrWq/D87dWTvHVa/xvvTfRnlDST2xT6xrWI4LR3zRwErU44hdoog8ii60sZkU1k48aSSwy6+ZRixqZe8f/cGkv2G/GYFSj23mw7McMcOhVchh3BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768498919; c=relaxed/simple;
	bh=tegX0Z/kfZv1/AcKJNcGxRXv024yyTYAJnUN/qrxplY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pnPtaKgUswYieZWi8OBh/zmbl+lLA/Z6E7iTtYIlDWxRJ7Fi38nDt8BwvXq6z0f7GIToe5Jvtc3BPNKqCLy1E5IjhaSpOTRtmC694ymOYWNmVeQ6wk4vVjbSNhof9zjhlzZDSr1GIfCgCk8djIcdwd8gN2fPIJLXPnoxaQU4uOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HaIYSOFk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF17C19422;
	Thu, 15 Jan 2026 17:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768498919;
	bh=tegX0Z/kfZv1/AcKJNcGxRXv024yyTYAJnUN/qrxplY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HaIYSOFkzGOX1FELeMIxNJBCUp2pBsmJr+vWtH9c22QOuR3bWR1i9x1arvu7BpZ5M
	 zJptP4/6imL6piFKD8gTvA+pOLriBbLiEyIF1E535zkpNchLbZjGjuE9UwN2CZ6cae
	 MnRw1IeoleGfz0rzIy8GO81+3hjwMen29CDZ0MdvCwF5RICh/RAWZTbVX3hWhlXzZn
	 bJchVcQWlc5Ar1XBcNmQtz14fBZleQsW62EVir1DibiN0LDmIb/ki5hKYI4+BISq38
	 KaGiLCo3RyZBKEkf+GTUN7n2UQQ4rMpGZeGTABOhGdizM3NqxRml61QpJcjoFmrhP8
	 zaXTszb+mFFXA==
Date: Thu, 15 Jan 2026 11:41:58 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	sre@kernel.org, conor+dt@kernel.org, eleanor15x@gmail.com,
	simona@ffwll.ch, airlied@gmail.com, tzimmermann@suse.de,
	krzk+dt@kernel.org, gregkh@linuxfoundation.org,
	jserv@ccns.ncku.edu.tw, mripard@kernel.org,
	linux-input@vger.kernel.org, dri-devel@lists.freedesktop.org,
	broonie@kernel.org, maarten.lankhorst@linux.intel.com,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	dmitry.torokhov@gmail.com, jirislaby@kernel.org,
	lgirdwood@gmail.com, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 6/6] dt-bindings: display: google,goldfish-fb: Convert
 to DT schema
Message-ID: <176849890696.935461.15138796644724079676.robh@kernel.org>
References: <20260113092602.3197681-1-visitorckw@gmail.com>
 <20260113092602.3197681-7-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113092602.3197681-7-visitorckw@gmail.com>


On Tue, 13 Jan 2026 09:26:02 +0000, Kuan-Wei Chiu wrote:
> Convert the Android Goldfish Framebuffer binding to DT schema format.
> Update the example node name to 'display' to comply with generic node
> naming standards.
> 
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
>  .../bindings/display/google,goldfish-fb.txt   | 17 ---------
>  .../bindings/display/google,goldfish-fb.yaml  | 38 +++++++++++++++++++
>  2 files changed, 38 insertions(+), 17 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/google,goldfish-fb.txt
>  create mode 100644 Documentation/devicetree/bindings/display/google,goldfish-fb.yaml
> 

Applied, thanks!


