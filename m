Return-Path: <linux-pm+bounces-22415-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 892E9A3BD87
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 12:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87E241895ACE
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 11:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C3B1DF73A;
	Wed, 19 Feb 2025 11:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gIkp8IRK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FA81C5F1B
	for <linux-pm@vger.kernel.org>; Wed, 19 Feb 2025 11:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739966263; cv=none; b=tYf27xb0UJ/CF+U4OiyJ2jqzqWQ+654s6uu6TUbfZn576b/XHa8Faeo3lv5/yQ0xcMFr9ZG4dPjXWlad7yll+Sm0U2H1Jhqr9TbkQwi/m0aW+YTuHl0JFmDzBA6arGhhPAPPPIEGL9Okip7r55v/NwxWSuzsW4lqRxtawwdlfe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739966263; c=relaxed/simple;
	bh=mKPuqkaO5/tQYVpdTMpg9OTc7P54WtoXIuwWQ6pX94g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oQrQMWYkZYvGibQcPNQlI7+8rgfZPiqnfk17AbnsaKQcUtD4N86QDRDn4N6PrcBhFAq8RKBkiG3T9WIkNxQ0lpQuHUVecTlhmZNKzb5GmLC8xUg89YftS6PmyEG8Ahd8RW2vomOB/0c76WxI4FBiOL94VgVxzqsWtOBvAtYjnnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gIkp8IRK; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e455bf1f4d3so4969681276.2
        for <linux-pm@vger.kernel.org>; Wed, 19 Feb 2025 03:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739966260; x=1740571060; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mKPuqkaO5/tQYVpdTMpg9OTc7P54WtoXIuwWQ6pX94g=;
        b=gIkp8IRKJvgifB+QHtNUPsXi+sJP3TWPAXop0Z8xNea0lMDpyVyYQgGyx9/O35fxad
         sZBwD0Jj4qyyuFj0X5RFitM6o76ynm/wnBSL0aNKjRahAgrP6Suq44IMyyO+Y/tSwqLv
         KaavDcj1TQkMWmdZtS6VUX+Byn1pdfwYEIhdS8iQF5wpprFLdHB/Nv6JRd12HaiFzMU4
         iJpJo0WOOES+8gz3pdSbeQ+na1UvdxnyaLfOkIxo/Vm6y15zlzwQTFUQXGtVP8l7xB80
         K7+WM2r6WkfdsiOCmXFMeTgieczVAUtlfx0wtZm16zb5PWgAOglN9BU2qKHU/QOZnvrJ
         c/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739966260; x=1740571060;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mKPuqkaO5/tQYVpdTMpg9OTc7P54WtoXIuwWQ6pX94g=;
        b=HxoP98rqs2xivPNYD5ApRb0KC2vH7s7nK6R07S2BBzLieUZiyMGY2V/AUlD4qptIf0
         eAQDcu0BNG3gqzbOPqfKaFzh6QfCMgBrBQmb2HUlBcVxru7arN59Tap7vFVaDNyYVyct
         qOYTMS0yy2YjXF/UicF6HMuFqnQIgnpmCsWF3yymGB5BEGGwQAzgFvuOmJdnYyMuLg84
         toUfUPC8XpD4pgC6SZLJJfIJqWlnk+6giMtJxUm+Q8jxF8UAlFxuXxwKFkpDUtfcKaGT
         wdkt4QwICRyXSWOD8sx52w28K2ZvkDZMyVgTdFqfhM81GYu6Fse3KVklDL8Tm2ZonHdm
         bODA==
X-Forwarded-Encrypted: i=1; AJvYcCUVjYid46kmr77b4dlEhmovTpPPLmCNXf9eNI2CZ9dVE1h51pyJ8YcGsnH9XA2Mq62UYIJuiAy6bQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzwQ99AQhyZ4uFRM80mRKD3Ek310t+2xirvci6z7au5dugE9twm
	gOV9lkcSFweK3VyNarvgARgtSFtXXEHBEO3HLBWmTm8marRH+vU7M8WA2RFYeyOX8PCoJwpEvju
	k9b9XmHBzd7qHY3eVx5UbmjhUcl8CRoKOnzeOXA==
X-Gm-Gg: ASbGncv2TJ7BHNw+bZMsk2DCohgZX7wS7j4gBYnnHSVDZIHd925ytlSZt+99ROK1n95
	NFAvTcW1LToywmnSTtx5yxfzdk7eUvdjTDaamnGzMBvMJXJE1FIlCFcJDuk80ZQG1q7gszuN5XA
	==
X-Google-Smtp-Source: AGHT+IHmLjRjhz37Ix+o6XyPakdzY6Uu3F+3kxUa8H2huII1zroZajXD9MVDQwO7EqR3XOK/hrhvfu283vamhduicEA=
X-Received: by 2002:a05:6902:d49:b0:e5e:1062:bcf7 with SMTP id
 3f1490d57ef6-e5e1062c055mr980483276.13.1739966260274; Wed, 19 Feb 2025
 03:57:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1738736156-119203-1-git-send-email-shawn.lin@rock-chips.com>
 <CAPDyKFq+pWXq75xEtfkeCkmkdZtfp9dAFej4M+6rO6EAUULf=w@mail.gmail.com>
 <yq14j0y25hd.fsf@ca-mkp.ca.oracle.com> <CAPDyKFqsiBaSV--a_SvJ1n0733XXjSoONztf0e=jsGTZhKxQJw@mail.gmail.com>
In-Reply-To: <CAPDyKFqsiBaSV--a_SvJ1n0733XXjSoONztf0e=jsGTZhKxQJw@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 19 Feb 2025 12:57:04 +0100
X-Gm-Features: AWEUYZm5qq0kCFH5BGU-KOAykNEjhYZd727rd8VcRiDAXDF4w-LfbABoCwlPr4U
Message-ID: <CAPDyKFqMJRXRYymhijyWD-e=ScvEc_qbAmJBi--WsJd+zkQu6A@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] Initial support for RK3576 UFS controller
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, 
	"James E . J . Bottomley" <james.bottomley@hansenpartnership.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>, 
	YiFeng Zhao <zyf@rock-chips.com>, Liang Chen <cl@rock-chips.com>, linux-scsi@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Feb 2025 at 16:20, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Wed, 12 Feb 2025 at 22:56, Martin K. Petersen
> <martin.petersen@oracle.com> wrote:
> >
> >
> > Ulf,
> >
> > > If so, may I suggest that I pick patch2, patch3 and patch4 via my
> > > pmdomain tree and share them via an immutable branch, so they can be
> > > pulled into James/Martin's scsi tree?
> >
> > Sure, that's fine with me.
>
> Okay, great! I have picked up the patches and pushed them to the below
> immutable branch, which is based upon rc2.
>
> git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git rockchip

Hi Martin,

We got a report about an issue in the branch above a couple of days
ago. The problem has been fixed and I have just published it to the
branch above.

If you already pulled-in the branch to your tree, please pull again to
get the fix too.

Kind regards
Uffe

