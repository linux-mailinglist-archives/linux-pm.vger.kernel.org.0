Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF621095E7
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2019 00:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbfKYXCh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Nov 2019 18:02:37 -0500
Received: from mailbackend.panix.com ([166.84.1.89]:42069 "EHLO
        mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfKYXCh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Nov 2019 18:02:37 -0500
Received: from hp-x360n (50-76-61-131-ip-static.hfc.comcastbusiness.net [50.76.61.131])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 47MMxk5VdLzmJm;
        Mon, 25 Nov 2019 18:02:34 -0500 (EST)
Date:   Mon, 25 Nov 2019 15:02:32 -0800 (PST)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: Help me fix a regression caused by 56b9918490 (PM: sleep: Simplify
 suspend-to-idle control flow)
In-Reply-To: <CAJZ5v0hFjW-MG5Jxqx7maC0OH9XzrAPEVqzidQhTORTW5i1M1g@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1911251501180.13123@hp-x360n>
References: <alpine.DEB.2.21.1911211549500.3167@hp-x360n> <CAJZ5v0jQ3RY8An+V2VYH+ZKLC6=HrCYUMomM6jyEXJ47aeLT+A@mail.gmail.com> <CAJZ5v0gKvDb8=Y04DB3wQe0rK8Zfw5yNuAybV980ozxfmem=BQ@mail.gmail.com> <alpine.DEB.2.21.1911230213510.2531@hp-x360n>
 <CAJZ5v0i2oC-w1RJ2X35fYyHdysorjLRYs-OBn+y_r6ksEZzVtg@mail.gmail.com> <alpine.DEB.2.21.1911241929220.16116@hp-x360n> <CAJZ5v0ichG5N+yLyyX1BZhNf+Fk_xrvQ+9q4FeP3XVtxKp7yug@mail.gmail.com> <alpine.DEB.2.21.1911250812070.3858@hp-x360n>
 <CAJZ5v0hFjW-MG5Jxqx7maC0OH9XzrAPEVqzidQhTORTW5i1M1g@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Mon, 25 Nov 2019, Rafael J. Wysocki wrote:

> So what exactly does happen when you try to suspend with
> sleep_no_lps0?  Does it return to user space right away by itself

Yeah. It's like it never suspends (or suspends quickly and comes right
back; I didn't bother to look at the dmesg in those cases). I could find
out if you wish, but- see my next E-mails.

	-Kenny

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Silicon Valley
