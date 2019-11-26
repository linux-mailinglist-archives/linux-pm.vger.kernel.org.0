Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 793AD10A446
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2019 20:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbfKZTDs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Nov 2019 14:03:48 -0500
Received: from mailbackend.panix.com ([166.84.1.89]:38641 "EHLO
        mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfKZTDs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Nov 2019 14:03:48 -0500
Received: from hp-x360n (c-73-241-154-233.hsd1.ca.comcast.net [73.241.154.233])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 47Mtbj49ZVzwRn;
        Tue, 26 Nov 2019 14:03:45 -0500 (EST)
Date:   Tue, 26 Nov 2019 11:03:44 -0800 (PST)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: Help me fix a regression caused by 56b9918490 (PM: sleep: Simplify
 suspend-to-idle control flow)
In-Reply-To: <12933162.9b7K5rSXZx@kreacher>
Message-ID: <alpine.DEB.2.21.1911261102180.2714@hp-x360n>
References: <alpine.DEB.2.21.1911211549500.3167@hp-x360n> <CAJZ5v0iJevs95=wpZF8iprXqs2R6H=T-FHfbFwGsQqcBe=Wk5w@mail.gmail.com> <alpine.DEB.2.21.1911260833250.2714@hp-x360n> <12933162.9b7K5rSXZx@kreacher>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Tue, 26 Nov 2019, Rafael J. Wysocki wrote:

> I've just realized that it is not necessary to use acpi_ec_query_flushed() in
> acpi_ec_flush_work() at all, because it calls flush_scheduled_work() anyway,
> so the appended patch should be good to go.
...
> Can you try it, please?

IFFFF this current fingers-crossed build fails I certainly shall.

	-Kenny

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Silicon Valley
