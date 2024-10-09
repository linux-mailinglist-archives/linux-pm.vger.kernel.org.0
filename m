Return-Path: <linux-pm+bounces-15408-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAB99970EE
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 18:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25BEF1F21ACC
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 16:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13661E5730;
	Wed,  9 Oct 2024 15:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mEh1XN+d"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA031E5703
	for <linux-pm@vger.kernel.org>; Wed,  9 Oct 2024 15:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728489332; cv=none; b=cOHaElQhleF1GXfST43AgjdNo4myH8Tw58/Oj5zvclONSoTFuXZWWTGAphvOSJSYG7IyjUJEKYT8XBy7sPjP1Ik7dlOyZ8ggNa/mQcwBzAC/yWuLcORYZHFweBXuLpLugd+T8piwx0hEd3wPvVcx0n6MKTNF2GUx7iY9JBdATH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728489332; c=relaxed/simple;
	bh=9IyxbRxcXn3W/ovlgPhTagWUE9DYLB2d0t3NLu1GTEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dc22eQgRjymLe3GfXTAFpPhSB+1FqVz1iiN57Pg/65VBaXvQ0AaszWZdOYJnGIsSvKQ3v4Ihf0fSH3LGajNjWAfE/Dig6zqZcO0WbazBa6lKxfMOHrRA5gAFxTOdn0sl4Twks5k9RoscuO3JjdoTCxZTVd6bse+VfG75G3Amh50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mEh1XN+d; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e28ea358f65so917382276.0
        for <linux-pm@vger.kernel.org>; Wed, 09 Oct 2024 08:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728489330; x=1729094130; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PL9hRQRfd6A1OkAh+5JXcnzv2ciGXqoLre3DkSp5z4s=;
        b=mEh1XN+dut+tJeZiI+F8yL2JB7TX6+Hjpcb76sZMjsqI+SyWRnsOlaaAzKV5wBrQgs
         MOCCSuOm58I99hLeuZRlnZMX3pMngqTDsmhlHrWoM8eBWYZ36zfkcGki6Ao6pStOgolh
         BEilJDpEs5E4UmOor0mN74rWGBocqoRaSHoWn9x4gjBIWWjcBz+Dy91YUugv6zPLbYmI
         zE7HeUAn/Qe8+nJPchw4lVjWDmJvlcGtkkpigfI4KFM7h6Ev/A3tTeIRnZtSTPnf91Cb
         KO1Jp1sp7x4vJmySQ5VelBb0wbxCaKs9RPMEOp1GBdjI8hsLPpdZzDpTNhYI91gwcvtX
         J9Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728489330; x=1729094130;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PL9hRQRfd6A1OkAh+5JXcnzv2ciGXqoLre3DkSp5z4s=;
        b=ef8udahALcby0jxz1V1c1qHeo4w/rvAtWnrWnDSZ1jQ2gAdMdHULouzQKk6OLSXE3n
         XJ1sNNSKQApYnorSwXKpha3OH96o9NT6ksyF1Jhhyl208X65uLI0HCI30SX052u4CxRt
         XDu2sjwEw+O289Zk+CmWpTHSMm8aYCmSNOA5jP1X6ZSxa37qRZ1YUsh+McKi1fZmUH56
         pfYg8Cj/IBpFxh7YGSUSqNiHcFYxx2g/KCe4HsQoUAm3UvBFrbd9s25N8uULe3aUaMwI
         5z9PMclufxwMpKgfl1R0CtK/xOu3ocJL2phTYQ/bGgdU80HHdMqSPvBiMLjbNfzT1UYc
         OH2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUmKX1UutBqcI9FXHd+HgXUSsoO0NtcQN0Bbo+pU00O9ffNFjcRBmaixInEnlxEW/mmTJtp5mla4A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzczrWECDHBrT7DqNtfeH6Y6kB6519fTXzZ/BEiTQ8d1qYBFkH5
	FyhqveQE+LFsWE8aKpKjAnDrYcTYKB7uT9opxoP9AsA6Hi1NS0jcxEKCVxlm/8yATveOklONfYp
	NMAfefKzv+Jaly7WMrfVS20Xrs5Dhl1QS0lPPRw==
X-Google-Smtp-Source: AGHT+IGr4JUYzFp39IBCDliI2NU/uIXqk9gKPXFzdTH3f5egjT/5+Vhap/s8Mz6XqzPyfQOagIBhPrN+2Q7yfWV9SU0=
X-Received: by 2002:a25:fc28:0:b0:e1a:90ef:3b6d with SMTP id
 3f1490d57ef6-e290b5ddff5mr83158276.7.1728489329967; Wed, 09 Oct 2024 08:55:29
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002122232.194245-1-ulf.hansson@linaro.org>
 <20241002122232.194245-4-ulf.hansson@linaro.org> <20241003071411.vvhqb6bxxnrbkaw7@vireshk-i7>
 <CAPDyKFodrKnmFNjqLWfv2AExqkfRo9DRrf7wqB4ht=XwjZDhtw@mail.gmail.com> <20241009154807.4i5qse7utnqbsoib@vireshk-i7>
In-Reply-To: <20241009154807.4i5qse7utnqbsoib@vireshk-i7>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 9 Oct 2024 17:54:53 +0200
Message-ID: <CAPDyKFoL5ZB45s6sgxDusjXk6PhUCA6U-n73XGZGHbvwCtVrLg@mail.gmail.com>
Subject: Re: [PATCH v4 03/11] OPP: Rework _set_required_devs() to manage a
 single device per call
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Dikshita Agarwal <quic_dikshita@quicinc.com>, 
	Vedang Nagar <quic_vnagar@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <quic_kdybcio@quicinc.com>, Nikunj Kela <nkela@quicinc.com>, 
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Mikko Perttunen <mperttunen@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Stephan Gerhold <stephan@gerhold.net>, Ilia Lin <ilia.lin@kernel.org>, 
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, Vikash Garodia <quic_vgarodia@quicinc.com>, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Oct 2024 at 17:48, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 09-10-24, 15:55, Ulf Hansson wrote:
> > On Thu, 3 Oct 2024 at 09:14, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > On 02-10-24, 14:22, Ulf Hansson wrote:
> > > >  /**
> > > >   * struct opp_config_data - data for set config operations
> > > >   * @opp_table: OPP table
> > > >   * @flags: OPP config flags
> > > > + * @index: The position in the array of required_devs
> > > >   *
> > > >   * This structure stores the OPP config information for each OPP table
> > > >   * configuration by the callers.
> > > > @@ -48,6 +49,7 @@ extern struct list_head opp_tables;
> > > >  struct opp_config_data {
> > > >       struct opp_table *opp_table;
> > > >       unsigned int flags;
> > > > +     unsigned int index;
> > >
> > > Maybe name this required_dev_index as well ?
> >
> > Sure!
> >
> > Did you manage to get some time to look at the other patches in the series yet?
>
> Ahh, they looked okay and most of them were already Acked by me I guess :)

Right, it was mostly patch 3 and patch4 that I would appreciate an
ack/reviewed-by tag from you.

If I make the rename to "required_dev_index" according to your
suggestion above, it sounds like I could add the acks from you?

>
> Sorry for the confusion.

No worries!

Kind regards
Uffe

