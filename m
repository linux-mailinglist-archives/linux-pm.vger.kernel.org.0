Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6721CF516
	for <lists+linux-pm@lfdr.de>; Tue, 12 May 2020 14:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbgELM5j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 May 2020 08:57:39 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:52090 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729519AbgELM5j (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 May 2020 08:57:39 -0400
Received: from 89-64-84-167.dynamic.chello.pl (89.64.84.167) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 94d77207d4edfcba; Tue, 12 May 2020 14:57:36 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Chris Murphy <chris@colorremedies.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: 5.7 sleep/wake regression
Date:   Tue, 12 May 2020 14:57:35 +0200
Message-ID: <7163502.2kdGmH96AJ@kreacher>
In-Reply-To: <CAJCQCtTxQw=P43wHM2ENX600Jm+BXU+f+=Wv09ijjiqWZoWsiQ@mail.gmail.com>
References: <CAJCQCtQ=1=UFaCvPO99W0t9SWuK5zG4ENKYzq2PgJ36iu-EiiQ@mail.gmail.com> <CAJZ5v0hqODC52Bogeo-2suROH63NmON=5a5K6OZEp1YYMYK_QA@mail.gmail.com> <CAJCQCtTxQw=P43wHM2ENX600Jm+BXU+f+=Wv09ijjiqWZoWsiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday, May 11, 2020 7:37:04 PM CEST Chris Murphy wrote:
> On Mon, May 11, 2020 at 5:15 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Mon, May 11, 2020 at 6:22 AM Chris Murphy <chris@colorremedies.com> wrote:
> > >
> > > Got an older Macbook Pro that does suspend to RAM and wake OK with
> > > 5.6, but starting with git 47acac8cae28, it will not wake up. Instead
> > > it has a black screen, gets hot, fans go to high, and it turns into a
> > > hair dryer. So it's a regression.
> >
> > There is a known issue addressed by this patch:
> >
> > https://patchwork.kernel.org/patch/11538065/
> >
> > so can you please try it?
> 
> Patch applied, but the problem remains.
> 
> CPU is i7-2820QM and dmesg for the working sleep+wake case:
> https://paste.centos.org/view/ea5b913d
> 
> In the failed wake case, I note the following: the fade-in/out sleep
> indicator light on the laptop is pulsing, suggests it did actually
> enter sleep OK. When waking by spacebar press, this sleep indicator
> light stops pulsing, the backlight does not come on, the laptop does
> not respond to either ssh or ping. Following  a power reset and
> reboot, the journal's last line is
> 
> [   61.678347] fmac.local kernel: PM: suspend entry (deep)
> 
> Let me know if I should resume bisect.

Please first try to revert commit

6d232b29cfce ("ACPICA: Dispatcher: always generate buffer
objects for ASL create_field() operator")

and see if that helps.

I have no other ideas ATM, so please continue bisecting if it doesn't help.

Cheers!



