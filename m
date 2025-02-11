Return-Path: <linux-pm+bounces-21904-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 243D4A317A2
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 22:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D454A3A4342
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 21:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47EF26868E;
	Tue, 11 Feb 2025 21:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="c/sF42oi"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E09F262803;
	Tue, 11 Feb 2025 21:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739309157; cv=none; b=i7bxUBpIhjHwTRGn2fsnBUc9i7/9XnRW2s9S0fQqjmiXjVO5uJSbmRTRakwWtU+g36SV8St2SRPMayQcggCwSF50t4DUb2wCYQ54tUaL3juqHPjx1w7ec8yt8mo6D+mhtYE8gSH/w1PTE7Tja1Bi8AJwGHpRFUarIhCzAf5X4dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739309157; c=relaxed/simple;
	bh=IZxrj6Gu0pIXpywIgOSybDUHKnFS0Y4eMhTg3+5V+js=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D1XZ9NEPr2rJ1wQR31naftQwtm4pRw9TxVKGmVklylyEJeuuxhY7WWIWtlYPpezshhvWWwHSsvkFLyBDxpwMbxfG7CwAaKLX8x0YHq5pbRqcBqA7GHuZqgUOZ8apSHY6XtI+nRKHSinfO90bnuQk/8D1jNEtjMFFiNfDQ58kMgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=c/sF42oi; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id cbb5aeea9cca1d0b; Tue, 11 Feb 2025 22:25:53 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id F20D3770175;
	Tue, 11 Feb 2025 22:25:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1739309153;
	bh=IZxrj6Gu0pIXpywIgOSybDUHKnFS0Y4eMhTg3+5V+js=;
	h=From:Subject:Date;
	b=c/sF42oid7G9JckXojZiUZzCaI7i9gYL/7L3Mjd3eQP45ZHvToVrSoLuNuHgw41n2
	 mxoajGMy/X5Rcq0mYGryz6Qna/dgG0Bt8T9NjlrBfGBBWNGwnmrULbOj5ONhRMBwX4
	 s288plxfAwTYj0CSZb+3v+FCdy3Gn19gW5o37Tp1Hmi8r7p4K+bhA7Gu3hKyTPzMFy
	 vFIqzK1c8IumlcnEEwz6IJkn+sYzmD3jjf8yUPHYyElOEL0/aBgj/uw3E2KYzfCrt7
	 wjNAzqeAD+7GQXkrBiudtf18bKPvFdF0xxSyJzx1rDbIkgStCGHDYUoX4425hWKG2x
	 hvo6GAyaTUMkw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>,
 Johan Hovold <johan@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Jon Hunter <jonathanh@nvidia.com>
Subject:
 [PATCH v1 00/10] PM: Make the core and pm_runtime_force_suspend/resume()
 agree more
Date: Tue, 11 Feb 2025 22:01:24 +0100
Message-ID: <2314745.iZASKD2KPV@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegvddtjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeegfffhudejlefhtdegffekteduhfethffhieettefhkeevgfdvgfefieekiefgheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthgvrhhnsehrohiflhgrnhgurdhhrghrvhgrrhgurdgvughupdhrtghpthhtohepuhhlfhdrhhgrnhhsshhonheslhhinhgrrhhordhorhhgpdhrtghpthhtohepjhhohhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

Hi Everyone,

This series is a result of the discussion on a recently reported issue
with device runtime PM status propagation during system resume and
the resulting patches:

https://lore.kernel.org/linux-pm/12619233.O9o76ZdvQC@rjwysocki.net/
https://lore.kernel.org/linux-pm/6137505.lOV4Wx5bFT@rjwysocki.net/

Overall, due to restrictions related to pm_runtime_force_suspend() and
pm_runtime_force_resume(), it was necessary to limit the RPM_ACTIVE
setting propagation to the parent of the first device in a dependency
chain that turned out to have to be resumed during system resume even
though it was runtime-suspended before system suspend.

Those restrictions are that (1) pm_runtime_force_suspend() attempts to
suspend devices that have never had runtime PM enabled if their runtime
PM status is currently RPM_ACTIVE and (2) pm_runtime_force_resume()
will skip device whose runtime PM status is currently RPM_ACTIVE.

The purpose of this series is to eliminate the above restrictions and
get pm_runtime_force_suspend() and pm_runtime_force_resume() to agree
more with what the core does.

First off, it turns out that detecting devices that have never had
runtime PM enabled is not really hard - it is sufficient to check
their power.last_status data when runtime PM is disabled.  If
power.last_status is RPM_INVALID at that point, runtime PM has never
been enabled for the given device, so patch [01/10] adds a helper
function for checking that.

Patch [02/10] makes the PM core use the new function to avoid setting
power.set_active for devices with no runtime PM support which really
is a fixup on top of

https://lore.kernel.org/linux-pm/6137505.lOV4Wx5bFT@rjwysocki.net/

Patch [03/10] modifies pm_runtime_force_suspend() to skip devices
with no runtime PM support with the help of the new function.

Next, patch [04/10] uses the observation that the runtime PM status
check in pm_runtime_force_resume() is redundant and drops that check.

Patch [05/10] removes the wakeirq enabling from the pm_runtime_force_resume()
error path because it is not really a good idea to enable wakeirqs during
system resume.

Patch [06/10] makes the PM core somewhat more consistent with
pm_runtime_force_suspend() and patch [07/10] prepares it for the subsequent
changes.

Patch [08/10] changes pm_runtime_force_resume() to handle the case in
which the runtime PM status of the device has been updated by the core to
RPM_ACTIVE after pm_runtime_force_suspend() left it in RPM_SUSPENDED.

Patch [09/10] restores the RPM_ACTIVE setting propagation to parents
and suppliers, but it takes exceptions into account (for example, devices
with no runtime PM support).

Finally, patch [10/10] adds a mechanism to discover cases in which runtime PM
is disabled for a device permanently even though it has been enabled for that
device at one point.

Please have a look and let me know if you see any problems.

Thanks!




