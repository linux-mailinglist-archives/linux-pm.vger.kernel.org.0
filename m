Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3E7B7ECA
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2019 18:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391679AbfISQJo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Sep 2019 12:09:44 -0400
Received: from mailbackend.panix.com ([166.84.1.89]:45600 "EHLO
        mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391682AbfISQJo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Sep 2019 12:09:44 -0400
Received: from hp-x360n (unknown [12.245.190.214])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 46Z1yF4L5KzmfW;
        Thu, 19 Sep 2019 12:09:41 -0400 (EDT)
Date:   Thu, 19 Sep 2019 09:09:39 -0700 (PDT)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: Help me help you debug what seems to be an EC resume issue
In-Reply-To: <CAJZ5v0hvauVP1NsQq8FTTf0_hk4_KujmCJTAE8ry43gu7wQ-GQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1909190857260.2973@hp-x360n>
References: <alpine.DEB.2.21.1909181742470.2771@hp-x360n> <CAJZ5v0gYGPkJ0-=HSzFCpMLqky2Q6JN3qnov3c2ZaUAeCeaSag@mail.gmail.com> <alpine.DEB.2.21.1909190444190.2973@hp-x360n> <CAJZ5v0hvauVP1NsQq8FTTf0_hk4_KujmCJTAE8ry43gu7wQ-GQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Thu, 19 Sep 2019, Rafael J. Wysocki wrote:

> If so, you can try writing 1 into
> /sys/module/acpi/parameters/sleep_no_lps0 and see if that makes any
> difference (without using ec_no_wakeup).

I'll try that soon; in a classic case of "it never makes that sound at the
mechanic's shop" I've done some 6+ sleep cycles since E-mailing you (and
with "ec_no_wakeup" off), and all have come back OK. Increased power drain
during random suspend cycles is still an issue, though, but that may be
unrelated.

(I did remove the MEI driver from the kernel, as I was seeing error returns
during probing on the resume end with "no_console_suspend/initcall_debug" on,
but I'd be surprised if that were an issue here.  I have no need for the MEI
at all, but it's been my experience that loading drivers for devices seem to
reduce the power consumption in s2idle even if I don't (directly) use them
(i.e., I see higher s2idle power drain if I don't enable the "skl_uncore" driver).)

	-Kenny

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Silicon Valley
