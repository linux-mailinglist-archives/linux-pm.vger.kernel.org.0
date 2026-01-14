Return-Path: <linux-pm+bounces-40884-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0456CD2118D
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 20:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EB61D3015ADB
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 19:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678E3352C2D;
	Wed, 14 Jan 2026 19:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jibrqmVA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4485A34D911;
	Wed, 14 Jan 2026 19:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768420140; cv=none; b=Ct+BGCeKuwIn/m+ybRw38rbXBDLv2vTefcE4Y27SQSQNinwZCSMNweTQCkPdcei2gQIHuprD2X10GodLicNS66fX61gRvDNQU8g5TZO90faMWLtsH1Tt/wlISnY32AHwBM+X1IspWiaImimC5VPGSP8TrXFM22gD6xXevU1Ks48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768420140; c=relaxed/simple;
	bh=tp23sPobZL67a+lYGtr7uSviXFwlADBrQjQ9Yo2xg6k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CY0loAS6InrsDvzytzsIgpUGQmTYO8XxalJO3CVL4If8X5fdf2Mwau//Y+YfcA0bZHSuhoDOrtn3y9agGS36qWJapfbQAcN2wtjZ/CRE031gn5H/93nPlGiX0unKkeEJ1JCezu/QVBCcjb94kmPZXt1tenNAxO0HZl1Jy+X3UYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jibrqmVA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90589C19422;
	Wed, 14 Jan 2026 19:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768420139;
	bh=tp23sPobZL67a+lYGtr7uSviXFwlADBrQjQ9Yo2xg6k=;
	h=From:To:Cc:Subject:Date:From;
	b=jibrqmVAfR7d8anhjuzbMe5jLG3c78gZsySsL6/d/kzZ80NFfRzcK4bVWRJC9dXIJ
	 Iay0aeLV/sOOzjE5uXl68d7jvYnSmmBtStx/t5ajPufO7dtirAOfpKaCrPSMTf70G3
	 h8IGz2MAr4sY4bezs7ZDqYQ0bqHqcKJwUMspuUJjDfki8R4qXTTbgH13w+QIMDDdP5
	 YaIIA/7U8NJ4vvBe6abIkgDWw9VbOlQITrXRfyW95ACAWndqjxYpg8utOcJ37i3JJA
	 Oh3FFORz6JnqNyjrngvQIC06kbqSJApbhINNwwbrpKXt6qkknf86MOQRY++DBXrb4U
	 b99EA1c1bpkRg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Doug Smythies <dsmythies@telus.net>
Subject:
 [PATCH v1 0/5] cpuidle: governors: teo: Wakeup events classification change
 and some refinements
Date: Wed, 14 Jan 2026 20:42:55 +0100
Message-ID: <2257365.irdbgypaU6@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Hi All,

This material has been in my local queue for almost a full development cycle,
so time to post it.

The motivation for the changes in this series is mostly theoretical, but I do
see some idle power improvements from patch [4/5], for example, but nothing
specifically worth reporting.

The first patch simply prevents idle states with zero-size bins from being
selected sometimes when teo_select() runs with stopped tick.

Patch [2/5] avoids counting tick wakeups as intercepts unless there are
sufficiently many intercepts within the tick period range to assume that
the tick wakeup may have clobbered a genuine intercept.

Patch [3/5] simply updates a coefficient in one of the inequalities to be
somewhat easier to interpret (this should be a cosmetic change).

Patch [4/5] changes the criteria used for classifying wakeup events as hits
or intercepts to (hopefully) make the classification work better for large
state bins.

Patch [5/5] refines the idle state lookup based on intercepts to first
consider the state with the maximum intercepts metric, so that state is
always taken into consideration.

Please see the individual patch changelogs for details.

Thanks!




