Return-Path: <linux-pm+bounces-15294-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABFA9937F1
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 22:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5133283DBF
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 20:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50591DE4C9;
	Mon,  7 Oct 2024 20:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NM+xKt86"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEE21DE3C5;
	Mon,  7 Oct 2024 20:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728331662; cv=none; b=d5VebbWgFj+k0JurTl5/Z03Afgrf7ixCaIpfM0YbjE67Zt8ZmKLJzxUKfNLKNK7hCqnr9fCz2ugnPP5PiI+VDm7uA3ZoTfZNPUE6HFK2eQlLWabEPrfE3GcsnAkxxdMDVTx29UVtflwSAvqPnYh+Y0loeUk9b8i5fYeaK0rMk1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728331662; c=relaxed/simple;
	bh=BxLDkE25VPOwCrsCvshNOC404xDqaWO7nzcWZR1O3so=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+1gysEP1XlM4mKOEHUxdP8DV6GVuKJyvCd/vH/fnoYzyhqLLoWmjAPZyowHXh7EVyQaaI4u9jEYpUfIXbLOrIzp7opJ1QsAf7+iraeS7bh6x6QAicZ8g9DPDUsR5cMRLHhpJxExfB4YcXgpbDoQFfYTkY4T3kWzsyKe4KjKmrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NM+xKt86; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09855C4CEC6;
	Mon,  7 Oct 2024 20:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728331662;
	bh=BxLDkE25VPOwCrsCvshNOC404xDqaWO7nzcWZR1O3so=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NM+xKt86wT/VjQBK3wc0ZgaUUaALWTVCDkajoZh7vpelgFeLiqb5iFhcbFuIy9NUa
	 QrPhih3W/hxBpQttV8eu/XAEOD83Lx9vhxWn0/C6Qbbbi4ahVCXuCN6q0pPW8XCeRC
	 RGaxW2c3fKYVWPIUyiWI7aDI9OXSCMmpdKhFKqnYM7/Hi0Ygl+EFqryaTmLtrkUP+N
	 CSb08v1l3OaoW95IyEp76YMb8FyogpJVEFmyFxXrYFcJo4qvMZfIwDnpJcm5WTei8n
	 Au7r962G4kpcFc6h7Ji/lRkifYzRoehZoPx859ZRHHI5IcFC6RtI88C3WJhCN0DZm3
	 LVlF9LIid1PMw==
Date: Mon, 7 Oct 2024 15:07:41 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Sebastian Reichel <sre@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-leds@vger.kernel.org,
	Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
	linux-pm@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v6 2/7] dt-bindings: mfd: add maxim,max77705
Message-ID: <172833166069.2315774.14681195967266298858.robh@kernel.org>
References: <20241007-starqltechn_integration_upstream-v6-0-0d38b5090c57@gmail.com>
 <20241007-starqltechn_integration_upstream-v6-2-0d38b5090c57@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007-starqltechn_integration_upstream-v6-2-0d38b5090c57@gmail.com>


On Mon, 07 Oct 2024 18:55:50 +0300, Dzmitry Sankouski wrote:
> Add maxim,max77705 core binding part.
> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> 
> ---
> Changes in v6:
> - unevaluatedProperties must be false
> - drop excessive sentence from description,
>   just describe the device
> 
> Changes in v5:
> - formatting changes
> - add unevaluatedProperties: false for nodes referencing
>   common schemas
> - remove additionalProperties on nodes with
>   unevaluatedProperties: false
> - add min and max to led index
> Changes in v4:
> - change dts example intendation from tabs
>  to spaces
> - remove interrupt-names property
> - remove obvious reg description
> - split long(>80) lines
> ---
>  Documentation/devicetree/bindings/mfd/maxim,max77705.yaml | 174 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  MAINTAINERS                                               |   1 +
>  2 files changed, 175 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


