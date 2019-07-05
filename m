Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80A7F603B6
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2019 12:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfGEKAA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Jul 2019 06:00:00 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37670 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727599AbfGEJ77 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Jul 2019 05:59:59 -0400
Received: by mail-ot1-f65.google.com with SMTP id s20so8533173otp.4;
        Fri, 05 Jul 2019 02:59:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=beyRNtev5O4mJWjS70eIztB/Qoa+o9lbeo95E6keUJY=;
        b=GxO/ukHzNFjQIbGBKy0lXvUbXviEoFbVcVPa7cV0LfgltvNpIbW+Pm0wNq2hqS9UpD
         i6xWvMqQnEV0OX7/0EM1islIOzCiS/tPTCkUDE77zTX8sJuS6bbPfZVJdBgS9hnQWX0K
         Cdo38cEFpIs7p+LHrGwe0mLRNTcCSdAIFFwGVMXk5U6vK4mhqTGAEUvM3oBaPFWguDqa
         i6a08A+BAv7SwXYjChRYG/Pm2tkoM5RupvFlzH/Z2pylMx+VWadkeR61jQecVl4wa8lW
         Fmo+4/YPnVHVbeyqbL2H9T38m7EeR2Nyly5ietvR3GVjNEw8Zz+e+Cs4cLPoOyIoXVs6
         z3iA==
X-Gm-Message-State: APjAAAXqdwIMiOLDqO68Z/+Jz6WjIk/jKIMOOiGbVwEAcTtbsKkcDgVw
        4+qOtLUwViLZz68rsB7U73QEmyilY1UL2XoT3jM=
X-Google-Smtp-Source: APXvYqw67TEYIC1UMzAsnjpjPZTeCtDomLNpsuRUXUnwN0RZoLylieiwvy4aa0ev1vzibsf4I9hvGEWjVJgwD2Kllx0=
X-Received: by 2002:a05:6830:8a:: with SMTP id a10mr2039247oto.167.1562320798736;
 Fri, 05 Jul 2019 02:59:58 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000005bf6c3058cde49a7@google.com> <8755905.1UUJr7qOyo@kreacher>
 <CACT4Y+awzZOSAseosiUDvs_zk7hFRuQrrr0LjRmVwesVbF_+aQ@mail.gmail.com>
In-Reply-To: <CACT4Y+awzZOSAseosiUDvs_zk7hFRuQrrr0LjRmVwesVbF_+aQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 5 Jul 2019 11:59:47 +0200
Message-ID: <CAJZ5v0h7O7Rpkf1ShV1PphqB__9EQ2MPkZwrU=x_iDvTn+9bQw@mail.gmail.com>
Subject: Re: linux-next boot error: WARNING in corrupted
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        syzbot <syzbot+de771ae9390dffed7266@syzkaller.appspotmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Len Brown <len.brown@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 5, 2019 at 11:37 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Fri, Jul 5, 2019 at 11:23 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > On Thursday, July 4, 2019 7:27:04 PM CEST syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following crash on:
> > >
> > > HEAD commit:    16c474c9 Add linux-next specific files for 20190704
> > > git tree:       linux-next
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=17f8b463a00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=983f02aae1ef31b6
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=de771ae9390dffed7266
> > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > >
> > > Unfortunately, I don't have any reproducer for this crash yet.
> > >
> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > Reported-by: syzbot+de771ae9390dffed7266@syzkaller.appspotmail.com
> > >
> ...
> > > ------------[ cut here ]------------
> > > __dev_pm_qos_remove_request() called for unknown object
> > > WARNING: CPU: 1 PID: 1 at drivers/base/power/qos.c:486
> > > __dev_pm_qos_remove_request+0x3d3/0x4d0 drivers/base/power/qos.c:486
> >
> > Viresh, any chance to look at this?
> >
> > I'm a bit concerned about the freq QoS series at this point, may defer pushing it.
>
> FWIW here is full WARNING since I am hitting it locally too:

So can you try to revert commits between

0b07ee944701 PM / QOS: Pass request type to dev_pm_qos_{add|remove}_notifier()

and

95c7e46c0f80 cpufreq: Add QoS requests for userspace constraints

inclusive from linux-next (they should revert cleanly) and see if that
makes the issue go away?
