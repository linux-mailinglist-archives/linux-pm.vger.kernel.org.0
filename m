Return-Path: <linux-pm+bounces-4987-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D25C87CFD2
	for <lists+linux-pm@lfdr.de>; Fri, 15 Mar 2024 16:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB1EAB22B55
	for <lists+linux-pm@lfdr.de>; Fri, 15 Mar 2024 15:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868CF3BBCD;
	Fri, 15 Mar 2024 15:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zd0qOD8J"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0953CF40
	for <linux-pm@vger.kernel.org>; Fri, 15 Mar 2024 15:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710515298; cv=none; b=Nz7AOBUc0x0uM13O9gC02GtF7TwAclhcjj3orUqdAb30rXaKDwTDd/exqymJgGZxFjCasFByvquFiKr4Q877zQ6ipjyyzBtIim2e6e4NcItdNCJ2PasWF8dkCXTLxOw/YVENtspPhOIag6wFXtX10ObHxeGX5C5lkmK70d0EQaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710515298; c=relaxed/simple;
	bh=1p+2qEhn/qrjk/VPCWJTzuUwNlO3E+p95QBrqAO/oNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mxwVY8Qr+1bDnPNIIO/0czab9//2UqVrtsnTAdHXxpJAsSnMqyBZFW3WeJ5v7i5cPN/16aFCHbvkm1y8DxVabEOcf1BToywce3aE58mDpwujF37Kj7OnOpAPiyUL5O7KKZLC4CqQ99IcVBeA8b/GKgELJcr/WrYAoNCyt6NRheQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Zd0qOD8J; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-789ddcd57f4so108617685a.2
        for <linux-pm@vger.kernel.org>; Fri, 15 Mar 2024 08:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710515294; x=1711120094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GSZdYN59DhOS8QyekeyWoGZ8e/VbiOIdQPzuTpNSPUk=;
        b=Zd0qOD8J4wpSz9bHCqS+4f5svRDAaWKkvBxOT8InfDa92eoDMLCYQGW78MKyBm3Czp
         pBX6uphgmFEFW7yRj17oQ+wqDqdt65HIfaELTgQMOmXNIfYy72w4v+qsEieDM1uq9yIY
         ztPqDYNb1cBJuMOXc3mFwMnO7DhkWJSfZUF1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710515294; x=1711120094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GSZdYN59DhOS8QyekeyWoGZ8e/VbiOIdQPzuTpNSPUk=;
        b=RYqX5jvhWcYu0+fvzKUWi8PLSUnS0LMZcLSCY/cucQluSUgPhvbkQSLEvWNikgxMPw
         ZuFWGwjL/fmjTwNx5AG/bMVmf+f6lo0O46dnc1Gfqo0GnFk2sgVdyDLJ5sAXwS9wkRfF
         m+xamfPA7LZFG/F5O8tJYA2dY/mG0xMl70n4WACZjsEh5zlmv98UFaxOKaEvukQnrlvc
         Ti9CL4qC/s5bp0PIx0ITYYAZEtCOTcTnyKcuVW4Fl9czA5aHwT2oYyD1RZtcJrrs2dVY
         VB/gJBrwnXwGL44YJFo+G87qpCY0NXFNrvGVVnmBCyGryOPjh8iDYQUhV9I8yAaL4spr
         1AWA==
X-Forwarded-Encrypted: i=1; AJvYcCX/vSLbs5762aqWOs/b9jRe8wnEsZDmJRr2bW7bXvKLD9YNI6ABBZWzIPXsCCumuqxb6ZOqVTHiNfr4zJmxedZrMo0jgLwUa90=
X-Gm-Message-State: AOJu0Yzn4ej67LbEpb9UzTEOhxWGvCKdUISe4CbIsbmMHdXevF+3jXrV
	qu0u9fh03fAUtKjIZ1YzLpXbMrBFIUnpgiQVVAeFMMdI/1SoL8Pkv1KUftHxPOQQAj8DS8yD+hQ
	=
X-Google-Smtp-Source: AGHT+IGyrzONAe/Z8wKU2ocdxmUiO1LkyJv0i9gtOtO3i0QMO+aWuAqAUSShwRTguZeBrhZaOB1MsQ==
X-Received: by 2002:a37:e30c:0:b0:789:e737:81c8 with SMTP id y12-20020a37e30c000000b00789e73781c8mr1307424qki.15.1710515293906;
        Fri, 15 Mar 2024 08:08:13 -0700 (PDT)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com. [209.85.160.171])
        by smtp.gmail.com with ESMTPSA id g28-20020a05620a13dc00b0078829ce9716sm2120293qkl.78.2024.03.15.08.08.12
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 08:08:12 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-42ee0c326e8so328031cf.0
        for <linux-pm@vger.kernel.org>; Fri, 15 Mar 2024 08:08:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXE++5YL40+2CpVo0FXpSWYVebs5lnR/HFAGS2shNC7txIwRTsMoEixzlY1mSjg6F1GVtac0pnWdrJ2MrtUbsjlx6131/mgGLg=
X-Received: by 2002:a05:622a:292:b0:430:b2ee:d6bf with SMTP id
 z18-20020a05622a029200b00430b2eed6bfmr193108qtw.25.1710515292052; Fri, 15 Mar
 2024 08:08:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230703085555.30285-1-quic_mkshah@quicinc.com>
 <20230703085555.30285-4-quic_mkshah@quicinc.com> <CAD=FV=XWH+Eoa9XjDns--NSDTZHeUwTdrX_r_QZhSPpbZNwz+w@mail.gmail.com>
 <f638e848-36c5-4cea-c2c8-841a003b1863@quicinc.com>
