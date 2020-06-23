Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBF1120574B
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jun 2020 18:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732416AbgFWQeo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jun 2020 12:34:44 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:57754 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729481AbgFWQeo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jun 2020 12:34:44 -0400
Received: from 89-64-86-94.dynamic.chello.pl (89.64.86.94) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 56e5a98637d0dac5; Tue, 23 Jun 2020 18:34:41 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] drivers: base: power: mark 2 functions as __init to save some memory
Date:   Tue, 23 Jun 2020 18:34:41 +0200
Message-ID: <2442161.XSOieovDCv@kreacher>
In-Reply-To: <20200621081854.882705-1-christophe.jaillet@wanadoo.fr>
References: <20200621081854.882705-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sunday, June 21, 2020 10:18:54 AM CEST Christophe JAILLET wrote:
> 'early_resume_init()' and 'late_resume_init() 'are only called respectively
> via 'early_resume_init' and 'late_resume_init'.
> They can be marked as __init to save a few bytes of memory.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/base/power/trace.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/power/trace.c b/drivers/base/power/trace.c
> index 977d27bd1a22..a97f33d0c59f 100644
> --- a/drivers/base/power/trace.c
> +++ b/drivers/base/power/trace.c
> @@ -265,14 +265,14 @@ static struct notifier_block pm_trace_nb = {
>  	.notifier_call = pm_trace_notify,
>  };
>  
> -static int early_resume_init(void)
> +static int __init early_resume_init(void)
>  {
>  	hash_value_early_read = read_magic_time();
>  	register_pm_notifier(&pm_trace_nb);
>  	return 0;
>  }
>  
> -static int late_resume_init(void)
> +static int __init late_resume_init(void)
>  {
>  	unsigned int val = hash_value_early_read;
>  	unsigned int user, file, dev;
> 

Applied as 5.8-rc material, thanks!



