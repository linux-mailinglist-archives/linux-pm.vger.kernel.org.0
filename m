Return-Path: <linux-pm+bounces-20668-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D93BCA16708
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 08:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18E6E3AB1A9
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 07:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A400618E03A;
	Mon, 20 Jan 2025 07:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmiS39Vn"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D56E145A18;
	Mon, 20 Jan 2025 07:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737357115; cv=none; b=VWF3V3AzKLEHXS1fQL8VBj8J7/VvmefNtQb+ZMcBa3QXBYC0VF5tBlYzm/yu24ivL+8ooZ2m/scPo3KR0DBS7ZYcseF7UjvuUjc5JBfAxkq4qR6U02LEXgn6CGkv1SELK9qWe2DCXIWDeszqBkskJLxbtwogtdzfh7Lt3GgjRnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737357115; c=relaxed/simple;
	bh=CYmVzP7C4vZmFNlB+K3Hmwu9dTRXeieNJKzxPQYjHIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r1UaM06Uv6JBKirzq7wxdVS/490rPPqzq3lAxbYMRm3pw5e0f1s4jhhHLiqlj7Uj5E5GPf4ORSeWk3ZUJAKQVudu/kluT2gIRuBLarLvrDLf1kZB88tkfPXJIVdcVRHyP6PxUb29LT7fyATzCLOzVi1m7StLz/bdY7eL4O3UVGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmiS39Vn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E95CC4CEDD;
	Mon, 20 Jan 2025 07:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737357114;
	bh=CYmVzP7C4vZmFNlB+K3Hmwu9dTRXeieNJKzxPQYjHIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jmiS39VnUEpA/ga4aMdlihd6sWavlVlL4ikVuRg6p5YfWO8HEHZintB7r+3APZVDd
	 vz2yXN3GfufEZFlFJGqxuzBqRRW+3VFAbRryEeZRookiDNfdL9VMLFDR4UVWPzzxqp
	 3n0vPmepYOwp7ndd9vrUXjjmd+0A7A8uurlMKUPd4sIGqbU0j/pAxPoxBBWvD9h32f
	 oYArr9EZEtVPqYiRIbf9Ehs2YNxeef87qPfc+GncnLgk7CymRewnUPmbLU/vSfLxO5
	 WBMnxGx/AikKp2A4eAuzvo9kno36jHsUBk4dTFI3sOM7+pRlf9jk7jpXm5D4Pm00VP
	 8hbyUWN0kuIww==
Date: Mon, 20 Jan 2025 07:11:48 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Fabio Estevam <festevam@denx.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Jonathan Corbet <corbet@lwn.net>, Serge Hallyn <serge@hallyn.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	chrome-platform@lists.linux.dev, devicetree@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH v2 06/12] reboot: indicate whether it is a HARDWARE
 PROTECTION reboot or shutdown
Message-ID: <Z433ND-LvkGo2se2@google.com>
References: <20250113-hw_protection-reboot-v2-0-161d3fc734f0@pengutronix.de>
 <20250113-hw_protection-reboot-v2-6-161d3fc734f0@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113-hw_protection-reboot-v2-6-161d3fc734f0@pengutronix.de>

On Mon, Jan 13, 2025 at 05:25:31PM +0100, Ahmad Fatoum wrote:
> It currently depends on the caller, whether we attempt a hardware
> protection shutdown (poweroff) or a reboot. A follow-up commit will make
> this partially user-configurable, so it's a good idea to have the
> emergency message clearly state whether the kernel is going for a reboot
> or a shutdown.
> 
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

