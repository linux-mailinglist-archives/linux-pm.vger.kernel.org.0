Return-Path: <linux-pm+bounces-12300-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2DA95422E
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 08:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4A631F2351C
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 06:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066258289E;
	Fri, 16 Aug 2024 06:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZfsVZej"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3B8A957;
	Fri, 16 Aug 2024 06:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723791529; cv=none; b=W2A/80zMZEsCom9wYtW6g/mjYlU911v59y+6r/frxopn/6FP1ZVSxePiOA4IyJbpO/YmGGao0m/IM0iFwiadgNZzeENRel4mXsBMc5PTkKk7FVhsf66+WuwiszHzSqPHuw2Ac/XPMNHENq1x9a+Cc1UOppRS+kTLkm4sfRUw1a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723791529; c=relaxed/simple;
	bh=zDRM1hzoX9ACvzIE3K0psyIc0oiEJxraUk2CzewLzOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8TOnB8cdELWlHgwAVWbFDFrh1v/u9QYvR6GBRXNpRy05wT5nDy/yfGRszdw7NlOVce/3tmLbyVSQSvTiehD9sTpFXwPIcrEv6j0++4WZxSvyeeOsxf0aW72VImvNDrJbtoQSEpUigSKJj9xlMroDqIj/IBse949MUxKHuBaeJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZfsVZej; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5becdf7d36aso402190a12.1;
        Thu, 15 Aug 2024 23:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723791526; x=1724396326; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1JwamsKksXLvsW0qhopzjl2x+H5y5UpQ08ylf3RpSZM=;
        b=hZfsVZejiJhmOUjM56Y8GFfjvVogrdceuvOE4I1xHuLdtJoOiu9alEvRJ2jPm+MQLT
         2s8XZVRDlo/hBcQf4Z2AHTRHbqzD+WOx/q6VjivlXME8T6IAPbHfLW/HcwloiJSqh814
         33rC0319QUkbY/jBjEh5OufCgwtpSPjozAJfTDGBsoKrjRwg1y13e3Q0Pj+gGmVM1iOY
         0bdNssMkcHLXDxgm2Dorad09/IN4rba+52CItdWe2QRnT52R2WCx1GlWfPwrXZbHcyfb
         HWZi8mG2k7ANTCG99t4Dyf6yW255lDyke8ZDeiLA96LC/lu+VnqOk6vbhoLwHfUxz486
         rVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723791526; x=1724396326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1JwamsKksXLvsW0qhopzjl2x+H5y5UpQ08ylf3RpSZM=;
        b=Nhs6J2HQ4YtspaChIhQ3zk8Ng9OSyy3L7cb15pa8Xlp5hGRMLPnYw/eEsAT4IkSlH+
         mChXnrdSFeiWBDDaxd75pxu+CEyuIvW0+UaAOOtb/Z3JKaBZFwqX7ibS5PwJP8ew0CQl
         kpWDeLcoCkTMB8AkjkJKKnL400F+6TBarhKpJE7cAtxWeeLH2mR9+4ZJaxqPzFBTrFEM
         M6bLeg4DWVPwbbJYXjH672NQZsEhQUxLigTHtIT0sWNxIcUnhvQ6MlTVjM8dGTJWemta
         F2rXqJVMX+Jj/mG9/qMWdrAyI6h86GD5Evu4TsjMRS4PebZ/hJDj0ACGeoMHcWQrkefr
         oxxg==
X-Forwarded-Encrypted: i=1; AJvYcCVY43w/9AMGdyS9OjaYAFiP+wybz6m5vQW1ieQj/+bOPXixCE8nc9XdhWB8L0mSD0O475h4hIUDdRWRIRN+Mph5kE2molIinx4x9nv0MZ0wlJneJ4LjdNrz+MeF+rw50nHqXSn0/xlrKMm2e4lC4xxdvGSCV5HBB3+p7J2HtSro8j87
X-Gm-Message-State: AOJu0Yy6jf4k/m44cRSOsefkGm2TkgZsCucGAKUhrpKGqSgfmZPRhxem
	ATvsdwVCe3Ya8kGDRrfMdbsytqrpZOd6Ek8SfZitthsOGddtWhej
X-Google-Smtp-Source: AGHT+IG5/2L2jkdBfceoeV/MuSblJkCtK6rCRn7E3vZSCNqnFhMc2Btvqv1Mazis6KiaqOHW7jKCaw==
X-Received: by 2002:a05:6402:1d56:b0:5bb:9ae0:4a41 with SMTP id 4fb4d7f45d1cf-5beca757128mr1109813a12.28.1723791526208;
        Thu, 15 Aug 2024 23:58:46 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbe7f3e0sm1830464a12.71.2024.08.15.23.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 23:58:45 -0700 (PDT)
Date: Fri, 16 Aug 2024 08:58:43 +0200
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: power: supply: sc27xx-fg: add low voltage
 alarm IRQ
Message-ID: <Zr74o7/4uurJeRnF@standask-GA-A55M-S2HP>
References: <Zr3SAHlq5A78QvrW@standask-GA-A55M-S2HP>
 <20240815-winnings-waving-1ec5561f90e7@spud>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815-winnings-waving-1ec5561f90e7@spud>

Hi Conor,

On Thu, Aug 15, 2024 at 03:46:18PM +0100, Conor Dooley wrote:
> On Thu, Aug 15, 2024 at 12:01:36PM +0200, Stanislav Jakubek wrote:
> > The SC27XX fuel gauge supports a low voltage alarm IRQ, which is used
> > for more accurate battery capacity measurements with lower voltages.
> > 
> > This was unfortunately never documented in bindings, do so now.
> > 
> > Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> > ---
> > Initial Linux driver submission adding this feature:
> > https://lore.kernel.org/lkml/ee1dd39f126bd03fb88381de9663d32df994d341.1542185618.git.baolin.wang@linaro.org/
> > 
> > The only in-tree user (sc2731.dtsi) has had interrupts specified since its
> > initial fuel-gauge submission:
> > https://lore.kernel.org/lkml/4f66af3b47ba241380f8092e08879aca6d7c35b3.1548052878.git.baolin.wang@linaro.org/
> 
> This context could go into the commit message I think, as justification
> for making the interrupt required.

TBH I'm not 100% sure that the interrupt is required, I just looked at
the Linux driver, and that it returns from probe if it doesn't get the IRQ.

> 
> Also, this binding is odd in that it has several compatibles in an enum,
> but the driver (added at the same time) only has one compatible in it.

I think the intent was to document the entire sc27xx series of PMICs, as
they're supposedly very similar (this is just my guess), while initially
adding support only for sc2731.

> Are you using the sc2731 in your device?

No, I do not have any such device.

Regards,
Stanislav

