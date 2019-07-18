Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2D916C3BE
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2019 02:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbfGRAIq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Jul 2019 20:08:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:49706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728068AbfGRAIp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 17 Jul 2019 20:08:45 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BFA620873;
        Thu, 18 Jul 2019 00:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563408524;
        bh=1FFEoza9+5oT6pKKCXm7RkOmgECLKITXvUuSVaUAhPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QKIPG+L38/WFupSp2hHZBakgJUjChj1CZCpQiEJB+frzR6l+M9NKAMbOK5kCYyHfD
         w96kErKeUPW9Pzn5LJJPFBGeI5YOMEgYAJCZ9x1Mwd+nEQtCW70ylaceo/GiNVWk94
         rDiPxz2tIh7djPRLMC8GaWWt02FojxcHFppLS4Fw=
Date:   Thu, 18 Jul 2019 02:08:42 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Thomas Lindroth <thomas.lindroth@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] cpuidle: Always stop scheduler tick on adaptive-tick CPUs
Message-ID: <20190718000841.GA28715@lenoir>
References: <6254683.2O5gIZElE2@kreacher>
 <20190716214024.GA8345@lenoir>
 <CAJZ5v0gB0AHTebjpp87YKA1wmE+tCw5V=eaRE2XDM3nyQYndnA@mail.gmail.com>
 <20190717132115.GB8345@lenoir>
 <CAJZ5v0icfumJc7E4+LgWpi3+UNpTsH4usAJOg4FEeCBptYYzUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0icfumJc7E4+LgWpi3+UNpTsH4usAJOg4FEeCBptYYzUQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jul 18, 2019 at 12:27:09AM +0200, Rafael J. Wysocki wrote:
> On Wed, Jul 17, 2019 at 3:21 PM Frederic Weisbecker <frederic@kernel.org> wrote:
> >
> > On Wed, Jul 17, 2019 at 09:55:08AM +0200, Rafael J. Wysocki wrote:
> > Well I think we disagree on that assumption that if a nohz_full CPU is put
> > idle, it will remain there indefinitely. Nohz_full CPUs aren't really special
> > in this regard, they can sleep on an IO, wait for a short event just like
> > any other CPU.
> 
> Fair enough.
> 
> This means that the governor (or rather governors) will need to be
> modified to address the issue reported by Thomas.
> 
> Fortunately, I have a patch going in that direction too. :-)

Good to hear, please also Cc me on that one, thanks!
