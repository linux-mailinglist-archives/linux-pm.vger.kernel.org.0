Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD78EB7FB8
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2019 19:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391852AbfISRKg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Sep 2019 13:10:36 -0400
Received: from mailbackend.panix.com ([166.84.1.89]:59010 "EHLO
        mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391584AbfISRKg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Sep 2019 13:10:36 -0400
Received: from hp-x360n (unknown [12.245.190.214])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 46Z3JW5MsJzstN;
        Thu, 19 Sep 2019 13:10:35 -0400 (EDT)
Date:   Thu, 19 Sep 2019 10:10:33 -0700 (PDT)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: Help me help you debug what seems to be an EC resume issue
In-Reply-To: <CAJZ5v0iQp4MNCY-ksGTaTntnmaARSZaOW4sX49zqavtSUvo=Xw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1909191004300.2842@hp-x360n>
References: <alpine.DEB.2.21.1909181742470.2771@hp-x360n> <CAJZ5v0gYGPkJ0-=HSzFCpMLqky2Q6JN3qnov3c2ZaUAeCeaSag@mail.gmail.com> <alpine.DEB.2.21.1909190444190.2973@hp-x360n> <CAJZ5v0hvauVP1NsQq8FTTf0_hk4_KujmCJTAE8ry43gu7wQ-GQ@mail.gmail.com>
 <alpine.DEB.2.21.1909190909440.2973@hp-x360n> <alpine.DEB.2.21.1909190930190.2842@hp-x360n> <CAJZ5v0iQp4MNCY-ksGTaTntnmaARSZaOW4sX49zqavtSUvo=Xw@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Thu, 19 Sep 2019, Rafael J. Wysocki wrote:

> I would recommend to read
> https://01.org/blogs/qwang59/2018/how-achieve-s0ix-states-linux
> at this point if you have not done it yet.

Yeah, I have ... and I get this after a resume:

> intel_pmc_core INT33A1:00: CPU did not enter SLP_S0!!! (S0ix cnt=0)

... and this even after multiple suspend/resume cycles:

> /sys/kernel/debug/pmc_core/slp_s0_residency_usec:0

I did determine I'm going in to C10 though, but that's a "when powered on"
issue; I'm trying to maximize the time I get in s2idle- it's the only thing
infuriating about this laptop. Hibernate works, and I do that when I know
I won't be using it for a while, but going from a laptop that would give me
nearly a week in S3 to this one where I can lose ~20-35% overnight sucks and
I've been pulling at any straw trying to reduce s2idle power draw.

	-Kenny

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Silicon Valley
