Return-Path: <linux-pm+bounces-20671-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB8BA16717
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 08:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91EE43A25B0
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 07:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A618A18E050;
	Mon, 20 Jan 2025 07:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jlr5gqBh"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7001E145A18;
	Mon, 20 Jan 2025 07:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737357168; cv=none; b=nkYRyTdiFm+qBgiqQ83bmNKVMKSXN72G4Unxvtpkyw5LdDZevi+6k9U/7Vppq88Hu2B/ZLeuWpZRx7admZ0uQDuVFHm4ucSFC18AjA8og+Fb6b+N61IK9y7mnrmkOYOdkWiPyOCg132Zz7TgtUBS4m/pCAnnnLvLbY3Ad6x7Tu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737357168; c=relaxed/simple;
	bh=6L242JdL3R+3UW1TjFijzpluk+ULCIhTMfosffkxXqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+QGT/HQ8EqRFr2JvuZfCEokWrqbVdE8i/049q+hKD0ePlxZM5EmkaKKMAMOqdksezyKE3tBdmuef1UIwv7ZwgXC9xyOhs0pIiLE/Aet4hREgg64h8RRkkd/NuFll7v+a24BhwVngRu/c59FDhhNSaRPxQABnxYqtqLrRN4Q0hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jlr5gqBh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1416C4CEDD;
	Mon, 20 Jan 2025 07:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737357168;
	bh=6L242JdL3R+3UW1TjFijzpluk+ULCIhTMfosffkxXqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jlr5gqBhQ4AsoZq5p+p80/zefksblLc7pz5OWERx1jLCOCw/iAv0aLPL1gfSl0cf/
	 opvc3ygxyxtBTBswO/koS1khR8E4RtWlLjTq4lfIyL2SHpw50WGM8DeLUSq7HcATHZ
	 05z5culFT+IlmO0BbOsmcr44vo/6h/JRoh0ISz7Kyv3xFLeZLg26D30EsZvO/LxOQm
	 K4rldMP59akgLOj1lh3/vsTAUUBVavUGGTrilF8pRrYC+t4CWqP+aOBInpG7ELJ+Gu
	 P3hgXzxNUkpx77vbDn7SUA3hIFthdeQLjGH55bjfyrFQ1hdDIiRph171F48/cWsnok
	 gpieyulZEcuJA==
Date: Mon, 20 Jan 2025 07:12:41 +0000
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
Subject: Re: [PATCH v2 09/12] platform/chrome: cros_ec_lpc: prepare for
 hw_protection_shutdown removal
Message-ID: <Z433aYZ1JB_t5jrb@google.com>
References: <20250113-hw_protection-reboot-v2-0-161d3fc734f0@pengutronix.de>
 <20250113-hw_protection-reboot-v2-9-161d3fc734f0@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113-hw_protection-reboot-v2-9-161d3fc734f0@pengutronix.de>

On Mon, Jan 13, 2025 at 05:25:34PM +0100, Ahmad Fatoum wrote:
> In the general case, a driver doesn't know which of system shutdown or
> reboot is the better action to take to protect hardware in an emergency
> situation. For this reason, hw_protection_shutdown is going to be
> removed in favor of hw_protection_trigger, which defaults to shutdown,
> but may be configured at kernel runtime to be a reboot instead.
> 
> The ChromeOS EC situation is different as we do know that shutdown is
> the correct action as the EC is programmed to force reset after the
> short period, thus replace hw_protection_shutdown with
> __hw_protection_trigger with HWPROT_ACT_SHUTDOWN as argument to
> maintain the same behavior.
> 
> No functional change.
> 
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

Acked-by: Tzung-Bi Shih <tzungbi@kernel.org>

