Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16BC3257470
	for <lists+linux-pm@lfdr.de>; Mon, 31 Aug 2020 09:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgHaHlO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 Aug 2020 03:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgHaHlO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 Aug 2020 03:41:14 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9736EC061573;
        Mon, 31 Aug 2020 00:41:13 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id d11so7106072ejt.13;
        Mon, 31 Aug 2020 00:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=7Z43O8JfZGEOJbTzWct2j97b+Vzag2iDAFjhrBOZbh0=;
        b=S+MWB5xid8EsnfOETftW1wAbWseRY5MXzdNZM9USHLL8XGbBlAeLuQ2FfISqCHQ92x
         8CSeMUqgJhww2DGgnCZ94v9R1b3HLuvlPWvdjFriEP5s7hnW/KRpAWGyrWhXUY/ZJ3HW
         qeC3JxMviUK2YLQsK2gUSk7DAgwpo2y80xuMeQsO4zs60qGdzdWHuVQoIZ5lkAW5YX/1
         kGTCLmizZqGvOe/GediJrnutq/Kz+Cdq9dFAp9XxUTp11PH3QnEWMX2Pj6vrNWSJYFWD
         OiduQgH3tT6FcXc7HmWZ0vHF3jG1qgSYQRNBEQfG2Scg41+jlou8ZoxCYjXW0wD6U7SW
         0exA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=7Z43O8JfZGEOJbTzWct2j97b+Vzag2iDAFjhrBOZbh0=;
        b=j6OS+qXysPwVPskxM6/7Y62IrS8TSmkORHQCUWy4wxgY4c8Jfl6oc3OoOeXCTJWufj
         MrdsM01LlRFIUxNEE9ip0jcn3lvwvPl2Kqi0ttIeO4an8pxD1rYxre2JlhVvRLCZISVc
         Or4aAW9Da9ssbWUtgc1PKbOzW3YTdHjp7R/hTrS0XN6J56/KnKIMq2chzn+3jF0VyVaw
         OZ02gi0gKQKs+hNbxeq1/eMhZkygzu5h4ogyvM+kC0P7rP5wWv4gF5BelyI62JOcggg2
         T7t0h9xikW+vRA6+L0ET/Wa4iPrpr0gKF2KTd53Yb/orDDDcMp092KHiMpl2zG7MVitl
         WkMA==
X-Gm-Message-State: AOAM533+GpfQLXg6Uc/H3LQGGRu7CWqZpNThDrCCQbgIOGJdKD/aQBJI
        pshQGrTG29jOt5PooR0CwP4Yos1huGTcBQ==
X-Google-Smtp-Source: ABdhPJwxxiJehrUW9GHFwB1NqvNIaDSokucVYNCAH43/+KBG9jum7Hb1k5l5vKcsxSDmbwlJRS7Eow==
X-Received: by 2002:a17:906:28c4:: with SMTP id p4mr6211271ejd.345.1598859671637;
        Mon, 31 Aug 2020 00:41:11 -0700 (PDT)
Received: from AnsuelXPS (host-95-235-252-96.retail.telecomitalia.it. [95.235.252.96])
        by smtp.gmail.com with ESMTPSA id fy8sm7466618ejb.9.2020.08.31.00.41.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Aug 2020 00:41:10 -0700 (PDT)
From:   <ansuelsmth@gmail.com>
To:     "'Sibi Sankar'" <sibis@codeaurora.org>,
        "'Viresh Kumar'" <viresh.kumar@linaro.org>
Cc:     <vincent.guittot@linaro.org>, <saravanak@google.com>,
        "'Sudeep Holla'" <sudeep.holla@arm.com>,
        "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        "'Rob Herring'" <robh+dt@kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200821140026.19643-1-ansuelsmth@gmail.com> <20200824104053.kpjpwzl2iw3lpg2m@vireshk-i7> <b339e01f9d1e955137120daa06d26228@codeaurora.org>
In-Reply-To: <b339e01f9d1e955137120daa06d26228@codeaurora.org>
Subject: R: [RFC PATCH v3 0/2] Add Krait Cache Scaling support
Date:   Mon, 31 Aug 2020 09:41:08 +0200
Message-ID: <039d01d67f6a$188700d0$49950270$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: it
Thread-Index: AQHE1KUT8lrzCHz2sVzN5qwVSE5wCwFurxwcAoW98xCpVYZpUA==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



> -----Messaggio originale-----
> Da: sibis=3Dcodeaurora.org@mg.codeaurora.org
> <sibis=3Dcodeaurora.org@mg.codeaurora.org> Per conto di Sibi Sankar
> Inviato: luned=EC 31 agosto 2020 07:46
> A: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Ansuel Smith <ansuelsmth@gmail.com>; vincent.guittot@linaro.org;
> saravanak@google.com; Sudeep Holla <sudeep.holla@arm.com>; Rafael J.
> Wysocki <rjw@rjwysocki.net>; Rob Herring <robh+dt@kernel.org>; linux-
> pm@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Oggetto: Re: [RFC PATCH v3 0/2] Add Krait Cache Scaling support
>=20
> On 2020-08-24 16:10, Viresh Kumar wrote:
> > +Vincent/Saravana/Sibi
> >
> > On 21-08-20, 16:00, Ansuel Smith wrote:
> >> This adds Krait Cache scaling support using the cpufreq notifier.
> >> I have some doubt about where this should be actually placed (clk =
or
> >> cpufreq)?
> >> Also the original idea was to create a dedicated cpufreq driver =
(like
> >> it's done in
> >> the codeaurora qcom repo) by copying the cpufreq-dt driver and =
adding
> >> the cache
> >> scaling logic but i still don't know what is better. Have a very
> >> similar driver or
> >> add a dedicated driver only for the cache using the cpufreq =
notifier
> >> and do the
> >> scale on every freq transition.
> >> Thanks to everyone who will review or answer these questions.
> >
> > Saravana was doing something with devfreq to solve such issues if I
> > wasn't mistaken.
> >
> > Sibi ?
>=20
> IIRC the final plan was to create a devfreq device
> and devfreq-cpufreq based governor to scale them, this
> way one can switch to a different governor if required.

So in this case I should convert this patch to a devfreq driver-=20
Isn't overkill to use a governor for such a task?
(3 range based on the cpufreq?)

> (I don't see if ^^ applies well for l2 though). In the
> interim until such a solution is acked on the list we
> just scale the resources directly from the cpufreq

In this case for this SoC we can't really scale the L2 freq
with the cpu since we observed a bug and we need to switch
back to the idle freq sometimes. Also this SoC use the generic
cpufreq-dt driver and doesn't have a dedicated driver. So we
must use a notifier.

> driver. On SDM845/SC7180 SoCs, L3 is modeled as a
> interconnect provider and is directly scaled from the
> cpufreq-hw driver.
>=20
> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project.

