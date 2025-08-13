Return-Path: <linux-pm+bounces-32242-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E10B240BE
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 07:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E875E167431
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 05:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7252028B4FD;
	Wed, 13 Aug 2025 05:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vMuqXpLq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C5723D7CF;
	Wed, 13 Aug 2025 05:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755064417; cv=none; b=s/llgCuvEa4l5wBNj2moDaAW8EWjYh98SYWfOwsGUph9o+5MQfcnlizOrMzA3IwgQ0zgGE5+clQNp6gwSNut8FA2PiCyo3KnxYDYSXy0BFTtTWHIxpIvdHz9jQInNHUxGf/3wIsuBcS/GtifMwkWf2APSBBkOae5oHoqs5gOrKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755064417; c=relaxed/simple;
	bh=EReAOI9mi2vfvwMel6LQ/cNUIe+w4g4jY6+lto9NZPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDW2wEuVdyFd3sMseoWRBuO0aEmO3KY0jLNOUgzClIBtG9Z+t3l/4A6RFZQ0IjQNJKbOJgedE3aW0BatwFQFIA8p9hpNwAmNyzDEVEYXiL0dOq3zetYWowW1fW3xwyHEPzUH6Pb1+vYQ7IErvTY+nZl/caMOYG6f+tdlVzknlSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vMuqXpLq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F8DBC4CEEB;
	Wed, 13 Aug 2025 05:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755064415;
	bh=EReAOI9mi2vfvwMel6LQ/cNUIe+w4g4jY6+lto9NZPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vMuqXpLqyJwCUXxGJYH52upFGI0oaqeisErNceOu6NPAbO5wVBetz8qcTjXEwH6QS
	 Cb5Rs91kkKOO9EYkeVWMjwvM/qxMXKjfqAzKfjFfCM2DzqhzJdC+jJzPAtYf0VeY10
	 ZiTIPft+MTAUOehLaBg4NQpQjJcBz86G5ONBjTeE=
Date: Wed, 13 Aug 2025 07:53:32 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Samuel Wu <wusamuel@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] PM: Support aborting suspend during filesystem sync
Message-ID: <2025081359-survey-sprinkled-e6dc@gregkh>
References: <20250812232126.1814253-1-wusamuel@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812232126.1814253-1-wusamuel@google.com>

On Tue, Aug 12, 2025 at 04:21:23PM -0700, Samuel Wu wrote:
> +static bool suspend_fs_sync_queued;
> +DEFINE_SPINLOCK(suspend_fs_sync_lock);
> +DECLARE_COMPLETION(suspend_fs_sync_complete);
> +void suspend_abort_fs_sync(void)
> +{
> +	spin_lock(&suspend_fs_sync_lock);
> +	complete(&suspend_fs_sync_complete);
> +	spin_unlock(&suspend_fs_sync_lock);
> +}

Why no documentation for this public function that you added, but yet
you added documentation for a static function that no one can call?

thanks,

greg k-h

