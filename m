Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56CF458D72
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2019 23:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfF0V6h (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Jun 2019 17:58:37 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:62773 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbfF0V6h (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jun 2019 17:58:37 -0400
Received: from 79.184.254.216.ipv4.supernova.orange.pl (79.184.254.216) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 41f31c8411a844ae; Thu, 27 Jun 2019 23:58:35 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Thomas Renninger <trenn@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] cpupower update for Linux 5.2-rc6
Date:   Thu, 27 Jun 2019 23:58:34 +0200
Message-ID: <4219947.JYe26LCyCL@kreacher>
In-Reply-To: <376ea5d7-110a-71fe-7b02-efe1b0aed88e@linuxfoundation.org>
References: <376ea5d7-110a-71fe-7b02-efe1b0aed88e@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wednesday, June 12, 2019 10:27:03 PM CEST Shuah Khan wrote:
>  This is a multi-part message in MIME format.
> --------------DA1BC82BAC95C219E9AB2661
> Content-Type: text/plain; charset=utf-8; format=flowed
> Content-Transfer-Encoding: 7bit
> 
> Hi Rafael,
> 
> Please pull the following update for Linux 5.2-rc6 or 5.3 depending on
> your pull request schedule for Linus.
> 
> This cpupower update for Linux 5.2-rc6 consists of a fix and a minor
> spelling correction.
> 
> diff is attached.
> 
> thanks,
> -- Shuah
> 
> ----------------------------------------------------------------
> The following changes since commit f2c7c76c5d0a443053e94adb9f0918fa2fb85c3a:
> 
>    Linux 5.2-rc3 (2019-06-02 13:55:33 -0700)
> 
> are available in the Git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux 
> tags/linux-cpupower-5.2-rc6
> 
> for you to fetch changes up to 04507c0a9385cc8280f794a36bfff567c8cc1042:
> 
>    cpupower : frequency-set -r option misses the last cpu in related cpu 
> list (2019-06-04 09:06:50 -0600)

Pulled (long ago) and queued for 5.3.

Thanks, and sorry for the delayed response.



