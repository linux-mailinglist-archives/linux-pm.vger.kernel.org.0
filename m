Return-Path: <linux-pm+bounces-36040-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF02BD7FE4
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 09:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 534CE18A577E
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 07:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBFA301712;
	Tue, 14 Oct 2025 07:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NjDlrzks"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998D134BA39;
	Tue, 14 Oct 2025 07:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760428047; cv=none; b=Q+lsfT67YV7Qu1MunZtGHnbPbfxOhB6vSgt4Mpt/ZYDw38O8vlTgxH4TFn5kqzntMbZJv8mvhEB54v4nHrZXzMEmQB2Qikqne+op8ZseOYs4M9BBYimV9vyhszU1gqXdsSqoAEnnojhGUHhEfsw6Mdis9vMAlMQoNRVsI/O0RpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760428047; c=relaxed/simple;
	bh=g7JNuJj+OqUGfhgCtCwRpgpvtAkXAEyTRMNNWOnq9pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ouvdOWOkrCjd/J2EC1fcXaqxh1Nfhur0AeOj1+qLdIvtKOZLqI3wiFNsjMg9wsJcjQ0/8URcIvG7NnYQTzX/Ty7tRJ3onyEUT/ux1GpnTc8ifRMPHWFJzsSrF33IZIstVwpFH5005lbpswbAGY0ggu9tSM2YFLDkujX+ETqLWCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NjDlrzks; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B66C4CEE7;
	Tue, 14 Oct 2025 07:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760428047;
	bh=g7JNuJj+OqUGfhgCtCwRpgpvtAkXAEyTRMNNWOnq9pk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NjDlrzks3O/M1dbBO/TF/OAv3mURyrpu7ljAxhZ+d/BmpcMeIgk7f9TYHIGzqStgs
	 AuJnsESSt3+RewLb2tzim+qUZWDmk5yCNJIaZYUg7WlBogyoaRVPQ9JPqVIr6K1VSq
	 KAUVAxi4/fkOGuhlL0DSp1HKXleqtJ3ts9VHbjBE=
Date: Tue, 14 Oct 2025 09:47:24 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Sasha Levin <sashal@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tomasz Figa <tfiga@chromium.org>, stable@vger.kernel.org
Subject: Re: stable: commit "cpuidle: menu: Avoid discarding useful
 information" causes regressions
Message-ID: <2025101451-unlinked-strongly-2fb3@gregkh>
References: <36iykr223vmcfsoysexug6s274nq2oimcu55ybn6ww4il3g3cv@cohflgdbpnq7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36iykr223vmcfsoysexug6s274nq2oimcu55ybn6ww4il3g3cv@cohflgdbpnq7>

On Tue, Oct 14, 2025 at 04:43:43PM +0900, Sergey Senozhatsky wrote:
> Hello,
> 
> We are observing performance regressions (cpu usage, power
> consumption, dropped frames in video playback test, etc.)
> after updating to recent stable kernels.  We tracked it down
> to commit 3cd2aa93674e in linux-6.1.y and commit 3cd2aa93674
> in linux-6.6.y ("cpuidle: menu: Avoid discarding useful information",
> upstream commit 85975daeaa4).
> 
> Upstream fixup fa3fa55de0d ("cpuidle: governors: menu: Avoid using
> invalid recent intervals data") doesn't address the problems we are
> observing.  Revert seems to be bringing performance metrics back to
> pre-regression levels.
> 

For some reason that commit was not added to the 6.1 releases, sorry
about that.  Can you submit a working/tested backport so we can queue it
up after the next round of releases in a few days?

thanks,

greg k-h

