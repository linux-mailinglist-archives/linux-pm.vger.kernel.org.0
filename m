Return-Path: <linux-pm+bounces-40365-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3A2CFDBAE
	for <lists+linux-pm@lfdr.de>; Wed, 07 Jan 2026 13:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2B11303164C
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jan 2026 12:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED9E329E7B;
	Wed,  7 Jan 2026 12:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXqYrhcc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78E9329E6F;
	Wed,  7 Jan 2026 12:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767789474; cv=none; b=MQR5ATq+5HtthK5tkb/t0VUvtlJl6Bi28GAj1GuOlO7W3rIfsTSGz0xAO4mb8Dy+B4q1Wzg6ZTZq8Ilcagk1IxD00RbV/VPhEC3v2b++xOsMo6ij4vZ+tny7XSVZCrML82uHnXK8xw9qZcXultYRnRjltJThTv3lDKS+3ZSRWf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767789474; c=relaxed/simple;
	bh=SSxdlXBDbRphoLQNWCYCgGFLbgHh+3HKYPtQc2L4wmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gq7idJdzcZSVmChrr0BGIrtnUNfoR5sRyFeifcbKLXkk9rUG2S2T2NsS/IYthDMaEh41mByQYNkYIKdu3owpv/jMK3ytpPZLTSNmxJ1G2jeGt2KCf2aXSxHRI5TQOkNv69HxecGimjfXIAKVN1eDAd1qtlTv01u+59rt6SAKkzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXqYrhcc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E39C16AAE;
	Wed,  7 Jan 2026 12:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767789473;
	bh=SSxdlXBDbRphoLQNWCYCgGFLbgHh+3HKYPtQc2L4wmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oXqYrhccgF/RvvTd9//5eSL5owPyT+ORoVztYCdhV4ICR9XzbGZ+ar0eGI55nkg9y
	 tzD7P5f+s0Yw4hgGXjSbYukDtuhwk3Jl4Td+MkJxV78W5VA3tkQ9Yeswmz05C4lmi7
	 1nHztxmamSWjJm8WI9W3oBxbV3G0QfChF9cEJVf5pVpKWnJzRrAubPJL8ctea7Iljh
	 sZ9Xw89BRIgD4/boMr7dOFu0CkZxm0g1QrAUvKW02TuPKzD4nfjXEdy7emdxxwpwoD
	 hJILI6ejjw8j74aqg2Dm+w544YYPl6Yqg+IR6IUQBdEvlb1mlAsvYAWcAy3ko9Iiwe
	 +2VyWDJmz1R1A==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Brian Norris <briannorris@chromium.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>, netdev@vger.kernel.org,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Simon Horman <horms@kernel.org>
Subject: [RESEND][PATCH v2 0/3] net: Discard pm_runtime_put() return value
Date: Wed, 07 Jan 2026 13:31:03 +0100
Message-ID: <2816529.mvXUDI8C0e@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <6245770.lOV4Wx5bFT@rafael.j.wysocki>
References: <6245770.lOV4Wx5bFT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Hi All,

This is a resend of

https://lore.kernel.org/linux-pm/5973090.DvuYhMxLoT@rafael.j.wysocki/

which mostly was a resend of patches [10-12/23] from:

https://lore.kernel.org/linux-pm/6245770.lOV4Wx5bFT@rafael.j.wysocki/

as requested by Jakub, except for the last patch that has been fixed
while at it and so the version has been bumped up.

The patches are independent of each other and they are all requisite
for converting pm_runtime_put() into a void function.

Thanks!




