Return-Path: <linux-pm+bounces-33706-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA151B41DBA
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 13:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FE58684DA1
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 11:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905F32FFDDE;
	Wed,  3 Sep 2025 11:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZomjYUrG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97E12FFDC9;
	Wed,  3 Sep 2025 11:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756900288; cv=none; b=BgrBJezbcKeAfhe42yGfaJrrgAv9DDOmkVd2MbB5Ojyp7UgW/Lv5L2NLa/A3LQ8F7H0iKHC6J6JHKvBI9O72bAji2eGt3g+2jU0/LK8HYZAOcUJpREH5sC9Km8R5SCRWnF25hc844OVvofka+uHke1EQZy7YPpNKuvS8BrB5PSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756900288; c=relaxed/simple;
	bh=1Z8SZEncw7tBGbQStmROPc1U7TqEyR8wI4U8vcoMmpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z1094daSVCTEH4aKVrUYP1563ozLU+3nlcYdXKbwC6fCQq3B8CAeV6Qi/ybmZ1+w8vfHCb8dLW5oTi63h3QR4k8F8ffJr5aoBukHAaeyaTMaW7m2DDWrnnjletBqzjWhDu3pZl7JKR5Uw8CtM7mLRIXtOwlHXB/6H/1Z2x4ElsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZomjYUrG; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5449432a9d7so2039399e0c.3;
        Wed, 03 Sep 2025 04:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756900285; x=1757505085; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KG/GG5WI92QmsMWA+qAHX/u6m8W8YnChxIQMgYM9v3s=;
        b=ZomjYUrGlShA20wkRXUNTNyS2q5miCD0xm9pHVHAlAaFf3yvWzElpTk5k9SRjlxmOq
         IORmZzWun3sdSY1/X6KFUbjLGU+PYxPSqv/niCx9pBGBlV4JAuj9+WpW2+ek1FMDFsj+
         jAOcohmUblm6Jiiba4nX3j5Kd9PwtHE33djtuX5bJmSrTDGvLuXu5kx8wqv0G85qnEHq
         N1WLX3V7QbAaoA40W7mXyrAKqXxD1geb0RRIjV1crctBvwcQnadzEKWANSoyjWCK3cEl
         ok4AUpzkp0L0yZOC2T9UcHZi6LeSb20PeI8uiiDk1BI2Ct2GdfY1J7othhOpkUA0z6S5
         QjDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756900285; x=1757505085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KG/GG5WI92QmsMWA+qAHX/u6m8W8YnChxIQMgYM9v3s=;
        b=KudmwmVnHoY216q4srBGZDoTkFOeVoShsI4w04pFXOLvE6LwAHOzwOQPJ93Ly/MBg7
         mPH98ku+nJtFzmKOJOErQpZoE0PAdvaGPZApLdDp2eBRJP++TOsoU52kk/uQ3ll873//
         vceb4a2qb1vzbOqsMxBQYsYGG1+5NMh9Sr42fp2JeVvPh5eIO5y2eNN5klQ4VvYzBME3
         gH8k4+Ghtjh/CsIZ74ahMPSss79KpPqepW5RDQOomFSg0/O8hmNjR5u95vSMLPtIV25f
         eNUCU5azW+yQHFtlKrkncAzpWNuBYINPVY9aB9ILFBuAw4X410L3u2KzCc5kBQEgeiqV
         01HA==
X-Forwarded-Encrypted: i=1; AJvYcCVQtKkOTtGwlnHVi11p+v6IQcY3IleV6RQLmKsmlQTyNAr+vtC1idFCOZIkbo0i7UJMxwOVuFIm3XttHLY=@vger.kernel.org, AJvYcCVnt82opgQkV6jEXol/wyPGQ9S4olwamA4nzomu3DNFdaxDhEyItDDCrlTPASuD3x5rccIItNm6JT6H@vger.kernel.org, AJvYcCW0RyQYVAOKaEW/oHjBk+ilEDFjwaljBpa6KJmQ3QPcCyZmAHbEXhxRRV8FojqDOxDtvR9fdwQraHo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+ts7dowTUpzCSfBvYfcVTvT7hviSKEulxStfV/xJXAjR8sF/s
	Q5elc3PmwLoGjrr1dMVvhyPQWo/10bsyO52Gr2zl0JHKlV2iOe5sXQqUSCx4avlk3doMR8NmlxS
	aXA7cwCny4AHwAFB49W2223H7kbOHYw7aKVVRSa+WCQ==
