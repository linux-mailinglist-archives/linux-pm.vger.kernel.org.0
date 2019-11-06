Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64ED2F1E3C
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2019 20:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbfKFTIi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Nov 2019 14:08:38 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:32991 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728263AbfKFTIi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Nov 2019 14:08:38 -0500
Received: by mail-pg1-f196.google.com with SMTP id h27so841630pgn.0
        for <linux-pm@vger.kernel.org>; Wed, 06 Nov 2019 11:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:to:cc:user-agent:date;
        bh=BaqbKobe0jxjSSf8ASCculhZ9lF+9i0oqNNSuq7LJSc=;
        b=k7NGxK51P0gq6/cVH8RnI35juHOis4+iMWtlorN4LInlpsFGO/3NaqjXNq9VUeTCH8
         ZEhmUoKVLpz0jUlnjNh+/TZ6r7XrEViRFU+ZCtB8F7lhS8OKBOU/RfYJPa1fnOsAkV5S
         lq5RqIinLZVDUI1ct+5W1pbtzutHgvpoQIJcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:to:cc
         :user-agent:date;
        bh=BaqbKobe0jxjSSf8ASCculhZ9lF+9i0oqNNSuq7LJSc=;
        b=PIwwcs+vJ12QdPjy+y0115ynzZ9VJwCUkNMgor2NeZAesdDp823rpT1ABWHAQMHhGa
         T4pm+s3k1N19BkKKiy25vlArm3xfwXYJ5WFOfLb22dLY8Jjhyws3T8Wu9AYJl1NPavRK
         zUAcQepkhklKjluZEAluk7/xJLz3iyc99+EQgXdsKn/83SmBskZkZ0QGBMOGvHqiyP5z
         aE4DQr12AEDfwdJp+Bt/yF3rp4SUVOoPn2MouRLEE0nBvVL0fK6WLvCOH8o/GJuzpYop
         kav43SYitdUbf/jZG2Nk5RrCZi++vp4PSRTnBP0Hjm+PRtM1GOMUpIG6nV655/MRwN/q
         kIWw==
X-Gm-Message-State: APjAAAUfMtKNEYaLdcqGAeJcPs+cFNlVHCSqKK7Po4+QQtCvtgZHOXTR
        s6ZOokPHfx2x2zSuzUthwvkULg==
X-Google-Smtp-Source: APXvYqySn9ZQK5mxiOTmHd4DqsJ+as1T8d47lJL0ESCaVp9l09y2Av93H7o78ZtWWtMB21Ub5sHMRg==
X-Received: by 2002:a17:90a:2065:: with SMTP id n92mr6061627pjc.20.1573067316837;
        Wed, 06 Nov 2019 11:08:36 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id c21sm23764032pgh.25.2019.11.06.11.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 11:08:35 -0800 (PST)
Message-ID: <5dc31a33.1c69fb81.c563.2043@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <507d1769-41ba-749a-cafa-d178128bbb8b@codeaurora.org>
References: <20190905091707.14420-1-mkshah@codeaurora.org> <5d7155f2.1c69fb81.61bf.f862@mx.google.com> <507d1769-41ba-749a-cafa-d178128bbb8b@codeaurora.org>
Subject: Re: [PATCH v2] soc: qcom: Introduce subsystem sleep stats driver
From:   Stephen Boyd <swboyd@chromium.org>
To:     Maulik Shah <mkshah@codeaurora.org>, agross@kernel.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        dianders@chromium.org, rnayak@codeaurora.org, ilina@codeaurora.org,
        lsrao@codeaurora.org
User-Agent: alot/0.8.1
Date:   Wed, 06 Nov 2019 11:08:34 -0800
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Maulik Shah (2019-11-06 01:22:14)
>=20
> On 9/6/2019 12:07 AM, Stephen Boyd wrote:
> > Quoting Maulik Shah (2019-09-05 02:17:07)
> >> +
> >> +static inline ssize_t subsystem_stats_print(char *prvbuf, ssize_t len=
gth,
> >> +                                           struct subsystem_stats *re=
cord,
> >> +                                           const char *name)
> >> +{
> >> +       return scnprintf(prvbuf, length, "%s\n\tVersion:0x%x\n"
> >> +                       "\tSleep Count:0x%x\n"
> >> +                       "\tSleep Last Entered At:0x%llx\n"
> >> +                       "\tSleep Last Exited At:0x%llx\n"
> >> +                       "\tSleep Accumulated Duration:0x%llx\n\n",
> >> +                       name, record->version_id, record->count,
> >> +                       record->last_entered, record->last_exited,
> >> +                       record->accumulated_duration);
> > Information in sysfs is supposed to be one value per file. This is a
> > bunch of different values and it includes a version field. Looks almost
> > like something we would put into /proc, but of course that doesn't make
> > any sense to put in /proc either.
> >
> > Please rethink the whole approach here. Can this be placed under the
> > remoteproc nodes for each remote processor that's in the system? That
> > would make it more discoverable by userspace looking at the remoteproc
> > devices. I suppose GPU and DISPLAY aren't "remoteproc"s though so maybe
> > this should be a new 'class' for devices that have an RPMh RSC? Maybe
> > make a qcom_rpmh_rsc class and then have these be stats in there.
>=20
> since stats can be used by userspace for the purpose of computing=20
> battery utilization /sys/power seems to be good place to keep it to me.
>=20
> Adding it under class may require it=C2=A0 to be device. we are using it =
only=20
> as module.
>=20

I believe /sys/power is for the power management subsystem, not
specifically battery utilization or remote processor power states.
Wouldn't battery be /sys/class/power_supply? Why not put this underneath
some /sys/class/remoteproc or so?

> >> +               kobject_put(prvdata->kobj);
> >> +               kfree(prvdata);
> >> +               return ret;
> >> +       }
> >> +
> >> +       return ret;
> >> +}
> >> +
> >> +static void __exit subsystem_sleep_stats_exit(void)
> >> +{
> >> +       sysfs_remove_file(prvdata->kobj, &prvdata->ka.attr);
> >> +       kobject_put(prvdata->kobj);
> >> +       kfree(prvdata);
> >> +}
> >> +
> >> +module_init(subsystem_sleep_stats_init);
> > So if this is compiled into an arm/arm64 image that doesn't include qcom
> > platform support it will create this directory? That's just nonsensical.
>=20
> Kconfig depends on QCOM_SMEM which inturn depends on ARCH_QCOM to get=20
> compiled into.
>=20
> It won't get compiled for other than qcom platforms.

Sure it won't get compiled for anything that doesn't have ARCH_QCOM
enabled, but it can run on a board or SoC that isn't qcom. That's the
concern.

