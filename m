Return-Path: <linux-pm+bounces-11266-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B631893801A
	for <lists+linux-pm@lfdr.de>; Sat, 20 Jul 2024 11:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 721882813AF
	for <lists+linux-pm@lfdr.de>; Sat, 20 Jul 2024 09:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B58481D0;
	Sat, 20 Jul 2024 09:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fljzD/IP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6B639AC9
	for <linux-pm@vger.kernel.org>; Sat, 20 Jul 2024 09:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721466374; cv=none; b=IOzeAuR0jnogo5VIqRMNYh6keAAnd+64+caMpHxo7eHjnwM0+4vpwzimkfV0FUG+C8UgVTyh+kgIrd6SfhORbzPYBJSSjPfhimLlqGwOByIVQ7qKt9cXUFdARpWWUBnwUxkP18YfhzwuTbfzPVs9LhQ1bLBlORJA+N3gABSsBt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721466374; c=relaxed/simple;
	bh=kaE7qhlqs3hPG8WDfqZEg3NLq9JZIY9ufQDjPJpYinE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QMiMMIQLcuiE7hKf2w07aAe4TNGZrurbytG1gHRTN/VeAaoz22AW/PQkBDHrQhsMi9pgqOpny+TOE+nnmFatachXlv5WxnLw+GrP6Nh/YsaDZRD7l8ry7Fd+2AzsbiOpHWkzQ57RM2hO7jly7eVoofzgnubt3+F9te9Wy5ZWITo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fljzD/IP; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e05ebca3a32so2646100276.1
        for <linux-pm@vger.kernel.org>; Sat, 20 Jul 2024 02:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721466371; x=1722071171; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZgP/dKKkZZaxVNsTYdDk63xHj3EMBh+nkMY+fLP+qDI=;
        b=fljzD/IPiysTXdJANoOSWWCECMM8D0tz1segSYW30iTtyWmRyVFmTbNGbqC6RGFO41
         hgWC5R8jTWKz5N3fhl9leQQTjfRIbGsQree6UvG/O6YWNuY+FAid6UEKZSf+Lo9I527/
         xLZhBo3oDDHUkOn3vgtQuv616TRXLR8yuxhW135PpngH2nSvdF0OXmtjB0Fe6fFkR7LU
         eAxeh+L+pE1mWYErnI996WOvDqM9vNLzb9rHOVtUhLUB6JXyBCPeAKxIVbYFK07iSgY3
         /92kav/XEa32UVT7K8XZjhReIJ6KJ0HHT31OfVBC2h+0amnOqTUlfm71+/RNGf/LArUJ
         mAig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721466371; x=1722071171;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZgP/dKKkZZaxVNsTYdDk63xHj3EMBh+nkMY+fLP+qDI=;
        b=Ha2jIj+jYgZPiq4gswQU+QCdvRJ4PcIeah4DDcMlzyBCOFCjX6LTEIJ1+Lzx97Bojz
         s62ZbpMK6yr6Lz0IPRxUpoBDdMrbjXtxWhV8YT9paby8m/7uehQm3AJE21/uNliWLif0
         OeqruLXahS7EsolQ8bLqilwUn31bQSvy4e0BM0xjxMF4vBeeEeZ2rNXW5QN5U99MROWH
         7yZOBcMO7oQlZy50nIUXUGDlAwAfINhfrRP5gn7DXziu6kPUzE/2X8R/I6z3EeByqdlt
         eYenc4P7ktY2AD8K02gAmw0VR463htUdwpYkxRNnJl8Py4bMQxJx20PZdkEXdYtBl/bM
         eimw==
X-Forwarded-Encrypted: i=1; AJvYcCXKSXR/+txC814GzZtLYtBGG+9ZX/+0QN5bzXU2B0+Cb5V/1oszEcwc/pL3aI6Jx22beUePdrfou/9QumrBDlg1N/1AiBqJn4g=
X-Gm-Message-State: AOJu0Yw/FAYsU05wPFTzAoRGh70A5NWgg2tKeK2AJw+ZWyNcBI5OKFb+
	c2upsvEym/jDoDhniTAe/F6YXlVuwgEfG+aVwvrI5NitPD2vG0/LhpZvjN5H8wVHgUOsLhFLqpf
	/USaXSRrdSwpHhWPFlC6Y3cPo4MdgmwzfKUeAMA==
X-Google-Smtp-Source: AGHT+IHBrLXyCpuXdXOEl0uMaVIdxqNi852ASxrBbMOIc/TUjiAyG406/Ya8SprigjdPYw9GbKEbSPhqk94NkJEvK2k=
X-Received: by 2002:a05:6902:1546:b0:e05:fea8:4c77 with SMTP id
 3f1490d57ef6-e087b7de46amr1137170276.14.1721466371078; Sat, 20 Jul 2024
 02:06:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711113239.3063546-1-quic_varada@quicinc.com>
 <20240711113239.3063546-4-quic_varada@quicinc.com> <iwdennlw4njxefulw5e2wofu4pylep65el4hiiso6xqmoaq5fb@i4hrltrn2o6z>
 <ZpjxobF6LZMMN8A9@hu-varada-blr.qualcomm.com> <CAA8EJpqHrgi-AvfxGxwph0MEs0=ALV_7XWoUcSgGTG3vVj62FA@mail.gmail.com>
 <Zpt9Jb0aIg96yKN3@hu-varada-blr.qualcomm.com>
