Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DECA15B087
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2020 20:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbgBLTNu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 14:13:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:46314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727279AbgBLTNu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 Feb 2020 14:13:50 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4584E2082F;
        Wed, 12 Feb 2020 19:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581534829;
        bh=2BzJ+C/j9nfC4mMwDSVQXQZS1h4QCt+FjZmeYq3xHpk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EjRpvzFkG1x7feKJlhLHSYQZIAwpUmsa5h+/O9v7udU0T6tLZoz9Z5FCKJULWguWa
         nMg/xeMXU/KR/+ps4T2fpnrnR3O03Ynxjq7EBXOdrwjvZJbO1wXKfciw63jZRB5ijx
         nkjr7Mez5UceuYLRzszSaMqS/3QDJGiqrnWZkLbs=
Date:   Wed, 12 Feb 2020 11:13:48 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 22/28] drivers: tty: Call cpu_latency_qos_*() instead of
 pm_qos_*()
Message-ID: <20200212191348.GB1987092@kroah.com>
References: <1654227.8mz0SueHsU@kreacher>
 <2339403.frKpfgBVMR@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2339403.frKpfgBVMR@kreacher>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Feb 12, 2020 at 12:27:04AM +0100, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> Call cpu_latency_qos_add/update/remove_request() instead of
> pm_qos_add/update/remove_request(), respectively, because the
> latter are going to be dropped.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/tty/serial/8250/8250_omap.c | 7 +++----
>  drivers/tty/serial/omap-serial.c    | 9 ++++-----
>  2 files changed, 7 insertions(+), 9 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
