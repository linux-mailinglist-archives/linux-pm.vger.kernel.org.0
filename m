Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82227453C6
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2019 07:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725775AbfFNFFv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Jun 2019 01:05:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:55304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbfFNFFu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 14 Jun 2019 01:05:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BCBF2133D;
        Fri, 14 Jun 2019 05:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560488750;
        bh=HKI2x1EvSe9g2nK7b8GlmwzEiX3DR91aqIl+fHCH+0Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vecLTE6gLDgLhuWI5qzQ4e3cMX6MMqOIVY2h3uLZ4yxwmxbh+WXbfS8JYYI5RO//q
         Loa2tXeEI8l9BNN1Cd+f5/X5UWfL+eRl6sWnPA8EPZZOgfqDJNespG+gWE5haEuYHj
         IC0wF9STRQ+dS3MjAqfBBSuAvejMQ3AlazhpwWxU=
Date:   Fri, 14 Jun 2019 07:05:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org
Subject: Re: [PATCH] thermal: bcm2835: no need to check return value of
 debugfs_create functions
Message-ID: <20190614050547.GA8952@kroah.com>
References: <20190613183729.GA32085@kroah.com>
 <b0e6c04d-143f-1b42-0536-028adc9a55a5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0e6c04d-143f-1b42-0536-028adc9a55a5@linaro.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jun 13, 2019 at 10:18:13PM +0200, Daniel Lezcano wrote:
> On 13/06/2019 20:37, Greg Kroah-Hartman wrote:
> > When calling debugfs functions, there is no need to ever check the
> > return value.  The function can work or not, but the code logic should
> > never do something different based on this.
> 
> Sorry if I'm missing some context but does it mean we do no longer take
> care of roll-backing anything?

Yes, but how can that happen here?

> It is acceptable to have half of the debugfs set for example?

Yes, your code should never care about this.

> Or a parent failing to create and the children polluting the root
> debugfs dir because the parent is NULL?

How can the parent be NULL?  Remember, debugfs_create_dir() can never
return NULL, so that should not happen.  And even if it does, that's
fine, who cares :)

thanks,

greg k-h
