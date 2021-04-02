Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81766352A5C
	for <lists+linux-pm@lfdr.de>; Fri,  2 Apr 2021 13:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbhDBLsp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Apr 2021 07:48:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:38926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229722AbhDBLso (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 2 Apr 2021 07:48:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C3A261055;
        Fri,  2 Apr 2021 11:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617364122;
        bh=QC9L+Y92QPrQRlMi/nwgcTIuFtD7a096q7lKpkbqBtE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gPKClQFVrEENpH6GYHa4AaHEm0Ui9YA7umMd5LkFmOU/8dS3w28Efgdy9RT5fLU/7
         TCjujMqHq0422duaKe4FOtHlaEpedd4jPLFNhyzgPIA62wtjXHnWdqvQTTts8UBkhq
         KwDOqcsmGr/8P1/iqVHoRk+kWawhakMzQeIkJGUs=
Date:   Fri, 2 Apr 2021 13:48:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukasz.luba@arm.com, rafael@kernel.org,
        Ram Chandrasekar <rkumbako@codeaurora.org>
Subject: Re: [PATCH v6 2/7] powercap/drivers/dtpm: Create a registering system
Message-ID: <YGcEl8gsSIcmyLf1@kroah.com>
References: <20210401183654.27214-1-daniel.lezcano@linaro.org>
 <20210401183654.27214-2-daniel.lezcano@linaro.org>
 <YGYe9p3oyNpMnsBT@kroah.com>
 <d0f818c7-3262-268b-bcc2-8036ce559d7b@linaro.org>
 <YGbPh/QrFsgyJC6B@kroah.com>
 <c819700a-97b6-9993-491b-599b82842dc2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c819700a-97b6-9993-491b-599b82842dc2@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Apr 02, 2021 at 01:10:51PM +0200, Daniel Lezcano wrote:
> >> To answer your questions, there is a SoC vendor thermal daemon using
> >> DTPM and there is a tool created to watch the thermal framework and read
> >> the DTPM values, it is available at [4]. It is currently under
> >> development with the goal of doing power rebalancing / capping across
> >> the different nodes when there is a violation of the parent's power limit.
> > 
> > Crazy ideas aside, your implementation of this is my main objection
> > here.  You are creating a user/kernel api that you will have to support
> > for 20+ years, without a real userspace user just yet (from what I can
> > tell).  That's rough, and is going to mean that this gets messy over
> > time.
> 
> I'm not sure to understand, the API already exists since v3.3, it is the
> powercap and DTPM is its backend. AFAICT, there are already users of it
> except they create their own way to build the hierarchy today.

The configfs api is what I am referring to here, the ones in this patch
series...

thanks,

greg k-h
