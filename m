Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5B210469F
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2019 23:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbfKTWaL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Nov 2019 17:30:11 -0500
Received: from mail-wm1-f48.google.com ([209.85.128.48]:51309 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfKTWaL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Nov 2019 17:30:11 -0500
Received: by mail-wm1-f48.google.com with SMTP id g206so1237945wme.1
        for <linux-pm@vger.kernel.org>; Wed, 20 Nov 2019 14:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=oKy2DWTXG/L7mqg9XwK9olxT4xdJoQ8QLvdwppKXwC4=;
        b=P6GQ1gMfi3dgqyxxdSpAc+w3+Rzki+jg0KjOiMEiI46EFNtnhvmpgHYKLAWF3PXbaK
         Ec+ybVfPuoNZqYNTj9LptIGHUw8nNcunnS0x7VrKmw69xfgTuS+4ZZ0vbzEhXPXjTkuI
         LBzQha2AteQXJnGOx7hwZqlAHEYVMfe/laqxHXlpWxwWZxcomXo5dDMnAS0aIXuOXTNS
         1VeM+hLDnMzT2YbfzsXhcTGbeQXoRpYSX7bQ9TjbtJH93DLLIKJVfLZXU/fc8kdhKi+c
         9DpMVK1bzOz4RTW6xY2+XhbfXrp9+m5G1XNvhwxGDaNu2Ula528UEBQESAiopbjeg0rH
         qxCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=oKy2DWTXG/L7mqg9XwK9olxT4xdJoQ8QLvdwppKXwC4=;
        b=scc29CuCXLIzXYVpQPehOojrBBJz8F31/DzmYefyqoW2tbhPlSZwZgA/ZwTqn/EWFt
         WpBBkHb1mCHMd7+OYBzP05dQGDI0dDzM6I8LrX87PooIoNg1CMizIV6J2oK9IQHXskbQ
         Il27VRDScN0hpX90u0yZB1PUuX5nVaIjwOT5dJiza8MbuYewWa8Pe8iAGv/e39vPe9Xs
         lqxLhM59+Toi12Ygg+RWPxc0TxjuRIuP/WMBESgSKRUWkUK8RZEcBwcfPB0KxJR1Nv2B
         +9XGMRWQ/p7UiAAK2fryhxBwuJKudQ2dt+5izP2LodFOq74pSQywSu5+buhYqHfsDDNM
         BlnQ==
X-Gm-Message-State: APjAAAW7be9wxFWKTpk4/FR3yh2HpBwiQiLJGzrIWjhk3b+jWoD9VUjq
        88Y0WOZoDkgaYWs7C5wtpppxnOU6KbscIuRNJPhmMQ==
X-Google-Smtp-Source: APXvYqwYY+/jKh3dBCJ8A6Iwcxw9njKwCKv4D8U6cP1LuLKPx6BT69ORI7shRA2aCCz1JuLlrSeabPpH6VYip6azQig=
X-Received: by 2002:a05:600c:214a:: with SMTP id v10mr6145804wml.102.1574289007712;
 Wed, 20 Nov 2019 14:30:07 -0800 (PST)
MIME-Version: 1.0
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 20 Nov 2019 17:29:56 -0500
Message-ID: <CADnq5_Mxj7b1=DNuCr-2OeWp_UTE8To4Bwgf2QFoEixg2tyGCg@mail.gmail.com>
Subject: PEP driver for Linux
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

I'm trying to understand how to hook in a platform specific driver to
support S0ix on Linux.  Windows defines a platform PEP (power engine
plugin) driver which the platform uses to coordinate the the low power
state of the SoC.  I'm not entirely sure how this would work on Linux.
My understanding is that the all devices go through their suspend
routines and then this PEP driver is responsible for putting the SOC
into it's lowest power state.  On a lot of platforms the PEP driver
interacts with a platform specific ACPI method to tell the platform
which devices are suspended.  I'm not really sure how this should be
handled on Linux.

Thanks,

Alex
