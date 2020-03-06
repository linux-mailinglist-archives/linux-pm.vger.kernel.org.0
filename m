Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C625C17C1EA
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2020 16:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgCFPfo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Mar 2020 10:35:44 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36968 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgCFPfo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Mar 2020 10:35:44 -0500
Received: by mail-qk1-f194.google.com with SMTP id y126so2674832qke.4
        for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2020 07:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vZAt7EuTcd6oJ9LombqPUkA52Qv+2N3r0RFkmD14qVs=;
        b=rnRXuk5el8Wxi8pXes3tqCH5/QpR/Rfyx0OlYlxa3HVXHOg180fONcRy7EjtlMPSc6
         Th959oJSCvaSPsPNe8hHiHe5eHfue1y+QAR0r0F++RYentyWwx0/REjwEPgM5wwWoPJZ
         lE4hIaC0vKXC8DWEToNeW+yiqPE87K9SF7VBLjxK/1kifBC6Z7TfbtEMkjCGVAkAQYGW
         AGMT4o0Udw8fAL0Mkb4Hy8nMyYIjLQZn112bWXk6zvO6Xwk3SnF30Wj0CSX+Fi9wj1k/
         5g7ggjP1tpiIBXhQlyDvb9B3+irKwyaBTa99/13XO/Bv2tbU/NSaiKeQPVavkVBG1UV/
         mlAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vZAt7EuTcd6oJ9LombqPUkA52Qv+2N3r0RFkmD14qVs=;
        b=JtxrA8N7gwMQqWGt2Av761ZUePHIHmjxLSCVxc6ZE2bBmokl0BhZMTC+fyKCqUgfMX
         25ynOthZWf6UASFgAjLQ76ATM9kvhxnMvAv60Nz6yGwLq7i93f+oK/qHMqbvF46UvC+B
         cMX3Yv80zEciCNPQrCqXKbB8AH+HcDF9sMPo8p+k1E+7ZrCXOpHbVN7td2Wgiw6XZUR8
         SVjR4NonQGEE6XeIjNhqEYkkRfJZpEqr15eaSoM2ZfUNO3avJXSCwVk32T9v8lzDYo3G
         7I0WTQPSsEpi2t6JTP+UxbjajfIxc27HgaTvfQoINHCMQstl5p7QfkOKBhXnPtexgs9i
         29mw==
X-Gm-Message-State: ANhLgQ0utohljjoJv3mEfP+gUHuYwnpr6ZOED3BHUj5exTqQ0zOK2woA
        qKJyi6ypbn46VmXDR/LFoOFhcdsTg9siQ7KLCwW8UA==
X-Google-Smtp-Source: ADFU+vsRwZwD/lvE0ZlhRuoPrPbsAUoOPliB8JM0vcI6fpS+pB2INIGaA49xhcDlqAc7wCKniJIHrrVENoCFi2UYcbg=
X-Received: by 2002:a05:620a:16b8:: with SMTP id s24mr3570871qkj.104.1583508942963;
 Fri, 06 Mar 2020 07:35:42 -0800 (PST)
MIME-Version: 1.0
References: <20200304122312.GE25004@bogus> <CAPDyKFpcN-p6sKqB0ujHAY29qPSg7qpSjYGymPaJ4W8jgCKGcg@mail.gmail.com>
 <20200305162321.GB53631@bogus> <CAPDyKFogjPG+mRsfPaxN7RjB7TQL9=qHNzA=K_t0F6M6Q9-TuA@mail.gmail.com>
 <20200306100431.GA16541@bogus> <CA+M3ks764moVU2h9iZJuN6B-e4wBUMymBfPnob_zraf50xqezA@mail.gmail.com>
 <20200306120646.GB44221@bogus> <CA+M3ks7+P=CjvUE28boANhrR6bhzLzyjBLovzWL_LjwL3UqmzQ@mail.gmail.com>
 <20200306134119.GB47929@bogus> <CA+M3ks5XBFcJqQozA=k6nU2XawRYT_qKnLW9t_GdkoRGNEd1yA@mail.gmail.com>
 <20200306144951.GA11624@bogus>
In-Reply-To: <20200306144951.GA11624@bogus>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Fri, 6 Mar 2020 16:35:32 +0100
Message-ID: <CA+M3ks6=gRj-5Qfe93+2BbECY=cGuj189MQu3yDnib-SbSM7Og@mail.gmail.com>
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

Le ven. 6 mars 2020 =C3=A0 15:50, Sudeep Holla <sudeep.holla@arm.com> a =C3=
=A9crit :
>
> On Fri, Mar 06, 2020 at 03:44:33PM +0100, Benjamin Gaignard wrote:
> > Le ven. 6 mars 2020 =C3=A0 15:23, Sudeep Holla <sudeep.holla@arm.com> a=
 =C3=A9crit :
> > >
> > > On Fri, Mar 06, 2020 at 01:32:59PM +0100, Benjamin Gaignard wrote:
> > > > Le ven. 6 mars 2020 =C3=A0 13:06, Sudeep Holla <sudeep.holla@arm.co=
m> a =C3=A9crit :
> > > > >
> > >
> > > [...]
> > >
> > > > > Sure, please create a deeper CPU state than WFI and enter so that=
 the CPU
> > > > > state is saved and restored correctly. What is the problem doing =
that ?
> > > >
> > > > This state stop the clocks for all the hardware blocks and not only=
 the CPUs
> > > > so we can't go on it while devices aren't suspended.
> > > > I may have missed something but I don't believe that I could add th=
is kind of
> > > > conditions in a cpu idle state, right ?
> > > > In this state I need to be able to enable the wake up sources becau=
se
> > > > it is the only
> > > > for hardware block used as broadcast timer to wake up the system.
> > > >
> > >
> > > We have discussed this in past in the thread I mentioned and may be
> > > others too. It sounds like a broken hardware, sorry if I am wrong.
> > > But this $subject patch is a hack to solve that and I am NACK-ing thi=
s
> > > now. Please fix it adding another CPU level idle state, we are not
> > > supporting without that and there is absolutely no need to.
> >
> > A CPU idle state only take care of CPU activities, right ? but before g=
oing in
> > the targeting state I need to be sure that the other hardware blocks
> > are suspended.
> > Is it possible to describe that in an idle state ?
> > What sound broken ? is it because we need to setup the wake up sources =
?
> >
>
> You said: " In DT I have one system power domain where the hardware block=
s
> (i2c,uart; spi, etc..) are attached + a power per CPU". Now since the CPU
> stays in WFI always in this platform, it means it is always ON and you
> can't vote to power down the magic "system power domain".

CPU power domains are subdomains of the system power domain so they can vot=
e
for the targeting power domain.

>
> --
> Regards,
> Sudeep
