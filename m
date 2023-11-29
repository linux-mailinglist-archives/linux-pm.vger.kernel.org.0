Return-Path: <linux-pm+bounces-478-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5EB7FD7C7
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 14:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E00FB20ED2
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 13:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5B21E53C;
	Wed, 29 Nov 2023 13:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ri0kKaOP"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F39414265
	for <linux-pm@vger.kernel.org>; Wed, 29 Nov 2023 13:18:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38BCCC433C7;
	Wed, 29 Nov 2023 13:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701263915;
	bh=CH4bkKpxHIWHSdFzklA5WiWWU65t0PzVjUEFdnbKQgg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ri0kKaOP/wr7YbGajgN2fILimAXlnGJSp4VVVU3zg0NXB5O5EWDJNUWsB3hOY9dSg
	 xcr+MsEeeCNlzPCd9YTlnCVs3ATRz+FStcpvccI+Gxy9F9rj9ZU9wa7f+k719NHOLm
	 1bjSvrSC5k7lSwBkZBa1HHmIlTpZ3+/pm1f5sjguyi5PYyUNOPW4iuwOKcgzYPSYcz
	 8+MdhdAJZ9DBt72pMGKfBSZP3J7KNK+3xhMkWrzMr3YdkeOlwu7RsBy3knsuyJ13RS
	 1+tvBg15Ey/g761GLH7MlaFSwIIm/Y6WLZVQJQJHXbgBzUS4AhFuVOWQkTPtert4yz
	 Edm7cTjiy7oTQ==
Date: Wed, 29 Nov 2023 22:18:30 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
 Len Brown <len.brown@intel.com>, suleiman@google.com,
 briannorris@google.com, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH v5] PM: sleep: Expose last succeeded resumed timestamp
 in sysfs
Message-Id: <20231129221830.05ee995bfd0f5337dd0fb4d1@kernel.org>
In-Reply-To: <6e664be1-dc6b-461e-b75d-2be49641402c@infradead.org>
References: <170108151076.780347.2482745314490930894.stgit@mhiramat.roam.corp.google.com>
	<170108152012.780347.6355289232990337333.stgit@mhiramat.roam.corp.google.com>
	<6e664be1-dc6b-461e-b75d-2be49641402c@infradead.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Randy,

On Mon, 27 Nov 2023 15:47:01 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> Hi--
> 
> 
> On 11/27/23 02:38, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu <mhiramat@kernel.org>
> > 
> 
> > diff --git a/kernel/power/main.c b/kernel/power/main.c
> > index f6425ae3e8b0..2ab23fd3daac 100644
> > --- a/kernel/power/main.c
> > +++ b/kernel/power/main.c
> 
> > @@ -514,6 +526,9 @@ static int suspend_stats_show(struct seq_file *s, void *unused)
> >  			suspend_step_name(
> >  				suspend_stats.failed_steps[index]));
> >  	}
> > +	seq_printf(s,	"last_success_resume_time:\t%-llu.%llu\n",
> 
> The <TAB> after "s," is a bit odd IMO, but I don't see a need to resend it
> just for that.

Yeah, this might be a cosmetic tab. You can see the other seq_prints()
in the same function also have the same <TAB>. I don't want to break it.

Thank you,

> 
> > +		   (unsigned long long)suspend_stats.last_success_resume_time.tv_sec,
> > +		   (unsigned long long)suspend_stats.last_success_resume_time.tv_nsec);
> >  
> >  	return 0;
> >  }
> 
> -- 
> ~Randy


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

