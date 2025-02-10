Return-Path: <linux-pm+bounces-21716-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61074A2F48E
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 18:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23B28188339B
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 17:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC15016EB7C;
	Mon, 10 Feb 2025 17:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OqyjN72n"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CA1256C98;
	Mon, 10 Feb 2025 17:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739207023; cv=none; b=p882Dqpk1yUdEIzd8B6VOjIJhf0UARfS7DQUaUMCN28clS2OIhxfQk9dBkodvh9I4RhnbgfpFSxTs3Hzmu7BYgQTk3kw9QrsLik/44ej13XDZiFA8BAYKxbFBKK88SqkC8tZ7zEZUVnEl/Gy9nGQN8MpKgU9oG7p+nfgIKGeHV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739207023; c=relaxed/simple;
	bh=iVvbp5R9zaKcBDnKZNg70lQ2ednSs8Akic8k6kRGPko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KK7OLD4WJ/3zNjgEGeSANf29C21NGfEqdQRgTu9O65IH/HlWzUvK+DmSL05LEtUZG8+NAKKKEJ65uzL5sECAO82mvf+8g/DVXf1LVTZ9WhFjfZMGKR+xuO9aW50eLTNWNPbRXpQ4cqs730una/IRwMzkrH2Kw/Xm9g87hY9BIcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OqyjN72n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AFA5C4CED1;
	Mon, 10 Feb 2025 17:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739207023;
	bh=iVvbp5R9zaKcBDnKZNg70lQ2ednSs8Akic8k6kRGPko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OqyjN72nrcnYbi9ScixNUWAuATL97nCR6anUGjoB7SeNwMlK3OPEWRggnQO29jQlM
	 FfNI4vNfm4j7lZ9yhmREylOI8+VhfklD6abGsAUu1OqlXJ4DA5oPynXwjTHfdoqRKD
	 U2FM4HcBafptDidoV9hTszuogYxibtbwUxN38PaS4zu/UKnrs/312g00/+y1buNVbH
	 xx6/Nm/5s1r+/P8wurec+2DKgF5PKu+vtfSDiYIgWPOrbTg7VudGE4IeZODX0n/tLJ
	 9q7RMDplTZNNL3zB8V5OooqgnGe5i46oMXXeKjF9pwZlyDYCSQsnpSJMWXnWw5uLV9
	 a8GDpOp17ledA==
Date: Mon, 10 Feb 2025 17:03:37 +0000
From: Lee Jones <lee@kernel.org>
To: Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pavel Machek <pavel@ucw.cz>, Hans de Goede <hdegoede@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Purism Kernel Team <kernel@puri.sm>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v17 3/7] power: supply: max77705: Add charger driver for
 Maxim 77705
Message-ID: <20250210170337.GE1868108@google.com>
References: <20250123-starqltechn_integration_upstream-v17-0-8b06685b6612@gmail.com>
 <20250123-starqltechn_integration_upstream-v17-3-8b06685b6612@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250123-starqltechn_integration_upstream-v17-3-8b06685b6612@gmail.com>

On Thu, 23 Jan 2025, Dzmitry Sankouski wrote:

> Add driver for Maxim 77705 switch-mode charger.
> It providing power supply class information to userspace.
> 
> The driver is configured through DTS (battery and system related
> settings).
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>

Still needs an Ack from Sebastian.

-- 
Lee Jones [李琼斯]

