Return-Path: <linux-pm+bounces-18625-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4139E5962
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 16:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B52B918825F2
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 15:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C9C21A44B;
	Thu,  5 Dec 2024 15:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="pTr+GQVS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B37F21A42B
	for <linux-pm@vger.kernel.org>; Thu,  5 Dec 2024 15:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733411391; cv=none; b=VKZ1doTy/tpwD0brYvHFBf/Ia32i29R66bgt5J256zB/JHF17IPPgq243nKfvy+fZazKPtLNAiXq7E8HR6/KALzv+dqUlDaZQupVBb5+2GCOBi77ZLsjmREKGIws+eNnx6xnRYamLFaWSa7aPICvoxMMskMkBPHRIb3gQ0oMtBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733411391; c=relaxed/simple;
	bh=kuDwn5MNGL8adcYkNgcDkUlwY1RIiGi86ZN+oVM7n88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Et4NjXJH8CbawyDwQh52Jf6uCm2VDUX7WN8eLrJczMuos/iOJpzfMIm979yL3cAFauhkbjHVi9c8HkVn3XDHcxMqA11e7zbgr/JrFS3bLVyXK+HzYKhwTDE0Gl72ldFoHrsA4Rf8qGDyivnjUMHyHwSBC1eAfd+A8OpVUQ9UAwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=pTr+GQVS; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b672a70f4eso81103685a.1
        for <linux-pm@vger.kernel.org>; Thu, 05 Dec 2024 07:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1733411389; x=1734016189; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PQOjMRYvtbhFCrEpt4LKpQp+egpXGKfp+zEXaVand9M=;
        b=pTr+GQVSEBdXCHfRc7MlFWfrTl3TaR42/zz/0KKrzLFfcX43Mo8/7iiylCN96BSKZl
         o9ufFCDF/MoGlOAQWj/eD90WdDm+C/bNLlBaMMYoJjItJ770CoMUEke4fSmazmLvbjd+
         PXCZC4Wc+Eil5WThzfLM/RSA/gcQaCxxtkIY45rgKGERPrf7kPVdCOppPztEUc2DMry4
         LhH1w6msmU5QGDW+HN7kbR/w/ln3rkk/YicCjwS2GkSzGJnYJElp+XI8+ZCqLuaohgne
         qj1qTOijcgorvoRyqm2xGUKynNMZPz1xhLWXNADC+GsXB+MCb1ZdY39CRT3Fgzonf70j
         2HPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733411389; x=1734016189;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PQOjMRYvtbhFCrEpt4LKpQp+egpXGKfp+zEXaVand9M=;
        b=aVl6CapnyEt/ypoeNNQZAx4yxgWH/OO1lmoMo/tCvB8hXhGlky25lU+OdLm47Hw/DH
         3Gog9kUieWIBDBlXA8Y9opyKGz52CCTBZfB8OsAwT717MhbWKsUMHUr6zyTyb4xCXAJX
         SjSGvLW0RMoDMmzDnR7xkp8OF/ZfOdBZ1AeYQ0m9+6/yR7jcfivK8LsUjTlxwhUjvoq6
         sHSlLL2DQ4f3Sw6oHE3m+sJT6v3aro9U6NHSEADV0Hv09xl3LOzZB94+1cw78f5OsVys
         sul78eoFbf8fmmw7wVptwLtLGrAouOKjNs35L0mQ9tIvtvWm4m6+8VdssAs3zENu1bEl
         IfXg==
X-Forwarded-Encrypted: i=1; AJvYcCWy/F4t9ottzLXAfpQ5LHcI0alG6/u5cGPe/I+cSkD0TNTwXO3OeT8g2oP02gxC29tftRhe/sB/JQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk9VDNhN0lZex3IAXAM++SfxJdacUH2fGpAzG/0dA9GD6zqg+j
	u6CTibXBHc7Nsg3LzdJhMSLZeM5Qycs0aBbkIOz0jDMkO7s5WQnNeYbljtVWkw==
X-Gm-Gg: ASbGncvetSroocZSlxwIShDLV84/Up/96b2u59l4OmL+mTydLWgfqG5kQoY27JAcSIU
	EqmBhnOoy+2u/jyo3daeRw5rSOxZ1d3BGjE67W49exUyNrzaoNzO1QBIUylvXru5d+HFtS02XFM
	YKstjecEdCO1USCFUQZByqXyOYfsDH8yTVRXtvcmtgla9SXt1H0o6s9ci+xB4vTywLyNXsffbri
	HPe49uBTo9BW1mOdnWLTBLw95Ae1O2pvR8xlrW6pCky2r4nsTE=
X-Google-Smtp-Source: AGHT+IHhbf/pZzCcxgVHVLVyaXCHOzFn02c6Zf1CQlCRr1jsnO2iE7Rk8YDhgArk93K5vr5mhEnW9g==
X-Received: by 2002:a05:6214:27e4:b0:6d8:8f14:2f5c with SMTP id 6a1803df08f44-6d8b73a6cb9mr151197666d6.23.1733411389235;
        Thu, 05 Dec 2024 07:09:49 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::d4d1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8da695c98sm7453136d6.33.2024.12.05.07.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 07:09:48 -0800 (PST)
Date: Thu, 5 Dec 2024 10:09:46 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
	Saravana Kannan <saravanak@google.com>
Subject: Re: [RFC/RFT PATCH] PM: sleep: Ignore device driver suspend()
 callback return values
Message-ID: <f6621a09-d5e4-4d3b-9b5c-55294c22030f@rowland.harvard.edu>
References: <08f3bd66d7fc8e218bb6958777f342786b2c3705.1731554471.git.len.brown@intel.com>
 <CAJZ5v0g1JwGRECd2JVKScWO9a=hmrY03YQx95JKZ+q5KisRb1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0g1JwGRECd2JVKScWO9a=hmrY03YQx95JKZ+q5KisRb1w@mail.gmail.com>

On Thu, Dec 05, 2024 at 12:55:08PM +0100, Rafael J. Wysocki wrote:
> Expanded CC list.
> 
> On Thu, Nov 14, 2024 at 4:23 AM Len Brown <lenb@kernel.org> wrote:
> >
> > From: Len Brown <len.brown@intel.com>
> >
> > Drivers commonly return non-zero values from their suspend
> > callbacks due to transient errors, not realizing that doing so
> > aborts system-wide suspend.
> >
> > Log, but do not abort system suspend on non-zero return values
> > from driver's .suspend/.suspend_noirq/.suspend_late callbacks.
> >
> > Both before and after this patch, the correct method for a
> > device driver to abort system-wide suspend is to invoke
> > pm_system_wakeup() during the suspend flow.
> >
> > Legacy behaviour can be restored by adding this line to your .config:
> > CONFIG_PM_SLEEP_LEGACY_CALLBACK_ABORT=y
> >
> > Signed-off-by: Len Brown <len.brown@intel.com>
> > ---

> 
> I'm wondering if there are any opinions on this.
> 
> IMV, drivers returning errors from their suspend callbacks without a
> sufficiently serious reason are kind of a problem.

There is a least one driver whose suspend callback returns an error if 
the device is enabled for wakeup and a wakeup event occurs during the 
suspend procedure.  We don't want to ignore those races.

Alan Stern

