Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 554AF2F1CCF
	for <lists+linux-pm@lfdr.de>; Mon, 11 Jan 2021 18:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389824AbhAKRnl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Jan 2021 12:43:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389552AbhAKRnl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Jan 2021 12:43:41 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B59C061786
        for <linux-pm@vger.kernel.org>; Mon, 11 Jan 2021 09:42:59 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id d203so203834oia.0
        for <linux-pm@vger.kernel.org>; Mon, 11 Jan 2021 09:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=re2Dq6x/nJKMglpv80zNx3DFtyc3Vfd/y3w43PVrNG8=;
        b=i3CAdZpOADuQPqseyugPd/4RvyS9Io1ojPr9NvP0LwKyXBQUvNIBc2t1rZa8CVn4XU
         YpOdafSd7I6KwN4SC1g+dh7qMLh5vpFKh2C29/vpPkPooyzX4kXp1CEM3qXR4qdHqG6f
         A8h2Ogc9RpcETpDpnyGZrRkjWKY+mo6Su+fQTpJ3f8nTsrfnHiHELmZsYv807RWnaHok
         tdFEEqk6QzLLSCwUmPMCDz33Ds2cZjcdLcjb37aLU2xbt+cJypmNNzVdpveeVX1k008/
         jL/jWjPuGIw6QSUDasUzRJicHIPAH5xMzeoE/m/7Fiq7sURf6hBfOwa9GkANotplnxxG
         36gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=re2Dq6x/nJKMglpv80zNx3DFtyc3Vfd/y3w43PVrNG8=;
        b=kBLfadU9AZjKzfAAAOvmTNzc5gxVrGfVDZUiuICSeC9VFj7d5BNAV0AdPHAjn5+5R7
         plDl4vaevmuLB2plZsqTfAvN/hzZ7ID1zOKF01xzKDX7AiJm/xMGj671SOoTuiagL18l
         2GXsd8MA/Ey22IgR2VPHKE/C6scNQehqV0fIxM3rdmo6ETYCht7VfVmAbSmwwa6vhyUC
         i6smV5HPosy8MwXyfb1eHSQKwj6Ry68faHvGD+z8bN6PCf2e2tDAjA/e3hBdBOL25KiK
         dfdN/p/BXUPWd6s2mjlvulHHIARKWhI34wjK1LwwmxRTpViMFkuCuOxxQ90EEUvHI5vJ
         ZLKQ==
X-Gm-Message-State: AOAM533WCv9vvBfOlTYnd2wMMFRAY9DkJ/HZxqIV4OsEgx5fjVO8x5dL
        1L1lqlJjnrbRAc0KXhLJXJQJpg==
X-Google-Smtp-Source: ABdhPJxeiEYbnJLXtJSBQ0suf19F/vvMmHo/GA2tk8NIhKhrJsLtQcvUWXLYgaknW7c48x92Nc0zmQ==
X-Received: by 2002:a54:400e:: with SMTP id x14mr320702oie.21.1610386979001;
        Mon, 11 Jan 2021 09:42:59 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id m7sm31967ool.29.2021.01.11.09.42.57
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 11 Jan 2021 09:42:58 -0800 (PST)
Date:   Mon, 11 Jan 2021 09:42:42 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Thierry Reding <treding@nvidia.com>
cc:     Hugh Dickins <hughd@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: 5.11-rc device reordering breaks ThinkPad rmi4 suspend
In-Reply-To: <X/xV7ZV5jzI7RvAe@ulmo>
Message-ID: <alpine.LSU.2.11.2101110922300.1620@eggly.anvils>
References: <alpine.LSU.2.11.2101102010200.25762@eggly.anvils> <X/xV7ZV5jzI7RvAe@ulmo>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-270854847-1610386978=:1620"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-270854847-1610386978=:1620
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Mon, 11 Jan 2021, Thierry Reding wrote:
> On Sun, Jan 10, 2021 at 08:44:13PM -0800, Hugh Dickins wrote:
> > 
> > Synaptics RMI4 SMBus touchpad on ThinkPad X1 Carbon (5th generation)
> > fails to suspend when running 5.11-rc kernels: bisected to 
> > 5b6164d3465f ("driver core: Reorder devices on successful probe"),
> > and reverting that fixes it.  dmesg.xz attached, but go ahead and ask
> > me to switch on a debug option to extract further info if that may help.
...
> 
> I think what might be happening here is that the offending patch causes
> some devices to be reordered in a way different to how they were ordered
> originally and the rmi4 driver currently depends on that implicit order.

Yes, all that you explained makes good sense, thanks.

> I'm not familiar with how exactly rmi4 works, so I'll have to do
> some digging to hopefully pinpoint exactly what's going wrong here.
> 
> In the meantime, it would be useful to know what exactly the I2C
> hierarchy looks like. For example, what's the I2C controller that the
> RMI4 device is hooked up to. According to the above, that's I2C bus 6,
> so you should be able to find out some details about it by inspecting
> the corresponding sysfs nodes:
> 
> 	$ ls -l /sys/class/i2c-adapter/i2c-6/
> 	$ cat /sys/class/i2c-adapter/i2c-6/name
> 	$ ls -l /sys/class/i2c-adapter/i2c-6/device/

That's curious: I don't even have a /sys/class/i2c-adapter directory.

(And I did wonder if you meant to say "smbus" rather than "i2c",
though I don't have any /sys/class/smbus* either: I have no notion
of the relationship between i2c and smbus, but I thought the failing
write_block calls were the ones in rmi_smbus.c rather than rmi_i2c.c.)

I've attached compressed output of "find /sys/bus /sys/class | sort":
/sys/bus looked more relevant than /sys/class, maybe it will help
point in the right direction?

And in case it's relevant, maybe I should mention that this is a
non-modular, all-built-in kernel.

But as I said to Rafael, my touchpad can wait: the wider ordering
discussion is much more important.

Hugh
--0-270854847-1610386978=:1620
Content-Type: APPLICATION/x-xz; name=sysbusclass.xz
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.LSU.2.11.2101110942420.1620@eggly.anvils>
Content-Description: 
Content-Disposition: attachment; filename=sysbusclass.xz

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
Z/sCAAAAAARZWg==

--0-270854847-1610386978=:1620--
