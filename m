Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBEBE247E3E
	for <lists+linux-pm@lfdr.de>; Tue, 18 Aug 2020 08:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgHRGHL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Aug 2020 02:07:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbgHRGHK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 18 Aug 2020 02:07:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E59E20709;
        Tue, 18 Aug 2020 06:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597730830;
        bh=6n7HKQ8FG9mYV1YWzHcAkCOw1Hb+vs4gc4MNYclnHAI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lh2kBDkZjRtgPYNuX+Ey0wdXvDKxr8aaLHJqYr2eOHgBvU3qvQvys3YQq3YUkAECD
         PNdlqtHYONuEasE8+luhaRYqqmuJwvKKzca1oNMfgi66KmSLOPMmdKzXlSfgcDaupz
         twoXNXrG/OdFb8k+qPpKU7z4Htcc0uk6tWS5/3F8=
Date:   Tue, 18 Aug 2020 08:07:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Qiwu Huang <yanziily@gmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Subject: Re: [PATCH v8 1/4] power: supply: core: add quick charge type
 property
Message-ID: <20200818060707.GB1742213@kroah.com>
References: <cover.1597376585.git.huangqiwu@xiaomi.com>
 <ced256ea8ac2f3e54c33677facc4c2ef04dee643.1597376585.git.huangqiwu@xiaomi.com>
 <20200814060909.GD1409566@kroah.com>
 <CAPtXDt1e3fi7ymW0-FSknUAYCQ80aL=4btbeA2e4Xre7+e7OtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPtXDt1e3fi7ymW0-FSknUAYCQ80aL=4btbeA2e4Xre7+e7OtA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 18, 2020 at 09:56:28AM +0800, Qiwu Huang wrote:
> On Fri, Aug 14, 2020 at 2:09 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Aug 14, 2020 at 11:46:54AM +0800, Qiwu Huang wrote:
> > > From: Qiwu Huang <huangqiwu@xiaomi.com>
> > >
> > > Reports the kind of quick charge type based on
> > > different adapter power.
> > >
> > > Signed-off-by: Qiwu Huang <huangqiwu@xiaomi.com>
> > > ---
> > >  Documentation/ABI/testing/sysfs-class-power | 21 +++++++++
> > >  drivers/power/supply/power_supply_sysfs.c   |  1 +
> > >  drivers/power/supply/qcom_smbb.c            | 51 +++++++++++++++++++++
> > >  include/linux/power_supply.h                | 14 ++++++
> > >  4 files changed, 87 insertions(+)
> >
> > You should also submit your driver that uses these new attributes at the
> > same time.  What happened to that request?  Otherwise no one really
> > knows how these are being used, or if they even are used by anyone.
> >
> 
> I don't think I can submit the whole driver because our drivers are
> divided into three parts, the first part is in ADSP, the second part
> is in kernel and the third part is in Android Hal.This is the second
> part.

WHat is "ADSP"?

Just submit your kernel driver code, that's all we care about here.
Userspace code is not anything we can do anything with :)

thanks,

greg k-h