In-Reply-To: <Zpt9Jb0aIg96yKN3@hu-varada-blr.qualcomm.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 20 Jul 2024 12:05:59 +0300
Message-ID: <CAA8EJppqoDR=q_6Dh4dF-rh5f-2B1=JZZPe83EbrCRGu-NmB2Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] clk: qcom: ipq5332: Use icc-clk for enabling NoC
 related clocks
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	gregkh@linuxfoundation.org, konrad.dybcio@linaro.org, djakov@kernel.org, 
	quic_wcheng@quicinc.com, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 20 Jul 2024 at 12:02, Varadarajan Narayanan
<quic_varada@quicinc.com> wrote:
>
> On Thu, Jul 18, 2024 at 01:47:32PM +0300, Dmitry Baryshkov wrote:
> > On Thu, 18 Jul 2024 at 13:42, Varadarajan Narayanan
> > <quic_varada@quicinc.com> wrote:
> > >
> > > On Sat, Jul 13, 2024 at 07:21:29PM +0300, Dmitry Baryshkov wrote:
> > > > On Thu, Jul 11, 2024 at 05:02:38PM GMT, Varadarajan Narayanan wrote:
> > > > > Use the icc-clk framework to enable few clocks to be able to
> > > > > create paths and use the peripherals connected on those NoCs.
> > > > >
> > > > > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > > > > ---
> > > > >  drivers/clk/qcom/gcc-ipq5332.c | 36 +++++++++++++++++++++++++++++-----
> > > > >  1 file changed, 31 insertions(+), 5 deletions(-)
> > > > >
> > > > > diff --git a/drivers/clk/qcom/gcc-ipq5332.c b/drivers/clk/qcom/gcc-ipq5332.c
> > > > > index f98591148a97..6d7672cae0f7 100644
> > > > > --- a/drivers/clk/qcom/gcc-ipq5332.c
> > > > > +++ b/drivers/clk/qcom/gcc-ipq5332.c
> > > > > @@ -4,12 +4,14 @@
> > > > >   */
> > > > >
> > > > >  #include <linux/clk-provider.h>
> > > > > +#include <linux/interconnect-provider.h>
> > > > >  #include <linux/mod_devicetable.h>
> > > > >  #include <linux/module.h>
> > > > >  #include <linux/platform_device.h>
> > > > >  #include <linux/regmap.h>
> > > > >
> > > > >  #include <dt-bindings/clock/qcom,ipq5332-gcc.h>
> > > > > +#include <dt-bindings/interconnect/qcom,ipq5332.h>
> > > > >
> > > > >  #include "clk-alpha-pll.h"
> > > > >  #include "clk-branch.h"
> > > > > @@ -131,12 +133,14 @@ static struct clk_alpha_pll gpll4_main = {
> > > > >                      * (will be added soon), so the clock framework
> > > > >                      * disables this source. But some of the clocks
> > > > >                      * initialized by boot loaders uses this source. So we
> > > > > -                    * need to keep this clock ON. Add the
> > > > > -                    * CLK_IGNORE_UNUSED flag so the clock will not be
> > > > > -                    * disabled. Once the consumer in kernel is added, we
> > > > > -                    * can get rid of this flag.
> > > > > +                    * need to keep this clock ON.
> > > > > +                    *
> > > > > +                    * After initial bootup, when the ICC framework turns
> > > > > +                    * off unused paths, as part of the icc-clk dependencies
> > > > > +                    * this clock gets disabled resulting in a hang. Marking
> > > > > +                    * it as critical to ensure it is not turned off.
> > > >
> > > > Previous comment was pretty clear: there are missing consumers, the flag
> > > > will be removed once they are added. Current comment doesn't make sense.
> > > > What is the reason for the device hang if we have all the consumers in
> > > > place?
> > >
> > > Earlier, since there were no consumers for this clock, it got
> > > disabled via clk_disable_unused() and CLK_IGNORE_UNUSED helped
> > > prevent that.
> > >
> > > Now, since this clk is getting used indirectly via icc-clk
> > > framework, it doesn't qualify for being disabled by
> > > clk_disable_unused(). However, when icc_sync_state is called, if
> > > it sees there are no consumers for a path and that path gets
> > > disabled, the relevant clocks get disabled and eventually this
> > > clock also gets disabled. To avoid this have changed 'flags' from
> > > CLK_IGNORE_UNUSED -> CLK_IS_CRITICAL.
> >
> > You don't seem to be answering my question: "What is the reason for
> > the device hang if we have all the consumers in place?"
> > Could you please answer it rather than describing the CCF / icc-clk behaviour?
>
> Sorry if I hadn't expressed myself clearly. All the consumers are
> not there in place yet.
>
> > Are there any actual consumers for GPLL4 at this point? If not, why do
> > you want to keep it running? Usually all PLLs are shut down when there
> > are no consumers and then restarted when required. This is the
> > expected and correct behaviour.
>
> There are consumers for GPLL4, but they are getting disabled by
> clk_disable_unused (this is expected). There seems to be some
> consumer that got enabled in boot loader itself but not accounted
> in Linux because of which we are relying on CLK_IGNORE_UNUSED.
>
> If missing consumer(s) is identified, we can do away with this
> flag. Till that is done, was hoping CLK_IS_CRITICAL could help.

NAK, please identify missing consumers instead of landing workarounds.

-- 
With best wishes
Dmitry