X-Gm-Gg: ASbGncu1epnIbA3KRAzoTaJny5gDcDTCmX7NKj+WixFS3rIj43USpWN+beOW77Iy3FR
	MCxtVmqaH0hqY+rt3ggjwmb67LIqNG214qmGbcXy6JYe/zvRK3u6eKBOVDg/twR4+D92pGOUVYG
	EIZHKbKFsVJ6/P2878XN3d3DxExwt/dOKr0Wb31LI5dHnoE7MO0s8BgKfX3YeN88RgX+lv1z4Bx
	phqgfKRqvsqouZy/7GAHYg=
X-Google-Smtp-Source: AGHT+IHuEs81FFipYz0jk66WrkA0VYYvXxkKkQVbbDcC/pneAy6OjYjnwENV4Q47x2+EkdGNRr/7NiTZNltZ3pTRRNQ=
X-Received: by 2002:a05:6122:2217:b0:543:c44d:c1ed with SMTP id
 71dfb90a1353d-544a0255f04mr4790044e0c.10.1756900285565; Wed, 03 Sep 2025
 04:51:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+zupgwnbt=5Oh28Chco=YNt9WwKzi2J+0hQ04nqyZG_7WUAYg@mail.gmail.com>
 <CAPwe5RMpdG1ziRAwDhqkxuzHX0x=SdFQRFUbPCVuir1OgE90YQ@mail.gmail.com>
 <5d692b81-6f58-4e86-9cb0-ede69a09d799@rowland.harvard.edu>
 <CAJZ5v0jQpQjfU5YCDbfdsJNV=6XWD=PyazGC3JykJVdEX3hQ2Q@mail.gmail.com>
 <20250829004312.5fw5jxj2gpft75nx@synopsys.com> <e3b5a026-fe08-4b7e-acd1-e78a88c5f59c@rowland.harvard.edu>
 <CAJZ5v0gwBvC-y0fgWLMCkKdd=wpXs2msf5HCFaXkc1HbRfhNsg@mail.gmail.com>
 <f8965cfe-de9a-439c-84e3-63da066aa74f@rowland.harvard.edu>
 <CAJZ5v0g9nip2KUs2hoa7yMMAow-WsS-4EYX6FvEbpRFw10C2wQ@mail.gmail.com>
 <CAJZ5v0gzFWW6roYTjUFeL2Tt8kKJ_g5Q=tp2=s87dy05x-Hvww@mail.gmail.com> <38b706cc-5966-4766-9165-51935fdcd790@rowland.harvard.edu>
