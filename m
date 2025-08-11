Return-Path: <linux-pm+bounces-32140-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 969DAB20220
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 10:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A21AB17E1B0
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 08:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B2D2DC331;
	Mon, 11 Aug 2025 08:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dbSZf/yP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079B22DA758
	for <linux-pm@vger.kernel.org>; Mon, 11 Aug 2025 08:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754901898; cv=none; b=A7NZtC3GjdwKi0Dmcm1UFURXiP9bSSy3unzY6VQ1mv4tjosEphMJbpPa1uCub/1yV8V1/pcsY4EH5tJmz2bban0q/xOVz5cD9VV3Xy069wTgF0LyVUSap59/qxOatiyovO1JcdjolQqExHtLLpyTHmCSSMznwCjA47pPJ/Tv0us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754901898; c=relaxed/simple;
	bh=axV6IrUwDJX16qYfVuK28rUUUeMC+FC9Cbf6mRURXWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UOf7Ws41s0DZs4d4hG1QFtwLQLzqO793LhonUUzQsDb6pDD+R9XBSATb3n7kshJ5+4p3cmXSzwQqTuX8woaT7cpu1mZ1wmkPy9Z7JGkvw7uT0m0Be3DUsPTXSqtJ4it6PhpYyt+njTrWDIBBtRkq+lVbynxNkPYJgN2Lef/MRcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dbSZf/yP; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76aea119891so4795140b3a.1
        for <linux-pm@vger.kernel.org>; Mon, 11 Aug 2025 01:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754901896; x=1755506696; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Cv/RLSsqKmx2C79kAK3hgUWMXi5KhDOAjUstrHLjrU=;
        b=dbSZf/yPvJ1v+rPJm2Nk8f9GYgcz1iiOsIRdXqtI/XlC9a3s8V4qFtkB7CEPA1+ilU
         5UNYFTpHwoodfd5zMO5O8zWNf6RfEA00bgroO/onhr97I4EdQGnk3CeenhXrd0wAO7rq
         AzQ9biJOfadOSfVkeE84+J26GaitQNAo9cnthsQ5bZ3Xj2yqQfIql1fG1r0e8LfNnmOk
         Gx8J37y3BhLjdNhdu7wKnL7Hgt7W+xrbo9r2jOJ1cooqW/PnYr72j8v4rUkajC6d3myJ
         ltgc9msYJrzvmzOR+oz5yf+Ga+DRHR6mpKgY/XtOf9YavH7iXnCM2VD8f5xVS+pJufvJ
         c36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754901896; x=1755506696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Cv/RLSsqKmx2C79kAK3hgUWMXi5KhDOAjUstrHLjrU=;
        b=BPGfhKoKZ5Ram8mki3mT3hqbvaY4VKq2K3JKTZ2UrpJpFBCprlzH5B08brdsHmhp71
         iJZYYMS55dsNz8xxiefGgFMu9yQjhwJ6v/XIuqb4BM77oG+6Fq1NTWAvBeZWikMwbruQ
         T7fZAGz9z7qwauujgWsauMksqCkeq6hLHMfkmxOiAY1KfCGTlVHG4n7XFVMA6w+tL0xN
         aw0DcGkCcEmb8+Qcas6MsldeweB6SHdHGusCt3cYXoEYycaspfi2ucB7BKUelfYVXN3D
         bm+7o+o2XQb1waWnpbn9/iriaJp+D0hpX9ETXBBpu9TjY97b3zcUQRsbx42DAuZ3Jgq/
         uL0A==
X-Forwarded-Encrypted: i=1; AJvYcCX89qvZGW0seChhkpDeQYudg82xB1jji9E1AgVbIWMvBeUw2auDU2Y5UxKXAJfLQITR4AHAQDfoyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwsrsrUsxSMDzr6M6GvSgvlMJDEfBvN+vIDKLsqwFY1qB+xS1dr
	zoPW6qs3ipBYcffKvKjBv7Q9kIh720NY9UvWW4fMd1b7S915jHAWCqBsKVsyur/74G0=
