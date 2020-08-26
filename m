Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF039253007
	for <lists+linux-pm@lfdr.de>; Wed, 26 Aug 2020 15:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730286AbgHZNeo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Aug 2020 09:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730239AbgHZNen (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Aug 2020 09:34:43 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEBAC061756
        for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2020 06:34:42 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id w3so1634331ilh.5
        for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2020 06:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=barpilot-io.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SMSWi9+6a7fi1K3fVedLr45HOo02Azh4dOLlARFQGTA=;
        b=GHB1USjRDQ9ReFPUSIb537h3FyxSfKQOZYZsTLPYUXlYh/DxmcA1ZBjDs0tOjwCSMn
         4SInLnowznEcUnKZFLmcWFVsvyHrK2zVgqtKXOcYFlDMtficXVVlKxYzngUJACVFmT3P
         e5DbazIiAdUwy5/+T2BuIptn4qT6fdGDMyHcl/I2r21O54HVr7cJsqy3mA+eu4iYcPuj
         Qsm4U+HsnYXUdSI3PAScyNPX3L0Suo2l2OinKKH2lsrQec16Lbo1jXC+i1rUvCk7aFwI
         wPnoEC+a3DBq6Hsqli4heRQ3Di18BhMJ9YLHAyOdnT0rzw/mZKS43cuITqutlw8Sv4oJ
         lIVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SMSWi9+6a7fi1K3fVedLr45HOo02Azh4dOLlARFQGTA=;
        b=PsAA62YYwnAfpUNE6SfP9wuIT0/rrwhH485Yl55BIXClG0PfXICaRTsh0OUcM6XNdv
         2jqRwVqEOl/3BA3Yp/w560vTTDIBAc10Ro8iwTu30Z7m6OFzSIDqc7x7h+p71Xf5fzb6
         nSU4rlTUcNUVT1kPQZ4cxIh4xV0E9ziPg0zTKLlt6qLyeCfhFPthTViH1fBEV38gc9QW
         dKANw3oYSYkrcy+Q+u/PKUu9AQLF3EnMWthGRNdVi47PlYtUlXgFzeH6PPDEGRQEh5RK
         mC5+ANP2M9GoJTOQ+5nxz7f7oZFJVQMXf3xrA86/B+KUfvvJe9wOA/643md7JXx7h2Ne
         rvpg==
X-Gm-Message-State: AOAM533n0S4qYrY/bqhppsk1/0xg6tpQHf/C8Qex2i+DjksvPiRIL0O4
        3zxMHW27KvEuhhIQUqoGQiMwNYS0NJ9PwsaYiufxLA==
X-Google-Smtp-Source: ABdhPJzuRzLNXCwTLOBci662EV2n8ED3qyz3twdJElWhNauwpNkSqtHvjnzo37MqSOqutxbjlkkrU8EDapbkV5opPm0=
X-Received: by 2002:a92:9fdb:: with SMTP id z88mr13062947ilk.57.1598448881300;
 Wed, 26 Aug 2020 06:34:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200826120421.44356-1-guilhem@barpilot.io> <CAJZ5v0i8XUF39Vv=EM4TgyXgK6zHniZW3tGYFPweO3kg+BrxOQ@mail.gmail.com>
 <CAGX5Wg0655U71nFcaAJXmj1XMA3MjnCVn=q1Pf=7LLyryHhroQ@mail.gmail.com> <CAJZ5v0hEEDp6thXSOM2ruVjKU02f1Jfn_nEms1yHUrQR2Q_XaQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0hEEDp6thXSOM2ruVjKU02f1Jfn_nEms1yHUrQR2Q_XaQ@mail.gmail.com>
From:   Guilhem Lettron <guilhem@barpilot.io>
Date:   Wed, 26 Aug 2020 15:34:30 +0200
Message-ID: <CAGX5Wg27wFbZUo2NAiBHsR=6F8hhwnZh3XTcioAQkejGOCvVNg@mail.gmail.com>
Subject: Re: [PATCH] intel_idle: Add ICL support
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 26 Aug 2020 at 15:17, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Aug 26, 2020 at 2:59 PM Guilhem Lettron <guilhem@barpilot.io> wrote:
> >
> > On my laptop, a Dell XPS 13 7390 2-in-1 with i7-1065G7, ACPI only report "C1_ACPI", "C2_ACPI" and "C3_ACPI".
>
> Can you list the properties of the idle states in this configuration, that is:
>
> $ grep -r '.*' /sys/devices/system/cpu/cpu0/cpuidle/state1/
>
> and analogously for state2 and state3, and send the output of this?
>
> On my desktop system the above comment produces the following output:
>
> /sys/devices/system/cpu/cpu0/cpuidle/state1/disable:0
> /sys/devices/system/cpu/cpu0/cpuidle/state1/above:1022634
> /sys/devices/system/cpu/cpu0/cpuidle/state1/time:2556533185
> /sys/devices/system/cpu/cpu0/cpuidle/state1/power:0
> /sys/devices/system/cpu/cpu0/cpuidle/state1/residency:2
> /sys/devices/system/cpu/cpu0/cpuidle/state1/latency:2
> /sys/devices/system/cpu/cpu0/cpuidle/state1/usage:17625391
> /sys/devices/system/cpu/cpu0/cpuidle/state1/desc:MWAIT 0x00
> /sys/devices/system/cpu/cpu0/cpuidle/state1/below:6578613
> /sys/devices/system/cpu/cpu0/cpuidle/state1/default_status:enabled
> /sys/devices/system/cpu/cpu0/cpuidle/state1/name:C1
> /sys/devices/system/cpu/cpu0/cpuidle/state1/s2idle/time:0
> /sys/devices/system/cpu/cpu0/cpuidle/state1/s2idle/usage:0
>
> Thanks!

grep -r '.*' /sys/devices/system/cpu/cpu0/cpuidle/state1/

/sys/devices/system/cpu/cpu0/cpuidle/state1/disable:0
/sys/devices/system/cpu/cpu0/cpuidle/state1/above:524
/sys/devices/system/cpu/cpu0/cpuidle/state1/time:63400881
/sys/devices/system/cpu/cpu0/cpuidle/state1/power:0
/sys/devices/system/cpu/cpu0/cpuidle/state1/residency:1
/sys/devices/system/cpu/cpu0/cpuidle/state1/latency:1
/sys/devices/system/cpu/cpu0/cpuidle/state1/usage:195432
/sys/devices/system/cpu/cpu0/cpuidle/state1/desc:ACPI FFH MWAIT 0x0
/sys/devices/system/cpu/cpu0/cpuidle/state1/below:27374
/sys/devices/system/cpu/cpu0/cpuidle/state1/default_status:enabled
/sys/devices/system/cpu/cpu0/cpuidle/state1/name:C1_ACPI
/sys/devices/system/cpu/cpu0/cpuidle/state1/s2idle/time:0
/sys/devices/system/cpu/cpu0/cpuidle/state1/s2idle/usage:0

grep -r '.*' /sys/devices/system/cpu/cpu0/cpuidle/state2/

/sys/devices/system/cpu/cpu0/cpuidle/state2/disable:0
/sys/devices/system/cpu/cpu0/cpuidle/state2/above:43616
/sys/devices/system/cpu/cpu0/cpuidle/state2/time:144893598
/sys/devices/system/cpu/cpu0/cpuidle/state2/power:0
/sys/devices/system/cpu/cpu0/cpuidle/state2/residency:759
/sys/devices/system/cpu/cpu0/cpuidle/state2/latency:253
/sys/devices/system/cpu/cpu0/cpuidle/state2/usage:102740
/sys/devices/system/cpu/cpu0/cpuidle/state2/desc:ACPI FFH MWAIT 0x31
/sys/devices/system/cpu/cpu0/cpuidle/state2/below:11351
/sys/devices/system/cpu/cpu0/cpuidle/state2/default_status:enabled
/sys/devices/system/cpu/cpu0/cpuidle/state2/name:C2_ACPI
/sys/devices/system/cpu/cpu0/cpuidle/state2/s2idle/time:0
/sys/devices/system/cpu/cpu0/cpuidle/state2/s2idle/usage:0

grep -r '.*' /sys/devices/system/cpu/cpu0/cpuidle/state3/

/sys/devices/system/cpu/cpu0/cpuidle/state3/disable:0
/sys/devices/system/cpu/cpu0/cpuidle/state3/above:18551
/sys/devices/system/cpu/cpu0/cpuidle/state3/time:43225299
/sys/devices/system/cpu/cpu0/cpuidle/state3/power:0
/sys/devices/system/cpu/cpu0/cpuidle/state3/residency:3144
/sys/devices/system/cpu/cpu0/cpuidle/state3/latency:1048
/sys/devices/system/cpu/cpu0/cpuidle/state3/usage:24205
/sys/devices/system/cpu/cpu0/cpuidle/state3/desc:ACPI FFH MWAIT 0x60
/sys/devices/system/cpu/cpu0/cpuidle/state3/below:0
/sys/devices/system/cpu/cpu0/cpuidle/state3/default_status:enabled
/sys/devices/system/cpu/cpu0/cpuidle/state3/name:C3_ACPI
/sys/devices/system/cpu/cpu0/cpuidle/state3/s2idle/time:0
/sys/devices/system/cpu/cpu0/cpuidle/state3/s2idle/usage:0

Guilhem Lettron
