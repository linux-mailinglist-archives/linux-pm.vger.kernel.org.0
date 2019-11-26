Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31C8710A6D1
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2019 23:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfKZWyc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Nov 2019 17:54:32 -0500
Received: from mail-lf1-f44.google.com ([209.85.167.44]:38609 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfKZWyc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Nov 2019 17:54:32 -0500
Received: by mail-lf1-f44.google.com with SMTP id q28so15479038lfa.5
        for <linux-pm@vger.kernel.org>; Tue, 26 Nov 2019 14:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=7hNUDAio+9PFw6f8HtKztM9KlmBMkFxqT28WwFbMNyY=;
        b=XKvoHQWhDRHyaDpoWo1NWqQbSxMQ9I3Mhap8FMzAcQmU8sQd48wZAMn9BrwRZKpr5x
         VXoCS18gnITzva1B/4R8WgHvDMe1PJdGICJBKrxPS3DNWQxxvJxouqqKmS9okiR0E2p3
         rQ/cyT8ixM8GZZr9v9pv5sYzjZbc4RHdzNk8hdfQqtZAS3W/pdMBTJgvwm3J/gPY9HS8
         ER/csu0Bg41LSAlpxIORxIFMM86+QCHw1nAosdfuhfu0YoRDgMAhTXTAOdognLJ6ncVL
         DslajHHYlzmWO7tU2j36YroHQyAJH1ye1inmQJ3eIb7w25Bk0h0W/hLB1fdUjuLYD7Rr
         bMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=7hNUDAio+9PFw6f8HtKztM9KlmBMkFxqT28WwFbMNyY=;
        b=WxEGzKv4shz0FRLcYm0CBxeIok821Gw4qtrkQvIc0UDnxGZNQKOU2p/LSfv3K1WmIl
         JBqTbK+SiQFCvy+unAugUrQVX+YzvsqBls4YXvaJ9eNnty0pk3g524jqs/FCAFZpw733
         Yi/eNN/BxiFAFm4n9WjFFUJ1110n8qOmj39t7/CnsncmCi+suM0I0zNJnMQFpop5Tw1Q
         l8UBQfddNiD9vu+hlHgC5OogKeZecLjA63HzgsG0Pf7tmMEh296b1a9eHjito7BWJsjW
         puE4ryRjrjY4XHTp2iO6oUJXHGph/LOoUoPdki96MVaSC0z/jtTTelQJsDloyPrLfpV5
         OqkQ==
X-Gm-Message-State: APjAAAVfVqPNhighLzjS6XER8zCSr2ZTjzpCIb3aivmEteeVjb1rxCZU
        68/sm0YeJNwv+JIUGSu5yk8/7TAwSWW/zD7Hjum9uQ==
X-Google-Smtp-Source: APXvYqzn6rp2FR7QqbsrEQBzURiwXKdbXcsEMVbanT8pGnyyJTklzfCN+yrF6OWsLbOjjoxNqLsKwZcKJvTegzREob0=
X-Received: by 2002:a19:7b18:: with SMTP id w24mr27049939lfc.48.1574808869603;
 Tue, 26 Nov 2019 14:54:29 -0800 (PST)
MIME-Version: 1.0
From:   Roman Kiryanov <rkir@google.com>
Date:   Tue, 26 Nov 2019 14:54:18 -0800
Message-ID: <CAOGAQepibJnd3pm6-a_5_cH74zonY_1S02Sx93WQQWOOarmtHA@mail.gmail.com>
Subject: Battery state monitoring when suspended
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, Sandeep Patil <sspatil@google.com>,
        Lingfeng Yang <lfy@google.com>, Arif Sukoco <arifs@google.com>,
        Steven Moreland <smoreland@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sebastian,

I am working in Android Studio Emulator. It runs on x86 and we found
an issue with power suspending.

We have a 'healthd' service that runs in userspace and listens for
NETLINK (nl_groups=~0) events from battery (we filter by SUBSYSTEM
inside healthd). We listen with EPOLLWAKEUP to take action quickly if
battery level is too low or it is overheated.

This approach has issues on x86: CONFIG_X86_CPUID sends messages to
NETLINK when the system is suspending and since healthd is listening
with EPOLLWAKEUP, it cancels suspension.

Could you help us here? Do you know how linux handles battery states
when suspended? E.g. linux does this in kernel which does not requires
EPOLLWAKEUP.

Thank you.

Regards,
Roman.
