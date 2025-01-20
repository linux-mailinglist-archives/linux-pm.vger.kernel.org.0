Return-Path: <linux-pm+bounces-20672-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D49A1671E
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 08:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 830C41642A9
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 07:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8751118E743;
	Mon, 20 Jan 2025 07:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmg5o6u0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5197618B499;
	Mon, 20 Jan 2025 07:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737357183; cv=none; b=mGMu5A0XUx9XyFdNTnHbUtTtB2QKnhnhh5TEwafUnGFmPDYr8/bcPLRn8+OEDyfK/DGf1IRH71JgDVcCyMw1PkQkCKV/mDqk0X1E00r9JfNcTZQytrIk6vbU/BK4EXf6pgH2AhD44c5Zev88ppif3mBqbqe8l3hWL/a4xMlAVZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737357183; c=relaxed/simple;
	bh=UO4G32EjgT/UexNzd0Sr3K2PK3BebkXSPvKW+lJVkzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nc5U99aQMxkPi8HVApP67liZNvkduQJcQ3HEmMLhdHzWWtHjQQlHXvVyIY5TPahfUNp7S9vnNZ1QR+1Jtxay0YNYrbL3kthZ9VFcazO/4k1G2pxkdHVSr4CBUciBEtis2GJsyRD7ayW+EH63HeSBvRfVJjs482mdNuNPdCuNTgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmg5o6u0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C70EC4CEDD;
	Mon, 20 Jan 2025 07:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737357182;
	bh=UO4G32EjgT/UexNzd0Sr3K2PK3BebkXSPvKW+lJVkzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gmg5o6u0vNrnoszv022cVXrvjFBPObTkQN+BnE+0vMEEZRf3GxcIbp2GW4aKvVkDX
	 cF6PPi9fO1ljmjJMwlpDX9srhayfXT/VfMQsz2LhfZHdL+/hQn13srO5wH4lV4+dKL
	 YJm2sST5IGUm/kcm57Lzd5HCismlPKMfEq8OPEX4lLpgbEetWLMZyoYpsWxKsyfZxO
	 KaLdI7qrN1eox3ve4OrIgtguHlaNwAwP45Q6DZIZKpe2RpE6Fl53H0zgw9KR5Wk22G
	 kp89EoILbwISLtuWIJsEa/MLFVmBPrUyCuN1kQqJi5ibVm/L0n1frbyxIGDraV2fe8
	 KV2eMnm3ayxAQ==
Date: Mon, 20 Jan 2025 07:12:56 +0000
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
Subject: Re: [PATCH v2 11/12] thermal: core: allow user configuration of
 hardware protection action
Message-ID: <Z433eMTJvHy1JlpB@google.com>
References: <20250113-hw_protection-reboot-v2-0-161d3fc734f0@pengutronix.de>
 <20250113-hw_protection-reboot-v2-11-161d3fc734f0@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113-hw_protection-reboot-v2-11-161d3fc734f0@pengutronix.de>

On Mon, Jan 13, 2025 at 05:25:36PM +0100, Ahmad Fatoum wrote:
> In the general case, we don't know which of system shutdown or
> reboot is the better action to take to protect hardware in an emergency
> situation. We thus allow the policy to come from the device-tree in the
> form of an optional critical-action OF property, but so far there was no
> way for the end user to configure this.
> 
> With recent addition of the hw_protection parameter, the user can now
> choose a default action for the case, where the driver isn't fully sure
> what's the better course of action.
> 
> Let's make use of this by passing HWPROT_ACT_DEFAULT in absence of the
> critical-action OF property.
> 
> As HWPROT_ACT_DEFAULT is shutdown by default, this introduces no
> functional change for users, unless they start using the new parameter.
> 
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

