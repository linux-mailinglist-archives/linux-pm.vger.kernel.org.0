Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C077743E791
	for <lists+linux-pm@lfdr.de>; Thu, 28 Oct 2021 19:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhJ1R7s (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Oct 2021 13:59:48 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:45968 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbhJ1R7s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Oct 2021 13:59:48 -0400
Received: by mail-ot1-f51.google.com with SMTP id l16-20020a9d6a90000000b0054e7ab56f27so9686509otq.12;
        Thu, 28 Oct 2021 10:57:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I8S1RsJjseOxeamOtCHDWEESw385GgbZxMc0otlNFT4=;
        b=omyGcgqioCUdNHKmUBsDXPGb4ZZ4rHvN8dVT5ZvmRbFM7FnpXAM0v3gOYZW+k+VyZo
         G8nVZbtSMaIB4ED5DGpn+bcAjfpKdwV9DJbasAD30t/mRZP58U7e9X1j7TW6T+A1Q72M
         oYuHZkjpNDLICSaH4oRpRjBJlQL3YrqdvckJ/DrpkFDRh3rXQa8rtQgw/kMdJd2hsTGb
         Oi94U6yA5noaEw2KkUX/Nuyr5G+wSPU9IrVTqKWwngEJr+uFQ/PSuxO0DrRI7S+kUUX+
         h37j+tBCVVnsWu6pJYrvqQYOWoK2CkRu5AQeqPZSbFGpQts14/7COO0FDwIAzY2fUFoE
         L9SQ==
X-Gm-Message-State: AOAM5333UTFNmDU4J0lBg/DZpQBZQybWlFqGc0l3S+h3OcKNVu3XoeeK
        /1ESNvN0sRQBQu3cz8jbnDbrvgoC4loLRb2Gv3U=
X-Google-Smtp-Source: ABdhPJzXwa3S6rWGIIGi30Zz/DajU0CJ6QC93fCNxo27WalKZOsNfI7lIcTXy2emRKDTsatjL0jlGOyEak+dLddHSEs=
X-Received: by 2002:a9d:65c1:: with SMTP id z1mr4562340oth.198.1635443840953;
 Thu, 28 Oct 2021 10:57:20 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2110241452460.2997@hadrien>
 <CAAYoRsXeQravNXKsWAZvacMmE_iBzaQ+mQxNbB5jcD_vkny+Sg@mail.gmail.com>
 <alpine.DEB.2.22.394.2110261658440.3825@hadrien> <CAAYoRsWXew+9Pch_9ux+UK0LFwy+211d2LmNLGKF_UTr3eS2Fw@mail.gmail.com>
 <alpine.DEB.2.22.394.2110281908150.9518@hadrien> <CAJZ5v0ihVdrZ1ogEc34+QgZUJW5-=RzP34-U1_91VTcLhbc4Nw@mail.gmail.com>
In-Reply-To: <CAJZ5v0ihVdrZ1ogEc34+QgZUJW5-=RzP34-U1_91VTcLhbc4Nw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 28 Oct 2021 19:57:09 +0200
Message-ID: <CAJZ5v0ij105B05xPGgfauwFv1KhXRnwh5p28R1y11qKWjxUOhg@mail.gmail.com>
Subject: Re: problem in changing from active to passive mode
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Doug Smythies <dsmythies@telus.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000030c37305cf6d71b9"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

--00000000000030c37305cf6d71b9
Content-Type: text/plain; charset="UTF-8"

On Thu, Oct 28, 2021 at 7:29 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Oct 28, 2021 at 7:10 PM Julia Lawall <julia.lawall@inria.fr> wrote:
> >
> > > Now, for your graph 3, are you saying this pseudo
> > > code of the process is repeatable?:
> > >
> > > Power up the system, booting kernel 5.9
> > > switch to passive/schedutil.
> > > wait X minutes for system to settle
> > > do benchmark, result ~13 seconds
> > > re-boot to kernel 5.15-RC
> > > switch to passive/schedutil.
> > > wait X minutes for system to settle
> > > do benchmark, result ~40 seconds
> > > re-boot to kernel 5.9
> > > switch to passive/schedutil.
> > > wait X minutes for system to settle
> > > do benchmark, result ~28 seconds
> >
> > In the first boot of 5.9, the des (desired?) field of the HWP_REQUEST
> > register is 0 and in the second boot (after booting 5.15 and entering
> > passive mode) it is 10.  I don't know though if this is a bug or a
> > feature...
>
> It looks like a bug.
>
> I think that the desired value is not cleared on driver exit which
> should happen.  Let me see if I can do a quick patch for that.

Please check the behavior with the attached patch applied.

--00000000000030c37305cf6d71b9
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="intel_pstate-clear-desired-on-offline.patch"
Content-Disposition: attachment; 
	filename="intel_pstate-clear-desired-on-offline.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kvb8zh900>
X-Attachment-Id: f_kvb8zh900

LS0tCiBkcml2ZXJzL2NwdWZyZXEvaW50ZWxfcHN0YXRlLmMgfCAgICAzICsrKwogMSBmaWxlIGNo
YW5nZWQsIDMgaW5zZXJ0aW9ucygrKQoKSW5kZXg6IGxpbnV4LXBtL2RyaXZlcnMvY3B1ZnJlcS9p
bnRlbF9wc3RhdGUuYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBsaW51eC1wbS5vcmlnL2RyaXZlcnMvY3B1ZnJl
cS9pbnRlbF9wc3RhdGUuYworKysgbGludXgtcG0vZHJpdmVycy9jcHVmcmVxL2ludGVsX3BzdGF0
ZS5jCkBAIC0xMDE1LDYgKzEwMTUsOSBAQCBzdGF0aWMgdm9pZCBpbnRlbF9wc3RhdGVfaHdwX29m
ZmxpbmUoc3RyCiAJdmFsdWUgfD0gSFdQX01BWF9QRVJGKG1pbl9wZXJmKTsKIAl2YWx1ZSB8PSBI
V1BfTUlOX1BFUkYobWluX3BlcmYpOwogCisJLyogQ2xlYXIgREVTSVJFRF9QRVJGICovCisJdmFs
dWUgJj0gfkhXUF9ERVNJUkVEX1BFUkYofjBMKTsKKwogCS8qIFNldCBFUFAgdG8gbWluICovCiAJ
aWYgKGJvb3RfY3B1X2hhcyhYODZfRkVBVFVSRV9IV1BfRVBQKSkKIAkJdmFsdWUgfD0gSFdQX0VO
RVJHWV9QRVJGX1BSRUZFUkVOQ0UoSFdQX0VQUF9QT1dFUlNBVkUpOwo=
--00000000000030c37305cf6d71b9--
