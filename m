Return-Path: <linux-pm+bounces-40145-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 45316CEF803
	for <lists+linux-pm@lfdr.de>; Sat, 03 Jan 2026 00:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0787D3007654
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jan 2026 23:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583862C0278;
	Fri,  2 Jan 2026 23:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8fxSun7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275592BE641;
	Fri,  2 Jan 2026 23:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767398019; cv=none; b=Y51hT9+Xc66Kxe3TaMrhfCDafpHAmA4vmzE0g9wznjY651UY6szfDms3E8BzTFzTKLrccKWxa/uVvaeHzlUvvnHe9S+CoxoyXHFnaqat780HdYLV6V/BlO5F/yvTg8dNpLy6T43NtN3J/Yh08YjHXzPVVlPpHXBFWI5YtubtJZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767398019; c=relaxed/simple;
	bh=PXwVS6BFpdChH2EkTuYmNLoBcUP2SFim4SNDnPpmGW8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jaxyyzimkDKw/ZOU2MkEpOz5Fn2nswO7y8lKA4VwuoKYNmuSiEGTziF3OuvdzKIJ2ARSoG+omwWrYYspNBt3TKFzEDR4Z1dnls4+A7Qcq+kYNxhB+Efl4rlC7inlAbXgB0oT0UB8QKaCeE/hHRMHenyFzyhsBl76TOjOF6VHQRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o8fxSun7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A24BC16AAE;
	Fri,  2 Jan 2026 23:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767398018;
	bh=PXwVS6BFpdChH2EkTuYmNLoBcUP2SFim4SNDnPpmGW8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o8fxSun7OjDwfjhUmyNPZr9rh/iuWZdyWFcpfHpOVVIYBZqSEBucWJl+ed49kSAU+
	 6kijnwOt1ErJaGup4ujqdyJ8WiFF4iBO+9PmfAZ8h1I22Wqs6exmZd0WwsxnLu0npr
	 ND3bux1xTL8cclf8JYQy1rTFCBK1AhrcsqJO0JV1z3p2zHashDzWKa91S5Ni8Vd7I+
	 8K02wUOffRWHuGZ/6g3xGJL83mqedutltvchx4ovqyauhTnCo2MtARDu504tgrhvNN
	 gsgUCpk7INryxiGJC131vdmF2P18onFHhEPpbq9a/l84LGC/7TQJYJcz1hMV773wMY
	 /FbrEbOecCpNw==
Date: Fri, 2 Jan 2026 15:53:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Brian
 Norris <briannorris@chromium.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>,
 netdev@vger.kernel.org
Subject: Re: [PATCH v1 10/23] net: ethernet: ti: am65-cpsw: Discard
 pm_runtime_put() return value
Message-ID: <20260102155337.2bab8b90@kernel.org>
In-Reply-To: <3608967.QJadu78ljV@rafael.j.wysocki>
References: <6245770.lOV4Wx5bFT@rafael.j.wysocki>
	<3608967.QJadu78ljV@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Dec 2025 21:11:42 +0100 Rafael J. Wysocki wrote:
> This patch is part of a series, but it doesn't depend on anything else
> in that series.  The last patch in the series depends on it.

Would you mind reposting patches 10, 11, 12 of the series as a single
set? If we get CCed only on a subset of the series PW assumes the rest
got eaten by email goblins and our CI doesn't process any of them.

