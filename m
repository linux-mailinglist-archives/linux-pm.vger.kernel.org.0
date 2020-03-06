Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E30E117C0CA
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2020 15:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbgCFOoq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Mar 2020 09:44:46 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38544 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgCFOop (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Mar 2020 09:44:45 -0500
Received: by mail-qt1-f193.google.com with SMTP id e20so1866171qto.5
        for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2020 06:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=518hMwbsCsnyP/dB9C2/OgbWz00OdebKwI9UeSAw2TQ=;
        b=UKn3ZOmHliESQFL4acmMtFs6xNMVgD2SYN401x8G989e969hHmIOBDhUUkzPbvn2ze
         t8iUUEi8b2Pi5GNrW7Rt0fOtIbgOJ7yxdNxXDIOQOQh/kDQtHBi5IFKikg4ciABcKkRN
         Q7Nv3kYSXtRPYepWvOl6k241BTN+Hc6ouBTMLUI9T46c2tdUHy+72JLrQ1YnxD4y2gQH
         x2VGkLZeS98C636ScvmdZ18jX0reOyV8e0LjHL3G3jtvRRkx7kiQDtznF2sxBMB+ODB/
         FX8+EHMdl8FKzPNrGOqOxJXa1pSnlFcIFD5Wah3u5qWtlIBdHeUFdoPkl4ipsE5LeFy9
         fwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=518hMwbsCsnyP/dB9C2/OgbWz00OdebKwI9UeSAw2TQ=;
        b=ovd5MKTKn8F25Ua2l03iX3QH/pjia7F6+1cINUfcFUKqYalhM1QxwmOjOOkqXCm7N1
         1UhtOAA3VM1/513TFn9JO3ZEaauhCJphbdI4tp5oPX5j3kfhc+1DP6Pqt8oqtdu7qnmq
         trgk3xmdoUiqN/trn+/k47BXPhPtRMJT8+3flRxrZDgGL7sRKQp36GRh/Ko+1s8gimt1
         vcNdSuS2hropBuxOBrLyrzzTqnzA+m0hpUgKn9ox1fwdLz7uCpI0gPFUrGEacZWChEY2
         jKI6VSAobctizHII2Ah3YT9tak03D2aerhLK10/ahPLG/qLbNqnUT64a1NkAb6C/EjS5
         x/3A==
X-Gm-Message-State: ANhLgQ26gUP88zlVgkO+S3Sy9ENNI1PshW2xdRZ6IZKfdUZ5bHNW9+bv
        OWWhBVFdHGBGxC6NUg24vIbqmtmtIFT6nB8CflY82w==
X-Google-Smtp-Source: ADFU+vu4U/dNx0QcNZ2vEVN12gifYuQ7Fr8ARH3ry0S07HX1FFcS8SFZtPwPvlsBxyvk8A6DHHwNRQC4nAghZCJ4Xvc=
X-Received: by 2002:aed:3f3c:: with SMTP id p57mr3299105qtf.234.1583505884448;
 Fri, 06 Mar 2020 06:44:44 -0800 (PST)
MIME-Version: 1.0
References: <20200303203559.23995-1-ulf.hansson@linaro.org>
 <20200303203559.23995-5-ulf.hansson@linaro.org> <20200304122312.GE25004@bogus>
 <CAPDyKFpcN-p6sKqB0ujHAY29qPSg7qpSjYGymPaJ4W8jgCKGcg@mail.gmail.com>
 <20200305162321.GB53631@bogus> <CAPDyKFogjPG+mRsfPaxN7RjB7TQL9=qHNzA=K_t0F6M6Q9-TuA@mail.gmail.com>
 <20200306100431.GA16541@bogus> <CA+M3ks764moVU2h9iZJuN6B-e4wBUMymBfPnob_zraf50xqezA@mail.gmail.com>
 <20200306120646.GB44221@bogus> <CA+M3ks7+P=CjvUE28boANhrR6bhzLzyjBLovzWL_LjwL3UqmzQ@mail.gmail.com>
 <20200306134119.GB47929@bogus>
In-Reply-To: <20200306134119.GB47929@bogus>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Fri, 6 Mar 2020 15:44:33 +0100
Message-ID: <CA+M3ks5XBFcJqQozA=k6nU2XawRYT_qKnLW9t_GdkoRGNEd1yA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] cpuidle: psci: Allow WFI to be the only state for
 the hierarchical topology
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Lina Iyer <ilina@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Le ven. 6 mars 2020 =C3=A0 15:23, Sudeep Holla <sudeep.holla@arm.com> a =C3=
=A9crit :
>
> On Fri, Mar 06, 2020 at 01:32:59PM +0100, Benjamin Gaignard wrote:
> > Le ven. 6 mars 2020 =C3=A0 13:06, Sudeep Holla <sudeep.holla@arm.com> a=
 =C3=A9crit :
> > >
>
> [...]
>
> > > Sure, please create a deeper CPU state than WFI and enter so that the=
 CPU
> > > state is saved and restored correctly. What is the problem doing that=
 ?
> >
> > This state stop the clocks for all the hardware blocks and not only the=
 CPUs
> > so we can't go on it while devices aren't suspended.
> > I may have missed something but I don't believe that I could add this k=
ind of
> > conditions in a cpu idle state, right ?
> > In this state I need to be able to enable the wake up sources because
> > it is the only
> > for hardware block used as broadcast timer to wake up the system.
> >
>
> We have discussed this in past in the thread I mentioned and may be
> others too. It sounds like a broken hardware, sorry if I am wrong.
> But this $subject patch is a hack to solve that and I am NACK-ing this
> now. Please fix it adding another CPU level idle state, we are not
> supporting without that and there is absolutely no need to.

A CPU idle state only take care of CPU activities, right ? but before going=
 in
the targeting state I need to be sure that the other hardware blocks
are suspended.
Is it possible to describe that in an idle state ?
What sound broken ? is it because we need to setup the wake up sources ?

>
> --
> Regards,
> Sudeep
