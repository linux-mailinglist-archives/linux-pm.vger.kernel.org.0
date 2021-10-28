Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36E8143E822
	for <lists+linux-pm@lfdr.de>; Thu, 28 Oct 2021 20:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbhJ1STj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Oct 2021 14:19:39 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:44810 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbhJ1STd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Oct 2021 14:19:33 -0400
Received: by mail-ot1-f54.google.com with SMTP id o10-20020a9d718a000000b00554a0fe7ba0so3950114otj.11;
        Thu, 28 Oct 2021 11:17:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=truNDpG90fQWo72XkDijF7IWVXAMqmIuqcS6DGlpBFY=;
        b=ZPV52JsXVk2wLT7vT/wrij907ZWFJ1cTyDvvL7e7c9dXwyQWp6r13uamVcWJ7KrzgD
         55r+gtDNcyBOfgklG6Ih6XSpFczCQtfKz+0zVDW/3g5leQcHMmKgSfWoiysZSf+sc8gj
         kFRXwwssEJCkMzXnYhbT78BxznKpESv+sMOvI3iv8TBmRvUHpx18einQ+9bnN5w/GJ68
         a8pBeUo8eR5iMhNAlsYnN88ZkaICmewZ6TFiD7SJdFih3dUTGUpo+QB3QPewbnhOWKHr
         KOdDOEuLON0CEhsrBG5u2pgomemGHpaafFQDgzsofov8bN178Cz4KqOARDcDxCbOTu0B
         Rybg==
X-Gm-Message-State: AOAM533925hqyO/fXWW0sEyPs4grO2HOojoz3+jOqWw+1LhrTvUkTp70
        9BKw8OHPpTQwjeOXqkISWQ9M6rYhE2vGm+DjPK5qC91J
X-Google-Smtp-Source: ABdhPJyYdC+RZ3q7w06ZOd4hr8KIaHlaIPh+eHjvQ2q/E3+nuQusT+FskZaV8L4M//MpaGqFfy/usE64BK+L3qqeZ7Q=
X-Received: by 2002:a9d:65c1:: with SMTP id z1mr4649248oth.198.1635445026044;
 Thu, 28 Oct 2021 11:17:06 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2110241452460.2997@hadrien>
 <CAAYoRsXeQravNXKsWAZvacMmE_iBzaQ+mQxNbB5jcD_vkny+Sg@mail.gmail.com>
 <alpine.DEB.2.22.394.2110261658440.3825@hadrien> <CAAYoRsWXew+9Pch_9ux+UK0LFwy+211d2LmNLGKF_UTr3eS2Fw@mail.gmail.com>
 <alpine.DEB.2.22.394.2110281908150.9518@hadrien> <CAJZ5v0ihVdrZ1ogEc34+QgZUJW5-=RzP34-U1_91VTcLhbc4Nw@mail.gmail.com>
 <CAJZ5v0ij105B05xPGgfauwFv1KhXRnwh5p28R1y11qKWjxUOhg@mail.gmail.com>
In-Reply-To: <CAJZ5v0ij105B05xPGgfauwFv1KhXRnwh5p28R1y11qKWjxUOhg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 28 Oct 2021 20:16:54 +0200
Message-ID: <CAJZ5v0gAax-uz+shKv4MNBiSBPKGroQGNKdYyUK4v6sRS15o_w@mail.gmail.com>
Subject: Re: problem in changing from active to passive mode
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Doug Smythies <dsmythies@telus.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000d3cfcc05cf6db77c"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

--000000000000d3cfcc05cf6db77c
Content-Type: text/plain; charset="UTF-8"

On Thu, Oct 28, 2021 at 7:57 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Oct 28, 2021 at 7:29 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Thu, Oct 28, 2021 at 7:10 PM Julia Lawall <julia.lawall@inria.fr> wrote:
> > >
> > > > Now, for your graph 3, are you saying this pseudo
> > > > code of the process is repeatable?:
> > > >
> > > > Power up the system, booting kernel 5.9
> > > > switch to passive/schedutil.
> > > > wait X minutes for system to settle
> > > > do benchmark, result ~13 seconds
> > > > re-boot to kernel 5.15-RC
> > > > switch to passive/schedutil.
> > > > wait X minutes for system to settle
> > > > do benchmark, result ~40 seconds
> > > > re-boot to kernel 5.9
> > > > switch to passive/schedutil.
> > > > wait X minutes for system to settle
> > > > do benchmark, result ~28 seconds
> > >
> > > In the first boot of 5.9, the des (desired?) field of the HWP_REQUEST
> > > register is 0 and in the second boot (after booting 5.15 and entering
> > > passive mode) it is 10.  I don't know though if this is a bug or a
> > > feature...
> >
> > It looks like a bug.
> >
> > I think that the desired value is not cleared on driver exit which
> > should happen.  Let me see if I can do a quick patch for that.
>
> Please check the behavior with the attached patch applied.

Well, actually, the previous one won't do anything, because the
desired perf field is already cleared in this function before writing
the MSR, so please try the one attached to this message instead.

--000000000000d3cfcc05cf6db77c
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="intel_pstate-clear-desired-on-offline.patch"
Content-Disposition: attachment; 
	filename="intel_pstate-clear-desired-on-offline.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kvb9osa10>
X-Attachment-Id: f_kvb9osa10

LS0tCiBkcml2ZXJzL2NwdWZyZXEvaW50ZWxfcHN0YXRlLmMgfCAgICA1ICsrKystCiAxIGZpbGUg
Y2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpJbmRleDogbGludXgtcG0v
ZHJpdmVycy9jcHVmcmVxL2ludGVsX3BzdGF0ZS5jCj09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGxpbnV4LXBtLm9y
aWcvZHJpdmVycy9jcHVmcmVxL2ludGVsX3BzdGF0ZS5jCisrKyBsaW51eC1wbS9kcml2ZXJzL2Nw
dWZyZXEvaW50ZWxfcHN0YXRlLmMKQEAgLTEwMDUsOSArMTAwNSwxMiBAQCBzdGF0aWMgdm9pZCBp
bnRlbF9wc3RhdGVfaHdwX29mZmxpbmUoc3RyCiAJCSAqLwogCQl2YWx1ZSAmPSB+R0VOTUFTS19V
TEwoMzEsIDI0KTsKIAkJdmFsdWUgfD0gSFdQX0VORVJHWV9QRVJGX1BSRUZFUkVOQ0UoY3B1LT5l
cHBfY2FjaGVkKTsKLQkJV1JJVEVfT05DRShjcHUtPmh3cF9yZXFfY2FjaGVkLCB2YWx1ZSk7CiAJ
fQogCisJLyogQ2xlYXIgdGhlIGRlc2lyZWQgcGVyZiBmaWVsZCBpbiB0aGUgY2FjaGVkIEhXUCBy
ZXF1ZXN0IHZhbHVlLiAqLworCXZhbHVlICY9IH5IV1BfREVTSVJFRF9QRVJGKH4wTCk7CisJV1JJ
VEVfT05DRShjcHUtPmh3cF9yZXFfY2FjaGVkLCB2YWx1ZSk7CisKIAl2YWx1ZSAmPSB+R0VOTUFT
S19VTEwoMzEsIDApOwogCW1pbl9wZXJmID0gSFdQX0xPV0VTVF9QRVJGKFJFQURfT05DRShjcHUt
Pmh3cF9jYXBfY2FjaGVkKSk7CiAK
--000000000000d3cfcc05cf6db77c--
