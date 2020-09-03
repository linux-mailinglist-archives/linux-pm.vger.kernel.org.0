Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95A4925C00D
	for <lists+linux-pm@lfdr.de>; Thu,  3 Sep 2020 13:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgICLPK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Sep 2020 07:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728422AbgICLOa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Sep 2020 07:14:30 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506DFC061244;
        Thu,  3 Sep 2020 04:00:35 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id m6so2767866wrn.0;
        Thu, 03 Sep 2020 04:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=SE22zCSVEAoxI5J9vYZxU5jk2PTxW8rlRt79/vsQVMc=;
        b=XHOo/wjgMIAcFXOEpJ8LD3JeyIS06RbRzdhJHQUNQryAsL5MqI9KCGWsJDlWGw6Hww
         0r1qNVory+ouhS3YefBZ3bC51Wemkyd5AZ/T2v3yonZYSLyRjebFpnAJaRXEFjXiWSK/
         DUUTknp8LIhWqVy8rhgEG9QW/cAssbuWgMFTs1OW7xUnSOUXWh1vBvG4/utmhUmshssd
         ZolOYsiKduKgb0bRlz0wzBCTQfC/r6haJPeN3CvbPf70QjElIk39PqgeTz7KA4Ts2JVK
         7t/MN3sATXo6IDk0wOjGSMRLimJGPLXCz3gIfStJcaNtRUWwumRdA8PcXB/BBbd6Devf
         o0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=SE22zCSVEAoxI5J9vYZxU5jk2PTxW8rlRt79/vsQVMc=;
        b=QTgzdgoYHeT45eXk00gc8Bc4McewHo3odEFQSSeUJ59oYewiSQfrCgkNJ4hvgPFuff
         C4uPqc6vlpFGWpux7uN700of+KA1UoW7IBdPaloyxi12K/e5UGmvrIoo3yteHVLFEzfD
         9Oz8SrYHosODRAKCatImudy9W5MwZX+K+ayu7HBc7NIMTzMR9+AK+R2YQ6qmFLoH8AIR
         HmUYSWUcwvcp3/ap+iCp2tfVNPxihflKV4Bn0/zp5dfAvC0xXKqznatWudos8aMLoTQ5
         USgFvd01UnssCMgOr+ay/4trHbRR8vsNr00GP77ofmr+lI031xmj56wTaV8+ovLsU62Z
         PBGg==
X-Gm-Message-State: AOAM5314cMMjEe/AAPItmX83AERq3F8O1MXHhU0QJE8LX2RcTxD5NZgN
        IaHmu2sQNujaRfmal91xAGXnnSKkHuxTyg==
X-Google-Smtp-Source: ABdhPJzT2JR3cqHJJ+PeIDEiZWnus85LDjLyqQxGZLcJGgQ0N86n6iNc76LXufOFcTVgGQkidXI/BA==
X-Received: by 2002:adf:e7ce:: with SMTP id e14mr1741534wrn.43.1599130833155;
        Thu, 03 Sep 2020 04:00:33 -0700 (PDT)
Received: from AnsuelXPS ([5.170.166.111])
        by smtp.gmail.com with ESMTPSA id s5sm3876136wrm.33.2020.09.03.04.00.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Sep 2020 04:00:32 -0700 (PDT)
From:   <ansuelsmth@gmail.com>
To:     "'Sibi Sankar'" <sibis@codeaurora.org>,
        "'Viresh Kumar'" <viresh.kumar@linaro.org>
Cc:     <vincent.guittot@linaro.org>, <saravanak@google.com>,
        "'Sudeep Holla'" <sudeep.holla@arm.com>,
        "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        "'Rob Herring'" <robh+dt@kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200821140026.19643-1-ansuelsmth@gmail.com> <20200824104053.kpjpwzl2iw3lpg2m@vireshk-i7> <b339e01f9d1e955137120daa06d26228@codeaurora.org> <039d01d67f6a$188700d0$49950270$@gmail.com> <20200903065314.y3ynhwydahaeg6o6@vireshk-i7> <6dc62d231c776b2cdfdc36cfe36e4140@codeaurora.org>
