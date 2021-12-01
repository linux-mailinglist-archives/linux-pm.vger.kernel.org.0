Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA48465704
	for <lists+linux-pm@lfdr.de>; Wed,  1 Dec 2021 21:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235626AbhLAUYn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Dec 2021 15:24:43 -0500
Received: from mout.gmx.net ([212.227.17.21]:51479 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234856AbhLAUYn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 1 Dec 2021 15:24:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638390076;
        bh=q71YJD2GJbB+Evas7AuEiEoGnJlNWjlK8HqioNqHW5A=;
        h=X-UI-Sender-Class:Date:From:To:Cc:In-Reply-To:References:Subject;
        b=Ssizf63a8a+XR7d+aySJWyv+AzGYxhyda3f2Xsz/bImumYXrDSkF3waOacfASE36E
         3zwCT+srkKc/HzInVYA8yuZ6EA1Ff3GI7sKU+UX0mIkgAFxGfRegX3+ffOZg2iS78t
         LIfd27ekxItJoWBNPp9JbMll4xpQ4zdvFgewqE2I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from flodo-tb13 ([37.5.248.227]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mzyuc-1mdS3O2Rd8-00x2A0; Wed, 01
 Dec 2021 21:21:16 +0100
Date:   Wed, 1 Dec 2021 21:21:15 +0100
From:   Florian Dollinger <dollinger.florian@gmx.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-pm <linux-pm@vger.kernel.org>
Message-ID: <3B1F93FF-F9B3-4BCB-AA31-AD8C692BA53D@getmailspring.com>
In-Reply-To: <CAJZ5v0gPCc++kkt-=zhmXWBnXcqtwm2OM1PgC2YeOhkkCjkYEg@mail.gmail.com>
References: <CAJZ5v0gPCc++kkt-=zhmXWBnXcqtwm2OM1PgC2YeOhkkCjkYEg@mail.gmail.com>
Subject: Re: Thinkbook 13s-IWL issues
X-Mailer: Mailspring
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Provags-ID: V03:K1:okhe1nHs5SPRnbJ4Y8L5k8sQFtsyPiMP06hGp1TPuR0muVwknvU
 whoS1296WOy53M/ddKBn22BGBdf+x/Slpi0dAk9z7kkIUYXwHt2wq1LTbfBI+ofqsLO/HOU
 GsKSn3xNRptgZhA4CfEgmTX1hHMZNDsP6+5nHUNXvwqayye/wwp6/kQCFsfqyHeVik412yB
 p81d04GFUQDhT1yW3S+1g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:at99G7VgKwg=:nQWrz8iyeKuPxjonpOXTvs
 aV6NeY7zDdRE2sk/Bx7oIPRv8SNsg6Uf5x6E9AnUenj0D7p7T0JNUaFmeduay28rPAI5rcAaU
 ZOj7QV4qwa++mA+LNwnnnOkGY/z40IxUTSl/tE8g3EZZOb7noMTmHb9mto09H4yznr8yndEgt
 A18vAX3jiKJg6l7QgUhkOc6qsuHt78waVkr9pBHQulM7xZg0O9zlRP/fCNddUVbNuzt6S+8+1
 EW+Wee39wgpkrEeaXPkjGJBTRlUzivrDhJQFU9H2AB7SYwqGiipjTlBJoFWgUjLHZcXZXlqHU
 8D2fU7d9IUp6gBVUHQyqVea7oqjRR2Ihp0X0gOUbtFJ0dWIKQZmm05ekrIPlVf1hklKa09PGb
 DkRlydjpmguYLkgIHlkXs/SZcaLTqr0qYgTgGb1yCOG0XXq4ak64CfworeFOpLkbTt/ZJzumZ
 lDV7VwrrBYqQWKGrE5Aw9J7m9TD6+zYNyjGQHRZNq73bdzcvks4SIP6X1dzBNRz04WZuhcdM1
 0pzN7d4IrsHxcVjjbDLPd2boyzub2eDl4GrscatSYGbs+DCVQdbfEW+vXNxrKfNhVCswm4Lhu
 y/Affg+LtDqLFAgZ9/2IDpf5j6oQdVpJG4y6mrvgEMC6uf2WVXOjqlB6/uRGPmVmBVW7VQ9OF
 2jZh1KOdmdhE0m7QwPcIieXib/cUBKSp7G+tmvk3ZXs3245KLbxqp7UOd2b4YZsgjMQvdP83O
 uCBfD5EE5dIjFgCt7pOx/jlouw7PGWw9mF0SQmxJkOgjDWvk8V2P9+4VPOPJFjjwtsiY1bzqK
 tuzl8RqC5MN6F+ab+4l2+bJOCUN4qPF5vf22dQ7XWOfEo/E33vcxBRepGLEs04bId6Eti3Yye
 Ie9NqFh9ZNuzfBvgYClkvYQWh+BhHuJP454SwTnE0EK2Wd649BSgRbZrCmrWMjp2F7OaKuCus
 gUQFUBC4h/A3nmEEKaIyv4Emptyvt7+PsUGSoLRQ/pCMvW0FavyEAEORB3u2Z+qOFUOlybP3r
 evB6yBOVQqWBL2FkFa9I2u1zIkxZdvad3rwsd9XxVlUM12TVkDoa3xgv1LRyFg3t1vgPc/Cbq
 eO41T8rN3pqH4c=
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Dec 1 2021, at 6:47 pm, Rafael J. Wysocki <rafael@kernel.org> wrote:

> What's there in /sys/power/mem_sleep on that system?


Sorry, it's `[s2idle] deep`. :)
