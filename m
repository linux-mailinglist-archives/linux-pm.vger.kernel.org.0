Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08B72A859E
	for <lists+linux-pm@lfdr.de>; Thu,  5 Nov 2020 19:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730862AbgKESDJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Nov 2020 13:03:09 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:61746 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbgKESDJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Nov 2020 13:03:09 -0500
Received: from 89-64-88-191.dynamic.chello.pl (89.64.88.191) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.514)
 id 578330c461e38a78; Thu, 5 Nov 2020 19:02:46 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Mike Galbraith <efault@gmx.de>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: v5.8+ powersave governor breakage?
Date:   Thu, 05 Nov 2020 19:02:46 +0100
Message-ID: <2454708.LCoKzY5ALV@kreacher>
In-Reply-To: <76661fbdbd31368c0a06cd58296f5ec12817e33c.camel@gmx.de>
References: <580d12716f6363d7404805fd4bc50e2d5ab459b0.camel@gmx.de> <2948497.iyA2Nh11HS@kreacher> <76661fbdbd31368c0a06cd58296f5ec12817e33c.camel@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thursday, November 5, 2020 4:08:30 PM CET Mike Galbraith wrote:
> On Thu, 2020-11-05 at 15:31 +0100, Rafael J. Wysocki wrote:
> > On Monday, November 2, 2020 7:18:41 AM CET Mike Galbraith wrote:
> >
> > > Desktop box did, it gained a working ondemand, while its previously
> > > working powersave went broke.
> >
> > Most likely that's because it was handled by intel_pstate in the "active" mode
> > previously, while it is now handled by it in the "passive" mode...
> 
> Perhaps the user interface should then nak switching to powersave as it
> used to nak switching to ondemand?

It cannot do that if the powersave governor is configured in.

[Essentially, the problem is that the "powersave" thing advertised by
intel_pstate in the "active" mode is not really the powersave governor,
but that is a mistake made in the past and cannot be undone.  Sorry about
that.]



