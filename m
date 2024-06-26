Return-Path: <linux-pm+bounces-9987-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 866229176C1
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 05:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2E271C211E1
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 03:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133D461FCA;
	Wed, 26 Jun 2024 03:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PoGvO6Aq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AED453E23
	for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2024 03:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719372362; cv=none; b=KTQklEIoM0+50ofcyrH98azuqoh/tgm/S9FtZ9p+zrVlP5nQ442BAx9r6k/RgUHSYwwLKBt6F1alxLi+p/wFhjdAx+O6Qsfzqlh2EGVhU+93gWAfXWizBeZ3+ieEgeKkxcagnLMhUeL635CMydvJsithgjG4NSDgCG9VDrPN33I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719372362; c=relaxed/simple;
	bh=/HV4PiP3EN52Urf1wUjCU3cuFwxxSxT873RnuJpLi/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PkykTFulRmE+6P3HxJmiwTdaUsZAFJjoEMjJLs3ktw9Dv2W+9JuEQV7ZX/Re1yoyuFzsyHCv2xiHIBpNt4OfV11JT9qWzyqjECnu+9kw3stz0cyobWGhEQ9XRTQ24KAAYLS+IBeG8vbya3oWWdf7VHJsk2ZkcO9NzZH704WtEJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PoGvO6Aq; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-711b1512aeaso4838468a12.3
        for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2024 20:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719372360; x=1719977160; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X5j2E0DaqtU2/8aTunjka7yV7RpklyOnhjcXWnzg8us=;
        b=PoGvO6AqMz7ZWt1Ml2ogWLGl87Yj3PsKHtupFNbZZahejOJ0hn9XokmuXohL5b1Hkm
         CdpSqrguHv0hwSkWbu3W5HZ3LqZHF4/qL62hDyQ4yZca9wbMK2F7qJ7xqYG6P9CqTEMW
         MaIE5xc4BSLZvzs6RXsZ4fUGxdCWn1gIHyRNybwbJxGqdQiVbT3HLKTpQHcr2OWMcWGh
         LCaLc1O+uuV5lGnT8Ie2gbba1H1QQjd2h+oTfdBdRB0m/KuVuILK8ZQ8J25sTR8azJaL
         kP2sJ6y1iO0RYjBhpfjLRQvIVR7+LmC6MDfLfyA1dQHGm+0GOs5tARa/cL+bChXibzm5
         Lfiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719372360; x=1719977160;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5j2E0DaqtU2/8aTunjka7yV7RpklyOnhjcXWnzg8us=;
        b=jAIW0RJPMM4Go6WGd6fuEJiXRhtOfcINZK5dADqJx40PuLcKRMQRoWiDjbNlrcu4Zv
         Gn7XpmmDI1DNnQgbHV37BQ/Pzp7xgB59dK4HjY2RAVbql5/jCBJFn2X5XkqyB8eakn+3
         Gvv+/zKNNwDMfw7mUDNUPLdzeGAGHaxyFsoLHkcs6vgdjUHi0jxdlcji6Qs9Nvzqh6G6
         0QOWAsmAWPuHh5rDEcMr93F15fTpSQr+KhkH1GIYeEH0j3bKZsdInMV/8XgOYFszg5nv
         b3fyIc/Hkfi/bI6Kjc80fD1He7hXGMFMLdgMd92atNLuoIE2V4b7OfQ9bnd2308tv4/5
         M5gQ==
X-Forwarded-Encrypted: i=1; AJvYcCUixYqkQ9n2A8c1AHypnO33uZyEplRSo37lUCB10clXzoD0jwZTzSPHa0TIKYbzUHY6qfElzLdusy1CXyYHdp5XEuRYpID8Gp4=
X-Gm-Message-State: AOJu0YxWxtoUUXGlU60qk4SLOp4brKWdJeek4xnx1trFH0YZdqvNrEWF
	fyUoO+Kpc7YDGghItokbWrldZhyuia79Ivg3hVowNVvdTlPr4dEtuXHR8tBK1SW1wrHJVaT+RBR
	O
X-Google-Smtp-Source: AGHT+IHbFYrPlfMzvf8YPQsheZj+Fh3cHIJmfITbawr1fIa30v+hI68ZJ7MyIoWPGnHyxFXlQq0Gnw==
X-Received: by 2002:a05:6a20:974e:b0:1bd:fe8:fc9a with SMTP id adf61e73a8af0-1bd0fe8fdc7mr5163550637.17.1719372359629;
        Tue, 25 Jun 2024 20:25:59 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3c6032sm88737895ad.150.2024.06.25.20.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 20:25:59 -0700 (PDT)
Date: Wed, 26 Jun 2024 08:55:57 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: perry.yuan@amd.com, gautham.shenoy@amd.com,
	Linux PM <linux-pm@vger.kernel.org>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Dhruva Gole <d-gole@ti.com>, Yipeng Zou <zouyipeng@huawei.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v14 5/5] cpufreq: Only disable boost during cpu online
 when using frequency tables
Message-ID: <20240626032557.5vsjmzyzmtkbzom6@vireshk-i7>
References: <20240624213400.67773-1-mario.limonciello@amd.com>
 <20240624213400.67773-6-mario.limonciello@amd.com>
 <20240625063003.cw62yt46b7uaskrp@vireshk-i7>
 <27c030be-d06b-46ab-87d0-2fbfd1dd9e13@amd.com>
 <20240626031142.ytzpyuflgo73piaw@vireshk-i7>
 <056cc207-678f-48ad-bc44-6b3b06bcc5a3@amd.com>
 <20240626031753.dti6ixxi2jlykjqn@vireshk-i7>
 <e8275758-e0f7-46c9-8131-094abe363292@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8275758-e0f7-46c9-8131-094abe363292@amd.com>

On 25-06-24, 22:20, Mario Limonciello wrote:
> Yeah; that's effectively the same result as Gautham's suggestion.  He had
> just said to change policy_has_boost_freq() for the same.

I know. The problem is policy_has_boost_freq() (as its name suggests)
needs to check if the policy supports boost freqs (in a generic way)
and it is used at several other places and it would be wrong to hack
that routine to fix this problem.

All we want here is for the core to not touch boost_enabled if the
policy->init() function has already done so.

> I'll test it with yours and reconcile the better one to submit back out for
> v15.

You can send it separately to be honest, and it looks like a fix, so
Rafael should be able to get it merged a bit sooner. Add a fixes tag
too.

-- 
viresh

