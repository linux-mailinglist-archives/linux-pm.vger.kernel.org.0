Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B89C2A81DF
	for <lists+linux-pm@lfdr.de>; Thu,  5 Nov 2020 16:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730660AbgKEPIp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Nov 2020 10:08:45 -0500
Received: from mout.gmx.net ([212.227.17.21]:33005 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728371AbgKEPIo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 5 Nov 2020 10:08:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604588912;
        bh=t5HOW7Hz+jDRKD1r1n54tNgALaBM9Fc2oZUe30efBQs=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=VRt6zM+oJ/zgMXhmtagWV1ZUm5+k8MEqthBCvhoAEn6ATpub158YeGJjiCIxdXPsy
         1fE8Aq5R7QZsc0AggPAZR/85UZRsKxKcPfPQ0vlAaItN2xl/DdNcjNZZsQEsFHjMKL
         uy99qHMgxj38uncJD9g0RuhcBrdqAJz8/S/0wTfk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.148.80]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MoO6C-1jzSMy3C2a-00olUQ; Thu, 05
 Nov 2020 16:08:32 +0100
Message-ID: <76661fbdbd31368c0a06cd58296f5ec12817e33c.camel@gmx.de>
Subject: Re: v5.8+ powersave governor breakage?
From:   Mike Galbraith <efault@gmx.de>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>
Date:   Thu, 05 Nov 2020 16:08:30 +0100
In-Reply-To: <2948497.iyA2Nh11HS@kreacher>
References: <580d12716f6363d7404805fd4bc50e2d5ab459b0.camel@gmx.de>
         <59d0b9516ce9a553b1e526c6495ac302f1f73e0d.camel@gmx.de>
         <2948497.iyA2Nh11HS@kreacher>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fXmhav/M4bAq6royUTcAXddASTC0cpAMTpGk4olCoWhN7Ydler5
 ix7I8xvTEet1Ixk6mzPjIIvfdObjOHZYZdS4tldo0UQI40lRdN3iduoDIRH7Lvs85BB+0wh
 bcOaMzTioB0F/aBVNXC8OHqo+cVLPU0tkG6oZ0R1pZKsYB4/Enw9yyGYYtDeCfcI0aBhkL2
 TyTsyqh9stNYmaBGjAX4A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wNXUDZbnq9c=:AgyGj4FybcXB1qI9XwszOW
 gjwid8An91agimBEZYL/ML7g9ePydLj0pa2lWVnzKL+qszDr00OSRMvP17yGGzgjLFnaVyn9Y
 qtUoAwt3ZzhQ8+4leNRskI3R9UCf7fN8V9LpQJ0vbApfIgsDVtCTc35n5goYHkH0UoexZ9BYE
 K48yFyPtc5fKIlIDY2DQZWr3hRsYdS935zcl2yBRLsVMBiOGjfa58MAKyzlKLgZAQya0cM9oB
 ot2rSm3b6zyMrWZlTIDeZ7iYG+SZnSToeWP+LeN2Pp+tVPPwtQyoLzI5pEoSQQ9tKMfRUYIN2
 diXDlgY2AZWgBQtxRLvRVVfJLmKV78KMFRBaD5HBdBVblPoj58cSV6A/8dwziqAtieltd7ZbB
 abx6h3hU8CXKLOczxLk5i2lNf2fAqn416xnD0UuyP88xOQ9+Gd+Z6QpDLMltdUX+34W/ihE6v
 oZEeRNSgqR/vPExE4DtzayallqMD0GSgMmD9X/hzhKeUNLEYgPDV8Ly8XhL90osUAORYZzq+B
 YEjU4qCrTOqEgvZycJpglOUfxnDNbWvsLoCOqpXpGWGqgDpMBOe+xfH62WnazZgc342SXJ3dD
 jHzrBN42DMQb737PbouuhFElgefL2NmOOt6q6fqs+RpTPRNtNv16gYIxwwiGBqu4EVCa1r8Wd
 bd4JMeajBo0qnn+i2e1Br1jhwHbgfF0Ml7FXh54qwJjxmU8BEjiFkFOjXBc2/qkmEadD/JJ6W
 hyjE4iPxqiRwBCkjGP0me4qatQeT8QPDobJo7Qag5kNhPMbTvEamNNlMi6LHGVO2nnwTakwXs
 PnqQpJqoT7D0sBrcQ4jvASUKn9+2nBc4BjSc8o4PvrSmdA0DbLY/qEiPR4PFesCNJg7iVDPiy
 gl3ArhCZFNHSkykkaYeg==
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 2020-11-05 at 15:31 +0100, Rafael J. Wysocki wrote:
> On Monday, November 2, 2020 7:18:41 AM CET Mike Galbraith wrote:
>
> > Desktop box did, it gained a working ondemand, while its previously
> > working powersave went broke.
>
> Most likely that's because it was handled by intel_pstate in the "active=
" mode
> previously, while it is now handled by it in the "passive" mode...

Perhaps the user interface should then nak switching to powersave as it
used to nak switching to ondemand?

	-Mike

