Return-Path: <linux-pm+bounces-33637-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C816B3FF6D
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 14:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31BD2189F8EE
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 12:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274352FA0ED;
	Tue,  2 Sep 2025 12:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D6dxhHir"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8D4286884;
	Tue,  2 Sep 2025 12:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756814465; cv=none; b=OLCWSE+R6vcQJtZuaAJnuDN1cdNUfa0MJIpU1uace/m1ldYLA3wMoUxpEjGQTir8CS1JKAzSmjZuYcq6gon2hD+qpUTCFS9RZXyJkGWuSByL51d0QMfyGFnZp4J1o7TSHxYDcTzy5porN3JF3iS51ml1FYf5TmICdwiqX0MLs7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756814465; c=relaxed/simple;
	bh=WYJ19TsFV+2Qqe9FAZF07Fv9E8KGb0hwWGVoVvOLLcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ob1cuVI4r+ZhxtQqiXkozl0lKwaZFDOg3NPZIT938ethOsr2L8Wans9Mu7Sj3S1QyVXN14ABNRnIJsolQklD4/E9SHQ7iG35Z3s5Olil5MoZpA+RqGzSYRlwdLK1HY0oBG4NIm/BVsHZK/rOOsM51WUNqLJ+Elmo7PwZLtdB7oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D6dxhHir; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9911C4CEF4;
	Tue,  2 Sep 2025 12:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756814464;
	bh=WYJ19TsFV+2Qqe9FAZF07Fv9E8KGb0hwWGVoVvOLLcg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D6dxhHirthDmmOONEd0DoBqRC7rq8jKelt97VFAbd0Er4DlNAtdmyBdRGOIe6SZ07
	 9UoUAnsnafz4GEokavFcEW5M/7Qpu8MO418TDzZD9XhJ3aNjeb8yOunwlnVBtB5dsd
	 L00zQm2Y6Hw8sZZ+IhYHpdx0/YycZ6QPKhGzKvCY=
Date: Tue, 2 Sep 2025 14:01:01 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	=?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>,
	Mason Chang <mason-cw.chang@mediatek.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Frank Wunderlich <frank-w@public-files.de>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Chad Monroe <chad.monroe@adtran.com>
Subject: Re: [PATCH linux-stable 6.12 0/3] thermal/drivers/mediatek/lvts:
 pick fixes into 6.12 stable tree
Message-ID: <2025090239-gondola-exes-8e13@gregkh>
References: <cover.1756568900.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1756568900.git.daniel@makrotopia.org>

On Sat, Aug 30, 2025 at 04:56:46PM +0100, Daniel Golle wrote:
> Temperature readings on the MT7988 are severely abnormal and inaccurate
> on some devices when using the default commands.
> Patches to fix this have been posted and merged for Linux 6.17, however,
> missing a Fixes:-tag they have not been picked into the Linux 6.12 stable
> tree which already comes with the driver support for MT7988 and hence
> suffers from this problem.
> All 3 commits apply cleanly on top of linux-6.12.y, so cherry-pick them
> now, adding the appropriate Fixes:-tag.

They also need to go to 6.16.y as if you upgraded you would have a
regression :(

I'll go queue them up there now as well.

thanks,
greg k-h

