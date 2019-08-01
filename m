Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33B067E405
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2019 22:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfHAUXA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Aug 2019 16:23:00 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44322 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbfHAUXA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Aug 2019 16:23:00 -0400
Received: by mail-pf1-f196.google.com with SMTP id t16so34672524pfe.11
        for <linux-pm@vger.kernel.org>; Thu, 01 Aug 2019 13:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:from:to:subject:user-agent:date;
        bh=fTIZJQikQI8w/BKVVJZ33osEkUPhfPGMi+gSFP68ip4=;
        b=lxWCa9qRPtHhH2oHKBdo2XyMWrk9vqfYVYeT6QPsAjlAmS0/cIk+KAOcG/75md+Br0
         5dFST6qO2H9lshNgpnQ8B3ElPqmBbyqzytFI8DolFwaGRugcmEpie+aWP7RcXWEgEW+Q
         hGHe//H9rh8Uive6cfcspibky09EEiirl8w+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:from:to:subject
         :user-agent:date;
        bh=fTIZJQikQI8w/BKVVJZ33osEkUPhfPGMi+gSFP68ip4=;
        b=aGPXGR1pHbhkNwt7rZH9xBtrTFjtuTGCzEThaaXh4GHE0pJqYegoixDzoxg45IBN+K
         rS4WsVpTz0o9HzuNDM3SqkZvqcvXBdilGF7lDe5q9/1nDzrw/Rs3KABlPqK+3GAhtdMF
         vGraWzqU4QUgHyhXwSnn8zS/Fv8kgQEP4OSodl/I9/sYCbB95iDvOw1/jGc44hc2Qwc2
         lme7K3EvKHpWn1KBvuIRgN1ZcXT1EXF1xX1YeEa8Igko+XGue3C2s3EWdnhQ5y73g3wp
         9y9LWdMIYDGxdNNf/B40Ky9K7/EYmAXuKpGwHIXMqnqo2Civ2ov5mcHsVoV3XtaYRRXl
         5r/Q==
X-Gm-Message-State: APjAAAXtd46rj/Tgj4JfHaa5ZsGQZaA7w9uBUtq1xhmlRk0i75TduCTK
        6MWihK7JUmU4CBotbagnDgXwmQ==
X-Google-Smtp-Source: APXvYqzOdAoaZaiqO2EChiR593oybTXQTEM78AmeRaPQ7zZ2jslmJrWVVU4RARZJaB1u8UqhhQ/+uw==
X-Received: by 2002:a63:5b52:: with SMTP id l18mr121210400pgm.21.1564690979818;
        Thu, 01 Aug 2019 13:22:59 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id l1sm94261462pfl.9.2019.08.01.13.22.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 13:22:59 -0700 (PDT)
Message-ID: <5d434a23.1c69fb81.c4201.c65b@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CANA+-vCoCuMtSKCfnav9NSwrzX7of9iLbppNX+pcymBp19kgQQ@mail.gmail.com>
References: <20190731215514.212215-1-trong@android.com> <32598586.Mjd66ZhNnG@kreacher> <CANA+-vDTDq__LnLBpM5u_VHHvpFA--K5Du63vPB7HfaKzBsPtg@mail.gmail.com> <6987393.M0uybTKmdI@kreacher> <CANA+-vAPpXF1=z1=OjOhr8HWQ=Qn39qtQ3+8bUeXNTuFFTxoJQ@mail.gmail.com> <CAJZ5v0go-qOTyQV4D2Sj_xQxT831PxJZP0uay67rG73Q3K2pHQ@mail.gmail.com> <5d42281c.1c69fb81.bcda1.71f5@mx.google.com> <CANA+-vCoCuMtSKCfnav9NSwrzX7of9iLbppNX+pcymBp19kgQQ@mail.gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
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
To:     Tri Vo <trong@android.com>
Subject: Re: [PATCH v6] PM / wakeup: show wakeup sources stats in sysfs
User-Agent: alot/0.8.1
Date:   Thu, 01 Aug 2019 13:22:58 -0700
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Tri Vo (2019-08-01 12:50:25)
> On Wed, Jul 31, 2019 at 4:45 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Rafael J. Wysocki (2019-07-31 16:10:38)
> > > On Thu, Aug 1, 2019 at 12:59 AM Tri Vo <trong@android.com> wrote:
> > > >
> > > > >
> > > > > So why wouldn't something like this suffice:
> > > > >
> > > > > dev =3D device_create_with_groups(wakeup_class, parent, MKDEV(0, =
0), ws,
> > > > >                                 wakeup_source_groups, "wakeup:%s"=
, ws->name);
> > > > >
> > > > > ?
> > > >
> > > > ws->name is inherited from the device name. IIUC device names are n=
ot
> > > > guaranteed to be unique. So if different devices with the same name
> > > > register wakeup sources, there is an error.
> > >
> > > OK
> > >
> > > So I guess the names are retained for backwards compatibility with
> > > existing user space that may be using them?
> > >
> > > That's kind of fair enough, but having two different identification
> > > schemes for wakeup sources will end up confusing.
> >
> > I understand your concern about the IDA now. Thanks for clarifying.
> >
> > How about we name the devices 'wakeupN' with the IDA when they're
> > registered with a non-NULL device pointer and then name them whatever
> > the name argument is when the device pointer is NULL. If we have this,
> > we should be able to drop the name attribute in sysfs and figure out the
> > name either by looking at the device name in /sys/class/wakeup/ if it
> > isn't 'wakeupN', or follow the symlink to the device in /sys/devices/
> > and look at the parent device name there.
>=20
> This makes it difficult for userspace to query the name a wakeup
> source, as it now has to first figure out if a wakeup source is
> associated with a device or not. The criteria for that is also
> awkward, userspase has to check if directory path contains "wakeupN",
> then it's a virtual wakeup source.

I think you mean if it doesn't match wakeupN then it's a virtual wakeup
source?

>=20
> IMO it's cleaner to consistently have /sys/class/wakeup/wakeupN/name
> for every wakeup source.

I don't find it awkward or difficult. Just know what the name of the
/sys/class/wakeup/ path is and then extract the name from there if it
doesn't match wakeupN, otherwise read the 'device' symlink and run it
through basename.

