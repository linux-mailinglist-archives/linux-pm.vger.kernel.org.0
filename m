Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55CFC2A8C22
	for <lists+linux-pm@lfdr.de>; Fri,  6 Nov 2020 02:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730414AbgKFBgQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Nov 2020 20:36:16 -0500
Received: from mout.gmx.net ([212.227.15.15]:46015 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730246AbgKFBgP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 5 Nov 2020 20:36:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604626566;
        bh=1VYn4LRQLmLDYGQ9PCTWZEHah9Il9YgyQ6VlLlMv9dg=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=C4m9Kuy+Hs0DWMb/PNCYtFtHTveeulk/NbTgY0Y1yXliEp+kaPKWAiWhUya5vKNfG
         HIqbYG4sHRFi500jNXkoO/TxuLg14NYEbrqDMwWkrGo70fwFKB8CBSz/zbPL8DYI3B
         0RbxLosdLDZbjWdsT52M8CapTFy1r2lCHL1hNg48=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([188.174.240.195]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mwfai-1kQLCp4Bv0-00y6Nh; Fri, 06
 Nov 2020 02:36:06 +0100
Message-ID: <b3b0ab83b3f82d03e213494654c53b32d610282f.camel@gmx.de>
Subject: Re: v5.8+ powersave governor breakage?
From:   Mike Galbraith <efault@gmx.de>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>
Date:   Fri, 06 Nov 2020 02:36:05 +0100
In-Reply-To: <2454708.LCoKzY5ALV@kreacher>
References: <580d12716f6363d7404805fd4bc50e2d5ab459b0.camel@gmx.de>
         <2948497.iyA2Nh11HS@kreacher>
         <76661fbdbd31368c0a06cd58296f5ec12817e33c.camel@gmx.de>
         <2454708.LCoKzY5ALV@kreacher>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:imsqUelnGyTysy2GzvyZURlA+VYsEfiR1F7XxI3it1gwjz1gh/8
 e/vVV0xoV1vqUKnoipNnEr4r9VoQeWhFNvWLdmMG6/GVtMXFse8+MjzU740UwLUwY5Birvf
 EcuX9cxu3UfHFyvNT+dWeuHC0cNqXVBNsIggpYyAx1d+rrVqWLClLfIC+chVVmO9VwRLFjR
 T9WA049YQ/UXV46uFbu3A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wvXDe0cf3NA=:ho1bEPEqPN4r3GhQTaRRTz
 0VFwZL/hTlwuQc0sO6fvMocPNDKf46XlYJJAnNYk6CpQ0sXXVC00SKMCDT5QQWq4qQd/j5OnI
 J00tGkuznKkFObSLecHJWDsJLXwjN50i+kp6mdbtlBEzYGQ5s7pnp8/rylzeqqPKs4bXVh5TH
 MsoXX+H6lNyIUF5wJS2vo+SZj1mljs5rqWNFaivJt7ngxvVmMETaUKejpH0TrR5ZQwY9jDqiR
 C7ogXEGzJaQM7ejL0v5QpPxoKBejkbMbjjCwjtd7QekjwzQ4qwpctAjQ9fz9BqhPaY1GCz706
 0AtNop2rHAKeW/13jL7mFJ1N7NFgU7H6s1Vva3tZKz0wSntUE8Am+LeJo4QGdKMFP5qNsgzCv
 dZjlV6a7vasO+lpj4TMrsc2lqQJwbfQ8lafvKaTgaUhbYvrcPNT3/hzazJgv9WtN+iAtf75Ng
 MxAqnUVLWv1Rdw7K4VULi7wpXsNt8nv+y9QagYn6vhguNVVog7cFobJi7T8mm/vE055elQ5IZ
 ZEeOUpfF2Pj19SuSyLF4W+8mROf+CHMnwvbvtJ4UeNicrUCH0pNGOV0Xr+R4He4dV8sy3+29m
 vp2wB/12NbsjcIf9kc+Mq7QXnckdBtKQijMNw1+P6kOHdtLiqEINPCHLumoIaDUToep++9xNV
 7GgxgmAYeYY+fGeVmPTTuTk8VZfPxDr8bH5Hd1PWUarJChn0X/EPsbNA1ry3ZrYZhCaiGP3wo
 8FMfKUmqMZI0ZLdr6D7Y1o4gT4dYJ99QgqWmSV2+3ouh2s46/1PaOYtA6cyUiKnvKERn8PByw
 uf8CqOjHHdeNNAnJv5erJqxUDCH5vbLJ1KBpecuHfa5FLsuVrRkIeoZAz2E8iXc2An/TZAaPX
 erf1K5eVWJIltYxomVZw==
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 2020-11-05 at 19:02 +0100, Rafael J. Wysocki wrote:
> On Thursday, November 5, 2020 4:08:30 PM CET Mike Galbraith wrote:
> > On Thu, 2020-11-05 at 15:31 +0100, Rafael J. Wysocki wrote:
> > > On Monday, November 2, 2020 7:18:41 AM CET Mike Galbraith wrote:
> > >
> > > > Desktop box did, it gained a working ondemand, while its previousl=
y
> > > > working powersave went broke.
> > >
> > > Most likely that's because it was handled by intel_pstate in the "ac=
tive" mode
> > > previously, while it is now handled by it in the "passive" mode...
> >
> > Perhaps the user interface should then nak switching to powersave as i=
t
> > used to nak switching to ondemand?
>
> It cannot do that if the powersave governor is configured in.
>
> [Essentially, the problem is that the "powersave" thing advertised by
> intel_pstate in the "active" mode is not really the powersave governor,
> but that is a mistake made in the past and cannot be undone.  Sorry abou=
t
> that.]

Hohum.  A little unfortunate, but it probably only affects a few aging
boxen like mine, and I now know better that to ever again do that.

