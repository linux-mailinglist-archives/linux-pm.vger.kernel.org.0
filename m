Return-Path: <linux-pm+bounces-30506-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D47C9AFEFF3
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 19:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FA865A725A
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 17:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CEF230BE0;
	Wed,  9 Jul 2025 17:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLHtwoBR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A362A230264;
	Wed,  9 Jul 2025 17:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752082665; cv=none; b=KGyqcBiqnJdDHk+u389fib2yvYABjoF3FbW8rH2+WgeWSP+HkTRyxhQrd5b3Mg1limF0TO22XX/s9dCtLu0kFaR8oUTA0LUfvv/Ci7NHBbQdp2vGyG87l5eVMVD+RSSqMVLPhllciYMpdfupqB5K4h80MdCCyyOOGrnoIAtWWfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752082665; c=relaxed/simple;
	bh=UrMsQCIJDhTzvXs4RqAiNo8Cvl8Hxt1Ziw4xZzCivP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FDbryEw3HqZnd91v1WRaaVRt1fdz+u15QUwtnikHHSfH2XzsithFTxZxUHf68whWrCJ73CXpBG3HdAO96d+OJjtUC4yfJvz5QtP7gmBMJUmPpkvw8kxRHY2gLBx0a5+FJVAQHlUAJjZ/JsXMJe8c2yp/1VAHINupeLLUPR+s5Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLHtwoBR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC82AC4CEF4;
	Wed,  9 Jul 2025 17:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752082665;
	bh=UrMsQCIJDhTzvXs4RqAiNo8Cvl8Hxt1Ziw4xZzCivP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QLHtwoBRBDQXByIwztN3KSGJHjSq3oNBskn8+BqLMMhqdtnTR0UyUptamUZIYxGzS
	 05rD14LKHLKqTeimzJ2y929jnGWklGIhtvQp6ocTIgZI3vagwr61joiQn1TPHnUZ89
	 ycdYhIM+lzyzlbzjyDSkxSyKQ6uYEu5lkXBMrDbs3vtdGAMwESE30BKXvvCDPaVQUt
	 W7dT2TuhGDf9YXB8WzyeFU2zclFXHgGlkoBe4ce2jqo0L70OLsP/cbUwRrE/xtKpDK
	 byWECBlTs4hfYQ4Le26gLoYuh+ujVmaP2G9fkzWyxgJrH2kUpRW7Z/X8wfGAOFJC6w
	 5tyz4QMbmlGCg==
Date: Wed, 9 Jul 2025 13:37:40 -0400
From: Sasha Levin <sashal@kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: patches@lists.linux.dev, stable@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Nat Wittstock <nat@fardog.io>, Lucian Langa <lucilanga@7pot.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com,
	linux-pm@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 6.15 6/8] PM: Restrict swap use to later in the
 suspend sequence
Message-ID: <aG6o5BYqwe1RmSqb@lappy>
References: <20250708000215.793090-1-sashal@kernel.org>
 <20250708000215.793090-6-sashal@kernel.org>
 <87ms9esclp.fsf@email.froward.int.ebiederm.org>
 <aG2AcbhWmFwaHT6C@lappy>
 <87tt3mqrtg.fsf@email.froward.int.ebiederm.org>
 <aG2bAMGrDDSvOhbl@lappy>
 <87ms9dpc3b.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87ms9dpc3b.fsf@email.froward.int.ebiederm.org>

On Wed, Jul 09, 2025 at 11:23:36AM -0500, Eric W. Biederman wrote:
>There is no indication that the kexec code path has ever been exercised.
>
>So this appears to be one of those changes that was merged under
>the banner of "Let's see if this causes a regression".
>
>To the original authors.  I would have appreciated it being a little
>more clearly called out in the change description that this came in
>under "Let's see if this causes a regression".
>
>Such changes should not be backported automatically.  They should be
>backported with care after the have seen much more usage/testing of
>the kernel they were merged into.  Probably after a kernel release or
>so.  This is something that can take some actual judgment to decide,
>when a backport is reasonable.

I'm assuming that you also refer to stable tagged patches that get
"automatically" picked up, right?

We already have a way to do what you suggest: maintainers can choose
not to tag their patches for stable, and have both their subsystem
and/or individual contributions ignored by AUTOSEL. This way they can
send us commits at their convenience.

There is one subsystem that is mostly doing that (XFS).

The other ones are *choosing* not to do that.

-- 
Thanks,
Sasha

