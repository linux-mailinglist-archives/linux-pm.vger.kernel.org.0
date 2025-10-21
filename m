Return-Path: <linux-pm+bounces-36539-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8BBBF4C26
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 08:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D3D418C4EED
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 06:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239AC26D4F8;
	Tue, 21 Oct 2025 06:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p4yD81KZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89B826CE34;
	Tue, 21 Oct 2025 06:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761029628; cv=none; b=ZJhTjLE3NqcSMPW8tZXWVR8cWkFNl+It6ccT1sEZERyCEowWWJDbrhZj85vreS9537rEVBnatDpccIPGjhfOgX7KrNhaDAjOmjOCQZnWXNub+dj5E16WgtThlIgz70OzUZTg1BVcvpTK/8fXUnxzSdvdTRRck7qWKhZXu0DPZIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761029628; c=relaxed/simple;
	bh=m4LFaAIzZI1Eef6ivEIcMLDkN6twcWE4plP0xAbRano=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gXdA9rBYFWjkX+68M0xfsLQsGZDZR2h4J29JGGqBwYe8OXcAm3LnwtqwZoJy2w1WCdsT0AZN+osp7QGFc6sUBoVKthe3NcRoxZBI8SbbYAJt/Z75zeap1gTJEobgdBuSxOUFXx0/A2zazpD04GT6R7VW82jc471CDNRyrGKPi+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p4yD81KZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3788C4CEF1;
	Tue, 21 Oct 2025 06:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761029627;
	bh=m4LFaAIzZI1Eef6ivEIcMLDkN6twcWE4plP0xAbRano=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p4yD81KZMaJ0dYbvKvdOzLXBUJ5pLeXBoicGz5+b543c5agzUVWOXYOYtxCEtb255
	 BeigKmh/bOCQ/019iXI9C6gvh/ra8bj7z/df4jMwUahp844OSW+7EkPaAoUeKfLo63
	 vMQL6aSir+ODNAkzXlm7fMi+UiHOfuGPmmcS7rjUcFT91Rx9YEzFlM4rU5OWGXAgvS
	 qFiEazT4Tk/jZUt+bTbLXpuBZ22d7bmnOxuPmkc6o+ST0c3mUXW/4GdXvSpd3JQLC4
	 UyL1P3DCbvqJ3bSoDpd+jhuawzlNpAyfGX/BdGGCgW9uEzdL4aWwbKigK7c0K1MMIl
	 RKO8ES+JtXmgg==
Date: Tue, 21 Oct 2025 08:53:44 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Talel Shenhar <talel@amazon.com>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: thermal: Convert amazon,al-thermal to DT
 schema
Message-ID: <20251021-invaluable-lynx-of-enterprise-314a7a@kuoka>
References: <20251013215820.783272-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251013215820.783272-1-robh@kernel.org>

On Mon, Oct 13, 2025 at 04:58:18PM -0500, Rob Herring (Arm) wrote:
> Convert amazon,al-thermal binding to DT schema format. It's a
> straight-forward conversion.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../bindings/thermal/amazon,al-thermal.txt    | 33 ------------
>  .../bindings/thermal/amazon,al-thermal.yaml   | 50 +++++++++++++++++++
>  MAINTAINERS                                   |  2 +-

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


