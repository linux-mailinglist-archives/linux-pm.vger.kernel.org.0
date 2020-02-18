Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5EC162207
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2020 09:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgBRIIt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Feb 2020 03:08:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:50876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbgBRIIt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 18 Feb 2020 03:08:49 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF418206EF;
        Tue, 18 Feb 2020 08:08:48 +0000 (UTC)
Date:   Tue, 18 Feb 2020 09:08:46 +0100
From:   Greg KH <greg@kroah.com>
To:     Peter Chen <peter.chen@nxp.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 23/28] drivers: usb: Call cpu_latency_qos_*() instead of
 pm_qos_*()
Message-ID: <20200218080846.GA2186559@kroah.com>
References: <1654227.8mz0SueHsU@kreacher>
 <19064076.ICumzjfW0v@kreacher>
 <20200212183827.GA1900941@kroah.com>
 <20200218080314.GB30350@b29397-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218080314.GB30350@b29397-desktop>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Feb 18, 2020 at 08:03:13AM +0000, Peter Chen wrote:
> On 20-02-12 10:38:27, Greg KH wrote:
> > On Wed, Feb 12, 2020 at 12:28:44AM +0100, Rafael J. Wysocki wrote:
> > > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > > 
> > > Call cpu_latency_qos_add/remove_request() instead of
> > > pm_qos_add/remove_request(), respectively, because the
> > > latter are going to be dropped.
> > > 
> > > No intentional functional impact.
> > > 
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >  drivers/usb/chipidea/ci_hdrc_imx.c | 12 +++++-------
> > >  1 file changed, 5 insertions(+), 7 deletions(-)
> > 
> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Hi Greg,
> 
> With this patch applied, the usb-next can't compile pass.

Did I apply this?  It looks to need to go through Rafael's tree which
introduces the new api, right?

thanks,

greg k-h
