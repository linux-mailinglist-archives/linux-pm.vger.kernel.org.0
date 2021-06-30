Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50B8A3B882E
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jun 2021 20:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbhF3SLB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Jun 2021 14:11:01 -0400
Received: from smtprelay0010.hostedemail.com ([216.40.44.10]:36714 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232694AbhF3SLA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Jun 2021 14:11:00 -0400
X-Greylist: delayed 495 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Jun 2021 14:11:00 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave07.hostedemail.com (Postfix) with ESMTP id 0A8BB182C36E0
        for <linux-pm@vger.kernel.org>; Wed, 30 Jun 2021 18:00:18 +0000 (UTC)
Received: from omf11.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 996BA182BF4F3;
        Wed, 30 Jun 2021 18:00:14 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf11.hostedemail.com (Postfix) with ESMTPA id 9D93620A29C;
        Wed, 30 Jun 2021 18:00:13 +0000 (UTC)
Message-ID: <d32d67710c87e5fde488ccbf094f4fa649655a58.camel@perches.com>
Subject: Re: [PATCH] powercap: Replace symbolic permissions with octal
 permissions
From:   Joe Perches <joe@perches.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Jinchao Wang <wjc@cdjrlc.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Date:   Wed, 30 Jun 2021 11:00:12 -0700
In-Reply-To: <CAJZ5v0h9Nx-u0U5O1hp1-BzzKXMVd3UO5BuGH6oc95aXQeu=ag@mail.gmail.com>
References: <20210624084403.1163-1-wjc@cdjrlc.com>
         <CAJZ5v0h9Nx-u0U5O1hp1-BzzKXMVd3UO5BuGH6oc95aXQeu=ag@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9D93620A29C
X-Spam-Status: No, score=-2.90
X-Stat-Signature: r3aumi41y1cmpu7by8xrwmz566mj1rzi
X-Rspamd-Server: rspamout03
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19q3KI551Z+RXekoPIyewutzcuwojVEW2A=
X-HE-Tag: 1625076013-190973
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2021-06-30 at 19:41 +0200, Rafael J. Wysocki wrote:
> On Thu, Jun 24, 2021 at 10:44 AM Jinchao Wang <wjc@cdjrlc.com> wrote:
> > 
> > Resolve following checkpatch issue,
> > Replace symbolic permissions with octal permissions
> 
> I don't see much value in this replacement and checkpatch complaining
> about the existing code base is not something to worry about in
> general.

https://lore.kernel.org/lkml/CA+55aFw5v23T-zvDZp-MmD_EYxF8WbafwwB59934FV7g21uMGQ@mail.gmail.com/

I do agree that in general checkpatch should not really be used as
the sole argument in favor of changing existing code.

So removing the "resolve following checkpatch issue" from the
commit message and replacing it with something like "to improve
readability" would be better.


