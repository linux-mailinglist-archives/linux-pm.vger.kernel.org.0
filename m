Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1BB7E345
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2019 21:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388622AbfHATZH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Aug 2019 15:25:07 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33034 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388603AbfHATZH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Aug 2019 15:25:07 -0400
Received: by mail-pf1-f193.google.com with SMTP id g2so34634383pfq.0
        for <linux-pm@vger.kernel.org>; Thu, 01 Aug 2019 12:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:from:to:subject:user-agent:date;
        bh=YaxBDmm4w6BxFdLcy1jn89PkJwYAWRGHPRdVfiDQRHM=;
        b=ngdU8xy+iHRs7rlnaToJzNd5WH7HncGMsuD5TRZ7tEyyzGqqZFG7GFYIufuwz+VmxT
         epuk93Kk1F0gG1Z2roZPQ4y3CoRWdi+sT/PZXv1BZXaBnl+covbf5XsLOLYHKlg7IB62
         cWkYR/qEgz8laAMUe6DPHSe3cNMu/zCGkvtfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:from:to:subject
         :user-agent:date;
        bh=YaxBDmm4w6BxFdLcy1jn89PkJwYAWRGHPRdVfiDQRHM=;
        b=Xz74/OQ4y9ZFmmOTPPTmNEp57Gu/NT0tn/AaWJb4K6mWLuNJnPzdGGYDQsP1Uaz4Y7
         w18Hv9h1/gGFzTYH/4XOv5tWzDvUlFa6rowi3AlzJ9+/U32jejt8IToBUatp6kT6VSBY
         8P4nARrjEJuxUHEjp+kEsgfaNI7wCGBprPzzUyfZea7HzxhQ2QegdRqgKqdxP8UypmAO
         vV8z/trRgOj3ZFvDCBa07LMlXC/s+N2f+tz+8HMSXANuW0FHgGZ3qH5kNxXnGCeTd5SQ
         hlZL9f2p/h5HKnCEOniDwLV4uNsWtItlFW2Ivbukv1+yvU9P0osBTc8xt9UM0uWZGOID
         4DDQ==
X-Gm-Message-State: APjAAAWG6/YDVaxNnugovYq8ldEngqICmVRblJu+aT/LOVgS4QOI2yXF
        ZFyuOuQ0iqHan2+cjp81XE6cgg==
X-Google-Smtp-Source: APXvYqxdgdlnp7cMvSt/ZUjqO9dvf+s5hQC0iB9FgVdGgYleySugtl6eoS1EjZoCYW6HFRx3+s5GKg==
X-Received: by 2002:a17:90a:cb87:: with SMTP id a7mr392002pju.130.1564687506224;
        Thu, 01 Aug 2019 12:25:06 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id t9sm6136860pji.18.2019.08.01.12.25.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 12:25:05 -0700 (PDT)
Message-ID: <5d433c91.1c69fb81.93f13.febc@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAJZ5v0hDE908XcreUyzZ8JGjFJbgVX1N1ELeMwf+n_ENxPA_DA@mail.gmail.com>
References: <20190731215514.212215-1-trong@android.com> <CANA+-vDTDq__LnLBpM5u_VHHvpFA--K5Du63vPB7HfaKzBsPtg@mail.gmail.com> <6987393.M0uybTKmdI@kreacher> <CANA+-vAPpXF1=z1=OjOhr8HWQ=Qn39qtQ3+8bUeXNTuFFTxoJQ@mail.gmail.com> <CAJZ5v0go-qOTyQV4D2Sj_xQxT831PxJZP0uay67rG73Q3K2pHQ@mail.gmail.com> <5d42281c.1c69fb81.bcda1.71f5@mx.google.com> <5d423637.1c69fb81.62114.ca6f@mx.google.com> <CAJZ5v0jkLXwqmXwyYtdZ9X2=W2KNKS4Ok_NrDew2yvvt1=4pgQ@mail.gmail.com> <5d4305df.1c69fb81.c4013.1950@mx.google.com> <CAJZ5v0hDE908XcreUyzZ8JGjFJbgVX1N1ELeMwf+n_ENxPA_DA@mail.gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Tri Vo <trong@android.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Hridya Valsaraju <hridya@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
From:   Stephen Boyd <swboyd@chromium.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v6] PM / wakeup: show wakeup sources stats in sysfs
User-Agent: alot/0.8.1
Date:   Thu, 01 Aug 2019 12:25:04 -0700
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Rafael J. Wysocki (2019-08-01 10:21:44)
> On Thu, Aug 1, 2019 at 5:31 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > BTW, paths in /sys/devices aren't supposed to matter too much. In this
> > case, I'd expect to see userspace looking at the /sys/class/wakeup path
> > to follow the symlink to figure out what device triggered a wakeup. It
> > can look at the 'device' symlink inside the directory for the wakeup
> > device to figure out which one it is.
>=20
> But if you go from the device, it would be good to be able to figure
> out which wakeup sources are associated with it and in the alarmtimer
> example you don't even see that it is a wakeup source without
> following the link.

Userspace shouldn't go from the device path (/sys/devices/.../rtc0 in
this example). That's incorrect. Instead, userspace should go from the
/sys/class/wakeup/... path. It should iterate over all the devices in
the class path and look at the device pointers instead.

# ls /sys/class/wakeup/*/device -l
lrwxrwxrwx. 1 root root 0 Aug  1 12:13 /sys/class/wakeup/alarmtimer/device =
-> ../../rtc0
lrwxrwxrwx. 1 root root 0 Aug  1 12:13 /sys/class/wakeup/wakeup0/device -> =
../../../a6f8800.usb
lrwxrwxrwx. 1 root root 0 Aug  1 12:13 /sys/class/wakeup/wakeup1/device -> =
../../../a8f8800.usb
lrwxrwxrwx. 1 root root 0 Aug  1 12:13 /sys/class/wakeup/wakeup2/device -> =
../../../cros-ec-rtc.1.auto
lrwxrwxrwx. 1 root root 0 Aug  1 12:13 /sys/class/wakeup/wakeup3/device -> =
../../sbs-16-000b
lrwxrwxrwx. 1 root root 0 Aug  1 12:13 /sys/class/wakeup/wakeup4/device -> =
../../../a88000.spi:ec@0:keyboard-controller
lrwxrwxrwx. 1 root root 0 Aug  1 12:13 /sys/class/wakeup/wakeup5/device -> =
../../../spi10.0
lrwxrwxrwx. 1 root root 0 Aug  1 12:13 /sys/class/wakeup/wakeup6/device -> =
../../../gpio-keys
lrwxrwxrwx. 1 root root 0 Aug  1 12:13 /sys/class/wakeup/wakeup7/device -> =
../../../1-1.1
lrwxrwxrwx. 1 root root 0 Aug  1 12:13 /sys/class/wakeup/wakeup8/device -> =
../../../1-1.2.4.1

>=20
> So the "wakeupN" virtual dev names for all wakeup source objects are
> less confusing IMO.
>=20
> It would be good to avoid the glue dir creation in all cases somehow too.

I recall some differences between a bus_type and a class. Are you
suggesting to use a bus_type for the wakeup sources? I like the class
approach taken here to use different device names because it avoids the
name collisions, avoids making another attribute to express the name of
the wakeup source, and doesn't make a more heavyweight driver
abstraction on top of wakeup sources.

In fact, that ls command above pretty much sums up the wakeup source
name and the device that it's associated with. Whatever goes on inside
/sys/devices/... with respect to where the devices go and how they're
structured is not important, at least to me. Why is it important to you?

