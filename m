Return-Path: <linux-pm+bounces-10852-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1ED92B612
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 13:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B8EF284A08
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 11:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2736E157A48;
	Tue,  9 Jul 2024 11:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tOAOMrxm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C10152E0F
	for <linux-pm@vger.kernel.org>; Tue,  9 Jul 2024 11:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720522970; cv=none; b=o3u4f1WsdsROJJPFAGDQbm2qwrKs60/UIEStHM65UL78ms92CTxZjmpnvhIsqZH07/jhlvhaeF6fNzI9urk/ylAU4ZBbGXW4jdNXkfRDy22Mh/AkfzWPg1Czuiyq2PRt47ZIfBVFW8Bn8nqqyC3f0FB2Ji9BG3FFWyiDczcQNR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720522970; c=relaxed/simple;
	bh=ICwC8hHB4nssKkN75Qlzvd8rIcpX9ZQoWm9Hdqy5DwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UMe1Y/p1AgTSaQeX4un0jrf8QRysHMJwKSBPFI7IgtiFATXmImwnQO50PtL/tUe9r7fTP3gA3khonubNVViuZPvIhizBhHZX90qrHLBG9m6qQ1wYooNHNwHoNFnxWQCtnDLR92KhmWY5ttPS145Bn8+02VXNWBcms7tAElwek5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tOAOMrxm; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70af0684c2bso3049663b3a.0
        for <linux-pm@vger.kernel.org>; Tue, 09 Jul 2024 04:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720522968; x=1721127768; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yz8rqRMqOY683u5fU+cnnte1WW97jEHEhVYRD53PDio=;
        b=tOAOMrxmF5SX9/yidFT9l3oQFPMmITisdEw0c3YjacAvBaG4OwL32ijQGjOnU4tScA
         loK0ASFvIfha/dDCuOCQj6Hj/fVeAjpoGLPdHHUHYvBkG2Kr5FRmefmd8CUe5/rQZ3XC
         kjR/7HQuMuD1uzpIiX0NW64A3E7kkdkOYJS+F7PKXOo5fJs9TX+fNzVeBVh5sKBCBfuq
         5uzEWpnI61a4f0qdHO6hnDA35m3vFd28VdVyRaQZc8cycXWcFfAMS3Ac6Wog94+v5eBb
         VyjNFC/xBaaZzMl7YOe/9ryJ3QOOBju2zUgCSc0iMlbdtBpnxmeKL8kEL+reOMeXTUvw
         vfNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720522968; x=1721127768;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yz8rqRMqOY683u5fU+cnnte1WW97jEHEhVYRD53PDio=;
        b=CbTRFWuvzoeZSS3XurK9rR8xKY5niHpvtllAbcKZqo8aXbHD8VRSdErQP/Dih4Zjad
         ZW8CVWG+4MZ2t2WhzsySK29o9K4h5S9e6JK9eHdjzhO+qC6NHs1MYGTC3wxCn5/C5CWa
         Gqx41TECRbfra3R1vETkh38sr2pCuyAbO7DAGolitdkgHXDeRKlrG0ZfDOvskOgVrYLE
         AB9Lu9UHzRW2U2mph3eKPhogDrfrCGwtQRuqdizwroc/AJzUyMtFmszprg85aPt5YR/7
         sT8oXxU1pTrjGe7kzkaNetqTR3f2tCvbqae8kc6KDi9XXsw8fUAa/fqeq+aGLhvr5UdR
         PLFA==
X-Forwarded-Encrypted: i=1; AJvYcCXGYT9eLV+rT3UviRmbsAQSD/l3BAsDF7YEGu1AXrjlMATZ3noJja5CWwdXs7/TV5dZ8Fcz89JR8/WpQ8dn2X1Dj2JYG1TPZ90=
X-Gm-Message-State: AOJu0YxOJZJ7ADHrRMbPCId5P2zQQtPhiT9vYn8+Z2Nbr7DSM5cOn8dW
	MykdGS6bGSMpC3WrTHyYmuj9ZQTQLhOLh34TnDSkRmsvoibQgIJUCDBWxw51hwk=
X-Google-Smtp-Source: AGHT+IEnZeyyy+JNipf3YeCIVNiI2S39fnrN1eQJ+5u6wVxKp7TogZLRs6I2FcH4SNfru3myy0T1dQ==
X-Received: by 2002:a05:6a00:1d0e:b0:706:6cb2:ed17 with SMTP id d2e1a72fcca58-70b435220f9mr2429638b3a.2.1720522967959;
        Tue, 09 Jul 2024 04:02:47 -0700 (PDT)
Received: from localhost ([122.172.84.129])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b438c0996sm1513827b3a.60.2024.07.09.04.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 04:02:47 -0700 (PDT)
Date: Tue, 9 Jul 2024 16:32:45 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH V3 1/8] rust: Add initial bindings for OPP framework
Message-ID: <20240709110245.o73xnrj6jsvz2v2w@vireshk-i7>
References: <cover.1719990273.git.viresh.kumar@linaro.org>
 <fe8e9a96b29122876346fc98a6a9ede7e4f28707.1719990273.git.viresh.kumar@linaro.org>
 <ZoVvn0QCSR8y4HQJ@Boquns-Mac-mini.home>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoVvn0QCSR8y4HQJ@Boquns-Mac-mini.home>

On 03-07-24, 08:34, Boqun Feng wrote:
> On Wed, Jul 03, 2024 at 12:44:26PM +0530, Viresh Kumar wrote:
> > +// SAFETY: `OPP` only holds a pointer to a C OPP, which is safe to be used from any thread.
> > +unsafe impl Send for OPP {}
> > +
> > +// SAFETY: `OPP` only holds a pointer to a C OPP, references to which are safe to be used from any
> > +// thread.
> > +unsafe impl Sync for OPP {}
> > +
> 
> Same for the above safety comments, as they are still based on the old
> implementation.

Do I still need to change these ? Since we aren't always using ARef
now.

-- 
viresh

