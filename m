Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 229991B9142
	for <lists+linux-pm@lfdr.de>; Sun, 26 Apr 2020 17:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgDZPqk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 26 Apr 2020 11:46:40 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:58660 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgDZPqj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 26 Apr 2020 11:46:39 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 6b032272187d8ff8; Sun, 26 Apr 2020 17:46:37 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Domenico Andreoli <domenico.andreoli@linux.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 0/2] Preparing to phase out uswsusp
Date:   Sun, 26 Apr 2020 17:46:37 +0200
Message-ID: <1636190.8qWULXYmPk@kreacher>
In-Reply-To: <20200413190843.044112674@gmail.com>
References: <20200413190843.044112674@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday, April 13, 2020 9:08:43 PM CEST Domenico Andreoli wrote:
> Dear maintainers,
> 
>   it is my understanding that the usermode software suspend is not any
> more the first choice for suspend/hibernate needs (uswsusp tool did
> not receive any update in years).

While the last part is true, the user space utilities are still usable.

Moreover, the kernel-based hibernation is still missing one important
piece with respect to the user space variant, which is image encryption.

That gap needs to be removed before the user space variant can be
regarded as deprecated.

> This small series aims to better separate the kernel side in view of
> a future phase out.
> 
> Marking the new option as deprecated and disabled by default is quite
> extreme but I've not any specific agenda for pushing it that far,
> it's just my interpretation and could be totally wrong.

It is not totally wrong, but a bit premature at this point.

Thanks!



