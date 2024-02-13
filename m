Return-Path: <linux-pm+bounces-3849-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFF98526DB
	for <lists+linux-pm@lfdr.de>; Tue, 13 Feb 2024 02:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 904391C246F8
	for <lists+linux-pm@lfdr.de>; Tue, 13 Feb 2024 01:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DACB286A6;
	Tue, 13 Feb 2024 01:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUPhreWH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360007AE49;
	Tue, 13 Feb 2024 01:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707786422; cv=none; b=l2pAkGcOOb19990X/FyLl8zDD+g0ESi5SfhO9giBgq3kXrIIEHvW7OYB0/deSDdMT32a12/dixspq7C7jibEdxuRnWOysRZCEEL2deKeuwBDgWtsvIxrNw7IYpaWPHeyMR6nWGqZwouudHQImwwXofHsYEbQZ53MHAbIJHw6S08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707786422; c=relaxed/simple;
	bh=yiRjXWW9vRy8oSt2OY9bdE1LF4uXuy72w5FirZcXiWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d3+D0zLKxoe8CDjySdtUley40Er/EXTfpHoFQ2iPSGk6mUR9/Fhb86GUHIESlVusocXfOdUszHElwX9dkvKIKHnvM4STub5OrP5Egp/mjF6i8D3BgPnDv3iARJ3823B4GNApbszIGUoy/NY43pBLlxZRg3HtPWHye0/wrzZDy5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUPhreWH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538FDC433F1;
	Tue, 13 Feb 2024 01:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707786421;
	bh=yiRjXWW9vRy8oSt2OY9bdE1LF4uXuy72w5FirZcXiWQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lUPhreWHveOFJzchwqyfcv++UOsX7plGbmLF+WVZf9oNBAqWh9YCNx+7dleUmWDcH
	 UH3AIcmOxwP8nDKZ2PBbVutfPQ/ms3dQhMhSaH91uM+fWKsrqzTW2qsPv/E3F9mSEE
	 Xsukyr6Zg5nfmmQ/25ML5WFZElcSuYcivNxys2ESwhjac+JZ4FBpKds60Y+MZl3SfR
	 NG3Wqjr6XFKmQtGcA9GZEwDMjE6dU4Nq1zFjMy/i8cLgVrcEk5FXghgTNdFjY450Bs
	 yB7KDndZv6c3XZ7SQukkSm1noEKw+NOEik0LsPhA1nJNyt11/4EmpZjv8Qti0ugKNu
	 lNjUMQEmgYScQ==
Date: Mon, 12 Feb 2024 17:07:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Ricardo Neri
 <ricardo.neri-calderon@linux.intel.com>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko
 <jiri@resnulli.us>, Johannes Berg <johannes@sipsolutions.net>, Florian
 Westphal <fw@strlen.de>, netdev@vger.kernel.org
Subject: Re: [PATCH v4 1/3] genetlink: Add per family bind/unbind callbacks
Message-ID: <20240212170700.4eda9c03@kernel.org>
In-Reply-To: <20240212161615.161935-2-stanislaw.gruszka@linux.intel.com>
References: <20240212161615.161935-1-stanislaw.gruszka@linux.intel.com>
	<20240212161615.161935-2-stanislaw.gruszka@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Feb 2024 17:16:13 +0100 Stanislaw Gruszka wrote:
> Add genetlink family bind()/unbind() callbacks when adding/removing
> multicast group to/from netlink client socket via setsockopt() or
> bind() syscall.
> 
> They can be used to track if consumers of netlink multicast messages
> emerge or disappear. Thus, a client implementing callbacks, can now
> send events only when there are active consumers, preventing unnecessary
> work when none exist.
> 
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>

LGTM! genetlink code is a bit hot lately, to avoid any conflicts can
I put the first patch (or all of them) on a shared branch for both
netdev and PM to pull in? Once the other two patches are reviewed,
obviously.

