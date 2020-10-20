Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58CA4293477
	for <lists+linux-pm@lfdr.de>; Tue, 20 Oct 2020 07:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391756AbgJTF44 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Oct 2020 01:56:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:50924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730488AbgJTF44 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 20 Oct 2020 01:56:56 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A76A222E8;
        Tue, 20 Oct 2020 05:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603173415;
        bh=oAtXafPoBCZJ2xzyrzOvNh0P6arfz924fKvmhGsZWz4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Aayejnllq8c9q2gjAgypAxdNbyI6HOZf7i+SoOfDAyQsrGPempusOZQ0IdPPZKl9C
         RLneft26fGYKxtgsdRjfecFZhOBvqF3KZXogLYxLUwht20n759bsWdCWpy5kh5/7cf
         1NLEF9Ury88msYIavO5wsPCVaMT6AKdXyYBsbOeA=
Date:   Tue, 20 Oct 2020 07:57:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc:     rafael.j.wysocki@intel.com, swboyd@chromium.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/1] kobject: Don't emit change events if not in sysfs
Message-ID: <20201020055738.GD3437534@kroah.com>
References: <20201019223257.261223-1-abhishekpandit@chromium.org>
 <20201019153232.1.I797f9874972a07fc381fe586b6748ce71c7b1fda@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019153232.1.I797f9874972a07fc381fe586b6748ce71c7b1fda@changeid>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 19, 2020 at 03:32:57PM -0700, Abhishek Pandit-Subedi wrote:
> Add a check to make sure the kobj is created and in sysfs before sending
> a change event notification. Otherwise, udev rules that depend on the
> change notification may find that the path that changed doesn't actually
> exist.

Why is the user of the kobject trying to emit a uevent before it is
registered?  Shouldn't we fix the root problem here instead?  Otherwise
the event is still "gone", the caller will not know what to do about it.

Please fix the root problem here.

thanks,

greg k-h
