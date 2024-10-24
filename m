Return-Path: <linux-pm+bounces-16392-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5AD9AEA5A
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 17:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22CCF1F22936
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 15:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51831EC006;
	Thu, 24 Oct 2024 15:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9DY1nOg"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E07F1EABDF;
	Thu, 24 Oct 2024 15:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729783622; cv=none; b=jqRcweaoH95VHUGtvA9vHneI4J/Qst6Yp7WB5AJSiGPWJaqSFERWr+ljRZADQY3Zb8A165UkeAG7uBZgFhM00f7GtDhB2K1XXa7b+ScT8FLYEBJbToc5hxLOzE0yCsXwY1+b7wuzbZxs/kRIG2V8b4Lokn5vkygfBcrPAdjjJMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729783622; c=relaxed/simple;
	bh=jKEd+Eu+KcQ+9lSZmD35vNpxUuBDiaX7uxj1Q002zOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VbQVoCNwZuHzJtiOITSwiMiQQnXvoZUvrbD9WWZzv+/MxRdAQBSVOg4YPardX6AwCJ8/vnKaL5WKjXeTei0dAAw20jJ9r2g9vV9yiqzNRQXpX592nTdA5OTXuQow2hv8fpuYcBkdI98Hxdp1S8M84uBllTtVDp9Ul3CSenyTO6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u9DY1nOg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E6FAC4AF0B;
	Thu, 24 Oct 2024 15:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729783622;
	bh=jKEd+Eu+KcQ+9lSZmD35vNpxUuBDiaX7uxj1Q002zOE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=u9DY1nOgPxITHNnXu/23/mrzfnPaB/hTpWuACBXe/K57recZAd/usN8DIdqduTm/B
	 ANfcws5y/fz4StIbCcmvII74aRDTPl/F+Z4TuAJMedw5YRPyAQdz4WrQvXEfxhq9mW
	 Y/ZwhPTHZRP2tbKcn2X9NLLGP1QdUaS0iydjEO+6q1cwQXnh+T/mpAWakacrIwL8Go
	 whicnFCP9SKRFsVehoyPVy76QAaihU+KWeVfYaRVCYkTd82/zcJ2k/RP3HVMTPBS8H
	 9sgNB4Leawx0dy8VAZ7l/U7axj56AigWGdyn59W5SZrclJSydhgQL2fz1+JKQRGzYw
	 m+xQn5jyrueFQ==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-28847f4207dso487282fac.0;
        Thu, 24 Oct 2024 08:27:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWUOhE7Fgdi1MD+wsKhHJ4jmQYrRuef5ZCT/FjwfM+DtjfQP7FnQUey7g37HhhSpuA2qx7Tev759Zk=@vger.kernel.org, AJvYcCWZ5Tx+t1TsN0+Q7xbSQN7o77Ju8eaKYBcnxR3Km+xAz9cXSbMDgxiEBYgA/b8vZpA/VrIMXSC787JMcSc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh63O/R5vaxrhPklyGtSa5kGcZZWzFJP41vzChO/X5WCR+Gql0
	D/iPY5YX9rS5Lds2XPL+0xzRskDPnC47igXDCxQXhQth7yvP/w67c5PTYCOlCJk+I4GVUz5kZ43
	O/7ewscDOLQF03tB2c8VEGxaq0ww=
X-Google-Smtp-Source: AGHT+IFwbkmVaRt/lULKGCbYY007JDFqVgryvtv6VEWHFJDjLEvtULEyL4BtQsbXvAl8uxKNk4kuNS24WHak9DG8CP4=
X-Received: by 2002:a05:6870:8a28:b0:287:e3e1:15f2 with SMTP id
 586e51a60fabf-28ccb504ab9mr6126096fac.25.1729783621452; Thu, 24 Oct 2024
 08:27:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021121138.422-1-zhengshaobo1@xiaomi.com> <20241024080043.647-1-zhengshaobo1@xiaomi.com>
In-Reply-To: <20241024080043.647-1-zhengshaobo1@xiaomi.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 24 Oct 2024 17:26:49 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gbpx7+hS=NS2+kNgRaOvADrY_2JsoRSg21tmF4oRnFwg@mail.gmail.com>
Message-ID: <CAJZ5v0gbpx7+hS=NS2+kNgRaOvADrY_2JsoRSg21tmF4oRnFwg@mail.gmail.com>
Subject: Re: [PATCH] thermal: gov_power_allocator: Granted power set to max
 when nobody request power
To: ZhengShaobo <zhengshaobo1@xiaomi.com>
Cc: chendejun@xiaomi.com, chuci@xiaomi.com, daniel.lezcano@linaro.org, 
	dingchongchong@xiaomi.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, lukasz.luba@arm.com, rafael@kernel.org, 
	rui.zhang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 10:01=E2=80=AFAM ZhengShaobo <zhengshaobo1@xiaomi.c=
om> wrote:
>
> On Wed, Oct 23, 2024 at 12:09:44PM +0200, Rafael J. Wysocki wrote:
> > On Mon, Oct 21, 2024 at 2:12=E2=80=AFPM ZhengShaobo <zhengshaobo1@xiaom=
i.com> wrote:
> > >
> > > From: zhengshaobo1 <zhengshaobo1@xiaomi.com>
> > >
> > > When total_req_power is 0, divvy_up_power() will set granted_power to=
 0,
> > > and cdev will be limited to the lowest performance. If our polling de=
lay
> > > is set to 200ms, it means that cdev cannot perform better within 200m=
s
> > > even if cdev has a sudden load. This will affect the performance of c=
dev
> > > and is not as expected.
> > >
> > > For this reason, if nobody requests power, then set the granted power=
 to
> > > the max_power.
> > >
> > > Signed-off-by: zhengshaobo1 <zhengshaobo1@xiaomi.com>
> >
> > I would have applied this, but your S-o-b above needs to be fixed.
> > Why don't you use your real name there?
> >
> > If it can be changed to "ZhengShaobo <zhengshaobo1@xiaomi.com>",
> > please let me know, and I will fix it for you when applying the patch.
> >
> Yes, it should be "ZhengShaobo <zhengshaobo1@xiaomi.com>".
> I would really appreciate your help in solving this problem.

OK, applied as 6.13 material with the S-o-b tag as per the above, thanks!

