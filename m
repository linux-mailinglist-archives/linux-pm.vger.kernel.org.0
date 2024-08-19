Return-Path: <linux-pm+bounces-12461-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FA595700F
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 18:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90438283891
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 16:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3B1166F0D;
	Mon, 19 Aug 2024 16:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="unGGN8Eg"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF87139578;
	Mon, 19 Aug 2024 16:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724084371; cv=none; b=b8AEBmUafN6uDvIv+gdb8TO3p2GGonF8TcKjreWsTLaDXWr3G9/MiW1S3x/9Q2RuCjyGh4kipV0hZLzAqkfk+UXPBRuWot/L9gWVJcQDjWUx+1mUvzZxg8WqacEDMBrPBdlduJzgHlMf103fFySuU3BaE10jVi80f2CZOUKvah0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724084371; c=relaxed/simple;
	bh=3MFHfwfDzx2g6dRLRWIn0vyc3XxIR0akm9KhefoMg0o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bw/5mYKXuebT6C/nHAiksFaNMSEKEataHsI/h+UY3VSGKcRWegYlBcyTchFuJfeI1SCY+acvr95LegA3xhgDmJn1TOaQpqRLQAzIQN6W2Oq65LIpj3EAjZA2uHK0bfuIZrrTsMJsfwJzt/hRK02qmOlMa9+GBy5QQzK8LFFK/+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=unGGN8Eg reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 2934c9cd07d903aa; Mon, 19 Aug 2024 18:19:27 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 2EB9373B5D4;
	Mon, 19 Aug 2024 18:19:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1724084367;
	bh=3MFHfwfDzx2g6dRLRWIn0vyc3XxIR0akm9KhefoMg0o=;
	h=From:Subject:Date;
	b=unGGN8EgzNH/LntS9cZckoffhKCkhBhTbbUydpjfGfP2VnOMe6nkPj4cgsRfihwJU
	 8H1I9ldbcejuTR0aUjtxWD7S+53V4ojmgxkoRzJWe0TOtUhxiKcrc7XBXAxrKhJlpj
	 UvyFINdeIoP6sE1bS23AOnlXcuIrytUKPwKnhBwJIH/6SI/LUFD4MoLA4UIpy+MdrI
	 +73FdqUArfVkV0TUkTUkhGqrPNCQmfmAlBNYPFXe+8/ZcgwbPlktFAsE70KAShJ7wU
	 +8MtRATaLvw6CybX8OUjBLCkh9vHCGfV0pbLeLdJYp1P7AJ+LEvABC6J6noTGYEI3k
	 9JLpRb+Rok5BQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Subject:
 [PATCH v3 00/14] thermal: Rework binding cooling devices to trip points
Date: Mon, 19 Aug 2024 17:49:07 +0200
Message-ID: <2205737.irdbgypaU6@rjwysocki.net>
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
X-VADE-SPAMSTATE: spam:low
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddruddugedguddttdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegoufhprghmkfhpucdlfedttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeegfffhudejlefhtdegffekteduhfethffhieettefhkeevgfdvgfefieekiefgheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgv
 iigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=35 Fuz1=35 Fuz2=35

Hi Everyone,

This is one more update of

https://lore.kernel.org/linux-pm/3134863.CbtlEUcBR6@rjwysocki.net/#r

the cover letter of which was sent separately by mistake:

https://lore.kernel.org/linux-pm/CAJZ5v0jo5vh2uD5t4GqBnN0qukMBG_ty33PB=NiEqigqxzBcsw@mail.gmail.com/

and it has been updated once already:

https://lore.kernel.org/linux-pm/114901234.nniJfEyVGO@rjwysocki.net/

Relative to the v2 above it drops 3 patches, one because it was broken ([04/17
in the v2), and two more that would need to be rebased significantly, either
because of dropping the other broken patch or because of the recent Bang-bang
governor fixes:

https://lore.kernel.org/linux-pm/1903691.tdWV9SEqCh@rjwysocki.net/

The remaining 14 patches, 2 of which have been slightly rebased and the rest
is mostly unchanged (except for some very minor subject and changelog fixes),
is not expected to be controversial and are targeting 6.12, on top of the
current linux-next material.

The original motivation for this series quoted below has not changed:

 The code for binding cooling devices to trip points (and unbinding them from
 trip point) is one of the murkiest pieces of the thermal subsystem.  It is
 convoluted, bloated with unnecessary code doing questionable things, and it
 works backwards.

 The idea is to bind cooling devices to trip points in accordance with some
 information known to the thermal zone owner (thermal driver).  This information
 is not known to the thermal core when the thermal zone is registered, so the
 driver needs to be involved, but instead of just asking the driver whether
 or not the given cooling device should be bound to a given trip point, the
 thermal core expects the driver to carry out all of the binding process
 including calling functions specifically provided by the core for this
 purpose which is cumbersome and counter-intuitive.

 Because the driver has no information regarding the representation of the trip
 points at the core level, it is forced to walk them (and it has to avoid some
 locking traps while doing this), or it needs to make questionable assumptions
 regarding the ordering of the trips in the core.  There are drivers doing both
 these things.

The first 5 patches in the series are preliminary.

Patch [06/14] introduces a new .should_bind() callback for thermal zones and
patches [07,09-12/14] modifies drivers to use it instead of the .bind() and
.unbind() callbacks which allows them to be simplified quite a bit.

The other patches [08,13-14/14] get rid of code that becomes unused after the
previous changes and do some cleanups on top of that.

The entire series along with 2 patches on top of it (that were present in the
v2 of this set of patches) is available in the thermal-core-testing git branch:

https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log/?h=thermal-core-testing

(note that this branch is going to be rebased shortly on top of 6.11-rc4
and the thermal control material in linux-next).

Thanks!




