Return-Path: <linux-pm+bounces-40124-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C150CEE7D2
	for <lists+linux-pm@lfdr.de>; Fri, 02 Jan 2026 13:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 650B13020369
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jan 2026 12:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADA730F53F;
	Fri,  2 Jan 2026 12:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ktg/X2UE"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533D230EF7A;
	Fri,  2 Jan 2026 12:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767356321; cv=none; b=K2xP1ZwmfOVs7bPr5xEXOHnnd0q6LOj0UxfdYP0jmPrDvUElVp6KlHEKkAz5ZQXwm5agcBjkmBIE+kTSwnQb2iWzfrB9VYQLKMULQ+5MPml8MTFEyVNPY3kVJEKsBRROybQ3f2hO1XQnDNB83lV9q8+Ddps7trvlczbNecQPHhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767356321; c=relaxed/simple;
	bh=Tb2YDXRKcVQK2vPJv/quYKFzQ2ip2fRl0IeUjAystjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JrQhTCeh1hQoAKoCpjM9rvGJFb2QJzpPchGM+h4uueYwhCNX69Gq71KUQkRaKpZQu6LCY6Qbuq1ahm3V9gifsKgPcfFuA1iV4DxINPaHAPN+3t9/g2fPahCX6un3vH2Rudjy2ZkAEeZkDH/I/1tfi6xcu3L6nfaxWuob4KhP4IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ktg/X2UE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE6DC116C6;
	Fri,  2 Jan 2026 12:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767356321;
	bh=Tb2YDXRKcVQK2vPJv/quYKFzQ2ip2fRl0IeUjAystjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ktg/X2UE+tCc8C8dX9A/3G0im4i6nDacLtA+mHqt3ttjLNMYDbABukyS16ZGsMFgt
	 EuR2gYg1o7QSvHpBp7ajMaxvbTtAATU+nV+SMezRvnrSdks5vOCcFUk3hnqVu9vk/e
	 GBLiGir02y3Rb/XTwIieYlqT/vsejJp57UPdi9m9ciDMuKBmDk9b859YhqV3AQ9z4s
	 PuMjZYatbP7KY1n7qiYEYdpx1jyCs6i4ZEriZyvVTbc1yCdHkjgTuGMRaJlh60SJz6
	 HyK3YKr9wVs5gkOcflnDJ9QZMCFqtuABxwL5R9Ue0HjjSAQfP9dCFaZWj0vaCkkdxl
	 NEJ+XawINS6RA==
Date: Fri, 2 Jan 2026 13:18:38 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, dmitry.torokhov@gmail.com, sre@kernel.org, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, 
	jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: serial: google,goldfish-tty: Convert to
 DT schema
Message-ID: <20260102-fast-clay-jackrabbit-6d6637@quoll>
References: <20251230181031.3191565-1-visitorckw@gmail.com>
 <20251230181031.3191565-2-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251230181031.3191565-2-visitorckw@gmail.com>

On Tue, Dec 30, 2025 at 06:10:26PM +0000, Kuan-Wei Chiu wrote:
> Convert the Google Goldfish TTY binding to DT schema format.
> Move the file to the serial directory to match the subsystem.
> Update the example node name to 'serial' to comply with generic node
> naming standards.
> 
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
>  .../devicetree/bindings/goldfish/tty.txt      | 17 ---------
>  .../bindings/serial/google,goldfish-tty.yaml  | 38 +++++++++++++++++++
>  2 files changed, 38 insertions(+), 17 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/goldfish/tty.txt
>  create mode 100644 Documentation/devicetree/bindings/serial/google,goldfish-tty.yaml
> 
> diff --git a/Documentation/devicetree/bindings/goldfish/tty.txt b/Documentation/devicetree/bindings/goldfish/tty.txt
> deleted file mode 100644
> index 82648278da77..000000000000
> --- a/Documentation/devicetree/bindings/goldfish/tty.txt
> +++ /dev/null
> @@ -1,17 +0,0 @@
> -Android Goldfish TTY
> -
> -Android goldfish tty device generated by android emulator.
> -
> -Required properties:
> -
> -- compatible : should contain "google,goldfish-tty" to match emulator
> -- reg        : <registers mapping>
> -- interrupts : <interrupt mapping>
> -
> -Example:
> -
> -	goldfish_tty@1f004000 {
> -		compatible = "google,goldfish-tty";
> -		reg = <0x1f004000 0x1000>;
> -		interrupts = <0xc>;
> -	};
> diff --git a/Documentation/devicetree/bindings/serial/google,goldfish-tty.yaml b/Documentation/devicetree/bindings/serial/google,goldfish-tty.yaml
> new file mode 100644
> index 000000000000..08fa12449a01
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/google,goldfish-tty.yaml
> @@ -0,0 +1,38 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/serial/google,goldfish-tty.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Google Goldfish TTY
> +
> +maintainers:
> +  - Kuan-Wei Chiu <visitorckw@gmail.com>
> +

Missing allOf to /schemas/serial/serial, unless this is not a serial, but then your
commit msg should explain that.

Best regards,
Krzysztof


