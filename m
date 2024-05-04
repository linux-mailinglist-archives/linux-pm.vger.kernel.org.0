Return-Path: <linux-pm+bounces-7495-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C953F8BB9DC
	for <lists+linux-pm@lfdr.de>; Sat,  4 May 2024 09:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D239CB217D1
	for <lists+linux-pm@lfdr.de>; Sat,  4 May 2024 07:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0FCAD55;
	Sat,  4 May 2024 07:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A1BBn3i+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA9B28EA;
	Sat,  4 May 2024 07:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714808921; cv=none; b=cNHRDUBkmLw6OXNPgHfHWxjre79ElDDSDfj1WJAA7KUTBRVK11bbRRlpGuVkvDRietig81T3YQg39UFdo9kZ7yAL9lXf7LWH1tcAV0J+tbbFd4g8M1PuTNPyCygRncPErQ0ukq16XDH4JqWUHDHjquhBvbp+okGS+NhkBbvU910=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714808921; c=relaxed/simple;
	bh=7lGWtYWiWuShIUGOZrz6IHQ4on9uOg3Q3LCahlB8OAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aC72n8fycvJlENcP+tqtzvJkrpF3xQGDkB2igk8bCM7s6R4ZlRtmIfPLA5yGEnWI4uVN0WdV+wf9LWaK9peM8skQAWHsMm86E+xNZdiHtnKjSHvTH8u6/UMVhrEVBotKM5npBhlU5Eml00hwqOgAi71kAWFBqdOH9nBJHo09rVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A1BBn3i+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E56C072AA;
	Sat,  4 May 2024 07:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714808920;
	bh=7lGWtYWiWuShIUGOZrz6IHQ4on9uOg3Q3LCahlB8OAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A1BBn3i+EaSvgOtT9OdV62OMu5bHUX/6rAgere9EkaJlKEc78Yg9cUATfx2LZtvz4
	 BZE+66CnT3cYl3/Tp6ew1XtSRIvVyQ7RxMBm0LIWp1vH+Vgjwvst91Idl0rl2UgUOi
	 H/X/qufpLgv5VeaX2aDkUtVfbsmCHIxsc3/KiVnw=
Date: Sat, 4 May 2024 09:48:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Georgi Djakov <djakov@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] interconnect changes for 6.10
Message-ID: <2024050420-flatterer-moodiness-4349@gregkh>
References: <20240503101901.1681356-1-djakov@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503101901.1681356-1-djakov@kernel.org>

On Fri, May 03, 2024 at 01:19:01PM +0300, Georgi Djakov wrote:
> Hello Greg,
> 
> This is the pull request with interconnect changes for the v6.10-rc1 merge
> window. It contains tiny clean-up and fix. As always, the summary is
> in the signed tag.
> 
> The patches have been in linux-next for more than a week with no reported
> issues. Please pull into char-misc-next when possible.
> 
> Thanks,
> Georgi
> 
> The following changes since commit 4cece764965020c22cff7665b18a012006359095:
> 
>   Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-6.10-rc1
> 

Pulled and pushed out, thanks.

greg k-h