In-Reply-To: <f638e848-36c5-4cea-c2c8-841a003b1863@quicinc.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 15 Mar 2024 08:07:56 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XgwrFWZ7uQ1fQbykyipFmyZB6nyJnKmS1s=hdAANd-gg@mail.gmail.com>
Message-ID: <CAD=FV=XgwrFWZ7uQ1fQbykyipFmyZB6nyJnKmS1s=hdAANd-gg@mail.gmail.com>
Subject: Re: [RESEND v4 3/3] arm64: dts: qcom: sc7280: Add power-domains for
 cpuidle states
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Maulik Shah <quic_mkshah@quicinc.com>, andersson@kernel.org, ulf.hansson@linaro.org, 
	swboyd@chromium.org, wingers@google.com, daniel.lezcano@linaro.org, 
	rafael@kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, sudeep.holla@arm.com, 
	jwerner@chromium.org, quic_lsrao@quicinc.com, quic_rjendra@quicinc.com, 
	devicetree@vger.kernel.org, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Rob Clark <robdclark@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 14, 2024 at 4:39=E2=80=AFPM Abhinav Kumar <quic_abhinavk@quicin=
c.com> wrote:
>
> Hi Doug
>
> On 3/14/2024 4:20 PM, Doug Anderson wrote:
> > Hi,
> >
> > On Mon, Jul 3, 2023 at 1:56=E2=80=AFAM Maulik Shah <quic_mkshah@quicinc=
.com> wrote:
> >>
> >> Add power-domains for cpuidle states to use psci os-initiated idle sta=
tes.
> >>
> >> Cc: devicetree@vger.kernel.org
> >> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> >> Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
> >> ---
> >>   arch/arm64/boot/dts/qcom/sc7280.dtsi | 98 +++++++++++++++++++++-----=
--
> >>   1 file changed, 73 insertions(+), 25 deletions(-)
> >
> > FWIW, I dug up an old sc7280-herobrine board to test some other change
> > and found it no longer booted. :( I bisected it and this is the change
> > that breaks it. Specifically, I can make mainline boot with:
> >
> > git revert --no-edit db5d137e81bc # arm64: dts: qcom: sc7280: Update
> > domain-idle-states for cluster sleep
> > git revert --no-edit 7925ca85e956 # arm64: dts: qcom: sc7280: Add
> > power-domains for cpuidle states
> >
>
> We noticed that some variants of sc7280 herobrine boards didnt boot but
> some did atleast till linux 6.8 rc-6. I have not tested linux 6.9 rc-1 ye=
t.

Wow, really? This doesn't seem like it would be related to the
variant. Maybe the firmware version? FWIW, the device I was having
problems with was a "villager-rev2" with FW 15368.0.0.

OK, so I just pulled out a `hoglin-rev5` with 15432.0.0 and v6.8-rc6
boots and WiFi comes up. However, when I move to full mainline
(b0546776ad3f (HEAD, linux/master) Merge tag 'printk-for-6.9' of
git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux) I get the
ath11k crash.

OK, so I updated my villager to 15432.0.0 and things work even without
reverting ${SUBJECT} patch. I guess that's the answer: this patch
broke things with some old firmwares but with the newer firmware it's
fixed. Hopefully that doesn't happen again since I don't think there
will ever be a newer firmware than 15432.0.0.


> > (I get an ath11k crash after that, but that's easy to hack out since I
> > don't need WiFi)
> >
>
> hmm, wifi worked alright on 6.8 rc-6 for us.

I guess I'll leave it to you to track down / report as needed.


> > I suppose the two options here are to either:
> >
> > 1. Track the problem down and figure out why the breaks boot and then
> > fix it. I'm personally not going to track this down, but if someone
> > wants me to test a patch I can do that.
> >
>
> Can Maulik help us do that?

OK, sounds like we don't need to, as long as everyone updates their
firmware. This should be OK.


> > 2. Delete all the herobrine dts files.
> >
> > So far we've been keeping the herobrine dts files alive because I
> > thought some graphics folks (Rob, Abhinav, Jessica, for instance) were
> > still using it. ...but Rob says he hasn't booted his in a while. No
> > idea if Abhinav and Jessica are using theirs. Any opinions? Is
> > herobrine hardware support near and dear to anyone these days?
> >
>
> Yes, so we have been using sc7280 herobrine devices even till the last
> cycle and quite a bit of feature development was actually done on that.
>
> It was the only device having eDP other than sc8280xp till x1e80100
> landed last cycle.

OK, thanks for confirming that they're still useful to you. When I got
the failures I feared that nobody was using them anymore.


> I do want to start using sc8280xp as well because from the experience we
> got, it has more visibility in terms of users. So that will address my
> eDP concern.
>
> But, the nice thing about chromebooks is we really like to use them for
> IGT development / CI debug as CrOS provides a nice environment to
> cros-deploy IGT.
>
> We can continue to use sc7180 for IGT development but if we want to
> debug issues with eDP + IGT, sc7280 is a really useful platform for that.
>
> sc8280xp or x1e80100 is not a CrOS supported device. So we will have to
> develop and test IGT directly on the device (which is a bit of a pain)
> unless someone has a better way of "cross-compilation" for IGT on
> non-CrOS images.

I'd have to let others comment on IGT.

-Doug

