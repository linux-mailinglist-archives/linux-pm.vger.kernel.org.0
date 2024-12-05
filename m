Return-Path: <linux-pm+bounces-18627-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B009A9E59C2
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 16:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B33718851DF
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 15:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A1D21C9E3;
	Thu,  5 Dec 2024 15:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HctYCbD+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075A521882B
	for <linux-pm@vger.kernel.org>; Thu,  5 Dec 2024 15:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733412824; cv=none; b=u0OEhRgKoo9A+OFQLu+le4qNew6Slz7KAPbkED07xGNajM8jAGFzVbBF/FmInET2kSC0URC+EDNuM2W89BuIEZdBBBSkLMYC2FikL5TzWsAun1b7v3oRTlZpbfGbEe4FROZpZMIcpImfUr8lERnsnYYsePFbfyxfn9JdipnHcGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733412824; c=relaxed/simple;
	bh=XLu9EMt98BXAOrTvMAEtCPXOwIHMRk1OAKPmuse7UIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ACJcOz6/y3NXUbz+CQ3Q0tJM6o654hSw+Z5dASDAdrcHbfIvCOJGdHMTDEGRUTayMORcM3v0BmgGts+IGRdD4j7gceOpb4RF8vQtoC5cMBq8K4/z+YWPXmT9truqM9WdfzjiALQHjcTM9GuHBOxnTTfS22Zh7Qk5hCmIDRgUBOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HctYCbD+; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-29e7516ee77so753492fac.1
        for <linux-pm@vger.kernel.org>; Thu, 05 Dec 2024 07:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733412821; x=1734017621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jqyc5+2B7ur7AVd1HVq+NlYkzDo0pcuzx6DJZkxtWOQ=;
        b=HctYCbD+eDdfcFWjp+PyTECRnryATpBrngWLETsi5JsQc9MCZ2N1KJOfvJ7EgwxcRQ
         phYqWHMr3ZcARSeTyerjhbEPJlPa3o5cKAqK/Sqao8gjb0hO4+DB2sfsPMF9jWSUNuLT
         1IJ2zOzS9SCZUdO8xVelZltCw6yOKLKNcQevvIGSQZOe2945okwvI000KdI2DvC/w1OM
         v2aCYJbVI7CWBPKr8sRjRtJcxtSp3pyb2EzVnTQtwIUQje5bYwuSoUZED8Tvmxw+3b4J
         YeC83u+MtZgtmj9owgnZZTZFoegVQIthc/DWulInpWe6ryvAGw34Irh73FLdD+GXSwkl
         BfjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733412821; x=1734017621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jqyc5+2B7ur7AVd1HVq+NlYkzDo0pcuzx6DJZkxtWOQ=;
        b=PLeFsTZ1NGojMXyBjuZ+Lywl5daXJziAK9X0jnXDSP5dwnwuYXuMl/SBf6mCKT+4Hz
         zOfGQEPLf9Bu7ouQ/zxXAMN/8CZvqNNOgIyFwJVYjCXsvvbE1LJVnY+DJMf7eJ+oV48x
         sbUIdCBed+xTKMo584QKdMgMApognx2ye5FhcfRMnVDIsSQqBpjipoklfbZqmvLqPe6C
         SxZDQRSpGk6YLbo8pzouNsgliU3pSoPGb9aUuo3NZ8H98V3qhDBHY68yzH0FlaWrcLZp
         X3M+AJo7f69gKUhPoZ/ykMNDNOW8FR+4ncwhTnLXVA8LdjVVudDVLgXcJvtgzyIzHg9G
         iK6g==
X-Gm-Message-State: AOJu0YySLuzUOI0w92NhEPOmHytBE+U6i4VFNXqTQ+kavqUCP6SEO2T9
	pi91Hd2NPcDjAP/VlcLpo2S8610JWRXNv3bbp4QfXILe8yl0arkgHeRxrs8RySN/qEn6ZJ/mecI
	3JddcR5tm1WghtfMjRu9/csc/3X+JMrx6qKVNng==
X-Gm-Gg: ASbGncvLH7EE2cHNCRWKhQqTZtbzijzhvM0wb7Cy7dlDFPq52ZE1E7y7KuoMlDZkj0H
	1jcANLQr5tj1M9Zs4px3Qsn/AGSLSQ0kYsowAIc9SiTdScLUoT1W2Sm3QZRJHHw==
X-Google-Smtp-Source: AGHT+IHf+AkyJnofJTvgFa7236gZC5rbZsuef45lGVmm0Os5D0m3L/CY9eIoZG7lzc09H/hQrfQICjGURPg+7deJAKc=
X-Received: by 2002:a05:6870:d88e:b0:29e:69a9:8311 with SMTP id
 586e51a60fabf-29e888d6318mr10908975fac.36.1733412821091; Thu, 05 Dec 2024
 07:33:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <08f3bd66d7fc8e218bb6958777f342786b2c3705.1731554471.git.len.brown@intel.com>
 <CAJZ5v0g1JwGRECd2JVKScWO9a=hmrY03YQx95JKZ+q5KisRb1w@mail.gmail.com> <f6621a09-d5e4-4d3b-9b5c-55294c22030f@rowland.harvard.edu>
In-Reply-To: <f6621a09-d5e4-4d3b-9b5c-55294c22030f@rowland.harvard.edu>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 5 Dec 2024 16:33:04 +0100
Message-ID: <CAPDyKFoJ45PZ_o6VdaCiyat+BC6XOZ5AMnxmsZVzk16cCxmDkw@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH] PM: sleep: Ignore device driver suspend()
 callback return values
To: Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 5 Dec 2024 at 16:09, Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Thu, Dec 05, 2024 at 12:55:08PM +0100, Rafael J. Wysocki wrote:
> > Expanded CC list.
> >
> > On Thu, Nov 14, 2024 at 4:23=E2=80=AFAM Len Brown <lenb@kernel.org> wro=
te:
> > >
> > > From: Len Brown <len.brown@intel.com>
> > >
> > > Drivers commonly return non-zero values from their suspend
> > > callbacks due to transient errors, not realizing that doing so
> > > aborts system-wide suspend.
> > >
> > > Log, but do not abort system suspend on non-zero return values
> > > from driver's .suspend/.suspend_noirq/.suspend_late callbacks.
> > >
> > > Both before and after this patch, the correct method for a
> > > device driver to abort system-wide suspend is to invoke
> > > pm_system_wakeup() during the suspend flow.
> > >
> > > Legacy behaviour can be restored by adding this line to your .config:
> > > CONFIG_PM_SLEEP_LEGACY_CALLBACK_ABORT=3Dy
> > >
> > > Signed-off-by: Len Brown <len.brown@intel.com>
> > > ---
>
> >
> > I'm wondering if there are any opinions on this.
> >
> > IMV, drivers returning errors from their suspend callbacks without a
> > sufficiently serious reason are kind of a problem.
>
> There is a least one driver whose suspend callback returns an error if
> the device is enabled for wakeup and a wakeup event occurs during the
> suspend procedure.  We don't want to ignore those races.
>
> Alan Stern

Right. I also think this looks a bit risky as the current behaviour
has really been there for a long time. Who knows what depends on this.

A way forward could be to implement the change as an opt-in thing,
rather than an opt-out. That would allow us to test it and see how it
plays to potentially change the default behaviour down the road.

Kind regards
Uffe