In-Reply-To: <38b706cc-5966-4766-9165-51935fdcd790@rowland.harvard.edu>
From: ryan zhou <ryanzhou54@gmail.com>
Date: Wed, 3 Sep 2025 19:51:14 +0800
X-Gm-Features: Ac12FXwm_mD1EWV17Y1ti0MZVGTnd5WtTf1pA6MdY1yndiDiEw7TDEB6M03beKc
Message-ID: <CAPwe5RM85di_ibJtt3Da+CUW9ZS_GhkXqdEgJssu_k+xjMSdmw@mail.gmail.com>
Subject: Re: [PATCH] drvier: usb: dwc3: Fix runtime PM trying to activate
 child device xxx.dwc3 but parent is not active
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
	Roy Luo <royluo@google.com>, 
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, 
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Alan Stern <stern@rowland.harvard.edu> =E4=BA=8E2025=E5=B9=B49=E6=9C=882=E6=
=97=A5=E5=91=A8=E4=BA=8C 10:41=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Sep 01, 2025 at 10:40:25PM +0200, Rafael J. Wysocki wrote:
> > Of course, the driver of B may also choose to leave the device in
> > runtime suspend in its system resume callback.  This requires checking
> > the runtime PM status of the device upfront, but the driver needs to
> > do that anyway in order to leave the device in runtime suspend during
> > system suspend, so it can record the fact that the device has been
> > left in runtime suspend.  That record can be used later during system
> > resume.
>
> As a general rule, I think this is by default the best approach.  That
> is, since B was in runtime suspend before the system sleep, you should
> just keep it in runtime suspend after the system sleep unless you have
> some good reason not to.  In other words, strive to leave the entire
> system in the same state that it started in, as near as possible.
>
Alan, I fully concur with your perspective. Specifically, I maintain that t=
he
device's runtime status should remain consistent before and after
system deep sleep.
To keep parent runtime-active during child wake, use device_link_add
create a link between them. Then dwc3_resume's pm_runtime_set_active
forces parent wake-up first.
However, for the dwc3 driver, both Rafael 's two solutions and
My aforementioned solution introduces new issues. When USB performs
deep sleep wake-up, the USB PHYS fails to initialize properly because
deep sleep wake-up executes runtime resume first, leaving the PHYS
initialized with per-sleep configurations. This ignores Type-C interface
requirements to reconfigure PHYS based on plug orientation.

> One good reason not to would obviously be if B is the source of a wakeup
> signal...
>
> > The kind of tricky aspect of this is when the device triggers a system
> > wakeup by generating a wakeup signal.  In that case, it is probably
> > better to resume it during system resume, but the driver should know
> > that it is the case (it has access to the device's registers after
> > all).
>
> Not necessarily.  Suppose that C is a child of B, and C is the wakeup
> source.  B's driver might decide to keep B in runtime suspend
> since B wasn't the wakeup source -- but then C's driver would have to
> make the same decision and would not have access to C's registers.
>
> >  It may, for example, use runtime_resume() for resuming the
> > device (and its parent etc) then.
>
> Consider this as a possible heuristic for B's ->resume callback, in the
> case where B was in runtime suspend throughout the system sleep:
>
>         If B's parent A is not in runtime suspend, test whether B
>         has a wakeup signal pending.  If it does, do a runtime
>         resume.  If not (or if A is in runtime suspend), leave B
>         in runtime suspend.
>
Following your suggestion, I conducted verification. If the child device
is in a runtime suspended state, the suspend and resume callback should
not be invoked. The proposed solution is as follows:
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 20945cad29a1..642bf4b5d3c4 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -2687,6 +2687,9 @@ int dwc3_pm_resume(struct dwc3 *dwc)
        struct device *dev =3D dwc->dev;
        int             ret =3D 0;

+        if (pm_runtime_suspended(dev))
+            return ret;
+
        pinctrl_pm_select_default_state(dev);

        pm_runtime_disable(dev);

> At first glance I think that will work fairly well.  Even if B is kept
> in runtime suspend when it shouldn't be, the normal runtime wakeup
> signalling mechanism should kick in without too much of a delay.
>
> The big problem is that this issue applies to all subsystems and
> devices.  It would be better if we had a uniform solution that could be
> implemented in the PM core, not in every single subsystem or device
> driver.
>
> Here's another possibility, one that can be implemented in the PM core
> during the ->resume, ->resume_early, or ->resume_noirq phase of system
> wakeup:
>
>         If A and B are both in runtime suspend, do not invoke B's
>         ->resume callback.  (Or maybe don't invoke it if A's ->resume
>         callback wasn't invoked.)
>
It is preferable for the PM core to maintain the runtime status
between parent and child devices,
where feasible. Could you advise on the most effective approach to
settle this issue?

