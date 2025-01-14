Return-Path: <linux-pm+bounces-20392-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FF3A0FD65
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 01:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9572169B26
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 00:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115143FC2;
	Tue, 14 Jan 2025 00:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ljBxiGVv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E373594A;
	Tue, 14 Jan 2025 00:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736814783; cv=none; b=mem9lmq+tWJVWHuovvH5wUxqUbi0ImUCAGnoI4++C88RujHZe2qm9GiAWhVcCXYQ6EsdSwfBufvGrIT1aqbTqVCKWRBHsOMZgsx3V1bVw+sF2ZIHyVaB/KpeUt54sXH0GV9sex4CiQ6Fa05bui3iCGlELRqnAWT/wJ9nrUrTdb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736814783; c=relaxed/simple;
	bh=Dc4HoTEpMuIQqxN+yb0S9m9HX99LLQVjCKWKk5kwv+s=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CgilEIb02e0Star39zvnAVhkRCS5g0+IszdG3ofC24E9L4D1iQQHFnraJ+g4yJpp9iqhn5Jp5ceQERoZZKJpc8uExZIv5rSe5Fl291gfosl1PxRf+2zgAyDtbX7F+YZAxvEWhC9hwsvoTtSoIaf+udx7LoverjS1oYMyYmqG3a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ljBxiGVv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4902DC4CED6;
	Tue, 14 Jan 2025 00:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1736814782;
	bh=Dc4HoTEpMuIQqxN+yb0S9m9HX99LLQVjCKWKk5kwv+s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ljBxiGVv/Vn72sT9smo/jB0vLdthB/Y3AxhqWw8vFy3s0v5OM70ANCXF8EK9+cKEJ
	 vMNAPTF7Lv/g4sdyYPEKkCXDG+r5SVZrXWdXN9cMDr7IqBA7XU+xYFnZLHOSMVaNtp
	 TCeDnAiXIIVLH6xbi5oX2nSl4aPvTB7bNz1IV8Bs=
Date: Mon, 13 Jan 2025 16:33:00 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Fabio Estevam
 <festevam@denx.de>, "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui
 <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Jonathan Corbet
 <corbet@lwn.net>, Serge Hallyn <serge@hallyn.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Matti Vaittinen
 <mazziesaccount@gmail.com>, Benson Leung <bleung@chromium.org>, Tzung-Bi
 Shih <tzungbi@kernel.org>, Guenter Roeck <groeck@chromium.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-security-module@vger.kernel.org, chrome-platform@lists.linux.dev,
 devicetree@vger.kernel.org, kernel@pengutronix.de, Matteo Croce
 <mcroce@microsoft.com>
Subject: Re: [PATCH v2 00/12] reboot: support runtime configuration of
 emergency hw_protection action
Message-Id: <20250113163300.4dce8816af9d448b6e263140@linux-foundation.org>
In-Reply-To: <20250113-hw_protection-reboot-v2-0-161d3fc734f0@pengutronix.de>
References: <20250113-hw_protection-reboot-v2-0-161d3fc734f0@pengutronix.de>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Jan 2025 17:25:25 +0100 Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:

> We currently leave the decision of whether to shutdown or reboot to
> protect hardware in an emergency situation to the individual drivers.
> 
> This works out in some cases, where the driver detecting the critical
> failure has inside knowledge: It binds to the system management controller
> for example or is guided by hardware description that defines what to do.
> 
> This is inadequate in the general case though as a driver reporting e.g.
> an imminent power failure can't know whether a shutdown or a reboot would
> be more appropriate for a given hardware platform.
> 
> To address this, this series adds a hw_protection kernel parameter and
> sysfs toggle that can be used to change the action from the shutdown
> default to reboot. A new hw_protection_trigger API then makes use of
> this default action.
> 
> My particular use case is unattended embedded systems that don't
> have support for shutdown and that power on automatically when power is
> supplied:
> 
>   - A brief power cycle gets detected by the driver
>   - The kernel powers down the system and SoC goes into shutdown mode
>   - Power is restored
>   - The system remains oblivious to the restored power
>   - System needs to be manually power cycled for a duration long enough
>     to drain the capacitors
> 
> With this series, such systems can configure the kernel with
> hw_protection=reboot to have the boot firmware worry about critical
> conditions.

This seems useful.

>  Documentation/ABI/testing/sysfs-kernel-reboot      |   8 ++
>  Documentation/admin-guide/kernel-parameters.txt    |   6 +
>  .../devicetree/bindings/thermal/thermal-zones.yaml |   5 +-
>  Documentation/driver-api/thermal/sysfs-api.rst     |  25 ++--
>  drivers/platform/chrome/cros_ec_lpc.c              |   2 +-
>  drivers/regulator/core.c                           |   4 +-
>  drivers/regulator/irq_helpers.c                    |  16 +--
>  drivers/thermal/thermal_core.c                     |  17 +--
>  drivers/thermal/thermal_core.h                     |   1 +
>  drivers/thermal/thermal_of.c                       |   7 +-
>  include/linux/reboot.h                             |  36 ++++--
>  include/uapi/linux/capability.h                    |   1 +
>  kernel/reboot.c                                    | 140 ++++++++++++++++-----
>  13 files changed, 195 insertions(+), 73 deletions(-)

I'm not sure what the merge path is.  Maybe the drivers tree, maybe
mm.git's mm-nonmm branches.

We're at -rc7 so I'll save this away and shall revisit after -rc1 with
a view to gathering acks (please) and adding the series to mm-nonmm, thanks.

