Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0297465686
	for <lists+linux-pm@lfdr.de>; Wed,  1 Dec 2021 20:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245363AbhLAThL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Dec 2021 14:37:11 -0500
Received: from mout.gmx.net ([212.227.17.22]:44801 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235901AbhLAThJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 1 Dec 2021 14:37:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638387222;
        bh=r2ja+eT10He+SKg0JT1rOTseNPfJOGXVBQbQvxLhvHA=;
        h=X-UI-Sender-Class:Date:From:To:Cc:In-Reply-To:References:Subject;
        b=Xqstck3E+p/CI2YaolPeSKF25dSAvqCi+/ryCJ+Oxg3W3kvxf2JRVjEF29Sj0veMA
         +z8SGrhcmHTp2Qqgvy/1GeFB0SyhRLqhwTmZLDdQxw7sqL1CAn9cgxa+HFCmu/J4PB
         tEKUG5Z3nWqPjPnFmajhBuLMLs+DCnEhHGkOPniI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from flodo-tb13 ([37.5.248.227]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M5wLT-1myHqn2Avr-007WCp; Wed, 01
 Dec 2021 20:33:42 +0100
Date:   Wed, 1 Dec 2021 20:33:41 +0100
From:   Florian Dollinger <dollinger.florian@gmx.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-pm <linux-pm@vger.kernel.org>
Message-ID: <05654583-C93C-400F-BAC5-36DCA60D7D0F@getmailspring.com>
In-Reply-To: <CAJZ5v0gPCc++kkt-=zhmXWBnXcqtwm2OM1PgC2YeOhkkCjkYEg@mail.gmail.com>
References: <CAJZ5v0gPCc++kkt-=zhmXWBnXcqtwm2OM1PgC2YeOhkkCjkYEg@mail.gmail.com>
Subject: Re: Thinkbook 13s-IWL issues
X-Mailer: Mailspring
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Provags-ID: V03:K1:mkY72/NknhBxVZ8sHz6EcGAt+ZooSCXNj/298xM3O/3yJMRlI5z
 6SaNFmv2YVmk7jCzfDzdZC6I7n1jc+L4Ax5rnMu7/zNmiOXcPvQ8CBz9pNz7EUSwRYxzz83
 CiN6lnGyhl5V9t3viBitXJuycXIBeH8lLFms785sjKUUoX/JFSHRvf4GGgWkp74EIOU1izM
 5FSLmee0zCJHixtaoh8Gw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:pt40rhbPoGU=:GoBIRe3McUJZ9Aj1mP9z18
 lSRzGYeA+ieY1fg4reo1jCwoHKZOZ7tYNriqR5DPFcQM9nCfZCon9uOynmRrqUXOvxUjtyDFF
 BvATiK4yASCeko+Ju1ll8/HuJFXpKkKE3pxKqPoEldxVBXuSbZy0KQNr6RqMwnTxi7sgZMfJh
 S84aW6nYhVR0wmGUu+SWYSPccQUHvw1k7Pc2jwEK1CnTvfFUyikvJ/DQT7cZONKHaKAKw0L/d
 04IcZgAuLHU3pHDs738LVdXCmv1WuHmAI657GmKMeKGKQFjS8DpQz5ouC4XpXrxASZHsQrUjI
 7jesiLyiP39fBihrxseacBa0a9dR4MgOg+xse6N2LtarbgWWoSyVXy4ruWku5Q6kJQ5kXku/e
 gmL31JnMDM9eY8wIldxx4VPAAIQ8CNGZ+/GRcypxfL/XcimvAVF+QjgLbbeHbmZ9GlFCC3JRA
 ioPj7FwoB02uXg6emPj7uceM4cQJYPyPcyw+Aq+2ElMRSZTyJ0oUsBXnZlVD310IqG//8rq9B
 he0dcU3DPPUg0em8Z2hTkT9K+adA0ZzXMKZXTspA2cMO8tGc7JqI2mFEB2ool0q6jqR7iI6bA
 4oa5rf4G8omVJ8yUeFlV1OFXwmJjsdQhPYiZ6n3CWPavTo8f+LEQUzu4yPD6WSEQs6tyjEhge
 92SSvAwmZeaShPsF2oOmwbvLd0QixnSSQoRCly7K9O82KOBV1F6T9QzRCEFTkqVAGTUQywCec
 4qhOv+FYEKLP3eAK7DwXbqE8H6pb5LZ2DUZPI+HLCCaXAYFH1L0hCIgj5VA3S5zNGgcMADsia
 8g1l1CvEe/kuFUvH3PKlXzzNdbtkTk0rBnI7ficAeTk0Y/yU0vdEQmIckpiPAvYQUvY5YNmFw
 uuuBG5+5Zez7ni4EYF3Zbx8iuj8elVqhzFivGERhcOPl7uiaDpdc2F/yo/S9xW4XIgt05vSgL
 9OQrx1rlGsfzDzBXcxLHpx8qPrleKprddWX3s9NGTBtRrPC3ZOdQvF+KjXv1vu2N85/nwmPmz
 ozUT3FqlpQnm2HuojLIRpNacJFSWZVVBFjtgPSj7zzUMZJbZWRhrNmbH2pLI8/+lF0y8f/5tz
 4ARtwujKkmwgCQ=
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On Dec 1 2021, at 6:47 pm, Rafael J. Wysocki <rafael@kernel.org> wrote:

> I would think so, but you may need to double check.
> What's there in /sys/power/mem_sleep on that system?


I am pretty sure now. The main problem for me currently is that I am not
able to get the kernel-log after the system crashed.

It looks like journald is stopping the output in the moment I invoke
`systemctl suspend`.

* If the system is coming back as it should, then the logging is
catching up afterward
* If the system is crashing, I lose those messages I would be interested in.

Do you have a clue of how to get around of that problem?


In `/sys/power/mem_sleep` there is `deep` btw :)
