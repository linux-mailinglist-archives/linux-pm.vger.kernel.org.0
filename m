Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73F3BD5F38
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2019 11:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730997AbfJNJon (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Oct 2019 05:44:43 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:45282 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730922AbfJNJon (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Oct 2019 05:44:43 -0400
Received: from 79.184.254.38.ipv4.supernova.orange.pl (79.184.254.38) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 4cda1dedb0538358; Mon, 14 Oct 2019 11:44:41 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     "Hernandez Lopez, Fabiola" <fabiola.hernandez.lopez@intel.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: Frequency not returning to fixed value after AVX workload
Date:   Mon, 14 Oct 2019 11:44:41 +0200
Message-ID: <3340378.NBreQbsDsf@kreacher>
In-Reply-To: <67737C20FC7E4D44B44817ABFA5B1DCE6EC01C77@CRSMSX104.amr.corp.intel.com>
References: <67737C20FC7E4D44B44817ABFA5B1DCE6EC01C77@CRSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Friday, October 11, 2019 7:45:55 PM CEST Hernandez Lopez, Fabiola wrote:
> Hi, 
> 
> We are seeing an unexpected behavior after applying AVX workloads. 
> After setting the CPU frequency to a fixed value with CPU Freq - userspace
> governor and applying heavy AVX workloads, the CPU frequency is decreased
> (as expected) but it never returns to the previously established value.

How do you measure the frequency?

> This does not happen on all cores, only on a single core. The only way to
> return to the desired frequency is by setting it through the command line
> again.

What exactly do you do to get the expected frequency back?

> We are wondering how can this change in frequency happen.

Is the target frequency in the turbo range?



