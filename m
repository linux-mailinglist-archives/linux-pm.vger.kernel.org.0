Return-Path: <linux-pm+bounces-18531-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B56459E3B74
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 14:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC586B2940E
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 13:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487141B4F02;
	Wed,  4 Dec 2024 13:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m4AxG7g6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAE71EB2A;
	Wed,  4 Dec 2024 13:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733317941; cv=none; b=VuZocxTKJQrjRFwECTfrc9OpImB2TS3jn37ak+jrVpi8IqCZ3PUYWQEFwAeUpQXZJhwCDw41aYAW6cCUgI0sUk8QxhvHDIRrExGp98mLssLlQon+Twm4jYxEmB4+CRfOBofAICOWE+HKcPuWXQAwBuix9jtKrvEB7+BkmF9womo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733317941; c=relaxed/simple;
	bh=IY8wv+1b2k0zyhlHNkdoP8JGOIyyLU3NwsvjFwQnsNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o5Qe2F2x2C64/UAe9N7bCzgWBOJxYsgE+LTLDIHlxayhkwRQvkJ6apYNkjq0Gyv6nB59QWrEWt3i+C+TqKiwvE3qZR30wMYRCy+1xQiH0S78/lmuHRgSlTdSD8FaqtcBTKz0gspvylDcul4wmvlThBhLoFjBE/uJ2JQqsvrhEiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m4AxG7g6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE73C4CED1;
	Wed,  4 Dec 2024 13:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733317939;
	bh=IY8wv+1b2k0zyhlHNkdoP8JGOIyyLU3NwsvjFwQnsNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m4AxG7g6KlhfeeH4Yk6jZLMFYFcbX+9+q1Q8YXw9YcszNqpiOOJtt2BLlF9ZqZzYj
	 iwK81wEQUlxHsVML8MNhlXbp+OcXLeKg5sU5KQxVssyhxHdz8xAqFL8cN5NS4wjdY7
	 09wKHeaI6gYmaEXlwmqqTHVXDXar92wtgY/8AXmE=
Date: Wed, 4 Dec 2024 14:12:16 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH v1] PM: sleep: Update stale comment in device_resume()
Message-ID: <2024120450-makeshift-haggler-625c@gregkh>
References: <2787627.mvXUDI8C0e@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2787627.mvXUDI8C0e@rjwysocki.net>

On Wed, Dec 04, 2024 at 02:02:04PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> There is no function called __device_suspend() any more and it is still
> mentioned in a comment in device_resume(), so update that comment.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/base/power/main.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-pm/drivers/base/power/main.c
> ===================================================================

Are you not using git?  This looks like the old cvs output :)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


