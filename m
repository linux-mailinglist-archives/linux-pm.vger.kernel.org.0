Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3FF2F1C2D
	for <lists+linux-pm@lfdr.de>; Mon, 11 Jan 2021 18:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389415AbhAKRVg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Jan 2021 12:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389243AbhAKRVf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Jan 2021 12:21:35 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5AEC061794
        for <linux-pm@vger.kernel.org>; Mon, 11 Jan 2021 09:20:55 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id d203so126302oia.0
        for <linux-pm@vger.kernel.org>; Mon, 11 Jan 2021 09:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=fdV0VW8YWN7jAg9JebTxlrGwTE2iDZU0jMTnkLks5R8=;
        b=JptZiE/BzILMv2edPkEWpTCiZDWqqUiaoiUj6VwDJX4FtOt7SHW4BaUrdj1iadpmmH
         oH7UncA1jzlSQ0DNhUKBhCw2dBAE4yLK13IClTXDIsEBBQ61eAigKNvE8eR5HxFLSEt5
         B6L2gAn3ARU3Mi1FbOC2dNgmASqtMIf7zMHah52QueN5wWrp1B2xQxTNERaMPAEZMnl0
         qMDOaYb93yqpSItXumjhux39nifB94ZY3XjEo5OUdlWGHgFQD/v6Hq0MSTw46A130FjZ
         SAKU4I6jHaBNbCmR5NzsPtYvuaoEp/3e+hH2M/35D8hrDf/WQVUaiABMK12yCj0NNeJr
         AQ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=fdV0VW8YWN7jAg9JebTxlrGwTE2iDZU0jMTnkLks5R8=;
        b=s2/U1LbDKj3KQByDdavzwViDKt5g/R2ftF9Oj+yk4BMmXPSy+UOIsStmtaT0rLxfME
         j8egtLjpL9xozkA05sZmVyhlQvmsglbBTHdP1yhJgIGzUDAxh6IIHCEuxp+sk/Kdzclo
         Ffi7+xqOedkworteEP+bjFu2tZO462H3f0Ed5wnK3D6Eqb9hEr2HZgNvLmxWgONHFsCf
         axupKeFFX7Efk9eWYwkKZTCFv8MjireSPC0rXYurk7uqr+cAoPSXqEyE1wH+AgmN+lRs
         9m8zHLVjKmh7skV7kqXz6zLo0VL+PsJoq02YdUJMZd7ZgXLurUdbWfnK2gy9RAPO0xbx
         ffHg==
X-Gm-Message-State: AOAM533sl/wHJdzwSeNo4Ebz/jRa4pDsxVptFGqlnjjT/A1BupBqh406
        p0cnycqH+JHWwrFsTMeIEdhC5Q==
X-Google-Smtp-Source: ABdhPJyYjPqVhMs1IGXL3i/+aSzZl7jL8FLkb4dcnzw/G7iPRUa7mUsCtdiFrZJkxyaSW0Rso7PrIQ==
X-Received: by 2002:a05:6808:2cb:: with SMTP id a11mr255356oid.93.1610385654570;
        Mon, 11 Jan 2021 09:20:54 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id n13sm72203otk.58.2021.01.11.09.20.53
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 11 Jan 2021 09:20:54 -0800 (PST)
Date:   Mon, 11 Jan 2021 09:20:37 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     "Rafael J. Wysocki" <rafael@kernel.org>
cc:     Hugh Dickins <hughd@google.com>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: 5.11-rc device reordering breaks ThinkPad rmi4 suspend
In-Reply-To: <CAJZ5v0gUQApODPUuHkfmHUw30XhX3U-5zYDu5JrgehzVrtyJQw@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.2101110908170.1561@eggly.anvils>
References: <alpine.LSU.2.11.2101102010200.25762@eggly.anvils> <CAJZ5v0gUQApODPUuHkfmHUw30XhX3U-5zYDu5JrgehzVrtyJQw@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 11 Jan 2021, Rafael J. Wysocki wrote:
> On Mon, Jan 11, 2021 at 5:44 AM Hugh Dickins <hughd@google.com> wrote:
> >
> > Hi Rafael,
> >
> > Synaptics RMI4 SMBus touchpad on ThinkPad X1 Carbon (5th generation)
> > fails to suspend when running 5.11-rc kernels: bisected to
> > 5b6164d3465f ("driver core: Reorder devices on successful probe"),
> > and reverting that fixes it.  dmesg.xz attached, but go ahead and ask
> > me to switch on a debug option to extract further info if that may help.
> 
> Does the driver abort the suspend transition by returning an error or
> does something else happen?

Both.  Thierry has pointed to the lines showing failed suspend transition;
and I forgot to mention that the touchpad is unresponsive from then on
(I might not have noticed the failed suspend without that).  But I don't
suppose that unresponsiveness is worth worrying about: things went wrong
in suspend, so it's not surprising if the driver does not recover well.

Thank you both for getting on to this so quickly - but don't worry about
getting my touchpad working: I'm glad to see you discussing the wider
issues of ordering that this has brought up.

Hugh
