Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6EB2B7EDC
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2019 18:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390376AbfISQNx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Sep 2019 12:13:53 -0400
Received: from mailbackend.panix.com ([166.84.1.89]:34958 "EHLO
        mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388133AbfISQNw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Sep 2019 12:13:52 -0400
Received: from hp-x360n (unknown [12.245.190.214])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 46Z2321xnhzmxj;
        Thu, 19 Sep 2019 12:13:49 -0400 (EDT)
Date:   Thu, 19 Sep 2019 09:13:48 -0700 (PDT)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: Help me help you debug what seems to be an EC resume issue
In-Reply-To: <CAJZ5v0hvauVP1NsQq8FTTf0_hk4_KujmCJTAE8ry43gu7wQ-GQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1909190909440.2973@hp-x360n>
References: <alpine.DEB.2.21.1909181742470.2771@hp-x360n> <CAJZ5v0gYGPkJ0-=HSzFCpMLqky2Q6JN3qnov3c2ZaUAeCeaSag@mail.gmail.com> <alpine.DEB.2.21.1909190444190.2973@hp-x360n> <CAJZ5v0hvauVP1NsQq8FTTf0_hk4_KujmCJTAE8ry43gu7wQ-GQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


BTW, is there any way to determine which devices are still on (out of d3cold)
at the time the kernel relinquishes control to the BIOS/ACPI as the last thing
to happen at suspend?

... and would it make any difference? IOW, when the handoff above occurs,
can/do/will the BIOS/ACPI re-enable devices we've explicitly shut down?

I'd scribble all over "/proc/acpi/wakeup" turning off everything except the
power button if I thought it would make a difference (and I believe at one
time I actually may have) but I wonder if that means anything once the
machine takes over?

Thanks,

	-Kenny, just trying to get more than a day's battery life on s2idle

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Silicon Valley
