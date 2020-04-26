Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C76C1B9171
	for <lists+linux-pm@lfdr.de>; Sun, 26 Apr 2020 18:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgDZQLI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 26 Apr 2020 12:11:08 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:55182 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbgDZQLI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 26 Apr 2020 12:11:08 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id ba38d69c9dd553f1; Sun, 26 Apr 2020 18:11:06 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Domenico Andreoli <domenico.andreoli@linux.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 1/2] uswsusp: use enter/leave helpers and make a global variable static
Date:   Sun, 26 Apr 2020 18:11:06 +0200
Message-ID: <6707632.IUqc4LGj7b@kreacher>
In-Reply-To: <20200413193718.883336371@gmail.com>
References: <20200413190843.044112674@gmail.com> <20200413193718.883336371@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday, April 13, 2020 9:08:44 PM CEST Domenico Andreoli wrote:
> From: Domenico Andreoli <domenico.andreoli@linux.com>
> 
> Regulate access to the userspace software suspend state via helper
> functions instead of a global variable.

IMO this can be done regardless of the second patch.

Some minor naming nits below.

> Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Linux PM <linux-pm@vger.kernel.org>
> 
> ---
>  kernel/power/hibernate.c |    8 ++++----
>  kernel/power/power.h     |    6 +++---
>  kernel/power/user.c      |   20 +++++++++++++++-----
>  3 files changed, 22 insertions(+), 12 deletions(-)
> 
> Index: b/kernel/power/user.c
> ===================================================================
> --- a/kernel/power/user.c
> +++ b/kernel/power/user.c
> @@ -37,7 +37,17 @@ static struct snapshot_data {
>  	bool free_bitmaps;
>  } snapshot_state;
>  
> -atomic_t snapshot_device_available = ATOMIC_INIT(1);
> +static atomic_t snapshot_device_available = ATOMIC_INIT(1);
> +
> +bool swsusp_try_enter(void)

Why not to call it snapshot_device_acquire() ->

> +{
> +	return atomic_add_unless(&snapshot_device_available, -1, 0);
> +}
> +
> +void swsusp_leave(void)
> +{

-> and this snapshot_device_release(), or something to that effect?

"swsusp" is a legacy name.

Thanks!



