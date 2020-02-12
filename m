Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A480315AFFF
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2020 19:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgBLSi3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 13:38:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:55750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727439AbgBLSi3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 Feb 2020 13:38:29 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6087F20661;
        Wed, 12 Feb 2020 18:38:28 +0000 (UTC)
Date:   Wed, 12 Feb 2020 10:38:27 -0800
From:   Greg KH <greg@kroah.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Peter Chen <Peter.Chen@nxp.com>, linux-usb@vger.kernel.org
Subject: Re: [PATCH 23/28] drivers: usb: Call cpu_latency_qos_*() instead of
 pm_qos_*()
Message-ID: <20200212183827.GA1900941@kroah.com>
References: <1654227.8mz0SueHsU@kreacher>
 <19064076.ICumzjfW0v@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19064076.ICumzjfW0v@kreacher>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Feb 12, 2020 at 12:28:44AM +0100, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> Call cpu_latency_qos_add/remove_request() instead of
> pm_qos_add/remove_request(), respectively, because the
> latter are going to be dropped.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/usb/chipidea/ci_hdrc_imx.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