X-Gm-Gg: ASbGncvRxNgoZub5w6AdgdggWLHDBq1wduVKCbkSMLXT53GNqR4GWuTC7+bcnoFKPNx
	lFVSY0G44kGv7c0OaiQsumURI9jHEaUD5zZxhRTBngm8kuqU51rOhU4sK65DiCYi91Fbtz0PaNf
	SGo2gM/ULyjF30C36unpn6H/yy5wTf3Q7Li1WbY0iPI6xOk2HJ8e2khQQl/rSzOw5nDE70Y5YOj
	8gSv0pJiXCvMGDnrfBHef9ttSO4XtXJy9HyDyk8ZxUZaWRI8Gi0v6kD1f4qCSq4+K6HLTyHQ3+y
	84whgQ+wvXSRi7H/6o2232AHVatd/vQVM18FY2RqYDyirDeo2f4ZoEFmH/ut/H+A8IlZu8n5mQt
	Z9vZjWAEGqFVkkgKRuivSGD+J
X-Google-Smtp-Source: AGHT+IFy8OLOJxDiWjWxN2vnbqxED9SLo1xlCRWSc/+yGzHbtDgkIgFFmU48b8h75I37s18jKrFjyA==
X-Received: by 2002:a05:6a20:12c9:b0:238:abe:6363 with SMTP id adf61e73a8af0-240412d3d1bmr28944777637.14.1754901896198;
        Mon, 11 Aug 2025 01:44:56 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422bac0d6csm22123918a12.38.2025.08.11.01.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 01:44:55 -0700 (PDT)
Date: Mon, 11 Aug 2025 14:14:53 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/3] opp: Add bw_factor support to adjust bandwidth
 dynamically
Message-ID: <20250811084453.ocibslv6kxkib6po@vireshk-i7>
References: <20250717-opp_pcie-v1-0-dde6f452571b@oss.qualcomm.com>
 <0dfe9025-de00-4ec2-b6ca-5ef8d9414301@oss.qualcomm.com>
 <20250801072845.ppxka4ry4dtn6j3m@vireshk-i7>
 <7bac637b-9483-4341-91c0-e31d5c2f0ea3@oss.qualcomm.com>
 <20250801085628.7gdqycsggnqxdr67@vireshk-i7>
 <7f1393ab-5ae2-428a-92f8-3c8a5df02058@oss.qualcomm.com>
 <20250804111340.t62d4y2zg77rr3rp@vireshk-i7>
 <6035a961-7c5a-4fde-b4ea-e9ea9d88e6c1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6035a961-7c5a-4fde-b4ea-e9ea9d88e6c1@oss.qualcomm.com>

Sorry for the delay, I was travelling a bit recently.

On 06-08-25, 10:35, Krishna Chaitanya Chundru wrote:
> On 8/4/2025 4:43 PM, Viresh Kumar wrote:
> > On 01-08-25, 15:05, Krishna Chaitanya Chundru wrote:
> > > Currently we are fetching the OPP based on the frequency and setting
> > > that OPP using dev_pm_opp_set_opp().
> > > 
> > > As you are suggesting to use dev_pm_opp_set_prop_name() here.
> > > This what I understood
> > > 
> > > First set prop name using dev_pm_opp_set_prop_name then
> > > set opp dev_pm_opp_set_opp()
> > > 
> > > if you want to change above one we need to first clear using
> > > dev_pm_opp_put_prop_name() then again call dev_pm_opp_set_prop_name
> > > & dev_pm_opp_set_opp()
> > 
> > dev_pm_opp_set_prop_name() should be called only once at boot time and not
> > again later on. It is there to configure one of the named properties before the
> > OPP table initializes for a device. Basically it is there to select one of the
> > available properties for an OPP, like selecting a voltage applicable for an OPP
> > for a device.
>
> Then we can't use this dev_pm_opp_set_prop_name(), there is possibility
> link width x1, x2, x4 etc can also change at runtime.

Hmm, looking at the way you have implemented the bw multiplier, you
are going to call that every time you need to change the OPP
configuration. That doesn't look nice TBH. Such configurations are
normally provided via DT or are configured once at boot and not
touched after that. What you are basically doing is something like,
adding a single OPP in DT and changing the OPP frequency right before
setting it at runtime.

FWIW, you are allowed to add multiple OPPs with same frequency value
but different bandwidths or levels. I think you should use that and
correctly describe the hardware first (which is the step in the right
direction). And then you can find the right OPP at runtime and send a
request to configure it. That way we can avoid adding hacks in the OPP
core.

-- 
viresh

