Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C4436343A
	for <lists+linux-pm@lfdr.de>; Sun, 18 Apr 2021 09:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhDRH3T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 18 Apr 2021 03:29:19 -0400
Received: from smtprelay0040.hostedemail.com ([216.40.44.40]:52134 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229671AbhDRH3S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 18 Apr 2021 03:29:18 -0400
X-Greylist: delayed 1150 seconds by postgrey-1.27 at vger.kernel.org; Sun, 18 Apr 2021 03:29:18 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave05.hostedemail.com (Postfix) with ESMTP id A7ACE1802E628
        for <linux-pm@vger.kernel.org>; Sun, 18 Apr 2021 07:09:41 +0000 (UTC)
Received: from omf04.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 6B112182CED34;
        Sun, 18 Apr 2021 07:09:40 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf04.hostedemail.com (Postfix) with ESMTPA id 4405AD1514;
        Sun, 18 Apr 2021 07:09:39 +0000 (UTC)
Message-ID: <794c957472f826b0f2860aecd365376266e2253a.camel@perches.com>
Subject: Re: [PATCH] base: power: runtime.c: Remove a unnecessary space
From:   Joe Perches <joe@perches.com>
To:     Sebastian Fricke <sebastian.fricke@posteo.net>,
        linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org
Date:   Sun, 18 Apr 2021 00:09:38 -0700
In-Reply-To: <20210418060800.8833-1-sebastian.fricke@posteo.net>
References: <20210418060800.8833-1-sebastian.fricke@posteo.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.10
X-Rspamd-Server: rspamout02
X-Stat-Signature: ymyth7o477mhj7gn5zkxwmfs9wfah16y
X-Rspamd-Queue-Id: 4405AD1514
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18DBgloPiuRQNLxqlT7w9xnq9BZgMJfYZ4=
X-HE-Tag: 1618729779-916855
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 2021-04-18 at 06:08 +0000, Sebastian Fricke wrote:
> Remove a redundant space to improve the quality of the comment.

I think this patch is not useful.

It's not redundant.

Two spaces after a period is commonly used to separate sentences.
It's especially common when used with fixed pitch fonts.

A trivial grep seems to show it's used about 50K times in comments.
Though single space after period may be used about twice as often.

$ git grep '^\s*\*.*\.  [A-Z]' | wc -l
54439
$ git grep '^\s*\*.*\. [A-Z]' | wc -l
110003

For drivers/base/power/runtime.c, that 2 space after period style is used 
dozens of times and changing a single instance of it isn't very useful.

> ---
> Side-note:
> I found this while reading the code, I don't believe it is important but
> I thought it doesn't hurt to fix it.
> ---
>  drivers/base/power/runtime.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 18b82427d0cb..499434b84171 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -786,7 +786,7 @@ static int rpm_resume(struct device *dev, int rpmflags)
>  	}
>  
> 
>  	/*
> -	 * See if we can skip waking up the parent.  This is safe only if
> +	 * See if we can skip waking up the parent. This is safe only if
>  	 * power.no_callbacks is set, because otherwise we don't know whether
>  	 * the resume will actually succeed.
>  	 */