In-Reply-To: <6dc62d231c776b2cdfdc36cfe36e4140@codeaurora.org>
Subject: R: R: [RFC PATCH v3 0/2] Add Krait Cache Scaling support
Date:   Thu, 3 Sep 2020 13:00:27 +0200
Message-ID: <01f201d681e1$70ff1bc0$52fd5340$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHE1KUT8lrzCHz2sVzN5qwVSE5wCwFurxwcAoW98xABeMrvawKX8ba/Aay9QdupLIiWEA==
Content-Language: it
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



> -----Messaggio originale-----
> Da: sibis=3Dcodeaurora.org@mg.codeaurora.org
> <sibis=3Dcodeaurora.org@mg.codeaurora.org> Per conto di Sibi Sankar
> Inviato: gioved=EC 3 settembre 2020 09:13
> A: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: ansuelsmth@gmail.com; vincent.guittot@linaro.org;
> saravanak@google.com; 'Sudeep Holla' <sudeep.holla@arm.com>; 'Rafael =
J.
> Wysocki' <rjw@rjwysocki.net>; 'Rob Herring' <robh+dt@kernel.org>; =
linux-
> pm@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Oggetto: Re: R: [RFC PATCH v3 0/2] Add Krait Cache Scaling support
>=20
> On 2020-09-03 12:23, Viresh Kumar wrote:
> > On 31-08-20, 09:41, ansuelsmth@gmail.com wrote:
> >> On 31-08-20, Sibi wrote:
> >> > On 2020-08-24 16:10, Viresh Kumar wrote:
> >> > > +Vincent/Saravana/Sibi
> >> > >
> >> > > On 21-08-20, 16:00, Ansuel Smith wrote:
> >> > >> This adds Krait Cache scaling support using the cpufreq =
notifier.
> >> > >> I have some doubt about where this should be actually placed =
(clk
> or
> >> > >> cpufreq)?
> >> > >> Also the original idea was to create a dedicated cpufreq =
driver
(like
> >> > >> it's done in
> >> > >> the codeaurora qcom repo) by copying the cpufreq-dt driver and
> adding
> >> > >> the cache
> >> > >> scaling logic but i still don't know what is better. Have a =
very
> >> > >> similar driver or
> >> > >> add a dedicated driver only for the cache using the cpufreq
notifier
> >> > >> and do the
> >> > >> scale on every freq transition.
> >> > >> Thanks to everyone who will review or answer these questions.
> >> > >
> >> > > Saravana was doing something with devfreq to solve such issues =
if I
> >> > > wasn't mistaken.
> >> > >
> >> > > Sibi ?
> >> >
> >> > IIRC the final plan was to create a devfreq device
> >> > and devfreq-cpufreq based governor to scale them, this
> >> > way one can switch to a different governor if required.
> >>
> >> So in this case I should convert this patch to a devfreq driver-
> >
> > I think this should happen nevertheless. You are doing DVFS for a
> > device which isn't a CPU and devfreq looks to be the right place of
> > doing so.
> >
> >> Isn't overkill to use a governor for such a task?
> >> (3 range based on the cpufreq?)
> >
> > I am not sure about the governor part here, maybe it won't be =
required
> > ?
>=20
> Yeah I don't see it being needed in ^^
> case as well. I just mentioned them as
> an advantage in case you wanted to switch
> to a different governor in the future.
>=20
> https://lore.kernel.org/lkml/d0bc8877-6d41-f54e-1c4c-
> 2fadbb9dcd0b@samsung.com/
>=20
> A devfreq governor tracking cpufreq was
> generally accepted but using a cpufreq
> notifier to achieve that was discouraged.
>=20

I read the patch discussion and it looks like at the very end they
lost interest in pushing it. That would very fit what I need here so
I'm asking how should I proceed? Keep the cpufreq notifier?
Introduce a dedicated governor? Ask them to resume the pushing or
try to include the changes to the passive governor by myself?=20

> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project.

