Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF6B6195C03
	for <lists+linux-pm@lfdr.de>; Fri, 27 Mar 2020 18:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgC0RJm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Mar 2020 13:09:42 -0400
Received: from mailbackend.panix.com ([166.84.1.89]:64295 "EHLO
        mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgC0RJm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Mar 2020 13:09:42 -0400
Received: from xps-7390.lan (ip68-111-223-64.sd.sd.cox.net [68.111.223.64])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 48ppHm1Jp1z1Zjv;
        Fri, 27 Mar 2020 13:09:39 -0400 (EDT)
Date:   Fri, 27 Mar 2020 10:09:38 -0700 (PDT)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: Why do I sometimes "lose" the "psys" RAPL counter?
In-Reply-To: <4ced6de2fba86c2b0d35bc0b8b986404d9033122.camel@linux.intel.com>
Message-ID: <alpine.DEB.2.21.2003271005360.2705@xps-7390>
References: <20200326181641.291505803E3@linux.intel.com>  <707c44fc116e37fdf8edd6543aadf8426f590799.camel@linux.intel.com>  <alpine.DEB.2.21.2003261303530.3213@xps-7390> <4ced6de2fba86c2b0d35bc0b8b986404d9033122.camel@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Fri, 27 Mar 2020, Srinivas Pandruvada wrote:

> You will not loose anything if you don't have psys domain.

OK. I think a BIOS update from HP that just came thru yesterday seems to
have fixed this issue, BTW.

> What distro you are using?

Kubuntu 19.10 (but I build my own kernels from Linus' master since I have
an IceLake CPU).

> Check thermald version (Some distros star this by

I disabled thermald a while ago; it goes overboard and slows me down too much.

> Run this tool once on your system
> https://github.com/intel/dptfxtract

I did that a while ago (back when I was using thermald) and have a bunch of
entries in /etc/thermald/... ; but as I'm no longer using thermald is this
relevant for me? What should I look for?

	-Kenny

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Silicon Valley
