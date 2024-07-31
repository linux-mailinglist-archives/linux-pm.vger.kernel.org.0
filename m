Return-Path: <linux-pm+bounces-11763-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA2D943424
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 18:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7485F1F2017A
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 16:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9564C1BBBC3;
	Wed, 31 Jul 2024 16:28:42 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5C01799F;
	Wed, 31 Jul 2024 16:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722443322; cv=none; b=SNTOEsIdd9nCcT8viyWZqN/yN7QAiyGc0K0V7vMFn6oTPRfsAcivpM2ps/qNrCKFB/szovAP7T+3Pf7C06H32pHe3QqZC0AWbMs+uufUnn67TGsFbjKoqJK0hj1D+sFwcIEnKfqiTB0IKbIo2kN4szMKPciX0zd63Ez0wH2jmro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722443322; c=relaxed/simple;
	bh=HSpz1EeEJHYsUpRT9Aroq+6XcAqm9KfzNPPf2z3Mbv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zl/QLCCn6s67v+fqZOHJnRQU8OO6WBBGLjfchWM8ysjFMda5A1ScWl87epOpMa8D7m8lO2aY4oXTTVcWZ60XW5/Z765gyNibLjeQfgu3WcFQwkHBY8pYw9sz4BMx3+EaeDkIPoKn4fw9hvYKPy7kxDfs1XtuZbqBwnpvYcRSaZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5d59e491fefso2615729eaf.1;
        Wed, 31 Jul 2024 09:28:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722443320; x=1723048120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HSpz1EeEJHYsUpRT9Aroq+6XcAqm9KfzNPPf2z3Mbv0=;
        b=XUvBiJvBFgD1mu4/HH2vaMSCfY6RpCVqsJ8/C/58dBRSFTRxUABwmP2sxOsdC3y6Pm
         qL3QYJDavTaBgMd09felfi3ejjeOc1LxXnmBvk3bKmBxc2iOcrnkA7qO309tK8tKy67g
         rNsDDB8BfaA8WpZUvm0ZnDXT1T9hjZluTq4YWoqdfZ+s9Q63odBdVpjhE83ncfLAXJuV
         RxpJGDcUuWxkQYcIpDtACLdWFOJBP78iBpcNNSyu0KXLyl+XfeSsrnuERaUNO4YRWV0G
         /L6VU8jBz93H9g7+Oew80XfeaVQmPNzYUR8+QfcEIHzzuQiqkV7GkSnVHLDr0OYqwctD
         dW+g==
X-Forwarded-Encrypted: i=1; AJvYcCUjUrlh91+Fy1Xf8qVr4vWlj/py+khvqvGKEGz5GPzuzuHIxTCK/9Oa/MDPSjM3MJ9+qBaQPaAUzkDfEN2TMrvvLUKi0EcK3+qOR8EKbW+ik/92HtAe8BKD+1qGrcCdLBbgwDgZDoA=
X-Gm-Message-State: AOJu0YxNlJ0WD703AZa8lNa4GToaJlS01umqg3obd3AIe1SGCYEaAVZJ
	f/Jnh/7jXE1vX5mh/PUd93rDECq/ngZZaYoKDalYZ/G9CgpY8Kwrq5YFBd7vwe2lAhkvoupsMIn
	JY3ijB9nZaDzEEC8WAGpTSwAdLEUDrw==
X-Google-Smtp-Source: AGHT+IFapFS4UEaCqEPkq/vs81Oz9A+bXhHVyutcG8ub7mTqY5Jkzwx7ZrqFoQcHctWl8GhI+LoPpvK48HNrtmR6CWU=
X-Received: by 2002:a05:6871:208:b0:260:df8a:52bf with SMTP id
 586e51a60fabf-267d4cd0f27mr14810175fac.2.1722443320040; Wed, 31 Jul 2024
 09:28:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726062601.674078-1-kai.heng.feng@canonical.com>
 <2048df524f8be7ed200bc92eb1c6efe106f0ed19.camel@intel.com>
 <CAAd53p5ftAjtfb-uCcVKR8G0JfoGnA_a0Se1E_vPeietgOENOg@mail.gmail.com>
 <CAJZ5v0i9Qt3OFKCbqkd-q4VKYreV2PZZpQ2Km9az2htANG5zxA@mail.gmail.com> <CAAd53p4macNjQN3i8vaf1s-5vj_7esKw37nqoUN1h+XqjQk71w@mail.gmail.com>
In-Reply-To: <CAAd53p4macNjQN3i8vaf1s-5vj_7esKw37nqoUN1h+XqjQk71w@mail.gmail.com>
From: Len Brown <lenb@kernel.org>
Date: Wed, 31 Jul 2024 12:28:29 -0400
Message-ID: <CAJvTdK=wafegpUB-KD=P9KazWngMNQb_rcbwQX_DDwPBtZ9W7w@mail.gmail.com>
Subject: Re: [PATCH] intel_idle: Add Jasper Lake and Elkhart Lake support
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, 
	"jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 2:18=E2=80=AFAM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> The crucial part to make the issue (i.e. slow ethernet) is
> ".disable_promotion_to_c1e =3D true".

Okay, so the problem statement is that on this machine with some
ethernet controller and some workload,
performance is better when you use just C1 and not C1E (or deeper) states.

And so you want to have the option of accessing C1 without the overhead of =
C1E?

Presumably you don't care about the power savings of the deeper states,
or you are using PM_QOS to avoid deep c-states at run time?

> Can we use that for EHL and JSL?

Yes.

You may also have a BIOS option to achieve the same goal, depending on
the platform.)

--=20
Len Brown, Intel

