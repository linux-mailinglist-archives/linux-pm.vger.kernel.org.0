Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59D60189C50
	for <lists+linux-pm@lfdr.de>; Wed, 18 Mar 2020 13:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgCRMyp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Mar 2020 08:54:45 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:45728 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgCRMyp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Mar 2020 08:54:45 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id f7d79faa9d0d97e6; Wed, 18 Mar 2020 13:54:43 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCHv2 46/50] power: Use show_stack_loglvl()
Date:   Wed, 18 Mar 2020 13:54:42 +0100
Message-ID: <3067782.Hudzh6pScr@kreacher>
In-Reply-To: <20200316143916.195608-47-dima@arista.com>
References: <20200316143916.195608-1-dima@arista.com> <20200316143916.195608-47-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday, March 16, 2020 3:39:12 PM CET Dmitry Safonov wrote:
> Aligning with other watchdog messages just before panic - use
> KERN_EMERG.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Dmitry Safonov <dima@arista.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

or please let me know if I'm expected to take this one.

> ---
>  drivers/base/power/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 0e99a760aebd..9b8450eab02e 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -515,7 +515,7 @@ static void dpm_watchdog_handler(struct timer_list *t)
>  	struct dpm_watchdog *wd = from_timer(wd, t, timer);
>  
>  	dev_emerg(wd->dev, "**** DPM device timeout ****\n");
> -	show_stack(wd->tsk, NULL);
> +	show_stack_loglvl(wd->tsk, NULL, KERN_EMERG);
>  	panic("%s %s: unrecoverable failure\n",
>  		dev_driver_string(wd->dev), dev_name(wd->dev));
>  }
> 




