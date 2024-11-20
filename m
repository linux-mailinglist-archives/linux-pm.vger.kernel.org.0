Return-Path: <linux-pm+bounces-17801-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B167D9D3515
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2024 09:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4615BB2243A
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2024 08:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DEE16DC3C;
	Wed, 20 Nov 2024 08:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H52j9Svc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8E11586DB;
	Wed, 20 Nov 2024 08:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732090356; cv=none; b=R+MS66Jbj5Pwgy2bBJjM0t4PIkHMUHVoJ1hgJkojNcWAHoUMfaASZQEgMlgaByJzCOB2UutL0bc5xLvouc1hJIVPWN3UOFmgdjJ2lD2/t0EY9nYfMZ11Dc7oYjXBqT32T7onGxHCZuODQyqrTACXVzRjdRaeULWKqblOfiuyxTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732090356; c=relaxed/simple;
	bh=ty/S4gauAhtzgOdL7+3lbsv+AiMkOi0u4zHGD4rkM34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5TpNIZadTy66+DTN5mNGX0fJhKB3Vo8fMQwsVBLAb4K66pAyBGGxEbErlTJA93/xyTmH037uHisLBDlSui3xhuujyLorDl5aNWZmHDv+Ls3ZpHgLHJhT69QdLmHxDMd7rNrlwwj9UBuMJqRzwNfktTqP/UvRUqw6BMSED2akRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H52j9Svc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1002BC4CED7;
	Wed, 20 Nov 2024 08:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732090355;
	bh=ty/S4gauAhtzgOdL7+3lbsv+AiMkOi0u4zHGD4rkM34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H52j9Svc7q9EL5E4/cBNawNgHi4DRKDFmkZHTPZQqsLqbBOiTKmkGsUmWqcrBHdGT
	 q1ldS+d+RwXWCXznSO96Sy8xESWdVuubgqBAM91MwfkamMFUa4wtJVzBLidliCM4Rk
	 jAsFtWr/SdOih3Yw0qy+O3gi9sA4fBP8CTfx58nqleTay4bAYYTKtJq0fGomXcfTP8
	 ieKFXUPiCq6b6pswhdGLPAdjg1xXLqHkPAtFHkFrz/IJ0aw7NESF0haGaoNRM6y6yq
	 NaND/dbfKyPxV0kHf9ZETMAkJJ6cpo1FPfOHmbtlgwBMLZ2vY4YTq3JwvoP7g3zWpE
	 rsnmLjLjn8yAQ==
Date: Wed, 20 Nov 2024 09:12:32 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH v3 1/2] dt-bindings: power/supply: Add ltc4162-f/s and
 ltc4015
Message-ID: <bwn36yetahe7bjwsrcx4lljn6r7ta4d2r6pacq4ccmxbkkurpo@vkgjle4ckl6b>
References: <20241119032304.23588-1-kimseer.paller@analog.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241119032304.23588-1-kimseer.paller@analog.com>

On Tue, Nov 19, 2024 at 11:23:03AM +0800, Kim Seer Paller wrote:
> Add LTC4162-F/S and LTC4015 to the supported devices of LTC4162-L.
> They share a common set of registers. The only differences lie in the
> resolution value of the scaling factor for battery voltage and battery
> current measurement, input voltage, and input current for different
> battery chemistries. The differences also include the calculation of
> setting and getting the actual voltage applied to the charge voltage,
> as well as getting the die temperature.
> 
> This add compatible entries for ltc4162-f/s and ltc4015 and include
> datasheets for new devices.
> 
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> ---
> V2 -> V3: Described differences in the programming model between variants/devices.
> V1 -> V2: Modified commit message describing differences between
>           variants/devices.
> 
>  .../devicetree/bindings/power/supply/ltc4162-l.yaml         | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml b/Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml
> index 29d536541..9b546150d 100644
> --- a/Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml
> @@ -17,12 +17,18 @@ description: |
>    panels, etc., and a rechargeable Lithium-Ion/Polymer battery.
>  
>    Specifications about the charger can be found at:
> +    https://www.analog.com/en/products/ltc4162-l.html
> +    https://www.analog.com/en/products/ltc4162-f.html
>      https://www.analog.com/en/products/ltc4162-s.html
> +    https://www.analog.com/en/products/ltc4015.html
>  
>  properties:
>    compatible:
>      enum:
>        - lltc,ltc4162-l
> +      - lltc,ltc4162-f
> +      - lltc,ltc4162-s
> +      - lltc,ltc4015

Keep alphabetical order.

I assume these are not compatible.

Best regards,
Krzysztof


