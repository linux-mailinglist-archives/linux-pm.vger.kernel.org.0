Return-Path: <linux-pm+bounces-30345-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2549AFC508
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 10:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB2007A5699
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 08:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1F029B8E6;
	Tue,  8 Jul 2025 08:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojphUlrm"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F23B19E992;
	Tue,  8 Jul 2025 08:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751962033; cv=none; b=Z75fTIZ2gqr+wr/8SWa/BoZpXGnyHMlKkm2vQrWteXdz5F1yoOEG4l1sfvgfEnBbwGu4pyWaOZ+HBmBNabZpUfZOHXmFSGrM5c91U0PC1H09X1fBaprhaWa7p7DIpwqzlAdR3zvafZT/l0OMvh8ChVKW4ZYjFbnUHTu6WdDYRxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751962033; c=relaxed/simple;
	bh=Y8Gvvfv+exKnqgTnsgCD3HEpXy6Nv9JBt5z6zPldElY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxCAaAh78pjcXhZhqxVev97c6Va6k7u0FdWmLNtcPm39mP4fgdyD17gu+Ng6enZ0M8bQ6nGZAKJnwngST6RXN9WuggZhXwJWOSO9zEnbcQvJxJfTzsXYEPJiEUK+9mSS6Ve/ZjYb5EbXX7baAuk6HblDIoGj26+8LXLdeIKFjM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojphUlrm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 114FAC4CEF0;
	Tue,  8 Jul 2025 08:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751962032;
	bh=Y8Gvvfv+exKnqgTnsgCD3HEpXy6Nv9JBt5z6zPldElY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ojphUlrmCYL+ylHhwJQLmTpIAWlu/m/SvoBx5cJ0himdrhJoKefEMSson6tINBWv4
	 NmbgfunAqDCQ1eBnTQfFKZPvHHSSDGHORVyxcP4dm0rF8zEwIGFpH8kZIbTpRisPnv
	 h7xYFEy6xXc1nyQFYfEH12rKWmxODiklFmk/GnKZ4HVaj3M+YHuEHpzZF01lVkHGSN
	 iwHDyEhfIuWotgGAGvC+o2MkN/QdntFk7svAn5rMUmG9EGza70mu6V0jJIqBRJEJih
	 EptMSl4+BmUflRkpgZCIG0XKC8MUMG/aVPgq9+X3KFVKgeYYadVKPAd/gWIVxtfHhF
	 FuXUWTRmGwmEA==
Date: Tue, 8 Jul 2025 10:07:10 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: power: qcom,rpmpd: document the
 Milos RPMh Power Domains
Message-ID: <20250708-scrupulous-chubby-bustard-4ccbdb@krzk-bin>
References: <20250707-sm7635-rpmhpd-v2-0-b4aa37acb065@fairphone.com>
 <20250707-sm7635-rpmhpd-v2-1-b4aa37acb065@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250707-sm7635-rpmhpd-v2-1-b4aa37acb065@fairphone.com>

On Mon, Jul 07, 2025 at 12:18:10PM +0200, Luca Weiss wrote:
> Document the RPMh Power Domains on the Milos (e.g. SM7635) Platform.

s/Platform/SoC/

otherwise it is ambiguous - platform as a board, platform
as a family or platform as a SoC sub arch (which usually we call
platform in kernel docs, see maintainers soc profile).

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


