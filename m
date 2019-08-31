Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43E5DA4575
	for <lists+linux-pm@lfdr.de>; Sat, 31 Aug 2019 18:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbfHaQsp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 31 Aug 2019 12:48:45 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40767 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbfHaQso (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 31 Aug 2019 12:48:44 -0400
Received: by mail-ed1-f65.google.com with SMTP id v38so5683786edm.7;
        Sat, 31 Aug 2019 09:48:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ztMy/qc6TZtxWztQakmFfR5mUH6yqYSc1RNJD7TlbZQ=;
        b=s0DJ7pg3BA42rYndtdKLUHBIo9N2tWK9bc7/62X4w586Mz2sozc8X12oEH8IrZyxNC
         c9iUvDNO2V1C+twP/W1CGx7WK8ay71ihd+CsYAtAPwDu4yRjPXZHOS0X+TKSfHX9t+mg
         5xm4vdkVYN/Fyhh24QGD6KD7qweGTDz368CbcwpVFY9NoKiTaArhVMjsFiOQo3zZJHJj
         95+ZUsHhGnjHyO6AJiDZ3GUoIbvny5RHVGZtFePhbaoA52BJTjRE+e6Ir2M7TOgTxIRp
         I6uT+eun4MZ1pNDjHSJX5w8nJh6uTA68DBhc+TuI12nFYAg5x7u0I+5FYTREh7coDFCs
         4TGg==
X-Gm-Message-State: APjAAAX1hNbgDU3MD18mN5+nT/7/MxsnB5pScY7Hm+3xc8vyp1jsyG7e
        LFlYwhW6d7LnxlFy/vrGpAOENLJgQwUIV8u4V86upA==
X-Google-Smtp-Source: APXvYqyl4ibkLRkDUjYF8n0z5MtjgExy1a9DAIVq8L6fnpy7YHsbekFn804yrSKHc1SJcIQgcCR5/e/oZGJpW7b9VUQ=
X-Received: by 2002:a50:bf4f:: with SMTP id g15mr21462355edk.92.1567270123028;
 Sat, 31 Aug 2019 09:48:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190325173232.216357-1-Yazen.Ghannam@amd.com>
 <SN6PR12MB26394D7FEE4582FD19860104F8230@SN6PR12MB2639.namprd12.prod.outlook.com>
 <SN6PR12MB2639ABA1421E220FF5813738F8100@SN6PR12MB2639.namprd12.prod.outlook.com>
In-Reply-To: <SN6PR12MB2639ABA1421E220FF5813738F8100@SN6PR12MB2639.namprd12.prod.outlook.com>
From:   Len Brown <lenb@kernel.org>
Date:   Sat, 31 Aug 2019 12:48:32 -0400
Message-ID: <CAJvTdKk28qQnVv-fMkd6dPGrbfYryp+7PRHgqyurLyavMHSGbw@mail.gmail.com>
Subject: Re: [PATCH] tools/power turbostat: Make interval calculation per
 thread to reduce jitter
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Yeah, I like this patch, and I have applied it.

thanks!
-Len

On Fri, Jun 7, 2019 at 12:28 PM Ghannam, Yazen <Yazen.Ghannam@amd.com> wrote:
>
> > -----Original Message-----
> > From: Ghannam, Yazen <Yazen.Ghannam@amd.com>
> > Sent: Tuesday, April 23, 2019 12:53 PM
> > To: Ghannam, Yazen <Yazen.Ghannam@amd.com>; linux-pm@vger.kernel.org; len.brown@intel.com
> > Cc: linux-kernel@vger.kernel.org; Len Brown <lenb@kernel.org>
> > Subject: RE: [PATCH] tools/power turbostat: Make interval calculation per thread to reduce jitter
> >
> > > -----Original Message-----
> > > From: linux-kernel-owner@vger.kernel.org <linux-kernel-owner@vger.kernel.org> On Behalf Of Ghannam, Yazen
> > > Sent: Monday, March 25, 2019 12:33 PM
> > > To: linux-pm@vger.kernel.org
> > > Cc: Ghannam, Yazen <Yazen.Ghannam@amd.com>; linux-kernel@vger.kernel.org; lenb@kernel.org
> > > Subject: [PATCH] tools/power turbostat: Make interval calculation per thread to reduce jitter
> > >
> > > From: Yazen Ghannam <yazen.ghannam@amd.com>
> > >
> > > Turbostat currently normalizes TSC and other values by dividing by an
> > > interval. This interval is the delta between the start of one global
> > > (all counters on all CPUs) sampling and the start of another. However,
> > > this introduces a lot of jitter into the data.
> > >
> > > In order to reduce jitter, the interval calculation should be based on
> > > timestamps taken per thread and close to the start of the thread's
> > > sampling.
> > >
> > > Define a per thread time value to hold the delta between samples taken
> > > on the thread.
> > >
> > > Use the timestamp taken at the beginning of sampling to calculate the
> > > delta.
> > >
> > > Move the thread's beginning timestamp to after the CPU migration to
> > > avoid jitter due to the migration.
> > >
> > > Use the global time delta for the average time delta.
> > >
> > > Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> > > ---
> >
> > Hi Len,
> >
> > Any comments on this patch?
> >
>
> Hi Len,
>
> Just wanted to check in. Do you have any comments on this patch?
>
> Thanks,
> Yazen



-- 
Len Brown, Intel Open Source Technology Center
